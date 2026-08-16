# Deblock4 - Scope - Stage 5C - Classic v3 (AVX2-class) Vector Backend

**Deliverable:** W3D-5C-SCOPE (for W3X ratification, then release to W3C)
**Version:** 1.2
**Date:** 2026-08-14
**Author:** W3D (designer)
**Route:** W3D -> W3X (ratification) -> W3C (with a mandatory
pre-implementation response round, section 6)
**Base:** the committed Stage 4C-accepted tree (identity 0.1.0-dev+4C),
confirmed with W3X per charter C-DELIV-01. W3X guarantees the local
repository is this base at patching time; no commit hash is recorded.
**Authority set (read together; highest committed versions prevail):** the
charter (AI_Charter_and_Invariants_Card v1_29 or later) PREVAILS over
everything here on conflict; Project Status v1_26; the Stage 4C scope v1_2
(the accepted vector-design precedent whose ratified decisions this scope
carries forward); D0 Binding Knowledge Index v1_13; Verification-and-Tiering
v1_11; Toolchain Findings v1_4 (F9/F10); README v1_12 (fallback general
guidance only, per its authority note); Session Bootstrap Header v1_1
(issued alongside this scope).
**Status:** W3X-RATIFIED 2026-08-14 (v1.0 ratified Q1-Q4; round outcomes
5C-RAT-1..8 ratified on the W3C pre-implementation response v1_0 and the
W3D review v1_0). IMPLEMENTATION RELEASED. The 5C-RAT-1 closing step is
DISCHARGED: W3X supplied the charter v1_29 documentation generation and
W3C's final delta knowledge sweep (2026-08-14) returned NO new
non-superseded knowledge item affecting this design. The pre-
implementation round is CLOSED; the only post-closure change is the v1.2
R4 wording correction below.
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

Implement the Classic v3 vector backend: the SAME width-generic vector body
proven at Stage 4C (src/classic_vector_backend.zig, untouched), instantiated
at the 256-bit widths (u8 N=32, u16 N=16) inside a NEW thin compilation unit
classic_backend_v3_avx2.zig compiled under the exact x86-64-v3 named level,
selected as tier `x86_64_v3_with_avx2`, and ACCEPTED SOLELY BY BYTE-IDENTITY
against the committed scalar oracle over a tail-forcing corpus re-derived for
the wider width (K2, K19(c), charter G9). No new mathematics exists in this
stage: 5C is the ratified S4C-1 promise made literal - "the same 4C code
with different parameters" - plus the 256-bit edge/tail re-proof, the
whole-level v3 selection surface, and the first recorded (NOT gated)
performance measurement. The known AVX2 near-edge hazard is stated in full
in section 4 and bound by S5C-4/S5C-5; no delivery that widens a read or
store beyond the proven 4C discipline can pass.

# 2. Frozen and forbidden surfaces

