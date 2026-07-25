# Deblock4 - Forward Roadmap

**Version:** 1.1
**Date:** 2026-07-25
**Status:** Orientation only; not controlling; not a coding scope. Aligned to charter v1.8, README v1.1.
**Author:** W3D designer
**Encoding:** US-ASCII only

---

# Purpose

This roadmap names the next few bounded steps so W3X and the coder can see the
arc. It is orientation only. Only ONE active coding scope is issued at a time,
and each scope is authored against the actual repository state at its start, not
against this roadmap.

A new reconciliation step (Stage 1A.1) has been inserted ahead of Stage 1B.1
because cold inspection of the current source found a defect that must be fixed
before backend-object isolation can begin from a clean baseline. See Stage 1A.1.

---

# The arc

```text
Stage 1A     PREVIOUSLY ACCEPTED - reconciliation required by 1A.1
             Zig scaffold, Windows DLL, VapourSynth API4 interop bridge.
             The committed source does not currently build (name mismatch);
             Stage 1A.1 restores a genuine building baseline.

Stage 1A.1   NEXT - R78 baseline reconciliation
             Fix the helper-bridge name mismatch, correct stale R76 wording,
             and re-establish a genuine R78 Debug/ReleaseSafe/ReleaseFast PASS.
             Small, non-pixel, no new architecture.

Stage 1B.1   Backend object isolation and one-DLL linkage
             Prove generic, scalar, SSE4.1, and AVX2 non-pixel probe objects
             compile under separate target contracts and link into one DLL.
             Generic/scalar may execute; SSE4.1/AVX2 link-and-inspect only (G5).

Stage 1B.2   Representative code-generation and feature-closure spikes
             Disposable probes to establish the smallest exact feature closure
             per backend by assembly inspection. Freezes nothing prematurely.

Stage 1B.3   CPU/OS capability detection and guarded backend dispatch
             Immutable global capability record; per-instance backend
             resolution; the guard that finally permits calling SSE4.1/AVX2.

Stage 2      Canonical scalar core and ReleaseSafe oracle
  (entry)    Begin the executable specification: formulas, threshold tables,
             range proofs, footprints, bounds, schedules A and B, and the
             independent identity/safety harness foundation.
```

---

# Why this ordering

```text
1A.1 before 1B.1
    Backend isolation must start from a scaffold that actually builds. The
    current source does not (see 1A.1). Repairing it inside 1B.1 would mix
    "does the scaffold work" with "do four objects isolate" in one acceptance
    gate; they are separate proofs and must not share one.

1B.2 after 1B.1
    Feature closures and vector widths are assembly-inspection results. 1B.1
    proves the multi-object STRUCTURE using provisional targets; 1B.2 measures
    what each object actually needs. Freezing closures in 1B.1 would violate
    A3 and P-03.

1B.3 after 1B.2
    Capability detection must check exactly the closures 1B.2 establishes.
    Detecting features before knowing which features the objects assume is
    backwards.

Stage 2 gated on 1B, not blocked by it
    Scalar algorithm design, source review, and test-vector authoring may
    proceed in parallel and do not depend on the dispatch scaffold. Only
    accepted code integration and backend work wait for 1B.
```

---

# Standing constraints across all stages

```text
- One active coding scope at a time.
- Each scope authored against the real HEAD at its start, verified cold.
- No pixel, frame-construction, copy, or deblocking code until the ReleaseSafe
  scalar oracle exists (charter; Stage 2).
- G5: no SSE4.1/AVX2 execution before a proven capability guard.
- The VSHelper4.h C-ABI bridge arrangement is preserved; direct translation is
  not reopened without a separately ratified scope.
- R78 is the current external-header baseline. API 4.2 remains the pinned
  contract.
- Delivery follows C-DELIV-01..08. Only W3X builds, runs, commits.
```

---

*This roadmap is informative. The charter and README prevail. Each stage
becomes real only as a formal coding scope issued against the actual repository
state at that time.*
