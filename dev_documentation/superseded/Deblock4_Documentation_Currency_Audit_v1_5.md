# Deblock4 - Documentation Currency Audit (post-Stage-4C)

**Version:** 1.5
**Date:** 2026-08-13
**Author:** W3D
**Purpose:** the complete audit W3X requested: every document in the
dev_documentation tree checked against the post-4C state; what was updated,
what is current, what is historical, and what to hand a new coder. This is
also the recovery map for a future designer session.
**Encoding:** US-ASCII; CRLF.

---

# STALE - IN SCOPE FOR THE T1 CONSOLIDATION SWEEP, NOT YET ADJUDICATED

```text
DO NOT USE THIS DOCUMENT FOR CURRENT SEQUENCING, PROJECT STATE OR ANY MPEG-2
ARCHITECTURE QUESTION.

WHERE TO GO INSTEAD:
    current state ......... Deblock4_Project_Status (section 0, latest)
    MPEG-2 / architecture . Deblock4_MPEG2_Deblocking_Investigation_and_
                            Decided_Architecture (latest) - the ratified
                            single source of truth
    work queue/decisions .. Deblock4_Standing_Task_Register_T_Series (latest)

THIS BANNER IS NOT AN ADJUDICATION. This document has NOT been swept yet. Its
content has not been assessed statement by statement, and nothing in it has
been declared superseded. The banner says only: it is known to contain stale
material, so do not rely on it, and do not treat the absence of a banner
elsewhere as evidence that another document is current.

DO NOT LET THIS BANNER BECOME A REASON TO SKIP THE DOCUMENT during T1. The
recorded incident that caused T1 was a designer skipping a document because
an index called it "fallback general guidance" - a classification believed
instead of checked. A label is a claim to verify, never permission to move on.
```

KNOWN STALE CONTENT IN THIS DOCUMENT, recorded so a reader is not misled:

```text
- its "canonical current set" OMITS the ratified MPEG-2 authority and the
  Standing Task Register - the two documents a successor most needs;
- it pins superseded generations of the coder introduction, the designer
  introduction and Project Status;
- it predates the architecture re-decision, the T1 sweep and every decision
  from DEC-01 onward.

NOTE ESPECIALLY: this document's one-line descriptions of other documents are
CLASSIFICATION CLAIMS, not facts. One of them - calling the README "fallback
general guidance" - is the direct cause of the incident that made T1
necessary. Treat every such description here as a claim to verify.
```

---

# 1. The canonical current set (after this audit; commit these versions)

```text
TOP LEVEL (dev_documentation/):
  AI_Charter_and_Invariants_Card_v1_29          the rulebook; PREVAILS
                                                (v1.28: residual starting-
                                                commit wording reconciled)
  111_New_Chat_Introduction_for_Coder_v1_27     FULL v1_21 content + post-4C
                                                currency + the plain-English
                                                communication ruling (v1_22-24
                                                rewrite line WITHDRAWN)
  111_New_Chat_Introduction_for_Designer_v1_20  currency-refreshed
  333_W3X_Designer_Communication_Convention_v1_1   + general plain-English duty
  333_W3X_Coder_Communication_Convention_v1_0      NEW; binds W3C identically
  000_Instructions_..._for_designer intro       process-meta; current enough
  Deblock4_Project_Status_v1_27                 5C ACCEPTED is top state;
                                                no active scope
  Deblock4_Forward_Roadmap_v1_20                Classic vector arc COMPLETE
                                                (2C oracle, 4C, 5C accepted)
  README_Deblock4_Design_Spec_v1_12             12.5 example 4C-true; header
                                                revision field corrected
  Deblock4_Verification_And_Tiering_Decisions_v1_11
  Deblock4_Toolchain_Findings_v1_4              (single copy; see s3 tidy)
  Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2  normative citation + GAIS
                                                G2-G4 CONFIRMED (G1/G5-G7
                                                pending)
  Deblock4_Concise_Project_Summary_v1.3         stage list now current
  Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_4  + s6 4C update
  Deblock4_Debug_Module_Inclusion_Pattern_v1_1  current (4C shipped no seams)
  Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1  current
  Deblock4_Session_Bootstrap_Header_v1_1        NEW stage-agnostic filename
                                                (starts at v1.0); charter-v1_27
                                                base rules; supersedes the old
                                                Stage_2C_-named header v1_0/v1_1
  Deblock4_Stage_1C_Creation_Error_Message_Table: use reference/ v1_6 - it is
                                                current (no tier hardcoding)

reference/ (the accepted authority set; highest versions):
  D0 Binding Knowledge Index v1_14 (K1-K34)
  D1 holywu_r9/ pinned snapshot + provenance (W3X-owned, read-only)
  D2 HolyWu Real Schedule v1_7 (T-1 register updated: deferred, 3C collapsed)
  D3 Scalar Obligations and Sanity Gate v1_11
  D4 Classic Scalar Oracle scope v1_10
  Addenda A v1_2 and B v1_2; Creation-Error Message Table v1_6
  (2C review records remain as history)

Scopes/4C/ (create at commit):
  Deblock4_Scope_Stage_4C_Classic_v2_SSE41_Backend_v1_2   the accepted contract
  Deblock4_W3D_Review_of_4C_Preimplementation_Response_v1_0
  Deblock4_W3D_Static_Review_of_Stage_4C_Delivery_v1_0
  Deblock4_W3D_Acceptance_Review_of_Stage_4C_v1_0
  COMMIT_MESSAGE_4C.txt (or use directly and discard)
```

