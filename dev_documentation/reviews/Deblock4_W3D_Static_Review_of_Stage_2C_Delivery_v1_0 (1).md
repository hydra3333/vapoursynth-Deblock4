# Deblock4 - W3D Static Review of the Stage 2C Implementation Delivery v1.0

**Deliverable:** W3D-2C-STATIC-REVIEW-OF-DELIVERY
**Version:** 1.0
**Date:** 2026-08-06
**Author:** W3D (designer)
**Route:** W3D -> W3X
**Reviews:** Deblock4_Stage_2C_Implementation_Delivery_v1_0.zip (manifest v1.0)
**Against:** D4 v1_9 + read-together authority set (D0 v1_11, D2 v1_6,
D3 v1_10, Addenda A/B v1_2, error table v1_6, D1 pin + provenance v1_4);
charter v1_26; the held Stage 1C + rider 1C.1 base tree.
**Status:** W3D STATIC REVIEW - no execution performed or claimed by W3D.
W3X runs build_2C_v1.bat and generates the H0 evidence; acceptance follows
the evidence, not this review.
**Encoding:** US-ASCII; CRLF.

---

# 1. VERDICT

```text
ZERO blocking findings. ZERO required changes.

The delivery is, in W3D's judgement after full static review, a faithful
implementation of the released Stage 2C contract, ready for W3X
validation. Two ADVISORY observations (section 4) affect only W3X's
operating order, not the delivery's content.
```

# 2. What was verified, and how

Every check below was performed cold in this session against the actual
delivered bytes and the held base tree.

```text
PACKAGING AND PROCESS
- Manifest complete: 10 REPLACES + 12 NEW + 0 removed, matching the
  apply/restore scripts' lists exactly; C-DELIV-07 honoured (no
  execution/PASS claim); H0 evidence ownership correctly assigned to
  W3X; base identified by content per the ratified Q8 form.
- apply_delivery.ps1 / restore_to_base.ps1: hard-abort, full preflight
  before any write, -LiteralPath throughout, exactly the 22 manifest
  paths, stop-not-overwrite on NEW collisions, no per-file base hashes,
  evidence and superseded folders untouched, holywu_reference removed
  only when empty.
- restore_to_base payload: ALL 10 files verified BYTE-IDENTICAL to the
  held Stage 1C + rider 1C.1 accepted tree.
- Forbidden surfaces: absent from the payload (using-echo, Deblock4
  filter-path modules, G10 modules, detection logic beyond the seam,
  build_1C_v1.bat, holywu_r9); src/deblock4_instance_creation.zig not
  shipped at all (manifest additionally records it byte-identical).
- Every delivered repository artifact US-ASCII, CRLF-only (verified).

AUTHORISED-BOUNDARY COMPLIANCE (per-file diff vs base)
- cpu_capability_detection.zig: the ENTIRE diff is the D-2C-1
  relocation - a returned {effective, summary_reason} pair, the emit
  call and its two parameters removed. Zero detection-logic change.
- deblock4_config.zig: declarations only (both ceilings + the exact
  token "intentionally-capped").
- print_helper_functions.zig: one new variant + one format arm
  mirroring forced_down; existing arms byte-unchanged; ratified line
  shape reproduced exactly.
- deblock4_version.zig: single-homed marker 1C -> 2C + its test.
- classic_instance_data.zig: format fields + resolved thresholds only.
- deblock4_selftest.zig: seam adaptation + S5 pure additions; existing
  1C contract retained.
- build.zig: module/unit-test wiring for the three new modules.

DESIGN CONFORMANCE (D-2C-1..6)
- backend_tier_selection.zig implements the ratified algorithm
  precisely: single emission point; emission occurs for every attempt
  REACHING selection including refusals (the error-union is captured,
  the line prints, the error then propagates - D-2C-4); refused
  explicit requests report the auto-resolution; intentionally-capped
  IF AND ONLY IF the ceiling strictly lowers the tier (D-2C-3, which
  is what keeps every Stage 1C line and the E3 force-down cases
  byte-stable); EFFECTIVE refusal tested before availability (D-2C-2,
  unit-tested in the N03 shape); Deblock4 passes ceiling=null and is
  byte-identical by construction; the selector is filter-neutral.
- classic_instance_creation.zig implements D-2C-6: float/depth
  refusals run with the clip checks BEFORE selection (no summary
  line); the S5 refusal arises inside selection (one line). The three
  ratified error strings match table v1_6 verbatim; the exhaustive
  17..32 guard is an embedded unit test.
- resolve() asserts (rather than clamps) index legality: VERIFIED SAFE
  - the unchanged 1C parseClassic enforces strength 0..60 and offsets
  within [-strength, 60-strength] at creation, so indices are provably
  in [0,60] in-domain and out-of-domain is refused at creation.
  Behaviourally equivalent to D3's function everywhere API-reachable.
- classic_frame_properties.zig legitimately unchanged: it stamps from
  the backend selection carried in instance data, so the capped tier
  flows through without modification.

MATHEMATICS (verified against W3D's independent D3-Appendix model,
the same model that reproduced 46/46 ratified values at orientation)
- All three threshold tables BYTE-IDENTICAL to the derivation.
- resolve() V1-V6 vectors match the O-1 tuples exactly; c0 pinned to
  the alpha-side index with the WP-5 faithfulness comment.
- filterEdge is the ratified formula: i32 intermediates throughout;
  arithmetic-shift semantics with the delta numerator MULTIPLIED by
  four; conditional p1/q1 writes; explicit final clamps (S2);
  comptime-enforced u8/u16 only; no @Vector, no @mulAdd; the O-6f i32
  range proof embedded with D3's documented bounds.
- Embedded A1-A5 and B1-B8 vectors: digit-identical to the model.
- Schedule A traversal: EXACTLY the ratified crossing order (vertical
  band at row 0; per band horizontal-then-vertical); eligibility
  edge>=3 and edge+2<extent; 4-row/4-column segments; taps x-3..x+2,
  writes x-2..x+1.
- Embedded O-4 matrix, order-sensitivity discriminator (cell x=5,y=2:
  110 correct vs 109 swapped - the model's exact first difference),
  O-5d native-16-bit matrix (including interior values 27988/28408),
  and O-7 10x10/12x6/6x6/11x7: ALL digit-identical to the model.
  Guard-band assertions prove the write footprint (O-6e).

K30 / K31
- K31 model (a) byte-row navigation implemented as ratified (rows in
  bytes, one cast per row, no stride division anywhere) AND
  mechanically enforced by a batch source audit that fails on any
  stride division.
- K30 two-part audit implemented as ratified: new modules + wiring
  audited in full (generic vocabulary + enumerated retired list,
  expected empty); existing modules audited on CHANGES only; accepted
  Stage 1C identifiers not renamed. Dual-mode base (git index, or
  -BaseRoot for index-independent runs).

PROOF SURFACE
- The crosswalk routes EVERY D3 v1_10 O/G identifier plus
  T-S5-1a/1b/2..5, K30, K31 and H0-H6 to exact test/gate identifiers
  with modes; the batch additionally machine-checks crosswalk
  identifier completeness.
- build_2C_v1.bat: re-executes the applicable 1C gates expecting +2C;
  three modes; T-S5-1a (count 1) and T-S5-1b (count 0) wired through
  the per-case expected-summary-count argument; T-S5-2 via the N04
  exact-line check (ratified byte shape verified present); T-S5-3/5
  via the force-down v1 (forced-down line byte-stable) and v2
  (intentionally-capped) cases; T-S5-4 via N03 + N02a/b; error rows
  incl. N01a/b/c1/c2 at count 0; sanity gate + negative control (the
  control must be REJECTED by G6 and must exercise G6); RS-vs-RF
  production hash identity across 21 cases; negative build controls;
  K30/K31 audits; OUTER_BATCH_EXIT_CODE discipline.

H0-H6 EXTERNAL REFERENCE
- build_holywu_r9_scalar.ps1: SHA256SUMS verified BEFORE AND AFTER the
  build (tamper window closed); compiles deblock.cpp ONLY - the DLL is
  scalar BY CONSTRUCTION (deblock_sse4.cpp never compiled); sources
  compiled in place by absolute path, never copied or EOL-normalised;
  auditable preliminary record with the complete command line.
- stage_2c_holywu_diff.vpy: record-vs-DLL hash guard; opt=1 forced at
  every invocation; six K26 sentinels with expected values AND an
  unexpected-changed-cells check; the fixed 17-case corpus;
  machine-readable first-difference summary; completion-state flow
  into the completed record per the schema.
```

