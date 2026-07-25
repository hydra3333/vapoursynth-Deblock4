# Deblock4 - Coding Scope: Stage 1B.1 Backend Object Isolation and One-DLL Linkage

**Version:** 1.0
**Date:** 2026-07-25
**Status:** Active coding scope for W3C. Controlling for this scope only.
**Author:** W3D designer
**Encoding:** US-ASCII only
**Prerequisite:** Stage 1A.1 must be accepted and committed first. This scope is
authored against the post-reconciliation commit, NOT against 81b04e8.

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
    <W3X FILLS THIS: the commit produced by accepting Stage 1A.1.
     It is NOT 81b04e8. Do not proceed until this is a real, clean-tree
     commit containing the R78 reconciliation.>

Active scope:
    Stage 1B.1 - prove generic, scalar, SSE4.1, and AVX2 non-pixel probe
    objects compile under separate target contracts and coexist in one
    Windows x64 DLL, with SSE4.1/AVX2 code linked and inspected but never
    executed.

Permitted changed files:
    build.zig
    src/backend_probe_generic.zig      (new)
    src/backend_probe_scalar.zig       (new)
    src/backend_probe_sse41.zig        (new)
    src/backend_probe_avx2.zig         (new)
    src/backend_isolation_smoke_test.zig  (new)
    (exact new-file names may be adjusted by W3C if it states the change and
     keeps them consistent across build.zig and the smoke test; the existing
     scaffold files below are NOT permitted to change.)

