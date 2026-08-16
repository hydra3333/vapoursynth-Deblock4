# Deblock4 - Stage 5C - W3C Delivery Manifest v1.0

**Stage:** 5C - Classic v3 (AVX2-class) vector backend
**Scope:** `Deblock4_Scope_Stage_5C_Classic_v3_AVX2_Backend_v1_2.md`
**Base:** W3X-confirmed committed Stage 4C tree, identity `0.1.0-dev+4C`
**Delivery target identity:** `0.1.0-dev+5C`
**Delivery form:** manual `apply_to_tree/` copy plus `restore_to_base/`
**Validation authority:** W3X runs; W3D independently reviews evidence
**W3C execution status:** W3C has NOT run builds, unit tests, vspipe differentials, disassembly gates, negative controls, or benchmarks.

## 1. Purpose

This delivery implements only the ratified Stage 5C Classic v3 surface. The
accepted scalar oracle, edge schedule, threshold mathematics, frozen
width-generic vector body, accepted v2 SSE4.1 object, and backend-tier selection
module remain untouched.

The new v3 object instantiates the same frozen vector body at:

- `u8 N=32` - 32 one-byte lanes = 256-bit storage batch;
- `u16 N=16` - 16 two-byte lanes = 256-bit storage batch.

The live one-lane horizontal tail terminal is V1,
`filterHorizontalLanes(T, 1, ...)`, per S5C-4 / 5C-RAT-6. No AVX2-specific
masked tail or widened near-edge read is introduced.

## 2. Files to apply

### NEW

- `build_5C_v1.bat`
- `src/classic_backend_v3_avx2.zig`
- `tests/classic_vector_backend_5c_tests.zig`

### REPLACES

- `build.zig`
- `src/classic_ar_all_frames_ready.zig`
- `src/deblock4_config.zig`
- `src/deblock4_selftest.zig`
- `src/deblock4_version.zig`

### Confirmed untouched/frozen

- `src/classic_scalar_kernel.zig`
- `src/classic_edge_schedule.zig`
- `src/classic_thresholds.zig`
- `src/classic_vector_backend.zig`
- `src/classic_backend_v2_sse41.zig`
- `src/backend_tier_selection.zig`

## 3. Implementation summary

`src/classic_backend_v3_avx2.zig` is a thin sibling of the accepted v2 unit. It
contains the exact named-x86-64-v3 compile-time drift guard, binds the frozen
body at u8 N=32 / u16 N=16, exposes the two object-mode-only C-callable roots,
and retains them by compile-time address take. Its top-of-module comments carry
the W3X human-maintainer mandate: N-as-lanes, physical storage widths, i32
widening, horizontal versus vertical width behaviour, C1/C2 tails, right-edge
over-read prohibition, AVX2 masked-I/O limits, stride-slack rule, object export
semantics, full named-v3 targeting, and runtime-guard invariant.

`src/classic_ar_all_frames_ready.zig` adds the matching v3 externs and dispatch
helpers. Its v1 and v2 switch arms remain unchanged; the previous v3
`BackendInvariant` placeholder becomes the real v3 call and the now-dead local
error-set member is removed.

`src/deblock4_config.zig` raises only `classic_tier_ceiling` to
`x86_64_v3_with_avx2`. `deblock4_tier_ceiling` is unchanged.

`src/deblock4_selftest.zig` updates the pure Classic implementation-ceiling
contracts so auto selects v3, explicit v2 remains available, and explicit v3 is
now implemented.

`build.zig` adds the exact named-v3 target, v3 object, DLL linkage, inspection
object step, and the two ratified v3-target test legs. The existing main unit
suite remains separate from the dedicated v2/v3 vector proof steps.

`tests/classic_vector_backend_5c_tests.zig` is test-only and is never imported
by production. It covers the D3 A/B, O-4, O-5d and O-7 fixtures at the new
widths; the exhaustive 8-bit p0/q0 lane sweep at N=32; every u8 remainder 1..31
and u16 remainder 1..15 with fixed-seed random scalar differentials; deliberate
non-16/32-byte alignment, non-vector-aligned strides and guard canaries; strong
non-vacuous tail data; and vertical bottom underfill row counts 1, 2 and 3.

`build_5C_v1.bat` extends the accepted proof matrix without modifying earlier
batches. It retains the already-reviewed prior inline PowerShell verbatim and
adds no executable PowerShell line beyond the Stage 4C batch. All new Stage 5C
mutation machinery is CMD plus the existing portable Python runner. It contains
no git executable call and performs no repository-state operation.

## 4. W3D harness join contract

The Stage 5C scope assigns the `.vpy/.cmd` differential and benchmark harnesses
to W3D. They are therefore not shipped by this W3C delivery.

Before W3X runs `build_5C_v1.bat`, two absolute runner paths must be supplied:

```cmd
set "DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER=<absolute path to W3D Stage 5C differential .cmd>"
set "DEBLOCK4_STAGE5C_BENCHMARK_RUNNER=<absolute path to W3D Stage 5C benchmark .cmd>"
```

### Differential runner environment

The batch supplies:

- `DEBLOCK4_PLUGIN_PATH`
- `DEBLOCK4_STAGE5C_INSPECTION_DIR`
- `DEBLOCK4_STAGE5C_EXPECTED_VERSION`
- `DEBLOCK4_STAGE5C_EXPECTED_V1`
- `DEBLOCK4_STAGE5C_EXPECTED_V2`
- `DEBLOCK4_STAGE5C_EXPECTED_V3`
- `DEBLOCK4_STAGE5C_RUN_KIND`
- `DEBLOCK4_STAGE5C_REQUIRE_STAGE4C_REGRESSION=1` on the positive Stage 5C call

