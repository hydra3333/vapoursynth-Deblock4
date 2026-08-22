# Deblock4 - T1S01a5b Population Derivation and Source-Coverage Map

**Deliverable:** T1S01a5b_A - POPULATION AND COVERAGE MAP
**Version:** 1.1
**Date:** 2026-08-22
**Author:** W3D
**Status:** PRE-ADJUDICATION ARTIFACT, produced BEFORE any a5b entry is
written, as DEC-77 and Review Scope v1.15 section 0.10 require. It contains
NO dispositions and adjudicates NOTHING.
**v1.1 AMENDMENT NOTE:** batch 1 (sections 9-10) is now ADJUDICATED AND
W3C-REVIEW-CLOSED at ledger Part2 v1.5. This version applies the amendments
that adjudication forced - four resegmented Part-B rows and one corrected
routing - and points Part A.3 at the population of record. It still contains
no dispositions: where an entry's outcome matters, the LEDGER is authority
and this map is a planning artifact only. Sections 11-13 rows are UNTOUCHED
and remain pre-adjudication.
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_15.md`
**Source:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`,
sections 9-13, lines 716-1098 (the a5b range ratified at DEC-56/DEC-68).
**Encoding:** US-ASCII; CRLF.

---

# 0. WHAT THIS DOCUMENT IS, AND THE ONE CONDITION ON IT

```text
DEC-77's RULE, LEARNED FROM a5 AT REAL COST: an overlap check against prior
entries is NOT a coverage check against the source. a5 enumerated overlap
meticulously and never once walked its source range for propositions with no
entry; two coverage failures survived five generations. THIS MAP IS THE WALK,
DONE FIRST.

TWO PARTS:
    PART A  the a5b POPULATION, derived fresh by this sub-tranche as Resume
            Brief 0f requires - NOT inherited from a5's settled 46-file
            snapshot.
    PART B  the SOURCE-COVERAGE MAP - every line of 716-1098 assigned to a
            segment; every segment either carries reserved entry ID(s) or a
            recorded no-proposition rationale.

THE ONE CONDITION: Part A is CONDITIONAL ON W3X's COMMIT of the 2026-08-21
continuity-refresh set. The derivation ran against the working tree BEFORE
that commit and substitutes the refresh generations by declared rule R-C.
AFTER COMMITTING, W3X should confirm the tree matches section A.4; if it does
not, the population MUST be re-derived before the first a5b entry is written.
A snapshot of a tree that never existed is not a snapshot.
```

---

# PART A. THE a5b POPULATION

## A.1 Mechanical base rule

```text
Walk dev_documentation recursively. INCLUDE *.md and *.txt. EXCLUDE, by the
ratified mechanical rules:
    superseded*/ and scheduled_for_deletion*/ subtrees ........ DEC-60
    T1/ (process/workshop, not applicable project knowledge) .. DEC-63
    GAIS_investigations/ (evidence-only history) .............. DEC-66

RAW RESULT AGAINST THE PRE-COMMIT TREE: 46 files. That number is NOT the
population; the raw tree still held BOTH generations of seven continuity
documents pending the refresh commit, and the raw count must not be confused
with a5's coincidentally-equal settled 46.
```

## A.2 Resolution rules, declared before use

```text
R-A LIVING-DOCUMENT RULE. Root continuity documents are one living document
    per name; only the NEWEST generation is a population member. Older
    generations are due for superseded/ handling and are excluded even while
    they still sit at root. Applied to seven collision pairs.

R-B POINT-IN-TIME-RECORD RULE. Scopes/ round briefs and their responses are
    distinct historical records of distinct review rounds, NOT generations of
    one living document. Both Verification Round Briefs (v1_0 AND v1_1)
    remain members. This matches a5 precedent: its probes classified them as
    separate candidate files.

R-C REFRESH SUBSTITUTION. The eight continuity documents refreshed on
    2026-08-21 enter at their committed new generations (Project Status
    v1_35, Forward Roadmap v1_24, Currency Audit v1_8, Concise Summary v1.8,
    coder intro v1_36 + blurb v1_6, designer intro v1_32 + blurb v1_8).

WHAT IS CORRECTLY ABSENT, so nobody "fixes" it: the Standing Task Register,
T1 Resume Brief, T1 Review Scope v1.15, T1S00 manifest and every a5 ledger
artifact live under T1/ and are excluded by DEC-63. They are process
machinery, not adjudicable project knowledge. Their a5-era predecessors were
equally absent from a5's population.
```

