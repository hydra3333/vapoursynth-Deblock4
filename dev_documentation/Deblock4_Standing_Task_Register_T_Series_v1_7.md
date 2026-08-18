# Deblock4 - Standing Task Register (T-Series) for the MPEG-2 / Deblock4 Arc

**Version:** 1.7
**Date:** 2026-08-18
**Author:** W3D (v1.0); W3C v1.1 reconciliation; W3D v1.2 sequencing and
method; W3D v1.3 outgoing-designer evidence absorbed; W3D v1.4 review model,
step plan and manifest finding; W3D v1.5 T1S00 review outcomes
**Status:** W3X-RATIFIED. This is the authoritative list of outstanding process
and design tasks for the Deblock4 MPEG-2 arc. (v1.1 was issued as a
"ratification candidate"; W3X confirmed ratification on 2026-08-17 and the
status line is corrected here.) It exists because the T-series was previously
carried only in conversation and in condensed form inside Project Status
section 0, which does not survive a session boundary well.
**Relationship to other documents:** the ARCHITECTURE authority is
Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05
(or later; read its section 0 first). THIS document holds the WORK QUEUE, not
the decisions. Where the two touch, the authority document prevails.
**Maintenance rule:** when a task completes, mark it DONE with the date and
the artifact that discharged it - do not delete it.
**Encoding:** US-ASCII; CRLF.

---

# 0. Status at a glance

```text
  T1        Formal consolidation sweep ......... IN PROGRESS.
                                                 T1S00 COMPLETE (manifest v1.3,
                                                 frame frozen). T1S01a1 issued
                                                 and BOTH ENTRIES REJECTED by
                                                 W3C - see DEC-23/24/25.
                                                 T1S01a2 HELD pending the
                                                 ledger template fix.
  T1-EVID   Outgoing-designer answer set ....... COMMITTED as evidence
                                                 (see DEC-11)
  T1-PREREG Pre-registered adjudication items .. 4 items registered; see
                                                 section T1-PREREG
  T1.1      Mathematical inventory/gap table ... NEW; runs inside T1, reports
                                                 after it
  T2        Retire the Grid Knowledge document . BLOCKED by T1
  T3        De-duplicate into references ....... BLOCKED by T1
  T4        Boundary-set mathematics ........... SUBSUMED into T1.1-MATHS;
                                                 no longer closed "by absorption"
  T5        Detector mathematics ............... AFTER T1 (order reversed by
                                                 W3X 2026-08-17)
  T6        D4-Q14 experiment plan ............. AFTER T5, as a separate
                                                 ratification (not one package)
  T7        Final consolidation commit ......... BLOCKED by T1-T6

  HARD RULE, independent of this queue: NO DEBLOCK4 KERNEL SCOPE MAY BE
  DRAFTED until the D4-Q14 architecture-discriminator experiment reports and
  W3X ratifies the architecture allowed to enter kernel/oracle development.

  CURRENT RESUME ORDER FOR A NEW W3D:
      Project Status v1.28 section 0
      -> MPEG-2 authority v1.05 section 0
      -> this task register (READ SECTION 1: DECISION LOG, then T1-PREREG)
      -> T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
      -> the T1 adjudication ledger as far as it has been delivered
      -> resume T1 at the first unadjudicated document in the scope manifest
```

---

# 1. DECISION LOG - decisions taken 2026-08-17, with the reason for each

Recorded here rather than only in conversation, because a chat death loses
conversation and this arc has already lost two designer sessions. Each entry
states what was decided and WHY, so a successor inherits the reasoning and not
just the instruction.