```text
BYTE-FROZEN (any delta is an automatic blocking finding):
    src/classic_scalar_kernel.zig
    src/classic_edge_schedule.zig
    src/classic_thresholds.zig
    src/classic_vector_backend.zig
  The scalar oracle IS the acceptance reference (S4/K19(c)). The
  width-generic vector body is 4C-ACCEPTED evidence and ALREADY
  admits the 5C widths (requireBackendWidth: u8 {16,32}, u16 {8,16},
  verified against the live tree 2026-08-14); 5C instantiates it and
  does not edit it. If the pre-implementation round finds a GENUINE
  width-generic defect, that is a STOP-and-report to W3X, never a
  silent edit (charter H1/H2).

FORBIDDEN (unchanged 4C forbidden surfaces continue):
    every Deblock4-filter module; the G10 debug modules beyond their
    established seams; build_1C_v1.bat, build_2C_v1.bat, build_4C_v1.bat
    and the resident audit scripts; the pinned holywu_r9 snapshot; the
    mathematics above; classic_backend_v2_sse41.zig (the accepted 4C
    object is 5C's structural template, not its editing surface).

AUTHORISED (the expected complete surface; the pre-implementation
response may propose narrow, argued additions):
    NEW  src/classic_backend_v3_avx2.zig - the 5C compilation unit:
         a thin instantiation binding N for 256-bit (32 for u8, 16 for
         u16), mirroring classic_backend_v2_sse41.zig exactly in shape:
         the comptime named-model drift guard against
         std.Target.x86.cpu.x86_64_v3, object-mode-only export fns
         deblock4_classic_v3_process_u8 / deblock4_classic_v3_process_u16
         (callconv(.c), same nine-argument signature), compiled into its
         OWN OBJECT under the exact x86-64-v3 named level. Tier
         confinement is then structural: AVX2-class instructions can
         exist only in this object (5C-T3 verifies).
    NEW  build_5C_v1.bat (extends the proof matrix; earlier batches
         retained and re-executed by it)
    NEW  tests/classic_vector_backend_5c_tests.zig [RATIFIED 5C-RAT-3]
         - W3C SOURCE, test-only: imports the frozen vector body and
         scalar oracle; NEVER imported by production code; the home
         of the explicit N=32/N=16 differential, every-remainder,
         alignment/stride and canary tests (5C-T1). The .vpy/.cmd
         harnesses that also live under tests/ remain W3D
         deliverables; ownership does not blur by directory.
    MOD  src/deblock4_config.zig       (classic_tier_ceiling raise to
                                        .x86_64_v3_with_avx2 ONLY;
                                        deblock4_tier_ceiling untouched)
    MOD  src/classic_ar_all_frames_ready.zig (the
                                        .x86_64_v3_with_avx2 arm changes
                                        from `return error.BackendInvariant`
                                        to calls of the two v3 externs,
                                        mirroring the v2 arm; v1 and v2
                                        arms retained verbatim)
    MOD  src/deblock4_version.zig      (single-homed identity advance)
    MOD  src/deblock4_selftest.zig     (v3 additions; the existing
                                        v3-positive detector case on the
                                        W3X host is already present and
                                        stays)
    MOD  build.zig                     (v3 target/module/object with the
                                        exact named level; inspection
                                        object install step; vector unit
                                        tests additionally run under the
                                        v3 target at the 5C widths)
    ---  src/backend_tier_selection.zig EXPECTED-UNTOUCHED [RATIFIED
                                        5C-RAT-8: verified generic across
                                        v1/v2/v3 and ceilings]; the
                                        conditional MOD authorisation is
                                        retained for genuine wiring
                                        discoveries, argued at delivery
```

# 3. Design decisions (S5C series - PROPOSED, for W3X ratification;
S5C-1/2/4/5 restate already-ratified 4C-RAT law at the new width)

