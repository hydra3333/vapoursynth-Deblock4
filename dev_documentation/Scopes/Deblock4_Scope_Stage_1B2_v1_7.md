# Deblock4 - Formal Coding Scope: Stage 1B.2

**Version:** 1.7
**Date:** 2026-07-29
**Status:** Formal active coding scope, authored by W3D for W3C. Controlling for
this scope only; the charter and README prevail on any conflict. v1.1 is
reconciled against the ACTUAL committed Stage 1B.1 source tree (build.zig, the
probe sources, and build_1B1_v7_3.bat), so file names, guards, paths, and
validation commands are exact rather than documented-from-description. v1.2 adds
section 1.1 (W3X tier-authority clarification: the tiers ARE the x86-64 psABI
levels; settled, cross-referenced to charter G3 / README 12.3). v1.3 folds in
W3C's first-response points: vzeroupper proof DEFERRED (3.2, the probe emits no
AVX/YMM); the report keeps three feature sets distinct (3.3 A/B/C); four
per-object within-level inputs named (3.1); the SSE4.1 guard reworded to its
accurate narrow meaning (2.2); exact batch/report paths fixed and docs/ created;
self-reference and inputs list corrected. v1.4: removed the pinned starting
commit (base is the attached tree; W3X may commit non-code changes between
scopes), and reworded FLAG 1 from an open judgment to a RATIFIED code-catch-up
(align the build targets to the full named levels; the FMA question itself is
settled and not reopened). v1.5 folds in W3C's second-response points: FIXED the
OSXSAVE contradiction (it IS a v3 level member -> set A; set B is the separate
XGETBV/XCR0 register read, not a level member); tightened the within-level
classifier to prove each object against ALL higher-level instructions, not just
AVX/VEX absence (3.1, V4, checklist); header validation item now names all four
objects; vzeroupper deferral corrected to Stage 5C (a 4C v2 function cannot
establish a YMM transition). Also added two W3X-requested 1B.3-forward
requirements to the report (3.3 G and H): detection stderr diagnostics
(per-bit + tier + fallback), and a debug-only FORCE-DOWN capability override
fenced by G5/G6 (force lower tier only, compiled out of release, loudly
announced).
**Encoding:** US-ASCII only.

---

# 0. Scope header (charter bootstrap)

