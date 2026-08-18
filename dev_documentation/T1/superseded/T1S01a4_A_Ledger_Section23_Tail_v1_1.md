# Deblock4 - T1S01a4 Ledger: Section 23 Steps 6-10 and the Ordering Defect

**Deliverable:** T1S01a4_A - LEDGER
**Version:** 1.1 - W3X's provisional position added; no adjudication changed
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Adjudicates:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`, section 23, lines 1694-1712
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_16.md`
**Encoding:** US-ASCII; CRLF.

---

# 0. COVERAGE DECLARATION

```text
ADJUDICATED HERE, and nothing else:

  lines 1694-1700   section 23 numbered steps 6, 7, 8, 9 and 10
  line  1702-1712   the old-roadmap-shorthand block (2D/3D/4D/5D) and the
                    prerequisites sentence that follows it

EVERY PROPOSITION IN THAT RANGE has an entry below, or is named here as
assigned onward. Nothing is assigned onward from this range.

CARRIED IN FROM THE REGISTER, because it is a property OF this range rather
than of any one line in it:

  DEC-32  section 23 orders step 8 (build the oracle) before step 9 (decide
          the schedule), while line 1153 says the schedule winner becomes
          part of that oracle. Adjudicated at LED-029.

NOT ADJUDICATED HERE, and where it goes:

  lines 1679-1694   section 23's opening paragraph and steps 1-5. Already
                    adjudicated in T1S01a2 at LED-003, LED-004, LED-005,
                    LED-006 and LED-009. NOT reopened.
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

**THE LEDGER SET WAS SWEPT BEFORE THIS ONE WAS WRITTEN.** T1S01a2 and T1S01a3
were read for overlap with this range. The overlap found is listed above and is
excluded rather than re-derived. This check exists because the previous
sub-tranche reported an already-adjudicated statement as a fresh find.

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
SWEPT        Searched the live corpus (excluding superseded/ and
             scheduled_for_deletion/) for "D4-Q16": found in this authority,
             the Concise Project Summary, the Standing Task Register, the T1
             resume brief and the T1S01a2/a3 ledgers. The ledger hits are
             adjudication records, not competing copies.
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
             was found and is recorded at LED-031.

DERIVED      "FREEZE" AT STEP 7 CANNOT MEAN WHAT "FREEZE" MEANS AT STEP 9, and
             the list does not say so. Step 9 freezes "the canonical scalar
             algorithm". If step 7 had already frozen the thresholds and
             formula canonically, step 9 would have nothing left to freeze;
             if step 9's quality decisions may revise them, step 7's freeze is
             provisional. Both readings cannot be right.
             THE COHERENT READING is that step 7 fixes a CANDIDATE algorithm -
             held constant so the comparison at step 9 is controlled - and
             step 9 freezes the CANONICAL one after the quality evidence.
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
PREVAILS     CANONICAL HOME: Verification and Tiering Decisions section 20.2.
             The acceptance basis for a construction scope is a verification
             rule, and verification rules live in that document - this
             authority's own single-source rule says non-MPEG-2-specific
             global rules remain in their existing authorities and are
             referenced rather than duplicated here.
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
ACTION   Pointer to Verification and Tiering Decisions section 20.2 at T3.
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
PREVAILS     LINE 1153 AND SECTION 20.2 PREVAIL over section 23's ordering.
             Both are substantive statements about what the oracle IS and how
             it is accepted; section 23 is a sequence list, and this
             authority's own single-source rule places work-queue sequencing
             outside its domain. The loser is the ordering, not either
             statement.
SWEPT        n/a - this entry claims a conflict, not uniqueness. The sources
             read to establish it are named in DERIVED-BASIS.

DERIVED      THE DEFECT IS NOT THE ORDER OF THE TWO STEPS. IT IS THAT STEP 8
             NAMES ONE ARTIFACT WHERE THE PROJECT NEEDS TWO.
             Running the comparison at all requires scalar implementations of
             both schedules - so a bare swap of steps 8 and 9 would produce a
             worse defect than the one it fixes, by scheduling a comparison
             before anything exists to compare. But what the comparison needs
             is scalar CANDIDATES, and what step 8 builds is the ACCEPTED
             oracle. These are different artifacts with different acceptance
             bases, and the list conflates them.
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
             all. That constraint is what the two-artifact reading satisfies
             and a swap does not.
             The Forward Roadmap independently places the oracle AND the
             schedules together in Stage 2D, with the freeze at 3D - a third
             arrangement, differing from both section 23 and this proposal.
             It is recorded at LED-031 and is NOT evidence for the repair.

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
            DEC-45. It is NOT ratified. If W3C refutes the two-artifact
            distinction the adoption falls, and W3C is expected to say so
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
PREVAILS     CANONICAL HOME: Verification and Tiering Decisions section 20.2,
             with the charter's per-type differential-equivalence rules for
             what the proof must show.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: the Forward Roadmap's Stage
             4D and 5D lines and the charter's G5 capability-guard rule. NOT
             EXHAUSTIVE.
SWEPT        Read Verification and Tiering Decisions section 20.2 in full, and
             the roadmap's stage list at lines 143-149.
```

