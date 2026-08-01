# Deblock4 - Stage 1C Phase 3a Designer Briefing

**Version:** 1.1
**Date:** 2026-08-01
**Author:** W3D
**Status:** Informative review guidance for the Phase 3a delivery. NOT a scope
and NOT a rule change: it consolidates the accumulated clarifications from the
Phase 2 -> Phase 3a arc that are not already clean in the scope or addendum, so
a designer reviewing Phase 3a has them in one place rather than reconstructing
them. On any conflict, the scope and charter govern.
**Encoding:** US-ASCII; CRLF.

## PHASE 3a REVIEW SET - READ AS A SET (charter 2.3a)

This document is ONE OF THREE that must be read together to review Stage 1C
Phase 3a. The set (use the LATEST filename version of EACH; any member may bump
as guidance accrues):

```text
Phase 3a review set (charter 2.3a version group):
  1. Deblock4_Scope_Stage_1C_Filter_Creation_v1_5.md        (the design authority)
  2. Deblock4_Stage_1C_Delivery_Plan_Addendum_v1_1.md       (phase delivery order + the 2/3 boundary ruling)
  3. Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_1.md   (THIS - accumulated 3a clarifications)
```

Reviewing Phase 3a from fewer than all three is incomplete. If any member is
missing or the set looks internally inconsistent, STOP and ask W3X (charter
2.3a). The scope and addendum are NOT duplicated here; this briefing cites them
and adds only what they do not already state.

## 1. Where Phase 3a sits

Phases 1 and 2 are accepted and committed. Phase 3 is split 3a/3b (a split W3C
proposed pre-emptively and W3D endorsed):

```text
3a (this delivery): the frame path - common_frame_mechanics,
    common_frame_property_helpers, classic_/deblock4_frame_properties, the
    tier-switch bodies in both *_ar_all_frames_ready in the settled C5 order,
    common_ar_error, lifecycle_trace_debug - PLUS real deblock4_plugin
    registration. Ends at a working, loadable, inert pass-through plugin. Stop
    for review.
3b (after 3a accepted): scaffolding sweep (C-STY-10), build_1C_v1.bat, the two
    tests/stage_1c_*_passthrough.vpy harnesses, and the full proof matrix.
```

Rationale for the split (worth preserving): 3a is where the real integration
surprises live (the C-interop that bit Phase 2 recurs here - property writes,
frame mechanics, createVideoFilter and registration actually executing). Get
the frame path solid FIRST, then build the proof harness around it in 3b. You
do not want to discover a frame-path bug through a failing proof gate.

### 1.1 The split is also an anti-stall delivery safeguard

The 3a/3b split was not approved only for architectural neatness. The earlier
attempt to deliver all of Stage 1C in one pass stalled for an unacceptably long
time and consumed excessive working/context budget without producing a usable
delivery. W3X raised that risk explicitly before Phase 3 began; W3D approved the
3a/3b escape valve, and W3X released Phase 3a as the bounded work.

Preserve that operational lesson:

```text
- Do NOT silently recombine 3a and 3b. Phase 3a stops for review.
- Do NOT pull the sweep or full proof-matrix work forward merely because the
  frame path appears complete. Those are Phase 3b and require W3X release.
- If a future released phase again proves too large, identify the problem early
  and propose a smaller reviewable sub-phase BEFORE prolonged work stalls.
- W3C or W3D may recommend a split; W3X alone accepts/releases the resulting
  phase boundary.
```

This is delivery governance, not a change to the Stage 1C design. It exists so
a memoryless future chat does not undo the process correction that allowed
Phases 1 and 2 to complete successfully.

## 2. The three 3a verification points (the load-bearing ones)

These are the specific things to check on the 3a delivery. They come from
clarifications settled with W3X during 3a formulation and are not spelled out
this concretely in the scope/addendum.

### 2.1 The creation callbacks must expose the exact VSPublicFunction C-ABI signature

Real plugin registration surfaced a necessary, mechanical boundary change: the
two creation callbacks (classic_/deblock4_instance_creation.create) must be
declared with the exact translated VSPublicFunction C-ABI parameter types
(the [*c]/optional forms translate-c generates), NOT idiomatic Zig pointers.
This is the SAME correction the router callbacks (getFrame/free) received in
Phase 2 (see the Phase 2 finding on the eight interop errors), applied one
level up to the creation callbacks.

VERIFY: the create signature matches VSPublicFunction exactly AND the create
BODY is unchanged from the accepted Phase 2 version - i.e. a clean
boundary-only diff. If the body logic changed under cover of the signature fix,
that is a flag. The body may bridge the [*c] parameters to idiomatic locals at
the top; the validation/build logic below stays byte-identical.

### 2.2 The permanent activation-reason switch is NOT restructured

