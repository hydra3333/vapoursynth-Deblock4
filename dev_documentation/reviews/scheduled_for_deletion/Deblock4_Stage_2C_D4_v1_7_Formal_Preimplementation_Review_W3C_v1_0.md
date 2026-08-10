# Deblock4 - Stage 2C Formal Pre-Implementation Scope Review

**Deliverable:** W3C-2C-D4-SECTION0-SECTION11-REVIEW  
**Version:** 1.0  
**Date:** 2026-08-04  
**Author:** W3C (coder; independent pre-implementation reviewer)  
**Route:** W3C -> W3X -> W3D  
**Reviewed scope:** `Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_7.md`  
**Reviewed source base:** `src(44).zip`  
**Status:** FORMAL THREE-WAY SCOPE REVIEW ROUND ACTIVE. This document is the
W3C section-0/section-11 response for W3D review through W3X. No Stage 2C
implementation, test harness, reference build, or delivery work has begun.
Implementation remains blocked until W3D responds, W3X resolves/adopts the
review outcome, and W3X explicitly releases implementation.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Review mandate and disposition

W3X instructed W3C to perform, in this order:

```text
1. D4 section-0 independent knowledge sweep;
2. independent verification of D2 v1.6 against the byte-pinned HolyWu r9
   snapshot, beginning with SHA256SUMS.txt;
3. D4 section-11 mandatory pre-implementation review of D4 v1.7 together
   with D3 v1.8 and Addenda A/B v1.2;
4. numbered findings for the ordinary W3C -> W3X -> W3D three-way scope
   review process;
5. STOP before implementation.
```

That is the process state now. The D4 design document is released as the
review authority, but W3X has not released implementation after this review
round.

Overall technical assessment:

```text
- the Stage 2C objective and scalar-first architecture are sound;
- D2 is source-accurate;
- D3 and Addenda A/B are, subject to the findings below, sufficient and
  sufficiently unambiguous to judge the intended implementation;
- no arithmetic, schedule, threshold, boundary, sentinel-fixture or
  differential-corpus correction was found;
- one source/scope conflict blocks implementation;
- two bounded knowledge/issuance corrections should be resolved in the
  three-way review before implementation release.
```

# 2. Inputs and revision check

The highest-version, non-superseded Stage 2C authority set reviewed was:

```text
AI_Charter_and_Invariants_Card_v1_26.md
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_9.md
holywu_r9/SHA256SUMS.txt and the four pinned upstream files
holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_6.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_8.md
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_7.md
Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_2.md
Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_2.md
Deblock4_Creation_Error_Message_Table_v1_6.md
Deblock4_Stage_2C_Session_Bootstrap_Header_v1_0.md
Deblock4_Stage_2C_Issuance_Bundle_Manifest_v1_0.md
```

Filename versions and internal versions agree for every member above.

Attached-package SHA-256 values:

```text
src(44).zip
e30657148cfecf54d4d7b48aba5f891a0b6630afcd61feb30027838e9c1c42b5

dev_documentation(13).zip
02875dc11b45f32f1f9b3f466d38acc556da74d097dfa0d7f291fca51843c73c

stage_2C_reference.zip
9d546b4b6c7bcb2afbb5e282d2b0fd68ecb9a331431e66474bd4ebbd4c7c929c
```

The source tree is the expected accepted Stage 1C plus rider 1C.1 base:

```text
identity                    0.1.0-dev+1C
build_1C_v1.bat             present
effective_invocation_text   present
Classic production path     writable copyFrame pass-through
```

Nothing under any of these directories was read or used as authority:

```text
superseded/
superseded_do_not_use_files_in_this_folder/
reviews/scheduled_for_deletion/
```

# 3. Independent D2 verification against HolyWu r9

## 3.1 Hash and byte check

`sha256sum -c SHA256SUMS.txt` passed for all four pinned files:

```text
deblock.cpp
600585ee46c783db5bc47ea22fcaadbbef48cd60caa8bf850e44a40b0de86367

deblock.h
6d59551e80b1f2e6ea246eb07fa09558c62fae17e2cfa83907e4f70aaf4b7cba

deblock_sse4.cpp
43249d76636f8255f9c40ed6b4b3bd45629517d30a10b0d6c98c38d05479c62e

LICENSE
39db8f9acf036595a2566ea3fe560bc7bd65d8749f088e0f4a4ef2f8a6cb4b34
```

The pinned upstream files remain LF-only and byte-intact.

## 3.2 Source verification result

D2 v1.6 accurately records the material source facts:

```text
- registration signature, defaults, ranges and plane handling;
- opt=1 as the forced C/scalar path; opt=0 may select SSE4;
- all three 61-entry threshold tables;
- aIndex/bIndex derivation and c0 indexed by aIndex;
- 8..16-bit integer scale/peak handling;
- the exact Schedule-A loop order;
- one 4-sample grid in every selected plane's own coordinates;
- luma-on-chroma behaviour;
- integer activation gates, side-activity gates, c widening, rounding,
  clamping and write footprints;
- negative signed-left-shift UB versus negative signed-right-shift facts;
- source-expression facts separated from pinned executable-result facts;
- the distinct float formula and non-finite divergence;
- HolyWu's mod-8 Point-resize/filter/Crop wrapper;
- copyFrame followed by sequential in-place filtering;
- fmParallel across frames with rpStrictSpatial dependency;
- Classic/HolyWu legal-shared-domain correspondence.
```

**D2 disposition: PASS.** No D2 correction or new source-fact finding is
required.

# 4. Independent section-0 knowledge sweep

The sweep began from the current non-superseded documentation tree rather than
from D0's checklist. It covered the charter, verification/tiering decisions,
toolchain findings, debug-module pattern, dispatch architecture, current
Project Status, roadmap, Stage 1C source contracts and the active Stage 2C set.

W3X directed during this review that
`README_Deblock4_Design_Spec_v1_9.md` is fallback general guidance: newer
ratified documents prevail, and W3C must identify the specific matter before
consulting it. D4 itself delegates five specific matters to that README, so
W3C announced and consulted only:

```text
README 6.1-6.5   boundary eligibility and stride slack
README 13.2      destination initial state
README 13.3      actual per-plane geometry/stride/storage
README 13.5/13.6 tier actually used and the always-on summary
README 15.2      criteria for any deliberate deviation
```

No older README passage was allowed to override D0/D2/D3/D4 or a later
ratified decision.

The sweep found the omitted charter duties recorded in Finding F2 below.
Withdrawn alternatives were confirmed as do-not-revisit only:

```text
no cross-backend integer tolerance;
no twin-build model;
no bespoke feature closures;
no subtraction of FMA from v3;
no Schedule B, midpoint or MPEG-2 geometry in Classic Stage 2C;
no speculative vector API in Stage 2C.
```

# 5. Numbered findings

## F1 - BLOCKER: S5's single truthful always-on line cannot be produced within the authorised source boundary

### Required behaviour

D4 S5 requires Classic Stage 2C to:

```text
auto            -> implemented v1;
explicit v1     -> v1;
explicit v2/v3  -> exact unimplemented-backend refusal;
Deblock4Tier    -> implemented tier actually executed;
always-on line  -> exactly one non-debug creation summary reporting the
                   implementation-capped v1 tier and making the cap visible.
```

D4 section 1 and the bootstrap forbid capability-detection changes. D4
section 7b authorises only `src/backend_tier_selection.zig` for applying the
implementation-availability cap. `src/print_helper_functions.zig` is not an
authorised existing-file change.

### Attached-source evidence

The current call sequence is:

```text
classic_instance_creation.zig:99-106
    backend_tier_selection.selectForInstance(...)

backend_tier_selection.zig:18-26
    cpu_capability_detection.initInstanceCapabilities(...)
    THEN selectForEffectiveTier(...)

cpu_capability_detection.zig:202-249
    derives ACTUAL/EFFECTIVE;
    emits the always-on summary at lines 238-243;
    returns the EFFECTIVE record.

backend_tier_selection.zig:29-50
    only after that emission selects/refuses the requested tier.
```

The existing always-on helper supports only:

```text
none
forced_down
hardware
```

in `print_helper_functions.zig:10-21`; there is no
`implementation_capped` reason.

Consequently, on W3X's v3-capable host, an authorised-only implementation can
cap Classic to v1 in `backend_tier_selection.zig`, but the already-emitted
single summary has reported the pre-cap EFFECTIVE v3 tier. Emitting another
line would violate the one-line contract and leave the false first line.
Formatting a replacement locally would violate charter C-STY-09, which makes
`print_helper_functions.zig` the sole home of shared always-on printing.

There is no correct implementation using only the present authorised changed
files.

### Additional ambiguity exposed by the source

The current summary is emitted before a later requested-backend refusal,
instance allocation and filter creation. If the summary seam moves, two
reasonable implementations can differ on whether failed N02/N03 creation
attempts emit a summary line. D4 defines their exact error rows but does not
settle this emission timing.

### Required W3D/W3X correction

Amend the authorised existing-file boundary and specify the emission contract.

At minimum, the scope needs narrow authority for:

```text
src/cpu_capability_detection.zig
    separate capability derivation from the final per-filter selection
    summary, or expose an equivalent no-premature-summary path;
    ACTUAL/EFFECTIVE detection, force-down and G10 semantics remain unchanged.

src/print_helper_functions.zig
    extend the existing single printing home with the implementation-capped
    reason/fields; do not create local print formatting.

src/backend_tier_selection.zig
    preserve EFFECTIVE refusal precedence, apply the Classic implemented-tier
    ceiling, and arrange the one final truthful summary.
```

W3D should specify whether the always-on summary is success-only or also
appears on failed creation attempts, and how existing Deblock4/pass-through
summary behaviour remains byte-stable.

The precise data-flow shape is a design choice for W3D/W3X; W3C must not choose
between altering the shared selector result, adding a Classic-specific
selection entry point, or another approved seam.

**Disposition:** implementation cannot begin until this is resolved and the
exact changed-file/change-class authority is reissued or amended.

## F2 - REQUIRED SECTION-0 ADDITION: directly applicable charter duties are absent from D0/D4's binding checklist

The independent sweep found two current charter duties that bear directly on
the new first-class scalar modules and frame-plane integration but are not
carried by D0 K1-K29 or D4 section 9.

### F2a - C-STY-10 first-class-module sweep

Stage 2C adds permanent production modules:

```text
src/classic_scalar_kernel.zig
src/classic_edge_schedule.zig
src/classic_thresholds.zig
```

Charter C-STY-10 requires:

```text
- permanent, non-scaffolding names;
- one-way dependency: scaffolding may call first-class code, never reverse;
- no first-class reference to a stage/probe/smoke marker or artefact;
- a textual first-class-file audit returning empty for scaffolding identifiers.
```

D4 P1 reruns the existing Stage 1C S2 audit, which usefully scans new files for
the known retired filenames, but neither D0 nor D4 explicitly maps the full
C-STY-10 obligation to Stage 2C or to the O/G crosswalk.

Required correction:

```text
- add the C-STY-10 duty to the binding index/checklist;
- require the successor runner/crosswalk to identify the first-class-module
  sweep gate and its exact domain.
```

### F2b - C-SIMD-03 stride units apply even though this scope is scalar

Charter C-SIMD-03 states:

```text
VapourSynth frame strides are byte counts. Any conversion to a typed sample
stride is checked once and names both units explicitly.
```

