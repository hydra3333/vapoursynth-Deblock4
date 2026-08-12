# Deblock4 - Scope - Stage 4C - Classic v2 (SSE4.1-class) Vector Backend

**Deliverable:** W3D-4C-SCOPE (for W3X ratification, then release to W3C)
**Version:** 1.1
**Date:** 2026-08-12
**Author:** W3D (designer)
**Route:** W3D -> W3X (ratification) -> W3C (with a mandatory
pre-implementation response round, section 6)
**Base:** the committed Stage 2C-accepted tree (identity 0.1.0-dev+2C),
confirmed with W3X per charter v1_27 C-DELIV-01. W3X guarantees the local
repository is this base at patching time.
**Authority set (read together; highest committed versions prevail):** the
charter (AI_Charter_and_Invariants_Card v1_27 or later) PREVAILS over
everything here on conflict; Project Status v1_24; the committed Stage 2C
authority set (D0 v1_12, D2 v1_6, D3 v1_11, D4 v1_10, Addenda A/B v1_2,
creation-error table v1_6, D1 pin v1_4); Verification-and-Tiering v1_11;
Toolchain Findings v1_4 (F9/F10); README v1_10 (fallback general guidance
only, per its authority note).
**Status:** W3X-RATIFIED 2026-08-12 (Q1 identity +4C; section-2 naming; release approved). RELEASED TO W3C.
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


# 1. Mission, in one paragraph

Implement the Classic v2 vector backend: the committed, byte-verified 2C
scalar oracle re-expressed with explicit `@Vector` operations, compiled into
the v2 (x86-64-v2 / SSE4.1-class) backend object, selected as tier
`x86_64_v2_with_sse41`, and ACCEPTED SOLELY BY BYTE-IDENTITY against the
scalar oracle over a tail-forcing corpus (K2, K19(c), charter G9). The
mathematics is DONE and FROZEN; this stage translates a proven algorithm
into vectors under a differential gate that cannot be argued with. The
kernel is authored WIDTH-PARAMETRIC so that Stage 5C (AVX2/256-bit) is the
SAME CODE INSTANTIATED WITH DIFFERENT PARAMETERS, with the edge/tail
machinery designed for both widths from the start (W3X-ratified intent,
2026-08-12).

# 2. Frozen and forbidden surfaces

```text
BYTE-FROZEN (any delta is an automatic blocking finding):
    src/classic_scalar_kernel.zig
    src/classic_edge_schedule.zig
    src/classic_thresholds.zig
  The scalar oracle IS the acceptance reference (S4/K19(c)). It is not
  edited, "improved", reformatted, or touched in any way.

FORBIDDEN (unchanged 2C forbidden surfaces continue):
    every Deblock4-filter module; the G10 debug modules beyond their
    established seams; build_1C_v1.bat and the resident 1C audit
    scripts; the pinned holywu_r9 snapshot; the mathematics above.

AUTHORISED (the expected complete surface; the pre-implementation
response may propose narrow, argued additions):
    NEW  src/classic_vector_backend.zig - the WIDTH-GENERIC body
         (tier-neutral source): parametrised
         processPlane(comptime T, comptime N, ...) - vector kernel +
         traversal, the vector analogue of the frozen scalar pair; NO
         tier assumption anywhere; the file Stage 5C reuses untouched.
    NEW  src/classic_backend_v2_sse41.zig - the 4C compilation unit:
         a thin instantiation binding N for 128-bit (16 for u8, 8 for
         u16), compiled into its OWN OBJECT classic_backend_v2_sse41
         under the exact x86-64-v2/SSE4.1 feature closure (the
         established per-object build pattern). Stage 5C adds the
         sibling classic_backend_v3_avx2.zig - same shape, different
         parameters - making S4C-1 literal in the file structure.
         Tier confinement is then structural: SSE4.1-class
         instructions can exist only in this object (4C-T3 verifies).
    NEW  build_4C_v1.bat (extends the proof matrix; 2C batch retained)
    MOD  src/deblock4_config.zig       (classic_tier_ceiling raise to
                                        .x86_64_v2_with_sse41 ONLY)
    MOD  src/backend_tier_selection.zig (only if wiring requires; the
                                        D-2C-1..4 emission contract is
                                        byte-stable for existing lines)
    MOD  src/classic_ar_all_frames_ready.zig (dispatch to the selected
                                        backend; scalar path retained
                                        verbatim as the v1 branch)
    MOD  src/deblock4_version.zig      (single-homed identity advance)
    MOD  src/deblock4_selftest.zig     (v2 additions; 1C/2C contract
                                        retained)
    MOD  build.zig                     (v2 object with EXACT feature
                                        closure; module/test wiring)
```

