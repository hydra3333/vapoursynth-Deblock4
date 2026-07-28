# Deblock4 - Discussion Paper: Same-Algorithm Tolerance and Full Declared Backend Tiers

**Version:** 1.1  
**Date:** 2026-07-28  
**Revision note:** Reissued under a new filename to prevent stale-download or browser-cache ambiguity. The substantive design assessment is unchanged from the W3C paper generated at approximately 23:20 ACST on 2026-07-28.  
**Status:** DESIGN DISCUSSION ONLY. Not a coding scope, charter amendment, or settled decision.  
**Requested by:** W3X  
**Assessment by:** W3C  
**Encoding:** US-ASCII only

---

## 1. Purpose

This paper records W3X's current position, checks it against the existing
Deblock4 architecture and selected prior art, gives W3C's assessment, and
identifies the decisions still required from W3D/W3X.

The immediate question is whether Deblock4 should continue to require
cross-backend bit-exact floating-point output, or instead require the same
specified algorithm with measured and justified tolerances between the scalar,
SSE4.1, and AVX2 production backends.

This discussion does not alter G5/G6, the one-DLL object structure, runtime CPU
guarding, the canonical schedule, bounds rules, or the scalar-oracle role.

---

## 2. W3X current position

W3X's present position is:

> For Deblock4's intended use on already poor, visibly blocky, luma-noisy and
> chroma-noisy VHS-derived captures, the estimated numerical effect of FMA and
> ordinary floating-point backend rounding differences appears negligible in
> relation to the end result.
>
> The project may be trying to solve differences that are not practically
> broken or material to restoration quality.
>
> Subject to technical objection and designer review, W3X proposes:
>
> 1. Change the shipping correctness goal from cross-backend bit-exact output
>    to implementation of the same specified algorithm, with numerical
>    tolerances to be assessed and determined.
> 2. Give scalar, SSE4.1, and AVX2 their full intended hardware targets.
> 3. Do not build and compare constrained and unconstrained twins of each SIMD
>    backend.
> 4. Compare the production scalar backend directly with each production SIMD
>    backend, measure the differences, and establish the smallest reasonable
>    tolerances supported by evidence.
>
> W3X also prefers:
>
> - a common source base for SIMD mathematics, parameterised at compile time by
>   backend width/lane configuration;
> - minimal backend-specific code;
> - no restriction merely for identity unless it protects a demonstrated
>   correctness, compatibility, or quality requirement;
> - distributed binaries that use fixed declared tiers, never W3X's native
>   build-machine CPU;
> - `ReleaseFast` production optimisation;
> - explicit strict floating-point semantics, for example:
>
>   ```zig
>   comptime {
>       @setFloatMode(.strict);
>   }
>   ```
>
> - no present requirement to rewrite expressions using `@mulAdd`;
> - designer-led determination of the eventual tolerance contract.

W3C recommends replacing the phrase **"full unconstrained hardware target"**
with **"full declared tier"** throughout future documents. "Unconstrained" can
be misread as native-host targeting, general fast-math, or permission to emit
features not checked by dispatch. That is not W3X's intent.

---

## 3. Existing Deblock4 architecture already supports the intended code-sharing model

W3X's recollection is correct. The controlling design specification already
defines the intended SIMD model as shared generic mathematics instantiated
under backend-specific compile-time widths.

The design currently specifies the conceptual configuration:

```zig
const BackendConfig = struct {
    vector_bytes: comptime_int,
};

const sse41 = BackendConfig{ .vector_bytes = 16 };
const avx2  = BackendConfig{ .vector_bytes = 32 };
```

and derives vector element counts from the element size:

```zig
fn Vec(comptime cfg: BackendConfig, comptime T: type) type {
    return @Vector(cfg.vector_bytes / @sizeOf(T), T);
}
```

The same 16-byte or 32-byte backend therefore naturally has different lane
counts for `u8`, `i16`, `i32`, and `f32`.

The specification also already says:

- use shared `@Vector` mathematics for differences, comparisons, masks,
  threshold selection, shifts, clipping, and selection;
