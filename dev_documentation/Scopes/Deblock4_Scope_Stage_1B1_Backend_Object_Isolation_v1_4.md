# Deblock4 - Coding Scope: Stage 1B.1 Backend Object Isolation and One-DLL Linkage

**Version:** 1.4
**Date:** 2026-07-25
**Status:** Active coding scope for W3C. Controlling for this scope only.
**Author:** W3D designer
**Encoding:** US-ASCII only
**Revision note:** v1.4 (after the v1.3 forced-symbol experiment was
empirically falsified) replaces the retention mechanism: W3X's first Debug build
proved that Zig 0.16 OMITS a non-exported pub fn entirely when nothing
semantically references it (both gated objects had .text length 0, no marker
symbol at all - not mangled, not present), so forceUndefinedSymbol has nothing
to retain. Section 5.2 is replaced by an explicit reference-graph anchor:
baseline code takes the ADDRESS of each gated marker (address-taken, never
called) so Zig emits it and the linker retains it via that reference, while it
stays non-exported and unreachable. This is the honest v1.3 fallback, now
ratified as the mechanism. Everything else is carried from v1.3 below.

**Prior revision note:** v1.3 (after charter v1.9 / invariant G6 and the
retention/export research) makes the retention mechanism G6-compliant: the
SSE4.1/AVX2 markers are NOT declared with the export keyword; retention is by
an explicit reference-graph anchor (baseline code takes the address of each
gated marker, address-taken and never called) that forces emission and retention
without export; export-table absence is structural (COFF safe-by-default) and
proven by a STANDING dumpbin /EXPORTS gate rather than relied upon implicitly.
Adds a mandatory research-package assessment gate before coding (section 0). The
prior v1.2-era delivery that used export fn on the gated markers is SUPERSEDED.
v1.2 added the baseline-target contract (section 2A). v1.1 set the post-1A.1
commit and the structural G5 proof.

---

# Session bootstrap header

```text
Project:
    Deblock4

Charter:
    filename          AI_Charter_and_Invariants_Card_v1_9.md
    internal version  1.9

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
    charter v1.9 and README v1.1 as controlling references;
    the working build_1B1.bat environment/setup head already drafted by W3X.

Required validation:
    the commands in section 7, run by W3X from a shell where build_1B1.bat has
    established the VsDevCmd environment so dumpbin resolves.

Expected result:
    the one Deblock4.dll builds in Debug, ReleaseSafe, ReleaseFast, now
    containing four backend probe objects, with the DLL root, generic, scalar,
    and smoke-test units on a deliberate x86-64 baseline (section 2A);
    the existing scaffold regression checks still pass (build probe, header
    probe API 4.2, existing DLL smoke test 0x44423401, unit tests);
    the new backend-isolation smoke test confirms generic and scalar markers
    execute and returns its expected value;
    the SSE4.1 and AVX2 markers are emitted and retained by an explicit
    reference-graph anchor (address-taken by baseline code, never called),
    shown present with non-zero .text by dumpbin /SYMBOLS, and proved non-reachable
    (not exported, not called, no startup/init/registration/import path);
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

# 0. Mandatory first step - assess the research before coding

Before proposing any implementation, W3C reads and assesses:

```text
Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
```

and confirms, in its first response, agreement or reasoned disagreement with the
G6-compliant retention approach this scope adopts (section 5.2). Specifically,
W3C states:

```text
- that it has read the research package and understands why gated backend code
  is never exported (charter G6);
- confirmation that it will implement the ratified reference-graph anchor of
  section 5.2 (address-taken by baseline code, never called, non-exported), and
  that it understands WHY the earlier forced-symbol mechanism was abandoned:
  W3X's build proved Zig 0.16 omits an unreferenced non-exported pub fn
  entirely, so there was nothing to force-retain;
- any disagreement with the anchor approach, raised and stopped on, rather than
  resolved silently inside the implementation.
```

No implementation is produced until this assessment is given. A prior 1B.1
delivery that declared the gated markers with the export keyword is SUPERSEDED
by G6 and must not be reproduced.

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

# 2A. Provisional baseline-target contract (binding)

The current build.zig obtains its target through:

```text
const target = b.standardTargetOptions(.{});
```

With no explicit CPU, this resolves to the NATIVE host CPU. On an AVX2-capable
machine that means the DLL root, generic, scalar, and smoke-test code could be
compiled with AVX2 (or other gated) instructions - silently violating G2
(generic/dispatch code contains no gated instructions) and creating a G5 bypass
(generic code runs on any machine, but native-compiled generic code would fault
on a machine lacking those instructions).

This scope therefore requires, as a binding structural contract:

```text
The following units are compiled to a DELIBERATE, FIXED, PROVISIONAL x86-64
BASELINE target that assumes no gated feature (no SSE4.1, AVX, AVX2, FMA):

    the Deblock4.dll root module
    backend_probe_generic
    backend_probe_scalar
    backend_isolation_smoke_test
    the existing DLL smoke-test executable (deblock4_dll_smoke_test)

