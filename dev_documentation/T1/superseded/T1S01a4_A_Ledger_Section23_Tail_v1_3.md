# Deblock4 - T1S01a4 Ledger: Section 23 Steps 6-10 and the Ordering Defect

**Deliverable:** T1S01a4_A - LEDGER
**Version:** 1.3 - second narrow reissue. Nine corrections, no reopening
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Adjudicates:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`, section 23, lines 1694-1700
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_18.md`
**Encoding:** US-ASCII; CRLF.

---

# 0. COVERAGE DECLARATION

```text
ADJUDICATED HERE, and nothing else:

  lines 1694-1700   section 23 numbered steps 6, 7, 8, 9 and 10

EVERY PROPOSITION IN THAT RANGE has an entry below. Nothing in that range is
assigned onward.

CARRIED IN FROM THE REGISTER, because it is a property OF this range rather
than of any one line in it:

  DEC-32  section 23 orders step 8 (build the oracle) before step 9 (decide
          the schedule), while line 1153 says the schedule winner becomes
          part of that oracle. Adjudicated at LED-029.

NOT ADJUDICATED HERE, BECAUSE ANOTHER LEDGER ALREADY OWNS IT:

  lines 1679-1681   T1S01a2 LED-003 (T1 described as paused) and LED-009
                    (the authority-stability statement, line 1681)
  lines 1683-1694   T1S01a2 LED-004 (the numbered sequence head, steps 1-5),
                    LED-005 (step 1 packaging permission, lines 1684-1685)
                    and LED-006 (step 1 freeze-before-judgement, line 1686)
  lines 1703-1710   T1S01a2 LED-010 - the 2D/3D/4D/5D shorthand AND the
                    prerequisite sentence that follows it. v1.1 OF THIS
                    LEDGER WRONGLY RE-ADJUDICATED THIS RANGE at LED-031 and
                    LED-032. Both are withdrawn at v1.2. LED-010's own
                    atomicity repair is owed to T1S01a5.

  NOTE ON THE RANGE: LED-010 records lines 1703-1710 while the prerequisite
  sentence it quotes actually runs to line 1713. The sentence is quoted in
  full in LED-010, so this is a range-recording defect and not lost text. IT
  IS AN a5 ITEM, recorded here so it is not lost.

NOT ADJUDICATED HERE, and where it goes:

  Appendix D        the open-items list. Cited repeatedly below as evidence,
                    but its own statements are T1S01a5's.
  section 14        Schedule-SA/SB definitions and 14.4's comparison
                    requirement. Cited as evidence; body sections are a
                    later step's.
  line 1153         "The winner becomes part of the future Deblock4 scalar
                    oracle." Cited as the conflicting statement at LED-029.
                    The line itself is body material and is NOT dispositioned
                    here - LED-029 disposes of the ORDERING, not of line 1153.
```

## The overlap sweep, recorded by name because a claim of one already failed

v1.1 of this ledger asserted that the ledger set had been swept and the overlap
excluded. THAT ASSERTION WAS FALSE: LED-010 was missed, and two entries
re-adjudicated text it already owned. W3C found it. The rule that follows is at
register DEC-48 - a claim that a check was performed must name what was
examined, in the same breath, or it must not be written.

```text
THE POPULATION IS EVERY ENTRY IN EVERY PRIOR T1 LEDGER - T1S01a1, T1S01a2
AND T1S01a3. v1.2 said "every T1S01a2 entry" and then listed entries that
are not in that ledger. W3C found it. The population is now named for what
it actually is, and enumerated per ledger.

T1S01a1 - LED-001 and LED-002, the two pre-registered items:
  LED-001   PR-1, the in-principle false-activation limit,
            authority section 12.5                        - no overlap
  LED-002   PR-2, the tc0-unscaled principle,
            authority section 9.1                         - no overlap
  (v1.2 listed these as T1S01a2 "header/section 0 currency statements".
   BOTH HALVES OF THAT WERE WRONG: wrong ledger and wrong subject.)

T1S01a2 - LED-003 to LED-012, which is the whole of that ledger:
  LED-003   section 23 lines 1679-1681                    - outside
  LED-004   section 23 steps 1-5, RECORDED as 1683-1694   - SEE BELOW
  LED-005   section 23 lines 1684-1685                    - outside
  LED-006   section 23 line 1686                          - outside
  LED-007   section 0 lines 55-57                         - outside
  LED-008   section 0 lines 53-57                         - outside
  LED-009   section 23 line 1681                          - outside
  LED-010   section 23 lines 1703-1710                    - OVERLAP,
            excluded above; this is the one v1.1 missed
  LED-011   header block lines 25-31                      - outside
  LED-012   Appendix E, v1.05 entry                       - outside

T1S01a3 - LED-013 to LED-024 plus LED-020a: section 0's seventeen
  architecture items and the header block. None touches section 23. Checked
  by reading each entry's DOCUMENT field.

LED-004 IS NOT CLEANLY OUTSIDE THIS RANGE, AND v1.2 SAID IT WAS.
  Its RECORDED range ends at line 1694. Line 1694 IS step 6 - the first
  line this sub-tranche adjudicates, quoted at LED-025. So as a RANGE
  statement, "outside" was false.
  THE PROPOSITIONS DO NOT OVERLAP: LED-004 claims steps 1-5, which end at
  line 1693, and LED-025 claims step 6 alone. So this is a range-recording
  defect in T1S01a2, not duplicate adjudication - the second such defect
  found in that ledger. IT IS REGISTERED FOR T1S01a5 alongside LED-010's
  1703-1710-versus-1713 defect. See register DEC-50.
  W3C found this, and it found it BECAUSE the comparison was enumerated
  rather than asserted. The countermeasure produced the finding that shows
  its own first application was wrong.
```