```text
Charter:
    filename          AI_Charter_and_Invariants_Card_v1_16.md
    internal version  1.16

Controlling specification:
    filename          README_Deblock4_Design_Spec_v1_9.md
    internal revision Design specification revision: 1.9

Supporting decisions record:
    filename          Deblock4_Verification_And_Tiering_Decisions_v1_9.md
    internal version  1.9

Repository:
    https://github.com/hydra3333/vapoursynth-Deblock4

Branch:
    main

Starting base:
    The attached Stage 1B.1 source tree (current repo HEAD as supplied by W3X).
    No commit hash is pinned: W3X may commit harness/environment/documentation
    changes between code scopes, so a pinned starting commit would go stale for
    no safety gain. The coder verifies against the ATTACHED tree (filenames,
    the probe guards, build.zig, build_1B1_v7_3.bat), which is the actual base
    that matters. If the attached tree and the repo HEAD ever disagree, stop and
    report to W3X.

Active scope:
    Stage 1B.2 - migrate the three build.zig target queries (baseline, sse41,
    avx2 probes) from the provisional Stage 1B.1 "smallest closure" targets to
    the production NAMED psABI LEVELS (x86_64_v1/v2/v3) used IN FULL - including
    DELETING the FMA subtraction from the v3 target and the FMA-exclusion guard
    from backend_probe_avx2.zig - then CONFIRM by assembly inspection that each
    object emits nothing outside its named level, RECORD the AVX/SSE
    (vzeroupper) transition question as deferred (the current v3 probe emits no
    AVX/YMM, so there is nothing to prove here; real proof owed at Stage 5C),
    and PRODUCE the whole-level feature-requirements record that Stage 1B.3 will
    enforce. No pixel, frame-construction, copy, deblocking, or
    backend-EXECUTION code.

Permitted changed files:
    build.zig
        (only the three target-query definitions and any comments; see Part 2)
    src/backend_probe_sse41.zig
    src/backend_probe_avx2.zig
        (only the @compileError target-guard predicates and comments; see Part 2)
    build_1B2_v1.bat
        (a NEW stage batch, created by copying the existing build_1B1_v7_3.bat
        and EXTENDING it with the within-level classification gate of Part 3;
        the 1B.1 batch is left in place as history. This exact name is fixed by
        this scope. Write it per the authoring rules in Part 3.1a: fixed working
        directory, factored subroutines, plain-token parameters, no special
        characters in text - be clever, not fancy.)
    docs/Deblock4_Stage_1B2_WithinLevel_Report.md
        (the produced whole-level requirements record. This exact path is fixed
        by this scope; CREATE the docs/ directory as part of adding this file.)

Forbidden changed files:
    src/backend_retention_anchor.zig    (the proven @extern anchor - DO NOT TOUCH)
    src/backend_probe_generic.zig
    src/backend_probe_scalar.zig
    src/dll_probe.zig
    src/build_probe.zig
    src/dll_smoke_test.zig
    src/backend_isolation_smoke_test.zig
    src/vapoursynth_api4.h, src/vapoursynth_header_probe.zig,
        src/vapoursynth_helper_bridge.c
    build_1B1_v7_3.bat                  (the 1B.1 batch - keep as history)
    build.zig.zon
    third_party/**                      (R78 headers - unchanged)
    the linkage/emission/PE-export MECHANISM in build.zig (addObject wiring,
        root-graph imports, dll_root_module import list, the installArtifact/
        install-object steps) - unchanged; only the three target-QUERY values
        and their stale comments move (Part 2).
    all others.

Inputs supplied:
    - this scope (Deblock4_Scope_Stage_1B2_v1_7.md);
    - AI_Charter_and_Invariants_Card_v1_16.md (Part 1 + this header);
    - README_Deblock4_Design_Spec_v1_9.md;
    - Deblock4_Verification_And_Tiering_Decisions_v1_9.md;
    - Deblock4_Toolchain_Findings_v1_1.md;
    - Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md;
    - the committed Stage 1B.1 v1.7 source tree, attached as a ZIP. Confirmed
      contents: build.zig, build.zig.zon, build_1B1_v7_3.bat, src/*.zig (the
      probe/anchor/smoke-test sources), src/vapoursynth_*, and
      third_party/vapoursynth/include/*.h (VapourSynth R78). The coder verifies
      filenames/paths against the actual tree before editing.

Required validation:
    W3X runs, on the Ryzen 3900X (primary) under the VS 2026 dev environment:
      1. `zig build`  (Debug) - must succeed; DLL + standalone objects produced.
      2. The standing dumpbin /EXPORTS gate - gated markers absent from .edata
         (UNCHANGED from 1B.1; a regression here fails the scope).
      3. dumpbin /SYMBOLS on each gated object - non-zero .text, marker present
         (UNCHANGED from 1B.1).
      4. The NEW within-level inspection (Part 3) on all FOUR per-object inputs:
         generic->v1, scalar->v1, sse41->v2, avx2->v3.
    See Part 4 for the exact command list and expected pass/fail summary.

Expected result:
    exact build configurations:  zig build (Debug); no target/cpu override flags.
    exact test executables:      zig build; dumpbin /EXPORTS, /SYMBOLS, /DISASM
                                 via VsDevCmd; the within-level inspection driver.
    exact pass/fail summary:     Part 4.
    exact files expected to change:   Permitted list above.
    exact files forbidden to change:  Forbidden list above.

Known open measurement gates:
    NONE apply to this scope. Stage 1B.2 is confirmation and record-production;
    it settles no measurement-gated question (Schedule A/B, midpoint scale,
    proper-chroma quality, AVX2 speed benefit all remain open and OUT OF SCOPE).

Implementation acceptance for this scope:
    This scope does NOT touch any pixel-producing or frame-construction path,
    so the per-type oracle contract does not apply here. "Done" means every
    item in Part 5 is satisfied: the objects target the named psABI levels in
    full; assembly inspection confirms each object emits nothing outside its
    named level; the vzeroupper question is recorded per the Part 3.2 deferral;
    the whole-level feature-requirements record is produced; and the Stage 1B.1
    linkage/retention/PE-export proofs still pass unchanged.
```

The session package contains: this completed header; Part 1 of the charter; the
controlling README; this scope; the files the scope touches; and the supporting
toolchain/backend-object documents named above.

---

# 1. Why this scope, in one paragraph

Stage 1B.1 proved the multi-object STRUCTURE (separate single-target objects,
@extern anchors, one-DLL linkage, gated markers absent from the PE export
table). It did so with PROVISIONAL probe targets that used the old "smallest
closure" policy - the committed build.zig SUBTRACTS `fma` from the AVX2 probe
target and adds only a minimal feature set. Production tiering (charter G3,
README 12.3) has since moved to the NAMED x86-64 psABI LEVELS used IN FULL:
the SSE4.1 backend targets `x86_64_v2`, the AVX2 backend targets `x86_64_v3`,
and FMA is PART of v3 and is NOT excluded (float contraction is prevented by
`.strict`, charter G8, not by removing FMA). Stage 1B.2 brings the OBJECTS onto
that production policy and CONFIRMS, by assembly inspection, that each stays
within its named level - and produces the exact whole-level requirements the
Stage 1B.3 runtime guard must later enforce. The linkage/emission/PE-export
mechanism is already correct and is not reopened.

## 1.1 Tier authority (W3X clarification - settled, not open)

```text
To remove any ambiguity: the project's CPU tiers ARE the x86-64 psABI
microarchitecture levels - x86_64_v1 (final fallback), v2, v3 - as defined by
the System V x86-64 ABI group (AMD, Intel, Red Hat, SUSE) and adopted by GCC,
LLVM/Clang, and glibc. This is the authoritative definition; the named level is
the feature contract, used in full. This is not under discussion. This restates
charter G3 / README 12.3 - those prevail, so if a gap becomes apparent between
the charter and this scope, bring it to W3X's attention immediately (do not
resolve it yourself).
```