```text
DEC-01  The task register is RATIFIED (status line corrected).
        WHY: it is the only document sequencing designer work; taking work
        direction from a document marked "candidate" left the sequence resting
        on conversation rather than a ratified record.
        (W3X, 2026-08-17)

DEC-02  T1 RUNS BEFORE T5. The earlier T5-first sequence is reversed.
        WHY: T5 derives detector features, scoring, confidence and the UNKNOWN
        threshold. The README already proved it can contain a fully-worked,
        previously ratified threshold and activation apparatus that nobody
        swept. If the sweep surfaces ratified detector-relevant material AFTER
        T5 is ratified, T5 is re-litigated with T6 built on top of it, and
        Q14's integrity depends on T5 being frozen and STAYING frozen. T1 costs
        time now; the alternative costs T5, T6 and possibly a Q14 re-run. The
        original reason for pausing T1 - not consolidating into a moving target
        - expired when the architecture re-decision settled.
        (W3X, 2026-08-17)

DEC-03  T5 is issued and ratified ALONE, then T6 separately. The permitted
        single coordinated T5+T6 package is NOT used.
        WHY: it makes "the detector mathematics were fixed before anyone saw
        held-out results" a matter of record rather than of internal document
        structure, and gives W3C a cleanly bounded artifact to cross-check.
        (W3X, 2026-08-17)

DEC-04  Forward Roadmap and Documentation Currency Audit currency is FOLDED
        INTO T1/T3 rather than fixed as a separate pass.
        WHY: T1/T3 will rewrite those passages properly; fixing them first is
        double work and would force pre-deciding adjudications that are T1's
        job.
        (W3X, 2026-08-17)

DEC-05  BANNERS: the Forward Roadmap v1.20 and the Documentation Currency Audit
        v1.4 receive an in-scope staleness banner NOW. The README and the Grid
        Knowledge document DO NOT, until adjudicated.
        WHY: a "superseded - do not rely on" banner placed BEFORE adjudication
        is a pre-judgement whose practical effect is permission to skip - the
        Architecture A mechanism relocated, not removed. The roadmap and audit
        are informative orientation with no unique ratified design to lose, so
        the risk is one-sided. The README and Grid Knowledge are the opposite:
        their danger is that they may still hold good, current, possibly-unique
        material, which is exactly what a premature label would bury. Their
        banners are written AFTER adjudication, reporting a disposition backed
        by a ledger entry. W3X identified this risk; W3D's original
        banner-all-four recommendation was withdrawn.
        (W3X, 2026-08-17)

DEC-06  PROTECTION DURING T1 COMES FROM THE SCOPE MANIFEST, NOT FROM LABELS.
        The first T1 artifact is a published manifest naming every in-scope
        document as UNADJUDICATED.
        WHY: a list of what MUST be read is safe; a label saying what MAY be
        skipped is the failure mode itself.
        (W3D recommendation, W3X accepted 2026-08-17)

DEC-07  README DESTINATION: it becomes a USER-FACING product document - what
        the filter does, the parameters, how to use it, a readable summary of
        how it works. It holds no controlling information and is an authority in
        no domain.
        WHY (W3X): it was an initial-phase document; controlling information
        should reside elsewhere. This also permanently removes the "ratified
        design hiding under a general-guidance label" condition.
        SEQUENCING CONSTRAINT (load-bearing): it CANNOT be reclassified yet.
        Reclassification is a promise about content, and the content has not
        been checked. Order is: T1 adjudicates every hit -> unique/current
        material is rehomed -> T3 strips the remainder -> ONLY THEN the
        classification changes to USER-FACING.
        INTERIM CLASSIFICATION: "unadjudicated - contains ratified design
        pending T1; not an authority, not yet user-facing." Deliberately grants
        no skip permission.
        (W3X, 2026-08-17)

DEC-08  T4 is NOT closed by absorption. It is subsumed into T1.1-MATHS, which
        produces an explicit gap table.
        WHY: "largely absorbed, confirm during T1" is an inference, and a gap
        discovered during T5 or the kernel scope is discovered at the worst
        possible time.
        (W3X, 2026-08-17)

DEC-09  SOURCE TREE: quick INVENTORY ONLY, no adjudication, no proposed edits.
        The inventory is handed to D4-Q16 as input.
        WHY: leaving source wholly out of scope would let T1 declare a clean
        single source of truth while the codebase still speaks the rejected
        architecture; full adjudication would sprawl T1 into a bounded coding
        scope that belongs to a different party. The inventory is already
        performed and recorded in section T1-SRC below.
        (W3X, 2026-08-17)

DEC-10  T1 IS DELIVERED INCREMENTALLY: the adjudication ledger is emitted and
        PRESENTED in batches as each document is adjudicated, not held to the
        end.
        WHY: two designer sessions have died mid-task and one died holding an
        unpresented batch. Incremental delivery caps the loss at one document's
        work. Only emitted artifacts survive an interruption (charter
        C-DELIV-09); un-emitted reasoning does not.
        (W3D recommendation, W3X accepted 2026-08-17 - noted as established
        practice with both designer and coder previously)

DEC-23  THE LEDGER TEMPLATE IS WRONG AND IS FIXED BEFORE ANY FURTHER TRANCHE.
        THE DEFECT: entries mixed two different acts - the DISPOSITION of an
        existing quoted statement, and a NEW GENERAL PROPOSITION derived by
        the designer. LED-002 consequently invented a sixth disposition
        ("SUPERSEDED-IN-FORM, CURRENT-IN-SUBSTANCE") that assumed its own
        conclusion.
        THE FIX: DISPOSITION is restricted to the five registered values and
        nothing else, ever. A separate DERIVED-PROPOSITION field carries
        anything the designer infers rather than finds, clearly marked as
        inference and separately reviewable.
        WHY IT MATTERS, in W3C's words, which are better than a paraphrase:
        otherwise future entries can make a statement "current in substance"
        by inventing the substance they wish it had.
        SCOPE OF THE FIX: this register, the T1 review scope, and the ledger
        template must be updated together before T1S01a2 is adjudicated.
        T1S01a1 is NOT discarded - W3C assessed it as reviewable as-is, and
        the corrections are recorded against it rather than by re-issue.
        (W3C T1S01a1_B method finding; W3D concurs; W3X 2026-08-18)

DEC-24  PR-1 IS SUBSTANTIALLY RESOLVED, AND NOT AS W3D PROPOSED.
        W3D PROPOSED: the false-activation limit is universal; authority
        section 12.5 is CURRENT-UNIQUE but misfiled inside the Architecture A
        rejection proof; relocate it as a general constraint with an A/B2/D
        severity gradation.
        W3C COUNTERED with a narrower core: if two different physical causes
        produce identical values for every input available to a decision rule,
        that rule cannot distinguish the causes - therefore a local artifact
        predicate must not be used as an implicit geometry classifier. That
        does NOT prove every future kernel reads only those six samples, nor
        that this limit is "the reason the detector exists at all".
        DECISIVE EVIDENCE, VERIFIED COLD BY W3D AGAINST THE SOURCE: authority
        section 13.1 ALREADY STATES THE GENERAL PRINCIPLE - "Do not let a
        local edge predicate become an implicit geometry classifier" - outside
        the rejection proof, among rules retained because they are "still
        exactly right". Sections 11 and 15.3 already record Architecture D's
        exposure at its uncertain internal candidate.
        THEREFORE the CURRENT-UNIQUE disposition is WRONG. What 12.5 uniquely
        holds is the PROOF, not the principle; the principle has a home.
        LIKELY REMEDY, to be re-derived rather than inherited: leave the proof
        at 12.5 as the Architecture A application and add a pointer from 13.1
        so the proof is findable from the principle. Far smaller than the
        relocation W3D proposed.
        CONSEQUENCE FOR T5: PR-1 was registered as BLOCKING T5 on the theory
        that the constraining principle had to be derived and relocated. It
        did not - it already exists. T5 is closer to unblocked than PR-1
        implied. W3X TO CONFIRM the block is lifted; the successor must not
        assume it.
        (W3C T1S01a1_B Q2; W3D verified; W3X 2026-08-18)

DEC-25  PR-2 IS NOT RATIFIED AS A STANDING KERNEL RULE.
        W3D PROPOSED: the tc0-unscaled rule - tighten the evidence bar, but
        correct at full strength once it passes - is a standing principle,
        because the two decisions are structurally independent.
        W3C COUNTERED: the source proves only that the REJECTED Architecture A
        scaled alpha/beta and left tc0 unscaled. "Full strength" is also
        imprecise: unscaled tc0 means the normal correction law remains
        AVAILABLE, not that maximum correction is always applied.
        DECISIVE EVIDENCE, VERIFIED COLD BY W3D AGAINST THE SOURCE: the
        shipped, ratified parameter `boundary_strength_offset` "offsets the
        index used for `alpha` and `tc0`" (README v1.12 line 692). One control
        moves the evidence threshold AND the correction limit together. The
        project has never treated the two as logically independent, so W3D's
        independence argument is refuted by its own live specification.
        DISPOSITION: preserve Architecture A's behaviour as HISTORY. Record
        the evidence-versus-correction coupling question as an OPEN
        kernel/quality decision under D4-Q02/D4-Q05, where the authority
        already leaves the final predicate, correction formula and strength
        behaviour open.
        (W3C T1S01a1_B Q3; W3D concurs; W3X 2026-08-18)

DEC-26  TWO W3D ADJUDICATION ERRORS ARE RECORDED, NOT ABSORBED SILENTLY.
        Both entries in the first ledger T1 produced were wrong in material
        ways, and both were knowledge-sweep failures by the designer.
        ERROR 1 (PR-1): W3D adjudicated section 12.5 as the unique home of a
        principle WITHOUT SWEEPING THE SAME DOCUMENT for whether the principle
        already lived elsewhere. It did, three sections later, stated more
        generally. W3D had read section 13 earlier in the same session.
        ERROR 2 (PR-2): W3D asserted that evidence thresholds and correction
        strength are structurally independent WITHOUT CHECKING the project's
        own parameter surface, where one shipped control couples them.
        WHY THIS IS IN THE PERMANENT RECORD: the incident that caused T1 was a
        designer skipping a document because an index called it "fallback
        general guidance" - a classification believed instead of checked. In
        the FIRST LEDGER T1 PRODUCED, the designer repeated the same failure
        one scale down, and prior familiarity with the document is again what
        made not re-checking feel safe. An independent reviewer found both in
        one pass.
        THE STANDING LESSON: the corrective is not "more care". It is that no
        adjudication is trustworthy because its author was careful - including
        an adjudication that reads well. On the evidence so far the three-way
        review is the only thing on this project that has caught anything.
        (W3D self-report; W3X 2026-08-18)

DEC-21  THE T1 SEARCH FRAME IS FINAL AND FROZEN AT 90 TERMS (groups 1-12).
        Group 12 added nine decision and Q14-integrity terms after W3C's
        SECOND independent term review: measured at +93 otherwise-unmatched
        lines and zero population change, both figures reproduced independently
        by W3D. Two terms justified the group alone - `architecture c\b`
        recovers four live lines about the REJECTED motion architecture that no
        other term matches, one of them in the MPEG-2 authority itself; `D4-D`
        recovers 23 lines whose entire content is a ratified decision pointer
        (`[D4-D01]`, `[D4-D02, F7]`) and which no vocabulary search could
        otherwise see.
        FREEZE RULE: any later term addition requires a recorded W3X decision
        AND a re-scan of every already-adjudicated step.
        WHY FREEZE: a search frame that moves during adjudication makes
        coverage unprovable - step 1 swept under one frame and step 4 under
        another, and afterwards nobody can say what was actually covered. Same
        discipline as freezing the detector mathematics before Q14 measures
        them: you do not move the instrument after you start reading it.
        SUPERSEDES the 42 -> 81 figure at DEC-18, correct when written but one
        review round short.
        (W3C T1S00_B v1_1 F1 and v1_2 M1; W3X 2026-08-18)

DEC-22  T1S01 IS SPLIT AT A DECLARED BOUNDARY into T1S01a and T1S01b.
            T1S01a  the MPEG-2 authority document v1.05 (1,983 lines),
                    carrying PR-1 and PR-2. The architecture re-decision
                    record is CONSULTED for those two items but not
                    adjudicated in its own right.
            T1S01b  the six Scopes/ architecture-record documents and the six
                    GAIS_investigations/ documents (3,758 lines), adjudicated
                    in their own right.
        WHY: the manifest reserved the right to split this step at a natural
        boundary and REPORT it rather than silently truncate. 13 documents and
        5,741 lines is too large for one honest pass, and PR-1 GATES T5 - so
        resolving it early lets it reach W3X as a standalone authority-document
        version bump instead of waiting for the whole sweep to close.
        THE BOUNDARY IS REAL, not arbitrary: T1S01a adjudicates the RATIFIED
        AUTHORITY; T1S01b adjudicates the WORKING RECORD BEHIND it.
        NAMING: T1S01a_A / T1S01a_B, then T1S01b_A / T1S01b_B.
        (W3D; declared to W3X 2026-08-18)

DEC-17  POPULATION AND SEARCH ARE SEPARATE MECHANISMS. The document
        population is a RECURSIVE INVENTORY of the live tree, reduced only by
        EXPLICIT RECORDED EXCLUSIONS. The term set then searches that
        already-known population; it does NOT build it.
        WHY: if the search builds the population, a zero-hit document silently
        disappears and a folder nobody thought to search is invisible - which
        is precisely PR-5. Under an inventory-first rule a document can only
        leave the population by an exclusion a reviewer can challenge.
        SECOND-ORDER CONSEQUENCE, and the reason DEC-18 is safe: because the
        population no longer depends on the terms, broadening the term set
        cannot add or lose documents. Over-inclusion becomes nearly free.
        (W3C T1S00_B Q2; W3X 2026-08-18)

DEC-18  THE TERM SET IS EXTENDED from 42 terms to 81, adding general geometry
        and scheduling, B2/Q14 detector vocabulary, activation and analyser
        vocabulary, and known residual topics (groups 8-11).
        WHY: the original 42 were good at finding DOCUMENTS and insufficient
        at finding STATEMENTS. A load-bearing claim can be written entirely in
        schedule, detector, threshold, topology, crop/origin or Q14 vocabulary
        without any registered term on the same line - and T1's completion
        test is about every MPEG-2-bearing STATEMENT, not every document.
        MEASURED BEFORE ADOPTION rather than accepted on argument: the
        additions change the document population by ZERO and add roughly 1,300
        statement-level hit lines, including 269 more in the MPEG-2 authority
        and 240 more in the README - the two documents the sweep most depends
        on. Bare `boundary` and bare `detector` were deliberately NOT added, on
        W3C's own advice, because in this repository they also describe
        delivery boundaries and CPU feature detection.
        (W3C T1S00_B PR-4; W3X 2026-08-18)

DEC-19  T1'S OWN PROCESS ARTIFACTS ARE EXPLICITLY EXCLUDED FROM ADJUDICATION,
        and audited for pointer accuracy and version currency AT CLOSURE
        instead. Covers this register, the T1 review scope and its W3C
        reviews, the scope manifest, ledger batches and step responses.
        The outgoing-designer evidence zip is excluded on the same explicit
        basis - reference evidence, not a knowledge-authority sweep target.
        THIS REVERSES the position taken in manifest v1.1, which had T1's
        paperwork in scope on the grounds that excluding "just process"
        documents would be classification-based exclusion.
        WHY THE REVERSAL: that conflated two different things. The recorded
        incident was an IMPLICIT exclusion resting on an index label nobody
        verified. This is an EXPLICIT exclusion, stated with its reason in the
        document a reviewer reads, with a compensating closure audit - it can
        be challenged, which a label granting quiet permission to skip cannot.
        The recursion argument is also plain: this register moved v1.1 -> v1.4
        in a single day, and the manifest adjudicating itself is circular.
        (W3C T1S00_B F1/PR-5 qualification; W3X 2026-08-18)

DEC-20  THE ORPHAN-FAMILY CHECK ON RETIRED FOLDERS WAS RUN, AND DOES NOT WORK
        AS SPECIFIED. Recorded as a negative result so nobody re-runs it and
        is alarmed.
        THE CHECK: for each retired document family carrying MPEG-2 hits,
        confirm a live successor or an explicit historical reason exists; flag
        families with neither.
        THE RESULT: 74 families flagged - too many to be a signal. Two causes.
        RENAMES defeat filename matching: the creation-error-message-table
        family (195 hits) and the 2C-preface family (67 hits) both HAVE live
        successors under changed filenames. COMPLETED-STAGE ARTIFACTS dominate
        the rest - stage scopes, coder responses, delivery manifests and
        acceptance reviews whose successor is not a document at all but the
        delivered accepted source plus the ratified knowledge set.
        REFINED OUTPUT: after filtering both classes, one substantial genuine
        candidate remains - the FLOATING EXACTNESS AND FULL DECLARED TIERS
        DISCUSSION family (4 files, 103 hits), a design discussion rather than
        a stage artifact, with no live namesake. Its subject matter appears in
        four live documents, which is evidence it was absorbed rather than
        orphaned - but absorbed-in-substance is a claim to VERIFY at T1S05,
        not to assume.
        STANDING RULE: the check is retained, but its raw output must be
        filtered for renames and completed-stage artifacts before it means
        anything.
        (W3C T1S00_B Q3/F4; W3D result; W3X 2026-08-18)

DEC-12  THE THREE-WAY REVIEW IS DEFERRED. W3C reviews each step as it is
        issued, but W3X does NOT adjudicate those responses between steps -
        they are collected and reviewed together against the completed
        ledger, in a final closure round: W3D answers every disagreement,
        UNSURE, MISSING and method finding; W3C independently re-reviews
        ONLY the entries where W3D disagreed with W3C or changed an
        adjudication; W3X decides and records.
        ONE CARVE-OUT: W3X reads the FIRST ledger-bearing response (T1S01_B)
        in full before the next step is adjudicated, and scans the top
        questions section of every later response.
        WHY THE CARVE-OUT EXISTS: deferral risks replicating a wrong METHOD
        silently. A wrong entry costs one entry; a wrong method - extracts
        too short to check, an outcome category systematically misapplied, a
        format that cannot be reviewed - is repeated across every remaining
        step before anyone sees it. One early read converts a possible full
        rework into a one-step correction.
        WHY DEFERRAL IS AFFORDABLE AT ALL: W3C is memoryless and sees one
        step at a time, so it never had cross-step visibility to lose.
        (W3X, 2026-08-18)

DEC-13  SIX STEPS, NAMED T1S00 TO T1S05, ordered by RISK rather than by
        document size or alphabet. Files carry the step number FIRST, with
        `_A_` for material going TO the coder and `_B_` for the coder's
        response, so a directory listing keeps a step and its answer
        together and the answer sorts after the question.
        WHY ORDERED BY RISK: T1S01 holds PR-1, which gates the detector
        mathematics task that follows T1. Resolving it early lets it go to
        W3X as a standalone authority-document version bump instead of
        waiting for the whole sweep to close.
        (W3X, 2026-08-18)

DEC-14  EVIDENCE SUPPLY: W3X supplies the COMPLETE dev_documentation zip and
        the SOURCE zip to W3C at the start of the coder chat, re-supplied at
        intervals and whenever the coder chat is replaced. Each step then
        carries only its ledger plus any bumped register.
        WHY: W3C's own review of the review scope found two BLOCKING defects
        - the scope assigned review obligations the evidence package could
        not discharge. Asking the coder to find what the designer walked
        past, while supplying only the designer's record of what was found,
        is impossible; so is asking what a search missed while supplying only
        the search's output. The full corpus discharges both, and costs less
        than the per-step extracts originally proposed.
        (W3X, 2026-08-18; W3C findings F1/F2/F3)

DEC-15  ALL SUPERSEDED LEDGER ENTRIES ARE TIER A, whether the plan is
        deletion or replacement by a pointer.
        WHY: the earlier split tiered only deletions, leaving
        pointer-replacement entries with no review tier at all. A
        wrongly-retired statement is equally gone either way.
        (W3C finding F4; W3X 2026-08-18)

DEC-16  READ-ONLY SOURCE INSPECTION IS PERMITTED AND, FOR TIER B, EXPECTED.
        No modification, build, execution, patch, delivery package or git
        operation at any point.
        WHY: Tier B asks whether a statement is a specification the code
        implements. That is a question about the code and cannot be answered
        honestly from documents alone. The earlier wording "do not touch
        source" was ambiguous.
        (W3C finding F2; W3X 2026-08-18)

DEC-11  THE OUTGOING DESIGNER'S ANSWER SET IS COMMITTED AS T1 EVIDENCE, as
        T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip
        in dev_documentation. Contents:
            OldDesigner_Q1_README_SlowDown_Map_v1_0.md
            OldDesigner_Q2_ArchA_Rejected_vs_Survived_v1_0.md
            OldDesigner_Q3_T1_Actual_Coverage_v1_0.md
            OldDesigner_Q4_Survey_Term_Set_v1_0.md
            Old_Designer_Summary_and_Warning_for_new_Designer.txt
        CLASSIFICATION, carried from the outgoing designer's own caution and
        preserved here so it does not evaporate with the chat that gave it:
            Q3 and Q4 are RECORD - relied upon as fact.
            Q1 and Q2 contain JUDGEMENT - positions to test, not findings.
                Q1 is used as a SEARCH MAP, not as a set of conclusions.
        WHY COMMITTED: Q3 is irreplaceable. It is the only record of what the
        aborted T1 pass actually covered, and the session that knew it is gone.
        Q1's section map and Q4's term set are direct inputs to the scope
        manifest. Held only as a chat upload, all of it dies with this session.
        (W3X, 2026-08-17)
```

