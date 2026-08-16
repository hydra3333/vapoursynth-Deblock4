# Deblock4 - Stage 2C Issuance Bundle Manifest (successor W3C session)

**Deliverable:** W3D-2C-BUNDLE-MANIFEST
**Version:** 1.0
**Date:** 2026-08-03
**Author:** W3D
**Status:** For W3X. The exact attachment list for issuing the released
Stage 2C scope to the successor (memoryless) W3C session, per charter I2 and
the D4 v1_7 authority set. The coder cannot reach the github repository, so
the bundle must be fully self-contained.
**Encoding:** US-ASCII; CRLF.

---

# 1. What W3X does with this manifest

1. Ratify the D4 v1_7 hygiene reissue (its revision note records the three
   deltas and provenance; no technical change).
2. Save the four W3D-produced files into the repo at the paths in section 2,
   complete the two <W3X: ...> fields in the bootstrap header, commit at
   leisure (commit is not required before issuance - the attached tree is
   the base).
3. Attach the packages in section 3 to the new W3C chat, in the stated
   order, with the section 4 issuance message.

# 2. New/updated repository files from this W3D delivery

```text
dev_documentation/reference/Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_7.md
    REISSUE of v1_6 (move v1_6 to reference/superseded_do_not_use_... after
    ratification, per established practice).
dev_documentation/Deblock4_Stage_2C_Session_Bootstrap_Header_v1_0.md
    New. Complete the two <W3X: ...> fields before issuance.
dev_documentation/Deblock4_Stage_2C_Issuance_Bundle_Manifest_v1_0.md
    New. This file.
dev_documentation/Deblock4_Project_Status_v1_21.md
    REPLACES v1_20 (move v1_20 to superseded/). Records the 2C release,
    ratifications, register state, housekeeping, and this reissue.
```

# 3. The attachment list for the new W3C chat

RECOMMENDED PACKAGING: two zips plus the bootstrap header as a loose file,
mirroring the repository layout so the coder's knowledge sweep can search
one attached documentation tree.

```text
ATTACHMENT 1 (loose file, first):
  Deblock4_Stage_2C_Session_Bootstrap_Header_v1_0.md   [W3X fields filled]

ATTACHMENT 2 (dev_documentation.zip - the documentation tree EXCLUDING
every superseded folder; the D0 section-6 sweep explicitly excludes
superseded/ and attaching it would only mislead):
  CONTROLLING:
    AI_Charter_and_Invariants_Card_v1_26.md
    README_Deblock4_Design_Spec_v1_9.md
    reference/Deblock4_Creation_Error_Message_Table_v1_6.md
  THE RELEASED 2C AUTHORITY SET (read together per charter 2.3a; each
  member at its own declared authority):
    reference/Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_7.md
    reference/Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_8.md
    reference/Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_2.md
    reference/Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_2.md
    reference/Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_9.md
    reference/Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_6.md
    reference/holywu_r9/  (all five files BYTE-EXACT: deblock.cpp,
        deblock.h, deblock_sse4.cpp, LICENSE, SHA256SUMS.txt, plus
        README_provenance_v1_4__replaces_holywu_r9_README_provenance.md)
        NOTE: zip transport preserves bytes; remind the coder the snapshot
        files are LF-intact and READ-ONLY (H0).
  KNOWLEDGE SET (informative; the domain of the section-0 sweep):
    Deblock4_Verification_And_Tiering_Decisions_v1_10.md
    Deblock4_Toolchain_Findings_v1_3.md
    Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
    Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
    Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0.md   (2D material; K11
        keeps it OUT of Classic - included so the sweep can confirm that)
    Deblock4_Project_Status_v1_21.md
    Deblock4_Forward_Roadmap_v1_17.md
    Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1.md (historical
        1C baseline the v1_6 table extends; optional)
    111_New_Chat_Introduction_for_Coder_v1_20.md
        CAVEAT TO STATE AT ISSUANCE: its IMMEDIATE NEXT ACTION block is
        STALE (still describes the closed Stage 1C G6 fix). The bootstrap
        header and D4 v1_7 prevail on current state; the intro's value is
        its rules-of-engagement and tacit-knowledge history.

ATTACHMENT 3 (src.zip - the exact prevailing source tree, named in the
bootstrap header's Starting commit field):
    the Stage 1C + rider 1C.1 accepted tree in full (src/, tests/, tools/,
    third_party/vapoursynth/include/, build.zig, build.zig.zon,
    build_1C_v1.bat, .gitignore)
```

# 4. Suggested issuance message to the coder (adapt freely)

```text
You are W3C for project Deblock4 (charter attached; read Part 1 first).
Attachment 1 is your completed session bootstrap header; it names the
active scope (D4 v1_7, RELEASED) and the exact attached source tree that
IS your base. Before ANY implementation: (1) perform the D4 section-0
independent knowledge sweep over the attached documentation tree
(excluding nothing - superseded folders are already omitted); (2) perform
the D4 section-11 mandatory pre-implementation review of the scope
together with D3 v1_8 and Addenda A/B v1_2, reporting numbered findings;
(3) independently verify D2 v1_6 against the byte-pinned holywu_r9
snapshot (hash-check SHA256SUMS.txt first). Report findings and stop; W3X
releases implementation after the review round resolves.
```

# 5. Known cosmetic lags (recorded so nobody burns a finding on them)

```text
- D3 v1_8 section-10 heading still reads "(D0 v1_8)". Content is current
  (its K16 already cites table v1_6); D0 v1_9's only deltas were pointer
  refreshes. Not reissued for a heading; fix at D3's next natural bump.
- 111_New_Chat_Introduction_for_Coder_v1_20 IMMEDIATE NEXT ACTION is
  stale (Stage 1C era) - see the caveat in section 3. Refresh is deferred
  until after the 2C delivery lands (W3X call, 2026-08-03).
- Deblock4_Forward_Roadmap_v1_17 and Deblock4_Concise_Project_Summary_v1.2
  predate the 2C release; Project Status v1_21 section 0 prevails on
  current state.
```

# 6. Binding Knowledge Checklist (D0 v1_9)

```text
K17  the bundle is SELF-CONTAINED for a memoryless session; superseded/
     is excluded from the sweep domain by omission; holywu_r9 ships
     byte-exact with its SHA256SUMS.
K26  the snapshot travels with its provenance v1_4; the reference-build
     record remains a separate W3X-generated artefact (not in this
     bundle - it does not exist yet).
D0 s6  the issuance message makes the two-sided sweep the coder's FIRST
     action, before implementation.
I2   every item the charter's session package requires is present:
     header, charter, README, scope + read-together set, source tree,
     test/harness contracts (D3 + Addenda + error table).
```
