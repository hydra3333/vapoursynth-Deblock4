const std = @import("std");

pub const dll_probe_value: u32 = 0x4442_3401;

// `export` makes this symbol externally visible using the C ABI.
// This is only a build/link probe; it is not the VapourSynth entry point.
export fn deblock4_build_probe_value() u32 {
    return dll_probe_value;
}

test "DLL probe export returns the expected value" {
    try std.testing.expectEqual(
        @as(u32, 0x4442_3401),
        deblock4_build_probe_value(),
    );
}
