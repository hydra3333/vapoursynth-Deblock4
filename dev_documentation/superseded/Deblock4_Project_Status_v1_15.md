# Deblock4 - Project Status

**Version:** 1.15
**Date:** 2026-07-31
**Status:** Current implementation and proof-state record. Informative, not controlling.
**Project:** Deblock4
**Repository:** https://github.com/hydra3333/vapoursynth-Deblock4
**Branch:** `main`
**Encoding:** US-ASCII only.

---

# 1. Purpose and authority

This document records where Deblock4 implementation currently stands, what has
been proved, what remains open, and the next bounded development scope.

It does not define the algorithm, amend an invariant, or replace an active
coding scope.

Document authority is:

```text
README_Deblock4_Design_Spec_v1_9.md
    controlling technical and algorithmic design specification

AI_Charter_and_Invariants_Card_v1_19.md
    controlling invariants, roles, coding standards, and process rules
    (v1.11 rewrote G3 for named psABI tiers and added G7/G8/G9; v1.12 reconciled
     A1/A2 and Part 3.2 to the integer-exact/float-tolerance and named-tier
     models and recorded the two-core-filter architecture. See
     Deblock4_Verification_And_Tiering_Decisions for the reasoning.)

Deblock4_Concise_Project_Summary_v1.2.md
    concise orientation and user-facing companion

Deblock4_Forward_Roadmap_v1_12.md
    informative forward stage sequence

Deblock4_Verification_And_Tiering_Decisions_v1_10.md
    durable record of the verification / tiering / two-filter decisions

Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
    informative research record behind the G6 retention/export decision

Deblock4_Toolchain_Findings_v1_1.md
    informative durable record of empirical Zig/linker facts (F1-F5):
    emission is per compilation unit; cross-compilation references do not
    force emission; object-mode export fn does not PE-export; the proven
    multi-feature-level dispatch idiom

Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md
    informative consolidated MPEG-2 grid / frame-vs-field-DCT knowledge

Deblock4_Project_Status_v1_14.md
    current implementation/proof state and next-step record
```

Where this status document conflicts with the README specification or charter,
the README specification and charter prevail.

Before a W3C session begins, W3X verifies that each controlling document's
filename version agrees with the version recorded inside the document.

---

# 2. Evidence basis

The status below records the builds, tests, and repository actions reported by
W3X from the initial Zig 0.16.0 scaffold work through the completed Stage 1B.3
runtime-capability-guard proof and commit.

It does not claim that W3D independently executed the repository. Under the
charter, W3X remains the authority for builds, runs, measurements, commits, and
pushes.

The current committed baseline is the accepted Stage 1B.3 infrastructure (the
scaffold plus backend objects, within-level confirmation, and the proven
capability guard). The exact starting commit for the next bounded scope must be
recorded in that scope's session bootstrap header.

---

# 3. Current position

Deblock4 has completed Stages 1A, 1A.1, 1B.1, 1B.2 and 1B.3, and is now well
into Stage 1C (filter creation): Phases 1 and 2 are delivered, accepted, and
committed; Phase 3a (frame path + real plugin registration) is about to be
received for review. Stage 1 as a whole is not yet complete (Stage 1C Phase 3
and the per-filter algorithm stages remain).

Milestone:

```text
Stage 1A complete   - Zig build, Windows DLL, VapourSynth API4 interop scaffold.
Stage 1A.1 complete - helper-bridge names reconciled (zig_vsh_* wrappers,
                      deblock4_vsh_bridge_self_test), stale R76 wording
                      corrected, genuine R78 build baseline re-established.
Stage 1B.1 complete - isolated per-level backend objects and one-DLL linkage
                      (@extern address anchors; no PE export of gated code).
Stage 1B.2 complete - within-level assembly confirmation (each object inside
                      its named psABI level; vzeroupper settled).
Stage 1B.3 complete - runtime capability guard: ACTUAL/EFFECTIVE records,
                      CPUID/XGETBV detection, comptime named-model cross-check,
                      G10 debug seams, first-class selftest; fully proved and
                      committed.
Stage 1C ACTIVE     - filter creation, phased delivery (scope v1_5, addendum
                      v1_1). Phase 1 (pure foundation) and Phase 2 (tier
                      selection + instance creation + permanent-skeleton
                      callback routers, pass-through) delivered, accepted, and
                      committed, green all three modes. Phase 3a (frame path +
                      real plugin registration) about to be received for W3D
                      review; Phase 3b (scaffolding sweep, build_1C batch, .vpy
                      harnesses, full proof matrix) follows.
```

