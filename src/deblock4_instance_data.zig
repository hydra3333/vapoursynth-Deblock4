// Immutable Deblock4 filter-instance data type.
const common_instance = @import("common_instance_data_structure.zig");
const call_parameters = @import("filter_call_parameters.zig");
const invocation_text = @import("effective_invocation_text.zig");

pub const Deblock4InstanceData = struct {
    common: common_instance.CommonInstanceFields,
    parameters: call_parameters.Deblock4Parameters,
    using_text: invocation_text.Value,
};
