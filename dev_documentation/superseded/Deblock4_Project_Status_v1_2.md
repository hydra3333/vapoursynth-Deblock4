# Deblock4 - Project Status

**Version:** 1.2
**Date:** 2026-07-28
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
README_Deblock4_Design_Spec_v1.2.md
    controlling technical and algorithmic design specification

AI_Charter_and_Invariants_Card_v1_10.md
    controlling invariants, roles, coding standards, and process rules
    (v1.9 added invariant G6; v1.10 revised its gated-code corollary after
     empirical falsification: the ban is on PE-EXPORT, not on the Zig export
     keyword. See Deblock4_Toolchain_Findings for the evidence.)

Deblock4_Concise_Project_Summary_v1.0.md
    concise orientation and user-facing companion

Deblock4_Forward_Roadmap_v1_1.md
    informative forward stage sequence

Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
    informative research record behind the G6 retention/export decision

Deblock4_Toolchain_Findings_v1_1.md
    informative durable record of empirical Zig/linker facts (F1-F5):
    emission is per compilation unit; cross-compilation references do not
    force emission; object-mode export fn does not PE-export; the proven
    multi-feature-level dispatch idiom

Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md
    informative consolidated MPEG-2 grid / frame-vs-field-DCT knowledge

Deblock4_Project_Status_v1_2.md
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

Deblock4 has completed the Stage 1 foundation and the Stage 1A.1 R78 baseline
reconciliation, but Stage 1 as a whole is not complete.

Milestone:

```text
Stage 1A complete   - Zig build, Windows DLL, VapourSynth API4 interop scaffold.
Stage 1A.1 complete - helper-bridge names reconciled (zig_vsh_* wrappers,
                      deblock4_vsh_bridge_self_test), stale R76 wording
                      corrected, genuine R78 build baseline re-established and
                      accepted. Accepted commit:
                      8b6779c4d39d96622825e0454e1cc23974de4a9a
                      (verify current HEAD before the next scope).
```

The project is not yet a functional VapourSynth deblocking filter. The current
DLL and executables are build, linkage, API-surface, and interop probes.

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
| Zig/C ownership and lifetime policy | Recorded in charter (current v1.9) |
| Numeric and SIMD helper policy | Recorded in charter (current v1.9) |
| External-source provenance policy | Recorded in charter (current v1.9) |

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
    PASS  Stage 1A.1 R78 baseline reconciliation (accepted, committed)
    PASS  Stage 1B.1 backend object isolation and one-DLL linkage (scope
          v1.7; accepted and committed)
    ACTIVE 1B.2 target-feature closure spikes and assembly inspection
    OPEN  CPU/OS capability detection (1B.3)
    OPEN  per-instance backend resolution and dispatch harness (1B.3)

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

# 7. Most recently completed bounded scope

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
5. The AVX2 object excludes FMA.
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
Deblock4_Project_Status_v1_2.md
AI_Charter_and_Invariants_Card_v1_10.md
Deblock4_Concise_Project_Summary_v1.0.md
README_Deblock4_Design_Spec_v1.2.md
Deblock4_Forward_Roadmap_v1_1.md
Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
111_New_Chat_Introduction_for_Coder_v1_2.md
Deblock4_Scope_Stage_1B1_Backend_Object_Isolation_v1_3.md
```

They serve different purposes and should live alongside one another:

| Document | Purpose |
|---|---|
| README design specification | Controlling technical and algorithmic design |
| Charter and invariants card | Controlling invariants, roles, coding, and process |
| Concise project summary | Fast orientation and public-facing summary |
| Project status | Current proof state, open work, and immediate execution sequence |

Before moving ahead, W3X should confirm:

1. the charter's canonical filename and internal version both say v1.9;
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

Stage 1B.2 - target-feature closure spikes and assembly inspection.

Determine the exact SSE4.1 and AVX2 feature closures by compiling and
INSPECTING GENERATED ASSEMBLY rather than by assumption, and settle the
AVX/SSE transition question (README section 12.7, vzeroupper) by inspection.
The feature closures remain deliberately open until this stage produces them.

Stage 1B.2 requires no new retention machinery: the four-object structure and
the baseline-target contract proved in Stage 1B.1 are exactly what it inspects.

Starting point: the accepted Stage 1B.1 commit on branch main (verify the
current HEAD before issuing the scope).

