# Deblock4 - Stage 2C Issuance Bundle Manifest (successor W3C session)

**Deliverable:** W3D-2C-BUNDLE-MANIFEST
**Version:** 1.2
**Date:** 2026-08-05
**Author:** W3D
**Status:** v1.1 reissue after the pre-implementation review round. The
attachment guide for issuing the corrected Stage 2C set (D4 v1_9) to W3C
ahead of IMPLEMENTATION RELEASE, per charter I2. The coder cannot reach the github
repository, so the bundle must be fully self-contained. PACKAGING RULE
(W3X-ratified 2026-08-05, Q7): packaging follows W3X's practice - the
READER-SIDE rules carry the weight. Whole-tree zips MAY include superseded
folders (the coder NEVER reads them); archive filenames are NOT pinned
(the base is identified by CONTENT); superseded generations may transiently
coexist (highest version prevails, 2.3a); the archive count is not pinned
and the bootstrap header may travel inside an archive.
**Encoding:** US-ASCII; CRLF.

---

# 1. What W3X does with this manifest

1. Save the corrected set into the repo at the paths in section 2 (prior
   generations move to superseded folders at leisure); complete the
   <W3X: ...> field in the bootstrap header. Place the review-record
   files under dev_documentation/reviews/ (NOT scheduled_for_deletion -
   W3C F5e).
2. Attach the section-3 set to the W3C chat with the section-4 message.
   All re-review findings are resolved by these line-focused
   corrections; a short W3C confirmation over the corrected lines is
   all that is asked (its own disposition requested only the W3D
   amendment + W3X decision).
3. EXPLICITLY RELEASE IMPLEMENTATION when satisfied (a separate W3X act
   from scope release).

# 2. New/updated repository files from this W3D delivery

```text
dev_documentation/reference/Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_9.md
dev_documentation/reference/Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_11.md
dev_documentation/reference/Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_10.md
dev_documentation/Deblock4_Stage_2C_Session_Bootstrap_Header_v1_2.md
dev_documentation/Deblock4_Stage_2C_Issuance_Bundle_Manifest_v1_2.md
dev_documentation/Deblock4_Project_Status_v1_23.md
dev_documentation/Deblock4_Toolchain_Findings_v1_4.md
dev_documentation/reviews/Deblock4_Stage_2C_D4_v1_7_Formal_Preimplementation_Review_W3C_v1_0.md
dev_documentation/reviews/Deblock4_W3D_Response_to_W3C_Stage_2C_Preimplementation_Review_v1_1.md
dev_documentation/reviews/Deblock4_Stage_2C_D4_v1_8_Focused_Rereview_W3C_v1_0.md
dev_documentation/reviews/Deblock4_W3D_Response_to_W3C_Focused_Rereview_v1_0.md
dev_documentation/333_W3X_Designer_Communication_Convention_v1_0.md
```

# 3. The attachment list for the new W3C chat

RECOMMENDED PACKAGING: two zips plus the bootstrap header as a loose file,
mirroring the repository layout so the coder's knowledge sweep can search
one attached documentation tree.

