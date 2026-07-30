# Deblock4 Stage 1B.3 Prep - Coder Research Tasks (W3C)

Version: v1.0
Audience: W3C (coder)
Encoding: US-ASCII only
Status: research/verification tasks, NOT an implementation scope. No production
code is written from this document. These two tasks produce the two settled
inputs that the Stage 1B.3 coder scope will then be built from.

Context in one line: Stage 1B.2 (committed) migrated the build targets to the
named x86-64 psABI levels (x86_64 / x86_64_v2 / x86_64_v3) and RECORDED the
runtime-guard requirements. Stage 1B.3 will IMPLEMENT and PROVE the runtime
capability guard that selects a tier on the actual CPU (whole-level dispatch
v3 -> v2 -> v1). Before that scope is written, two inputs must be nailed down.
This document requests independent research/verification on both.

Deliver each task as its own section with sources cited. Where your finding
disagrees with the starting material below, say so explicitly - that is the
point of asking. Do not resolve project-policy questions yourself; bring
discrepancies back to W3X.

---

## PART A - Authoritative set-A CPUID bit list per psABI level

### A.0 What "set A" means (so the task is unambiguous)

The Stage 1B.2 report separates THREE feature sets. Only set A is your subject
here:

- Set A = the runtime-CHECKABLE CPU capability bits that DEFINE each x86-64
  psABI level. This is the exact list Stage 1B.3's detection path will CPUID-
  check for whole-level satisfaction. It is the level contract.
- Set B = the SEPARATE AVX/YMM OS-state check (run XGETBV, read XCR0). It is a
  register read, NOT a CPUID membership bit, and NOT itself a level member. It
  is out of scope for Part A except where noted in A.2 item 4.
- Set C = Zig's full RESOLVED model feature set (from --show-builtin). It may
  include compiler codegen/tuning properties that CANNOT be CPUID-checked. It
  is recorded for build reproducibility only and must NOT be imposed on the
  runtime guard.

A tier is satisfied only when the CPU reports EVERY bit that level requires
(example: a CPU with AVX2 but without BMI2 is NOT v3). Accuracy here is load-
bearing: a wrong bit means a wrong tier selection, which under charter G5 can
mean an illegal-instruction fault. Treat this as safety-critical.

### A.1 Starting point (from THIS project's own toolchain output)

The following per-level ISA feature membership was extracted from this project's
own `zig build-exe --show-builtin` dumps for each named model
(zig_builtin_x86_64_v1/v2/v3.txt), with Zig tuning/codegen flags already
stripped out. Use it as the starting list to VERIFY and COMPLETE - not as
authority in itself:

```text
v1 (x86_64 baseline): 64bit, cmov, cx8, fxsr, mmx, sse, sse2, x87
v2 adds:              cx16, popcnt, sse3, ssse3, sse4_1, sse4_2, sahf, crc32 (*)
v3 adds:              avx, avx2, bmi (bmi1), bmi2, f16c, fma, lzcnt, movbe,
                      xsave, OSXSAVE
```

(*) I have flagged `crc32` and `sahf` as items whose psABI level assignment I
want you to double-check specifically; confirm or correct their placement.

### A.2 What to produce