- specialise widening, narrowing, transpose, cross-vector shuffles, packing,
  awkward vertical loads, tails, and final stores where necessary;
- place common formulas in `common_math.zig`;
- instantiate that shared source separately into scalar, SSE4.1, and AVX2
  objects where Zig permits clear genericity;
- keep SSE4.1 and AVX2 entry points/adapters in their target-specific modules.

Accordingly, the proposed architecture is not three independently maintained
algorithms. It is:

```text
one specified algorithm
    + shared scalar/vector mathematical helpers
    + compile-time backend width/type configuration
    + backend-specific movement/adapters where the hardware shape requires it
    + separately compiled machine-code objects
```

The call boundary between generic dispatch and each object remains a stable,
non-vector ABI. Inside each object, compile-time instantiation determines the
vector types and legal batch width.

### W3C assessment

This is the right architecture and should remain the target. Backend-specific
duplication should be accepted only where vector movement or instruction
lowering genuinely differs. Genericity should not be forced where it obscures
proof or produces materially worse machine code.

"Same code base" must not be interpreted as "identical source in every line."
A shared mathematical kernel plus small specialised adapters is a better and
more maintainable definition.

---

## 4. Zig 0.16 floating-point and optimisation mechanics

### 4.1 `ReleaseFast` and float mode are separate controls

`ReleaseFast` requests normal production optimisation and disables normal
runtime safety checks. It does not, by itself, select Zig's
result-changing `.optimized` floating-point mode.

Zig 0.16 floating-point operations use `.strict` by default.
`@setFloatMode(.optimized)` is a separate source-level permission equivalent
to a general fast-math bundle. It may permit:

- assumptions excluding meaningful NaN and infinity results;
- insignificant signed zero;
- reciprocal substitution for division;
- contraction such as multiply-add fusion;
- reassociation and other algebraically equivalent rewrites that change
  floating-point results.

Therefore the closest Zig 0.16 expression of W3X's intended policy is:

```text
ReleaseFast
+ explicit fixed backend target
+ full declared feature tier
+ `.strict` floating-point semantics
```

This tells the compiler to optimise aggressively while preserving the
specified floating-point calculation.

### 4.2 Explicit module-scope strict mode

Because `.strict` is already the default, no functional source change is
required merely to obtain strict semantics.

Nevertheless, W3C supports an explicit module- or kernel-scope declaration:

```zig
comptime {
    @setFloatMode(.strict);
}
```

Reasons:

- it makes the intended numerical contract visible at the enforcement point;
- it prevents a future maintainer from assuming `ReleaseFast` implies
  fast-math;
- it protects the kernel if a containing scope later changes float mode;
- it is mechanically reviewable.

The exact placement should be chosen when the real float-kernel module exists.
It should not be scattered redundantly through every helper.

### 4.3 `@mulAdd` is not required

No current decision requires rewriting arithmetic with `@mulAdd`.

Under `.strict`, enabling FMA in the AVX2 CPU feature tier does not itself mean
that an ordinary source expression:

```zig
a * b + c
```

may be contracted when contraction would change the specified result.

`@mulAdd` would explicitly define one-rounding fused semantics. It is an
algorithm choice, not merely a target switch.

Therefore W3X may validly decide:

```text
- include FMA capability in a full declared tier if that tier requires it;
- keep `.strict`;
- write normal expressions;
- do not require `@mulAdd`;
- accept that FMA may remain unused unless a strict-semantics operation can
  benefit or a later measured design explicitly selects fused semantics.
```

This is important: **not subtracting FMA** and **requiring FMA use** are
different decisions.

### 4.4 No Zig 0.16 "contraction only" float mode

Zig 0.16 publicly exposes `.strict` and `.optimized`; it does not expose a
supported middle mode meaning "strict except automatic FMA contraction."

If later measurements show that explicit fused arithmetic materially helps,
the project can consider a narrow `@mulAdd` use at the exact expression. It
does not need to decide that now.

---

## 5. Meaning of "full declared tier"

The distributed objects must not be built for W3X's native CPU. That point is
already settled and should remain settled.

The desired rule is:

> Each production backend is compiled with every feature positively included
> in its declared tier and checked by its runtime guard. Features are not
> subtracted merely to force cross-backend floating-point identity.

Conceptually:

```text
generic/scalar tier
    fixed supported x86-64 baseline
    no feature that is unavailable on the minimum supported CPU

SSE4.1 tier
    the complete explicit feature closure required by the compiled SSE4.1
    object

AVX2 tier
    the complete explicit feature closure required by the compiled AVX2
    object, potentially including FMA if W3D/W3X choose a tier that includes it
```

Two rules remain non-negotiable:

1. Dispatch must check the **whole compiled closure**, not merely the marketing
   label or one CPUID bit.
2. Stage 1B.2 must establish the actual closure by compilation and assembly
   inspection before the feature set becomes normative.

An architecture-level shorthand such as `x86_64_v3` may be convenient, but it
is broader than "AVX2 exists." It is valid only if Deblock4 intentionally
adopts the complete tier and dispatch verifies every required CPU/OS feature.
It must not be combined with an AVX2-only runtime check.

### Majority-of-CPUs objective

"Target the majority of CPUs in the wild" is a product support objective, not
a sufficient feature definition.

The designer should separately settle:

- the minimum supported x86-64 generation;
- whether old pre-SSE4.1 machines remain supported through scalar;
- whether SSE4.1 is retained as a meaningful middle tier;
- whether AVX2 is expected to cover the main performance population;
- whether the AVX2 tier includes FMA and any other bundled features;
- whether a future packaging strategy may use VapourSynth's multiple-copy
  optimisation-level loader instead of, or in addition to, internal dispatch.

Until that evidence is collected, explicit minimal/full declared closures are
safer than choosing an architecture level by popularity assertion.

---

## 6. Prior-art comparison

## 6.1 Zsmooth

Zsmooth is useful precedent, but not a direct architectural template.

Its current public goals include:

- a standard scalar implementation for every algorithm;
- tests covering scalar and vector implementations;
- cross-platform and cross-architecture support.

Its published build instructions use:

```text
native development build:
    zig build -Doptimize=ReleaseFast

Windows AVX2 build:
    zig build -Doptimize=ReleaseFast
        -Dtarget=x86_64-windows
        -Dcpu=x86_64_v3
```

Its current prebuilt x86-64 policy assumes AVX2 as the baseline. This is a
distribution choice: one prebuilt x86-64 binary may require AVX2. It is not the
same as Deblock4's planned one-DLL internal scalar/SSE4.1/AVX2 dispatch.

Zsmooth also explicitly accepts very small floating-point output differences
in at least one documented case: it uses true single-precision arithmetic
where another implementation uses double precision, trading negligible output
differences for substantial speed.

### What Zsmooth supports in this discussion

Zsmooth supports these principles:

- scalar plus vector implementations are normal;
- `ReleaseFast` is normal for production;
- fixed cross targets are normal;
- accepting tiny numerical differences can be a legitimate performance and
  implementation decision;
- tests must cover scalar and vector forms.

### What Zsmooth does not settle for Deblock4

Its public build policy does not by itself answer:

- Deblock4's exact SSE4.1 and AVX2 runtime feature closures;
- whether Deblock4 should use `x86_64_v3`;
- Deblock4's threshold-decision tolerance;
- whether float output differences are acceptable under Deblock4's algorithm;
- whether one generic vector kernel gives good code for Deblock4's horizontal
  and vertical edge adapters.

W3C did not verify Zsmooth's complete current source-level SIMD genericity or
all compiler flags during this review. The conclusions above are limited to
its current public goals, README, and published build commands.

## 6.2 HolyWu/classic VapourSynth-Deblock

The current classic Deblock interface exposes:

```text
opt=0    automatic detection
opt=1    C backend
opt=2    SSE4.1 backend
```

It supports integer and 32-bit float formats and is established prior art for
runtime selection between a baseline C implementation and an SSE4.1
implementation.

It does not provide an AVX2 tier, and it is written in C++. Therefore it does
not settle Zig's compile-time lane-width approach or the FMA/tolerance policy.

Its relevance is narrower:

- runtime backend selection is conventional;
- a scalar/C backend remains valuable;
- SSE4.1 is a reasonable compatibility/performance tier;
- the algorithm and optimised implementation can coexist without making CPU
  selection part of the public mathematical algorithm.

W3C did not verify the current Meson compiler flags in this pass and therefore
does not claim a specific fast-math, FMA, or target-level setting for classic
Deblock.

## 6.3 VapourSynth itself

VapourSynth R75 added support for plugins shipping multiple copies targeting
different x64 optimisation levels and automatically loading the best one.
This confirms that multi-tier CPU packaging is an accepted ecosystem pattern.

However, VapourSynth R76 also fixed an internal AVX2 code-generation problem
that could produce garbage pixels at edges with certain compilers. This is a
useful caution:

> Mature compilers and CPUs remove the need to micromanage scheduling and
> instruction selection, but they do not remove the need to test vector tails,
> bounds, object targeting, and generated code.

Deblock4 should get out of the compiler's way where semantics permit, while
retaining strong differential, bounds, tail, and assembly validation.

---

## 7. W3C assessment of W3X's proposed simplification

## 7.1 Change the goal from bit-exactness to same algorithm plus tolerance

**Supported with qualification.**

Recommended policy:

```text
Integer formats:
    scalar == SSE4.1 == AVX2 exactly

Floating-point formats:
    same specified algorithm
    deterministic per backend
    strict floating-point semantics
    direct scalar-vs-SIMD differences bounded by a measured and justified
    tolerance contract
```

Integer tolerance is unnecessary and would weaken defect detection. A defined
integer algorithm has one result.

For float, "same algorithm" must be defined by invariants, not merely by output
closeness. It must include:

- edge positions and eligibility;
- vertical/horizontal schedule and dependency order;
- formulas and constants;
- threshold selection and comparison directions;
- per-edge non-finite handling;
- clipping and output conversion;
- unchanged-border and tail behaviour;
- plane-class footprints;
- no stale-tile or batching changes that alter the canonical state observed.

## 7.2 Give each backend its full target

**Supported after terminology correction.**

Use "full declared tier," not "unconstrained" or "native."

No feature should be subtracted merely for floating identity unless the
subtraction protects a demonstrated requirement. Conversely, no feature may be
silently added outside the declared and runtime-guarded closure.

## 7.3 Skip constrained/unconstrained twin builds

**Supported.**

The dual-build three-step proposal is not required if production policy is:

- one strict `ReleaseFast` production build per backend;
- direct validation of those exact production objects;
- no general fast-math build;
- no separate identity-constrained AVX2 twin.

A ReleaseSafe scalar oracle should still exist. It is not an intermediate
feature-constrained SIMD build; it is the readable arithmetic/bounds oracle.

## 7.4 Compare scalar directly with each production backend

**Supported.**

Recommended direct matrix:

```text
production scalar vs ReleaseSafe scalar oracle
production SSE4.1 vs ReleaseSafe scalar oracle
production AVX2 vs ReleaseSafe scalar oracle
```

For integer paths, require exact identity.

For float paths, initially record rather than prematurely freeze:

- maximum absolute difference;
- maximum ULP difference for finite ordinary values;
- number and percentage of differing samples;
- difference histogram;
- exact finite/NaN/infinity classification agreement;
- signed-zero behaviour where the contract requires preservation;
- threshold/decision-mask differences;
- maximum final output difference following a decision-mask difference;
- the input, coordinates, backend, and branch for every worst case.

The final tolerance must not simply equal the largest difference observed in
the development corpus. W3D should derive a candidate bound from the arithmetic
and then challenge it with separate adversarial and real-video corpora.

---

## 8. Why backend testing remains necessary

The proposed relaxation concerns legitimate floating-point numerical
variation. It does not relax structural correctness.

Most serious SIMD defects are not FMA rounding differences. They include:

- wrong lane mapping;
- signed/unsigned comparison mistakes;
- incorrect widening or narrowing;
- wrong saturation;
- stale data across dependent edges;
- bad transpose/shuffle;
- invalid edge/tail load or store;
- accidental use of features outside the runtime guard;
- a compiler lowering that scalarises or changes the intended object closure.

