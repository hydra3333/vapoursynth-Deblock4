// Immutable Classic filter-instance data type.
const common_instance = @import("common_instance_data_structure.zig");
const call_parameters = @import("filter_call_parameters.zig");
const invocation_text = @import("effective_invocation_text.zig");
const thresholds_module = @import("classic_thresholds.zig");

pub const SampleStorage = enum {
    u8,
    u16,
};

pub const FormatFields = struct {
    sample_type: c_int,
    bits_per_sample: u8,
    bytes_per_sample: u8,
    storage: SampleStorage,
};

pub const ClassicInstanceData = struct {
    common: common_instance.CommonInstanceFields,
    parameters: call_parameters.ClassicParameters,
    format: FormatFields,
    thresholds: thresholds_module.Resolved,
    using_text: invocation_text.Value,
};