## A.3 Declared population: 40 files

SUPERSEDED AT v1.1 - READ THE DELTA INSTEAD. The population of record is
`T1S01a5b_A_Population_Delta_v1_1.md`: 38 files (root 30, Scopes/ 6,
reference/ 2), derived after the refresh commit that this section was
conditional on. The 40-file list below is RETAINED AS THE HISTORICAL
DERIVATION, not as the current population; the delta accounts for every
difference (four generation substitutions, two removals to superseded/).

```text
ROOT (30):
    000_Instructions_to_coder_for_creating_New_Chat_Introduction_for_coder.txt
    000_Instructions_to_designer_for_creating_New_Chat_Introduction_for_designer.md
    111_New_Chat_Introduction_for_Coder_v1_36.md                       [R-C]
    111_New_Chat_Introduction_for_Designer_v1_32.md                    [R-C]
    222-INITIAL_BLURB_FOR_CODER_CHAT_v1_6.txt                          [R-C]
    222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_8.txt                       [R-C]
    333_W3X_Coder_Communication_Convention_v1_0.md
    333_W3X_Designer_Communication_Convention_v1_1.md
    AI_Charter_and_Invariants_Card_v1_31.md
    Deblock4_Concise_Project_Summary_v1.8.md                           [R-C]
    Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_4.md
    Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md
    Deblock4_Documentation_Currency_Audit_v1_8.md                      [R-C]
    Deblock4_Forward_Roadmap_v1_24.md                                  [R-C]
    Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
    Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md
    Deblock4_Project_Status_v1_35.md                                   [R-C]
    Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
    Deblock4_Session_Bootstrap_Header_v1_4.md
    Deblock4_Session_State_Stage_1B3_v1_0.md
    Deblock4_Stage_1C_Creation_Error_Message_Table_v1_1.md
    Deblock4_Stage_1C_Phase_3a_Designer_Briefing_v1_2.md
    Deblock4_Stage_1C_Phase_3b_Coder_Resume_Brief_v1_1.md
    Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_14.md
    Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_7.md
    Deblock4_Toolchain_Findings_F6_Addendum_for_v1_2.md
    Deblock4_Toolchain_Findings_v1_4.md
    Deblock4_Verification_And_Tiering_Decisions_v1_11.md
    README_Deblock4_Design_Spec_v1_12.md

SCOPES/ (8):
    Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
    Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
    Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2.md
    Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
    Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md               [R-B]
    Deblock4_D4_Verification_Round_Brief_for_W3C_v1_1.md               [R-B]
    Deblock4_T1_W3C_Review_Scope_v1_1_W3C_Review_v1_0.md
    Deblock4_T1_W3C_Review_Scope_v1_7.md

REFERENCE/ (2):
    reference/holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
    reference/holywu_r9/SHA256SUMS.txt
```

## A.4 Delta against a5's settled 46, accounted rather than waved at

```text
a5's settled snapshot: 46. This population: 40. The difference of six is
EXACTLY the six older root generations retired under R-A (coder intro v1_33,
designer intro v1_29, coder blurb v1_3, designer blurb v1_5, currency audit
v1_6, roadmap v1_22) - continuity churn, not membership churn. No document
CLASS entered or left the population; a5's probe conclusions about which
FILES carry which propositions remain attackable on the same set of living
documents at newer generations. Any a5b probe that touches a refreshed
continuity document must nonetheless treat the NEW generation as unswept
text: R-C substitutes membership, not content equivalence.
```

---

# PART B. SOURCE-COVERAGE MAP, LINES 716-1098

## B.1 How to read it

```text
Every line of the range is assigned to exactly one segment; blank lines and
horizontal rules belong to the segment they close. RESERVED IDs continue
from a5's LED-063: a5b entries are LED-064 onward. SPLIT-CANDIDATE flags mark
segments whose CLAIM visibly bundles propositions that may not share a
disposition - the a5 atomic-claim lesson applied BEFORE drafting instead of
after four failures. A flag is an expectation, not a commitment; the split
decision happens at adjudication WITH evidence.

NO-PROPOSITION segments are recorded with a rationale, per DEC-77: a gap in
the map must be a recorded decision, never an oversight.
```

