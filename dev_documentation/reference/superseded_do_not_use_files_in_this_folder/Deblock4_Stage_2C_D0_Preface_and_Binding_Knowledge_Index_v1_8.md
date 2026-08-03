# Deblock4 - Stage 2C Preface and Binding Knowledge Index

**Deliverable:** W3D-2C-D0
**Version:** 1.8
**Date:** 2026-08-02
**Author:** W3D (designer), ratified by W3X
**Status:** Living index; updated as 2C deliverables land (extend, do not rewrite).
**Encoding:** US-ASCII; CRLF.

---

# 1. Purpose

Stage 2C introduces the first real deblocking mathematics into Deblock4: the
Classic ReleaseSafe scalar oracle and the HolyWu external-reference
differential harness. A large body of prior research, experimentation, and
hard-won findings governs this work. All of it is captured in committed
repository documents; NONE of it lives only in any chat's memory.

This preface (a) records the Stage 2C plan and its pinned reference, and
(b) indexes every binding knowledge item with its home document/section and
the 2C-family point at which it applies - so that no participant (W3X, W3D,
W3C, or any successor chat) can lose it by forgetfulness. Every 2C-family
deliverable MUST carry a Binding Knowledge Checklist naming the items from
section 4 that it touches and stating how each is honoured (or why it is out
of scope for that deliverable). Reviewers check the deliverable against its
checklist AND the checklist against this index.

# 2. Pinned external reference (D-CLASSIC-4, RATIFIED)

```text
Reference:  HolyWu VapourSynth-Deblock, tag r9
Ratified:   W3X, 2026-08-02
Verified:   r9 src/ is byte-identical to master src/ as of 2026-08-02
Contents:   src/deblock.cpp (448 lines, scalar core = oracle reference)
            src/deblock_sse4.cpp (169 lines; THEIR SIMD - later 4C reference
            reading only, never our implementation source)
            src/deblock.h (17 lines)
Snapshot:   to be archived read-only in-repo by deliverable W3D-2C-D1
            (W3X-owned once committed, like the VapourSynth R78 headers).
Rule:       all schedule/formula citations in 2C documents reference THIS
            snapshot by file/function/line (README requirement: inspect the
            real source; never compare against an assumed schedule).
```

# 3. Stage 2C deliverable plan (short-boundary, extensible)

```text
W3D-2C-D0  This preface + binding knowledge index. (this document)
W3D-2C-D1  Pin record + read-only source snapshot committed to the repo.
W3D-2C-D2  HolyWu Real Schedule document: line-by-line inspection of
           deblock.cpp - actual edge order, formulas, rounding, clipping,
           threshold derivation from strength, frame-boundary behaviour,
           and the faithful luma-on-chroma path - with file/function/line
           citations into the D1 snapshot.
W3D-2C-D3  Independent scalar obligations + loose whole-image sanity gate
           (the acceptance basis under the oracle-construction exception).
W3D-2C-D4  Stage 2C coder scope draft, assembled from D1-D3, checklist
           embedded, for W3X ratification and release.
Then:      W3C implementation delivery/deliveries; W3D review; W3X run,
           acceptance, commit - per the established Stage 1C process.
```

Each boundary is a valid stopping point; a successor designer resumes from
the committed deliverables alone (the Stage 1C dead-coder recovery proved
this model).

# 4. Binding knowledge index

Authority note: the charter and the README prevail where any summary here
is imprecise. Section references are to the CURRENT committed versions
(README_Deblock4_Design_Spec_v1_9, AI_Charter_and_Invariants_Card_v1_26,
Deblock4_Verification_And_Tiering_Decisions_v1_10,
Deblock4_Toolchain_Findings_v1_3); "or later" always applies.

## 4.1 Vector semantics and SIMD discipline (the "@Vector" lessons)

