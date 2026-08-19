# Deblock4 - Tier Briefing for W3X, and the T1S01a5 Tier C Sample

**Deliverable:** T1S01a5_A - TIER BRIEFING
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X
**Purpose:** answer W3X's request for the tier definitions and a Tier C list,
and explain why one part of that request W3D must decline.
**Encoding:** US-ASCII; CRLF.

---

# 1. THE THREE TIERS, BRIEFLY

```text
THE TIER IS DERIVED FROM THE DISPOSITION. It is not an importance marker and
the designer does not choose it. Review scope section 6:

  TIER A - FULL REVIEW.
      Which entries: every CONFLICTING entry; EVERY SUPERSEDED entry,
      whether the plan is deletion or a pointer; and the four
      pre-registered items.
      What W3C does: answers all five questions in scope section 8. The
      source text is quoted verbatim in the entry.
      Why: getting a conflict wrong writes a false statement into the
      document the whole project treats as authoritative. Retiring
      knowledge is high-risk whether it is deleted or merely pointed
      away from.

  TIER B - CLASSIFICATION CHECK.
      Which entries: every OPERATIVE-SPEC entry.
      What W3C does: ONE question only - is this really a specification
      the code implements, or is it background knowledge dressed as one?
      Why: "this document is just general guidance" is the exact
      judgement that caused the recorded incident. It is the single call
      this project has already got wrong, so it gets its own tier.

  TIER C - SPOT CHECK.
      Which entries: CURRENT-UNIQUE and CURRENT-DUPLICATE.
      What W3C does: the same five questions as Tier A, but only on the
      entries W3X SAMPLES. W3X selects; the designer does not choose
      which ones W3C sees.
      Why: you are checking whether the routine entries are as solid as
      the important ones, which is where hurried work shows first.
```

# 2. HOW a5 FALLS OUT - 33 C, 1 A, 0 B

```text
  TIER A   1 entry    LED-063, the only CONFLICTING entry
  TIER B   0 entries
  TIER C  33 entries

THERE ARE NO TIER B ENTRIES, AND THERE NEVER HAVE BEEN. The disposition
OPERATIVE-SPEC has not been used once in T1 - a2, a3, a4 and a5 all return
zero. That is worth knowing rather than assuming: it means the tier which
exists BECAUSE of the recorded incident has never once fired.
W3D does not read that as a defect yet. Sections 1-8 are codec facts,
geometry and evidence - none of it is a specification the code implements,
because Deblock4 has no kernel. THE PLACE TO WATCH IS T1S02/T1S03, the
README, which is where the recorded incident actually happened and where an
OPERATIVE-SPEC statement is most likely to be sitting misfiled as guidance.
If T1S03 also returns zero Tier B, that is a finding worth raising.
```

# 3. WORKED EXAMPLES OF EACH TIER

## TIER A - three real examples

```text
LED-063  (a5)  Section 8 says the detailed calibration record "remains in
               the W3C verification report". Section 24's reference R8 names
               that report, and no file of that name exists. CONFLICTING,
               and deliberately left unresolved because the other side of
               the conflict is in section 24, which belongs to a6.
LED-029  (a4)  The authority's section 23 orders step 8 - build the scalar
               oracle - before step 9 - decide the schedule - while line
               1153 says the schedule winner BECOMES PART OF that oracle.
               CONFLICTING. This one cost four review rounds.
LED-005  (a2)  An authority statement permitting T5 and T6 to be packaged
               together, against DEC-03 which requires T5 ratified alone.
               SUPERSEDED - and the ONLY SUPERSEDED entry in T1 so far.
```

## TIER B - none exist, so here is what one would look like

```text
A statement in the README such as a fixed-point threshold conversion table,
an immutable threshold set, or a canonical read ordering - text that reads
as background description but which the code actually implements. The
recorded incident is exactly this: README sections 3.11 and 3.13 held a
fully-worked ratified grid architecture that everyone treated as history.
The single question W3C would be asked is whether it is really a
specification, or knowledge dressed as one.
```

## TIER C - three real examples from a5

