// Stage 5C unit proof for the frozen Classic width-generic vector backend.
//
// This file is test-only. Production code must never import it. It deliberately
// exercises the 256-bit storage widths, every horizontal remainder, minimally
// sample-aligned/non-vector-aligned rows, canaries, and scalar-oracle identity.
const std = @import("std");
const frozen = @import("classic_frozen");
const vector_backend = frozen.vector_backend;
const scalar_kernel = frozen.scalar_kernel;
const scalar_schedule = frozen.edge_schedule;

const ThresholdValues = struct {
    alpha: i32,
    beta: i32,
    c0: i32,
    c1: i32,
    peak: i32,
};

fn thresholdsForBits(bits_per_sample: u8) ThresholdValues {
    std.debug.assert(bits_per_sample >= 8 and bits_per_sample <= 16);
    const shift: u4 = @intCast(bits_per_sample - 8);
    const scale: i32 = @as(i32, 1) << shift;
    return .{
        .alpha = 255 * scale,
        .beta = 27 * scale,
        .c0 = 35 * scale,
        .c1 = scale,
        .peak = (@as(i32, 1) << @as(u5, @intCast(bits_per_sample))) - 1,
    };
}

fn threshold8Strength25() ThresholdValues {
    return .{ .alpha = 13, .beta = 4, .c0 = 1, .c1 = 1, .peak = 255 };
}

fn threshold8Strength0() ThresholdValues {
    return .{ .alpha = 0, .beta = 0, .c0 = 0, .c1 = 1, .peak = 255 };
}

fn threshold16Strength25() ThresholdValues {
    return .{ .alpha = 3328, .beta = 1024, .c0 = 256, .c1 = 256, .peak = 65535 };
}

fn vectorThresholds(t: ThresholdValues) vector_backend.Thresholds {
    return .{ .alpha = t.alpha, .beta = t.beta, .c0 = t.c0, .c1 = t.c1, .peak = t.peak };
}

fn GuardedPlane(comptime T: type) type {
    if (T != u8 and T != u16) @compileError("Stage 5C guarded plane requires u8 or u16");
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
            var stride_samples = width + 1;
            while (((stride_samples * @sizeOf(T)) % 16 == 0) or
                ((stride_samples * @sizeOf(T)) % 32 == 0))
            {
                stride_samples += 1;
            }

            const reserve_prefix: usize = 32;
            const suffix_samples: usize = 32;
            const storage = try allocator.alloc(
                T,
                reserve_prefix + height * stride_samples + suffix_samples,
            );
            @memset(storage, canary(T));

            var prefix_samples: usize = 1;
            while (prefix_samples < reserve_prefix) : (prefix_samples += 1) {
                const address = @intFromPtr(storage.ptr + prefix_samples);
                if (address % 16 != 0 and address % 32 != 0) break;
            }
            std.debug.assert(prefix_samples < reserve_prefix);

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

        fn plane(self: *Self) vector_backend.BytePlane {
            const base = self.storage.ptr + self.prefix_samples;
            std.debug.assert(@intFromPtr(base) % @alignOf(T) == 0);
            std.debug.assert(@intFromPtr(base) % 16 != 0);
            std.debug.assert(@intFromPtr(base) % 32 != 0);
            const stride_bytes = self.stride_samples * @sizeOf(T);
            std.debug.assert(stride_bytes % @alignOf(T) == 0);
            std.debug.assert(stride_bytes % 16 != 0);
            std.debug.assert(stride_bytes % 32 != 0);
            return .{
                .base = @ptrCast(base),
                .width = self.width,
                .height = self.height,
                .stride_bytes = stride_bytes,
            };
        }

        fn scalarPlane(self: *Self) scalar_schedule.BytePlane {
            const p = self.plane();
            return .{ .base = p.base, .width = p.width, .height = p.height, .stride_bytes = p.stride_bytes };
        }

        fn set(self: *Self, x: usize, y: usize, value: T) void {
            self.storage[self.prefix_samples + y * self.stride_samples + x] = value;
        }

        fn get(self: *const Self, x: usize, y: usize) T {
            return self.storage[self.prefix_samples + y * self.stride_samples + x];
        }

        fn expectGuards(self: *const Self) !void {
            const marker = canary(T);
            for (self.storage[0..self.prefix_samples]) |value| {
                try std.testing.expectEqual(marker, value);
            }
            for (0..self.height) |y| {
                const row_start = self.prefix_samples + y * self.stride_samples;
                for (self.storage[row_start + self.width .. row_start + self.stride_samples]) |value| {
                    try std.testing.expectEqual(marker, value);
                }
            }
            const suffix_start = self.prefix_samples + self.height * self.stride_samples;
            for (self.storage[suffix_start ..]) |value| {
                try std.testing.expectEqual(marker, value);
            }
        }
    };
}

