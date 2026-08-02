// G10 debug-only Stage 1C lifecycle trace seam.
//
// This file is reached only through source-visible conditional imports under
// enable_trace_lifecycle. The inner gate is defence in depth.
const std = @import("std");
const builtin = @import("builtin");
const config = @import("deblock4_config.zig");
const common = @import("common_instance_data_structure.zig");
const parameters = @import("filter_call_parameters.zig");
const version = @import("deblock4_version.zig");

pub const tools = if (config.debug.enable_trace_lifecycle) struct {
    pub const MARKER = "DEBLOCK4_LIFECYCLE_TRACE_DEBUG_MARKER_1C71FE01";
    pub const CODE_MARKER: u32 = 0x1C71_FE01;

    comptime {
        if (builtin.mode != .Debug) {
            @compileError("enable_trace_lifecycle is Debug-only");
        }
    }

    pub fn deblock4_lifecycle_trace_marker_1C71FE01() u32 {
        std.debug.print("{s}\n", .{MARKER});
        return CODE_MARKER;
    }

    comptime {
        _ = &deblock4_lifecycle_trace_marker_1C71FE01;
    }

    pub fn pluginInit() void {
        std.debug.print(
            "deblock4: lifecycle plugin-init version={s} marker={s}\n",
            .{ version.identity_string, MARKER },
        );
    }

    pub fn creationEnter(filter_name: []const u8) void {
        std.debug.print(
            "deblock4: lifecycle creation-enter filter={s} version={s}\n",
            .{ filter_name, version.identity_string },
        );
    }

    pub fn creationExitClassic(
        instance_id: u64,
        video: common.VideoInfoFields,
        config_values: parameters.ClassicParameters,
        selection: common.BackendSelection,
    ) void {
        const planes = config_values.common.planes;
        std.debug.print(
            "deblock4: lifecycle creation-exit filter=Classic instance={d} " ++
                "size={d}x{d} chroma={d}x{d} color={s} source_planes={d} " ++
                "subsampling={d}x{d} frames={d} fps={d}/{d} strength={d} " ++
                "boundary_offset={d} side_offset={d} planes_all={d} " ++
                "planes_count={d} plane0={d} plane1={d} plane2={d} " ++
                "backend={s} tier={s} provenance={s} grid=fixed_h264_4x4 " ++
                "version={s}\n",
            .{
                instance_id,
                video.width,
                video.height,
                video.chroma_width,
                video.chroma_height,
                colorFamilyName(video.color_family),
                video.num_planes,
                video.subsampling_w,
                video.subsampling_h,
                video.num_frames,
                video.fps_num,
                video.fps_den,
                config_values.common.strength,
                config_values.common.boundary_strength_offset,
                config_values.common.side_activity_offset,
                @intFromBool(planes.all),
                planes.count,
                planes.indices[0],
                planes.indices[1],
                planes.indices[2],
                common.backendRequestName(selection.requested_backend),
                common.backendTierName(selection.selected_tier),
                provenanceName(selection.provenance),
                version.identity_string,
            },
        );
    }

    pub fn creationExitDeblock4(
        instance_id: u64,
        video: common.VideoInfoFields,
        config_values: parameters.Deblock4Parameters,
        selection: common.BackendSelection,
    ) void {
        const planes = config_values.common.planes;
        const grid = resolvedGrid(config_values.grid);
        std.debug.print(
            "deblock4: lifecycle creation-exit filter=Deblock4 instance={d} " ++
                "size={d}x{d} chroma={d}x{d} color={s} source_planes={d} " ++
                "subsampling={d}x{d} frames={d} fps={d}/{d} strength={d} " ++
                "boundary_offset={d} side_offset={d} planes_all={d} " ++
                "planes_count={d} plane0={d} plane1={d} plane2={d} " ++
                "backend={s} tier={s} provenance={s} grid={s} " ++
                "luma_step={d}x{d} chroma_step={d}x{d} " ++
                "midpoint_class={d} midpoint_scale_set={d} " ++
                "midpoint_scale={d} version={s}\n",
            .{
                instance_id,
                video.width,
                video.height,
                video.chroma_width,
                video.chroma_height,
                colorFamilyName(video.color_family),
                video.num_planes,
                video.subsampling_w,
                video.subsampling_h,
                video.num_frames,
                video.fps_num,
                video.fps_den,
                config_values.common.strength,
                config_values.common.boundary_strength_offset,
                config_values.common.side_activity_offset,
                @intFromBool(planes.all),
                planes.count,
                planes.indices[0],
                planes.indices[1],
                planes.indices[2],
                common.backendRequestName(selection.requested_backend),
                common.backendTierName(selection.selected_tier),
                provenanceName(selection.provenance),
                grid.mode,
                grid.luma_step_x,
                grid.luma_step_y,
                grid.chroma_step_x,
                grid.chroma_step_y,
                @intFromBool(grid.has_midpoint_class),
                @intFromBool(grid.midpoint_scale != null),
                grid.midpoint_scale orelse 0.0,
                version.identity_string,
            },
        );
    }

    pub fn getFrame(
        phase: []const u8,
        filter_name: []const u8,
        instance_id: u64,
        n: c_int,
        reason: c_int,
        returned_frame: bool,
    ) void {
        std.debug.print(
            "deblock4: lifecycle getFrame-{s} filter={s} instance={d} " ++
                "frame={d} reason={d} returned={d}\n",
            .{ phase, filter_name, instance_id, n, reason, @intFromBool(returned_frame) },
        );
    }

    pub fn free(filter_name: []const u8, instance_id: u64) void {
        std.debug.print(
            "deblock4: lifecycle free filter={s} instance={d}\n",
            .{ filter_name, instance_id },
        );
    }

    const GridTrace = struct {
        mode: []const u8,
        luma_step_x: u32,
        luma_step_y: u32,
        chroma_step_x: u32,
        chroma_step_y: u32,
        has_midpoint_class: bool,
        midpoint_scale: ?f64,
    };

    fn resolvedGrid(grid: parameters.Deblock4GridParameters) GridTrace {
        return switch (grid) {
            .mpeg2_progressive => .{
                .mode = "mpeg2_progressive",
                .luma_step_x = 8,
                .luma_step_y = 8,
                .chroma_step_x = 8,
                .chroma_step_y = 8,
                .has_midpoint_class = false,
                .midpoint_scale = null,
            },
            .mpeg2_field_separated => |field| .{
                .mode = "mpeg2_field_separated",
                .luma_step_x = 8,
                .luma_step_y = 4,
                .chroma_step_x = 8,
                .chroma_step_y = 4,
                .has_midpoint_class = true,
                .midpoint_scale = field.midpoint_threshold_scale,
            },
            .custom => |custom| .{
                .mode = "custom",
                .luma_step_x = custom.luma_step_x,
                .luma_step_y = custom.luma_step_y,
                .chroma_step_x = custom.chroma_step_x,
                .chroma_step_y = custom.chroma_step_y,
                .has_midpoint_class = custom.luma_midpoint_enabled,
                .midpoint_scale = custom.midpoint_threshold_scale,
            },
        };
    }

    fn colorFamilyName(value: common.ColorFamily) []const u8 {
        return switch (value) {
            .gray => "gray",
            .rgb => "rgb",
            .yuv => "yuv",
        };
    }

    fn provenanceName(value: common.BackendSelectionProvenance) []const u8 {
        return switch (value) {
            .automatic => "automatic",
            .explicit => "explicit",
        };
    }
} else struct {};
