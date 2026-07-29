# Deblock4 - New Chat Introduction for Coder

**Version:** 1.5
**Date:** 2026-07-29
**Status:** Informative successor orientation; not controlling; aligned to ratified charter v1.14
**Role:** W3C successor coder
**Encoding:** US-ASCII only

---

# IMMEDIATE NEXT ACTION

Stage 1B.1 is COMPLETE (scope v1.7, accepted and committed). The next bounded
scope is **Stage 1B.2 - within-level confirmation and assembly inspection**:
confirm each backend object stays WITHIN its named psABI level (x86_64_v1/v2/v3)
by compiling and INSPECTING GENERATED ASSEMBLY (nothing outside the level is
emitted), settle the AVX/SSE transition (vzeroupper) question by inspection, and
PRODUCE the whole-level feature requirements that Stage 1B.3 will enforce. Stage
1B.2 does NOT derive a bespoke closure and does NOT check a runtime guard (that
guard is a Stage 1B.3 artifact). The tiers are the named psABI levels used in
full; FMA is part of the v3 level and is NOT excluded (`.strict` prevents
contraction), so 1B.2 must not expect FMA emission.

TWO FILTERS, CLASSIC FIRST: the plugin will register deblock4.Classic (H.264,
faithful to HolyWu, built first as a known de-risking algorithm) and
deblock4.Deblock4 (the end-goal MPEG-2 algorithm, second). Stage 1B.x is shared
infrastructure and precedes both; per-algorithm stages then run Classic
(2C..5C), then Deblock4 (2D..5D). Backend equivalence is per filter: integer
byte-exact across scalar/v2/v3; float same-algorithm within a measured tolerance
with exact structural results. This is NOT universal float bit-identity.

Do not introduce pixel-producing, frame-construction, plane-copy, or deblocking
code in Stage 1B.2. Do not call SSE4.1 or AVX2 code: G5 still forbids execution
until the Stage 1B.3 capability guard exists.

What Stage 1B.1 established, and which 1B.2 builds on rather than revisits:

```text
- four separately compiled probe objects (generic, scalar, SSE4.1, AVX2) link
  into the one Deblock4.dll;
- generic and scalar modules are in the DLL root graph, so their export fn
  declarations genuinely PE-export (the smoke test links against them);
- SSE4.1 and AVX2 markers are export fn in their OWN single-target objects.
  That gives emission and linker visibility, and object-mode export does NOT
  create a PE export;
- the DLL root references each gated marker by @extern, address-taken and
  NEVER called, stored in internal non-exported pointers;
- neither gated marker appears in the PE export table; a standing dumpbin
  /EXPORTS gate enforces this permanently;
- the baseline target contract is fixed and -Dtarget/-Dcpu are not exposed,
  so native overrides are rejected;
- duplicate-symbol rule: a source is in the DLL root graph OR a linked
  object, never both.
```

CRITICAL and counter-intuitive: the prohibition is on PE-EXPORT, not on the Zig
export keyword. Gated backend code IS declared export fn. Charter v1.10 carries
the corrected corollary; Deblock4_Toolchain_Findings records the three
mechanisms that were empirically falsified before this one worked. Read both
before proposing any change to the backend object structure.

Before changing anything, verify the branch, exact HEAD, working-tree state,
document versions, and formal scope package.


---

# 1. Purpose and authority

You are the successor coder chat and may have no prior memory. This file orients
you; it does not define the algorithm, amend an invariant, authorise changes,
or replace a coding scope.

```text
W3X  human coordinator: decisions, repository, builds, runs, commits, pushes
W3D  designer/reviewer: specifications, design review, scopes, harness design
W3C  coder - your role: implement one supplied bounded scope
```

Only W3X may claim that a build, test, benchmark, commit, or push occurred. You
provide mechanically applicable code or patches and exact validation commands;
W3X runs them and reports the real results.

Where a charter or design ambiguity affects correctness or scope, identify it
and stop. Do not choose the most plausible interpretation.

---

# 2. Required reading order

Read in this order. Establish the map first; return to detailed controlling
sections when the active scope quotes or requires them.

## 2.1 `Deblock4_Project_Status` (latest version) - INFORMATIVE

Read first for the reported proof state, open work, and why Stage 1B.1 is next.
It may contain an older charter pointer; the latest ratified charter prevails.

## 2.2 `Deblock4_Concise_Project_Summary_v1.1.md` - INFORMATIVE

Read for the compact project shape, vocabulary, public surface, stage sequence,
and the per-filter integer-exact / float-tolerance backend relationship.

## 2.3 `AI_Charter_and_Invariants_Card_v1_14.md` - CONTROLLING

