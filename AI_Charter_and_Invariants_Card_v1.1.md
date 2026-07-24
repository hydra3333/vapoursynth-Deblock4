# Deblock4 - Project Charter and Invariants Card

**Version:** 1.1
**Date:** 2026-07-24
**Status:** Ratified charter baseline. The pinned session card is Part 1.
**Companion specification:** `README_Deblock4_Design_Spec_v1.0.md`
**Companion SHA-256:** `7087807e520c8475c69eacf17288717beaa43b9b6912e2fa72577e57303058c4`
**Encoding:** US-ASCII only. See C-STY-01.

---

# Part 0 - What this project is (read once)

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

# Session bootstrap header

Every W3C session begins with a filled copy of this header. Nothing outside the listed package may be assumed present.

```text
Project:
    Deblock4

Charter:
    Deblock4_AI_Charter_and_Invariants_Card_v1.1.md
    SHA-256: <pinned hash>

Controlling specification:
    README_Deblock4_Design_Spec_v1.0.md
    SHA-256:
        7087807e520c8475c69eacf17288717beaa43b9b6912e2fa72577e57303058c4

Repository:
    <repository URL>

Branch:
    <branch>

Starting commit:
    <commit hash>

Active scope:
    <scope identifier and one-sentence objective>

Permitted changed files:
    <exact list>

Forbidden changed files:
    <exact list, or "all others">

Inputs supplied:
    <exact files and revisions>

Required validation:
    <build commands, test executables, expected pass/fail summary>

Expected result:
    exact build configurations;
    exact test executables;
    exact pass/fail summary;
    exact files expected to change;
    exact files forbidden to change.

Known open measurement gates:
    <only those relevant to this scope>

Implementation acceptance for this scope:
    <what "done" means, independent of any open measurement gate>

The session package contains:
    1. this completed header;
    2. Part 1 of this charter;
    3. the controlling README/specification;
    4. the active scope;
    5. all files the scope touches;
    6. any scope-specific test vectors or harness contract.
```

Two process notes on the hashes:

```text
The specification hash is recorded by W3D at scope-authoring time and
verified by W3X at session start.

If the specification changes after a scope is authored, the scope is
RE-ISSUED with the new hash rather than the hash being edited in place.
A stale hash must fail loudly, which is its entire purpose.
```

---

# Part 1 - THE CARD (pin at the top of every session)

> **Deblock4 non-negotiable invariants.** Violating any of these produces code that looks correct and fails later, usually at a stage far from the mistake. If a scope appears to require violating one, stop and escalate - do not resolve it locally.

## A. Correctness architecture

```text
A1  The canonical scalar implementation IS the specification.
    Required identity, for every supported format:
        scalar == SSE4.1 == AVX2

    Integer paths are byte-exact.
    Float paths are bit-exact across backends under strict mode and the
    same inherited process MXCSR state.

A2  Output must never depend on which backend ran, or on how any backend
    groups work into batches. Batch width is an implementation detail and
    must be invisible in the output.

A3  Estimates, benchmarks, and expectations are never requirements.
    Nothing untested becomes normative. No syntax, and no architecture
    level, is frozen before it compiles and its output is inspected.
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

## C. The two tail classes - never conflate

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

D4  Cross-orientation operations can be dependent at their crossings.
    Therefore the canonical vertical-pass-then-horizontal-pass order is
    output-defining and must never be relaxed.

    Never merge the vertical and horizontal passes.
    Never batch a vertical edge with a horizontal edge.

D5  SIMD may batch only across genuinely independent positions.
```

## E. Thresholds