fn canary(comptime T: type) T {
    return if (T == u8) 0xD7 else 0xD7D7;
}

fn copyPixels(comptime T: type, dst: *GuardedPlane(T), src: *const GuardedPlane(T)) void {
    for (0..src.height) |y| {
        for (0..src.width) |x| dst.set(x, y, src.get(x, y));
    }
}

fn fillStrongHorizontal(comptime T: type, plane: *GuardedPlane(T), bits_per_sample: u8) void {
    const scale: u32 = @as(u32, 1) << @as(u5, @intCast(bits_per_sample - 8));
    for (0..plane.height) |y| {
        const base_value: u32 = if (y < 4) 195 else 5;
        for (0..plane.width) |x| plane.set(x, y, @intCast(base_value * scale));
    }
}

fn nextPseudoRandom(state: *u64) u32 {
    state.* = state.* *% 6364136223846793005 +% 1442695040888963407;
    return @truncate(state.* >> 16);
}

fn fillRandomWithStrongTail(
    comptime T: type,
    plane: *GuardedPlane(T),
    bits_per_sample: u8,
    state: *u64,
) void {
    const peak: u32 = (@as(u32, 1) << @as(u5, @intCast(bits_per_sample))) - 1;
    for (0..plane.height) |y| {
        for (0..plane.width) |x| plane.set(x, y, @intCast(nextPseudoRandom(state) & peak));
    }

    const scale: u32 = @as(u32, 1) << @as(u5, @intCast(bits_per_sample - 8));
    for (1..7) |y| {
        const value: u32 = if (y < 4) 195 * scale else 5 * scale;
        for (0..plane.width) |x| plane.set(x, y, @intCast(value));
    }
}

fn expectFixtureMatchesScalar(
    comptime T: type,
    comptime N: usize,
    width: usize,
    height: usize,
    input: []const T,
    t: ThresholdValues,
) !void {
    std.debug.assert(input.len == width * height);
    var expected = try GuardedPlane(T).init(std.testing.allocator, width, height);
    defer expected.deinit();
    var actual = try GuardedPlane(T).init(std.testing.allocator, width, height);
    defer actual.deinit();

    for (input, 0..) |value, index| {
        const x = index % width;
        const y = index / width;
        expected.set(x, y, value);
        actual.set(x, y, value);
    }

    scalar_schedule.processPlane(T, expected.scalarPlane(), .{
        .alpha = t.alpha, .beta = t.beta, .c0 = t.c0, .c1 = t.c1, .peak = t.peak,
    });
    vector_backend.processPlane(T, N, actual.plane(), vectorThresholds(t));

    for (0..height) |y| {
        for (0..width) |x| try std.testing.expectEqual(expected.get(x, y), actual.get(x, y));
    }
    try expected.expectGuards();
    try actual.expectGuards();
}

fn expectPlaneMatchesScalar(
    comptime T: type,
    comptime N: usize,
    width: usize,
    height: usize,
    bits_per_sample: u8,
    random_state: ?*u64,
) !void {
    var expected = try GuardedPlane(T).init(std.testing.allocator, width, height);
    defer expected.deinit();
    var actual = try GuardedPlane(T).init(std.testing.allocator, width, height);
    defer actual.deinit();

    if (random_state) |state| {
        fillRandomWithStrongTail(T, &expected, bits_per_sample, state);
    } else {
        fillStrongHorizontal(T, &expected, bits_per_sample);
    }
    copyPixels(T, &actual, &expected);

    const t = thresholdsForBits(bits_per_sample);
    scalar_schedule.processPlane(T, expected.scalarPlane(), .{
        .alpha = t.alpha,
        .beta = t.beta,
        .c0 = t.c0,
        .c1 = t.c1,
        .peak = t.peak,
    });
    vector_backend.processPlane(T, N, actual.plane(), vectorThresholds(t));

    for (0..height) |y| {
        for (0..width) |x| try std.testing.expectEqual(expected.get(x, y), actual.get(x, y));
    }
    try expected.expectGuards();
    try actual.expectGuards();
}