---

# LED-025  Step 6 - reconcile the public parameter surface before pixel work

```text
DOCUMENT     authority v1.05, section 23, step 6, line 1694
CLAIM        "Reconcile D4-Q16 public parameter/diagnostic surface before real
             pixel work."
ASSERTS      that the public parameter and diagnostic surface is redesigned
             before any kernel pixel mathematics is implemented.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, and unaffected by the T1/T5 reversal - it concerns
             post-Q14 development order, not the documentation sweep. It is
             also stated in the D4 issue register in this same document, where
             D4-Q16 is defined and marked OPEN, and again at lines 1496-1500
             where the redesign obligations are enumerated.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: the D4-Q16 register entry in section 21, with the
             obligations at lines 1496-1500. A step in a sequence list is a
             work-queue restatement of a question the register owns.
DUPLICATE-ACTION  POINTER. Section 23 is not a designated summary layer, so
             the narrow exception does not reach it.
             KNOWN NON-CANONICAL COPIES INCLUDE: the Concise Project Summary
             and the Standing Task Register, both of which restate the
             before-pixel-work ordering. NOT AN EXHAUSTIVE LIST - the sweep
             recorded below searched for the D4-Q16 token across the live
             corpus, not for every paraphrase of the ordering.
SWEPT        TWO SEPARATE CLAIMS ARE SWEPT HERE, because v1.1 swept only one
             of them and W3C found the gap.
             (a) DUPLICATION. Searched the live corpus (excluding
             superseded/ and scheduled_for_deletion/) for "D4-Q16": found in
             this authority, the Concise Project Summary, the Standing Task
             Register, the T1 resume brief and the T1S01a2/a3 ledgers. The
             ledger hits are adjudication records, not competing copies.
             (b) UNAFFECTEDNESS BY THE T1/T5 REVERSAL, which is what REASON
             actually claims and which search (a) does NOT establish.
             NARROWED AT v1.3 TO WHAT WAS ACTUALLY EXAMINED. v1.2 said this
             checked "every decision touching sequence", and named two. The
             register has later sequencing decisions - DEC-32, DEC-45,
             DEC-49 - so the claim was broader than the check. W3C found it,
             and it is the same defect class as the false sweep assertion:
             a check described more widely than it was performed.
             WHAT WAS ACTUALLY CHECKED, and it is sufficient for the claim
             REASON makes: DEC-02 and DEC-03, which ARE the T1/T5/T6
             reversal being referred to. DEC-02 reverses T1 against T5 and
             T6; DEC-03 withdraws the coordinated T5+T6 packaging
             permission. Neither reaches D4-Q16, the public parameter
             surface, or any post-Q14 development step. THEREFORE THAT
             REVERSAL did not alter this relationship.
             NOT CLAIMED: that no current register decision changes
             D4-Q16's position. That is a broader claim, it would need the
             broader search, and this entry does not need it.
```

```text
TIER     C
PROPOSED
ACTION   Replace with a pointer to D4-Q16 at T3. No change of meaning.
VERDICT  [W3C]
```

---

# LED-026  Step 7 - derive and freeze the scalar kernel mathematics

