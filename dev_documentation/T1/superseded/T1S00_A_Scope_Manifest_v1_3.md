# Deblock4 - T1 Step 00: Scope Manifest for the Documentation Consolidation Sweep

**Deliverable:** T1S00_A - SCOPE MANIFEST
**Version:** 1.3 - TERM SET FROZEN
**Date:** 2026-08-18
**Base snapshot:** the W3X-supplied dev_documentation zip AFTER the
supersession moves of 2026-08-18 (409 files). Every document present in the
pre-move snapshot was verified byte-identical; only file LOCATIONS changed,
plus the newly committed T1 artifacts.
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Status:** PROPOSED. Nothing here is adjudicated. This document defines WHAT
WILL BE SWEPT and HOW THE LIST WAS BUILT. No document below has been reviewed
for content yet; every one is UNADJUDICATED.
**Encoding:** US-ASCII; CRLF.

---

# 0. What this document is, and the one thing to check hardest

This is the list of every document T1 will read, and the search that produced
the list. It exists so the FRAME can be checked before any work happens inside
it. If a document is missing from this list, it will never be adjudicated - it
will not even be deliberately skipped. It will be invisible.

That is not a theoretical concern. Section 4 records that the previous survey
missed two entire live folders, and section 5 records what this one might
still miss.

```text
THE CHEAPEST MOMENT TO FIND A MISSING DOCUMENT IS NOW.
Read section 0.1 (how the list is built), section 3 (what is in scope) and
section 5 (known weaknesses) first.
```

## 0.1 POPULATION AND SEARCH ARE SEPARATE MECHANISMS

This is the single most important rule in the manifest, and v1.0/v1.1 stated
it only implicitly. Made formal here at W3C's recommendation:

```text
POPULATION - what gets swept:
    RECURSIVELY ENUMERATE every file in the supplied live documentation tree.
    Then apply ONLY explicit, recorded exclusions (section 2).
    The search does NOT build this list.

SEARCH - what gets found inside it:
    Run the registered term set (section 1) across that already-known
    population to locate candidate statements and to quantify coverage.
```

**Why this matters more than it looks.** If the search builds the population,
a zero-hit document silently disappears and a folder nobody thought to search
is invisible - which is exactly the failure PR-5 records. Under an
inventory-first rule, a document can only leave the population by an EXPLICIT
recorded exclusion that a reviewer can challenge.

It also changes the economics of the term set. Because the population no
longer depends on the terms, broadening the term set cannot add or lose
documents - it only finds more statements inside documents already in scope.
Over-inclusion therefore becomes close to free, which is why section 1 is as
broad as it is. This was verified mechanically: adding 39 further terms
changed the document population by ZERO.

---

# 1. The term set, stated verbatim

Run case-insensitively across every live document. A "hit" counts LINES
CONTAINING AT LEAST ONE TERM, not term occurrences. A dot is a regular
expression any-character, so `field.dct` matches "field-dct", "field DCT" and
"field_dct".

```text
GROUP 1 - format and standard names
    mpeg-2      mpeg2       h\.262      13818

GROUP 2 - coded structures
    dct_type            field.dct           frame.dct
    macroblock          16x16               8x8
    picture_structure   frame_pred_frame_dct
    progressive_frame   transform block

GROUP 3 - interlacing and field organisation
    interlac        field pictur    field-organis   field-organiz
    frame-organis   frame-organiz   weave           woven
    separatefields  top field       bottom field    parity

GROUP 4 - this project's grid vocabulary, including rejected mechanisms
    grid_mode   midpoint    edge_step
    luma_step   chroma_step pitch

GROUP 5 - architecture identifiers
    architecture a      architecture b      architecture d

GROUP 6 - chroma geometry
    4:2:0   4:2:2   4:4:4   chroma sit  subsampl

GROUP 7 - deblocking domain
    tc0     deblock

GROUP 8 - general geometry and scheduling
    \bgrid\b        \bdct\b          frame pictur    frame.coded
    field.coded     whole.frame     interleav       schedule
    processing order    block boundar    candidate edge
    topology        mixed.boundar

GROUP 9 - B2 / Q14 detector vocabulary
    \bB2\b      classifier      confidence      \bUNKNOWN\b
    NO_DCT      D4-Q            Q14

GROUP 10 - activation, correction and analyser vocabulary
    threshold       activat         alpha           beta
    full strength   half.correct    strength map    pre.pass
    unmodified source               fmparallel
    proper chroma   luma.on.chroma

GROUP 11 - known load-bearing residual topics
    grid origin     crop            nominal grid    grid.shift
    motion compens  MBAFF           regime

GROUP 12 - decisions and Q14 integrity vocabulary
    architecture c\b    D4-D            false.confident
    held.out            calibration     viab
    ground truth        per.MB          frame/field
```

