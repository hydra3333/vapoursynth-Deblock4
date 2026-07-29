# Deblock4 - Forward Roadmap

**Version:** 1.6
**Date:** 2026-07-29
**Status:** Orientation only; not controlling; not a coding scope. Aligned to charter v1.14, README v1.7.
**Author:** W3D designer
**Encoding:** US-ASCII only

---

# Purpose

This roadmap names the next few bounded steps so W3X and the coder can see the
arc. It is orientation only. Only ONE active coding scope is issued at a time,
and each scope is authored against the actual repository state at its start, not
against this roadmap.

Status (v1.6): Stages 1A, 1A.1 and 1B.1 are COMPLETE and committed. Stage 1B.2
is the active next stage.

TWO FILTERS, CLASSIC FIRST: the plugin registers two core filters -
deblock4.Classic (H.264, faithful to HolyWu, built FIRST as a known/de-risking
algorithm with an external reference oracle) and deblock4.Deblock4 (the end-goal
MPEG-2 algorithm, built SECOND on proven infrastructure). The Stage 1
infrastructure work is filter-agnostic; the per-algorithm stages run as a
Classic series (2C..5C) first, then a Deblock4 series (2D..5D). See README v1.6
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

Stage 1B.2   ACTIVE - confirm each object stays WITHIN its named psABI level.
             The tiers are the named levels x86_64_v1/v2/v3 used in full
             (charter G3); the level IS the feature contract, not a bespoke
             closure. 1B.2 confirms each object emits nothing outside its level
             and settles the AVX/SSE
             transition (vzeroupper) question by inspection. No new retention
             machinery; it inspects the Stage 1B.1 structure.

Stage 1B.3   CPU/OS capability detection and guarded whole-level dispatch.
             Immutable global capability record; per-instance backend
             resolution selecting the highest fully-satisfied level with
             v3->v2->v1 fallback; the guard that finally permits calling the
             v2/v3 backends. Prefer Zig std.Target level-satisfaction so target
             and detection share one definition of each level.

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
Aligned version references to charter v1.14 / README v1.7.

*This roadmap is informative. The charter and README prevail. Each stage
becomes real only as a formal coding scope issued against the actual repository
state at that time.*