```text
TIER     C
PROPOSED
ACTION   Pointer at T3.
VERDICT  [W3C]
```

---

# LED-031  The old-roadmap shorthand block

```text
DOCUMENT     authority v1.05, section 23, lines 1702-1710
CLAIM        "The old roadmap shorthand remains conceptually: 2D Deblock4
             scalar/oracle construction; 3D Deblock4 scalar quality/canonical
             freeze; 4D Deblock4 v2 backend + differential proof; 5D Deblock4
             v3 backend + differential/performance proof."
ASSERTS      that the older stage labels still map onto the current sequence.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       The mapping is current AS A MAPPING. But the labels it maps to
             are owned by the Forward Roadmap, which defines the stage
             contents, and this copy defines nothing.
CONFLICTS    none as written - but see DERIVED. The roadmap's own Stage 2D
             line does not say what this shorthand says it says.
PREVAILS     CANONICAL HOME: the Forward Roadmap's stage list. Stage labels
             are roadmap objects.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: the Forward Roadmap stage
             list itself is the home; restatements appear in the coder
             introduction, the README and the Concise Project Summary. NOT
             EXHAUSTIVE.
SWEPT        Searched the live corpus for "2D" as a stage label and read the
             Forward Roadmap's stage list at lines 143-149 in full.

DERIVED      THE SHORTHAND AND ITS OWN CANONICAL HOME DISAGREE ABOUT WHERE THE
             SCHEDULE DECISION SITS. This block says 2D is "scalar/oracle
             construction" and 3D is "quality/canonical freeze". The Forward
             Roadmap's Stage 2D line includes "schedules A/B" IN 2D, alongside
             the oracle - so the roadmap places the schedule work with the
             oracle, section 23 places it after, and this shorthand implies a
             third split. Three live documents, three arrangements of the same
             two decisions.
             THIS IS EVIDENCE FOR LED-029 BEING A REAL DEFECT rather than a
             drafting slip: the ambiguity has propagated to every document
             that restates the sequence, which is what happens when a sequence
             is written in more than one place and specified in none.
DERIVED-BASIS
             Forward Roadmap lines 143-149, read cold. Note the roadmap
             carries an in-scope staleness banner, and its own banner at lines
             41-43 flags the Stage 2D line for naming "midpoint", which
             belongs to the REJECTED Architecture A. That banner is not an
             adjudication and the roadmap remains in the sweep population; the
             disagreement recorded here is about the schedule, not the
             midpoint, and does not depend on the banner.
```

