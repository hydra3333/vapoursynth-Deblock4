# Deblock4 - Project Charter and Invariants Card

**Version:** 1.30
**Date:** 2026-08-18
**Status:** W3X-ratified. Part 1 carries invariants G1-G10. v1.14 corrects
the mandatory bootstrap (per-type acceptance + oracle-construction exception,
closing the reinstated byte-identity and the circular oracle rule), splits
Stage 1B.2/1B.3 in G3, clarifies OSXSAVE level-membership vs runtime safety,
and softens FMA wording. v1.17 adds G10: the ratified debug-only code inclusion pattern.
v1.18 records the Stage 1B.3 ratifications: the ACTUAL/EFFECTIVE two-record model (G1),
the G3 one-mechanism reconciliation (comptime membership cross-check, compile-FAIL),
the Debug-only hard-reject for debug options and the fix-not-force rule (G10), 
the nothing-above-v1 tightening for generic/dispatch/detection code (G2), 
the module single-homes and one-way-dependency/sweep standing rules (C-STY-09/10), and
the attached-source-tree session-base alternative. v1.19 replaces the C-DELIV-06 LF default
with the ratified CRLF-for-repository-files rule plus the pinned git whitespace configuration.
v1.20 adds C-DELIV-09: incremental emission for interrupt-safety and review continuity, with 
the honest only-delivered-work-survives limit and the unchanged final packaged deliverable; 
the rule is copied verbatim into every scope header. v1.21 adds section 2.3a: version-currency and paired-document 
discipline (verify latest with W3X; a directly-provided document beats the latest committed; STOP on a
version-paired mismatch). v1.22 generalises 2.3a from pairs to version SETS of two or more
(latest of each member prevails; read the set together; STOP on an incomplete or inconsistent declared set).
v1.23 adds I7: a change to criteria applied to the proposer's own work must name a different-party verifier
and must never be silently absorbed; it also makes the bootstrap charter reference self-referential,
updates the W3D role wording for successor-session continuity, and normalises this repository document to CRLF.
v1.24 replaces C-DELIV-09 with independently verified wording: a material-risk trigger rather than a mechanical
module count; complete self-identifying recovery/review increments; an exact and honest recoverability boundary;
later integration may supersede earlier increments; and the final integrated C-DELIV-01..08 package remains the
artifact of record. No Part 1 invariant or project-design change.
v1.25 binds the current C-DELIV-09 reminder block into every scope and delivery-plan addendum, copied verbatim
from its latest version per section 2.3a; the charter governs on any difference. No Part 1 invariant or
project-design change.
v1.29 (2026-08-14) one-phrase completion of the v1.28 reconciliation: the
C-DELIV-03 closing sentence's "commit verification" (a step that no longer
exists under the confirmed-base model) becomes "base confirmation". Nothing
else changed. Finding and exact wording by the Stage 5C-era W3C session
(second orientation review, Q1, 2026-08-14).
v1.28 (2026-08-14) currency-only reconciliation of residual pre-v1.27
starting-commit wording with the C-DELIV-01 base-confirmation model: the
section-1 template field, C-DELIV-03's statement and verification bullet,
C-DELIV-04's replacement-file bullet, and C-DELIV-08 (git rev-parse removed;
branch/base confirmed with W3X). Patch anchors, git apply --check, whitespace
and git diff --check mechanics unchanged. No new rule; no rule removed.
Finding credited to the Stage 5C-era W3C session (its orientation Q1,
2026-08-14).
v1.27 (2026-08-12) updates the section 4.3 delivery protocol to match the accepted no-script,
manual-base process. C-DELIV-01 drops the exact-starting-commit requirement: the base is the
prevailing repository state confirmed with W3X (who guarantees the local repo IS the base); no
commit hash or per-file base hash is recorded. New C-DELIV-10 states the refined git rule
(forbidden in machinery: stash, auto staging/committing, and correctness depending on index/
staging/HEAD state; permitted: non-destructive reads and W3X-manual git; staging never used;
commit is a manual post-acceptance W3X act). New C-DELIV-11 states that deliveries ship no
PowerShell and no repository-operating script: application is a manual copy of apply_to_tree/
or W3X-manual git apply, and backout is a manual W3X command block plus an optional
restore_to_base/ data folder. The existing patch workflow (C-DELIV-02/03) remains available as
a W3X-manual option. No Part 1 invariant or project-design change.
v1.26 adds section 2.3b, replacing automatic scope reissue after every later controlling-document change with a
materiality-based compatibility decision owned by W3D recommendation and W3X decision/recording; uncertain or
disputed compatibility remains STOP-and-reissue. It also limits the C-DELIV-09 reminder-block requirement to
scopes and delivery-plan addenda issued henceforth. No Part 1 invariant or project-design change.
**Companion specification:** `README_Deblock4_Design_Spec_v1_12.md`
**Companion internal revision:** `Design specification revision: 1.12`
**Encoding:** US-ASCII only. See C-STY-01.

---

# Part 0 - What this project is (read once)

Deblock4 is a VapourSynth plugin, written in Zig, that removes block artifacts left behind by lossy video compression. It is a from-scratch reimplementation informed by HolyWu's `VapourSynth-Deblock`, not a port of it.

The immediate purpose is restoration of PAL 576i tape material captured to MPEG-2 by consumer hardware DVD recorders, where coarse quantisation of a noisy analogue signal leaves visible 8x8 block structure.

The plugin registers two CORE filters, built in this order; later QED variants
are separate future workstreams that do not change the two-core sequence:

```text
INITIAL CORE DELIVERY (this project):
    deblock4.Classic     H.264 filter, faithful to HolyWu     <- built FIRST
    deblock4.Deblock4    the MPEG-2-aware edge filter          <- built SECOND
                         (the end goal)

LATER PLANNED WORKSTREAMS (separate, do not alter the above):
    deblock4.Deblock4_qed             masked/blended variant
    deblock4.Deblock4_qed_autoadjust  automatic strength selection
```

deblock4.Classic is built first BECAUSE it is a known algorithm with HolyWu's
plugin as an external reference oracle, so it proves the shared infrastructure
and verification harness before the novel MPEG-2 algorithm. deblock4.Deblock4 -
the MPEG-2 filter - is the project's end goal. See README section 1.0 and the
verification/tiering decisions record section 8.

The two filters are DIFFERENT algorithms sharing one dispatch/backend
infrastructure, registered as two calls (not selected by a parameter). Each
filter is internally same-algorithm: its scalar/v2/v3 backends are equivalent
to its own scalar oracle (G7).

Four things distinguish the Deblock4 (MPEG-2) filter from HolyWu's filter. The
Classic filter, by contrast, deliberately REPRODUCES HolyWu (see D-CLASSIC-1 in
the decisions record):

1. **The block grid is a parameter (Deblock4 only).** HolyWu's filter is
   H.264-derived and hard-anchored to a 4-pixel grid at origin (0,0). MPEG-2
   uses 8x8 transforms, so on MPEG-2 material half of its candidate edges sit
   mid-block. Deblock4 takes explicit per-plane-class grid steps. (Classic keeps
   the fixed H.264 4-pixel grid.)
2. **Proper chroma filter (Deblock4 only).** HolyWu applies the luma filter to
   chroma planes. Deblock4 implements the gentler spec-correct chroma filter.
   Classic FAITHFULLY reproduces HolyWu's luma-on-chroma behaviour, because
   Classic's job is to be the known reference, not to improve it.
3. **AVX2 exists.** The reference offers C and SSE4.1 only; both Deblock4 and
   Classic add the v3/AVX2 tier.
4. **Correctness is provable, not assumed.** Each filter's canonical scalar
   implementation is its executable specification; every backend reproduces it
   with INTEGER exactness and FLOAT equivalence within the approved differential
   contract (G7) - not universal float byte-identity.

The project is deliberately small in scope compared to CNR3. Deblock4 is stateless and one-frame-in/one-frame-out: there is no cache, no reordering, no cross-frame state, and therefore none of the diagnostic apparatus that state demanded.

---

# Session bootstrap header

Every W3C session begins with a filled copy of this header. Nothing outside the listed package may be assumed present.

```text
Project:
    Deblock4

Charter:
    filename          this charter file (the prevailing version per 2.3a)
    internal version  as stated in this file's header

Controlling specification:
    filename          README_Deblock4_Design_Spec - HIGHEST COMMITTED VERSION
                      (v1_12 at this writing, or later)
    internal revision as stated in that file's header

Repository:
    https://github.com/hydra3333/vapoursynth-Deblock4

Branch:
    main

Base:
    confirmed with W3X (C-DELIV-01; no commit hash and no per-file base
    hashes - the base is the prevailing repository state W3X confirms, or
    the exact attached source tree W3X supplies, identified by content).
    (HISTORICAL NOTE: the pre-v1.28 template field here was "Starting
    commit: <commit hash>" with the v1.18 attached-tree alternative; both
    are superseded by the v1.27 base-identification rule.)

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
    If this scope MODIFIES an established pixel-producing or frame-construction
    path, acceptance is PER OUTPUT TYPE against the applicable ReleaseSafe
    scalar oracle (see G7 and Deblock4_Verification_And_Tiering_Decisions 20):
      INTEGER planes - byte-identical to the oracle (no tolerance);
      FLOAT planes   - same specified algorithm, exact structural results, and
                       within the approved magnitude and near-threshold
                       numeric-activation differential contract.
    A pure COPY/SHARE/PASSTHROUGH path (specified result = source unchanged)
    must be BYTE-IDENTICAL to the source for every format, integer and float
    alike, and must not mutate the source.
    ORACLE-CONSTRUCTION EXCEPTION: the FIRST bounded Stage 2C/2D scope that
    CONSTRUCTS a filter's ReleaseSafe scalar oracle is exempt from comparison
    against a pre-existing oracle (it creates that oracle). It is accepted
    against independently authored scalar obligations (arithmetic vectors,
    threshold tables, geometry, footprints, schedule, range/overflow proof,
    memory canaries, exceptional-value cases, the pinned external reference
    oracle where applicable) AND a deliberately loose whole-image SANITY gate
    (a corruption tripwire: bounded per-pixel change concentrated near block
    boundaries, no wholesale global change; method selected at Stage 2, nothing
    pinned now per A3). After that oracle is accepted, every subsequent
    pixel/frame/copy/ReleaseFast-scalar/v2/v3 scope must be differentially
    validated against it.

The session package contains:
    1. this completed header;
    2. Part 1 of this charter;
    3. the controlling README/specification;
    4. the active scope;
    5. all files the scope touches;
    6. any scope-specific test vectors or harness contract.
```

Revision matching, which replaces the SHA-256 pinning used in v1.1:

```text
Every controlling document is identified TWICE in the scope header:
    by filename, which carries the version;
    by the version string recorded INSIDE the document.

W3C verifies the two agree before beginning work, and stops if they do not.

Scope currency after a later controlling-document change is governed by
section 2.3b. Version strings are never edited in place without a rename.
```

What this does and does not catch, stated plainly so the residual risk is
understood rather than assumed away:

```text
CAUGHT  an old file attached under a new name
CAUGHT  a renamed file whose contents were never updated
CAUGHT  a scope pointing at a superseded revision

NOT CAUGHT  an in-place edit that does not change the version string

The uncaught case is accepted deliberately. It is a discipline risk under a
single coordinator, not a mechanism failure, and SHA-256 pinning proved to
cost more in circular-dependency maintenance than the residual risk warrants.
```

---

# Part 1 - THE CARD (pin at the top of every session)

> **Deblock4 non-negotiable invariants.** Violating any of these produces code that looks correct and fails later, usually at a stage far from the mistake. If a scope appears to require violating one, stop and escalate - do not resolve it locally.

## A. Correctness architecture

