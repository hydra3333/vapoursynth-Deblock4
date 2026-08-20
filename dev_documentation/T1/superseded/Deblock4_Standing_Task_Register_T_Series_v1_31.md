# Deblock4 - Standing Task Register (T-Series) for the MPEG-2 / Deblock4 Arc

**Version:** 1.31
**Date:** 2026-08-19
**Author:** W3D (v1.0); W3C v1.1 reconciliation; W3D v1.2 sequencing and
method; W3D v1.3 outgoing-designer evidence absorbed; W3D v1.4 review model,
step plan and manifest finding; W3D v1.5 T1S00 review outcomes; W3C v1.30
recovery-state reconciliation after W3D session limit; W3D v1.31 consolidated
task list into section 0 and recorded the 2026-08-19 recovery-closure
decisions
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
THIS SECTION IS THE CONSOLIDATED TASK LIST AND SEQUENCING RECORD.

WHY IT LIVES HERE. Until v1.31 the full picture existed in no single document:
this register carried the T-series status, T1S00 carried the step assignments,
and the resume brief carried the sub-tranche table. A successor had to
assemble it. It is assembled here because this is the ratified work queue and
the only document whose job is sequencing.

READ THE CAVEAT AT 0b BEFORE RELYING ON IT: this register lives under T1/ and
is therefore excluded from every T1 search.
```

## 0.1 THE FULL TASK LIST AND SEQUENCING

```text
T1S00   Manifest, frozen search frame            COMPLETE; at v1.6
        90 terms, six steps                      (DEC-69 delivery-describing
                                                 bump at v1.5; v1.6 corrected
                                                 its attribution, sequence
                                                 record and a fence defect
                                                 inherited from v1.4)

        POPULATIONS - DO NOT CONFLATE, AND DO NOT RECONCILE BY REWRITING
        HISTORY:
            47   frozen T1S00 survey record - what was surveyed 2026-08-18
            41   current T1 adjudication population, after DEC-66
            46   settled a5 search snapshot - what the a5 SWEPT fields ran over

        MECHANICAL EXCLUSIONS IN FORCE:
            any folder whose name begins "superseded" or
                "scheduled_for_deletion"                          DEC-60
            everything under T1/                                  DEC-63
            everything under GAIS_investigations/                 DEC-66

T1S01   THE ARCHITECTURE RECORD
        frozen original assignment: 13 documents, ~5,741 lines, 1,114 hits
        current after DEC-66:        7 documents (authority + six Scopes/)

  T1S01a  The ratified MPEG-2 authority (1,983 lines)

    a1    PR-1 and PR-2 only                     CLOSED by decision, DEC-54
    a2    Header + currency statements           CLOSED; reissued v1.1
    a3    Section 0, seventeen numbered items    CLOSED provisionally, DEC-42
    a4    Section 23 tail, steps 6-10            CLOSED provisionally, DEC-52
    a5    BODY PART 1, sections 1-8,
          lines 223-715                        < LEDGER v1.5 DELIVERED;
                                                 AWAITING W3C REVIEW
    a5b   BODY PART 2, sections 9-13,
          lines 716-1098                         NOT STARTED. Split ratified
                                                 at DEC-68; blocked until a5
                                                 closes.
    a6    Sections 14-22, plus section 24
          (DEC-55) and Appendices A-D            NOT STARTED
    a7    Appendix E older entries, the six
          owed items, whole-document
          consistency pass                       NOT STARTED; DECLARED FINAL.
                                                 The consistency pass happens
                                                 THERE AND NOWHERE EARLIER.

    RANGES ARE EXACT, NOT APPROXIMATE (DEC-56). Section 1 begins at line 223;
    lines 216-222 are section 0's tail and belong to a3.

  T1S01b  Working record behind the authority    NOT STARTED
          SCOPES-ONLY under DEC-66 - the six Scopes/ documents. The six
          GAIS_investigations/ documents are no longer part of it.

T1S02   README part 1 - decision-status table,
        sections 3.11-6.2, F12-F17. ~2,000 lines NOT STARTED
T1S03   README part 2 - Appendices A and B,
        section 20. ~1,800 lines                 NOT STARTED
T1S04   Charter (holds PR-3), D0 Binding
        Knowledge Index, D2 HolyWu Real Schedule NOT STARTED
T1S05   ~30 remaining live documents, mostly
        low-hit informative records, plus the
        reference provenance files               NOT STARTED

  T1-EVID   Outgoing-designer answer set         COMMITTED as evidence, DEC-11
  T1-PREREG Pre-registered adjudication items    4 registered; see section
  T1.1      Mathematical inventory/gap table     runs INSIDE T1, reports after

DOWNSTREAM OF T1, IN ORDER:

  T8      Close the provenance gaps T1 surfaces  OPEN, DEC-65.
          Runs AFTER T1 and BEFORE T5. Does NOT block T1, T2 or T3.
          Highest-priority item: F8, vertical geometry invariance. It is
          tagged [DERIVED], has no recorded basis, and EVERY architecture in
          the register - including the rejected ones - assumes it.
          T1 establishes WHERE a statement lives. It never establishes that
          the statement is TRUE. T8 is where that happens.

  T5      Detector mathematics                   AFTER T8, DEC-02.
          Must be FROZEN before any held-out judgement.
          PR-1's block on T5 is CONFIRMED LIFTED (DEC-57). Unblocked is not
          next.

  T6      D4-Q14 experiment plan and execution   AFTER T5, as a SEPARATE
                                                 ratification, DEC-03.
          The single coordinated T5+T6 package permission is WITHDRAWN.

  T2      Retire the Grid Knowledge document     BLOCKED by T1
  T3      De-duplicate MPEG-2 content into
          references                             BLOCKED by T1
  T4      Boundary-set mathematics               SUBSUMED into T1.1-MATHS,
                                                 DEC-08. Not closed by
                                                 absorption.
  T7      Final consolidation commit             BLOCKED by T1-T6 and T8

HARD RULE, INDEPENDENT OF THIS QUEUE:
    NO DEBLOCK4 KERNEL SCOPE MAY BE DRAFTED until D4-Q14 reports and W3X
    ratifies the architecture allowed to enter kernel/oracle development.
    Q14 is an ARCHITECTURE DISCRIMINATOR, not a shipping gate: B2 may advance
    only if viable; otherwise D only if viable; if neither is adequate, the
    architecture REOPENS. NOTHING SHIPS AT Q14.

CURRENT RESUME ORDER FOR A SUCCESSOR W3D:
    Deblock4_T1_Resume_Brief section 0a, HIGHEST COMMITTED VERSION
    -> this register: section 0, the 0a recovery gate, and the DECISION LOG
    -> the delivered a5 ledger, highest version
    -> T1S01a5_A_Classification_Repair_v1_1.md
    -> T1S01a5_B_Coder_Response_v1_1.md, the Tier C sample review
    -> T1S01a5_B_Classification_Repair_Response_v1_0.md
    -> bring the a5 closure route to W3X
    -> ONLY AFTER a5 closes, start T1S01a5b.
```

## 0b. TWO CAVEATS THIS SECTION CANNOT FIX BY ITSELF

```text
CAVEAT 1 - THIS REGISTER IS INVISIBLE TO EVERY T1 SEARCH.
    DEC-63 excludes everything under T1/ from the search population, and this
    register lives there, as does the resume brief. DEC-63's own standing
    obligation says applicable knowledge must be PROMOTED OUT of T1/ before it
    counts, and warns that "a successor writing a substantive finding into a
    resume brief or covering note and leaving it there makes it permanently
    invisible to every future sweep."
    THE SEQUENCING RECORD ABOVE IS PROCESS MATERIAL, NOT APPLICABLE PROJECT
    KNOWLEDGE, so its location is correct. But the exposure is real and is
    recorded here so it is not rediscovered as a gap: if durable project
    knowledge is ever written into this register or the resume brief, it must
    be promoted out or it is lost to the sweep.

CAVEAT 2 - THIS SECTION IS NOT THE LIVE SUB-TRANCHE STATE.
    Deblock4_T1_Resume_Brief section 0a is bumped every time a sub-tranche is
    issued or closed. THIS REGISTER IS NOT. Where the two disagree on STATE,
    THE RESUME BRIEF IS RIGHT and this section has staled.
    The shape above - the steps, the ranges, the sequencing, the populations
    and the exclusions - changes only by a recorded decision, and is therefore
    safe to rely on. The live position markers are not.
```

## 0a. RECOVERY GATE AFTER THE 2026-08-19 W3D SESSION LIMIT

```text
THIS SECTION RECORDS RECOVERY STATE. IT DOES NOT CREATE A NEW RATIFIED PROCESS
RULE AND IT DOES NOT CLAIM a5 CLOSED.

WHAT DIED:
    the immediately preceding W3D chat session.

WHAT SURVIVED AS PHYSICALLY DELIVERED W3D ARTIFACTS:
    T1S01a5_A_Ledger_Body_Part1_v1_3.md
    T1S01a5_A_Classification_Repair_v1_1.md
    this register v1.29
    Resume Brief v1.10

WHAT W3D SAID IT WOULD DO NEXT BUT DID NOT DELIVER:
    rewrite the a5 ledger from Classification Repair v1.1.

WHAT W3C DID FOR RECOVERY:
    produced T1S01a5_A_Ledger_Body_Part1_v1_4.md as an explicit recovery
    reconstruction rather than inventing the dead designer's unseen working
    v1.5/v1.6 generations.

WHY THE NORMAL REVIEW FLOW CANNOT BE PRETENDED:
    W3C authored recovery ledger v1.4. A later W3C session is still the W3C
    party; a chat reset does not turn W3C into an independent verifier of
    W3C-authored text.

WHAT SUCCESSOR W3D MUST DO BEFORE a5b:
    independently check recovery ledger v1.4 against:
        - delivered ledger v1.3;
        - Classification Repair v1.1;
        - the accepted W3C sample/re-sweep findings;
        - the binding T1 review scope and this register.
    Then either:
        A. adopt/reissue a W3D-owned corrected ledger; or
        B. identify and correct any reconstruction error first.

WHAT W3X THEN OWES:
    choose/ratify the one-off recovery closure path for a5. The clean default
    is to treat successor W3D as the independent verifier of the W3C recovery
    artifact, rather than asking W3C to certify its own reconstruction.
    If W3X wants a further review layer, bound it explicitly.

WHEN THE NEW CODER IS FIRST ASKED FOR AN a5 REVIEW:
    TELL IT BEFORE IT STARTS that ledger v1.4 was authored by W3C as a recovery
    reconstruction. It must not report "independent W3C review of v1.4" as
    though v1.4 were W3D-authored.

NO TECHNICAL REOPENING IS IMPLIED:
    - all 22 classification-repair probe tables are complete at v1.1;
    - the settled search population/counts were reproduced;
    - the repair classifications passed substantively;
    - the remaining gate is provenance/independence of the reconstructed
      ledger artifact and formal closure.

THEREFORE:
    NOT READY FOR a5b YET.
    READY FOR SUCCESSOR-W3D RECOVERY VERIFICATION OF THE a5 LEDGER.
```

---

# 1. DECISION LOG - decisions taken 2026-08-17, with the reason for each

Recorded here rather than only in conversation, because a chat death loses
conversation and this arc has already lost two designer sessions. Each entry
states what was decided and WHY, so a successor inherits the reasoning and not
just the instruction.

```text
DEC-74  THE FULL TASK LIST AND SEQUENCING RECORD LIVES IN SECTION 0 OF THIS
        REGISTER.
        WHAT WAS WRONG: the complete picture existed in no single document.
        This register held the T-series status, T1S00 held the step
        assignments and their line counts, and the resume brief held the
        sub-tranche table. The populations, the mechanical exclusions and the
        downstream T8/T5/T6 order were spread across all three plus the
        decision log. A successor had to assemble it from four places, and the
        successor designer of 2026-08-19 did exactly that and then found the
        assembled version existed nowhere.
        WHY HERE: this is the ratified work queue and the only document whose
        job is sequencing. T1S00 is a FROZEN survey frame and must not become
        a live status document; the resume brief is a recovery artifact that
        is rewritten every sweep.
        RECORDED WITH ITS OWN LIMITATION, at section 0b: this register lives
        under T1/ and is therefore invisible to every T1 search under DEC-63.
        That is correct for process material and wrong for anything durable,
        so the standing promote-out obligation is restated where a writer will
        meet it.
        (W3D raised the gap; W3X directed the location 2026-08-19)

DEC-73  THE ONE-OFF a5 RECOVERY ROUTE CLOSES WITH AN ORDINARY W3C REVIEW OF A
        W3D-AUTHORED LEDGER.
        THE PROBLEM IT RESOLVES: W3C authored recovery ledger v1.4, so no
        later W3C session could independently verify it - a chat reset does
        not create a different party (section 0a). W3X therefore held open a
        one-off recovery-review route.
        WHY IT CAN NOW CLOSE NORMALLY: the successor W3D built ledger v1.5
        TEXTUALLY on delivered ledger v1.3 under DEC-70, and v1.4 was ruled
        out as a source. v1.5 is a W3D document made from W3D's delivered
        inputs, so W3C reviews it as an ordinary independent reviewer with
        nothing of its own to certify. The special route is not needed and
        is not used.
        THE TIER C SAMPLE IS NOT REOPENED. W3X selected it, W3C reviewed the
        eleven entries at T1S01a5_B_Coder_Response_v1_1.md, and the result -
        3 AGREE, 8 DISAGREE - drove the re-sweep, the classification repair
        and the rewrite. It is settled and is not re-run.
        (W3X decided 2026-08-19)

DEC-72  THE T1S00 ATTRIBUTION AND SEQUENCE DEVIATIONS ARE CORRECTED AT v1.6
        AND RECORDED RATHER THAN QUIETLY FIXED.
        DEFECT 1: T1S00 v1.5's header read "Author: W3D". W3C produced it
        during recovery, after the designer session had ended - its own
        revision note describes advancing the status through "the W3C
        recovery-ledger v1.4 verification gate", which did not exist until
        W3C created v1.4. The care taken over ledger v1.4's authorship was
        not taken here, and a document inside the frozen search frame
        carrying the wrong author misstates the provenance of the frame.
        DEFECT 2: DEC-69 sequenced the bump AFTER the a5 ledger rewrite. It
        ran BEFORE, during recovery - the condition DEC-69 was written to
        prevent.
        NO REMEDY ON DEFECT 2, AND THE REASON MATTERS: the constraint existed
        to protect designer attention during a5, and that risk has passed.
        Undoing the bump would cost work and protect nothing. What is owed is
        the RECORD, so a later step meets a decision rather than a fresh find
        - the DEC-59 lesson.
        A THIRD DEFECT WAS FOUND AND ATTRIBUTED ACCURATELY: the revision
        history had no heading and no opening code fence, leaving the
        document's fences unbalanced. THIS IS NOT W3C's - v1.4 has it too.
        Inherited, carried forward, and fixed at v1.6.
        (W3D found; W3X directed the correction 2026-08-19)

