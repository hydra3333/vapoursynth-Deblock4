// Classic width-parametric vector backend.
//
// The committed scalar oracle remains frozen. This module re-expresses the
// same integer edge arithmetic with explicit @Vector lanes and keeps frame
// addressing in byte-row form. Vector values are loaded/stored only through
// defined-layout fixed arrays; vector pointers are never overlaid on frame
// memory.
const std = @import("std");
const scalar_kernel = @import("classic_scalar_kernel.zig");
const scalar_schedule = @import("classic_edge_schedule.zig");
const thresholds_module = @import("classic_thresholds.zig");

pub const BytePlane = scalar_schedule.BytePlane;
pub const Thresholds = thresholds_module.Resolved;

fn LaneVector(comptime L: usize, comptime T: type) type {
    requireStorageType(T);
    if (L == 0) @compileError("Classic vector lane count must be nonzero");
    return @Vector(L, T);
}

fn I32Vector(comptime L: usize) type {
    if (L == 0) @compileError("Classic vector lane count must be nonzero");
    return @Vector(L, i32);
}

fn BoolVector(comptime L: usize) type {
    if (L == 0) @compileError("Classic vector lane count must be nonzero");
    return @Vector(L, bool);
}

pub fn LaneSamples(comptime T: type, comptime L: usize) type {
    const V = LaneVector(L, T);
    return struct {
        p2: V,
        p1: V,
        p0: V,
        q0: V,
        q1: V,
        q2: V,
    };
}

pub fn LaneResult(comptime T: type, comptime L: usize) type {
    const V = LaneVector(L, T);
    return struct {
        p1: V,
        p0: V,
        q0: V,
        q1: V,
        activated: BoolVector(L),
    };
}

pub fn filterLanes(
    comptime T: type,
    comptime L: usize,
    samples: LaneSamples(T, L),
    thresholds: Thresholds,
) LaneResult(T, L) {
    requireStorageType(T);
    const VI = I32Vector(L);
    const VT = LaneVector(L, T);

    const p2: VI = @intCast(samples.p2);
    const p1: VI = @intCast(samples.p1);
    const p0: VI = @intCast(samples.p0);
    const q0: VI = @intCast(samples.q0);
    const q1: VI = @intCast(samples.q1);
    const q2: VI = @intCast(samples.q2);

    const alpha: VI = @splat(thresholds.alpha);
    const beta: VI = @splat(thresholds.beta);
    const c0: VI = @splat(thresholds.c0);
    const c1: VI = @splat(thresholds.c1);
    const zero: VI = @splat(0);
    const one: VI = @splat(1);
    const two: VI = @splat(2);
    const four: VI = @splat(4);
    const peak: VI = @splat(thresholds.peak);
    const shift_one: @Vector(L, u5) = @splat(1);
    const shift_three: @Vector(L, u5) = @splat(3);

    const activated = (absDiff(L, p0, q0) < alpha) &
        (absDiff(L, p1, p0) < beta) &
        (absDiff(L, q0, q1) < beta);

    const ap = absDiff(L, p2, p0);
    const aq = absDiff(L, q2, q0);
    const p_side_active = ap < beta;
    const q_side_active = aq < beta;
    const p_side_c = @select(i32, p_side_active, c1, zero);
    const q_side_c = @select(i32, q_side_active, c1, zero);
    const c = c0 + p_side_c + q_side_c;

    const average = (p0 + q0 + one) >> shift_one;
    const delta_unclamped = (((q0 - p0) * four) + p1 - q1 + four) >> shift_three;
    const delta = clampVector(L, delta_unclamped, -c, c);
    const delta_p1 = clampVector(
        L,
        (p2 + average - (p1 * two)) >> shift_one,
        -c0,
        c0,
    );
    const delta_q1 = clampVector(
        L,
        (q2 + average - (q1 * two)) >> shift_one,
        -c0,
        c0,
    );

    const filtered_p1_i32 = @select(
        i32,
        p_side_active,
        clampVector(L, p1 + delta_p1, zero, peak),
        p1,
    );
    const filtered_p0_i32 = clampVector(L, p0 + delta, zero, peak);
    const filtered_q0_i32 = clampVector(L, q0 - delta, zero, peak);
    const filtered_q1_i32 = @select(
        i32,
        q_side_active,
        clampVector(L, q1 + delta_q1, zero, peak),
        q1,
    );

    const filtered_p1: VT = @intCast(filtered_p1_i32);
    const filtered_p0: VT = @intCast(filtered_p0_i32);
    const filtered_q0: VT = @intCast(filtered_q0_i32);
    const filtered_q1: VT = @intCast(filtered_q1_i32);

    return .{
        .p1 = @select(T, activated, filtered_p1, samples.p1),
        .p0 = @select(T, activated, filtered_p0, samples.p0),
        .q0 = @select(T, activated, filtered_q0, samples.q0),
        .q1 = @select(T, activated, filtered_q1, samples.q1),
        .activated = activated,
    };
}

