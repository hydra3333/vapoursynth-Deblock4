// Classic scalar threshold tables and integer-depth derivation.
//
// These values are the byte-pinned HolyWu r9 tables. c0 deliberately follows
// the alpha-side index; changing that attribution changes Classic output.
const std = @import("std");

pub const table_length: usize = 61;
pub const alphas = [table_length]u16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 17, 20, 22, 25, 28, 32, 36, 40, 45, 50, 56, 63, 71, 80, 90, 101, 113, 127, 144, 162, 182, 203, 226, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 };
pub const betas = [table_length]u16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27 };
pub const cs = [table_length]u16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 7, 8, 8, 10, 11, 12, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35 };

pub const Resolved = struct {
    alpha: i32,
    beta: i32,
    c0: i32,
    c1: i32,
    peak: i32,
};

pub fn resolve(
    strength: u8,
    boundary_strength_offset: i8,
    side_activity_offset: i8,
    bits_per_sample: u8,
) Resolved {
    std.debug.assert(strength <= 60);
    std.debug.assert(bits_per_sample >= 8 and bits_per_sample <= 16);

    const alpha_index_i16 = @as(i16, strength) + @as(i16, boundary_strength_offset);
    const beta_index_i16 = @as(i16, strength) + @as(i16, side_activity_offset);
    std.debug.assert(alpha_index_i16 >= 0 and alpha_index_i16 <= 60);
    std.debug.assert(beta_index_i16 >= 0 and beta_index_i16 <= 60);

    const alpha_index: usize = @intCast(alpha_index_i16);
    const beta_index: usize = @intCast(beta_index_i16);
    const shift: u4 = @intCast(bits_per_sample - 8);
    const scale: i32 = @as(i32, 1) << shift;
    const peak_shift: u5 = @intCast(bits_per_sample);

    return .{
        .alpha = @as(i32, alphas[alpha_index]) * scale,
        .beta = @as(i32, betas[beta_index]) * scale,
        .c0 = @as(i32, cs[alpha_index]) * scale,
        .c1 = scale,
        .peak = (@as(i32, 1) << peak_shift) - 1,
    };
}

fn expectResolved(expected: Resolved, actual: Resolved) !void {
    try std.testing.expectEqual(expected.alpha, actual.alpha);
    try std.testing.expectEqual(expected.beta, actual.beta);
    try std.testing.expectEqual(expected.c0, actual.c0);
    try std.testing.expectEqual(expected.c1, actual.c1);
    try std.testing.expectEqual(expected.peak, actual.peak);
}

test "threshold vectors V1 through V6" {
    try expectResolved(.{ .alpha = 13, .beta = 4, .c0 = 1, .c1 = 1, .peak = 255 }, resolve(25, 0, 0, 8));
    try expectResolved(.{ .alpha = 0, .beta = 0, .c0 = 0, .c1 = 1, .peak = 255 }, resolve(0, 0, 0, 8));
    try expectResolved(.{ .alpha = 255, .beta = 27, .c0 = 35, .c1 = 1, .peak = 255 }, resolve(60, 0, 0, 8));
    try expectResolved(.{ .alpha = 7, .beta = 10, .c0 = 0, .c1 = 1, .peak = 255 }, resolve(30, -10, 5, 8));
    try expectResolved(.{ .alpha = 255, .beta = 18, .c0 = 35, .c1 = 1, .peak = 255 }, resolve(50, 10, 0, 8));
    try expectResolved(.{ .alpha = 3328, .beta = 1024, .c0 = 256, .c1 = 256, .peak = 65535 }, resolve(25, 0, 0, 16));
}

test "all threshold table entries remain pinned" {
    const expected_alphas = [table_length]u16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 5, 6, 7, 8, 9, 10, 12, 13, 15, 17, 20, 22, 25, 28, 32, 36, 40, 45, 50, 56, 63, 71, 80, 90, 101, 113, 127, 144, 162, 182, 203, 226, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255 };
    const expected_betas = [table_length]u16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27 };
    const expected_cs = [table_length]u16{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 7, 8, 8, 10, 11, 12, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35 };
    try std.testing.expectEqualSlices(u16, &expected_alphas, &alphas);
    try std.testing.expectEqualSlices(u16, &expected_betas, &betas);
    try std.testing.expectEqualSlices(u16, &expected_cs, &cs);
}

test "full legal strength and offset-corner domain" {
    var strength: u8 = 0;
    while (strength <= 60) : (strength += 1) {
        const neutral = resolve(strength, 0, 0, 8);
        const index: usize = @intCast(strength);
        try std.testing.expectEqual(@as(i32, alphas[index]), neutral.alpha);
        try std.testing.expectEqual(@as(i32, betas[index]), neutral.beta);
        try std.testing.expectEqual(@as(i32, cs[index]), neutral.c0);
        try std.testing.expectEqual(@as(i32, 1), neutral.c1);
        try std.testing.expectEqual(@as(i32, 255), neutral.peak);
        if (strength == 60) break;
    }

    const selected_strengths = [_]u8{ 0, 25, 60 };
    for (selected_strengths) |s| {
        const low: i8 = -@as(i8, @intCast(s));
        const high: i8 = @as(i8, @intCast(60 - s));
        const corners = [_][2]i8{ .{ low, low }, .{ low, high }, .{ high, low }, .{ high, high } };
        for (corners) |corner| {
            const got = resolve(s, corner[0], corner[1], 8);
            const ai: usize = @intCast(@as(i16, s) + @as(i16, corner[0]));
            const bi: usize = @intCast(@as(i16, s) + @as(i16, corner[1]));
            try std.testing.expectEqual(@as(i32, alphas[ai]), got.alpha);
            try std.testing.expectEqual(@as(i32, betas[bi]), got.beta);
            try std.testing.expectEqual(@as(i32, cs[ai]), got.c0);
            try std.testing.expectEqual(@as(i32, 1), got.c1);
            try std.testing.expectEqual(@as(i32, 255), got.peak);
        }
    }
}

test "bit-depth scaling is exhaustive from 8 through 16" {
    var bits: u8 = 8;
    while (bits <= 16) : (bits += 1) {
        const shift: u4 = @intCast(bits - 8);
        const scale: i32 = @as(i32, 1) << shift;
        const strengths = [_]u8{ 0, 25, 60 };
        for (strengths) |strength| {
            const got = resolve(strength, 0, 0, bits);
            const index: usize = @intCast(strength);
            try std.testing.expectEqual(@as(i32, alphas[index]) * scale, got.alpha);
            try std.testing.expectEqual(@as(i32, betas[index]) * scale, got.beta);
            try std.testing.expectEqual(@as(i32, cs[index]) * scale, got.c0);
            try std.testing.expectEqual(scale, got.c1);
            try std.testing.expectEqual((@as(i32, 1) << @as(u5, @intCast(bits))) - 1, got.peak);
        }
        if (bits == 16) break;
    }
}