DEC-71  THE CONCISE PROJECT SUMMARY STAYS IN THE T1 POPULATION UNTIL T1S05
        ADJUDICATES IT.
        THE QUESTION: W3X observed that the summary is not a definitive
        knowledge source - it was meant as a short reading of Project Status -
        and considered excluding it from sweeping or retiring it early.
        THE RULING: it stays. THE REASON IS DEC-05, ratified by W3X for
        exactly this shape of decision: a "do not rely on" label placed
        BEFORE adjudication is a pre-judgement whose practical effect is
        permission to skip. The README and Grid Knowledge were spared banners
        on that ground and this document is in the same class - unadjudicated,
        owned by T1S05, and possibly holding current material nobody has
        checked for that question.
        TESTED RATHER THAN ASSUMED: the deferred-workstream list is safely
        carried in the charter and README, so nothing there is at risk. But
        two items are unique to this document in the live population - the
        "in-tree yardstick" description of Stage 2C's oracle role, and the DV
        presets deferral - and four deferred items (MJPEG, automatic grid
        selection, the 4:2:2 preset, automatic strength analysis) live ONLY
        in this summary and the README, which DEC-07 strips at T3.
        WHAT DID CHANGE: the summary is bumped to v1.7, restoring fourteen
        items that v1.6 dropped with no mandate, and now states in its own
        voice that it is NOT a definitive source of project knowledge and
        loses to Project Status section 0 wherever the two differ.
        (W3D raised the DEC-05 tension and supplied the uniqueness evidence;
        W3X decided 2026-08-19)

DEC-70  THE a5 LEDGER IS REBUILT TEXTUALLY ON DELIVERED v1.3, AND THE W3C
        RECOVERY RECONSTRUCTION v1.4 IS NOT A SOURCE.
        WHAT WENT WRONG WITH v1.4: W3C reported it itself, which is why this
        decision is clean. It left 17 of the 34 entries untouched and rewrote
        the other 17 - exactly the 17 with a mandated change - but retained
        only 27% to 67% of their text against mandates that in most cases
        touched a single field. Entry text fell from 121,333 to 83,654
        characters. What went was disproportionately the DEC-50 evidence:
        enumerated populations, line numbers, recorded negative results, and
        the reasoning supporting each disposition. LED-037 lost its stated
        population, its fifteen classified hit lines and its six-document
        collision enumeration, leaving the bare assurance DEC-50 prohibits.
        LED-058 lost the recorded negative result that no live document
        asserts mixture is OBSERVED rather than PERMITTED.
        THE RULE ADOPTED: v1.3 is the TEXT; every change traces to a delivered
        artifact or a ratified decision; anything the successor adds on its
        own judgement is labelled a NEW W3D FINDING with its evidence rather
        than presented as a repair mandate.
        THE LINEAGE WAS AUDITED BEFORE RELYING ON v1.3, not assumed sound:
        entry text across the W3D chain rose monotonically, 114,731 ->
        117,030 -> 116,968 -> 121,333, and the only two per-entry shrinks -
        LED-051 and LED-052 at v1.3 - are the recorded atomic splits, where
        the parent lost text to a new child that gained more. v1.3 IS A
        FAITHFUL ACCUMULATION OF EVERYTHING W3D WROTE.
        CREDIT WHERE IT IS DUE: W3C identified its own reconstruction as
        lossy and recommended rebuilding from v1.3 rather than expanding v1.4.
        That recommendation is why this round is clean.
        (W3C self-reported; W3D quantified; W3X decided 2026-08-19)

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

DEC-69  T1S00 IS BUMPED TO v1.5 - DELIVERY-DESCRIBING PARTS ONLY, AND THE
        BUMP MUST SAY SO IN ITSELF.
        WHY: T1S00 is one of the live documents a successor is sent to read,
        and it has drifted in FIVE delivery-describing places while its frozen
        search frame has not drifted at all:
            it names three sub-tranches (a1, a2, a3); there are eight
            its STATUS line predates T1S01a2 even running
            its exclusion list names four folders and knows nothing of
              DEC-60's mechanical rule, DEC-63's T1/ exclusion or DEC-66
            it defines T1S01b as Scopes PLUS GAIS
            it pins charter v1.29; the charter is v1.31
        WHAT MAY BE EDITED: the sub-tranche list, the status line, the
        exclusion statement, the T1S01b definition, and the pinned
        generations - which are DE-PINNED to "highest committed version",
        because a pinned generation in an orientation document is the defect
        that produced the wrong one here.
        WHAT MUST NOT BE TOUCHED: the 90-term set, the surveyed population
        tables, the hit counts, and section 5's recorded weaknesses. THE
        FROZEN SEARCH FRAME IS NOT REOPENED BY THIS BUMP.
        THE BUMP MUST RECORD ITSELF: v1.5 states in its own revision note
        that W3X authorised delivery-describing edits only and that the
        frozen frame was deliberately left alone - otherwise a reader meeting
        "v1.5" on a document declared frozen cannot tell what moved.
        SEQUENCING: AFTER the T1S01a5 classification repair and ledger
        rewrite. It is orientation hygiene, not a blocker, and W3D should not
        have a fourth document in flight while a5 is mid-correction.
        (W3D raised the drift; W3X decided 2026-08-19)

DEC-68  THE T1S01a5 / T1S01a5b SPLIT IS RATIFIED.
            T1S01a5   authority sections 1-8,  lines 223-715  THE EVIDENCE
                      HALF: codec facts, syntax regimes, whole-frame geometry,
                      the SeparateFields derivation, the measured LG and OTA
                      material, prior art, the GAIS calibration rule.
            T1S01a5b  authority sections 9-13, lines 716-1098 THE ARCHITECTURE
                      HALF: options and re-decision, B2 topology mathematics,
                      Architecture D, the Architecture A rejection proof,
                      scheduler/kernel separation.
        THE BOUNDARY IS A SUBJECT BOUNDARY, not a line count: section 8 ends
        what was established and how it was verified; section 9 opens what the
        project decided to build on it. Same shape as DEC-35's a3/a4 split.
        It also keeps all three PR-1/PR-2 home sections - 9.1, 12.5, 13.1 - on
        one side, so the DEC-24 pointer re-derivation happens in one place.
        a6 and a7 are UNCHANGED.
        (W3D declared under the split-and-report provision; W3X ratified
        2026-08-19)

DEC-67  THREE SWEEP METHOD RULES ARE RATIFIED. Each was paid for by a defect.
        RULE 1 - OPEN EVERY HIT. A hit recorded but not classified is NOT
        SWEPT. PAID FOR BY: an entry whose SWEPT field said "THE DISTINCTION
        MATTERS AND IS NOT RESOLVED BY THIS SEARCH" and then did not resolve
        it, when the counter-evidence was inside the file the search had
        already returned.
        RULE 2 - NORMALISE WHITESPACE ON PHRASE SEARCHES. The corpus wraps
        sentences across lines, so raw line matching returns SILENT ZEROES
        rather than errors. PAID FOR BY: probing the authority for one of its
        OWN sentences and getting zero hits in the authority.
        RULE 3 - SEARCH THE PROPOSITION, NOT THE SENTENCE, IN W3C's BOUNDED
        FORM. W3D's original wording, "plausible phrasings", was rejected by
        W3C as too discretionary to be a review criterion - it becomes either
        an under-search or an open-ended ritual. The ratified form:
            declare the proposition;
            declare a BOUNDED probe family covering its material concepts,
              including the source wording and reasonable independent
              reformulations;
            run it over the declared population with whitespace normalisation;
            OPEN EVERY CANDIDATE FILE and classify each occurrence, recording
              a MIXED classification where one file carries different
              meanings;
            if opening a genuine CARRIER exposes an equivalent phrasing the
              family did not cover, ADD IT, RECORD WHY, and rerun the same
              population;
            claim NO EXHAUSTIVENESS beyond the declared population and probe
              family.
        PAID FOR BY: probing the authority's exact words and calling a
        proposition unique when the corpus states it four other ways.

        AND THE ONE THAT SURVIVED ALL THREE, recorded because it is the
        reusable part: OPENING A HIT IS NOT THE SAME AS READING IT. In the a5
        re-sweep W3D opened every hit as Rule 1 requires and STILL
        misclassified seven files - a Zig comment about a version string
        counted as the MPEG-2 single-source rule; "I7 independent
        verification" counted as the GAIS rule; the substring inside the
        identifier D4-Q01 counted as the edge-position convention. THE
        FAILURE MODE IS NOT "DID NOT LOOK". IT IS "LOOKED AND SAW WHAT WAS
        EXPECTED".
        A COUNT THAT COMES OUT RIGHT CAN STILL HAVE THE WRONG MEMBERS: in
        LED-033 a false candidate entered while a real carrier escaped the
        probe, and the two cancelled to give the correct total.
        I7 PROVENANCE: W3D proposed from the failures; W3C verified and
        supplied Rule 3's bounded form; W3X ratified 2026-08-19.

DEC-66  THE GAIS_investigations/ TREE IS IGNORED FOR EVERYTHING - SEARCH AND
        ADJUDICATION ALIKE - ON THE SAME FOOTING AS superseded*.
        THE RULE: nothing under GAIS_investigations/ is searched, adjudicated,
        or usable as knowledge. W3X has moved the two raw GAIS files that sat
        at documentation root into that tree:
            GAIS_GATING_RESPONSE.txt
            GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt
        WHY: GAIS failed as a citation authority - section 8 of the authority
        records five wrong patent attributions and two unlocatable papers. The
        verified material was DELIBERATELY ABSORBED into the F-series and the
        retained-reasoning list; the raw responses were never meant to become
        competing authority. W3X's judgement is that leaving them adjudicable
        is too dangerous while the corpus is being consolidated.

        CONSEQUENCES, STATED BECAUSE THEY ARE NOT ALL OBVIOUS:
          1. THE ADJUDICATION POPULATION DROPS FROM 47 TO 41. The search
             population is unchanged at 46 - GAIS was already out of it.
          2. T1S01b BECOMES SCOPES-ONLY. T1S00 defines it as the six Scopes
             documents PLUS the six GAIS documents; the GAIS half is removed.
          3. LED-023's DISCHARGE ROUTE CHANGES, AND IMPROVES. That entry -
             owed to T1S01a7 - tests the header's blanket claim that nothing
             in the authority rests on unverified GAIS testimony. It can no
             longer be discharged by COMPARISON against the GAIS files. It
             must instead be discharged CONSTRUCTIVELY: every claim must have
             a recorded non-GAIS basis. THAT IS A STRICTER TEST, and it is
             the same shape as task T8. a7 and T8 should discharge it
             together rather than separately.
          4. NOTHING IS DELETED. The files remain on disk as history. Ignored
             is not destroyed, and the record of WHY they were set aside is
             this decision.

        A CONFLICT W3D RAISED BEFORE RECORDING THIS, and the resolution: this
        decision changes the ADJUDICATION POPULATION, which is part of T1S00's
        FROZEN SEARCH FRAME - while DEC-69 authorises editing only T1S00's
        delivery-describing parts. THE RESOLUTION IS TO RECORD IT AS AN
        EXCLUSION, NOT AS A POPULATION EDIT: T1S00 v1.5 adds GAIS to its
        exclusion statement and leaves section 3.3's survey table standing as
        the record of what was surveyed, marked excluded. The population is
        then stated as 47 SURVEYED / 41 ADJUDICATED. This is exactly how
        DEC-60 and DEC-63 were handled and it keeps the freeze visibly intact.
        (W3D raised the danger and the conflict; W3X decided 2026-08-19)

DEC-65  T8 IS OPENED: CLOSE THE PROVENANCE GAPS T1 SURFACES.
        WHY: T1 is a location-and-currency sweep and does NOT establish that
        a statement is true. Its remedy tasks have no home for "verify this
        claim's basis", so findings of that class would be recorded and then
        orphaned. T1S01a5 surfaced five in its first eight sections.
        SEQUENCING: T8 runs BEFORE T5 and does not block T1, T2 or T3. T7,
        the closing commit, now depends on T8 as well.
        HIGHEST PRIORITY ITEM: F8, vertical geometry invariance. It is
        tagged [DERIVED], has no recorded basis, and every architecture in
        the register including the rejected ones assumes it.
        NUMBERING NOTE: W3D proposed calling this T7. T7 ALREADY EXISTS as
        the final consolidation commit. Checked before allocating; the task
        is T8.
        (W3D proposed; W3X 2026-08-19)

DEC-64  SUPERSEDED IS SPLIT BY KIND, AND THE PROPAGATION LIMB IS THE POINT.
        THE PROBLEM: the disposition vocabulary defines SUPERSEDED as "no
        longer true. Retire or delete it." That covers both a statement that
        WAS true and has been overtaken, and one that was NEVER true. The
        word reads as the first. The remedy adequate for the first - a
        pointer to the newer statement - is DANGEROUS for the second: a
        reader following it concludes the old text was merely older, not
        wrong, and never asks what else rested on it.
        THE PROJECT HAS ALREADY HANDLED THE SECOND CASE THREE TIMES, THREE
        DIFFERENT WAYS: section 8's discredited citation table (corrected
        attributions PLUS a separate list of what survived as reasoning -
        the model); section 4.4's "that description is RETIRED" (retired,
        but not marked wrong and with no note of what depended on it);
        Architecture A's rejection proof. One class, three treatments.
        PROPOSED REMEDY, to be added to the ledger entry template: every
        SUPERSEDED entry carries
            SUPERSEDED-KIND   OVERTAKEN | ERRONEOUS
            PROPAGATION       for ERRONEOUS: where the false statement was
                              relied on, searched and enumerated - or "none
                              found", with the population named.
        A FIELD, NOT A SIXTH DISPOSITION, because the tiering and the
        existing entries key off SUPERSEDED and a new disposition would mean
        revisiting all of it.

        W3X's REFINEMENT, AND IT SHARPENS THE RULE: pragmatically OVERTAKEN
        and ERRONEOUS have the SAME effect on the statement itself - we do
        not use it either way. THE DISTINCTION THEREFORE EARNS ITS KEEP
        ENTIRELY THROUGH PROPAGATION, not through the label:
            OVERTAKEN  - work built on it was right at the time and normally
                         remains right, because the newer statement usually
                         agrees in substance.
            ERRONEOUS  - work built on it MAY BE WRONG NOW, and that is a
                         question nothing in the current machinery asks.
        SUPERSEDED-KIND on its own would be near-useless. It exists to
        TRIGGER the propagation search.

        VERIFICATION: charter I7 applies - this criterion will judge W3D's
        own entries. W3D proposes; W3C VERIFIES THE WORDING before it binds;
        W3X ratifies. NOT YET BINDING ON THE LEDGER.
        COST OF ADOPTING NOW: nil. T1S01a5 has NO SUPERSEDED entries (33
        CURRENT-*, one CONFLICTING) and the only prior one, T1S01a2 LED-005,
        is an OVERTAKEN case - an authority statement overtaken by DEC-03.
        THE FIRST REAL ERRONEOUS CASE WILL BE THE README's REJECTED
        ARCHITECTURE AT T3, which is where getting it wrong costs most.
        (W3D proposed; W3X accepted subject to W3C wording verification,
        and supplied the propagation refinement, 2026-08-19)

