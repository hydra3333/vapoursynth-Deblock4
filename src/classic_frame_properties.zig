// Classic frame-property policy.
const vs = @import("vapoursynth_api4");
const common = @import("common_instance_data_structure.zig");
const helpers = @import("common_frame_property_helpers.zig");
const instance_module = @import("classic_instance_data.zig");
const version = @import("deblock4_version.zig");

pub fn write(
    frame: *vs.VSFrame,
    instance: *const instance_module.ClassicInstanceData,
    vsapi: [*c]const vs.VSAPI,
) helpers.WriteError!void {
    const map = try helpers.writableMap(frame, vsapi);
    try helpers.setData(map, "Deblock4Filter", "Classic", vsapi);
    try helpers.setData(
        map,
        "Deblock4Tier",
        common.backendTierName(instance.common.backend_selection.selected_tier),
        vsapi,
    );
    try helpers.setData(map, "Deblock4Version", version.identity_string, vsapi);
    try helpers.setData(
        map,
        "Deblock4Using",
        instance.using_text.slice(),
        vsapi,
    );
}