Independently verify and complete the following, citing sources (Intel SDM
Vol 2 CPUID leaf/bit assignments; and the official x86-64 psABI document that
defines the microarchitecture levels - "System V Application Binary Interface,
AMD64 Architecture Processor Supplement", the microarchitecture-levels section):

1. A TABLE mapping, for EACH level (v1/v2/v3), every set-A feature to the exact
   CPUID query the runtime check must perform: CPUID leaf (EAX input, and ECX
   sub-leaf where relevant) + result register + bit position.
   Example row format:
     v3 | AVX2   | CPUID.(EAX=07H,ECX=0):EBX bit 5
     v3 | OSXSAVE| CPUID.(EAX=1):ECX bit 27
     v2 | SSE4.2 | CPUID.(EAX=1):ECX bit 20
   Cover every feature in the completed lists.

2. Cross-check each level's membership against the OFFICIAL psABI definition of
   x86-64-v1 / x86-64-v2 / x86-64-v3. Explicitly FLAG:
   - any feature in my starting list that the psABI does NOT require for that
     level (i.e. I over-listed), and
   - any feature the psABI DOES require that is MISSING from my starting list
     (i.e. I under-listed).
   Resolve the `crc32` / `sahf` question raised in A.1 as part of this.

3. Confirm OSXSAVE (CPUID.1:ECX.27) is correctly treated as a set-A v3
   MEMBERSHIP bit (it is a CPUID bit, so whole-v3 satisfaction must include it),
   and that it is DISTINCT from the set-B XGETBV/XCR0 register read. State the
   difference in one line: OSXSAVE says "XSAVE/XGETBV instructions are
   available"; the XCR0 read says "the OS is actually saving YMM state" - two
   different layers.

4. Identify any feature where "CPUID reports the bit present" and "the OS has
   actually enabled the state" can DIFFER (the AVX/YMM case). This is the seam
   between set A (membership) and set B (OS-state). You do not implement set B
   here; just confirm which features require the additional set-B check before
   their code may execute, so 1B.3 does not conflate presence with usability.

### A.3 Deliverable for Part A

The table from A.2 item 1, plus a short discrepancy note (A.2 item 2) listing
any add/remove against my starting list with the citation that justifies it.
This table becomes the detection contract for the Stage 1B.3 scope.

---

## PART B - How to compile the debug-only force-down override OUT of release

### B.0 What is being gated, and the hard requirement

Stage 1B.3 will include a DEBUG-ONLY, FORCE-DOWN capability override: a test
seam that forces selection of a LOWER tier than the CPU actually supports, so
the v3 -> v2 -> v1 fallback dispatch can be exercised on a single machine
(W3X's dev box is x86_64_v3, so without this seam the lower paths are never
taken). Safety model, per charter G5/G6:

- FORCE-DOWN ONLY. The override may MASK OFF capability bits the CPU genuinely
  has (forcing a lower tier - always safe, since running lower code on a higher
  CPU never faults). It must NEVER forge a bit the CPU lacks (forcing a HIGHER
  tier is the faulting footgun). A higher phantom capability must be
  STRUCTURALLY impossible, not merely discouraged.
- COMPILED OUT OF RELEASE. This is the research question. In a release build the
  override code must NOT EXIST in the binary - not "present but disabled by a
  runtime flag". The governing principle (the G6 lesson) is that "not compiled
  in" is a strictly stronger guarantee than "defaults to off".
- LOUDLY ANNOUNCED and ACTUAL-vs-EFFECTIVE distinguished (diagnostic behaviour;
  not part of this research question, listed for completeness).

The question for Part B is narrow and mechanical: what is the correct way, in
Zig 0.16.0, to make the force-down code CEASE TO EXIST in a release binary?

### B.1 What to research

Please independently research and report on the following, pinned to Zig
0.16.0 specifically (idioms have shifted across Zig versions, so cite the
version your findings apply to):

1. IDIOM. Is there an official / recommended Zig idiom for conditional
   compilation gated on a build option? The candidate we have in mind is:
   `b.option(bool, "enable_force_down", ...)` in build.zig, threaded into a
   generated options module (the `@import("build_options")` mechanism, or
   `Step.Options` / `addOptions`), then branched in source with
   `comptime` / `if (build_options.enable_force_down)`. Confirm the exact
   current 0.16 spelling of this (the build.zig API names, and the source-side
   import name), or provide the idiom Zig actually recommends now.

2. OMISSION GUARANTEE - THE KEY QUESTION. Does Zig's compilation model
   GUARANTEE that the disabled branch is OMITTED FROM THE BINARY (comptime /
   dead-code elimination so the code and any symbols it references are not
   emitted), or does it merely make the branch UNREACHABLE at runtime while the
   code still exists in the image? Our requirement is true omission. If a plain
   `if (build_options.flag)` only guarantees unreachability, tell us, and give
   the construct that DOES guarantee omission - e.g.:
     - a `comptime` branch / `inline` gate that is comptime-known false,
     - putting the seam in a separate file/module that is only imported when the
       option is set,
     - `@compileError` style structural exclusion,
     - or whatever Zig's actual guarantee mechanism is.
   Cite behaviour, do not assume it.

3. COMMON STANDARD. What is the commonly-applied pattern in real Zig 0.16
   projects for "debug-only test seams that must vanish in release"? Note any
   established convention and any pitfalls - for example, does merely importing
   the build_options module pull anything into the binary; does the optimize
   mode (Debug / ReleaseSafe / ReleaseFast) interact with dead-code elimination
   here; does runtime_safety matter.

4. COMPARISON TO C #ifdef. How does the Zig approach compare to the C/C++
   `#ifdef DEBUG` preprocessor model? Zig has no preprocessor; state whether
   Zig has a genuine structural equivalent (symbol simply does not exist) or a
   preferred different mechanism, and where each sits relative to our "must not
   exist in release" bar. W3X's slight prior lean is toward an "#ifdef-like"
   compiler-driven omission if Zig supports one - confirm whether it does.

5. GATE CHOICE. Which gate is cleanest for "exists only in debug/test builds":
   (a) a build-option boolean (b.option), (b) an optimize-mode check
   (`@import("builtin").mode`), or (c) a separate build target/step? Give a
   recommendation with rationale. Note in particular whether tying the seam to
   optimize mode is safe/appropriate, or whether an explicit opt-in option is
   preferable (we do not want the seam silently present in every Debug build if
   that is undesirable, nor absent when a tester needs it).

### B.2 Deliverable for Part B

A short comparison of the viable mechanisms, a clear RECOMMENDATION with
rationale, and - if possible - a MINIMAL illustrative example for Zig 0.16.0:
the build.zig option definition plus the source-side branch, showing the
release binary would not contain the seam. Flag explicitly whether your
recommendation delivers TRUE OMISSION (requirement met) or only unreachability
(requirement NOT met, needs strengthening).

### B.3 Note

W3X is also seeking an independent answer to this same question from another
assistant, and W3D (designer) is researching it in parallel. The three findings
will be compared. So: show your reasoning and cite the Zig-0.16-specific
behaviour you rely on, rather than giving a bare recommendation - the value is
in a verifiable answer that can be diffed against the others.

---

## Sequencing note

Neither task writes production code. Part A yields the detection bit-table;
Part B yields the chosen omission mechanism. With both settled, W3D writes the
Stage 1B.3 coder scope (detection core over set A + set-B XCR0 step; whole-level
v3->v2->v1 dispatch; requirement G diagnostics; requirement H force-down seam
using the Part B mechanism). The vzeroupper AVX-to-SSE transition proof remains
DEFERRED to Stage 5C and is NOT reopened at 1B.3.
