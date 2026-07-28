# Deblock4 - Discussion Paper: Same-Algorithm Tolerance and Full Declared Backend Tiers

**Version:** 1.3  
**Date:** 2026-07-28  
**Status:** W3X CURRENT POSITION FOR W3D REVIEW. Not yet a controlling specification, charter amendment, or coding scope.  
**Requested by:** W3X  
**Assessment by:** W3C  
**Encoding:** US-ASCII only

**Revision note:** v1.3 reconciles the paper with the decisions reached in the
tail of the design discussion (some of which were lost from the failing designer
chat and have since been recovered). The substantive corrections are: the named
psABI microarchitecture levels ARE the tier feature closures (Stage 1B.2
confirms an object stays within its level rather than discovering a bespoke
closure); several previously-open questions are now decided (integer exactness,
FMA/BMI inclusion via the level, named-level vs explicit-features, selected-tier
reporting); always-on stderr emission of version and selected tier is added; and
the R76 miscompile mitigations are named explicitly. No change of direction from
v1.2; these are conformance corrections. v1.2 recorded the position mid-way
through a failing chat and is superseded. v1.1 changed only the header.

---

## 0. Substantive changes since v1.0

The following points are no longer merely candidate options in this discussion.
They are W3X's current position, subject to W3D review and formal adoption:

1. The cross-backend shipping goal should change from universal bit-exact
   output to implementation of the same specified algorithm, with
   yet-to-be-derived numerical tolerances where floating-point evaluation
   legitimately differs.
2. Each backend should use its **full declared tier**. Features should not be
   subtracted merely to preserve floating-point identity unless a demonstrated
   correctness, compatibility, or quality requirement justifies the
   subtraction.
3. "Full declared tier" replaces "unconstrained hardware target." It means a
   fixed, explicit, runtime-guarded feature contract. It does not mean native
   build-machine targeting or general fast-math.
4. Distributed Deblock4 objects are not compiled for W3X's native CPU. This was
   already settled and remains settled.
5. Deblock4 should build one production form of scalar, SSE4.1, and AVX2 rather
   than constrained and unconstrained twins.
6. Each production SIMD backend should be compared directly against the
   canonical scalar oracle.
7. The intended implementation remains a common mathematical source base,
   instantiated at compile time for backend width and element type, with
   backend-specific code only where data movement or ABI shape genuinely
   requires it.
8. Production float kernels should use `ReleaseFast` and explicit strict
   floating-point semantics:

   ```zig
   comptime {
       @setFloatMode(.strict);
   }
   ```

9. There is no present requirement to express arithmetic using `@mulAdd`.
10. W3D advice is required on the eventual tolerance derivation, metrics,
    corpus, and acceptance thresholds.
11. The tiers are the named psABI microarchitecture levels used in full:
    x86_64_v1 (scalar), x86_64_v2 (SSE4.1-class), x86_64_v3 (AVX2). The tier
    feature set is the published level, not a bespoke per-build closure, so
    Stage 1B.2 CONFIRMS each object stays within its level rather than
    discovering a closure. Dispatch checks for the v3 level first and, if the
    CPU satisfies it IN FULL, uses v3; otherwise it falls back to v2 on the
    same whole-level basis, and to v1 (the always-satisfied catch-all) if v2 is
    not satisfied. FMA is part of v3 and is not subtracted for identity; under
    strict semantics it is not required to appear.

---

## 1. Purpose

This paper records W3X's current position, checks it against the existing
Deblock4 architecture and selected prior art, gives W3C's assessment, and
identifies the matters still requiring W3D/W3X decision.

The central question is whether Deblock4 should continue to require
cross-backend bit-exact floating-point output, or instead require the same
specified algorithm with measured and justified tolerances between the
production scalar, SSE4.1, and AVX2 backends.

This discussion does not alter:

- G5 or G6;
- the Stage 1B.1 one-DLL object architecture;
- runtime CPU and operating-system capability guarding;
- the canonical vertical-then-horizontal schedule;
- plane footprints, bounds, tails, or dependency rules;
- the canonical scalar implementation as the readable algorithm oracle;
- deterministic output from a given selected backend.

---

## 2. W3X current position

W3X's current position is:

> For Deblock4's intended use on already poor, visibly blocky, luma-noisy and
> chroma-noisy VHS-derived captures, the numerical effect of FMA and ordinary
> floating-point backend rounding differences is ASSESSED (not yet measured) as
> likely negligible in relation to the restoration objective. The measurement
> that would confirm this is deferred to the real-kernel stage (section 9);
> the direction below is taken on that expectation, to be validated by evidence.
>
> The project risks spending design and validation effort on differences that
> are not practically broken and do not matter to the end result.
>
> W3X therefore prefers:
>
> 1. Change the output goal from universal cross-backend bit exactness to the
>    same specified algorithm, with tolerances to be assessed and determined.
> 2. Give scalar, SSE4.1, and AVX2 their full declared hardware tiers.
> 3. Skip constrained-versus-scalar and
>    unconstrained-versus-constrained twin-build comparisons.
> 4. Compare the actual production scalar backend directly with each actual
>    production SIMD backend, measure the differences, and identify the
>    smallest reasonable tolerances supported by evidence.
> 5. Preserve a common code base for SIMD mathematics, selected or
>    instantiated by compile-time vector width/lane configuration, with minimal
>    backend-specific source.
> 6. Do not constrain compilers or CPUs without a demonstrated reason.
> 7. Keep distributed targets fixed and declared; never compile them for the
>    native build machine.
> 8. Use `ReleaseFast` and explicit `.strict` floating-point semantics.
> 9. Do not require `@mulAdd` at this stage.
> 10. Seek W3D advice before making the tolerance contract normative.

W3C agrees with this direction, subject to the qualifications in this paper.

---

## 3. Existing Deblock4 architecture already supports the intended common code base

W3X's recollection is correct. The Deblock4 design already calls for shared
generic mathematics instantiated under backend-specific compile-time widths.

The conceptual configuration is:

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

The same backend width therefore produces different lane counts for `u8`,
`i16`, `i32`, and `f32` without maintaining independent formula
implementations.

The intended source split is:

```text
shared mathematical source:
    differences
    comparisons
    threshold selection
    masks
    arithmetic
    clipping
    selection
    algorithm order

backend-specific adapters where required:
    entry points
    loads and stores
    widening and narrowing
    packing
    transposes
    cross-vector shuffles
    awkward vertical access
    tail handling
```

The architecture is therefore:

```text
one specified algorithm
    + shared scalar/vector mathematics
    + compile-time backend configuration
    + narrow hardware-shape adapters
    + separately targeted machine-code objects
```

### W3C assessment

This remains the correct target.

"Common code base" should mean one mathematical implementation and minimal
target-specific adapters. It should not require identical source text where
the hardware data-movement shape differs. Forced genericity can obscure
ownership, bounds, dependency, and lane-layout proofs or generate materially
worse code.

Backend-specific duplication should require a concrete reason, such as:

- different transpose or shuffle structures;
- different vector packing;
- different tail strategy;
- a Zig lowering limitation;
- clearer proof or maintenance;
- measured machine-code improvement.

It should not arise merely because the backend names differ.

---

## 4. Zig 0.16: fast optimisation and accurate semantics

## 4.1 `ReleaseFast` and floating-point mode are independent

`ReleaseFast` requests production optimisation. It does not automatically
select Zig's result-changing `.optimized` floating-point mode.

Under `ReleaseFast`, the compiler remains free to optimise:

- inlining;
- constant propagation;
- dead-code elimination;
- loop transformation;
- vectorisation where semantics permit;
- instruction scheduling;
- register allocation;
- load/store organisation;
- target-specific instruction selection;
- code layout.

