# Deblock4 — Project Charter and Invariants Card

**Version:** 0.1
**Date:** 2026-07-24
**Status:** Working charter. Part 1 is pinned at the top of every W3D and W3C session.
**Companion:** `README_Deblock4_Draft_Spec_v0.6.md` (the specification; this document does not restate it)

---

# Part 0 — What this project is (read once)

Deblock4 is a VapourSynth plugin, written in Zig, that removes block artifacts left behind by lossy video compression. It is a from-scratch reimplementation informed by HolyWu's `VapourSynth-Deblock`, not a port of it.

The immediate purpose is restoration of PAL 576i tape material captured to MPEG-2 by consumer hardware DVD recorders, where coarse quantisation of a noisy analogue signal leaves visible 8x8 block structure.

Three filters are planned, in order:

```text
Deblock4                  the core edge filter          <- current work
Deblock4_qed              masked/blended variant        <- later
Deblock4_qed_autoadjust   automatic strength selection  <- last
```

Four things distinguish it from the filter it is informed by:

1. **The block grid is a parameter.** HolyWu's filter is H.264-derived and hard-anchored to a 4-pixel grid at origin (0,0). MPEG-2 uses 8x8 transforms, so on MPEG-2 material half of its candidate edges sit mid-block. Deblock4 takes explicit per-plane-class grid steps.
2. **Chroma gets a proper chroma filter.** HolyWu applies the luma filter to chroma planes; H.264 defines a distinct, gentler chroma filter that modifies only the two samples adjacent to the boundary. Deblock4 implements the proper one.
3. **AVX2 exists.** The reference offers C and SSE4.1 only.
4. **Correctness is provable, not assumed.** A canonical scalar implementation is the executable specification, and every backend must reproduce it exactly.

The project is deliberately small in scope compared to CNR3. Deblock4 is stateless and one-frame-in/one-frame-out: there is no cache, no reordering, no cross-frame state, and therefore none of the diagnostic apparatus that state demanded.

---

# Part 1 — THE CARD (pin at the top of every session)

> **Deblock4 non-negotiable invariants.** Violating any of these produces code that looks correct and fails later, usually at a stage far from the mistake. If a scope appears to require violating one, stop and escalate — do not resolve it locally.

## A. Correctness architecture

```text
A1  The canonical scalar implementation IS the specification.
    Required identity, for every supported format:
        scalar == SSE4.1 == AVX2
    Byte-exact for integer paths. Bit-exact for float under strict mode.

A2  Output must never depend on which backend ran, or on how any backend
    groups work into batches. Batch width is an implementation detail and
    must be invisible in the output.

A3  Estimates, benchmarks, and expectations are never requirements.
    Nothing untested becomes normative. No syntax is frozen before it compiles.
```

## B. Geometry and bounds

```text
B1  Edge position convention, used everywhere without exception:
        e = index of the FIRST sample on the q side of the boundary
        p2 p1 p0 | q0 q1 q2   =   e-3 e-2 e-1 | e e+1 e+2

B2  Footprints are PER PLANE CLASS. They are not global.
        luma          read e-3 .. e+2    write e-2 .. e+1
        proper chroma read e-2 .. e+1    write e-1 .. e

B3  Radii are named constants selected by plane class.
    They are NEVER written as literals, and neither is any value derived
    from them. The literal 7 (minimum extent) is specifically forbidden:
    it is correct only for edge_step = 4.

B4  Eligibility, derived per axis, per plane, from that plane's own
    dimensions and that plane class's own radii:
        eligible(e)  <=>  e - read_radius_before >= 0
                     AND  e + read_radius_after  <= extent - 1

B5  Chroma steps are in CHROMA SAMPLE coordinates.
    They are never derived by dividing luma steps by a subsampling ratio.
    (An MPEG-2 4:2:0 macroblock has one 8x8 chroma block per component
    covering the whole 16x16 luma area: chroma pitch 8 = luma pitch 16.)

B6  No whole-frame padding, resizing, or cropping.
    No reliance on VapourSynth stride padding for over-reads or over-writes.
```

## C. The two tail classes — never conflate