The project is not yet a functional VapourSynth deblocking filter (no pixel
processing exists; that is the per-filter 2C/2D+ work). As of the frozen
handoff point, the committed tree includes the Stage 1B.3 detector, the
first-class deblock4_selftest, and the accepted Stage 1C Phase 1+2 modules
(version identity, instance records, pure parameter validation, tier
selection, per-filter instance creation, and permanent-skeleton callback
routers that pass frames through unmodified). Real plugin registration and the
frame path arrive with Phase 3a (about to be reviewed); no deblocking
arithmetic exists yet.

Stage 1B.1 complete - isolated backend objects and one-DLL linkage proved.
Four separately compiled probe objects (generic, scalar, SSE4.1, AVX2) link
into the one Deblock4.dll; the gated SSE4.1/AVX2 markers are emitted with
non-zero .text and externally linkable, retained by internal @extern address
anchors, never called, and absent from the PE export table. Debug, ReleaseSafe
and ReleaseFast all pass, all existing scaffold regressions pass, and both
-Dcpu=native and -Dtarget=native are rejected. Scope of record: v1.7.

Three retention mechanisms were empirically FALSIFIED before the working one
was found, and the evidence is preserved (see Deblock4_Toolchain_Findings):
(a) forceUndefinedSymbol / INCLUDE-class retention of a non-exported pub fn -
Zig omits an unreferenced non-export function entirely (.text length 0);
(b) a compound object welding baseline and gated code into one unit -
withdrawn as unverifiable and unproven for retention;
(c) a cross-compilation address reference from the DLL root - emission is
decided per compilation unit, so a reference in one compilation does not force
emission in a separately compiled object.
The working mechanism is object-mode export fn (emission + linkage, and NOT a
PE export) referenced from the DLL root by @extern, address-taken and never
called. Charter v1.10 revised the G6 corollary accordingly.

---

# 4. Completed and proved

| Area | Current status |
|---|---|
| Zig 0.16.0 toolchain | Proven by local build and test runs |
| ZLS 0.16.0 and VS Code | Workspace established |
| Git repository and GitHub workflow | Established; scaffold reported committed and pushed |
| `build.zig` and `build.zig.zon` | Working for the current scaffold |
| Debug build | Passed for the settled scaffold |
| ReleaseSafe build | Passed for the settled scaffold and final helper-bridge architecture |
| ReleaseFast build | Passed for the settled scaffold |
| Zig tests | Working |
| Build/run probe executable | Passed |
| Windows x64 DLL construction | Proven with `Deblock4.dll` probe |
| DLL export/import-library/client linkage | Proven by smoke-test executable |
| VapourSynth API selection | API 4.2 explicitly pinned via VS_USE_API_42 |
| `VapourSynth4.h` | Translated into a Zig module |
| `VSConstants4.h` | Translated into a Zig module |
| `VSHelper4.h` | Compiled as C through a narrow tested C-ABI bridge |
| Vendored headers | Updated to VapourSynth R78; API 4.2 pin survives; bridge decision confirmed still needed |
| Stage 1A.1 name reconciliation | Accepted: zig_vsh_isConstantVideoFormat, zig_vsh_areValidDimensions, deblock4_vsh_bridge_self_test; C-INT-04 comments added |
| R78 build baseline | Debug/ReleaseSafe/ReleaseFast + build probe + header probe (API 4.2) + DLL smoke (0x44423401) + tests, accepted |
| Zig-facing helper naming | Settled as `zig_vsh_originalName` for direct compatibility wrappers |
| Zig/C ownership and lifetime policy | Recorded in charter (current v1.19) |
| Numeric and SIMD helper policy | Recorded in charter (current v1.19) |
| External-source provenance policy | Recorded in charter (current v1.19) |