```text
K1  Vector BYTES vs vector ELEMENTS must never be conflated.
      README 3.6 (SIMD batch), 3.7 (Vector bytes), 3.8 (Vector lanes).
      Applies: D3 obligations wording; 4C/5C backend scopes; any coder text
      that mentions @Vector widths.
K2  SIMD width must not define output: scalar, v2, v3 byte-identical for
      integer formats regardless of batch width.
      README 4.3.  Applies: D3 (obligation), 2C differential harness
      definition, 4C/5C acceptance.
K3  (APPLIES TO D2: documenting HolyWu's real frame-boundary behaviour,
      and it exposes that non-mod-8 policy is SETTLED, not open - see the
      note under section 5.) The TWO TAIL CLASSES are different things and
      must never be confused:
      ALGORITHMIC boundary tail (frame-edge behaviour of the algorithm,
      README 3.10 + section 6 corrected frame-boundary policy) vs SIMD
      BATCH tail (vector-width remainder handling, README 3.12 + section 7
      corrected SIMD-tail policy, esp. 7.2 "Never confuse the two tail
      classes").  Applies: D2 (document HolyWu's actual frame-boundary
      behaviour), D3 (state boundary obligations), 4C/5C (batch tails).
K4  AVX2 masked load/store warning: README 7.4. AVX2 backend notes 7.3.
      Applies: 5C primarily; recorded here so 2C documents do not
      accidentally promise masked-IO semantics.
```

## 4.2 Miscompile guard and float semantics

```text
K5  R76-class miscompile risk and its PERMANENT mitigations (charter G9):
      Verification_And_Tiering 5. Classic's 4-pixel grid is the
      HIGHER-EXPOSURE case (Roadmap, "why this ordering").
      Applies: D3 (obligations must be miscompile-detecting: independent
      vectors, not implementation-derived), 2C scope (the differential
      harness is itself a standing G9 guard), 4C/5C.
K6  (APPLIES TO D2: the float arithmetic account must separate the
      source-EXPRESSION fact from the external-EXECUTION fact; see K26.)
      Non-fused float semantics: a*b+c must retain non-fused semantics; no
      @mulAdd (README, section 3 rules; background in
      Deblock4_Floating_Exactness_and_Full_Declared_Tiers_Discussion_v1_3).
      Applies: D2 (note HolyWu's arithmetic type reality), D3, coder scope.
      Note: Classic integer paths dominate; float applies to threshold
      derivation if HolyWu uses it - D2 must establish the fact.
```

## 4.3 Oracle and differential doctrine