```text
LED-042  CURRENT-DUPLICATE. F4, the 4:2:0 chroma frame-organisation
         asymmetry - the single most-restated fact in the corpus. Claims
         STAY-CANONICAL and names the designer introduction as a concrete
         non-canonical copy.
LED-046  CURRENT-DUPLICATE. F8, vertical edges are geometry-invariant. The
         entry itself records that this is the weakest-evidenced of the
         eight facts and the one the whole architecture rests on.
LED-037  CURRENT-UNIQUE. The authority's own audit claim that its Schedule
         renaming is complete. W3D TESTED the claim rather than accepting
         it, and reported it true - so the thing for W3C to attack is the
         search, not the conclusion.
```

# 4. THE PART W3D MUST DECLINE, AND WHY

```text
W3X ASKED W3D TO NOMINATE CANDIDATES FOR THE TIER C SAMPLE. W3D SHOULD NOT
DO THAT, AND THE REASON IS THREE DAYS OLD.

Review scope section 6, Tier C: "W3X selects a random sample - THE DESIGNER
DOES NOT CHOOSE WHICH ONES YOU SEE."

This is not W3D being precious. DEC-62 records that a5's tier labels were
wrong on 31 of 34 entries because W3D had used the field as an importance
marker, effectively pre-selecting 23 entries for full review. That was the
reviewed party setting the depth of its own review. Nominating a sample now
would be the same act in a more direct form.

W3D CAN HONESTLY DO TWO THINGS INSTEAD, and both are below:
  (a) list ALL 33 Tier C entries with neutral one-line descriptors, so W3X
      can see what is there without W3D's opinion attached;
  (b) offer a MECHANICAL selection method that removes designer influence
      entirely, so nobody has to trust W3D's restraint.
```

# 5. ALL 33 TIER C ENTRIES - NEUTRAL LIST, NO RECOMMENDATION

```text
ENTRY     DISPOSITION        LINES     SUBJECT
LED-033   CURRENT-DUPLICATE  226-229   Section 1 - the document's stated purpose
LED-034   CURRENT-UNIQUE     231-240   Section 1 - the four-layer statement taxonomy
LED-035   CURRENT-DUPLICATE  242-244   Section 1 - Classic is not a Deblock4 design or acceptance basis
LED-036   CURRENT-DUPLICATE  246-259   Section 1.1 - the Schedule-SA/SB/SC renaming rule
LED-037   CURRENT-UNIQUE     261-265   Section 1.1 - the v1.04 naming-consistency audit claim
LED-038   CURRENT-DUPLICATE  272       Section 1.2 - the edge-position symbol `e`
LED-039   CURRENT-UNIQUE     273-275   Section 1.2 - the MPEG-2 coordinate symbols and the pitch generalisation
LED-040   CURRENT-DUPLICATE  278-279   Section 1.2 - the plane-relative chroma coordinate rule
LED-041   CURRENT-DUPLICATE  286-302   Section 2 - F1, F2 and F3, the block and macroblock composition facts
LED-042   CURRENT-DUPLICATE  304-308   Section 2 - F4, the 4:2:0 chroma frame-organisation asymmetry
LED-043   CURRENT-DUPLICATE  310-317   Section 2 - F5, dct_type semantics and the NO_DCT prohibition
LED-044   CURRENT-UNIQUE     319-323   Section 2 - F6, the post-decode knowledge limit
LED-045   CURRENT-DUPLICATE  325-327   Section 2 - F7, TFF/BFF is not a grid parameter
LED-046   CURRENT-DUPLICATE  329-332   Section 2 - F8, vertical edges are geometry-invariant
LED-047   CURRENT-UNIQUE     335-371   Section 2.1 - the H.262 provenance re-audit and its result
LED-048   CURRENT-DUPLICATE  377-399   Section 3 - the picture/syntax regime table
LED-049   CURRENT-DUPLICATE  401-415   Section 3.1 - the MediaInfo triage route
LED-050   CURRENT-UNIQUE     421-445   Section 4 - the scope statement and the horizontal footprint notation
LED-051   CURRENT-UNIQUE     447-499   Section 4.2 and 4.3 - frame-organised and field-organised luma geometry
LED-051a  CURRENT-DUPLICATE  500       Section 4.3 - TFF/BFF does not move the spatial row sets
LED-052   CURRENT-DUPLICATE  502-511   Section 4.4 - vertical luma edges, and the retirement of the parity-split description
LED-052a  CURRENT-UNIQUE     511-513   Section 4.4 - the retirement of the parity-split vertical description
LED-053   CURRENT-UNIQUE     519-529   Section 4.5 - 4:2:0 chroma geometry in chroma-plane coordinates
LED-053a  CURRENT-DUPLICATE  517       Section 4.5 - the chroma-plane coordinate declaration
LED-054   CURRENT-DUPLICATE  531-542   Section 4.6 - 4:2:2 and 4:4:4 chroma follow luma
LED-055   CURRENT-DUPLICATE  547-564   Section 5 - the SeparateFields tearing derivation
LED-056   CURRENT-UNIQUE     570-573   Section 6 - the measurement absorption statement
LED-057   CURRENT-DUPLICATE  575-606   Section 6.1 and 6.2 - the OTA and LG measurements
LED-058   CURRENT-DUPLICATE  609-625   Section 6.2 - REGIME 3, decision significance and evidence precision
LED-059   CURRENT-DUPLICATE  627-639   Section 6.3 - the corpus consequence
LED-060   CURRENT-UNIQUE     646-673   Section 7 - the prior-art records P1 to P4
LED-061   CURRENT-DUPLICATE  681-687   Section 8 - the GAIS calibration rule
LED-062   CURRENT-UNIQUE     690-708   Section 8 - retained reasoning ideas and the discredited citation set
```

