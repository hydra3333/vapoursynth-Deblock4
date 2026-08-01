// Immutable Classic filter-instance data type.
const common_instance = @import("common_instance_data_structure.zig");
const call_parameters = @import("filter_call_parameters.zig");

pub const ClassicInstanceData = struct {
    common: common_instance.CommonInstanceFields,
    parameters: call_parameters.ClassicParameters,
};
