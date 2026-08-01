// Shared filter-neutral frame-property write mechanics.
//
// Property policy and names remain in the per-filter property modules.
const vs = @import("vapoursynth_api4");

pub const WriteError = error{PropertyWriteFailed};

pub fn writableMap(
    frame: *vs.VSFrame,
    vsapi: [*c]const vs.VSAPI,
) WriteError!*vs.VSMap {
    return vs.zig_vs_get_frame_properties_rw(vsapi, frame) orelse
        error.PropertyWriteFailed;
}

pub fn setData(
    map: *vs.VSMap,
    key: [*:0]const u8,
    value: []const u8,
    vsapi: [*c]const vs.VSAPI,
) WriteError!void {
    if (vs.zig_vs_map_set_data_utf8_replace(
        vsapi,
        map,
        key,
        value.ptr,
        @intCast(value.len),
    ) != 0) return error.PropertyWriteFailed;
}

pub fn setInt(
    map: *vs.VSMap,
    key: [*:0]const u8,
    value: i64,
    vsapi: [*c]const vs.VSAPI,
) WriteError!void {
    if (vs.zig_vs_map_set_int_replace(vsapi, map, key, value) != 0) {
        return error.PropertyWriteFailed;
    }
}

pub fn setFloat(
    map: *vs.VSMap,
    key: [*:0]const u8,
    value: f64,
    vsapi: [*c]const vs.VSAPI,
) WriteError!void {
    if (vs.zig_vs_map_set_float_replace(vsapi, map, key, value) != 0) {
        return error.PropertyWriteFailed;
    }
}