Phase 2 deliberately built the callback routers on their PERMANENT path: the
real getFrame/free plus the activation-reason switch STRUCTURE, with minimal
pass-through branch bodies. Phase 3a REPLACES those minimal bodies with the
settled C5-order handlers - it does NOT restructure the switch.

VERIFY: the switch structure in classic_/deblock4_callback_router is unchanged
from Phase 2; only the branch bodies (and the ar_* handler modules they call)
carry the new frame-path work. A restructured switch is a flag - it would mean
the Phase 2 permanent-skeleton contract was broken.

### 2.3 lifecycle_trace_debug is authored IN 3a, and its creation-exit line is complete and one physical line

lifecycle_trace_debug (the third G10 seam, build option enable_trace_lifecycle)
is authored in 3a - built INTO the C5-order handlers as they are written, not
retrofitted in 3b. Its release-absence proof (the G10 three-surface check)
lands in 3b with the rest of the matrix; authoring-in-3a and proving-in-3b is
the correct division.

W3C self-audited and corrected the creation-exit trace line to dump the FULL
resolved instance configuration, not merely dimensions/strength/grid name.

VERIFY three things on the trace: (a) the creation-exit dump is GENUINELY
complete against the instance record (filter kind, selected tier, every
validated parameter, the plane set, resolved grid, midpoint applicability -
"full" in substance, not just in name); (b) it is ONE physical line per record
(charter C-1C-6 flush-per-line / single-line-record discipline - a full config
dump is exactly where a coder might spill to multiple lines); (c) the trace is
debug-only and the production creation/validation body is untouched (the trace
call changes at successful exit; the logic it observes does not).

## 3. The C5 frame-path order (from scope v1.5, restated because 3a implements it)

The scope pins the binding order for *_ar_all_frames_ready (do not re-derive):

```text
1. obtain the requested source frame (common_frame_mechanics);
2. the TIER switch calls the branch target and yields the final writable output
   frame (in 1C every branch calls the shared pass-through placeholder, which
   produces the writable copy);
3. THIS filter's property module annotates that final frame
   (classic_/deblock4_frame_properties);
4. return the final frame.
```

At 2C/2D only the branch targets change; the property/return tail is stable.
VERIFY 3a implements exactly this order - properties are written AFTER the tier
branch yields the output frame, not before (this is the C5 correction from the
architecture review; writing properties before the branch would assume every
future backend returns the same pre-made frame).

## 4. What must NOT appear in 3a (boundary with 3b and with 2C/2D)

```text
- No scaffolding sweep, no build_1C_v1.bat, no .vpy harnesses, no proof matrix
  (all 3b).
- No pixel arithmetic, no algorithmic plane construction, no real
  classic_vN/deblock4_vN backends (2C/2D; G5 governs). Every tier branch calls
  the pass-through placeholder.
- No restructuring of the permanent switch (2.2); no change to the accepted
  Phase 1/2 modules beyond the mechanical creation-callback signature (2.1).
```

## 5. Verification stance (unchanged, restated)

W3D CANNOT run Zig; all review is STATIC against source with file and line.
W3X's toolchain run of the delivery's validation is authoritative. Expect the
same benign Zig `--listen` "failed command:" test-runner artifact seen since
1B.3 (a stderr-writing test that still passes) - judge by exit code and the
absence of `error:`, not by that marker. W3C and W3D provide findings and
recommendations; W3X alone accepts or rejects a phase, releases the next phase,
and commits. A W3C/W3D recommendation to proceed is not itself phase acceptance.

## 6. Provenance note

The material in sections 1-2 was settled in the designer chat during Phase 2
acceptance and Phase 3a formulation, and much of it existed only in that chat's
review turns. This briefing captures it before that chat's context is lost, per
the project's handover discipline. If a later clarification supersedes anything
here, this briefing is version-bumped; use the latest per charter 2.3a.

*Revision history*
```text
v1.1 (2026-08-01) Added the previously unrecorded delivery-governance reason
     for the 3a/3b split: the earlier whole-1C attempt stalled and consumed
     excessive working/context budget, so the split is an intentional anti-
     stall safeguard, not merely convenient sequencing. Recorded that 3a and
     3b must not be silently recombined, that further subdivision should be
     proposed before prolonged work stalls, and that W3X alone accepts/releases
     phases while W3C/W3D advise. Updated this briefing's filename in the review
     set. No design or scope change.
v1.0 (2026-08-01) Initial consolidation of the Phase 2 -> 3a clarifications
     (3a/3b split and rationale; the three verification points -
     VSPublicFunction creation-callback signature with unchanged body,
     unrestructured permanent switch, complete one-line lifecycle trace; the
     C5 order restated; the 3a/3b/2C-2D boundary). Declares the Phase 3a
     review set (scope v1_5 + addendum v1_1 + this briefing) per charter 2.3a.
```