pub fn processPlane(
    comptime T: type,
    comptime N: usize,
    plane: BytePlane,
    thresholds: Thresholds,
) void {
    requireStorageType(T);
    requireBackendWidth(T, N);
    if (plane.width == 0 or plane.height == 0) return;
    std.debug.assert(plane.stride_bytes >= plane.width * @sizeOf(T));

    // Schedule-A top band: verticals only, in increasing x order.
    var edge_x: usize = scalar_schedule.edge_step;
    while (edge_x < plane.width) : (edge_x += scalar_schedule.edge_step) {
        if (scalar_schedule.edgeEligible(edge_x, plane.width)) {
            filterVerticalSegment(T, plane, edge_x, 0, thresholds);
        }
    }

    var edge_y: usize = scalar_schedule.edge_step;
    while (edge_y < plane.height) : (edge_y += scalar_schedule.edge_step) {
        // Ratified P3 reorder: the complete horizontal edge precedes this
        // band's vertical edges. Vertical edges remain strictly x-ordered.
        if (scalar_schedule.edgeEligible(edge_y, plane.height)) {
            filterHorizontalEdge(T, N, plane, edge_y, thresholds);
        }

        edge_x = scalar_schedule.edge_step;
        while (edge_x < plane.width) : (edge_x += scalar_schedule.edge_step) {
            if (scalar_schedule.edgeEligible(edge_x, plane.width)) {
                filterVerticalSegment(T, plane, edge_x, edge_y, thresholds);
            }
        }
    }
}

fn filterHorizontalEdge(
    comptime T: type,
    comptime N: usize,
    plane: BytePlane,
    edge_y: usize,
    thresholds: Thresholds,
) void {
    var x: usize = 0;
    while (x + N <= plane.width) : (x += N) {
        filterHorizontalLanes(T, N, plane, x, edge_y, thresholds);
    }
    filterHorizontalTail(T, N, plane, x, edge_y, plane.width - x, thresholds);
}

fn filterHorizontalTail(
    comptime T: type,
    comptime N: usize,
    plane: BytePlane,
    column_start: usize,
    edge_y: usize,
    remaining: usize,
    thresholds: Thresholds,
) void {
    if (remaining == 0) return;
    if (N == 1) {
        std.debug.assert(remaining == 1);
        filterHorizontalScalarColumn(T, plane, column_start, edge_y, thresholds);
        return;
    }

    const half = N / 2;
    var offset: usize = 0;
    var left = remaining;
    if (left >= half) {
        filterHorizontalLanes(T, half, plane, column_start, edge_y, thresholds);
        offset += half;
        left -= half;
    }
    filterHorizontalTail(T, half, plane, column_start + offset, edge_y, left, thresholds);
}

fn filterHorizontalLanes(
    comptime T: type,
    comptime L: usize,
    plane: BytePlane,
    column_start: usize,
    edge_y: usize,
    thresholds: Thresholds,
) void {
    const row_p2 = rowSamples(T, plane, edge_y - 3);
    const row_p1 = rowSamples(T, plane, edge_y - 2);
    const row_p0 = rowSamples(T, plane, edge_y - 1);
    const row_q0 = rowSamples(T, plane, edge_y);
    const row_q1 = rowSamples(T, plane, edge_y + 1);
    const row_q2 = rowSamples(T, plane, edge_y + 2);

    const result = filterLanes(T, L, .{
        .p2 = loadContiguous(T, L, row_p2, column_start),
        .p1 = loadContiguous(T, L, row_p1, column_start),
        .p0 = loadContiguous(T, L, row_p0, column_start),
        .q0 = loadContiguous(T, L, row_q0, column_start),
        .q1 = loadContiguous(T, L, row_q1, column_start),
        .q2 = loadContiguous(T, L, row_q2, column_start),
    }, thresholds);

    storeContiguous(T, L, row_p1, column_start, result.p1);
    storeContiguous(T, L, row_p0, column_start, result.p0);
    storeContiguous(T, L, row_q0, column_start, result.q0);
    storeContiguous(T, L, row_q1, column_start, result.q1);
}