## 1.1 Registered follow-up, not yet drafted

```text
CHARTER PROPOSAL (W3D to draft; charter I7 applies - W3D is proposer, W3C is
the named independent verifier, W3X ratifies):

  A knowledge sweep selects documents by CONTENT MATCH, never by
  classification. Classification governs which document PREVAILS in a conflict;
  it never governs whether a document is READ. No document may carry a
  classification whose practical effect is permission to skip it.

WHY IT IS A CHARTER MATTER AND NOT JUST A LESSON: the recorded incident was not
caused by carelessness. It was caused by a correct-looking process - the
currency audit classified the README as "fallback general guidance" and the
designer accepted the classification instead of checking it. A lesson in a
status document does not bind a successor; a charter rule does. It constrains
W3D's own sweeps, hence the I7 verifier requirement.
```

---

# T1 - Formal consolidation sweep of the MPEG-2-bearing document set

```text
WHAT: read and adjudicate EVERY MPEG-2, grid, field-DCT, interlacing and
related design statement in the live document set. For each hit decide: is it
current, relevant and accurate? If consistent with the authority document, is
it duplication that should become a reference (T3)? If it CONFLICTS, decide and
RECORD which prevails and why, naming the document it came from. Anything worth
keeping is folded into the authority document at the right place, without
duplicating.

WHY THIS IS NOT ALREADY DONE, STATED HONESTLY: authority document v1.05 is
ratified and prevails, and it is a good document. But it was built from the
investigation rounds plus a TARGETED recovery during the v1.03-v1.05 passes. It
has never been fed by the full sweep. "Single source of truth" is therefore
currently a STATUS WE HAVE GRANTED IT, not a state it has been demonstrated to
be in. T1 is the work that makes the claim true.

COMPLETION TEST: T1 is DONE when every MPEG-2-bearing statement in the live set
has an individual recorded disposition. It is NOT done when the authority
document merely looks comprehensive. T1 must not be marked DONE by inference.
```

