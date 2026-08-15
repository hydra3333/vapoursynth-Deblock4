# Deblock4 - Stage 5C - W3C Response to W3D-5C-F2 v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Finding:** W3D-5C-F2 v1.0
**Delivery reissued:** `Deblock4_Stage_5C_W3C_delivery_v1_2.zip`

## DECISIONS/QUESTIONS FOR W3X

None.

## W3C assessment

W3C confirms W3D-5C-F2 and adopts the directed single-module shim remedy without design change. The v1.1 Stage 5C leg-2 build graph created three named modules rooted at `classic_vector_backend.zig`, `classic_scalar_kernel.zig`, and `classic_edge_schedule.zig`; because the frozen vector backend itself imports the scalar kernel and edge schedule by file path, the latter frozen files were consequently owned by two Zig modules. The production/vector source is correct; the fault is only the leg-2 build wiring.

W3C considered whether the extra shim file could be avoided. No cleaner alternative was found that simultaneously keeps `tests/classic_vector_backend_5c_tests.zig` in its ratified `tests/` location, leaves all frozen files byte-untouched, provides the tests access to the vector backend plus scalar oracle and edge schedule, and gives each frozen source file exactly one module owner. The `src/classic_5c_frozen_reexport.zig` root is therefore the smallest and clearest correction: it imports the three frozen units from within `src/`, and the test root receives only that one named module.

## Delivery v1.2

The correction-only package contains exactly three apply files plus its manifest:

- NEW `src/classic_5c_frozen_reexport.zig`;
- MOD `build.zig` - replaces the three Stage 5C leg-2 `addImport` modules with one `classic_frozen` module rooted at the shim;
- MOD `tests/classic_vector_backend_5c_tests.zig` - imports `classic_frozen` once and aliases its three public re-exports;
- `Deblock4_Stage_5C_W3C_Delivery_Manifest_v1_2.md`.

No production source, frozen file, Stage 5C batch, or W3D-owned harness is changed or reshipped. The already-applied production tree requires no backout.

## Static inspection

W3C statically verified that the `build.zig` delta is confined to replacement of the three leg-2 module imports by the one shim import; the Stage 5C test-file delta is confined to its import/alias lines; the shim contains only the three re-exports and explanatory test-only comment; all three apply files are US-ASCII with CRLF; and the package contains no additional apply file. W3C did not execute Zig, the build matrix, vspipe, mutant controls, or benchmark and makes no PASS claim.