```text
C1  Incomplete ALGORITHMIC footprint (would read outside the plane):
        leave unchanged. Do not invent pixels.

C2  Complete valid footprint that merely underfills a vector register:
        STILL PROCESSED, via narrower vectors or scalar cleanup.
        "Does not fill a YMM register" is not "invalid edge".
```

## D. Schedule and dependency

```text
D1  The canonical schedule is output-defining. It is not a performance choice.

D2  Luma: adjacent same-orientation edges OVERLAP (edge at e writes e-2..e+1;
    edge at e+4 reads from e+1). Left-to-right and top-to-bottom order is
    load-bearing. Never batch adjacent luma edge positions.

D3  Proper chroma: adjacent same-orientation edges are INDEPENDENT for
    edge_step >= 3 (write e-1..e; next read begins at e+step-2).
    Batching across chroma edge positions is permitted.

D4  Across orientations, everything is dependent, always.
    Never merge the vertical and horizontal passes.
    Never place a vertical and a horizontal edge in the same batch,
    even in chroma where D3 applies.

D5  SIMD may batch only across genuinely independent positions.
```

## E. Thresholds

```text
E1  Kernels RECEIVE thresholds as a parameter.
    They never fetch them from a general filter-instance pointer.
        filter_segment(samples..., thresholds)      correct
        filter_segment(samples..., &instance)       forbidden

E2  Threshold scaling happens ONCE at filter creation, in i64, producing
    immutable threshold sets. Kernels select a set. Kernels never scale,
    never convert, never perform float arithmetic on thresholds.

E3  Midpoint activation reads the CURRENT DESTINATION state at that exact
    canonical schedule point. It must not read pristine source.

E4  A future strength map reads the UNMODIFIED SOURCE in a pre-pass.
    This is deliberately the opposite rule to E3. Do not conflate them.

E5  Any future auto-derived threshold must stay inside the domain the
    arithmetic range proof assumed, or the range proof is re-derived.
```

## F. Numeric policy

```text
F1  Non-finite (NaN / infinity) handling is evaluated PER EDGE POSITION,
    over exactly that position's read footprint. Never per segment,
    never per batch. Implement by lane masking, never by declining a batch.
    (Per-batch declining makes output depend on backend width: see A2.)

F2  Strict floating point. No contraction, no reassociation, no fast-math.
    FMA is excluded from the AVX2 object's target feature set, so
    contraction is impossible at the code-generation level.

F3  The plugin never modifies MXCSR. Denormal behaviour is inherited from
    the host and must not be depended upon.

F4  Arithmetic tiers:  8-12 bit -> i16 (after proof)
                      13-16 bit -> i32
                          float -> strict f32
```

## G. Dispatch and build

```text
G1  Dispatch happens ONCE at plugin load. The resulting function pointer is
    immutable thereafter and is therefore safe to call from any fmParallel
    worker without synchronisation. No per-frame dispatch.

G2  Generic and dispatch code must contain NO AVX2 instructions. Only the
    AVX2 object may assume them. Dispatch cannot require the feature it is
    detecting.

G3  The AVX2 object is compiled to a minimal feature closure
    (v2 baseline + AVX + AVX2), and the runtime detector must check exactly
    that closure — including OSXSAVE and XCR0 XMM+YMM state, not merely the
    AVX2 CPUID bit.

G4  Deblock4 is stateless and 1-in/1-out. No shared mutable state beyond
    immutable configuration. All scratch is per-call, never per-instance.
```

## H. When to stop

```text
H1  If a scope seems to require violating an invariant, STOP and escalate.
    Do not resolve it locally, and do not "improve" the invariant.

H2  If a claim about existing code cannot be verified against source with
    file and line, it is not a fact. Say so rather than inferring.

H3  If a required value has no evidence behind it, leave it explicitly
    unset rather than guessing a plausible default.
```

*(End of card.)*

---

# Part 2 — Roles and three-way interaction

## 2.1 The three parties

