# Deblock4 - Verification and Tiering Decisions

**Version:** 1.1
**Date:** 2026-07-28
**Status:** Decisions of record (no longer under review). Durable capture of the
numerical-equivalence (verification) model and the CPU-tiering model, agreed by
W3X with W3D and W3C input, so the decisions and their reasoning are not lost
across chats. Items are marked INVARIANT (now lifted into charter v1.11 as
G3/G7/G8/G9 and F2) or SPECIFICATION (now lifted into README design spec v1.3).
The charter and README prevail for any controlling rule; this document records
what was decided, why, and the detail behind it.

v1.1 is a FULL FOLD: it absorbs the useful detail from the superseded discussion
paper (Deblock4_Floating_Exactness_and_Full_Declared_Tiers_Discussion, up to
v1.3) - the shared-kernel code model, the x86-64 level breakdown, the tolerance
work items T1-T7, prior-art findings, and the provisional policy wording - so
this is the single durable record and the discussion paper is retired.
**Encoding:** US-ASCII only.

**Origin:** settled during the post-Stage-1B.1 design discussion. Supersedes the
earlier twin-build proposal in
Deblock4_Design_Question_Three_Step_Verification_Model_v1_0.md (now withdrawn -
see section 6) and the coder discussion paper
Deblock4_Floating_Exactness_and_Full_Declared_Tiers_Discussion_v1_0.md (whose
direction was adopted).

---

# 1. The two decisions in one paragraph

Cross-backend BIT-EXACTNESS is replaced by SAME-ALGORITHM equivalence: integer
paths remain exact across all backends; float paths must implement the same
specified algorithm and agree within a measured tolerance, with hardware
accuracy gains (e.g. FMA) treated as a feature rather than a defect. CPU support
is expressed as three NAMED psABI LEVELS - x86_64_v1, v2, v3 - compiled with no
feature exclusions, dispatched by selecting the highest level the CPU fully
satisfies and falling back down the chain, with the selected level emitted to
stderr on every run.

---

# 2. Motivation

Bit-exactness across backends has no user-visible value in itself; it existed to
make SIMD verification against the readable scalar backend a mechanical yes/no
check. For deblocking already-noisy, blocky PAL VHS/MPEG-2 captures, forcing the
fast paths to match the least-capable backend bit-for-bit was assessed as
fixing things that are not broken and do not matter to the end result, at the
cost of constraining instruction sets the compiler and CPU are purpose-built to
use well. The ecosystem norm agrees: zsmooth ships ReleaseFast at x86_64_v3 and
accepts tiny float differences; classic Deblock does runtime scalar/SSE4.1
selection. Neither chases cross-backend bit-exactness.

The counter-consideration - that a relaxed goal must not let real bugs hide -
is addressed by keeping the scalar oracle and by keeping structural/edge checks
exact (section 3), and by the R76 miscompile guards (section 5).

---

# 3. The verification model

## 3.1 Integer paths: EXACT (INVARIANT)

All integer arithmetic produces bit-identical results across scalar, v2 and v3.
A defined integer algorithm has exactly one correct result, and the same integer
computation on wider instructions yields the identical value, so exactness costs
nothing and a tolerance there would only mask bugs. Integer output is exact and
reproducible, and this survives the no-exclusions tiering choice (section 4):
v3's additional integer instructions compute identical integer results; only
float rounding differs.

## 3.2 Float paths: SAME ALGORITHM WITHIN A MEASURED TOLERANCE (INVARIANT)

Float backends implement the same specified algorithm and must agree with the
scalar oracle within a tolerance that is deterministic per backend. Accuracy
improvements available on capable hardware (for example FMA's single-rounding
fused multiply-add on v3) are acceptable and are treated as a feature, not a
defect.

## 3.3 One production build per backend (SPECIFICATION)

There is a single production build per backend, compared directly against the
ReleaseSafe scalar oracle. The earlier twin-build (constrained + unconstrained)
model is dropped (section 6).

## 3.4 Structural and edge checks stay EXACT and loud (INVARIANT)

