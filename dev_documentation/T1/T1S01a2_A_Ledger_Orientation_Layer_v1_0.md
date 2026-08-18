# Deblock4 - T1S01a2 Ledger: the Authority Document's Orientation and Currency Layer

**Deliverable:** T1S01a2_A - LEDGER
**Version:** 1.0
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Step:** T1S01a, sub-tranche 2
**Document adjudicated:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Sections adjudicated in this sub-tranche:** the document header block, section
0 (CURRENT ARCHITECTURE POSITION), section 23 (DEVELOPMENT SEQUENCE AFTER
RATIFICATION), and Appendix E (REVISION HISTORY).
**Search frame:** the frozen 90-term set, manifest v1.4.
**Template:** review scope v1.7 - findings and derived propositions separated.

**THIS IS NOT THE FINAL SUB-TRANCHE OF THIS DOCUMENT.** Cross-entry
consistency checking is not due yet. Sections 1-22 and Appendices A-D follow in
later sub-tranches.

**Status:** PROPOSED ADJUDICATIONS. Nothing here is decided.
**Encoding:** US-ASCII; CRLF.

---

# 0. Why this layer first, and what it is

The document's **orientation and currency layer** is everything it says about
where the project stands, as distinct from what it says about MPEG-2. That is
sections 0 and 23 plus the header and revision history.

It is taken first because an error here misleads every reader of the document,
including one who reads nothing else - and section 0 is the section every
orientation instruction in the project tells a successor to read first.

W3C flagged part of this during successor orientation, correctly, and reasoned
that the later Standing Task Register governs the work queue while this
document governs MPEG-2 architecture. That reasoning is adopted below, but it
is adopted as an adjudication with a recorded disposition rather than inherited
as a conclusion.

---

# LED-003  Section 23, opening paragraph - T1 described as PAUSED

## WHAT THE DOCUMENT SAYS

```text
DOCUMENT     Deblock4_MPEG2_..._Decided_Architecture_v1_05, section 23,
             lines 1679-1681
CLAIM        "The formal documentation consolidation tasks T1-T3 remain live
             but W3X has PAUSED T1 while the Q14 work is set up"
ASSERTS      that T1, the consolidation sweep, is not running, and that the
             Q14 preparation work proceeds ahead of it.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  CONFLICTING
REASON       It was true when written and is now false. W3X reversed the
             sequence on 2026-08-17: T1 runs FIRST, recorded as DEC-02 in the
             Standing Task Register with its reason - that T5 derives detector
             mathematics, and the README has already proved a ratified design
             can sit unread in a document nobody swept, so discovering that
             after T5 is ratified would cost T5, T6 and possibly a Q14 re-run.
CONFLICTS    Standing Task Register (v1.9 at this writing), DEC-02.
PREVAILS     THE TASK REGISTER, on this statement.
             The authority document prevails on MPEG-2 architecture. It does
             NOT prevail on the work queue, which is the register's domain and
             which the register carries with a later ratified decision.
             NOTE THE DIRECTION: this is a case where the NEWER document wins
             because it is the right authority for the subject AND later - not
             merely because it is newer. Recency is evidence toward
             supersession, never proof of it.
```

## PROPOSED ACTION

Authority version bump replacing the paragraph with a pointer: the work queue
and its sequencing live in the Standing Task Register; this document does not
restate it. **PROPOSAL ONLY - W3D does not edit the ratified authority.**

```text
TIER     A (CONFLICTING - all conflicts are Tier A)
VERDICT  [W3C]
```

---

# LED-004  Section 23, the numbered development sequence

## WHAT THE DOCUMENT SAYS

```text
DOCUMENT     same, section 23, lines 1683-1701
CLAIM        the ten-step ordered sequence beginning "1. T5: derive and ratify
             the detector / feature mathematics needed by Q14" and placing at
             step 5 "Resume/complete T1-T3 documentation consolidation at
             W3X's chosen point, before stale duplicate MPEG-2 guidance can
             govern implementation."
ASSERTS      an operative development order in which T5 is first and the
             documentation sweep is fifth.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  CONFLICTING
REASON       Same reversal as LED-003, but this is the OPERATIVE LIST rather
             than the narrative sentence, and therefore the more dangerous of
             the two: a reader looking for "what happens next" reads a
             numbered list before prose. Steps 1 and 5 are inverted against
             the current ratified order.
CONFLICTS    Standing Task Register DEC-02 (sequence) and DEC-03 (T5 and T6
             ratified separately, not as one package).
PREVAILS     THE TASK REGISTER, on the ORDER of steps 1 and 5 only.
             STEPS 6-10 ARE NOT AFFECTED AND REMAIN CURRENT: the D4-Q16
             parameter reconciliation, the kernel mathematics freeze, the
             independent oracle, the Schedule-SA/SB quality decisions and the
             vector backends are all still correctly ordered and still
             correctly gated behind Q14. Do not discard the list; reorder its
             head.
```