```text
A1  Each filter's canonical ReleaseSafe scalar implementation IS that filter's
    executable specification. Required relationship, per filter, for every
    supported format (revised v1.12; see G7):

        INTEGER:  ReleaseSafe scalar == ReleaseFast scalar
                                     == v2 == v3       (byte-exact)
        FLOAT:    ReleaseFast scalar, v2 and v3 implement the SAME specified
                  algorithm and satisfy the approved differential contract
                  against the ReleaseSafe scalar oracle (integer-exact
                  structural results; float magnitudes within the measured
                  tolerance).

    Byte-exact FLOAT identity across backends is NOT required; hardware
    accuracy differences are a feature, not a defect (legitimate backend
    evaluation differences, including any future EXPLICITLY APPROVED fused
    operation; note .strict means ordinary a*b+c is NOT auto-fused, so FMA is
    included in the v3 target but not relied upon; ordinary a*b+c is not
    result-changing contracted under .strict and no @mulAdd is currently
    required, so 1B.2 does not expect FMA emission).

A2  Batch width, alignment, stride, thread scheduling, and grouping must never
    alter the output WITHIN one selected backend. Backend selection may affect
    ONLY float final magnitudes in the approved tolerance regime, and the
    near-threshold numeric activation decision it controls; it must NOT affect
    geometry, bounds, schedule, lane mapping, tails, non-finite handling,
    dispatch, or any other structural result, which stay exact across backends.

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
    Contraction (including auto-fusing a*b+c into an FMA) is prevented by
    explicit @setFloatMode(.strict) at kernel scope (G8), NOT by excluding FMA
    from the target. FMA is part of the v3 level (G3) and remains available;
    under .strict the compiler will not fuse unless an explicit @mulAdd is
    used, which is not currently required. (Revised v1.11: earlier charters
    excluded FMA from the AVX2 target; that exclusion is dropped in favour of
    full declared tiers plus .strict.)

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

    TWO RECORDS (ratified at Stage 1B.3): the ACTUAL record is process-wide,
    detected once, immutable - the hardware/OS truth, never modified by any
    seam. The EFFECTIVE record is computed once per instance at creation -
    actual INTERSECTED with any debug force-down ceiling (G10) - and is
    immutable for that instance; with no seam it equals actual. Dispatch
    consumes EFFECTIVE; diagnostics may report both, distinctly labelled.

    The requested backend is resolved once PER FILTER INSTANCE at filter
    creation:
        "auto"                 -> highest level the CPU fully satisfies
        "x86_64_v3_with_avx2"  -> the full v3 level, or creation error
        "x86_64_v2_with_sse41" -> the full v2 level, or creation error
        "x86_64_v1_baseline"   -> the baseline v1 level (scalar)
    (whole-level dispatch: each named level requires the ENTIRE level; a CPU
    missing any feature of a level falls back to the next lower level.)

    Each instance stores an immutable function table or selected entry
    points. Frame processing performs no capability test and no backend
    selection. A function-pointer call in the hot path is fine; a
    feature-test branch or backend-choice branch is not.

G2  Generic, dispatch, and CAPABILITY-DETECTION code must contain NOTHING
    ABOVE THE v1 BASELINE - no v2 and no v3 instructions (tightened v1.18 to
    match 3.2 and the Stage 1B.3 proof; previously stated only for AVX2).
    Only a level's own object may assume that level's instructions. Dispatch
    and detection cannot require the features they are detecting; detection
    is proven v1-only by standalone-object disassembly inspection.

G3  Backends are compiled for NAMED x86-64 psABI microarchitecture LEVELS,
    used in full with no identity-driven feature exclusions (revised v1.11;
    see Part 7 and Deblock4_Verification_And_Tiering_Decisions):

        scalar/generic  -> x86_64_v1  (baseline: CMOV, CX8, FPU, FXSR, MMX,
                                       OSFXSR, SCE, SSE, SSE2)
        SSE4.1 backend  -> x86_64_v2  (adds SSE3, SSSE3, SSE4.1, SSE4.2,
                                       POPCNT, CMPXCHG16B, LAHF-SAHF)
        AVX2 backend    -> x86_64_v3  (adds AVX, AVX2, BMI1, BMI2, F16C,
                                       FMA, LZCNT, MOVBE, OSXSAVE)

    NAMED-LEVEL MEMBERSHIP vs RUNTIME SAFETY are two distinct things and the
    prose must not conflate them: OSXSAVE is a MEMBER of the v3 level under the
    psABI definition (so it is part of the level contract), AND at runtime the
    AVX/YMM path additionally requires executing XGETBV and confirming XCR0
    XMM+YMM state. A level-membership list names OSXSAVE; a runtime guard checks
    OSXSAVE plus XCR0. Do not silently substitute XSAVE for OSXSAVE.

    These parenthetical lists are a READING AID and are NOT the authoritative
    definition. The AUTHORITATIVE per-level feature set is the x86-64 psABI
    microarchitecture-level standard, and the implementation must derive both
    the compile TARGET and the runtime DETECTION from ONE mechanism that encodes
    that standard so target and detection cannot drift. THE RATIFIED MECHANISM
    (Stage 1B.3, recorded v1.18): compile targets use Zig's named CPU models
    (std.Target.x86.cpu.x86_64/_v2/_v3); runtime detection necessarily reads
    real CPUID/XGETBV (locations are Intel SDM facts that do not exist in the
    compiler model), so the detection unit carries a COMPTIME assertion that its
    per-level MEMBERSHIP sets exactly equal the feature-set differences of those
    same named models, through an explicit name-mapping table and a W3X-approved
    exclusion list (OS-state policy rows and compiler tuning properties,
    reviewed, never silently grown). Any mismatch is @compileError - the build
    FAILS for human reconciliation; a toolchain upgrade can change the models
    only loudly, never silently. Because dispatch is WHOLE-LEVEL, an incomplete
    hand-copied list must never become the detection contract - the mechanism
    is. See Deblock4_Verification_And_Tiering_Decisions 4.1/4.6.

    The level IS the tier's feature contract - a published standard, not a
    bespoke per-build closure. FMA is PART of the v3 level and is NOT excluded;
    under strict float semantics (G8) the compiler will not auto-fuse, so FMA
    is included in the v3 target but is not relied upon: ordinary a*b+c must
    not be result-changing contracted under .strict, and no @mulAdd is currently
    required, so 1B.2 must not expect FMA emission (a later explicit decision
    could introduce fused semantics). The v3
    level's additional integer instructions compute identical integer results,
    so integer exactness (G7) is unaffected.

    WHOLE-LEVEL dispatch. Dispatch checks that the CPU satisfies the ENTIRE
    level, never the headline instruction. Selection tests v3, then v2, then
    v1, and uses the highest FULLY-satisfied level, falling back down the
    chain; v1 always succeeds. A CPU exposing AVX2 but failing any other v3
    requirement is NOT v3 - running the v3 backend on it would fault - so
    dispatch selects the highest LOWER level it fully satisfies (normally v2,
    otherwise v1). A public
    backend token and its detected feature set name the same level contract.

    Stage 1B.2 CONFIRMS each compiled object stays WITHIN its declared level
    and RECORDS the complete level and OS-state requirements that Stage 1B.3
    must enforce; it does not derive a bespoke closure, and it does not check a
    runtime guard (that guard is a Stage 1B.3 artifact). Stage 1B.3 implements
    and proves that guard. If any object emits an instruction outside its level,
    stop.

G4  Deblock4 is stateless and 1-in/1-out. No shared mutable state beyond
    immutable configuration. All scratch is per-call, never per-instance.

G5  A backend's instructions are never EXECUTED on a machine not yet proven
    to support them.

    Compiling and LINKING a backend object into the DLL is safe by itself:
    an object's mere presence executes nothing.

    Calling into a backend object is permitted only after the immutable
    capability record required by G1 exists and has confirmed the complete
    feature contract required by that object, or after an equivalent explicit
    in-process guard has been proved for the active scope. For AVX2 the
    confirmed contract includes the required CPU AVX and AVX2 features,
    OSXSAVE, and XCR0 XMM+YMM state. The guard must execute and pass before
    control can enter the target-specific function.

    NO BYPASS. There is no manual, command-line, environment-variable, build-
    flag, or "this machine is known to support it" route that permits calling
    target-specific code without the guard having run and passed. An informal
    assumption about the build or host machine is not a guard.

    UNGUARDED EXECUTION PATHS ARE EXECUTION. Presence in the DLL is safe only
    if NO unguarded path can reach target-specific instructions. That includes,
    and is not limited to, static initialisers, registration paths, import
    thunks, and test calls. An AVX2 object may sit in the DLL before capability
    detection exists ONLY if none of these can run its instructions first. A
    static initialiser inside an AVX2 object runs at DLL load, before any
    capability check, and is therefore forbidden from containing gated code.

    Consequence for early scopes: a backend-isolation or linkage proof verifies
    a target-specific object by its presence, symbols, object isolation, and
    successful linkage - not by invoking its code. Backend-identity probing
    that requires executing SSE4.1 or AVX2 instructions waits until a proven
    capability guard protects the call. Generic and scalar probes may be
    called because they assume no gated feature.

    During Stage 1 spikes, before the production capability detector exists, a
    test-local guard is acceptable. On an unsupported or indeterminate host the
    test reports SKIP and does not call the target-specific entry point. SKIP
    is a correct outcome, not a failure; a fault or a silent pass is not.

    This prevents an illegal-instruction fault when a target-specific probe
    runs on a machine that lacks its required features. It also prevents a
    probe that happens to run on a capable machine from being mistaken for
    proof that the guarded path is correct on an incapable machine.
```

```text
G6  SAFETY PROPERTIES REST ON EXPLICIT OR STRUCTURAL MECHANISMS, NEVER ON
    IMPLICIT TOOLCHAIN BEHAVIOUR.

    A safety property (G2, G3, G5, or any later one) must be established by a
    mechanism that is explicitly requested and documented, or that holds
    structurally by construction - not by the ABSENCE of an unrequested
    toolchain behaviour. Implicit behaviour is an undocumented contract: a
    toolchain release may change it silently, breaking the safety property
    with no signal.

    Preference order when choosing a mechanism:

    1. STRUCTURAL: the unsafe state is inexpressible by construction.
       Example: a target-specific function that is never declared exportable
       cannot appear in the PE export table; there is no export-candidacy to
       depend on. (COFF/PE is safe-by-default here: no symbol enters the
       export table unless positively declared via export keyword, .def
       EXPORTS, or /EXPORT. Retention without export is achievable by
       reference-graph anchoring - an explicit address reference from guarded
       dispatch code - or by an explicit /INCLUDE-class retention directive,
       neither of which adds an export.)

    2. EXPLICIT DECLARATION: the safe set is positively stated.
       Example: an explicit export allowlist (.def) so that exactly the named
       symbols are public and everything else is provably absent, by request
       rather than by default.

    3. GUARDED RESIDUAL: where a residual dependency on toolchain behaviour
       is genuinely unavoidable, it must be continuously verified by a
       loud-failing gate in the standing validation (not a one-time
       inspection), so a toolchain change can never alter the behaviour
       silently. The gate names the exact property it checks and fails the
       run, not just a report line.

    A scope that establishes a safety property states which tier its
    mechanism sits in. Tier 3 requires the standing gate to be delivered in
    the same scope as the mechanism it guards.

    Corollary for gated backend code (revised v1.10 after empirical
    falsification of the v1.9 form; see Part 7 and the toolchain findings
    document, F1/F2/F4/F5):

    THE BAN IS ON PE-EXPORT, NOT ON THE export KEYWORD.

    Three properties are separately controlled and must not be conflated:

```text
        EMISSION   code exists in an object. Decided PER COMPILATION UNIT:
                   the semantic root must be in that unit's own graph
                   (export fn, or an in-graph reference). A reference from a
                   DIFFERENT compilation does NOT force emission.

        LINKAGE    a symbol is visible to the linker for cross-object
                   reference. In Zig this is export/@export on the definition
                   side and extern/@extern on the reference side. There is no
                   other mechanism.

        PE EXPORT  a symbol appears in the DLL's .edata export table. This
                   requires a dllexport-class directive from the DLL
                   compilation itself. export in an OBJECT-mode compilation
                   grants emission and linkage but NOT PE-export candidacy.