DEC-63  THE T1/ TREE IS A WORKSHOP, NOT A SHELF. IT IS EXCLUDED FROM THE T1
        SEARCH POPULATION ENTIRELY.
        THE RULE, as W3X ruled it 2026-08-19:
            Nothing under T1/ is searchable. Knowledge files MAY be created
            and worked on inside T1/ - for temporary or consolidation
            purposes - but while they are there they are NOT searchable, NOT
            applicable and NOT final. For content to become real applicable
            knowledge it must be COPIED OR MOVED OUT of T1/ into the
            dev_documentation tree proper, and not into a retired tree.
            LOCATION DETERMINES STATUS, and status is checkable by path.
        POPULATION UNDER DEC-60 PLUS DEC-63, on the W3X common base:
            543 files, 442 excluded as retired, 47 further excluded as T1/,
            leaving a SEARCH POPULATION OF 54.

        WHY IT WAS NEEDED. The a5 ledger searched T1/ as well, on W3D's
        reasoning that a copy anywhere refutes a uniqueness claim. W3C
        applied that wording exactly as written and found it made SUPERSEDED
        GENERATIONS OF THE a5 LEDGER refute the a5 ledger's own
        CURRENT-UNIQUE entries - four times over, rising by one with every
        reissue. W3C's reasoning was faithful to the wording; the wording was
        W3D's defect.

        WHY THE PATH RULE BEAT W3D's PROPOSED ALTERNATIVE. W3D proposed an
        ASSERT-versus-QUOTE distinction: a document asserts when it states a
        proposition as true, quotes when it reproduces it to adjudicate.
        W3X rejected it. THE REASON IS THE REUSABLE PART: assert-versus-quote
        requires a judgement per file, on a criterion that decides whether
        W3D's own uniqueness claims survive - which charter I7 exists to
        prevent. A path test requires no judgement at all. This is the DEC-60
        lesson applied a second time: prefer the mechanism to the criterion.

        IT ALSO REMOVES AN ASYMMETRY W3D INVENTED. T1S00 section 2.0a already
        excluded T1's own process artifacts from ADJUDICATION. W3D widened the
        SEARCH beyond that on its own reasoning and never flagged the
        inconsistency. Search and adjudication now agree.

        VERIFIED BEFORE RULING, NOT AFTER. All 47 live T1/ files were
        classified: 45 are sweep artifacts, the task register, the resume
        brief or the review scope; two are outgoing-designer advice documents
        (W3D_Advice_T1S01a3_Position, W3D_Handover_Answers_Q2_Q4). Both were
        probed for MPEG-2 and design content and the only technical words in
        either appear in one sentence of bookkeeping about which ledger entry
        carries which item. NOTHING IN T1/ ASSERTS PROJECT KNOWLEDGE, so the
        exclusion loses nothing today.

        THE STANDING OBLIGATION THAT KEEPS IT TRUE. Because the exclusion is
        safe only while that remains so, applicable knowledge must not be
        left to live in T1/. Anything durable is promoted OUT of T1/ before
        it counts. A successor writing a substantive finding into a resume
        brief or covering note and leaving it there makes it permanently
        invisible to every future sweep.

        RECORDED SO IT IS NOT REDISCOVERED AS A GAP (the DEC-59 lesson):
        T1/ IS DELIBERATELY NEVER SWEPT. A later step finding that the task
        register and resume brief were never adjudicated has found a
        DECISION, not an omission.

        CONSEQUENCE ALREADY APPLIED: four numeric SWEPT claims in the a5
        ledger had been measured over the wider population and were wrong.
        Corrected at a5 ledger v1.5; no disposition changed.
        (W3C exposed the defect; W3D verified and quantified; W3X ruled and
        chose the rule 2026-08-19)

DEC-62  THE a5 TIER LABELS WERE WRONG ON 31 OF 34 ENTRIES, AND THE DIRECTION
        OF THE ERROR IS THE PART THAT MATTERS.
        THE RULE: review scope section 6 derives the tier FROM THE
        DISPOSITION. Tier A is CONFLICTING or SUPERSEDED, plus the four
        pre-registered items. Tier B is OPERATIVE-SPEC and carries ONE
        question - is this really a specification the code implements. Tier C
        is CURRENT-UNIQUE or CURRENT-DUPLICATE, and W3X SELECTS A RANDOM
        SAMPLE.
        WHAT a5 DID INSTEAD: used the field as an IMPORTANCE marker. 23
        entries marked A, 9 marked B, 2 marked C, against a correct
        distribution of 33 C and one A.
        W3C REPORTED THE NINE TIER B CASES. It did not report the 23 TIER A
        CASES, and THOSE ARE THE MORE SERIOUS HALF. The scope says of Tier C:
        "W3X selects a random sample - THE DESIGNER DOES NOT CHOOSE WHICH
        ONES YOU SEE." By marking 23 of its own entries Tier A, W3D set the
        review depth of its own work. It LOOKS generous because it asks for
        more scrutiny, and it is still the reviewed party shaping the review
        - which is what charter I7 exists to stop. A designer who can mark
        entries Tier A can also, by omission, mark the rest as lesser.
        NOT INHERITED - CHECKED, NOT ASSUMED. The a2, a3 and a4 ledgers all
        derive tier from disposition correctly. a5 invented the misuse.
        REMEDY at a5 ledger v1.4: every TIER field is now COMPUTED from the
        entry's DISPOSITION rather than typed, so it cannot drift again.
        W3X ACTION NOW OWED: 33 entries are Tier C, so W3X must select the
        random sample for W3C, and W3D must not be shown the selection.
        (W3C found the Tier B half; W3D found the Tier A half while checking
        the Tier B finding; W3X 2026-08-19)

DEC-61  TWO a5 METHOD DEFECTS, BOTH W3C's, BOTH FOUND BEFORE IT COMPLETED A
        SINGLE ENTRY REVIEW.
        (a) COMPOUND DISPOSITIONS. Three a5 entries - LED-051, LED-052,
            LED-053 - gave DIFFERENT DISPOSITIONS to different propositions
            inside ONE entry. DEC-33(a) permits exactly two remedies for a
            statement whose clauses have different statuses: SPLIT the entry,
            or NARROW the claim. A compound DISPOSITION field is neither.
            SEVERITY, STATED IN BOTH DIRECTIONS: the second status was
            VISIBLE in the disposition field rather than hidden in REASON, so
            the specific danger DEC-33(a) names - a second unrecorded
            disposition hiding in prose - did not occur. But the rule's
            positive requirement was breached and its remedy is prescribed.
            REMEDY APPLIED at a5 ledger v1.3: LED-051a, LED-052a and LED-053a
            created. No disposition, canonical home, action or SWEPT result
            changed - each proposition keeps the outcome it already had.
            THE EXTENT WAS ENUMERATED, NOT SAMPLED: every DISPOSITION field
            in the ledger was extracted and inspected; exactly three were
            compound. Entry count 31 -> 34.
            THE BOUNDARY THIS ESTABLISHES, and it is worth having: an entry
            with ONE disposition and PER-PROPOSITION canonical homes or
            duplicate actions is EXPRESSLY PERMITTED - review scope 5.4
            requires the canonical source to be identified per proposition,
            and DEC-36 ratified that wording. What is forbidden is
            per-proposition DISPOSITIONS. Ten a5 entries do the former and
            are correct as written.
        (b) A FALSE HISTORICAL CLAIM, AND THE MORE INSTRUCTIVE OF THE TWO.
            a5 LED-036 stated it was the FIRST entry in T1 to claim
            STAY-CANONICAL, and the ledger's closing question repeated it.
            IT IS FALSE. T1S01a3 ledger v1.4 already claims it at LED-020
            (line 535) and LED-021 (line 654), corrected to it from
            RETAIN-SUMMARY at a3 ledger v1.3 under DEC-38.
            WHERE IT CAME FROM: the T1 resume brief said "no entry anywhere
            in T1 has yet claimed STAY-CANONICAL ... a5 is where that first
            happens", from v1.3 through v1.6. The a5 designer read it,
            repeated it, AND CITED THE BRIEF AS ITS DERIVED-BASIS - so an
            unchecked statement acquired a source and looked evidenced.
            THE SUBSTANTIVE RESULT OF LED-036 IS UNAFFECTED: section 1.1
            remains the canonical home, the named non-canonical copy is real,
            and the DEC-43 evidence requirement is satisfied. Only the
            framing is withdrawn.
            WHAT IS ACTUALLY TRUE AND SHOULD BE INHERITED INSTEAD: the DEC-43
            evidence requirement post-dates the a3 uses, so a5 is the first
            sub-tranche whose STAY-CANONICAL claims were WRITTEN UNDER THE
            REFINED RULE. Narrower, and checkable.
            FIXED AT SOURCE: resume brief v1.7 corrects the line and records
            why, so the next successor does not inherit it a third time.
        (W3C found both; W3D verified both against the a3 ledger and by
        enumerating every disposition field; W3X 2026-08-19)

DEC-60  THE RETIRED-TREE EXCLUSION BECOMES A MECHANICAL TEST INSTEAD OF AN
        ENUMERATED LIST OF FOLDERS.
        THE RULE, as W3X ruled it 2026-08-19:
            A file is EXCLUDED from the T1 search population if ANY folder in
            its path has a name beginning "superseded" or
            "scheduled_for_deletion". Everything else in the supplied
            dev_documentation tree is IN.
        APPLIED TO THE CURRENT TREE: 519 files, 432 excluded across five
        folders - superseded/, Scopes/superseded/, T1/superseded/,
        reference/superseded_do_not_use_files_in_this_folder/ and
        reviews/scheduled_for_deletion/ - leaving a SEARCH POPULATION OF 87.
        THE ADJUDICATION POPULATION IS UNCHANGED AT 47, re-derived under the
        new rule rather than assumed to be unaffected. The 47 additionally
        excludes T1's own process artifacts (T1S00 2.0a), the pinned HolyWu
        source (2.0b) and the evidence zip (2.0c).

        WHAT WENT WRONG, AND WHY THE FIX IS A MECHANISM RATHER THAN A LONGER
        LIST. T1S00 section 2 excluded FOUR NAMED FOLDERS. T1/superseded/ did
        not exist when that list was written - it was created during the
        sweep, as T1's own artifacts were superseded - so it was never added.
        The a5 corpus manifest quoted the four-folder list verbatim and
        therefore reported a 124-file search population when the searches had
        actually run over 87. AN ENUMERATED EXCLUSION LIST STALES EVERY TIME A
        FOLDER IS RETIRED, which on this project is often.

        THE DEEPER FAULT, recorded because it is reusable: the a5 ledger's
        searches and the a5 corpus manifest implemented the same rule TWO
        DIFFERENT WAYS - one matched any path containing "/superseded/", the
        other matched four literal prefixes - and nothing checked that they
        agreed. That is precisely what charter G3 forbids in the dispatch
        mechanism, where compile target and runtime detection must derive from
        ONE mechanism with a comptime cross-check that fails the build loudly.
        The same defect, built into an evidence artifact instead of a binary.
        THE COUNTERMEASURE ADOPTED: the population is DEFINED ONCE and
        inherited. Ledger section 0.5 states it; all 39 SWEPT fields in that
        ledger refer to it rather than restating it.

        NO RE-SCAN OF ADJUDICATED STEPS IS REQUIRED, and this was checked
        rather than assumed. The prior ledgers were searched for any SWEPT
        field claiming to have searched a retired tree: none does, and
        T1S01a4 LED-025's SWEPT field already states its population as
        "excluding superseded/ and scheduled_for_deletion/". Prior practice
        therefore already matched this rule; only the written descriptions
        were inconsistent with it.

        NO a5 FINDING CHANGES. The a5 searches always ran over the 87. W3D
        additionally tested whether the disputed folder could have changed a
        result: no CURRENT-UNIQUE claim in the a5 ledger returns any hit in a
        retired tree.

        THE ACCEPTED RESIDUAL RISK IS UNCHANGED AND IS RESTATED SO IT IS NOT
        LOST: T1S00 section 5 weakness W3 already records that excluding
        retired folders by name means a document filed as superseded while
        holding the only copy of something current will not be found. DEC-60
        makes the exclusion broader and more reliable; it does not reduce W3.

        FOUND BY: W3C, on receiving the refreshed corpus, before completing
        the a5 entry review - by noticing that the manifest's table
        contradicted the manifest's own prose.
        (W3C found; W3D verified and quantified; W3X ruled 2026-08-19)

DEC-59  PROJECT STATUS v1.32 IS KNOWINGLY LEFT STALE IN TWO PLACES. THIS IS
        A RECORDED DECISION, NOT AN OVERSIGHT - DO NOT REDISCOVER IT.
        WHAT IS STALE, both created by the decisions of 2026-08-19:
          1. its section 0 says "THE FAILURE TALLY IS AT NINE (DEC-41)";
             the tally is now TEN.
          2. its section 0 says W3X "still owes an explicit confirmation
             that PR-1's block on T5 is lifted"; that confirmation was
             given at DEC-57.
        THE DECISION: W3X declines a Project Status bump for these two
        lines. The resume brief and this register carry the current state,
        and Project Status explicitly tells its reader that the resume
        brief's section 0a prevails on T1 state where the two disagree.
        WHY IT IS RECORDED RATHER THAN LEFT: an unrecorded known-stale
        statement is indistinguishable from an undiscovered one. A later
        sweep - T1S05 adjudicates Project Status - would find these two
        lines, report them as a fresh discovery, and propose a correction
        for a matter already decided. THAT IS DEC-41 INSTANCE 8 EXACTLY: an
        already-adjudicated item re-derived as a find, which invites a
        reviewer to reopen settled work.
        WHAT T1S05 MUST DO WITH THEM: record the disposition as ALREADY
        DECIDED here, and propose no correction on these two lines. Any
        OTHER stale statement in that document is still its to adjudicate
        normally.
        (W3D raised as a consequence of DEC-41 and DEC-57; W3X decided
        2026-08-19)

DEC-55  AUTHORITY SECTION 24 IS ASSIGNED TO T1S01a6. IT WAS IN NO
        SUB-TRANCHE AT ALL.
        WHAT WAS FOUND: section 24, "REFERENCES OF RECORD", occupies
        authority v1.05 lines 1717-1761 and appears in none of the declared
        sub-tranches - not a5 (sections 1-13), not a6 as DEC-53 declared it
        (sections 14-22 plus Appendices A-D), not a7 (Appendix E). Section 23
        was covered in two pieces, steps 1-5 at a2 and steps 6-10 at a4, so
        nothing swept forward into 24 either.
        HOW IT WAS FOUND, because the method is the reusable part: the
        successor designer enumerated every top-level heading in the
        authority with its line number and reconciled the heading list
        against the declared sub-tranche ranges, rather than reading the
        ranges and finding them plausible.
        WHY IT MATTERS - IT IS NOT FILLER. Section 24 carries the H.262
        provenance statement underpinning the F-series geometry facts, the
        statement that the Grid Knowledge document is superseded by this
        authority, and the statement that the README's old separated-field
        architecture does not prevail. Those are exactly the class of
        proposition T1 exists to disposition, and two of them are
        supersession claims that other documents rely on.
        THIS IS DEC-53's GAP ONE SCALE SMALLER. DEC-53 closed a hole where
        the BODY had been assigned to "later sub-tranches" nobody named.
        This is a hole where a section was assigned to nobody at all, and it
        survived the restructure that was written to find exactly this.
        DISPOSITION: section 24 joins T1S01a6.
        (W3D found; W3X 2026-08-19)

