// Classic scalar edge mathematics.
//
// One canonical formula body serves exact u8 and u16 storage. Every
// intermediate is i32; the signed divisions use arithmetic right shift, and
// the possibly-negative delta term is multiplied by four rather than shifted.
const std = @import("std");
const thresholds_module = @import("classic_thresholds.zig");

pub const Thresholds = thresholds_module.Resolved;

pub fn EdgeSamples(comptime T: type) type {
    requireStorageType(T);
    return struct {
        p2: T,
        p1: T,
        p0: T,
        q0: T,
        q1: T,
        q2: T,
    };
}

pub fn EdgeResult(comptime T: type) type {
    requireStorageType(T);
    return struct {
        p1: T,
        p0: T,
        q0: T,
        q1: T,
        activated: bool,
    };
}

pub fn filterEdge(
    comptime T: type,
    samples: EdgeSamples(T),
    thresholds: Thresholds,
) EdgeResult(T) {
    requireStorageType(T);

    const p2: i32 = @intCast(samples.p2);
    const p1: i32 = @intCast(samples.p1);
    const p0: i32 = @intCast(samples.p0);
    const q0: i32 = @intCast(samples.q0);
    const q1: i32 = @intCast(samples.q1);
    const q2: i32 = @intCast(samples.q2);

    if (!(absDiff(p0, q0) < thresholds.alpha and
        absDiff(p1, p0) < thresholds.beta and
        absDiff(q0, q1) < thresholds.beta))
    {
        return .{
            .p1 = samples.p1,
            .p0 = samples.p0,
            .q0 = samples.q0,
            .q1 = samples.q1,
            .activated = false,
        };
    }

    const ap = absDiff(p2, p0);
    const aq = absDiff(q2, q0);
    const p_side_active = ap < thresholds.beta;
    const q_side_active = aq < thresholds.beta;
    const c = thresholds.c0 +
        (if (p_side_active) thresholds.c1 else 0) +
        (if (q_side_active) thresholds.c1 else 0);

    const average = (p0 + q0 + 1) >> 1;
    const delta_unclamped = (((q0 - p0) * 4) + p1 - q1 + 4) >> 3;
    const delta = clampI32(delta_unclamped, -c, c);
    const delta_p1 = clampI32((p2 + average - (p1 * 2)) >> 1, -thresholds.c0, thresholds.c0);
    const delta_q1 = clampI32((q2 + average - (q1 * 2)) >> 1, -thresholds.c0, thresholds.c0);

    return .{
        .p1 = if (p_side_active) sampleFromI32(T, clampI32(p1 + delta_p1, 0, thresholds.peak)) else samples.p1,
        .p0 = sampleFromI32(T, clampI32(p0 + delta, 0, thresholds.peak)),
        .q0 = sampleFromI32(T, clampI32(q0 - delta, 0, thresholds.peak)),
        .q1 = if (q_side_active) sampleFromI32(T, clampI32(q1 + delta_q1, 0, thresholds.peak)) else samples.q1,
        .activated = true,
    };
}

fn requireStorageType(comptime T: type) void {
    if (T != u8 and T != u16) {
        @compileError("Classic scalar storage must be exactly u8 or u16");
    }
}

fn absDiff(a: i32, b: i32) i32 {
    const difference = a - b;
    return if (difference < 0) -difference else difference;
}

fn clampI32(value: i32, low: i32, high: i32) i32 {
    return if (value < low) low else if (value > high) high else value;
}

fn sampleFromI32(comptime T: type, value: i32) T {
    requireStorageType(T);
    return @intCast(value);
}

fn expectResult(comptime T: type, expected: [4]T, actual: EdgeResult(T)) !void {
    try std.testing.expectEqual(expected[0], actual.p1);
    try std.testing.expectEqual(expected[1], actual.p0);
    try std.testing.expectEqual(expected[2], actual.q0);
    try std.testing.expectEqual(expected[3], actual.q1);
}

test "activation vectors A1 through A5" {
    const t = thresholds_module.resolve(25, 0, 0, 8);
    const a1 = filterEdge(u8, .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 113, .q1 = 113, .q2 = 113 }, t);
    try expectResult(u8, .{ 100, 100, 113, 113 }, a1);
    try std.testing.expect(!a1.activated);

    const a2 = filterEdge(u8, .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 112, .q1 = 112, .q2 = 112 }, t);
    try expectResult(u8, .{ 101, 103, 109, 111 }, a2);
    try std.testing.expect(a2.activated);

    const a3 = filterEdge(u8, .{ .p2 = 100, .p1 = 104, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 110 }, t);
    try expectResult(u8, .{ 104, 100, 110, 110 }, a3);
    try std.testing.expect(!a3.activated);

    const a4 = filterEdge(u8, .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 100, .q1 = 100, .q2 = 100 }, thresholds_module.resolve(0, 0, 0, 8));
    try expectResult(u8, .{ 100, 100, 100, 100 }, a4);
    try std.testing.expect(!a4.activated);

    const a5 = filterEdge(u8, .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 114, .q2 = 114 }, t);
    try expectResult(u8, .{ 100, 100, 110, 114 }, a5);
    try std.testing.expect(!a5.activated);
}

