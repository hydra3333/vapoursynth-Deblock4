# Deblock4 - Project Status

**Version:** 1.0
**Date:** 2026-07-25
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
README_Deblock4_Design_Spec_v1.1.md
    controlling technical and algorithmic design specification

AI_Charter_and_Invariants_Card_v1.5.md
    controlling invariants, roles, coding standards, and process rules

Concise_Project_Summary_v1.0.md
    concise orientation and user-facing companion

Deblock4_Project_Status_v1.0.md
    current implementation/proof state and next-step record
```

Where this status document conflicts with the README specification or charter,
the README specification and charter prevail.

Before a W3C session begins, W3X verifies that each controlling document's
filename version agrees with the version recorded inside the document.

---

# 2. Evidence basis

The status below records the builds, tests, and repository actions reported by
W3X during the initial Zig 0.16.0 scaffold work.

It does not claim that W3D independently executed the repository. Under the
charter, W3X remains the authority for builds, runs, measurements, commits, and
pushes.

The current scaffold has been reported committed to the repository. The exact
starting commit for the next bounded scope must be recorded in that scope's
session bootstrap header.

---

# 3. Current position

Deblock4 has completed the foundation of Stage 1, but Stage 1 as a whole is not
complete.

Recommended milestone name:

```text
Stage 1A complete - Zig build, Windows DLL, and VapourSynth API4 interop
scaffold proven.
```

The project is not yet a functional VapourSynth deblocking filter. The current
DLL and executables are build, linkage, API-surface, and interop probes.

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
| VapourSynth API selection | API 4.2 explicitly pinned for R76+ headers |
| `VapourSynth4.h` | Translated into a Zig module |
| `VSConstants4.h` | Translated into a Zig module |
| `VSHelper4.h` | Compiled as C through a narrow tested C-ABI bridge |
| Zig-facing helper naming | Settled as `zig_vsh_originalName` for direct compatibility wrappers |
| Zig/C ownership and lifetime policy | Recorded in charter v1.5 |
| Numeric and SIMD helper policy | Recorded in charter v1.5 |
| External-source provenance policy | Recorded in charter v1.5 |

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

The project does not yet have:

- a real VapourSynth plugin entry and registration path;
- a `Deblock4` filter creation function;
- an `arInitial` / `arAllFramesReady` frame path;
- frame allocation or final plane-construction policy;
- the canonical scalar deblocking implementation;
- threshold tables or threshold expansion;
- scalar arithmetic range proofs;
- the ReleaseSafe scalar oracle;
- the independent differential identity and safety harness;
- production scalar, SSE4.1, and AVX2 backend objects in their final structure;
- actual SSE4.1 or AVX2 deblocking kernels;
- frozen vector widths or lane organisations;
- frozen target-feature closures;
- assembly proof for material loads, stores, masking, tails, or gathers;
- CPU and operating-system capability detection;
- per-filter-instance backend resolution;
- frame-property writes;
- quality decisions for Schedule A versus B, midpoint scale, and proper chroma.

No pixel-producing or frame-construction scope, including a copy path, may pass
acceptance before the ReleaseSafe scalar oracle exists and proves identity for
every affected plane.

---

# 6. Stage map

```text
Stage 1 - Zig project / build / dispatch scaffold and spikes
    PASS  Zig project scaffold
    PASS  VS Code and ZLS integration
    PASS  Windows DLL construction and client linkage
    PASS  VapourSynth API4 core/constants translation
    PASS  VSHelper4 C-ABI bridge architecture
    OPEN  final backend object isolation
    OPEN  target-feature closure spikes
    OPEN  assembly inspection
    OPEN  CPU/OS capability detection
    OPEN  per-instance backend resolution and dispatch harness

Stage 2 - Canonical scalar core and proof harness
    NOT STARTED as accepted implementation

Stage 3 - Scalar quality decisions
    NOT STARTED