fn filterHorizontalScalarColumn(
    comptime T: type,
    plane: BytePlane,
    x: usize,
    edge_y: usize,
    thresholds: Thresholds,
) void {
    const row_p2 = rowSamples(T, plane, edge_y - 3);
    const row_p1 = rowSamples(T, plane, edge_y - 2);
    const row_p0 = rowSamples(T, plane, edge_y - 1);
    const row_q0 = rowSamples(T, plane, edge_y);
    const row_q1 = rowSamples(T, plane, edge_y + 1);
    const row_q2 = rowSamples(T, plane, edge_y + 2);
    const result = scalar_kernel.filterEdge(T, .{
        .p2 = row_p2[x],
        .p1 = row_p1[x],
        .p0 = row_p0[x],
        .q0 = row_q0[x],
        .q1 = row_q1[x],
        .q2 = row_q2[x],
    }, thresholds);
    row_p1[x] = result.p1;
    row_p0[x] = result.p0;
    row_q0[x] = result.q0;
    row_q1[x] = result.q1;
}

fn filterVerticalSegment(
    comptime T: type,
    plane: BytePlane,
    edge_x: usize,
    row_start: usize,
    thresholds: Thresholds,
) void {
    const row_end = @min(row_start + scalar_schedule.edge_step, plane.height);
    const row_count = row_end - row_start;
    if (row_count == scalar_schedule.edge_step) {
        filterVerticalFourRows(T, plane, edge_x, row_start, thresholds);
        return;
    }

    // C2 bottom underfill: the legal 1..3 rows are still processed, using the
    // frozen scalar edge body. No read is widened beyond the valid segment.
    var y = row_start;
    while (y < row_end) : (y += 1) {
        filterVerticalScalarRow(T, plane, edge_x, y, thresholds);
    }
}

fn filterVerticalFourRows(
    comptime T: type,
    plane: BytePlane,
    edge_x: usize,
    row_start: usize,
    thresholds: Thresholds,
) void {
    var windows: [4][6]T = undefined;
    inline for (0..4) |lane| {
        const row = rowSamples(T, plane, row_start + lane);
        windows[lane] = loadWindow6(T, row, edge_x - 3);
    }

    const result = filterLanes(T, 4, .{
        .p2 = lanePackFromWindows(T, windows, 0),
        .p1 = lanePackFromWindows(T, windows, 1),
        .p0 = lanePackFromWindows(T, windows, 2),
        .q0 = lanePackFromWindows(T, windows, 3),
        .q1 = lanePackFromWindows(T, windows, 4),
        .q2 = lanePackFromWindows(T, windows, 5),
    }, thresholds);

    const p1: [4]T = result.p1;
    const p0: [4]T = result.p0;
    const q0: [4]T = result.q0;
    const q1: [4]T = result.q1;
    inline for (0..4) |lane| {
        const row = rowSamples(T, plane, row_start + lane);
        const output = [4]T{ p1[lane], p0[lane], q0[lane], q1[lane] };
        storeWindow4(T, row, edge_x - 2, output);
    }
}

fn filterVerticalScalarRow(
    comptime T: type,
    plane: BytePlane,
    edge_x: usize,
    y: usize,
    thresholds: Thresholds,
) void {
    const row = rowSamples(T, plane, y);
    const result = scalar_kernel.filterEdge(T, .{
        .p2 = row[edge_x - 3],
        .p1 = row[edge_x - 2],
        .p0 = row[edge_x - 1],
        .q0 = row[edge_x],
        .q1 = row[edge_x + 1],
        .q2 = row[edge_x + 2],
    }, thresholds);
    row[edge_x - 2] = result.p1;
    row[edge_x - 1] = result.p0;
    row[edge_x] = result.q0;
    row[edge_x + 1] = result.q1;
}

