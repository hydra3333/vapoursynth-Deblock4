# Deblock4 - T1S01a5 Corpus Manifest (the W3X common base)

**Deliverable:** T1S01a5_A - CORPUS MANIFEST
**Version:** 1.4 - regenerated against the W3X-supplied COMMON BASE
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Base:** the `dev_documentation.zip` W3X supplied as the common base for
W3C and W3D. This file describes THAT tree and no other.
**Encoding:** US-ASCII; CRLF.

---

# 0. WHAT THE COMMON BASE CHANGED, AND WHAT IT DID NOT

```text
THE POPULATION IS 101, NOT 87 AND NOT 94. Applying DEC-60 to the common
base gives 543 files, 442 excluded, 101 searchable. W3D's earlier manifests
described an 87-file tree; W3C measured 94 on the tree it held. All three
numbers were honest measurements of three different trees. This one is the
common base and supersedes both.

THE DELTA IS ENTIRELY T1's OWN PAPERWORK. Against the tree W3D searched:
    17 files added - EVERY ONE a T1 sweep artifact
     3 files removed - all superseded a3/a4 covering notes
     0 files added outside T1/
Of the 84 shared files, exactly TWO differ in content, and both differences
are the same two-character typo fix: 'confluct' -> 'conflIct' in
222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt and
222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt. Neither touches an a5 finding.
NOTED FOR W3X, NOT AS A BLOCKER: both were edited IN PLACE without a
version bump, which the project's immutable-version discipline would
normally forbid. Recorded so it is not later mistaken for corruption.

THE T1 FOLDER NOW HOLDS MULTIPLE LIVE GENERATIONS OF ITS OWN ARTIFACTS:
five task register generations (v1.21 to v1.25), four resume brief
generations INCLUDING a download duplicate named `... v1_6 (1).md`, four a5
ledger generations, three a5 corpus manifest generations. W3C's option A -
retire superseded T1 generations under a `superseded` tree - has not been
applied. DEC-60 would then exclude them mechanically.
```

# 1. THE POPULATION RULE (register DEC-60)

```text
A file is EXCLUDED if ANY folder in its path has a name beginning
"superseded" or "scheduled_for_deletion". Everything else is IN.

    543  files in the common base
    442  excluded, in five folders: superseded/, Scopes/superseded/,
         T1/superseded/, reference/superseded_do_not_use_files_in_this_folder/,
         reviews/scheduled_for_deletion/
    101  SEARCH POPULATION
```

# 2. THE QUESTION THE COMMON BASE MAKES UNAVOIDABLE

```text
Of the 101, 45 are T1 SWEEP ARTIFACTS - ledgers, covering notes, corpus
manifests, coder responses, the task register, the resume brief and the
review scope. Those documents QUOTE the authority's propositions in order to
adjudicate them. The remaining 56 ASSERT propositions to a reader.

W3D RE-TESTED EVERY CURRENT-UNIQUE CLAIM AGAINST BOTH POPULATIONS, using
WHITESPACE-NORMALISED matching because the authority wraps sentences across
lines and raw line matching silently returns zero. Result:

    claim                         asserting copies    sweep-artifact copies
    LED-034 four-layer taxonomy          1                    4
    LED-039 row pitch symbol             1                    4
    LED-044 F6 knowledge limit           1                    4
    LED-047 provenance audit result      1                    4
    LED-053 no phase ambiguity           1                    4
    LED-056 absorption record            1                    4
    LED-060 P4 negative result           1                    4
    LED-052a retirement record           1                    4
    LED-037 audit claim                  1                    4

EVERY UNIQUENESS CLAIM HOLDS IN THE ASSERTING POPULATION. And the recurring
"4" is not four other documents - it is the a5 ledger itself, generations
v1.0, v1.1, v1.2 and v1.3, quoting the sentence it adjudicates.
THAT IS THE WHOLE OF Q7 IN ONE COLUMN. Under a reading where a quotation
counts as a copy, this ledger refutes its own entries four times over, and
the count rises by one with every reissue.

ONE PROBE NEEDS ITS RESULT STATED PRECISELY RATHER THAN AS A NUMBER.
LED-062's probe is the literal patent number `US 6,633,612`, which appears
in 7 asserting files - the GAIS answer files and the Scopes verification
briefs. That is NOT a contradiction of LED-062: the entry claims uniqueness
for the CORRECTED ATTRIBUTION TABLE, not for the patent numbers, and its
SWEPT field already records that the numbers appear in the GAIS and Scopes
evidence as the original claims and the verification work. The probe tests
a different proposition from the one the entry disposes of.
```

