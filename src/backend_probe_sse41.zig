const builtin = @import("builtin");

pub const marker_value: u32 = 0x4442_3412;

comptime {
    if (builtin.cpu.arch != .x86_64 or builtin.os.tag != .windows) {
        @compileError("SSE4.1 backend probe requires Windows x86-64");
    }

    if (!builtin.cpu.has(.x86, .sse4_1)) {
        @compileError("SSE4.1 backend probe target lacks SSE4.1");
    }

    if (builtin.cpu.has(.x86, .avx) or
        builtin.cpu.has(.x86, .avx2) or
        builtin.cpu.has(.x86, .fma))
    {
        @compileError("SSE4.1 backend probe target exceeds its provisional contract");
    }
}

// G6: object-mode export forces emission and supplies linker visibility.
// The DLL-root anchor takes this address via @extern; it is never called or
// PE-exported in Stage 1B.1.
export fn deblock4_backend_probe_sse41_marker() callconv(.c) u32 {
    return marker_value;
}