fn lanePackFromWindows(
    comptime T: type,
    windows: [4][6]T,
    comptime tap: usize,
) @Vector(4, T) {
    const values = [4]T{
        windows[0][tap],
        windows[1][tap],
        windows[2][tap],
        windows[3][tap],
    };
    return values;
}

fn loadWindow6(comptime T: type, row: []T, start: usize) [6]T {
    var values: [6]T = undefined;
    @memcpy(values[0..], row[start..][0..6]);
    return values;
}

fn storeWindow4(comptime T: type, row: []T, start: usize, values: [4]T) void {
    @memcpy(row[start..][0..4], values[0..]);
}

fn loadContiguous(
    comptime T: type,
    comptime L: usize,
    row: []T,
    start: usize,
) @Vector(L, T) {
    return row[start..][0..L].*;
}

fn storeContiguous(
    comptime T: type,
    comptime L: usize,
    row: []T,
    start: usize,
    lanes: @Vector(L, T),
) void {
    const values: [L]T = lanes;
    @memcpy(row[start..][0..L], values[0..]);
}

fn rowSamples(comptime T: type, plane: BytePlane, y: usize) []T {
    requireStorageType(T);
    const row_bytes = plane.base + y * plane.stride_bytes;
    const row_ptr: [*]T = @ptrCast(@alignCast(row_bytes));
    return row_ptr[0..plane.width];
}

fn absDiff(comptime L: usize, a: I32Vector(L), b: I32Vector(L)) I32Vector(L) {
    const difference = a - b;
    const zero: I32Vector(L) = @splat(0);
    return @select(i32, difference < zero, -difference, difference);
}

fn clampVector(
    comptime L: usize,
    value: I32Vector(L),
    low: I32Vector(L),
    high: I32Vector(L),
) I32Vector(L) {
    const low_clamped = @select(i32, value < low, low, value);
    return @select(i32, low_clamped > high, high, low_clamped);
}

fn requireStorageType(comptime T: type) void {
    if (T != u8 and T != u16) {
        @compileError("Classic vector storage must be exactly u8 or u16");
    }
}

fn requireBackendWidth(comptime T: type, comptime N: usize) void {
    requireStorageType(T);
    if ((T == u8 and N != 16 and N != 32) or
        (T == u16 and N != 8 and N != 16))
    {
        @compileError("Classic vector width is not a ratified 4C/5C width");
    }
}

fn expectLaneMatchesScalar(
    comptime T: type,
    comptime L: usize,
    inputs: [L]scalar_kernel.EdgeSamples(T),
    thresholds: Thresholds,
) !void {
    var p2: [L]T = undefined;
    var p1: [L]T = undefined;
    var p0: [L]T = undefined;
    var q0: [L]T = undefined;
    var q1: [L]T = undefined;
    var q2: [L]T = undefined;
    inline for (0..L) |lane| {
        p2[lane] = inputs[lane].p2;
        p1[lane] = inputs[lane].p1;
        p0[lane] = inputs[lane].p0;
        q0[lane] = inputs[lane].q0;
        q1[lane] = inputs[lane].q1;
        q2[lane] = inputs[lane].q2;
    }

    const actual = filterLanes(T, L, .{
        .p2 = p2,
        .p1 = p1,
        .p0 = p0,
        .q0 = q0,
        .q1 = q1,
        .q2 = q2,
    }, thresholds);
    const actual_p1: [L]T = actual.p1;
    const actual_p0: [L]T = actual.p0;
    const actual_q0: [L]T = actual.q0;
    const actual_q1: [L]T = actual.q1;
    const actual_activated: [L]bool = actual.activated;

    inline for (0..L) |lane| {
        const expected = scalar_kernel.filterEdge(T, inputs[lane], thresholds);
        try std.testing.expectEqual(expected.p1, actual_p1[lane]);
        try std.testing.expectEqual(expected.p0, actual_p0[lane]);
        try std.testing.expectEqual(expected.q0, actual_q0[lane]);
        try std.testing.expectEqual(expected.q1, actual_q1[lane]);
        try std.testing.expectEqual(expected.activated, actual_activated[lane]);
    }
}