```

    Therefore, for target-specific (gated) backend code:

```text
        - it is compiled as its own single-target object, where export fn is
          PERMITTED and is the mechanism that gives it emission and linkage;
        - it is NOT part of the DLL root compilation graph (which is what
          would make an export PE-export);
        - baseline code reaches it only by @extern + address-taken, stored in
          internal non-exported pointers, NEVER called before the capability
          guard (G5 unchanged);
        - it must NEVER appear in the PE export table. Where the toolchain
          offers an explicit export-list mechanism (a .def-class allowlist),
          use it (tier 2). Otherwise the absence rests on documented
          object-mode behaviour and MUST be enforced by a standing
          loud-failing dumpbin /EXPORTS gate (tier 3), delivered in the same
          scope.
```

    The v1.9 form of this corollary ("gated functions are NOT declared with
    the export keyword; absence from the export table is then structural")
    was falsified by build evidence: without export, Zig omits an unreferenced
    function entirely, so no retention mechanism can act on it; and export in
    an object-mode unit does not in fact create a PE export. The SAFETY GOAL
    is unchanged - no export-table doorway, nothing reachable before the
    guard. Only the mechanism claim is corrected to match the toolchain.
```

```text
G7  CROSS-BACKEND EQUIVALENCE IS SAME-ALGORITHM, SPLIT BY TYPE (added v1.11;
    see Deblock4_Verification_And_Tiering_Decisions).

    INTEGER paths produce BIT-IDENTICAL results across scalar, v2 and v3. A
    defined integer algorithm has one correct result; wider instructions
    compute the identical value, so exactness costs nothing and a tolerance
    there would only mask bugs. Integer output is exact and reproducible.

    FLOAT paths implement the SAME specified algorithm and must agree with the
    scalar oracle within a MEASURED, deterministic-per-backend tolerance.
    Legitimate backend evaluation differences (including any future
    EXPLICITLY APPROVED fused operation) are a FEATURE, not a defect. Under
    .strict, ordinary a*b+c is not result-changing contracted; FMA is included
    in the v3 target but not relied upon, and no @mulAdd is currently required,
    so 1B.2 must NOT expect FMA emission. A later explicit decision could
    introduce fused semantics. The tolerance is DERIVED analytically and then STRESS-TESTED
    against adversarial and real-footage corpora, never merely fitted to the
    largest difference observed in development.

    STRUCTURAL and edge results stay EXACT and loud even under float tolerance:
    lane mapping, saturation, widen/narrow, transpose/shuffle, tail handling,
    bounds, dispatch selection, plane selection, finite/non-finite masks, and
    the schedule/geometry. A final-magnitude tolerance must NEVER excuse a wrong
    lane, tail, bound, schedule, or structural mask.

    ONE thing is NOT a structural result and MAY differ for FLOAT paths only:
    the NUMERIC ACTIVATION DECISION (whether a computed float value falls below
    its threshold, i.e. filter-this-position-or-not), when the controlling value
    lies within the approved decision-boundary tolerance. Integer paths show
    ZERO activation differences. Tolerance therefore applies to final float
    magnitudes AND to that near-threshold numeric activation decision - never to
    any structural mask. (See Deblock4_Verification_And_Tiering_Decisions 3.4/3.5.)

    The ReleaseSafe scalar backend is the ground-truth oracle. The ReleaseFast
    production scalar backend is proven against that oracle before it is used
    as the reference for the SIMD comparisons.

G8  FLOAT KERNELS USE EXPLICIT .strict FLOAT MODE (added v1.11).

    Float kernels state @setFloatMode(.strict) explicitly at kernel scope.
    Production optimisation is ReleaseFast; .strict and ReleaseFast are
    INDEPENDENT controls, and ReleaseFast does NOT imply fast-math. .strict
    prevents result-changing reordering and auto-contraction (including fusing
    a*b+c into an FMA), keeping scalar-vs-SIMD differences to genuine rounding.
    There is NO @mulAdd requirement: not subtracting FMA is not requiring it.
    General fast-math (.optimized) is rejected as a default.

G9  THE SCALAR-VS-SIMD DIFFERENTIAL IS A STANDING GATE ACROSS TOOLCHAIN
    VERSIONS (added v1.11; the R76-class miscompile guard).

    Compiler code-generation defects (correct source, wrong machine code)
    cluster at EDGES and TAILS - exactly where a deblocker operates - and
    produce gross corruption, not rounding. Because the risk is toolchain-
    version dependent ("certain compilers"), the scalar-vs-SIMD differential
    test is a STANDING gate, re-run on EVERY Zig or LLVM version bump, not a
    one-time check. The test corpus MUST include non-vector-width-multiple
    dimensions with strong boundary edges (e.g. 711x480) to force the tail
    path. .strict (G8) is retained partly for this reason. This gate is the
    reason the relaxed float tolerance (G7) does not weaken defect detection:
    garbage vastly exceeds any tolerance band and is caught regardless.
```

```text
G10 DEBUG-ONLY CODE IS STRUCTURALLY ABSENT FROM PRODUCTION BINARIES, BY THE
    RATIFIED THREE-LAYER PATTERN (added v1.17; empirically ratified 2026-07-30
    by gate_pattern_test_v2; mechanics and evidence in
    Deblock4_Debug_Module_Inclusion_Pattern, v1.1 or later).

    SCOPE. This governs code whose EXISTENCE is conditional: test seams,
    debug-only diagnostics, and any code that must not exist in a production
    binary. It is distinct from Part 3.3's optional diagnostic BUILD MODES,
    which compile PRODUCTION code with different optimisation; a Debug-mode
    build of production code is not debug-only code.

    ENABLING. Debug-only code is enabled by an EXPLICIT opt-in build option,
    default OFF, never tied to optimize mode alone. Presence is a deliberate,
    visible choice in the build invocation. IN ADDITION (ratified at Stage
    1B.3), build.zig HARD-REJECTS any debug option set true with any optimize
    mode other than Debug: debug-only code is therefore structurally
    impossible in ReleaseSafe/ReleaseFast/ReleaseSmall by two independent
    mechanisms (the option default and the build-time rejection).

    THE THREE LAYERS, all required:

    1. GATED INCLUSION (primary, load-bearing). The debug module is included
       by a source-visible conditional declaration at the import site:

           const fd = if (build_options.enable_x)
               @import("x_debug.zig")
           else
               struct {};

       With the option off, the module is never analysed and never emitted
       (comptime exclusion, proven independent of optimize mode), and any
       stray reference in ungated code FAILS TO COMPILE against the empty
       struct. The condition lives in the source where a maintainer reads it,
       not hidden in the build script.

    2. GATED CONTENT (defence in depth). Uses are wrapped in the same
       comptime-known gate at each call site, and features INSIDE the debug
       module are individually gated too. This is redundant for omission only
       while layer 1 is intact; it is the proven fallback if a future edit
       imports the module unconditionally, and it makes each feature
       individually provable. Inner gates NEVER license an unconditional
       import - that reasoning is backwards and forbidden.

    3. PROVEN ABSENCE (per G6 tier 3). Production artifacts are proven clean
       by a standing loud-failing gate scanning THREE surfaces - raw binary
       strings, the PE export table, and disassembly - for seam-unique
       markers (a diagnostic string, an exported probe name where the test
       shape uses one, and a machine-code immediate). Absence is verified,
       never assumed. A pattern-level test ratifies the mechanism; each
       production scope still proves its own artifact.

    CAPABILITY SEAMS. A debug seam that affects capability or tier selection
    may only REDUCE (force-down by masking real capability - effective =
    actual INTERSECT ceiling, so a request at or above actual can only yield
    actual); it must be structurally unable to fabricate capability the CPU
    lacks. The seam offers NO value naming the top tier: a detection miss on
    known-capable hardware is a DETECTOR DEFECT TO FIX, never a case for
    forcing up. When active the seam announces loudly, reporting actual and
    effective distinctly; an invalid forcing input fails loudly at
    construction, never silently doing nothing. G5's no-bypass rule is
    unchanged: a debug seam is never a route around the guard.
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
| **W3D** | Designer / reviewer (continuity-bearing AI role; successor sessions are oriented by the current designer handover) | Specification authorship, design review, verification against source, harness design, scope authoring | Write production code |
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

I7  A CHANGE TO CRITERIA APPLIED TO THE PROPOSER'S OWN WORK REQUIRES AN
    INDEPENDENT VERIFIER.

    If any party proposes a change to acceptance, review, verification,
    proof, harness, delivery, or process criteria that will be used to judge,
    constrain, or accept that same party's work, the change must explicitly
    identify both:

        proposer:  the party that proposed the change;
        verifier:  a DIFFERENT party that independently checked it.

    Proposer and verifier must never be the same party. The change must not be
    silently absorbed into a charter, specification, scope, addendum, harness,
    review, delivery, or acceptance record. Normative adoption still requires
    W3X ratification or release wherever this charter otherwise requires it.
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

## 2.3a Version currency and paired or grouped documents - verify before relying

Document version numbers are usually part of the filename, and the highest
version number in the filename normally indicates the latest prevailing
version, which should be used - EXCEPT that a document W3X provides directly in
this session may be newer than anything yet committed, and takes precedence.
Verify the actual latest versions with W3X before relying on a number baked
into a file. If W3X indicates a newer ratified package exists, STOP and obtain
it from W3X, since the latest document may not yet have been committed to the
github project repository. On occasion documents are explicitly tied together as a version SET of two or
more - typically where a document header names its companion documents and
declares them a set that must be read together. For such a set: use the LATEST
filename version of EACH member (any member may bump independently as guidance
accrues), and read the members together as one authority. Where a declared set
is incomplete (a member missing) or internally inconsistent, STOP: do NOT rely
on a partial set; report it to W3X and seek direction. Never mix members from
different generations against a header that ties them to specific versions.

## 2.3b Scope currency against later controlling-document changes

A scope MUST be reissued when a later controlling-document change alters,
supersedes, contradicts, or materially qualifies anything the scope relies
on, quotes, requires, permits, forbids, or uses for acceptance.

A scope need NOT be reissued for an unrelated controlling-document change.
In that case: any party may flag the change; W3D assesses materiality and
recommends; W3X decides and records the compatibility decision in one line
in the Project Status document (for example: "scope vX / charter vY:
compatible, W3X <date>"). The session package then uses the newer
controlling document together with that recorded decision.

Where materiality is uncertain, disputed, or cannot be established by
inspection, STOP and reissue the scope.

## 2.4 Harness ownership

```text
H-OWN  W3D owns the independent acceptance and differential-correctness
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

Rationale, carried over from CNR3: an implementer writing their own acceptance tests tests what they built, not what was specified. For a project whose central claim is per-filter backend equivalence (integer-exact, float within the differential contract), that failure mode is fatal and silent.

The independent differential correctness harness is the single most important artifact in this project after the scalar reference.

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

Tiers are the NAMED x86-64 psABI microarchitecture levels, used IN FULL, per G3
(revised v1.12; the earlier "smallest tested feature closure" / "FMA excluded"
policy is superseded):

```text
x86_64_v1_baseline  plugin entry, registration, CPU/OS capability detection,
    scalar path. Baseline SSE/SSE2. Every 64-bit CPU.

x86_64_v2_with_sse41  the full v2 level (SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT,
    CMPXCHG16B, LAHF-SAHF). The SSE4.1-class backend.

x86_64_v3_with_avx2   the full v3 level (AVX, AVX2, BMI1, BMI2, F16C, FMA,
    LZCNT, MOVBE, OSXSAVE). The AVX2-class backend. FMA is PART of the level and
    is NOT excluded; .strict (G8) prevents contraction. OSXSAVE is a level member;
    the runtime AVX/YMM guard additionally executes XGETBV and checks XCR0.
```