## T1-METHOD - how the sweep is run

```text
M1  HIT SET DERIVED MECHANICALLY, NOT INHERITED.
    A defined term list is swept across every live document, so the population
    is reproducible and W3X can see what was searched and what matched. The
    "seventeen documents" figure from v1.0/v1.1 is treated as an estimate to be
    replaced by the actual manifest, not as the scope.
    WHY: an inherited count cannot be audited and may itself be wrong.

M2  SCOPE MANIFEST PUBLISHED FIRST (DEC-06).
    Every in-scope document listed as UNADJUDICATED before adjudication begins.
    superseded/ folders are OUT of scope as authority, with one mechanical
    exception: a check that no live document cites anything in them as current.

M3  EVERY HIT IS ADJUDICATED IN SITU.
    The document is opened and read FOR THIS QUESTION, with document and
    section quoted. Not from an index, not from a summary, and specifically not
    from prior familiarity.
    WHY, AND THIS IS THE SHARP EDGE OF THE RECORDED INCIDENT: the previous
    designer HAD read parts of the README earlier in the project, and that is
    precisely why skipping it felt safe. The useful check is not "did I read
    the specifications" but "did I read them FOR THIS QUESTION". Prior
    familiarity is treated as a reason for suspicion, not a reason to move on.

M4  FIVE DISPOSITIONS, each recorded with its reason:
      CURRENT-UNIQUE      leave in place
      CURRENT-DUPLICATE   becomes a pointer (T3)
      CONFLICTING         decide and record which prevails and its origin
      SUPERSEDED          retire or excise (T2/T3)
      OPERATIVE-SPEC      stays where it is used, gets a pointer alongside
                          (the deliberate T3 carve-out)

M5  OUTPUT IS A WRITTEN ADJUDICATION LEDGER listing every hit and its
    disposition. The ledger is what PROVES the sweep was thorough and lets a
    successor see that a document was CONSIDERED rather than SKIPPED. It is
    also the evidence for any authority-document version bump that absorbs
    recovered material.

M6  INCREMENTAL DELIVERY (DEC-10). Ledger batches emitted and presented per
    document as adjudication completes.

M7  SUPERSESSION IS READ FROM THE DOCUMENTS THEMSELVES.
    Where a document states what it supersedes or is superseded by, the ledger
    records that statement and its source. Where supersession is UNCLEAR or the
    documents disagree, the ledger records UNRESOLVED and the item comes to
    W3X as a decision item rather than being settled by W3D inference.
    WHY: inferred supersession is exactly how good work gets discarded quietly.

M9  THE TERM SET IS DEFINED EXPLICITLY, RUN, AND DIFFED.
    The T1 log states W3D's own term set verbatim, runs it on the CURRENT
    generation with superseded/ excluded, and DIFFS the resulting document
    list against the outgoing designer's recorded survey (Q4). Any document
    appearing under the new set but not the old was invisible to the original
    survey and is called out by name.
    WHY: the original "17 documents / 137 hits" frame came from one grep with
    a finite term set. Its author warned that a document using none of those
    terms would never appear on the list, and that warning is CONFIRMED on
    this project's own documents - see PR-4.
    KNOWN BLIND SPOTS OF THE ORIGINAL SET, to be covered by the new one: bare
    "8x8" without "grid"; macroblock; 16x16; picture_structure;
    frame_pred_frame_dct; SeparateFields; woven; midpoint; edge_step;
    luma_step; chroma_step; H.262; 13818; pitch; chroma geometry text;
    "field pictures".

M11 THE POPULATION IS AN INVENTORY, NOT A SEARCH RESULT (DEC-17).
    Enumerate the live tree recursively; subtract only explicit recorded
    exclusions; then search. A zero-hit document stays in the population and
    its zero is a RESULT, not a reason to drop it.

M10 THE README IS READ AGAINST THE OUTGOING DESIGNER'S SECTION MAP.
    Q1 supplies a per-section slow-down map. It is used as a READING ORDER and
    a set of anchors, NOT as a set of conclusions (DEC-11 classification). Its
    anchors were re-verified against README v1_12 on 2026-08-17 and are
    materially accurate despite being derived from v1_11: sections 3.11 (526),
    3.13 (600), 3.14 (660) and 6.2 (1248) are at IDENTICAL lines, and the tail
    has shifted by about seven lines (F-series 3160-3232; Appendix A 3422;
    Appendix B 3740; section 20 at 3320).
    WHY: it converts the highest-risk document in the set from an unstructured
    2,800-line read into a prioritised one, without inheriting any judgement.

M8  THE CHARTER IS READ BUT NOT STRIPPED.
    T1 adjudicates the charter like everything else - it does carry MPEG-2
    content (the chroma-step invariant B5, Part 0, the parameter reference).
    T3 does NOT strip it, because rule-context belongs where the rules are. A
    charter statement conflicting with the ratified authority becomes a
    PROPOSAL to W3X, never a W3D edit (charter P-09).
```