```text
S5C-1  SAME BODY, WIDER INSTANTIATION (S4C-1 fulfilled). The v3 unit
       instantiates processPlane(T, N) with u8 N=32 and u16 N=16 -
       widths the frozen body already ratifies at compile time. NO
       structural change to the body is in scope. The vertical-edge
       path is WIDTH-INVARIANT by ratified design (4C-RAT-3: the
       four-row lane pack computes at @Vector(4, i32) because
       Schedule A's 4-step dependency caps vertical lanes at 4 - an
       ALGORITHM property, not an implementation one); 5C changes
       horizontal-edge batching width only. The response confirms this
       reading against the frozen source (R1).

S5C-2  ACCEPTANCE BASIS: SCALAR-vs-VECTOR BYTE IDENTITY, unchanged
       (K2, K19(c), G9). v3 output is byte-identical to the committed
       scalar oracle for every corpus case, every plane, every depth,
       or the delivery fails. There is NO HolyWu re-run and NO
       v2-vs-v3 acceptance shortcut: the oracle is the single
       reference; a v1-vs-v2-vs-v3 three-way equality check is run as
       corroborating evidence but the ORACLE differential is the gate.
       Two levels as at 4C: (a) pure-Zig unit level at the 5C widths
       and every 5C remainder; (b) end-to-end vspipe SHA-256 per-frame
       equality, backend=x86_64_v1_baseline vs
       backend=x86_64_v3_with_avx2 (and the v2 leg retained).

S5C-3  PERFORMANCE IS MEASURED AND RECORDED, NEVER GATED (charter
       P-10; the "actual AVX2 speed benefit" is MEASUREMENT-GATED
       knowledge per the settled open-thread classification, decided
       by evidence, closed by this stage's measurement).
       [RATIFIED 5C-RAT-4] The benchmark step is a W3D-OWNED Python
       runner (time.perf_counter around the exact vspipe process; ONE
       discarded warm-up run then THREE recorded runs per backend
       v1/v2/v3; identical clip, frames, parameters, sink and
       environment; every raw duration printed); build_5C_v1.bat only
       invokes it.
       Acceptance does NOT depend on any speed threshold: a v3 that is
       byte-identical but no faster still PASSES 5C, and the measured
       result is recorded in Project Status as the closing of that
       measurement question. No benchmark number becomes normative
       (charter A3).

S5C-4  THE TWO TAIL CLASSES, RESTATED AT 256-BIT (charter section C,
       binding; S4C-4 carried forward). C1 - incomplete ALGORITHMIC
       footprint: eligibility is the oracle's (edge >= 3 AND
       edge+2 < extent) and is NEVER widened or narrowed; widening N
       does not change eligibility, row reads, or the footprint. C2 -
       complete valid footprint that merely underfills the 256-bit
       register: STILL PROCESSED. The ratified mechanism is UNCHANGED:
       descending same-body power-of-two decomposition (4C-RAT-4) -
       at N=32 the chain is 32,16,8,4,2,1 and is ALREADY IMPLEMENTED
       by the frozen recursive tail. [RATIFIED 5C-RAT-6 / W3D-F1
       CORRECTION: the descent TERMINATES IN A ONE-LANE VECTOR
       application of the same body, filterHorizontalLanes(T, 1, ..)
       ("V1"), NOT the scalar-column function; the N==1
       scalar-column branch is DEFENSIVE code unreachable from any
       ratified width. The historical 4C wording "then scalar 1"
       misnamed this terminal; the adopted normative tables (the
       response R4 tables with every terminal "S1" read as "V1")
       carry the corrected names. Byte-identity is unaffected: V1 is
       the identical i32 arithmetic and the 4C remainder sweep proved
       this exact path. Candidate D0 K-item at the 5C doc pass.] NO
       masked inactive lanes; NO masked loads/stores (section 4); NO
       read or write beyond the C1 footprint, ever.

S5C-5  TIER CONFINEMENT AND INSPECTION (C-SIMD-01/02; the 1B.2
       discipline; S4C-5 carried forward). v3 vector code is compiled
       ONLY into the v3 backend object under the exact x86-64-v3
       named level; the v1 object remains free of v2/v3-class
       instructions and the v2 object remains free of v3-class
       instructions (assembly containment audit, whole-token matching
       per the accepted 4C repair, re-run across ALL THREE objects);
       the comptime named-model drift guard mirrors the v2 unit
       exactly at x86_64_v3; the named-model perturbation control is
       retained and must still fail the build. RS==RF production byte
       identity continues (K10). F9 stands: every vector lane is
       EXPLICIT @Vector work. NOTE for T3 expectations: the DESCENDING
       TAIL means the v3 object legitimately contains 128-bit-and-
       narrower operations (the N=16 and narrower sub-instantiations);
       containment means NOTHING ABOVE v3 anywhere and no v3-class
       instructions outside the v3 object - it does not mean the v3
       object is 256-bit-only. The G5/1B.3 runtime guard is unchanged
       and already proven: v3 executes only after whole-level
       detection including OSXSAVE and XGETBV/XCR0 XMM+YMM state.

S5C-6  SELECTION SURFACE. classic_tier_ceiling raises to
       .x86_64_v3_with_avx2 - the ONLY config change. Consequences,
       all gate-checked on the W3X 3900X (a full-v3 host, the standing
       positive detector case): auto resolves to v3 with the
       capability-derived reason shape; the 4C-era
       intentionally-capped(v2) expected line DISAPPEARS from the
       gates (updated IN THE 5C GATES ONLY - 4C's committed evidence
       is history, not rewritten); explicit backend=
       "x86_64_v3_with_avx2" is accepted on capable hardware and
       refused with the ratified S5 wording where unsupported;
       explicit v2 remains accepted (and is a differential leg);
       scalar remains requestable (the reference leg).
       deblock4_tier_ceiling stays untouched. Existing emission
       semantics unchanged.

S5C-7  STAGE IDENTITY. The single-homed identity advances to
       0.1.0-dev+5C. All prior identity gates re-run expecting the new
       token via the 5C matrix's updated expectation (the S6
       discipline).
```

# 3b. BINDING KNOWLEDGE CHECKLIST (D0 v1_13 standing mechanism;
W3D-authored, every line verified against the index)