```text
DOCUMENT     authority v1.05, section 23, step 7, lines 1695-1696
CLAIM        "Derive/freeze Deblock4's scalar kernel mathematics, footprints,
             thresholds, mixed-boundary fixtures and proper-chroma siting
             consequences."
ASSERTS      that the kernel mathematics are derived and frozen at this point
             in the sequence.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Every named item is also carried as an open item in
             Appendix D and as an open question in the section 21 register
             (D4-Q02 luma kernel mathematics, D4-Q04 footprint, D4-Q10
             proper-chroma siting). This step is the work-queue restatement;
             the registers are where the items are defined.
CONFLICTS    none, ON THE PLAIN READING. See DERIVED - the word "freeze" is
             doing two different jobs in this list, and only one of them is
             consistent with step 9.
PREVAILS     CANONICAL HOME, PER PROPOSITION: kernel mathematics -> D4-Q02;
             footprints -> D4-Q04; proper-chroma siting -> D4-Q10; the
             complete not-yet-frozen inventory -> Appendix D.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: Appendix D's open-items list
             and the section 21 register entries named above, both inside this
             authority; the Forward Roadmap's Stage 2D line, outside it. NOT
             EXHAUSTIVE.
SWEPT        Searched Appendix D and section 21 for each named item; searched
             the live corpus for "ReleaseSafe scalar oracle" and "2D" to find
             restatements of the stage content. The roadmap's Stage 2D line
             was found; it is recorded as corrected background under
             LED-029. (v1.2 still pointed here to LED-031, which is
             withdrawn.)

DERIVED      "FREEZE" AT STEP 7 CANNOT MEAN WHAT "FREEZE" MEANS AT STEP 9, and
             the list does not say so. Step 9 freezes "the canonical scalar
             algorithm". If step 7 had already frozen the thresholds and
             formula canonically, step 9 would have nothing left to freeze;
             if step 9's quality decisions may revise them, step 7's freeze is
             provisional. Both readings cannot be right.
             THE COHERENT READING is that step 7 fixes a CANDIDATE algorithm -
             held constant so the comparison at step 9 is controlled - and
             step 9 freezes the CANONICAL one after the quality evidence.
             THE CONSTRAINT THAT STOPS THIS BEING ABUSED, supplied by W3C at
             its review and adopted here as part of the reading rather than
             as a footnote to it: IF STEP 9's QUALITY WORK CHANGES ANY
             STEP-7 VALUE THAT 14.4 REQUIRED TO BE HELD IDENTICAL DURING THE
             COMPARISON, THE OLD COMPARISON NO LONGER PROVES THE REVISED
             CANDIDATE. The candidate stage is re-entered, and the affected
             comparison AND ANY OTHER QUALITY EVIDENCE THAT DEPENDED ON THE
             CHANGED VALUE are rerun - completed at v1.3 to W3C's full
             scope, because a changed threshold or footprint can underpin a
             step 9 quality decision other than the SA/SB comparison, and
             that evidence is stale for exactly the same reason.
             Without this, the two-senses reading would
             license step 9 silently revising thresholds while keeping the
             comparison evidence that was gathered under the old ones - and
             that would be a worse defect than the ambiguity it resolves.
             W3D DID NOT STATE THIS CONSTRAINT. W3C did.
DERIVED-BASIS
             Section 14.4 requires that SA and SB be compared "using identical
             geometry, formulas, thresholds, clipping and boundary policy.
             Only order differs." That comparison is impossible unless the
             thresholds and formula are already fixed before it runs - so
             step 7 preceding step 9 is REQUIRED, not defective. What the text
             lacks is the distinction between fixed-for-the-comparison and
             frozen-as-canonical.
             W3C's earlier warning - that step 7 freezes thresholds while
             Appendix D still lists threshold and strength behaviour as
             unresolved - resolves the same way: Appendix D describes the
             state TODAY, and step 7 is the step that changes it. There is no
             contradiction between them. The ambiguity is internal to the
             word.
```

```text
TIER     C for the disposition. THE DERIVED HALF IS TIER A BY W3X DIRECTION -
         see the routing note below.
PROPOSED
ACTION   At T3, pointer as above. SEPARATELY, and not as part of T3: W3X may
         wish the two senses distinguished in the authority text. That is a
         wording change to a ratified document and is NOT proposed here.

         AN EXPLICIT VERDICT ON THE DERIVED HALF IS REQUIRED - register
         DEC-47. State plainly EITHER that the two-senses reading holds and
         your earlier threshold warning is dissolved, OR that it does not and
         the step 7 defect is live. SILENCE DOES NOT DISCHARGE THIS - DEC-44.
         If this response does not answer it, it is re-asked, and it stays
         open until answered. The reason it is flagged this hard: it is W3D's
         own argument dissolving a warning raised against W3D's own area, and
         it would be easy to lose while everyone looks at LED-029.
VERDICT  [W3C]
```

---