## B.2 Section 9 - ARCHITECTURE OPTIONS AND THE RE-DECISION (716-805)

```text
716-717   heading                              NO-PROPOSITION (title line)
718-726   9.1: what old A WAS - separated-field row step, primary/midpoint
          mod-8 candidate classes              LED-064
727-737   9.1: A's creation-time threshold scaling mechanism - S formula,
          scale_threshold, tc0/correction deliberately unscaled
                                               LED-065
738-745   9.1: the five engineering ideas RETAINED from A
                                               LED-066 / 066a / 066b
          AMENDED v1.1 (adjudicated): item 5 (line 745, uncertainty
          measurable and explicit) split to LED-066a; the "/multiply"
          token of item 3 (line 743) split to LED-066b. Both are
          CURRENT-UNIQUE; the map did not anticipate either.
746-747   9.1: the geometry mechanism REJECTED; exact proof at Appendix C
                                               LED-067
          NOTE: Appendix C is OUTSIDE this sub-tranche (a6's range). The
          entry will need a CITED-OUTSIDE-RANGE record (scope 0.6), and the
          in-range rejection proof is section 12 - the mapping between the
          two rejection statements is itself adjudication material.
748-756   9.2: what B WAS - the region-phase pipeline
                                               LED-068
757-761   9.2: WHY B is superseded - vague at mixed boundaries, encouraged
          the incorrect parity-split SIMD reading; B2 replaces
                                               LED-069
762-785   9.3: B2's four-layer separation (mode policy / map producer /
          topology compiler / edge predicate + kernel), incl. the future
          side-data bypass note in layer B     LED-070 / 070a / 070b
          SPLIT-CANDIDATE flag CONFIRMED: the side-data sentence became
          LED-070a (POINTER, provisional on LED-097 in a later batch).
          AMENDED v1.1 (adjudicated): the segment's HEADING at line 763,
          "Architecture B2 - PRIMARY CANDIDATE", is a substantive current
          proposition this map missed entirely - now LED-070b. A coverage
          omission, found by W3C review, recorded here so the same class of
          heading is not missed in sections 11-13.
786-788   9.3: the governing separation principle - "where is the edge" vs
          "does it look like an artifact"      LED-071
789-795   9.4: WHY C is rejected - motion similarity unreliable for
          dct_type; miss-and-probe failure mode
                                               LED-072
796-803   9.5: what D IS and why created - detector-free, actual whole-frame
          internal edge, avoids A's pitch collision; topology deferred to
          section 11 (IN-RANGE pointer)        LED-073 / 073a
          AMENDED v1.1 (adjudicated): the section-11 pointer (line 803) is a
          separate atomic claim and is CURRENT-UNIQUE - split to LED-073a,
          whose target LED-082 must confirm on its batch.
804-805   hrule + blank                        NO-PROPOSITION (separator)
```

## B.3 Section 10 - B2 MACROBLOCK-TOPOLOGY MATHEMATICS (807-876)