Even under float tolerance, the following are checked EXACTLY and fail loudly on
any mismatch, because the dangerous SIMD defects are structural, not rounding:
lane mapping, saturation, widen/narrow, transpose/shuffle, tail handling,
bounds, dispatch selection, and decision masks. A tolerance applies ONLY to
final float magnitudes, never to these.

## 3.5 Near-threshold decision flips: ACCEPTABLE for this material (DECISION)

Where a small float rounding difference lands at a filter on/off decision
threshold and flips the decision for a pixel, that is accepted for this
material (noisy VHS), bounded by the final-output tolerance. A single pixel
occasionally filtered-or-not on already-noisy content is immaterial. This is a
deliberate call for Deblock4's domain, not a general rule.

## 3.6 Float mode: .strict (INVARIANT)

Float kernels are compiled with an explicit .strict float mode at kernel scope.
Production is ReleaseFast; .strict and ReleaseFast are independent controls.
.strict prevents the compiler from reordering/contracting float operations
(including auto-fusing a*b+c into an FMA), which keeps scalar-vs-SIMD
differences to genuine rounding and simplifies bug detection. There is NO
@mulAdd requirement: not subtracting FMA is not the same as requiring it
(section 4.4).

## 3.7 Scalar oracle, and ReleaseFast-vs-ReleaseSafe scalar check (SPECIFICATION)

The ReleaseSafe scalar backend is the ground-truth oracle. Additionally, each
release proves the ReleaseFast production scalar backend against the ReleaseSafe
scalar oracle before it is used as the reference for the SIMD comparisons, so
that ReleaseFast optimisation has not itself changed the scalar result. (Coder
Q9, adopted.)

## 3.8 Tolerance methodology (W3D ACTION; numbers deferred to Stage 2)

The tolerance is DERIVED, then STRESS-TESTED, not fitted to the largest observed
difference:

```text
metrics (to be finalised by W3D): per-pixel maximum absolute difference; a
    count of samples exceeding a small threshold; and, separately and EXACTLY,
    decision-mask agreement. ULP/relative measures considered where meaningful.
evidence required before freezing a tolerance:
    - an analytical bound on the operation chain (e.g. FMA single-vs-double
      rounding) where derivable;
    - threshold-neighbour synthetic inputs (values engineered near decision
      boundaries);
    - random float inputs, including non-finite and signed-zero cases;
    - a real VHS corpus;
    - a SEPARATE confirmation corpus NOT used to choose the bound.
```

Only the METHODOLOGY is settled now. The tolerance VALUES cannot be fixed until
real kernels exist (Stage 2), because only then are the actual differences
known.

---

# 4. The tiering model

## 4.1 Three named psABI levels, no exclusions (INVARIANT + SPECIFICATION)

CPU support is expressed as three levels from the x86-64 psABI
microarchitecture-level standard (maintained by the System V x86-64 ABI group -
AMD, Intel, and others - and adopted by GCC, LLVM/Clang and glibc; Zig targets
the same named levels):

```text
x86_64_v1   baseline AMD64 (SSE, SSE2). Every 64-bit CPU. -> generic/scalar.
x86_64_v2   adds SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT.      -> SSE4.1-class.
x86_64_v3   adds AVX, AVX2, BMI1, BMI2, FMA, F16C, LZCNT,
            MOVBE (AVX/AVX2 requiring OSXSAVE).            -> AVX2 backend.
(x86_64_v4  adds AVX-512 subsets. OUT OF SCOPE - no W3X hardware to verify it.)
```

The levels are compiled with NO feature exclusions - the full declared tier.
The tier's feature set IS the published level contents; it is not a bespoke,
per-build measured closure. This is simpler and drift-proof: target and
detection both refer to the same named level.

## 4.2 Dispatch: highest fully-satisfied level, with fallback (INVARIANT)

```text
for tier in [v3, v2, v1]:            # highest first
    if cpu_satisfies_entire_level(tier):
        select tier; stop
# v1 always satisfies, so selection always succeeds
```

## 4.3 WHOLE-LEVEL detection (INVARIANT - the one real trap)

