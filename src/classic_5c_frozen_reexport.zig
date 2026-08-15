//! Stage 5C test-only module root: re-exports the frozen Classic units so
//! the tests/ module can import ONE module without double-rooting any
//! frozen file. Never imported by production code.
pub const vector_backend = @import("classic_vector_backend.zig");
pub const scalar_kernel = @import("classic_scalar_kernel.zig");
pub const edge_schedule = @import("classic_edge_schedule.zig");