These must still fail loudly even when final float values happen to fall
within a broad numerical tolerance.

Therefore tolerance validation should be layered:

```text
structural exact checks:
    geometry, schedules, masks, bounds, tails, classifications, dispatch

numeric comparison:
    output difference within the float tolerance contract
```

Where practical, compare decision masks exactly before applying a final output
tolerance. A tiny rounding change at a threshold may legitimately flip a
decision only if the designer explicitly accepts that behaviour.

---

## 9. Recommended provisional position for designer review

W3C recommends that W3D/W3X consider adopting the following direction now,
subject to formal document amendments:

> Deblock4 implements one specified deblocking algorithm through scalar,
> SSE4.1, and AVX2 production backends.
>
> Shared mathematical source is instantiated at compile time for the backend's
> vector width and arithmetic type. Backend-specific code is limited to entry
> points and data movement such as loads, transposes, shuffles, packing, tails,
> and stores where hardware shape requires it.
>
> Production objects use `ReleaseFast`, explicit strict floating-point
> semantics, and their full declared and runtime-guarded feature tiers.
> Features are not subtracted merely to force floating-point byte identity.
> Distributed objects are never built for an uncontrolled native-host CPU.
>
> Integer outputs remain exact across all backends. Floating-point outputs must
> implement the same algorithm and remain deterministic per backend, but may
> differ within a measured, analytically supported and adversarially validated
> tolerance contract.
>
> Only one production form of each backend is built. Each production backend is
> compared directly against the canonical ReleaseSafe scalar oracle. No
> constrained/unconstrained SIMD twin matrix is required unless later evidence
> reveals a specific need.
>
> Zig's `.strict` float mode is retained and stated explicitly at the float
> kernel's authoritative scope. No `@mulAdd` requirement is imposed. Explicit
> fused semantics may be considered later only if real-kernel measurements
> justify it.

---

## 10. Open questions for W3D/W3X

### Q1. Scope of relaxed identity

Is tolerance permitted only for 32-bit floating-point formats, with all
integer formats remaining exact?

**W3C recommendation:** yes.

### Q2. Normative definition of "same algorithm"

Which internal decisions must remain exact across backends?

Candidates:

- edge eligibility;
- threshold-set selection;
- filter activation masks;
- non-finite masks;
- branch choice;
- clipping/saturation class;
- processing schedule.

Must threshold decisions match exactly, or may near-boundary float differences
produce different activation decisions if final output remains within a
separate bound?

### Q3. Tolerance metrics

Which combination becomes acceptance-critical?

- absolute error;
- ULP error;
- relative error;
- maximum differing sample count;
- decision-mask differences;
- classification differences;
- final code-value difference after conversion.

**W3C recommendation:** no single metric. Use exact structural/classification
gates plus absolute and ULP output bounds.

### Q4. Tolerance evidence

What evidence is required before freezing tolerance?

- analytical operation-chain bound;
- synthetic threshold-neighbour vectors;
- exhaustive or stratified integer-domain vectors where applicable;
- random float vectors;
- non-finite/signed-zero cases;
- real VHS/DVD restoration corpus;
- separate confirmation corpus not used to choose the bound.

### Q5. Exact full declared tiers

What are the final feature sets for:

- generic/scalar baseline;
- SSE4.1;
- AVX2?

Does the AVX2 tier include FMA, BMI1, BMI2, F16C, LZCNT, POPCNT, or any other
feature? Dispatch must check exactly what the compiled object requires.

### Q6. Architecture-level names

Should Deblock4 use explicit feature additions/subtractions or a named
architecture level such as `x86_64_v3`?

**W3C recommendation:** let Stage 1B.2 measurement decide. Do not adopt a named
level unless its full feature contract is intentionally supported and checked.

### Q7. FMA intent

Is the decision merely:

```text
do not artificially subtract FMA from a declared tier
```

or:

```text
the float algorithm should actively use fused multiply-add
```

These are different. Under `.strict`, the first does not imply the second.

**W3C recommendation:** adopt only the first now. Reconsider explicit
`@mulAdd` after real-kernel arithmetic and benchmarks exist.