```text
K7  Classic oracle contract: README "Classic oracle contract" (section 4),
      including the e-relative read footprint e-3..e+2 and write footprint
      e-2..e+1 (p1,p0,q0,q1).
      Applies: D2 (verify against real source), D3 (footprint obligations),
      coder scope.
K8  Do not use HolyWu as the ONLY oracle: README 4.2. Independent scalar
      obligations + hand-derived vectors are mandatory, not optional.
      Applies: D3 is this requirement made concrete.
K9  Oracle sequencing (charter G7) + per-type differential acceptance +
      ORACLE-CONSTRUCTION EXCEPTION: Verification_And_Tiering 20.1/20.2 and
      Roadmap standing constraints. The 2C scope that CONSTRUCTS the oracle
      is accepted against D3 obligations + loose whole-image sanity gate,
      not against a pre-existing oracle. After acceptance, NO pixel/frame/
      copy/backend code for Classic is accepted except differentially
      validated against the oracle (integer byte-identical).
      Applies: D3, D4, and every Classic delivery after 2C.
K10 ReleaseFast-vs-ReleaseSafe scalar check: Verification_And_Tiering 3.7.
      Applies: 2C proof surface (the oracle is ReleaseSafe; RF must match
      byte-identically for integer).
K11 Schedule A (verified HolyWu-equivalent) vs Schedule B (Deblock4
      two-pass candidate): README 5.1-5.4. CLASSIC IS SCHEDULE A ONLY -
      faithful HolyWu including luma-on-chroma; no grid_mode, no midpoint,
      no Schedule B (Roadmap Stage 2C line). Schedule B and the MPEG-2
      grid/field knowledge (Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0)
      are 2D material - explicitly DEFERRED, listed here so nobody
      "helpfully" imports them into Classic.
      Applies: D2 (Schedule A verification IS the task), D3, D4 scope
      boundary.
K19 THREE-LAYER COMPARISON DOCTRINE (do not flatten to "byte-identical"):
      (a) GENERAL: HolyWu is NOT an absolute bit-exact specification;
          deliberate, documented, quality-validated differences are
          permitted (README ~217 + settled-decisions table: "desired
          baseline similarity, not absolute requirement"). This is the
          ratified "slightly more accurate arithmetic acceptable" decision.
      (b) CLASSIC EXTERNAL (stronger, supersedes loose equal-or-better
          wording; README ~807): HolyWu C/scalar at the pinned commit IS
          the external oracle for Classic. deblock4.Classic scalar vs
          HolyWu C/scalar: INTEGER planes - byte-exact is the TARGET and
          ANY difference is INVESTIGATED (then either fixed, or justified
          under (a) as deliberate/documented/validated); FLOAT planes -
          tolerance discipline, structural results exact.
      (c) INTERNAL (V&T 20.1, merciless): Deblock4 tier vs Deblock4
          ReleaseSafe scalar oracle: INTEGER byte-identical, no tolerance,
          any difference is a defect; FLOAT within the approved
          differential contract; COPY/SHARE byte-identical for ALL types
          including float.
      Applies: D3 (obligations must state which layer each check lives
      in), D4 (harness gates named per layer), 4C/5C (layer (c) governs),
      and every review of a Classic pixel difference.
K27 DESTINATION INITIAL STATE AND FRAME-PROPERTY CONTRACT (README 13.2;
      from W3C combined-review sweep F4a). The destination frame begins
      semantically identical to the source for all pixels and for all
      frame properties that must be preserved; the filter then writes its
      own ratified audit properties (Deblock4Filter, Deblock4Tier,
      Deblock4Version, Deblock4Using). Consequence: "output identical to
      source" obligations mean PLANE BYTES, never the whole frame object
      - audit properties are written even when no pixel changes. Never
      compare opaque frame-object memory.
      Applies: D3 O-5c/G4 wording; D4 (retain the copyFrame-equivalent
      destination-initial-state step before selected-plane filtering);
      every "byte-identical" claim about a FRAME rather than a PLANE.
K28 ACTUAL PER-PLANE GEOMETRY, STRIDE AND STORAGE (README 13.3; sweep
      F4b). For every selected plane use the ACTUAL plane width, height,
      stride, bytes-per-sample and the correct format family obtained
      from the frame; NEVER infer chroma bounds, extents or steps from
      luma dimensions and subsampling ratios. Stride is movement only,
      never usable slack (README 6.4).
      Applies: D4 A5/A6 and its checklist; D3 O-6e canaries and the
      production-path plane-routing proofs; 4C/5C.
K29 VALID INTEGER DEPTHS EXTEND TO 32 (external VapourSynth API fact;
      from W3C updated-package F1). queryVideoFormat permits integer
      bitsPerSample 8..32 (float restricted to 16 or 32); storage is 1
      byte at 8, 2 bytes at 9..16, 4 bytes above 16. A valid 17..32-bit
      integer clip is API-REACHABLE and is NOT malformed metadata. A
      filter that supports only 8..16 must REFUSE valid 17..32-bit
      integer inputs with a dedicated creation error (table v1_4:
      "Classic: integer input must be between 8 and 16 bits"), never the
      "input video metadata is invalid" row. Applies: D4 A1b/S1; D3
      section 8; every future format-domain decision.
K26 EXTERNAL-ORACLE EXECUTION PIN (G6 discipline applied to the
      reference; from W3C findings F12 then F1-of-revision-review).
      Byte-pinning the HolyWu SOURCE (D1) does NOT pin the RESULT, and
      the unpinned behaviours are of THREE DIFFERENT CLASSES:
        (i)  signed RIGHT shift of a negative value: implementation-
             defined / language-mode dependent - pinnable by recording
             the compiler and mode;
        (ii) LEFT shift of a negative signed value ((q0-p0)<<2 at
             deblock.cpp:106,180 when q0<p0): C++ UNDEFINED BEHAVIOUR in
             the relevant language modes - the STANDARD promises no
             result, so recording compiler/flags reduces but does not
             eliminate the gap; only the OBSERVED BEHAVIOUR of one exact
             binary is a fact;
        (iii) float contraction/reassociation: build-flag dependent.
      A HolyWu layer-(b) comparison therefore records and controls:
        - the byte-pinned source identity (D1 SHA256SUMS);
        - FORCED C/scalar path: opt=1, OR a proven no-DEBLOCK_X86 build
          (deblock.cpp:326,349-359 - opt=0 auto-selects SSE4 on capable
          x86; absence of opt does NOT select the oracle);
        - compiler and version; C++ language mode; optimisation and
          floating-point flags;
        - VapourSynth version and the invoked resize/std plugin versions;
        - the inherited floating-point environment (incl. MXCSR);
        - MANDATORY: the exact SHA-256 of the reference DLL/executable
          actually run - the BINARY is the practical layer-(b) oracle;
        - BEHAVIOURAL SENTINELS (K26 SIGNED-SHIFT sentinels; B2/B5 probe
          the class-(ii) negative-LEFT-shift UB region with q0-p0
          negative, B4 probes a negative RIGHT shift in the side-delta
          with q0-p0 positive - NOT all "negative-delta"): run against
          that exact binary with observed outputs recorded (D4 Addendum
          A is the plugin-level fixture authority);
        - REBUILD RULE: any rebuilt reference binary is a NEW oracle
          artefact requiring fresh hash AND sentinel revalidation.
      DEBLOCK4-SIDE COROLLARY: the Zig oracle must not contain an
      analogous negative-left-shift construction; it computes the delta
      core with well-defined arithmetic (e.g. i32 multiply by 4), whose
      value equals the intended idiom for all in-range inputs.
      Applies: D2 (WP-1 semantics split); D1 provenance (source pin vs
      reference-build record distinction); D3 (floor-shift vectors carry
      this dependency until sentinels exist); D4 (harness pins the build,
      records sentinels, asserts in-domain inputs); every external run.
```