# 3. Ratified design decisions (S4C series; W3X 2026-08-12 unless noted)

```text
S4C-1  ONE PARAMETRISED BODY, TWO WIDTH-STAGED PROOFS. The vector kernel
       is written width-generic over @Vector(N, T): T in {u8, u16}
       exactly as the scalar kernel (comptime-enforced), N a comptime
       width parameter. Stage 4C INSTANTIATES AND PROVES the 128-bit
       forms (N=16 for u8, N=8 for u16). Stage 5C adds the 256-bit
       instantiations (N=32/N=16) of the SAME body and re-proves the
       tails at that width - "5C is the same 4C code with different
       parameters". ALL tail/underfill machinery is width-parametric
       from the first line: no 128-bit-only assumption anywhere.
       Arithmetic inside lanes is the scalar kernel's i32 semantics
       exactly (widen to i32 lanes; the same clamps; no saturating
       shortcuts unless proven bit-identical per C-SIMD-04 discipline).

S4C-2  ACCEPTANCE BASIS: SCALAR-vs-VECTOR BYTE IDENTITY (K2, K19(c),
       charter G9 standing gate). The v2 backend's output is
       byte-identical to the committed scalar oracle for every corpus
       case, every plane, every depth, or the delivery fails. There is
       NO HolyWu re-differential in 4C: 2C anchored scalar==HolyWu;
       4C proves v2==scalar; identity is transitive by construction.
       The differential runs at TWO levels: (a) pure-Zig unit level -
       the vector kernel/segment functions against the scalar
       equivalents over the D3 vector/matrix fixtures PLUS exhaustive
       and randomised property inputs; (b) end-to-end vspipe level -
       same clip, same parameters, backend="x86_64_v1_baseline" vs
       backend="x86_64_v2_with_sse41", SHA-256 per-frame equality.

S4C-3  THE UNIFORM-SCHEDULE CONSTRAINT (load-bearing; settled against
       the committed oracle 2026-08-12). The oracle applies ONE
       overlapping Schedule-A to EVERY selected plane (verified in both
       the committed tree and HolyWu filterC). Consequently the charter
       D3 chroma-independence batching freedom IS NOT AVAILABLE in any
       Classic backend: adjacent same-orientation edges must never be
       batched ON ANY PLANE. Vector parallelism lives INSIDE a segment
       and, only where PROVEN independent, across segments - see the
       section-5 proposal and section-6 investigation. The O-4
       order-sensitivity fixture is the standing tripwire: any
       traversal reordering that changes cell (x=5,y=2) is wrong.

S4C-4  THE TWO TAIL CLASSES (charter section C, verbatim, binding):
       C1 - incomplete ALGORITHMIC footprint (would read outside the
       plane): leave unchanged; do not invent pixels. The eligibility
       rule is the oracle's (edge >= 3 AND edge+2 < extent) and is
       NEVER widened or narrowed. C2 - complete valid footprint that
       merely UNDERFILLS a vector register: STILL PROCESSED, via
       narrower vectors, masked lanes, or scalar cleanup. "Does not
       fill a register" is not "invalid edge". All C2 machinery is
       width-parametric (S4C-1).

S4C-5  TIER CONFINEMENT AND INSPECTION (charter C-SIMD-01/02, the 1B.2
       discipline). v2 vector code is compiled ONLY into the v2 backend
       object under its exact feature closure; the v1 object remains
       free of SSE4.1-class instructions (assembly containment audit,
       1B.2 form, re-run in the 4C matrix); comptime guards mirror the
       established Set-A/Set-B pattern; the named-model perturbation
       control is retained and must still fail the build. RS==RF
       production byte identity continues (K10). F9 stands: LLVM loop
       autovectorisation is OFF in Zig 0.16.0 - every vector lane in
       the v2 object is EXPLICIT @Vector work, and the scalar oracle
       stays genuinely scalar.

S4C-6  PER-PLANE GATING FREEDOM (W3X 2026-08-12: "as-required gated
       blocks for Y vs U/V"). The implementation MAY structure
       per-plane or per-sample-type code paths (e.g. separate gated
       blocks for Y and U/V) for pragmatic engineering reasons,
       PROVIDED every path implements the SAME uniform schedule and
       kernel and the byte-identity gate holds per plane. No
       chroma-specific algorithm, grid, or threshold exists in Classic
       (that design belongs to Deblock4, stages 3D+).

S4C-7  SELECTION SURFACE. classic_tier_ceiling raises to
       .x86_64_v2_with_sse41 - the ONLY config change. Consequences,
       all gate-checked: on v2-or-better hardware auto resolves to v2
       with reason=capability-derived text unchanged in shape; on
       v3 hardware the summary reports intentionally-capped(v2) with
       actual=x86_64_v3_with_avx2 (the N04-class expected line moves
       accordingly and the 2C expected line is updated IN THE 4C GATES
       ONLY - 2C's own committed evidence is history, not rewritten);
       explicit backend="x86_64_v2_with_sse41" is accepted on capable
       hardware and refused with the ratified S5 wording where
       unsupported; the scalar tier remains requestable and is the
       differential's reference leg. D-2C-1..4 emission semantics are
       unchanged.

S4C-8  STAGE IDENTITY. The single-homed identity advances to
       0.1.0-dev+4C (Stage 3C was collapsed by W3X ruling 2026-08-12;
       no 3C identity ever exists). All 1C/2C identity gates re-run
       expecting the new token via the 4C matrix's updated expectation,
       exactly the S6 discipline used at 2C.
```

