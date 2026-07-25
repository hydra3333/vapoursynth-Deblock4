# Deblock4 - Coding Scope: Stage 1A.1 R78 Baseline Reconciliation

**Version:** 1.1
**Date:** 2026-07-25
**Status:** Active coding scope for W3C. Controlling for this scope only.
**Author:** W3D designer
**Encoding:** US-ASCII only
**Revision note:** v1.1 adds C-INT-04 (quoted passage + required wrapper comments) and expands validation to run the complete existing runtime scaffold (build probe and DLL smoke test) in all three modes, per coder review of v1.0.

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
    81b04e8ce1522ddd443102b4b8e5bb9db57c7771

Active scope:
    Stage 1A.1 - reconcile the VapourSynth helper-bridge names, correct stale
    R76 wording, and re-establish a genuine R78 build/test PASS baseline.

Permitted changed files:
    src/vapoursynth_api4.h
    src/vapoursynth_helper_bridge.c
    src/vapoursynth_header_probe.zig

Forbidden changed files:
    all others, including build.zig, build.zig.zon, third_party/**,
    the DLL and build probes, .vscode/**, and every document.

Inputs supplied:
    the repository at commit 81b04e8 (clean working tree, verified by W3X);
    the R78 VapourSynth headers under third_party/vapoursynth/include/
        (VERSION.txt: "headers from VapourSynth Release R78, refreshed
         2026-07-25");
    this scope;
    charter v1.8 and README v1.1 as controlling references.

Required validation:
    the commands in section 6, run by W3X, in the stated build modes.

Expected result:
    Debug, ReleaseSafe, and ReleaseFast all build;
    the standalone build probe runs and prints PASS;
    the VapourSynth header probe runs and prints its PASS line with API 4.2;
    the bridge self-test returns 7;
    the DLL smoke test runs from zig-out\bin and reports PASS (0x44423401);
    zig build test passes;
    git diff --check clean;
    only the three permitted files changed.

Known open measurement gates:
    none apply to this scope. This scope proves a build/interop baseline, not
    any pixel or quality result.

Implementation acceptance for this scope:
    see section 7.
```

Verify the branch and starting commit before changing anything. If HEAD is not
81b04e8 on a clean tree, stop and report rather than proceeding.

---

# 1. Why this scope exists

Cold inspection of commit 81b04e8 found that the three helper-bridge files do
not agree on symbol names. The header declares symbols nothing defines, and the
C file defines symbols the header never declares. On this exact source the
translated Zig module would not expose the names the Zig probe imports, so the
scaffold as committed is not a valid R78 PASS baseline despite earlier reports.

This scope reconciles the names to one deliberate, charter-compliant convention,
corrects stale wording, and re-proves the baseline under the R78 headers. It
introduces no pixel, frame, copy, deblocking, backend-isolation, capability, or
dispatch code. It is a prerequisite to Stage 1B.1.

---

# 2. The confirmed defect

Verified in the supplied source at commit 81b04e8:

```text
src/vapoursynth_api4.h declares:
    zig_vsh_isConstantVideoFormat
    zig_vsh_areValidDimensions
    deblock4_vsh_bridgeSelfTest

src/vapoursynth_helper_bridge.c defines:
    deblock4_vsh_is_constant_video_format
    deblock4_vsh_are_valid_dimensions
    deblock4_vsh_bridge_self_test

src/vapoursynth_header_probe.zig expects (via @hasDecl and a call):
    deblock4_vsh_is_constant_video_format
    deblock4_vsh_are_valid_dimensions
    deblock4_vsh_bridge_self_test
```

The header disagrees with the C file and the Zig probe on all three names, and
on two of three it also disagrees on prefix.

---

# 3. The ratified naming decision

W3X has ratified the following convention for this reconciliation. It applies
the charter's established wrapper-naming rule.

## 3.1 Compatibility wrappers use zig_vsh_ + the exact original name

A function that merely wraps a VapourSynth vsh_ helper takes the ORIGINAL helper
name, unchanged, with a `zig_` prefix. Nothing about the original name is
altered, so recognition against the VapourSynth headers is exact.

The two wrapper functions call, respectively, `vsh_isConstantVideoFormat` and
`vsh_areValidDimensions` (confirmed in R78 VSHelper4.h, where the mangling macro
resolves each to `vsh_<name>` in C). Therefore:

```text
wraps vsh_isConstantVideoFormat  ->  zig_vsh_isConstantVideoFormat
wraps vsh_areValidDimensions     ->  zig_vsh_areValidDimensions
```

Casing is the VapourSynth original's casing, unchanged. Do not convert these to
snake_case; the point of the convention is exact correspondence with the header.

## 3.2 Deblock4-native code uses deblock4_

The self-test wraps no vsh_ helper. It constructs fixtures, calls the two
wrappers, and composes a result. It is Deblock4-native code, so it keeps the
`deblock4_` prefix. Its name stays in the snake_case form the C and Zig files
already use:

```text
deblock4_vsh_bridge_self_test
```

## 3.3 The three reconciled names, final

```text
zig_vsh_isConstantVideoFormat      wrapper; = vsh original + zig_ prefix
zig_vsh_areValidDimensions         wrapper; = vsh original + zig_ prefix
deblock4_vsh_bridge_self_test      Deblock4 composition; wraps nothing
```

Note the reconciliation direction: for the two wrappers, the HEADER was already
correct and the C file and Zig probe move to match it. For the self-test, the C
file and Zig probe were already correct and the HEADER moves to match them. Do
not simply make all three files match the majority; apply the names above.

---

# 4. Required changes, per file

## 4.1 src/vapoursynth_helper_bridge.c

Rename the two wrapper definitions and every internal call to them:

```text
deblock4_vsh_is_constant_video_format  ->  zig_vsh_isConstantVideoFormat
deblock4_vsh_are_valid_dimensions      ->  zig_vsh_areValidDimensions
```

This includes the three call sites inside `deblock4_vsh_bridge_self_test`
(the `is_constant_video_format` call and the two `are_valid_dimensions` calls).

Leave `deblock4_vsh_bridge_self_test` named as it is. Leave its body logic,
fixtures, and the returned bitmask (expected 7) unchanged.

Each renamed wrapper definition also receives the comment that charter C-INT-04
requires at the compatibility boundary (see section 5.2). These comments are not
optional cleanup; they are mandated by the controlling rule. Conceptually,
immediately above each wrapper definition:

```c
/*
 * C-INT-04: project-authored Zig-facing compatibility wrapper for
 * vsh_isConstantVideoFormat. The zig_ prefix marks a compatibility wrapper;
 * it does not imply compiler-generated code.
 */
