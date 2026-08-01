// Shared filter-neutral VapourSynth frame mechanics.
//
// This module owns only request, obtain, writable-copy, release, and filter-
// error idioms. It contains no filter policy, property names, or tier logic.
const vs = @import("vapoursynth_api4");

pub fn requestSourceFrame(
    n: c_int,
    source_handle: ?*anyopaque,
    frame_context: ?*vs.VSFrameContext,
    vsapi: [*c]const vs.VSAPI,
) void {
    const source = sourceNode(source_handle) orelse return;
    vs.zig_vs_request_frame_filter(vsapi, n, source, frame_context);
}

pub fn obtainSourceFrame(
    n: c_int,
    source_handle: ?*anyopaque,
    frame_context: ?*vs.VSFrameContext,
    vsapi: [*c]const vs.VSAPI,
) ?*const vs.VSFrame {
    const source = sourceNode(source_handle) orelse return null;
    return vs.zig_vs_get_frame_filter(vsapi, n, source, frame_context);
}

pub fn passThroughWritableCopy(
    source: *const vs.VSFrame,
    core: ?*vs.VSCore,
    vsapi: [*c]const vs.VSAPI,
) ?*vs.VSFrame {
    return vs.zig_vs_copy_frame(vsapi, source, core);
}

pub fn releaseFrame(
    frame: *const vs.VSFrame,
    vsapi: [*c]const vs.VSAPI,
) void {
    vs.zig_vs_free_frame(vsapi, frame);
}

pub fn setFilterError(
    message: [*:0]const u8,
    frame_context: ?*vs.VSFrameContext,
    vsapi: [*c]const vs.VSAPI,
) void {
    vs.zig_vs_set_filter_error(vsapi, message, frame_context);
}

fn sourceNode(handle: ?*anyopaque) ?*vs.VSNode {
    const raw = handle orelse return null;
    return @ptrCast(raw);
}