```text
E1  Kernels RECEIVE thresholds as a parameter.
    They never fetch them from a general filter-instance pointer.
        filter_segment(samples..., thresholds)      correct
        filter_segment(samples..., &instance)       forbidden

E2  In fixed-strength Deblock4, base and midpoint threshold sets are
    computed ONCE at filter creation, in i64. Pixel kernels never scale
    or convert thresholds.

    A future automatic-strength driver may create or select threshold sets
    during its unmodified-source per-call pre-pass, but threshold
    arithmetic still remains outside the pixel kernels.

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
G1  CPU and operating-system capabilities are detected ONCE, into an
    immutable process/plugin-wide capability record.

    The requested backend is resolved once PER FILTER INSTANCE at filter
    creation:
        "auto"   -> highest backend allowed by the capability record
        "avx2"   -> AVX2 or creation error
        "sse41"  -> SSE4.1 or creation error
        "scalar" -> scalar

    Each instance stores an immutable function table or selected entry
    points. Frame processing performs no capability test and no backend
    selection. A function-pointer call in the hot path is fine; a
    feature-test branch or backend-choice branch is not.

G2  Generic and dispatch code must contain NO AVX2 instructions. Only the
    AVX2 object may assume them. Dispatch cannot require the feature it is
    detecting.

G3  The SSE4.1 and AVX2 objects are compiled for the smallest feature
    closures proven by the Zig 0.16.0 build and assembly spike.

    Dispatch checks exactly the features assumed by each compiled object.
    AVX2 additionally requires CPU AVX, OSXSAVE, and XCR0 XMM+YMM state.

    FMA is excluded from the AVX2 object.

    No architecture level such as x86_64_v2 or x86_64_v3 becomes normative
    before the object has compiled and its emitted instructions have been
    inspected. A public backend token and its detected feature set must
    name the same contract.

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

# Part 2 - Roles and three-way interaction

## 2.1 The three parties

| Tag | Who | Owns | Never does |
|---|---|---|---|
| **W3X** | The coordinator (human) | Decisions, repository, builds, test runs, commits, releases, all traffic between parties | - |
| **W3D** | Designer / reviewer (persistent AI session) | Specification authorship, design review, verification against source, harness design, scope authoring | Write production code |
| **W3C** | Coder (memoryless AI session) | Implementation to a supplied scope | Invent design, choose defaults, alter invariants |

## 2.2 Interaction rules

```text
I1  All traffic passes through W3X. W3D and W3C never communicate directly.
    Neither may assume the other has seen anything.

I2  W3C is memoryless by design. Every session receives:
        a completed session bootstrap header
        + Part 1 of this charter
        + the controlling README/specification
        + one bounded scope
        + every file and test contract that scope touches
    Nothing else may be assumed present.

I3  W3C implements the scope. Where the scope is ambiguous, W3C states the
    ambiguity and stops. It does not choose.

I4  W3D authors specifications, scopes, reviews, and harnesses.
    W3D does not write production code, and does not run anything.

I5  Disagreement between W3D and W3C is settled by evidence - source,
    standard, or measurement - not by role seniority. Either may be wrong,
    and both have been.

I6  Only W3X builds, runs, measures, and commits. No AI output is trusted
    to be correct until W3X has built and run it.
```

## 2.3 Scopes quote what they rely on

The controlling specification is roughly three thousand lines. Attaching it in full is required by I2, but a session that must locate twenty relevant lines inside it has merely traded one risk for another.

```text
Scopes quote the controlling specification sections in full, inline.

The attached specification is the authority and the tie-breaker.
The quotations are what the coder actually works from.

Quoting is not redundancy; it is the mechanism by which attaching the
whole specification remains practical.
```

## 2.4 Harness ownership

```text
H-OWN  W3D owns the independent acceptance and differential-identity
       harness: its cases, expected results, coverage obligations, and
       pass criteria.

       W3C does not invent or weaken acceptance criteria.

       W3C still implements:
           scope-required module-local tests;
           harness adapters and hooks;
           test-only backend selectors;
           fixtures explicitly specified by W3D.

       Local implementation tests supplement the independent harness.
       They never replace it.