DEC-56  DECLARED SUB-TRANCHE RANGES ARE EXACT, NOT APPROXIMATE, AND DEC-53's
        WERE WRONG AT BOTH ENDS.
        THE CORRECTED RANGES, derived from the authority's own headings:
            T1S01a5   lines 223-1098    sections 1-13
            T1S01a6   lines 1099-1676   sections 14-22
                      PLUS 1717-1932    section 24 (DEC-55) and
                                        Appendices A-D
            NOT IN a6 lines 1677-1716   section 23 - steps 1-5 adjudicated
                                        at a2, steps 6-10 at a4
            T1S01a7   Appendix E entries v1.04 down to v1.00, the six owed
                      corrections, and the whole-document consistency pass
        WHAT WAS WRONG: DEC-53 said a5 was "approx. lines 216-1098". Section
        1 begins at line 223; lines 216-222 are the tail of section 0's item
        17, ALREADY ADJUDICATED AT a3. It also said a6 ran to 1678, while
        section 22 ends at 1676 and 1677 is the section 23 heading.
        WHY THIS IS A RULE AND NOT A TYPO CORRECTION: a coverage declaration
        is a TESTABLE CLAIM under DEC-50 - it must name the population
        examined in a form another party can check by counting. "Approx." in
        a coverage declaration makes the claim untestable at exactly the
        boundary where overlap and omission occur. A range that reaches back
        into adjudicated text is worse than untestable: re-adjudicating
        already-passed text is the defect that cost T1S01a4 two review rounds
        and produced DEC-48 and DEC-50 in the first place.
        WHAT a5 MUST THEREFORE DO: declare 223-1098 exactly, and state in its
        coverage declaration that 216-222 belongs to a3 and is not
        re-adjudicated here.
        (W3D found and derived; W3X 2026-08-19)

DEC-57  PR-1's BLOCK ON T5 IS CONFIRMED LIFTED, AND THIS REGISTER WAS THE
        DOCUMENT IN ERROR.
        THE CONTRADICTION: the designer introduction stated "T5 is NOT
        BLOCKED by PR-1 any more (DEC-24, W3X confirmed 2026-08-18)", while
        DEC-24 and DEC-54 in this register recorded the confirmation as still
        outstanding. Two live documents disagreed, and the one a cold
        successor reads FIRST was the introduction.
        THE RULING: W3X confirms the block IS lifted, and rules that the
        introduction was correct in substance - the confirmation had been
        given and this register failed to record it. The register is
        therefore corrected at DEC-24 and DEC-54; the introduction is NOT
        touched.
        WHAT DOES NOT CHANGE: T5 remains sequenced AFTER T1 (DEC-02), and T6
        after T5 as a separate ratification (DEC-03). Unblocked is not next.
        WHY IT IS RECORDED RATHER THAN QUIETLY FIXED: an ungiven confirmation
        and an unrecorded one look identical from inside the register, and
        the difference decides whether the successor may rely on the
        introduction. It is now on the record which way it went.
        (W3D raised the contradiction; W3X ruled 2026-08-19)

DEC-58  A DANGLING REFERENCE OF RECORD IN THE AUTHORITY IS REGISTERED AS AN
        OPEN ITEM FOR T1S01a6.
        THE FINDING: authority v1.05 section 24 reference R8 names
        `Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md` and
        describes it as the independent external-verification record. NO FILE
        OF THAT NAME EXISTS ANYWHERE IN THE SUPPLIED DOCUMENTATION TREE.
        BASIS FOR THAT CLAIM, recorded per DEC-50 so it can be tested: a
        filename search of the whole tree for the pattern
        `*W3C_Verification_and_Design_Review*` returned nothing, and a
        content search for the string returned only the authority's own
        generations v1.00 through v1.05.
        W3X's PLAUSIBLE REFERENT, EXPLICITLY UNVERIFIED:
            Scopes/Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md
        It is recorded as a candidate to test, NOT as the answer. T1S01a6
        must either establish the referent by content comparison or record
        that the reference cannot be resolved and propose a disposition.
        WHY IT MATTERS: a reference of record is a provenance claim. An
        unresolvable one in the document the project treats as its single
        source of truth is the kind of thing that reads as verified for years.
        (W3D found; W3X registered and supplied the candidate referent
        2026-08-19)

DEC-38  STAY-CANONICAL IS RATIFIED AS A THIRD DUPLICATE-ACTION VALUE, AND THE
        I7 PROVENANCE RUNS THE OPPOSITE WAY TO DEC-36.
        THE GAP: the RETAIN-SUMMARY rule ratified at DEC-36 already said a
        copy that IS the canonical home simply stays - but the action
        vocabulary offered only RETAIN-SUMMARY and POINTER, both of which
        describe NON-canonical copies. The commonest case had no label. In
        the first ledger written under the rule, two entries were therefore
        marked with an exception they did not need, and the count of entries
        genuinely relying on the exception read as nine when it is seven.
        THE RULE, at review scope v1.10 sections 5.4 and 5.4a:
            STAY-CANONICAL   this copy IS the canonical home; it stays
                             because it is canonical, not by exception
            RETAIN-SUMMARY   not canonical, but earns the narrow exception
            POINTER          not canonical, and does not earn it
        No sixth DISPOSITION is created. The five are untouched.
        WHAT W3D ADDED AS VERIFIER, and why it is not cosmetic: an entry
        claiming STAY-CANONICAL must NAME WHERE THE NON-CANONICAL COPIES ARE.
        Every other action carries a test - RETAIN-SUMMARY must clear three
        conditions, POINTER follows from failing them. Without the naming
        requirement STAY-CANONICAL would be the only action established by
        ASSERTION, and would become the easy answer, which is exactly the
        failure mode W3C itself warned about for RETAIN-SUMMARY. An entry
        that cannot say where the other copies live has not shown the
        statement is a duplicate at all.
        I7 PROVENANCE: W3C proposed; W3D independently verified against the
        scope text and strengthened; W3X ratified. DEC-36 ran W3D-proposes /
        W3C-verifies; this one runs the other way. Both directions work, and
        that is the point of the rule.
        (W3C T1S01a3_B v1.1 Q1; W3D verified; W3X 2026-08-18)