The level IS the feature contract. Stage 1B.2 CONFIRMS each object stays WITHIN
its level (emits nothing outside it) rather than deriving a bespoke closure.
Runtime detection checks the ENTIRE level (whole-level dispatch, G3), plus the
required OSXSAVE and XCR0 XMM+YMM state for AVX/YMM use, and selects the highest
fully-satisfied level with v3->v2->v1 fallback. The public backend tokens are
exactly the level names above (plus "auto"); see the quick-reference API and the
verification/tiering decisions record section 4.5.1.

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
          where an invariant is being honoured. It is likely a human reader
          may not know zig, so explanation and clarity are essential. A
          reader six months later must be able to see that a loop bound is
          derived and not arbitrary.

C-STY-03  Name the invariant by its card reference at the ENFORCEMENT POINT,
          or at the narrow helper that centralises it, together with an
          assertion where one is possible.
              e.g. "// D4: never batch across orientations"
          Do not repeat the same invariant comment at every caller when one
          authoritative comment and assertion already protect the rule.

C-STY-04  Named constants, never magic numbers. This is not style preference
          here: B3 forbids literal radii and derived values outright.

C-STY-05  Explicit over clever. This code will be read by memoryless sessions
          and humans who may not or cannot infer intent from history.

C-STY-06  Public API names state their actual effect. Inherited names are not
          preserved for familiarity when they mislead.

C-STY-07  One module, one responsibility. Kernel modules contain arithmetic;
          drivers contain traversal; policy modules contain validation and
          preset expansion. Kernels do not read configuration.

C-STY-08  All debug output must go strictly to stderr and be flushed
          immediately.

C-STY-09  SHARED CONFIG AND PRINTING HAVE SINGLE HOMES; EXTEND, DO NOT FORK
          (ratified at Stage 1B.3 scope time; recorded v1.18).

          deblock4_config.zig is the declarations-ONLY switchboard (flags,
          names, constants in shallow namespaces; no functions; it NAMES debug
          gates but contains no gated bodies and is itself production code).
          print_helper_functions.zig is the only home for shared always-on
          printing. print_diag_helper_functions.zig and force_down_debug.zig
          are the gated debug homes (G10; separate modules, separate gates, no
          import between them). Later stages EXTEND these modules; feature
          code must not grow bespoke config constants or print routines
          elsewhere. Skeleton fully, content minimally, extend-do-not-fork.

C-STY-10  PERMANENT NAMES, ONE-WAY DEPENDENCY, AND THE SWEEP TEST
          (ratified at Stage 1B.3 scope time; recorded v1.18).

          First-class files, symbols, and artifacts carry PERMANENT names: no
          stage numbers, no probe/smoke vocabulary. Stage-numbered and
          probe/smoke vocabulary is reserved for disposable scaffolding
          (probe files, smoke tests, stage validation batches).

          DEPENDENCY DIRECTION IS ONE-WAY: scaffolding MAY import and call
          first-class modules; first-class modules must NEVER import,
          reference, or name any scaffolding file, symbol, marker, or
          artifact. Shared functions never reside in scaffolding files.

          THE SWEEP TEST: deleting every scaffolding file (planned for the
          filter-creation stage, in one deliberate sweep) must require ZERO
          edits to first-class modules. A textual audit of first-class files
          for scaffolding identifiers must return EMPTY and is a delivery
          obligation for any scope that adds first-class modules.

```

## 4.1 Zig/C interop and memory-transfer policy

```text
C-INT-01  OWNERSHIP IS EXPLICIT AT EVERY LANGUAGE BOUNDARY.

          Every pointer, slice, C string, and allocation crossing a Zig/C
          boundary has exactly one documented ownership class:

              borrowed;
              caller-owned;
              callee-owned;
              copied by the callee.

          The interface states who may free it and the exact event that ends
          its valid lifetime. Ownership must never be inferred merely from a
          pointer or slice type.

C-INT-02  MIXED OWNERSHIP MUST NOT SHARE AN UNTAGGED RETURN CONTRACT.

          A function must not return newly allocated storage on one path and
          static or borrowed storage on another path through the same
          untagged result type.

          An allocating helper returns either:

              success containing caller-owned storage;
              or an error containing no storage.

          Allocation failure is handled by the caller in a separate, visibly
          non-owning branch. A static fallback string is never returned as
          though it were an allocation and is never freed.

C-INT-03  FORMATTED C-STRING LIFETIME IS PROVEN, NOT ASSUMED.

          A helper that allocates a formatted, zero-terminated C string:

              has a name that exposes allocation and termination ownership,
                  for example allocPrintZ;
              returns an error union;
              returns only owned storage on success;
              never catches allocation failure by returning a string literal.

          Before passing allocated storage to an external API, verify from
          pinned documentation, headers, or source whether the callee copies,
          retains, takes ownership of, or merely borrows the data.

          Where the callee copies the data, free the allocation immediately
          after the call. Where the lifetime contract is not proven, stop and
          verify it. Do not leak memory by assumption and do not free memory
          by guess.

          "Required by C interop" is not accepted as evidence that a leak is
          unavoidable.

C-INT-04  COMPATIBILITY-WRAPPER NAMES PRESERVE EXTERNAL CORRESPONDENCE.

          Where an external C helper requires a Zig-facing compatibility
          wrapper, preserve the original external symbol spelling after a
          zig_ prefix:

              vsh_areValidDimensions
                  ->
              zig_vsh_areValidDimensions

          The zig_ prefix means "Zig-facing compatibility wrapper"; it does
          not claim that the Zig compiler generated the function.

          Functions that add Deblock4 policy, validation, composition, or
          testing use the deblock4_ prefix instead.

          Wrapper comments identify the original external function and state
          that the wrapper is project-authored compatibility code.

C-MEM-01  FRAME CONSTRUCTION CONSIDERS SHARING BEFORE COPYING.

          The frame-construction scope explicitly considers each applicable
          implementation option rather than assuming a whole-plane copy:

              host-supported sharing or reuse of an unmodified source plane;
              exact active-row copying into newly allocated storage;
              another API-supported construction proven to preserve identity
                  and lifetime safety.

          The output requirement is byte identity for every unmodified plane.
          Plane sharing is a preferred option where the VapourSynth API and
          lifetime contract prove it safe; it is not itself an output-defining
          invariant.

          Where copying is selected:

              copy only active row bytes;
              honour source and destination strides independently;
              use memcpy only where non-overlap is proven;
              use memmove where overlap is permitted or possible;
              preserve required frame properties separately.

          Scalar, SSE4.1, and AVX2-specific copy implementations remain valid options
          where there is a credible engineering basis for expecting a useful benefit,
          including reduced frame-construction cost, better integration with an existing
          backend, or simpler combined copy-and-processing traversal.
          No prior demonstration that a generic copy path is a bottleneck is required
          before such an option is considered, implemented, or selected for evaluation.
          Though at face value, SIMD effort may appear to be most beneficial located in the
          deblocking arithmetic kernels.

          Any specialised copy implementation must preserve the same bounds, overlap,
          stride, identity, and lifetime contract as the canonical copy path. Where
          practical, its benefit and maintenance cost are measured against the simpler
          alternative before final release retention. Absence of a large measured gain
          is evidence to consider, not an automatic prohibition.
```

## 4.2 Numeric and SIMD helper policy

```text
C-NUM-01  GENERIC NUMERIC HELPERS MUST NOT CONCEAL NUMERIC POLICY.

          A generic numeric helper must not hide, weaken, or silently choose
          any range, signedness, overflow, saturation, accumulator-width,
          rounding, conversion, non-finite, or scalar/vector contract.

          Its accepted types, preconditions, intermediate widths, exact result
          rule, and failure behaviour are explicit at the helper or its single
          authoritative enforcement point.

          Where scalar and vector forms share a helper, every scalar
          precondition remains true and is enforced for every vector lane.
          Removal of runtime checks in ReleaseFast never substitutes for the
          required arithmetic and bounds proof.

C-SIMD-01  VECTOR SYNTAX IS NOT SIMD PROOF.

          Use of @Vector, @select, inline loops, array/vector coercions, or a
          function named load, store, gather, fast, or SIMD does not prove the
          generated instruction sequence or its efficiency.

          Every production backend's material load, store, arithmetic,
          masking, gather, shuffle, and tail strategy is compiled under its
          exact target feature closure and inspected where code generation is
          load-bearing. Operations may scalarise, split across narrower
          instructions, or lower differently between build modes or Zig
          versions.

C-SIMD-02  VECTOR WIDTH IS AN EXPLICIT BACKEND CONTRACT.

          std.simd.suggestVectorLength may inform a Stage 1 experiment but does
          not become production policy by itself.

          Production vector widths and lane organisation are selected
          explicitly per backend, sample type, and operation after compilation
          and relevant assembly inspection. Batch width remains output-invisible
          under A2.

C-SIMD-03  MEMORY UNITS AND ALIGNMENT ARE EXPLICIT AND PROVEN.

          VapourSynth frame strides are byte counts. Any conversion to a typed
          sample stride is checked once and names both units explicitly.

          The default memory path accepts the alignment actually guaranteed by
          the host API and constructed plane view. A stronger @alignCast or
          aligned-load/store assumption requires proof for:

              frame and plane base alignment;
              stride preservation;
              sample type and size;
              every processed offset;
              every affected traversal and tail.

          An alignment cast is an assertion, not an optimisation hint.

C-SIMD-04  FAST FLOAT HELPERS MUST BE SEMANTICALLY IDENTICAL.

          A comparison-and-select replacement for @min, @max, clamp, absolute
          difference, conversion, or another floating operation is forbidden
          unless its behaviour is proved identical to the canonical scalar rule
          for:

              every finite operand order;
              NaN and positive or negative infinity;
              positive and negative zero;
              exact result bits;
              every supported scalar and vector form.

          A shorter or faster-looking instruction sequence is not equivalent
          merely because ordinary finite test values produce the same numeric
          result.

C-SIMD-05  GATHER IS A SEMANTIC DESCRIPTION, NOT A CODEGEN CLAIM.

          Lane-by-lane indexed loads may be explored where the Deblock4
          schedule permits independent work, but they are not treated as a
          hardware gather operation without assembly evidence.

          Hardware gather, scalar-load-and-pack, shuffle, transpose, and
          alternative traversal strategies remain candidates until compiled,
          measured where relevant, and proved against the same bounds,
          dependency, tail, and identity contract.
```

## 4.3 Delivery protocol

The delivery unit is one bounded coding scope, but the delivery format is
selected independently for each changed file. A single scope may therefore
contain a whole new file, a patch for one existing file, and a whole-file
replacement for another existing file.

```text
C-DELIV-01  EVERY DELIVERY IDENTIFIES ITS EXACT BASE AND SCOPE.

            Before presenting code, W3C states:

                scope identifier and one-sentence objective;
                repository and branch;
                base identification, CONFIRMED WITH W3X (see below);
                permitted changed files;
                forbidden changed files;
                delivery format selected for each changed file;
                required build and test commands;
                expected pass, fail, or skip result for each command.

            BASE IDENTIFICATION (ratified v1.27, replacing the earlier
            exact-starting-commit requirement). There is no commit-hash base
            requirement. W3X GUARANTEES that the local repository IS the base
            at patching time; the base is therefore the prevailing repository
            state as CONFIRMED WITH W3X at delivery time. W3C does not infer
            the base from an earlier conversation, from the status document,
            or from a recorded commit hash or per-file base hash. If W3X
            supplies an attached source tree as the base, that tree IS the
            base, identified by content; if W3C is unsure it holds the current
            base, it asks W3X to confirm or re-supply rather than inferring.

            A delivery whose base W3X has not confirmed is provisional and is
            not applied.

C-DELIV-02  DELIVERY FORMAT IS CHOSEN PER FILE STATE.

            NEW OR GREENFIELD FILE:
                deliver the complete file;
                there is no prior file against which a useful patch can anchor.

            EXISTING FILE, SMALL LOCALISED CHANGE:
                deliver a unified-diff patch;
                use this when the change is concentrated in one or a few nearby
                regions and the patch is easier to review than replacement.

            EXISTING FILE, LARGE OR DISPERSED CHANGE:
                deliver the complete replacement file;
                use this when the change touches roughly more than 30 percent
                of the file, restructures it substantially, or changes several
                separate regions such that a patch becomes harder to audit than
                the resulting file.

            The 30 percent value is a reviewability guide, not a target to game.
            W3C chooses the format that makes omissions, accidental deletions,
            and unintended movement easiest for W3X to detect.

            Do not deliver both a patch and a replacement for the same file in
            one revision. If a delivery format changes after review, issue a
            clearly named replacement revision and withdraw the earlier form.