D4 A1c/A6 and D3 O-6e/O-8c correctly require actual per-plane stride,
bytes-per-sample and canaries, but do not state or judge the checked
byte-stride-to-sample-stride conversion rule. HolyWu performs such a
conversion; the Zig implementation may instead use byte addressing, but it
must not silently divide and assume.

Two reasonable implementations can therefore differ structurally while
passing ordinary valid-frame byte comparisons:

```text
- explicit byte-based addressing with no conversion; or
- one checked conversion to sample stride with named units; or
- an impermissible unchecked conversion.
```

Required correction:

```text
- carry C-SIMD-03 into D0/D4;
- state in A1c or the proof contract that any typed-stride conversion is
  checked once for the storage width and names byte/sample units;
- map the proof to code inspection/assertion plus the existing canary tests.
```

Charter C-STY-09 should also be named in the amended S5 checklist because F1
requires extending the single printing home rather than forking it.

**Disposition:** these are direct knowledge/proof corrections, not new
algorithm policy and not Open Rule Questions.

## F3 - REQUIRED ISSUANCE/AUTHORITY RECONCILIATION

This finding has three process-facing parts. They did not contaminate this
review because W3X supplied direct clarification and W3C used the highest
versions while excluding forbidden folders. They should nevertheless be
reconciled before implementation is issued to a memoryless session.

### F3a - README authority wording conflicts with W3X's current direction

Current documents say:

```text
bootstrap:
    README v1.9 is the "Controlling specification".

D0:
    charter and README prevail where the index is imprecise.
```

W3X has now directed:

```text
README v1.9 is fallback general guidance;
newer ratified documents supersede it;
W3C identifies the specific matter before consulting it.
```

Required W3D/W3X action:

```text
record that hierarchy in the bootstrap/D0 or in an explicit charter-2.3b
compatibility note. D4's inline, scope-specific requirements and the current
ratified companions prevail; README v1.9 supplies fallback guidance only on
identified gaps.
```

### F3b - "scope released" and "implementation released" are not consistently distinguished

D4's header and bootstrap call D4 v1.7 `RELEASED`. D4 section 11 then says not
to implement until W3X "releases the scope". Project Status v1.21 and the
issuance message describe the intended two-step process correctly:

```text
released design/scope -> mandatory successor W3C review ->
W3D/W3X resolution -> W3X releases implementation.
```

The current W3X instruction resolves this session: this document begins the
three-way scope-review round and implementation is not authorised.

Required wording correction for the next issuance:

```text
D4 is released as the review authority;
implementation is NOT authorised until W3X explicitly releases
implementation after the section-0/section-11 review resolves.
```

### F3c - actual package layout differs from the issuance manifest/bootstrap

The manifest recommends two zips plus a loose bootstrap and says superseded
folders are omitted. The actual issuance was three zips, with the bootstrap
inside the reference archive, and included excluded folders.

Other actual-versus-described differences include:

```text
bootstrap names `src.zip`; actual file is `src(44).zip`;
reference root contains both D4 v1.6 and v1.7;
documentation root contains Project Status v1.20 and v1.21;
bootstrap status still says DRAFT for W3X;
superseded/scheduled-for-deletion directories are present.
```

The highest-version rule and explicit exclusion policy made the current review
deterministic. For future issuance, either package exactly as the manifest
states or update the manifest/bootstrap to the actual archive names, hashes,
layout and exclusions.

**Disposition:** F3a/F3b should be resolved before implementation release.
F3c is non-algorithmic packaging hygiene but should be corrected for the next
memoryless handoff.

# 6. D3 and Addenda A/B assessment

Subject to F1/F2, D3 v1.8 is sufficient and sufficiently unambiguous to judge
the intended scalar delivery.

Confirmed strengths include:

```text
- exact threshold tuples and exhaustive 8..16-bit table/arithmetic checks;
- fixed 17-bit and 32-bit end-to-end refusals plus exhaustive 17..32 guard;
- strict activation and side-gate discriminators;
- exact single-edge vectors including floor-shift and 16-bit cases;
- whole-schedule order-sensitive matrix;
- native 16-bit matrix rather than a false x256 shortcut;
- complete-footprint boundary cases, including the extent mod 4 == 3 class;
- source immutability, row/plane canaries and i32 range proof;
- production-path plane, format, property and bit-depth routing;
- mandatory O/G-to-test crosswalk;
- a sanity gate with a required negative control.
```

Addendum A is a valid K26 execution pin. W3C independently reproduced:

```text
B2 -> 109 107 103 101
B4 ->   1   3   6   8
B5 -> 160 158  42  40
```

in both fixture orientations, with exactly four intended changed samples and
no other changed sample.

Addendum B is active rather than vacuous. W3C independently reproduced all
recorded non-vacuity counts:

```text
C01 3028       C03 3287
C09 1596       C10 2881
C11 1596       C12 2881
C13 3311       C14 3367       C15 3591
YUV420P8 chroma 32x32: 680
YUV422P8 chroma 32x64: 1442
C16 Y/U/V: 3311 / 747 / 747
C17 Y/U/V: 1061 / 215 / 215
```

The S1 and K29 error rows are exact and adequately proved by N01a/N01b and
N01c1/N01c2 plus the exhaustive direct guard. N02a/N02b and N03 separately
prove implementation availability and EFFECTIVE-tier precedence. N04 is the
correct production case for S5 once F1's source seam is resolved.

The H0-H6 external-reference design is feasible and appropriately separates:

```text
pinned source identity;
generated binary identity;
forced scalar invocation;
behavioural sentinel validation;
actual-run domain guards;
decisive byte comparison;
authority-fixed non-vacuous corpus.
```

# 7. Confirmed no-finding areas

No correction is required for:

```text
- the strategic choice of Classic-first, scalar-first oracle construction;
- the separation between Classic and the later MPEG-2 Deblock4 algorithm;
- S1 integer-only Stage 2C and both float-width refusals;
- S2 explicit clamps alongside the i32 range proof;
- S3 legal-shared-domain comparison;
- S4 oracle-construction acceptance;
- S6 identity advance to 0.1.0-dev+2C;
- S7 one canonical formula body with no speculative vector API;
- threshold tables or bit-depth scaling;
- c0-from-aIndex faithfulness;
- Schedule A or its sequential in-place dependencies;
- luma-on-chroma and per-plane 4-grid behaviour;
- native complete-footprint boundaries and small-plane pass-through;
- the copyFrame-equivalent destination initial state;
- source-frame immutability and audit-property semantics;
- ReleaseSafe/ReleaseFast integer byte identity;
- K26 fixture mathematics or Addendum-B corpus arithmetic;
- the successor-runner rule that build_1C_v1.bat remains immutable and is
  not run against the +2C identity.
```

No new Open Rule Question is proposed. F1-F3 are direct source-boundary,
knowledge-index and issuance corrections rather than competing policy choices.

# 8. Required three-way response and stopping point

W3C requests that W3D, through W3X:

```text
1. resolve F1 by defining and authorising the exact truthful-summary seam,
   exact files/change classes, and failed-creation summary timing;
2. verify F2 and add the confirmed charter duties to D0/D4/proof routing;
3. reconcile the README hierarchy and the review-release versus
   implementation-release wording;
4. record whether the current packaging discrepancies require reissue or only
   correction at the next handoff;
5. return a numbered W3D response for W3X decision.
```

A focused re-review of the amended lines and source boundary should be
sufficient. No D2, formula, matrix, boundary, sentinel or corpus re-derivation
is needed unless those contents change.

**W3C STOPS HERE. No implementation is authorised or underway.**

---

*End of W3C Stage 2C formal section-0/section-11 pre-implementation review.*