Zig's `.strict` mode constrains transformations that would change the
specified floating-point result or exceptional-value semantics. It does not
disable normal optimisation.

The intended production combination is therefore:

```text
ReleaseFast
+ fixed full declared CPU tier
+ strict floating-point semantics
```

This expresses W3X's goal accurately:

> Tell the compiler to be fast, while requiring the declared arithmetic
> semantics to remain accurate.

## 4.2 Explicit strict mode

Zig 0.16 uses `.strict` by default, so no source statement is technically
required merely to obtain strict behaviour.

W3X nevertheless strongly prefers, and W3C supports, an explicit authoritative
declaration to use `.strict` in all cases everywhere in this project:

```zig
comptime {
    @setFloatMode(.strict);
}
```

This is valuable because it:

- states the numerical contract at the enforcement point;
- prevents confusion between `ReleaseFast` and fast-math;
- protects the kernel from a future enclosing `.optimized` declaration;
- is easy to inspect and test;
- avoids scattering redundant declarations through every helper.

The exact placement should be selected for every module/function as appropriate
to ensure that it explicitly and visibly applies everywhere.

## 4.3 `@mulAdd` is not required

There is no present requirement to change ordinary source expressions to
`@mulAdd`.

These are separate choices:

```text
FMA is present in the AVX2 feature tier.
The algorithm explicitly requires fused one-rounding multiply-add semantics.
```

The first does not imply the second.

Under `.strict`, an ordinary source expression:

```zig
a * b + c
```

retains its specified non-fused evaluation where contraction would change the
result. Enabling the FMA CPU feature merely makes the instruction available
when a legal strict-semantics use exists.

`@mulAdd` would deliberately define fused one-rounding semantics. That is an
algorithmic decision which must be ratified by W3X - W3X is not against use of
FMA and may even prefer it, however W3X prefers conjecture and testing and
evidence to assist in decision making on whether to depart from our
standard zig @vector approach.

Current position:

```text
- do not subtract FMA merely for cross-backend identity;
- do not require FMA use;
- do not require `@mulAdd`;
- let Stage 2 measurements decide whether an explicit fused operation is ever
  worthwhile.
```

## 4.4 No public "strict except automatic contraction" mode

Zig 0.16 publicly exposes `.strict` and `.optimized`. It does not expose a
supported middle mode meaning:

```text
strict arithmetic except permit result-changing automatic FMA contraction
```

`.optimized` is a general fast-math bundle, not a simple "more effort" or
"more accurate" switch.

W3X has now rejected general fast-math as the default because it can permit
accuracy-reducing or semantic-changing transformations beyond FMA.

The selected direction is therefore:

```text
ReleaseFast
+ `.strict`
+ full declared tier
+ no identity-driven feature subtraction
```

---

## 5. Full declared tiers

The phrase **full declared tier** is adopted for this discussion.

It means:

Every feature positively included in the backend's stated contract may be
used by the compiler, and runtime checking and dispatch proves support for the
whole compiled closure before the backend can execute.

The x86-64 Microarchitecture Levels are defined by a collaboration of Linux distributors
(Red Hat, SUSE, Canonical) and processor manufacturers (Intel, AMD).
These levels act as instruction set baselines, grouping together various CPU extensions
introduced over the years. They allow software developers to compile code optimized
for newer hardware without having to check for dozens of individual CPU flags.
Each level is a strict subset of the next (e.g., a v3 CPU supports everything in v1 and v2).

Breakdown of Each Level (check the collaoration specification for precise details):

**x86-64-v1 (The Baseline)**    
This represents the foundational implementation of the 64-bit architecture.
Almost any 64-bit computer in existence supports this level.
Instruction extensions included (check the spec for the full list): 
CMOV, CX8, FPU, FXSR, MMX, OSFXSR, SCE, SSE, SSE2.
Significance: Serves as the universal fallback binary standard for nearly all Linux distributions.