int zig_vsh_isConstantVideoFormat(const VSVideoInfo *vi) { ... }
```

```c
/*
 * C-INT-04: project-authored Zig-facing compatibility wrapper for
 * vsh_areValidDimensions. The zig_ prefix marks a compatibility wrapper;
 * it does not imply compiler-generated code.
 */
int zig_vsh_areValidDimensions(...) { ... }
```

Exact wrapping may be adjusted for the project's line-length convention, but each
comment must name the original external `vsh_` function it wraps and state that
the wrapper is project-authored compatibility code.

## 4.2 src/vapoursynth_api4.h

The two wrapper declarations already use the correct `zig_vsh_` names; leave
them. Change only the self-test declaration to match the C/Zig snake_case form:

```text
Find:
    int deblock4_vsh_bridgeSelfTest(void);
Replace:
    int deblock4_vsh_bridge_self_test(void);
```

Also correct the stale release wording, separating the pinned API contract from
the header release actually vendored:

```text
Find:
    * Deblock4 targets VapourSynth API 4.2 as supplied with R76+.
Replace:
    * Deblock4 pins VapourSynth API 4.2 via VS_USE_API_42. The vendored
    * headers are currently VapourSynth R78. The pinned API contract is
    * deliberate and independent of the vendored header release; updating the
    * headers must not silently change the compiled API contract.
```

Do not otherwise alter the file, its include order, or the `VS_USE_API_42`
definition.

## 4.3 src/vapoursynth_header_probe.zig

Update the two wrapper references to the new `zig_vsh_` names, in the `@hasDecl`
checks and anywhere the wrappers are named:

```text
deblock4_vsh_is_constant_video_format  ->  zig_vsh_isConstantVideoFormat
deblock4_vsh_are_valid_dimensions      ->  zig_vsh_areValidDimensions
```

Leave the `deblock4_vsh_bridge_self_test` `@hasDecl` and call unchanged, and
leave the `!= 7` self-test assertion unchanged. Leave the API 4.2 checks
(`VAPOURSYNTH_API_MINOR != 2`) unchanged.

---

# 5. Controlling passages the coder must actively apply

Quoted so the memoryless coder works from the text, not a reference.

## 5.1 Charter A3 (nothing untested becomes normative)

```text
A3  Estimates, benchmarks, and expectations are never requirements.
    Nothing untested becomes normative. No syntax, and no architecture
    level, is frozen before it compiles and its output is inspected.
```

Consequence here: this scope changes nothing about targets or feature closures.
It only reconciles names and re-proves the existing baseline.

## 5.2 Charter C-INT-04 (compatibility-wrapper names and comments)

This rule is the direct basis for the entire naming decision in section 3 and
for the comment requirement in section 4.1.

```text
C-INT-04  COMPATIBILITY-WRAPPER NAMES PRESERVE EXTERNAL CORRESPONDENCE.

          Where an external C helper requires a Zig-facing compatibility
          wrapper, preserve the original external symbol spelling after a
          zig_ prefix:

              vsh_areValidDimensions
                  ->
              zig_vsh_areValidDimensions

          The zig_ prefix means "Zig-facing compatibility wrapper"; it does
          not claim that the Zig compiler generated the function.

          Functions that add Deblock4 policy, validation, composition, or
          testing use the deblock4_ prefix instead.

          Wrapper comments identify the original external function and state
          that the wrapper is project-authored compatibility code.
