const builtin = @import("builtin");
const std = @import("std");

pub const marker_value: u32 = 0x4442_3410;

comptime {
    if (builtin.cpu.arch != .x86_64 or builtin.os.tag != .windows) {
        @compileError("generic backend probe requires Windows x86-64");
    }

    if (builtin.cpu.has(.x86, .sse4_1) or
        builtin.cpu.has(.x86, .avx) or
        builtin.cpu.has(.x86, .avx2) or
        builtin.cpu.has(.x86, .fma))
    {
        @compileError("generic backend probe contains a gated CPU feature");
    }
}

// Safe baseline marker called by the external backend-isolation smoke test.
export fn deblock4_backend_probe_generic_marker() u32 {
    return marker_value;
}

test "generic backend marker returns the expected value" {
    try std.testing.expectEqual(
        @as(u32, 0x4442_3410),
        deblock4_backend_probe_generic_marker(),
    );
}
