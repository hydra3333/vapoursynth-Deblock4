Design proposal for W3C assessment: the three-step verification model
(constrained bit-exact proof, tolerance-verified unconstrained release)

Status: DESIGN EXPLORATION, not a scope. No code is requested. W3D and W3X have
converged on a leaning; W3C is asked for an independent assessment to
pressure-test it BEFORE it is adopted into the charter/README. Disagreement is
explicitly invited.

----------------------------------------------------------------------
1. Background and motivation
----------------------------------------------------------------------

The project currently requires scalar, SSE4.1 and AVX2 backends to produce
bit-for-bit identical output. That is why the AVX2 target excludes FMA: fused
multiply-add rounds once where separate multiply-then-add rounds twice, so an
FMA-using AVX2 backend would differ from scalar/SSE4.1 in the last bit on
exactly the operations FMA touches. (FMA is the MORE accurate form; it is
excluded purely for cross-backend identity.)

W3X has questioned whether cross-backend bit-exactness is the right SHIPPING
goal, as opposed to a verification instrument:

- The overarching goal is deblocking quality and speed. Bit-exactness across
  backends has no user-visible value in itself; it exists to make SIMD
  verification against the readable scalar oracle a mechanical yes/no check.
- Hand-constraining instruction sets (subtracting FMA today; possibly rounding
  modes, reciprocal approximations, or operation-order constraints once real
  kernels exist) is second-guessing compilers and CPUs at a job they are
  purpose-built to do, with effects inside pipelines and caches that are not
  knowable from source. Letting the compiler target the real CPU freely is the
  performance-correct default; a constraint should have to justify itself.
- Extra accuracy on capable hardware (e.g. FMA on AVX2) can legitimately be
  framed as a FEATURE of running on a newer PC, not a defect.

The counter-consideration, which the model below is designed to answer: the
shipped binary must be a TESTED binary. Shipping an unconstrained build while
verifying only a constrained build would mean the tested code is not the
shipped code; a codegen-only defect (bad fusion, an unexpectedly coarse
approximation) would never be caught. That naive form is rejected.

----------------------------------------------------------------------
2. The proposed model
----------------------------------------------------------------------

Two builds of each SIMD backend; three verification/release steps.

Builds per backend (SSE4.1, AVX2):

    CONSTRAINED build    compiled under an exactness-constrained target
                         (today: FMA subtracted; possibly more constraints
                         once real kernels exist) such that its output is
                         bit-identical to scalar.

    UNCONSTRAINED build  compiled with the full feature set of its tier
                         (FMA enabled for AVX2; whatever else the tier
                         legitimately offers), letting the compiler generate
                         the best code it can.

The three steps:

    STEP 1  ALGORITHM PROOF (bit-exact, mechanical)
            constrained SSE4.1  == scalar   bit-for-bit
            constrained AVX2    == scalar   bit-for-bit
            Any mismatch is a defect, full stop. This preserves the scalar
            oracle and the zero-judgment mechanical check.

    STEP 2  RELEASE-CODEGEN REGRESSION BOUND (tolerance, per backend)
            unconstrained SSE4.1 vs constrained SSE4.1   within tolerance T
            unconstrained AVX2   vs constrained AVX2     within tolerance T
            This BOUNDS the release build's deviation from its proven-correct
            constrained twin on the test corpus; it does not PROVE the
            deviation is only rounding. Because step 1 already proved the
            algorithm, a within-T difference is CONSISTENT WITH expected
            rounding (FMA fusion etc.), and a difference EXCEEDING T is a
            clear signal of a codegen-level defect. The residual risk this
            step does NOT eliminate: a small-magnitude defect that stays
            under T, and any behaviour on inputs the corpus does not exercise.
            The tolerance and corpus must be chosen with that residual in
            mind (see Q1, Q2).

    STEP 3  RELEASE
            The UNCONSTRAINED builds ship. Users on capable hardware get the
            faster and (marginally) more accurate code as a benefit.