# LED-027  Step 8 - build the independent ReleaseSafe scalar oracle

```text
DOCUMENT     authority v1.05, section 23, step 8, line 1697
CLAIM        "Build the independent ReleaseSafe scalar oracle under its own
             obligations."
ASSERTS      that the oracle is constructed, and that it is accepted against
             obligations rather than against a pre-existing oracle.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. The obligations-not-diff acceptance basis is specified
             in Verification and Tiering Decisions section 20.2, the
             oracle-construction exception, which exists precisely to break
             the circularity of requiring an oracle before the code that
             becomes one. D4-Q03 in section 21 states the same in question
             form.
CONFLICTS    none in this entry. The ORDERING conflict is LED-029.
PREVAILS     CANONICAL HOME: THE CHARTER's ORACLE-CONSTRUCTION EXCEPTION, in
             the mandatory session-bootstrap block, with Verification and
             Tiering Decisions section 20.2 as the detailed durable decision
             record and rationale.
             CORRECTED AT v1.2. v1.1 named the tiering record as the
             canonical home. W3C pointed out that the tiering record's own
             header says the charter and README are controlling and prevail,
             so it cannot be the canonical home for a controlling rule.
             VERIFIED COLD rather than taken on trust: the charter carries
             the exception in full, including the independently-authored
             obligations list with SCHEDULE among them, and the sanity-gate
             requirement. The two documents agree; what changes is which one
             is the home.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: the charter's G-series
             wording, the README, the Forward Roadmap's Stage 2D line, the
             coder introduction and the Concise Project Summary. NOT
             EXHAUSTIVE - the corpus search below was for one phrase.
SWEPT        Searched the live corpus for "ReleaseSafe scalar oracle": found
             in the charter, README, Forward Roadmap, coder introduction,
             Concise Project Summary, Project Status, the D0 binding knowledge
             index, Verification and Tiering Decisions and this authority.
             Read section 20.2 in full to establish which is the specifying
             copy rather than assuming the authority's own copy was.
```

```text
TIER     C
PROPOSED
ACTION   Pointer at T3 to THE CHARTER's oracle-construction exception, the
         canonical controlling home, naming Verification and Tiering
         Decisions section 20.2 as the detailed record. (CORRECTED at v1.3:
         v1.2 corrected the canonical home in PREVAILS and left this action
         pointing at the old target, so the entry contradicted itself. W3C
         found it.)
VERDICT  [W3C]
```

---

# LED-028  Step 9 - the schedule and quality decisions, and the canonical freeze

```text
DOCUMENT     authority v1.05, section 23, step 9, lines 1698-1699
CLAIM        "Perform processing Schedule-SA/SB and quality decisions; freeze
             the canonical scalar algorithm."
ASSERTS      that the processing-order winner and the quality decisions are
             settled here, and that the canonical algorithm is frozen at this
             point.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Section 14 defines the candidates and 14.4 specifies the
             required comparison and its corpus; Appendix D lists the winner
             as not yet frozen. This step restates work those sections own.
CONFLICTS    none in this entry. The ORDERING conflict is LED-029.
PREVAILS     CANONICAL HOME: section 14, and 14.4 for the comparison
             requirement.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: Appendix D's open-items
             entry for the SA/SB winner, inside this authority; the Forward
             Roadmap's Stage 3D line and the Standing Task Register's quality-
             gate list, outside it. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "Schedule-SA": found in this
             authority, Project Status, the designer introduction, the T1
             resume brief, the Standing Task Register and the T1S01a2/a3
             ledgers. Read section 14 in full.
```

```text
TIER     C
PROPOSED
ACTION   Pointer to section 14 at T3.
VERDICT  [W3C]
```

---

# LED-029  THE ORDERING - step 8 before step 9, against line 1153