```text
ATTACHMENT 1 (loose file, first):
  Deblock4_Stage_2C_Session_Bootstrap_Header_v1_2.md   [W3X field filled;
      may instead travel inside an archive per the Q7 packaging rule]

ATTACHMENT 2 (dev_documentation.zip - the documentation tree; superseded
folders MAY be present per the Q7 rule - the coder NEVER reads them and
always uses the highest non-superseded version of each document):
  CONTROLLING (the README is FALLBACK GUIDANCE per the ratified authority
  wording carried in the bootstrap/D0/D4 headers):
    AI_Charter_and_Invariants_Card_v1_26.md
    README_Deblock4_Design_Spec_v1_9.md   [fallback general guidance]
    reference/Deblock4_Creation_Error_Message_Table_v1_6.md
  THE RELEASED 2C AUTHORITY SET (read together per charter 2.3a; each
  member at its own declared authority):
    reference/Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_9.md
    reference/Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_10.md
    reference/Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_2.md
    reference/Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_2.md
    reference/Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_11.md
    reference/Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_6.md
    reference/holywu_r9/  (all five files BYTE-EXACT: deblock.cpp,
        deblock.h, deblock_sse4.cpp, LICENSE, SHA256SUMS.txt, plus
        README_provenance_v1_4__replaces_holywu_r9_README_provenance.md)
        NOTE: zip transport preserves bytes; remind the coder the snapshot
        files are LF-intact and READ-ONLY (H0).
  KNOWLEDGE SET (informative; the domain of the section-0 sweep):
    Deblock4_Verification_And_Tiering_Decisions_v1_10.md
    Deblock4_Toolchain_Findings_v1_4.md
    Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
    Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
    Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md   (2D material; K11
        keeps it OUT of Classic - included so the sweep can confirm that)
    Deblock4_Project_Status_v1_23.md
    Deblock4_Forward_Roadmap_v1_17.md
    333_W3X_Designer_Communication_Convention_v1_0.md
    reviews/Deblock4_Stage_2C_D4_v1_7_Formal_Preimplementation_Review_W3C_v1_0.md
    reviews/Deblock4_W3D_Response_to_W3C_Stage_2C_Preimplementation_Review_v1_1.md
    reviews/Deblock4_Stage_2C_D4_v1_8_Focused_Rereview_W3C_v1_0.md
    reviews/Deblock4_W3D_Response_to_W3C_Focused_Rereview_v1_0.md
        NOTE: review-record files capture positions AS PUT at their
        date; the RATIFIED ISSUED SET PREVAILS on any difference.
        Known post-ratification deltas: the reason token was W3X-
        amended to intentionally-capped after response v1_1, and
        the K31 wording was enriched (byte-row default, @divExact,
        HolyWu/zsmooth survey) after response v1_0 - see the D4
        v1_8/v1_9 revision notes and status v1_23 section 0.
    Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1.md (historical
        1C baseline the v1_6 table extends; optional)
    111_New_Chat_Introduction_for_Coder_v1_20.md
        CAVEAT TO STATE AT ISSUANCE: its IMMEDIATE NEXT ACTION block is
        STALE (still describes the closed Stage 1C G6 fix). The bootstrap
        header and D4 v1_9 prevail on current state; the intro's value is
        its rules-of-engagement and tacit-knowledge history.

ATTACHMENT 3 (src.zip - the exact prevailing source tree, named in the
bootstrap header's Starting commit field):
    the Stage 1C + rider 1C.1 accepted tree in full (src/, tests/, tools/,
    third_party/vapoursynth/include/, build.zig, build.zig.zon,
    build_1C_v1.bat, .gitignore)
```

# 4. Suggested issuance message to the coder (adapt freely)

```text
Your focused re-review v1_0 is resolved: W3X ratified all six decisions
in the attached W3D response (F1 T-S5-1a/1b split; F2 detection-LOGIC
consistency + the (a)-(e) exception form in D0/D4; F3 the narrow
non-cleanup K30 audit contract - accepted Stage 1C identifiers are NOT
renamed, they are gate-asserted by the re-executed matrix; F4 the K31
per-model proof - byte-row navigation recommended default, @divExact or
modulo assertion for the typed model, unit-suffix naming idiom, silent
division named forbidden with the HolyWu/zsmooth survey cited; F5a-d
issuance cleanups; F5e filing corrected). The corrected set is attached:
D4 v1_9, D0 v1_11, D3 v1_10 (mirror only), bootstrap v1_2, manifest
v1_2, status v1_23. Confirm the corrected lines match your required
corrections - a short acknowledgement suffices, no re-derivation of
anything - and stop. W3X's explicit IMPLEMENTATION RELEASE follows.
```

# 5. Known cosmetic lags (recorded so nobody burns a finding on them)

```text
- (RESOLVED this round: the D3 "(D0 v1_8)" heading lag - fixed by the D3
  v1_9 reissue chosen at W3X Q9.)
- 111_New_Chat_Introduction_for_Coder_v1_20 IMMEDIATE NEXT ACTION is
  stale (Stage 1C era) - see the caveat in section 3. Refresh is deferred
  until after the 2C delivery lands (W3X call, 2026-08-03).
- Deblock4_Forward_Roadmap_v1_17 and Deblock4_Concise_Project_Summary_v1.2
  predate the 2C release; Project Status v1_23 section 0 prevails on
  current state (v1_22 at this issuance).
```

# 6. Binding Knowledge Checklist (D0 v1_11)

```text
K17  the bundle is SELF-CONTAINED for a memoryless session; superseded
     folders are excluded from the sweep domain by the READER-side rule
     (Q7 packaging ruling); holywu_r9 ships byte-exact with SHA256SUMS.
K26  the snapshot travels with its provenance v1_4; the reference-build
     record remains a separate W3X-generated artefact (not in this
     bundle - it does not exist yet).
D0 s6  the issuance message makes the two-sided sweep the coder's FIRST
     action, before implementation.
I2   every item the charter's session package requires is present:
     header, charter, README, scope + read-together set, source tree,
     test/harness contracts (D3 + Addenda + error table).
```