# 2. What this audit changed (issued today)

```text
D2 v1_6 -> v1_7        T-1 register: 3C collapsed; deferred to quality phase.
README v1_10 -> v1_11  12.5 auto example extended with the 4C ceiling.
Bootstrap header: NEW stage-agnostic filename at v1_0 (the old file was
                       named ..._Stage_2C_Session_Bootstrap_Header, so the
                       new name starts fresh); base = confirmed-with-W3X
                       (no hashes); 2C file lists removed (live in scopes).
Dispatch explained -> v1_4  new section 6: the pattern went live in 4C.
Concise summary -> v1.3    stage list marked with actual completion state.
(Earlier: coder intro v1_25; designer intro v1_20; status v1_26;
roadmap v1_18; acceptance review v1_0; commit message. This v1.1 pass:
charter v1_28; roadmap v1_19; README v1_12; bootstrap v1_1; coder intro
v1_26; MPEG-2 knowledge v1_2; the GAIS capture file.)

CHECKED, CURRENT, NO CHANGE NEEDED:
  V&T v1_11; Toolchain Findings v1_4;
  creation-error table v1_6 (no hardcoded tiers); CDELIV09 reminder block
  v1_1; 333 convention v1_0; debug-module pattern v1_1; D0 v1_14; D3 v1_11;
  D4 v1_10; Addenda A/B v1_2; 000 designer-intro instructions.
```

# 3. Housekeeping for W3X (manual tidy; not W3D acts)

```text
Move to superseded/ (or delete, your call):
  top level: Toolchain_Findings_v1_3; Toolchain_Findings_v1_4.old..md;
             Project_Status_v1_22 and v1_24 (v1_26 prevails);
             111_..._Coder_v1_20 and v1_21 (v1_22-v1_24 never committed,
             withdrawn); 111_..._Designer_v1_19;
             333_..._Designer_..._v1_0 (v1_1 prevails);
             Forward_Roadmap_v1_17; README v1_9/v1_10; Concise Summary v1.2;
             DISPATCH explained v1_3; MPEG2 knowledge v1_0;
             Stage_1C_Creation_Error_Message_Table_v1_1 (reference v1_6
             prevails); V&T v1_10; charter v1_26.
  Scopes/:   the old per-stage working versions (1B3 v1_0..v1_2, 1C
             v1_0..v1_4, 1C1 v1_0, D4 v1_8, D0 v1_10, D3 v1_9, 2C bootstrap
             header v1_1, Toolchain F6 addendum) - keep the HIGHEST of each
             where it is; older versions to superseded.
  reference/: D4 v1_6/v1_7, D0 v1_9, D3 v1_8, 2C bootstrap header v1_0 to
             superseded once the accepted set (D4 v1_10, D0 v1_13, D3 v1_11,
             D2 v1_7) is in place.
  GAIS files: rename the mislabelled GAIS_GATING_RESPONSE.txt to
             GAIS_ZIG_GATING_RESPONSE.txt (it is a Zig conditional-
             compilation response); add the new
             GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt to the package.
  reviews/:  the duplicate "..._Delivery_v1_0 (1).md"; the
             reviews/scheduled_for_deletion/ folder is yours to empty.
  Scopes/2C/: contains a duplicate Toolchain_Findings_v1_4 - keep the top-
             level copy as canonical, move this one to superseded.

EXAMPLE_ONLY issuance-format documents (Scopes/): retained as historical
examples. NOTE for 5C issuance: their base-identification examples predate
charter v1_29 - follow the charter and the Session Bootstrap Header v1_1,
not the examples, on base mechanics.
```

# 4. What to hand a new coder (the 5C handover, in order)