```text
BINDING ON 5C (glosses are 5C applications; the index text prevails):
K1   N is vector ELEMENT count, never bytes: u8 N=32, u16 N=16 at
     256-bit. A "256-bit register" is 32 u8 lanes or 16 u16 lanes;
     never conflate register bytes with lane count.
K2   SIMD width must not define output: scalar, v2 and v3
     byte-identical (integer; float refused per K29/S1).
K4   AVX2 MASKED LOAD/STORE WARNING - NOW BINDING (it was expressly
     deferred to 5C by the 4C checklist). AVX2 masked integer I/O
     (VPMASKMOV class) exists ONLY at dword/qword granularity: there
     is NO byte- or word-granular masked load/store below AVX-512.
     A masked byte-tail is therefore not expressible as a single
     masked op for u8/u16 data, and README 7.4 (quoted in section 4)
     forbids adopting masked tails "merely because they sound
     branchless". The ratified descending-decomposition tail
     (4C-RAT-4) REMAINS the 5C mechanism; masked-I/O tails are
     out of scope.
K5   R76-class miscompile mitigations are PERMANENT: explicit @Vector +
     the standing scalar-vs-SIMD differential + tail-forcing corpus
     (G9), re-derived for the 256-bit remainder classes.
K7   Frozen edge footprint: reads e-3..e+2, writes e-2..e+1.
K9   Oracle sequencing: the accepted 2C scalar path is the mandatory
     differential reference for every 5C pixel/backend path.
K10  RS==RF production byte identity remains a standing re-run gate.
K11  Classic is Schedule A ONLY; the ratified 4C-RAT-2 band reorder is
     the ONLY approved deviation from raw interleave; no adjacent-edge
     batching; the O-4 order tripwire stands.
K12  Settled toolchain object/export/linkage facts govern the v3
     object (F1-F5; the v2 unit is the working proof of the pattern).
K13  G5: v3 instructions execute only behind the proven whole-level
     guard (incl. OSXSAVE + XGETBV/XCR0) and the immutable
     per-instance selection. The current dispatch arm's
     error.BackendInvariant is REPLACED by real calls - reachable only
     when selection has already proven v3.
K14  Any permanent test/debug seam takes the full G10 discipline
     (5C ships NONE; the T5 mutant mechanism is the 4C-RAT-6
     out-of-repo copy, reused).
K15  v3 is a separate target-specific object per the settled
     architecture; no PE-export doorway; no static-init v3 execution;
     the dumpbin /EXPORTS gate re-runs.
K16  Creation-error strings and using-echo surfaces stay byte-stable
     except where S5C-6 expressly authorises movement.
K18  Proof-domain and audit discipline: the 5C batch inherits the
     deliverable-tree domain rules of the standing matrix.
K19c Classic-internal scalar-vs-v3 equivalence is merciless integer
     byte-identity; no tolerances.
K21  Do-not-revisit list stands: no twin-build, no bespoke feature
     closure, no identity-driven feature subtraction (FMA is PART of
     v3 and is NOT excluded; under .strict it is simply not relied
     upon - integer code emits no FMA anyway).
K23  Diagnostics contract: the reported selected tier IS the executed
     tier; output deterministic and exact.
K24  One canonical formula body: the v3 unit instantiates; it never
     forks or rewrites the frozen formulas or the frozen vector body.
K25  Whole-level detection only; a CPU exposing AVX2 but failing any
     other v3 requirement is NOT v3 (falls back v2 then v1).
K27  Destination starts copyFrame-equivalent; source properties
     preserved before audit properties.
K28  ACTUAL per-plane width/height/stride/storage; never infer chroma
     geometry from luma; stride slack is not pixels (load-bearing for
     the near-edge hazard, section 4).
K29  Integer 8..16 only; 17..32 dedicated refusal; float refused.
K30  The new module (classic_backend_v3_avx2) takes a first-class
     permanent name and one-way dependency; K30-style identifier
     audit as delivery evidence + W3D re-verification.
K31  Strides are BYTE counts; byte-row navigation; never silent
     division.
K32  Charter v1_27+ delivery mechanics: no hashes, no
     repository-operating scripts, no PowerShell, no staging; manual
     W3X apply/backout; base confirmed with W3X.

EXPRESSLY NOT BINDING ON 5C (do not silently import):
K3   HolyWu frame-boundary documentation duty -> 2C history.
K6, K22, F10  float semantics -> the later bounded float step.
K8   multi-oracle caution -> satisfied structurally (as at 4C).
K17  superseded by charter v1_27+ (see K32).
K20  quality-divergence bar -> deferred quality/enhancement phase.
K26  HolyWu external binary pin -> 2C evidence history; 5C never
     runs it.
```

# 4. THE AVX2 NEAR-EDGE HAZARD, FULLY EXPLICIT (the spine; read
before section 5)

