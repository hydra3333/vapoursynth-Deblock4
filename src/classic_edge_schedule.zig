// Classic Schedule-A scalar traversal over a writable plane.
//
// Row starts are navigated in bytes. Each row is cast once to the exact sample
// storage type for within-row sample indexing; no stride division exists.
const std = @import("std");
const kernel = @import("classic_scalar_kernel.zig");
const thresholds_module = @import("classic_thresholds.zig");

pub const edge_step: usize = 4;
pub const read_radius_before: usize = 3;
pub const read_radius_after: usize = 2;
pub const write_radius_before: usize = 2;
pub const write_radius_after: usize = 1;

pub const BytePlane = struct {
    base: [*]u8,
    width: usize,
    height: usize,
    stride_bytes: usize,
};

pub fn processPlane(
    comptime T: type,
    plane: BytePlane,
    thresholds: thresholds_module.Resolved,
) void {
    requireStorageType(T);
    if (plane.width == 0 or plane.height == 0) return;
    std.debug.assert(plane.stride_bytes >= plane.width * @sizeOf(T));

    var x: usize = edge_step;
    while (x < plane.width) : (x += edge_step) {
        if (edgeEligible(x, plane.width)) {
            filterVerticalSegment(T, plane, x, 0, thresholds);
        }
    }

    var y: usize = edge_step;
    while (y < plane.height) : (y += edge_step) {
        const horizontal_eligible = edgeEligible(y, plane.height);
        if (horizontal_eligible) {
            filterHorizontalSegment(T, plane, 0, y, thresholds);
        }

        x = edge_step;
        while (x < plane.width) : (x += edge_step) {
            if (horizontal_eligible) {
                filterHorizontalSegment(T, plane, x, y, thresholds);
            }
            if (edgeEligible(x, plane.width)) {
                filterVerticalSegment(T, plane, x, y, thresholds);
            }
        }
    }
}

pub fn edgeEligible(edge: usize, extent: usize) bool {
    return edge >= read_radius_before and edge + read_radius_after < extent;
}