## 1.0 THE TERM SET IS FROZEN AT 90 TERMS FOR THE DURATION OF T1

```text
Groups 1-12, 90 terms, are the registered search frame. It is FROZEN from
this version. Any later addition requires a recorded W3X decision AND a
re-scan of every already-adjudicated step against the added terms.
```

**Why freeze.** A search frame that moves during adjudication makes coverage
unprovable: step 1 was swept under one frame and step 4 under another, and no
one can say afterwards what was actually covered. This is the same discipline
that requires the detector mathematics to be frozen before Q14 measures them -
you do not move the instrument after you start reading it. W3C raised this and
it is right.

## 1.2 Groups 8-11 - added at W3C's recommendation, and measured before adoption

W3C's independent review found the original 42 terms good for finding
DOCUMENTS but insufficient for finding STATEMENTS, because a load-bearing
claim can be written entirely in schedule, detector, threshold, topology,
crop/origin or Q14 vocabulary without using any registered term on the same
line. T1's completion test is about every MPEG-2-bearing STATEMENT, not every
document, so that gap was real.

The proposal was tested rather than accepted on argument:

```text
DOCUMENT POPULATION CHANGE:  zero. The three zero-hit documents stay zero.
STATEMENT COVERAGE ADDED:    about 1,300 further hit lines across the live
                             corpus, including 269 more in the MPEG-2
                             authority and 240 more in the README - i.e. the
                             two documents the sweep most depends on.
```

That result is what makes the addition safe: it buys statement coverage at no
population cost. Deliberately NOT added, on W3C's own advice: bare `boundary`
and bare `detector`, which in this repository also describe delivery
boundaries and CPU feature detection and would bury the signal.

## 1.3 Group 12 - added after a second independent W3C scan, also measured

W3C's second pass found nine further terms carrying current architecture and
Q14-integrity vocabulary that none of the 81 matched. Measured on the
47-document population:

```text
DOCUMENT POPULATION CHANGE:  zero, again.
STATEMENT COVERAGE ADDED:    93 otherwise-unmatched lines, 63 of them inside
                             T1S01 documents.
```

W3D independently reproduced both figures exactly (81-term total 3,840 ->
90-term total 3,933). Two of the nine justify the group on their own:

```text
`architecture c\b`  Four live lines naming the REJECTED motion-classifier
                    Architecture C match no other term - including one in the
                    MPEG-2 authority itself and one in the re-decision brief.
                    A sweep that cannot find statements about a rejected
                    architecture is exactly the wrong blind spot for this
                    project to have.

`D4-D`              Of 45 live lines carrying ratified D4-D decision
                    identifiers, 23 match nothing else. Many are bare
                    references - "[D4-D01]", "[D4-D02, F7]", "[D4-D12]" -
                    lines whose entire content IS a ratified decision pointer
                    and which a vocabulary-based search cannot otherwise see.
                    (W3C counted 22; W3D reproduces 23. The difference is one
                    line and stems from slightly different corpus
                    generations. Immaterial, recorded rather than smoothed.)
```

The remaining seven - false-confident, held-out, calibration, viability,
ground truth, per-MB, FRAME/FIELD - are the vocabulary of the Q14 integrity
discipline itself: the anti-tuning separation, the independent viability bars,
and the per-macroblock truth extraction. Statements about how the experiment
must not be gamed are worth being able to find.