For these units:
    - the baseline target is set explicitly in build.zig, not inherited from
      the native host;
    - -Dcpu=native, any other CPU override, environment route, or build option
      MUST NOT silently replace the baseline for these units;
    - an unsupported or conflicting target request is REJECTED rather than
      quietly turned into native-host code.
```

Notes and boundaries:

- This is NOT a Stage 1B.2 feature-closure decision. It is the minimum
  structural baseline needed to satisfy G2 and G5 during Stage 1B.1. The exact
  final baseline closure is still a later matter; here it need only be a
  deliberate, gated-feature-free x86-64 baseline.
- The SSE4.1 and AVX2 probe objects are exempt from the baseline (they exist
  precisely to carry gated features) but remain non-exported and non-reachable
  per sections 4 and 5.
- The SEMANTIC requirement is stated here; the exact Zig 0.16 target-query
  syntax is left to W3C, subject to W3X compilation proof (A3, P-03). If the
  chosen syntax cannot both fix the baseline and reject native override cleanly
  on Zig 0.16, W3C states this rather than forcing it.

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

# 5. G5 and G6 are the governing invariants - the proof is STRUCTURAL

Quoted so the memoryless coder works from the text:

```text
G5  A backend's instructions are never EXECUTED on a machine not yet proven
    to support them. ... UNGUARDED EXECUTION PATHS ARE EXECUTION: static
    initialisers, registration paths, import thunks, and test calls all count.

G6  Safety properties rest on EXPLICIT or STRUCTURAL mechanisms, never on
    implicit toolchain behaviour. Preference: (1) structural - the unsafe
    state is inexpressible by construction; (2) explicit declaration - the
    safe set is positively stated; (3) guarded residual - a loud-failing
    standing gate. Corollary: gated backend functions are NOT declared with
    the export keyword; their retention is proven by explicit reference or an
    explicit retention directive, and their absence from the export table is
    then structural (COFF/PE exports nothing without positive declaration).
```

## 5.1 Do NOT declare the SSE4.1 or AVX2 markers with the export keyword

This is the G6 corollary and it is the single most important rule in this scope.

An exported target-specific function is a public, callable entry point into the
DLL - a call path that bypasses the dispatch guard (G5), and a property that
would depend on the toolchain NOT exporting it (implicit behaviour G6 forbids).

Therefore the SSE4.1 and AVX2 marker functions:

```text
- are NOT declared with the export keyword (this is the structural, tier-1
  mechanism: COFF/PE puts nothing in the export table without positive
  declaration, so a non-exported function CANNOT appear there by construction);
- are retained by an explicit mechanism (section 5.2), not by export;
- are NOT called by any generic/scalar code;
- are NOT referenced by any DLL-load, static-initialiser, registration, or
  import-thunk path.
```

The generic and scalar markers MAY use export, because the smoke test calls them
from outside the DLL and they are safe baseline code. Only the gated markers are
forbidden the export keyword.

Note on the superseded delivery: an earlier 1B.1 implementation declared the
gated markers with export fn and relied on the toolchain not tabling them. That
is exactly what G6 forbids. Do not reproduce it.

## 5.2 Prove presence by an EXPLICIT REFERENCE-GRAPH ANCHOR (ratified mechanism)

Empirical finding (W3X Debug build, confirmed by dumpbin /SYMBOLS on the failed
cache objects): Zig 0.16 does NOT emit a top-level `pub fn ... callconv(.c)`
marker if nothing semantically references it. Both gated objects had `.text`
length 0 and contained no marker symbol at all - not under the requested name,
not mangled, not present. `forceUndefinedSymbol` (a /INCLUDE-class requirement)
therefore has nothing to retain: it correctly requests the symbol, but the
symbol was never generated. The forced-undefined mechanism of the superseded
attempt is abandoned.

The ratified mechanism is an explicit reference-graph anchor. The principle:
give Zig a genuine semantic reference to each gated marker so it is EMITTED, and
make that reference an ADDRESS reference from retained baseline code so the
linker RETAINS it - without ever CALLING it and without EXPORTING it.

```text
1. Each gated marker (SSE4.1, AVX2) is a real, non-exported function. It is NOT
   declared with the export keyword (G6 unchanged).

2. Baseline (generic-target) code TAKES THE ADDRESS of each gated marker and
   stores it into an internal, non-exported, module-level pointer (for example
   a small internal table of *const fn () callconv(.c) u32, or one pointer per
   marker). Taking the address is the semantic reference that forces Zig to
   EMIT the function, and it is the reachability-graph reference that makes the
   linker RETAIN it.

3. The address is TAKEN, never CALLED. There is no call through the pointer
   anywhere in Stage 1B.1. The pointer exists and is retained; nothing invokes
   it. This is the G5-critical line: address-taken retains code without
   creating an execution path; a call would create one and is forbidden here.

