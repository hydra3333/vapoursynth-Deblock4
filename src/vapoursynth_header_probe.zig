const std = @import("std");
const vs = @import("vapoursynth_api4");

// These declarations are required by the intended API4 plugin implementation.
// Checking them here makes a missing or incompatible header fail at compile time.
comptime {
    if (!@hasDecl(vs, "VAPOURSYNTH_API_MAJOR"))
        @compileError("VapourSynth header lacks VAPOURSYNTH_API_MAJOR");

    if (!@hasDecl(vs, "VAPOURSYNTH_API_MINOR"))
        @compileError("VapourSynth header lacks VAPOURSYNTH_API_MINOR");

    if (!@hasDecl(vs, "VSFrame"))
        @compileError("VapourSynth header lacks VSFrame");

    if (!@hasDecl(vs, "VSNode"))
        @compileError("VapourSynth header lacks VSNode");

    if (!@hasDecl(vs, "VSAPI"))
        @compileError("VapourSynth header lacks VSAPI");

    if (!@hasDecl(vs, "VSPLUGINAPI"))
        @compileError("VapourSynth header lacks VSPLUGINAPI");

    if (!@hasDecl(vs, "fmParallel"))
        @compileError("VapourSynth header lacks fmParallel");

    if (!@hasDecl(vs, "arInitial"))
        @compileError("VapourSynth header lacks arInitial");

    if (!@hasDecl(vs, "arAllFramesReady"))
        @compileError("VapourSynth header lacks arAllFramesReady");
}

fn verifyVapourSynthApi4() !void {
    if (vs.VAPOURSYNTH_API_MAJOR != 4)
        return error.UnsupportedVapourSynthApiMajor;

    // Force the translated opaque and function-table types to be usable from
    // Zig without requiring a VapourSynth runtime or calling any API function.
    const frame: ?*vs.VSFrame = null;
    const node: ?*vs.VSNode = null;
    const api: ?*const vs.VSAPI = null;
    const plugin_api: ?*const vs.VSPLUGINAPI = null;

    _ = frame;
    _ = node;
    _ = api;
    _ = plugin_api;

    // Force translation and semantic analysis of the required API4 enum values.
    _ = vs.fmParallel;
    _ = vs.arInitial;
    _ = vs.arAllFramesReady;
}

pub fn main() !void {
    try verifyVapourSynthApi4();

    std.debug.print(
        "Deblock4 VapourSynth API header probe: PASS (API {d}.{d})\n",
        .{
            vs.VAPOURSYNTH_API_MAJOR,
            vs.VAPOURSYNTH_API_MINOR,
        },
    );
}

test "VapourSynth core plugin header is API4 compatible" {
    try verifyVapourSynthApi4();
}