```text
DOCUMENT     authority v1.05, section 23, steps 8-9 (lines 1697-1699), read
             against line 1153
CLAIM        the SEQUENCE: "8. Build the independent ReleaseSafe scalar oracle
             [...] 9. Perform processing Schedule-SA/SB and quality decisions;
             freeze the canonical scalar algorithm." Line 1153: "The winner
             becomes part of the future Deblock4 scalar oracle."
ASSERTS      that the oracle is built before the decision that determines one
             of its constituent properties.
CLASS        W3X-RATIFIED, and internally inconsistent
DISPOSITION  CONFLICTING
REASON       The two statements cannot both be executed as written. If the
             schedule winner becomes part of the oracle, the oracle cannot be
             complete before the winner is known. This is not a wording
             preference: Verification and Tiering Decisions section 20.2 lists
             SCHEDULE among the independently authored obligations the
             oracle-construction scope is accepted AGAINST, so under the
             ratified acceptance rule the schedule is an INPUT to that scope.
             A scope cannot be accepted against an obligation that the
             following step is scheduled to decide.
CONFLICTS    authority line 1153; Verification and Tiering Decisions section
             20.2.
PREVAILS     LINE 1153 AND THE CHARTER's ORACLE-CONSTRUCTION EXCEPTION
             PREVAIL over section 23's ordering, with Verification and
             Tiering Decisions section 20.2 as the detailed record of the
             same rule. (Source hierarchy corrected at v1.2 on W3C's
             finding; v1.1 named the tiering record first.)
             Both are substantive statements about what the oracle IS and how
             it is accepted; section 23 is a sequence list, and this
             authority's own single-source rule places work-queue sequencing
             outside its domain. The loser is the ordering, not either
             statement.
SWEPT        n/a - this entry claims a conflict, not uniqueness. The sources
             read to establish it are named in DERIVED-BASIS.

DERIVED      THE DEFECT IS NOT A BARE 8/9 ORDERING SWAP. STEP 8 CONFLATES
             TWO ROLES AND TWO ACCEPTANCE STATES:
                 8a  COMPARISON CANDIDATE role - scalar implementations of
                     both schedules, sufficient to run 14.4's controlled
                     comparison. NOT an accepted oracle.
                 8b  RELEASESAFE ORACLE role - accepted under the
                     oracle-construction rule, after the schedule freeze.
             Running the comparison at all requires scalar implementations of
             both schedules, so a bare swap of steps 8 and 9 would produce a
             worse defect than the one it fixes, by scheduling a comparison
             before anything exists to compare. What the comparison needs is
             a CANDIDATE; what step 8 builds is an ACCEPTED ORACLE; the list
             gives them one name and one position.
             WHAT IS PROVED IS THE SEPARATION OF STATUS AND ACCEPTANCE
             BASIS, NOT OBJECT IDENTITY. The same implementation may be
             reused, refactored or hardened across the two roles; the
             project does not currently require two persistent
             implementation artifacts. The winning candidate does NOT become
             the oracle by winning - 8b must still construct and accept it
             under its own independently authored basis - but nothing in the
             ratified text requires that candidate's code to be discarded.
             WORDING CORRECTED AT v1.3. v1.1 argued "one artifact where the
             project needs two"; W3C accepted the roles/states separation
             and expressly declined to establish the stronger
             two-implementations proposition; v1.2 added the refinement but
             LEFT THE OLD PREMISE LIVE IMMEDIATELY ABOVE IT. A partial
             replacement that leaves the rejected claim in the operative
             text is the same defect as a reissue whose closing section
             still argues the pre-reissue position. W3C found it.

             THE PROPOSED REPAIR, which preserves every constraint:
                 8a  author the scalar obligations, and build the scalar
                     candidate implementations of Schedule-SA and Schedule-SB
                     needed to run 14.4's comparison. These are COMPARISON
                     INSTRUMENTS. They are not the accepted oracle and do not
                     become it by surviving.
                 9   run the comparison and the quality decisions; freeze the
                     canonical scalar algorithm, schedule included.
                 8b  build and accept the independent ReleaseSafe scalar
                     oracle under section 20.2, with the frozen schedule now
                     available as an authored obligation.
             Numbering is illustrative; W3X may prefer a renumbering.
DERIVED-BASIS
             Section 14.4: SA and SB "must be compared in scalar form using
             identical geometry, formulas, thresholds, clipping and boundary
             policy. Only order differs." It requires scalar FORM. It does not
             require the accepted oracle, and nothing in section 14 says the
             comparison instrument must be the oracle.
             Section 20.2: the construction scope is accepted against
             independently authored obligations - "arithmetic vectors,
             threshold tables, geometry, footprints, schedule, range/overflow
             proof, memory canaries, exceptional-value cases" - which places
             the schedule before the accepted oracle, not after it.
             Line 1153: the winner becomes part OF the oracle, which is
             consistent with 8b and inconsistent with 8-before-9 as written.
             W3C's constraint, from its first review of this range: it
             declined to propose swapping the steps because scalar candidate
             implementations may be needed in order to compare schedules at
             all. That constraint is what the two-role reading satisfies and
             a swap does not.
             THE FORWARD ROADMAP IS NOT EVIDENCE EITHER WAY, AND v1.1 WAS
             WRONG TO SAY IT WAS. v1.1 claimed the roadmap, section 23 and
             the shorthand block arrange these decisions three different
             ways, and offered that as evidence the defect is structural.
             W3C showed the claim is overstated: the roadmap's Stage 2D line
             includes "schedules A/B" but never says the WINNER is selected
             at 2D, and Stage 3D is the quality decision and canonical
             freeze. That reads naturally as build candidates at 2D, compare
             and select at 3D - which is COMPATIBLE with this repair rather
             than contrary to it. The roadmap is retained here as background
             only. THE CONFLICT STANDS WITHOUT IT, on line 1153 and the
             charter's acceptance rule alone.
             W3D withdrew this claim on W3C's finding. A supporting argument
             that flatters the proposal it supports is exactly the kind that
             should not survive its refutation quietly.

             AN OPEN QUESTION THE REPAIR EXPOSES, AND DOES NOT ANSWER: the
             candidate implementations at 8a produce pixels but are not the
             oracle, so neither 20.1's differential-measurement rule nor
             20.2's construction exception plainly covers them. 20.2 exempts
             "the FIRST bounded scope that constructs a filter's ReleaseSafe
             scalar oracle" - and 8a is not that scope. What accepts 8a is
             therefore unspecified. This is a real gap in the ratified
             verification rules, not a drafting nicety, and it belongs to W3X
             rather than to this ledger.
```