**x86-64-v2 (The Vector Era Vectorization)**    
This level introduces advanced vector expansions and popcount logic. 
It targets hardware that was manufactured roughly after 2008-2010.
Instruction extensions included (check the spec for the full list): 
SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT, CMPXCHG16B, LAHF-SAHF.
Significance: This is the minimum baseline required by modern software platforms, including
Windows 11 and various modern Linux builds.

**x86-64-v3 (The AVX2 Standard)**    
This standard marks a massive jump in performance for multimedia, database operations, and machine
learning because it introduces 256-bit vector registers.
Instruction extensions included (check the spec for the full list):
AVX, AVX2, BMI1, BMI2, F16C, FMA, LZCNT, MOVBE, OSXSAVE.
Significance: Major enterprise operating systems like Red Hat Enterprise Linux 10 require v3 as a
hard baseline.
Most mainstream consumer processors built over the last decade fully support it.

**x86-64-v4 (The AVX-512 Tier)**    
The highest standardized microarchitecture level focuses primarily on ultra-wide 512-bit
vector processing.
Instruction extensions included (check the spec for the full list):
AVX512F, AVX512CD, AVX512DQ, AVX512BW, AVX512VL.
Significance: It is used predominantly in high-performance computing (HPC) nodes, heavy
rendering, and server environments. 
Many consumer-tier processors (and Intel hybrid chips with "E-cores") omit AVX-512,
meaning they cannot run v4 software natively.

It does not mean:    
- `-Dcpu=native`;
- the build machine's exact processor;
- every feature supported by W3X's CPU;
- general fast-math;
- unguarded instruction use;
- features outside the declared runtime check;
- an architecture-level shorthand adopted without measuring its complete closure.

Conceptually:

```text
scalar/generic tier:
    deliberate lowest supported x86-64 baseline

SSE4.1 tier:
    full explicit feature closure required by the SSE4.1 object

AVX2 tier:
    full explicit feature closure required by the AVX2 object
    potentially including FMA where the tier deliberately includes it
```

### Settled point: no native distributed objects

Distributed Deblock4 objects are not compiled for W3X's native processor.

This remains settled because native targeting can silently add assumptions such
as BMI, BMI2, LZCNT, POPCNT, F16C, FMA, or later vector features that are not
represented by a simple public backend name or runtime check.

### Stage 1B.2 responsibility

The tier feature set is NOT discovered per build. It IS the published contents
of the chosen named psABI level (section 5, x86-64-v1/v2/v3). Stage 1B.2
therefore CONFIRMS conformance to the level rather than determining a bespoke
closure. Specifically, Stage 1B.2 must confirm:

- that each object's emitted instructions stay WITHIN its declared level
  (no instruction outside the level appears);
- that baseline (lower-tier) code contains no higher-tier gated instructions;
- that the runtime guard checks the WHOLE level, not the headline instruction;
- representative emitted instruction classes, as evidence of the above.

Because the level is a published standard, "which features are in the tier" is
answered by the psABI level definition, not by measurement; measurement only
verifies the object did not stray outside it.

Stage 1B.2 does not require an FMA instruction to appear merely because FMA is
part of the v3 level. Under strict source semantics (section 4.3) the compiler
will not auto-fuse, so FMA may legitimately be absent; its presence-if-used or
absence-if-unused are both acceptable. What matters is that nothing OUTSIDE the
declared level is emitted.

---

## 6. Majority-of-CPUs objective

W3X's product objective is to cover a useful majority of CPUs in the wild.

That objective should guide, but not replace, the technical target definition.

The tier decision should consider:

- the minimum x86-64 CPU generation worth supporting;
- whether scalar should cover pre-SSE4.1 x86-64 systems;
- whether SSE4.1 remains a useful middle tier;
- the installed population with AVX2;
- the availability of AVX, OSXSAVE, and XMM/YMM state for AVX2;
- whether bundling FMA or other features would unnecessarily reduce AVX2
  coverage;
- whether a broader tier materially improves generated Deblock4 code;
- the maintenance value of three stable public backend names.