## 1.1 Why this set, and what was deliberately included

Rejected vocabulary is IN the set on purpose. `midpoint`, `grid_mode`,
`luma_step` and `architecture a` describe designs the project has abandoned -
which is exactly why the sweep must find every place they still appear as
though live.

Bare `8x8` and `macroblock` are included despite being noisy, because the
previous survey's own recorded weakness was that MPEG-2 material can be
discussed without using any obvious MPEG-2 word.

`parity`, `pitch` and `deblock` are the noisiest terms here and will produce
false hits in SIMD and build contexts. That cost is accepted: over-inclusion
costs reading time, under-inclusion costs a missed document.

---

# 2. What is EXCLUDED, and the one check run against it

```text
EXCLUDED AS AUTHORITY - four retired folders (contents grow as documents are
retired; the count is deliberately not pinned here, because a retired-file
tally goes stale every time W3X retires anything and none of it affects the
adjudication population):
    superseded/
    Scopes/superseded/
    reference/superseded_do_not_use_files_in_this_folder/
    reviews/scheduled_for_deletion/

These are history and evidence. They are NOT swept for current knowledge and
nothing in them is treated as live design authority.
```

RETIRED DURING T1 SETUP, recorded so the moves are auditable:
```text
  -> superseded/          Task Register generations superseded by the current
                          one (v1_0 through v1_4 at the time of writing; the
                          register family is excluded from adjudication at
                          2.0a in any case)
  -> Scopes/superseded/   T1 W3C Review Scope v1_1, v1_3
```
The W3C review OF scope v1.1 was briefly moved with them and then RESTORED to
`Scopes/` at W3D's recommendation. It is not a superseded scope; it is the
record of a review that found two blocking defects, and review records are
evidence of process rather than superseded instructions. It stays live and in
scope.

## 2.0a EXPLICIT EXCLUSION - T1's own process artifacts

Recorded as a decision, not left to inference. v1.1 put T1's paperwork IN
scope; W3C argued for exclusion and the argument is better.

```text
EXCLUDED FROM ADJUDICATION:
    Deblock4_Standing_Task_Register_T_Series (all generations)
    Deblock4_T1_W3C_Review_Scope (all generations)
    the W3C reviews of that scope
    the T1 scope manifest (this document)
    T1 ledger batches and W3C step responses
    T1/T1S00_A.zip and successors

COMPENSATING CHECK AT CLOSURE:
    every one of these is audited for pointer accuracy and version currency
    when T1 closes. Excluded from adjudication is NOT excluded from scrutiny.
```

**Why this reverses v1.1.** These documents change during the very work they
govern - the register has moved v1.1 -> v1.4 in a single day - so sweeping
them creates recursion and version churn against a moving target. The manifest
adjudicating itself is circular outright.

**Why this is not the failure mode T1 exists to correct.** The original
incident was an IMPLICIT exclusion resting on an index label nobody verified.
This is an EXPLICIT exclusion, recorded with its reason, in the document a
reviewer reads, with a compensating audit at closure. A recorded exclusion can
be challenged; a label that quietly grants permission to skip cannot.

## 2.0b EXPLICIT EXCLUSION - pinned third-party reference source

```text
EXCLUDED FROM PROJECT-KNOWLEDGE ADJUDICATION:
    reference/holywu_r9/deblock.cpp
    reference/holywu_r9/deblock_sse4.cpp
    reference/holywu_r9/deblock.h
    reference/holywu_r9/LICENSE

REASON: pinned third-party reference implementation and licence, not Deblock4
project knowledge. The live provenance document and the SHA256 record REMAIN
in the population and are swept. The reference source may still be consulted
where a ledger entry requires it.
```

**Why this moved.** v1.2 stated this exclusion correctly but in section 3,
while section 0.1 says exclusions live in section 2 - so the manifest did not
literally obey its own population rule, and the 47-document count was right
only by an exclusion recorded in the wrong place. No count changes; the rule
and the arithmetic now agree. W3C's catch.

