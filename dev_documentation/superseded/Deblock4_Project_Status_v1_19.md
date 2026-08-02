# Deblock4 - Project Status

**Version:** 1.19
**Date:** 2026-08-01
**Status:** Current implementation and proof-state record. Informative, not controlling.
**Project:** Deblock4
**Repository:** https://github.com/hydra3333/vapoursynth-Deblock4
**Branch:** `main`
**Encoding:** US-ASCII only.

---

# 0. STATE ADVANCE (v1.19, 2026-08-02) - read this first: STAGE 1C COMPLETE

```text
CLOSURE (v1.19): Delivery v1_13 (three-line source correction: pub export fn
-> pub fn on the three G10 markers) passed W3D static review and W3X's
authoritative run: full fifteen-gate proof matrix green, 40/40 tests x three
modes, Debug positive controls live, Debug DLL export table restored to
VapourSynthPluginInit2 + _DllMainCRTStartup only, OUTER_BATCH_EXIT_CODE=0.
W3X ACCEPTED Phase 3b and STAGE 1C, and committed the v1_13-applied tree.
STAGE 1C IS COMPLETE. The G6 finding below is retained as history. Next
released step (W3X's choice of timing): rider 1C.1 (using echo). Remaining
doc items: P4 creation-error message-table review; scope S3-wording amendment
at next issuance.
```

This revision advances ONLY the live state; the detailed body below is
retained from v1.17 and is superseded WHERE IT DESCRIBES PHASE 3a AS A
CANDIDATE. Current facts:

```text
- Phase 3a: W3D-reviewed (15 checks), W3X toolchain-validated, ACCEPTED and
  COMMITTED.
- Phase 3b: released; delivered and debugged through corrections v1_0..v1_12
  (repository main = the v1_12-applied state; base artifact
  designer_interaction/deliveries/
  Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_12.zip).
- Proof matrix: passes ALL gates and both release modes end-to-end EXCEPT the
  final Debug export-exclusion gate, which caught a REAL G6 violation: the
  three G10 debug markers are PE-exported from the Debug DLL (root cause
  verified: pub export fn = dllexport in the DLL compilation; correct in the
  1B.1 object-mode context, wrong in the DLL). Gate verdict CORRECT; never
  relax it; fix is source-side.
- The W3C coder chat that produced v1_0..v1_12 reached maximum length and
  died; a successor coder resumes from
  Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_0.md, which PREVAILS on
  current state and carries the directed fix, per-marker retention
  verification obligations, and the paid-for harness lessons.
- Toolchain findings recorded en route: F6 (VapourSynth coerces numeric args
  to registered type pre-plugin; wrong-type rejection unreachable) and the
  empty-planes boundary interception (harness case retired; plugin empty-
  array validation RETAINED as low-level-API defence). S3's proof domain was
  W3X-ratified as the Stage 1C deliverable tree (allowlist).
- After the G6 fix and a fully green matrix: W3X accepts Phase 3b, commits,
  and Stage 1C is complete; the released-next small step is rider 1C.1
  (Deblock4_Scope_Stage_1C1_Rider_Using_Echo_v1_0.md), released ONLY after
  1C acceptance.
```

# 1. Purpose and authority

This document records where Deblock4 implementation currently stands, what has
been proved, what remains open, and the next bounded review or development
step.

It does not define the algorithm, amend an invariant, or replace an active
coding scope.

Document authority and current orientation are:

```text
README_Deblock4_Design_Spec_v1_9.md
    controlling technical and algorithmic design specification

AI_Charter_and_Invariants_Card_v1_26.md
    controlling invariants, roles, coding standards, delivery rules, version-
    set discipline (2.3a), and scope-currency decisions (2.3b)

Deblock4_Verification_And_Tiering_Decisions_v1_10.md
    informative durable record of the verification / tiering / two-filter
    decisions and their reasoning; charter and README prevail on conflict

Deblock4_Concise_Project_Summary_v1.2.md
    concise orientation and user-facing companion

Deblock4_Forward_Roadmap_v1_13.md
    informative forward stage sequence; its narrow Phase 3a status line predates
    production of the delivery candidate and is queued for a separate currency
    check

111_New_Chat_Introduction_for_Coder_v1_19.md
    current informative W3C successor orientation

111_New_Chat_Introduction_for_Designer_v1_13.md
    current informative W3D successor orientation

Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
    ratified and binding Stage 1C design authority

Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
    binding Stage 1C delivery order and phase-boundary clarification

Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
    informative Phase 3a review guidance; one member of the mixed-authority
    Phase 3a review set

Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    current verbatim C-DELIV-09 reminder block for scopes and delivery-plan
    addenda issued henceforth

Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
    informative research record behind the G6 retention/export decision

Deblock4_Toolchain_Findings_v1_1.md
    informative durable record of empirical Zig/linker facts (F1-F5)

Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md
    informative consolidated MPEG-2 grid / frame-vs-field-DCT knowledge

Deblock4_Project_Status_v1_17.md
    this informative implementation/proof-state and next-action record
```

