# Deblock4 - Stage 1C Delivery Plan Addendum (phased)

**Version:** 1.1
**Date:** 2026-08-01
**Author:** W3D
**Companion to:** Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md (the binding
scope; unchanged by this addendum).
**Purpose:** Split the Stage 1C delivery into ordered phases so each is small,
self-contained, and reviewable. The full scope remains the design authority and
the coder reads ALL of it for context; this addendum governs only DELIVERY
ORDER and what to emit in each pass.
**Encoding/EOL:** US-ASCII; CRLF.

## Why phased

The Stage 1C module set is large (17+ modules plus the proof harness). A single
full-scope delivery risks stalling and gives no early review checkpoint. Phasing
caps the blast radius of any error to one phase and produces working, testable
increments. This addendum does NOT change any design decision in scope v1.5;
module names, the dispatch architecture, C1-C9 resolutions, and the proof matrix
are all unchanged.

## Standing instruction to the coder

Read the ENTIRE scope v1.5 for context so every module you write fits the whole.
But DELIVER ONLY the phase you are currently asked for. Do not emit modules from
a later phase. Follow the chartered delivery discipline (propose-before-
transform, before/after block identifiers with unique change ids, #OLD#
commenting rather than deletion, CRLF, US-ASCII, full files). Prevailing branch-
main source is the anchor (no commit id); if unsure you hold current source, ask
W3X to upload it.

## Phase 1 - pure foundation (DELIVER THIS FIRST, THIS PHASE ONLY)

Scope: the pure, VapourSynth-free foundation. Everything here compiles and
unit-tests with NO VS core (C-1C-2 twin discipline), so it is independently
verifiable before any VS-facing code exists.

Modules:
```text
src/deblock4_version.zig
    Single-homed version identity: semantic "0.1.0-dev", stage marker "1C",
    identity "0.1.0-dev+1C", vs_packed_version 0.1 (scope s4, N3). No VS.
src/common_instance_data_structure.zig
    CommonInstanceFields ONLY (C3 option B): source-node handle placeholder +
    video-info fields, immutable instance_id (allocated at creation from the
    process-wide monotonic atomic counter - the counter lives here or in a
    pure util; the stored id is a plain immutable integer, C4), filter_kind
    (diagnostics only), BackendSelection. No parameter records. No VS logic;
    node/video types may be referenced but the file holds no VS calls.
src/filter_call_parameters.zig
    ONE sectioned pure module (COMMON / CLASSIC / DEBLOCK4): every call
    parameter's type, default, range, and SELF-CONTAINED validation. The
    `backend` string is syntax-checked here (recognised token?), not resolved.
    ClassicParameters and Deblock4Parameters immutable records. P1-P3 rules:
    midpoint no-default (P1); custom steps integer >= 1 (P2, upper-bound check
    deferred to creation where the clip dimension exists); planes non-negative
    integer indices with reject-duplicates / reject-empty / order-independent
    (P3; the clip-format upper-bound check is consumer-side, not here).
src/classic_instance_data.zig
    ClassicInstanceData = CommonInstanceFields + ClassicParameters (type only).
src/deblock4_instance_data.zig
    Deblock4InstanceData = CommonInstanceFields + Deblock4Parameters (type
    only).
```

Phase-1 tests (pure, no VS core):
```text
- filter_call_parameters: valid; out-of-range; wrong-type; duplicate-plane;
  empty-planes; (Deblock4) step<1; backend recognised vs unknown string.
- deblock4_version: the identity/semantic/packed fields are internally
  consistent.
```

Phase-1 acceptance (what W3X runs to sign off phase 1):
```text
- the pure modules compile in the baseline v1 object set;
- the phase-1 unit tests pass;
- deblock4_selftest (if extended this phase) still builds;
- no VS-facing code introduced; no scaffolding retired yet.
```

STOP after phase 1. Do not begin phase 2 until W3X accepts phase 1.

## Phase 2 - selection + creation (context now; deliver after phase 1 accepted)

