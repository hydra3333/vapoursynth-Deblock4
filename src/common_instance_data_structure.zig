// Shared filter-neutral declarations for immutable filter-instance state.
//
// This module is deliberately VapourSynth-free. The source-node field is an
// opaque handle and video metadata is copied into pure fields at creation.
// VS-facing creation/free code performs the typed conversions in later phases.
const std = @import("std");

pub const FilterKind = enum {
    classic,
    deblock4,
};

pub const ColorFamily = enum {
    gray,
    rgb,
    yuv,
};

pub const BackendRequest = enum {
    auto,
    x86_64_v1_baseline,
    x86_64_v2_with_sse41,
    x86_64_v3_with_avx2,
};

pub const BackendTier = enum {
    x86_64_v1_baseline,
    x86_64_v2_with_sse41,
    x86_64_v3_with_avx2,
};

pub const BackendSelectionProvenance = enum {
    automatic,
    explicit,
};

pub const BackendSelection = struct {
    requested_backend: BackendRequest,
    selected_tier: BackendTier,
    provenance: BackendSelectionProvenance,
};

pub const VideoInfoFields = struct {
    format_is_constant: bool,
    dimensions_are_constant: bool,
    color_family: ColorFamily,
    num_planes: u8,
    width: u32,
    height: u32,
    chroma_width: u32,
    chroma_height: u32,
    subsampling_w: u8,
    subsampling_h: u8,
    num_frames: i32,
    fps_num: i64,
    fps_den: i64,
};

pub const CommonInstanceFields = struct {
    source_node_handle: ?*anyopaque,
    video_info: VideoInfoFields,
    instance_id: u64,
    filter_kind: FilterKind,
    backend_selection: BackendSelection,
};

// The allocator is process-wide and atomic. The id stored in each immutable
// CommonInstanceFields value is an ordinary u64, not an atomic field.
var next_instance_id: u64 = 1;

pub fn allocateInstanceId() u64 {
    return @atomicRmw(
        u64,
        &next_instance_id,
        .Add,
        1,
        .monotonic,
    );
}

pub fn backendRequestName(value: BackendRequest) []const u8 {
    return switch (value) {
        .auto => "auto",
        .x86_64_v1_baseline => "x86_64_v1_baseline",
        .x86_64_v2_with_sse41 => "x86_64_v2_with_sse41",
        .x86_64_v3_with_avx2 => "x86_64_v3_with_avx2",
    };
}

pub fn backendTierName(value: BackendTier) []const u8 {
    return switch (value) {
        .x86_64_v1_baseline => "x86_64_v1_baseline",
        .x86_64_v2_with_sse41 => "x86_64_v2_with_sse41",
        .x86_64_v3_with_avx2 => "x86_64_v3_with_avx2",
    };
}

test "instance ids are allocated monotonically" {
    const first = allocateInstanceId();
    const second = allocateInstanceId();

    try std.testing.expectEqual(first + 1, second);
}

test "backend names are the settled public tokens" {
    try std.testing.expectEqualStrings(
        "auto",
        backendRequestName(.auto),
    );
    try std.testing.expectEqualStrings(
        "x86_64_v3_with_avx2",
        backendTierName(.x86_64_v3_with_avx2),
    );
}