This is the W3X-ratified charter baseline, internal version 1.14. Verify the
filename and internal version agree before acting; if a newer ratified version
exists in the repository, it prevails over the number written here.

Before proposing code, read the bootstrap header, Part 1 in full, W3C role,
coding/interop/numeric/SIMD/delivery rules, and process rules. Pay particular
attention to G5 (no execution before the guard), G6 (safety properties rest on
explicit/structural mechanisms, never implicit toolchain behaviour; the ban is
on PE-EXPORT of gated code, NOT on the Zig export keyword - gated backend code
IS declared export fn in its own object), and C-DELIV-01 through C-DELIV-08.

## 2.4 `README_Deblock4_Design_Spec_v1_7.md` - CONTROLLING

Read its metadata, executive summary, and decision-status table. For Stage
1B.1, focus first on:

```text
section 11  proposed source/module architecture
section 12  compilation and one-DLL runtime dispatch
section 14  validation specification
section 20  proposed development stages
```

The README is the technical tie-breaker. Later scopes will quote the detailed
algorithmic sections they require.

## 2.5 `Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
Deblock4_Toolchain_Findings_v1_1.md` - INFORMATIVE

Read for the Stage 1B.1 retention/export decision. It records the research query,
the external findings verbatim, and the designer assessment that led to charter
G6. It explains WHY gated backend code is never exported and how retention
without export works in COFF/PE (reference-graph anchoring; /INCLUDE-class
directives; COFF safe-by-default exports). The active 1B.1 scope requires you to
assess this before writing code.

## 2.6 `Deblock4_Toolchain_Findings_v1_1.md` - INFORMATIVE

Read for the empirical Zig/linker facts that determine how backend objects are
built and retained (F1-F5): emission is decided per compilation unit; a
cross-compilation reference does NOT force emission; object-mode `export fn`
grants emission and linkage but does NOT create a PE export; and the proven
idiom for multiple CPU-feature levels in one binary (separate single-target
units, self-emitting via export, referenced across the linker seam by @extern,
with dispatch populating function pointers after CPU detection). This explains
why the Stage 1B.1 structure is what it is, and it is the pattern Stage 1B.3
dispatch will follow.

## 2.7 `Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md` - INFORMATIVE, DEFERRED

Do NOT read this for Stage 1B.1. It has NOTHING to do with backend object
isolation and reading it now risks scope bleed into a pure build/linkage task.

Read it ONLY when your active scope involves grid handling, field separation,
DCT, or pixel processing (Stage 2 entry and later). At that point it is
essential background: it explains why edge_step_y is the hard parameter, the
three DCT regimes, what field separation does to the block grid (pitch-4 vs
pitch-8), why the midpoint machinery exists and why it does not break
vectorisation, and the measured fact that the target LG footage is regime-3
(adaptive per-MB DCT) in every practical mode - so the midpoint machinery is
required, not optional. Until a grid/pixel scope is active, this document is
future reading; leave it be.

## 2.8 Formal active coding scope

Read last. It must identify the starting commit, exact permitted and forbidden
files, validation, and acceptance. Do not write production code from this
introduction alone.

---

# 3. Where the project is

**Stages 1A, 1A.1 and 1B.1 are complete; Stage 1 is not complete.**

Reported proved: Zig 0.16.0 scaffold, Windows DLL/client linkage, VapourSynth
API4 core/constants translation, and the settled `VSHelper4.h` C-ABI bridge.
Stage 1A.1 reconciled the helper-bridge names and re-established a genuine R78
build baseline; its accepted commit is the Stage 1B.1 starting point (verify the
exact HEAD in the repository).

Stage 1B.1 proved the isolated backend objects and one-DLL linkage (see
IMMEDIATE NEXT ACTION for what it established).

Not yet present: a functional VapourSynth filter, scalar deblocking code,
ReleaseSafe scalar oracle, final feature closures, capability detection, or
runtime dispatch.

---

# 4. Tacit knowledge and closed dead ends

Repository-sensitive items below are historical reports. Verify current source.

## 4.1 Last reported environment

```text
repository:
    E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4
branch:
    main
Zig:
    C:\SOFTWARE\zig\zig.exe
ZLS:
    C:\SOFTWARE\zig\zls.exe
headers:
    third_party\vapoursynth\include\
```

Reported `build.zig.zon` fingerprint:

```text
0x7f9af282a5ce8d76
```

Do not copy a fingerprint from a disposable `zig init` project; it belongs to
that package, not Deblock4.

## 4.2 `VSHelper4.h` bridge decision

The attempted all-header translation gave:

```text
Debug       passed
ReleaseFast passed
ReleaseSafe failed
```

ReleaseSafe failed in generated Zig after Windows CRT declarations were reached
through `VSHelper4.h`, including secure wide-string declarations associated
with `wcscat_s` and `wcscpy_s`. Macro workarounds were not satisfactory.

Settled architecture:

```text
VapourSynth4.h + VSConstants4.h
    translated into Zig