```text
806-817   preamble: M = 16*m; per-x-interval single ownership of boundary
          descriptors; coalescing only on matched kind/geometry
                                               LED-074 / 074a / 074b
          SPLIT-CANDIDATE flag CONFIRMED: coalescing became LED-074a.
          AMENDED v1.1 (adjudicated): a THIRD split was needed - the
          geometry sentence (M = 16*m, 16-pixel segment) is duplicated and
          was riding inside LED-074's uniqueness claim; it is now LED-074b,
          leaving LED-074 as the ownership rule alone (CURRENT-UNIQUE).
818-832   10.1: internal-edge table at M+8 - FRAME pitch-1 edge / FIELD no
          edge / UNKNOWN D4-D07 no-filter policy
                                               LED-075
833-834   10.1: "most direct observable difference" significance claim
                                               LED-076
835-849   10.2: the U/L macroblock-row boundary topology table incl. both
          UNKNOWN rows                         LED-077
850-854   10.2: mixed-rule provenance (independently adopted, MBAFF-informed,
          NOT inherited) AND the Q14/fixture coverage obligation
                                               LED-078   SPLIT-CANDIDATE
          (a provenance claim and a forward obligation rarely share one
          disposition)
855-862   10.3: seam-ambiguity elimination - classification change is table
          input, exactly ONE topology per 16-pixel segment, never competing
          hypotheses on the same samples       LED-079
863-871   10.4: the conservative UNKNOWN policy statement
                                               LED-080
872-876   10.4: "current policy, not a timeless truth"; the revisit-
          requirement cross-reference; hrule   LED-081 / 081a
          AMENDED v1.1 (adjudicated): the cross-reference sentence is a
          separate atomic claim AND IS FALSE - the authority says "Section
          15 requires a revisit", but section 15 specifies the Q14
          experiment and section 16 ("UNKNOWN POLICY REVISIT") imposes the
          requirement. LED-081a: SUPERSEDED / SUPERSEDED-KIND ERRONEOUS,
          Tier A, with DEC-84 propagation executed. The out-of-range
          obligation therefore routes to SECTION 16, not section 15 - this
          map's v1.0 note was one of the four dependencies the propagation
          found and corrected. Proposed authority repair (line 873, one
          word) awaits W3X ratification.
```

## B.4 Section 11 - ARCHITECTURE D EXACT FALLBACK (878-914)

```text
877-898   D's exact Case-(a) luma topology: vertical x=8k invariant;
          boundary e=16k dual pitch-2 parity edges; internal e=16k+8 single
          pitch-1 candidate with conservative activation; the A-derived
          threshold-scale as EXPERIMENT CANDIDATE, not public parameter
                                               LED-082   SPLIT-CANDIDATE
          (the experiment-candidate status sentence is a status claim
          separable from the geometry contract)
899-902   exactness characterisation: exact for FIELD/FIELD boundaries,
          conservative for mixed, approximate for FRAME/FRAME
                                               LED-083
903-909   the two measurable quality risks (internal false activation in
          FIELD; pitch-2-for-pitch-1 quality at FRAME/FRAME)
                                               LED-084
910-914   "D must earn viability; not automatic because simpler"; hrule
                                               LED-085
```

## B.5 Section 12 - ARCHITECTURE A REJECTION PROOF (916-1048)

```text
915-920   the section's PURPOSE: detailed so rejected A is not rediscovered
          as forgotten good design             LED-086
921-952   12.1: literal transposition mathematics - field-row candidates,
          frame-row mapping e=2r+p, p=0/p=1 sequences, EVERY literal-A
          operation is pitch 2                 LED-087
953-978   12.2: the e=8 counterexample - true frame-DCT edge reads/writes vs
          both literal-A projections; neither touches the 7/8 pair; literal
          A is a DIFFERENT ALGORITHM, not a transposition
                                               LED-088
979-1009  12.3: faithful-union collision at e=16 - F/E/O hypothesis write
          sets, the {14,16}/{15,17} overlaps, canonical-order consequence,
          and the conclusion that "union + local gate" defines a NEW
          double-filter algorithm; rejected rather than invented
                                               LED-089
1010-1019 12.4: candidate-count cost - four ops per 16 rows vs two; ~2x
          before activation rejection; faithful union likewise 4-for-2
                                               LED-090
1020-1046 12.5: the in-principle limit - identical sample tuples from
          different causes cannot be threshold-separated; scaling tunes the
          trade, cannot eliminate it; midpoint_threshold_scale is NOT a
          safety proof and NOT soft confidence
                                               LED-091   SPLIT-CANDIDATE
          (the general indistinguishability limit and the two specific
          claims about midpoint_threshold_scale may separate)
1047-1048 hrule + blank                        NO-PROPOSITION (separator)
```

## B.6 Section 13 - SCHEDULER/KERNEL SEPARATION (1050-1098)