```text
TIER     C for the disposition. The DERIVED half is offered as support for
         LED-029 and should be attacked with it.
PROPOSED
ACTION   Pointer to the Forward Roadmap at T3. The three-way disagreement is
         a consequence of LED-029 and needs no separate remedy IF LED-029's
         repair is adopted and recorded in one place.
VERDICT  [W3C]
```

---

# LED-032  The prerequisites sentence

```text
DOCUMENT     authority v1.05, section 23, lines 1711-1712
CLAIM        "but Q14 and the architecture/API reconciliation are now
             prerequisites before 2D's pixel mathematics can be responsibly
             scoped."
ASSERTS      that no Deblock4 pixel mathematics may be scoped until the
             architecture-discriminator experiment reports and the public
             surface is reconciled.
CLASS        W3X-RATIFIED
DISPOSITION  OPERATIVE-SPEC
REASON       This one is NOT merely work-queue sequencing, and that is why it
             takes a different disposition from its neighbours. It is the
             live prohibition currently governing the project: no kernel scope
             may be drafted before Q14 reports and W3X ratifies what may enter
             kernel development. It is being obeyed right now - the filter has
             no kernel, and no kernel scope is open - so it is a specification
             the project actually implements rather than a plan it intends to
             follow.
CONFLICTS    none.
PREVAILS     n/a - OPERATIVE-SPEC statements stay where they are and gain a
             pointer alongside.
SWEPT        n/a - no uniqueness, independence or unaffectedness is claimed.
             The statement is restated elsewhere (Project Status, both
             introductions, the register); the disposition does not depend on
             it being unique, and OPERATIVE-SPEC keeps it here regardless.
```

```text
TIER     C
PROPOSED
ACTION   Keep in place. Add a pointer alongside at T3 so the restatements
         elsewhere reduce to references to this sentence.
VERDICT  [W3C]
```

---

# What W3C is asked here

```text
1. LED-029'S DERIVED HALF IS THE WHOLE SUB-TRANCHE. The finding - that the
   ordering contradicts line 1153 and section 20.2 - is straightforward. The
   REPAIR is new reasoning by the designer and rests on a distinction the
   ratified text does not draw: that the comparison instrument and the
   accepted oracle are different artifacts. If that distinction is wrong, or
   if the project cannot afford two scalar implementations, the repair fails
   and the defect needs a different answer.
   YOUR EARLIER CONSTRAINT IS WHAT THE REPAIR IS BUILT AROUND - you declined
   to propose a step swap because candidates may be needed to compare
   schedules at all. Check that the repair actually honours it rather than
   merely citing it.

2. THE ACCEPTANCE GAP AT 8a. If the candidates are not the oracle, section
   20.2's exception does not cover them and 20.1's differential rule has
   nothing to diff against. W3D states this as an open question rather than
   answering it. Is it real, and is it as wide as stated?

3. LED-026'S TWO SENSES OF "FREEZE". W3D reads step 7 as fixing a candidate
   algorithm and step 9 as freezing the canonical one, and argues this
   dissolves the threshold warning from your first review of this range.
   Does it, or is there still a live problem there?

4. THE DISPOSITIONS. Six of the eight entries are CURRENT-DUPLICATE with
   POINTER, which is a uniform result and therefore suspect on its face. The
   uniformity is claimed to follow from section 23 being a sequence list that
   restates work other sections own. Test at least one against its stated
   home independently.

5. LED-032 IS THE ONE THAT BREAKS THE PATTERN - OPERATIVE-SPEC rather than
   CURRENT-DUPLICATE, on the ground that the project is obeying it right now.
   If that reasoning is wrong, it is wrong in an interesting way, because the
   same argument could be made about several neighbours.

6. THE STAY-CANONICAL EVIDENCE RULE YOU REFINED IS NOT EXERCISED HERE - no
   entry claims STAY-CANONICAL. Every duplicate in this range is
   non-canonical, which is itself worth a moment's suspicion: it means this
   ledger asserts that section 23 owns nothing in lines 1694-1712 except
   LED-032. Is that right?
```

---

*Revision history*
```text
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