## T1-PREREG - pre-registered adjudication items (registered 2026-08-17)

```text
Registered BEFORE T1 starts so they cannot be lost between now and the point
in the sweep where they are reached. Each was surfaced by checking the
outgoing designer's answers against the current ratified set. NONE IS
ADJUDICATED - each is an item the ledger must resolve with a recorded
disposition. Numbering is PR-n to keep them distinct from the F/D/K series.

PR-1  [RESOLVED 2026-08-18 - SEE DEC-24. The narrower core stands; the
      general principle already exists at authority 13.1; W3D's relocation
      proposal and CURRENT-UNIQUE disposition were wrong. Text below retained
      as the original registration.]
      R4 - THE IN-PRINCIPLE FALSE-ACTIVATION LIMIT MAY BE UNIVERSAL, AND IS
      CURRENTLY FILED AS AN ARCHITECTURE-A REJECTION ARGUMENT.
      WHAT WAS FOUND: authority v1.05 section 12.5 states the limit itself -
      for p2,p1,p0 = A,A,A and q0,q1,q2 = A+d,A+d,A+d, side activity is zero,
      a real compression seam and a benign step are the identical observation,
      and no threshold can distinguish two causes producing the same sample
      tuple; a threshold trades the two errors, it cannot eliminate them.
      WHAT IS ABSENT: any statement that this constrains EVERY architecture's
      kernel gating on flat content. Section 12.5 sits inside section 12,
      titled as the Architecture A rejection proof, and its closing paragraph
      is entirely about midpoint_threshold_scale.
      THE OUTGOING DESIGNER'S POSITION (Q2 R4, a position to test, not a
      ratified statement): the limit is universal; it is WHY B2 classifies
      structure rather than relying on edge-local evidence alone; and it must
      not be re-derived later as though it were a B2-specific problem.
      WHY IT MATTERS AND WHY IT IS REGISTERED HERE: if the position is
      correct, R4 is a boundary condition on T5. It bounds what ANY activation
      threshold can achieve and supplies the reason the detector must classify
      structure. Deriving detector mathematics without it in view is deriving
      it half-blind. Its present filing - a general constraint stored inside
      one architecture's rejection proof - is the same shape as the recorded
      incident: sound reasoning sitting where nobody searching for it would
      look.
      REQUIRED DISPOSITION: adjudicate whether the universality claim is
      correct; if so, it is relocated or restated in the authority document
      where a detector designer will find it, by W3X-ratified version bump.
      T5 MUST NOT BE DRAFTED WITHOUT THIS ITEM RESOLVED.

PR-2  [RESOLVED 2026-08-18 - SEE DEC-25. NOT ratified as a standing rule;
      preserved as history, with the coupling question opened under
      D4-Q02/D4-Q05. Text below retained as the original registration.]
      S5 - THE tc0-UNSCALED PRINCIPLE HAS DEGRADED FROM PRINCIPLE TO HISTORY.
      THE PRINCIPLE: evidence thresholds may be tightened, but a test that
      PASSES corrects at FULL strength - do not half-correct.
      WHAT WAS FOUND: it appears in authority v1.05 section 9.1, but inside
      the NARRATIVE DESCRIBING WHAT ARCHITECTURE A DID ("tc0 and the one-sample
      correction addition were deliberately not scaled, so a midpoint that
      activated was corrected at normal strength"), NOT in the retained-ideas
      list four lines below it.
      WHY IT MATTERS: Architecture A is rejected, so that sentence now reads
      as a description of a dead design rather than a surviving principle. The
      outgoing designer flagged S5 as easily lost because it was a one-line
      remark in README 3.13; it is now a one-line remark inside a rejection
      narrative, which is a worse hiding place.
      REQUIRED DISPOSITION: adjudicate whether S5 is a standing kernel
      principle; if so, promote it out of the narrative into a place that
      binds future kernel work.
      W3D ERRATUM RECORDED HERE: while framing the question that produced this
      finding, W3D told W3X that v1.05 section 9.1 lists FOUR retained ideas.
      It lists FIVE (creation-time fixed-point conversion; immutable threshold
      sets; no float/multiply in the pixel loop; deterministic/stateless
      operation; uncertainty should be measurable and explicit). A five-item
      bullet list was miscounted while asking whether a list was complete.
      Recorded rather than silently corrected, per P-02.

PR-3  CHARTER E3 IS A LIVE INVARIANT WRITTEN IN THE VOCABULARY OF A REJECTED
      MECHANISM.
      WHAT WAS FOUND: charter E3 reads "Midpoint activation reads the CURRENT
      DESTINATION state at that exact canonical schedule point. It must not
      read pristine source." The underlying rule - the outgoing designer's S4,
      canonical-schedule read ordering, which makes output schedule-defined and
      deterministic - is live and load-bearing. But midpoint activation is a
      rejected mechanism.
      WHY IT MATTERS: a reader can reasonably conclude E3 has no trigger
      condition and therefore does not apply. An invariant that appears
      inapplicable is an invariant that stops being enforced.
      REQUIRED DISPOSITION: this is CHARTER TEXT. T1 records the finding and
      brings W3X a PROPOSAL (charter P-09; W3D never edits the charter). The
      companion rule E4 - a strength map reads UNMODIFIED SOURCE in a pre-pass,
      deliberately the opposite of E3 - must be checked in the same pass, since
      the B2 detector pre-pass is an E4-class reader.

PR-4  D2 HolyWu Real Schedule v1_7 WAS INVISIBLE TO THE ORIGINAL SURVEY.
      WHAT WAS FOUND: re-running the outgoing designer's exact term set
      (Q4) against the current generation reproduces his shape, but running an
      EXTENDED set surfaces documents his set could not see. Most are
      incidental; D2 v1_7 is not - it is a member of the accepted Stage-2C
      authority set.
      WHY IT MATTERS: it is direct confirmation, on this project's own
      documents, of the blind-spot warning the outgoing designer gave in Q4 -
      a document whose relevant content uses none of the survey terms does not
      appear on the list at all, so it cannot be adjudicated or even skipped
      deliberately. It is invisible rather than rejected.
      REQUIRED DISPOSITION: D2 v1_7 enters the scope manifest. The manifest
      records BOTH term sets and the resulting document diff (M9).

PR-5  TWO ENTIRE LIVE FOLDERS WERE OUTSIDE THE PREVIOUS SURVEY.
      WHAT WAS FOUND while building the T1S00 manifest: the previous survey
      ran on the dev_documentation ROOT only. Two live subfolders were never
      searched:
          Scopes/               6 documents  2,817 lines  486 hits
          GAIS_investigations/  6 documents    941 lines  233 hits
      WHY IT IS SERIOUS: Scopes/ holds the primary working record of the
      ARCHITECTURE RE-DECISION itself - the brief that reopened Architecture
      A, the coder's independent evaluation that produced the current primary
      candidate, and TWO live generations of the verification-round brief
      with no supersession marker on either. The most consequential design
      event in this project had its working record outside the scope of the
      sweep meant to consolidate project knowledge.
      THIS IS NOT A TERM-SET WEAKNESS. Those documents are saturated with
      MPEG-2 vocabulary and would have matched the old seven terms easily.
      They were simply outside the directory that was searched - a SELECTION
      failure, exactly like the original incident, but in the folder
      dimension rather than the label dimension.
      SUPERSEDES the narrower PR-4 finding, which named one invisible
      document (D2 v1_7). The real answer is twelve plus D2 plus several
      smaller ones. PR-4 remains open as the TERM-SET review task; PR-5 is
      the folder-selection finding.
      REQUIRED DISPOSITION: all twelve documents are in the T1S00 manifest
      and assigned to step T1S01. No further action beyond adjudicating them.

CLEARED, RECORDED SO IT IS NOT RE-INVESTIGATED:
  S6 - threshold scaling surviving into Architecture D - was flagged by the
  outgoing designer as most likely silently dropped and load-bearing for D's
  definition. IT IS NOT DROPPED. Authority v1.05 section 11 defines D's
  internal candidate with "an A-derived alpha/beta threshold scale is an
  experiment candidate, not yet a public parameter", and D4-Q05 records the
  same disposition. Absent from the section 9.1 bullet list, present where it
  actually governs. No action required.
```