VSHelper4.h
    compiled as C through the Zig build graph
    exposed through narrow project-authored C-ABI wrappers
```

This final arrangement was reported passing ReleaseSafe. Do not casually
reopen all-header translation.

Direct wrappers preserve the external name after `zig_`:

```text
vsh_areValidDimensions -> zig_vsh_areValidDimensions
```

Deblock4 policy/composition/test functions use `deblock4_` instead.

## 4.3 Existing scaffold proof

Reported proof already includes:

```text
Windows x64 DLL built
expected export present
separate smoke-test executable linked or loaded it
C-ABI probe called
expected identity marker returned
```

Stage 1B.1 extends this proof; it should not replace it with an unrelated DLL
experiment.

Reported historical files included:

```text
build.zig
build.zig.zon
src/build_probe.zig
src/dll_probe.zig
src/dll_smoke_test.zig
src/vapoursynth_api4.h
src/vapoursynth_helper_bridge.c
src/vapoursynth_header_probe.zig
```

Inspect the repository; this is not an authoritative current inventory.

## 4.4 External helper review

`zsmooth` string, copy, math, and vector helpers were reviewed. No reviewed
function is approved merely because it is reusable or already Zig code. Apply
the charter's function-specific safety, codegen, and provenance rules.

Closed shortcuts:

```text
translate VSHelper4.h with the core headers
copy a zig init fingerprint
import an external common module wholesale
treat @Vector or load/store/gather naming as SIMD proof
```

Reopen one only through a bounded scope justified by new evidence or a concrete
need.

---

# 5. What will bite you

```text
If you are about to add pixel, frame-construction, copy, or real deblocking
code, do not. The ReleaseSafe scalar oracle does not yet exist.

If you are about to CALL SSE4.1 or AVX2 probe code in Stage 1B.1, do not.
G5 permits compile/link/presence proof but forbids execution before a proven
in-process capability guard confirms the complete feature contract. There is
no command-line, environment-variable, build-flag, manual, or 'known capable
machine' bypass. Static initialisers, registration paths, import thunks, and
test calls all count as execution.

If you are about to declare a gated (SSE4.1/AVX2) function with the export
keyword, do not. Charter G6: gated backend code is NEVER exported. An exported
symbol is a call path that bypasses the dispatch guard, and relying on the
toolchain not to export it is exactly the implicit-behaviour dependency G6
forbids. Retain gated code by explicit reference or an explicit retention
directive; its absence from the export table must be structural. Prove that
absence with a standing dumpbin /EXPORTS gate, not a one-time look.

If you are about to compile generic or dispatch code under AVX2, do not.
Dispatch must run on machines lacking the feature it detects.

If you are about to freeze feature closures, vector widths, lane layouts,
load/store forms, or gather strategy from intuition, do not. Those are Stage
1B.2 compile-and-assembly results.

If you are about to use a VapourSynth stride as a typed-sample offset, stop.
VapourSynth strides are byte counts.

If you are about to batch adjacent luma edges or merge vertical and horizontal
passes, stop. Schedule and dependency rules are output-defining.

If you are about to perform broad cleanup or import utilities during Stage
1B.1, do not. It is an isolation/linkage proof, not a refactoring scope.

If you are about to claim PASS without W3X's actual output, do not.

If a patch does not match its stated base and anchors, do not hand-edit it into
place. Issue a corrected delivery.
```

---

# 6. What may not be fully written down

Verify rather than assume:

```text
1. Exact current HEAD and clean/dirty working-tree state.
2. Whether the attached charter filename and internal version both identify
   ratified v1.10 (or newer); stop on any mismatch.
3. Exact committed scaffold inventory after W3X's adjustments.
4. Exact final build commands and console markers for Debug, ReleaseSafe, and
   ReleaseFast bridge validation.
5. Exact DLL smoke-test and helper-bridge result markers.
6. Whether .vscode/extensions.json and .vscode/tasks.json are committed.
7. Whether temporary placeholder or disposable probe files remain.
8. The coordinator machine's actual CPU features.
9. Whether the Project Status document was updated past v1.0 to reflect 1A.1
   and the G6 development.
10. The formal Stage 1B.1 permitted/forbidden file set (from the active scope).
11. Final SSE4.1 and AVX2 feature closures; these remain deliberately open.
12. Whether Zig 0.16 forceUndefinedSymbol (or its equivalent) retains a
    NON-exported symbol - the empirical crux the active scope asks you to
    settle with W3X for G6-compliant retention without export.