## 2.0c EXPLICIT EXCLUSION - the outgoing-designer evidence zip

```text
T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
    REFERENCE EVIDENCE, not a knowledge-authority sweep target.
    Its five named contents are read where the register or scope directs.
    The two JUDGEMENT files remain positions to test, never project findings;
    the two RECORD files are relied on as fact.
    Excluded from the document population EXPLICITLY - not merely because it
    happens to be a zip.
```

**One mechanical check IS run against them:** whether any LIVE document cites
anything in a retired folder as current. Four live documents mention those
paths - the Currency Audit v1.4, Project Status v1.28, the D0 Binding
Knowledge Index v1.14 and the Task Register (current generation; the register
family is excluded from adjudication at 2.0a, so only the first three yield
ledger entries). Each mention is a ledger
entry to adjudicate; a reference that merely says "the old copy was moved to
superseded/" is fine, a reference that treats retired content as live is not.

## 2.0d ORPHAN-FAMILY CHECK on the retired folders - run, and its result

W3C proposed a cheap mechanical guard on the largest assumption in this
manifest: for each retired document family carrying MPEG-2 hits, confirm a
live successor or an explicit historical reason exists, and flag only the
families with neither. The check was run.

```text
RESULT: 74 retired families flagged. That is too many to be a signal.
```

Inspection shows the check as specified is too blunt, in two ways:

```text
FALSE ORPHANS FROM RENAMING. The "creation error message table" family
(195 hits) and the "2C preface and binding knowledge index" family (67 hits)
both HAVE live successors - under changed filenames
(Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1 and
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14). Filename
matching cannot see a rename.

COMPLETED-STAGE PROCESS ARTIFACTS. Most of the remaining 74 are stage scopes,
coder responses, delivery manifests and acceptance reviews for stages 1B3,
1C, 2C, 4C, 5C, M1 and M2. Their "successor" is not a same-named document at
all - it is the delivered, accepted source plus the ratified knowledge
documents. Absence of a live namesake is expected and means nothing.
```

Refined check, and what it leaves: after removing renames and completed-stage
artifacts, the genuine candidates are few. The largest is the FLOATING
EXACTNESS AND FULL DECLARED TIERS DISCUSSION family (4 files, 103 hits) - a
design DISCUSSION document, not a stage artifact, with no live namesake. A
live-citation check finds its subject matter discussed in four live documents
(the README, Verification and Tiering Decisions v1.11, the D0 index and the
charter), which is good evidence it was absorbed rather than orphaned - but
absorbed-in-substance is a claim to verify, not to assume.

```text
DISPOSITION: the refined orphan list is registered as ledger items at T1S05.
The check is retained as a standing method rule but its output must be
filtered for renames and completed-stage artifacts before it means anything.
The 74-family raw result is recorded here so nobody re-runs it and is
alarmed.
```

## 2.1 Four files exist in BOTH a live folder and a retired folder

Verified byte-identical by checksum:

```text
Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
    root  AND  Scopes/superseded/
Deblock4_Session_State_Stage_1B3_v1_0.md
    root  AND  Scopes/superseded/
Deblock4_Toolchain_Findings_v1_4.md
    root  AND  Scopes/superseded/
Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    root  AND  reviews/scheduled_for_deletion/
```

The copies are identical TODAY, so nothing is currently wrong. The hazard is
divergence: if the live copy is later edited, the retired copy becomes a
plausible-looking stale twin with the same filename. Toolchain Findings v1.4
is the one that matters, being a live knowledge document. Registered as a
ledger item; disposition is W3X's, and the likely answer is to delete the
retired duplicates rather than maintain two.

---

# 3. THE SWEEP LIST - 47 live documents, all UNADJUDICATED

