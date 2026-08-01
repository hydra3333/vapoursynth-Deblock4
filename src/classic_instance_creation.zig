// Stage 1C Classic instance creation.
//
// Full parameter extraction, clip-dependent validation, EFFECTIVE-tier
// selection, and immutable instance construction occur exactly once here.
const std = @import("std");
const vs = @import("vapoursynth_api4");
const config = @import("deblock4_config.zig");
const backend_tier_selection = @import("backend_tier_selection.zig");
const classic_callback_router = @import("classic_callback_router.zig");
const classic_instance_data = @import("classic_instance_data.zig");
const common_instance = @import("common_instance_data_structure.zig");
const filter_call_parameters = @import("filter_call_parameters.zig");

const lifecycle_dbg = if (config.debug.enable_trace_lifecycle)
    @import("lifecycle_trace_debug.zig")
else
    struct {};

const empty_integer_array = [_]i64{};

pub const CreationError = error{
    VariableFormatOrDimensions,
    UnsupportedColorFamily,
    InvalidVideoMetadata,
    PlaneIndexOutOfRange,
    AllocationFailed,
};

pub fn create(
    in_optional: ?*const vs.VSMap,
    out_optional: ?*vs.VSMap,
    user_data: ?*anyopaque,
    core_optional: ?*vs.VSCore,
    vsapi_c: [*c]const vs.VSAPI,
) callconv(.c) void {
    _ = user_data;
    if (vsapi_c == null) return;
    const in = in_optional orelse return;
    const out = out_optional orelse return;
    const core = core_optional orelse return;
    const vsapi: *const vs.VSAPI = @ptrCast(vsapi_c);

    if (config.debug.enable_trace_lifecycle) {
        lifecycle_dbg.tools.creationEnter("Classic");
    }

    var map_error: c_int = 0;
    const source_optional = vs.zig_vs_map_get_node(
        vsapi,
        in,
        "clip",
        0,
        &map_error,
    );
    if (map_error != vs.peSuccess or source_optional == null) {
        setError(out, vsapi, "Classic: clip is required and must be a video node");
        return;
    }
    const source = source_optional.?;

    const video_info_optional = vs.zig_vs_get_video_info(vsapi, source);
    if (video_info_optional == null) {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, "Classic: source video information is unavailable");
        return;
    }
    const video_info = video_info_optional.?;

    if (vs.zig_vsh_isConstantVideoFormat(video_info) == 0) {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, "Classic: input clip must have constant format and dimensions");
        return;
    }

    const call = readClassicCall(in, vsapi) catch |err| {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, readErrorMessage(err));
        return;
    };
    const parameters = filter_call_parameters.parseClassic(call) catch |err| {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, validationMessage(err));
        return;
    };

    const copied_video_info = copyVideoInfo(video_info) catch |err| {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, creationMessage(err));
        return;
    };
    validatePlanes(parameters.common.planes, copied_video_info.num_planes) catch |err| {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, creationMessage(err));
        return;
    };

    const selection = backend_tier_selection.selectForInstance(
        "Classic",
        parameters.common.backend,
    ) catch |err| {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, selectionMessage(err));
        return;
    };

    const instance = std.heap.c_allocator.create(
        classic_instance_data.ClassicInstanceData,
    ) catch {
        vs.zig_vs_free_node(vsapi, source);
        setError(out, vsapi, creationMessage(error.AllocationFailed));
        return;
    };
    instance.* = .{
        .common = .{
            .source_node_handle = @ptrCast(source),
            .video_info = copied_video_info,
            .instance_id = common_instance.allocateInstanceId(),
            .filter_kind = .classic,
            .backend_selection = selection,
        },
        .parameters = parameters,
    };

    if (config.debug.enable_trace_lifecycle) {
        lifecycle_dbg.tools.creationExitClassic(
            instance.common.instance_id,
            instance.common.video_info,
            instance.parameters,
            instance.common.backend_selection,
        );
    }
    vs.zig_vs_create_video_filter_single_dependency(
        vsapi,
        out,
        "Classic",
        video_info,
        &classic_callback_router.getFrame,
        &classic_callback_router.free,
        source,
        @ptrCast(instance),
        core,
    );
}

pub fn validatePlanes(
    planes: filter_call_parameters.PlaneRequest,
    num_planes: u8,
) CreationError!void {
    if (planes.all) return;
    for (planes.indices[0..@intCast(planes.count)]) |plane| {
        if (plane >= num_planes) return error.PlaneIndexOutOfRange;
    }
}

fn readClassicCall(
    in: *const vs.VSMap,
    vsapi: *const vs.VSAPI,
) error{WrongType}!filter_call_parameters.ClassicCall {
    return .{
        .strength = try readOptionalInt(in, vsapi, "strength"),
        .boundary_strength_offset = try readOptionalInt(in, vsapi, "boundary_strength_offset"),
        .side_activity_offset = try readOptionalInt(in, vsapi, "side_activity_offset"),
        .planes = try readOptionalIntArray(in, vsapi, "planes"),
        .backend = try readOptionalData(in, vsapi, "backend"),
    };
}

fn readOptionalInt(map: *const vs.VSMap, vsapi: *const vs.VSAPI, key: [*:0]const u8) error{WrongType}!filter_call_parameters.CallValue {
    const count = vs.zig_vs_map_num_elements(vsapi, map, key);
    if (count < 0) return .missing;
    if (count != 1) return error.WrongType;
    var map_error: c_int = 0;
    const value = vs.zig_vs_map_get_int(vsapi, map, key, 0, &map_error);
    if (map_error != vs.peSuccess) return error.WrongType;
    return .{ .integer = value };
}