The Phase 3a review set is a declared read-together set under charter 2.3a but
has MIXED AUTHORITY: scope v1_5 is the binding design authority, addendum v1_1
governs delivery order and boundaries, and briefing v1_2 is informative review
guidance. Read-together status does not equalise authority.

Charter 2.3b compatibility decision:

```text
scope v1_5 + addendum v1_1 / charter v1.26: compatible, grandfathered to next issuance, W3X 2026-08-01.
```

Scope v1_5 and addendum v1_1 therefore stand unchanged for the remainder of
Stage 1C unless a real material reason requires reissue. Their historical
charter pins and absence of the later C-DELIV-09 reminder block are not a STOP
condition. The prevailing charter governs; the reminder-block requirement
applies at their next natural issuance.

Where this status document conflicts with the README specification, charter,
or binding scope/addendum, those documents prevail.

Before a W3C or W3D session relies on a package, W3X verifies document currency
and any declared version set under charter 2.3a, and applies recorded scope-
currency decisions under charter 2.3b.

# 2. Evidence basis

The status below records builds, tests, repository actions, document decisions,
and delivery state reported by W3X from the initial Zig 0.16.0 scaffold through
the accepted Stage 1C Phase 2 commit and production of the Phase 3a delivery
candidate.

It does not claim that W3D or W3C independently executed the repository. Under
the charter, W3X remains the authority for builds, runs, measurements, commits,
pushes, and acceptance.

The current accepted and committed implementation baseline is Stage 1C Phase 2:
the proven Stage 1B.3 capability infrastructure plus the accepted Phase 1 pure
foundation and Phase 2 tier-selection, instance-creation, and permanent-router
modules. Phase 3a delivery v1.0 exists as a candidate against that baseline but
is not yet accepted or committed.

For any Phase 3a review, correction, or re-integration, W3X supplies the
prevailing branch-main source or an exact attached source tree together with
the delivery artifacts and review findings. Do not infer or require an old HEAD
SHA merely because earlier status text did so.

# 3. Current position

Deblock4 has completed Stages 1A, 1A.1, 1B.1, 1B.2 and 1B.3 and is well into
Stage 1C (filter creation). Phases 1 and 2 are accepted and committed. W3C has
produced Phase 3a delivery v1.0 (frame path plus real plugin registration); it
awaits W3D static review, W3X toolchain validation, and W3X acceptance. Phase
3b has not been released. Stage 1 as a whole is not complete.

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
                      v1_1; both grandfathered under charter 2.3b). Phase 1
                      (pure foundation) and Phase 2 (tier selection + instance
                      creation + permanent-skeleton callback routers) are
                      accepted and committed, green all three modes. Phase 3a
                      delivery v1.0 exists and awaits W3D static review, W3X
                      toolchain validation, and W3X acceptance. Phase 3b
                      (scaffolding sweep, build_1C batch, .vpy harnesses, full
                      proof matrix) is not released.
