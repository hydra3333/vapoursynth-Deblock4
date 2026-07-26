# Deblock4 - Coding Scope: Stage 1B.1 Backend Object Isolation and One-DLL Linkage

**Version:** 1.1
**Date:** 2026-07-25
**Status:** Active coding scope for W3C. Controlling for this scope only.
**Author:** W3D designer
**Encoding:** US-ASCII only
**Revision note:** v1.1 sets the real post-1A.1 starting commit; replaces the
earlier export-based presence/disassembly proof with a structural G5 proof
(object presence by linker map or .obj symbols; non-execution by
non-reachability, not by disassembly); names dumpbin via VsDevCmd; adds the
three-bucket expected-final-status model; confirms extension of the existing
Deblock4.dll.

---

# Session bootstrap header

```text
Project:
    Deblock4

Charter:
    filename          AI_Charter_and_Invariants_Card_v1_8.md
    internal version  1.8

Controlling specification:
    filename          README_Deblock4_Design_Spec_v1.1.md
    internal revision Design specification revision: 1.1

Repository:
    https://github.com/hydra3333/vapoursynth-Deblock4

Branch:
    main

Starting commit:
    8b6779c4d39d96622825e0454e1cc23974de4a9a
    (the accepted Stage 1A.1 R78 baseline; verify clean tree at this commit)

Active scope:
    Stage 1B.1 - prove generic, scalar, SSE4.1, and AVX2 non-pixel probe
    objects compile under separate target contracts and coexist in the one
    existing Windows x64 Deblock4.dll, with SSE4.1/AVX2 code linked and its
    presence proved, but never exported, called, or otherwise reachable.

Permitted changed files:
    build.zig
    src/backend_probe_generic.zig            (new)
    src/backend_probe_scalar.zig             (new)
    src/backend_probe_sse41.zig              (new)
    src/backend_probe_avx2.zig               (new)
    src/backend_isolation_smoke_test.zig     (new)
    (new-file names may be adjusted by W3C if it states the change in its
     delivery manifest and keeps them consistent across build.zig and the
     smoke test. The EXISTING scaffold sources listed below must not change.)

Forbidden changed files:
    build.zig.zon, third_party/**, .vscode/**, all documents, and the existing
    scaffold sources:
        src/build_probe.zig
        src/dll_probe.zig
        src/dll_smoke_test.zig
        src/vapoursynth_api4.h
        src/vapoursynth_header_probe.zig
        src/vapoursynth_helper_bridge.c

Retained non-source artifacts permitted in the phase commit (not scope
"implementation" files, but legitimately committed for traceability; see
section 10):
    the phase patch file
    build_1B1.bat (the stage validation utility)

Inputs supplied:
    the repository at commit 8b6779c (clean tree, verified by W3X);
    the R78 headers under third_party/vapoursynth/include/;
    this scope;
    charter v1.8 and README v1.1 as controlling references;
    the working build_1B1.bat environment/setup head already drafted by W3X.

Required validation:
    the commands in section 7, run by W3X from a shell where build_1B1.bat has
    established the VsDevCmd environment so dumpbin resolves.

Expected result:
    the one Deblock4.dll builds in Debug, ReleaseSafe, ReleaseFast, now
    containing four backend probe objects;
    the existing scaffold regression checks still pass (build probe, header
    probe API 4.2, existing DLL smoke test 0x44423401, unit tests);
    the new backend-isolation smoke test confirms generic and scalar markers
    execute and returns its expected value;
    the SSE4.1 and AVX2 objects are proved retained in the DLL by structural
    evidence (section 6), and proved non-reachable (not exported, not called,
    not referenced by any startup path);
    git diff --check clean; only permitted files and retained artifacts present.

Known open measurement gates:
    feature closures, vector widths, lane layouts, load/store forms, and
    FMA-exclusion-by-assembly are Stage 1B.2 results and are NOT settled here.

Implementation acceptance for this scope:
    see section 8.
```

Verify the branch and starting commit before changing anything. If the tree is
not clean at 8b6779c, stop and report.

---

# 1. Objective