W3C's current expectation is that there are 3 tiers being `x86-64 Microarchitecture Levels`:

```text
scalar baseline
SSE4.1 middle tier
AVX2 main performance tier
```

is a sensible initial structure, but Stage 1B.2 evidence should advise the
actual closures rather than adopting an architecture level by intuition. 

The W3X holds the formal decision making on applicability and use of tiers,
with advice from W3C and W3D. As previously mentioned, if at runtime it is
determined that a cpu matches a teir - testing in order from hightest (v3) to
lowest (v1) as the catch-all - then the the dispatcher should use
that tier; similarly at compile-time the back-end modules must be compiled with
the full teir instruction sets available for that tier chosen for that module.
If doubt exists in any way about this position (eg in building dispatching mechanism
etc) then this MUST be raised immediately with W3D and W3X with clarification of
the issue.

---

## 7. Prior-art findings

## 7.1 Zsmooth

Zsmooth is relevant precedent for the broad engineering philosophy:

- it maintains scalar and vector implementations;
- it tests scalar and vector forms;
- it uses `ReleaseFast` production builds;
- it publishes fixed cross-target builds;
- its public Windows AVX2 command uses a declared architecture level rather
  than the build machine's native target;
- it accepts very small floating-point output differences in at least one
  documented performance/precision trade-off.

This supports:

- shared algorithm plus optimised implementations;
- production optimisation;
- declared CPU tiers;
- evidence-based acceptance of negligible float differences;
- testing the actual vector implementations.

Zsmooth is not a direct template for Deblock4 because its public x86-64
packaging and dispatch model differ. A published AVX2 baseline binary is not
the same architecture as Deblock4's one DLL containing internally dispatched
scalar, SSE4.1, and AVX2 objects.

A complete source-line audit of Zsmooth's current vector-generic structure and
all compiler switches has not yet been made. It should become normative
precedent only after that audit.

## 7.2 Classic VapourSynth-Deblock

Classic Deblock provides established precedent for:

- a scalar/C implementation;
- an SSE4.1 implementation;
- automatic or forced runtime backend selection;
- integer and float format support.

It confirms that the public algorithm can coexist with multiple machine
implementations without making backend selection part of the mathematical
filter interface.

It does not settle:

- AVX2 target policy;
- FMA;
- Zig compile-time vector configuration;
- tolerance selection;
- one-DLL Zig object linkage.

A source/build audit of its current compiler flags should be performed if W3D
wants its exact choices used as a design precedent.

## 7.3 Existing-code precedent does not remove Deblock4 validation

The existence of mature compiler, CPU, SIMD, Zsmooth, and classic Deblock code
strongly supports getting out of the compiler's way on:

- scheduling;
- registers;
- legal instruction selection;
- vector lowering;
- ordinary target-specific optimisation.

It does not remove the need to validate Deblock4-specific:

- lane mapping;
- edge footprints;
- canonical processing order;
- vertical/horizontal dependencies;
- tail handling;
- transpose/shuffle correctness;
- runtime feature closure;
- bounds;
- output comparisons.

Those are implementation-specific risks, not unsolved CPU-design problems.

The project should stop policing negligible rounding history merely for
identity while continuing to test the structural errors that can produce
materially wrong pixels.

## 7.4 The R76-class miscompile risk and its mitigations

The VapourSynth R76 fix corrected cases where certain compilers compiled the
AVX2 path of internal filters so as to produce garbage pixels at frame edges.
This is a compiler CODE-GENERATION defect (correct source, wrong machine code),
clustering at EDGES and TAILS - exactly where a deblocker operates. The symptom
is gross "garbage edge" corruption, not rounding, so differential testing
catches it trivially and it reinforces rather than threatens the relaxed float
tolerance. (Corroborated by an AviSynth+ Visual Studio 2017 precedent and by
independent GAIS analysis, which independently recommended the same 711x480-style
edge-forcing test.)