# 4. Why the edge/tail discipline is the spine (read before section 5)

```text
Charter G9, verbatim rationale: compiler code-generation defects
(correct source, wrong machine code) CLUSTER AT EDGES AND TAILS -
exactly where a deblocker operates - and produce gross corruption, not
rounding. The risk is toolchain-version dependent, so the
scalar-vs-SIMD differential is a STANDING gate re-run on every Zig/LLVM
bump, and the corpus MUST include non-vector-width-multiple dimensions
with strong boundary edges (e.g. 711x480) to force the tail path.
History: the project's own R76-class miscompile guard exists because
this class of failure was REAL. AVX2 (5C) raises the stakes - wider
registers mean more frequent underfill tails and bigger corruption
blast radius - which is WHY the tail machinery is width-parametric now,
not retrofitted in 5C.
```

# 5. Designer proposal: vector geometry, batching, tails (for coder
investigation - this is a PROPOSAL, not a directive)

```text
P1  HORIZONTAL-EDGE SEGMENTS (the friendly case). A horizontal edge at
    row y processes columns in groups where each column's taps are
    purely vertical (rows y-3..y+2 of that column) and columns are
    mutually independent. PROPOSAL: vectorise ACROSS CONTIGUOUS
    COLUMNS - lanes = columns; loads are six contiguous row-slices
    (rows y-3..y+2), all natural unaligned vector loads; the kernel
    runs per-lane; stores write rows y-2..y+1 column-slices. Lane
    count N per S4C-1; a row's segments provably do not overlap each
    other in columns, so MULTI-SEGMENT batching along the row (up to
    N columns per vector op) is proposed as safe AND is the main
    throughput win. Tail: width remainder handled per S4C-4 C2.

P2  VERTICAL-EDGE SEGMENTS (the transpose case). A vertical edge at
    column x processes 4 rows whose taps are purely horizontal
    (columns x-3..x+2 of that row); rows are mutually independent.
    PROPOSAL (primary): process the 4 rows as lanes via strided row
    loads + in-register transpose of the 6-tap window (classic
    deblocker structure), width-parametric; the 4-row segment
    underfills 128-bit lanes for u8 (4 of 16) - batching MULTIPLE
    same-x vertical segments down the plane is NOT proposed as the
    baseline because Schedule-A interleaves horizontal edges between
    row bands (dependency, S4C-3). ALTERNATIVE for coder assessment
    (P2-alt): keep vertical segments scalar in 4C if the transpose
    cost exceeds the win at 128-bit, and revisit at 256-bit - byte
    identity makes this a pure engineering choice, and an honest
    "scalar verticals" 4C is acceptable if argued.

P3  TRAVERSAL ORDER. Baseline: reproduce the oracle's exact
    interleaved traversal (hor(x), ver(x) per x within each row band).
    W3D's dependency analysis suggests one reordering is
    output-identical (all horizontal segments of a band, then the
    band's vertical segments in x order) because ver(x) writes touch
    only columns <= x+1 and later hor(x+k>=4) reads start at column
    x+k; the coder is asked to CONFIRM OR REFUTE this analysis
    line-by-line against the frozen schedule source. If confirmed and
    ratified, it enables P1's full-row horizontal batching; if
    refuted, the baseline stands and P1 batches only within the
    dependency-safe span the coder derives.

P4  MEMORY DISCIPLINE (charter C-SIMD-03). Strides are BYTE counts
    (K31); the byte-row navigation model is retained; UNALIGNED
    vector loads/stores are the baseline; no @alignCast or
    aligned-load assumption without the full C-SIMD-03 proof list.
    No gather instructions are assumed (C-SIMD-05): P2's strided rows
    are lane-by-lane loads unless assembly evidence shows otherwise.

P5  TAILS, CONCRETELY. For every loop that advances by N lanes: the
    remainder is processed by (in preference order, coder to assess)
    (a) a narrower comptime instantiation of the SAME body (e.g. N/2,
    then scalar), or (b) masked lanes, or (c) the scalar kernel -
    whose availability is guaranteed since it is compiled anyway.
    NEVER by widening a read/write beyond the C1 footprint. Every
    tail path is exercised by the corpus (section 7) at BOTH the unit
    and vspipe levels.
```

