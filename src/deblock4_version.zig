// Deblock4 single-homed runtime and emitted version identity.
//
// build.zig.zon remains the permitted package-manifest mirror. The Stage 2C
// whole-plugin proof later verifies that mirror against semantic_version.
pub const semantic_version = "0.1.0-dev";
pub const stage_marker = "2C";
pub const identity_string = semantic_version ++ "+" ++ stage_marker;

pub const vs_major: u16 = 0;
pub const vs_minor: u16 = 1;
pub const vs_packed_version: i32 =
    (@as(i32, vs_major) << 16) | @as(i32, vs_minor);

test "version representations remain internally consistent" {
    const std = @import("std");

    try std.testing.expectEqualStrings("0.1.0-dev", semantic_version);
    try std.testing.expectEqualStrings("2C", stage_marker);
    try std.testing.expectEqualStrings(
        "0.1.0-dev+2C",
        identity_string,
    );
    try std.testing.expectEqual(@as(u16, 0), vs_major);
    try std.testing.expectEqual(@as(u16, 1), vs_minor);
    try std.testing.expectEqual(@as(i32, 1), vs_packed_version);
    try std.testing.expectEqual(
        (@as(i32, vs_major) << 16) | @as(i32, vs_minor),
        vs_packed_version,
    );
}