# 3. Findings

```text
NONE blocking. NONE required.
```

# 4. Advisory observations (W3X operating order only)

```text
OBS-1  The K30 audit's default mode diffs against the git INDEX, which
       is correct only while the delivery is applied but UNSTAGED. Run
       build_2C_v1.bat BEFORE staging or committing the applied
       delivery (the natural order anyway), or pass
       -BaseRoot <delivery>/restore_to_base for an index-independent
       run. The script documents this assumption in-line.
OBS-2  The reference build uses /O2. This is compliant: the oracle's
       integer semantics are optimisation-independent, the DLL is
       scalar by construction (only deblock.cpp is compiled), opt=1 is
       forced at load, and the Addendum A sentinels validate the built
       artefact regardless. Recorded so nobody re-litigates it.
```

# 5. W3X runbook to acceptance

```text
1. Apply on a clean working tree: apply_delivery.ps1 -TargetRoot <repo>.
2. BEFORE staging/committing (OBS-1), from an x64 MSVC developer
   prompt: build_2C_v1.bat. Expect OUTER_BATCH_EXIT_CODE=0.
3. The H0 arc runs inside the batch: reference build, guards,
   sentinels, corpus. ADDENDUM A SENTINEL MISMATCH = HARD STOP per
   H3(c): stop and report to W3D/W3C; never adjust D3.
4. Retain zig-out/inspection_2C evidence; supply the console capture
   and evidence to W3D for the acceptance-review round.
5. Only after W3D's evidence review and your acceptance: stage, commit,
   push. Evidence artefacts are not committed source (D4 7d).
```

# 6. Assessment

The delivery demonstrates exactly the discipline the three-way process
was designed to produce: every ratified decision of the review rounds
(D-2C-1..6, T-S5-1a/1b, the K30 contract, K31 model (a), the token, the
table strings) is implemented in its ratified form and most are
mechanically self-enforced by the proof runner. The mathematics
reproduces W3D's independent derivation digit for digit at every
embedded vector and matrix. W3D finds the delivery READY FOR W3X
VALIDATION.

---

*Revision history*
```text
v1.0 (2026-08-06) Initial static review of the Stage 2C implementation
     delivery v1.0. Zero blocking findings; two advisory observations
     on W3X operating order.
```