### Q8. Explicit strict-mode placement

Should the future authoritative float-kernel module contain:

```zig
comptime {
    @setFloatMode(.strict);
}
```

**W3C recommendation:** yes, once, at the narrow authoritative scope.

### Q9. Scalar oracle and production scalar

Should every release prove the `ReleaseFast` production scalar backend against
the `ReleaseSafe` scalar oracle before comparing SIMD?

**W3C recommendation:** yes.

### Q10. Reproducibility and user controls

If float outputs differ by backend:

- is a forced `backend="scalar"` mode sufficient for reproducibility;
- should frame properties record the selected backend;
- should the exact backend tier/build identity be exposed diagnostically;
- is distributed-render cross-machine byte identity explicitly not promised
  for float clips?

### Q11. Stage 1B.2 shape

Under this simplified model, should Stage 1B.2 establish one full declared
closure per backend and inspect representative instruction lowering, without
requiring FMA to appear?

**W3C recommendation:** yes. Output tolerances require real kernels and belong
later.

### Q12. Document amendments

If adopted, the following existing requirements need formal revision:

- executive-summary scalar/SSE4.1/AVX2 equality for float;
- mandatory backend identity clauses;
- FMA exclusion;
- prohibition on `x86_64_v3` based solely on float identity;
- float signed-zero bit-pattern identity;
- Stage 4 and Stage 5 proof language;
- validation matrices and release criteria;
- definitions of backend defect versus tolerated numerical difference.

---

## 11. Strongest argument against the proposed change

The strongest objection is reproducibility:

```text
the same script and input may produce different float-frame bytes on different
CPUs because auto dispatch selects different backends
```

That affects hashes, cross-machine render comparison, caches, and bug
reproduction.

W3C considers this manageable if:

- differences are bounded and quality-neutral;
- each backend is deterministic;
- the selected backend is recorded;
- a forced scalar backend is available;
- integer output remains exact;
- the project states the float reproducibility contract honestly.

---

## 12. W3C conclusion

W3C does not object to W3X's proposed direction.

The existing Deblock4 architecture already supports the desired common code
base: shared mathematical code parameterised by vector width and type, with
small target-specific adapters and separately compiled objects.

W3C recommends:

1. retain exact output for integer formats;
2. change float shipping correctness from bit identity to the same specified
   algorithm plus a designer-approved tolerance contract;
3. compile one production scalar, SSE4.1, and AVX2 object each;
4. use `ReleaseFast`, explicit `.strict`, and full declared tiers;
5. never use native-host targeting for distributed objects;
6. do not require `@mulAdd`;
7. compare each production backend directly against the ReleaseSafe scalar
   oracle;
8. keep exact structural, mask, classification, bounds, tail, and dispatch
   checks alongside numeric tolerance;
9. let Stage 1B.2 define and inspect one feature closure per backend;
10. let W3D determine tolerance methodology before it becomes normative.

This gets out of the compiler's way on scheduling, vectorisation, register use,
instruction selection, and legal target-specific lowering, while retaining a
clear definition of the algorithm and strong tests for the defects that
actually matter.

---

## 13. Sources consulted

1. Deblock4 Design Specification revision 1.1, especially sections 1, 4, 8.6,
   9, 10, 11.8-11.13, 12, and the staged roadmap.
2. Deblock4 design question, "Three-Step Verification Model", version 1.0.
3. Zig 0.16.0 Language Reference:
   floating-point operations, `@setFloatMode`, `@mulAdd`, and build modes.
4. Zsmooth current public README and release/build instructions, version 0.19.0
   current at review date.
5. HolyWu VapourSynth-Deblock current public README, release r9 current at
   review date.
6. VapourSynth ChangeLog, R75 multi-optimisation-level plugin loading and R76
   AVX2 edge-codegen fix.

### Source-verification boundary

This review verified current public Zsmooth and classic Deblock README/build
information. It did not complete a source-line audit of Zsmooth's full SIMD
generic implementation or classic Deblock's current Meson compiler flags.
Those should be inspected directly if W3D wants either project to become a
normative implementation precedent rather than contextual prior art.