```

Rationale, carried over from CNR3: an implementer writing their own acceptance tests tests what they built, not what was specified. For a project whose central claim is `scalar == SSE4.1 == AVX2`, that failure mode is fatal and silent.

The differential identity harness is the single most important artifact in this project after the scalar reference.

---

# Part 3 - Targets and toolchain

## 3.1 Fixed targets

```text
Language        Zig 0.16.0            pinned; chosen for ZLS support
Editor          VS Code + ZLS         ZLS supports 0.16.0
Host OS         Windows 10 / 11 x64
Target          x86_64-windows
Artifact        one DLL containing generic/dispatch code
                    + scalar
                    + SSE4.1
                    + AVX2 objects
Host app        VapourSynth API4, R76+ headers
Threading       fmParallel
Filter shape    1-in / 1-out, stateless
```

## 3.2 Instruction-set tiers

Exact feature closures are established by the Stage 1 spike, not asserted here (A3, G3, P-03).

```text
generic baseline
    plugin entry, registration, CPU/OS capability detection, scalar path
    -> supported Windows x86-64 baseline
    -> no SSE4.1, AVX, AVX2 or FMA assumption

SSE4.1 object
    -> baseline + the smallest tested feature closure required by
       generated SSE4.1 code
    -> expected to include SSE4.1
    -> exact closure fixed only after the Zig 0.16.0 compile/assembly spike

AVX2 object
    -> baseline + the smallest tested feature closure required by
       generated AVX2 code
    -> expected to include AVX and AVX2
    -> FMA excluded
    -> exact closure fixed only after the Zig 0.16.0 compile/assembly spike

Runtime detection checks exactly the final compiled closure, plus the
required OSXSAVE and XCR0 state for AVX/YMM use.
```

The scalar path is the canonical reference, is always available, and is also a production backend token.

## 3.3 Build modes

```text
DLL production objects:
    generic/dispatch  ReleaseFast
    scalar            ReleaseFast
    SSE4.1            ReleaseFast
    AVX2              ReleaseFast

Harness / reference build:
    canonical scalar  ReleaseSafe

Optional diagnostic builds:
    all objects       Debug or ReleaseSafe as required by the active scope
```

Explanation, because this distinction is easy to lose:

```text
The ReleaseSafe scalar harness build is the arithmetic and bounds oracle.
The scalar code inside the production DLL is a production backend and is
compiled with the DLL's production optimisation mode.

Both instantiate the SAME canonical scalar source. They differ only in
build mode and use. There is never a second implementation.
```

Why the oracle is built differently: `ReleaseFast` removes integer overflow checking. The i16 arithmetic tier is safe only because of the range proof; there is no runtime net beneath it. `ReleaseSafe` turns a range-proof error into a trap during validation instead of silently wrapped arithmetic in production.

Required consequence:

```text
At least once per release, the production DLL's scalar backend is run
through the differential harness and shown to match the ReleaseSafe
oracle exactly.

A mismatch is not a harness defect. It is proof that the range proof is
wrong, and it halts the release.
```

## 3.4 Performance posture

Speed matters, but never at the cost of an invariant. A faster schedule that changes output is not faster, it is a different filter. A wider batch that crosses a dependency is not an optimisation, it is a bug.

The honest expectation, worth holding so effort lands where it pays: on 720x576 field-separated material this filter will not be the bottleneck in any realistic restoration chain. AVX2 work is justified by correctness of engineering and by users with larger sources, not by the coordinator's own throughput.

---

# Part 4 - Coding standards

```text
C-STY-01  US-ASCII ONLY, in all project artifacts without exception:
              production source and comments;
              generated diagnostics and test output;
              patch files and commit messages;
              commands and code blocks;
              specifications, charters, scopes, and all other documents.

          Rationale: a single rule with no exceptions is mechanically
          checkable. Validation may reject any byte above 0x7F anywhere in
          the repository, with no judgement required about which artifact
          class a file belongs to.

          Note: shields.io badges, HTML header blocks, and markdown image
          syntax are already pure ASCII (URL-encoded), so this rule does
          not affect README presentation.

C-STY-02  Comments are plentiful and human-readable. Explain WHY, especially
          where an invariant is being honoured. A reader six months later
          must be able to see that a loop bound is derived and not arbitrary.