## PROPOSED ACTION

Authority version bump reordering steps 1-5 to place T1-T3 first, or replacing
steps 1-5 with a pointer to the register while retaining 6-10 in place.
**PROPOSAL ONLY.**

```text
TIER     A
VERDICT  [W3C]
```

---

# LED-005  Section 23, step 1 - the coordinated T5+T6 package

## WHAT THE DOCUMENT SAYS

```text
DOCUMENT     same, section 23, lines 1684-1686
CLAIM        "T5 may be the first frozen part of one coordinated T5+T6 design
             package, but it must be fixed before held-out experiment
             judgement."
ASSERTS      that a single combined T5+T6 deliverable is permitted, provided
             the T5 part is frozen first.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  SUPERSEDED
REASON       W3X decided on 2026-08-17 that T5 is issued and ratified ALONE,
             with T6 following as a separate ratification (DEC-03). The
             permission this sentence grants was live and has been withdrawn.
             The REASON for withdrawing it is preserved and matters: two
             separate ratifications make "the detector mathematics were fixed
             before anyone saw held-out results" a matter of record rather
             than of internal document structure.
CONFLICTS    Standing Task Register DEC-03.
PREVAILS     THE TASK REGISTER.
             NOTE THE SUBSTANCE THAT SURVIVES: the CLAUSE after the comma -
             "it must be fixed before held-out experiment judgement" - is NOT
             superseded. It is the anti-tuning discipline and it remains
             binding. Only the packaging permission is withdrawn.
```

## PROPOSED ACTION

Authority version bump removing the packaging permission and retaining the
freeze-before-judgement requirement. **PROPOSAL ONLY.**

```text
TIER     A (all SUPERSEDED entries are Tier A - DEC-15)
VERDICT  [W3C]
```

---

# LED-006  Section 0, the status date-stamp and "next substantive artifact"

## WHAT THE DOCUMENT SAYS

```text
DOCUMENT     same, section 0, lines 51-57
CLAIM        "STATUS AT 2026-08-16 [...] The next substantive artifact is the
             D4-Q14 architecture-discriminator EXPERIMENT, not a filtering
             implementation."
ASSERTS      that the immediately following piece of work is the Q14
             experiment.
CLASS        W3X-RATIFIED (as at 2026-08-16)
DISPOSITION  CONFLICTING
REASON       The next substantive artifact is now the T1 sweep, then T5, then
             T6, then the experiment. The sentence is in the section every
             orientation document in this project directs a successor to read
             FIRST, which is what raises it above a wording nit.
             THE SENTENCE'S REAL PURPOSE SURVIVES INTACT AND MUST BE KEPT: its
             point is the contrast - "not a filtering implementation". That
             prohibition is undamaged and is the reason the sentence exists.
CONFLICTS    Standing Task Register DEC-02; Project Status v1.29 section 0.
PREVAILS     THE TASK REGISTER on WHAT IS NEXT.
             THIS DOCUMENT PREVAILS on what is NOT next - no filtering
             implementation before Q14 reports - which is an architecture
             matter and squarely in its domain.
```

## PROPOSED ACTION

Authority version bump: keep the prohibition, replace the positive claim with
a pointer to the register. Consider whether a date-stamped `STATUS AT` block
belongs in an architecture authority at all - see the derived note at LED-008.
**PROPOSAL ONLY.**

```text
TIER     A
VERDICT  [W3C]
```

---

# LED-007  Appendix E, the v1.05 revision entry

## WHAT THE DOCUMENT SAYS

```text
DOCUMENT     same, Appendix E, revision history, v1.05 entry
CLAIM        "reconciles section 23 to the current W3X sequencing: T1 remains
             paused while T5 detector mathematics and T6 Q14 planning
             proceed."
ASSERTS      what the v1.05 revision DID when it was made.
CLASS        DERIVED (a record of an editorial act)
DISPOSITION  CURRENT-UNIQUE
REASON       THIS ONE IS NOT SUPERSEDED, AND IT MATTERS THAT IT IS NOT.
             A revision-history entry is a statement about the PAST - what a
             particular version changed and why. This entry accurately records
             what v1.05 did on 2026-08-16. That remains true no matter how
             many times the sequence is later reversed.
             CHANGING IT WOULD BE FALSIFYING THE RECORD. The correct treatment
             of a superseded DECISION is to supersede it; the correct
             treatment of an accurate record OF that decision is to leave it
             exactly alone.
CONFLICTS    none. It does not assert a current sequence; it reports a past
             edit.
PREVAILS     n/a.
```