```text
Charter G9, verbatim rationale: compiler code-generation defects
(correct source, wrong machine code) CLUSTER AT EDGES AND TAILS -
exactly where a deblocker operates - and produce gross corruption, not
rounding. G9 continues: "AVX2 (5C) raises the stakes - wider registers
mean more frequent underfill tails and bigger corruption blast radius"
- which is why the tail machinery was built width-parametric at 4C.
This section names the hazard's concrete faces so no delivery can meet
it by accident.

FACE 1 - WIDE LOADS NEAR THE RIGHT EDGE OVER-READ. A horizontal edge
at row y loads six row-slices of N columns starting at column x. At
N=32 a "load full width and mask the store" shortcut reads columns
x..x+31; for the final partial group that read runs PAST the last
valid column - into stride slack for interior rows, and past the
BUFFER for the bottom-most loaded row (edge_y+2 of the last eligible
horizontal edge). Charter B6 FORBIDS relying on VapourSynth stride
padding for over-reads; K28 states stride slack is not pixels. The
frozen body never over-reads (loadContiguous slices exactly L
elements); the hazard is a DELIVERY reintroducing a wide-load
shortcut. RULE: no read or write beyond the exact lane span, ever;
the descending decomposition (S5C-4) is the only tail mechanism.

FACE 2 - AVX2 MASKED I/O IS NOT A BYTE-TAIL SOLUTION (K4, now
binding). README 7.4, quoted verbatim:
  "AVX2 masked integer loads/stores are not a universal byte-tail
   solution. Available instructions operate at particular element
   granularities and may complicate byte-oriented deblocking.
   Do not adopt masked tails merely because they sound branchless.
   A short scalar or smaller-vector cleanup outside the hot
   full-vector loop is usually easier to prove and may be faster."
Concretely: VPMASKMOV exists at 32/64-bit element granularity only;
u8/u16 lanes cannot be byte/word-masked below AVX-512. Any masked-tail
proposal is out of scope in 5C.

FACE 3 - MORE FREQUENT, DEEPER TAILS. At N=32 the u8 remainder class
is 1..31 (was 1..15): PAL 720-luma yields remainder 16 (a full
half-width step), 704-luma divides exactly, and chroma planes at 352
and 360 produce 0 and 8. The corpus (section 7) forces every
remainder CLASS boundary: 1, 15, 16, 17, 31 for u8 and 1, 7, 8, 9, 15
for u16, so every level of the 32,16,8,4,2,1 descent executes and is
byte-checked at both unit and vspipe levels.

FACE 4 - WHAT DOES NOT CHANGE (assert, do not re-derive). Widening N
changes NOTHING about: eligibility (C1), row reads (six rows around
edge_y), the vertical-edge path (four-row lane pack, N=4 compute,
width-invariant by 4C-RAT-3), the schedule (4C-RAT-2 band order), or
thresholds. A delivery that "adapts" any of these for 256-bit has
misread the design and fails review.

FACE 5 - EXECUTION SAFETY AND TRANSITION HYGIENE. G5 unchanged: the
v3 object's instructions never execute before whole-level detection
(OSXSAVE membership AND runtime XGETBV/XCR0 XMM+YMM). The
SSE/AVX-transition (vzeroupper) question was settled by inspection at
Stage 1B.2 for the named-model objects; 5C-T3's disassembly evidence
re-confirms VEX encoding and transition hygiene rather than assuming
them (G6: verified, not assumed).
```

# 5. Designer proposal (for coder investigation - a PROPOSAL, not a
directive)

