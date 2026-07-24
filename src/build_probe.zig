const std = @import("std");

pub const project_name = "Deblock4";
pub const required_zig_version = "0.16.0";

pub fn main() void {
    std.debug.print(
        "{s} Zig {s} build probe: PASS\n",
        .{ project_name, required_zig_version },
    );
}

test "project identity is stable" {
    try std.testing.expectEqualStrings("Deblock4", project_name);
}

test "basic integer arithmetic works" {
    try std.testing.expectEqual(@as(u32, 42), 40 + 2);
}