fn expectTailNonVacuous(
    comptime T: type,
    comptime N: usize,
    remainder: usize,
    bits_per_sample: u8,
) !void {
    const width = N + remainder;
    const height: usize = 7;
    var actual = try GuardedPlane(T).init(std.testing.allocator, width, height);
    defer actual.deinit();
    fillStrongHorizontal(T, &actual, bits_per_sample);

    const before = actual.get(N, 3);
    const t = thresholdsForBits(bits_per_sample);
    vector_backend.processPlane(T, N, actual.plane(), vectorThresholds(t));
    try std.testing.expect(actual.get(N, 3) != before);
    try actual.expectGuards();
}

fn expectLaneBatchMatchesScalarU8(inputs: [32]scalar_kernel.EdgeSamples(u8)) !void {
    var p2: [32]u8 = undefined;
    var p1: [32]u8 = undefined;
    var p0: [32]u8 = undefined;
    var q0: [32]u8 = undefined;
    var q1: [32]u8 = undefined;
    var q2: [32]u8 = undefined;
    inline for (0..32) |lane| {
        p2[lane] = inputs[lane].p2;
        p1[lane] = inputs[lane].p1;
        p0[lane] = inputs[lane].p0;
        q0[lane] = inputs[lane].q0;
        q1[lane] = inputs[lane].q1;
        q2[lane] = inputs[lane].q2;
    }
    const t = thresholdsForBits(8);
    const actual = vector_backend.filterLanes(u8, 32, .{
        .p2 = p2, .p1 = p1, .p0 = p0, .q0 = q0, .q1 = q1, .q2 = q2,
    }, vectorThresholds(t));
    const actual_p1: [32]u8 = actual.p1;
    const actual_p0: [32]u8 = actual.p0;
    const actual_q0: [32]u8 = actual.q0;
    const actual_q1: [32]u8 = actual.q1;
    const actual_active: [32]bool = actual.activated;
    inline for (0..32) |lane| {
        const expected = scalar_kernel.filterEdge(u8, inputs[lane], .{
            .alpha = t.alpha, .beta = t.beta, .c0 = t.c0, .c1 = t.c1, .peak = t.peak,
        });
        try std.testing.expectEqual(expected.p1, actual_p1[lane]);
        try std.testing.expectEqual(expected.p0, actual_p0[lane]);
        try std.testing.expectEqual(expected.q0, actual_q0[lane]);
        try std.testing.expectEqual(expected.q1, actual_q1[lane]);
        try std.testing.expectEqual(expected.activated, actual_active[lane]);
    }
}

test "5C D3 A and B fixtures match scalar at N=32 in both orientations" {
    const defaults = threshold8Strength25();
    const Fixture = struct { taps: [6]u8, thresholds: ThresholdValues };
    const fixtures = [_]Fixture{
        .{ .taps = .{ 100, 100, 100, 113, 113, 113 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 112, 112, 112 }, .thresholds = defaults },
        .{ .taps = .{ 100, 104, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 100, 100, 100 }, .thresholds = threshold8Strength0() },
        .{ .taps = .{ 100, 100, 100, 110, 114, 114 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 110, 110, 110, 100, 100, 100 }, .thresholds = defaults },
        .{ .taps = .{ 200, 100, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 0, 0, 0, 9, 9, 9 }, .thresholds = defaults },
        .{ .taps = .{ 195, 195, 195, 5, 5, 5 }, .thresholds = thresholdsForBits(8) },
        .{ .taps = .{ 104, 100, 100, 110, 110, 110 }, .thresholds = defaults },
        .{ .taps = .{ 100, 100, 100, 110, 110, 106 }, .thresholds = defaults },
    };
    for (fixtures) |fixture| {
        const flat = [7]u8{ 0x5A, fixture.taps[0], fixture.taps[1], fixture.taps[2], fixture.taps[3], fixture.taps[4], fixture.taps[5] };
        try expectFixtureMatchesScalar(u8, 32, 7, 1, &flat, fixture.thresholds);
        try expectFixtureMatchesScalar(u8, 32, 1, 7, &flat, fixture.thresholds);
    }
}