```text
P1  [RATIFIED with the W3X COMMENTARY MANDATE, 5C-RAT-7: the v3 unit
    carries prominent human-facing top-of-module commentary covering,
    at least: N is lane count not bytes, with the v2/v3 u8/u16 width
    calculations; "256-bit" names the storage batch and named tier,
    not every internal logical vector; i32 widening may lower one
    logical vector to multiple YMM operations; horizontal scales with
    N while vertical remains the fixed four-row pack; C1 vs C2; why
    right-edge over-read is forbidden; why AVX2 dword/qword masked
    I/O is no u8/u16 tail mechanism; why the descending cleanup
    exists; stride slack is never pixels; object-mode export fn is
    emission/linkage not a PE export; the target is full named
    x86-64-v3; execution stays behind the proven whole-level guard.
    The equivalent v2-unit commentary reconciliation is a REGISTERED
    POST-5C FOLLOW-UP (section 9); the v2 unit stays frozen in 5C.]
    THE THIN UNIT IS A MIRROR. classic_backend_v3_avx2.zig follows
    classic_backend_v2_sse41.zig line-for-line in shape: the comptime
    verifyNamedV3Target() drift guard (x86_64_v3 named model,
    populateDependencies, per-feature equality, @compileError on
    drift); processU8 -> processPlane(u8, 32, ...); processU16 ->
    processPlane(u16, 16, ...); object-mode-only export fns
    deblock4_classic_v3_process_u8/_u16 with the identical
    nine-argument callconv(.c) signature; the comptime address-take
    retention block. Deviations from the mirror require argument.

P2  BUILD WIRING IS A MIRROR. build.zig adds classic_v3_target
    (x86_64_v3 explicit cpu_model), classic_v3_module/object, DLL
    addObject, the classic-v3-object inspection install step, and a
    test wiring running TWO v3-target legs [RATIFIED 5C-RAT-3]:
    (leg 1) the frozen body's own test file compiled/run under the
    exact v3 target; (leg 2) the new tests/classic_vector_backend_
    5c_tests.zig for the explicit N=32/N=16, every-remainder,
    alignment/stride/canary proof. The frozen body file is not
    edited.

P3  DISPATCH ARM. classic_ar_all_frames_ready.zig: declare the two v3
    externs beside the v2 externs; the .x86_64_v3_with_avx2 arm calls
    callV3U8/callV3U16 mirroring the v2 helpers. The v1 and v2 arms
    are retained byte-verbatim. error.BackendInvariant disappears
    from this switch entirely (every tier now has a real arm) - the
    coder VERIFIED (W3D re-verified, repository-wide) that exactly
    two sites exist - the error-set member and the placeholder arm -
    so [RATIFIED 5C-RAT-5] the now-dead BackendInvariant member is
    REMOVED from the local error set with the arm.

P4  BENCHMARK STEP (S5C-3). [RATIFIED 5C-RAT-4 as amended by the
    response: the W3D-owned Python runner, invoked by the batch as a
    final NON-GATING step; raw numbers into the evidence log; no
    pass criterion; presence of the numbers is the obligation.]

P5  TAILS: NOTHING NEW. [RATIFIED 5C-RAT-6: the response R4 per-
    remainder tables for u8 N=32 and u16 N=16 are ADOPTED AS
    NORMATIVE with the W3D-F1 terminal correction (every terminal
    "S1" reads "V1" = filterHorizontalLanes(T,1); the scalar-column
    branch is defensive/unreachable), together with the response's
    chroma-forcing corpus frame widths.]
```

# 6. MANDATORY PRE-IMPLEMENTATION RESPONSE (the three-way round;
implementation begins only after W3X ratifies the outcome)

```text
Before any code, W3C returns a written response covering:

R1  ASSESSMENT of P1-P5: confirm, refute, or amend each, with
    reasoning grounded in the frozen body/schedule source (file and
    line), the accepted v2 unit, and Zig 0.16.0 vector semantics
    (F9: no autovec; everything explicit). R1 expressly includes:
    (a) confirmation from the frozen source that the vertical path is
    width-invariant and the horizontal tail descent already covers
    N=32; (b) confirmation that no other code path depends on the
    dispatch arm's error.BackendInvariant.

R2  ONE OR TWO RELIABLE ALTERNATIVES where W3C sees a materially
    better or safer structure, each with tradeoffs and its
    byte-identity argument. "Reliable" outranks "fast" for
    correctness structure; the benchmark form (P4) is the one place
    performance shaping is welcome.

R3  RELIABILITY CROSS-CHECK OF THE PRIOR RATIFIED REASONING (the
    standing W3X instruction, carried from 4C): re-read charter
    sections C and D, G5, G9, and C-SIMD-01..05 IN LIGHT OF WHERE WE
    ARE NOW - 4C shipped and byte-anchored at 128-bit, runtime R79,
    Zig 0.16.0 with autovectorisation disabled (F9), the ratified
    4C-RAT set - and state explicitly either "the ratified reasoning
    holds unchanged at 256-bit" or name what reads differently and
    why. Silence is not concurrence.

R4  THE PER-WIDTH TAIL BEHAVIOUR TABLE for u8 N=32 and u16 N=16:
    for every remainder 1..N-1, which sub-instantiations execute in
    which order, terminating at the one-lane vector
    V1 = filterHorizontalLanes(T, 1, ...) per S5C-4 / 5C-RAT-6 (NOT
    the defensive scalar-column branch); plus the corpus dimensions
    that force each class boundary (cross-checked against section 7).

R5  ANY AUTHORISED-SURFACE ADDITIONS needed (section 2), argued file
    by file - expressly including the placement of the new 5C-width
    unit tests without touching the frozen body file.

W3X ratifies (with W3D review) the resulting design points; only then
does implementation start. [ROUND STATUS: the response v1_0 was
received PROVISIONAL (coder package predated charter v1_29); W3D
review v1_0 verified it; W3X ratified 5C-RAT-1..8 on 2026-08-14. ONE
OPEN CLOSING STEP: the coder's final DELTA KNOWLEDGE SWEEP against the
W3X-supplied current package (5C-RAT-1). A clean delta sweep closes
the round without further ratification; any new finding routes W3D ->
W3X as usual.]
```

