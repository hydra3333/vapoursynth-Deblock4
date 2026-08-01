// Stage 1C Phase 2 Classic callback router.
//
// The callback signatures and activation switch are permanent. Phase 3
// replaces only the minimal branch bodies with the settled per-filter
// activation handlers; it must not restructure this switch.
const std = @import("std");
const vs = @import("vapoursynth_api4");
const instance_module = @import("classic_instance_data.zig");

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
    _ = core;

    const raw_instance = instance_data orelse return null;
    const instance: *instance_module.ClassicInstanceData =
        @ptrCast(@alignCast(raw_instance));
    const raw_source = instance.common.source_node_handle orelse return null;
    const source: *vs.VSNode = @ptrCast(raw_source);

    return switch (activation_reason) {
        vs.arInitial => phase2Initial(
            n,
            source,
            frame_context,
            vsapi,
        ),
        vs.arAllFramesReady => phase2AllFramesReady(
            n,
            source,
            frame_context,
            vsapi,
        ),
        vs.arError => phase2Error(),
        else => null,
    };
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
    if (instance.common.source_node_handle) |raw_source| {
        const source: *vs.VSNode = @ptrCast(raw_source);
        vs.zig_vs_free_node(vsapi, source);
    }
    std.heap.c_allocator.destroy(instance);
}

fn phase2Initial(
    n: c_int,
    source: *vs.VSNode,
    frame_context: ?*vs.VSFrameContext,
    vsapi: [*c]const vs.VSAPI,
) ?*const vs.VSFrame {
    vs.zig_vs_request_frame_filter(vsapi, n, source, frame_context);
    return null;
}

fn phase2AllFramesReady(
    n: c_int,
    source: *vs.VSNode,
    frame_context: ?*vs.VSFrameContext,
    vsapi: [*c]const vs.VSAPI,
) ?*const vs.VSFrame {
    // Phase 2 pass-through: return the requested source frame unchanged.
    return vs.zig_vs_get_frame_filter(vsapi, n, source, frame_context);
}

fn phase2Error() ?*const vs.VSFrame {
    return null;
}