| Tag | Who | Owns | Never does |
|---|---|---|---|
| **W3X** | The coordinator (human) | Decisions, repository, builds, test runs, commits, releases, all traffic between parties | — |
| **W3D** | Designer / reviewer (persistent AI session) | Specification authorship, design review, verification against source, harness design, scope authoring | Write production code |
| **W3C** | Coder (memoryless AI session) | Implementation to a supplied scope | Invent design, choose defaults, alter invariants |

## 2.2 Interaction rules

```text
I1  All traffic passes through W3X. W3D and W3C never communicate directly.
    Neither may assume the other has seen anything.

I2  W3C is memoryless by design. Every session receives:
        this card (Part 1)
        + one scope
        + the files that scope touches
    Nothing else may be assumed present.

I3  W3C implements the scope. Where the scope is ambiguous, W3C states the
    ambiguity and stops. It does not choose.

I4  W3D authors specifications, scopes, reviews, and harnesses.
    W3D does not write production code, and does not run anything.

I5  Disagreement between W3D and W3C is settled by evidence — source,
    standard, or measurement — not by role seniority. Either may be wrong,
    and both have been.

I6  Only W3X builds, runs, measures, and commits. No AI output is trusted
    to be correct until W3X has built and run it.
```

## 2.3 Harness ownership

Carried over from CNR3, where it repeatedly proved its worth:

```text
H-OWN  The test harness is a W3D deliverable, not a W3C by-product.

Rationale: an implementer writing their own tests tests what they built,
not what was specified. For a project whose central claim is
scalar == SSE4.1 == AVX2, that failure mode is fatal and silent.
```

The differential identity harness is the single most important artifact in this project after the scalar reference. It should be scoped and reviewed as a first-class deliverable, not appended to an implementation stage.

---

# Part 3 — Targets and toolchain

## 3.1 Fixed targets

```text
Language        Zig 0.16.0            pinned; chosen for ZLS support
Editor          VS Code + ZLS         ZLS supports 0.16.0
Host OS         Windows 10 / 11 x64
Target          x86_64-windows
Artifact        one DLL, containing generic + SSE4.1 + AVX2 objects
Host app        VapourSynth API4, R76+ headers
Threading       fmParallel
Filter shape    1-in / 1-out, stateless
```

## 3.2 Instruction-set tiers

```text
generic baseline    plugin entry, registration, dispatch, CPU detection
                    -> must run on any x86-64. No AVX2 anywhere.

SSE4.1              one compiled object
                    -> x86_64 v2 baseline

AVX2                one compiled object
                    -> v2 + AVX + AVX2, minimal closure, FMA EXCLUDED
```

A pre-SSE4.1 scalar path exists as the canonical reference and is always available.

## 3.3 Build modes

```text
production backends     ReleaseFast
canonical scalar        ReleaseSafe when built for the harness
```

Rationale, and worth stating because it is easy to get backwards: `ReleaseFast` removes integer overflow checking. The i16 arithmetic tier is safe only because of the range proof — there is no runtime net beneath it. Building the scalar reference in `ReleaseSafe` for harness runs means any range-proof error surfaces as a trap during validation rather than as silently wrapped arithmetic in production. Cheap insurance; the harness is not performance-critical.

## 3.4 Performance posture

Speed matters, but never at the cost of an invariant. Concretely: a faster schedule that changes output is not faster, it is a different filter. A wider batch that crosses a dependency is not an optimisation, it is a bug.

The honest expectation, worth holding in mind so effort lands where it pays: on 720x576 field-separated material this filter will not be the bottleneck in any realistic restoration chain. AVX2 work is justified by correctness of engineering and by users with larger sources, not by the coordinator's own throughput.

---

# Part 4 — Coding standards

```text
C-STY-01  ASCII only. In source, comments, commit messages, and documents.

C-STY-02  Comments are plentiful and human-readable. Explain WHY, especially
          where an invariant is being honoured. A reader six months later
          must be able to see that a loop bound is derived and not arbitrary.

C-STY-03  Every invariant that could be violated silently gets either an
          assertion or a comment naming the invariant by its card reference,
          e.g. "// D4: never batch across orientations".

C-STY-04  Named constants, never magic numbers. This is not style preference
          here: B3 forbids literal radii and derived values outright.

C-STY-05  Explicit over clever. This code will be read by memoryless sessions
          that cannot infer intent from history.

C-STY-06  Public API names state their actual effect. Inherited names are not
          preserved for familiarity when they mislead.

C-STY-07  One module, one responsibility. Kernel modules contain arithmetic;
          drivers contain traversal; policy modules contain validation and
          preset expansion. Kernels do not read configuration.
```