# 3. The population - compare this against your copy of the common base

```text
LINES   SHA-256 (16)      KD  PATH
KD = A for a document that ASSERTS, S for a T1 SWEEP ARTIFACT that quotes.
The A/S split is W3D's PROPOSAL under Q7 and is NOT ratified; it is shown
so W3C can test the classification file by file rather than in the abstract.

    60  9588f696976181f6  A   000_Instructions_to_coder_for_creating_New_Chat_Introduction_for_coder.txt
   111  6839adaacc38f4ae  A   000_Instructions_to_designer_for_creating_New_Chat_Introduction_for_designer.md
  1018  23eb5bd8f145a6a8  A   111_New_Chat_Introduction_for_Coder_v1_33.md
   914  626dfdbd33a41020  A   111_New_Chat_Introduction_for_Designer_v1_28.md
   219  b70e61e4e199158c  A   222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
   246  e4ca6c07c1266a05  A   222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
   120  cd504d5ac121ccf2  A   333_W3X_Coder_Communication_Convention_v1_0.md
   155  a19c96cdeb8fc39e  A   333_W3X_Designer_Communication_Convention_v1_1.md
  2631  f1aec8c3dadcbf74  A   AI_Charter_and_Invariants_Card_v1_31.md
   421  05abc6228867c4fe  A   Deblock4_Concise_Project_Summary_v1.5.md
   661  bd12fdcd0179e258  A   Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_4.md
   139  45f13086f39d7900  A   Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
   116  a30dfc66f06bbed3  A   Deblock4_Designer_Chat_2_Death_Resume_Brief_v1_0.md
   276  08c94f1e65c13a61  A   Deblock4_Documentation_Currency_Audit_v1_6.md
   299  bc95be01b55e750b  A   Deblock4_Forward_Roadmap_v1_22.md
  1983  6f5cabf2c5b160ff  A   Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
   317  956e1e71add74fac  A   Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
  1728  a3f597950ed8f66f  A   Deblock4_Project_Status_v1_32.md
    50  25a07b4345203645  A   Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
   883  37806b9b66f47622  A   Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
   135  161cb5343fb5539a  A   Deblock4_Session_Bootstrap_Header_v1_3.md
   143  25c7b1ef1ab9a687  A   Deblock4_Session_State_Stage_1B3_v1_0.md
   111  ef3641295e9bad4d  A   Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1.md
   222  aa99ff2017df91dd  A   Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
   266  655aa23a10cdddb6  A   Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1.md
   630  7254cd80e2fd4055  A   Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md
   420  c1b1f110f32563c1  A   Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md
    46  b1ea44173476f4bc  A   Deblock4_Toolchain_Findings_F6_Addendum_for_v1_2.md
   534  ab89dfba62870fd6  A   Deblock4_Toolchain_Findings_v1_4.md
   879  66033d343afc9c05  A   Deblock4_Verification_And_Tiering_Decisions_v1_11.md
   267  2460e92b60ee088b  A   GAIS_GATING_RESPONSE.txt
    73  a4a4cf845c935826  A   GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt
   114  8119bfe2e2897381  A   GAIS_investigations/Deblock4_GAIS_Followup_Critique_and_Refined_Questions_v1_0.md
   115  1021f88223cb2393  A   GAIS_investigations/Deblock4_GAIS_Followup_Critique_and_Refined_Questions_v1_0_ANSWER.md
   204  e09f8476a9fd1cec  A   GAIS_investigations/Deblock4_GAIS_Investigation_Brief_ChromaFieldGeometry_and_PriorArt_v1_0.md
   241  072f6707f426374e  A   GAIS_investigations/Deblock4_GAIS_Investigation_Brief_ChromaFieldGeometry_and_PriorArt_v1_0_ANSWER.md
   100  61801b0c83154ca1  A   GAIS_investigations/Deblock4_GAIS_OptionSpace_Request_v1_0.md
   167  e0df7887e97ed815  A   GAIS_investigations/Deblock4_GAIS_OptionSpace_Request_v1_0_ANSWER.md
  3792  c671b5f145cf0653  A   README_Deblock4_Design_Spec_v1_12.md
   213  0c35aa3ae729a446  A   Scopes/Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
  1088  60b646a7d246cbd3  A   Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
   255  ce6544126eec6e65  A   Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md
  1020  d97baaef40622f3b  A   Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
    98  af73a672d70892a1  A   Scopes/Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md
   143  020d854c1ff8f160  A   Scopes/Deblock4_D4_Verification_Round_Brief_for_W3C_v1_1.md
   353  57f7f8e1d2daffd5  A   Scopes/Deblock4_T1_W3C_Review_Scope_v1_1_W3C_Review_v1_0.md
   826  ab7f535dc83e125c  A   Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
  2060  5646d84d47589c57  S   T1/Deblock4_Standing_Task_Register_T_Series_v1_21.md
  2267  ca563d2d0b86774b  S   T1/Deblock4_Standing_Task_Register_T_Series_v1_22.md
  2311  c67ea213713a0fbe  S   T1/Deblock4_Standing_Task_Register_T_Series_v1_23.md
  2383  d40152518f3b5772  S   T1/Deblock4_Standing_Task_Register_T_Series_v1_24.md
  2461  4c1d3210c58fac06  S   T1/Deblock4_Standing_Task_Register_T_Series_v1_25.md
   711  cf510b655ffdb210  S   T1/Deblock4_T1_Resume_Brief_v1_5.md
   823  6663bd105cb3f5ab  S   T1/Deblock4_T1_Resume_Brief_v1_6 (1).md
   823  6663bd105cb3f5ab  S   T1/Deblock4_T1_Resume_Brief_v1_6.md
   834  510159605fb3d947  S   T1/Deblock4_T1_Resume_Brief_v1_7.md
  1094  1643286dd0285489  S   T1/Deblock4_T1_W3C_Review_Scope_v1_11.md
   264  cbba7825f2a71a0f  A   T1/Deblock4_W3D_Advice_T1S01a3_Position_v1_0.md
   257  4bd65e58a82842c1  A   T1/Deblock4_W3D_Handover_Answers_Q2_Q4_v1_1.md
   757  c0f01ff4cc0133ad  S   T1/T1S00_A_Scope_Manifest_v1_4.md
   179  6414dc48f3d58d62  S   T1/T1S00_A_v4.zip
   112  441aab434aef894a  S   T1/T1S01a1_A_Designer_Batch.zip
    32  58068911c8708db6  S   T1/T1S01a1_B_Coder_Response.zip
   493  b3b8bf71746d9a60  S   T1/T1S01a2_A_Ledger_Currency_Statements_v1_1.md
   357  3243d4ed631af0be  S   T1/T1S01a2_A_Ledger_Orientation_Layer_v1_0.md
    30  7f6651acb461e607  S   T1/T1S01a2_B_Coder_Response.zip
   169  03426d0b06e70945  S   T1/T1S01a3_A_Covering_Note_for_W3C_v1_3.md
   329  e32e8b2a0f08bf20  S   T1/T1S01a3_A_Designer_Batch.zip
   256  758987d59dcade93  S   T1/T1S01a3_A_Designer_Batch_v2.zip
   303  a4968a150151fce0  S   T1/T1S01a3_A_Designer_Batch_v4.zip
   954  e4362bd44dfe5a18  S   T1/T1S01a3_A_Ledger_Architecture_Summary_v1_4.md
    33  6a041989a2ab607a  S   T1/T1S01a3_B_Coder_Response.zip
   369  d11daca0d08a9049  S   T1/T1S01a3_B_Coder_Response_v1_1.md
    11  d9fe2599ddf3b437  S   T1/T1S01a3_B_Coder_Response_v1_2.zip
   308  84accbe761d4faa1  S   T1/T1S01a4_A_Covering_Note_for_W3C_v1_4.md
   251  c87af7f6f63ec437  S   T1/T1S01a4_A_Designer_Batch_v2.zip
   301  0184908c23147f6c  S   T1/T1S01a4_A_Designer_Batch_v3.zip
   299  cd5660333fc3a5ad  S   T1/T1S01a4_A_Designer_Batch_v4.zip
   324  f485a5fff79767ce  S   T1/T1S01a4_A_Designer_Batch_v5.zip
   792  1c1abe50b0ef93a8  S   T1/T1S01a4_A_Ledger_Section23_Tail_v1_4.md
    19  a013cf5bf770b7d7  S   T1/T1S01a4_B_Coder_Response_v1_0.zip
    33  b3abf84ebe43a6d7  S   T1/T1S01a4_B_Coder_Response_v1_1.zip
    20  984b5a8acb17a985  S   T1/T1S01a4_B_Coder_Response_v1_2.zip
    15  1b0bb01aaa1d82c8  S   T1/T1S01a4_B_Coder_Response_v1_3.zip
   197  e0b443bf2697c932  S   T1/T1S01a5_A_Corpus_Manifest_v1_0.md
   197  d80e11777a296af9  S   T1/T1S01a5_A_Corpus_Manifest_v1_1.md
   204  67389f11ca8caed1  S   T1/T1S01a5_A_Corpus_Manifest_v1_2.md
   533  8d5b94fa3ea5658d  S   T1/T1S01a5_A_Covering_Note_for_W3C_v1_3.md
   501  21d17117858cc3c6  S   T1/T1S01a5_A_Designer_Batch_v5.zip
  2337  01fa3f2492eadf5c  S   T1/T1S01a5_A_Ledger_Body_Part1_v1_0.md
  2387  edcece543b094d32  S   T1/T1S01a5_A_Ledger_Body_Part1_v1_1.md
  2445  10a054be10dfe48d  S   T1/T1S01a5_A_Ledger_Body_Part1_v1_2.md
  2584  38b8aeaf89d60933  S   T1/T1S01a5_A_Ledger_Body_Part1_v1_3.md
    11  e1cb8fc461435592  S   T1/T1S01a5_B_Coder_Response_v1_0.zip
    32  e19a9d3494f8f75f  A   T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
   339  39db8f9acf036595  A   reference/holywu_r9/LICENSE
   124  dcccdf7687eb83ab  A   reference/holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
     4  6e926b08cfdede69  A   reference/holywu_r9/SHA256SUMS.txt
   448  600585ee46c783db  A   reference/holywu_r9/deblock.cpp
    17  6d59551e80b1f2e6  A   reference/holywu_r9/deblock.h
   169  43249d76636f8255  A   reference/holywu_r9/deblock_sse4.cpp

TOTAL SEARCHABLE: 101   ASSERTING: 56   SWEEP ARTIFACTS: 45
```

# 4. The two T1 files that are NOT sweep artifacts

```text
    T1/Deblock4_W3D_Advice_T1S01a3_Position_v1_0.md
    T1/Deblock4_W3D_Handover_Answers_Q2_Q4_v1_1.md
These are designer ADVICE documents that happen to live in T1/. They are
classified A because they state positions to a reader rather than quoting
text in order to adjudicate it. THEY ARE THE EDGE CASE ANY ASSERT-VERSUS-
QUOTE RULE MUST GET RIGHT, and W3C should test that classification first.
```

# 5. Source tree

```text
Unchanged. NO CODE HAS CHANGED during T1; identity remains 0.1.0-dev+5C and
all three deblock4.Deblock4 dispatch arms remain pass-through writable
copies. No a5 entry rests on a source claim.
```