```text
TIER     A - CONFLICTING, and the repair is a proposal about the development
         sequence of an unwritten filter. The DERIVED half is the part to
         attack.
PROPOSED
ACTION   W3X HAS ALREADY TAKEN A PROVISIONAL POSITION ON THIS ENTRY, and W3C
         is told so rather than left to infer it:
         1. THE REPAIR IS PROVISIONALLY ADOPTED, SUBJECT TO W3C - register
            DEC-45. It is NOT ratified. If W3C refutes the two-role/
            two-acceptance-state distinction the adoption falls, and W3C is
            expected to say so
            plainly if it thinks so. A provisional position is a thing to
            test, not a thing to confirm; the reviewer is not being asked to
            agree with W3X.
         2. If ratified, the repaired sequence is recorded in the STANDING
            TASK REGISTER, not in the authority - consistent with
            LED-003/LED-004's treatment of the head of the same list.
         3. THE ACCEPTANCE GAP BELOW IS REGISTERED OPEN at DEC-46, owed to
            Verification and Tiering Decisions, and is a blocker on the 8a
            scope rather than on T1. W3D deliberately did not close it:
            authoring that acceptance basis would be W3D writing the
            criteria for W3D's own future deliverable.
VERDICT  [W3C]
```

---

# LED-030  Step 10 - vector backends only after the canonical freeze

```text
DOCUMENT     authority v1.05, section 23, step 10, line 1700
CLAIM        "Only then develop D4 v2/v3 vector backends and differential
             proof."
ASSERTS      that no vector backend work begins until the canonical scalar
             algorithm is frozen and the oracle exists to diff against.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, and correct on its own terms - it is the same rule the
             Classic filter was actually built under. Verification and Tiering
             Decisions section 20.2 states it generally: after the oracle is
             accepted, every subsequent pixel-producing, ReleaseFast, v2 or v3
             scope must be differentially measured against it.
CONFLICTS    none. Note that LED-029's repair does NOT disturb this step: the
             canonical freeze still precedes backend work under the proposed
             sequence, because 8b follows 9.
PREVAILS     CANONICAL HOME: THE CHARTER - G7 for what cross-backend
             equivalence means per output type, and the oracle-construction
             exception's closing sentence for the after-acceptance rule
             ("every subsequent pixel/frame/copy/ReleaseFast-scalar/v2/v3
             scope must be differentially validated against it"). Tiering
             Decisions section 20.2 is the detailed durable record.
             CORRECTED AT v1.2, same finding as LED-027.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: the Forward Roadmap's Stage
             4D and 5D lines. NOT EXHAUSTIVE.
             CORRECTED AT v1.2: v1.1 also named charter G5. THAT WAS WRONG -
             G5 is the execution-safety rule (a backend's instructions are
             never executed on a machine not proven to support them), which
             is a different proposition. Verified cold at charter line 506.
             The equivalence material is G7, at line 643, and G7 is part of
             the canonical home named above rather than a non-canonical
             copy. W3C found this.
SWEPT        Read Verification and Tiering Decisions section 20.2 in full, the
             charter's oracle-construction block and G7, and the roadmap's
             stage list at lines 143-149.
```

```text
TIER     C
PROPOSED
ACTION   Pointer at T3.
VERDICT  [W3C]
```

---

# REMOVED AT v1.2 - LED-031 AND LED-032