fn filterVerticalSegment(
    comptime T: type,
    plane: BytePlane,
    edge_x: usize,
    row_start: usize,
    thresholds: thresholds_module.Resolved,
) void {
    const row_end = @min(row_start + edge_step, plane.height);
    var y = row_start;
    while (y < row_end) : (y += 1) {
        const row = rowSamples(T, plane, y);
        const result = kernel.filterEdge(T, .{
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
}

fn filterHorizontalSegment(
    comptime T: type,
    plane: BytePlane,
    column_start: usize,
    edge_y: usize,
    thresholds: thresholds_module.Resolved,
) void {
    const column_end = @min(column_start + edge_step, plane.width);
    const row_p2 = rowSamples(T, plane, edge_y - 3);
    const row_p1 = rowSamples(T, plane, edge_y - 2);
    const row_p0 = rowSamples(T, plane, edge_y - 1);
    const row_q0 = rowSamples(T, plane, edge_y);
    const row_q1 = rowSamples(T, plane, edge_y + 1);
    const row_q2 = rowSamples(T, plane, edge_y + 2);

    var x = column_start;
    while (x < column_end) : (x += 1) {
        const result = kernel.filterEdge(T, .{
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
}

fn rowSamples(comptime T: type, plane: BytePlane, y: usize) [*]T {
    requireStorageType(T);
    const row_bytes = plane.base + y * plane.stride_bytes;
    return @ptrCast(@alignCast(row_bytes));
}

fn requireStorageType(comptime T: type) void {
    if (T != u8 and T != u16) {
        @compileError("Classic schedule storage must be exactly u8 or u16");
    }
}

fn canaryValue(comptime T: type) T {
    requireStorageType(T);
    return if (T == u8) 0xA5 else 0xA5A5;
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
            const stride_samples = width + 4;
            const prefix_samples: usize = 8;
            const suffix_samples: usize = 8;
            const storage = try allocator.alloc(
                T,
                prefix_samples + height * stride_samples + suffix_samples,
            );
            @memset(storage, canaryValue(T));
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
            std.debug.assert(x < self.width and y < self.height);
            self.storage[self.prefix_samples + y * self.stride_samples + x] = value;
        }

        fn get(self: *const Self, x: usize, y: usize) T {
            std.debug.assert(x < self.width and y < self.height);
            return self.storage[self.prefix_samples + y * self.stride_samples + x];
        }

        fn loadFlat(self: *Self, values: []const T) void {
            std.debug.assert(values.len == self.width * self.height);
            for (0..self.height) |y| {
                for (0..self.width) |x| {
                    self.set(x, y, values[y * self.width + x]);
                }
            }
        }

        fn expectLogical(self: *const Self, expected: []const T) !void {
            try std.testing.expectEqual(self.width * self.height, expected.len);
            for (0..self.height) |y| {
                for (0..self.width) |x| {
                    try std.testing.expectEqual(
                        expected[y * self.width + x],
                        self.get(x, y),
                    );
                }
            }
        }

        fn expectGuards(self: *const Self) !void {
            const canary = canaryValue(T);
            for (self.storage[0..self.prefix_samples]) |sample| {
                try std.testing.expectEqual(canary, sample);
            }
            for (0..self.height) |y| {
                const row_start = self.prefix_samples + y * self.stride_samples;
                for (self.storage[row_start + self.width .. row_start + self.stride_samples]) |sample| {
                    try std.testing.expectEqual(canary, sample);
                }
            }
            const suffix_start = self.prefix_samples + self.height * self.stride_samples;
            for (self.storage[suffix_start .. suffix_start + self.suffix_samples]) |sample| {
                try std.testing.expectEqual(canary, sample);
            }
        }
    };
}

fn expectRow(comptime T: type, plane: anytype, y: usize, expected: []const T) !void {
    try std.testing.expectEqual(plane.width, expected.len);
    for (expected, 0..) |value, x| {
        try std.testing.expectEqual(value, plane.get(x, y));
    }
}

fn expectBothOrientations(
    comptime T: type,
    taps: [6]T,
    expected_writes: [4]T,
    thresholds: thresholds_module.Resolved,
) !void {
    const surrounding: T = if (T == u8) 0x5A else 0x5A5A;
    var input: [7]T = undefined;
    input[0] = surrounding;
    for (taps, 0..) |sample, index| input[index + 1] = sample;

    var expected = input;
    expected[2] = expected_writes[0];
    expected[3] = expected_writes[1];
    expected[4] = expected_writes[2];
    expected[5] = expected_writes[3];

    var vertical = try TestPlane(T).init(std.testing.allocator, 7, 1);
    defer vertical.deinit();
    vertical.loadFlat(&input);
    processPlane(T, vertical.plane(), thresholds);
    try vertical.expectLogical(&expected);
    try vertical.expectGuards();

    var horizontal = try TestPlane(T).init(std.testing.allocator, 1, 7);
    defer horizontal.deinit();
    horizontal.loadFlat(&input);
    processPlane(T, horizontal.plane(), thresholds);
    try horizontal.expectLogical(&expected);
    try horizontal.expectGuards();
}

test "A1-A5 and B1-B8 run in both vertical and horizontal orientations" {
    const defaults = thresholds_module.resolve(25, 0, 0, 8);

    try expectBothOrientations(u8, .{ 100, 100, 100, 113, 113, 113 }, .{ 100, 100, 113, 113 }, defaults);
    try expectBothOrientations(u8, .{ 100, 100, 100, 112, 112, 112 }, .{ 101, 103, 109, 111 }, defaults);
    try expectBothOrientations(u8, .{ 100, 104, 100, 110, 110, 110 }, .{ 104, 100, 110, 110 }, defaults);
    try expectBothOrientations(u8, .{ 100, 100, 100, 100, 100, 100 }, .{ 100, 100, 100, 100 }, thresholds_module.resolve(0, 0, 0, 8));
    try expectBothOrientations(u8, .{ 100, 100, 100, 110, 114, 114 }, .{ 100, 100, 110, 114 }, defaults);

    try expectBothOrientations(u8, .{ 100, 100, 100, 110, 110, 110 }, .{ 101, 103, 107, 109 }, defaults);
    try expectBothOrientations(u8, .{ 110, 110, 110, 100, 100, 100 }, .{ 109, 107, 103, 101 }, defaults);
    try expectBothOrientations(u8, .{ 200, 100, 100, 110, 110, 110 }, .{ 100, 102, 108, 109 }, defaults);
    try expectBothOrientations(u8, .{ 0, 0, 0, 9, 9, 9 }, .{ 1, 3, 6, 8 }, defaults);
    try expectBothOrientations(u8, .{ 195, 195, 195, 5, 5, 5 }, .{ 160, 158, 42, 40 }, thresholds_module.resolve(60, 0, 0, 8));
    try expectBothOrientations(u16, .{ 25600, 25600, 25600, 28160, 28160, 28160 }, .{ 25856, 26368, 27392, 27904 }, thresholds_module.resolve(25, 0, 0, 16));
    try expectBothOrientations(u8, .{ 104, 100, 100, 110, 110, 110 }, .{ 100, 102, 108, 109 }, defaults);
    try expectBothOrientations(u8, .{ 100, 100, 100, 110, 110, 106 }, .{ 101, 102, 108, 110 }, defaults);
}

test "Schedule A O-4 exact matrix and order sensitivity" {
    const input = [_]u8{
        100,100,100,100,110,110,110,110,
        100,100,100,100,110,110,110,110,
        100,100,100,100,110,110,110,110,
        100,100,100,100,110,110,110,110,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
    };
    const expected = [_]u8{
        100,100,101,103,107,109,110,110,
        100,100,101,103,107,109,110,110,
        101,101,102,104,108,110,110,110,
        103,103,104,106,109,110,111,111,
        109,109,109,109,110,110,111,111,
        111,111,111,111,111,111,111,111,
        112,112,112,112,112,112,112,112,
        112,112,112,112,112,112,112,112,
    };
    const t = thresholds_module.resolve(25, 0, 0, 8);

    var frame = try TestPlane(u8).init(std.testing.allocator, 8, 8);
    defer frame.deinit();
    frame.loadFlat(&input);
    processPlane(u8, frame.plane(), t);
    try frame.expectLogical(&expected);
    try frame.expectGuards();
    try std.testing.expectEqual(@as(u8, 110), frame.get(5, 2));

    const swapped = struct {
        fn run(comptime Sample: type, plane_view: BytePlane, thresholds: thresholds_module.Resolved) void {
            var x: usize = edge_step;
            while (x < plane_view.width) : (x += edge_step) {
                if (edgeEligible(x, plane_view.width)) {
                    filterVerticalSegment(Sample, plane_view, x, 0, thresholds);
                }
            }
            var y: usize = edge_step;
            while (y < plane_view.height) : (y += edge_step) {
                const horizontal_eligible = edgeEligible(y, plane_view.height);
                if (horizontal_eligible) {
                    filterHorizontalSegment(Sample, plane_view, 0, y, thresholds);
                }
                x = edge_step;
                while (x < plane_view.width) : (x += edge_step) {
                    if (edgeEligible(x, plane_view.width)) {
                        filterVerticalSegment(Sample, plane_view, x, y, thresholds);
                    }
                    if (horizontal_eligible) {
                        filterHorizontalSegment(Sample, plane_view, x, y, thresholds);
                    }
                }
            }
        }
    };
    var wrong = try TestPlane(u8).init(std.testing.allocator, 8, 8);
    defer wrong.deinit();
    wrong.loadFlat(&input);
    swapped.run(u8, wrong.plane(), t);
    var differs = false;
    for (expected, 0..) |value, index| {
        const x = index % 8;
        const y = index / 8;
        if (wrong.get(x, y) != value) differs = true;
    }
    try std.testing.expect(differs);
    try std.testing.expectEqual(@as(u8, 109), wrong.get(5, 2));
    try wrong.expectGuards();
}

test "native 16-bit O-5d matrix" {
    const input = [_]u16{
        25600,25600,25600,25600,28160,28160,28160,28160,
        25600,25600,25600,25600,28160,28160,28160,28160,
        25600,25600,25600,25600,28160,28160,28160,28160,
        25600,25600,25600,25600,28160,28160,28160,28160,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
    };
    const expected = [_]u16{
        25600,25600,25856,26368,27392,27904,28160,28160,
        25600,25600,25856,26368,27392,27904,28160,28160,
        25856,25856,26112,26624,27648,28096,28288,28288,
        26368,26368,26624,27136,27872,28192,28352,28352,
        27904,27904,27976,27988,28108,28264,28480,28480,
        28416,28416,28416,28408,28424,28480,28544,28544,
        28672,28672,28672,28672,28672,28672,28672,28672,
        28672,28672,28672,28672,28672,28672,28672,28672,
    };
    var frame = try TestPlane(u16).init(std.testing.allocator, 8, 8);
    defer frame.deinit();
    frame.loadFlat(&input);
    processPlane(u16, frame.plane(), thresholds_module.resolve(25, 0, 0, 16));
    try frame.expectLogical(&expected);
    try frame.expectGuards();
}

test "O-7 10x10 skips ineligible x8 and y8" {
    var frame = try TestPlane(u8).init(std.testing.allocator, 10, 10);
    defer frame.deinit();
    for (0..10) |y| {
        for (0..10) |x| {
            frame.set(x, y, if (y < 4) (if (x < 4) 100 else 110) else 112);
        }
    }
    processPlane(u8, frame.plane(), thresholds_module.resolve(25, 0, 0, 8));
    const expected_rows = [_][10]u8{
        .{100,100,101,103,107,109,110,110,110,110},
        .{100,100,101,103,107,109,110,110,110,110},
        .{101,101,102,104,108,110,110,110,110,110},
        .{103,103,104,106,109,110,111,111,111,111},
        .{109,109,109,109,110,110,111,111,111,111},
        .{111,111,111,111,111,111,111,111,111,111},
        .{112,112,112,112,112,112,112,112,112,112},
        .{112,112,112,112,112,112,112,112,112,112},
        .{112,112,112,112,112,112,112,112,112,112},
        .{112,112,112,112,112,112,112,112,112,112},
    };
    for (expected_rows, 0..) |row, y| try expectRow(u8, &frame, y, &row);
    try frame.expectGuards();
}

test "O-7 12x6 has vertical-only processing" {
    var frame = try TestPlane(u8).init(std.testing.allocator, 12, 6);
    defer frame.deinit();
    for (0..6) |y| {
        for (0..12) |x| {
            frame.set(x, y, if (x < 4) 100 else if (x < 8) 110 else 120);
        }
    }
    processPlane(u8, frame.plane(), thresholds_module.resolve(25, 0, 0, 8));
    const expected = [_]u8{100,100,101,103,107,109,111,113,117,119,120,120};
    for (0..6) |y| try expectRow(u8, &frame, y, &expected);
    try frame.expectGuards();
}

test "O-7 6x6 is byte-identical pass-through" {
    var frame = try TestPlane(u8).init(std.testing.allocator, 6, 6);
    defer frame.deinit();
    var expected: [36]u8 = undefined;
    for (&expected, 0..) |*sample, index| sample.* = @intCast(index * 7 % 256);
    frame.loadFlat(&expected);
    processPlane(u8, frame.plane(), thresholds_module.resolve(25, 0, 0, 8));
    try frame.expectLogical(&expected);
    try frame.expectGuards();
}

test "O-7 11x7 covers extent mod four equals three" {
    var frame = try TestPlane(u8).init(std.testing.allocator, 11, 7);
    defer frame.deinit();
    for (0..7) |y| {
        for (0..11) |x| {
            frame.set(x, y, if (y < 4) (if (x < 4) 100 else if (x < 8) 110 else 120) else 112);
        }
    }
    processPlane(u8, frame.plane(), thresholds_module.resolve(25, 0, 0, 8));
    const expected_rows = [_][11]u8{
        .{100,100,101,103,107,109,111,113,117,119,120},
        .{100,100,101,103,107,109,111,113,117,119,120},
        .{101,101,102,104,108,110,111,113,116,118,119},
        .{103,103,104,106,109,110,111,113,115,116,117},
        .{109,109,109,109,110,111,112,113,113,114,115},
        .{111,111,111,111,111,111,112,112,113,113,113},
        .{112,112,112,112,112,112,112,112,112,112,112},
    };
    for (expected_rows, 0..) |row, y| try expectRow(u8, &frame, y, &row);
    try frame.expectGuards();
}

test "single-edge taps, surrounding samples, and guard bands remain intact" {
    const input = [_]u8{ 77, 110, 110, 110, 100, 100, 100 };
    const expected = [_]u8{ 77, 110, 109, 107, 103, 101, 100 };
    var frame = try TestPlane(u8).init(std.testing.allocator, 7, 1);
    defer frame.deinit();
    frame.loadFlat(&input);
    processPlane(u8, frame.plane(), thresholds_module.resolve(25, 0, 0, 8));
    try frame.expectLogical(&expected);
    try frame.expectGuards();
}