## T1-KNOWN - items the sweep must handle (already surfaced; do not rediscover)

```text
  - the current Deblock4LumaStepY / midpoint audit-property model CANNOT
    express mixed B2 geometry as a single per-frame string;
  - 4:2:2 and 4:4:4 chroma FOLLOW luma DCT organisation and therefore CANNOT
    inherit the 4:2:0 fixed-chroma simplification;
  - the analyser rules require an unmodified-source pre-pass and per-call
    scratch under fmParallel;
  - schedule remains output-defining; proper chroma is a separate quality gate;
    grid origin / crop ordering is load-bearing;
  - the successor introductions are reconciled to the single MPEG-2 authority;
    check the remaining documents for equivalent stale field-separated /
    midpoint / one-step-per-frame wording;
  - Forward Roadmap v1.20: Stage 2D line still lists "schedules A/B, midpoint,
    proper chroma" as Deblock4 scalar-core content; no mention of B2,
    Architecture D or the Q14 gate anywhere; "next candidates" list names two
    items M1/M2 have completed; header date field (2026-08-01) predates the 5C
    content it describes (DEC-04);
  - Documentation Currency Audit v1.4: its "canonical current set" omits the
    prevailing MPEG-2 authority AND this task register, and pins three
    superseded versions (coder intro v1_27, designer intro v1_20, Project
    Status v1_27; actual v1_30, v1_23, v1_28) (DEC-04);
  - Grid Knowledge v1.2 header carries two conflicting version blocks
    ("Version: 1.2" immediately followed by "Version: 1.0, Date: 2026-07-27")
    and no supersession banner while sitting at top level (T2);
  - GAIS_GATING_RESPONSE.txt is still misnamed; it is a Zig
    conditional-compilation response and the currency audit records that it
    should be GAIS_ZIG_GATING_RESPONSE.txt (W3X manual act);
  - README v1_12 section 2, the decision-status table (line ~294), already
    carries "HISTORICAL SNAPSHOT (as of README v1.5); not maintained
    row-by-row" - so it is labelled, but labelled as UNMAINTAINED, which means
    rows may lag in EITHER direction. The outgoing designer names it the
    section most likely to hold a ruling nobody has re-checked. Read every row;
    a stale-marked table is not an adjudicated table;
  - README v1_12 contains an F-numbered FINDINGS series INSIDE the README
    (F12-F17, lines 3160-3232) - ruling-class content in a document classified
    as general guidance. F15 (MPEG-2 4:2:0 chroma geometry) overlaps the
    authority document's F4: verify they are identical and record which
    prevails on any nuance. F17 may hold measurement gates never carried into
    the D4-Q register;
  - README v1_12 Appendices A and B: A.9.3 (interlaced 4:2:0 chroma) and A.6
    (definitive luma table) are the flagged divergence risks against the
    authority document; B.5 may hold open items never migrated to D4-Q;
  - the FLOATING EXACTNESS AND FULL DECLARED TIERS DISCUSSION family (4
    retired files, 103 hits) has no live namesake; its subject matter appears
    in the README, Verification and Tiering Decisions v1.11, the D0 index and
    the charter. Verify at T1S05 that it was genuinely absorbed rather than
    orphaned - do not assume it from the citations (DEC-20);
  - D0 Binding Knowledge Index v1.14 section 1.1 still pins README v1_9 as
    "fallback general guidance" - harmless in practice (D0 governs completed
    Stage 2C) but a stale pin, and an instance of the classification wording
    DEC-07 retires.
```

## T1-SRC - source-tree inventory (DEC-09; PERFORMED 2026-08-17)

```text
STATUS: DONE as an inventory. Handed to D4-Q16 as input. No adjudication, no
dispositions, no proposed edits - those belong to that bounded coding scope.

VERIFIED COLD against the W3X-supplied source tree, not from memory:

  NO DEBLOCK4 PIXEL MATHEMATICS EXISTS. src/deblock4_ar_all_frames_ready.zig
  lines 25-27 send all three dispatch arms (v1/v2/v3) to
  passThroughWritableCopy(). There is no threshold table, no activation test
  and no filter arithmetic anywhere in the deblock4_*.zig modules. Classic by
  contrast carries real kernels (classic_scalar_kernel.zig 194 lines;
  classic_vector_backend.zig 913; classic_thresholds.zig 123; plus the v2/v3
  thin objects). W3X's understanding is CONFIRMED on this point.

  THE PARAMETER / PROPERTY / DIAGNOSTIC SURFACE DOES STILL CARRY SUPERSEDED
  MPEG-2 VOCABULARY. This is NOT a defect and NOT a process failure: it was
  correctly ratified at Stage 1C, BEFORE the architecture re-decision, and
  authority v1.05 section 20 already registers it as legacy scaffolding awaiting
  D4-Q16. It is recorded here so it cannot be lost:

    src/filter_call_parameters.zig            74 hits
    tests/stage_1c_deblock4_passthrough.vpy   75 hits
    src/effective_invocation_text.zig         56 hits
    src/lifecycle_trace_debug.zig             36 hits
    src/deblock4_frame_properties.zig         30 hits
    src/deblock4_instance_creation.zig        20 hits
    src/deblock4_selftest.zig                 18 hits
    src/deblock4_plugin.zig                    5 hits
    build_5C_v1.bat                            present
    (terms: mpeg2_field_separated, midpoint_threshold_scale, luma_step_*,
     chroma_step_*, grid_mode, Deblock4LumaStepY/ChromaStep*/MidpointScale)

  CONSEQUENCE FOR THE RULE "source always reflects latest knowledge": it holds
  for ALGORITHM content, because no Deblock4 algorithm content exists yet. It
  does not hold for the PUBLIC SURFACE, which advertises a grid model the
  project has since rejected. Anyone calling the filter today can still pass
  grid_mode="mpeg2_field_separated". That is a D4-Q16 item, not a T1 item.
```

---

# T1.1-MATHS - mathematical inventory, gap analysis and disposition (NEW)