Modules:
```text
src/backend_tier_selection.zig
    Startup tier choice consuming cpu_capability_detection + the EFFECTIVE
    record; produces immutable BackendSelection. Pure (no VS). Unit tests:
    auto/explicit-ok/explicit-too-high/invalid.
src/classic_instance_creation.zig
src/deblock4_instance_creation.zig
    Full-signature VSMap extraction; call filter_call_parameters + backend_
    tier_selection; clip-dependent checks (CONSTANT format/dimensions REQUIRED
    per README v1_9 s11.3 - refuse variable clips; planes upper bound; P2 step
    upper bound vs plane dimension); build THIS filter's instance record;
    createVideoFilter(fmParallel) wiring THIS filter's router callbacks.
src/classic_callback_router.zig
src/deblock4_callback_router.zig
    PERMANENT SKELETON ONLY this phase (see the boundary rule below): the real
    getFrame/free entry points and the activation-reason switch, on their
    permanent per-filter home, but each reason branch is a minimal placeholder.
    Settled error messages on refusal (in the creation modules).
```

PHASE 2 / PHASE 3 BOUNDARY (binding - resolves the createVideoFilter question):
the two *_callback_router modules are needed in Phase 2 because createVideoFilter
requires real callback addresses; a throwaway stub would be discarded in Phase
3, which is exactly the churn this phasing avoids. So Phase 2 MAY create the
routers on their PERMANENT path, subject to a strict boundary:
```text
IN PHASE 2 (permanent, kept):
  - the real getFrame and free function signatures and registration wiring;
  - the activation-reason switch STRUCTURE (arInitial / arAllFramesReady /
    arError cases present), on the permanent per-filter router module.
IN PHASE 2 (minimal, replaced in Phase 3 WITHOUT touching the switch):
  - arInitial branch: request the source frame for frame n (the genuine 1C
    behaviour; not throwaway);
  - arAllFramesReady branch: obtain the source frame and return it unmodified
    (pass-through), NO property writes yet, NO tier switch yet;
  - arError branch: minimal error return.
NOT IN PHASE 2 (Phase 3):
  - common_frame_mechanics, common_frame_property_helpers, the per-filter
    frame-property modules, the tier switch body, common_ar_error as its own
    module, lifecycle_trace_debug, deblock4_plugin registration, the sweep,
    build_1C_v1.bat, the .vpy harnesses, and the full proof matrix.
```

Rule of thumb the coder stated and W3D endorses: no PERMANENT Phase-3
implementation, and any seam that IS temporary must be explicit and replaceable
without editing the permanent switch structure. The Phase-3 property/tier work
then slots into the existing branches (the C5 order) rather than restructuring
them. This keeps the createVideoFilter wiring real and permanent from Phase 2.

Phase-2 acceptance: selection unit tests pass; an instance can be constructed,
run (pass-through, no properties), and freed in a Debug e2e smoke; constant-
format refusal proven; the router switch structure is the permanent one (only
the branch bodies are minimal).

STOP after phase 2. Do not begin phase 3 until W3X accepts phase 2.

## Phase 3 - frame path + plugin + sweep + full proof (context now; later)

Modules: the two *_callback_router; classic_/deblock4_ar_initial;
classic_/deblock4_ar_all_frames_ready (binding C5 order); common_ar_error;
common_frame_mechanics; common_frame_property_helpers; classic_/deblock4_
frame_properties; deblock4_plugin (registration); lifecycle_trace_debug;
build_1C_v1.bat; the two tests/stage_1c_*_passthrough.vpy; the scaffolding
sweep (scope s8). Then the FULL proof matrix (B/G/E/S/V/N gates, scope s11).

Phase-3 acceptance: the entire scope s11 matrix passes; W3D independent
artifact verification; coder concurrence; P4 message table ratified; W3X
commits. Stage 1C complete.

## Note

Phases 1 and 2 carry their pure unit tests WITH them (they need no VS core).
The end-to-end and cross-module gates (E1-E6, S1-S3, G1-G2, V1, N1) are
inherently whole-plugin and run at phase 3, as the scope's proof matrix already
implies. This ordering is a delivery convenience, not a change to the proof
obligations: every scope v1.5 gate must still pass at phase 3 before acceptance.

*Revision history*
```text
v1.1 (2026-08-01) Resolved the Phase 2/3 boundary question W3C raised about
     createVideoFilter needing router callbacks: the two *_callback_router
     modules may be created on their PERMANENT path in Phase 2 (real
     getFrame/free + the activation-reason switch STRUCTURE), with minimal
     branch bodies (arInitial requests frame n; arAllFramesReady passes
     through with no properties/tier; arError minimal) that Phase 3 fills in
     WITHOUT restructuring. Avoids a throwaway stub. No scope/design change;
     delivery-boundary clarification only.
v1.0 (2026-08-01) Initial phased delivery plan for scope v1.5. Delivery order
     only; no design change.
```