C-STY-03  Name the invariant by its card reference at the ENFORCEMENT POINT,
          or at the narrow helper that centralises it, together with an
          assertion where one is possible.
              e.g. "// D4: never batch across orientations"
          Do not repeat the same invariant comment at every caller when one
          authoritative comment and assertion already protect the rule.

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

# Part 5 - Process rules

```text
P-01  VERIFY COLD.
      Claims about existing code are verified against source with file and
      line, in the current session, not recalled. "I believe HolyWu does X"
      is not evidence.

P-02  SKEPTICISM IS THE PRIMARY INSTRUMENT.
      Plausible-sounding agreement is the failure mode to guard against, not
      disagreement. A review that finds nothing should be suspected before
      it is celebrated.

P-03  NOTHING UNTESTED BECOMES NORMATIVE.
      Build syntax, API spellings, architecture levels, and codegen
      expectations are provisional until they compile and run. Documents
      mark them as such.

P-04  ONE SCOPE, ONE DELIVERABLE, ONE REVIEW.

      The six macro-stages are planning and reporting buckets, not a rule
      that every stage must be implemented in one scope.

      A macro-stage may be divided into a small number of bounded subscopes
      when each has:
          one independently reviewable objective;
          an exact changed-file set;
          an executable validation result;
          no speculative dependency on later work.

      A subscope must not split the enforcement of a single invariant across
      two scopes. Where an invariant's correctness depends on two artifacts
      agreeing, those artifacts belong in one scope. For example, the
      per-plane-class radii (B2, B3) and the bounds derived from them (B4)
      are implemented and reviewed together; a subscope adding bounds logic
      while the radii constants live in an unwritten module will produce
      plausible literals that satisfy the scope and violate B3.

      Do not reproduce CNR3-style proof microphase proliferation.
      Do not make a scope so large that a memoryless coder must change
      several independent architectural surfaces at once.

P-05  DESIGN DECISIONS ARE RECORDED WITH THEIR REASONS.
      A decision without a recorded rationale will be re-litigated, or worse,
      silently reversed by someone who cannot see why it was made.

P-06  SETTLED-BY-DESIGN AND PROVEN-BY-MEASUREMENT ARE DIFFERENT STATES.
      Both are legitimate. Conflating them is not.

P-07  MEASUREMENT CLOSES MEASUREMENT QUESTIONS.
      Once an item is marked measurement-gated, further abstract argument is
      not progress. Build the harness and run it.

P-08  SOURCE PROVENANCE IS PINNED.
      Claims resting on software source record the exact repository, tag or
      commit, file, and relevant lines.

      Claims resting on a standard record the exact edition and the best
      available clause, page, or definition references.

      Where the controlling evidence is a documented structural derivation
      from several standard definitions, preserve the definitions and the
      full derivation; do not invent a clause number merely to satisfy a
      citation format.

P-09  A coding scope may implement the controlling specification.
      It may not amend this charter or the README unless the scope
      explicitly identifies a documentation amendment ratified by W3X.

P-10  IMPLEMENTATION ACCEPTANCE IS SEPARATE FROM MEASUREMENT GATES.
      A scope may PASS its implementation acceptance while a related quality
      question remains OPEN.

      For example: a scalar implementation may pass algorithmic correctness
      while Schedule A versus B remains an open quality decision; a proper
      chroma implementation may pass identity and safety while its
      settled-by-design quality validation remains open.

      Implementation proof is never blocked on corpus availability.
```

---

# Part 6 - Quick reference

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

Stage 1 gating, stated precisely:

```text
Stage 1 does NOT gate:
    scalar algorithm design;
    source review;
    test-vector authoring;
    corpus assembly.

A working Zig build scaffold DOES gate:
    executable scalar tests;
    accepted code integration;
    backend object and link work.

A difficulty in one optional dispatch/build experiment must not prevent
independent scalar design work from continuing.
```

Corpus assembly begins during Stage 2 and is the most likely schedule risk, being procurement rather than coding. Extensibility guards (E1, E4, E5) enter kernel signatures during Stage 2, when they are nearly free.

## 6.3 Public API names

