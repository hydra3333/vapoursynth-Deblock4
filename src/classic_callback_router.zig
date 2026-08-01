// Stage 1C Classic callback router.
//
// The activation-reason switch is permanent. Phase 3a fills its branch
// targets but does not restructure the switch.
const std = @import("std");
const vs = @import("vapoursynth_api4");
const config = @import("deblock4_config.zig");
const instance_module = @import("classic_instance_data.zig");
const ar_initial = @import("classic_ar_initial.zig");
const ar_all_frames_ready = @import("classic_ar_all_frames_ready.zig");
const common_ar_error = @import("common_ar_error.zig");

const lifecycle_dbg = if (config.debug.enable_trace_lifecycle)
    @import("lifecycle_trace_debug.zig")
else
    struct {};

pub fn getFrame(
    n: c_int,
    activation_reason: c_int,
    instance_data: ?*anyopaque,
    frame_data: [*c]?*anyopaque,
    frame_context: ?*vs.VSFrameContext,
    core: ?*vs.VSCore,
    vsapi: [*c]const vs.VSAPI,
) callconv(.c) ?*const vs.VSFrame {
    _ = frame_data;

    const raw_instance = instance_data orelse return null;
    const instance: *instance_module.ClassicInstanceData =
        @ptrCast(@alignCast(raw_instance));

    if (config.debug.enable_trace_lifecycle) {
        lifecycle_dbg.tools.getFrame(
            "enter",
            "Classic",
            instance.common.instance_id,
            n,
            activation_reason,
            false,
        );
    }

    const result = switch (activation_reason) {
        vs.arInitial => ar_initial.handle(
            n,
            instance,
            frame_context,
            vsapi,
        ),
        vs.arAllFramesReady => ar_all_frames_ready.handle(
            n,
            instance,
            frame_context,
            core,
            vsapi,
        ),
        vs.arError => common_ar_error.handle(),
        else => null,
    };

    if (config.debug.enable_trace_lifecycle) {
        lifecycle_dbg.tools.getFrame(
            "exit",
            "Classic",
            instance.common.instance_id,
            n,
            activation_reason,
            result != null,
        );
    }
    return result;
}

pub fn free(
    instance_data: ?*anyopaque,
    core: ?*vs.VSCore,
    vsapi: [*c]const vs.VSAPI,
) callconv(.c) void {
    _ = core;

    const raw_instance = instance_data orelse return;
    const instance: *instance_module.ClassicInstanceData =
        @ptrCast(@alignCast(raw_instance));
    if (config.debug.enable_trace_lifecycle) {
        lifecycle_dbg.tools.free("Classic", instance.common.instance_id);
    }
    if (instance.common.source_node_handle) |raw_source| {
        const source: *vs.VSNode = @ptrCast(raw_source);
        vs.zig_vs_free_node(vsapi, source);
    }
    std.heap.c_allocator.destroy(instance);
}
