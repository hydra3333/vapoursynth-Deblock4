# Deblock4 - Stage 2C Coder Scope: Classic Scalar Oracle and HolyWu Differential

**Deliverable:** W3D-2C-D4 (SCOPE - for W3X ratification and release to W3C)
**Version:** 1.10
**Date:** 2026-08-05
**Author:** W3D (designer)
**Status:** RELEASED AS THE REVIEW AUTHORITY; W3X ratified 2026-08-03; on
2026-08-05 ratified the pre-implementation review resolutions (D-2C-1..6,
K30/K31) and then the focused re-review corrections (T-S5-1a/1b split; the
D0/K13 consistency fixes; the K30 audit contract; the K31 per-model proof).
SCOPE RELEASE and IMPLEMENTATION RELEASE are separate W3X acts: do NOT
begin implementation until W3X EXPLICITLY RELEASES IMPLEMENTATION. Read
with D3 v1_10. W3X alone releases, accepts and commits.
**Built from:** D0 v1_11, D1 (pinned r9 snapshot + provenance v1.4),
D2 v1_6, D3 v1_10, and Addendum A v1.2 (K26 sentinel fixtures) + Addendum
B v1.2 (mandatory differential corpus) which are READ-TOGETHER PARTS of
the released D4 authority set. Cite those documents, not this summary, where
they are more specific. ALWAYS the highest committed version of each.
**Document authority (W3X-ratified 2026-08-05):** CONTROLLING for this
scope: the charter (prevailing per 2.3a), this scope, and its read-together
authority set above. README_Deblock4_Design_Spec_v1_9 is FALLBACK GENERAL
GUIDANCE: where it conflicts with the charter, a ratified decision record,
or this authority set, THE LATTER PREVAIL; consult it only on an IDENTIFIED
MATTER the authority set does not settle, naming the matter and section in
the report. Specifically SUPERSEDED for Stage 2C: README 12.5/12.6
(auto-selects highest CPU-capable backend - superseded by S5) and 8.1
(float coverage - superseded by S1).
**Encoding:** US-ASCII; CRLF.

**Incremental emission (charter C-DELIV-09) - standing reminder:** When this
scope/phase is large enough that withholding all output creates a material
interruption or review-continuity risk - normally multiple modules or more
than a few files - W3C EMITS complete modules or small coherent groups as they
are finished, each marked "increment N of ~M: <what>" (~M is an estimate and
may be revised). Each increment is a complete, self-identifying recovery and
review artifact against the stated base; it need not be independently
applyable. ONLY EMITTED ARTIFACTS SURVIVE an interruption: the recoverable
state is the last complete emitted increment(s); the current incomplete
increment AND any later un-emitted integration, reconciliation, validation, or
revision work may be lost, and earlier increments may be superseded by later
integration. W3C does not claim to preserve or resume un-emitted internal
work. The increments do NOT replace the final deliverable: at scope/phase end
W3C rebuilds and re-packages the complete integrated work against the
authoritative base as one deliverable of record meeting C-DELIV-01..08 in
full, validated as a whole - merely concatenating increments is not proof of
integration. W3X ordinarily applies only the final package, unless W3X
explicitly directs otherwise.

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
  1. src/classic_scalar_kernel.zig - ONE canonical, non-duplicated
     edge-formula body (K24 in its ratified S7 form), instantiated ONLY
     for the exact u8/u16 scalar storage types in Stage 2C, behind a
     clean scalar call boundary. No width-generic or vector API is
     required or authorised in 2C; 4C may generalise the boundary
     mechanically but may not fork the formulas.
  2. src/classic_edge_schedule.zig - Schedule A traversal + per-position
     eligibility bounds (D2 section 3; D3 O-7; README 6.1/6.2/6.5).
  3. src/classic_thresholds.zig - the three 61-entry tables and the
     derivation chain (D2 section 2; D3 O-1/O-1c).
  4. Wiring the above into the Classic frame path in place of
     pass-through, for INTEGER formats only (see decision S1).
  5. Tests asserting EVERY D3 v1_10 obligation on its routed proof
     surface (D3 section 1 routing rule), including O-8 a-h and the
     mandatory O/G-to-test crosswalk.
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
  - Registration, the using-echo surfaces, capability-detection LOGIC,
    and G10 debug modules (K13/K14/K16) - unchanged (the sole authorised
    detection-module edit is the D-2C-1 print-seam relocation; no
    semantic change).
  - Parameter validation, creation-error strings and tier RESOLUTION are
    unchanged EXCEPT the narrowly authorised items of the D0 v1_11
    section-5 exception list (a)-(e): (a) the S1 float refusal, (b) the
    K29 integer-depth refusal (A1b), (c) the S5 backend-unavailable
    refusal, (d) the S5 implementation-availability cap with the
    EFFECTIVE-over-availability precedence test, and (e) the D-2C-1
    summary-emission relocation. Items (a)-(c) are creation-error rows;
    items 4-5 are resolution/proof changes. Nothing else.
  - superseded/ (never read, move or delete - K17).
  - The pinned reference under dev_documentation/reference/holywu_r9/
    (W3X-owned, read-only, never modified or EOL-normalised).