```

The accepted committed tree is not yet a functional VapourSynth deblocking
filter: no deblocking arithmetic exists. The unaccepted Phase 3a candidate adds
the real plugin entry/registration path, the API4 frame path, writable
copyFrame pass-through, frame properties, tier-switch bodies that all target
the same inert pass-through placeholder, common error handling, and the third
G10 lifecycle-trace seam. It does not add real Classic or Deblock4 algorithm
backends and does not execute gated v2/v3 arithmetic.

Stage 1B.1 complete - isolated backend objects and one-DLL linkage proved.
Four separately compiled probe objects (generic, scalar, SSE4.1, AVX2) link
into the one Deblock4.dll; the gated SSE4.1/AVX2 markers are emitted with
non-zero .text and externally linkable, retained by internal @extern address
anchors, never called, and absent from the PE export table. Their export-table
absence is enforced by the standing loud-failing dumpbin /EXPORTS gate, not
assumed from implicit toolchain behaviour. Debug, ReleaseSafe and ReleaseFast
all pass, all existing scaffold regressions pass, and both -Dcpu=native and
-Dtarget=native are rejected. Scope of record: v1.7.

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
called before guarded dispatch. Charter G6 carries the controlling rule.

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
| Stage 1B.1 backend isolation/linkage | Accepted and committed; one DLL, separately targeted objects, gated markers absent from PE exports |
| Stage 1B.2 within-level confirmation | Accepted and committed; generated instructions confirmed within named v1/v2/v3 levels |
| Stage 1B.3 capability guard | Accepted and committed; ACTUAL/EFFECTIVE records, CPUID/XGETBV, drift check, G10 seams, selftest |
| Stage 1C Phase 1 | Accepted and committed; pure foundation green in Debug/ReleaseSafe/ReleaseFast |
| Stage 1C Phase 2 | Accepted and committed; tier selection, instance creation, permanent routers green in all three modes |
| Zig-facing helper naming | Settled as `zig_vsh_originalName` for direct compatibility wrappers |
| Zig/C ownership and lifetime policy | Recorded in prevailing charter v1.26 |
| Numeric and SIMD helper policy | Recorded in prevailing charter v1.26 |
| External-source provenance policy | Recorded in prevailing charter v1.26 |

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

# 5. Not implemented, not accepted, or not yet proved

The distinction between the accepted committed baseline and the Phase 3a
delivery candidate is load-bearing.

Present in Phase 3a delivery v1.0 but NOT YET W3D-reviewed, W3X-validated,
accepted, or committed:

- real VapourSynth plugin entry and registration for both filters;
- `arInitial` / `arAllFramesReady` frame mechanics and common error handling;
- standard API4 copyFrame writable pass-through with plane data unchanged;
- Deblock4Filter, Deblock4Tier, Deblock4Version, and related frame properties;
- per-filter tier-switch bodies in the settled C5 order, with every tier branch
  calling the shared inert pass-through placeholder;
- debug-only `enable_trace_lifecycle`, the third G10 seam.

Still not delivered because Phase 3b is not released:

- C-STY-10 scaffolding sweep;
- `build_1C_v1.bat`;
- the two `tests/stage_1c_*_passthrough.vpy` harnesses;
- the full Stage 1C proof matrix, including release-absence and end-to-end gates.

Still not implemented in any accepted or candidate algorithm path:

Shared / infrastructure:
- callable real Classic/Deblock4 backend tables and execution of algorithmic
  backend arithmetic;
- frozen production vector widths or lane organisations;
- the independent full differential-correctness and safety harness.

deblock4.Classic (H.264, built FIRST):
- the Classic scalar oracle (faithful HolyWu, including luma-on-chroma);
- the Classic v2 and v3 backends and their differential proof;
- the HolyWu external-reference cross-check harness.

deblock4.Deblock4 (MPEG-2, built SECOND):
- the canonical scalar deblocking implementation (grids, schedules, midpoint,
  proper chroma), threshold tables/expansion, and scalar range proofs;
- the Deblock4 ReleaseSafe scalar oracle;
- the Deblock4 v2 and v3 backends and their differential proof;
- quality decisions for Schedule A versus B, midpoint scale, and proper chroma.

The Stage 1C copyFrame path is a pure identity pass-through, not algorithmic
pixel construction. It must remain byte-identical to the source and must not
mutate it. After a filter's ReleaseSafe scalar oracle has been accepted, later
pixel-producing, frame-construction, copy/share, ReleaseFast-scalar, v2, and v3
work is validated against that oracle under the charter's per-output-type
contract.

The first bounded Stage 2C/2D scope that CONSTRUCTS an oracle is the sole oracle-
comparison exception: it is accepted against independently authored scalar
obligations and the corruption-sanity gate in the charter and
Deblock4_Verification_And_Tiering_Decisions section 20.

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
    ACTIVE Stage 1C Phase 3a: W3C delivery v1.0 (frame mechanics, property
          modules, tier-switch bodies, error handler, lifecycle trace, and real
          deblock4_plugin registration) exists and awaits W3D static review, W3X
          toolchain validation, and W3X acceptance. Review uses the complete
          mixed-authority set: scope v1_5 + addendum v1_1 + root-level Phase 3a
          Designer Briefing v1_2. Scope/addendum are grandfathered under charter
          2.3b. Phase 3b is not released.

Per-filter algorithm stages run Classic first, then Deblock4:

Stage 2C..5C - Classic (H.264, faithful to HolyWu): scalar oracle + HolyWu
    external-reference harness, compatibility gate, v2 backend, v3 backend
    NOT STARTED

Stage 2D..5D - Deblock4 (MPEG-2): scalar core + differential harness, quality
    decisions (Schedule A/B, midpoint, proper chroma), v2 backend, v3 backend
    NOT STARTED

Stage 6 - VapourSynth integration and release readiness (BOTH filters)
    API header/interop groundwork proved; inert integration candidate exists at
    Stage 1C Phase 3a, but algorithmic integration and release work remain
```