Important translation result:

```text
VapourSynth4.h + VSConstants4.h
    translated into Zig

VSHelper4.h
    compiled as C
    exposed through narrow Zig-facing C-ABI wrappers
```

This architecture avoids the Zig 0.16.0 ReleaseSafe translation failure caused
by Windows CRT declarations reached through `VSHelper4.h`.

---

# 5. Not implemented or not yet proved

The project does not yet have (grouped by filter where relevant):

Shared / infrastructure:
- a real VapourSynth plugin entry and registration path (filter-creation stage);
- dispatch WIRING that consumes the EFFECTIVE record to call a backend (the
  capability detection and the ACTUAL/EFFECTIVE records themselves are DONE in
  Stage 1B.3; only the consumption/wiring remains);
- frozen vector widths or lane organisations;
- frame-property writes (Deblock4Filter/Deblock4Tier/etc.).

(Whole-level CPU/OS capability detection, per-filter-instance backend
resolution, and within-level assembly confirmation are COMPLETE - Stages 1B.2
and 1B.3 - and are recorded in sections 6/7, not here.)

deblock4.Classic (H.264, to be built FIRST):
- Classic filter registration and creation function;
- the Classic scalar oracle (faithful HolyWu, incl. luma-on-chroma);
- the Classic v2 and v3 backends and their differential proof;
- the HolyWu external-reference cross-check harness.

deblock4.Deblock4 (MPEG-2, to be built SECOND):
- Deblock4 filter registration and creation function;
- the canonical scalar deblocking implementation (grids, schedules, midpoint,
  proper chroma), threshold tables/expansion, and scalar range proofs;
- the Deblock4 ReleaseSafe scalar oracle;
- the Deblock4 v2 and v3 backends and their differential proof;
- quality decisions for Schedule A versus B, midpoint scale, and proper chroma.

Cross-cutting:
- an `arInitial` / `arAllFramesReady` frame path;
- frame allocation or final plane-construction policy;
- the independent differential correctness and safety harness.

After a filter's ReleaseSafe scalar oracle has been accepted, no subsequent
pixel-producing or frame-construction scope, including a copy/share path, may
pass without validation against that oracle under the integer-exact /
float-differential contract for every affected plane.

The first bounded Stage 2C/2D scope that CONSTRUCTS that oracle is the sole
exception: it is accepted against the independently authored scalar obligations
and the corruption-sanity gate defined by the charter and
Deblock4_Verification_And_Tiering_Decisions section 20 (it creates the oracle,
so no pre-existing oracle exists to diff against).

---

# 6. Stage map

