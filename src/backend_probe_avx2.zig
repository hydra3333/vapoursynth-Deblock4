const builtin = @import("builtin");

pub const marker_value: u32 = 0x4442_3413;

comptime {
    if (builtin.cpu.arch != .x86_64 or builtin.os.tag != .windows) {
        @compileError("AVX2 backend probe requires Windows x86-64");
    }

    // The named x86_64_v3 target supplies complete psABI membership,
    // including FMA. This guard preserves the required AVX-family minimum;
    // Stage 1B.2 assembly inspection proves whole-level containment.
    if (!builtin.cpu.has(.x86, .sse4_1) or
        !builtin.cpu.has(.x86, .avx) or
        !builtin.cpu.has(.x86, .avx2))
    {
        @compileError("AVX2 backend probe target lacks required x86_64_v3 AVX-family features");
    }
}

// G6: object-mode export forces emission and supplies linker visibility.
// The DLL-root anchor takes this address via @extern; it is never called or
// PE-exported in Stage 1B.1.
export fn deblock4_backend_probe_avx2_marker() callconv(.c) u32 {
    return marker_value;
}