C-DELIV-03  PATCHES REQUIRE ANCHOR VERIFICATION BEFORE APPLICATION.

            Every patch states the base as CONFIRMED WITH W3X (C-DELIV-01)
            or, for a separately
            versioned non-repository input, the exact filename and internal
            version against which it was prepared.

            Every hunk includes enough unchanged surrounding context to make
            its target unambiguous to both W3X and a memoryless successor. The
            delivery also quotes the principal existing anchor text outside the
            patch when the location or overload could otherwise be confused.

            Before applying a patch, W3X confirms:

                the repository is on the stated branch and is the
                confirmed base (C-DELIV-01);
                the quoted anchor exists exactly once where uniqueness matters;
                git apply --check succeeds;
                git apply --check --whitespace=error succeeds.

            A patch that fails base confirmation, anchor verification, or
            either apply check is NOT edited by hand to make it fit. Stop,
            report the mismatch, and request a replacement patch or whole file
            prepared against the actual source.

C-DELIV-04  WHOLE-FILE DELIVERIES ARE COMPLETE AND PATH-EXPLICIT.

            A whole-file delivery states:

                repository-relative destination path;
                whether the file is new or replaces an existing file;
                the confirmed base (C-DELIV-01) for an existing-file
                replacement;
                language and expected line ending;
                any build.zig registration or companion-file dependency.

            The delivered file contains the complete intended bytes. It has no
            omitted middle, ellipsis, "unchanged below", or instruction to copy
            fragments from an earlier answer.

            Existing-file replacement is not permission for unrelated cleanup.
            W3C still preserves names, comments, layout, and behaviour outside
            the bounded scope unless the scope explicitly authorises change.

C-DELIV-05  THE DELIVERY MANIFEST MAKES APPLICATION MECHANICAL.

            Each delivery begins with a compact manifest containing:

                Adds or changes:
                    exact purpose of the scope;

                Defers or does not change:
                    nearby work that remains deliberately out of scope;

                Files:
                    path, state, and delivery form for every file;

                Apply sequence:
                    exact W3X commands or save/replace actions;

                Validation:
                    exact commands, modes, executables, and expected results;

                Review notes:
                    the principal invariant enforcement points and any known
                    measurement gate not closed by this scope.

            Patch files use a scope-derived name such as:

                S1B1_backend_object_isolation_v1.patch

            Replacement revisions use _v2, _v3, and so on. Do not silently
            overwrite an earlier review artifact while it may still be in use.

C-DELIV-06  DEBLOCK4 TOOL AND LANGUAGE ASSUMPTIONS ARE EXPLICIT.

            The pinned language and primary build tool are:

                Zig 0.16.0;
                zig build through the repository's build.zig;
                Windows x86_64 target;
                VS Code plus matching ZLS as the coordinator's editor setup.

            Required build modes are named exactly when applicable:

                Debug;
                ReleaseSafe;
                ReleaseFast.

            Typical command forms are:

                zig build -Doptimize=Debug
                zig build -Doptimize=ReleaseSafe
                zig build -Doptimize=ReleaseFast

            The active scope must name the actual repository steps as well,
            such as check, test, a probe executable, or another build.zig step.
            Example command forms do not substitute for scope-specific commands.

            VapourSynth4.h and VSConstants4.h are translated into Zig.
            VSHelper4.h is compiled as C and exposed through the established
            narrow C-ABI bridge. A delivery must not replace that arrangement
            with direct translation unless a separately ratified scope proves
            the ReleaseSafe failure has been eliminated under the pinned tools.

            Every delivered source, patch, command file, diagnostic, comment,
            and document is US-ASCII. LINE ENDINGS (ratified v1.19, replacing
            the earlier LF default): every REPOSITORY text file is CRLF. This
            is a Windows-only project; cmd.exe requires CRLF batch files for
            reliable label/goto/call scanning; the committed repository
            practice is CRLF; and one uniform rule with no per-file judgement
            is mechanically checkable (C-STY-01 spirit). The repository git
            configuration is pinned to core.autocrlf=false and
            core.whitespace=cr-at-eol so the mandatory
            `git apply --check --whitespace=error` and `git diff --check`
            gates pass over CRLF content legitimately - never bypass the
            gates with nowarn. Exception: an existing SCAFFOLDING file that is
            LF today keeps its endings until the filter-creation-stage sweep
            deletes it (C-STY-10) - converting a doomed file is churn.
            Delivery-transport artifacts that never enter the repository
            (reports, manifests, validation logs) may be LF. When charter
            text and established repository practice appear to conflict, the
            coder states the conflict and stops rather than silently picking
            a side.

C-DELIV-07  W3X BUILDS, RUNS, AND REPORTS; W3C DOES NOT CLAIM EXECUTION.

            W3C may inspect and validate an artifact in its available sandbox,
            but only W3X's local repository results establish project PASS.

            W3X applies or saves the delivery, then reports back for every
            required command:

                exact command;
                build mode;
                process exit code;
                concise pass/fail/skip summary;
                first failure and relevant surrounding output if not PASS;
                git status --short after validation.

            For code-generation or feature-closure scopes, W3X also supplies
            the requested emitted assembly, object inspection, or instruction
            listing. "It built" does not close an assembly obligation.

            W3C reviews the actual report before recommending PASS or a commit.
            W3X alone commits and pushes.

C-DELIV-08  MINIMUM APPLY AND VALIDATION DISCIPLINE.

            PATCH DELIVERY, from repository root:

                git status --short
                git apply --check <scope>.patch
                git apply --check --whitespace=error <scope>.patch
                git apply <scope>.patch
                git diff --check
                git status --short

            WHOLE-FILE DELIVERY:

                confirm branch and base with W3X (C-DELIV-01);
                save the complete file at the stated repository-relative path;
                confirm the path and file state with git status --short;
                inspect git diff -- <path> for an existing-file replacement;
                run git diff --check.

            Then run every scope-specific Debug, ReleaseSafe, ReleaseFast, test,
            smoke, and inspection command in the stated order.

            A delivery is not accepted merely because it parses or compiles.
            Acceptance requires the bounded scope's stated runtime, identity,
            safety, and inspection evidence.

C-DELIV-09  INCREMENTAL EMISSION FOR INTERRUPT-SAFETY AND REVIEW CONTINUITY.

            When a scope or phase is large enough that withholding all output
            creates a material interruption or review-continuity risk - normally
            multiple modules or more than a few files - W3C EMITS complete
            modules or small coherent groups as they are finished rather than
            waiting for one final package. Each increment carries a one-line
            marker of the form "increment N of ~M: <what>"; ~M is an estimate
            and may be revised as the bounded work becomes clearer.

            Each increment is a COMPLETE, self-identifying recovery and review
            artifact against the stated base. It need not be independently
            applyable or accepted unless W3C explicitly says so.

            PURPOSE AND HONEST LIMIT: emitted increments provide a recoverable
            baseline if the session is interrupted and running review
            checkpoints for W3X. ONLY EMITTED ARTIFACTS SURVIVE an interruption.
            W3C must NOT claim to preserve, checkpoint, or resume un-emitted
            internal reasoning, partial work, or integration changes. The
            recoverable state is exactly the last complete emitted increment or
            set of increments. The current incomplete increment and any later
            un-emitted integration, reconciliation, validation, or revision work
            may be lost. Earlier increments may be superseded by later
            integration and are not the final delivery of record.

            THE FINAL DELIVERABLE IS UNCHANGED. Incremental emission is for
            continuity, interrupt-safety, and review only; it does NOT replace
            the properly packaged final deliverable. At the end of the scope or
            phase, W3C rebuilds and re-packages the complete integrated work
            against the authoritative base as one final deliverable meeting
            C-DELIV-01..08 in full. The final result is validated as a whole;
            merely concatenating increments is not proof of integration. The
            packaged final deliverable is the artifact of record that W3X
            applies unless W3X explicitly directs otherwise.

            This rule is restated verbatim in the header of every scope and
            every delivery-plan addendum ISSUED HENCEFORTH, using the current
            Deblock4_Scope_Header_CDELIV09_Reminder_Block (latest version per
            section 2.3a). The charter governs on any difference.

C-DELIV-10  REPOSITORY-OPERATION AND GIT DISCIPLINE.

            No delivery or validation machinery performs a repository state
            change. FORBIDDEN in any machinery: git stash; automatic staging
            or committing; and any proof, audit, or apply machinery whose
            CORRECTNESS depends on a particular local git index, staging, or
            HEAD state. PERMITTED: non-destructive git reads (for example
            git diff --check, git status, git ls-files) and W3X-MANUAL git
            workflows (for example git apply, and the manual per-file backout
            block a delivery provides). Git STAGING is never used in this
            process. COMMIT is a manual W3X act performed only after W3D
            review and W3X acceptance; no AI output and no delivery script
            commits, stages, or otherwise mutates repository state.

C-DELIV-11  DELIVERIES SHIP NO EXECUTING REPOSITORY MACHINERY.

            A delivery ships NO PowerShell machinery and NO script that
            performs a repository operation. APPLICATION is a manual W3X act:
            either copying the contents of an apply_to_tree/ mirror over the
            repository, or a W3X-manual git apply. BACKOUT is a manual W3X
            act the delivery PROVIDES (never executes): a per-file command
            block, and/or a restore_to_base/ folder of pre-change copies W3X
            may hand-copy back. The one permitted script kind is a plain-CMD
            driver for an EXTERNAL reference build (for example the HolyWu
            reference .cmd with certutil hash guards), which touches no
            repository state. A batch's pre-existing, already-reviewed inline
            scripting and its calls to resident prior-stage audit scripts are
            retained, not rewritten.
```

### 4.3.1 Worked example - small existing-file patch

This example is illustrative. Its commit and code are not an instruction to
modify the current repository.

```text
Scope:
    EXAMPLE-SMALL-PATCH - name an existing DLL marker constant.

Base:
    repository  https://github.com/hydra3333/vapoursynth-Deblock4
    branch      main
    commit      0123456  (illustrative only)

File:
    src/dll_probe.zig
    state       existing
    delivery    unified-diff patch

Why patch:
    one localised function changes; substantially less than 30 percent of the
    file; the existing export is a unique anchor.

Anchor that must exist before application:
    pub export fn deblock4_dll_probe_marker() callconv(.c) u32 {
        return 0x44423401;
    }
```

```diff
diff --git a/src/dll_probe.zig b/src/dll_probe.zig
--- a/src/dll_probe.zig
+++ b/src/dll_probe.zig
@@ -1,5 +1,7 @@
+const dll_probe_marker: u32 = 0x44423401;
+
 pub export fn deblock4_dll_probe_marker() callconv(.c) u32 {
-    return 0x44423401;
+    return dll_probe_marker;
 }
```

The delivery manifest would then require W3X to run the patch checks, the three
stated build modes, the DLL smoke test, and `git diff --check`, and to report the
actual commands and results. If the quoted function differs or appears in an
unexpected location, the patch is not applied.

### 4.3.2 Worked example - new whole-file delivery

This example is illustrative. It demonstrates that a new file is delivered in
full even when another file in the same scope, such as `build.zig`, is delivered
as a patch.

```text
Scope:
    EXAMPLE-WHOLE-FILE - add a non-pixel scalar identity probe.

Base:
    repository  https://github.com/hydra3333/vapoursynth-Deblock4
    branch      main
    commit      0123456  (illustrative only)

File:
    src/scalar_identity_probe.zig
    state       new
    delivery    complete file
    language    Zig 0.16.0
    line ending LF

Why whole file:
    no previous file exists, so there is no safe or useful patch base.
