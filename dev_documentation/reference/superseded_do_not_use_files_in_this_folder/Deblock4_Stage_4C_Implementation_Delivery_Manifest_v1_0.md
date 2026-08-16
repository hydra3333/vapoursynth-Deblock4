# Deblock4 - Stage 4C Implementation Delivery Manifest

**Deliverable:** W3C-4C-IMPLEMENTATION-DELIVERY
**Version:** 1.0
**Date:** 2026-08-12
**Author:** W3C (coder)
**Scope:** `Deblock4_Scope_Stage_4C_Classic_v2_SSE41_Backend_v1_2.md`
**Base:** committed Stage 2C-accepted tree, identity `0.1.0-dev+2C`, as confirmed by W3X
**Intended identity after application:** `0.1.0-dev+4C`
**Status:** IMPLEMENTATION DELIVERY FOR W3D REVIEW / W3X VALIDATION. NO W3C EXECUTION OR PASS CLAIM.
**Encoding:** US-ASCII; CRLF.

---

# 1. Delivery shape

This is the charter-v1.27 no-script/manual-application package.

```text
Deblock4_Stage_4C_Implementation_Delivery_v1_0/
    Deblock4_Stage_4C_Implementation_Delivery_Manifest_v1_0.md
    apply_to_tree/
        build_4C_v1.bat                                  NEW
        build.zig                                        REPLACES
        src/classic_ar_all_frames_ready.zig              REPLACES
        src/classic_backend_v2_sse41.zig                 NEW
        src/classic_vector_backend.zig                   NEW
        src/deblock4_config.zig                          REPLACES
        src/deblock4_selftest.zig                        REPLACES
        src/deblock4_version.zig                         REPLACES
    restore_to_base/
        build.zig
        src/classic_ar_all_frames_ready.zig
        src/deblock4_config.zig
        src/deblock4_selftest.zig
        src/deblock4_version.zig
```

Counts:

```text
apply_to_tree:    8 files = 5 REPLACES + 3 NEW
restore_to_base:  5 files = pre-change data for every REPLACES file
```

No `.patch` file is shipped.
No `.ps1` file is shipped.
No application, restore, staging, commit, stash, or other repository-operating
script is shipped.

`build_4C_v1.bat` retains the already-reviewed inline PowerShell and calls to
resident Stage-1/2 audit scripts inherited from `build_2C_v1.bat`, exactly
under the charter-v1.27 C-DELIV-11 retained-batch exception. Stage-4C-specific
logic adds no new PowerShell invocation. The inherited non-destructive
`git diff --check` / `git status` reads remain; no repository state is changed.

---

# 2. What the implementation adds

## 2.1 `src/classic_vector_backend.zig` - NEW first-class tier-neutral body

- Explicit `@Vector(L,T)` lane arithmetic for the frozen Classic integer
  formula.
- Storage types remain exactly u8/u16; arithmetic widens to i32 lanes.
- Signed right shifts mirror the scalar formula (`>>1`, `>>3`); the possibly
  negative `(q0-p0)` term remains multiply-by-four, never a negative left
  shift.
- Final 0..peak clamps remain explicit.
- Ratified P3 traversal: top vertical-only band unchanged; then each full
  horizontal edge before that band's vertical edges; vertical edges remain
  strict increasing-x.
- Horizontal full width:
  - u8 N=16 in 4C;
  - u16 N=8 in 4C;
  - same source accepts the pre-ratified 5C widths N=32/N=16.
- C2 tails use descending same-body power-of-two widths, then scalar one lane.
  No inactive masked lanes.
- Row navigation stays in bytes until the one K31 byte-to-sample cast. The
  resulting row is sliced to the actual plane width, excluding stride slack.
- Horizontal loads/stores use fixed-length slice <-> vector VALUE coercion,
  never vector-pointer overlay.
- Primary vertical form is the ratified four-row lane pack:
  each row is one contiguous 6-sample read and 4-sample write with in-register
  repacking; 1..3-row bottom underfill uses the frozen scalar edge body.
- Tests cover:
  - A/B discriminator inputs;
  - native-16-bit discriminator;
  - strong negative-delta region;
  - exhaustive 8-bit p0/q0 single-edge sweep;
  - fixed-seed random u8/u16 lane properties;
  - the exact D3 A/B orientation fixtures;
  - exact O-4 input;
  - exact O-5d native-16 input;
  - exact O-7 geometry inputs;
  - every u8 4C horizontal remainder 1..15;
  - every u16 4C horizontal remainder 1..7 at bits 9..16;
  - four-row vertical lane pack and legal 1..3-row bottom underfills.

## 2.2 `src/classic_backend_v2_sse41.zig` - NEW first-class v2 object root

- Thin u8/u16 4C instantiation:
  - u8 -> N=16;
  - u16 -> N=8.
- Compiled only as the dedicated named x86-64-v2 object.
- At comptime, compares the complete populated target feature set to Zig
  0.16.0's named `x86_64_v2` feature set; any drift fails compilation.