Prove the multi-object backend STRUCTURE: that four separately-targeted,
non-pixel probe objects compile and link into the one existing Windows x64
Deblock4.dll, that the generic baseline is not contaminated by gated
instructions, and that no path can reach SSE4.1 or AVX2 code before a capability
guard exists (Stage 1B.3).

This is a structural and linkage proof. It is not a feature-closure decision, a
SIMD-behaviour proof, or anything to do with pixels.

---

# 2. Extend the existing DLL - do not create a second one

The current build.zig builds one dynamic library:

```text
addLibrary(.name = "Deblock4", .linkage = .dynamic,
           root_source_file = src/dll_probe.zig)
```

Stage 1B.1 EXTENDS this same Deblock4.dll so that the four backend probe objects
are compiled under their own target contracts and linked into it. A separate
probe DLL would prove a different architecture and weaken the intended one-DLL
linkage result; do not create one.

How the four objects are expressed (separate modules/objects linked into the
existing library, versus Zig's mechanism for per-object target settings) is an
implementation question for W3C to solve within build.zig, consistent with
README sections 11 and 12. State the chosen mechanism in the delivery manifest.

---

# 3. Scope boundary - what must NOT appear

```text
No deblocking arithmetic.
No frame construction or plane copy.
No real VapourSynth frame processing (arInitial/arAllFramesReady).
No threshold tables.
No SIMD PIXEL kernels.
No CPU capability detection (that is Stage 1B.3).
No final dispatch policy (that is Stage 1B.3).
No change to the existing scaffold sources or the interop bridge.
No freezing of feature closures, vector widths, or lane layouts.
No EXPORT of any SSE4.1 or AVX2 function (see section 5).
```

Each probe object exists only to establish presence and isolation. Its identity,
where it has one, is a trivial value, not computed pixel work.

---

# 4. Provisional targets only

Provisional per-object target settings are permitted solely to construct the
objects and MUST be labelled provisional in comments. They are NOT a Stage 1B.2
closure decision and must not be presented as one. Do not use x86_64_v3 as the
AVX2 target (it includes FMA; README 12.3). The provisional AVX2 target excludes
FMA.

```text
generic probe object   baseline; no gated features; may execute
scalar probe object    baseline; no gated features; may execute
SSE4.1 probe object    provisional SSE4.1 target; NOT exported, NOT called
AVX2 probe object      provisional AVX2 target, FMA excluded; NOT exported,
                       NOT called
```

---

# 5. G5 is the governing invariant - the proof is STRUCTURAL

Quoted so the memoryless coder works from the text:

```text
G5  A backend's instructions are never EXECUTED on a machine not yet proven
    to support them.

    Compiling and LINKING a backend object into the DLL is safe by itself:
    an object's mere presence executes nothing.

    ... NO BYPASS. There is no manual, command-line, environment-variable,
    build-flag, or "this machine is known to support it" route that permits
    calling target-specific code without the guard having run and passed. ...

    UNGUARDED EXECUTION PATHS ARE EXECUTION. Presence in the DLL is safe only
    if NO unguarded path can reach target-specific instructions. That includes,
    and is not limited to, static initialisers, registration paths, import
    thunks, and test calls. ...
```

## 5.1 Do NOT export the SSE4.1 or AVX2 probe functions

An exported target-specific function is a public, callable entry point into the
DLL. Before the Stage 1B.3 capability guard exists, an external caller could
invoke it on a machine lacking the feature, faulting - exactly the bypass G5
forbids. Therefore the SSE4.1 and AVX2 probe functions are NOT exported, NOT
called by any generic/scalar code, and NOT referenced by any DLL-load, static
initialiser, registration, or import-thunk path.

## 5.2 Prove presence WITHOUT a callable entry point

"Present and linked" must be shown by evidence that does not open a reachable
path:

```text
PREFERRED  a linker map for Deblock4.dll showing each backend object was
           retained in the link (each object's symbol appears in the map).

FALLBACK   dumpbin /SYMBOLS on the intermediate backend .obj files, plus
           evidence the linker consumed them, if a map is impractical under
           Zig 0.16.

DATA-ONLY  a non-executable, read-only data marker per backend, retained by
           reference from generic/scalar code, read WITHOUT executing any
           target-specific instruction. If used, the marker must contain no
           gated code and its retention path must be generic/scalar only.
```

W3C chooses one, states which in the delivery manifest, and explains why it does
not create a reachable execution path. If Zig 0.16 cannot emit a link map, say
so and use the fallback rather than inventing a target-specific export.

## 5.3 Prove non-execution STRUCTURALLY, not by disassembly

`dumpbin /DISASM` shows which instructions are PRESENT. It does not show whether
any path can REACH them, so it does not by itself prove non-execution. The G5
non-execution proof is the following structural evidence:

```text
- no SSE4.1 or AVX2 function is exported (dumpbin /EXPORTS shows only
  generic/scalar/existing entry points, none target-specific);
- no generic or scalar code calls a target-specific function;
- no DLL-load, static-initialiser, registration, or import-thunk path
  references target-specific code;
- the new smoke test invokes generic/scalar code only;
- target-object presence and linkage are shown separately, per 5.2.
```

`dumpbin /DISASM` may be included as SUPPLEMENTARY inspection (useful later for
1B.2 code-generation work), but it is not the basis for the non-execution
conclusion.

---

# 6. Windows inspection tooling

The environment is established by `build_1B1.bat` calling VsDevCmd:

```text
CALL "C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
```

after which `dumpbin` resolves via PATH (currently to the MSVC 14.51.x
Hostx64\x64 build). Do not hard-code the MSVC version; rely on VsDevCmd
selecting the current toolset, and have the batch verify `where dumpbin` before
use, as the drafted setup head already does.

Inspection commands the scope relies on (W3C states the exact final forms in the
delivery manifest, and which artifact each runs against):

```text
dumpbin /EXPORTS zig-out\bin\Deblock4.dll
    proves NO target-specific function is exported (section 5.3).

linker map for Deblock4.dll   (preferred presence evidence, section 5.2)
    or dumpbin /SYMBOLS on the backend .obj files   (fallback)
    proves each backend object was retained in the link.

dumpbin /DISASM zig-out\bin\Deblock4.dll   (supplementary only)
    inspection aid; not the non-execution proof.
```

"It built" does not close the inspection obligation (charter C-DELIV-07). W3C
states each exact command; W3X runs them and reports output.

---

# 7. Validation, run by W3X

The existing build_1B1.bat setup head establishes the VsDevCmd environment,
verifies dumpbin, restores the working directory, checks git state, and wipes
.zig-cache and zig-out for a cold build. After that, for each MODE in
{Debug, ReleaseSafe, ReleaseFast}:

```text
zig build -Doptimize=<MODE>
zig build run -Doptimize=<MODE>              (existing build probe: PASS)
zig build vs-header-run -Doptimize=<MODE>    (existing header probe: API 4.2)
zig build test -Doptimize=<MODE>             (existing unit tests)
zig-out\bin\deblock4_dll_smoke_test.exe      (existing DLL smoke: 0x44423401)

<the new build step(s) that build the four-object Deblock4.dll>
<the new backend-isolation smoke test: generic/scalar markers execute and
 return the expected value; no target-specific code is called>
```

After the three modes, the structural G5 inspection (once is sufficient, on a
representative built DLL, but state which mode's artifact):

```text
dumpbin /EXPORTS zig-out\bin\Deblock4.dll
<presence evidence: linker map, or dumpbin /SYMBOLS on backend .obj files>
dumpbin /DISASM zig-out\bin\Deblock4.dll    (supplementary, optional to retain)

git diff --check
git status --short
```

Expected:

```text
- the DLL builds in all three modes with four backend probe objects retained;
- all existing scaffold regression checks still pass;
- the new backend-isolation smoke test passes, executing generic/scalar only;
- dumpbin /EXPORTS shows NO target-specific export;
- presence evidence shows both SSE4.1 and AVX2 objects retained in the link;
- git diff --check clean; git status --short shows only permitted files
  (and the retained phase artifacts once committed).
```

W3C reviews W3X's actual output before recommending PASS. Only W3X commits.

The exact final body of build_1B1.bat is completed by W3C AFTER this patch is
accepted by W3D, and W3C then tells W3X precisely what to change in the drafted
batch (its per-mode body and the dumpbin inspection block), preserving the
environment-setup head W3X has already written.

---

# 8. Implementation acceptance

```text
Generic, scalar, SSE4.1, and AVX2 non-pixel probe objects are built under
isolated target contracts and coexist in the one existing Deblock4.dll.
Generic and scalar probes execute and return their identity markers via the new
backend-isolation smoke test, which invokes only generic/scalar code.

The SSE4.1 and AVX2 objects are proved RETAINED in the link by structural
evidence (linker map or intermediate-object symbols), and proved NON-REACHABLE:
not exported (dumpbin /EXPORTS), not called by generic/scalar code, and not
referenced by any DLL-load, static-initialiser, registration, or import-thunk
path.

The existing scaffold regression checks (build probe, header probe API 4.2,
existing DLL smoke test 0x44423401, unit tests) still pass in all three modes.

No pixel, frame, copy, deblocking, capability-detection, or final dispatch path
is introduced; no feature closure, vector width, or lane layout is frozen; no
target-specific function is exported or called.
```

Deferred explicitly to later stages:

```text
- exact SSE4.1 and AVX2 feature closures, by assembly inspection   -> 1B.2
- FMA-exclusion proved by emitted assembly                          -> 1B.2
- vector widths, lane layouts, load/store forms                     -> 1B.2
- CPU/OS capability detection and the guard that permits execution  -> 1B.3
- per-instance backend resolution and dispatch                      -> 1B.3
```

---

# 9. Controlling passages to apply

Beyond G5 (section 5), the coder actively applies:

```text
G2   generic and dispatch code contain no AVX2 instructions; the generic and
     scalar objects and the smoke test build and run on any x86-64.

A3, G3, P-03   nothing untested becomes normative; provisional targets are
     labelled provisional; no architecture level (x86_64_v2/v3) is frozen;
     x86_64_v3 is not used as the AVX2 target (FMA).

C-INT-04   if any Zig-facing C compatibility wrapper is introduced, it takes
     zig_ + the exact original name and carries the required comment. (Not
     expected in this scope, but the rule stands if wrapper code appears.)

C-SIMD-01, C-SIMD-02   vector syntax and helper names are not proof of emitted
     instructions; keep probes trivial and prove structure, not codegen.

C-DELIV-02..05   new files delivered whole; the build.zig change delivered as
     an anchor-verifiable patch citing base commit 8b6779c; a delivery manifest
     lists each file, its state, and its form; do not hand-edit a failing patch.

README sections 11 (module architecture, esp. 11.11 sse41, 11.12 avx2, 11.13
     backend_api, 11.15 dispatch - as the INTENDED final shape) and 12 (one-DLL
     dispatch, 12.1/12.2/12.3) - this scope builds PROBES toward that shape,
     not the final modules.
```

---

# 10. Expected final status model (three buckets)

Per agreed project policy, the phase's final status distinguishes:

```text
Scoped implementation files (authorised by this scope):
    build.zig
    src/backend_probe_generic.zig
    src/backend_probe_scalar.zig
    src/backend_probe_sse41.zig
    src/backend_probe_avx2.zig
    src/backend_isolation_smoke_test.zig
    (final new-file names per the delivery manifest)

Retained delivery artifact:
    the Stage 1B.1 phase patch file

Reusable W3X validation utility:
    build_1B1.bat (this stage's validation batch)
```

The commit legitimately contains the retained patch and the batch in addition to
the scoped source files. The project record describes this accurately rather
than claiming only the source files were committed.

---

# 11. Coder's first response

Before delivering code, W3C returns a compact orientation check per the coder
introduction: documents and versions received; controlling vs informative;
current milestone (Stage 1A.1 accepted; 1B.1 active); starting commit 8b6779c on
a clean tree; the G5 consequence that SSE4.1/AVX2 are linked and their presence
proved structurally but never exported, called, or reached; and any mismatch or
ambiguity blocking work.

---

*This scope is controlling for Stage 1B.1 only. The charter and README prevail
where they differ. W3X builds, runs, and commits; W3C delivers and reviews the
actual results before recommending a commit. After W3D accepts the patch, W3C
specifies the exact build_1B1.bat body changes to W3X.*