```

Complete delivered file:

```zig
const std = @import("std");

pub const scalar_identity_marker: u32 = 0x5343414c;

pub export fn deblock4_scalar_identity_probe() callconv(.c) u32 {
    return scalar_identity_marker;
}

test "scalar identity marker is stable" {
    try std.testing.expectEqual(
        @as(u32, 0x5343414c),
        scalar_identity_marker,
    );
}
```

The manifest would identify any required `build.zig` registration separately;
because `build.zig` already exists, that localised registration would normally
be delivered as an anchor-verifiable patch. W3X saves the complete new file,
applies the separate patch, runs `git diff --check`, and executes every build
and test command named by the scope.

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

P-11  MATERIAL EXTERNAL IMPLEMENTATION INFLUENCE IS TRACEABLE.

      Before external code, an algorithmic formulation, a test vector, an
      interop technique, or a helper pattern is copied, adapted, or materially
      relied upon, record where reasonably feasible:

          a suitable common marker flagging external influence
          repository and upstream owner;
          applicable licence, if any;
          exact commit, tag, or release;
          file and relevant lines;
          disposition:
              copied;
              adapted;
              independently reimplemented;
              design inspiration only;
              reviewed and rejected.

      Source comments carry attribution where code is copied or adapted, or
      where the applicable licence requires it.

      Where an external implementation contains a defect or unsafe contract
      that Deblock4 deliberately does not adopt, record that rejection when it
      materially explains the replacement design.

      Material that was only reviewed for engineering lessons belongs in the
      relevant design, review, or provenance record rather than being credited
      inside unrelated production code.

      In regard to Deblock4 itself, we already know it is a complete redevelopment
      of Deblock and thus attribution belongs in the relevant design, review, or
      provenance record as well as in the github project README.md and also once at
      or near the top of the "main" code module, rather than being also credited
      inside of every code module.

P-12  EXTERNAL COMMON-UTILITY CODE IS NOT ADOPTED AS A SHORTCUT.

      External string, copy, numeric, vector, SIMD, memory, or other common
      helper modules are not copied, adapted, or adopted wholesale merely
      because they are reusable, concise, tested elsewhere, or written for
      Zig and VapourSynth.

      Each candidate function requires a fresh function-specific review that
      establishes, as applicable:

          a concrete Deblock4 need;
          the exact Zig and external-API version assumptions;
          ownership, lifetime, bounds, overlap, stride, and alignment safety;
          signedness, range, overflow, rounding, and non-finite semantics;
          scalar/vector integer exactness and float differential equivalence;
          exact target-feature and build-mode code generation;
          tail and dependency compatibility;
          tests and provenance required by this charter.

      Review, inspiration, or apparent similarity creates no presumption of
      adoption. When any of those obligations is unclear, the default
      disposition is "reviewed and rejected" until new evidence justifies
      reconsideration.

      The external common helpers reviewed during the v1.4 investigation are
      not approved for adaptation or adoption. Any future proposal to use one
      starts again under this rule rather than relying on the earlier review.
```

---

# Part 6 - Quick reference

## 6.1 Where things are decided

| Question | Answer lives in |
|---|---|
| What the algorithm does | `spec.zig` (executable) and the README |
| Whether output is correct | The independent differential correctness harness |
| Whether output looks good | The scalar quality gate and corpus |
| Whether it is fast | Benchmarks, after correctness |
| What a parameter means | README public API section |
| Whether something may be changed | This card |
| How debug-only code is included and proven absent | G10 and `Deblock4_Debug_Module_Inclusion_Pattern` |
| Where shared config and printing live | C-STY-09 (single homes; extend, do not fork) |
| Scaffolding vs first-class naming and cleanup | C-STY-10 (one-way dependency; the sweep test) |
| Changes to criteria applied to the proposer's own work | I7 (named proposer + different-party verifier; W3X ratifies normative adoption) |

## 6.2 The development stages

```text
1  Zig project / build / dispatch / tiering scaffold and spikes (SHARED,
   filter-agnostic; Stage 1B.2 confirms objects stay within their named level)

Per-filter algorithm stages run TWICE - Classic first, then Deblock4:
2C/2D  Canonical scalar core and proof harness
3C/3D  Scalar quality/compatibility decisions
       (Classic: HolyWu compatibility gate; Deblock4: Schedule A/B, midpoint
        scale, proper chroma)
4C/4D  v2 (SSE4.1-class) backend and differential proof
5C/5D  v3 (AVX2-class) backend and differential + performance proof

6  VapourSynth integration, validation matrix, docs, release (BOTH filters)
```

Classic (H.264, known algorithm) is built first to prove the shared
infrastructure and harness against an external reference oracle before the novel
Deblock4 MPEG-2 algorithm. See README section 20.

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

The plugin registers TWO filters. Full parameter definitions are in README
sections 3.14 (Deblock4) and 3.15 (Classic); summarised here:

deblock4.Deblock4 (MPEG-2 filter):

```text
grid_mode                    REQUIRED, no default
                             "mpeg2_progressive"
                             | "mpeg2_field_separated" | "custom"
                             | "auto" (reserved, currently rejected)
                             (grid_mode="h264" REMOVED - the H.264 grid use
                              case is owned by deblock4.Classic)

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

backend                      "auto" | "x86_64_v3_with_avx2"
                             | "x86_64_v2_with_sse41" | "x86_64_v1_baseline"

custom-mode primitives       luma_step_x, luma_step_y,
                             chroma_step_x, chroma_step_y,
                             luma_midpoint_enabled
                             accepted ONLY with grid_mode="custom"
```

deblock4.Classic (H.264 filter, faithful to HolyWu; fixed 4-pixel grid):

```text
strength                     as above (shared canonical tables)
boundary_strength_offset     as above
side_activity_offset         as above
planes                       default all
backend                      "auto" | "x86_64_v3_with_avx2"
                             | "x86_64_v2_with_sse41" | "x86_64_v1_baseline"

(NO grid_mode, NO midpoint_threshold_scale, NO custom steps - Classic has a
 fixed H.264 grid and reproduces HolyWu including luma-on-chroma.)
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

## v1.30 (2026-08-18) - W3C-found, W3D-drafted, W3X-directed 2026-08-18

CURRENCY CORRECTION ONLY. NO RULE CHANGES. NO INVARIANT CHANGES.

```text
finder:    W3C (successor orientation, 2026-08-18, question Q2)
drafter:   W3D at W3X's express direction
authority: W3X directed the fix; W3D does not edit the charter on its own
           authority and did not do so here
```

THE DEFECT: the charter's own header at the top declared the companion
specification as `README_Deblock4_Design_Spec_v1_12.md`, while the MANDATORY
SESSION BOOTSTRAP TEMPLATE embedded in Part 0 still named
`README_Deblock4_Design_Spec_v1_9.md` with "Design specification revision:
1.9" - a three-generation-stale pointer inside the block a future coding
scope copies verbatim.

THE FIX, and why it is shaped this way: the entry is now VERSION-AGNOSTIC
rather than repinned to v1.12, matching the idiom the SAME template already
uses two lines above for the charter itself ("the prevailing version per
2.3a" / "as stated in this file's header"). Repinning would only schedule the
identical defect for the next README bump. It reads:

```text
Controlling specification:
    filename          README_Deblock4_Design_Spec - HIGHEST COMMITTED VERSION
                      (v1_12 at this writing, or later)
    internal revision as stated in that file's header
```

NOT CHANGED, AND FLAGGED INSTEAD: that block still calls the README the
"Controlling specification". The project has since decided the README becomes
USER-FACING product documentation holding no controlling information, and
Project Status records a pending W3X ruling on its status. Changing that word
would be a RULE change, not a currency correction, so it is deliberately left
alone and raised separately. See the T1 consolidation sweep, which adjudicates
the README at steps T1S02 and T1S03.

v1.29 (2026-08-14) - W3C-proposed, W3D-verified, W3X-ratified 2026-08-14

Provenance for this self-affecting delivery-criteria change (I7):

```text
proposer:  W3C (Stage 5C-era session, second orientation review Q1, with
           the exact replacement wording)
verifier:  W3D (confirmed the phrase occurs exactly once, at the end of
           C-DELIV-03, and that no other clause still references a commit
           verification step)
ratifier:  W3X (approved 2026-08-14: "q1 yes please")
```

- In C-DELIV-03's closing sentence, "A patch that fails commit
  verification, anchor verification, or either apply check" becomes
  "A patch that fails base confirmation, anchor verification, or either
  apply check". This removes the last reference to the superseded
  starting-commit regime; the confirmed-base model (C-DELIV-01) defines
  the verification that replaces it. No other change; no Part 1 invariant
  or project-design change.

## v1.28 (2026-08-14) - W3C-proposed, W3D-verified, W3X-ratified 2026-08-14

Provenance for this self-affecting delivery-criteria change (I7):

```text
proposer:  W3C (Stage 5C-era session, orientation response Q1, 2026-08-14)
verifier:  W3D (successor designer session; anchors verified against the
           live v1_27 bytes before editing)
