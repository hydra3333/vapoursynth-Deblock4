# Deblock4 - Stage 2C Coder Scope: Classic Scalar Oracle and HolyWu Differential

**Deliverable:** W3D-2C-D4 (SCOPE - for W3X ratification and release to W3C)
**Version:** 1.0
**Date:** 2026-08-03
**Author:** W3D (designer)
**Status:** DRAFT for mandatory W3C pre-implementation review (with D3 v1_3).
NOT released. W3X alone releases, accepts and commits.
**Built from:** D0 v1_5 (binding knowledge index), D1 (pinned r9 snapshot +
provenance v1.1), D2 v1_3 (HolyWu Real Schedule), D3 v1_3 (obligations and
sanity gate). Cite those documents, not this summary, where they are more
specific.
**Encoding:** US-ASCII; CRLF.

---

# 0. KNOWLEDGE SWEEP (standing, two-sided - D0 section 6.1, verbatim)

```text
KNOWLEDGE SWEEP (standing, two-sided): Before implementation, W3C must
independently search the committed documentation set (excluding
superseded/) for relevant non-superseded, non-withdrawn knowledge,
rules, or decisions bearing on this scope, WITHOUT starting from the
checklist below, and report as numbered findings anything relevant that
the checklist or the Stage 2C+ Binding Knowledge Index does not carry.
Withdrawn alternatives are reportable only as do-not-revisit
confirmations. W3D verifies; confirmed items become new index K-numbers;
W3X adopts any scope amendment.
```

# 1. What Stage 2C delivers

The FIRST real deblocking mathematics in Deblock4: a plain-Zig scalar
oracle for deblock4.Classic, wired into the production frame path for
integer formats, plus the external HolyWu differential harness that
validates it.

```text
IN SCOPE
  1. src/classic_scalar_kernel.zig - the shared edge kernel (comptime
     element type), authored per K24 so the SAME body can later be
     instantiated for v2/v3 widths WITHOUT rewriting it.
  2. src/classic_edge_schedule.zig - Schedule A traversal + per-position
     eligibility bounds (D2 section 3; D3 O-7; README 6.1/6.2/6.5).
  3. src/classic_thresholds.zig - the three 61-entry tables and the
     derivation chain (D2 section 2; D3 O-1/O-1c).
  4. Wiring the above into the Classic frame path in place of
     pass-through, for INTEGER formats only (see decision S1).
  5. Zig unit tests asserting EVERY D3 v1_3 obligation on its routed
     proof surface (D3 section 1 routing rule).
  6. tests/stage_2c_classic_*.vpy + the 2C batch runner: end-to-end
     cases, the whole-image sanity gate, and the creation-path cases.
  7. tools/holywu_reference/ - the K26 external differential harness
     (section 6), including the reference-build record.
  8. build_2C_v1.bat - the Stage 2C proof matrix, extending the standing
     fifteen-gate 1C matrix (section 7).

OUT OF SCOPE (do not touch, do not "improve")
  - ANY @Vector code, SIMD intrinsic, or backend object (4C = v2,
    5C = v3). 2C is scalar only. K1/K24/K13.
  - deblock4.Deblock4 pixel work, grid_mode, midpoint, Schedule B,
    field-DCT geometry (2D).
  - Registration, parameter validation, creation-error strings, the
    using-echo surfaces, tier selection/detection, G10 debug modules
    (K13/K14/K16).
  - superseded/ (never read, move or delete - K17).
  - The pinned reference under dev_documentation/reference/holywu_r9/
    (W3X-owned, read-only, never modified or EOL-normalised).
```

# 2. Ratified scope decisions