Detection requires the ENTIRE level, never the headline instruction. A CPU with
AVX2 but missing any other v3 feature (e.g. BMI2) is NOT v3 - it is v2. The
compiler, given a v3 target, may emit any v3 instruction anywhere in the object,
so a naive "has AVX2?" check followed by running the v3 backend would crash with
an illegal instruction on such a CPU. This is the one combination that is
actually dangerous, and it is prohibited.

Accepted trade: whole-level detection is slightly COARSER than a bespoke
per-feature check - a CPU with AVX2 but missing one v3 feature runs the v2
backend even though a hand-built bare-AVX2 backend could have run on it. Those
CPUs are rare; the simplicity and safety of whole-level detection is worth
excluding them from the top tier. (Same bet zsmooth makes.)

## 4.4 FMA in v3: present but unused under .strict (DECISION)

v3 includes FMA and it is not excluded, so the v3 object MAY contain FMA. Under
.strict (section 3.6) the compiler will not auto-fuse a*b+c, so FMA remains
present-but-unused unless a future MEASURED decision explicitly selects @mulAdd.
"Do not subtract FMA" and "require FMA" are separate decisions; only the former
is made.

## 4.5 Terminology and native-target rule (SPECIFICATION)

The term is "full declared tier", not "unconstrained" (which risks being
misread as native-host targeting). Distributed objects are NEVER built for
W3X's native CPU; each backend targets its declared psABI level.

## 4.6 Detection implementation (DEFERRED to Stage 1B.3)

Prefer an existing standards-compliant conformance check. Investigation order:
Zig std.Target's own level definitions (drift-proof, since target and detection
then share one source of truth) and any ready-made "CPU satisfies level X"
helper; failing that, assemble the check from the std feature-set constant plus
a runtime CPUID query; zsmooth and VapourSynth are proven references (VapourSynth
performs whole-level detection with fallback at the framework level, and even
tunes level membership - the R78 avx512bf16 relaxation). Any function we write
is psABI-compliant by construction because it checks the standard per-level
feature list.

---

# 5. R76-class miscompile risk and its permanent mitigations (INVARIANT guards)

Named after the VapourSynth R76 fix, where certain compilers occasionally
compiled the AVX2 path of some internal filters (maximum, minimum, 3x3
convolution) so as to produce garbage pixels along frame edges. Corroborated by
an AviSynth+ precedent (Visual Studio 2017 miscompiled an AVX2 merge path) and
by independent GAIS analysis.

Nature: a compiler CODE-GENERATION defect - correct source, wrong machine code -
clustering at EDGES and TAILS (partial final vectors and image-boundary
handling), which is exactly where a deblocker operates. The symptom is gross
"garbage edge" corruption, NOT rounding. It is therefore caught trivially by
differential testing (garbage vastly exceeds any tolerance band), and it
REINFORCES the scalar oracle and the exact structural/edge checks rather than
threatening the relaxed-tolerance model.

Three permanent mitigations:

```text
M1  Test corpus MUST include non-vector-width-multiple dimensions with strong
    boundary edges (e.g. 711x480) to force the tail path to execute.
M2  The scalar-vs-SIMD differential is a STANDING gate, re-run on EVERY Zig or
    LLVM version bump. "Certain compilers" means the risk is toolchain-version
    dependent and can appear from a compiler update alone, with source
    unchanged.
M3  Retain .strict (section 3.6), which avoids the aggressive float rewrites
    most associated with this class of defect.
```

Related, deferred (README 12.7 territory): the AVX-SSE transition penalty /
vzeroupper question raised by GAIS. Noted for the kernel/dispatch work; not a
correctness issue, a performance one, and not settled here.

---

# 6. Withdrawn / superseded alternatives (recorded so they are not revisited)

```text
- Cross-backend BIT-EXACTNESS as the shipping goal: superseded by section 3
  (integer exact / float tolerance).
- The TWIN-BUILD model (a constrained bit-exact build plus an unconstrained
  release build, verified against each other): withdrawn. It doubled the build
  matrix and, in the naive form, risked shipping a build different from the one
  bit-exactly verified. Replaced by one production build per backend compared
  directly to the scalar oracle (section 3.3).
- Per-build BESPOKE feature closures: replaced by named psABI levels
  (section 4.1), which are simpler and drift-proof.
- Feature EXCLUSIONS for float identity (e.g. subtracting FMA from v3):
  dropped in favour of full declared tiers plus .strict (sections 3.6, 4.4).
```