## 4.4 Platform, build, and process findings already paid for

```text
K12 Toolchain Findings F1-F8 (Deblock4_Toolchain_Findings_v1_3): esp.
      F4/F8 (export fn: object-mode vs DLL-root are different properties),
      F5 (proven multi-feature-level idiom), F6 (VapourSynth numeric
      coercion pre-plugin), F7 (empty-array boundary; plugin defence
      retained).  Applies: any 2C source work touching modules/exports;
      harness design (no host-owned error text assertions).
K13 G5: no v2/v3 backend EXECUTION before the proven whole-level capability
      guard (charter). 2C is scalar-only; the guard machinery from 1B.3
      stands untouched.  Applies: D4 scope boundary, 4C/5C.
K14 G10 three-layer debug-seam obligations + the Debug Module Inclusion
      Pattern (Deblock4_Debug_Module_Inclusion_Pattern_v1_1): any new 2C
      diagnostics follow the pattern; the standing fifteen-gate matrix
      keeps its G10 gates green.  Applies: D4, coder deliveries.
K15 Backend-object dispatch architecture:
      Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3 and
      Deblock4_S1B1_Retention_Export_Research_Package_v1_0. The oracle is
      scalar and lives in normal code; backend objects re-enter at 4C/5C.
      Applies: 4C/5C (indexed now so it is not re-derived).
K16 Creation-error message table v1_4 is the ratified source obligation:
      the v1_1 rows unchanged PLUS the THREE Stage 2C Classic additions
      (float refusal; integer-depth refusal per K29; backend-unavailable
      refusal) under the section-5 narrow exception. No EXISTING string
      is altered. Deblock4Using / the using-echo
      surfaces (rider 1C.1) must remain byte-stable.
      Applies: D4 no-touch list, coder deliveries.
K17 Delivery self-containment rule (Stage 1C.1 lesson; wording corrected
      per W3C revision-review F6 to match the SETTLED W3X model): a
      delivery carries and stages EVERY file its proof touches. It does
      NOT require a globally clean tree: every existing target it patches
      must match its declared base hash; every new destination must
      satisfy its declared precondition; unrelated W3X-owned paths are
      neither inspected nor constrained (W3X works live in the tree).
      Never reads, moves, or deletes anything under superseded/; ships a
      scoped restore-to-base command block derived from its own manifest.
      Applies: every 2C-family coder delivery.
K18 Proof-domain and audit discipline: S3 domain is the deliverable tree
      (allowlist); the four -File PowerShell audits; the cmd/quoting
      lessons; benign artifacts judged by exit code (Zig --listen context,
      negative-configure FileNotFound).  Homes: build_1C_v1.bat + Stage 1C
      scope v1_5 (amended) + Resume Brief v1_1 section 3.
      Applies: 2C proof-surface extensions.
```

## 4.5 Quality-claim, withdrawn-alternatives, and reproducibility doctrine
(added v1.2 after full V&T/README section sweep)