```text
1049-1053 the retention meta-claim: the older README rules below are "still
          exactly right and load-bearing"      LED-092
          NOTE: this is the most duplicate-exposed claim in the range by
          construction - it EXPLICITLY says the README carries these rules.
          Expect CURRENT-DUPLICATE dispositions with canonical-home
          adjudication per rule, and per-proposition carrier evidence
          (the a5 LED-032a lesson).
1054-1068 13.1: schedule-decides-WHERE / predicate-decides-filterable /
          kernel-decides-HOW; do not let the predicate become an implicit
          geometry classifier                  LED-093
1069-1074 13.2: detector pre-pass reads UNMODIFIED source; output-affecting
          detector is part of the canonical algorithm
                                               LED-094
1075-1081 13.3: per-call scratch; immutable per-instance config allowed;
          output-affecting cross-frame state FORBIDDEN in v1 unless a later
          scope models temporal dependencies   LED-095
1082-1088 13.4: the detector itself needs proof - scalar definition joins
          the oracle-level structural algorithm; structural exactness per
          per-type verification rules; no unproved convenience helpers
                                               LED-096
1089-1098 13.5: D4-Q13 open; trusted side data must feed the SAME
          FRAME/FIELD/UNKNOWN map contract; runtime correctness must not
          depend on side data before its trust contract is scoped; hrule
                                               LED-097   SPLIT-CANDIDATE
          (Q13-status, the same-contract requirement and the
          no-dependence rule are three separable claims)
```

## B.7 Coverage arithmetic

```text
Range 716-1098 = 383 lines. Segments above tile the range with no gap and no
overlap; the only NO-PROPOSITION segments are the section-9 title pair and
two bare separators, each recorded with its rationale. RESERVED ENTRIES:
LED-064 through LED-097 = 34, with SEVEN SPLIT-CANDIDATE flags (LED-070,
074, 078, 082, 091, 097 and the LED-067 Appendix-C mapping question).
COUNTS HERE ARE PLANNING FIGURES ONLY - the adjudicated ledger derives its
own totals by enumeration, never from this map (a5's standing lesson).

TWO CITED-OUTSIDE-RANGE obligations are visible BEFORE adjudication:
    LED-067 -> Appendix C (a6)    LED-081 -> section 16 (a6)
Both will use scope 0.6's ratified format.
    CORRECTED v1.1: the second read "section 15" at v1.0. Section 16 is
    where the revisit requirement lives; see the 872-876 row. Corrected
    under DEC-84 propagation from ledger LED-081a.
    ALSO NOTE, v1.1: batch 1 produced 29 entries where this map reserved
    18 for sections 9-10 - seven splits and four coverage additions. The
    planning-figures caveat above held exactly; treat the sections 11-13
    reservations the same way.
```

---

# C. WHAT HAPPENS NEXT, IN ORDER

```text
1. W3X commits the refresh set and confirms the tree matches A.3/A.4 (or
   orders re-derivation).
2. W3D adjudicates against this map, in map order, under Review Scope v1.15 -
   semantic probe families per DEC-67 Rule 3, atomic claims, occurrence-level
   evidence, mechanical gates run on files re-read from disk (DEC-87).
3. The first a5b ledger batch travels to W3C WITH this map, so coverage can
   be attacked as a claim rather than reconstructed.
```

---

*Revision history*

```text
v1.1 (2026-08-22) POST-BATCH-1 AMENDMENT, applied after batch 1 closed its
     W3C review cycle at ledger Part2 v1.5 (29 entries, all AGREE across
     four rounds). Four Part-B rows resegmented to match what adjudication
     actually found: 738-745 -> LED-066/066a/066b; 762-785 ->
     LED-070/070a/070b (including line 763's B2 PRIMARY CANDIDATE heading,
     a coverage omission this map missed); 796-803 -> LED-073/073a;
     806-817 -> LED-074/074a/074b. The 872-876 row and the Part-B.7
     obligation list corrected from "section 15" to "section 16" under
     DEC-84 propagation from LED-081a (ERRONEOUS). A.3 pointed at
     Population Delta v1.1 as the population of record, its 40-file list
     retained as historical derivation. Sections 11-13 rows UNTOUCHED and
     still pre-adjudication. NO disposition is recorded here; the ledger
     remains authority for every outcome.
v1.0 (2026-08-21) Initial population derivation (40 files, conditional on the
     refresh commit) and full source-coverage walk of lines 716-1098:
     34 reserved entries LED-064..097, seven split-candidate flags, two
     pre-identified CITED-OUTSIDE-RANGE obligations, four recorded
     no-proposition segments. Produced BEFORE adjudication per DEC-77 and
     Review Scope v1.15 section 0.10.
```