# 6. A MECHANICAL WAY TO PICK THE SAMPLE

```text
The list above is in document order, which is not a property W3D chose - it
follows the authority's own section order. So an interval pick is already
designer-independent:

  EVERY THIRD ENTRY starting from the first  -> 11 entries
  EVERY THIRD starting from the second      -> 11 entries
  EVERY THIRD starting from the third       -> 11 entries

Pick a starting offset yourself and take every third. That yields a third
of the ledger, spread across all eight sections, with no possibility of W3D
having shaped it. If you prefer a smaller sample, every fourth gives 8.

ON SAMPLE SIZE, W3D DECLARES ITS INTEREST AND THEN GIVES THE REASONING.
A larger sample costs W3D more rework and finds more defects, so W3D wants
a smaller one and should not be trusted on the number. What the record says:
W3C has made six findings in this sub-tranche so far and NOT ONE was a wrong
disposition - all six were method, provenance or supply. The entries
themselves have not yet been tested at all. That argues for a sample large
enough to actually test them.

DO NOT TELL W3D WHICH ENTRIES ARE IN THE SAMPLE. Send it to W3C directly.
```

# 7. THE REMAINING OPEN QUESTIONS - WHEN W3D WILL BRING EACH BACK

```text
W3X has directed that each be clarified and recommended at the time it is
needed rather than all at once. W3D will raise each with a clarification, a
recommendation and a worked example where one helps:

  Q1   ratify the a5/a5b split          -> raised when a5b is scoped
  Q5   LED-059's conditional            -> raised when a6 is scoped, or
                                           earlier if W3C's review settles it
  --   T1S00 bumped, or amended by      -> raised at T1 closure, with the
       DEC-60/63/66 by reference?          full list of amendments-by-decision
  Q3   coordinate keys: pointer, or     -> raised at T3, with the three
       pointer-with-restatement            affected entries as the example
  Q2   Schedule collision routing       -> raised at T1S02/T1S03
  Q4   LG measurement provenance        -> now inside T8; raised there
  Q6   generalise the GAIS rule to any  -> raised after T1 closes, as a
       research instrument                 charter proposal under I7
  Q9   retire superseded T1 generations -> hygiene, W3X's convenience

Q7 withdrawn. Q10 -> T8. Q11 -> DEC-64, with W3C to verify the wording.
Q12 -> DECIDED: GAIS_investigations/ is evidence-only. Recorded at DEC-66.
```

---

*End of briefing. Nothing here is ratified.*
