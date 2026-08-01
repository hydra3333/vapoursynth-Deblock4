// Deblock4 VapourSynth API4 plugin root.
//
// Thin by design: registration only. Parsing and frame logic remain in their
// settled per-filter modules.
const vs = @import("vapoursynth_api4");
const config = @import("deblock4_config.zig");
const version = @import("deblock4_version.zig");
const classic_creation = @import("classic_instance_creation.zig");
const deblock4_creation = @import("deblock4_instance_creation.zig");

const lifecycle_dbg = if (config.debug.enable_trace_lifecycle)
    @import("lifecycle_trace_debug.zig")
else
    struct {};

const classic_arguments =
    "clip:vnode;strength:int:opt;boundary_strength_offset:int:opt;" ++
    "side_activity_offset:int:opt;planes:int[]:opt;backend:data:opt;";
const deblock4_arguments =
    "clip:vnode;grid_mode:data;strength:int:opt;" ++
    "boundary_strength_offset:int:opt;side_activity_offset:int:opt;" ++
    "planes:int[]:opt;midpoint_threshold_scale:float:opt;" ++
    "backend:data:opt;luma_step_x:int:opt;luma_step_y:int:opt;" ++
    "chroma_step_x:int:opt;chroma_step_y:int:opt;" ++
    "luma_midpoint_enabled:int:opt;";

pub export fn VapourSynthPluginInit2(
    plugin: ?*vs.VSPlugin,
    vspapi: [*c]const vs.VSPLUGINAPI,
) callconv(.c) void {
    if (plugin == null or vspapi == null) return;

    if (config.debug.enable_trace_lifecycle) {
        lifecycle_dbg.tools.pluginInit();
    }

    if (vs.zig_vsp_config_plugin(
        vspapi,
        "com.hydra3333.deblock4",
        "deblock4",
        "Deblock4",
        version.vs_packed_version,
        plugin,
    ) == 0) return;

    _ = vs.zig_vsp_register_function(
        vspapi,
        "Classic",
        classic_arguments,
        "clip:vnode;",
        &classic_creation.create,
        plugin,
    );

    // The namespace "deblock4" and function "Deblock4" deliberately differ
    // only by capitalisation; core.deblock4.Deblock4(...) is legal and settled.
    _ = vs.zig_vsp_register_function(
        vspapi,
        "Deblock4",
        deblock4_arguments,
        "clip:vnode;",
        &deblock4_creation.create,
        plugin,
    );
}