test "vector lane body matches scalar A and B discriminator set" {
    const t = thresholds_module.resolve(25, 0, 0, 8);
    const inputs = [8]scalar_kernel.EdgeSamples(u8){
        .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 113, .q1 = 113, .q2 = 113 },
        .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 112, .q1 = 112, .q2 = 112 },
        .{ .p2 = 100, .p1 = 104, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 110 },
        .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 114, .q2 = 114 },
        .{ .p2 = 110, .p1 = 110, .p0 = 110, .q0 = 100, .q1 = 100, .q2 = 100 },
        .{ .p2 = 200, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 110 },
        .{ .p2 = 0, .p1 = 0, .p0 = 0, .q0 = 9, .q1 = 9, .q2 = 9 },
        .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 106 },
    };
    try expectLaneMatchesScalar(u8, 8, inputs, t);
}

test "vector lane body matches scalar 16-bit discriminator" {
    const input = scalar_kernel.EdgeSamples(u16){
        .p2 = 25600,
        .p1 = 25600,
        .p0 = 25600,
        .q0 = 28160,
        .q1 = 28160,
        .q2 = 28160,
    };
    try expectLaneMatchesScalar(
        u16,
        4,
        [4]scalar_kernel.EdgeSamples(u16){ input, input, input, input },
        thresholds_module.resolve(25, 0, 0, 16),
    );
}

fn TestPlane(comptime T: type) type {
    requireStorageType(T);
    return struct {
        const Self = @This();

        allocator: std.mem.Allocator,
        storage: []T,
        width: usize,
        height: usize,
        stride_samples: usize,
        prefix_samples: usize,
        suffix_samples: usize,

        fn init(allocator: std.mem.Allocator, width: usize, height: usize) !Self {
            const stride_samples = width + 7;
            const prefix_samples: usize = 16;
            const suffix_samples: usize = 16;
            const storage = try allocator.alloc(
                T,
                prefix_samples + height * stride_samples + suffix_samples,
            );
            @memset(storage, testCanary(T));
            return .{
                .allocator = allocator,
                .storage = storage,
                .width = width,
                .height = height,
                .stride_samples = stride_samples,
                .prefix_samples = prefix_samples,
                .suffix_samples = suffix_samples,
            };
        }

        fn deinit(self: *Self) void {
            self.allocator.free(self.storage);
            self.* = undefined;
        }

        fn plane(self: *Self) BytePlane {
            return .{
                .base = @ptrCast(self.storage.ptr + self.prefix_samples),
                .width = self.width,
                .height = self.height,
                .stride_bytes = self.stride_samples * @sizeOf(T),
            };
        }

        fn set(self: *Self, x: usize, y: usize, value: T) void {
            self.storage[self.prefix_samples + y * self.stride_samples + x] = value;
        }

        fn get(self: *const Self, x: usize, y: usize) T {
            return self.storage[self.prefix_samples + y * self.stride_samples + x];
        }

        fn expectGuards(self: *const Self) !void {
            const canary = testCanary(T);
            for (self.storage[0..self.prefix_samples]) |value| {
                try std.testing.expectEqual(canary, value);
            }
            for (0..self.height) |y| {
                const row_start = self.prefix_samples + y * self.stride_samples;
                for (self.storage[row_start + self.width .. row_start + self.stride_samples]) |value| {
                    try std.testing.expectEqual(canary, value);
                }
            }
            const suffix_start = self.prefix_samples + self.height * self.stride_samples;
            for (self.storage[suffix_start .. suffix_start + self.suffix_samples]) |value| {
                try std.testing.expectEqual(canary, value);
            }
        }
    };
}

fn testCanary(comptime T: type) T {
    return if (T == u8) 0xD7 else 0xD7D7;
}

fn fillStructured(comptime T: type, plane: *TestPlane(T), bits_per_sample: u8) void {
    const scale: u32 = @as(u32, 1) << @as(u5, @intCast(bits_per_sample - 8));
    for (0..plane.height) |y| {
        for (0..plane.width) |x| {
            const block_term: u32 = @intCast(((x / 4) * 7 + (y / 4) * 5) % 19);
            const fine_term: u32 = @intCast((x * 3 + y * 11) % 5);
            const value = (80 + block_term + fine_term) * scale;
            plane.set(x, y, @intCast(value));
        }
    }
}

