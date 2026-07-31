// Deblock4 shared declarations-only switchboard.
//
// Keep namespaces shallow. This production module contains no functions and
// no gated bodies; it only names values consumed by first-class modules.
const deblock4_build_options = @import("deblock4_build_options");

pub const debug = struct {
    pub const enable_force_down =
        deblock4_build_options.enable_force_down;
    pub const enable_verbose_detection =
        deblock4_build_options.enable_verbose_detection;
};

pub const tier = struct {
    pub const name_v1 = "x86_64_v1_baseline";
    pub const name_v2 = "x86_64_v2_with_sse41";
    pub const name_v3 = "x86_64_v3_with_avx2";
};

pub const diag = struct {
    pub const summary_prefix = "deblock4";
};

pub const plugin = struct {
    // W3X updates this single source when the plugin version advances.
    pub const version_string = "0.1.0-dev";
};