test "5C D3 O-4 and O-5d exact inputs match scalar at new widths" {
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
    try expectFixtureMatchesScalar(u8, 32, 8, 8, &o4, threshold8Strength25());

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
    try expectFixtureMatchesScalar(u16, 16, 8, 8, &o5d, threshold16Strength25());
}

test "5C D3 O-7 exact geometry inputs match scalar at N=32" {
    var input_10x10: [100]u8 = undefined;
    for (0..10) |y| {
        for (0..10) |x| input_10x10[y * 10 + x] = if (y < 4) (if (x < 4) 100 else 110) else 112;
    }
    try expectFixtureMatchesScalar(u8, 32, 10, 10, &input_10x10, threshold8Strength25());

    var input_12x6: [72]u8 = undefined;
    for (0..6) |y| {
        for (0..12) |x| input_12x6[y * 12 + x] = if (x < 4) 100 else if (x < 8) 110 else 120;
    }
    try expectFixtureMatchesScalar(u8, 32, 12, 6, &input_12x6, threshold8Strength25());

    var input_6x6: [36]u8 = undefined;
    for (&input_6x6, 0..) |*sample, index| sample.* = @intCast(index * 7 % 256);
    try expectFixtureMatchesScalar(u8, 32, 6, 6, &input_6x6, threshold8Strength25());

    var input_11x7: [77]u8 = undefined;
    for (0..7) |y| {
        for (0..11) |x| input_11x7[y * 11 + x] = if (y < 4) (if (x < 4) 100 else if (x < 8) 110 else 120) else 112;
    }
    try expectFixtureMatchesScalar(u8, 32, 11, 7, &input_11x7, threshold8Strength25());
}

test "5C exhaustive 8-bit p0 q0 single-edge sweep matches scalar at N=32" {
    var p0_value: u16 = 0;
    while (p0_value <= 255) : (p0_value += 1) {
        var q0_base: u16 = 0;
        while (q0_base <= 224) : (q0_base += 32) {
            var inputs: [32]scalar_kernel.EdgeSamples(u8) = undefined;
            inline for (0..32) |lane| {
                const p: u8 = @intCast(p0_value);
                const q: u8 = @intCast(q0_base + lane);
                inputs[lane] = .{ .p2 = p, .p1 = p, .p0 = p, .q0 = q, .q1 = q, .q2 = q };
            }
            try expectLaneBatchMatchesScalarU8(inputs);
        }
        if (p0_value == 255) break;
    }
}

test "5C u8 N=32 every remainder is scalar-identical guarded and non-vacuous" {
    var state: u64 = 0x5C3200A55EED1234;
    var remainder: usize = 1;
    while (remainder < 32) : (remainder += 1) {
        var trial: usize = 0;
        while (trial < 8) : (trial += 1) {
            try expectPlaneMatchesScalar(u8, 32, 64 + remainder, 11, 8, &state);
        }
        try expectTailNonVacuous(u8, 32, remainder, 8);
    }
}

test "5C u16 N=16 every remainder is scalar-identical guarded and non-vacuous" {
    var state: u64 = 0x5C1600B16EED5678;
    var remainder: usize = 1;
    while (remainder < 16) : (remainder += 1) {
        const bits: u8 = @intCast(9 + ((remainder - 1) % 8));
        var trial: usize = 0;
        while (trial < 8) : (trial += 1) {
            try expectPlaneMatchesScalar(u16, 16, 32 + remainder, 11, bits, &state);
        }
        try expectTailNonVacuous(u16, 16, remainder, bits);
    }
}

test "5C vertical width-invariant path covers bottom underfill 1 2 and 3" {
    var state: u64 = 0x5C4C0FFEE1234567;
    for ([_]usize{ 9, 10, 11 }) |height| {
        try expectPlaneMatchesScalar(u8, 32, 13, height, 8, &state);
        try expectPlaneMatchesScalar(u16, 16, 13, height, 16, &state);
    }
}