fn readOptionalIntArray(map: *const vs.VSMap, vsapi: *const vs.VSAPI, key: [*:0]const u8) error{WrongType}!filter_call_parameters.CallValue {
    const count = vs.zig_vs_map_num_elements(vsapi, map, key);
    if (count < 0) return .missing;
    if (count == 0) return .{ .integer_array = empty_integer_array[0..] };
    var map_error: c_int = 0;
    const values = vs.zig_vs_map_get_int_array(vsapi, map, key, &map_error);
    if (map_error != vs.peSuccess or values == null) return error.WrongType;
    return .{ .integer_array = values[0..@intCast(count)] };
}

fn readOptionalData(map: *const vs.VSMap, vsapi: *const vs.VSAPI, key: [*:0]const u8) error{WrongType}!filter_call_parameters.CallValue {
    const count = vs.zig_vs_map_num_elements(vsapi, map, key);
    if (count < 0) return .missing;
    if (count != 1) return error.WrongType;
    var map_error: c_int = 0;
    const value = vs.zig_vs_map_get_data(vsapi, map, key, 0, &map_error);
    if (map_error != vs.peSuccess or value == null) return error.WrongType;
    const size = vs.zig_vs_map_get_data_size(vsapi, map, key, 0, &map_error);
    if (map_error != vs.peSuccess or size < 0) return error.WrongType;
    return .{ .data = value[0..@intCast(size)] };
}

pub fn copyVideoInfo(video_info: *const vs.VSVideoInfo) CreationError!common_instance.VideoInfoFields {
    if (video_info.width <= 0 or video_info.height <= 0 or video_info.format.colorFamily == vs.cfUndefined) {
        return error.VariableFormatOrDimensions;
    }
    if (video_info.format.numPlanes <= 0 or video_info.format.numPlanes > 3 or
        video_info.format.subSamplingW < 0 or video_info.format.subSamplingW > 31 or
        video_info.format.subSamplingH < 0 or video_info.format.subSamplingH > 31 or
        vs.zig_vsh_areValidDimensions(&video_info.format, video_info.width, video_info.height) == 0)
    {
        return error.InvalidVideoMetadata;
    }
    const color_family: common_instance.ColorFamily = switch (video_info.format.colorFamily) {
        vs.cfGray => .gray,
        vs.cfRGB => .rgb,
        vs.cfYUV => .yuv,
        else => return error.UnsupportedColorFamily,
    };
    const width: u32 = @intCast(video_info.width);
    const height: u32 = @intCast(video_info.height);
    const subsampling_w: u8 = @intCast(video_info.format.subSamplingW);
    const subsampling_h: u8 = @intCast(video_info.format.subSamplingH);
    const shift_w: u5 = @intCast(subsampling_w);
    const shift_h: u5 = @intCast(subsampling_h);
    const has_chroma = color_family == .yuv and video_info.format.numPlanes > 1;
    return .{
        .format_is_constant = true,
        .dimensions_are_constant = true,
        .color_family = color_family,
        .num_planes = @intCast(video_info.format.numPlanes),
        .width = width,
        .height = height,
        .chroma_width = if (has_chroma) width >> shift_w else width,
        .chroma_height = if (has_chroma) height >> shift_h else height,
        .subsampling_w = subsampling_w,
        .subsampling_h = subsampling_h,
        .num_frames = video_info.numFrames,
        .fps_num = video_info.fpsNum,
        .fps_den = video_info.fpsDen,
    };
}

fn setError(out: *vs.VSMap, vsapi: *const vs.VSAPI, message: [*:0]const u8) void {
    vs.zig_vs_map_set_error(vsapi, out, message);
}
fn readErrorMessage(err: error{WrongType}) [*:0]const u8 { return switch (err) { error.WrongType => "Classic: one or more arguments have the wrong type" }; }
fn validationMessage(err: filter_call_parameters.ValidationError) [*:0]const u8 { return switch (err) {
    error.WrongType => "Classic: one or more arguments have the wrong type",
    error.StrengthOutOfRange => "Classic: strength must be between 0 and 60",
    error.BoundaryStrengthOffsetOutOfRange => "Classic: boundary_strength_offset is out of range for strength",
    error.SideActivityOffsetOutOfRange => "Classic: side_activity_offset is out of range for strength",
    error.UnknownBackend => "Classic: backend is not a recognised token",
    error.EmptyPlanes => "Classic: planes must not be empty",
    error.TooManyPlanes => "Classic: planes contains too many indices",
    error.NegativePlaneIndex => "Classic: plane indices must be non-negative",
    error.PlaneIndexTooLarge => "Classic: a plane index is too large",
    error.DuplicatePlaneIndex => "Classic: planes must not contain duplicates",
    else => "Classic: an argument is not valid for this filter",
}; }
fn selectionMessage(err: backend_tier_selection.SelectionError) [*:0]const u8 { return switch (err) {
    error.InvalidForceDownValue => "Classic: DEBLOCK4_FORCE_DOWN has an invalid value",
    error.RequestedBackendUnavailable => "Classic: requested backend is above the EFFECTIVE CPU tier",
}; }
fn creationMessage(err: CreationError) [*:0]const u8 { return switch (err) {
    error.VariableFormatOrDimensions => "Classic: input clip must have constant format and dimensions",
    error.UnsupportedColorFamily => "Classic: input color family is unsupported",
    error.InvalidVideoMetadata => "Classic: input video metadata is invalid",
    error.PlaneIndexOutOfRange => "Classic: a plane index is outside the source format",
    error.AllocationFailed => "Classic: instance allocation failed",
}; }

test "Classic clip validation rejects a plane above the source format" {
    const planes = filter_call_parameters.PlaneRequest{ .all = false, .count = 1, .indices = .{ 2, 0, 0 } };
    try std.testing.expectError(error.PlaneIndexOutOfRange, validatePlanes(planes, 2));
}