# 6. MANDATORY PRE-IMPLEMENTATION RESPONSE (the three-way round;
implementation begins only after W3X ratifies the outcome)

```text
Before any code, W3C returns a written response covering:

R1  ASSESSMENT of P1-P5: confirm, refute, or amend each, with
    reasoning grounded in the frozen schedule/kernel source and the
    Zig 0.16.0 vector semantics actually available (F9: no autovec;
    everything explicit).

R2  ONE OR TWO RELIABLE ALTERNATIVES where W3C sees a materially
    better or safer structure (e.g. a different vertical-edge
    strategy, a different tail mechanism), each with its tradeoffs
    and its byte-identity argument. "Reliable" outranks "fast"
    everywhere in 4C; performance claims belong to 5C.

R3  RELIABILITY CROSS-CHECK OF THE PRIOR RATIFIED REASONING (W3X
    instruction, 2026-08-12): re-read charter sections C and D, G9,
    and C-SIMD-01..05 IN LIGHT OF WHERE WE ARE NOW - 2C shipped and
    byte-anchored, runtime R79, Zig 0.16.0 with autovectorisation
    disabled (F9), the committed uniform-schedule fact (S4C-3) - and
    state explicitly either "the ratified reasoning holds unchanged"
    or name what reads differently today and why. Silence is not
    concurrence: the response addresses this item expressly.

R4  THE PARAMETRISATION PLAN: the concrete comptime shape of
    @Vector(N,T) instantiation, where N enters, how the 5C widths
    slot in WITHOUT structural change, and the per-width tail
    behaviour table (what happens at width remainder 1..N-1 for both
    T, both widths).

R5  ANY AUTHORISED-SURFACE ADDITIONS needed (section 2), argued file
    by file.

W3X ratifies (with W3D review) the resulting design points; only then
does implementation start. This round is deliberate: tails and lane
geometry are where paper designs meet implementation reality, and this
project fixes designs BEFORE code, not after.
```

# 7. Proof surface (build_4C_v1.bat extends the standing matrix)