---

# 7. Diagnostics and reproducibility

## 7.1 Always-on version and tier emission (SPECIFICATION)

The version marker and the SELECTED tier are emitted to stderr on every run,
always-on (ffmpeg-style), NOT behind the gated debug path. This makes
"which tier ran" immediately visible for support and performance triage
(e.g. a user reporting slowness -> confirm which tier was selected and why a
higher one was not).

## 7.2 Reproducibility contract (SPECIFICATION - wording to finalise)

```text
- a forced backend="scalar" selection is available;
- the selected backend is recorded in frame properties;
- float cross-MACHINE byte-identity is explicitly NOT promised;
- integer output IS exact and reproducible;
- a given backend is deterministic run-to-run on the same machine
  (determinism is non-negotiable and is unchanged by any of the above).
```

---

# 8. Architecture note (affirmed, unchanged)

The shared kernel is the DEFAULT: one common_math.zig with compile-time
width/type configuration, and backend-specific code ONLY for data movement
(loads, transposes, shuffles, packing, tail handling, stores) where the vector
shape genuinely differs. Backend-specific divergence carries the burden of
proof: it is permitted only where vector movement or lowering genuinely differs,
not as a general licence. "Same code base" does not mean identical source on
every line, but the shared kernel is what divergence must be argued away from,
not toward.

G5, G6, the Stage 1B.1 one-DLL object structure, the @extern anchor mechanism,
and the scalar-oracle role are all UNCHANGED by the decisions in this document.

---

# 9. Status of the coder's twelve questions

```text
Q1  integer exact / float tolerance                       DECIDED (3.1, 3.2)
Q2  near-threshold decision flips acceptable              DECIDED (3.5)
Q3  tolerance metrics                                     METHODOLOGY (3.8);
                                                          numbers at Stage 2
Q4  tolerance evidence set                                METHODOLOGY (3.8);
                                                          numbers at Stage 2
Q5  exact feature sets per tier                           DECIDED in principle:
                                                          the named-level
                                                          contents (4.1);
                                                          1B.2 confirms objects
                                                          stay within level
Q6  named level vs explicit features                      DECIDED: named (4.1)
Q7  FMA subtract vs require                               DECIDED: neither (4.4)
Q8  explicit .strict at kernel scope                      DECIDED (3.6)
Q9  ReleaseFast scalar proven vs ReleaseSafe oracle       DECIDED: yes (3.7)
Q10 reproducibility controls                              DECIDED in substance
                                                          (7.2); wording to
                                                          finalise
Q11 1B.2 shape (one closure per backend)                  DECIDED (4.1, 5)
Q12 which documents to amend                              this record, then
                                                          charter + README
```

---

# 10. Follow-on documents

```text
DONE:
- Charter amendment v1.10 -> v1.11: G3 rewritten (named psABI tiers, whole-level
  dispatch); G7 added (integer-exact/float-tolerance); G8 added (.strict); G9
  added (R76 standing differential gate); F2 updated (contraction prevented by
  .strict, not FMA exclusion).
- README design spec v1.2 -> v1.3: sections 1.1, 4.3, 8.6, 12.3, 12.8 (corrected
  G6), 13.6 (new: stderr emission + reproducibility), 14.3/14.7/14.8, F10, and
  the decision-status table.
- Discussion paper folded into this record and retired (see section 11 origin).

OUTSTANDING:
- W3D designer response to W3C: endorse the direction and answer the twelve
  questions per section 9. (The answers are settled here; the response is the
  coder-facing delivery of them.)
- Stage 1B.2: confirm each object stays within its named level.
- Stage 1B.3: implement whole-level detection (section 4.6); freeze tolerance
  numbers once real kernels exist.
```

---

# 11. Folded-in detail (from the retired discussion paper)

## 11.1 Shared-kernel code model

The shared mathematics is instantiated at compile time for backend width and
element type. Conceptually:

```zig
const BackendConfig = struct {
    vector_bytes: comptime_int,
};

const sse41 = BackendConfig{ .vector_bytes = 16 };
const avx2  = BackendConfig{ .vector_bytes = 32 };
```

with vector lanes derived from element size:

```zig
fn Vec(comptime cfg: BackendConfig, comptime T: type) type {
    return @Vector(cfg.vector_bytes / @sizeOf(T), T);
}
```

The same backend width therefore produces different lane counts for u8, i16,
i32 and f32 without maintaining independent formula implementations.

Source split: SHARED mathematical source (differences, comparisons, threshold
selection, masks, arithmetic, clipping, selection, algorithm order); BACKEND-
SPECIFIC adapters only where required (entry points, loads/stores, widening/
narrowing, packing, transposes, cross-vector shuffles, awkward vertical access,
tail handling). Backend-specific duplication must justify itself with a concrete
reason (different transpose/shuffle structure, different packing, different tail
strategy, a Zig lowering limitation, clearer proof, or measured machine-code
improvement) - never merely because the backend names differ.

## 11.2 The x86-64 psABI microarchitecture levels

Defined by a collaboration of Linux distributors (Red Hat, SUSE, Canonical) and
processor manufacturers (Intel, AMD), adopted by GCC, LLVM/Clang and glibc; Zig
targets the same named levels. Each level is a strict superset of the previous.
Consult the psABI specification for the authoritative per-level list.

```text
x86-64-v1  (baseline)   CMOV, CX8, FPU, FXSR, MMX, OSFXSR, SCE, SSE, SSE2.
                        Universal fallback; almost every 64-bit CPU.
x86-64-v2  (~2008-2010)  SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT, CMPXCHG16B,
                        LAHF-SAHF. Minimum baseline for e.g. Windows 11.
x86-64-v3  (AVX2)       AVX, AVX2, BMI1, BMI2, F16C, FMA, LZCNT, MOVBE,
                        OSXSAVE. 256-bit registers. Most mainstream consumer
                        CPUs of the last decade support it.
x86-64-v4  (AVX-512)    AVX512F/CD/DQ/BW/VL. OUT OF SCOPE - no W3X hardware to
                        verify; many consumer chips omit AVX-512.
```

Deblock4 maps scalar->v1, SSE4.1->v2, AVX2->v3, each used in full.

## 11.3 Tolerance work items (T1-T7)

These expand section 3.8. Methodology is settled now; the numeric values are
frozen only once real kernels exist (Stage 2).

```text
T1 Scope         tolerance applies to FLOAT formats only; integer stays exact.
T2 Invariants    which internal results stay EXACT across float backends:
                 edge eligibility, threshold-set selection, non-finite masks,
                 filter-activation masks, branch choices, clipping class, the
                 canonical schedule, border/tail decisions.
T3 Decision      may a near-boundary float difference flip a filter-activation
   boundary       decision if the final output stays within a separate bound?
                 DECIDED (section 3.5): yes, acceptable for this material.
T4 Metrics       acceptance-critical set: exact structural/classification
                 gates; max absolute output difference; ULP reporting; explicit
                 decision-mask reporting; worst-case sample capture. Mean/RMS
                 alone is insufficient.
T5 Derivation    analytical error bound from the real float operation chain,
                 distinguishing ordinary rounding, cancellation, comparison
                 boundaries, output conversion, and any future fused op.
T6 Corpora       synthetic threshold-neighbour cases; exact halfway-rounding;
                 extreme finite values; signed zero; subnormals; NaN/Inf per
                 policy; minimum dimensions; partial vectors/tails; random
                 float vectors; representative noisy VHS/DVD material; and a
                 SEPARATE confirmation corpus not used to choose the bound.
T7 Freeze rule   the final tolerance must NOT merely equal the largest
                 development-corpus difference; it needs margin, analytical
                 support, and independent confirmation before becoming
                 normative.
```

## 11.4 Prior-art findings