**Count verified mechanically.** v1.0 claimed 49 while its tables held 48;
W3C caught the discrepancy. v1.2's figure is the enumerated live population
(51 text documents) MINUS the four T1 self-artifacts explicitly excluded at
2.0a (task register v1_4, review scope v1_4, its focused re-review, and the
W3C review of scope v1_1). Hit counts below are the ORIGINAL 42-term counts,
retained so the diff against the previous survey in section 4 stays
comparable; groups 8-11 add roughly 1,300 further statement-level hits inside
these same documents without changing which documents appear.

Hits are lines matching the term set. "Lines" is total document length, given
so the reading cost is visible. Step assignment is section 6.

## 3.1 Root - the main document set

```text
 HITS  LINES  DOCUMENT                                              STEP
  463   3792  README_Deblock4_Design_Spec_v1_12.md                  S02/S03
  395   1983  Deblock4_MPEG2_Deblocking_Investigation_and_
                Decided_Architecture_v1_05.md                       S01
  116    317  Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md       S05
  113   1440  Deblock4_Project_Status_v1_28.md                      S05
  101    728  111_New_Chat_Introduction_for_Designer_v1_23.md       S05
   98   2533  AI_Charter_and_Invariants_Card_v1_29.md               S04
   97    889  111_New_Chat_Introduction_for_Coder_v1_30.md          S05
   56    276  Deblock4_Concise_Project_Summary_v1.3.md              S05
   41    879  Deblock4_Verification_And_Tiering_Decisions_v1_11.md  S05
   38    111  Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1   S05
   36    420  Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md     S04
   34    630  Deblock4_Stage_2C_D0_Preface_and_Binding_
                Knowledge_Index_v1_14.md                            S04
   33    883  Deblock4_Scope_Stage_1B3_Runtime_Capability_
                Guard_v1_3.md                                       S05
   32    266  Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1    S05
   29    159  222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_1.txt          S05
   25    199  Deblock4_Documentation_Currency_Audit_v1_4.md         S05
   24    132  222-INITIAL_BLURB_FOR_CODER_CHAT_v1_1.txt             S05
   22    231  Deblock4_Forward_Roadmap_v1_20.md                     S05
   21    661  Deblock4_DISPATCH_RELATED_Backend_Objects_
                Explained_v1_4.md                                   S05
   19     73  GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt             S05
   17    116  Deblock4_Designer_Chat_2_Death_Resume_Brief_v1_0.md   S05
   16    534  Deblock4_Toolchain_Findings_v1_4.md                   S05
   11    222  Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md  S05
   11    143  Deblock4_Session_State_Stage_1B3_v1_0.md              S05
    7     87  Deblock4_Session_Bootstrap_Header_v1_1.md             S05
    3     46  Deblock4_Toolchain_Findings_F6_Addendum_for_v1_2.md   S05
    2    155  333_W3X_Designer_Communication_Convention_v1_1.md     S05
    2    111  000_Instructions_to_designer_for_creating_New_
                Chat_Introduction_for_designer.md                   S05
    1    139  Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md       S05
    1    120  333_W3X_Coder_Communication_Convention_v1_0.md        S05
    0    267  GAIS_GATING_RESPONSE.txt                              S05
    0     60  000_Instructions_to_coder_for_creating_New_Chat_
                Introduction_for_coder.txt                          S05
    0     50  Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1    S05
```

Zero-hit documents stay ON the list. A zero is a RESULT to be recorded, not a
reason to remove a document from scope - and a zero from this term set is not
proof of no MPEG-2 content, only proof that these words are absent.

## 3.2 Scopes/ - the architecture re-decision record

**This entire folder was absent from the previous survey.** See section 4.

```text
 HITS  LINES  DOCUMENT                                              STEP
  214   1088  Deblock4_D4_Architecture_ReDecision_W3C_
                Evaluation_v1_0.md                                  S01
  127   1020  Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_
                CODER_RESPONSE.md                                   S01
   52    213  Deblock4_D4_Architecture_ReDecision_Brief_for_
                W3C_v1_0.md                                         S01
   41    255  Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md      S01
   29    143  Deblock4_D4_Verification_Round_Brief_for_W3C_v1_1.md  S01
   23     98  Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md  S01
```