DEC-39  T1S01a3 IS CORRECTED AT v1.3 AND T1S01a2 IS NOT REOPENED.
        WHAT W3C PASSED, having tested rather than agreed: the coverage
        declaration; all seven genuine RETAIN-SUMMARY uses, each checked
        against the three conditions separately; the new per-proposition
        canonical homes; the two changed dispositions; the swept fields; and
        the uniformity of LED-013 to LED-019, which it checked by sampling
        propositions across seven subject areas rather than by inspection.
        THREE CORRECTIONS APPLIED AT LEDGER v1.3:
          (a) LED-020 and LED-021 relabelled STAY-CANONICAL per DEC-38;
          (b) LED-020 SPLIT under the atomic-claim rule. It carried two
              propositions with two different canonical homes and two
              different actions - the authority-status declaration, whose
              home is the header, and what the v1.05 revision did, whose home
              is Appendix E. Mapping them per proposition inside one entry is
              not a substitute for splitting; the new entry is LED-020a;
          (c) LED-013 item 2: the RETIREMENT IN PRINCIPLE of
              `mpeg2_field_separated` now maps to D4-Q16 as well as the token
              spelling. Verified cold: the authority's own D4-Q16 text says no
              public name should invite SeparateFields input, which IS that
              retirement.
        T1S01a2 IS NOT REOPENED. W3C spot-checked the v1.1 reissue against the
        defect that caused it and passed it: the declaration is narrowed to
        what it actually adjudicates and every omission is assigned onward.
        Old-format duplicate entries are reconciled at T1S01a7's whole-document
        consistency pass rather than by reopening a passed ledger for
        formatting.
        (ROUTING CORRECTED 2026-08-19: DEC-53 moved the whole-document
        consistency pass from T1S01a5 to T1S01a7. Corrected here rather than
        annotated elsewhere, because a later decision does not make an
        earlier decision's still-live wording safe to follow. See DEC-51.)
        (W3C T1S01a3_B v1.1; W3X 2026-08-18)

DEC-40  TWO SMALL PRACTICES, RECORDED BECAUSE THEY WERE BEING FOLLOWED
        WITHOUT BEING WRITTEN DOWN.
        (a) A REISSUED STEP PACKAGE TAKES A ZIP-LEVEL VERSION SUFFIX and the
            superseded zip moves to superseded/. The review scope's literal
            form keeps one zip name per step and bumps versions inside; T1S00
            went through five suffixed zips without anyone recording the
            deviation. Two identically-named zips in play is a hand-error
            waiting to happen for whoever moves the files, and the coder's
            copy would be indistinguishable from one already reviewed.
        (b) A REISSUE THAT LEAVES A REGION UNCHANGED PROVES IT rather than
            asserting it. Ledger v1.2 declared its entry block byte-identical
            to v1.1; W3C relied on that and reviewed only the changed section,
            saying so. That converted a repeat review into a focused one. Any
            future reissue that touches part of a document should state the
            unchanged region and how the identity was established.
        (W3D; W3X 2026-08-18)

DEC-48  A CLAIM THAT A CHECK WAS PERFORMED MUST NAME WHAT WAS EXAMINED, IN
        THE SAME BREATH, OR IT MUST NOT BE WRITTEN.
        WHAT HAPPENED: T1S01a4 ledger v1.1's coverage declaration stated that
        the ledger set had been swept for overlap and that the overlap was
        excluded rather than re-derived. The statement was FALSE. T1S01a2
        LED-010 already adjudicated authority lines 1703-1710, and the a4
        ledger re-adjudicated the same text at LED-031 and LED-032. W3C found
        it.
        WHY THIS IS ITS OWN RULE AND NOT ANOTHER DEC-41 LINE: the sweep
        failure at DEC-41 instance 8 was an omission. This is an ASSERTION.
        A false assurance is worse than a missing one, because it tells the
        next reader not to check. The a4 declaration was itself the
        countermeasure adopted after instance 8 - so the countermeasure was
        written, and then not performed, and the writing was mistaken for the
        performing.
        THE UNDERLYING PATTERN, stated because it is the same in all three of
        W3D's recent failures: THE INTENTION TO CHECK IS RECORDED AS THE
        CHECK. A claim phrased as "the set was swept" is unfalsifiable by the
        reader and unmemorable to the author.
        THE RULE: an entry, section or covering note that claims a check was
        done must NAME the items examined - document, section or entry
        identifier, and range - so the claim can be tested by counting. A
        claim that cannot be tested that way is not written at all.
        FIRST APPLICATION: a4 ledger v1.2's section 0 lists every T1S01a2
        entry with its range and the comparison result, including the one that
        overlaps. Had that form been used in v1.1, LED-010 would either have
        appeared or its absence would have been visible.
        (W3C found the defect; W3D derived the rule; W3X 2026-08-18)

DEC-49  T1S01a4's TECHNICAL CORE IS CONFIRMED BY W3C; THE SUB-TRANCHE IS
        REISSUED NARROWLY RATHER THAN RESTARTED.
        CONFIRMED BY INDEPENDENT REVIEW:
          - the section 23 ordering conflict is real;
          - the candidate-before-comparison / accepted-oracle-after-winner
            repair is sound at its core (DEC-45 stands), REFINED to two ROLES
            and two ACCEPTANCE STATES rather than two permanent separately
            implemented codebases. The winning candidate does not become the
            oracle by winning; whether 8b reuses its code is a later scoping
            question;
          - DEC-47 IS DISCHARGED. W3C's explicit verdict: the
            two-senses-of-freeze reading HOLDS and its earlier threshold
            warning is DISSOLVED - subject to a constraint W3D had not stated,
            that if step 9 revises any value section 14.4 required to be held
            fixed, the comparison evidence is stale and the affected
            comparison is rerun;
          - DEC-46's acceptance gap is confirmed REAL, correctly left open,
            and correctly scoped: it blocks the 8a candidate scope, not T1.
            W3C also agrees W3D should not author and self-verify that future
            criterion.
        CORRECTED AT LEDGER v1.2, all on W3C's findings: LED-031 and LED-032
        withdrawn as duplicate adjudication; the adjudicated range narrowed to
        lines 1694-1700; LED-025's unaffectedness claim given its own sweep;
        the canonical home for the oracle acceptance rule corrected to the
        CHARTER with Tiering Decisions 20.2 as the detailed record; charter G5
        removed from a copy list as the wrong rule; and the roadmap
        three-way-disagreement claim WITHDRAWN as overstated - the roadmap's
        2D/3D split is compatible with the repair, not contrary to it. The
        ordering conflict stands without it.
        T1S01a5 DOES NOT BEGIN until the narrow reissue is checked, so that
        the sub-tranches after a4 inherit a clean a4.
        (DISCHARGED 2026-08-19: the reissue was checked and T1S01a4 closed at
        DEC-52. The original wording also gave the reason as "a5 is the final
        cross-entry consistency pass", which DEC-53 had already moved to a7;
        the instruction was right and its stated reason was stale.)
        (W3C T1S01a4_B v1.0; W3D reissued; W3X 2026-08-18)

DEC-53  THE T1S01a SUB-TRANCHE STRUCTURE IS RESTRUCTURED: THE BODY GETS TWO
        NAMED SUB-TRANCHES, AND THE FINAL PASS MOVES TO T1S01a7.
        THE GAP THIS CLOSES: T1S01a3's coverage declaration assigned
        "sections 1-22 and Appendices A-D -> later sub-tranches of T1S01a"
        WITHOUT NAMING THEM, and no later sub-tranche picked the body up. That
        is roughly 1,600 lines and the bulk of the manifest's 1,114 hits - the
        geometry facts, architecture mathematics, rejection proofs, the D4
        issue register and Appendix D. Running the whole-document consistency
        pass with the body unadjudicated would check consistency over a
        document most of which was never swept, and LED-023's deferred
        provenance claim could never be confirmed, only qualified.
        THE STRUCTURE, declared under the manifest's split-and-report
        provision (T1S00 v1.4 section on T1S01):
            T1S01a5  BODY PART 1 - sections 1-13 (stated here as "approx.
                     lines 216-1098"; RANGE CORRECTED to EXACTLY 223-1098 at
                     DEC-56 - section 1 begins at line 223 and 216-222 is
                     section 0's tail, adjudicated at a3):
                     geometry facts, prior art, GAIS calibration rule,
                     architecture options and re-decision, B2 topology
                     mathematics, Architecture D, the A rejection record,
                     section 13 retained rules. Includes re-adjudication of
                     the PR-1/PR-2 home sections (12.5, 13.1, 9.1)
                     consistently with DEC-24/DEC-25.
            T1S01a6  BODY PART 2 - sections 14-22 (stated here as "approx.
                     lines 1099-1678"; RANGE CORRECTED to EXACTLY 1099-1676
                     at DEC-56) plus Appendices A-D: schedules, Q14
                     experiment, D4 issue register, quality gates,
                     open-mathematics list. EXTENDED at DEC-55 to include
                     SECTION 24, lines 1717-1761, which this structure left
                     in no sub-tranche at all.
            T1S01a7  FINAL SUB-TRANCHE of the authority, and DECLARED AS
                     FINAL per the manifest rule: Appendix E entries v1.04
                     down to v1.00 (the v1.05 entry stays with LED-012);
                     the LED-023 provenance-claim discharge; the six owed
                     corrections (LED-023, a2 old-format entries,
                     LED-020/021 copy-list phrasing, LED-010 range and
                     atomicity, LED-004 range); and the whole-document
                     cross-entry consistency pass, which happens THERE AND
                     NOWHERE EARLIER.
        LED-023 GROUNDWORK, held as recorded evidence for a7 per W3X: the
        provenance-tag census across the authority finds twenty tagged claims
        (6 H.262-VERIFIED, 6 DERIVED, 3 MEASURED, 5 W3X-RATIFIED) and every
        GAIS mention is the discipline rule itself, an explicit refutation,
        or a corrected-details note. Necessary but not sufficient: the
        untagged body assertions are checked by a5/a6, which is what makes
        the a7 discharge possible.
        (W3D raised; W3X 2026-08-18)

DEC-54  T1S01a1 IS CLOSED BY DECISION, NOT BY REISSUE - ASCERTAINED FROM THE
        RECORD RATHER THAN ASSUMED.
        THE QUESTION: W3C rejected both a1 entries and no reissued a1 ledger
        exists, so was the first sub-tranche left open?
        THE ANSWER, verified against this register: NO. Both pre-registered
        items were resolved at register level and W3X-ratified on 2026-08-18:
            PR-1 -> DEC-24. The narrower core stands; section 13.1 already
                    holds the general principle; 12.5 uniquely holds the
                    PROOF. The pre-registered items list marks PR-1 RESOLVED.
            PR-2 -> DEC-25. Not ratified as a standing rule; Architecture A's
                    behaviour preserved as history; the coupling question
                    recorded OPEN under D4-Q02/D4-Q05. Marked RESOLVED.
        WHAT REMAINS OWED, and where it goes:
            1. DEC-24's LIKELY REMEDY - leave the proof at 12.5, add a
               pointer from 13.1 - was recorded "to be re-derived rather
               than inherited". That re-derivation folds into T1S01a5, which
               adjudicates sections 12 and 13 anyway.
            2. DEC-24's "W3X TO CONFIRM the T5 block is lifted" - DISCHARGED
               2026-08-19 at DEC-57. W3X confirmed the block IS lifted and
               ruled that the designer introduction, which had recorded the
               confirmation as already given, was correct in substance and
               this register was wrong to record it as outstanding.
        NO REISSUED a1 LEDGER IS NEEDED. The entries' subject matter is
        re-adjudicated at a5 under the current rules, consistently with
        DEC-24/DEC-25, which prevail as ratified decisions.
        (W3D ascertained from DEC-24/25 and the pre-registered items list;
        W3X 2026-08-18)

DEC-52  T1S01a4 IS CLOSED, PROVISIONALLY, ON W3C's RECOMMENDATION.
        W3C finds no remaining technical, ledger-entry or live-framing defect.
        It did not restate its earlier conclusions but re-verified them, and it
        did not accept W3D's enumeration - it ran its own search across all
        four batch documents, checked seven semantic variants beyond the
        literal wording family, and found no live stale premise.
        WHAT IS SETTLED FROM W3C's SIDE:
          - the section 23 ordering conflict is real;
          - the candidate role must precede the SA/SB comparison and the
            accepted ReleaseSafe-oracle role follows the schedule and
            canonical freeze - two ROLES, two ACCEPTANCE STATES, NO
            different-object-identity requirement established;
          - the two-senses-of-freeze reading holds and the earlier threshold
            warning is dissolved, subject to the rerun constraint;
          - the DEC-46 acceptance gap is real, remains OPEN, and blocks a
            future 8a candidate-building scope rather than T1.
        CLOSURE IS PROVISIONAL: T1S01a7's whole-document cross-entry
        consistency pass may reopen any entry.
        (ROUTING CORRECTED 2026-08-19: DEC-53 moved the whole-document
        consistency pass from T1S01a5 to T1S01a7. Corrected here rather than
        annotated elsewhere, because a later decision does not make an
        earlier decision's still-live wording safe to follow. See DEC-51.)
        THE COST, RECORDED HONESTLY BECAUSE THE VERSION NUMBERS MISLEAD: five
        ledger versions and four W3C review rounds. The TECHNICAL result was
        substantially right at v1.0 and survived every round. Rounds two,
        three and four were spent on W3D's own method and framing defects -
        a false sweep assurance, an inaccurate enumeration, and three
        successive partial replacements. W3C found every one.
        (W3C T1S01a4_B v1.3; W3X 2026-08-18)

DEC-51  PARTIAL REPLACEMENT IS ITS OWN FAILURE MODE, AND THE COUNTERMEASURE
        IS A DECLARED-SCOPE CHECK RATHER THAN A COMPLETION REPORT.
        REFINED WORDING RATIFIED 2026-08-18, in W3C's wording. W3D's original
        said "search the whole document set and enumerate every occurrence".
        W3C's objection is not about phrasing: THE OBJECT OF PROOF IS THE
        REJECTED PROPOSITION WITHIN A DECLARED SCOPE, NOT THE STRING. A
        literal search can produce a complete list of the terms it happened to
        look for while the rejected proposition survives in a paraphrase, and
        the author reports a pass because the count reconciles - the original
        failure in a more elaborate format.

        THE RULE - PARTIAL-REPLACEMENT CHECK:
          After replacing a materially rejected formulation, do not report the
          replacement complete from the edited location alone.
          1. DECLARE THE REPLACEMENT SCOPE: identify the current document,
             package, authority set or other bounded population in which the
             rejected proposition could still remain live.
          2. SEARCH USING THE METHOD APPROPRIATE TO THE PROPOSITION: the
             rejected wording and obvious lexical variants where useful, AND
             semantic inspection of live framing where a paraphrase could
             preserve the rejected proposition without its exact words.
          3. ENUMERATE AND CLASSIFY THE CANDIDATE MATCHES: each match and
             location recorded as LIVE, HISTORICAL/META, or FALSE/IRRELEVANT,
             so an omission or misclassification can be attacked.
          4. CLAIM NO EXHAUSTIVENESS BEYOND THE DECLARED SCOPE OR METHOD. A
             literal search proves only what that search can prove. A
             project-wide completion claim requires a project-wide declared
             scope and search.
          5. A BARE ASSURANCE - "the replacement was swept", "all occurrences
             were fixed" - IS NOT EVIDENCE.

        THE PATTERN IT ANSWERS, three consecutive occurrences, each caught by
        W3C and none by its author:
          1. T1S01a3 v1.1 rewrote its entries and left the closing section
             arguing the pre-reissue position, asking W3C to reopen two
             ratified decisions;
          2. T1S01a4 v1.2 added the accepted two-ROLE refinement and left the
             rejected two-ARTIFACT premise live above it, in DEC-45, and in
             the covering note;
          3. T1S01a4 v1.3 corrected section 0's population and LED-025's
             sweep, then asked W3C to verify BOTH of the formulations the same
             document had just withdrawn.
        WHY IT KEEPS HAPPENING: the author's attention is on the field being
        corrected. Making the correction FEELS like completing the work, and
        the surrounding framing, written under the old belief, reads as
        familiar rather than as wrong. Each time the correction itself was
        right and was reported as complete.
        WHY IT MATTERS MORE THAN A TYPO: the stale framing is usually the part
        that TELLS THE READER WHAT TO THINK - a closing section, a status
        paragraph, a covering note. A reviewer answering it in good faith
        produces findings that contradict the correction.

        TWO THINGS THE FIRST APPLICATION DEMONSTRATED, both recorded because
        they are the evidence for the rule rather than against it:
          - W3D's first enumeration was written from MEMORY of which places
            had been edited. It listed five occurrences; the search found
            seven. It was corrected before issue. An enumeration written from
            recollection is the same assurance in a longer form; the
            distinction that matters is SEARCHING versus REMEMBERING.
          - W3D's enumeration was LEDGER-LOCAL while W3D's own rule said
            whole document set. W3C found the mismatch and supplied the
            missing whole-batch check itself. HAD THE SCOPE BEEN DECLARED, AS
            THE REFINED RULE NOW REQUIRES, THE MISMATCH WOULD HAVE BEEN
            VISIBLE TO ITS AUTHOR. That is the refinement earning its place.

        RELATION TO DEC-50: same form, different check. DEC-50 governs a check
        used as EVIDENCE; this governs a replacement reported as COMPLETE.
        Both replace an assurance with something falsifiable, and both were
        proposed too rigidly by W3D and narrowed by W3C for the same reason -
        a mandatory form becomes the evidence.

        I7 PROVENANCE, recorded distinctly because the rule judges W3D's own
        deliverables and W3D proposed it:
            proposer:  W3D, derived from W3C's three partial-replacement
                       findings
            verifier:  W3C - ACCEPT IN PRINCIPLE WITH THE REFINEMENT ABOVE,
                       supplied after an independent whole-batch search that
                       did not take W3D's enumeration on trust
            ratifier:  W3X, 2026-08-18, on the refined wording
        THIS IS THE THIRD RULE IN THIS SUB-TRANCHE TO ARRIVE W3D-PROPOSED AND
        LEAVE W3C-IMPROVED, after the RETAIN-SUMMARY/STAY-CANONICAL evidence
        requirement and DEC-50. In each case W3X ratification alone would have
        left the I7 hole open.

DEC-50  DEC-48 IS REFINED IN W3C's WORDING, AND ITS FIRST APPLICATION FAILED
        IN A WAY THAT PROVES THE RULE RATHER THAN THE OPPOSITE.
        THE REFINEMENT, adopted. DEC-48 was written globally - name the items,
        the ranges, test by counting. W3C's verification: the principle is
        right but the wording is too broad for a universal criterion, because
        not every legitimate check has a natural range or is tested by
        counting - byte-identity checks, hash checks, build checks, source
        searches and whole-document semantic comparisons do not. The refined
        rule, in W3C's wording:
            A claim that a check was performed must identify the actual
            OBJECT OR POPULATION examined AND the result or basis, in a form
            that makes the claim independently testable.
            For a bounded set, range, overlap or coverage check: ENUMERATE
            the population and record each member's relevant range or result,
            so that an omission is visible.
            For other checks: record the identifiers and the method or basis
            appropriate to that check. DO NOT INVENT A LINE RANGE WHERE NO
            NATURAL RANGE EXISTS.
            A bare assurance such as "the set was swept" is not evidence and
            must not be written as though the check were demonstrated.
        This keeps the strength and removes the ritual - the failure mode
        where an author attaches an artificial range to a check that is not a
        range check, and the form becomes the evidence.
        I7 PROVENANCE: W3D proposed, derived from W3C's method finding; W3C
        verified - ACCEPT IN PRINCIPLE WITH THE REFINEMENT ABOVE; W3X
        ratified 2026-08-18 on the refined wording.
        THE FIRST APPLICATION WAS WRONG, AND THAT IS THE EVIDENCE FOR THE
        RULE. a4 ledger v1.2's enumeration called its population "every
        T1S01a2 entry" and then listed LED-001 and LED-002, which belong to
        T1S01a1 and adjudicate the pre-registered items rather than currency
        statements - wrong ledger, wrong subject. It also recorded LED-004 as
        outside the a4 range when LED-004's RECORDED range ends at line 1694,
        which IS step 6.
        BOTH WERE VISIBLE ONLY BECAUSE THE LIST EXISTED TO BE COUNTED. The
        assurance it replaced would have produced neither finding. A
        countermeasure that fails visibly on first use is working; the one it
        replaced failed invisibly for two sub-tranches.
        A SECOND T1S01a2 RANGE-RECORDING DEFECT IS THEREFORE OWED TO T1S01a7:
            LED-004  recorded 1683-1694; propositions are steps 1-5, ending
                     1693; line 1694 is step 6 and belongs to a4 LED-025.
            (alongside LED-010, recorded 1703-1710, sentence runs to 1713.)
        Neither is duplicate adjudication. Both are recording defects.
        (ROUTING CORRECTED 2026-08-19: DEC-53 moved the whole-document
        consistency pass from T1S01a5 to T1S01a7. Corrected here rather than
        annotated elsewhere, because a later decision does not make an
        earlier decision's still-live wording safe to follow. See DEC-51.)
        (W3C found and verified; W3D applied; W3X 2026-08-18)

DEC-45  THE TWO-ROLE / TWO-ACCEPTANCE-STATE ORDERING REPAIR IS PROVISIONALLY
        ADOPTED, SUBJECT TO W3C. It is NOT ratified and must not be cited as
        settled.
        WORDING CORRECTED 2026-08-18. This decision was recorded as the
        "two-artifact" repair and said step 8 "names ONE artifact where the
        project needs TWO". W3C accepted the separation of ROLES and
        ACCEPTANCE STATES and expressly declined to establish the stronger
        two-implementations proposition. DEC-49 recorded that refinement, but
        a later corrective entry does not make an earlier decision's still-
        live wording safe to ratify by reference - so the wording is fixed
        here rather than annotated. W3C found this.
        THE DEFECT (DEC-32, now adjudicated at T1S01a4 LED-029): section 23
        builds the ReleaseSafe scalar oracle at step 8 and decides the
        Schedule-SA/SB winner at step 9, while authority line 1153 says the
        winner becomes part of that oracle, and Verification and Tiering
        Decisions section 20.2 lists SCHEDULE among the independently
        authored obligations the oracle-construction scope is accepted
        AGAINST. Under the ratified acceptance rule the schedule is an INPUT
        to that scope. A scope cannot be accepted against an obligation the
        next step is scheduled to decide.
        THE REPAIR: the fault is NOT the order of the two steps. Step 8
        CONFLATES TWO ROLES AND TWO ACCEPTANCE STATES - a comparison
        candidate, which is not an accepted oracle, and the accepted
        ReleaseSafe oracle. What is proved is the separation of STATUS AND
        ACCEPTANCE BASIS, not object identity: the same implementation may
        be reused, refactored or hardened across both roles, and the project
        does not require two persistent implementation artifacts.
            8a  author the scalar obligations and build the scalar CANDIDATE
                implementations of Schedule-SA and Schedule-SB needed to run
                section 14.4's comparison. Comparison instruments. NOT the
                accepted oracle, and they do not become it by surviving.
            9   run the comparison and the quality decisions; freeze the
                canonical scalar algorithm, schedule included.
            8b  build and accept the independent ReleaseSafe scalar oracle
                under section 20.2, with the frozen schedule now available as
                an authored obligation.
        WHY NOT A BARE SWAP OF 8 AND 9: section 14.4 requires SA and SB to be
        compared in scalar FORM with only order differing, so scalar
        implementations must exist before the comparison can run at all. W3C
        declined to propose a swap for exactly this reason. A swap would
        schedule a comparison before anything existed to compare - a worse
        defect than the one it fixes.
        WHERE IT IS RECORDED IF RATIFIED: the STANDING TASK REGISTER, not the
        authority - consistent with DEC-32's treatment of the head of the
        same list, and with the authority's own single-source rule placing
        work-queue sequencing outside its domain.
        STATUS: W3X provisionally adopts, SUBJECT TO W3C's independent
        review at T1S01a4. The repair is DERIVED DESIGNER REASONING resting
        on a distinction the ratified text does not itself draw explicitly:
        the COMPARISON-CANDIDATE ROLE and the ACCEPTED-ORACLE ROLE have
        different acceptance states and must occur at different points in
        the sequence. THIS DOES NOT ESTABLISH DIFFERENT OBJECT IDENTITY. If
        W3C refutes that roles-and-acceptance-states distinction, the
        provisional adoption falls and the defect needs a different answer.
        (CORRECTED 2026-08-18: this paragraph still rested on the rejected
        "different artifacts" premise after the rest of the decision had
        been corrected. W3C found it. See DEC-51.)
        (W3D derived; W3X provisionally adopted 2026-08-18; W3C review owed)

DEC-46  AN ACCEPTANCE GAP IS REGISTERED AS OPEN AND OWED TO THE VERIFICATION
        AND TIERING DECISIONS DOCUMENT. It is not closed here and must not be
        allowed to lapse by silence.
        THE GAP, exposed by DEC-45's repair and invisible without it: the
        scalar candidate implementations at 8a PRODUCE PIXELS but are NOT the
        oracle. Section 20.2's construction exception is written for "the
        FIRST bounded scope that constructs a filter's ReleaseSafe scalar
        oracle", which 8a is not; and section 20.1's differential rule has no
        accepted oracle to measure them against, because 8b has not happened
        yet. WHAT ACCEPTS 8a IS THEREFORE UNSPECIFIED.
        WHY IT IS LEFT OPEN DELIBERATELY: writing that acceptance basis would
        be W3D authoring the criteria that will judge W3D's own future
        deliverable, which charter I7 exists to prevent, and it is not needed
        until the candidates are actually scoped.
        WHEN IT MUST BE CLOSED: before any scope that builds a scalar
        candidate is issued. It is a blocker on 8a, not on T1.
        (W3D raised; W3X registered open 2026-08-18)

DEC-47  THE TWO-SENSES-OF-FREEZE QUESTION REQUIRES AN EXPLICIT W3C VERDICT
        AND MUST NOT BE LET SLIDE.
        THE QUESTION: section 23 step 7 says "derive/freeze" the kernel
        mathematics, thresholds and footprints; step 9 says "freeze the
        canonical scalar algorithm". Both cannot be canonical freezes - if
        step 7 froze them canonically, step 9 has nothing left to freeze; if
        step 9 may revise them, step 7's freeze is provisional.
        W3D'S READING: step 7 fixes a CANDIDATE algorithm, held constant so
        that section 14.4's comparison is controlled - 14.4 positively
        REQUIRES identical thresholds and formulas across SA and SB - and
        step 9 freezes the CANONICAL one afterwards. On that reading W3C's
        earlier warning dissolves: Appendix D lists thresholds as unresolved
        because that describes TODAY, and step 7 is the step that changes it.
        WHY THIS IS FLAGGED RATHER THAN CARRIED: if W3D's reading is wrong,
        there is a LIVE second defect in step 7, and it would be easy for
        that to disappear because the reader was looking at LED-029. It is
        W3D's own argument, dissolving a warning raised against W3D's own
        area, which is precisely the shape that needs a different party.
        DISCHARGE CONDITION: a W3C verdict that states plainly either that
        the two-senses reading holds and the warning is dissolved, or that it
        does not and the step 7 defect is live. SILENCE DOES NOT DISCHARGE
        IT - see DEC-44. If the T1S01a4 response does not answer it, it is
        re-asked, and it stays open until answered.
        (W3C raised the original warning; W3D derived the resolution; W3X
        flagged it must-answer 2026-08-18)

DEC-42  T1S01a3 IS CLOSED, PROVISIONALLY, ON W3C's RECOMMENDATION.
        W3C reviewed the v4 batch and reported the outstanding findings
        resolved sufficiently to proceed, with no W3C hold on T1S01a4. It
        adjudicated LED-020a independently - the only entry no other party had
        seen - and reached the POINTER conclusion by its own route: the
        authority header is not the designated read-first summary layer, so
        the narrow exception does not reach that proposition. It also
        confirmed the named non-canonical copies genuinely exist in the
        corpus.
        CLOSURE IS PROVISIONAL in the ordinary way: T1S01a7's whole-document
        cross-entry consistency pass may reopen any entry.
        (ROUTING CORRECTED 2026-08-19: DEC-53 moved the whole-document
        consistency pass from T1S01a5 to T1S01a7. Corrected here rather than
        annotated elsewhere, because a later decision does not make an
        earlier decision's still-live wording safe to follow. See DEC-51.)
        W3C was careful to say it claims neither a project PASS nor an
        authority amendment, and it held that line unprompted. Correct.
        (W3C T1S01a3_B v1.2; W3X 2026-08-18)

DEC-43  THE STAY-CANONICAL EVIDENCE REQUIREMENT IS REFINED, AND ITS I7 CHAIN
        IS NOW COMPLETE. It was not complete when DEC-38 was recorded.
        WHAT DEC-38 GOT WRONG: it recorded ONE provenance chain for a rule
        with TWO parts. The STAY-CANONICAL ACTION was proposed by W3C and
        verified by W3D - sound. The EVIDENCE REQUIREMENT was W3D's own
        addition, and it had no different-party verifier. W3D cannot verify a
        criterion applied to W3D's own ledger, and W3X ratification is not a
        different-party check. Recording both parts as one chain hid that.
        HOW IT WAS FOUND: W3D flagged that W3C's clearance response had not
        answered the covering note's explicit invitation to attack the
        addition. W3X put the question to W3C directly. W3C confirmed the
        diagnosis and supplied the missing verification.
        THE REFINED RULE, at review scope v1.11 section 5.4a: an entry
        claiming STAY-CANONICAL must name AT LEAST ONE concrete non-canonical
        copy and its location; it SHOULD record others found by the sweep; it
        MUST NOT imply exhaustiveness without a recorded sweep.
        WHY THE REFINEMENT IS BETTER, and it is: one located copy is
        logically sufficient to establish duplication, while W3D's "name
        where the non-canonical copies are" reads as a completeness claim.
        That would have put a coverage assertion in the ACTION field with no
        search behind it - and the SWEPT field is precisely where coverage
        claims belong, because that is where they can be attacked. This
        project has already had to withdraw one inadequate coverage claim.
        LED-020 AND LED-021 DO NOT SATISFY THE REFINED WORDING. Both use the
        definite article - "the non-canonical copies" - and one has its SWEPT
        field expressly withdrawn, so no sweep backs the implied list.
        THEY ARE NOT REOPENED. The correct phrasing is stated in the scope so
        T1S01a4 uses it from the start, and the two entries are carried as a
        NAMED ITEM for T1S01a7's consistency pass - the same treatment
        already ratified for T1S01a2's old-format entries at DEC-39. Severity
        is low: the withdrawn sweep is visible in the entry, so no reader
        could take exhaustiveness as established.
        (ROUTING CORRECTED 2026-08-19: DEC-53 moved the whole-document
        consistency pass from T1S01a5 to T1S01a7. Corrected here rather than
        annotated elsewhere, because a later decision does not make an
        earlier decision's still-live wording safe to follow. See DEC-51.)
        (W3D proposed; W3C verified with refinement; W3X 2026-08-18)

DEC-44  A SECOND FAILURE MODE IS NOW ON THE RECORD, DISTINCT FROM DEC-41's.
        COMPLIANCE MISTAKEN FOR VERIFICATION. Asked to review a package
        containing a NEW criterion, W3C went and complied with it - it checked
        that the named copies existed - and reported the matter resolved. It
        had not asked whether the criterion itself was justified. Compliance
        and verification look identical from the inside: both involve doing
        the work the new rule demands, and both end with the reviewer
        satisfied.
        WHY IT IS NOT ANOTHER DEC-41 INSTANCE: DEC-41's instances are all
        failures to sweep the whole artifact, and their countermeasure is to
        finish an edit by sweeping the file. This is a different thing with a
        different countermeasure, and filing it under DEC-41 would bury it.
        THE RULE THAT FOLLOWS: WHEN A PACKAGE EXPLICITLY INVITES THE REVIEWER
        TO ATTACK A CRITERION, THE RESPONSE MUST ANSWER THAT INVITATION -
        even if only to say it accepts the criterion and why. Silence on an
        explicit invitation must not be read by anyone as acceptance.
        WHO CAUGHT WHAT, recorded accurately because the three-way process is
        the thing being evidenced: W3D noticed the invitation had gone
        unanswered and that its own addition was therefore unverified; W3X
        put the question to W3C rather than letting it be carried as an open
        item; W3C then supplied a verification that IMPROVED the rule rather
        than endorsing it. Each leg did something neither of the others did.
        (W3D, W3C, W3X; 2026-08-18)

DEC-41  THE FAILURE TALLY IS NOW ELEVEN, AND THE LAST EIGHT POST-DATE THE
        COUNTERMEASURES. Recorded as a prediction, not a history.
            1. claimed a section was the UNIQUE home of a principle -> the
               same document already stated it three sections later;
            2. claimed two design decisions were INDEPENDENT -> one shipped
               control moves both;
            3. claimed a list's tail was UNAFFECTED -> the same document
               contradicts the order;
            4. proposed a rule, wrote that it must not be applied yet, and
               had already applied it seven times;
            5. reissued a ledger and left its closing section arguing the
               pre-reissue position;
            6. fixed two stale sections of the designer introduction and left
               the section that is read FIRST, having personally written the
               line about the defect rarely being alone in between;
            7. corrected the disposition of two entries and left the count of
               those entries stale two hundred lines away in the same file;
            8. swept the authority, found a stale sequencing sentence in
               Appendix E, reported it as a fresh find and proposed an
               authority correction -> IT WAS ALREADY ADJUDICATED at LED-012
               and LED-003 in T1S01a2, a ledger W3C had already passed, and
               LED-012's PROPOSED ACTION IS 'NONE - DO NOT TOUCH';
            9. wrote INTO THE NEXT LEDGER that the ledger set had been swept
               for exactly that overlap - and it had not. T1S01a2 LED-010
               was missed and its text re-adjudicated twice. The
               countermeasure adopted after instance 8 was written down and
               then not performed. See DEC-48;
           10. added a NINTH instance to this very list and left the heading
               saying EIGHT, together with three prose sentences reasoning
               about "the eight" - so the decision that records the failure
               tally committed the failure it records. Found 2026-08-19 by a
               successor designer during orientation, by counting the list
               against its own heading. Project Status v1.32 had the count
               right at nine, so the two live documents disagreed.
               THIS IS DEC-51's FAILURE MODE EXACTLY: the author's attention
               was on the field being corrected - the list - and the
               surrounding framing, written under the old count, read as
               familiar rather than as wrong;
           11. asserted in a ledger entry that it was the FIRST use of
               STAY-CANONICAL in T1 -> a3's ledger had already used it twice.
               THE AGGRAVATING PART IS THE BASIS, not the error: the claim
               was inherited from the resume brief and the brief was CITED as
               its DERIVED-BASIS, so an unchecked statement acquired a
               source. A cited basis that was never opened is worse than a
               bare assertion, because it survives the reader's first test.
               THIS IS INSTANCE 8 IN MIRROR IMAGE. Instance 8 was a sweep
               that produced a find without opening the ledgers; this was a
               claim ABOUT the ledgers, made without opening them. The rule
               from instance 8 - a sweep producing a find must check the
               ledgers first - would have caught it, had it been read as
               covering claims about ledger history and not only finds about
               the authority.
        THE SWEPT FIELD WAS ADDED AFTER 1-3 AND CANNOT CATCH 4-7 OR 10,
        because those are not failures to search. They are one thing in
        different clothes: FIXING OR ASSERTING WHAT IS IN FRONT OF YOU AND NOT
        SWEEPING THE ARTIFACT.
        INSTANCE 8 IS THE MOST INSTRUCTIVE OF THE ELEVEN, and it is the one
        instance where the countermeasure already existed, was written down,
        was aimed at exactly this, and did not fire. LED-012's own text says
        it was flagged so that a later sweep would not pattern-match 'T1
        remains paused' and rewrite history. The designer pattern-matched it
        and proposed rewriting history. The charter's knowledge-sweep rule
        says to sweep SPECIFICATIONS AND DECISION RECORDS; the specification
        was swept and the decision record - the ledger set - was not opened.
        A SWEEP THAT PRODUCES A 'FIND' MUST CHECK THE LEDGERS BEFORE THE FIND
        IS REPORTED. An already-adjudicated item re-derived as a discovery is
        worse than a missed one: it invites a reviewer to reopen settled work
        and, here, would have destroyed a record two parties agreed to keep.

        WHAT ACTUALLY CAUGHT ALL ELEVEN: an independent party reading the
        whole artifact rather than the part under discussion. W3C caught
        1-4, 7, 9 and 11; successor designers caught 5, 6 and 10. Instance 8
        was caught by
        NEITHER - W3X directed the designer to raise the correction properly,
        and the ledger sweep that should have preceded the report happened
        then. NOT ONE OF THE ELEVEN WAS CAUGHT BY ITS AUTHOR, AND NOT ONE
        PREVENTED BY A RULE. That is the strongest evidence this project has
        that the three-way process is load-bearing rather than ceremony.
        WHAT INSTANCE 10 ADDS, and it is worth more than the tally: the
        failure does not spare the documents that describe it. A successor
        should therefore not treat this register, this decision, or a
        carefully written correction as exempt.
        THE DEFENCE THAT WORKS is not more care: it is finishing an edit by
        sweeping the whole file, and treating 'I found one' as a reason to
        keep looking rather than to close the item.
        (W3D; W3X 2026-08-18; instance 10 recorded 2026-08-19)

DEC-36  THE RETAIN-SUMMARY EXCEPTION IS RATIFIED, IN W3C's WORDING.
        THE PROBLEM IT SOLVES: the authority's section 0 restates decisions
        recorded formally elsewhere in the SAME document. Strictly that is
        duplication - but section 0 is the read-first compression every
        orientation document sends a cold successor to, and reducing it to
        pointers would follow the de-duplication rule correctly while
        destroying the document's usability.
        THE RULE, at review scope v1.9 section 5.4: a non-canonical
        CURRENT-DUPLICATE copy normally becomes a POINTER. EXCEPTION - an
        explicitly designated summary, index or orientation layer INSIDE the
        canonical authority may be RETAINED as a subordinate summary where its
        declared function requires a concise restatement, provided the entry
        identifies the canonical source PER PROPOSITION, the retained copy
        introduces NO UNIQUE NORMATIVE CONTENT, and it is not treated as an
        independent authority. Every CURRENT-DUPLICATE entry now carries
        DUPLICATE-ACTION: RETAIN-SUMMARY | POINTER.
        W3D'S PROPOSAL WAS REJECTED AND W3C's ADOPTED. W3D proposed classifying
        duplicates DESIGNED or INCIDENTAL. W3C rejected that axis, correctly: a
        stale duplicate can be deliberately designed too, so authorial intent
        is the wrong test - what matters is whether the copy has an APPROVED
        CONTINUING ROLE. W3C also showed W3D had overstated the danger, since
        T3's actual wording strips duplicates out of OTHER documents into
        pointers to the authority and never instructed anyone to hollow out the
        authority's own summary.
        I7 PROVENANCE: W3D proposed; W3C independently verified and supplied
        the replacement wording; W3X ratified. This governs criteria applied to
        W3D's own ledger, so I7 plainly applies.
        (W3C T1S01a3_B Q1; W3X 2026-08-18)

DEC-37  A FOURTH INSTANCE OF THE SAME W3D FAILURE, AND THE ONE THAT SHOWS THE
        SWEPT FIELD IS NOT SUFFICIENT ON ITS OWN.
        WHAT HAPPENED: T1S01a3 v1.0 proposed the duplicate-handling exception
        above, wrote explicitly that it must NOT be applied retroactively to
        the entries above it - and had ALREADY APPLIED IT in seven entries'
        PREVAILS fields, which said "THIS COPY STAYS as summary". That outcome
        was possible only under a rule W3X had not ratified.
        WHY IT MATTERS: this is derived reasoning leaking into the FINDINGS
        half, which is precisely what the two-part template and review question
        Q-F exist to catch. The designer had the rule in front of it and
        flagged the risk in the same document.
        THE PATTERN, now four times:
            1. claimed a section was the UNIQUE home of a principle -> section
               13.1 of the same document already stated it;
            2. claimed two design decisions were INDEPENDENT -> the shipped
               `boundary_strength_offset` moves both;
            3. claimed a list's tail was UNAFFECTED -> line 1153 of the same
               document contradicts the order;
            4. proposed a rule, wrote that it must not be applied yet, and had
               already applied it seven times.
        WHAT THIS TELLS US: the SWEPT field was added after instances 1-3 and
        would NOT have caught instance 4, because instance 4 is not a failure
        to search - it is asserting a conclusion the ratified evidence does not
        yet support. The failure takes a different form each time.
        COUNTERMEASURE ADOPTED: review question Q-F gains a fourth trap -
        "is the entry applying a rule that has not been ratified?" - and a
        successor designer should expect to commit this class of error rather
        than assume it died with the last one. W3C caught all four, in every
        case by reading the source rather than the ledger.
        (W3D self-report on W3C's finding; W3X 2026-08-18)

DEC-35  T1S01a IS SPLIT FURTHER: a3, a4 and a5 are defined, and a5 is the
        document's FINAL sub-tranche.
        THE REMAINING SUB-TRANCHES OF THE AUTHORITY DOCUMENT:
            T1S01a3  section 0's SEVENTEEN NUMBERED ARCHITECTURE ITEMS, plus
                     the header's remaining statements - the ratified-status
                     declaration, the single-source boundary rule and the
                     provenance-tag discipline.
                     SUBJECT: what the document says the ARCHITECTURE IS.
            T1S01a4  section 23's steps 6-10, carrying the DEC-32 ordering
                     finding.
                     SUBJECT: the post-Q14 development sequence and its
                     internal contradiction.
            T1S01a5  Appendix E entries v1.04 down to v1.00.
                     THIS IS THE FINAL SUB-TRANCHE OF THIS DOCUMENT, and the
                     designer must say so in it, because cross-entry
                     consistency across the whole document is checked there
                     and nowhere earlier (DEC-27).
        SUPERSEDED IN PART 2026-08-19: DEC-53 restructured this. The body had
        never been assigned to a named sub-tranche, so a5 and a6 became body
        parts 1 and 2 and the FINAL sub-tranche moved to a7. The RULE above -
        the designer must identify the final sub-tranche as the last, and
        cross-entry consistency is checked there and nowhere earlier - is
        UNCHANGED and still binds; only the sub-tranche it names has moved.
        WHY a3 AND a4 ARE SEPARATE and not one delivery: they are different
        subjects. Section 0's seventeen items are the substantive heart of the
        authority - geometry, source modes, B2, D, the rejected architectures,
        the Q14 gate. Section 23's tail is a development sequence carrying a
        known internal contradiction that needs working properly, not
        appending to something else. Bundling them would bury one in the
        other.
        WHY a5 IS LAST: the correct disposition of a historical revision entry
        depends on how the live sections it describes were adjudicated, so the
        revision history can only be judged once the body has been.
        SECOND REASON, STATED PLAINLY: the designer session doing this work
        has run long and may not survive it. Smaller deliveries are more
        likely to arrive complete, and each one that lands is one a successor
        does not have to redo.
        (W3D proposal; W3X 2026-08-18)

DEC-31  THE LEDGER MUST PROVE ITS OWN COVERAGE. A sub-tranche may not declare
        a range adjudicated while logging only a SELECTION from it.
        THE DEFECT: T1S01a2 v1.0 declared four whole ranges of the authority
        document adjudicated - header, all of section 0, all of section 23,
        Appendix E - and logged six entries covering only the CURRENCY
        statements. Section 0's seventeen numbered architecture items, most of
        Appendix E, and section 23's stable tail were not ledgered.
        WHY IT IS A METHOD BLOCKER and not a completeness quibble: T1 is
        complete only when EVERY MPEG-2-bearing statement has a recorded
        disposition. If a range can be declared swept while a selection is
        logged, the finished ledger proves nothing - it shows what was logged
        and silently reports the rest as swept. From outside it is
        indistinguishable from a thorough sweep. That is the "looks complete"
        failure the ledger exists to make impossible.
        THE RULE: every sub-tranche declares the EXACT statements it
        adjudicates, and assigns every omitted statement in the declared
        document to a NAMED later sub-tranche. Nothing is left implicit.
        (W3C T1S01a2_B Q1; W3D concurs; W3X 2026-08-18)

DEC-32  SECTION 23's STEPS 8 AND 9 ARE IN THE WRONG ORDER IN THE AUTHORITY -
        A REAL INTERNAL CONTRADICTION, FOUND BY W3C.
        WHAT W3D CLAIMED: that section 23's steps 6-10 were unaffected by the
        sequencing reversal and could be retained unchanged.
        WHAT IS ACTUALLY THE CASE, verified cold by W3D against the source:
        authority line 1153 states "The winner becomes part of the future
        Deblock4 scalar oracle" - the Schedule-SA/SB winner. Section 23 step 8
        BUILDS the ReleaseSafe scalar oracle; step 9 DECIDES the schedule. The
        document therefore specifies building an artifact before the decision
        that defines one of its constituent properties. The Verification and
        Tiering record independently requires the schedule as an obligation of
        the oracle-construction scope.
        A SECOND WARNING IN THE SAME TAIL, from W3C: step 7 says to FREEZE
        thresholds before the later quality-decision step, while the
        authority's open-quality records still list final threshold and
        strength behaviour as unresolved.
        WHAT IS NOT ESTABLISHED: the repaired order. W3C explicitly declined
        to propose swapping 8 and 9, because scalar candidate implementations
        may be needed to COMPARE schedules. What is established is narrower:
        the canonical schedule and quality decisions that define the accepted
        algorithm must be settled before the final accepted scalar oracle can
        serve as the reference for later backends.
        DISPOSITION: deferred to T1S01a4 WITH THIS FINDING ATTACHED. It must
        not be silently treated as checked.
        ROUTING CORRECTED 2026-08-18: this entry originally said T1S01a3.
        DEC-35 later split T1S01a further and put section 23's tail in
        T1S01a4, so two live records disagreed until now. W3C found the
        contradiction and correctly followed DEC-35 as the later and more
        specific decision.
        (W3C T1S01a2_B; W3D verified line 1153 cold; W3X 2026-08-18)

DEC-33  THREE PROCESS-CRITERIA CORRECTIONS, ALL FOUND BY W3C, ALL I7.
        Provenance: W3C found them and drafted the substance; W3D drafted the
        exact wording; W3C verifies; W3X ratifies. They govern criteria that
        judge W3D's own ledger, so I7 plainly applies - unlike a currency edit
        that merely mirrors an already-ratified W3X decision, which W3C
        correctly noted W3D had over-flagged as I7.
        (a) ATOMIC-CLAIM RULE. One disposition covers one proposition. A
            sentence whose clauses have different statuses is split or
            narrowed - never given one disposition with the other status
            preserved in REASON, which is a second unrecorded disposition
            hiding in prose.
        (b) THE SWEPT FIELD. Any claim that a statement is UNIQUE, INDEPENDENT
            or UNAFFECTED must record WHAT WAS SEARCHED to establish it.
            WHY: W3D made that class of unchecked assertion THREE TIMES -
            claiming a section was the unique home of a principle the same
            document already stated elsewhere; claiming two decisions were
            independent when one shipped parameter moves both; claiming a
            list's tail was unaffected when the same document contradicts it.
            Twice W3D had flagged the risk in the very entry and still did not
            check. "More care" has now failed three times, so the check is
            made VISIBLE and auditable instead of internal. W3C can now attack
            the SEARCH, not only the conclusion.
        (c) CURRENT-DUPLICATE REDEFINED. It must identify the CANONICAL HOME
            and state which side this copy is on. The old wording told the
            reader to replace "this copy" with a pointer, which is wrong when
            the copy being adjudicated IS the home - a gap W3C hit on its
            first use of the category.
        LANDED IN: review scope v1.8.
        (W3C T1S01a2_B Q2/Q3; W3X 2026-08-18)

DEC-34  RECORDED: scope v1.7 and charter v1.31 are COMPATIBLE. W3C compared
        charter v1.31 against v1.29 and found the operative change to be the
        neutral README wording in the bootstrap template plus revision
        history, with no rule or invariant change and no material effect on
        the T1 review scope. No scope reissue was required on that account.
        WHY RECORDED AT ALL: charter 2.3b requires the compatibility decision
        to be recorded when a controlling-document change is unrelated to an
        existing scope. W3C looked for the record and did not find one.
        (W3C T1S01a2_B Q5; W3X 2026-08-18)

DEC-29  OWED AFTER T3: THE README'S CHARTER STATUS CHANGE. REGISTERED HERE
        SO IT CANNOT BE LOST.
        WHAT IS OWED: a full charter proposal removing the README's
        "controlling specification" status, raised by W3D, verified by W3C,
        ratified by W3X.
        WHEN: after T3 strips the README. NOT before.
        WHY NOT BEFORE: reclassification is a promise about content, and
        DEC-07 already ratified that the README cannot be reclassified until
        T1 adjudicates it and T3 strips it. The README is 3,792 lines and
        still holds ratified Architecture A design at sections 3.11 and 3.13.
        WHAT THE PROPOSAL MUST DO - and this is the part that makes it a real
        piece of work rather than a word swap. "Controlling specification" is
        load-bearing at SEVEN charter sites, FOUR of which are rules that
        OPERATE on it:
            the bootstrap template heading (now neutral, charter v1.31);
            the scope-attachment list;
            the scope package contents list;
            "attaching it in full is required by I2";
            "scopes quote the controlling specification sections in full";
            P-09 "a coding scope may implement the controlling specification";
            "it may not amend this charter or the README unless...".
        Deleting the status would leave I2 and P-09 operating on an object
        with NO NAMED REFERENT - P-09 would say a coding scope may implement
        nothing in particular. THE PROPOSAL MUST NAME THE REPLACEMENT OBJECT,
        probably the ratified MPEG-2 authority plus whatever T3 leaves as the
        design specification.
        INTERIM STATE: charter v1.31 made the bootstrap template's heading
        neutral and recorded that the classification is under a pending
        ruling. It changed NO rule and NO status; all four operative clauses
        were verified intact after the edit.
        (W3X directed the interim fix and the registration, 2026-08-18)

DEC-30  DEC-05 IS DISCHARGED, TWELVE DOCUMENTS LATE, AND THE LATENESS IS THE
        POINT.
        WHAT LANDED: staleness banners on Forward Roadmap (now v1.21) and
        Documentation Currency Audit (now v1.5). Each states its own specific
        known-stale content, states that the banner is NOT an adjudication
        and that the document has not been swept, and states that the banner
        is NOT permission to skip the document during T1.
        WHAT WENT WRONG: DEC-05 approved these banners "NOW" on 2026-08-17.
        W3D recorded the decision and then went straight on to build the scope
        manifest. The action sat undischarged through roughly a dozen
        documents until W3C found it during successor orientation and asked
        whether it had been deferred deliberately.
        WHY IT MATTERS BEYOND THE TWO FILES: a decision recorded in this
        register READS AS DONE to anyone auditing it. This is the same shape
        as DEC-23, where the ledger-template fix existed in the register but
        not in the document that bound W3C - and W3C caught that one too.
        STANDING HABIT ADOPTED: when this register records an action, the
        artifact ships in the SAME turn, or the register says explicitly that
        it is OWED and names who owes it.
        (W3C found it; W3X directed the fix; 2026-08-18)

DEC-27  A STEP COVERING A LARGE DOCUMENT IS DELIVERED IN SUB-TRANCHES.
        NAMING: T1S01a2, T1S01a3 and so on, keeping the existing `_A_` to the
        coder and `_B_` back. No new convention is needed - the scheme W3X
        specified has now absorbed three structural changes without
        modification.
        REVIEW: W3C reviews each sub-tranche AS IT LANDS rather than waiting
        for the document's ledger to complete.
        WHY SUB-TRANCHES: a designer session that dies mid-document loses
        everything not yet delivered. This caps that loss at one part. Same
        reasoning as the incremental delivery at DEC-10, applied one level
        down, because the authority document alone is 1,983 lines and the
        designer session adjudicating it has already run long.
        THE RULE THAT DEPENDS ON IT: some entries conflict only with OTHER
        entries, which may sit in a part the reviewer has not seen.
        Cross-entry consistency within a document is therefore checked at the
        FINAL sub-tranche of that document, which the designer MUST identify
        as the last. W3C is not expected to spot contradictions against
        entries it was never shown - asking it to would be the same defect as
        asking it to find omissions without the source document, which W3C
        itself flagged as blocking.
        (W3D proposal; W3X 2026-08-18)

DEC-28  DEC-23 IS DISCHARGED. The corrected ledger template is now present in
        the document that actually binds W3C - review scope v1.6, carried into
        v1.7 - rather than only in this register.
        WHAT LANDED: the entry is split into two labelled halves. Findings
        about existing text, where DISPOSITION is exactly one of the five
        registered values and nothing else; and a separate DERIVED /
        DERIVED-BASIS pair for anything the designer reasoned TO rather than
        found. A sixth review question Q-F covers derived propositions and
        names the three traps that have each already occurred once: a derived
        proposition that already exists somewhere unchecked, an unchecked
        claim of independence or uniqueness, and derived material leaking into
        the findings half. The prohibitions gained a matching line - findings
        and derivations fail SEPARATELY, and an entry can quote its source
        correctly while reasoning wrongly from it.
        W3C's statement of the danger is kept VERBATIM in the scope because it
        is better than a paraphrase: otherwise future entries can make a
        statement "current in substance" by inventing the substance they wish
        it had.
        (W3D; W3X 2026-08-18)

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
        CONFIRMED 2026-08-19 - SEE DEC-57. The block IS lifted. T5 remains
        sequenced AFTER T1 (DEC-02); unblocked is not next.
        (W3C T1S01a1_B Q2; W3D verified; W3X 2026-08-18; confirmation
        2026-08-19)

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
                SUPERSEDED IN PART by DEC-27: T1S01a is itself delivered in
                sub-tranches T1S01a1, T1S01a2, T1S01a3...
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

M2  SCOPE MANIFEST PUBLISHED FIRST (DEC-06), WITH LATER MECHANICAL
    EXCLUSIONS APPLIED WITHOUT REWRITING THE FROZEN HISTORICAL SURVEY.
    Current T1 search exclusions:
      - any path component beginning "superseded" or
        "scheduled_for_deletion" (DEC-60);
      - everything under T1/ (DEC-63);
      - everything under GAIS_investigations/ (DEC-66).
    T1/ is a workshop/process tree, not an applicable-knowledge shelf.
    GAIS_investigations/ is ignored for T1 search and adjudication.

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

M12 THREE RATIFIED SEARCH/CLASSIFICATION RULES APPLY (DEC-67).
    1. OPEN EVERY HIT. A returned candidate left unclassified is not swept.
    2. NORMALISE WHITESPACE for phrase searches.
    3. SEARCH THE PROPOSITION, NOT MERELY THE SOURCE SENTENCE, using a bounded
       declared probe family. If opening a genuine carrier reveals an
       equivalent phrasing the family missed, add it, record why, and rerun
       the SAME population.
    In all cases, opening a file is not enough: classify what the matched
    passage ACTUALLY MEANS as CARRIER / APPLIES / DIFFERENT / IDENTIFIER /
    NOISE, using MIXED where one file carries more than one meaning.

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
      as the original registration.
      ITS BLOCK ON T5 IS CONFIRMED LIFTED 2026-08-19 - SEE DEC-57. The
      12.5/13.1 pointer remedy is still RE-DERIVED at T1S01a5 rather than
      inherited (DEC-54), and T5 remains sequenced after T1 (DEC-02).]
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

# T8 - Close the provenance gaps the sweep surfaces

```text
WHAT: collect the statements T1 finds to be CURRENT AND PROBABLY RIGHT BUT
WITHOUT A RECORDED BASIS, and close each by direct citation - or record
explicitly that it cannot be closed.

WHY IT IS ITS OWN TASK. T1 is a LOCATION AND CURRENCY sweep. It establishes
where each statement lives, whether it is current, whether it is duplicated
and whether it contradicts something. IT DOES NOT ESTABLISH THAT A STATEMENT
IS TRUE. The remedy tasks it feeds - T2 retire, T3 de-duplicate, T4 boundary
mathematics, T5 detector mathematics - have no home for "verify this claim's
basis", so without T8 these findings are recorded and then nothing happens to
them.

ALREADY SURFACED BY T1S01a5 - do not rediscover:
  F8 - vertical transform-block edges are geometry-invariant at x=8k.
       Tagged [DERIVED]. NO RECORDED BASIS ANYWHERE. HIGHEST PRIORITY: it is
       the fact the entire architecture rests on. If it were false, B2 would
       need a classifier on both axes and Architecture D's "vertical:
       process normally" rule would be wrong. W3D believes it correct - it
       follows from field organisation being a REORDERING OF ROWS, which
       cannot move a column boundary - and believing it is exactly why it
       needs writing down. See ledger LED-046.
  F6 - a post-decode filter cannot know per-macroblock dct_type without
       trusted side data. Tagged [DERIVED], no recorded basis. The probable
       basis is the VapourSynth API4 filter contract and the absence of any
       dct_type frame property. See LED-044.
  F7 - TFF/BFF is not a grid parameter. Tagged [DERIVED], no recorded basis.
       See LED-045.
  F5 - its provenance rests ONLY on "W3C verification report V4.3", and the
       report named at section 24 reference R8 cannot be located under that
       filename (DEC-58). If it cannot be found, F5 should be re-verified
       against H.262 directly. F4 is NOT affected: it carries clause 6.1.3
       independently. See LED-063 and LED-043.
  The LG measurement table - carries the [MEASURED] tag, whose own definition
       requires "named material/tooling", and names no tooling, sample size
       or date. Section 6.1 two paragraphs above names its sample size, so
       the omission is not house style. See LED-057.

EXPECT MORE. T1S01a5b, T1S01a6 and T1S01a7 have not run, and a5 found five in
its first eight sections.

SEQUENCING: T8 runs AFTER T1 AND BEFORE T5. T5 derives detector
mathematics on top of these facts; deriving on an unrecorded basis is how the
project got here. T8 does NOT block T1, T2 or T3.

WHAT T8 IS NOT: it is not a re-verification of everything. It closes gaps T1
NAMES. A statement with a recorded basis is out of scope even if a reader
would like more of it.
```

---

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

```text
v1.30 (2026-08-19) W3C recovery-state reconciliation after the preceding W3D
     chat reached its session/context limit. NO NEW DECISION NUMBER is created
     by this bump. Section 0 now records the actual recoverable endpoint:
     Classification Repair v1.1 is complete; W3C reconstructed the missing
     a5 ledger rewrite as v1.4 from delivered v1.3 + repair v1.1 + accepted
     W3C findings; that v1.4 is a W3C-authored RECOVERY CANDIDATE and therefore
     cannot be represented as a normal W3D proposal independently reviewed by
     W3C. New section 0a records the recovery gate: successor W3D must
     independently verify/adopt/correct the reconstruction, then W3X chooses
     the one-off a5 closure route. a5b remains NOT STARTED until that closure.
     Also reconciles the current-facing T1 method summary to DEC-60/63/66/67,
     separates 47 surveyed / 41 adjudicated / 46 a5 searchable populations,
     and states the live sequence as T1 -> T8 -> T5 -> T6/Q14. Historical DEC
     text is preserved.

v1.29 (2026-08-19) Records DEC-66 to DEC-69.
     DEC-66 ignores the GAIS_investigations/ tree for EVERYTHING, search and
     adjudication alike, on the same footing as superseded*. Adjudication
     population 47 -> 41; search population unchanged at 46; T1S01b becomes
     Scopes-only; LED-023's discharge becomes constructive rather than
     comparative, which is stricter, and should be done with T8.
     DEC-67 ratifies the three sweep method rules, with W3C's bounded form of
     the third, and records the lesson that survived all three: opening a hit
     is not reading it.
     DEC-68 ratifies the T1S01a5 / T1S01a5b split at the section 8/9 boundary.
     DEC-69 authorises a T1S00 bump to v1.5, DELIVERY-DESCRIBING PARTS ONLY,
     with the frozen search frame untouched and the bump required to say so
     in its own revision note. Sequenced after the a5 repair and rewrite.
     STANDING HABIT ADDED AT W3X's DIRECTION: this register and the T1 resume
     brief are COMMITTED AFTER EVERY BUMP, not at batch boundaries. Nine of
     the project's durable findings live only here, and this document sits in
     T1/ - which DEC-63 makes unsearchable. Its survival depends entirely on
     being committed, never on being findable by a sweep.

v1.28 (2026-08-19) Records DEC-64 and DEC-65, and opens task T8.
     DEC-64 splits SUPERSEDED by kind - OVERTAKEN or ERRONEOUS - with a
     PROPAGATION field for the erroneous case. W3X's refinement is the
     substance of it: pragmatically the two kinds have the same effect on the
     statement, so the distinction earns its keep entirely through the
     propagation search it triggers, not through the label. NOT YET BINDING:
     W3C verifies the wording first under charter I7, because the criterion
     judges W3D's own entries. Adopting now costs nothing - a5 has no
     SUPERSEDED entries and the first erroneous case will be the README's
     rejected architecture at T3.
     DEC-65 opens T8, to close the provenance gaps T1 surfaces - statements
     current and probably right but with no recorded basis. Five are already
     named, F8 first because the whole architecture rests on it. T8 runs
     before T5 and blocks T7. W3D proposed calling it T7; T7 already exists.
     No finding, disposition or sequencing of T1 changed.

v1.27 (2026-08-19) Records DEC-63: the T1/ tree is excluded from the T1 search
     population entirely - a workshop, not a shelf. Knowledge may be drafted
     there but is not searchable, applicable or final until promoted out.
     Search population 54. Chosen over W3D's assert-versus-quote proposal
     because a path test needs no judgement, where that proposal needed one
     per file on a criterion judging W3D's own claims. Verified before ruling:
     nothing in T1/ asserts project knowledge. Four numeric SWEPT claims in
     the a5 ledger were measured over the old population and are corrected at
     ledger v1.5; no disposition changed.

v1.26 (2026-08-19) Records DEC-62: the a5 tier labels were wrong on 31 of 34
     entries, because the designer used the field as an importance marker
     while review scope section 6 derives it from the disposition. The 23
     Tier A mislabels are the serious half - they amount to the designer
     setting the review depth of its own work, which the scope forbids in
     terms. Tier fields are now computed from disposition. W3X owes the Tier
     C sample selection. No finding, disposition or action changed.
     ALSO PENDING, NOT YET A DECISION: the search-population question raised
     by W3C - whether a document that QUOTES a proposition in order to
     adjudicate it counts as a copy refuting uniqueness. See a5 covering note
     Q7. Until W3X rules, ledger section 0.5's wider-population paragraph is
     marked UNDER ADJUDICATION in the ledger itself.

v1.25 (2026-08-19) Records DEC-61, two a5 method defects found by W3C before
     it completed a single entry review: three entries carrying compound
     DISPOSITION fields, split at a5 ledger v1.3 under DEC-33(a); and a false
     claim that a5 was the first STAY-CANONICAL use in T1, inherited from the
     resume brief and citing that brief as its basis. NEITHER CHANGES A
     FINDING. DEC-61 also fixes the boundary the first defect exposed:
     per-proposition HOMES and ACTIONS under one disposition are permitted and
     required by review scope 5.4; per-proposition DISPOSITIONS are not.
     DEC-41 MOVES TO ELEVEN. Instance eleven is the false first-use claim,
     recorded because its aggravating feature is the CITED BASIS - the brief
     was named as the source and never opened - which makes it instance 8 in
     mirror image.
     No task, dependency, sequencing or technical decision changed.

v1.24 (2026-08-19) Records DEC-60: the T1 retired-tree exclusion becomes a
     mechanical path test - any folder whose name begins "superseded" or
     "scheduled_for_deletion" - replacing T1S00 section 2's enumerated list of
     four folders, which had staled when T1/superseded/ was created during the
     sweep. Search population 87; adjudication population unchanged at 47,
     re-derived rather than assumed. No re-scan of adjudicated steps is
     required and that was verified, not asserted: no prior ledger SWEPT field
     claims to have searched a retired tree.
     THE FINDING IS W3C's, made before it had completed a single entry review.
     No other decision, task or sequencing changed.

v1.23 (2026-08-19) Two corrections carried out on W3X's answers to the
     questions raised with v1.22, before either version was accepted.
     (a) THE REVISION HISTORY IS NOW FENCED. This document ended with a
         closing code fence that had no opener, so the whole revision
         history sat outside the fenced style every other block in this file
         uses, and the file ended with a stray fence. The defect is
         INHERITED - fence counting on v1.21 before any edit showed the same
         imbalance - and is fixed here by opening the block, which W3X
         confirmed as the intended shape.
     (b) DEC-59 RECORDS A DELIBERATE NON-CORRECTION, which is the part worth
         reading.
     WHY THIS IS v1.23 AND NOT A SILENT EDIT OF v1.22: v1.22 had already
     been delivered to W3X when these answers arrived. Two files with the
     same name and different contents in play is the exact hazard DEC-40(a)
     records, and it costs nothing to avoid.
     No decision, task, sequencing or technical content changed.

v1.22 (2026-08-19) CURRENCY PASS plus four new decisions, run at W3X's
     direction before T1S01a5 was issued, after a successor designer's
     orientation reconciled this register against the authority document and
     against the resume brief.
     NEW DECISIONS: DEC-55 assigns authority section 24 to T1S01a6, which no
     sub-tranche covered; DEC-56 makes declared ranges EXACT and corrects
     DEC-53's, which were wrong at both ends; DEC-57 confirms PR-1's block on
     T5 is lifted and records that THIS REGISTER, not the designer
     introduction, was the document in error; DEC-58 registers the dangling
     reference R8 as an open item for a6, with W3X's candidate referent
     recorded as unverified.
     DEC-41 MOVES TO TEN. Instance ten is this decision itself: a ninth
     instance had been added to its list while the heading and three prose
     sentences still said eight, so the entry recording the failure tally
     had committed the failure it records. Heading, prose and the
     who-caught-what attribution are corrected together rather than one at a
     time, which is the DEC-51 lesson applied to DEC-41.
     ROUTING CORRECTED IN SIX PLACES: DEC-39, DEC-42, DEC-43, DEC-49, DEC-50
     and DEC-52 all still routed carried items to "T1S01a5's whole-document
     consistency pass", which DEC-53 had moved to a7; the section 0 status
     block still said "T1S01a5 LAST for this document". Each is corrected in
     place with a note saying why, because a later decision does not make an
     earlier decision's still-live wording safe to follow. DEC-35's
     a5-as-final structure is marked SUPERSEDED IN PART, with the RULE it
     carries - identify the final sub-tranche, check consistency there and
     nowhere earlier - preserved unchanged.
     ALSO: the resume order at section 0 no longer pins Project Status to a
     version (it said v1.28 while v1.32 was current) and now sends a
     successor to the resume brief's section 0a first.
     METHOD, recorded because DEC-51 requires it: the replacement scope was
     declared as this register plus the T1 resume brief; the live corpus was
     searched for each rejected proposition; every hit was classified LIVE or
     HISTORICAL before any edit; and the file was re-searched afterwards. The
     enumeration is in the covering note issued with this pass.
     RECORDED HONESTLY: this history has NO ENTRIES FOR v1.13 THROUGH v1.21.
     Nine generations passed without a revision note in a document whose own
     maintenance rule is that reasoning must not be lost. The gap is NOT
     reconstructed here - inventing entries after the fact would be worse
     than the gap - and the decision log itself carries the substance, since
     each of those generations added DEC entries with their reasons.
     No task, dependency, sequencing or technical decision is changed by the
     currency half of this pass.

v1.12 (2026-08-18) Ratifies the RETAIN-SUMMARY exception in W3C's wording
     after W3C rejected W3D's DESIGNED/INCIDENTAL axis as the wrong test
     (DEC-36). Records a fourth instance of W3D's recurring unchecked-assertion
     failure - proposing a rule, forbidding its retroactive use, and having
     already used it seven times - together with the finding that the SWEPT
     field would not have caught it, because the failure takes a different form
     each time (DEC-37). Corrects DEC-32's routing, which said the section 23
     ordering defect went to T1S01a3 while DEC-35 put it in T1S01a4; W3C found
     the contradiction and correctly followed the later decision.
v1.11 (2026-08-18) Defines the remaining sub-tranches of the authority
     document - a3 the architecture items, a4 the development-sequence tail
     with its ordering finding, a5 the revision history and, as the document's
     FINAL sub-tranche, the cross-entry consistency check (DEC-35). Corrects
     the status-at-a-glance block to match.
v1.10 (2026-08-18) Records the outcome of the second authority sub-tranche.
     W3C found a coverage defect - a range declared adjudicated while only a
     selection was logged - now a standing rule that every sub-tranche
     declares its exact statements and assigns every omission to a named later
     sub-tranche (DEC-31). Records the real internal contradiction W3C found
     in the authority's own development sequence, where the scalar oracle is
     built before the schedule decision that defines part of it, deferred to
     T1S01a3 with the finding attached rather than treated as checked
     (DEC-32). Records the three process-criteria corrections now landed in
     review scope v1.8, including the SWEPT field added because "more care"
     had failed three times (DEC-33). Records the charter compatibility
     decision W3C could not find (DEC-34). Corrected the status-at-a-glance
     block, which still said T1S01a2 was held pending a fix discharged at
     DEC-28 - W3C raised that twice before it was fixed.
v1.9 (2026-08-18) Registers the README charter-status change as OWED AFTER T3,
     with the seven load-bearing charter sites enumerated and the requirement
     that any proposal NAME THE REPLACEMENT OBJECT for I2 and P-09 (DEC-29) -
     because deleting the status alone would leave two rules operating on
     nothing. Records DEC-05's banners as finally discharged, twelve documents
     after they were approved, and adopts the habit that follows: an action
     recorded here ships in the same turn or is explicitly marked owed
     (DEC-30). Both items were surfaced by W3C during successor orientation.
v1.8 (2026-08-18) Records sub-tranche delivery for large documents and its one
     dependent rule - cross-entry consistency is checked at the final
     sub-tranche, because a reviewer cannot be asked to find contradictions
     against entries it was never shown (DEC-27). Records DEC-23 as discharged
     now that the corrected ledger template is present in the review scope
     rather than only here (DEC-28). No sequencing, tier, disposition value or
     pre-registered item changed.
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