ratifier:  W3X (approved 2026-08-14: "q1 yes please")
```

- Currency-only reconciliation of residual pre-v1.27 starting-commit
  wording with the C-DELIV-01 confirmed-base model: section-1 template
  field ("Starting commit" -> "Base: confirmed with W3X", with a
  historical note); C-DELIV-03 statement and verification bullet;
  C-DELIV-04 existing-file-replacement bullet; C-DELIV-08 (the
  "git rev-parse --short HEAD" line removed; "verify branch and starting
  commit" -> "confirm branch and base with W3X"). Patch anchor
  uniqueness, git apply --check, whitespace checks and git diff --check
  are unchanged.
- Also in this pass (W3X-approved 2026-08-14): the companion-README pin
  advanced from v1_9/1.9 to v1_12/1.12, and this Part 7 history gained
  the previously missing v1.27 entry below (the v1.27 change had been
  recorded only in the header Status block).
- No Part 1 invariant or project-design change.

## v1.27 (2026-08-12) - W3X-ratified 2026-08-12 (retrospective entry)

(Entry added retrospectively in v1.28; the change itself was ratified and
in force from 2026-08-12, described in the header Status block.)

- Updated the section 4.3 delivery protocol to the accepted no-script,
  manual-base process. C-DELIV-01 drops the exact-starting-commit
  requirement: the base is the prevailing repository state confirmed with
  W3X (who guarantees the local repo IS the base); no commit hash or
  per-file base hash is recorded.
- Added C-DELIV-10 (git discipline: no stash, no automatic staging or
  committing, no machinery whose correctness depends on index/staging/
  HEAD state; non-destructive reads and W3X-manual git permitted; staging
  never used; commit is a manual post-acceptance W3X act).
- Added C-DELIV-11 (deliveries ship no PowerShell and no
  repository-operating script; application is a manual copy of
  apply_to_tree/ or W3X-manual git apply; backout is a manual W3X command
  block plus an optional restore_to_base/ folder).
- The existing patch workflow (C-DELIV-02/03) remains available as a
  W3X-manual option. No Part 1 invariant or project-design change.

## v1.26 (2026-08-01) - W3C-proposed, W3D-verified, W3X-ratified 2026-08-01

Provenance for this self-affecting scope/delivery-process change:

```text
proposer:  W3C (base rule), refined per W3X direction and W3D verification
verifier:  W3D (Deblock4_W3D_Response_CoderIntro_v1_19_Direction_and_Charter_v1_26_Proposal_v1_0.md)
ratifier:  W3X (ratified 2026-08-01)
```

- Added section 2.3b. A scope is reissued only when a later controlling-
  document change alters, supersedes, contradicts, or materially qualifies
  something the scope relies on or uses for acceptance. For unrelated changes,
  W3D assesses and recommends, W3X decides, and the compatibility decision is
  recorded in one Project Status line. Uncertain or disputed materiality remains
  STOP-and-reissue.
- Replaced the obsolete automatic-reissue sentence in the session-bootstrap
  revision-matching block with a pointer to section 2.3b. Immutable filename/
  internal-version matching remains unchanged.
- Qualified the C-DELIV-09 reminder-block requirement prospectively: it applies
  to every scope and delivery-plan addendum ISSUED HENCEFORTH. This permits
  explicit compatibility/grandfathering decisions for already-ratified, in-
  flight documents without manufacturing a mixed scope generation.
- No Part 1 invariant or project-design change.

## v1.25 (2026-08-01) - W3D-proposed, W3C-verified, W3X-ratified 2026-08-01

Provenance for this delivery-criteria reminder change:

```text
proposer:  W3D (wording conveyed by W3X 2026-08-01)
verifier:  W3C (checked against Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md)
ratifier:  W3X (ratified 2026-08-01)
```

- Appended the ratified C-DELIV-09 reminder-block requirement: every scope and
  every delivery-plan addendum restates the rule using the current
  Deblock4_Scope_Header_CDELIV09_Reminder_Block, latest per section 2.3a. The
  reminder block is copied verbatim into those documents; the charter governs
  on any difference.
- Independently checked reminder-block v1.1 against the operative v1.24
  C-DELIV-09 obligations. It accurately preserves the risk trigger, increment
  marker, honest recoverability boundary, possible increment supersession,
  whole-integration requirement, and final-package authority. No reminder-block
  change is required.
- No Part 1 invariant or project-design change.

## v1.24 (2026-08-01) - W3C-proposed, W3D-verified, W3X-ratified 2026-08-01

Provenance for this self-affecting delivery-criteria change:

```text
proposer:  W3C (Deblock4_W3C_Review_of_Charter_C_DELIV_09_v1_0.md)
verifier:  W3D (independently verified; confirmation carried by W3X 2026-08-01)
ratifier:  W3X (ratified 2026-08-01)
```

- Replaced C-DELIV-09 verbatim with the independently verified wording from
  section 4 of the W3C proposal. The revised trigger is material interruption
  or review-continuity risk rather than a mechanical module count. Each emitted
  increment is a complete, self-identifying recovery/review artifact, but need
  not be independently applyable or accepted unless explicitly stated.
- Corrected the recovery claim: only emitted artifacts survive; the current
  incomplete increment and later un-emitted integration, reconciliation,
  validation, or revision work may be lost. Earlier increments may be
  superseded by later integration.
- Preserved the final-delivery contract: W3C rebuilds and re-packages the
  complete integrated work against the authoritative base, validates it as a
  whole, and delivers one C-DELIV-01..08 artifact of record for W3X to apply
  unless W3X explicitly directs otherwise.
- No Part 1 invariant or project-design change.

## v1.23 (2026-08-01) - W3C-proposed, W3D-verified, W3X-ratified 2026-08-01

Provenance for this self-affecting criteria change:

```text
proposer:  W3C
verifier:  W3D (Deblock4_W3D_Verification_of_Charter_v1_23_Proposal_v1_0.md)
ratifier:  W3X (ratified 2026-08-01)
```

- Added I7 in section 2.2: when a party proposes a change to criteria that will
  be applied to that party's own work, the change must name the proposer and a
  different-party independent verifier and must never be silently absorbed.
  Normative adoption remains subject to W3X ratification/release where required.
  Added the corresponding Part 6.1 quick-reference row.
- Replaced the stale session-bootstrap charter v1.17 / internal 1.17 literal
  with self-referential wording that always points to the prevailing charter
  and the internal version stated in its header.
- Updated the W3D role description from a persistent AI session to a
  continuity-bearing AI role whose successor sessions are oriented through the
  current designer handover.
- Normalised this repository document to CRLF, as already required by
  C-DELIV-06. No Part 1 invariant or project-design change.

## v1.22 (2026-08-01)

Generalised section 2.3a from paired (two) documents to version SETS of two or
more. Where a document header declares a read-together set, the LATEST filename
version of EACH member prevails (members may bump independently), the set is
read together as one authority, and an incomplete or inconsistent declared set
is a STOP-and-ask condition. The rule remains general; it names no specific
set.

## v1.21 (2026-08-01)

Added section 2.3a (version currency and paired documents). The highest
filename version is normally prevailing, but a document W3X provides directly
this session takes precedence over the latest committed; latest versions are
verified with W3X (a newer ratified document may not yet be committed); and
where a document header names a companion at a specific version and the
versions mismatch, STOP and seek W3X direction rather than mixing generations.

## v1.20 (2026-08-01)

Added C-DELIV-09 (incremental emission for interrupt-safety and review
continuity). W3C emits completed modules incrementally with an "increment N
of ~M" marker so an interrupted session's recoverable baseline is the last
complete emitted increment (at most the module in flight is lost); W3C must
NOT claim to preserve un-emitted internal work. The final packaged deliverable
(C-DELIV-01..08) is unchanged - increments are a running preview, and the
scope is re-packaged as one deliverable of record at the end. The rule is
copied verbatim into every scope header as a standing reminder.

## v1.19 (2026-07-31)

- C-DELIV-06 line-ending rule replaced (W3X-ratified after the Stage 1B.3
  v1/v2 delivery round surfaced a charter/practice contradiction: v1
  delivered CRLF per repository practice, v2 flipped to LF per the charter's
  literal text, and an LF batch file is functionally hazardous under
  cmd.exe). New rule: every repository text file is CRLF; git pinned to
  core.autocrlf=false and core.whitespace=cr-at-eol so the mandatory
  whitespace gates pass legitimately without bypass; existing LF scaffolding
  files keep their endings until the filter-stage sweep deletes them;
  transport-only artifacts may be LF; conflicts between charter text and
  practice are stated, not silently resolved.

## v1.18 (2026-07-30)

- Recorded the Stage 1B.3 ratifications into the card and standards:
  G1 gains the ACTUAL/EFFECTIVE two-record model (actual = process-wide
  immutable truth; effective = per-instance actual INTERSECT force-down
  ceiling; dispatch consumes effective).
  G2 tightened: generic, dispatch, AND capability-detection code contain
  nothing above the v1 baseline (no v2 and no v3 instructions), detection
  proven v1-only by standalone-object disassembly (previously stated only
  for AVX2; reconciles with 3.2).
  G3 one-mechanism paragraph replaced with the ratified mechanism: targets
  use Zig named CPU models; runtime detection reads real CPUID/XGETBV with
  SDM locations; a COMPTIME assertion proves per-level membership equals the
  named-model set differences through an explicit name map and W3X-approved
  exclusion list; mismatch is @compileError (FAIL, never a warning).
  G10 ENABLING gains the Debug-only hard-reject (either debug option outside
  -Doptimize=Debug fails the build); CAPABILITY SEAMS gains the intersection
  statement, the no-top-tier-value / fix-not-force rule, the loud
  announcement, and loud-fail on invalid forcing input.
- Added C-STY-09 (shared config and printing have single homes:
  deblock4_config.zig declarations-only switchboard, print_helper_functions
  always-on, print_diag_helper_functions + force_down_debug gated; extend,
  do not fork) and C-STY-10 (permanent names; one-way dependency from
  scaffolding to first-class only; the sweep test as a delivery obligation).
- Session bootstrap header and C-DELIV-01 record the ratified
  attached-source-tree-as-base alternative to a pinned starting commit
  (W3X may commit non-source material between coding scopes).
- Part 6.1 gains rows for C-STY-09 and C-STY-10.

## v1.17 (2026-07-30)

- ADDED G10: debug-only code is structurally absent from production binaries by
  the ratified three-layer pattern (explicit opt-in option default off; C-3
  source-visible conditional import as the primary comptime-exclusion boundary;
  gated content as defence in depth; three-surface proven absence per G6 tier
  3). Capability-affecting seams may only force DOWN, never fabricate (G5
  unchanged). Empirical basis: gate_pattern_test_v2 on the Windows Zig 0.16.0
  toolchain, ten enforced tests all PASS, including an isolation control
  attributing omission to the outer conditional import alone, omission shown
  identical in Debug/ReleaseSafe/ReleaseFast, stray references failing to
  compile, and a deliberate layer-1 breach still omitting via layer 2.
  Mechanics and evidence: Deblock4_Debug_Module_Inclusion_Pattern v1.1.
- Part 6.1 gains a row pointing debug-only inclusion questions at G10 and the
  pattern document. Status line updated to G1-G10.

## v1.16 (2026-07-29)

Companion-pin sync only: the companion specification pin and bootstrap advanced
to README v1.9 (README's v1.9 was a mechanical decision-status-table fix). No
invariant or rule change; this bump exists solely to keep the load-bearing
companion pin exact, per the exact-version discipline.

## v1.15 (2026-07-29)

Post-re-audit consistency cleanup: H-OWN wording "differential-identity" ->
"differential-correctness" harness. Companion reference advanced to README v1.8.
No invariant change.

## v1.14 (2026-07-29)

Independent re-audit corrections (scope-blockers C1/C2 and highs H1/H3/M1/M2/M3):
- BOOTSTRAP (C1): companion spec/revision corrected to README v1.7; charter/
  README self-versions fixed; removed "1.1 or later prevailing version"; the
  pixel-path acceptance clause rewritten from universal byte-identity to the
  per-type contract (INTEGER byte-identical; FLOAT within the differential
  contract; pure copy/share byte-identical), with the ORACLE-CONSTRUCTION
  EXCEPTION (C2) and a loose whole-image sanity gate. This stops a future scope
  copying a template that reinstates the removed policy or deadlocks oracle
  creation. Full wording in Deblock4_Verification_And_Tiering_Decisions 20.
- G3 (H1): Stage 1B.2 CONFIRMS within-level and RECORDS the requirements; the
  runtime guard is a Stage 1B.3 artifact - 1B.2 does not check a guard.
- CPU levels (H3): OSXSAVE added to the v3 lists as a level MEMBER, with an
  explicit note distinguishing level membership from the runtime XGETBV/XCR0
  safety check; do not substitute XSAVE for OSXSAVE.
- Fallback (M3): "AVX2-but-not-v3 is v2" restated as "select the highest lower
  level fully satisfied, normally v2 else v1".
- FMA (M1): "present-but-unused" softened to "included in the v3 target but not
  relied upon; ordinary a*b+c not result-changing contracted under .strict; no
  @mulAdd currently required; 1B.2 does not expect FMA emission".
- Terminology (M2): a residual "backend identity" phrase reworded to integer
  exactness / float differential equivalence.

## v1.13 (2026-07-29)

Second audit pass (W3C found residuals in the v1.12 reconciliation):
- G7: activation-mask contradiction fixed - structural masks stay EXACT; the
  NUMERIC ACTIVATION decision may differ for float paths only within the
  decision-boundary tolerance; integer shows zero activation differences.
- G3 / Part 3.2: v1 and v2 psABI feature lists completed (v2 adds CMPXCHG16B,
  LAHF-SAHF) and marked a READING AID, with the authoritative per-level set
  deferred to one mechanism (prefer Zig std.Target) so target and detection
  cannot drift - important because dispatch is whole-level.
- A1/G7: FMA reworded from an accuracy example to "any future explicitly
  approved fused operation", so 1B.2 is not read as needing to prove FMA
  emission (under .strict FMA is present-but-unused in v3).

## v1.12 (2026-07-29)

Consistency reconciliation after the document audit, plus the two-core-filter
direction. No new project direction; this removes superseded live text that
still contradicted the v1.11 decisions, and records the filter architecture.

- Part 0 filter inventory REPLACED: the plugin registers two CORE filters -
  deblock4.Classic (H.264, faithful to HolyWu, built FIRST) and
  deblock4.Deblock4 (the MPEG-2 end goal, SECOND); QED variants are separate
  later workstreams. The four distinguishing points are scoped to Deblock4;
  Classic deliberately reproduces HolyWu (incl. luma-on-chroma).
- A1/A2 REWRITTEN (audit B2): the pinned card no longer mandates universal
  float bit-identity. Integer is byte-exact across ReleaseSafe scalar /
  ReleaseFast scalar / v2 / v3; float is same-algorithm within the approved
  differential contract; structural results stay exact; backend selection may
  affect only float magnitudes and the near-threshold numeric activation
  decision.
- Part 3.2 REWRITTEN (audit H1): tiers are the named psABI levels used in full;
  the "smallest tested closure" / "FMA excluded" policy is superseded; Stage
  1B.2 confirms within-level; whole-level dispatch with v3->v2->v1 fallback.
- Backend tokens set (audit H2): "auto" / "x86_64_v3_with_avx2" /
  "x86_64_v2_with_sse41" / "x86_64_v1_baseline", in G1, the quick-reference,
  and all diagnostics/errors.
- Harness terminology: "differential identity harness" -> "independent
  differential correctness harness".
- Quick-reference updated: Deblock4 API drops grid_mode="h264" (owned by
  Classic); a Classic API summary is added; the stages show shared Stage 1 then
  per-filter Classic-then-Deblock4 (2C/2D..5C/5D).
- Metadata: date to 2026-07-29; companion README reference to v1.5 (the
  reconciled README issued alongside).

Not changed: integer exactness, structural/edge exactness, G5 execution safety,
G6 export discipline, the Stage 1B.1 object architecture. Full reasoning is in
Deblock4_Verification_And_Tiering_Decisions.

## v1.11 (2026-07-28)

Adopted the verification and tiering decisions recorded in
Deblock4_Verification_And_Tiering_Decisions_v1_0. Three changes to Part 1:

- REWROTE G3. The prior G3 required "smallest feature closures", EXCLUDED FMA
  from the AVX2 object, and forbade any architecture level from becoming
  normative before assembly inspection. All three are reversed: backends now
  target the NAMED x86-64 psABI levels v1/v2/v3 IN FULL (the level is the
  published feature contract, not a bespoke measured closure); FMA is part of
  the v3 level and is not excluded; dispatch is WHOLE-LEVEL with v3->v2->v1
  fallback. Stage 1B.2 now CONFIRMS an object stays within its level rather
  than deriving a closure. The safety intent (dispatch checks exactly what the
  object may execute) is unchanged; the mechanism is now a named level plus a
  whole-level guard.
- ADDED G7: cross-backend equivalence is same-algorithm, split by type -
  integer exact, float same-algorithm within a measured tolerance, with
  structural/edge results exact even under tolerance, and the scalar oracle
  (ReleaseSafe) as ground truth with the ReleaseFast scalar proven against it.
- ADDED G8: float kernels use explicit @setFloatMode(.strict); ReleaseFast and
  .strict are independent; no @mulAdd requirement; fast-math rejected.
- ADDED G9: the scalar-vs-SIMD differential is a STANDING gate re-run on every
  Zig/LLVM version bump (the R76-class miscompile guard), with an
  edge/tail-forcing corpus requirement.

The change relaxes cross-backend FLOAT bit-identity to a measured tolerance and
stops constraining instruction sets for identity; it does NOT relax integer
exactness, structural/edge exactness, G5 execution safety, or G6 export
discipline. Full reasoning and the withdrawn alternatives (twin-build, bespoke
closures) are in the decisions document.

## v1.10 (2026-07-28)

Revised the G6 corollary for gated backend code after W3X build evidence
falsified its v1.9 mechanism claim. The v1.9 corollary said gated functions are
never declared with the export keyword, and that their absence from the export
table is therefore structural (tier 1). Two Stage 1B.1 builds proved this
unsatisfiable and factually wrong on Zig 0.16 + lld-link (COFF/PE):

1. Without export (and with no in-unit reference), Zig omits the function
   ENTIRELY - both gated objects showed .text length 0 with no marker symbol -
   so no retention mechanism (forceUndefinedSymbol / INCLUDE-class, nor a
   cross-compilation address reference) has anything to retain. Emission is
   decided per compilation unit; a reference from a different compilation does
   not force it.
2. export in an OBJECT-mode compilation does NOT create a PE export: the
   generic and scalar markers are export fn in addObject-ed units and appeared
   in NEITHER the DLL export table NOR the import library. PE-export requires a
   dllexport-class directive from the DLL compilation itself.

The corollary now bans PE-EXPORT of gated code rather than the export keyword,
separates the three properties (emission, linkage, PE-export) with their
distinct controls, and requires either an explicit export-list allowlist
(tier 2) or a standing loud-failing dumpbin /EXPORTS gate (tier 3). The safety
goal is unchanged: no export-table doorway, and nothing reachable before the
capability guard (G5). Only the mechanism claim is corrected. Evidence and the
corresponding community-proven Zig dispatch idiom are recorded in
Deblock4_Toolchain_Findings (F1, F2, F4, F5).

## v1.9 (2026-07-25)

Added invariant G6: safety properties rest on explicit or structural
mechanisms, never on implicit toolchain behaviour. Motivated by the Stage 1B.1
retention/export question: the delivered mechanism marked target-specific
markers with the export keyword and relied on the toolchain not adding them to
the PE export table - an implicit behaviour that a future toolchain release
could change silently. External research (2026-07-25, see the Stage 1B.1
research findings document) confirmed: COFF/PE is safe-by-default for exports
(nothing is exported without positive declaration); retention without export is
achievable structurally by reference-graph anchoring or an explicit
/INCLUDE-class directive; and the dominant single-binary dispatch pattern
(FFmpeg/x264/dav1d function-pointer contexts) keeps feature-specific symbols
entirely off the public surface. G6 encodes the preference order: structural,
then explicit declaration, then guarded residual with a standing loud-failing
gate. Corollary: gated backend functions are never declared with the export
keyword.

## v1.8 (2026-07-25)

Completed the G5 consolidation. v1.7 promoted the execution-safety rule from
C-SIMD-06 into G5 but carried only the general contract, silently dropping
three concrete enforcement specifics that the retired rule had stated. Those
are now restored into G5, so no enforcement detail was lost in the move:

- the explicit NO-BYPASS clause (no manual, command-line, environment-variable,
  build-flag, or "known to support it" route around the guard);
- the enumeration of unguarded execution paths that count as execution (static
  initialisers, registration paths, import thunks, test calls), with the note
  that a static initialiser in an AVX2 object runs at DLL load before any
  capability check;
- the Stage 1 spike behaviour: a test-local guard is acceptable, and on an
  unsupported or indeterminate host the test reports SKIP rather than faulting
  or passing silently.

No invariant meaning changed between v1.7 and v1.8. This revision restores
detail that should have accompanied G5 when C-SIMD-06 was retired.

## v1.7 (2026-07-25)

Ratification candidate issued after designer review of the v1.6 delivery
protocol and target-specific execution safeguard.

- Added G5 to Part 1 so target-specific execution safety is a cross-scope
  invariant rather than only a Part 4 implementation rule. Compiling and
  linking an SSE4.1 or AVX2 object is permitted; calling it requires the G1
  capability record or an equivalent proved in-process guard.
- Made the early-scope consequence explicit: Stage 1B.1 may prove SSE4.1 and
  AVX2 object presence, symbols, isolation, and linkage, but does not invoke
  their code. Feature-specific identity calls wait for guarded execution.
- Retired C-SIMD-06 because G5 now carries the same safety contract at the
  correct controlling level and duplicate normative wording would invite drift.
- Updated the charter filename, internal version, and status for v1.7 review.

Part 1 changed by adding G5. Explicit W3X ratification is required before this
revision becomes the controlling charter baseline.

## v1.6 (2026-07-25)

Draft ratification candidate that added the controlling Deblock4 delivery
protocol for memoryless coder sessions and W3X application. It was superseded
by v1.7 before ratification so the execution safeguard could be promoted into
Part 1 as G5.

- Replaced the stale draft-review status and updated the bootstrap filename
  and internal version for the v1.6 ratification candidate. W3X did not ratify
  that candidate before it was superseded by v1.7.
- Proposed C-SIMD-06: target-specific objects may be compiled and linked
  before the production detector exists, but guarded execution was required.
  v1.7 promotes this safety contract into Part 1 as G5.
- Added section 4.3 and C-DELIV-01 through C-DELIV-08. Delivery format is chosen
  per file: new files are complete files; small localised existing-file changes
  are patches; changes over roughly 30 percent or across several separate
  regions are normally complete replacement files.
- Added exact-base and anchor-verification gates, mixed-format delivery
  manifests, explicit Zig 0.16.0/build-mode/C-ABI-bridge assumptions, W3X
  apply-and-report duties, minimum patch and whole-file application commands,
  and worked patch and whole-file examples.

No invariant in Part 1 changed in this draft. The delivery protocol was
retained by v1.7; the execution-safety rule was promoted into Part 1 as G5.

## v1.5 (2026-07-25)

Added an explicit oracle-identity acceptance requirement to the session bootstrap header
for any scope touching a pixel or frame-construction path, so copy-path work cannot pass
acceptance before the scalar oracle exists. Closes the gap where P-04's non-binding stage
order was the only thing sequencing kernel correctness ahead of copy optimisation.

## v1.4 (2026-07-25)

Issued after review of external Zig/VapourSynth common numeric and vector
helper patterns during the Stage 1 scaffold.

- Added C-NUM-01 so generic numeric helpers cannot conceal range, signedness,
  overflow, saturation, accumulator width, rounding, conversion, non-finite,
  or scalar/vector policy.
- Added C-SIMD-01 through C-SIMD-05 for code-generation proof, explicit backend
  vector widths, byte-versus-sample stride units, proven alignment, strict
  floating-point equivalence, and evidence-based gather claims.
- Added P-12 so external common-utility modules are never copied, adapted, or
  adopted wholesale as a shortcut. Every candidate function requires a fresh,
  Deblock4-specific semantic, safety, code-generation, test, and provenance
  review.
- Recorded the current disposition of the reviewed external common helpers:
  no reviewed function is approved for adaptation or adoption; any future use
  requires new evidence and a new function-specific review.
- Corrected the v1.3 history description of C-MEM-01 to match the ratified
  wording: specialised copy paths may be evaluated without first proving a
  generic path is a bottleneck.

No invariant in Part 1 changed. This revision adds numeric, SIMD, and external
helper-adoption safeguards derived from source review.

## v1.3 (2026-07-25)

Drafted during the Zig 0.16.0 build and VapourSynth API4 interop scaffold,
following review of external Zig/VapourSynth implementation patterns.

- Corrected C-STY-08 wording while preserving its requirement that all debug
  output go to stderr and be flushed immediately.
- Added C-INT-01 through C-INT-04 for explicit Zig/C ownership, prohibition of
  mixed owned-and-static return contracts, proven C-string lifetime, and
  correspondence-preserving Zig-facing compatibility-wrapper names.
- Added C-MEM-01 so frame construction considers safe plane sharing, exact
  stride-correct copying, and other API-supported options without freezing an
  implementation mechanism as an output invariant. Specialised copy paths
  remain valid evaluation options without prior bottleneck proof, subject to
  the same correctness contract and practical measurement before retention.
- Added P-11 so copied, adapted, independently reimplemented, inspiration-only,
  and reviewed-and-rejected external material remain distinguishable and
  traceable.
- Recorded that an alleged C-interop leak is never accepted without evidence
  of the receiving API's actual copy, retention, borrowing, or ownership
  contract.

No invariant in Part 1 changed. This revision adds coding and process rules
derived from the initial Zig/C interop and external-source review.

## v1.2 (2026-07-24)

Issued after the first repository push exposed a circular dependency in the
v1.1 hash mechanism.

- **Removed SHA-256 pinning entirely.** In practice the mechanism could not
  bootstrap: converting the README to ASCII changed its bytes and invalidated
  the hash pinned in the charter that referenced it, while the charter's own
  hash remained an unresolvable placeholder because it would have had to be
  self-referential. Replaced with dual identification by filename version and
  internal version string, which W3C checks for agreement.
- Companion specification updated to `README_Deblock4_Design_Spec_v1_6.md`,
  which carries the M1, M2, and FMA corrections.
- The residual risk of the simpler scheme is recorded explicitly rather than
  left implicit: an in-place edit that does not change the version string is
  not detected.

No invariant in Part 1 changed. This revision is metadata and process only.

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
