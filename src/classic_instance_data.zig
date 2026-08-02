// Immutable Classic filter-instance data type.
const common_instance = @import("common_instance_data_structure.zig");
const call_parameters = @import("filter_call_parameters.zig");
const invocation_text = @import("effective_invocation_text.zig");

pub const ClassicInstanceData = struct {
    common: common_instance.CommonInstanceFields,
    parameters: call_parameters.ClassicParameters,
    using_text: invocation_text.Value,
};