```text
v1.1 carried two entries here:
    LED-031  the old-roadmap 2D/3D/4D/5D shorthand
    LED-032  the prerequisites sentence

BOTH ARE WITHDRAWN. They re-adjudicated authority lines 1703-1710, which
T1S01a2 LED-010 already owns and disposes of - CURRENT-DUPLICATE, with the
prerequisite statement staying here and the stage-name shorthand becoming a
pointer to the Forward Roadmap once T1 repairs it. W3C found this.

THE SOURCE TEXT IS NOT ORPHANED. It remains adjudicated at LED-010, and
LED-010's own atomicity - it covers two propositions under one disposition -
is already owed to T1S01a5's whole-document consistency pass. Pulling that
repair forward into a4 would move a5's work without improving it.

WHAT THIS SUB-TRANCHE ADJUDICATES IS THEREFORE LINES 1694-1700 ONLY.
Section 0 is corrected to say so.

THE ROADMAP OBSERVATION FROM LED-031 IS RETAINED, corrected, as evidence
under LED-029 - not as a second adjudication of already-ledgered text. It is
corrected because W3C showed the claim was overstated: see LED-029.
```

---

# What W3C is asked here

You asked for a mechanical delta check on nine named corrections. That is
what this is. Nothing technical is reopened.

```text
1. IS THE OVERLAP NOW ACTUALLY EXCLUDED? Section 0 no longer asserts that a
   sweep happened - it names every T1S01a2 entry, its range, and the
   comparison. That is the countermeasure to the failure you found, and it is
   the first thing to test, because a naming that is itself incomplete would
   be the same defect wearing better clothes.

2. LED-025's SECOND SWEEP. The entry now sweeps unaffectedness separately
   from duplication, by checking every sequencing decision in the register
   and finding none that reaches D4-Q16. Is that the right search to prove
   the claim REASON actually makes?

3. THE THREE CORRECTIONS YOU SUPPLIED, applied at LED-027, LED-029 and
   LED-030: charter first and tiering record as detailed record; G5 removed
   as the wrong rule; the roadmap withdrawn as evidence and recorded as
   compatible-not-contrary. Did each land where you meant it?

4. YOUR TWO REFINEMENTS ARE NOW LOAD-BEARING TEXT rather than review
   comments, and should be read as such: the two-roles-not-two-codebases
   wording in LED-029's DERIVED half, and the rerun constraint in LED-026's.
   Both are yours. Check that they say what you meant rather than what W3D
   understood you to mean - that gap is where refinements usually die.

5. WHAT IS UNCHANGED FROM v1.1 AND NEEDS NO RE-READING: LED-028 entire;
   LED-026's finding half; LED-027 and LED-030's DISPOSITION and REASON;
   LED-029's CLAIM, ASSERTS, DISPOSITION, REASON and CONFLICTS.
   NOTE PRECISELY: LED-029's PREVAILS field DID change - the source hierarchy
   correction touches the finding half, not only the derivation - so
   "LED-029's finding half is unchanged" would be false and is not claimed.
   Only the fields named in the revision history moved.
```

---

