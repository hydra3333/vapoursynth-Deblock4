# Deblock4 - T1S01a5 Corpus Manifest (the population W3D searched)

**Deliverable:** T1S01a5_A - CORPUS MANIFEST
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Purpose:** W3C stopped the a5 review because it could not reproduce
this ledger's whole-corpus searches against the corpus generation it
holds. That was correct. This manifest states EXACTLY which files and
which bytes W3D searched, so a discrepancy is detectable by comparison
rather than arguable from memory.
**Encoding:** US-ASCII; CRLF.

---

# 0. How to use this

```text
W3X supplies the current dev_documentation zip. BEFORE reviewing, compare
the SHA-256 digests below against the supplied tree. Any file whose digest
differs, or that is present in one and absent in the other, is a
population difference that could change a SWEPT result - and should be
reported rather than reconciled silently.

EXPECTED DIFFERENCES, so they are not reported as defects: the task
register and the T1 resume brief have advanced to v1.23 and v1.6 in the
a5 batch. Those two files, plus the a5 ledger, covering note and this
manifest, are the only artifacts that post-date the snapshot below.

EXCLUDED FROM THIS LIST, per manifest T1S00 section 2: superseded/,
Scopes/superseded/, reference/superseded_do_not_use_files_in_this_folder/
and reviews/scheduled_for_deletion/. They are not part of the search
population and no SWEPT field in the a5 ledger searched them.

124 FILES HERE VERSUS THE MANIFEST'S 47 DOCUMENTS - THE TWO NUMBERS MEASURE
DIFFERENT THINGS AND SHOULD NOT BE RECONCILED.
    47   the ADJUDICATION population: what T1 gives a disposition to. It
         excludes T1's own process artifacts (T1S00 section 2.0a), the pinned
         HolyWu source (2.0b) and the evidence zip (2.0c).
    124  the SEARCH population: every live file the a5 SWEPT fields actually
         ran across. It is deliberately WIDER, because a duplication or
         uniqueness claim must be tested against everything that exists, not
         only against what T1 will disposition. A copy sitting in a T1
         process artifact is still a copy for the purpose of testing a
         uniqueness claim - it just does not receive its own entry.
WHERE THE a5 ENTRIES RELY ON THAT DISTINCTION they say so explicitly, by
excluding T1 process artifacts from a count after including them in a search.
LED-035 is the clearest example.
```

---

# 1. The searched population