```text
WHAT: a distinct thread running INSIDE the T1 sweep and reporting AFTER it.
During adjudication, every mathematical statement encountered is captured to a
separate maths inventory as well as to the main ledger, recording:
    what the mathematics asserts;
    where it lives (document and section);
    its evidence class (H.262-VERIFIED / SPEC / SOURCE / MEASURED / DERIVED /
        PENDING / W3X-RATIFIED);
    whether it is current under the ratified authority.

ON COMPLETION the inventory is reconciled against what the architecture and the
forthcoming detector work actually REQUIRE, producing a three-column table:
    mathematics we have and can rely on;
    mathematics we have but which is superseded or unverified;
    mathematics we need and do not have.

Each gap gets a recommendation - derive now / derive inside T5 / defer to the
kernel or scheduler scope, with the reason - and each recommendation comes to
W3X as a decision item under the normal communication convention.

BOUNDARY: T1.1-MATHS records WHERE the mathematics is and WHAT is missing. It
does not itself derive new mathematics.

KNOWN STARTING POSITION (verified 2026-08-17, to be confirmed by the sweep):
  PRESENT in authority v1.05 section 4: whole-frame pitch mathematics -
    frame-organised luma e=8k pitch 1; field-organised luma e=16k+p pitch 2;
    the six-tap footprints R_s/W_s; vertical edges at x=8k; 4:2:0 chroma.
  PRESENT in authority v1.05 section 10: the complete B2 macroblock topology
    table including the mixed-boundary rule.
  ABSENT and DEFERRED BY DESIGN: 4:2:2 / 4:4:4 chroma scheduler tables
    (v1.05 section 4.6 defers these to the kernel/scheduler scope); final luma
    kernel footprint and eligibility radii (open under D4-Q02/Q04 and NOT
    closable before the architecture gate - deriving them now would invent
    numbers ahead of the evidence meant to determine them).

WHY IT EXISTS: T4 was marked "largely absorbed; confirm during T1", which is an
inference. A gap discovered during T5 or the kernel scope is discovered at the
worst possible time. (DEC-08)
```

---

# T2 - Retire the Grid Knowledge document

```text
WHAT: Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2 is superseded by the
authority document but still sits in the main dev_documentation directory
looking current, carrying possibly-misleading load-bearing content. Move it to
superseded/, and edit the Documentation Currency Audit in the SAME pass so
nothing references it as live. Its post-adjudication banner (DEC-05) is written
at this point, reporting a disposition backed by ledger entries.

WHY AFTER T1: it is the file most likely to hold content the sweep still needs
- its G-series checklist, and the Fig 6-1/6-2 chroma-siting material behind
D4-Q10. Retiring a referenced document is a COORDINATED edit, not a
drag-and-drop: the M2 lesson, where deleting a batch without amending the two
audit scripts that named it would have silently disabled two gates.
```

# T3 - De-duplicate MPEG-2 content into references

```text
WHAT: once T1 establishes what is duplicated, strip duplicated KNOWLEDGE and
DECISIONS out of the other documents and replace them with pointers to the
authority document. One home per fact.

TWO CARVE-OUTS, both deliberate:
  - operative SPECIFICATIONS stay where they are used. A document describing
    parameter behaviour the filter implements is specification, not knowledge;
    it gets a pointer, not a hollowing-out.
  - the charter's MPEG-2 mentions are rule-context and are NOT touched (M8).

README-SPECIFIC (DEC-07): the superseded MPEG-2 architecture sections are
EXCISED and replaced with pointers, NOT annotated in place.
WHY: annotated wrong design is still wrong design sitting under a heading that
looks authoritative, and this project has already proved that readers trust the
heading. Rehoming targets: MPEG-2 content -> the ratified authority; tiering /
verification / two-filter rationale -> Deblock4_Verification_And_Tiering_
Decisions; global rules -> the charter BY PROPOSAL TO W3X, never by W3D edit.
Load-bearing content with no existing home comes to W3X as a list with a
proposed destination; W3D does not invent a new authority document
unilaterally.
```

# T4 - Boundary-set mathematics

```text
STATUS: SUBSUMED into T1.1-MATHS (DEC-08). Retained here so the thread is not
lost. T4 closes when T1.1-MATHS delivers its gap table and W3X rules on the
recommendations - not by a judgement that the authority document "appears to
cover it".
```

# T5 - Detector mathematics

```text
WHAT: the formal specification of the B2 classifier - which features are
computed per macroblock, how the FRAME and FIELD hypotheses are scored, how
confidence is derived, and where the UNKNOWN threshold sits. Also the
equivalent statement for Architecture D's single uncertain internal candidate.

SEQUENCE: AFTER T1 (DEC-02). Issued and ratified ALONE; T6 follows separately
(DEC-03).

WHY IT PRECEDES T6: the experiment measures THIS SPECIFIC DETECTOR. A detector
that has not been defined cannot be measured, and defining it after seeing
held-out results would be tuning to the test.

OWNERSHIP: W3D derives; W3C independently cross-checks the derivation and its
SIMD consequences; W3X ratifies (D4-D11). Charter I7 applies to any acceptance
criterion W3D proposes that will judge W3D's own derivation.
```

# T6 - The D4-Q14 architecture-discriminator experiment plan

```text
WHAT: the written plan for the experiment that decides B2 versus D:
  - how per-macroblock dct_type GROUND TRUTH is extracted from real PAL MPEG-2
    bitstreams (frame_pred_frame_dct is readable per picture via
    mediainfo --Details=1, which gives cheap regime triage ONLY);
  - how both legs are scored (B2: confusion matrices, confidence margins,
    UNKNOWN rate, FALSE-CONFIDENT rate, reported separately for FRAME/FRAME,
    FIELD/FIELD and MIXED boundaries; D leg: true-boundary versus
    false-candidate feature distributions with ROC sweeps);
  - NO_DCT / skipped / motion-only macroblocks as their OWN truth class, never
    fabricated into FRAME or FIELD;
  - the CALIBRATION and HELD-OUT subsets, with primary metrics and viability
    criteria PREDECLARED before held-out results are examined;
  - the decision rule: B2 if viable; else D if viable; else REOPEN the
    architecture - never force D merely because it is the fallback.

WHY IT MATTERS MORE THAN IT LOOKS: the target LG VHS-to-DVD recorder was
measured with frame_pred_frame_dct=0 in every practical restoration speed mode
(XP/SP/LP/EP; MLS is the frame-DCT control). The ADAPTIVE-CAPABLE per-macroblock
regime is therefore normal target-device operation and B2 is not engineering for
a merely theoretical regime. This picture-level fact does NOT prove that every
recording or picture actually contains both FRAME and FIELD macroblocks; Q14's
per-MB truth extraction measures that prevalence.

DEPENDS ON: T5 ratified first (DEC-03).
```

# T7 - Commit the consolidated set

```text
WHAT: the eventual commit that closes the FORMAL consolidation/retirement arc
and records the ratified experiment-plan set. This is NOT a prohibition on W3X
committing interim T1 ledger batches, banner edits or register bumps as they
land. Record what moved, what was retired and why, so a successor is not left
doing git archaeology.
```

---

# 2. THE RECORDED INCIDENT - why T1 is shaped this way

Kept in full because it is the reason for M3, DEC-05, DEC-06, DEC-07 and the
pending charter proposal, and because a successor who knows the rules but not
this incident will relax them.

