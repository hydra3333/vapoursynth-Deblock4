# Deblock4 - Forward Roadmap

**Version:** 1.21
**Date:** 2026-08-01
**Status:** Orientation only; not controlling; not a coding scope. Aligned to the current charter and README (see those documents for their versions).
**Author:** W3D designer
**Encoding:** US-ASCII only

---

# STALE - IN SCOPE FOR THE T1 CONSOLIDATION SWEEP, NOT YET ADJUDICATED

```text
DO NOT USE THIS DOCUMENT FOR CURRENT SEQUENCING, PROJECT STATE OR ANY MPEG-2
ARCHITECTURE QUESTION.

WHERE TO GO INSTEAD:
    current state ......... Deblock4_Project_Status (section 0, latest)
    MPEG-2 / architecture . Deblock4_MPEG2_Deblocking_Investigation_and_
                            Decided_Architecture (latest) - the ratified
                            single source of truth
    work queue/decisions .. Deblock4_Standing_Task_Register_T_Series (latest)

THIS BANNER IS NOT AN ADJUDICATION. This document has NOT been swept yet. Its
content has not been assessed statement by statement, and nothing in it has
been declared superseded. The banner says only: it is known to contain stale
material, so do not rely on it, and do not treat the absence of a banner
elsewhere as evidence that another document is current.

DO NOT LET THIS BANNER BECOME A REASON TO SKIP THE DOCUMENT during T1. The
recorded incident that caused T1 was a designer skipping a document because
an index called it "fallback general guidance" - a classification believed
instead of checked. A label is a claim to verify, never permission to move on.
```

KNOWN STALE CONTENT IN THIS DOCUMENT, recorded so a reader is not misled:

```text
- the opening status paragraph knows Stage 5C is complete, but the stage arc
  further down still says "Stage 1C ACTIVE" and "Stage 5C NEXT";
- the Stage 2D line still describes "schedules A/B, midpoint, proper chroma"
  as the Deblock4 scalar-core content. MIDPOINT BELONGS TO THE REJECTED
  ARCHITECTURE A;
- B2, Architecture D and the D4-Q14 gate are not mentioned anywhere;
- the "next candidates" list names work that maintenance scopes M1 and M2
  have since completed;
- the header date field (2026-08-01) predates the 5C content the document
  describes.
```

---

# Purpose

This roadmap names the next few bounded steps so W3X and the coder can see the
arc. It is orientation only. Only ONE active coding scope is issued at a time,
and each scope is authored against the actual repository state at its start, not
against this roadmap.

Status (v1.20): Stages 1A..1C (incl. rider 1C.1 using-echo), 2C, 4C AND 5C
are COMPLETE and accepted; identity 0.1.0-dev+5C. The committed 2C scalar
path is the Classic ORACLE; the 4C SSE4.1 (128-bit) and 5C AVX2-class
(256-bit) vector backends are both proven byte-identical to it, both being
the SAME frozen width-generic body at different N. Stage 3C was COLLAPSED
(T-1 deferred to a later quality phase). The Classic vector arc is now
COMPLETE for the ratified tier set: no higher tier is in scope (AVX-512 is
expressly out; K21/C-SIMD-05). MEASURED at 5C and recorded as settled
knowledge: AVX2 is ~1.15x scalar and only ~3% over SSE4.1 on the benchmark
workload, because the vertical path is width-invariant by algorithm and the
filter is substantially memory-bound - width alone is not where remaining
time lives. NO ACTIVE SCOPE. Registered next candidates (W3X releases):
post-5C v2 commentary reconciliation; identifier-cleanup hygiene pass;
deferred quality phase (T-1); the bounded float step; Deblock4 stages 4D/5D.
Current detail: Project Status v1_27 (or later), section 0.

TWO FILTERS, CLASSIC FIRST: the plugin registers two core filters -
deblock4.Classic (H.264, faithful to HolyWu, built FIRST as a known/de-risking
algorithm with an external reference oracle) and deblock4.Deblock4 (the end-goal
MPEG-2 algorithm, built SECOND on proven infrastructure). The Stage 1
infrastructure work is filter-agnostic; the per-algorithm stages run as a
Classic series (2C..5C) first, then a Deblock4 series (2D..5D). See README
section 1.0/20 and Deblock4_Verification_And_Tiering_Decisions sections 8 and 20. The
MPEG-2 filter remains the end goal; Classic-first is a sequencing choice only.

---

# The arc