Forbidden changed files:
    build.zig.zon, third_party/**, .vscode/**, all documents, and the existing
    scaffold sources:
        src/build_probe.zig
        src/dll_probe.zig
        src/dll_smoke_test.zig
        src/vapoursynth_api4.h
        src/vapoursynth_header_probe.zig
        src/vapoursynth_helper_bridge.c

Inputs supplied:
    the repository at the reconciled commit (clean tree, verified by W3X);
    the R78 headers under third_party/vapoursynth/include/;
    this scope;
    charter v1.8 and README v1.1 as controlling references.

Required validation:
    the commands in section 7, run by W3X.

Expected result:
    one Deblock4 DLL builds in Debug, ReleaseSafe, and ReleaseFast, containing
    four backend probe objects;
    the generic and scalar probes execute and return their identity markers;
    the SSE4.1 and AVX2 objects are proved present and linked by symbol/object
    inspection, NOT by execution;
    an inspection step confirms no unguarded path can execute SSE4.1/AVX2 code;
    git diff --check clean; only permitted files changed.

Known open measurement gates:
    feature closures, vector widths, lane layouts, load/store forms, and FMA
    exclusion-by-assembly are Stage 1B.2 results and are NOT settled here.

Implementation acceptance for this scope:
    see section 8.
```

Verify the branch and the reconciled starting commit before changing anything.
If the tree is not clean at that commit, stop and report.

---

# 1. Objective

Prove the multi-object backend STRUCTURE: that four separately-targeted,
non-pixel probe objects compile and link into one Windows x64 DLL without the
generic baseline being contaminated by gated instructions, and without any path
that could execute SSE4.1 or AVX2 code before a capability guard exists.

This is a structural and linkage proof. It is not a feature-closure decision, a
SIMD-behaviour proof, or anything to do with pixels.

---

# 2. Scope boundary - what must NOT appear

```text
No deblocking arithmetic.
No frame construction or plane copy.
No real VapourSynth frame processing (arInitial/arAllFramesReady).
No threshold tables.
No SIMD PIXEL kernels.
No CPU capability detection (that is Stage 1B.3).
No final dispatch policy (that is Stage 1B.3).
No change to the existing scaffold or the interop bridge.
No freezing of feature closures, vector widths, or lane layouts.
```

Each probe object exists only to establish presence and isolation. Its
"identity marker" is a trivial constant return, not computed pixel work.

---

# 3. Required structure

```text
one Deblock4 DLL (extend the existing DLL, or a clearly-named probe DLL if the
existing dll_probe must stay untouched - W3C states which and keeps the existing
DLL probe unchanged):

    generic backend probe object
        target: generic baseline; no gated features
        exports a generic identity marker; may be executed

    scalar backend probe object
        target: generic baseline; no gated features
        exports a scalar identity marker; may be executed

    SSE4.1 backend probe object
        target: a PROVISIONAL SSE4.1-capable setting sufficient to build
        exports a marker SYMBOL; its code is NOT executed in this scope

    AVX2 backend probe object
        target: a PROVISIONAL AVX2-capable setting sufficient to build,
                with FMA excluded
        exports a marker SYMBOL; its code is NOT executed in this scope

one smoke-test executable
    links the DLL
    calls the generic and scalar markers and checks their values
    confirms the SSE4.1 and AVX2 marker symbols are PRESENT (linked) WITHOUT
        calling them
```

Provisional target settings are permitted solely to construct the objects and
MUST be labelled provisional in comments. They are not a Stage 1B.2 closure
decision and must not be presented as one.

---

# 4. G5 is the governing invariant here - apply it strictly

Quoted so the memoryless coder works from the text:

```text
G5  A backend's instructions are never EXECUTED on a machine not yet proven
    to support them.

    Compiling and LINKING a backend object into the DLL is safe by itself:
    an object's mere presence executes nothing.

    Calling into a backend object is permitted only after the immutable
    capability record required by G1 exists and has confirmed the complete
    feature contract required by that object, or after an equivalent explicit
    in-process guard has been proved for the active scope. ...

    NO BYPASS. There is no manual, command-line, environment-variable, build-
    flag, or "this machine is known to support it" route that permits calling
    target-specific code without the guard having run and passed. ...

    UNGUARDED EXECUTION PATHS ARE EXECUTION. Presence in the DLL is safe only
    if NO unguarded path can reach target-specific instructions. That includes,
    and is not limited to, static initialisers, registration paths, import
    thunks, and test calls. ... A static initialiser inside an AVX2 object runs
    at DLL load, before any capability check, and is therefore forbidden from
    containing gated code.
```

Consequences for this scope, which has NO capability guard yet:

```text
- The SSE4.1 and AVX2 probe objects must contain NO code that runs at DLL load.
  No static/comptime initialiser, no constructor, no registration, no import
  thunk may execute their gated instructions.
- Their marker must be retrievable by SYMBOL PRESENCE / linkage inspection, not
  by calling a function that runs gated code. If a marker is a plain exported
  constant with no gated computation, reading its presence is fine; CALLING a
  function that executes SSE4.1/AVX2 instructions is not.
- The smoke test calls only the generic and scalar markers. For SSE4.1/AVX2 it
  verifies the symbol is present and linked, and does not call gated code.
- There is no "the build machine has AVX2 so it is fine" exception.
```

If the coder cannot expose an SSE4.1/AVX2 identity marker WITHOUT executing
gated code, it states this and stops rather than calling the code. Symbol
presence via inspection is the intended mechanism.

---

# 5. Other controlling passages to apply

## 5.1 Charter G2 (generic stays clean)

```text
G2  Generic and dispatch code must contain NO AVX2 instructions. Only the
    AVX2 object may assume them. Dispatch cannot require the feature it is
    detecting.
```

The generic and scalar probe objects must build under a baseline target that
assumes no gated feature, and the smoke test (which runs on any machine) must
link and run without requiring SSE4.1 or AVX2.

## 5.2 Charter G3 / A3 / P-03 (do not freeze closures)

```text
G3  The SSE4.1 and AVX2 objects are compiled for the smallest feature
    closures proven by the Zig 0.16.0 build and assembly spike.
    ... No architecture level such as x86_64_v2 or x86_64_v3 becomes
    normative before the object has compiled and its emitted instructions
    have been inspected.
```

This scope uses PROVISIONAL targets only to construct objects. It does not
establish the final closure, and must not use "x86_64_v3" as an AVX2 target
(it includes FMA; see README 12.3). Provisional AVX2 target excludes FMA.

## 5.3 Charter C-SIMD-01 and C-SIMD-02 (vector syntax is not proof)

```text
C-SIMD-01  Vector syntax is not SIMD proof.
C-SIMD-02  A name like gather is a semantic description, not a codegen claim.
```

Not central here (no pixel SIMD), but relevant if a probe uses any vector type
to force a target-specific object: presence of @Vector proves nothing about
emitted instructions. Keep probes trivial.

## 5.4 Charter C-DELIV-02/03/04/05 (delivery)

New files are delivered whole (C-DELIV-04). The build.zig change is an existing
file with a localised addition, delivered as an anchor-verifiable patch
(C-DELIV-03) citing the reconciled base commit. A delivery manifest (C-DELIV-05)
lists each file, its state, and its form. Do not hand-edit a failing patch.

## 5.5 Charter P-04 (bounded scope)

```text
P-04  ... A subscope must not split the enforcement of a single invariant
      across two scopes.
```

This scope is self-contained: it proves structure and G5 compliance together,
and defers closures to 1B.2 as a clean seam, not a split invariant.

## 5.6 README sections to read in full

The coder reads, and works from, these README sections:

```text
section 11  proposed source/module architecture (esp. 11.11 sse41, 11.12 avx2,
            11.13 backend_api, 11.15 dispatch - for intended final shape;
            this scope builds only PROBES toward that shape)
section 12  compilation and one-DLL runtime dispatch (esp. 12.1 required binary
            shape, 12.2 compile CPU-specific objects separately, 12.3 the
            x86_64_v3/FMA rule)
section 14  validation specification (for the inspection expectations)
```

These are the intended architecture. This scope builds disposable PROBES that
prove the structure is achievable; it does not implement the final modules.

---

# 6. Windows inspection tooling must be named exactly

The SSE4.1/AVX2 "present but not executed" proof requires object/symbol
inspection, not "inspect the binary." W3C states the exact tool and command it
expects W3X to run, choosing from tools available in the coordinator's
environment, for example:

```text
- dumpbin /exports <artifact>           (MSVC toolchain) to list exported
                                         symbols and confirm the four markers
- dumpbin /disasm <object-or-dll>       to show that no gated instruction sits
                                         on a DLL-load or unguarded path
- or the LLVM equivalents llvm-objdump -d / llvm-nm if that is what is installed
```

If W3C is unsure which tool is present, it asks W3X to confirm the available
inspector rather than guessing, and states the command precisely once known.
"It built" does not close the inspection obligation (charter C-DELIV-07).

---

# 7. Validation, run by W3X

```text
git status --short
git rev-parse --short HEAD

zig build -Doptimize=Debug
zig build -Doptimize=ReleaseSafe
zig build -Doptimize=ReleaseFast

<the exact build.zig step(s) that build the four-object DLL and the smoke test>
<run the smoke test: generic and scalar markers correct;
 SSE4.1/AVX2 markers present but NOT called>

<the exact named inspection command(s) from section 6, with their output>

zig build test -Doptimize=Debug
zig build test -Doptimize=ReleaseSafe
zig build test -Doptimize=ReleaseFast

git diff --check
git status --short
```

Expected:

```text
- the DLL builds in all three modes with four backend probe objects present;
- generic and scalar markers execute and return expected values;
- SSE4.1 and AVX2 marker symbols are present and linked;
- inspection confirms no unguarded path executes gated instructions;
- tests pass; git diff --check clean; only permitted files changed.
```

W3C reviews W3X's actual output before recommending PASS. Only W3X commits.

---

# 8. Implementation acceptance

Conceptually:

```text
Generic, scalar, SSE4.1, and AVX2 non-pixel probe objects are built under
isolated target contracts and coexist in one Windows x64 DLL. Generic and
scalar probes execute successfully and return their identity markers.
Target-specific SSE4.1 and AVX2 objects are proved present and linked by named
symbol/object inspection, with no unguarded path (static initialiser,
registration, import thunk, or test call) able to execute their instructions.
No pixel, frame, copy, deblocking, capability-detection, or final dispatch path
is introduced, and no feature closure, vector width, or lane layout is frozen.
```

Deferred, explicitly, to later stages:

```text
- exact SSE4.1 and AVX2 feature closures, by assembly inspection   -> 1B.2
- FMA-exclusion proved by emitted assembly                          -> 1B.2
- vector widths, lane layouts, load/store forms                     -> 1B.2
- CPU/OS capability detection and the guard that permits execution  -> 1B.3
- per-instance backend resolution and dispatch                      -> 1B.3
```

---

# 9. Coder's first response

Before delivering code, W3C returns a compact orientation check per the coder
introduction: documents and versions received; controlling vs informative;
current milestone; that Stage 1A.1 is its prerequisite and the starting commit
is the reconciled one (not 81b04e8); the G5 consequence that SSE4.1/AVX2 link
but are not called; the reconciled commit, branch, and clean tree; and any
mismatch or ambiguity blocking work.

If Stage 1A.1 is not yet accepted and committed, W3C states that this scope is
blocked on it and does not begin.

---

*This scope is controlling for Stage 1B.1 only. The charter and README prevail
where they differ. W3X builds, runs, and commits; W3C delivers and reviews the
actual results before recommending a commit.*