```text
WHAT HAPPENED: Deblock4's grid architecture was an open design question. W3D
ran a four-round external research engagement plus two rounds of coder
verification to settle MPEG-2 block geometry and decide an architecture. That
produced the whole-frame input contract, the chroma findings and a decided
architecture. Then, while BEGINNING the consolidation sweep, W3D opened
README_Deblock4_Design_Spec and found sections 3.11 and 3.13 already contained a
fully-worked, PREVIOUSLY RATIFIED Deblock4 grid architecture - the union step-4
grid with scaled midpoint thresholds - complete with fixed-point threshold
conversion, immutable threshold sets and canonical read ordering. Someone had
already designed it properly. Nobody in the investigation had read it.

WHY IT WAS MISSED: the source tree was swept thoroughly. The decision record was
swept thoroughly. The SPECIFICATION was not, because the currency audit
described the README as "fallback general guidance" and that classification was
ACCEPTED INSTEAD OF CHECKED. A 2,800-line document carrying 137 MPEG-2 hits and
a ratified architecture is not fallback anything.

WHAT IT COST: everything downstream reopened. The just-decided architecture went
back on the table; a full comparison brief and a coder evaluation round were
needed; and the outcome changed materially. The rediscovered design was
ultimately REJECTED - but only after proper analysis, and that analysis produced
B2, which is better than what the investigation had reached alone. The near-miss
therefore ran BOTH ways: the project nearly shipped past good work, and nearly
missed the argument that improved it.

THE RULE THAT FOLLOWS: any knowledge sweep must include SPECIFICATION documents,
not merely decision records - and a document's CLASSIFICATION in an index is a
CLAIM TO BE VERIFIED, not a fact to be relied on. If a document plausibly
touches the question, read it, whatever the audit calls it.

WHAT THE ABORTED T1 PASS ACTUALLY COVERED (outgoing designer, Q3, RECORD):
NO document was read and consciously judged out of scope. None. T1 consisted of
exactly two acts before it stopped - the mechanical hit survey, and a PARTIAL
reading of ONE document (README v1_11: the decision-status table region, plus
sections 3.11 and 3.13 in full). For every other document the correct
classification is NEVER REACHED, not "rejected for a stated reason". There are
no hidden adjudications to trust or distrust, and every out-of-scope judgement
is the new designer's to make fresh. Parts of several documents were read
earlier in that session FOR OTHER PURPOSES - the charter's delivery sections,
Project Status, the currency audit, D0, both intros - and NONE of that counts as
T1 coverage.

THE SHARPER POINT, for anyone who has reported a sweep as done: the useful check
is not "did I read the specifications" but "did I read them FOR THIS QUESTION".
The previous designer HAD read parts of the README earlier in the project - that
is precisely why skipping it felt entitled and safe. FAMILIARITY IS WHAT MADE
THE OMISSION FEEL SAFE.
```

---

v1.7 (2026-08-18) Records the outcome of the first ledger-bearing tranche,
     whose two entries W3C REJECTED and whose method W3C found defective. The
     ledger template is fixed before any further tranche - five dispositions
     only, derived propositions in a separate field (DEC-23). PR-1 is resolved
     against W3D's proposal: the constraining principle already exists at
     authority 13.1, so the CURRENT-UNIQUE disposition was wrong and T5 may be
     closer to unblocked than PR-1 implied (DEC-24). PR-2 is not ratified as a
     standing rule; the coupling question becomes an open kernel decision
     (DEC-25). Both W3D errors are recorded permanently, because the designer
     repeated inside T1 the exact failure T1 exists to correct (DEC-26).
     Written under coder-chat-death recovery conditions; the companion
     Deblock4_T1_Resume_Brief_v1_0 carries the same content in narrative form
     for a cold successor.
v1.6 (2026-08-18) Closes the one currency gap W3C flagged as non-blocking:
     DEC-18 recorded the term set at 81 and stopped one review round short of
     the frozen 90. DEC-21 records the final frame, the freeze rule and its
     reason. DEC-22 declares the T1S01 split into T1S01a (the ratified
     authority, carrying PR-1 and PR-2) and T1S01b (the working record behind
     it), under the split-and-report provision the manifest reserved.
v1.5 (2026-08-18) T1S00 review outcomes absorbed after W3C recommended against
     starting T1S01 from manifest v1.0. All W3C findings accepted, none
     rejected. Recorded: population and search as separate mechanisms, the
     structural fix for PR-5 (DEC-17); the term set extended 42 -> 81 terms
     after measuring that it adds ~1,300 statement-level hits at zero
     population cost (DEC-18); T1's own process artifacts and the evidence zip
     explicitly excluded from adjudication with a closure audit, REVERSING
     manifest v1.1 (DEC-19); and the orphan-family check run and reported as
     a negative result, with its one genuine candidate registered for T1S05
     (DEC-20). Added method rule M11. Two arithmetic errors W3C caught in
     manifest v1.0 - a 49-versus-48 count and a 1,109-versus-1,114 hit total -
     are corrected in manifest v1.2 and noted here so the record shows they
     were found by review rather than by the author.
v1.4 (2026-08-18) T1 RELEASED by W3X; the T1S00 scope manifest is issued.
     Recorded the deferred three-way review model with its first-response
     carve-out (DEC-12), the six risk-ordered steps and the T1Snn_A/_B naming
     (DEC-13), the full-corpus evidence supply that replaced the per-step
     extract model after W3C found two blocking defects in the review scope
     (DEC-14), all superseded entries raised to Tier A (DEC-15), and
     read-only source inspection stated as permitted and expected (DEC-16).
     Added PR-5: building the manifest showed the previous survey searched
     the dev_documentation root only, leaving two live folders - the
     architecture re-decision record and the external research briefs, twelve
     documents and 3,758 lines - entirely outside its scope. PR-4 is narrowed
     to the term-set review task it always was.
v1.3 (2026-08-17) W3D. Absorbed the outgoing designer's four-document answer
     set, committed as evidence (DEC-11) with its record/judgement
     classification preserved. Added section T1-PREREG registering four
     adjudication items that must not be lost before the sweep reaches them:
     R4's possibly-universal false-activation limit currently filed inside the
     Architecture A rejection proof and gating T5 (PR-1); S5's degradation from
     principle to rejection-narrative history, with a W3D erratum recorded
     (PR-2); charter E3 stated in the vocabulary of a rejected mechanism, to be
     raised as a charter proposal (PR-3); and D2 v1_7's invisibility to the
     original survey (PR-4). Recorded S6 as CLEARED so it is not
     re-investigated. Added method rules M9 (term set defined, run and diffed)
     and M10 (README read against the re-verified section map). Added the
     README decision-status table, the in-README F12-F17 findings series and
     the Appendix A/B divergence risks to T1-KNOWN. Recorded in the incident
     section what the aborted T1 pass actually covered. No decision from v1.2
     was reversed.
v1.2 (2026-08-17) W3D. Status corrected to RATIFIED (DEC-01). T1 moved ahead of
     T5 on W3X's reversal (DEC-02) with the reason recorded. T5-alone-then-T6
     confirmed (DEC-03). Roadmap/currency-audit currency folded into T1/T3
     (DEC-04). Banner policy split, README and Grid Knowledge deliberately NOT
     bannered pre-adjudication (DEC-05) after W3X identified the mislabelling
     risk in W3D's original recommendation. Scope manifest adopted as the
     protection mechanism (DEC-06). README destination and its sequencing
     constraint recorded (DEC-07). T4 subsumed into the new T1.1-MATHS
     (DEC-08). Source inventory performed and recorded (DEC-09). Incremental
     ledger delivery adopted (DEC-10). T1-METHOD, the decision log and the
     recorded incident added in full so the reasoning survives a session death.
v1.1 (2026-08-16) W3C handoff reconciliation for W3X: authority pointer
     advanced to ratification-recording v1.05; T1 progress corrected so the
     targeted v1.03-v1.05 recovery is not mistaken for the formal sweep;
     T5->T6 sequencing made explicit; LG evidence tightened to
     adaptive-capable rather than assumed observed mixture; T7 clarified as the
     eventual consolidation commit, not the current pre-handoff documentation
     commit.
v1.0 (2026-08-16) First issue. Captures the T1-T7 queue that previously existed
     only in conversation and in condensed form in Project Status section 0,
     with the T1 pause reason recorded in full so the sequencing decision is
     not mistaken for neglect.
```