```text
LINES   SHA-256 (16)      PATH
    60  9588f696976181f6  000_Instructions_to_coder_for_creating_New_Chat_Introduction_for_coder.txt
   111  6839adaacc38f4ae  000_Instructions_to_designer_for_creating_New_Chat_Introduction_for_designer.md
  1018  23eb5bd8f145a6a8  111_New_Chat_Introduction_for_Coder_v1_33.md
   914  626dfdbd33a41020  111_New_Chat_Introduction_for_Designer_v1_28.md
   219  0843dde5f6d96bed  222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
   246  fdc4ab2fd9156619  222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
   120  cd504d5ac121ccf2  333_W3X_Coder_Communication_Convention_v1_0.md
   155  a19c96cdeb8fc39e  333_W3X_Designer_Communication_Convention_v1_1.md
  2631  f1aec8c3dadcbf74  AI_Charter_and_Invariants_Card_v1_31.md
   421  05abc6228867c4fe  Deblock4_Concise_Project_Summary_v1.5.md
   661  bd12fdcd0179e258  Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_4.md
   139  45f13086f39d7900  Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
   116  a30dfc66f06bbed3  Deblock4_Designer_Chat_2_Death_Resume_Brief_v1_0.md
   276  08c94f1e65c13a61  Deblock4_Documentation_Currency_Audit_v1_6.md
   299  bc95be01b55e750b  Deblock4_Forward_Roadmap_v1_22.md
  1983  6f5cabf2c5b160ff  Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
   317  956e1e71add74fac  Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
  1728  a3f597950ed8f66f  Deblock4_Project_Status_v1_32.md
    50  25a07b4345203645  Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
   883  37806b9b66f47622  Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
   135  161cb5343fb5539a  Deblock4_Session_Bootstrap_Header_v1_3.md
   143  25c7b1ef1ab9a687  Deblock4_Session_State_Stage_1B3_v1_0.md
   111  ef3641295e9bad4d  Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1.md
   222  aa99ff2017df91dd  Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
   266  655aa23a10cdddb6  Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1.md
   630  7254cd80e2fd4055  Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md
   420  c1b1f110f32563c1  Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md
    46  b1ea44173476f4bc  Deblock4_Toolchain_Findings_F6_Addendum_for_v1_2.md
   534  ab89dfba62870fd6  Deblock4_Toolchain_Findings_v1_4.md
   879  66033d343afc9c05  Deblock4_Verification_And_Tiering_Decisions_v1_11.md
   267  2460e92b60ee088b  GAIS_GATING_RESPONSE.txt
    73  a4a4cf845c935826  GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt
   114  8119bfe2e2897381  GAIS_investigations/Deblock4_GAIS_Followup_Critique_and_Refined_Questions_v1_0.md
   115  1021f88223cb2393  GAIS_investigations/Deblock4_GAIS_Followup_Critique_and_Refined_Questions_v1_0_ANSWER.md
   204  e09f8476a9fd1cec  GAIS_investigations/Deblock4_GAIS_Investigation_Brief_ChromaFieldGeometry_and_PriorArt_v1_0.md
   241  072f6707f426374e  GAIS_investigations/Deblock4_GAIS_Investigation_Brief_ChromaFieldGeometry_and_PriorArt_v1_0_ANSWER.md
   100  61801b0c83154ca1  GAIS_investigations/Deblock4_GAIS_OptionSpace_Request_v1_0.md
   167  e0df7887e97ed815  GAIS_investigations/Deblock4_GAIS_OptionSpace_Request_v1_0_ANSWER.md
  3792  c671b5f145cf0653  README_Deblock4_Design_Spec_v1_12.md
   213  0c35aa3ae729a446  Scopes/Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
  1088  60b646a7d246cbd3  Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
   255  ce6544126eec6e65  Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md
  1020  d97baaef40622f3b  Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
    98  af73a672d70892a1  Scopes/Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md
   143  020d854c1ff8f160  Scopes/Deblock4_D4_Verification_Round_Brief_for_W3C_v1_1.md
   353  57f7f8e1d2daffd5  Scopes/Deblock4_T1_W3C_Review_Scope_v1_1_W3C_Review_v1_0.md
   826  ab7f535dc83e125c  Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
  2060  5646d84d47589c57  T1/Deblock4_Standing_Task_Register_T_Series_v1_21.md
   711  cf510b655ffdb210  T1/Deblock4_T1_Resume_Brief_v1_5.md
  1094  1643286dd0285489  T1/Deblock4_T1_W3C_Review_Scope_v1_11.md
   264  cbba7825f2a71a0f  T1/Deblock4_W3D_Advice_T1S01a3_Position_v1_0.md
   257  4bd65e58a82842c1  T1/Deblock4_W3D_Handover_Answers_Q2_Q4_v1_1.md
   757  c0f01ff4cc0133ad  T1/T1S00_A_Scope_Manifest_v1_4.md
   179  6414dc48f3d58d62  T1/T1S00_A_v4.zip
   112  441aab434aef894a  T1/T1S01a1_A_Designer_Batch.zip
    32  58068911c8708db6  T1/T1S01a1_B_Coder_Response.zip
   493  b3b8bf71746d9a60  T1/T1S01a2_A_Ledger_Currency_Statements_v1_1.md
   357  3243d4ed631af0be  T1/T1S01a2_A_Ledger_Orientation_Layer_v1_0.md
    30  7f6651acb461e607  T1/T1S01a2_B_Coder_Response.zip
   148  54b4fbaa37e6c17a  T1/T1S01a3_A_Covering_Note_for_W3C_v1_1.md
   169  03426d0b06e70945  T1/T1S01a3_A_Covering_Note_for_W3C_v1_3.md
   329  e32e8b2a0f08bf20  T1/T1S01a3_A_Designer_Batch.zip
   256  758987d59dcade93  T1/T1S01a3_A_Designer_Batch_v2.zip
   303  a4968a150151fce0  T1/T1S01a3_A_Designer_Batch_v4.zip
   954  e4362bd44dfe5a18  T1/T1S01a3_A_Ledger_Architecture_Summary_v1_4.md
    33  6a041989a2ab607a  T1/T1S01a3_B_Coder_Response.zip
   369  d11daca0d08a9049  T1/T1S01a3_B_Coder_Response_v1_1.md
    11  d9fe2599ddf3b437  T1/T1S01a3_B_Coder_Response_v1_2.zip
   258  ba5f3d487bfebcbb  T1/T1S01a4_A_Covering_Note_for_W3C_v1_2.md
   294  cceb357adfc2a5fc  T1/T1S01a4_A_Covering_Note_for_W3C_v1_3.md
   308  84accbe761d4faa1  T1/T1S01a4_A_Covering_Note_for_W3C_v1_4.md
   251  c87af7f6f63ec437  T1/T1S01a4_A_Designer_Batch_v2.zip
   301  0184908c23147f6c  T1/T1S01a4_A_Designer_Batch_v3.zip
   299  cd5660333fc3a5ad  T1/T1S01a4_A_Designer_Batch_v4.zip
   324  f485a5fff79767ce  T1/T1S01a4_A_Designer_Batch_v5.zip
   792  1c1abe50b0ef93a8  T1/T1S01a4_A_Ledger_Section23_Tail_v1_4.md
    19  a013cf5bf770b7d7  T1/T1S01a4_B_Coder_Response_v1_0.zip
    33  b3abf84ebe43a6d7  T1/T1S01a4_B_Coder_Response_v1_1.zip
    20  984b5a8acb17a985  T1/T1S01a4_B_Coder_Response_v1_2.zip
    15  1b0bb01aaa1d82c8  T1/T1S01a4_B_Coder_Response_v1_3.zip
  1336  d00452b18a847451  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_10.md
  1381  0329fdf00f863b11  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_11.md
  1455  5c9676f026822e7a  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_12.md
  1588  4d64b0415f39bab9  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_14.md
  1660  1b24983f178c8619  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_15.md
  1744  e287ce41f9afbaec  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_16.md
  1812  2fa26d8b01c7a03b  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_17.md
  1870  4c214b6a6039c6da  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_18.md
  1914  1ca30dcec65417f8  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_19.md
  1991  63fe9ece273a0939  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_20.md
  1000  1e0b5d415e549052  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_6.md
  1167  5ca3fbc677472d94  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_8.md
  1228  925b97e1f4174eb0  T1/superseded/Deblock4_Standing_Task_Register_T_Series_v1_9.md
   256  f33fff10a9320f34  T1/superseded/Deblock4_T1_Resume_Brief_v1_0.md
   446  79a7374a1ba06670  T1/superseded/Deblock4_T1_Resume_Brief_v1_1.md
   538  66442f0d693c73d5  T1/superseded/Deblock4_T1_Resume_Brief_v1_2.md
   599  0d1b7d6f5374d3dc  T1/superseded/Deblock4_T1_Resume_Brief_v1_3.md
   675  db6667adf58ca204  T1/superseded/Deblock4_T1_Resume_Brief_v1_4.md
  1041  611250cf93e9819d  T1/superseded/Deblock4_T1_W3C_Review_Scope_v1_10.md
   778  8fe4ea11a0950b61  T1/superseded/Deblock4_T1_W3C_Review_Scope_v1_6.md
   913  ae6522390c22147e  T1/superseded/Deblock4_T1_W3C_Review_Scope_v1_8.md
   979  7a5515532e95e3c9  T1/superseded/Deblock4_T1_W3C_Review_Scope_v1_9.md
   105  cf4aa6e82d8e7846  T1/superseded/T1S00_A.zip
   624  e279bf2457f2fc99  T1/superseded/T1S00_A_Scope_Manifest_v1_2.md
   732  43b6ae83fa954258  T1/superseded/T1S00_A_Scope_Manifest_v1_3.md
    67  b3e8cdeec42305b2  T1/superseded/T1S00_A_v1_5.zip
   173  2da55b84c8af3699  T1/superseded/T1S00_A_v2.zip
   179  6414dc48f3d58d62  T1/superseded/T1S00_A_v3.zip
   418  baf90afabacb82f1  T1/superseded/T1S00_B_Coder_Response_v1_0.md
    14  abfeed838d35cd2c  T1/superseded/T1S00_B_V3_Coder_Response.zip
    16  5014cd2f744b9db2  T1/superseded/T1S00_B_v2_Coder_Response.zip
   745  c1761f5ef9c96470  T1/superseded/T1S01a3_A_Ledger_Architecture_Summary_v1_1.md
   823  eeffa3d8d9735590  T1/superseded/T1S01a3_A_Ledger_Architecture_Summary_v1_2.md
   183  bb0c2b339cb11674  T1/superseded/T1S01a4_A_Covering_Note_for_W3C_v1_1.md
   580  8220441e9d4545d3  T1/superseded/T1S01a4_A_Ledger_Section23_Tail_v1_1.md
   651  6f9d0fe4c06856fb  T1/superseded/T1S01a4_A_Ledger_Section23_Tail_v1_2.md
   736  daf48def12b002fc  T1/superseded/T1S01a4_A_Ledger_Section23_Tail_v1_3.md
    32  e19a9d3494f8f75f  T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
   339  39db8f9acf036595  reference/holywu_r9/LICENSE
   124  dcccdf7687eb83ab  reference/holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
     4  6e926b08cfdede69  reference/holywu_r9/SHA256SUMS.txt
   448  600585ee46c783db  reference/holywu_r9/deblock.cpp
    17  6d59551e80b1f2e6  reference/holywu_r9/deblock.h
   169  43249d76636f8255  reference/holywu_r9/deblock_sse4.cpp

TOTAL FILES IN THE SEARCHED POPULATION: 124
```

---

# 2. Note on the source tree

```text
W3C reports it still holds the previously supplied source snapshot and
does not need it re-supplied. W3D confirms that is correct: NO CODE HAS
CHANGED during T1. Identity remains 0.1.0-dev+5C and all three
deblock4.Deblock4 dispatch arms remain pass-through writable copies,
verified cold in the supplied tree at src/deblock4_ar_all_frames_ready.zig
and src/deblock4_version.zig. No a5 entry rests on a source claim.
```