```text
S1  FLOAT (resolves register T-2). Stage 2C implements INTEGER formats
    (8..16 bit) ONLY. Classic's 1C creation currently has NO sample-type
    gate, so a 32-bit float clip is accepted today and would reach the
    new pixel path. Silent pass-through of float once Classic deblocks
    would be a lie to the user. Therefore 2C ADDS one creation-error row
    (an ADDITION to, not an alteration of, the ratified table - K16):
      Classic: float input is not supported yet
    W3X RATIFICATION REQUIRED for creation-error table v1_2 carrying
    this row. Float support (bias-free unclamped formulas, the K22/V&T
    3.8 tolerance numbers, and the documented HolyWu non-finite
    divergence per D2 section 5) is DEFERRED to a later bounded step.
    If W3X prefers float acceptance in 2C instead, this scope must be
    re-issued: it materially changes the obligation set.

S2  EXPLICIT FINAL CLAMPS (resolves Open Rule Question Q1; W3C and W3D
    positions concurred). The scalar kernel RETAINS explicit 0..peak
    final sample clamps. Recorded as an intentional architecture and
    safety decision - cheap, mirrors the reference, makes the range
    guarantee locally obvious, survives maintenance and changed
    preconditions - NOT as though byte-equivalence compels that exact
    expression. D3 O-6f's worst-case bound proof is retained ALONGSIDE
    the clamps, not instead of them.

S3  DIFFERENTIAL DOMAIN. The HolyWu comparison covers the LEGAL SHARED
    DOMAIN only: mod-8 frame geometry, in-range offsets, integer
    formats. The three documented divergences (HolyWu's offset clamp,
    its pad-filter-crop wrapper, its float non-finite behaviour) are
    external-only facts, never Classic behaviours to reproduce, and the
    harness must ASSERT its inputs are in-domain rather than assume it
    (D0 section 5; D2 sections 6/8; D3 O-1b).

S4  ORACLE STATUS. Per the oracle-construction exception (charter G7;
    V&T 20.2; K9), this delivery is accepted against D3 v1_3's
    obligations plus its sanity gate - NOT against a pre-existing
    oracle. AFTER acceptance the delivered scalar path BECOMES the
    oracle, and every later Classic pixel/copy/backend change is
    accepted only by byte-identical differential against it (K19 layer
    (c)).
```

# 3. Architecture requirements

```text
A1  SHARED KERNEL, COMPTIME-PARAMETERISED (K24; V&T 11.1). Author the
    edge mathematics ONCE, parameterised at comptime over element type
    (u8..u16) and the derived peak/scale. The 2C instantiation is
    scalar (one sample per lane-position, plain arithmetic). The body
    must be structured so a later width parameter can instantiate the
    SAME logic for v2/v3 without rewriting the mathematics. Do NOT
    write vector code now; do NOT hand-specialise per bit depth.
A2  WELL-DEFINED ARITHMETIC (K26 corollary; D2 WP-1). Compute the delta
    core as an i32 MULTIPLY BY 4 - never a negative left-shift analogue
    (that construction is C++ UB in the reference; Zig must not mirror
    the hazard). Divisions use signed >> (arithmetic/floor). NEVER
    @divTrunc, symmetric rounding, or float arithmetic on integer paths.
    All intermediates in i32 (D3 O-6f bounds), not the pixel type.
A3  NO FUSED FLOAT, NO @mulAdd anywhere (K6) - trivially satisfied by
    S1 but stated so it survives the later float step.
A4  SCHEDULE FIDELITY (D2 section 3; K11). Reproduce Schedule A exactly:
    top band vertical sweep; then per band - horizontal at x=0, then per
    interior x horizontal THEN vertical; sequential, in place, on the
    destination copy. The order is output-defining (D2's four documented
    overlaps). No tiling, no intra-frame parallelism, no reordering.
A5  BOUNDS FROM THE FOOTPRINT, NOT A MODULUS (README 6.2; D3 O-7).
    Eligibility per edge position per axis: e - read_radius_before >= 0
    AND e + read_radius_after <= extent - 1, candidates at multiples of
    edge_step. Consume the NAMED footprint descriptor; no hard-coded
    literals, no mod-8 assumption, no padding, no crop, no invented
    pixels. Orientations independent; neither eligible -> byte-identical
    pass-through.
A6  NO STRIDE ABUSE (README 6.4). Stride slack is never algorithm-usable
    and never written (D3 O-6e canaries prove it).
A7  DETERMINISM AND SOURCE IMMUTABILITY (K23; D3 O-6d). Same binary +
    input + parameters -> byte-identical output; the source frame is
    never modified.
A8  G10/G6 DISCIPLINE UNCHANGED (K14, charter G6/G10). Any new debug
    output follows the ratified three-layer pattern; no new PE exports;
    the release G10 three-surface absence proofs must stay green.
```

# 4. Implementation obligations (the mathematics)

Implement exactly what D2 v1_3 documents; D3 v1_3 judges it. The
normative statements live there - this section only fixes the pointers:

```text
- thresholds, offset clamp chain, bit-depth scaling: D2 section 2
  (Classic REJECTS out-of-range offsets - D3 O-1b - it does NOT clamp
  like HolyWu; the clamp chain applies to the LEGAL domain).
- horizontal edge: D2 section 4.1; vertical edge: D2 section 4.2.
- activation and side-activity gates: STRICT < at all five comparison
  sites (D3 A1/A3/A5/B7/B8).
- c widening and the shared ap/aq write gating: D2 4.1; D3 B3/B7/B8.
- c0 from the ALPHA index (D2 WP-5): FAITHFUL. Do not "fix". Any change
  is a K19 layer-(a)/K20 proposal for the 3C quality gate (register T-1).
- read footprint e-3..e+2, write footprint e-2..e+1 (K7).
- luma-on-chroma: the full luma algorithm, same thresholds, 4-grid in
  each plane's own coordinates (D2 section 3; D3 O-5a).
- unprocessed planes: byte-identical copy (D3 O-5b).
```

# 5. Acceptance basis

D3 v1_3 in full: O-1, O-1b, O-1c, O-2 (A1-A5), O-3 (B1-B8), O-4 with its
order-sensitivity and top-band obligations, O-5 (a-d incl. the LITERAL
native-16-bit matrix - the x256 shortcut is FALSE), O-6 (a general
write-footprint-union invariant, b-c, d source immutability, e canaries,
f i32 range proof), O-7 (a 10x10, b 12x6, c 6x6, c2 11x7), and the
sanity gate G1-G6 INCLUDING the mandatory constant-fill negative control
that the gate must reject. Proof routing per D3 section 1.

# 6. The external HolyWu differential harness (K26)

```text
H1  REFERENCE BUILD. Build the pinned r9 source (D1 snapshot bytes) as a
    VapourSynth plugin for the reference run. Record a REFERENCE-BUILD
    RECORD file containing: compiler and version; C++ language mode;
    optimisation and floating-point flags; VapourSynth version; invoked
    plugin versions; the exact SHA-256 of the built DLL; and the D1
    source hashes it was built from.
H2  FORCED SCALAR PATH. Every reference invocation passes opt=1.
    opt=0 auto-selects SSE4 on capable x86 (D2 section 1) - omitting opt
    does NOT select the oracle. The harness must FAIL LOUDLY if opt is
    absent or the reference build is not the hashed one.
H3  BEHAVIOURAL SENTINELS. Run D3's B2/B4/B5 negative-delta vectors
    against that exact binary and RECORD the observed outputs in the
    reference-build record. These are the empirical facts covering the
    C++ undefined-behaviour region (negative left shift). A REBUILT
    reference binary is a NEW oracle artefact: fresh hash AND sentinel
    revalidation before any comparison is believed.
H4  IN-DOMAIN ASSERTION (S3). The harness asserts every generated input
    is mod-8, in-range-offset, integer - and refuses to run otherwise,
    so it can never silently drift into a divergence region and report a
    known divergence as a defect (or mask a real one).
H5  COMPARISON. Same source clip through deblock4.Classic and through
    the reference plugin (opt=1), byte-compared per plane per frame.
    INTEGER: byte-exact is the TARGET; any difference is a FINDING to be
    INVESTIGATED - not auto-accepted and not auto-rejected - and is
    resolved either as a Deblock4 defect (fix) or, only with W3X
    ratification under K19(a)/K20 criteria, as a deliberate documented
    quality-validated deviation (D0 K19 layer (b)).
H6  CONTENT. At minimum: synthetic blocky material at several strengths
    and offset combinations, plus real 720x576 PAL MPEG-2-derived frames
    if available to W3X. Record exact invocations so runs reproduce.
```

# 7. Proof surface

```text
P1  build_2C_v1.bat extends the 1C matrix: it must keep every existing
    1C gate green (three modes, unit tests, G10 three-surface absence,
    negative controls, S1/S2/S3/V1 audits, using-echo cases) AND add:
      - the full D3 obligation unit-test run in all three modes;
      - the 2C vspipe end-to-end cases incl. creation-path cases;
      - the sanity gate incl. its negative control;
      - ReleaseSafe vs ReleaseFast byte-identity for every O-vector and
        composite frame (K10);
      - the differential harness run, gated on the reference-build
        record being present and its DLL hash matching.
P2  Judge benign artifacts by EXIT CODE (Zig --listen context, negative
    configure FileNotFound) - the established rule.
P3  Assertions against Zig LF output: exit codes and positive substrings;
    never findstr /X on CRLF-mixed captures.
```