# 7. Proof surface (build_5C_v1.bat extends the standing matrix)

```text
ORDER: full 1C gate re-execution (expecting +5C identity), full 2C
gate re-execution (85/85 three modes, RS==RF, sanity gate + negative
control, K31 audit; HolyWu arc NOT re-run), full 4C gate re-execution
(vector unit suite at the 4C widths, v1-vs-v2 differential; the
S5C-6 expected-line updates applied IN THE 5C GATES ONLY), THEN the
5C surface:

  5C-T1  v3 unit tests, three modes, in the two ratified legs
         (5C-RAT-3): the frozen-body tests under the v3 target, plus
         tests/classic_vector_backend_5c_tests.zig at u8 N=32 /
         u16 N=16 against the scalar equivalents over all D3
         fixtures, exhaustive 8-bit single-edge sweeps, seeded
         randomised property tests (documented seed) at EVERY 5C
         tail remainder (u8 1..31, u16 1..15), AND the explicit
         memory-safety fixtures: minimal sample-valid (deliberately
         non-16/32-byte-aligned) base positions, non-vector-aligned
         strides, prefix/suffix/row-slack CANARIES verified intact,
         no assumed padding, strong-edge data so tail execution is
         non-vacuous (Concise Summary section 7 doctrine).
  5C-T2  End-to-end differential: vspipe SHA-256 per-frame equality,
         backend=x86_64_v1_baseline vs backend=x86_64_v3_with_avx2,
         over the FULL corpus below, all plane subsets,
         representative strengths incl. corner offsets; PLUS the
         three-way v1==v2==v3 corroboration on a corpus subset.
  5C-T3  Assembly containment (1B.2 form, whole-token matching per
         the accepted 4C repair): v1 object free of v2/v3-class
         instructions; v2 object free of v3-class instructions
         (VEX/AVX2-class scan); v3 object's 256-bit vector paths
         present (ymm-register evidence) under the exact named level,
         with the S5C-5 note honoured (narrower sub-instantiation ops
         inside the v3 object are legitimate); vzeroupper/VEX
         transition hygiene confirmed from the same disassembly;
         dumpbin /EXPORTS gate re-run (no gated symbol PE-exported);
         inspection artifacts retained as evidence.
  5C-T4  Selection gates on the W3X 3900X: auto->v3
         capability-derived; explicit v3 accepted; explicit v2
         accepted; scalar requestable; the 4C intentionally-capped
         expected line removed from the 5C gates; refusal wording
         gates for unsupported hardware asserted structurally (string
         shape, since the 3900X cannot exercise the refusal live);
         count gates re-asserted.
  5C-T5  Negative controls: the named-model perturbation still fails
         at comptime (now for BOTH the v2 and v3 drift guards); the
         option-combination rejections re-run; the 4C-RAT-6 mutant
         control REUSED AT THE NEW WIDTH: out-of-repo source copy,
         one narrow one-lane mutation in the FINAL-COLUMN cleanup
         path the v3 build actually executes, mutant build must be
         REJECTED by 5C-T1 and 5C-T2; copy discarded; no repository
         file, git, PowerShell or staging touched (C-DELIV-10/11).
  5C-T6  Benchmark record (NON-GATING, S5C-3): the ratified W3D
         Python runner invoked by the batch; raw numbers into the
         evidence log; no pass criterion.

CORPUS (tail-forcing is mandatory, G9 verbatim; re-derived for
256-bit): the 4C dims PLUS dimensions forcing every 5C remainder
class boundary - u8 widths hitting remainder 1, 15, 16, 17, 31
(e.g. 705x480, 719x479, 720x576 [rem 16], 721x481, 735x479-class)
and u16 widths hitting remainder 1, 7, 8, 9, 15 - across u8 and u16,
4:2:0/4:2:2/4:4:4 and GRAY, plane subsets, and [RATIFIED 5C-RAT-2, replacing the 4C-carried "both
orientations" phrasing]: HORIZONTAL - at least one case whose
eligible horizontal edge carries a valid C2 tail SHORTER than the
full N=32 (u8) and N=16 (u16) batch; VERTICAL - at least one case
forcing legal bottom underfill of the width-invariant four-row path
at EACH of row counts 1, 2 and 3 (heights whose final band leaves
1, 2, 3 rows). Chroma-forcing frame widths from the adopted R4
set (e.g. 4:2:0 frames 706/734/736/738/766 -> u8 chroma remainders
1/15/16/17/31) are included so remainder classes are forced ON
CHROMA PLANES of legal even-width frames. The adopted R4 tables and
this corpus cross-agree (verified at ratification).
```