```text
Stage 1 - Zig project / build / dispatch / tiering scaffold and spikes (SHARED)
    PASS  Zig project scaffold
    PASS  VS Code and ZLS integration
    PASS  Windows DLL construction and client linkage
    PASS  VapourSynth API4 core/constants translation
    PASS  VSHelper4 C-ABI bridge architecture
    PASS  Stage 1A.1 R78 baseline reconciliation (accepted, committed)
    PASS  Stage 1B.1 backend object isolation and one-DLL linkage (scope
          v1.7; accepted and committed)
    PASS  Stage 1B.2 within-level confirmation and assembly inspection (each
          object stays inside its named psABI level; whole-level requirements
          recorded; standing batch build_1B2_v5_REDEVELOPED.bat) - accepted
          and committed
    PASS  Stage 1B.3 runtime capability guard: CPUID/XGETBV detection over the
          verified Set-A table + Set-B XCR0, whole-level v3->v2->v1 into
          immutable ACTUAL and EFFECTIVE records, the shared config/print
          module skeleton, a first-class self-test exe, and the debug-only
          force-down seam (G10 pattern) - built, fully proved (v1-only detection
          object, one guarded XGETBV, three-surface G10 absence with live
          positive control, force-down and build-reject matrices, drift
          perturbation), and committed. No dispatch wiring or VS entry point yet
          (deferred to the filter stage, by design).
    PASS  Stage 1C Phase 1 (pure foundation: version identity, common instance
          fields, per-filter instance records, pure parameter validation) -
          accepted and committed, green all three modes.
    PASS  Stage 1C Phase 2 (backend tier selection consuming the EFFECTIVE
          record; per-filter instance creation with constant-format refusal;
          permanent-skeleton callback routers passing frames through
          unmodified) - accepted and committed, green all three modes, bridge
          extended not forked.
    ACTIVE Stage 1C Phase 3a: frame path (mechanics, property modules, tier-
          switch bodies, error handler, lifecycle trace) + real deblock4_plugin
          registration - about to be received for W3D review. Phase 3b (sweep,
          build_1C batch, .vpy harnesses, full proof matrix) follows.

Per-filter algorithm stages run Classic first, then Deblock4:

Stage 2C..5C - Classic (H.264, faithful to HolyWu): scalar oracle + HolyWu
    external-reference harness, compatibility gate, v2 backend, v3 backend
    NOT STARTED

Stage 2D..5D - Deblock4 (MPEG-2): scalar core + differential harness, quality
    decisions (Schedule A/B, midpoint, proper chroma), v2 backend, v3 backend
    NOT STARTED

Stage 6 - VapourSynth integration and release readiness (BOTH filters)
    API header/interop groundwork proved; functional integration not started
```

Stage 1 does not block source review, scalar algorithm design, test-vector
authoring, or corpus assembly. It does gate accepted code integration,
executable scalar testing, and backend object/link work.

---

# 7. Most recently completed bounded scope

## Stage 1C Phase 2 - tier selection + instance creation (PASS, committed)

Phase 2 delivered backend_tier_selection (the startup tier choice consuming
the proven 1B.3 EFFECTIVE record: auto->highest, explicit<=effective honoured,
explicit>effective and unknown-token refused), the two per-filter
instance_creation modules (full-signature VSMap extraction, constant-format/
dimension refusal per README v1_9 s11.3, consumer-side plane-bound check,
immutable instance records), and the two permanent-skeleton callback routers
(real getFrame/free + the permanent activation-reason switch, with minimal
pass-through bodies that return the source frame unmodified). Validated via a
single-root smoke harness mirroring the future plugin topology. Two review
rounds resolved a validation-harness module-collision (harness-only fix, source
byte-identical) and eight C-interop type mismatches (callback [*c] signatures,
[*c] slice handling, u5/u8 cast). Green all three modes; bridge extended not
forked; accepted and committed.

## Stage 1C Phase 1 - pure foundation (PASS, committed)

Phase 1 delivered the pure, VapourSynth-free foundation: deblock4_version
(single-homed identity 0.1.0-dev+1C, separate packed version), CommonInstance
Fields, the two per-filter instance-data records (C3 option B, no tagged
union), and filter_call_parameters (sectioned pure module: self-contained
type/range/default validation, P1 midpoint no-default, P2 steps>=1, P3 plane
rules). Immutable instance_id from a monotonic atomic counter (C4). Green all
three modes with no VS core; accepted and committed.

## Stage 1B.3 - runtime capability guard (PASS)

Stage 1B.3 built and proved the runtime capability guard: raw CPUID/XGETBV
detection over the Set-A table plus the Set-B XCR0 check, whole-level
v3->v2->v1 resolution into an immutable ACTUAL (process-wide) and EFFECTIVE
(per-instance) record, the shared config/print module skeleton, the first-class
deblock4_selftest.exe, and the debug-only G10 force-down seam. The full proof
matrix ran and was independently verified at the instruction/byte level: the
baseline detection object is v1-only, XGETBV occurs exactly once behind the
OSXSAVE guard, the two gated markers are absent from both release artifacts on
all three surfaces (with a live Debug positive control), the force-down and
build-reject matrices behave, and the named-model drift perturbation fires on
demand. Accepted and committed; standing batch build_1B3_v5.bat. It
does NOT wire dispatch or create the VapourSynth entry point - those are the
filter-creation stage, by design. The 1B.2 entry below is retained as the
preceding milestone.