Note that BOTH v1_0 and v1_1 of the Verification Round Brief sit live in the
same folder with no supersession marker on either. That is itself a ledger
item.

The T1 process documents that also live in this folder - the review scope, its
two W3C reviews - are EXPLICITLY EXCLUDED at 2.0a and audited at closure
instead. v1.1 had them in scope; W3C's argument for exclusion was better.

## 3.3 GAIS_investigations/ - external research briefs and answers

**This entire folder was also absent from the previous survey.**

```text
 HITS  LINES  DOCUMENT                                              STEP
   93    241  Deblock4_GAIS_Investigation_Brief_ChromaField
                Geometry_and_PriorArt_v1_0_ANSWER.md                S01
   56    204  Deblock4_GAIS_Investigation_Brief_ChromaField
                Geometry_and_PriorArt_v1_0.md                       S01
   27    167  Deblock4_GAIS_OptionSpace_Request_v1_0_ANSWER.md      S01
   25    114  Deblock4_GAIS_Followup_Critique_and_Refined_
                Questions_v1_0.md                                   S01
   23    115  Deblock4_GAIS_Followup_Critique_and_Refined_
                Questions_v1_0_ANSWER.md                            S01
    9    100  Deblock4_GAIS_OptionSpace_Request_v1_0.md             S01
```

These are EVIDENCE, not authority. Project rule: no GAIS factual claim,
citation or quotation enters project knowledge without independent
verification, and the ratified MPEG-2 authority records the verified outcome
and prevails over the raw responses. The sweep's job here is therefore
narrow and specific: check that every GAIS claim the authority document RELIES
on was actually verified, and find any GAIS claim that leaked into a project
document WITHOUT verification.

## 3.4 reference/holywu_r9/ - the reference implementation

```text
 HITS  LINES  DOCUMENT                                              STEP
   12    124  README_provenance_v1_4__replaces_holywu_r9_
                README_provenance.md                                S05
    3      4  SHA256SUMS.txt                                        S05
```

The C++ sources and licence in that folder are third-party reference material,
not project documents, and are EXPLICITLY EXCLUDED at section 2.0b. The
provenance document that describes them, and the checksum record, are swept.

---

# 4. Diff against the previous survey - what it could not see

The previous designer's survey found 17 files (15 distinct) using a
seven-term set. That record is in
`OldDesigner_Q4_Survey_Term_Set_v1_0.md`, supplied as evidence. Re-running
their exact terms on the current generation reproduces their result shape, so
their record is sound. This set finds substantially more.

## 4.1 The finding that matters: two entire live folders were invisible

```text
Scopes/               6 live documents   2,817 lines   486 hits
GAIS_investigations/  6 live documents     941 lines   233 hits
                     --------------------------------------------
                     12 documents        3,758 lines   719 hits
```

The previous survey ran on the `dev_documentation` ROOT only. It was not a
term-set weakness - the `Scopes/` documents are saturated with MPEG-2 terms
and would have matched the old seven terms easily. They were simply outside
the directory that was searched.

**Why this is serious, and not merely more reading.** `Scopes/` holds the
primary record of the architecture re-decision itself: the brief that put
Architecture A back on the table, the coder's independent evaluation that
produced the current primary candidate, and two generations of the
verification-round brief. The re-decision is the single most consequential
design event in this project, and its working record was never in scope for
the sweep meant to consolidate project knowledge.

This is the same failure as the original incident in a different dimension.
That one missed a document because its LABEL said it did not matter. This one
missed twelve because they were in a FOLDER nobody searched. Both are
selection failures, not reading failures.

## 4.2 Other documents this set finds and the old one did not

```text
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md    36 hits  (= PR-4)
Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1   32 hits
Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard    33 hits
Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2    11 hits
Deblock4_Session_State_Stage_1B3_v1_0.md             11 hits
000_Instructions_to_designer... / Debug_Module... / both conventions
                                                    1-2 hits each
reference/holywu_r9/ provenance and checksums        3-12 hits
```

PR-4 registered D2 v1.7 as one invisible document. The real answer is twelve
plus D2 plus several smaller ones.