```text
Stage 1A     COMPLETE - Zig scaffold, Windows DLL, VapourSynth API4 bridge.
Stage 1A.1   COMPLETE - R78 baseline reconciliation (helper-bridge names,
             genuine Debug/ReleaseSafe/ReleaseFast PASS).
Stage 1B.1   COMPLETE - backend object isolation and one-DLL linkage. Generic,
             scalar, SSE4.1, AVX2 non-pixel probe objects compile under separate
             target contracts and link into one DLL; gated markers retained by
             @extern anchors, never called, absent from the PE export table.

Stage 1B.2   COMPLETE - confirmed each object stays WITHIN its named psABI
             level (x86_64_v1/v2/v3 used in full, charter G3), settled the
             AVX/SSE (vzeroupper) question by inspection, and recorded the
             whole-level feature requirements. Standing batch
             build_1B2_v5_REDEVELOPED.bat. Committed.

Stage 1B.3   COMPLETE - runtime capability guard. CPUID/XGETBV detection over
             the Set-A table + Set-B XCR0; whole-level v3->v2->v1 into immutable
             ACTUAL and EFFECTIVE records; the shared config/print skeleton; the
             self-test exe; and a debug-only force-down seam (G10, force-DOWN-
             only). Built and fully proved (v1-only detection object, one
             guarded XGETBV, three-surface G10 absence with live positive
             control, force-down and build-reject matrices, drift perturbation),
             and committed. The comptime cross-check reconciles detection
             membership with Zig std.Target named models (dependency-populated)
             so target and detection share one definition of each level.
             Dispatch wiring and the VS entry point are the filter stage.

Stage 1C ACTIVE  - filter creation, phased (scope v1_5, addendum v1_1).
             Phase 1 (pure foundation) and Phase 2 (tier selection consuming the
             EFFECTIVE record; per-filter instance creation; permanent-skeleton
             callback routers, pass-through) ACCEPTED and COMMITTED. Phase 3a
             (frame path + real deblock4_plugin registration) delivery v1_0
             awaits review/validation/acceptance; Phase 3b is NOT RELEASED
             (scaffolding sweep per C-STY-10, build_1C batch,
             .vpy harnesses, full proof matrix) follows. No gated backend
             arithmetic (G5 governs until the 2C/2D scalar oracle).

Per-filter algorithm stages then run Classic first, then Deblock4:

Stage 2C     Classic scalar oracle + HolyWu external-reference differential
             harness (faithful HolyWu incl. luma-on-chroma; no grid_mode,
             no midpoint, no Schedule A/B).
Stage 3C     COLLAPSED (W3X ruling 2026-08-12). Its only live content was the
             T-1 c0-from-alpha-index quality question, now deferred to a later
             quality/enhancement phase; the acceptance basis it would have set
             is already in force (the committed 2C scalar path is the oracle).
             No 3C identity exists. Superseded by going straight to 4C.
Stage 4C     ACCEPTED 2026-08-13. Classic v2 (SSE4.1-class) backend, proven
             byte-identical to the scalar oracle. Identity 0.1.0-dev+4C.
Stage 5C     NEXT (not yet scoped). Classic v3 (AVX2-class) backend: the SAME
             width-generic vector body at 256-bit + its own tail/edge proof +
             performance proof. Known AVX2 near-edge corruption hazard to be
             made explicit in the scope.

Stage 2D     Deblock4 scalar core and ReleaseSafe oracle: formulas, threshold
             tables, range proofs, footprints, bounds, schedules A/B, midpoint,
             proper chroma, and the differential correctness harness foundation.
Stage 3D     Deblock4 scalar quality decisions and canonical-algorithm freeze.
Stage 4D     Deblock4 v2 backend + differential proof.
Stage 5D     Deblock4 v3 backend + differential + performance proof.

Stage 6      VapourSynth integration, validation matrix, docs, release
             readiness - BOTH filters.
```

---

# Why this ordering

```text
1B.2 after 1B.1
    The named-level tiers are the feature contract, but 1B.2 still CONFIRMS by
    assembly inspection that each object emits nothing outside its level, and it
    produces the exact whole-level feature requirements. 1B.1 proved the
    multi-object STRUCTURE; 1B.2 confirmed it stays in-bounds. The runtime guard
    that enforces those requirements is a 1B.3 artifact, not a 1B.2 one.

1B.3 after 1B.2
    Capability detection must check exactly the named levels the objects target,
    as whole levels. Confirming in-level emission first keeps detection honest.

Classic before Deblock4
    Classic is a known algorithm with HolyWu as an external reference oracle, so
    building it first proves the shared infrastructure and the differential
    harness (and the R76/G9 miscompile guard, to which Classic's 4-pixel grid is
    the higher-exposure case) before the novel MPEG-2 algorithm is attempted.

Stage 2C/2D gated on Stage 1, not blocked by it
    Scalar algorithm design, source review, and test-vector authoring may
    proceed in parallel and do not depend on the dispatch scaffold. Only
    accepted code integration and backend work wait for Stage 1B.
```

---

# Standing constraints across all stages

