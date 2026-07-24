const std = @import("std");
const vs = @import("vapoursynth_api4");

// VapourSynth4.h and VSConstants4.h are translated into this Zig module.
// VSHelper4.h is compiled as C and exposed through the bridge declarations
// contained in the translated wrapper header.
comptime {
    // VapourSynth4.h
    if (!@hasDecl(vs, "VAPOURSYNTH_API_MAJOR"))
        @compileError("VapourSynth4.h lacks VAPOURSYNTH_API_MAJOR");

    if (!@hasDecl(vs, "VAPOURSYNTH_API_MINOR"))
        @compileError("VapourSynth4.h lacks VAPOURSYNTH_API_MINOR");

    if (!@hasDecl(vs, "VSFrame"))
        @compileError("VapourSynth4.h lacks VSFrame");

    if (!@hasDecl(vs, "VSNode"))
        @compileError("VapourSynth4.h lacks VSNode");

    if (!@hasDecl(vs, "VSAPI"))
        @compileError("VapourSynth4.h lacks VSAPI");

    if (!@hasDecl(vs, "VSPLUGINAPI"))
        @compileError("VapourSynth4.h lacks VSPLUGINAPI");

    if (!@hasDecl(vs, "fmParallel"))
        @compileError("VapourSynth4.h lacks fmParallel");

    if (!@hasDecl(vs, "arInitial"))
        @compileError("VapourSynth4.h lacks arInitial");

    if (!@hasDecl(vs, "arAllFramesReady"))
        @compileError("VapourSynth4.h lacks arAllFramesReady");

    // VSConstants4.h
    if (!@hasDecl(vs, "VSC_RANGE_LIMITED"))
        @compileError("VSConstants4.h lacks VSC_RANGE_LIMITED");

    if (!@hasDecl(vs, "VSC_RANGE_FULL"))
        @compileError("VSConstants4.h lacks VSC_RANGE_FULL");

    // C bridge to VSHelper4.h
    if (!@hasDecl(vs, "deblock4_vsh_is_constant_video_format"))
        @compileError("VSHelper4.h bridge lacks format helper");

    if (!@hasDecl(vs, "deblock4_vsh_are_valid_dimensions"))
        @compileError("VSHelper4.h bridge lacks dimension helper");

    if (!@hasDecl(vs, "deblock4_vsh_bridge_self_test"))
        @compileError("VSHelper4.h bridge lacks self-test");
}

fn verifyVapourSynthHeaders() !void {
    if (vs.VAPOURSYNTH_API_MAJOR != 4)
        return error.UnsupportedVapourSynthApiMajor;

    if (vs.VAPOURSYNTH_API_MINOR != 2)
        return error.UnsupportedVapourSynthApiMinor;

    // Force semantic analysis of important API types.
    const frame: ?*vs.VSFrame = null;
    const node: ?*vs.VSNode = null;
    const api: ?*const vs.VSAPI = null;
    const plugin_api: ?*const vs.VSPLUGINAPI = null;

    _ = frame;
    _ = node;
    _ = api;
    _ = plugin_api;

    // Force semantic analysis of required API and constants declarations.
    _ = vs.fmParallel;
    _ = vs.arInitial;
    _ = vs.arAllFramesReady;
    _ = vs.VSC_RANGE_LIMITED;
    _ = vs.VSC_RANGE_FULL;

    // Compile, link, execute, and verify representative VSHelper4.h helpers.
    const helper_result = vs.deblock4_vsh_bridge_self_test();

    if (helper_result != 7)
        return error.VapourSynthHelperBridgeSelfTestFailed;
}

pub fn main() !void {
    try verifyVapourSynthHeaders();

    std.debug.print(
        "Deblock4 VapourSynth headers probe: PASS " ++
            "(API {d}.{d}; core/constants translated; helpers compiled as C)\n",
        .{
            vs.VAPOURSYNTH_API_MAJOR,
            vs.VAPOURSYNTH_API_MINOR,
        },
    );
}

test "VapourSynth plugin-side headers are API 4.2 compatible" {
    try verifyVapourSynthHeaders();
}