The runner must recognise these run kinds:

- `stage4c-regression`
- `stage4c-tail-mutant-expected-failure`
- `positive`
- `tail-mutant-expected-failure`

For positive/regression modes, exit 0 must mean the requested W3D-owned
scalar/v2/v3 differential and selection obligations were actually satisfied.
For the two mutant modes, exit 0 must mean the deliberate mutation was actually
rejected/difference-detected as intended. A mere successful process launch is
not sufficient.

### Benchmark runner environment

The batch supplies:

- `DEBLOCK4_PLUGIN_PATH`
- `DEBLOCK4_STAGE5C_BENCHMARK_DIR`
- `DEBLOCK4_STAGE5C_EXPECTED_VERSION`
- `DEBLOCK4_STAGE5C_EXPECTED_V1`
- `DEBLOCK4_STAGE5C_EXPECTED_V2`
- `DEBLOCK4_STAGE5C_EXPECTED_V3`

The W3D runner owns the ratified `time.perf_counter()` method: one discarded
warm-up and three recorded runs per v1/v2/v3 backend with identical clip,
frames, parameters, sink and environment. Exit 0 must mean the required raw
numbers were recorded. No speed threshold is an acceptance criterion.

## 5. Manual application - W3X only

Do not run an application script. From the delivery package, manually copy the
contents of `apply_to_tree/` over the W3X-confirmed `0.1.0-dev+4C` repository
root, preserving relative paths.

The package intentionally contains no patch and no automated repository
operation.

## 6. Manual backout - W3X only

`restore_to_base/` contains the exact pre-change copies for every REPLACES file.
W3X may hand-copy those files back. The three NEW files must then be deleted.

Equivalent manual command pattern, with `<delivery-root>` replaced by the
actual package location and the current directory set to the repository root:

```cmd
copy /Y "<delivery-root>\restore_to_base\build.zig" "build.zig"
copy /Y "<delivery-root>\restore_to_base\src\classic_ar_all_frames_ready.zig" "src\classic_ar_all_frames_ready.zig"
copy /Y "<delivery-root>\restore_to_base\src\deblock4_config.zig" "src\deblock4_config.zig"
copy /Y "<delivery-root>\restore_to_base\src\deblock4_selftest.zig" "src\deblock4_selftest.zig"
copy /Y "<delivery-root>\restore_to_base\src\deblock4_version.zig" "src\deblock4_version.zig"
del /Q "build_5C_v1.bat"
del /Q "src\classic_backend_v3_avx2.zig"
del /Q "tests\classic_vector_backend_5c_tests.zig"
```

This block is documentation for a manual W3X action; no delivery script executes
it.

## 7. Validation command - W3X executes

Use the x64 Visual Studio developer prompt, from the repository root, after W3D
has supplied the two runner paths:

```cmd
set "DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER=<W3D absolute .cmd path>"
set "DEBLOCK4_STAGE5C_BENCHMARK_RUNNER=<W3D absolute .cmd path>"
call build_5C_v1.bat
```

The batch is intended to re-execute the retained 1C/2C/4C proof surface and then
5C-T1..T6, including the two v3 unit legs in Debug/ReleaseSafe/ReleaseFast,
end-to-end scalar/v2/v3 differentials, object/disassembly containment, selection
gates, named-model and live-V1 mutant controls, release byte identity, and the
non-gating benchmark record.

W3X should report the actual console/transcript result. W3D then independently
reviews the retained evidence. W3C makes no pre-run PASS claim.

## 8. Static delivery inspection performed by W3C

These are source/package inspections only, not execution validation:

- changed/new file inventory matches the ratified authorised surface exactly;
- all six named frozen/expected-untouched files above are byte-identical to the
  W3X-supplied Stage 4C base;
- no file was removed;
- all eight applied text files are US-ASCII with CRLF line endings;
- `build_5C_v1.bat` has no missing or duplicate internal labels and no unresolved
  `call :label` / `goto` target;
- executable PowerShell lines in `build_5C_v1.bat` are the same set as the
  accepted Stage 4C batch; no new executable PowerShell line was added;
- `build_5C_v1.bat` has no git executable call;
- the named-model mutator uses the existing `tools\run_vs.cmd --python-script`
  one-script contract via environment variables, not unsupported script
  arguments.

## 9. K30-style identifier/dependency evidence

Static source inspection records the intended one-way structure:

- `src/classic_backend_v3_avx2.zig` imports only standard/builtin facilities and
  the frozen `classic_vector_backend.zig` body;
- the only canonical width bindings are
  `processPlane(u8, 32, ...)` and `processPlane(u16, 16, ...)` in that v3 unit;
- `classic_ar_all_frames_ready.zig` reaches the v3 object only through the exact
  two C-linkage roots `deblock4_classic_v3_process_u8/u16`;
- `build.zig` owns the target/module/object linkage and inspection-object name;
- production source does not import the Stage 5C test module;
- `src/backend_tier_selection.zig` remains byte-identical to the base.

W3D independent identifier re-verification remains required by the scope.

## 10. Registered post-5C follow-up

Per W3X direction / 5C-RAT-7, once Stage 5C is finalised the equivalent
human-maintainer commentary is to be retro-fitted and reconciled into
`src/classic_backend_v2_sse41.zig` under a separate authorised follow-up. That
file is deliberately untouched by this Stage 5C delivery.