- Owns object-mode `export fn` linkage roots for emission/linkage only.
- Baseline code reaches those roots through `extern`; no vector ABI crosses the
  object boundary and no PE-export doorway is intended.

## 2.3 Narrow existing-file integrations

```text
build.zig
    adds exact named-v2 target/object;
    links the object into Deblock4.dll;
    installs a v2 inspection object;
    adds dedicated `classic-v2-object` and `test-classic-v2` steps;
    DOES NOT add vector tests to the inherited default `test` step, preserving
    the historical 85-test 2C suite as a separately re-runnable gate.

src/deblock4_config.zig
    ONLY Classic implementation ceiling:
        x86_64_v1_baseline -> x86_64_v2_with_sse41

src/classic_ar_all_frames_ready.zig
    retains the scalar calls as the v1 branch;
    adds v2 u8/u16 extern calls at the existing selected-tier choke point;
    v3 remains an invariant failure in 4C.

src/deblock4_selftest.zig
    updates the implementation-ceiling contract:
    auto capped at v2; explicit v2 accepted; explicit v3 not implemented.

src/deblock4_version.zig
    single-homed stage marker 2C -> 4C and corresponding identity test.
```

`src/backend_tier_selection.zig` is NOT delivered because the accepted +2C
implementation is already ceiling-generic and remains byte-identical.

The three scalar oracle files are NOT delivered and remain byte-identical:

```text
src/classic_scalar_kernel.zig
src/classic_edge_schedule.zig
src/classic_thresholds.zig
```

---

# 3. Manual W3X application

From the package, W3X manually copies the CONTENTS of:

```text
apply_to_tree\
```

over the repository root, preserving relative paths.

There is no apply script and no staging step.

After the manual copy, useful W3X-manual non-destructive checks are:

```cmd
git -c core.whitespace=cr-at-eol diff --check
git status --short --untracked-files=all
```

Expected W3C-owned implementation surface:

```text
 M build.zig
 M src/classic_ar_all_frames_ready.zig
 M src/deblock4_config.zig
 M src/deblock4_selftest.zig
 M src/deblock4_version.zig
?? build_4C_v1.bat
?? src/classic_backend_v2_sse41.zig
?? src/classic_vector_backend.zig
```

Unrelated W3X-owned documentation/evidence files may also be present and are
outside this delivery's ownership.

---

# 4. W3D-owned differential harness join contract

The Stage-4C scope assigns the `.vpy/.cmd` end-to-end differential harness to
W3D, not W3C. That W3D harness was not supplied with the inputs available to
this W3C delivery.

`build_4C_v1.bat` therefore does NOT invent a W3D filename. Before W3X runs
the batch, set:

```cmd
set "DEBLOCK4_STAGE4C_DIFFERENTIAL_RUNNER=<absolute path to W3D's Stage-4C .cmd>"
```

The W3D `.cmd` is invoked with no command-line arguments. The W3C batch sets
these environment variables for the join:

```text
DEBLOCK4_PLUGIN_PATH
    absolute path to the DLL under test.

DEBLOCK4_STAGE4C_INSPECTION_DIR
    absolute evidence directory available to the W3D runner.

DEBLOCK4_STAGE4C_EXPECTED_VERSION
    `0.1.0-dev+4C`.

DEBLOCK4_STAGE4C_EXPECTED_V1
    `x86_64_v1_baseline`.

DEBLOCK4_STAGE4C_EXPECTED_V2
    `x86_64_v2_with_sse41`.

DEBLOCK4_STAGE4C_RUN_KIND
    `positive`
        full W3D-owned T2 scalar-vs-v2 end-to-end differential and the
        vspipe-level selection coverage required by 4C-T4; exit 0 only when
        the W3D harness's own acceptance contract succeeds.

    `tail-mutant-expected-failure`
        the same differential directed at the temporary deliberately corrupted
        DLL; it must return nonzero because the one-lane tail corruption is
        detected.
```

W3D remains responsible for the exact `.vpy/.cmd` content, corpus, hashes,
selection assertions, its own decisive result semantics, and independent
review of the resulting evidence. This join contract only lets the W3C-owned
batch call that separately owned proof surface without guessing its filename.

---

# 5. `build_4C_v1.bat` proof-driver structure

The new batch inherits the already-reviewed Stage-2C runner mechanics. It does
not modify `build_2C_v1.bat`.

Order:

```text
1. Re-run inherited S1/G10/S2/S3/V1/static Stage-2C gates.
2. ReleaseSafe:
     production build;
     inherited default test suite, explicitly requiring `85/85 tests passed`;
     inherited 2C e2e with raised-ceiling expected lines;
     G10 absence/export checks;
     4C-T1 `test-classic-v2`.
3. ReleaseFast:
     same inherited gates + 85/85;
     4C-T1 `test-classic-v2`.
4. ReleaseSafe-vs-ReleaseFast retained production-output identity.
5. Call W3D runner, positive T2/T4 leg, using ReleaseFast DLL.
6. Debug:
     build with existing three G10 seams;
     inherited default 85/85 suite;
     4C-T1 `test-classic-v2`;
     inherited e2e/lifecycle/force-down gates with v2 ceiling expectations.
7. Retained baseline frame-path and detector inspection.
8. 4C-T3:
     build/capture the named-v2 object;
     require both v2 linkage roots;
     require XMM vector evidence;
     reject EVEX/VEX/above-v2 instruction families;
     re-check baseline Classic frame-path object for v2-only instructions.
9. Retained named-model BMI2 perturbation.
10. 4C-T5:
     copy source to a TEMP tree outside the repository;
     use the existing portable-Python runner to make one narrow one-lane
     scalar-tail-result corruption in the COPY only;
     require `test-classic-v2` to reject it;
     build the mutant DLL;
     call W3D runner and require its T2 differential to reject it;
     discard the temp tree.
11. Retained target/CPU/debug-option negative-build controls.
12. Final inherited static/EOL/sweep checks and evidence summary.
```

The HolyWu external comparison is intentionally NOT re-run. Its H0-H6 evidence
is Stage-2C history, as required by the 4C scope. The generated proof summary
states this explicitly rather than claiming a new HolyWu PASS.

---

# 6. K30 authoring evidence

This is delivery-authoring evidence only, not W3X execution acceptance.

## Part 1 - new first-class domain

Domain inspected:

```text
src/classic_vector_backend.zig
src/classic_backend_v2_sse41.zig
ADDED build.zig wiring for those modules/steps
new vector unit-test names
```

Case-insensitive checks covered:

```text
stage-number / probe / smoke vocabulary;
the canonical thirteen retired Stage-1C S2 basenames.
```

Authoring result:

```text
EMPTY
```

## Part 2 - existing edited modules, added lines only

Domain:

```text
src/classic_ar_all_frames_ready.zig
src/deblock4_config.zig
src/deblock4_selftest.zig
src/deblock4_version.zig
```

Authoring result for new retired/scaffolding references:

```text
EMPTY
```

## Merged-tree S2 simulation

The retained S2 roots (`build.zig`, `build.zig.zon`, `src`, `tests`, `tools`)
were simulated against the canonical retired-basename list with the established
self/exclusion handling.

Authoring result:

```text
ZERO collisions
```

W3D independently re-verifies the K30 evidence.

---

# 7. Other mechanical authoring checks

Performed without executing Zig/VapourSynth:

```text
apply_to_tree file count:              8
restore_to_base file count:            5
all delivered repository text:         US-ASCII, CRLF
three frozen scalar oracle files:      byte-identical to accepted +2C base
backend_tier_selection.zig:             byte-identical to accepted +2C base
no shipped .ps1:                        confirmed
no shipped .patch:                      confirmed
no HolyWu invocation in build_4C:       confirmed
no new PowerShell invocation in 4C additions:
                                        confirmed
```

The W3C environment did not have a usable Zig 0.16.0 executable and the
official binary could not be downloaded into the container. Therefore W3C has
NOT compiled, linked, disassembled, loaded, or run this implementation and
makes NO project PASS claim.

---

# 8. W3X validation entry point

Once the separately W3D-owned differential runner is available and its
absolute path is set:

```cmd
build_4C_v1.bat
```

W3X supplies the actual console output and `zig-out\inspection_4C` evidence for
W3D artifact review.

The batch is designed to exit nonzero on the first failed gate and to retain a
combined transcript/diagnostic index in `zig-out\inspection_4C`.

---

# 9. Manual W3X backout

No command below is executed by the delivery.

## Git-manual form

From the repository root:

```cmd
git restore -- build.zig
git restore -- src/classic_ar_all_frames_ready.zig
git restore -- src/deblock4_config.zig
git restore -- src/deblock4_selftest.zig
git restore -- src/deblock4_version.zig

del /Q build_4C_v1.bat
del /Q src\classic_backend_v2_sse41.zig
del /Q src\classic_vector_backend.zig
```

Then optionally inspect:

```cmd
git status --short --untracked-files=all
```

## Data-copy form

`restore_to_base\` contains the exact pre-change copies of all five REPLACES
files. W3X may manually copy those contents over the repository and manually
delete the three NEW files.

`restore_to_base\` serves three purposes only:

```text
1. delivery base record for the five replaced files;
2. W3D mechanical comparison input;
3. optional manual W3X copy-back resource.
```

It is inert data; no restore machinery is included.

---

# 10. W3C disposition

The W3C-owned Stage-4C source and proof-driver surface is delivered for static
W3D review and subsequent W3X validation.

No Stage-4C execution/PASS claim is made.

The only separately owned input still required before the full proof matrix can
run is the W3D `.vpy/.cmd` differential harness identified in section 4.