Three permanent mitigations are adopted:

```text
M1  the test corpus MUST include non-vector-width-multiple dimensions with
    strong boundary edges (e.g. 711x480) to force the tail path to execute;
M2  the scalar-vs-SIMD differential is a STANDING gate, re-run on EVERY Zig or
    LLVM version bump - "certain compilers" means the risk is toolchain-version
    dependent and can appear from a compiler update with source unchanged;
M3  retain .strict (section 4.2), which avoids the aggressive float rewrites
    most associated with this class of defect.
```

A related performance question (the AVX-SSE transition penalty / vzeroupper,
raised by GAIS) is noted for the kernel and dispatch work; it is a performance
matter, not a correctness one, and is not settled here.

---

## 8. Revised verification model

The constrained/unconstrained twin-build model is not W3X's preferred
direction - W3X discourages it.

The preferred production and validation matrix is:

```text
canonical ReleaseSafe scalar oracle

production ReleaseFast scalar
production ReleaseFast SSE4.1
production ReleaseFast AVX2
```

Direct comparisons:

```text
production scalar  vs ReleaseSafe scalar oracle
production SSE4.1  vs ReleaseSafe scalar oracle
production AVX2    vs ReleaseSafe scalar oracle
```

Acceptable comparison tolerances will be determined by W3D.

## 8.1 Integer formats

W3C recommends exact comparison:

```text
scalar == SSE4.1 == AVX2
```

This does not require target-feature subtraction. Correct defined integer
arithmetic has one result. A difference normally indicates:

- a different formula;
- an overflow-width mistake;
- wrong signedness;
- wrong rounding or saturation;
- a lane, mask, tail, or schedule defect.

W3X has not explicitly rejected exact integer comparison. This should be
confirmed in the formal designer decision.

## 8.2 Floating-point formats

The proposed goal is:

```text
same specified algorithm
+ deterministic output per selected backend
+ direct scalar-versus-production-backend comparison
+ designer-approved numerical tolerances
```

Before a tolerance is frozen, validation should record:

- maximum absolute difference;
- maximum ULP difference for ordinary finite values;
- number and percentage of differing samples;
- difference histogram;
- exact finite/NaN/infinity classification agreement;
- signed-zero behaviour where relevant;
- threshold or filter-activation mask differences;
- maximum final output difference following any decision difference;
- input values, coordinates, backend, and branch for every worst case.

The eventual acceptance rule should combine exact structural checks and
numerical bounds. A broad final-pixel tolerance must not silently excuse a
wrong lane, tail, bounds rule, or processing schedule.

---

## 9. Tolerance work requiring W3D advice

Tolerance is now the principal unresolved design area.

W3D should advise on:

### T1. Scope

Does tolerance apply only to float formats, while integer formats remain exact?

**W3C recommendation:** yes.

### T2. Same-algorithm invariants

Which internal results must remain exact across float backends?

Candidates:

- edge eligibility;
- threshold-set selection;
- non-finite masks;
- filter-activation masks;
- branch choices;
- clipping class;
- canonical schedule;
- border and tail decisions.

### T3. Decision-boundary policy

May a legitimate near-boundary floating-point difference change a filter
activation decision if the final output remains within a separate bound?

This is the most important policy question because a one-ULP arithmetic
difference can become a larger output difference when it changes a branch.

### T4. Metrics

Which metrics are acceptance-critical?

W3C recommends a combination of:

- exact structural/classification gates;
- maximum absolute output difference;
- ULP reporting;
- explicit decision-mask reporting;
- worst-case sample capture.

Mean error or RMS alone is insufficient.

### T5. Derivation

What analytical error bound follows from the real float operation chain?

The bound should be derived after the real kernels exist and should distinguish:

- ordinary arithmetic rounding;
- cancellation;
- comparison boundaries;
- output conversion;
- any future explicit fused operation.

### T6. Corpora

The tolerance should be challenged with:

- synthetic threshold-neighbour cases;
- exact halfway-rounding cases;
- extreme finite values;
- signed zero;
- subnormals;
- NaN and infinity according to policy;
- minimum dimensions;
- partial vectors and tails;
- random float vectors;
- representative noisy VHS/DVD restoration material;
- a separate confirmation corpus not used to choose the bound.

### T7. Freeze rule

The final tolerance must not merely equal the largest difference observed in
the development corpus.

W3D should state what margin, analytical support, and independent confirmation
are required before it becomes normative.

---

## 10. Settled current position versus remaining open questions

## 10.1 Settled current position for W3D review

The following are treated as settled W3X preferences unless W3D presents a
specific objection:

1. same-algorithm plus tolerance replaces universal float bit identity;
2. common mathematical code base with compile-time vector configuration;
3. minimal backend-specific adapters;
4. one production build per backend;
5. direct production-backend comparisons against scalar;
6. `ReleaseFast`;
7. explicit `.strict`;
8. no current `@mulAdd` requirement;
9. full declared tiers;
10. no distributed native-host target;
11. no feature subtraction merely for float identity;
12. Stage 1B.2 CONFIRMS each object stays within its named psABI level
    (it does not measure a bespoke closure);
13. tolerance design is deferred until real kernels exist;
14. integer outputs remain EXACT across backends (float only gets tolerance);
15. the tiers are the NAMED psABI levels v1/v2/v3, used in full with no
    identity-driven exclusions; the v3 tier therefore includes FMA, BMI1,
    BMI2, F16C, LZCNT, MOVBE as part of the level, all runtime-guarded;
16. dispatch selects the highest FULLY-satisfied level, testing v3 then v2
    then v1, and falls back down the chain; v1 always succeeds; the guard
    checks the WHOLE level, never the headline instruction;
17. the selected tier and the version marker are emitted to stderr on every
    run, always-on (ffmpeg-style), not behind the gated debug path;
18. the production ReleaseFast scalar backend is proven against the ReleaseSafe
    scalar oracle before being used as the reference for SIMD comparisons.

## 10.2 Remaining open questions

Several questions previously listed here are now decided and have moved to
section 10.1 (integer exactness; tier feature membership; named-level vs
explicit features; selected-tier reporting). What remains genuinely open is the
tolerance design and the resulting document amendments:

1. Which float internal masks and decisions must remain exact across backends
   (the same-algorithm invariants of T2)?
2. What numerical metrics and tolerance values become normative (T4, deferred
   to real kernels)?
3. What corpus and analytical proof are required before a tolerance is frozen
   (T5-T7)?
4. What reproducibility promise is made for float output across machines
   (section 14)?
5. Exactly which charter, README, roadmap, and harness clauses are amended
   (section 13).

---

## 11. Recommended provisional policy wording

W3C recommends the following as the basis for W3D's formal revision:

> Deblock4 implements one specified deblocking algorithm through scalar,
> SSE4.1, and AVX2 production backends.
>
> Shared mathematical source is instantiated at compile time for the
> backend's vector width and arithmetic type. Backend-specific code is limited
> to entry points and data movement where the hardware shape or clear code
> generation requires it.
>
> Production objects use `ReleaseFast`, explicit strict floating-point
> semantics, and their full declared and runtime-guarded feature tiers.
> Features are not subtracted merely to force floating-point byte identity.
> Distributed objects are never compiled for an uncontrolled native-host CPU.
>
> One production form of each backend is built. Each production backend is
> compared directly against the canonical ReleaseSafe scalar oracle.
>
> Integer outputs remain exact across backends unless W3D/W3X explicitly decide
> otherwise. Floating-point outputs must implement the same specified algorithm
> and remain deterministic per backend, but may differ within a measured,
> analytically supported, and adversarially validated tolerance contract.
>
> Zig's `.strict` float mode is stated explicitly at the authoritative float
> kernel scope. No `@mulAdd` requirement is imposed. Explicit fused semantics
> may be considered later only if real-kernel evidence justifies that separate
> algorithmic decision.