# 8. Delivery packaging (K17)

```text
- SELF-CONTAINED: carry and stage EVERY file the proof touches,
  including harnesses authored at their final paths (never "relocated
  from superseded/").
- Preconditions hash ONLY the files the delivery touches; a globally
  clean tree is NOT required and unrelated W3X-owned paths are neither
  inspected nor constrained (W3X works live in the tree).
- Ship a SCOPED restore-to-base command block derived from the
  delivery's own manifest (the exact files, the exact base hashes).
- Never read, move or delete anything under superseded/.
- Manifest states every file, its role, and its declared base hash or
  new-file precondition.
```

# 9. Binding Knowledge Checklist (D0 v1_5)

```text
K1/K24  scalar only now; kernel authored comptime-parameterised so v2/v3
        instantiate the same body later (A1). No @Vector in 2C.
K2      SIMD width must not define output - the D3 vectors become the
        permanent exact regression set for 4C/5C.
K3      boundary policy operative NOW: A5 + D3 O-7 (native footprint
        bounds; no pad/crop; small-plane pass-through).
K5/G9   the differential harness and the independent D3 vectors are the
        standing miscompile guard; Classic's 4-pixel grid is the
        higher-exposure case.
K6      no fused float/@mulAdd (A3).
K7      footprints implemented and asserted.
K9      oracle-construction exception is the acceptance basis (S4).
K10     RS vs RF byte-identity gate (P1).
K11     Schedule A only (A4); no Schedule B / 2D content.
K12     toolchain findings F1-F8 respected; no host-owned error text
        asserted.
K13     no v2/v3 execution; the 1B.3 capability guard untouched.
K14     G10 three-layer pattern for any new debug output (A8).
K16     creation strings unchanged EXCEPT the single ADDED float-refusal
        row requiring error-table v1_2 ratification (S1); using-echo
        surfaces byte-stable.
K17     delivery packaging rules (section 8).
K19     layer (b) = the HolyWu differential (H5, investigate-then-
        resolve); layer (c) = future Classic changes vs this oracle.
K20     any deviation claim must meet the README 15.2 criteria; none is
        proposed in 2C.
K21     do-not-revisit list respected (no twin-build, no cross-backend
        bit-exactness goal, no bespoke closures, no FMA exclusion).
K22     float deferred (S1); its non-finite divergence documented.
K23     determinism + source immutability + reproducible invocations
        (A7, H6).
K25     no feature-grained selection logic added.
K26     external-oracle execution pin implemented in full (H1-H3).
```

# 10. Open Rule Questions (carried from D3 section 9b)

```text
Q1  RESOLVED by S2 (retain explicit clamps) - pending W3X ratification
    of this scope; then it leaves the register.
Q2  Review-loop termination: OPEN. W3D withdrew its urgency after the
    D3 follow-up round found a real error (O-6a). Trigger to revisit: a
    review round returning ONLY additions and no corrections.
Q3  Knowledge-sweep scope narrowing: WATCH ITEM, no action requested.
    Trigger: two consecutive sweeps returning "confirmed, no gaps".
New entries from any party are added here rather than raised ad hoc.
```

# 11. W3C review instructions (mandatory, pre-implementation)

Review THIS scope together with D3 v1_3. Report numbered findings on:
scope completeness and boundaries; feasibility and ambiguity; whether
the D3 obligations are sufficient AND sufficiently unambiguous to judge
a delivery; the S1 float decision and its added error row; the K26
harness design (H1-H4 especially); the proof-surface additions; and the
section-0 independent knowledge sweep. State explicitly if a required
behaviour is under-specified enough that two reasonable implementations
could differ. Do not begin implementation until W3X releases the scope.

---

Revision: v1.0 (2026-08-03) initial scope draft, built from D0 v1_5,
D1/provenance v1.1, D2 v1_3, D3 v1_3. Awaiting W3C review and W3X
ratification. S1 requires a creation-error-table v1_2 decision.
