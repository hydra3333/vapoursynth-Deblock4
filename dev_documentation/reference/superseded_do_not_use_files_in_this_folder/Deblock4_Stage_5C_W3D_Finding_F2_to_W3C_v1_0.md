# Deblock4 - Stage 5C - W3D Blocking Finding W3D-5C-F2 to W3C v1.0

**From:** W3D (designer), relayed by W3X
**To:** W3C (coder)
**Date:** 2026-08-15
**Delivery under review:** Deblock4_Stage_5C_W3C_delivery_v1_1 (the F1-fixed
batch) as applied and executed by W3X on 2026-08-15.
**Status:** ONE blocking finding in the 5C-T1 leg-2 BUILD WIRING; directed
remedy with one design decision for you to confirm or improve. Separately,
a W3D-owned failure in the benchmark runner was found in the same run and
has ALREADY been fixed and reissued on the W3D side (noted for the record
only; no W3C action).

## What the run proved (retained evidence - the stage substance is GREEN)

Identity gates at 0.1.0-dev+5C; all structural audits; 85/85 unit suite;
selftest with auto -> x86_64_v3_with_avx2; 5C-T1 LEG 1 (the frozen vector
body's own 28/28 tests under the exact v3 target) PASS in all three modes;
the W3D positive differential ALL_PASS (17 cases, three-way v1/v2/v3,
byte-identical, non-vacuity green); the 4C regression differential
ALL_PASS (18 cases); BOTH mutant controls CORRECTLY REJECTED; T3
containment and T4 selection green; RS==RF byte identity green.

## W3D-5C-F2 (BLOCKING): leg-2 module graph double-roots a frozen file

FINDING. 5C-T1 leg 2 (tests/classic_vector_backend_5c_tests.zig) fails to
COMPILE in all three modes:

```text
src\classic_vector_backend.zig:1:1: error: file exists in modules
    'classic_scalar_kernel' and 'classic_vector_backend'
note: files must belong to only one module
note: file is the root of module 'classic_scalar_kernel'   [sic - see below]
note: file is imported here by the root of module 'classic_vector_backend'
    const scalar_kernel = @import("classic_scalar_kernel.zig");
```

CAUSE (build.zig, the classic_5c_test_module block): the test module is
given THREE separate created modules, one rooting each frozen file. But
classic_vector_backend.zig itself imports classic_scalar_kernel.zig and
classic_edge_schedule.zig BY FILE PATH, which pulls those files into the
'classic_vector_backend' module - so each frozen file ends up in two
modules at once, which Zig forbids. The frozen sources are correct and
untouched; this is wiring only. (Leg 1 compiles fine because it is a
single module.)

## Directed remedy (W3X-ratified surface addition; confirm or improve)

Add ONE tiny new W3C source file, src/classic_5c_frozen_reexport.zig,
whose entire content is a pub re-export shim:

```zig
//! Stage 5C test-only module root: re-exports the frozen Classic units so
//! the tests/ module can import ONE module without double-rooting any
//! frozen file. Never imported by production code.
pub const vector_backend = @import("classic_vector_backend.zig");
pub const scalar_kernel = @import("classic_scalar_kernel.zig");
pub const edge_schedule = @import("classic_edge_schedule.zig");
```

Then in build.zig the test module gets a SINGLE import (suggested name
"classic_frozen") rooting that shim at the v3 target, replacing the three
addImport calls; and in tests/classic_vector_backend_5c_tests.zig the
three named imports collapse to one:

```zig
const frozen = @import("classic_frozen");
const vector_backend = frozen.vector_backend;
const scalar_kernel = frozen.scalar_kernel;
const edge_schedule = frozen.edge_schedule;
```

WHY THIS SHAPE: all file-path imports then live inside one module (the
shim's directory is src/, same as the frozen files), so no file is
double-rooted; the frozen files stay byte-frozen; the tests/ location
ratified at 5C-RAT-3 is preserved (a tests/-rooted module cannot reach
../src by file import, which rules out the no-new-file variant); and the
shim is test-only, production-unreachable, satisfying K30 one-way
dependency (W3D will re-verify no production file imports it).

If you see a cleaner wiring that keeps the frozen files single-moduled
without a new file, propose it instead of implementing silently.

## Delivery form

Deblock4_Stage_5C_W3C_delivery_v1_2: the new shim file, the corrected
build.zig, the adjusted tests/classic_vector_backend_5c_tests.zig, plus
manifest note. No other file. W3D will byte-diff every shipped file
against v1_1 and re-verify K30. The already-applied production tree
needs no backout: nothing production-side changes.

## For the record only (no W3C action)

The same run exposed a W3D defect: the W3D benchmark runner's generated
.vpy was syntactically invalid (a quoting defect in the W3D file
generator, not in your batch or the join contract - your batch invoked
it exactly per manifest section 4). W3D has reissued
stage_5c_benchmark.py v1.1 with an end-to-end stub-proven fix; W3X
replaces that one file in tools\stage_5c\. Your batch is unchanged by
this.

## DECISIONS/QUESTIONS FOR W3C

Q1 only: confirm the shim remedy (or propose a cleaner single-moduled
wiring) before reissuing.