```text
zsmooth           maintains scalar + vector implementations and tests both;
                  ReleaseFast production; publishes fixed cross-target builds;
                  its public Windows AVX2 build uses a declared architecture
                  level (x86_64_v3), not the native machine; accepts very small
                  float differences in at least one documented precision/perf
                  trade-off. Supports: shared algorithm + optimised backends,
                  declared tiers, evidence-based acceptance of negligible float
                  differences. NOT a direct template - its packaging/dispatch
                  differs from Deblock4's one-DLL internal dispatch. A full
                  source/flag audit is owed before it is normative precedent.
classic Deblock   scalar/C + SSE4.1 + runtime backend selection, integer and
   (HolyWu)        float. Confirms the public algorithm can coexist with several
                  machine implementations without backend selection entering the
                  filter interface. Does not settle AVX2 policy, FMA, Zig
                  compile-time vector config, tolerance, or one-DLL linkage.
VapourSynth       performs whole-level detection with fallback at the framework
                  level (baseline / AVX2 / AVX-512 / zen4), and even tunes level
                  membership (R78 relaxed the zen4 check to exclude avx512bf16
                  since compilers never emit it alone). Best reference for how a
                  framework defines and checks levels.
```

Existing mature code supports getting out of the compiler's way on scheduling,
registers, legal instruction selection, vector lowering, and ordinary
target-specific optimisation - but does NOT remove Deblock4's own validation of
lane mapping, edge footprints, canonical order, vertical/horizontal
dependencies, tails, transpose/shuffle correctness, runtime feature closure,
bounds, and output comparisons. Stop policing negligible rounding for identity;
keep testing the structural errors that produce materially wrong pixels.

## 11.5 Provisional policy wording (seed for controlling docs)

Recorded as the seed the README v1.3 amendment drew from; retained for
traceability.

> Deblock4 implements one specified deblocking algorithm through scalar,
> SSE4.1, and AVX2 production backends. Shared mathematical source is
> instantiated at compile time for the backend's vector width and arithmetic
> type; backend-specific code is limited to entry points and data movement
> where the hardware shape or clear code generation requires it. Production
> objects use ReleaseFast, explicit strict floating-point semantics, and their
> full declared and runtime-guarded feature tiers; features are not subtracted
> merely to force floating-point byte identity; distributed objects are never
> compiled for an uncontrolled native-host CPU. One production form of each
> backend is built and compared directly against the canonical ReleaseSafe
> scalar oracle. Integer outputs remain exact across backends. Floating-point
> outputs implement the same specified algorithm and remain deterministic per
> backend, but may differ within a measured, analytically supported, and
> adversarially validated tolerance. Zig's .strict float mode is stated
> explicitly at the authoritative float kernel scope; no @mulAdd requirement is
> imposed.

## 11.6 Strongest argument against the change (recorded)

Cross-machine reproducibility: the same script and float input may produce
different frame bytes on different CPUs because automatic dispatch selects a
different backend. This can affect hashes, cached results, distributed
rendering, regression comparisons, and bug reproduction. Assessed manageable
because: the differences are (expected to be) negligible; each selected backend
is deterministic; the selected backend and tier are diagnosable (frame property
+ always-on stderr); users can force backend="scalar"; integer output stays
exact; and the float reproducibility contract is stated honestly (section 7.2).

---

# 12. Revision history

```text
v1.1  Full fold. Marked the decisions as of-record rather than under review;
      recorded that charter v1.11 and README v1.3 amendments are DONE; absorbed
      the useful detail from the (now retired) discussion paper as section 11
      (shared-kernel model, psABI level breakdown, tolerance T1-T7, prior art,
      provisional policy wording, strongest counter-argument). This is now the
      single durable record for the verification and tiering decisions.
v1.0  Initial decision record capturing the verification (integer-exact /
      float-tolerance) and tiering (named psABI levels, whole-level fallback)
      models, R76 guards, withdrawn alternatives, and the coder-question status.
```

---

*Informative knowledge capture so these decisions and their reasoning are not
re-derived in a later chat. The charter and README prevail for any controlling
rule. The discussion paper (Deblock4_Floating_Exactness_and_Full_Declared_Tiers_
Discussion) is superseded by this record and should be retired.*