test "single-edge vectors B1 through B8" {
    const t = thresholds_module.resolve(25, 0, 0, 8);
    try expectResult(u8, .{ 101, 103, 107, 109 }, filterEdge(u8, .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 110 }, t));
    try expectResult(u8, .{ 109, 107, 103, 101 }, filterEdge(u8, .{ .p2 = 110, .p1 = 110, .p0 = 110, .q0 = 100, .q1 = 100, .q2 = 100 }, t));
    try expectResult(u8, .{ 100, 102, 108, 109 }, filterEdge(u8, .{ .p2 = 200, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 110 }, t));
    try expectResult(u8, .{ 1, 3, 6, 8 }, filterEdge(u8, .{ .p2 = 0, .p1 = 0, .p0 = 0, .q0 = 9, .q1 = 9, .q2 = 9 }, t));
    try expectResult(u8, .{ 160, 158, 42, 40 }, filterEdge(u8, .{ .p2 = 195, .p1 = 195, .p0 = 195, .q0 = 5, .q1 = 5, .q2 = 5 }, thresholds_module.resolve(60, 0, 0, 8)));
    try expectResult(u16, .{ 25856, 26368, 27392, 27904 }, filterEdge(u16, .{ .p2 = 25600, .p1 = 25600, .p0 = 25600, .q0 = 28160, .q1 = 28160, .q2 = 28160 }, thresholds_module.resolve(25, 0, 0, 16)));
    try expectResult(u8, .{ 100, 102, 108, 109 }, filterEdge(u8, .{ .p2 = 104, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 110 }, t));
    try expectResult(u8, .{ 101, 102, 108, 110 }, filterEdge(u8, .{ .p2 = 100, .p1 = 100, .p0 = 100, .q0 = 110, .q1 = 110, .q2 = 106 }, t));
}

test "explicit final sample clamps remain active" {
    try std.testing.expectEqual(@as(i32, 0), clampI32(-1, 0, 255));
    try std.testing.expectEqual(@as(i32, 123), clampI32(123, 0, 255));
    try std.testing.expectEqual(@as(i32, 255), clampI32(256, 0, 255));
}

test "documented 16-bit arithmetic bounds fit i32" {
    const sample_min: i64 = 0;
    const sample_max: i64 = 65535;
    const scale_max: i64 = 256;
    const alpha_max: i64 = 255 * scale_max;
    const beta_max: i64 = 27 * scale_max;
    const c0_max: i64 = 35 * scale_max;
    const c_max: i64 = c0_max + 2 * scale_max;
    const average_numerator_max: i64 = sample_max + sample_max + 1;
    const delta_numerator_min: i64 = 4 * (sample_min - sample_max) + sample_min - sample_max + 4;
    const delta_numerator_max: i64 = 4 * (sample_max - sample_min) + sample_max - sample_min + 4;
    const side_numerator_min: i64 = sample_min + sample_min - 2 * sample_max;
    const side_numerator_max: i64 = sample_max + sample_max - 2 * sample_min;
    const p0_q0_preclamp_min: i64 = sample_min - c_max;
    const p0_q0_preclamp_max: i64 = sample_max + c_max;
    const p1_q1_preclamp_min: i64 = sample_min - c0_max;
    const p1_q1_preclamp_max: i64 = sample_max + c0_max;

    try std.testing.expectEqual(@as(i64, 65280), alpha_max);
    try std.testing.expectEqual(@as(i64, 6912), beta_max);
    try std.testing.expectEqual(@as(i64, 8960), c0_max);
    try std.testing.expectEqual(@as(i64, 9472), c_max);
    try std.testing.expectEqual(@as(i64, 131071), average_numerator_max);
    try std.testing.expectEqual(@as(i64, -327671), delta_numerator_min);
    try std.testing.expectEqual(@as(i64, 327679), delta_numerator_max);
    try std.testing.expectEqual(@as(i64, -131070), side_numerator_min);
    try std.testing.expectEqual(@as(i64, 131070), side_numerator_max);
    try std.testing.expectEqual(@as(i64, -9472), p0_q0_preclamp_min);
    try std.testing.expectEqual(@as(i64, 75007), p0_q0_preclamp_max);
    try std.testing.expectEqual(@as(i64, -8960), p1_q1_preclamp_min);
    try std.testing.expectEqual(@as(i64, 74495), p1_q1_preclamp_max);

    const bounds = [_]i64{
        sample_min, sample_max, alpha_max, beta_max, c0_max, c_max,
        average_numerator_max, delta_numerator_min, delta_numerator_max,
        side_numerator_min, side_numerator_max, p0_q0_preclamp_min,
        p0_q0_preclamp_max, p1_q1_preclamp_min, p1_q1_preclamp_max,
    };
    for (bounds) |bound| {
        try std.testing.expect(bound >= std.math.minInt(i32));
        try std.testing.expect(bound <= std.math.maxInt(i32));
    }
}
