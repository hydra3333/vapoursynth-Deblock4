// Deblock4 arInitial request policy.
const vs = @import("vapoursynth_api4");
const instance_module = @import("deblock4_instance_data.zig");
const frame_mechanics = @import("common_frame_mechanics.zig");

pub fn handle(
    n: c_int,
    instance: *const instance_module.Deblock4InstanceData,
    frame_context: ?*vs.VSFrameContext,
    vsapi: [*c]const vs.VSAPI,
) ?*const vs.VSFrame {
    frame_mechanics.requestSourceFrame(
        n,
        instance.common.source_node_handle,
        frame_context,
        vsapi,
    );
    return null;
}