fn expectFixtureMatchesScalar(
    comptime T: type,
    comptime N: usize,
    width: usize,
    height: usize,
    input: []const T,
    thresholds: Thresholds,
) !void {
    std.debug.assert(input.len == width * height);
    var expected = try TestPlane(T).init(std.testing.allocator, width, height);
    defer expected.deinit();
    var actual = try TestPlane(T).init(std.testing.allocator, width, height);
    defer actual.deinit();

    for (input, 0..) |value, index| {
        const x = index % width;
        const y = index / width;
        expected.set(x, y, value);
        actual.set(x, y, value);
    }

    scalar_schedule.processPlane(T, expected.plane(), thresholds);
    processPlane(T, N, actual.plane(), thresholds);
    for (0..height) |y| {
        for (0..width) |x| {
            try std.testing.expectEqual(expected.get(x, y), actual.get(x, y));
        }
    }
    try expected.expectGuards();
    try actual.expectGuards();
}

fn expectPlaneMatchesScalar(
    comptime T: type,
    comptime N: usize,
    width: usize,
    height: usize,
    thresholds: Thresholds,
    bits_per_sample: u8,
) !void {
    var expected = try TestPlane(T).init(std.testing.allocator, width, height);
    defer expected.deinit();
    var actual = try TestPlane(T).init(std.testing.allocator, width, height);
    defer actual.deinit();

    fillStructured(T, &expected, bits_per_sample);
    for (0..height) |y| {
        for (0..width) |x| actual.set(x, y, expected.get(x, y));
    }

    scalar_schedule.processPlane(T, expected.plane(), thresholds);
    processPlane(T, N, actual.plane(), thresholds);

    for (0..height) |y| {
        for (0..width) |x| {
            try std.testing.expectEqual(expected.get(x, y), actual.get(x, y));
        }
    }
    try expected.expectGuards();
    try actual.expectGuards();
}

fn expectOneLaneTailMatchesScalar(
    comptime T: type,
    comptime N: usize,
    bits_per_sample: u8,
) !void {
    const width = N + 1;
    const height: usize = 6;
    const edge_y: usize = 3;
    const column_start = N;
    const thresholds = thresholds_module.resolve(60, 0, 0, bits_per_sample);

    var expected = try TestPlane(T).init(std.testing.allocator, width, height);
    defer expected.deinit();
    var actual = try TestPlane(T).init(std.testing.allocator, width, height);
    defer actual.deinit();

    fillStructured(T, &expected, bits_per_sample);
    for (0..height) |y| {
        for (0..width) |x| actual.set(x, y, expected.get(x, y));
    }

    // Exercise the final scalar cleanup lane directly. This is deliberately
    // independent of later Schedule-A edges so the T5 one-lane mutation cannot
    // be hidden by subsequent frame traversal.
    filterHorizontalScalarColumn(T, expected.plane(), column_start, edge_y, thresholds);
    // Exercise the exact N==1 cleanup specialization targeted by T5.
    filterHorizontalTail(T, 1, actual.plane(), column_start, edge_y, 1, thresholds);

    for (0..height) |y| {
        for (0..width) |x| {
            try std.testing.expectEqual(expected.get(x, y), actual.get(x, y));
        }
    }
    try expected.expectGuards();
    try actual.expectGuards();
}

fn nextPseudoRandom(state: *u64) u32 {
    state.* = state.* *% 6364136223846793005 +% 1442695040888963407;
    return @truncate(state.* >> 16);
}

fn randomEdgeSamples(comptime T: type, state: *u64, bits_per_sample: u8) scalar_kernel.EdgeSamples(T) {
    const peak: u32 = (@as(u32, 1) << @as(u5, @intCast(bits_per_sample))) - 1;
    return .{
        .p2 = @intCast(nextPseudoRandom(state) & peak),
        .p1 = @intCast(nextPseudoRandom(state) & peak),
        .p0 = @intCast(nextPseudoRandom(state) & peak),
        .q0 = @intCast(nextPseudoRandom(state) & peak),
        .q1 = @intCast(nextPseudoRandom(state) & peak),
        .q2 = @intCast(nextPseudoRandom(state) & peak),
    };
}

test "strong-delta lane body matches scalar" {
    const input = scalar_kernel.EdgeSamples(u8){
        .p2 = 195,
        .p1 = 195,
        .p0 = 195,
        .q0 = 5,
        .q1 = 5,
        .q2 = 5,
    };
    try expectLaneMatchesScalar(
        u8,
        4,
        [4]scalar_kernel.EdgeSamples(u8){ input, input, input, input },
        thresholds_module.resolve(60, 0, 0, 8),
    );
}