```text
1. 111_New_Chat_Introduction_for_Coder_v1_27      (orientation; read first)
2. AI_Charter_and_Invariants_Card_v1_29           (the rulebook; prevails)
3. Deblock4_Session_Bootstrap_Header_v1_1         (base + environment)
4. The Stage 5C scope, when W3D has written it and W3X ratified it
   (it names the stage authority set: D0 v1_14 checklist, the 4C/5C scopes
   v1_2 as the vector-design precedent, Toolchain Findings v1_4, and the
   proof-matrix requirements)
5. On request during the knowledge sweep: the knowledge documents
   (D0 v1_14; Toolchain Findings v1_4; MPEG-2 Grid Knowledge v1_2) and
   Project Status v1_26.
Expect back FIRST: the pre-implementation response the 5C scope will
require - never code.
```

# 5. Recovery note for a future designer session

If the designer session is lost, orient from: designer intro v1_20 ->
status v1_26 section 0 -> the 4C scope v1_2 and acceptance review v1_0 ->
this audit. The container workspace is disposable; every accepted artifact
lives in the repository once W3X commits the section-1 set.

---

*Revision history*
```text
v1.4 (2026-08-16) Post-5C maintenance M1 COMPLETE and accepted: the v2
     SSE4.1 unit now carries the same maintainer-commentary standard as its
     v3 sibling (6 -> 52 comment lines) and both units carry the K33-complete
     V1 tail wording. Comments only; executable inertness PROVEN (v2 object
     instruction stream byte-identical; .text length/relocs/checksum
     identical with only the .debug$S checksum moved; candidate DLL
     disassembly identical to the retained accepted 5C dump; every differing
     raw byte accounted for by name). Identity remains 0.1.0-dev+5C.
     5C-RAT-7 is DISCHARGED and removed from the registered follow-up list.
     REMAINING registered follow-up: the identifier-cleanup hygiene pass
     (next), then the deferred quality phase (T-1), the bounded float step,
     and Deblock4 stages 4D/5D.
     LESSON RECORDED (M1-W3C-F1, for future proof design): raw whole-file
     binary identity is NOT a valid inertness predicate for any change that
     moves source lines, because object and image formats retain
     source-location and debug records. Use instruction-stream identity plus
     structural comparison instead - it discriminates executable content
     better, since raw comparison conflates instructions with metadata and
     cannot say which moved. A gate that can only be passed by defeating its
     own scope is a broken gate; W3C correctly refused to reinterpret the
     failure as a pass, and the specification, not the delivery, was
     corrected.
v1.3 (2026-08-15) Stage 5C closeout: Project Status to v1_27 (5C accepted,
     benchmark recorded), Forward Roadmap to v1_20 (Classic vector arc
     complete), D0 Binding Knowledge Index to v1_14 (K33 V1-terminal fact,
     K34 measured bandwidth/vertical-path bound). Stage 5C scope v1_2, the
     W3D pre-implementation review, findings F1/F2 and the accepted W3C
     delivery/manifest join the per-stage authority set. Registered post-5C
     follow-ups: v2-unit commentary reconciliation (5C-RAT-7); the
     identifier-cleanup hygiene pass.
v1.2 (2026-08-14) Second-pass advance (W3C second orientation review):
     charter to v1_29 (C-DELIV-03 phrase completion), coder intro to v1_27
     (stale-pin sweep + orphaned 1C handover tail excised); fixed the
     section-4 "MPEG-2 Grid Knowledge v1_1" typo (correct: v1_2) - a W3D
     miss in v1.1, caught by W3C. GAIS rename and Scopes/4C folder moves
     remain pending W3X manual housekeeping.
v1.1 (2026-08-14) References advanced after the eight-file recovery batch
     (charter v1_28; roadmap v1_19; README v1_12; bootstrap v1_1; coder
     intro v1_26; MPEG-2 knowledge v1_2 + the GAIS capture file; GAIS
     rename recorded in housekeeping). Fixed the erroneous "Session
     Bootstrap Header v1_2" reference (correct: v1_1). Issued as v1.1
     rather than a same-version reissue, per immutable-version discipline.
v1.0 (2026-08-13) First full-tree currency audit, performed at W3X request
     after Stage 4C acceptance. Five documents updated, thirteen verified
     current, housekeeping enumerated, 5C handover list included.
```

---

*Revision history addendum*
```text
v1.5 (2026-08-18) Staleness banner applied per the ratified decision DEC-05,
     which approved it and which had gone undischarged. NO CONTENT WAS
     ADJUDICATED, changed or retired: the banner records that the document is
     known stale and in scope for the T1 sweep, and explicitly states that it
     is not an adjudication and not permission to skip the document.
```