```text
ORDER: full 1C gate re-execution (expecting +4C identity), full 2C
gate re-execution (85/85 three modes, RS==RF, sanity gate + negative
control, K31 audit; the HolyWu external arc is NOT re-run - its
evidence is 2C history; the S5/N-class expected lines updated for the
raised ceiling), THEN the 4C surface:

  4C-T1  v2 unit tests, three modes: the vector kernel/segment
         functions vs the scalar equivalents over ALL D3 fixtures
         (A/B vectors, O-4 + order tripwire, O-5d, O-7 family) plus
         exhaustive 8-bit single-edge sweeps and seeded randomised
         property tests (documented seed) for u8/u16 at N and every
         tail remainder.
  4C-T2  End-to-end differential: vspipe SHA-256 per-frame equality,
         backend=x86_64_v1_baseline vs backend=x86_64_v2_with_sse41,
         over the FULL corpus below, all plane subsets, representative
         strengths incl. corner offsets.
  4C-T3  Assembly containment (1B.2 form): v1 object free of
         SSE4.1-class instructions; v2 object's vector paths present
         under the exact feature closure; inspection artifacts
         retained as evidence.
  4C-T4  Selection gates: auto->v2 on capable hardware; the
         intentionally-capped(v2)/actual=v3 line byte-shape on the
         W3X 3900X; explicit v2 accepted; explicit v3 refused with
         the ratified S5 wording; scalar requestable (differential
         leg); D-2C-4 count gates re-asserted.
  4C-T5  Negative controls: the BMI2-class named-model perturbation
         still fails at comptime; the nine option-combination
         rejections; a NEW control - a deliberate one-lane tail
         perturbation in a test-only seam must be CAUGHT by 4C-T1/T2
         (proves the differential actually exercises tails).

CORPUS (tail-forcing is mandatory, G9 verbatim): the 17-case 2C dims
PLUS non-width-multiple, strong-edge cases chosen to force every
remainder class at N=16 and N=8 - at minimum widths/heights covering
remainder 1, N/2-1, N-1 (e.g. 711x480, 719x479, 353x289-class), u8
and u16, 4:2:0/4:2:2/4:4:4 and GRAY, plane subsets, and at least one
case where an eligible edge's segment is shorter than a full vector
at BOTH orientations.
```

# 8. Delivery and process (charter v1_27 rules bind)

```text
No-script package per C-DELIV-10/11: apply_to_tree/ mirror applied by
one manual W3X copy; restore_to_base/ pre-change data; manifest with
the manual per-file backout block; NO PowerShell, NO git in machinery,
NO patch files; base confirmed with W3X (C-DELIV-01, no hashes).
K30-style identifier audit discharged as delivery evidence + W3D
independent re-verification (the 2C precedent). Harness ownership:
W3D delivers the .vpy/.cmd differential harness; W3C delivers source
+ batch. C-DELIV-07: no execution or PASS claims by W3C; W3X runs all
validation; W3D artifact-reviews the passing evidence. Communication
per the W3X designer convention v1_0. C-DELIV-09 incremental emission
applies (header block above).
```

# 9. Out of scope (registered homes named)

```text
AVX2/256-bit instantiation and ALL performance work        -> Stage 5C
T-1 (c0-from-alpha-index) and every quality divergence     -> deferred
    quality/enhancement phase (K19(a)/K20 bar; status v1_24)
Chroma-grid / field-DCT / Y-vs-UV algorithm design         -> Deblock4,
    stages 3D+ (ratified README design; knowledge doc v1_1)
Float (16/32-bit) in any form (F10 rules pre-pinned)       -> the later
    bounded float step
The identifier-cleanup hygiene pass                        -> its own
    registered scope
```

---

*Revision history*
```text
v1.1 (2026-08-12) W3X ratification round: identity +4C confirmed (Q1);
     section-2 NEW-file naming made concrete (classic_vector_backend
     .zig width-generic body + classic_backend_v2_sse41.zig thin
     instantiation/object, per the house per-object pattern; 5C adds
     classic_backend_v3_avx2.zig); status advanced to RATIFIED and
     RELEASED TO W3C.
v1.0 (2026-08-12) Initial 4C scope: parametrised @Vector(N,T) single
     body with 128-bit proof (5C = same code, different parameters);
     byte-identity acceptance vs the committed scalar oracle at unit
     and vspipe levels; uniform-schedule no-adjacent-batching
     constraint; two-tail-class discipline; tier confinement; the
     mandatory pre-implementation three-way response (P1-P5 proposal,
     R1-R5 required items incl. the W3X-instructed reliability
     cross-check); tail-forcing corpus; ceiling raise to v2; identity
     +4C. Authored per W3X rulings of 2026-08-12.
```