---

# 2. The exact changes (Part A: target definitions)

## 2.1 build.zig - replace the three provisional target queries

The committed build.zig defines three target queries near the top of `build()`:
`baseline_target`, `sse41_probe_target`, and `avx2_probe_target`. All three use
`.cpu_model = .{ .explicit = &std.Target.x86.cpu.x86_64 }` plus
`.cpu_features_add` / `.cpu_features_sub` closures. In particular:
- baseline SUBTRACTS { sse4_1, avx, avx2, fma };
- sse41 ADDS { sse4_1 }, SUBTRACTS { avx, avx2, fma };
- avx2 ADDS { sse4_1, avx, avx2 }, SUBTRACTS { fma }  (comment: "AVX2 explicitly
  excludes FMA" - the OLD policy).
Replace these with the NAMED psABI LEVELS, so target and (later) detection can
share one definition of each level per charter G3 / README 12.4. Change ONLY
these three target-query values and their now-stale comments; leave every other
part of build.zig byte-unchanged.

Investigate and use, in this preference order (report which was used and why):

```text
PREFERRED:  the named level CPU models if Zig 0.16 exposes them directly, e.g.
              std.Target.x86.cpu.x86_64_v2
              std.Target.x86.cpu.x86_64_v3
            used as `.cpu_model = .{ .explicit = &std.Target.x86.cpu.x86_64_v2 }`
            (verify the exact identifiers exist in THIS Zig 0.16.0 std; if the
            identifiers differ, report the actual ones and use them).

FALLBACK:   only if a named-level model is not available in std, construct each
            level from its psABI feature set as a single explicit featureSet,
            NOT as an ad-hoc add/sub closure, and cite the psABI level
            definition. Do NOT reintroduce an FMA subtraction.
```

Constraints on this change:

```text
- baseline_target (v1): the baseline x86_64 level. It currently SUBTRACTS
  { sse4_1, avx, avx2, fma }; since v1 has none of these, the subtraction is
  redundant. Move it to the named v1/baseline level; the removed subtraction is
  a no-op, so this is a cleanup, not a behaviour change.
- sse41_probe_target (v2): the FULL x86_64_v2 level (SSE3, SSSE3, SSE4.1, SSE4.2,
  POPCNT, CMPXCHG16B, LAHF-SAHF - decisions 4.1 / 11.2). It currently subtracts
  { avx, avx2, fma }; v2 contains none of these, so dropping the subtraction is
  also a no-op for v2, but the target must now BE the named v2 level.
- avx2_probe_target (v3): the FULL x86_64_v3 level (AVX, AVX2, BMI1, BMI2, F16C,
  FMA, LZCNT, MOVBE, OSXSAVE). FMA IS INCLUDED. DELETE the
  `.cpu_features_sub = std.Target.x86.featureSet(&.{.fma})` line and its
  "excludes FMA" comment. This is the load-bearing change: production v3 is the
  whole level.
- Do NOT use -mcpu=native and do NOT expose any -Dtarget/-Dcpu override. The
  levels stay fixed in build.zig; build.zig currently rejects those overrides by
  OMISSION (it never calls standardTargetOptions), and build_1B1_v7_3.bat proves
  the rejection - preserve that (charter G3; native detection is fallible,
  decisions 4.6).
- Change ONLY the three target-query values and their stale comments. Do NOT
  change addObject wiring, the dll_root_module import list, the install steps,
  the anchor, or the export gate.
```

## 2.2 src/backend_probe_sse41.zig and src/backend_probe_avx2.zig - guards only

Both probe sources have a `comptime { ... }` block with feature guards. The
exact edits:

`src/backend_probe_avx2.zig` (THE LOAD-BEARING ONE):

```text
- KEEP the arch/OS guard and the positive feature guard
  (!has(sse4_1) or !has(avx) or !has(avx2) -> @compileError).
- DELETE the FMA-exclusion guard entirely:
      if (builtin.cpu.has(.x86, .fma)) {
          @compileError("AVX2 backend probe target must exclude FMA");
      }
  Once the target is full x86_64_v3, FMA IS present, so this guard would fire
  and BREAK THE BUILD. Removing it is required for the object to compile at all.
- Optionally, strengthen the positive guard to assert whole-v3 membership
  (e.g. also bmi2, f16c, lzcnt, movbe) so the guard proves "this IS v3"; if you
  do, use the level's feature set, not an ad-hoc list. Minimal correct change =
  just delete the FMA-exclusion guard.
- Update the now-stale "provisional features"/"must exclude FMA" comments.
```

`src/backend_probe_sse41.zig`:

```text
- KEEP the arch/OS guard and the positive guard (!has(sse4_1) -> @compileError).
- The negative guard
      if (has(avx) or has(avx2) or has(fma)) ->
          @compileError("...exceeds its provisional contract")
  does NOT fire under full x86_64_v2 (v2 contains none of avx/avx2/fma), so it
  will still pass. But its "provisional contract" FRAMING is stale. Reword the
  message/comment ACCURATELY to what the narrow predicate actually proves, e.g.
  "SSE4.1 backend probe target unexpectedly enables AVX-family features outside
  the x86_64_v2 contract". Do NOT claim it is a complete whole-level comparison
  (it only checks avx/avx2/fma); whole-level confirmation is the job of the
  named target plus the assembly inspection (Part 3), not this guard. Keep the
  positive sse4_1 guard.
- Update the stale "provisional contract" comment.
```

For BOTH: do NOT change the marker function, its name, its callconv(.c), or the
marker_value (0x4442_3412 for sse41, 0x4442_3413 for avx2). Those are
load-bearing for the retention proof. These remain NON-pixel probe markers; add
no backend/kernel logic. If a clean whole-level guard is awkward in this Zig
0.16 std, STOP and report the exact obstacle rather than inventing a guard; do
not weaken the positive feature assertion.

---

# 3. The exact changes (Part B: within-level confirmation and the record)

This is the substantive deliverable. Stage 1B.2 must CONFIRM by inspection - not
assert - that each object stays within its named level, and must PRODUCE the
requirements record.

## 3.1 Within-level assembly inspection

Classify FOUR per-object inspection inputs by disassembly, confirming the
emitted instruction set of each stays WITHIN its named level:

```text
deblock4_backend_probe_generic.obj  -> v1 control
deblock4_backend_probe_scalar.obj   -> v1 control
deblock4_backend_probe_sse41.obj    -> v2
deblock4_backend_probe_avx2.obj     -> v3
```

Do NOT attempt to classify the whole DLL as a single level: it intentionally
contains the linked v2 and v3 objects. Inspect the objects, not the DLL, for
level membership.

```text
- v3 object: may contain AVX/AVX2/BMI/etc. instructions; must contain NOTHING
  outside x86_64_v3 (in particular NO AVX-512 / EVEX-encoded instructions).
- v2 object: may contain SSE3..SSE4.2/POPCNT; must contain NO AVX/AVX2/VEX-
  encoded instructions and nothing above x86_64_v2.
- the two v1 control objects (generic, scalar): nothing above x86_64_v1.
- FMA: FMA instructions are PERMITTED in the v3 object (FMA is a level member),
  but under .strict ordinary a*b+c must NOT be auto-fused. Since these probes
  contain no arithmetic kernel, the expected finding is simply that no FMA
  contraction is forced; RECORD whether any FMA instruction appears and why.
  Their ABSENCE is legitimate and is NOT a failure (README 14.8).
```

Use MSVC dumpbin via VsDevCmd (Zig 0.16 ships only a flagless objdump; see
Toolchain Findings F3):

```bat
CALL "C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
dumpbin /NOLOGO /DISASM:BYTES <object-or-dll>
```

Because dumpbin /DISASM shows instructions PRESENT but not whether any path
REACHES them (Toolchain F3), that is acceptable HERE: within-level emission is a
property of the whole object, not of a reached path. (Non-execution remains the
@extern-never-called structural proof, unchanged from 1B.1.)

Deliver this as an EXTENSION of the existing stage batch. build_1B1_v7_3.bat
already produces, in its "ReleaseFast dumpbin proof gates" section:
  zig-out\inspection\Deblock4_exports.txt          (/EXPORTS gate)
  zig-out\inspection\deblock4_backend_probe_sse41_symbols.txt  (/SYMBOLS)
  zig-out\inspection\deblock4_backend_probe_avx2_symbols.txt   (/SYMBOLS)
  zig-out\inspection\Deblock4_disasm.txt           (/DISASM - "supplementary only")
Copy that batch to build_1B2_v1.bat and ADD a within-level classification gate
that consumes disassembly and FAILS the batch (goto :fail) on any out-of-level
instruction, per the level rules above. Prefer per-object disassembly of the
gated objects (dumpbin /NOLOGO /DISASM on each .obj) so v2 and v3 are checked
separately, rather than only the whole DLL. Keep the batch's existing loud-fail
structure (set exit_code; goto :fail; the final W3C-review banner).

If a fully automated out-of-level classifier is impractical for the full x86
instruction set in this scope, deliver a gate that (a) greps for a defensible
DENY-LIST of clearly out-of-level encodings (e.g. any EVEX/AVX-512 mnemonic in
any object; any VEX/AVX mnemonic in the v2 object) and fails on a hit, PLUS
(b) emits the per-object disassembly to files for W3X review, and say plainly
which checks are automated vs manual - do not claim automation you did not build
(C-DELIV-07).

## 3.1a build_1B2_v1.bat authoring rules (structure and style, W3X-directed)

These rules govern HOW the batch file is written. They change no gate's
behaviour - the same proofs run - they only restructure the batch to be robust
and maintainable. They are hard-won W3X batch-scripting lessons; follow them
literally. (These constraints are about the CONTENT OF THE .bat FILE, not about
this scope document's prose.)

```text
BE CLEVER, NOT FANCY. Aim for a clean, factored, boring batch that a human can
read and that cannot be tripped by a stray special character. Do not reach for
elaborate cmd.exe tricks; a small set of plain subroutines is the goal.

1. FIXED WORKING DIRECTORY. Keep the existing fixed absolute working directory
   (CD /D to the committed project folder, exactly as build_1B1_v7_3.bat does).
   Do NOT make it script-relative (no %~dp0). The batch lives and runs in its
   one committed folder by design.

2. FACTOR REPEATED CODE INTO SUBROUTINES called by CALL :label with parameters,
   instead of replicating the run-echo-check block throughout. Group the
   subroutines BY THE SHELL SYNTAX THEY NEED, so that syntax lives ONLY inside
   the routine body and NEVER in a caller's argument list. A workable set
   (the coder may refine the exact split, keeping the principle):
     - a routine that echoes and runs a command and does goto :fail on non-zero
       exit, with NO redirection;
     - a routine that captures a command's output to a named file - the ONLY
       place output redirection ( the > operator ) appears;
     - a routine for a pipe, defined ONLY if a pipe is genuinely unavoidable -
       the pipe operator appears ONLY there (the 1B.1 batch needs no pipe; it
       captures with > then matches on the file);
     - a routine that asserts a findstr pattern is PRESENT in a file (fail if
       absent), and one that asserts a pattern is ABSENT (fail if present);
     - where a specific gate needs a regex or multiple needles (e.g. the
       SECT-line marker-defined check, or the multi-needle anchor-absent
       check), give THAT gate its OWN dedicated named routine so its brackets
       and /C: quoting stay inside the routine, out of any parameter.

3. PARAMETERS ARE PLAIN TOKENS. Every argument passed to any subroutine must be
   a plain token: no parentheses, no pipe operator, no redirection operator, no
   quotes-within-quotes, no other special characters. All redirection, piping,
   and findstr matching happen INSIDE the routine bodies, using the parameters -
   never in the caller's CALL line.

4. NO SPECIAL CHARACTERS IN TEXT. Do NOT use parentheses or other special
   characters in any echo, comment, message string, or label anywhere in the
   batch. Where build_1B1_v7_3.bat echoes text containing parentheses, reword
   to remove them. (This avoids the block-parsing and delayed-expansion
   failures that special characters cause inside cmd.exe blocks.)

5. PRESERVE EVERY EXISTING GATE'S BEHAVIOUR. The Debug/ReleaseSafe/ReleaseFast
   build-run-test loop; the EXPORTS present/absent gates for all four markers
   plus the anchors; the SYMBOLS SECTn + non-zero .text gates; the
   -Dcpu=native and -Dtarget=native rejection gates; git diff --check and git
   status - all must still run and still fail loudly. ADD the new within-level
   classification gate of Part 3.1. Same proofs, cleaner structure.

6. KEEP THE LOUD-FAIL DISCIPLINE (set exit_code; goto :fail; the final
   W3C-review banner) and the fixed zig-out\inspection\ output paths.
```

## 3.2 The vzeroupper question (README 12.7) - DEFERRED PROOF (W3D ruling)

W3C correctly observed that the current v3 probe is a no-argument marker that
returns a `u32` constant: it performs no vector/YMM work, so the compiler emits
no AVX/YMM instruction and there is no AVX-to-SSE ABI boundary for a `vzeroupper`
to guard. Absence of `vzeroupper` in this trivial function proves only that none
was required - NOT how the compiler handles a real AVX-using function returning
to SSE/baseline code. Since this scope forbids changing the marker and forbids
adding kernel/vector logic, the vzeroupper transition CANNOT be settled here.

W3D ruling: adopt Option A - defer the transition proof. Stage 1B.2 records, in
the hand-forward report, exactly this:

```text
The current v3 probe emits no AVX/YMM instruction (constant u32 return);
therefore no AVX-to-SSE transition existed in the inspected object and
`vzeroupper` was not applicable. The compiler AVX-transition / vzeroupper proof
is DEFERRED to the first real v3 function that actually uses YMM state (Stage
5C, when the first real Classic v3 / YMM-using function exists; the
Deblock4 v3 path may be re-checked at Stage 5D). A recorded owed item, not a pass.
```

Do NOT introduce a synthetic AVX/YMM probe to force a transition in this scope
(Option B): that is separate probe-design work (emission, retention, non-
execution, inspection) and a synthetic probe would prove compiler behaviour on
synthetic code, not on the real kernels. If W3X prefers Option B, it must be
authored as its own bounded scope; it is OUT OF SCOPE here.

## 3.3 The whole-level feature-requirements record (the 1B.3 hand-forward)

Produce docs/Deblock4_Stage_1B2_WithinLevel_Report.md. W3C correctly noted that
a Zig CPU model's RESOLVED feature set may include compiler code-generation or
tuning properties in addition to hardware/OS capability bits, and Stage 1B.3
cannot CPUID-check a compiler tuning property. The report must therefore keep
three sets DISTINCT and must NOT instruct Stage 1B.3 to test every bit in Zig's
resolved model set:

```text
A. AUTHORITATIVE psABI LEVEL MEMBERSHIP (runtime-checkable)
   For each level v1/v2/v3: the CPU feature bits that DEFINE the level under the
   x86-64 psABI standard - the runtime-CHECKABLE CPU capability bits Stage 1B.3
   verifies for whole-level satisfaction. This is the level contract.
   NOTE: OSXSAVE IS a member of the x86_64_v3 level (it is a CPUID bit,
   CPUID.1:ECX.27) and therefore belongs HERE in set A, checked as part of
   whole-v3 satisfaction. Do not move it to set B. A tier is satisfied only when
   the CPU reports EVERY bit the level requires (e.g. a CPU with AVX2 but no
   BMI2 is NOT v3).

B. SEPARATE RUNTIME AVX/YMM OS-STATE CHECK (a register read, not a level member)
   AFTER confirming level membership (including OSXSAVE) in set A, the AVX tiers
   need one MORE runtime step before their code may execute: run the XGETBV
   instruction and read XCR0 to confirm the OS has enabled XMM and YMM state.
   This XCR0 check is ADDITIONAL runtime safety; it is NOT a CPUID
   feature-membership bit and NOT itself a psABI level member (that is why it is
   listed separately). OSXSAVE (set A) says "XSAVE/XGETBV is available"; the
   XCR0 read (set B) says "the OS is actually saving YMM state" - two different
   things at two layers (README 12.3, 12.4; decisions 4.6).

C. ZIG RESOLVED TARGET/MODEL FEATURE SET (reproducibility only)
   The exact feature set the toolchain resolved for each chosen target/model
   (e.g. from `zig build-exe --show-builtin`, or the resolved featureSet), taken
   from the toolchain, NOT hand-copied from prose. This may include
   compiler-internal / codegen / tuning properties. It is recorded for
   REPRODUCIBILITY of the build; it is NOT the runtime-check list and must NOT
   be imposed wholesale on the Stage 1B.3 guard. Where set C contains anything
   beyond set A + the ISA bits, call it out explicitly so 1B.3 does not mistake
   a tuning property for a runtime-checkable capability.

Plus:
D. The within-level inspection result per object (pass, with evidence), for the
   four objects of Part 3.1.
E. The vzeroupper finding per Part 3.2 (the deferral record).
F. An explicit statement that this record is the input contract for Stage 1B.3,
   which IMPLEMENTS and PROVES the runtime guard against set A + requirement B
   (1B.2 produces requirements; it does not implement or check a runtime guard -
   charter G3, README 12.3).

REQUIREMENTS PASSED FORWARD TO STAGE 1B.3 (record these in the report as 1B.3
obligations; they are NOT 1B.2 work - detection does not exist until 1B.3):

G. DETECTION DIAGNOSTICS. Stage 1B.3's detection path must be able to emit, to
   stderr, per-level-member present/absent detail (which set-A bits were found
   and which were missing), the chosen tier NAME, and the fallback reason when a
   higher tier was not selected (e.g. "AVX2 present but BMI2 absent -> not v3 ->
   selected v2"). This EXTENDS the already-required once-per-instance emission of
   version / requested-token / selected-tier / fallback-reason (README 12.5,
   decisions 7.1); the per-bit detail is a debug-level emission (behind the
   diagnostic path, quiet on normal runs).

H. DEBUG-ONLY, FORCE-DOWN capability override for testing fallback dispatch.
   Stage 1B.3 MAY provide a test seam to force a LOWER tier than the CPU
   supports, so v3->v2->v1 fallback can be exercised on one machine (W3X's dev
   box is x86_64_v3). It is permitted ONLY under all of these safety fences
   (charter G5/G6):
     - FORCE-DOWN ONLY: it may MASK OFF capability bits the CPU genuinely has
       (forcing selection of a lower tier, which never faults - running lower
       code on a higher CPU is always safe). It must NEVER forge a bit the CPU
       lacks (forcing a HIGHER tier is the G5 footgun that faults); a higher
       phantom capability must be structurally impossible, not merely discouraged.
     - COMPILED OUT OF RELEASE: gated by a Zig build option so the override code
       DOES NOT EXIST in a release binary (the G6 lesson: "not compiled in" is
       stronger than "defaults off"). W3X will settle the exact Zig build-option
       mechanism at 1B.3 scope time.
     - LOUDLY ANNOUNCED: when the override is active, the set-G stderr diagnostics
       must state plainly that detection was overridden and to what, so a forced
       result is never mistaken for a real one.
     - ACTUAL vs EFFECTIVE distinguished: when force-down is active, diagnostics
       must report (1) the ACTUAL detected set-A bits and XCR0 state, (2) the
       force-down request/mask, (3) the resulting EFFECTIVE capability set /
       maximum permitted tier, and (4) the selected tier and fallback reason. A
       deliberately masked bit must NEVER be reported as genuinely absent from
       the CPU - the real capability and the forced-down effective capability
       stay separately labelled.
   This lets 1B.3 test fallback dispatch without ever enabling unguarded
   execution. (Recorded here so it is not lost; it is scoped and built at 1B.3.)
```

This record is informative (not a controlling document); the charter and README
prevail. It exists so 1B.3 enforces exactly the psABI levels these objects
target - checking the runtime-checkable set A plus OS-state B, NOT Zig's full
resolved set C.

---

# 4. Validation commands and expected pass/fail

W3X runs the batch (build_1B2_v1.bat); W3C does not claim execution
(C-DELIV-07). The batch already sets up VsDevCmd, restores the working
directory, prints git status/HEAD, cleans .zig-cache and zig-out, and runs the
mode loop. The whole run must end with the batch's success banner, not :fail.

```text
[V1] The mode loop, for each of Debug ReleaseSafe ReleaseFast:
       zig build -Doptimize=<mode>
       zig build run -Doptimize=<mode>
       zig build vs-header-run -Doptimize=<mode>
       zig build test -Doptimize=<mode>
       zig-out\bin\deblock4_dll_smoke_test.exe
       zig build backend-isolation-run -Doptimize=<mode>
     EXPECT: all succeed in all three modes (UNCHANGED behaviour, now with the
             objects on the named levels). The AVX2 object must now BUILD with
             FMA in-target (the removed guard no longer fires).

[V2] EXPORTS gate (ReleaseFast artifacts), UNCHANGED from 1B.1:
       build_probe_value, generic_marker, scalar_marker PRESENT;
       sse41_marker, avx2_marker, and *_marker_anchor ABSENT.
     Any gated marker or anchor in .edata is an automatic FAIL.

[V3] SYMBOLS gates, UNCHANGED from 1B.1: each gated .obj has a marker on a
     SECTn line and non-zero .text.

[V4] NEW within-level gate (Part 3.1): per-object disassembly classified; each
     object emits nothing REQUIRING A HIGHER LEVEL than its own:
       v1 objects (generic, scalar): no instruction requiring x86_64_v2/v3/later
         (absence of VEX/AVX alone is NOT sufficient - also no SSE4.x/POPCNT/etc
         that are v2-or-higher);
       v2 object: no instruction requiring x86_64_v3 or later (no VEX/AVX/AVX2);
       v3 object: no instruction requiring a level above v3 (no AVX-512/EVEX).
     The automated deny-list gate FAILS loudly on every forbidden instruction or
     encoding IT detects. Complete per-object disassembly is retained for the
     explicitly manual remainder. Any out-of-level instruction found by EITHER
     the automated gate OR W3X's manual review is an overall scope FAIL. The
     batch/report must NOT claim exhaustive automated classification.

[V5] NEW vzeroupper finding (Part 3.2): the report records that the v3 probe
     emits no AVX/YMM (constant return), so no transition existed and vzeroupper
     was not applicable; the real transition proof is DEFERRED to Stage 5C.
     (This is a recorded deferral, not a pass/fail of a transition.)

[V6] Override-rejection gates, UNCHANGED from 1B.1:
       zig build -Doptimize=ReleaseFast -Dcpu=native   -> MUST be rejected
       zig build -Doptimize=ReleaseFast -Dtarget=native -> MUST be rejected

[V7] git diff --check and git status --short clean (no whitespace errors;
     only the permitted files changed).
```

Overall PASS = V1-V7 all as expected AND the Part 5 checklist satisfied AND the
Deblock4_Stage_1B2_WithinLevel_Report.md produced. Any regression in V2/V3/V6
(the 1B.1 proofs) is an automatic FAIL: this scope must not disturb the proven
mechanism.

---

# 5. Definition of done (checklist)

```text
[ ] build.zig: the three target queries use the NAMED psABI levels (v1/v2/v3)
    in full; the `.cpu_features_sub = ...{.fma}` line is DELETED from the v3
    target; nothing else in build.zig changed (addObject/imports/install/anchor
    wiring byte-unchanged).
[ ] the chosen level-definition mechanism is reported (named std model, e.g.
    std.Target.x86.cpu.x86_64_v2 / _v3 if they exist in this Zig 0.16 std, vs an
    explicit psABI featureSet fallback) with the exact identifiers used.
[ ] backend_probe_avx2.zig: the FMA-exclusion @compileError is removed; the
    positive guard and the marker (name/callconv/0x4442_3413) are unchanged.
[ ] backend_probe_sse41.zig: the positive sse4_1 guard kept; the negative guard
    reworded from "provisional contract" to an ACCURATE narrow description
    (unexpected AVX-family features outside the v2 contract - not claimed as a
    complete whole-level comparison); marker (0x4442_3412) unchanged.
[ ] build_1B2_v1.bat created from build_1B1_v7_3.bat with the NEW within-level
    classification gate added; the 1B.1 batch left in place; loud-fail structure
    preserved.
[ ] build_1B2_v1.bat follows the Part 3.1a authoring rules: fixed absolute
    working directory (no %~dp0); repeated code factored into a small set of
    CALL :label subroutines grouped by shell syntax (redirection and any pipe
    each confined to their own routine); all subroutine parameters are plain
    tokens (no parens/pipes/redirects/nested quotes/special chars); NO
    parentheses or special characters in any echo/comment/string/label; every
    existing gate's behaviour preserved.
[ ] within-level classification of all FOUR objects (generic->v1, scalar->v1,
    sse41->v2, avx2->v3) confirms each contains NO instruction requiring a
    HIGHER level than its own (v1: nothing requiring v2+, i.e. not merely
    "no AVX" but also no v2-only SSE4.x/POPCNT/etc; v2: nothing requiring v3+;
    v3: no AVX-512/EVEX), failing loudly otherwise. The automated portion may be
    a conservative deny-list covering every reliably detectable forbidden family
    per object, with complete disassembly retained and the remainder explicitly
    manual; the batch must NOT claim exhaustive automated classification.
[ ] the vzeroupper transition is recorded as DEFERRED per Part 3.2 (v3 probe
    emits no AVX/YMM; real proof owed at Stage 5C) - not claimed as settled.
[ ] Deblock4_Stage_1B2_WithinLevel_Report.md produced with contents A-H of
    Part 3.3, including the Stage 1B.3 detection-diagnostics (G) and debug-only
    force-down (H) obligations. The three feature sets are kept DISTINCT (A psABI
    runtime-checkable membership incl. OSXSAVE; B separate XGETBV/XCR0 OS-state
    register read; C Zig resolved set for reproducibility only, NOT imposed on
    the 1B.3 guard); sets from the toolchain.
[ ] the 1B.1 proofs still pass unchanged: gated markers + anchors ABSENT from
    the PE export table; generic/scalar/build_probe present; symbols/.text gates
    pass; -Dcpu/-Dtarget=native still rejected.
[ ] NO pixel/frame/copy/deblocking code; NO call to any gated backend (G5); NO
    -mcpu=native; NO exposed -Dtarget/-Dcpu override.
[ ] delivery per C-DELIV-01..08: whole-file for new files (the batch, the
    report), anchor-verifiable patch for the small build.zig/probe edits, exact
    manifest, honest SKIPs, no claimed execution.
```

---

# 6. Out of scope (do not do these)

```text
- Stage 1B.3 runtime detection / capability guard / dispatch table (this scope
  PRODUCES the requirements; 1B.3 implements them).
- Any backend KERNEL or pixel code; any call to a gated marker.
- Schedule A/B, midpoint scale, proper-chroma, or performance work.
- Touching the @extern anchor, the retention mechanism, or the export gate
  logic (only the target definitions and probe guards move).
- Introducing @mulAdd or any fused-multiply reliance.
- Any HolyWu / Classic / Deblock4 algorithm work (those are Stage 2C onward).
```

---

# 7. Notes for W3X (author's flags - not part of the coder's task)

```text
FLAG 1 (RATIFIED by W3X - stated for the coder, not an open question):
  Aligning the build TARGETS to the full named psABI levels (x86_64_v1/v2/v3)
  belongs in Stage 1B.2 and is part of this scope. The committed 1B.1 source
  still carries the OLD provisional targets (build.zig subtracts fma from the
  AVX2 target; backend_probe_avx2.zig has a guard that rejects fma). Those are
  leftover code, not current policy: the settled policy (charter G3, README
  12.3, decisions) is the named levels IN FULL, with FMA a normal member of v3
  (compiled in, not relied upon, kept non-fused by .strict). This scope brings
  the CODE into line with that settled policy. This is not an FMA decision and
  not under discussion - it is a code-catch-up to a decision already made.
  Rationale it belongs here: 1B.2 is defined as "confirm each object stays
  WITHIN its named level", which is only meaningful once the objects TARGET the
  named level; and the AVX2 object cannot compile as full v3 until the fma
  guard is removed.

FLAG 2 (owed input, not blocking): the exact HolyWu commit/tag for Classic's
  oracle (D-CLASSIC-4) is still owed but is NOT needed for Stage 1B.2 - it
  first matters at Stage 2C. The proposed HolyWu r9 release
  (https://github.com/HolyWu/VapourSynth-Deblock/archive/refs/tags/r9.zip) is a
  sensible candidate to PIN at that time; it is not consumed by this scope.

FLAG 3 (source-verified): this scope was reconciled against the ACTUAL
  committed source. Confirmed: the three FMA-subtracting target queries in
  build.zig; the FMA-exclusion @compileError in backend_probe_avx2.zig (which
  WILL break the build the moment v3 goes full, so its removal is mandatory, not
  optional); the object paths zig-out\backend-objects\*.obj and
  zig-out\bin\Deblock4.dll; the inspection dir zig-out\inspection\; and the
  complete existing stage batch build_1B1_v7_3.bat (which already does the
  EXPORTS/SYMBOLS/DISASM gates and the -Dcpu/-Dtarget=native rejection gates).
  The one thing NOT verifiable from here is whether std.Target.x86.cpu.x86_64_v2
  / _v3 exist as named models in this exact Zig 0.16.0 std - hence the
  investigate-with-fallback wording in Part 2.1.
```

---

*This scope is controlling for Stage 1B.2 only. The charter (v1.16) and README
(v1.9) prevail on any conflict. It authorises confirmation, target-definition
migration to named levels, and record production - no pixel, backend-execution,
or algorithm work.*