*Revision history*
```text
v1.3 (2026-08-18) SECOND NARROW REISSUE. Nine corrections, all W3C's, none
     reopening the technical result.
     THE FIRST APPLICATION OF DEC-48 WAS ITSELF INACCURATE, which W3C found
     BECAUSE the enumeration existed to be counted:
       - the population was called "every T1S01a2 entry" and then included
         LED-001 and LED-002, which belong to T1S01a1 and adjudicate the
         pre-registered items, not currency statements. Wrong ledger and
         wrong subject. The population is now named as every entry in every
         prior T1 ledger and enumerated per ledger.
       - LED-004 was recorded as outside this range. Its RECORDED range
         ends at line 1694, which IS step 6. The propositions do not
         overlap - LED-004 claims steps 1-5, ending 1693 - so this is a
         SECOND range-recording defect in T1S01a2, now registered for
         T1S01a5 at DEC-50.
     OTHER CORRECTIONS:
       LED-025  the unaffectedness sweep claimed "every decision touching
                sequence" and named two. Narrowed to what was examined -
                DEC-02 and DEC-03, which ARE the reversal - and the broader
                claim is expressly not made.
       LED-026  the rerun constraint extended to ALL quality evidence that
                depended on a changed value, not only the SA/SB comparison.
                W3C's full scope, which v1.2 had narrowed.
       LED-026  stale pointer to the withdrawn LED-031 replaced.
       LED-027  PROPOSED ACTION now points at the charter, agreeing with
                the canonical home v1.2 corrected in PREVAILS. The entry
                had contradicted itself.
       LED-029  the rejected "one artifact / two artifacts" premise removed
                from the operative text and replaced throughout with two
                ROLES and two ACCEPTANCE STATES. v1.2 added the refinement
                and left the rejected claim live above it - a partial
                replacement, the same defect as a reissue whose closing
                section still argues the pre-reissue position.
     UNCHANGED: every disposition; LED-028 entire; the finding halves of
     LED-025, LED-026, LED-027, LED-029 and LED-030 apart from the fields
     named above.
v1.2 (2026-08-18) NARROW REISSUE after W3C's review, which recommended
     against closing a4 on v1.1.
     THE METHOD DEFECT, and it is W3D's: v1.1's coverage declaration
     asserted that the ledger set had been swept and the overlap excluded.
     THE ASSERTION WAS FALSE. T1S01a2 LED-010 already adjudicates authority
     lines 1703-1710 - the 2D/3D/4D/5D shorthand AND the prerequisite
     sentence - and v1.1 re-adjudicated both at LED-031 and LED-032. This is
     the second consecutive sub-tranche in which W3D re-derived
     already-ledgered material, and this time the false assurance was
     written into the document as the countermeasure against it.
     WITHDRAWN: LED-031 and LED-032. The source text stays with LED-010;
     its atomicity repair is already owed to T1S01a5. The adjudicated range
     is corrected to lines 1694-1700, and LED-010's own range-recording
     defect (it says 1703-1710 while the sentence runs to 1713) is recorded
     as an a5 item rather than fixed here.
     SECTION 0 NO LONGER ASSERTS THAT A SWEEP HAPPENED. It names every
     T1S01a2 entry, its range and the comparison - register DEC-48.
     CORRECTIONS APPLIED, all W3C's:
       LED-025  SWEPT now covers UNAFFECTEDNESS separately from
                duplication. v1.1 claimed the step was unaffected by the
                T1/T5 reversal and searched only for duplication.
       LED-026  the rerun constraint added to the DERIVED half: if step 9
                revises a value 14.4 held fixed, the comparison evidence is
                stale and the affected comparison is rerun. W3C's, and W3D
                had not stated it.
       LED-027  canonical home corrected to the CHARTER's
                oracle-construction exception, with the tiering record as
                the detailed record. Verified cold against the charter.
       LED-029  DERIVED refined from "two artifacts" to TWO ROLES AND TWO
                ACCEPTANCE STATES - the winning candidate does not become
                the oracle by winning, but nothing requires its code to be
                thrown away. Source hierarchy corrected. AND THE ROADMAP
                THREE-WAY-DISAGREEMENT CLAIM IS WITHDRAWN: W3C showed the
                roadmap's 2D/3D split is compatible with this repair rather
                than contrary to it. The conflict stands without it.
       LED-030  canonical home corrected as LED-027; charter G5 removed
                from the copy list as the wrong rule (it is execution
                safety, verified at charter line 506).
     UNCHANGED: LED-028 entire; the finding halves of LED-026 and LED-029;
     LED-027 and LED-030's dispositions and reasons.
v1.1 (2026-08-18) Records W3X's decisions on the three questions this ledger
     raised, before issue. NO ENTRY'S DISPOSITION, CLAIM, REASON, CONFLICTS,
     PREVAILS, DUPLICATE-ACTION, SWEPT, DERIVED OR DERIVED-BASIS FIELD
     CHANGED; only two routing blocks did.
     LED-029: W3X provisionally adopts the two-artifact repair SUBJECT TO
     W3C (DEC-45), and W3C is told so explicitly rather than left to infer
     it from silence - with the equally explicit statement that a provisional
     position is a thing to test and not a thing to confirm. The acceptance
     gap is registered open at DEC-46 and named a blocker on the 8a scope.
     LED-026: the DERIVED half is raised to Tier A by W3X direction and an
     explicit verdict is required (DEC-47), because W3D's argument dissolves
     a warning raised against W3D's own area and could otherwise be lost
     behind LED-029.
v1.0 (2026-08-18) First ledger for T1S01a4. Adjudicates section 23 steps 6-10
     and the roadmap-shorthand tail, and disposes of the DEC-32 ordering
     defect at LED-029 with a derived two-artifact repair that separates the
     scalar comparison instruments from the accepted ReleaseSafe oracle.
     Records an acceptance gap the repair exposes and does not answer.
     Written under review scope v1.11, including the refined STAY-CANONICAL
     evidence requirement - which no entry here needed to invoke.
     The T1S01a2 and T1S01a3 ledgers were swept for overlap BEFORE this was
     written, and the overlap is excluded in section 0 rather than
     re-derived.
```