---

# 5. What THIS manifest might still be missing - read this before approving

Stated plainly, because the whole point of publishing the manifest is to be
told what it got wrong.

```text
W1  A LIVE DOCUMENT WITH NO MPEG-2 VOCABULARY AT ALL.
    A document could carry a load-bearing decision about geometry, thresholds
    or schedules while using none of the registered terms. Zero-hit documents remain
    in scope precisely because a zero is a result, not an exclusion - but a
    document that is BOTH zero-hit AND was never listed cannot be caught this
    way.

W2  FOLDER SELECTION IS STILL A HUMAN JUDGEMENT.
    Section 4.1 shows the previous survey's fatal error was choosing where to
    look. This manifest covers seven folders because those are the seven that
    exist in the supplied zip. If material lives OUTSIDE dev_documentation -
    in the repository root, in a tools folder, in commit messages, in an
    email - this manifest cannot see it. W3X CONFIRMED on 2026-08-18 that
    the supplied zip IS the whole documentation set, which closes this
    weakness as far as it can be closed - it now rests on W3X's confirmation
    rather than on W3D's assumption.

W3  RETIRED FOLDERS ARE EXCLUDED ON THEIR FOLDER NAME.
    350 files are excluded because of the folder they sit in. If a document
    was filed as superseded but holds the ONLY copy of something current,
    this sweep will not find it. The mechanical citation check in section 2
    is a partial defence, not a complete one. Accepting this is a deliberate
    cost decision, not an oversight - but it is the largest single
    assumption in the manifest.

W4  BINARY AND NON-TEXT FILES ARE UNSEARCHED.
    Several .zip delivery packages sit in retired folders. Nothing was
    extracted from them. Two zips also sit in LIVE folders:
    `T1/T1S00_A.zip` (this manifest, already listed) and
    `T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip`
    (five documents, already supplied separately and classified at DEC-11).
    Both are containers whose contents are accounted for elsewhere, so
    neither hides unlisted material - but no zip anywhere was opened by the
    search.

W5  THE TERM SET WAS NOT INDEPENDENTLY DERIVED IN THE FIRST INSTANCE, THOUGH
    IT HAS NOW BEEN INDEPENDENTLY EXTENDED TWICE.
    The registered set began as W3D's 42 terms. W3C's PR-4 reviews added
    groups 8-11 and then group 12, taking it to 90 - each addition measured
    before adoption, and the set is now FROZEN (section 1.0). This weakness is
    substantially reduced but NOT eliminated: two independent passes are not a
    proof of completeness, and W1 remains the residual risk.
```

---

# 6. Step assignment

```text
T1S00  This manifest. No adjudication.

T1S01  THE ARCHITECTURE RECORD - 13 documents, ~5,741 lines, 1,114 hits
       (395 + 486 + 233; v1.0 stated 1,109, an arithmetic error W3C caught).
       The MPEG-2 authority v1.05, all six Scopes/ documents, all six
       GAIS_investigations/ documents.
       Holds PR-1 (the possibly-universal false-activation limit) and PR-2
       (the tc0-unscaled principle).
       WHY GROUPED: adjudicating the authority document without its working
       record would repeat the manifest's own lesson. PR-1 asks whether a
       limit filed inside a rejection proof is universal; the re-decision
       documents are where that reasoning was actually done.
       THIS IS A LARGE STEP. If it proves too large in practice it will be
       split at a natural boundary and reported, not silently truncated.

T1S02  README v1.12 part 1 - decision-status table, sections 3.11 to 6.2,
       the F12-F17 findings series. ~2,000 lines.

T1S03  README v1.12 part 2 - Appendices A and B, section 20. ~1,800 lines.

T1S04  The charter v1.29 (read, never stripped; holds PR-3), the D0 Binding
       Knowledge Index v1.14, and D2 HolyWu Real Schedule v1.7.
       ~3,600 lines.

T1S05  All remaining live documents - 30 items, mostly low-hit informative
       records, plus the reference provenance files.
```