```text
K20 "MORE ACCURATE" MUST BE DEFINED (README 15.2) + default conservative
      choice (15.3). A different output is NOT automatically more accurate
      because it came from a codec-inspired schedule, AVX2, narrower
      arithmetic, or fewer instructions. An equal-or-better claim must
      refer to: reduced actual block discontinuities; retained legitimate
      detail; fewer artifacts; closer agreement with a clean reference;
      stable behaviour across representative content. If not demonstrably
      equal or better: retain the verified HolyWu-equivalent result.
      Applies: EVERY K19 layer-(b) justification; Stage 3C quality gate.
K21 WITHDRAWN / DO-NOT-REVISIT alternatives (V&T 6): cross-backend
      bit-exactness as shipping goal; the twin-build model; per-build
      bespoke feature closures; float-identity feature exclusions (e.g.
      subtracting FMA from v3). All superseded - do not re-propose.
      Applies: D4 and all 4C/5C scoping and review.
K22 FLOAT-PATH FINE INVARIANTS (V&T 3.4-3.8): structural results stay
      EXACT while the near-threshold numeric-activation decision may flip
      (3.4, INVARIANT) and such flips are ACCEPTED for this material
      (3.5, DECISION); float mode is .strict (3.6); FMA is included in v3
      but not relied upon under .strict (4.4); tolerance METHODOLOGY is a
      W3D action with numbers fixed at Stage 2 (3.8) - for Classic this
      binds only if D2 shows float in the pinned HolyWu path; otherwise
      the tolerance-numbers duty defers to 2D and D3 must say so
      explicitly.
      Applies: D2 (establish the arithmetic-type fact), D3, D4.
K23 DIAGNOSTICS AND REPRODUCIBILITY CONTRACT (V&T 7): one always-on
      version/tier line per instance creation (live since 1C); forced
      scalar backend selection available; selected backend recorded in
      frame properties; float cross-MACHINE byte-identity explicitly NOT
      promised; integer output exact and reproducible; per-binary
      determinism (same binary/backend/input/parameters/FP environment
      incl. MXCSR) is NON-NEGOTIABLE.
      Applies: D3 obligations, D4, user-facing docs.
K24 SHARED-KERNEL AUTHORING (ratified S7 form; supersedes the earlier
      BackendConfig/width-instantiation wording per W3C F5): ONE
      canonical, non-duplicated mathematical body behind a clean scalar
      call boundary; comptime STORAGE element type exactly u8 or u16;
      bitsPerSample a separate arithmetic parameter; no per-bit-depth
      hand-specialisation; NO speculative width/vector API in 2C. Stage
      4C may generalise the call boundary MECHANICALLY but may NOT fork
      or rewrite the formulas - that prohibition is the testable content
      of K24. 2C writes ZERO vector code.
      Applies: D4 A1/S7, 4C/5C.
K25 WHOLE-LEVEL DETECTION TRAP (V&T 4.3): capability detection checks
      whole named psABI levels, never individual-feature closures; the
      1B.3 guard embodies this and 2C must not add any feature-grained
      selection logic.
      Applies: D4 no-touch list.
```

# 5. What Stage 2C explicitly does NOT include

NARROW STAGE-2C EXCEPTION (W3X-ratified 2026-08-03, after W3C combined-
review F3/F1): Stage 2C MAY add exactly the ratified format- and
availability-refusal creation errors required to stop the filter making
false claims once it produces pixels - specifically: (a) the float-input
refusal, (b) the integer-depth refusal (K29) and the unimplemented-
backend refusal carried by creation-error table v1_4, (c) the Classic-
only IMPLEMENTED-TIER AVAILABILITY cap
on backend resolution (D4 S5: auto resolves to the highest EFFECTIVE-
supported AND implemented tier; explicit unimplemented tiers are refused;
Deblock4Tier reports the tier actually executed), and (d) the associated
exact EFFECTIVE-vs-availability precedence test. NO other validation,
creation-string, detection or using-echo change. All
other creation strings, the using-echo surfaces and the registration
remain untouched (K16).

SETTLED (recorded here after W3C D2 findings F8/F9; NOT open in 2C):
- Classic NON-MOD-8 boundary policy is DECIDED by README 6.1/6.3: process
  only edges whose COMPLETE footprint lies in-plane, leave unsupported
  extreme edges unchanged, and NEVER use a whole-frame pad/resize/crop
  wrapper. HolyWu's pad-filter-crop is an EXTERNAL layer-(b) fact to
  document, never a Classic behaviour to reproduce. (D2 T-3 collapses to
  "already settled - native footprint bounds".)