## Stage 1B.2 - within-level confirmation and assembly inspection (PASS)

Stage 1B.2 confirmed, by generated-assembly inspection, that each backend
object emits nothing outside its named psABI level (x86_64_v1/v2/v3), settled
the vzeroupper question by inspection, and recorded the whole-level feature
requirements that Stage 1B.3 detects at runtime. Accepted and committed; the
standing validation batch is build_1B2_v5_REDEVELOPED.bat. The 1B.1 detail
below is retained as the immediately preceding milestone.

## Stage 1B.1 - backend object isolation and one-DLL linkage (scope v1.7, PASS)

Objective:

```text
Prove that generic, scalar, SSE4.1, and AVX2 probe modules can be compiled under
separate intended target contracts and linked into one Windows x64 DLL without
pixel-producing code or contamination of the generic baseline.
```

The scope should use non-pixel backend identity probes only.

Expected structure:

```text
one Deblock4 DLL
    generic/dispatch probe object
    scalar probe object
    SSE4.1 probe object
    AVX2 probe object

one smoke-test executable
    loads or links the DLL
    calls each permitted probe
    verifies exact backend identity markers
```

Proof obligations, all met (per scope v1.7):

1. Generic and scalar code contain no SSE4.1, AVX, AVX2, or FMA assumption; the
   DLL root, generic, scalar, and smoke-test units are on a fixed provisional
   x86-64 baseline target, with -Dtarget/-Dcpu overrides rejected (section 2A).
2. The SSE4.1 and AVX2 probes are isolated from generic/dispatch code.
3. All four objects coexist in the one existing Deblock4.dll.
4. The gated SSE4.1/AVX2 markers ARE declared export fn in their own
   single-target objects (emission and linker visibility) and are NOT present
   in the PE export table (charter G6 v1.10: the ban is on PE-export, not the
   export keyword). Retention is by internal @extern address anchors in the
   DLL root, address-taken and never called.
5. (Historical, SUPERSEDED: earlier 1B.1 detail said "the AVX2 object excludes
   FMA". Under the named x86_64_v3-in-full contract, FMA is a member of the v3
   level and is included in the target; .strict (G8) prevents contraction so it
   is not relied upon. The exclusion no longer applies.)
6. No pixel, frame, copy, or deblocking path is introduced.
7. Debug, ReleaseSafe, and ReleaseFast build/test expectations are stated and
   run by W3X, including the existing scaffold regression checks.
8. A standing dumpbin /EXPORTS gate fails the run if any gated marker appears
   in the export table.
9. Changed and forbidden files are explicitly bounded; the phase patch and
   build_1B1.bat are the permitted retained non-source artifacts.

Implementation acceptance:

```text
The intended multi-object DLL structure builds and links in every required
mode, its non-pixel identity smoke test passes, and generic code remains free
of unsupported feature assumptions.
```

This Stage 1B.1 scope did not freeze production vector widths or code-generation
choices. Those remain measurement and assembly-inspection questions for Stage
1B.2. The feature contracts themselves are the already-settled named full
v1/v2/v3 levels.

---

# 8. Following Stage 1 work

## Stage 1B.3 - runtime capability guard (COMPLETED; recorded here for reference)

Stage 1B.3 implements CPUID/XGETBV detection over the verified Set-A bit table
plus the Set-B XCR0 check, whole-level v3->v2->v1 resolution into an immutable
ACTUAL (process-wide) record and an EFFECTIVE (per-instance) record, the shared
module skeleton (deblock4_config.zig, print_helper_functions.zig,
print_diag_helper_functions.zig, cpu_capability_detection.zig), a first-class
deblock4_selftest.exe built from the same source modules as the DLL, and a
debug-only force-down seam under the G10 three-layer inclusion pattern (both
debug options Debug-only; force-DOWN-only). It did NOT wire dispatch or create
the VapourSynth entry point (those are the filter-creation stage). Built,
proved, and committed. See
Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md.