T1S01 was moved ahead of the README deliberately. PR-1 gates the detector
mathematics task that follows T1, so if it resolves early it can go to W3X as
a standalone authority-document version bump rather than waiting for the whole
sweep to close.

---

# 7. What happens next

```text
1. W3X reviews this manifest and says what is missing (see section 5).
2. W3C reviews it under PR-4 and says what the term set would still miss.
3. Corrections found during T1S00 are folded into the manifest BEFORE T1S01
   begins - however many bumps that takes. It took three: v1.1 (post-move
   rebase), v1.2 (first W3C review), v1.3 (second W3C review, term-set
   freeze).
4. T1S01 adjudication begins.
```

No document in section 3 has been read for adjudication. Every one is
UNADJUDICATED, and the ledger will record a disposition for each.

---

v1.3 (2026-08-18) Issued after W3C's second T1S00 pass, which independently
     reproduced the v1.2 population and coverage figures and found one real
     residual gap plus one formal inconsistency. TERM SET FROZEN at 90 terms
     (section 1.0): group 12 adds decisions and Q14-integrity vocabulary,
     measured at +93 otherwise-unmatched lines and zero population change,
     both figures reproduced independently by W3D. Two terms justify the group
     alone - `architecture c\b` recovers four live lines about the rejected
     motion architecture that nothing else matched, and `D4-D` recovers 23
     bare ratified-decision-pointer lines. The pinned third-party reference
     source is moved from section 3 to an explicit section 2.0b exclusion, so
     the manifest now literally obeys its own population rule and the
     47-document count is right for a recorded reason rather than by accident.
     Clerical currency fixed and made generation-neutral where it had staled
     twice: retired-folder counts and retirement lists are no longer pinned to
     a snapshot, stale "42 terms" prose in section 5 replaced, and section 7's
     instruction no longer names a specific bump.
v1.2 (2026-08-18) Issued after W3C's T1S00_B review, which recommended against
     starting T1S01 from v1.0. All findings accepted. Section 0.1 makes
     POPULATION and SEARCH formally separate mechanisms - recursive inventory
     first, then explicit recorded exclusions, with the term set searching an
     already-known population rather than building it (W3C Q2; the direct
     structural answer to PR-5). Term groups 8-11 added (W3C PR-4) after
     measuring that they add ~1,300 statement-level hits while changing the
     document population by zero. T1 self-artifacts and the evidence zip are
     now EXPLICIT recorded exclusions with a closure audit (2.0a, 2.0b),
     reversing v1.1's decision to sweep T1's own paperwork - W3C's recursion
     argument was better, and an explicit challengeable exclusion is not the
     implicit label-based skip that caused the original incident. The
     orphan-family check was run (2.0c): it flagged 74 families, which
     inspection shows is too blunt - renames and completed-stage artifacts
     dominate - and the refined result is registered at T1S05. Count corrected
     to 47 and the T1S01 hit total corrected from 1,109 to 1,114, both W3C
     catches.
v1.1 (2026-08-18) Rebased on the post-supersession-move snapshot. Live count
     49 -> 51. Task Register v1_1 replaced by v1_4 and v1_1/v1_2/v1_3 recorded
     as retired; T1 W3C Review Scope v1_1 and v1_3 recorded as retired; scope
     v1_4, its focused W3C re-review, and the restored W3C review of v1_1
     added to the live list at T1S05, with a note stating why T1's own
     paperwork is in its own scope. W2 (is the zip the whole set?) closed by
     W3X confirmation. W4 extended to name the two zips now sitting in live
     folders. All pre-existing documents verified byte-identical to the
     previous snapshot; no hit count or line number changed.
v1.0 (2026-08-18) First issue. 42-term set stated verbatim; 49 live documents
     listed with hit and line counts; four retired folders excluded with a
     citation check run against them; four live/retired duplicate filenames
     recorded; diff against the previous survey showing two entire live
     folders (12 documents, 3,758 lines) that were outside its search;
     five stated weaknesses of this manifest; six-step assignment with the
     architecture record moved ahead of the README.
```
