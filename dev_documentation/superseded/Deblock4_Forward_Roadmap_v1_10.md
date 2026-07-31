# Deblock4 - Forward Roadmap

**Version:** 1.10
**Date:** 2026-07-31
**Status:** Orientation only; not controlling; not a coding scope. Aligned to the current charter and README (see those documents for their versions).
**Author:** W3D designer
**Encoding:** US-ASCII only

---

# Purpose

This roadmap names the next few bounded steps so W3X and the coder can see the
arc. It is orientation only. Only ONE active coding scope is issued at a time,
and each scope is authored against the actual repository state at its start, not
against this roadmap.

Status (v1.10): Stages 1A, 1A.1, 1B.1, 1B.2 and 1B.3 are COMPLETE and committed.
The filter-creation stage (VS entry point, scaffolding sweep, dispatch wiring) is
now active.

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

Filter stage ACTIVE - the VapourSynth entry point, the scaffolding sweep
             (retiring probe/smoke/dll_probe files per C-STY-10), and dispatch
             wiring that CONSUMES the EFFECTIVE record 1B.3 proved. No gated
             backend arithmetic yet (G5 governs until the 2C/2D scalar oracle).

Per-filter algorithm stages then run Classic first, then Deblock4:

Stage 2C     Classic scalar oracle + HolyWu external-reference differential
             harness (faithful HolyWu incl. luma-on-chroma; no grid_mode,
             no midpoint, no Schedule A/B).
Stage 3C     Classic compatibility/quality gate (short; no open algorithm
             decision).
Stage 4C     Classic v2 (SSE4.1-class) backend + differential proof.
Stage 5C     Classic v3 (AVX2-class) backend + differential + performance proof.

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
    multi-object STRUCTURE; 1B.2 confirms it stays in-bounds. The runtime guard
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
- Each scope authored against the real HEAD at its start, verified cold.
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
- R78 is the current external-header baseline. API 4.2 remains the pinned
  contract.
- "backend" means one filter's scalar/v2/v3 implementation; a second algorithm
  is a second filter with its own backends and oracle.
- Delivery follows C-DELIV-01..08. Only W3X builds, runs, commits.
```

---

v1.6 (2026-07-29): replaced the circular "no deblocking code until the oracle
exists" standing constraint with the oracle-construction exception and the
post-oracle per-type validation rule (audit C2; see decisions section 20).
Aligned version references to charter v1.15 / README v1.8.

v1.8 (2026-07-29): de-versioned the two incidental README cites (aligned-to line
and "See README") to section/document references so they no longer cascade on
README revisions. No arc change.
v1.7 (2026-07-29): cross-reference sync to charter v1.15 / README v1.8 /
decisions v1.7 (incl. the final-package-review README pointer fix). No arc change.

*This roadmap is informative. The charter and README prevail. Each stage
becomes real only as a formal coding scope issued against the actual repository
state at that time.*