test "exhaustive 8-bit p0 q0 single-edge sweep matches scalar" {
    const thresholds = thresholds_module.resolve(60, 0, 0, 8);
    var p0_value: u16 = 0;
    while (p0_value <= 255) : (p0_value += 1) {
        var q0_base: u16 = 0;
        while (q0_base <= 240) : (q0_base += 16) {
            var inputs: [16]scalar_kernel.EdgeSamples(u8) = undefined;
            inline for (0..16) |lane| {
                const p: u8 = @intCast(p0_value);
                const q: u8 = @intCast(q0_base + lane);
                inputs[lane] = .{
                    .p2 = p,
                    .p1 = p,
                    .p0 = p,
                    .q0 = q,
                    .q1 = q,
                    .q2 = q,
                };
            }
            try expectLaneMatchesScalar(u8, 16, inputs, thresholds);
        }
        if (p0_value == 255) break;
    }
}

test "seeded random lane properties match scalar for u8 and u16" {
    // Fixed seed is part of the permanent G9 regression corpus.
    var state: u64 = 0x4C5EED1D3A7A11C5;

    var batch: usize = 0;
    while (batch < 256) : (batch += 1) {
        var inputs_u8: [16]scalar_kernel.EdgeSamples(u8) = undefined;
        for (&inputs_u8) |*input| input.* = randomEdgeSamples(u8, &state, 8);
        const strength_u8: u8 = @intCast(nextPseudoRandom(&state) % 61);
        try expectLaneMatchesScalar(
            u8,
            16,
            inputs_u8,
            thresholds_module.resolve(strength_u8, 0, 0, 8),
        );
    }

    var bits: u8 = 9;
    while (bits <= 16) : (bits += 1) {
        batch = 0;
        while (batch < 64) : (batch += 1) {
            var inputs_u16: [8]scalar_kernel.EdgeSamples(u16) = undefined;
            for (&inputs_u16) |*input| input.* = randomEdgeSamples(u16, &state, bits);
            const strength_u16: u8 = @intCast(nextPseudoRandom(&state) % 61);
            try expectLaneMatchesScalar(
                u16,
                8,
                inputs_u16,
                thresholds_module.resolve(strength_u16, 0, 0, bits),
            );
        }
        if (bits == 16) break;
    }
}

test "D3 A and B fixtures match scalar in both orientations" {
    const defaults = thresholds_module.resolve(25, 0, 0, 8);
    const Fixture = struct { taps: [6]u8, thresholds: Thresholds };
    const fixtures = [_]Fixture{
        .{ .taps = .{ 100, 100, 100, 113, 113, 113 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 112, 112, 112 }, .thresholds = defaults },
        .{ .taps = .{ 100, 104, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 100, 100, 100 }, .thresholds = thresholds_module.resolve(0, 0, 0, 8) },
        .{ .taps = .{ 100, 100, 100, 110, 114, 114 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 110, 110, 110, 100, 100, 100 }, .thresholds = defaults },
        .{ .taps = .{ 200, 100, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 0, 0, 0, 9, 9, 9 }, .thresholds = defaults },
        .{ .taps = .{ 195, 195, 195, 5, 5, 5 }, .thresholds = thresholds_module.resolve(60, 0, 0, 8) },
        .{ .taps = .{ 104, 100, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 110, 110, 106 }, .thresholds = defaults },
    };
    for (fixtures) |fixture| {
        const flat = [7]u8{ 0x5A, fixture.taps[0], fixture.taps[1], fixture.taps[2], fixture.taps[3], fixture.taps[4], fixture.taps[5] };
        try expectFixtureMatchesScalar(u8, 16, 7, 1, &flat, fixture.thresholds);
        try expectFixtureMatchesScalar(u8, 16, 1, 7, &flat, fixture.thresholds);
    }
}