```

These are verification items, not invitations to redesign the project.

---

# 7. Working with W3X and delivering code

Use this style:

```text
one bounded objective
exact changed-file set
minimal unrelated change
clear comments at invariant-enforcement points
ASCII-only artifacts
mechanical delivery under C-DELIV
exact commands and expected results
actual W3X outputs before PASS
```

Do not compress safety-critical comments about ownership, lifetime, alignment,
target features, numeric range, or schedule dependencies.

Delivery form is selected per file:

```text
new file
    -> complete whole file
existing file, small localised change
    -> anchor-verifiable unified diff patch
existing file, roughly more than 30 percent changed or several regions
    -> complete replacement file
```

One scope may mix forms. Every delivery identifies its exact base, application
order, validation, expected results, and deliberate SKIPs. W3X applies, runs,
and reports. After W3X reports PASS, provide a commit message unless asked not
to.

---

# 8. First response expected from the successor

Before proposing implementation, give W3X a compact orientation check:

```text
1. Exact document filenames and internal versions received.
2. Which documents are controlling and informative.
3. Current milestone: Stage 1A complete; Stage 1 incomplete.
4. Immediate scope: Stage 1B.1 object isolation and one-DLL linkage.
5. G5 consequence: generic/scalar may run; SSE4.1/AVX2 link but are not called.
   No bypass; unguarded initialisers, registration, thunks, and tests count as
   execution.
6. G6 consequence: gated code is never exported; retention is by explicit
   reference or directive; export-table absence is structural and proven by a
   standing gate. State that you have read the research package and will assess
   it before writing code.
7. Repository branch, HEAD, git status --short, and relevant scaffold files.
8. Any mismatch, stale version, missing input, or ambiguity blocking changes.
```

Do not re-summarise every document. Demonstrate that you know where the project
is, what governs it, and what the next proof must do.

---

# 9. Required handover package

Supply this introduction together with:

```text
Deblock4_Project_Status_v1_6.md (or latest in the repository)
Deblock4_Concise_Project_Summary_v1.1.md
AI_Charter_and_Invariants_Card_v1_14.md   (or newer ratified)
README_Deblock4_Design_Spec_v1_7.md
Deblock4_Verification_And_Tiering_Decisions_v1_6.md
Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
Deblock4_Toolchain_Findings_v1_1.md
Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md   (deferred; grid/pixel stages only)
Deblock4_Forward_Roadmap_v1_6.md
formal active coding scope (Stage 1B.2)
all source files and test contracts touched by that scope
```

If only this introduction is present, implementation must not begin.

---

# 10. Revision note

```text
v1.5  Aligned to the reconciled package: charter v1.10 -> v1.14, README
      v1.2 -> v1.7, concise summary v1.0 -> v1.1, roadmap -> v1.6, plus the
      decisions record v1.5. Stage 1B.2 reframed from "feature-closure spikes"
      to within-level confirmation that PRODUCES requirements for 1B.3 (which
      implements the guard). Added the two-filter/Classic-first architecture and
      the per-filter integer-exact/float-tolerance backend relationship (not
      universal float bit-identity). G6 phrasing corrected in the reading list
      (ban is on PE-export, not the export keyword). Named psABI tiers; FMA part
      of v3, not excluded.
v1.4  Stage 1B.1 complete; retargeted to Stage 1B.2. Charter v1.9 -> v1.10
      (G6 corollary corrected: the ban is on PE-EXPORT, not the export
      keyword; gated backend code IS export fn). README v1.1 -> v1.2. Added
      Deblock4_Toolchain_Findings to the reading order and handover package,
      and recorded what 1B.1 established.
v1.3  added the MPEG-2 grid / field-DCT knowledge document to the reading order
      as INFORMATIVE but DEFERRED - not for Stage 1B.1 (pure isolation), only
      for grid/pixel stages (Stage 2 entry and later), to avoid scope bleed.
      Renumbered the formal-scope reading entry to 2.7.
v1.2  re-aligned to ratified charter v1.10 (adds G6: explicit/structural
      mechanisms over implicit toolchain behaviour; gated code never exported).
      Updated milestone to 1A.1-complete, added the retention/export research
      package to the reading order, flagged the superseded export-based 1B.1
      delivery, and added the retention-without-export empirical crux. The
      active 1B.1 scope now requires research-package assessment before coding.
v1.1  aligned the handover to W3X-ratified charter v1.8 and carried the
      complete G5 no-bypass, unguarded-execution, and SKIP consequences.
```

---

*This file preserves coder-session orientation and tacit history. It is not an
algorithm specification, invariant source, coding scope, or proof that the
current repository still matches the last reported scaffold.*