Stage 1 does not block source review, scalar algorithm design, test-vector
authoring, or corpus assembly. It does gate accepted code integration,
executable scalar testing, and backend object/link work.

---

# 7. Current candidate and most recently completed bounded scope

## Stage 1C Phase 3a - frame path + real plugin registration (DELIVERED CANDIDATE; NOT YET ACCEPTED)

W3C delivery v1.0 has been produced. It is now the current review candidate, not
an accepted milestone. It adds the real plugin registration and inert API4 frame
path bounded by the Phase 3a review set. W3D static review, W3X toolchain
validation, and W3X acceptance remain outstanding; Phase 3b is not released.

The most recently accepted and committed bounded scope remains Phase 2 below.

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

# 8. Active and following Stage 1 work

## Stage 1C Phase 3a - delivery candidate awaiting review and validation

W3C delivery v1.0 contains the Phase 3a frame path and real plugin registration
bounded by the existing mixed-authority review set:

```text
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
```

The principal review points are:

- creation callbacks expose the exact translated VSPublicFunction C-ABI
  signature, immediately rebind validated idiomatic locals, preserve the
  accepted parsing/validation/tier-selection/allocation/ownership/filter-
  construction logic, and add only the authorised lifecycle trace around it;
- the permanent activation-reason switch is not restructured;
- C5 order is obtain source -> frozen-tier switch -> property annotate -> return;
- the lifecycle trace is one physical line per event and creation successful-
  exit carries the complete resolved configuration;
- every tier branch remains the shared inert pass-through; no real v2/v3
  algorithm backend executes.

Phase 3a stops for W3D review, W3X toolchain validation, and W3X acceptance. Do
not begin Phase 3b or make unrelated production changes unless W3X releases a
bounded correction or the next phase.

## Stage 1C Phase 3b - not released

After Phase 3a acceptance and explicit W3X release, Phase 3b performs the
C-STY-10 scaffolding sweep, supplies build_1C_v1.bat and the two .vpy harnesses,
and runs the full Stage 1C proof matrix. It must not be silently recombined with
Phase 3a.

## Stage 1B.3 - runtime capability guard (COMPLETED; retained for reference)

Stage 1B.3 implemented CPUID/XGETBV detection over the verified Set-A bit table
plus the Set-B XCR0 check, whole-level v3->v2->v1 resolution into immutable
ACTUAL and EFFECTIVE records, the shared module skeleton, a first-class
`deblock4_selftest.exe`, and the original debug-only G10 seams. It deliberately
did not create the VapourSynth entry point or frame path; those are Phase 3a
candidate work. See
Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md.

## Stage 1B.2 - within-level confirmation and assembly inspection (COMPLETED; retained for reference)

Stage 1B.2 confirmed that each object's emitted instructions stay within its
named psABI level, inspected relevant vector/code-generation forms, settled the
AVX/SSE `vzeroupper` question, and produced the whole-level requirements later
enforced by Stage 1B.3. The tier is the named level, not a bespoke closure; FMA
is part of v3 but is not relied upon under `.strict`.

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

Stage 1C may establish a byte-identical inert pass-through using the standard
API4 copyFrame idiom before an algorithmic scalar oracle exists. It must not
perform deblocking or algorithmic plane construction. Once a filter's oracle
exists, subsequent pixel/frame/copy/backend work is accepted only under the
charter's oracle-based per-output-type validation contract.

# 10. Documentation package readiness

The current controlling/orientation/review package is:

```text
README_Deblock4_Design_Spec_v1_9.md
AI_Charter_and_Invariants_Card_v1_26.md
Deblock4_Verification_And_Tiering_Decisions_v1_10.md
Deblock4_Concise_Project_Summary_v1.2.md
Deblock4_Forward_Roadmap_v1_13.md
Deblock4_Project_Status_v1_17.md
Deblock4_Toolchain_Findings_v1_1.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
111_New_Chat_Introduction_for_Coder_v1_19.md
111_New_Chat_Introduction_for_Designer_v1_13.md
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
Scopes/Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md
Scopes/Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
Deblock4_Stage_1C_Phase_3a_W3C_delivery_v1_0.zip
```