```

Consequence here: the two wrappers take the exact original names after `zig_`
(section 3.1), the self-test keeps `deblock4_` (section 3.2), and each wrapper
definition carries the C-INT-04 comment (section 4.1). Applying this rule is a
required part of acceptance, not a stylistic nicety.

## 5.3 Charter C-DELIV-06 (tool and interop assumptions, the bridge)

```text
VapourSynth4.h and VSConstants4.h are translated into Zig.
VSHelper4.h is compiled as C and exposed through the established narrow C-ABI
bridge. A delivery must not replace that arrangement with direct translation
unless a separately ratified scope proves the ReleaseSafe failure has been
eliminated under the pinned tools.
```

Consequence here: do not translate VSHelper4.h into Zig. The bridge stays. This
scope only renames symbols crossing the existing bridge.

## 5.4 Charter C-DELIV-02 and C-DELIV-03 (delivery format and anchoring)

Each changed file is an existing file with a localised change, so each is
delivered as an anchor-verifiable unified-diff patch stating the base commit
81b04e8 and quoting enough surrounding context that W3X can confirm the target.
A patch that fails commit or anchor verification, or either git apply --check,
is not hand-edited to fit; issue a corrected patch.

## 5.5 Charter P-03 (nothing untested becomes normative)

```text
P-03  Build syntax, API spellings, architecture levels, and codegen
      expectations are provisional until they compile and run.
```

Consequence here: acceptance requires W3X's actual build and run results, not a
claim that the rename "should" compile.

---

# 6. Validation, run by W3X

Because this scope re-establishes a genuine R78 scaffold baseline, validation
runs the COMPLETE existing runtime scaffold, not only the header probe and unit
tests. That means the standalone build probe and the DLL smoke-test executable
are executed too. The default `zig build` for each mode installs the DLL and the
smoke-test executable into `zig-out\bin`, so the smoke executable is run after
the corresponding mode's default build.

From the repository root, on branch main at the reconciled working tree, for each
MODE in {Debug, ReleaseSafe, ReleaseFast}:

```text
git status --short
git rev-parse --short HEAD

zig build -Doptimize=<MODE>
zig build run -Doptimize=<MODE>
zig build vs-header-run -Doptimize=<MODE>
zig build test -Doptimize=<MODE>
zig-out\bin\deblock4_dll_smoke_test.exe

git diff --check
git status --short
```

Expected runtime lines (exact existing formatting is authoritative; these are
the source-verified strings at commit 81b04e8):

```text
build probe (zig build run):
    "Deblock4 Zig 0.16.0 build probe: PASS"
    (the standalone build probe prints "<name> Zig <version> build probe: PASS")

header probe (zig build vs-header-run):
    "Deblock4 VapourSynth headers probe: PASS
     (API 4.2; core/constants translated; helpers compiled as C)"
    and the bridge self-test returns 7 internally (a non-7 result fails)

DLL smoke test (zig-out\bin\deblock4_dll_smoke_test.exe):
    "Deblock4 DLL smoke test: PASS (value 0x44423401)"
    (the exported symbol is deblock4_build_probe_value; the marker is
     0x4442_3401; a mismatch prints FAIL and returns an error)
```

Overall expected:

```text
- all three optimize modes build with no error;
- the standalone build probe runs and prints its PASS line in every mode;
- vs-header-run prints the probe PASS line reporting API 4.2 in every mode;
- the bridge self-test returns 7 in every mode;
- the DLL smoke test runs from zig-out\bin and reports PASS (value 0x44423401);
- zig build test passes in every mode;
- git diff --check reports no whitespace errors;
- git status --short shows only the three permitted files modified.
```

Note: no build.zig change is required to run these existing probes; the `run`,
`vs-header-run`, and `test` steps and the installed smoke executable already
exist in the current build graph.

If any mode fails, W3X reports the exact command, mode, exit code, and first
failure output. The coder does not claim PASS; only W3X's results establish it.

---

# 7. Implementation acceptance

```text
The three helper-bridge files agree on the ratified names:
    zig_vsh_isConstantVideoFormat
    zig_vsh_areValidDimensions
    deblock4_vsh_bridge_self_test

The stale R76 wording is corrected to separate the pinned API-4.2 contract from
the R78 vendored headers.

Under the R78 headers, in Debug, ReleaseSafe, and ReleaseFast, the complete
existing runtime scaffold passes: the build probe prints PASS; the header probe
reports API 4.2; the bridge self-test returns 7; the DLL smoke test reports PASS
with value 0x44423401; and zig build test passes.

Only the three permitted files changed. No pixel, frame, copy, deblocking,
backend-isolation, capability, or dispatch code was introduced. The VSHelper4.h
C-ABI bridge arrangement is unchanged in structure.
```

This scope deliberately does NOT prove: any backend isolation, any feature
closure, any SIMD behaviour, any pixel or quality result. Those belong to later
stages.

---

# 8. What this unblocks

Once W3X reports PASS and commits, the resulting commit becomes the clean R78
baseline. Stage 1B.1 is authored against THAT commit, not 81b04e8. The Stage
1B.1 scope's bootstrap header will record the post-reconciliation commit as its
starting commit.

---

*This scope is controlling for Stage 1A.1 only. The charter and README prevail
where they differ. W3X builds, runs, and commits; W3C delivers and reviews the
actual results before recommending a commit.*