```text
- One active coding scope at a time.
- Each scope authored against the base confirmed with W3X at its start
  (charter v1.27+ C-DELIV-01; no commit ids), verified cold.
- Oracle sequencing (charter G7; Deblock4_Verification_And_Tiering_Decisions 20):
  after a filter's ReleaseSafe scalar oracle exists, no pixel, frame-construction,
  copy, or backend code is ACCEPTED for that filter until differentially
  validated against that oracle (per-type: integer byte-identical; float within
  the differential contract; pure copy/share byte-identical). ORACLE-CONSTRUCTION
  EXCEPTION: the first bounded Stage 2C/2D scope that CONSTRUCTS the oracle is
  exempt from comparison against a pre-existing oracle (it creates it) and is
  accepted against independently authored scalar obligations plus a loose
  whole-image sanity gate. (This replaces the earlier circular "no deblocking
  code until the oracle exists" wording, which forbade writing the very code
  that becomes the oracle.)
- G5: no v2/v3 backend EXECUTION before a proven whole-level capability guard.
- The VSHelper4.h C-ABI bridge arrangement is preserved; direct translation is
  not reopened without a separately ratified scope.
- The R78-era in-tree API4 headers remain the COMPILE contract (API 4.2
  pinned); the portable RUNTIME is R79.
- "backend" means one filter's scalar/v2/v3 implementation; a second algorithm
  is a second filter with its own backends and oracle.
- Delivery follows C-DELIV-01..11. Only W3X builds, runs, commits.
```

---

v1.17 (2026-08-02): RIDER 1C.1 accepted and committed (using echo live); next
bounded step is Stage 2C. No arc change.

v1.16 (2026-08-02): STAGE 1C COMPLETE (delivery v1_13 accepted; matrix fully
green). No arc change.

v1.15 (2026-08-02): Phase 3a accepted/committed; 3b debugged to v1_12-applied;
one open G6 export finding; Resume Brief prevails. No arc change.

v1.14 (2026-08-01): Phase 3a state advanced to delivery-in-review (v1_0 exists,
awaiting W3D review / W3X validation / W3X acceptance; 3b not released). No arc
change.

v1.13 (2026-08-01): advanced status to Stage 1C mid-flight - Phases 1 and 2
accepted and committed, Phase 3a about to be reviewed. No roadmap/design
change; status currency only.

v1.12 (2026-07-31): corrected the inline status-line label (said v1.10; now
matches the document version) - a coder-review catch. Version bumped per
immutable-version discipline (v1.11 was already exchanged). No arc change.

v1.11 (2026-07-31): repaired the revision history (added the missing v1.9 and
v1.10 entries and reordered newest-first). No arc change from v1.10.

v1.10 (2026-07-31): Stage 1B.3 marked COMPLETE and committed; the filter-creation
stage marked ACTIVE (VS entry point, scaffolding sweep, dispatch wiring
consuming the EFFECTIVE record). Status line advanced. Charter references to
v1.19.

v1.9 (2026-07-31): Stage 1B.2 marked COMPLETE; Stage 1B.3 marked ACTIVE for the
scope/delivery round. Charter references advanced toward v1.19.

v1.8 (2026-07-29): de-versioned the two incidental README cites (aligned-to line
and "See README") to section/document references so they no longer cascade on
README revisions. No arc change.

v1.7 (2026-07-29): cross-reference sync to charter v1.15 / README v1.8 /
decisions v1.7 (incl. the final-package-review README pointer fix). No arc change.

v1.6 (2026-07-29): replaced the circular "no deblocking code until the oracle
exists" standing constraint with the oracle-construction exception and the
post-oracle per-type validation rule (audit C2; see decisions section 20).
Aligned version references to charter v1.15 / README v1.8.

*This roadmap is informative. The charter and README prevail. Each stage
becomes real only as a formal coding scope issued against the actual repository
state at that time.*

# Revision note

v1.20 (2026-08-15) Stage 5C accepted: status paragraph advanced to the
5C-complete position, identity 0.1.0-dev+5C, the Classic vector arc recorded
as complete for the ratified tier set, and the measured AVX2 benefit recorded
as settled knowledge with its design explanation.
v1.19 (2026-08-14) Currency of the retained body (W3C orientation Q3): the
v1.17 status paragraph replaced with the current v1.19 status; "real HEAD"
constraint reworded to the confirmed-base model; R78/R79
compile-vs-runtime distinction stated; C-DELIV range extended to ..11.
v1.18 (2026-08-13) Annotated the Classic stage line for the post-4C reality:
Stage 3C collapsed (T-1 deferred), Stage 4C accepted, Stage 5C is next. The 2D
and later stages are unchanged.

---

*Revision history addendum*
```text
v1.21 (2026-08-18) Staleness banner applied per the ratified decision DEC-05,
     which approved it and which had gone undischarged. NO CONTENT WAS
     ADJUDICATED, changed or retired: the banner records that the document is
     known stale and in scope for the T1 sweep, and explicitly states that it
     is not an adjudication and not permission to skip the document.
```