---

# Part 5 — Process rules

Adapted from CNR3 practice, restated for this project's shape.

```text
P-01  VERIFY COLD.
      Claims about existing code are verified against source with file and
      line, in the current session, not recalled. "I believe HolyWu does X"
      is not evidence. This rule has already caught four errors in this
      project that would otherwise have reached code.

P-02  SKEPTICISM IS THE PRIMARY INSTRUMENT.
      Plausible-sounding agreement is the failure mode to guard against, not
      disagreement. A review that finds nothing should be suspected before
      it is celebrated.

P-03  NOTHING UNTESTED BECOMES NORMATIVE.
      Build syntax, API spellings, and codegen expectations are provisional
      until they compile and run. Documents mark them as such.

P-04  ONE SCOPE, ONE DELIVERABLE, ONE REVIEW.
      Scopes are sized to the six macro-stages, not subdivided into proof
      microphases. This project does not need CNR3's granularity because it
      has no cross-frame state to police.

P-05  DESIGN DECISIONS ARE RECORDED WITH THEIR REASONS.
      A decision without a recorded rationale will be re-litigated, or worse,
      silently reversed by someone who cannot see why it was made.

P-06  SETTLED-BY-DESIGN AND PROVEN-BY-MEASUREMENT ARE DIFFERENT STATES.
      Both are legitimate. Conflating them is not. Documents keep them
      visibly distinct.

P-07  MEASUREMENT CLOSES MEASUREMENT QUESTIONS.
      Once an item is marked measurement-gated, further abstract argument is
      not progress. Build the harness and run it.

P-08  SOURCE PROVENANCE IS PINNED.
      Any claim resting on HolyWu, FFmpeg, or a standard records the exact
      tag, commit, or clause, so it can be re-verified later.
```

---

# Part 6 — Quick reference

## 6.1 Where things are decided

| Question | Answer lives in |
|---|---|
| What the algorithm does | `spec.zig` (executable) and the README |
| Whether output is correct | The differential identity harness |
| Whether output looks good | The scalar quality gate and corpus |
| Whether it is fast | Benchmarks, after correctness |
| What a parameter means | README public API section |
| Whether something may be changed | This card |

## 6.2 The six development stages

```text
1  Zig project / build / dispatch scaffold and spikes
2  Canonical scalar core and proof harness
3  Scalar quality decisions (Schedule A/B, midpoint scale, chroma)
4  SSE4.1 backend and identity proof
5  AVX2 backend and identity and performance proof
6  VapourSynth integration, validation matrix, docs, release readiness
```

Notes: Stage 1 gates nothing — scalar work proceeds even if a build spike stalls. Corpus assembly begins during Stage 2 and is the most likely schedule risk, being procurement rather than coding. Extensibility guards (E1, E4, E5) enter kernel signatures during Stage 2, when they are nearly free.

## 6.3 Terms that are easy to confuse

| Term | Means | Does not mean |
|---|---|---|
| `edge_step` | Spacing of candidate boundaries | Anything about vectors |
| `boundary_strength_offset` | Shifts detection threshold **and** correction limit | Detection only |
| `side_activity_offset` | Shifts per-side flatness threshold only | Anything about strength |
| Offset (in a parameter name) | An offset to the strength index | A spatial offset |
| Segment | Base group of positions along one edge | A vector width |
| Midpoint class | Candidate positions at odd multiples of the half-step | A second detector |
| Schedule | The canonical traversal order | A performance choice |
| Grid | Where block boundaries are | Where vectors start |

---

*This card and charter are maintained by W3D and ratified by W3X. Changes to Part 1 require explicit ratification and a version bump; changes elsewhere do not.*
