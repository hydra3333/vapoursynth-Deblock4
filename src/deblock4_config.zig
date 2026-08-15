// Deblock4 shared declarations-only switchboard.
//
// Keep namespaces shallow. This production module contains no functions and
// no gated bodies; it only names values consumed by first-class modules.
const deblock4_build_options = @import("deblock4_build_options");
const deblock4_version = @import("deblock4_version.zig");
const common_instance = @import("common_instance_data_structure.zig");

pub const debug = struct {
    pub const enable_force_down =
        deblock4_build_options.enable_force_down;
    pub const enable_verbose_detection =
        deblock4_build_options.enable_verbose_detection;
    pub const enable_trace_lifecycle =
        if (@hasDecl(deblock4_build_options, "enable_trace_lifecycle"))
            deblock4_build_options.enable_trace_lifecycle
        else
            false;
};

pub const tier = struct {
    pub const name_v1 = "x86_64_v1_baseline";
    pub const name_v2 = "x86_64_v2_with_sse41";
    pub const name_v3 = "x86_64_v3_with_avx2";
};

pub const implementation = struct {
    pub const classic_tier_ceiling: ?common_instance.BackendTier =
        .x86_64_v3_with_avx2;
    pub const deblock4_tier_ceiling: ?common_instance.BackendTier = null;
    pub const intentionally_capped_reason_token = "intentionally-capped";
};

pub const diag = struct {
    pub const summary_prefix = "deblock4";
};

pub const plugin = struct {
    pub const version_string = deblock4_version.identity_string;
};