# 8. Delivery and process (charter v1_29 rules bind)

```text
No-script package per C-DELIV-10/11: apply_to_tree/ mirror applied by
one manual W3X copy; restore_to_base/ pre-change data; manifest with
the manual per-file backout block; NO PowerShell, NO git in machinery,
NO patch files; base confirmed with W3X (C-DELIV-01, no hashes).
K30-style identifier audit discharged as delivery evidence + W3D
independent re-verification. Harness ownership: W3D delivers the
.vpy/.cmd differential and benchmark harness; W3C delivers source +
batch. C-DELIV-07: no execution or PASS claims by W3C; W3X runs all
validation; W3D artifact-reviews the passing evidence. Communication
per the W3X coder convention v1_0. C-DELIV-09 incremental emission
applies (header block above). Session Bootstrap Header v1_1 is issued
by W3X alongside this scope.
```

# 9. Out of scope (registered homes named)

```text
Float (16/32-bit) in any form (F10 rules pre-pinned)       -> the later
    bounded float step
T-1 (c0-from-alpha-index) and every quality divergence     -> deferred
    quality/enhancement phase (K19(a)/K20 bar)
Chroma-grid / field-DCT / Y-vs-UV algorithm design         -> Deblock4,
    stages 3D+ (the 4C never-a-basis ruling stands verbatim: nothing
    in Classic's vector code is a design or acceptance basis for
    Deblock4)
Masked-I/O tails, AVX-512, gather/scatter of any kind      -> not in
    this project's ratified tier set / mechanism set (K4, K21,
    C-SIMD-05)
The identifier-cleanup hygiene pass                        -> its own
    registered scope
v2-unit commentary reconciliation (mirror the ratified v3
    commentary into classic_backend_v2_sse41.zig)           -> REGISTERED
    post-5C follow-up (5C-RAT-7); that file is frozen in 5C
Any scalar-oracle or width-generic-body edit               -> STOP and
    report (section 2)
Deblock4 tier ceiling, Deblock4 backends                   -> stages 4D/5D
```

---

*Revision history*
```text
v1.2 (2026-08-14) Correction-only (W3C post-ratification review Q1,
     W3D-verified): section 6 R4 still said the tail table terminates
     "at scalar", contradicting the S5C-4 / 5C-RAT-6 V1 correction
     ratified in v1.1; R4 now names V1 = filterHorizontalLanes(T,1,..)
     and excludes the defensive scalar-column branch. Header status
     records the 5C-RAT-1 discharge: current package supplied and the
     W3C delta knowledge sweep returned clean, closing the
     pre-implementation round. No design change; no new obligation.
v1.1 (2026-08-14) Ratification round closed on the W3C pre-implementation
     response v1_0 + W3D review v1_0: 5C-RAT-1..8 folded at their homes
     (current-package supply + delta sweep; corpus orientation split;
     tests/classic_vector_backend_5c_tests.zig + explicit memory-safety
     proof; W3D Python benchmark runner; dead BackendInvariant member
     removal; normative R4 tables with the W3D-F1 V1-terminal
     correction + chroma-forcing widths; W3X commentary mandate + the
     registered v2 follow-up; tier-selection expected-untouched).
     IMPLEMENTATION RELEASED pending the clean delta sweep.
v1.0 (2026-08-14) Initial 5C scope: 256-bit instantiation of the frozen
     4C width-generic body (u8 N=32, u16 N=16) in a mirror thin object
     classic_backend_v3_avx2.zig; byte-identity acceptance vs the
     committed scalar oracle at unit and vspipe levels with a
     tail-forcing corpus re-derived for the 5C remainder classes; the
     AVX2 near-edge hazard stated in five explicit faces (wide-load
     over-read, masked-I/O granularity, deeper tails, width-invariant
     surfaces, execution/transition hygiene); K4 promoted to binding;
     performance measured and recorded but never gated (S5C-3);
     ceiling raise to v3; identity +5C; mandatory pre-implementation
     response R1-R5 incl. the standing reliability cross-check.
     Authored against the live 0.1.0-dev+4C tree, verified cold.
```
