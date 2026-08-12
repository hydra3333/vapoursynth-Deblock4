// Classic arAllFramesReady work in the binding C5 order.
const vs = @import("vapoursynth_api4");
const instance_module = @import("classic_instance_data.zig");
const frame_mechanics = @import("common_frame_mechanics.zig");
const frame_properties = @import("classic_frame_properties.zig");
const edge_schedule = @import("classic_edge_schedule.zig");

const ProcessingError = error{
    InvalidFrameFormat,
    InvalidPlaneGeometry,
    BackendInvariant,
};

pub fn handle(
    n: c_int,
    instance: *const instance_module.ClassicInstanceData,
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

    // C5.2: preserve the copyFrame-equivalent destination state, then run the
    // selected production backend. Stage 2C can resolve only the scalar tier.
    const output = frame_mechanics.passThroughWritableCopy(source, core, vsapi) orelse {
        frame_mechanics.setFilterError("Classic: failed to copy the source frame", frame_context, vsapi);
        return null;
    };

    processOutputFrame(output, instance, vsapi) catch {
        frame_mechanics.releaseFrame(output, vsapi);
        frame_mechanics.setFilterError("Classic: failed to process the destination frame", frame_context, vsapi);
        return null;
    };

    // C5.3: annotate the final output frame; C5.4 returns that same frame.
    frame_properties.write(output, instance, vsapi) catch {
        frame_mechanics.releaseFrame(output, vsapi);
        frame_mechanics.setFilterError("Classic: failed to write audit frame properties", frame_context, vsapi);
        return null;
    };
    return output;
}

fn processOutputFrame(
    output: *vs.VSFrame,
    instance: *const instance_module.ClassicInstanceData,
    vsapi_c: [*c]const vs.VSAPI,
) ProcessingError!void {
    if (vsapi_c == null) return error.InvalidFrameFormat;
    const vsapi: *const vs.VSAPI = @ptrCast(vsapi_c);
    if (instance.common.backend_selection.selected_tier != .x86_64_v1_baseline) {
        return error.BackendInvariant;
    }

    const format_ptr = vsapi.getVideoFrameFormat.?(output);
    if (format_ptr == null) return error.InvalidFrameFormat;
    const format = format_ptr.*;
    if (instance.format.sample_type != vs.stInteger or
        format.sampleType != instance.format.sample_type or
        format.bitsPerSample != @as(c_int, instance.format.bits_per_sample) or
        format.bytesPerSample != @as(c_int, instance.format.bytes_per_sample) or
        format.numPlanes <= 0 or format.numPlanes > 3)
    {
        return error.InvalidFrameFormat;
    }

    var plane: c_int = 0;
    while (plane < format.numPlanes) : (plane += 1) {
        if (!planeSelected(instance, @intCast(plane))) continue;

        const width_raw = vsapi.getFrameWidth.?(output, plane);
        const height_raw = vsapi.getFrameHeight.?(output, plane);
        const stride_raw = vsapi.getStride.?(output, plane);
        const write_ptr_c = vsapi.getWritePtr.?(output, plane);
        if (width_raw <= 0 or height_raw <= 0 or stride_raw <= 0 or write_ptr_c == null) {
            return error.InvalidPlaneGeometry;
        }

        const width: usize = @intCast(width_raw);
        const height: usize = @intCast(height_raw);
        const stride_bytes: usize = @intCast(stride_raw);
        if (stride_bytes < width * @as(usize, instance.format.bytes_per_sample)) {
            return error.InvalidPlaneGeometry;
        }
        const write_ptr: [*]u8 = @ptrCast(write_ptr_c);
        const sample_alignment: usize = switch (instance.format.storage) {
            .u8 => @alignOf(u8),
            .u16 => @alignOf(u16),
        };
        if (@intFromPtr(write_ptr) % sample_alignment != 0 or
            stride_bytes % sample_alignment != 0)
        {
            return error.InvalidPlaneGeometry;
        }
        const plane_view = edge_schedule.BytePlane{
            .base = write_ptr,
            .width = width,
            .height = height,
            .stride_bytes = stride_bytes,
        };

        switch (instance.format.storage) {
            .u8 => edge_schedule.processPlane(u8, plane_view, instance.thresholds),
            .u16 => edge_schedule.processPlane(u16, plane_view, instance.thresholds),
        }
    }
}

fn planeSelected(
    instance: *const instance_module.ClassicInstanceData,
    plane: u32,
) bool {
    const request = instance.parameters.common.planes;
    if (request.all) return true;
    for (request.indices[0..@intCast(request.count)]) |selected| {
        if (selected == plane) return true;
    }
    return false;
}