## PROPOSED ACTION

**NONE. Do not touch.** Flagged here only so that a later sweep does not
"correct" it by pattern-matching the phrase "T1 remains paused" and quietly
rewrite history.

```text
TIER     C (CURRENT-UNIQUE)
VERDICT  [W3C]
```

---

# LED-008  Header block, the supersession paragraph

## WHAT THE DOCUMENT SAYS

```text
DOCUMENT     same, header block, lines 25-31
CLAIM        "this document absorbs and supersedes
             Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md. The
             MPEG-2-specific content still present in
             README_Deblock4_Design_Spec_v1_12.md, the concise summary,
             roadmap, status/orientation files and current Stage-1C parameter
             descriptions should then be reduced to references to this
             document as part of the planned currency/consolidation pass."
ASSERTS      the supersession of the Grid Knowledge document, and that
             MPEG-2 content elsewhere should become pointers.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       Both halves are current and correct. The Grid Knowledge
             supersession stands. The second half is the authority document
             ITSELF specifying the work that T3 exists to perform, and it
             names the correct targets - README, concise summary, roadmap,
             status/orientation files, Stage-1C parameter descriptions. Every
             one of those is in the T1 population.
             WORTH RECORDING FOR T3: the concise summary and the roadmap have
             since received corrective treatment (summary v1.4, roadmap v1.21
             banner) but NEITHER has been reduced to pointers. This sentence
             is therefore still OWED work, not discharged work.
CONFLICTS    none.
PREVAILS     this document.
```

## WHAT THE DESIGNER INFERRED

```text
DERIVED        Sections 0 and 23 are WORK-QUEUE content living inside an
               ARCHITECTURE authority, and that structural mismatch - not
               carelessness - is what generated LED-003 through LED-006. Four
               conflicts in one sub-tranche all have the same cause: a
               document whose domain is MPEG-2 geometry also carries a
               date-stamped project status and a numbered development order,
               so every project-level decision taken elsewhere silently
               ages it.

DERIVED-BASIS  The four conflicting statements are all sequencing or status
               claims; not one of them is an MPEG-2 claim. The document's own
               single-source rule (header, lines 13-22) already draws exactly
               this line: it says MPEG-2 facts live here while "global project
               rules that are not MPEG-2-specific [...] remain in their
               existing authorities and are referenced rather than duplicated
               here." Sections 0 and 23 are the document breaking its own
               stated rule.

               LIMIT OF THIS INFERENCE, stated so it is not over-read: this is
               a proposal about DOCUMENT STRUCTURE. It is not an MPEG-2
               finding, it does not follow from the four conflicts as a matter
               of logic - four conflicts could equally be four accidents - and
               W3D has NOT swept the other twenty sections to check whether
               the same pattern recurs. A structural claim made from one
               sub-tranche is exactly the kind of claim that should wait for
               the rest of the document.
               W3D RECOMMENDS NOT ACTING ON THIS until T1S01a is complete.
```

```text
TIER     A (carries a derived proposition)
VERDICT  [W3C]
```

---

# What W3C is asked here

Beyond the standard questions and Q-F:

```text
1. LED-007 is the one to attack from the opposite direction to the others.
   W3D declined to supersede it, arguing that editing an accurate historical
   record would falsify it. If that reasoning is wrong - if a revision entry
   that repeats a now-false claim should carry a marker - say so. W3D would
   rather be told the record needs annotating than discover later that a
   successor read it as current guidance.

2. LED-004 preserves steps 6-10 while reordering 1-5. Check that 6-10 really
   are unaffected. W3D read them as correctly ordered and correctly gated,
   but a partial reorder is exactly where an ordering dependency gets missed.

3. THE DERIVED NOTE AT LED-008 IS A STRUCTURAL PROPOSAL MADE FROM ONE
   SUB-TRANCHE, and W3D has recommended against acting on it yet. Test both
   the inference AND that self-imposed limit. If the limit is excessive
   caution - if four same-cause conflicts in the document's own orientation
   layer are already enough - say so.

4. Every proposed action in this tranche is an authority version bump written
   by the party that found the defect. Charter I7 shape. Test the remedies at
   least as hard as the findings.
```

---

*Revision history*
```text
v1.0 (2026-08-18) First issue of T1S01a2, under the corrected two-part ledger
     template from review scope v1.7. Adjudicates the authority document's
     orientation and currency layer: header, section 0, section 23 and the
     revision history. Three CONFLICTING, one SUPERSEDED, two CURRENT-UNIQUE,
     one derived structural proposition which W3D recommends not acting on
     until the document is fully swept. Not the final sub-tranche.
```