4. The pointer table/variables are themselves internal and non-exported, so no
   external caller can reach the markers through them either. (An exported
   pointer would be a doorway; keep the anchor internal.)

5. The gated markers still never appear in the PE export table (G6, structural).
```

Why address-taken and not called: a call is an execution path, and until the
Stage 1B.3 capability guard exists there is no safe caller. Taking the address
merely records "this code exists and is referenced", which is exactly enough for
emission and linker retention, and is inert at runtime. The anchor thus proves
presence-and-linkage without ever executing gated instructions - the whole point
of the isolation stage.

What is FORBIDDEN as an anchor (all would violate the fallback discipline):

```text
- declaring the marker export (G6 breach: export-table doorway);
- a data-only marker (proves data survived, not that CODE was emitted/retained);
- a call to the marker, guarded or unguarded (G5 breach: execution path);
- a "guard" that is really a disguised call, or a branch that could reach the
  call at runtime before the capability record exists;
- any reference that does not genuinely force emission (if a chosen form leaves
  .text length 0 again, it is not a valid anchor - stop and report).
```

Verification that the anchor worked (W3X, per section 6/7):

```text
- the DLL links successfully (the markers are now emitted and retained);
- dumpbin /SYMBOLS on the installed gated .obj files shows each marker function
  present with non-zero .text (contrast: the failed build showed .text 0);
- dumpbin /EXPORTS on Deblock4.dll shows NEITHER gated marker (still not
  exported - the anchor is an internal address reference, not an export);
- the smoke test still references only generic/scalar and never the gated
  markers or the internal pointer table.
```

If any chosen anchor form still leaves the gated .text empty, or forces the
markers into the export table, or can only be made to work by adding a call,
Stage 1B.1 STOPS again for W3D review rather than proceeding. The anchor must
achieve emission + retention + non-export + non-execution simultaneously; if it
cannot on Zig 0.16, that is new information for review, not something to force.

W3C proposes the exact Zig form of the anchor (pointer table shape, where the
address is taken, how it is kept internal) in its delivery manifest, and W3D
reviews that the address is genuinely taken-not-called and the pointer is
genuinely internal before acceptance.


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
    proves NO target-specific marker function is exported (sections 5.2, 5.3).

dumpbin /SYMBOLS <installed SSE4.1 .obj>   and   <installed AVX2 .obj>
    proves each target-specific marker function is defined in its object
    (section 5.2). Objects are installed at stable paths under zig-out.

successful Deblock4.dll link with the reference-graph anchor in place
    is proof the markers are emitted and retained (the anchor's address
    reference forces emission; a missing marker would fail the link).

dumpbin /DISASM zig-out\bin\Deblock4.dll   (supplementary only)
    inspection aid; not the non-execution proof.
```

All dumpbin inspection runs against the ReleaseFast artifacts, since ReleaseFast
is the last mode built by build_1B1.bat.

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

After the three modes, the structural G5 inspection on the ReleaseFast
artifacts (the last mode built):

```text
dumpbin /EXPORTS zig-out\bin\Deblock4.dll
    (must show NO target-specific marker in the export table)
dumpbin /SYMBOLS <installed SSE4.1 .obj>
dumpbin /SYMBOLS <installed AVX2 .obj>
    (must show the target-specific marker functions defined)
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
- successful link with the reference-graph anchor, plus dumpbin /SYMBOLS on the
  installed objects showing each gated marker present with NON-ZERO .text
  (contrast the falsified build: .text length 0), proves emission and retention;
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

The SSE4.1 and AVX2 markers are real functions NOT declared with the export
keyword (G6). They are EMITTED and RETAINED by an explicit reference-graph
anchor - baseline code takes each marker's address (address-taken, never called)
into an internal non-exported pointer - shown present with non-zero .text by
dumpbin /SYMBOLS on the installed objects. They are proved NON-REACHABLE:
not exported (dumpbin /EXPORTS), not called by generic/scalar code, and not
referenced by any DLL-load, static-initialiser, registration, or import-thunk
path.

The existing scaffold regression checks (build probe, header probe API 4.2,
existing DLL smoke test 0x44423401, unit tests) still pass in all three modes.

The DLL root, generic, scalar, and both smoke-test units are compiled to a
deliberate provisional x86-64 baseline (section 2A), not the native host, and no
override silently replaces that baseline.

No gated (SSE4.1/AVX2) marker is declared with the export keyword (G6); their
absence from the PE export table is structural, and a STANDING dumpbin /EXPORTS
gate in the batch fails the run if either ever appears there.

No pixel, frame, copy, deblocking, capability-detection, or final dispatch path
is introduced; no feature closure, vector width, or lane layout is frozen; no
target-specific function is exported or called; no data-only marker substitutes
for a retained target-specific marker function.
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