AVX-512: dropped from the model for now. W3X has no AVX-512-capable machine,
and a backend that cannot be executed locally cannot complete steps 1-2. If
AVX-512 is ever added, it requires hardware that can run its verification.

Determinism is unchanged and non-negotiable: any given shipped backend must
produce identical output run-to-run on the same machine. The model relaxes
only CROSS-BACKEND identity of the shipped builds, never reproducibility.

----------------------------------------------------------------------
3. Timing position
----------------------------------------------------------------------

W3X/W3D leaning: this is adopted as the TARGET model now (so design decisions
stop assuming shipped bit-exactness), but the tolerance work of step 2 is
deferred until Stage 2 produces real kernels - because only then do we know
which operations actually differ, by how much, and whether the unconstrained
speed/accuracy gain justifies the two-build infrastructure. Until then the
constrained model remains the working default. If Stage 2 measurement shows
the unconstrained gain is negligible, falling back to ship-the-constrained-
build (making steps 2-3 unnecessary) remains open.

----------------------------------------------------------------------
4. Questions for W3C
----------------------------------------------------------------------

Assess independently and advise. Specifically:

Q1  SOUNDNESS. Do steps 1-3 together close the "shipped code is untested
    code" gap? Is there any path by which a defect could survive step 1
    (bit-exact vs scalar) AND step 2 (tolerance vs constrained twin) and
    still ship? Consider codegen differences between the two builds beyond
    rounding: instruction selection, autovectorization shape, memory access
    order, denormal/NaN handling, anything else.

Q2  TOLERANCE PRACTICALITY. Step 2's tolerance must be tight enough to catch
    real defects and loose enough to pass legitimate rounding. Given the
    intended arithmetic (integer-dominant pixel work with a float tier), is a
    sound tolerance derivable analytically (bounding FMA single-vs-double
    rounding per operation chain), or only empirically? Propose the shape a
    step-2 comparison SHOULD take (per-pixel max absolute difference?
    count-above-threshold? both?) and what evidence would justify a chosen T.

Q3  BUILD/INFRASTRUCTURE COST. The model doubles the SIMD build matrix
    (constrained + unconstrained per backend) and adds a second comparison
    regime to validation. From the build-system side (Zig, per-object
    targets, the existing batch), how heavy is that in practice? Is there a
    materially cheaper arrangement that preserves the same guarantees?

Q4  CONSTRAINT SCOPE. Today the only exactness constraint is FMA
    subtraction. From your knowledge of compiler behaviour, which OTHER
    codegen behaviours are plausible future threats to step-1 bit-exactness
    in real kernels (e.g. reciprocal/rsqrt approximations, vector-width-
    dependent reassociation, rounding-mode assumptions, autovectorizer
    reordering of float reductions), and are any of them relevant to
    integer-dominant deblocking arithmetic, or is this in practice a
    float-tier-only concern?

Q5  INTERACTION WITH STAGE 1B.2. Stage 1B.2 (feature-closure by assembly
    inspection) establishes WHICH instructions each backend's target may
    emit. Under the two-build model, 1B.2 presumably needs to establish TWO
    closures per backend (constrained and unconstrained). Does that change
    1B.2's shape or cost materially? Also confirm or challenge: 1B.2 proves
    instruction emission only; output-correctness comparison (steps 1-2)
    requires real kernels and belongs to Stage 2.

Q6  RECOMMENDATION. Adopt as target model now with step-2 tolerances
    deferred to Stage 2 (the W3X/W3D leaning)? Adopt with modifications?
    Or keep shipped bit-exactness and revisit later? Give reasoning, and
    name the strongest argument AGAINST the position you recommend.

----------------------------------------------------------------------
5. What this is not
----------------------------------------------------------------------

- Not a scope; no code, no build changes, no document edits are requested.
- Not a relaxation of G5/G6, dispatch, or the Stage 1B.1 object structure -
  those are orthogonal and unchanged. (The two-build model would double the
  gated objects at build time, but the non-PE-export/@extern/never-called
  discipline applies identically to both builds.)
- Not a decision. W3X compares W3C's assessment against W3D's before ruling.