Scope v1_5 and addendum v1_1 remain the controlling Stage 1C documents despite
their historical pins. Their compatibility with charter v1.26 is recorded in
section 1 under charter 2.3b; they are grandfathered until next issuance. The
reminder block is supplied directly and applies to scopes/addenda issued
henceforth.

The Phase 3a review set must be complete and read together, while retaining its
mixed authority. The delivery ZIP is a candidate artifact, not proof of W3D
review, W3X validation, acceptance, or commit.

Before Phase 3a can be accepted, W3X should confirm:

1. the prevailing charter filename and internal version are v1.26;
2. the README filename and internal design revision are v1.9;
3. Project Status filename and internal version are v1.17;
4. the charter 2.3b compatibility line for scope v1_5/addendum v1_1 is present;
5. all three Phase 3a review-set members are present at the stated versions;
6. the Phase 3a delivery v1.0 artifact and its checksum/manifest are the exact
   candidate being reviewed;
7. W3D's static findings and W3X's actual validation outputs are recorded before
   any PASS recommendation;
8. Phase 3b remains unreleased until Phase 3a acceptance and explicit W3X
   release;
9. any correction is prepared against the prevailing branch-main source or an
   exact source tree supplied by W3X, not an inferred stale commit.

With those checks complete, the project has enough design, process,
orientation, and current-state material to review Phase 3a safely.

# 11. Status update discipline

This file should be updated only when a material implementation, delivery,
review, acceptance, or proof milestone changes the current state.

Examples:

- Stage 1B.1 accepted;
- within-level confirmation completed at Stage 1B.2;
- capability/dispatch harness accepted;
- scalar oracle established;
- Schedule A/B quality decision settled;
- a filter's v2 or v3 backend differential contract proved (integer-exact / float-tolerance);
- a bounded delivery candidate enters or leaves formal review;
- functional VapourSynth integration accepted.

For each material update:

1. bump the status document version;
2. update the date;
3. state the newly accepted evidence;
4. move items between completed and open sections;
5. identify the next bounded review, correction, or coding action;
6. do not amend the charter or controlling design specification implicitly.

---

# 12. Immediate next action

Do not begin fresh implementation or Phase 3b.

The immediate bounded action is the Phase 3a review/validation/acceptance loop:

1. W3D reviews W3C delivery v1.0 statically against the complete mixed-authority
   Phase 3a review set, with file-and-line evidence.
2. W3X applies or stages the exact candidate against the prevailing source and
   runs the required toolchain validation.
3. W3C responds only to bounded findings or correction instructions supplied by
   W3X; no unrelated cleanup or Phase 3b work is pulled forward.
4. W3X decides acceptance. Only after Phase 3a acceptance may W3X release Phase
   3b.

Phase 3b, when released, performs the scaffolding sweep, supplies the build batch
and two .vpy harnesses, and closes the full Stage 1C proof matrix.

No gated backend arithmetic executes in Stage 1C. Each tier branch remains the
same inert pass-through until the per-filter scalar-oracle stages. Classic is
built first; Deblock4 remains the end goal.

Starting point for any correction: the prevailing branch-main source or exact
source tree supplied by W3X together with the reviewed Phase 3a artifact. Do not
infer or transcribe a commit id.

# 13. Revision history

```text
v1.17 Full status reconciliation after production of Stage 1C Phase 3a W3C
      delivery v1.0 and ratification of charter v1.26. Current accepted baseline
      advanced from Stage 1B.3 to Stage 1C Phase 2; Phase 3a is recorded as a
      delivered candidate awaiting W3D static review, W3X toolchain validation,
      and W3X acceptance; Phase 3b is explicitly unreleased. Updated live pins
      (charter v1.26, roadmap v1.13, coder intro v1.19, designer intro v1.13,
      briefing v1.2, self v1.17, reminder block v1.1), classified the Phase 3a
      review set as mixed authority, and recorded the charter-2.3b compatibility
      decision grandfathering scope v1_5 and addendum v1_1 to next issuance.
      Corrected the stale exact-commit/HEAD rule to prevailing-source or exact
      supplied-tree discipline. Distinguished candidate Phase 3a components from
      accepted code, preserved the permitted byte-identical API4 copyFrame
      pass-through exception, recorded the third G10 lifecycle seam, and changed
      the immediate action from implementation to the Phase 3a review/validation/
      acceptance loop. No design or Part 1 invariant change.
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
