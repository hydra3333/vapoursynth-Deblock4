// Deblock4 frame-property policy.
const vs = @import("vapoursynth_api4");
const common = @import("common_instance_data_structure.zig");
const helpers = @import("common_frame_property_helpers.zig");
const instance_module = @import("deblock4_instance_data.zig");
const version = @import("deblock4_version.zig");

const GridAudit = struct {
    mode: []const u8,
    luma_step_x: u32,
    luma_step_y: u32,
    chroma_step_x: u32,
    chroma_step_y: u32,
    midpoint_scale: ?f64,
};

pub fn write(
    frame: *vs.VSFrame,
    instance: *const instance_module.Deblock4InstanceData,
    vsapi: [*c]const vs.VSAPI,
) helpers.WriteError!void {
    const map = try helpers.writableMap(frame, vsapi);
    try helpers.setData(map, "Deblock4Filter", "Deblock4", vsapi);
    try helpers.setData(
        map,
        "Deblock4Tier",
        common.backendTierName(instance.common.backend_selection.selected_tier),
        vsapi,
    );
    try helpers.setData(map, "Deblock4Version", version.identity_string, vsapi);

    const grid = resolvedGrid(instance);
    try helpers.setData(map, "Deblock4GridMode", grid.mode, vsapi);
    try helpers.setInt(map, "Deblock4LumaStepX", grid.luma_step_x, vsapi);
    try helpers.setInt(map, "Deblock4LumaStepY", grid.luma_step_y, vsapi);
    try helpers.setInt(map, "Deblock4ChromaStepX", grid.chroma_step_x, vsapi);
    try helpers.setInt(map, "Deblock4ChromaStepY", grid.chroma_step_y, vsapi);
    if (grid.midpoint_scale) |scale| {
        try helpers.setFloat(map, "Deblock4MidpointScale", scale, vsapi);
    }
}

fn resolvedGrid(
    instance: *const instance_module.Deblock4InstanceData,
) GridAudit {
    return switch (instance.parameters.grid) {
        .mpeg2_progressive => .{
            .mode = "mpeg2_progressive",
            .luma_step_x = 8,
            .luma_step_y = 8,
            .chroma_step_x = 8,
            .chroma_step_y = 8,
            .midpoint_scale = null,
        },
        .mpeg2_field_separated => |grid| .{
            .mode = "mpeg2_field_separated",
            .luma_step_x = 8,
            .luma_step_y = 4,
            .chroma_step_x = 8,
            .chroma_step_y = 4,
            .midpoint_scale = grid.midpoint_threshold_scale,
        },
        .custom => |grid| .{
            .mode = "custom",
            .luma_step_x = grid.luma_step_x,
            .luma_step_y = grid.luma_step_y,
            .chroma_step_x = grid.chroma_step_x,
            .chroma_step_y = grid.chroma_step_y,
            .midpoint_scale = if (grid.luma_midpoint_enabled)
                grid.midpoint_threshold_scale
            else
                null,
        },
    };
}