## Stage 1B.2 - within-level confirmation and assembly inspection (COMPLETED; recorded here for reference)

The following was CONFIRMED (not derived):

- that each object's emitted instructions stay WITHIN its named psABI level
  (x86_64_v1/v2/v3) - nothing outside the level appears;
- explicit vector widths by sample type and operation;
- contiguous unaligned load/store lowering;
- lane mask and `@select` lowering;
- narrow-tail strategies;
- scalar-load-and-pack, shuffle, transpose, and gather candidates;
- the AVX/SSE transition (`vzeroupper`) question, settled by inspection;
- emitted assembly in relevant build modes.

The tiers ARE the named psABI levels used in full (the level is the feature
contract, not a bespoke closure). FMA is part of the v3 level and is NOT
excluded; it is included in the v3 target but not relied upon (under `.strict`
ordinary a*b+c stays non-fused; no @mulAdd currently required), so 1B.2 did NOT
expect FMA emission. Stage 1B.2 PRODUCED the whole-level feature requirements; it did not implement
or check a runtime guard - that guard is the Stage 1B.3 artifact, now COMPLETE
and committed.
`@Vector`, inline loops, and suggested vector lengths are not proof of generated
SIMD instructions.

## Filter-creation stage (ACTIVE) - VS entry point, scaffolding sweep, dispatch

Stage 1B.3 already implemented and PROVED the whole-level capability record
(immutable process-wide ACTUAL and per-instance EFFECTIVE, whole-level checks
including AVX/OSXSAVE/XCR0, the comptime named-model cross-check, v3->v2->v1
resolution, requested-backend resolution and rejection). The remaining work is:

- the VapourSynth entry point and filter registration;
- the scaffolding sweep (retiring the probe/smoke/dll_probe files and remaining
  LF holdouts per C-STY-10's sweep test);
- dispatch WIRING that stores immutable selected entry points from the EFFECTIVE
  record and consumes them, with proof that no per-frame capability or backend-
  choice branch exists.

After Stage 1B is checkpointed, begin the per-filter algorithm stages - Classic
(2C) first, then Deblock4 (2D) - each with its canonical scalar source and
ReleaseSafe proof harness.

---

# 9. Stage 2 entry sequence

The recommended scalar sequence is:

```text
small synthetic sample neighbourhoods
    -> single-edge scalar arithmetic
    -> threshold tables and range proofs
    -> named luma/chroma footprints and eligibility
    -> canonical traversal schedules
    -> whole-plane scalar oracle and safety harness
```

The same canonical scalar source must instantiate both:

```text
ReleaseSafe scalar oracle
ReleaseFast production scalar backend
```

There must never be a second independent scalar implementation.

Only after the oracle can produce and compare complete plane outputs should a
pixel-producing VapourSynth frame path, plane sharing, or copy implementation
be accepted.

---

# 10. Documentation package readiness

The current controlling/orientation package is:

```text
README_Deblock4_Design_Spec_v1_9.md
AI_Charter_and_Invariants_Card_v1_19.md
Deblock4_Verification_And_Tiering_Decisions_v1_10.md
Deblock4_Concise_Project_Summary_v1.2.md
Deblock4_Forward_Roadmap_v1_12.md
Deblock4_Project_Status_v1_14.md
Deblock4_Toolchain_Findings_v1_1.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
111_New_Chat_Introduction_for_Coder_v1_13.md
111_New_Chat_Introduction_for_Designer_v1_7.md
```

They serve different purposes and should live alongside one another:

| Document | Purpose |
|---|---|
| README design specification | Controlling technical and algorithmic design |
| Charter and invariants card | Controlling invariants, roles, coding, and process |
| Verification and tiering decisions | Durable record of the verification/tiering/two-filter decisions |
| Concise project summary | Fast orientation and public-facing summary |
| Forward roadmap | Orientation on the next bounded stages |
| Project status | Current proof state, open work, and immediate execution sequence |

Before moving ahead, W3X should confirm:

1. the charter's canonical filename and internal version both say v1.19;
2. the README's filename and internal design revision both say v1.9;
3. the concise summary remains marked non-controlling;
4. this status document remains marked informative and non-controlling;
5. the next coding scope records the actual starting commit;
6. the repository working tree is clean before the next scope begins.

With those checks complete, the project has enough design, process, orientation,
and current-state documentation to proceed safely.

---

# 11. Status update discipline

This file should be updated only when a material implementation or proof
milestone changes the current state.

Examples:

- Stage 1B.1 accepted;
- within-level confirmation completed at Stage 1B.2;
- capability/dispatch harness accepted;
- scalar oracle established;
- Schedule A/B quality decision settled;
- a filter's v2 or v3 backend differential contract proved (integer-exact / float-tolerance);
- functional VapourSynth integration accepted.

For each material update:

1. bump the status document version;
2. update the date;
3. state the newly accepted evidence;
4. move items between completed and open sections;
5. identify the next bounded scope;
6. do not amend the charter or controlling design specification implicitly.

---

# 12. Immediate next action

The FILTER-CREATION stage. Stages 1A through 1B.3 are complete and committed;
the shared infrastructure (build, backends, within-level confirmation, and the
proven runtime capability guard with its ACTUAL/EFFECTIVE records) now exists.
The next bounded work is:

- register the VapourSynth entry point and filter-creation function;
- perform the scaffolding sweep - retire the probe/smoke/dll_probe files and any
  remaining LF holdouts, per C-STY-10's sweep test (deleting all scaffolding
  must require ZERO edits to first-class modules);