```

# 2. Ratified scope decisions

```text
S1  FLOAT - RATIFIED BY W3X 2026-08-03 (resolves register T-2). Stage
    2C implements INTEGER formats (8..16 bit) ONLY, and REFUSES float
    input explicitly.
    RATIONALE (W3X, confirmed against the settled float decisions):
    float is a FIRST-CLASS path in this project with its own ratified
    accuracy discipline - final-magnitude tolerance plus separately
    reported and bounded near-threshold ACTIVATION FLIPS accepted for
    this noisy-VHS material (V&T 3.4/3.5), .strict float mode with no
    auto-contraction (V&T 3.6), FMA retained in v3 rather than excluded
    (V&T 4.4; K21), and structural results exact regardless (V&T 3.4).
    Integer paths by contrast carry NO tolerance at all. A float clip
    must therefore be treated as float WITH that accuracy apparatus, or
    not at all: running it through an integer pass would both mislead
    the user and bypass a ratified verification regime. Classic's 1C
    creation currently has NO sample-type gate (constant-format only),
    so a 32-bit float clip is accepted today and would reach the new
    pixel path - hence an explicit refusal is required, not silence.
    2C therefore ADDS one creation-error row (an ADDITION to, not an
    alteration of, the ratified table - K16):
      Classic: float input is not supported
    Creation-error table v1_6 (W3X-ratified and controlling) carries this
    row. W3C review confirmed the wording, the shorter form WITHOUT "yet"
    so no user-facing scheduling promise is made; the future float work
    item lives in the design documents instead. NOTE (F1/F2): float
    refusal is SAMPLE-TYPE based and covers BOTH 16-bit and 32-bit float
    (tested via N01a/N01b); a SEPARATE ratified row refuses valid
    17..32-bit INTEGER input (K29; "Classic: integer input must be
    between 8 and 16 bits"; N01c1/N01c2 + the exhaustive 17..32 guard) -
    VapourSynth permits integer depths to
    32 and such a clip is NOT malformed metadata.
    FUTURE: W3X intends to STRONGLY CONSIDER extending the project to
    implement Classic float support, most likely as a bounded step near
    the end of the project. When taken up it must carry: the bias-free
    unclamped formulas (D2 section 5), the K22/V&T 3.8 tolerance
    NUMBERS (still owed), the activation-flip reporting of V&T 3.5, and
    the documented HolyWu non-finite divergence (D2 section 5) as an
    external-only fact. The refusal row is retired at that point.
    F16 STORAGE-NEVER-COMPUTE RULE (Toolchain Findings v1_4 F10, W3X-
    ratified 2026-08-05; recorded here so the future float step inherits
    it): VapourSynth float is 16-bit HALF and 32-bit. Zig/LLVM f16
    ARITHMETIC is pathological (~100x; zig #19550), so f16 is a STORAGE
    width, NEVER a COMPUTE width - widen to f32 on load (register/row
    granularity, never whole-plane; per-edge widen/compute/narrow with
    f16 reload is the safe default because deblocking is not pointwise -
    the O-4 order-sensitivity proves the dependency), compute in f32
    under .strict (V&T 3.6; no @mulAdd, K6), narrow on store. ORDERING
    RULE: this compute-width choice (semantics B = f32-compute/f16-store,
    ratified as THE algorithm, never an optimisation of true-f16
    semantics A) is PINNED BEFORE the K22/V&T 3.8 tolerance NUMBERS are
    derived, because the tolerances are semantics-dependent. F16C is an
    x86-64-v3 feature and its instructions stay confined to v3 objects.
    The full guidance and the F16-1..F16-8 investigation checklist live
    in Toolchain Findings v1_4 F10.

S2  EXPLICIT FINAL CLAMPS (resolves Open Rule Question Q1; W3C and W3D
    positions concurred). The scalar kernel RETAINS explicit 0..peak
    final sample clamps. Recorded as an intentional architecture and
    safety decision - cheap, mirrors the reference, makes the range
    guarantee locally obvious, survives maintenance and changed
    preconditions - NOT as though byte-equivalence compels that exact
    expression. D3 O-6f's worst-case bound proof is retained ALONGSIDE
    the clamps, not instead of them.

S5  IMPLEMENTED-TIER AVAILABILITY - RATIFIED BY W3X 2026-08-03
    (resolves W3C F1 / proposed Q4). Until 2C the filter passed frames
    through, so claiming a v3 tier was harmless; once it PRODUCES PIXELS
    with scalar code the claim would be false. Backend resolution is
    therefore capped by BOTH effective hardware capability AND
    implementation availability:
      auto            -> the highest tier that is BOTH EFFECTIVE-supported
                         AND IMPLEMENTED for this filter; in Stage 2C
                         that is x86_64_v1_baseline.
      explicit v1     -> execute the scalar implementation.
      explicit v2/v3  -> FAIL CREATION with the ratified row
                         "Classic: requested backend is not available in
                         this build". NEVER silently substitute scalar
                         for an explicit named request.
      Deblock4Tier    -> reports the IMPLEMENTED tier actually executed
                         (README 13.5 "actually used") - v1 in 2C.
    PRECEDENCE: the existing EFFECTIVE-tier refusal ("requested backend
    is above the EFFECTIVE CPU tier") retains precedence when both apply;
    2C must fix and TEST that precedence explicitly.
    ALWAYS-ON LINE (V&T 7 / K23; live since 1C): the non-debug per-
    creation line reports the RESOLVED implemented tier and, when auto
    capped below the effective tier, states why - reusing the EXISTING
    force-down reason= idiom rather than inventing a new format, e.g.
      deblock4: 0.1.0-dev+2C Classic backend=auto tier=x86_64_v1_baseline
        reason=intentionally-capped(x86_64_v1_baseline)
        actual=x86_64_v3_with_avx2
    The line format is SETTLED by D-2C-3 below; it MUST make the capping
    visible without a debug build.
    USING-ECHO UNCHANGED (K16): the rider 1C.1 line continues to report
    the REQUEST token (backend=auto), byte-stable; only the always-on
    tier line and Deblock4Tier report resolution.
    SCOPE: Classic only in 2C. deblock4.Deblock4 stays pass-through and
    unchanged; it inherits the equivalent rule at 2D.
    F1 RESOLUTION - RATIFIED BY W3X 2026-08-05 (resolves the successor-
    W3C pre-implementation review BLOCKER F1; proposer W3D, verifier the
    W3C focused re-review, adopter W3X):
    D-2C-1 EMISSION SEAM. The single always-on creation summary is
      emitted ONCE, from backend_tier_selection, AFTER the final per-
      instance tier is resolved (or its refusal determined) and BEFORE
      selection returns. cpu_capability_detection STOPS emitting it and
      instead returns, alongside the EFFECTIVE record, the ACTUAL tier
      and the computed SummaryReason. Detection semantics are UNCHANGED
      (Set-A/Set-B tables, comptime cross-check, CPUID/XGETBV/XCR0,
      ACTUAL/EFFECTIVE model, force-down intersection, G10 announce);
      only the print call moves. print_helper_functions remains the SOLE
      always-on formatting home (C-STY-09).
    D-2C-2 CEILING IS DATA. selectForEffectiveTier gains an implemented-
      tier ceiling PARAMETER (filter-neutral; no per-filter branch in
      the selector). Ceilings are declared in deblock4_config.zig:
      Classic -> x86_64_v1_baseline in 2C; Deblock4 -> no cap
      (unchanged). Resolution order (normative): auto -> the LOWER of
      effective and ceiling; explicit -> the EFFECTIVE refusal is tested
      FIRST (precedence), then the availability refusal, else honoured.
    D-2C-3 REASON PRECEDENCE. reason=intentionally-capped(...) is
      reported IF AND ONLY IF the ceiling STRICTLY lowers the tier
      (rank(ceiling) < rank(effective)); otherwise the EXISTING reason
      logic (none / forced-down / hardware) applies byte-unchanged -
      which is what keeps every Stage 1C summary line stable, including
      the E3 force-down cases. The actual= field reports the ACTUAL
      hardware tier (charter G1 vocabulary).
    D-2C-4 EMISSION TIMING. Exactly ONE summary line per creation
      ATTEMPT, including attempts refused at tier selection (this
      PRESERVES current behaviour; suppressing it would change
      deblock4.Deblock4, which 2C must not touch). On a refused explicit
      request the line reports the tier auto WOULD have resolved (the
      lower of effective and ceiling); it never claims the refused tier
      was selected. Refusals occurring BEFORE tier selection emit NO
      line (D-2C-6).
    D-2C-6 REFUSAL PLACEMENT. The S1 float and K29 integer-depth
      refusals are CLIP-FORMAT checks: they run with the existing
      clip-dependent checks BEFORE tier selection and emit NO summary
      line. The S5 availability refusal runs INSIDE selection, which
      emits one. Fixed corpus consequences: N01a/N01b/N01c1/N01c2 ->
      exact error row, NO summary line; N02a/N02b/N03 -> exact error row
      WITH one summary line; N04 -> success WITH one intentionally-
      capped summary line.

S6  STAGE IDENTITY - RATIFIED BY W3X 2026-08-03 (resolves W3C F9d). The
    single-homed identity advances 0.1.0-dev+1C -> 0.1.0-dev+2C. A
    pixel-producing build labelled 1C would defeat the audit trail. The
    delivery must update every place the marker is asserted (selftest
    banner, always-on line, Deblock4Version property, matrix identity
    gates) and say so in its manifest. Deblock4Using content and format
    remain byte-stable.

S7  K24 STRICTNESS - RATIFIED BY W3X 2026-08-03 (resolves W3C proposed
    Q5). The v1.1 wording ("structured so a later width parameter can
    instantiate the same logic") had no objective acceptance test. The
    ratified, testable form:
      REQUIRED NOW: ONE canonical, non-duplicated mathematical body for
      the edge formulas, comptime-parameterised over element type, behind
      a clean scalar call boundary. No formula is written twice anywhere
      in the tree; no per-bit-depth hand-specialisation.
      NOT REQUIRED NOW: any speculative vector API, BackendConfig shape,
      or width-generic instantiation interface. Stage 4C may generalise
      the boundary MECHANICALLY but may NOT fork or rewrite the formulas;
      that prohibition is the real content of K24 and is testable then.

S3  DIFFERENTIAL DOMAIN. The HolyWu comparison covers the LEGAL SHARED
    DOMAIN only: mod-8 frame geometry, in-range offsets, integer
    formats. The three documented divergences (HolyWu's offset clamp,
    its pad-filter-crop wrapper, its float non-finite behaviour) are
    external-only facts, never Classic behaviours to reproduce, and the
    harness must ASSERT its inputs are in-domain rather than assume it
    (D0 section 5; D2 sections 6/8; D3 O-1b).

S4  ORACLE STATUS. Per the oracle-construction exception (charter G7;
    V&T 20.2; K9), this delivery is accepted against D3 v1_10's
    obligations plus its sanity gate - NOT against a pre-existing
    oracle. AFTER acceptance the delivered scalar path BECOMES the
    oracle, and every later Classic pixel/copy/backend change is
    accepted only by byte-identical differential against it (K19 layer
    (c)).
```

# 3. Architecture requirements

```text
A1  SHARED KERNEL - S7's RATIFIED FORM (supersedes the earlier
    non-objective wording; W3C F5). ONE canonical, non-duplicated
    mathematical body for the edge formulas, behind a clean scalar call
    boundary; no formula written twice anywhere in the tree; no
    per-bit-depth hand-specialisation; NO speculative width/vector API.
    Comptime STORAGE element type is EXACTLY u8 or u16 (A1b);
    bitsPerSample (8..16) is a separate runtime/immutable arithmetic
    parameter driving scale and peak. Stage 4C may generalise the call
    boundary mechanically but may NOT fork or rewrite the formulas.
A1b FORMAT AND STORAGE CONTRACT (W3C F2; K28). Explicit, not inferred:
      sample type  : stInteger ONLY in Stage 2C (float refused per S1).
      storage      : 8-bit -> u8 samples, bytesPerSample == 1;
                     9..16-bit -> u16 samples, bytesPerSample == 2.
      arithmetic   : bitsPerSample drives scale = 1<<(bits-8) and
                     peak = (1<<bits)-1 INDEPENDENTLY of the u16 storage
                     type. A 10-bit clip must NOT use 16-bit scale/peak.
      validation   : bitsPerSample must be 8..16 and the sampleType /
                     bitsPerSample / bytesPerSample metadata must be
                     internally consistent; inconsistent metadata uses the
                     EXISTING "Classic: input video metadata is invalid"
                     row (no new string).
      out-of-range : CONFIRMED API-reachable (K29: VapourSynth permits
                     integer depths 8..32). A valid 17..32-bit integer
                     clip MUST be refused with the ratified row "Classic:
                     integer input must be between 8 and 16 bits" (table
                     v1_6), NEVER the metadata-invalid row. Proof:
                     N01c1 + N01c2 + the exhaustive 17..32 direct guard
                     test (D3 O-1d).
      data model   : the delivery must state WHERE sampleType,
                     bitsPerSample and bytesPerSample are obtained and
                     where they are stored on the immutable instance.
A1c PLANE ACCESS (K28; README 13.3). For every selected plane use the
      ACTUAL width, height, stride, bytes-per-sample and format family
      obtained from the frame. NEVER infer chroma extents or steps from
      luma dimensions and subsampling ratios.
A1d DESTINATION CONTRACT (K27; README 13.2). Retain the copyFrame-
      equivalent step so the destination begins semantically identical to
      the source (pixels and preserved properties) BEFORE selected-plane
      filtering; then write the ratified audit properties. "Identical to
      source" obligations mean PLANE BYTES, never the frame object.

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

Implement exactly what D2 v1_6 documents; D3 v1_10 judges it. The
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

D3 v1_10 in full: O-1, O-1b, O-1c (73 enumerated tuple cases + the
exhaustive bits=8..16 arithmetic checks), O-1d (integer-depth refusal), O-2 (A1-A5), O-3 (B1-B8), O-4
with its order-sensitivity and top-band obligations, O-5 (a-d incl. the
LITERAL native-16-bit matrix - the x256 shortcut is FALSE - and the
corrected strength-zero PLANE-BYTE semantics), O-6 (a general
write-footprint-union invariant, b-c, d source immutability, e canaries,
f i32 range proof), O-7 (a 10x10, b 12x6, c 6x6, c2 11x7), O-8 a-h
production-path routing, the MANDATORY O/G-to-test crosswalk (D3 7d),
and the sanity gate G1-G6 with its defined PLANE-BYTES + audit-property
comparison and the mandatory constant-fill negative control the gate
must reject. Proof routing per D3 section 1.

# 6. The external HolyWu differential harness (K26)

```text
H0  D1 EXCEPTION, NARROWLY DEFINED (W3C F6 - H1 previously conflicted
    with D1's read-only rule). The D1 snapshot remains W3X-owned,
    read-only, and is NEVER part of the Deblock4 production build graph.
    The ISOLATED tools/holywu_reference build MAY read those exact bytes
    after verifying SHA256SUMS.txt, and MAY compile them in an external
    temporary workspace. It MUST NOT modify or EOL-normalise them, and
    MUST NOT copy LF sources into the S3-audited deliverable tree.
    OWNERSHIP (W3C F6):
      W3C DELIVERS : build scripts, hash verification, the harness, the
                     reference-build-record schema/template, guard tests.
      W3X GENERATES: the reference DLL, the completed record, sentinel
                     observations, run evidence (locally, not by W3C).
      PACKAGING    : generated DLL/record/logs are EVIDENCE, retained
                     under the inspection output area, NOT committed
                     source; the manifest states this explicitly and the
                     scoped restore block must not delete W3X evidence.
H1  REFERENCE BUILD RECORD. The build script HASHES THE ACTUAL SOURCE
    BYTES before compiling (never merely copies D1's expected hashes into
    the record) and fails if they differ. The record captures enough to
    audit a rebuild: OS/architecture; compiler and linker versions;
    COMPLETE compile/link command lines; C++ language mode; optimisation
    and FP flags; ALL preprocessor definitions, especially DEBLOCK_X86
    present/absent; the exact source-file set; VapourSynth header
    hashes/version; runtime/plugin versions; the exact DLL SHA-256; and
    the D1 source hashes built from. K26's MXCSR/FP-environment field is
    recorded, or explicitly marked NOT APPLICABLE for the integer-only
    domain of S3 (state which).
H2  FORCED SCALAR PATH. Every reference invocation passes opt=1.
    opt=0 auto-selects SSE4 on capable x86 (D2 section 1) - omitting opt
    does NOT select the oracle. The harness must FAIL LOUDLY if opt is
    absent or the reference build is not the hashed one.
H3  BEHAVIOURAL SENTINELS - CLASSIFIED AND MADE INVOKABLE (W3C F7).
    (a) CLASSIFICATION, corrected: B2 and B5 have q0-p0 NEGATIVE and so
        exercise the negative-left-shift C++ UB region; B4 has q0-p0
        POSITIVE and does NOT - it exercises a negative signed RIGHT
        shift in the side-delta. Keep all three; record what each proves.
    (b) PLUGIN-LEVEL FIXTURES: HolyWu exposes a frame filter, not an
        edge function, and the schedule is sequential in-place - so an
        abstract six-tap vector is NOT directly invokable and two
        harnesses could embed it differently and legitimately disagree.
        Each sentinel MUST therefore specify: frame dimensions and
        format; plane and plane-selection arguments; strength and
        offsets; ALL surrounding sample values; orientation; the exact
        edge/lane coordinates read back; the expected output bytes; and
        how every other Schedule-A edge in that frame is made inactive
        or otherwise accounted for. W3D supplies these fixtures with the
        D4 revision or as an addendum before release.
    (c) MISMATCH GATE: the hashed reference binary is usable ONLY if its
        observed sentinel outputs equal the ratified expected outputs.
        On ANY mismatch: HARD STOP; no H5 comparison is trusted; report
        compiler/build identity and observed bytes to W3X/W3D. NEVER
        silently rewrite D3 to match the binary - that would be a
        material oracle change requiring three-way ratification.
    (d) REBUILD: a rebuilt reference binary is a NEW oracle artefact
        requiring fresh hash AND sentinel revalidation before use.
H4  IN-DOMAIN ASSERTION (S3) - INSPECT THE ACTUAL RUN INPUTS, never
    trust the generator (W3C F7d). Before any comparison, assert:
      constant format and dimensions; sampleType == integer;
      bitsPerSample in 8..16; bytesPerSample consistent with bit depth;
      mod-8 width and height for every compared plane/frame; supported
      colour family and legal plane selection; strength and offsets in
      the legal shared domain; opt EXACTLY 1 on every HolyWu call.
    NEGATIVE CONTROLS (harness self-tests, each must FAIL BEFORE any
    comparison), EACH MAPPED TO ITS PROOF SURFACE (W3C F6):
      invocation-level (constructible clips/args): missing opt;
        missing/auto Classic backend; non-mod-8 geometry; float input;
        out-of-range offset.
      file/record guard test: wrong DLL hash.
      valid integer depth 17..32 (CONFIRMED reachable, K29):
        invocation-level refusal cases with the exact dedicated row
        (Addendum B N01c1/N01c2) PLUS the exhaustive 17..32 direct
        validation/guard test.
      internally INCONSISTENT metadata: direct guard/unit test with
        synthetic metadata unless a real API path is separately shown;
        uses the existing metadata-invalid row.
    No host-owned error text is asserted anywhere (K12/F6).
H5  COMPARISON AND DECISIVE GATE. Same source clip through
    deblock4.Classic with EXPLICIT backend="x86_64_v1_baseline" and
    through the reference plugin with opt=1 (W3C F6: never auto - after
    4C/5C auto would silently compare a vector backend, but the K19
    layer-(b) gate is defined as Classic SCALAR vs HolyWu C/scalar;
    additional vector-vs-HolyWu runs may be ADDED later but never
    replace this gate). H4 inspects and RECORDS both actual request
    values. Byte-compared per plane per frame. Gate semantics, explicit:
      PASS : ZERO plane-byte differences over the mandatory corpus; OR
             every nonzero difference is named in a W3X-RATIFIED
             deviation record satisfying K19(a)/K20 criteria.
      FAIL : any unratified difference; any SKIPPED mandatory case; any
             domain, hash or sentinel guard failure.
      PROCESS: nonzero exit code on FAIL; emit the exact first-difference
             frame/plane/x/y and both values; retain a machine-readable
             difference summary.
    A difference is a FINDING to investigate - never auto-accepted, never
    auto-rejected - resolved as a Deblock4 defect (fix) or, only with W3X
    ratification, as a documented quality-validated deviation (K19(a)).
H6  MANDATORY CORPUS - ENUMERATED, not "several" (W3C F8):
      bit depths : 8, one u16-stored intermediate (10 AND 12 both
                   included), and 16; PLUS D3's exhaustive pure
                   bits=8..16 threshold checks.
      formats    : Gray; YUV with a selected CHROMA plane; RGB.
      planes     : omitted/all, and at least one explicit subset.
      strengths  : exactly 0, 25 (default) and 60.
      offsets    : symmetric zero; and asymmetric LEGAL combinations
                   including at least one that exercises c0-from-alpha
                   (aoffset non-zero with boffset zero) and its mirror.
      frames     : the EXACT invocation matrix, formats (including
                   SUBSAMPLED chroma cases), dimensions, synthetic pixel
                   definitions and non-vacuity conditions are fixed by
                   ADDENDUM B (mandatory differential corpus) - authority-
                   fixed, never coder-selected after seeing results.
      output     : the exact invocation list and output location recorded
                   so any run reproduces.
    Real 720x576 PAL material is an OPTIONAL additional corpus in 2C;
    the compatibility/quality corpus gate belongs to Stage 3C.
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
T-S5-1a Exactly ONE summary line for every creation attempt that
    REACHES backend tier selection, whether selection succeeds or
    refuses: the existing exact-count gate (one "deblock4: <identity>
    <Filter> backend=" line) passes at count 1 for Classic AND Deblock4
    in every such 2C case.
T-S5-1b NO summary line for attempts refused BEFORE tier selection
    (D-2C-6): the same gate asserts count 0 for N01a, N01b, N01c1 and
    N01c2. The O/G crosswalk and the batch assert BOTH counts.
T-S5-2  Classic auto on a v3-capable host: the line reports
    tier=x86_64_v1_baseline reason=intentionally-capped(...) with
    actual=<host actual tier>; the Deblock4Tier property agrees (N04).
T-S5-3  Byte-stability: every Deblock4 summary line, and every Classic
    force-down line under DEBLOCK4_FORCE_DOWN=v1, is byte-identical to
    the Stage 1C expectation apart from the S6 marker (+1C -> +2C).
T-S5-4  Precedence: N03 (force-down v1 + explicit v3) yields the
    EFFECTIVE refusal row, not the availability row; N02a/N02b yield
    the availability row on the un-forced v3-capable host.
T-S5-5  Debug-only combined case: DEBLOCK4_FORCE_DOWN=v2 with Classic
    auto reports intentionally-capped with actual=<host actual tier>.
```

# 7b. Authorised integration surfaces (W3C F9a; D-2C-5)

The section-1 file list names NEW modules; the work necessarily reaches
existing integration surfaces. Those are AUTHORISED, narrowly, and must
be named in the manifest (NEW or REPLACES; no base hashes - section 8):

```text
- Classic creation/validation: ONLY to add the THREE ratified refusals
  (S1 float; K29 integer-depth; S5 backend-unavailable) and the
  format/storage contract of A1b. No other string or validation change.
- Classic immutable instance data: to carry sampleType/bitsPerSample/
  bytesPerSample and the resolved implemented tier.
- Classic arAllFramesReady frame path: to call the oracle instead of
  pass-through, retaining the A1d destination contract.
- Frame-property writing: ONLY so Deblock4Tier reports the implemented
  tier (S5); key set and formats unchanged.
- backend/tier resolution: ONLY to apply the implementation-availability
  cap of S5; additionally becomes the SINGLE summary emission point
  (D-2C-1) and applies the D-2C-2 resolution algorithm.
- src/cpu_capability_detection.zig (D-2C-1, NARROW): move the summary
  emission out of initInstanceCapabilities; return/expose the ACTUAL
  tier and the computed SummaryReason to the caller. FORBIDDEN: any
  change to detection logic (Set-A/Set-B tables, comptime cross-check,
  CPUID/XGETBV/XCR0, ACTUAL/EFFECTIVE model, force-down intersection,
  G10 announce path).
- src/print_helper_functions.zig (D-2C-3, NARROW): EXTEND SummaryReason
  with the intentionally_capped variant and its one-line format
  mirroring forced_down; the none/forced_down/hardware variants and
  their emitted bytes are UNCHANGED; no new printing home (C-STY-09).
- src/deblock4_config.zig (D-2C-2, NARROW): declare the per-filter
  implemented-tier ceilings and the reason token; declarations only.
- src/deblock4_selftest.zig (NARROW): extend the existing 1C pure
  section with the D-2C-2/D-2C-3 resolution cases; existing cases
  unchanged.
- build.zig: module and unit-test wiring for the new files.
- version identity: the S6 marker advance.
NOTHING ELSE. Anything further is a finding to raise BEFORE coding, not
a judgement call at implementation time.
```

# 7c. Proof-runner composition (W3C F9b)

```text
SUCCESSOR-MATRIX MODEL (corrected per W3C revised-package F2: the
historical runner's identity gate asserts 0.1.0-dev+1C and therefore
CANNOT pass on the +2C tree - the earlier wrapper model was impossible):
  build_1C_v1.bat : remains IMMUTABLE HISTORICAL EVIDENCE, unmodified,
                    unrenamed, never run against the 2C tree. (W3X may
                    optionally re-run it against a separate byte-pinned
                    1C baseline to prove historical reproducibility;
                    that is not a 2C gate.)
  build_2C_v1.bat : RE-EXECUTES every still-applicable Stage 1C
                    invariant/regression gate against the CURRENT tree
                    (three modes, unit tests, G10 three-surface absence,
                    negative controls, S1/S2/S3/V1 audits, using-echo
                    cases, error-table cases) EXPECTING the +2C
                    identity, then runs the additive 2C gates.
                    Version-neutral helpers (tools/run_vs.cmd etc.) are
                    reused where they exist.
```

# 7d. Generated reference artefacts (W3C F9c)

```text
The reference DLL, completed build record, comparison logs and sentinel
observations are GENERATED EVIDENCE retained under the inspection output
area: not committed source, not staged delivery files. The manifest says
so, and the scoped restore-to-base block MUST NOT delete them or any
other unrelated W3X-owned evidence.
```

# 8. Delivery packaging (K17)

```text
- SELF-CONTAINED: carry and stage EVERY file the proof touches,
  including harnesses authored at their final paths (never "relocated
  from superseded/").
- BASE IDENTIFICATION (W3X-ratified 2026-08-05, replacing the earlier
  per-file base-hash requirement): the base is the ATTACHED PREVAILING
  SOURCE TREE itself. The manifest states every file, its role, and
  whether it is NEW or REPLACES an existing file in that tree. NO
  per-file base hashes are recorded (any recorded hash drifts when
  branch main receives unrelated commits). If W3C is unsure it holds
  the current source, it ASKS W3X to re-upload rather than inferring.
  A globally clean tree is NOT required; unrelated W3X-owned paths are
  neither inspected nor constrained (W3X works live in the tree).
- TWO HASHES REMAIN MANDATORY - they are oracle identity, not source
  bookkeeping: the D1 snapshot SHA256SUMS verification (H0) and the
  K26 reference-binary SHA-256 with its rebuild-revalidation rule.
- Ship a SCOPED restore-to-base command block derived from the
  delivery's own manifest (the exact files it stages).
- Never read, move or delete anything under superseded/.
```

# 9. Binding Knowledge Checklist (D0 v1_11)

```text
K1/K24  scalar only now; ONE canonical non-duplicated formula body
        behind a clean scalar boundary (A1/S7); exact u8/u16 storage; NO
        speculative width/vector API. 4C generalises the boundary
        mechanically, never forks the formulas. No @Vector in 2C.
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
K13     no v2/v3 execution; the 1B.3 capability-detection/guard LOGIC
        untouched (the D-2C-1 print-seam relocation is the sole
        authorised edit to that module and changes no semantics).
K14     G10 three-layer pattern for any new debug output (A8).
K16     creation strings unchanged EXCEPT the THREE added Classic rows of
        error-table v1_6 (S1 float refusal; K29 integer-depth refusal; S5 backend-unavailable
        refusal); using-echo surfaces byte-stable.
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
K26     external-oracle execution pin implemented in full (H0-H4,
        including the H4 in-domain assertion - corrected from "H1-H3").
K27     destination initial state and frame-property contract (A1d);
        "identical" means PLANE BYTES (D3 O-5c/G4).
K28     actual per-plane geometry/stride/storage (A1c, A1b); never
        inferred chroma bounds; D3 O-8 proves it on the production path.
K29     valid integer depths extend to 32; A1b/S1 refuse 17..32-bit
        explicitly with the ratified row (N01c1/N01c2 + the exhaustive
        17..32 guard), never as malformed
        metadata.
K30     first-class module discipline (charter C-STY-10) applies to the
        new modules (classic_scalar_kernel / classic_edge_schedule /
        classic_thresholds): permanent names, one-way dependency
        (scaffolding may import first-class, never the reverse), no
        first-class reference to scaffolding identifiers. AUDIT CONTRACT
        (W3X-ratified 2026-08-05, the narrow non-cleanup form; full text
        D0 v1_11 K30): (1) the NEW modules plus their build wiring and
        unit-test names are audited in full, case-insensitively, over
        filenames/declarations/symbols/strings/comments, for stage-
        number/probe/smoke vocabulary AND the enumerated retired-
        scaffolding list; expected EMPTY. (2) For EXISTING edited
        modules only the 2C CHANGES are audited: no new scaffolding
        reference, no retired-identifier reference. Pre-existing
        ACCEPTED Stage 1C regression identifiers are NOT renamed in
        this scope (they are gate-asserted by the re-executed matrix);
        any such cleanup is a recorded post-2C candidate, not 2C work.
        Named in the O/G crosswalk with this exact two-part domain.
K31     stride units are explicit and checked EVEN IN SCALAR CODE
        (charter C-SIMD-03): VapourSynth strides are BYTE counts
        (getStride is the byte distance between row starts; verified
        against the R78 header and HolyWu deblock.cpp:237). Two
        permitted models, coder's choice; unit-suffixed names
        (stride_bytes / stride_samples) are the recommended idiom:
        (a) BYTE ROW NAVIGATION (RECOMMENDED default per W3X
            preference): the plane base stays a byte pointer; row
            addresses are computed in BYTES (base + y*stride_bytes -
            no division exists anywhere); ONE named, explicit cast to
            the sample type per row/plane view for within-row SAMPLE
            indexing. Proof: code inspection plus the O-6e canaries
            and O-8c/O-8h; no conversion assertion is applicable.
        (b) TYPED SAMPLE STRIDE: exactly ONE checked conversion PER
            PLANE stride/view construction - @divExact(stride_bytes,
            bytesPerSample) or an explicit stride_bytes %
            bytesPerSample == 0 assertion - naming both units; typed
            indexing thereafter. Proof: inspection + the assertion
            plus O-6e and O-8c/O-8h.
        FORBIDDEN either way: the silent unchecked division (the
        HolyWu deblock.cpp:237 / zsmooth remove_grain.zig:810 idiom)
        and any arithmetic whose unit is ambiguous at the point of
        use. Applies to u8 and u16 storage alike; carries forward
        unchanged to 4C/5C vector addressing.
```

# 10. Open Rule Questions (carried from D3 section 9b)

```text
Q1  RESOLVED by S2 (retain explicit clamps; W3X-ratified 2026-08-03 as
    recorded in S2 itself). Removed from the open register on D4
    RELEASE. Implementation requirement unambiguous either way: retain
    the clamps.
T-2 RESOLVED by S1 (integer-only in 2C; explicit float refusal; float
    implementation strongly considered as a late bounded step). The
    float work item is CARRIED FORWARD here so it is not lost:
    "Classic float support" with the four requirements listed in S1.
Q2  Review-loop termination: OPEN. W3D withdrew its urgency after the
    D3 follow-up round found a real error (O-6a). Trigger to revisit: a
    review round returning ONLY additions and no corrections.
Q3  Knowledge-sweep scope narrowing: WATCH ITEM, no action requested.
    Trigger: two consecutive sweeps returning "confirmed, no gaps".
Q4  (W3C) implemented-tier availability: RESOLVED by S5 (W3X-ratified).
Q5  (W3C) K24 strictness: RESOLVED by S7 (W3X-ratified) - one canonical
    non-duplicated formula body now, no speculative vector API; 4C may
    generalise mechanically but never fork the formulas.
New entries from any party are added here rather than raised ad hoc.
```

# 11. W3C review instructions (mandatory, pre-implementation)

Review THIS scope together with D3 v1_10 and Addenda A v1.2 and B v1.2. Report numbered findings on:
scope completeness and boundaries; feasibility and ambiguity; whether
the D3 obligations are sufficient AND sufficiently unambiguous to judge
a delivery; the S1 float decision and its added error row; the K26
harness design (H1-H4 especially); the proof-surface additions; and the
section-0 independent knowledge sweep. State explicitly if a required
behaviour is under-specified enough that two reasonable implementations
could differ. This scope is RELEASED as the review authority. Do NOT
begin implementation until W3X EXPLICITLY RELEASES IMPLEMENTATION after
the review round is resolved: scope release and implementation release
are separate W3X acts.

---

Revision: v1.9 (2026-08-05) Resolves the W3C focused re-review v1_0 of
v1_8, all six W3X decisions ratified 2026-08-05: (a) T-S5-1 split into
T-S5-1a/1b (count 1 at/after selection, count 0 before it) - the v1_8
gate contradicted D-2C-6 (W3D defect). (b) Consistency fixes: section-1
bullet and K13 reworded to detection LOGIC with the D-2C-1 relocation
excepted; literal item counts replaced by the D0 section-5 (a)-(e)
reference form (the five-vs-four count drift was W3D-found). (c) K30
gains the ratified narrow non-cleanup AUDIT CONTRACT (accepted Stage 1C
regression identifiers are gate-asserted and are not renamed; cleanup is
a recorded post-2C candidate). (d) K31 gains the per-model proof with
byte-row navigation as the recommended default per W3X preference,
@divExact/assert for the typed model, the unit-suffix naming idiom, and
the named forbidden silent-division idiom (ecosystem survey: HolyWu
deblock.cpp:237 and zsmooth remove_grain.zig:810 both divide silently).
(e) Section 7b labelled D-2C-5. Pointers advanced to D0 v1_11/D3 v1_10.
Provenance: F1-F5 proposer W3C, verifier W3D (cold, file+line), adopter
W3X; the K31 refinement W3D-proposed after W3X's stride-units challenge
and the zsmooth survey, W3X-adopted.
Revision: v1.8 (2026-08-05) Resolves the successor-W3C pre-implementation
review v1_0 per the W3D response v1_1, ALL NINE decisions W3X-ratified
2026-08-05 (Q1-Q9; W3X amended the reason token to intentionally-capped).
(a) S5 gains the F1-blocker resolution D-2C-1..4 and D-2C-6 (emission seam
in backend_tier_selection; ceiling-as-data; reason precedence; one line
per creation attempt; clip-format refusals before selection). (b) Section
7 gains gates T-S5-1..5. (c) Section 7b gains the narrow authorisations
for cpu_capability_detection / print_helper_functions / deblock4_config /
deblock4_selftest and retires 7b base hashes. (d) Section 8 base-hash
requirement replaced by attached-tree identification; D1/K26 hashes
explicitly preserved. (e) Section 9 checklist -> D0 v1_10, gains K30
(C-STY-10) and K31 (C-SIMD-03). (f) Section 11 and the header adopt the
scope-release vs implementation-release distinction; header records the
README fallback-authority ruling incl. superseded 12.5/12.6 and 8.1.
Provenance: F1/F2a/F2b/F3a/F3b/F3c proposer W3C, verifier W3D (cold,
file+line), adopter W3X; D-2C-1..6 and the section-8 amendment proposer
W3D, verifier the W3C focused re-review, adopter W3X.
Revision: v1.7 (2026-08-03) Issuance-hygiene reissue for release to the
successor W3C session; NO technical content change. (a) Status line records
the 2026-08-03 W3X release (the v1_6 header still read DRAFT/NOT-released
after the release call - confirmed stale by W3X). (b) Added the charter
C-DELIV-09 scope-header reminder block, copied verbatim from
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1 per charter v1.25/v1.26
(the block was required for scopes issued after 2026-08-01 and its omission
survived seven review rounds; caught in the W3D successor orientation
review). (c) Section-9 checklist heading pointer refreshed D0 v1_8 -> v1_9
to match the Built-from line (content already current). Provenance: W3D
proposed (successor session); W3X decides/ratifies at issuance; the
successor W3C's mandatory section-11 review is the cross-party check.
Revision: v1.6 (2026-08-03) W3C v1.5-package review (convergence): F1
every operative authority reference updated to the release set (D0 v1_9,
D2 v1_6, D3 v1_8, provenance v1.4, Addenda A/B v1.2, error table v1_6);
singular N01c references replaced by N01c1/N01c2 + exhaustive 17..32
guard; F3 Q1 governance state unified (ratified via S2; leaves register
on release). No technical content changed.
Revision: v1.5 (2026-08-03) W3C v1.4-package review: F1 three-row
authorisation made consistent (section-1 five-item exception; 7b THREE
refusals; K16 THREE rows); F2 H4 split valid-17..32 (invocation + exhaustive
guard) from inconsistent-metadata (guard-only); F4 section-1 item 1
rewritten to the ratified S7/A1 kernel form. Authority: error table v1_5,
D3 v1_7, D2 v1_5, provenance v1.4, Addenda A v1_2 + B v1_2.
Revision: v1.4 (2026-08-03) W3C updated-package review: F1 confirmed
17..32-bit integer reachability, added the ratified integer-depth refusal
(S1/A1b/K29/N01c); F2 float refusal covers 16- and 32-bit (N01a/N01b);
F3 explicit-v3 availability proved separately (N02b); F4 swept stale
D3 v1_3 / D0 v1_5 / old-K24 operative text to D0 v1_8 / D3 v1_6 / S7
form; S1 ratification note updated to table v1_4 controlling. Authority
set: D0 v1_8, D2 v1_4, D3 v1_6, provenance v1.3, Addenda A v1_1 + B v1_1,
error table v1_4.
Revision: v1.3 (2026-08-03) resolved W3C revised-package review F1-F7:
authority set updated to D0 v1_7 / D3 v1_5 / provenance v1.2 with
Addenda A+B named as read-together parts; section-5 acceptance
enumerates O-8, the crosswalk, plane-byte semantics and bit-depth
checks; 7c replaced by the successor-matrix model (the wrapper was
impossible against the +2C identity); section-1 out-of-scope block
narrowed to the four authorised items; A1 rewritten to S7's form with
exact u8/u16 storage; H5 forces backend=x86_64_v1_baseline; H4 negative
controls mapped to proof surfaces; H6 corpus fixed by Addendum B; K16
names both rows.
v1.2 (2026-08-03) resolved W3C combined-review F1-F9 and
proposed Q4/Q5: S5 implemented-tier availability; S6 stage identity ->
+2C; S7 testable K24 form; A1b/A1c/A1d format-storage-plane-destination
contracts (K27/K28); H0 narrow D1 build exception with ownership and
packaging; H1 full build-record fields with source hashing before
compile; H3 sentinel classification, plugin-level fixtures and hard-stop
mismatch gate; H4 actual-input domain guards with negative controls; H5
decisive PASS/FAIL gate; H6 enumerated mandatory corpus; 7b authorised
integration surfaces; 7c wrapper proof-runner model; 7d generated-
evidence status; S1 wording without "yet". Creation-error table v1_2
carries TWO new Classic rows.
v1.1 (2026-08-03) S1 RATIFIED by W3X with rationale recorded
and verified against V&T 3.4-3.6/4.4 (float is a first-class path with
its own tolerance and activation-flip discipline; integer paths carry no
tolerance; therefore refuse float rather than run it through an integer
pass). Future Classic float support carried forward as an explicit late
work item. v1.0 (2026-08-03) initial scope draft. (Historical: built
from D0 v1_5 / D3 v1_3; current authority set is in the header.)