Stage 4 - SSE4.1 backend and identity proof
    NOT STARTED

Stage 5 - AVX2 backend, identity, and performance proof
    NOT STARTED

Stage 6 - VapourSynth integration and release readiness
    API header/interop groundwork proved; functional integration not started
```

Stage 1 does not block source review, scalar algorithm design, test-vector
authoring, or corpus assembly. It does gate accepted code integration,
executable scalar testing, and backend object/link work.

---

# 7. Recommended next bounded scope

## Stage 1B.1 - backend object isolation and one-DLL linkage

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

Required proof obligations:

1. Generic and scalar code contain no AVX, AVX2, or FMA assumption.
2. The SSE4.1 and AVX2 probes are isolated from generic/dispatch code.
3. All four modules coexist in one DLL.
4. Exported or internal calling conventions are stable.
5. The AVX2 object excludes FMA.
6. No pixel, frame, copy, or deblocking path is introduced.
7. Debug, ReleaseSafe, and ReleaseFast build/test expectations are stated and
   run by W3X.
8. Changed and forbidden files are explicitly bounded in the coding scope.

Implementation acceptance:

```text
The intended multi-object DLL structure builds and links in every required
mode, its non-pixel identity smoke test passes, and generic code remains free
of unsupported feature assumptions.
```

This scope does not freeze the final feature closures or vector widths. Those
remain measurement and code-generation questions for Stage 1B.2.

---

# 8. Following Stage 1 work

## Stage 1B.2 - representative code-generation and feature-closure spikes

Investigate with disposable, non-production probes:

- explicit vector widths by sample type and operation;
- contiguous unaligned load/store lowering;
- lane mask and `@select` lowering;
- narrow-tail strategies;
- scalar-load-and-pack, shuffle, transpose, and gather candidates;
- SSE4.1 and AVX2 target-feature syntax;
- FMA exclusion;
- emitted assembly in relevant build modes.

The purpose is to establish the smallest exact feature closure assumed by each
compiled backend object. `@Vector`, inline loops, and suggested vector lengths
are not proof of generated SIMD instructions.

## Stage 1B.3 - CPU/OS capability record and backend resolution

After compiled feature closures are known:

- detect immutable process/plugin-wide CPU and OS capabilities once;
- include required AVX, OSXSAVE, and XCR0 XMM/YMM-state checks;
- resolve `auto`, `scalar`, `sse41`, and `avx2` once per simulated filter
  instance;
- reject explicitly requested unsupported backends;
- store immutable selected entry points;
- prove that no per-frame capability or backend-choice branch exists.

After Stage 1B is checkpointed, begin Stage 2 with the canonical scalar source
and ReleaseSafe proof harness.

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

The following four-document package is sufficient to move into the next
bounded scope:

```text
Deblock4_Project_Status_v1.0.md
AI_Charter_and_Invariants_Card_v1.5.md
Concise_Project_Summary_v1.0.md
README_Deblock4_Design_Spec_v1.1.md
```

They serve different purposes and should live alongside one another:

| Document | Purpose |
|---|---|
| README design specification | Controlling technical and algorithmic design |
| Charter and invariants card | Controlling invariants, roles, coding, and process |
| Concise project summary | Fast orientation and public-facing summary |
| Project status | Current proof state, open work, and immediate execution sequence |

Before moving ahead, W3X should confirm:

1. the charter's canonical filename and internal version both say v1.5;
2. the README's filename and internal design revision both say v1.1;
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
- feature closures frozen after Stage 1B.2;
- capability/dispatch harness accepted;
- scalar oracle established;
- Schedule A/B quality decision settled;
- SSE4.1 or AVX2 identity proved;
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

Author the bounded W3C coding scope for:

```text
Stage 1B.1 - backend object isolation and one-DLL linkage
```

Use the actual clean-tree starting commit and quote all controlling charter and
README sections on which the scope relies.