---

## 12. Consequences for Stage 1B.2

If W3D accepts this direction, Stage 1B.2 should:

1. adopt the named psABI level as each backend's declared tier (v1 scalar,
   v2 SSE4.1, v3 AVX2), rather than deriving a bespoke closure;
2. compile representative probes under those level contracts;
3. inspect object-level emitted instructions;
4. prove baseline (lower-tier) code contains no higher-tier gated instructions;
5. prove each object stays WITHIN its level and that each runtime guard checks
   the WHOLE level (not the headline instruction);
6. keep FMA as part of the v3 level rather than subtracting it for identity;
7. not require FMA instructions to appear unless source semantics legally
   produce them;
8. leave real output tolerance comparison to the real-kernel stage.

The prior two-closure-per-backend (constrained/unconstrained twin) form is no
longer the plan, and the closure is the published level rather than a measured
per-build set.

---

## 13. Required document amendments if adopted

Formal adoption will require reviewing and amending at least:

- the universal scalar/SSE4.1/AVX2 equality statement;
- any clause requiring float bit identity;
- FMA exclusion that exists solely for identity;
- backend defect definitions;
- float signed-zero and NaN comparison rules;
- Stage 1B.2 feature-closure language;
- Stage 2 differential harness requirements;
- production release criteria;
- reproducibility documentation;
- backend diagnostic reporting;
- roadmap references to constrained/unconstrained twin builds.

No existing text should be weakened for integer correctness, bounds, schedule,
tails, masks, dispatch, or target isolation merely because float numerical
identity is relaxed.

---

## 14. Strongest argument against the change

The strongest objection remains cross-machine reproducibility:

```text
the same script and float input may produce different frame bytes on different
CPUs because automatic dispatch selects different production backends
```

This can affect:

- hashes;
- cached results;
- distributed rendering;
- regression comparisons;
- bug reproduction.

W3C considers the risk manageable if:

- differences are demonstrably negligible;
- each selected backend is deterministic;
- the selected backend and tier are diagnosable;
- users can force scalar or another backend;
- integer outputs remain exact;
- the float reproducibility contract is stated honestly.

---

## 15. W3C conclusion

W3C supports W3X's current direction.

The project should not constrain useful compiler or CPU capability merely to
preserve a floating-point rounding history that is immaterial to the intended
restoration result.

The project should:

- specify the algorithm;
- preserve strict arithmetic semantics;
- use production optimisation;
- use fixed full declared tiers;
- share mathematical source;
- minimise backend-specific adapters;
- test the actual production objects;
- keep exact structural, bounds, schedule, mask, tail, and dispatch proofs;
- measure real float differences;
- adopt only tolerances justified by arithmetic and adversarial evidence.

This approach gets out of the compiler's way where the compiler is expert,
without delegating Deblock4's algorithm, target contract, or acceptance
criteria to implicit behaviour.

---

## 16. Sources and verification boundary

Sources considered in the underlying assessment:

1. Deblock4 Design Specification revision 1.1.
2. Deblock4 Project Charter and Invariants Card v1.10.
3. Deblock4 design question, "Three-Step Verification Model", v1.0.
4. Zig 0.16.0 language documentation for build modes, `@setFloatMode`, and
   `@mulAdd`.
5. Current public Zsmooth README and published build instructions.
6. Current public HolyWu VapourSynth-Deblock README.
7. VapourSynth change history concerning multi-tier plugin loading and an AVX2
   edge-codegen correction.

Verification boundary:

- The Deblock4 common-code architecture is grounded in the supplied
  specification.
- The Zig semantics were checked against Zig 0.16 documentation during the
  discussion.
- Zsmooth and classic Deblock were used as contextual prior art.
- A complete source-line and compiler-flag audit of both external projects has
  not yet been completed. Neither should become a normative implementation
  precedent until that audit is performed.
