// Deblock4 arAllFramesReady work in the binding C5 order.
const vs = @import("vapoursynth_api4");
const instance_module = @import("deblock4_instance_data.zig");
const frame_mechanics = @import("common_frame_mechanics.zig");
const frame_properties = @import("deblock4_frame_properties.zig");

pub fn handle(
    n: c_int,
    instance: *const instance_module.Deblock4InstanceData,
    frame_context: ?*vs.VSFrameContext,
    core: ?*vs.VSCore,
    vsapi: [*c]const vs.VSAPI,
) ?*const vs.VSFrame {
    // C5.1: obtain the frame requested by arInitial.
    const source = frame_mechanics.obtainSourceFrame(
        n,
        instance.common.source_node_handle,
        frame_context,
        vsapi,
    ) orelse return null;
    defer frame_mechanics.releaseFrame(source, vsapi);

    // C5.2: this filter's only runtime dispatcher is the frozen tier switch.
    const output = switch (instance.common.backend_selection.selected_tier) {
        .x86_64_v1_baseline => frame_mechanics.passThroughWritableCopy(source, core, vsapi),
        .x86_64_v2_with_sse41 => frame_mechanics.passThroughWritableCopy(source, core, vsapi),
        .x86_64_v3_with_avx2 => frame_mechanics.passThroughWritableCopy(source, core, vsapi),
    } orelse {
        frame_mechanics.setFilterError("Deblock4: failed to copy the source frame", frame_context, vsapi);
        return null;
    };

    // C5.3: annotate the final output frame; C5.4 returns that same frame.
    frame_properties.write(output, instance, vsapi) catch {
        frame_mechanics.releaseFrame(output, vsapi);
        frame_mechanics.setFilterError("Deblock4: failed to write audit frame properties", frame_context, vsapi);
        return null;
    };
    return output;
}
