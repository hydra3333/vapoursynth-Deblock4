const std = @import("std");
const capability_detection = @import("cpu_capability_detection.zig");

pub const dll_probe_value: u32 = 0x4442_3401;

// `export` makes this symbol externally visible using the C ABI.
// This remains build/link scaffolding, not the VapourSynth entry point. The
// call constructs a real Stage 1B.3 capability record without entering any
// gated backend, making release-artifact absence inspection meaningful.
export fn deblock4_build_probe_value() u32 {
    _ = capability_detection.initInstanceCapabilities(
        "dll-probe",
        .auto,
    ) catch @panic("dll probe capability initialization failed");
    return dll_probe_value;
}

test "DLL probe export returns the expected value" {
    try std.testing.expectEqual(
        @as(u32, 0x4442_3401),
        deblock4_build_probe_value(),
    );
}