```text
grid_mode                    REQUIRED, no default
                             "h264" | "mpeg2_progressive"
                             | "mpeg2_field_separated" | "custom"
                             | "auto" (reserved, currently rejected)

strength                     base table index, 0..60, default 25
                             effective floor is 16; at or below 15 the
                             filter is a no-op on that axis

boundary_strength_offset     shifts the alpha and tc0 index
                             legal range [-strength, 60 - strength]

side_activity_offset         shifts the beta index only
                             legal range [-strength, 60 - strength]

midpoint_threshold_scale     scales luma midpoint alpha/beta only
                             0.0 .. 1.0; conditional on a midpoint class

planes                       default all

backend                      "auto" | "avx2" | "sse41" | "scalar"

custom-mode primitives       luma_step_x, luma_step_y,
                             chroma_step_x, chroma_step_y,
                             luma_midpoint_enabled
                             accepted ONLY with grid_mode="custom"
```

## 6.4 Terms that are easy to confuse

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
| Dispatch | Per-instance backend resolution at creation | A per-frame decision |

---

# Part 7 - Revision history

## v1.1 (2026-07-24)

Issued after independent coder review of v1.0. All fourteen required corrections and five recommendations accepted.

Substantive corrections, recorded with their causes because they are the clearest available evidence for P-01 and P-02:

- **G1 contradicted a settled API decision.** v1.0 stated that dispatch resolves once at plugin load into a globally immutable function pointer. That is incompatible with `backend` being a per-instance user parameter, which W3D itself had recommended two rounds earlier so that users could self-diagnose backend identity failures. Two filter instances in one script may legitimately request different backends. Corrected to: capability discovery global and once; backend resolution per instance and once; no per-frame decision. The invariant that mattered survives and is sharper, because it now names what is forbidden in the hot path rather than describing a pointer's lifetime. **Found by review, not by implementation failure.**
- **Part 3.2 violated A3 and P-03.** v1.0 froze `x86_64_v2` as the SSE4.1 contract before the Stage 1 spike, four sections after stating that nothing untested becomes normative. It was also technically wrong: `x86_64_v2` includes SSE3, SSSE3, SSE4.2 and POPCNT, so a public backend token named `"sse41"` would have demanded features its name does not mention. Feature closures are now fixed by the spike, and token names must match detected feature sets.
- **C-STY-01 contradicted itself.** v1.0 mandated ASCII-only documents while using em dashes, including in its own title. Resolved by W3X ratification in favour of full ASCII across all artifacts, on the grounds that it matches established practice, removes a recurring per-document judgement, and is mechanically checkable.
- **D4 was over-broad.** "Across orientations, everything is dependent, always" is mathematically stronger than the truth. The dependency exists at crossings, and that is sufficient to make the canonical pass order output-defining. Narrowed without weakening the guard.
- **E2 was too broad** and appeared to forbid the future automatic-strength pre-pass that E4 anticipates. Scoped to fixed-strength Deblock4.
- **P-08 conflicted with the accepted H.262 structural proof**, having demanded a clause number for a conclusion that rests normatively on a derivation from two definitions. Amended to preserve derivations rather than invent citations.
- **H-OWN could be read as forbidding module-local tests.** Clarified: W3D owns acceptance criteria, W3C still writes ordinary unit tests.
- **P-04 over-corrected against CNR3.** Macro-stages are planning buckets; bounded subscopes are permitted, with a new rule that a subscope must not split one invariant's enforcement.

Additions: session bootstrap header with pinned specification hash; scalar object in the DLL artifact statement; production-versus-harness scalar build modes with a required per-release cross-check; MXCSR qualification on float identity and harness recording of MXCSR state; Stage 1 gating stated precisely; P-09 and P-10 added; public API names added to quick reference.

## v1.0 (2026-07-24)

Initial charter. Not ratified; superseded by v1.1 before use.

---

*This card and charter are maintained by W3D and ratified by W3X. Changes to Part 1 require explicit ratification and a version bump; changes elsewhere do not.*