test "D3 O-4 exact input and O-5d native16 input match scalar" {
    const o4 = [_]u8{
        100,100,100,100,110,110,110,110,
        100,100,100,100,110,110,110,110,
        100,100,100,100,110,110,110,110,
        100,100,100,100,110,110,110,110,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
    };
    try expectFixtureMatchesScalar(u8, 16, 8, 8, &o4, thresholds_module.resolve(25, 0, 0, 8));

    const o5d = [_]u16{
        25600,25600,25600,25600,28160,28160,28160,28160,
        25600,25600,25600,25600,28160,28160,28160,28160,
        25600,25600,25600,25600,28160,28160,28160,28160,
        25600,25600,25600,25600,28160,28160,28160,28160,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
    };
    try expectFixtureMatchesScalar(u16, 8, 8, 8, &o5d, thresholds_module.resolve(25, 0, 0, 16));
}

test "D3 O-7 exact geometry inputs match scalar" {
    var input_10x10: [100]u8 = undefined;
    for (0..10) |y| {
        for (0..10) |x| input_10x10[y * 10 + x] = if (y < 4) (if (x < 4) 100 else 110) else 112;
    }
    try expectFixtureMatchesScalar(u8, 16, 10, 10, &input_10x10, thresholds_module.resolve(25, 0, 0, 8));

    var input_12x6: [72]u8 = undefined;
    for (0..6) |y| {
        for (0..12) |x| input_12x6[y * 12 + x] = if (x < 4) 100 else if (x < 8) 110 else 120;
    }
    try expectFixtureMatchesScalar(u8, 16, 12, 6, &input_12x6, thresholds_module.resolve(25, 0, 0, 8));

    var input_6x6: [36]u8 = undefined;
    for (&input_6x6, 0..) |*sample, index| sample.* = @intCast(index * 7 % 256);
    try expectFixtureMatchesScalar(u8, 16, 6, 6, &input_6x6, thresholds_module.resolve(25, 0, 0, 8));

    var input_11x7: [77]u8 = undefined;
    for (0..7) |y| {
        for (0..11) |x| input_11x7[y * 11 + x] = if (y < 4) (if (x < 4) 100 else if (x < 8) 110 else 120) else 112;
    }
    try expectFixtureMatchesScalar(u8, 16, 11, 7, &input_11x7, thresholds_module.resolve(25, 0, 0, 8));
}

test "whole-plane vector schedule matches scalar O-4 and O-7 geometry family" {
    const t8 = thresholds_module.resolve(25, 0, 0, 8);
    try expectPlaneMatchesScalar(u8, 16, 8, 8, t8, 8);
    try expectPlaneMatchesScalar(u8, 16, 10, 10, t8, 8);
    try expectPlaneMatchesScalar(u8, 16, 12, 6, t8, 8);
    try expectPlaneMatchesScalar(u8, 16, 6, 6, t8, 8);
    try expectPlaneMatchesScalar(u8, 16, 11, 7, t8, 8);
    try expectPlaneMatchesScalar(
        u16,
        8,
        8,
        8,
        thresholds_module.resolve(25, 0, 0, 16),
        16,
    );
}

test "u8 whole-plane horizontal tails cover every 4C remainder" {
    const thresholds = thresholds_module.resolve(60, 0, 0, 8);
    var remainder: usize = 1;
    while (remainder < 16) : (remainder += 1) {
        try expectPlaneMatchesScalar(u8, 16, 32 + remainder, 11, thresholds, 8);
    }
    try expectOneLaneTailMatchesScalar(u8, 16, 8);
}

test "u16 whole-plane horizontal tails cover every 4C remainder" {
    var bits: u8 = 9;
    while (bits <= 16) : (bits += 1) {
        const thresholds = thresholds_module.resolve(60, 0, 0, bits);
        var remainder: usize = 1;
        while (remainder < 8) : (remainder += 1) {
            try expectPlaneMatchesScalar(u16, 8, 24 + remainder, 11, thresholds, bits);
        }
        if (bits == 16) break;
    }
    try expectOneLaneTailMatchesScalar(u16, 8, 16);
}

test "vertical four-row lane pack and bottom underfills match scalar" {
    const thresholds = thresholds_module.resolve(60, 0, 0, 8);
    try expectPlaneMatchesScalar(u8, 16, 23, 8, thresholds, 8);
    try expectPlaneMatchesScalar(u8, 16, 23, 9, thresholds, 8);
    try expectPlaneMatchesScalar(u8, 16, 23, 10, thresholds, 8);
    try expectPlaneMatchesScalar(u8, 16, 23, 11, thresholds, 8);
}