- Classic OUT-OF-RANGE OFFSETS are creation ERRORS (README 3.14 + ratified
  creation-error table v1_1), never silently clamped. HolyWu's offset
  clamp is an EXTERNAL layer-(b) fact. The differential harness compares
  only the LEGAL SHARED DOMAIN (mod-8 frames, in-range offsets, integer
  integer only - float is refused per D4 S1) and asserts its inputs are
  in-domain.

```text
- No grid_mode, no midpoint, no Schedule B, no field-DCT geometry (2D).
- No v2/v3 SIMD implementation (4C/5C); vectorclass in the HolyWu tree is
  THEIR dependency and is never imported.
- No change to registration, detection, G10 modules, or the using-echo
  surfaces, and NO validation/creation-string/tier-resolution change
  EXCEPT the four narrowly authorised Stage 2C items (section 5): the
  float refusal, the integer-depth refusal (K29), the backend-unavailable
  refusal, and the implemented-tier cap + precedence test.
```

# 6. Standing knowledge-sweep protocol (two-sided, issued henceforth)

Ratified mechanism ensuring no committed knowledge/decision is silently
missed by any scope. Applies to every scope issued from Stage 2C onward;
the block in 6.1 is embedded verbatim in each scope header (same issuance
mechanism as the C-DELIV-09 reminder block).

```text
1. W3D (authoring): every scope carries a Binding Knowledge Checklist
   naming the K-items of this index that govern it, produced by
   re-searching the doc set during authoring.
2. W3C (pre-implementation review): INDEPENDENTLY search the committed
   documentation set - own keywords, own reading, deliberately not
   starting from W3D's checklist - for relevant, non-superseded,
   non-withdrawn knowledge, rules, or decisions. Report as numbered
   review findings anything relevant that is ABSENT from the scope's
   checklist or from this index. Independence is the point: two
   searchers, different blind spots.
3. W3D verifies findings; confirmed items are appended to this index as
   the next K-numbers (the established K19/K20-K25 append pattern) and
   the scope is amended if material (ordinary I3/2.3b machinery).
4. Exclusions: superseded/ is OUT OF SCOPE for the search; withdrawn
   alternatives (K21 / V&T 6) are reportable only as do-not-revisit
   confirmations, never as proposals.
```

## 6.1 Standard scope-header block (embed verbatim, issued henceforth)

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

---

Revision: v1.8 (2026-08-03) W3C updated-package review: added K29 (valid
integer depths extend to 32; refuse 17..32-bit explicitly - F1); K26
sentinel wording corrected to signed-shift with B4 distinguished (F6);
no-touch block and K24 reconciled with the ratified exception and S7
(F5); creation authority is table v1_4. v1.7 (2026-08-03) W3C
revised-package review F3a: section-5
exception widened to name the S5 tier-availability cap and precedence
test; K16 updated to table v1_2 with the two additions. v1.6 (2026-08-03)
W3C combined-review sweep applied: added K27
(README 13.2 destination initial state and frame-property contract) and
K28 (README 13.3 actual per-plane geometry/stride/storage, no inferred
chroma bounds); added the narrow Stage-2C exception to section 5
permitting ONLY the ratified float-input and unimplemented-backend
refusals (creation-error table v1_2). v1.5 (2026-08-03) W3C
revision-review applied: K26 rewritten -
three distinct unpinned-behaviour classes incl. negative-left-shift C++
UNDEFINED BEHAVIOUR, mandatory reference-binary hash, behavioural
sentinels, rebuild rule, and the Deblock4 no-UB-analog corollary (F1);
K17 corrected to the settled touched-paths-only precondition model, no
clean-tree presumption (F6). v1.4 (2026-08-02) added K26 (external-oracle execution pin, G6
discipline; from W3C D2 finding F12, W3D-refined and W3X-adopted);
sharpened K3/K6 applies-to-D2 notes and recorded the SETTLED non-mod-8
boundary and offset-rejection policies in section 5 (W3C findings F8/F9).
v1.3 (2026-08-02) added section 6, the standing two-sided
knowledge-sweep protocol and its verbatim scope-header block (W3X-proposed,
W3D-refined to two-sided independence). v1.2 (2026-08-02) appended K20-K25 (quality-claim definition,
do-not-revisit list, float fine invariants incl. Stage-2 tolerance duty,
reproducibility contract, shared-kernel comptime model, whole-level trap)
after a full section sweep of V&T v1_10 and README v1_9 bodies prompted by
W3X completeness check. v1.1 appended K19 (three-layer comparison doctrine)
on W3X recall check. v1.0 was the initial index, K1-K18.