- wire dispatch to store immutable selected entry points from the EFFECTIVE
  capability record and consume them, with proof that no per-frame capability or
  backend-choice branch exists.

No gated backend arithmetic executes yet - G5 continues to govern until each
filter's ReleaseSafe scalar oracle exists at Stage 2C/2D.

Two filters, Classic first: the plugin will register deblock4.Classic (H.264,
built first) and deblock4.Deblock4 (the end-goal MPEG-2 algorithm, second). The
1B.x infrastructure work is filter-agnostic and now complete; the per-algorithm
build then runs for Classic first, then Deblock4. See README section 1.0.
The MPEG-2 filter remains the end goal; Classic-first is a sequencing choice.

Starting point: the accepted Stage 1B.3 commit on branch main (verify the
current HEAD before issuing the scope).

---

# 13. Revision history

```text
v1.14 Coder-review corrections: scaffold-era wording advanced (evidence basis
      now spans through 1B.3; committed baseline = the 1B.3 infrastructure, not
      merely the scaffold; current-position milestone table now lists
      1B.1/1B.2/1B.3; the DLL/executables description includes the real
      capability detector and selftest); the v1.13 revision entry's self-ref
      transition corrected to v1_13; cross-pins advanced to the new generation
      (roadmap v1_12, coder intro v1_13, designer intro v1_7, self-ref v1_14).
      Version bumped per immutable-version discipline (v1.13 was already
      exchanged).
v1.13 Full reconciliation after Stage 1B.3 COMPLETE and committed. Corrected all
      stale body layers a prior surgical edit missed: package/authority pins
      (charter v1_16 -> v1_19, roadmap v1_8 -> v1_10, self-ref -> v1_13,
      decisions/summary/coder-intro pins, added the designer intro); removed the
      three now-DONE shared items from "Not implemented" (capability detection,
      backend resolution, within-level assembly confirmation); marked the
      historical "AVX2 object excludes FMA" claim SUPERSEDED; batch name made
      exact (build_1B3_v5.bat); replaced the obsolete duplicate "Stage 1B.3 -
      Implement and prove" section and the obsolete "Immediate next action:
      Stage 1B.2" section with the filter-creation stage; readiness-check pin
      -> v1.19. (v1.11 and v1.12 were interim surgical passes; this entry
      supersedes them.)
v1.12 Interim: position table advanced (1B.3 -> PASS, filter stage ACTIVE) and
      sections 7/8 headline-updated. Body pins/lists not yet reconciled.
v1.11 Interim: charter pin and current-position headline advanced for the 1B.3
      scope/delivery round.
v1.10 Cross-reference sync after the companion-pin cascade: charter v1.15 ->
      v1.16, decisions v1.8 -> v1.9, roadmap v1.7 -> v1.8, coder intro -> v1.9.
      No content change beyond pointers.
v1.9  Mechanical review corrections: the standing oracle-precedence paragraph
      (H1) restated with the Stage 2C/2D oracle-construction exception, so this
      informative record no longer carries the half-rule that would forbid the
      scope that builds the first oracle; the "final feature closures" scope
      note (M3) reworded - the named v1/v2/v3 contracts are already settled and
      1B.2 confirms vector/codegen details, it does not freeze closures.
v1.8  Mechanical review corrections: the authority block and documentation
      package list now name decisions v1.8 and coder intro v1.7 (were still
      v1.5 / v1.6 despite the v1.7 note claiming they were synced);
      completed-table charter references advanced from v1.14 to current v1.15.
v1.7  Cross-reference sync to the post-re-audit package (incl. final package
      review: evidence-basis concise ref -> v1.1; package-list coder intro ->
      v1.6; FMA wording aligned) (charter v1.15, README
      v1.8, decisions v1.7, coder intro v1.6). No content change beyond pointers.
v1.6  Independent re-audit corrections (H1/H2): authority block, evidence basis,
      documentation-package list, and readiness checks updated to the current
      set (charter v1.15, README v1.8, decisions v1.5, roadmap v1.7, concise
      summary v1.1, this doc v1.6); the coder intro is named with its exact
      filename/revision (111_New_Chat_Introduction_for_Coder_v1_4.md), not
      "(current)". Stage 1B.2 wording corrected: it PRODUCES the whole-level
      feature requirements that 1B.3 dispatch enforces (dispatch does not
      produce them; the guard is a 1B.3 artifact). Completed-table charter
      references updated to v1.14.
v1.5  Second audit pass regeneration of the stale sections W3C flagged: stage
      map (section 6) and Stage 1B.2/1B.3 (section 8) rewritten (within-level
      confirmation; 1B.2 produces requirements, 1B.3 implements/checks the
      guard; FMA-exclusion removed; named-level tokens; Classic/Deblock4
      2C..5C / 2D..5D split). Evidence-basis and section 9 examples updated
      off stale roadmap/status/backend references.
v1.4  Consistency reconciliation after the document audit (two passes). Authority
      block, evidence basis, and documentation-package section updated to charter
      v1.12 / README v1.6 / decisions v1.4 / roadmap v1.5 (were stale at
      v1.9/v1.1/v1.2 and listed a "four-document package" of eight files). Stage
      map (section 6), Stage 1B.2/1B.3 (section 8), and the section 9 examples
      regenerated: "feature-closure spikes" -> within-level confirmation;
      Stage 1B.2 PRODUCES requirements while Stage 1B.3 IMPLEMENTS/CHECKS the
      guard; FMA-exclusion language removed (FMA is part of v3, present-but-
      unused under .strict); old backend tokens -> the named-level tokens;
      generic Stage 4/5 "identity proof" -> the Classic/Deblock4 (2C..5C /
      2D..5D) split with the integer-exact / float-tolerance contract. The "Not
      implemented" list is split into shared / Classic / Deblock4 entries.
v1.3  Two-filter / Classic-first note and 1B.2 named-level correction.
```

---

*This document is informative and non-controlling. The charter and README
prevail. It records the current proof state; each stage becomes real only as a
formal coding scope against the actual repository at that time.*
