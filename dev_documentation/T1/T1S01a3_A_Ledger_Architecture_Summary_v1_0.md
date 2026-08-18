# Deblock4 - T1S01a3 Ledger: the Architecture Summary and Header Statements

**Deliverable:** T1S01a3_A - LEDGER
**Version:** 1.0
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Step:** T1S01a, sub-tranche 3
**Document adjudicated:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Template:** review scope v1.8 - atomic claims, SWEPT field, canonical-home
CURRENT-DUPLICATE.
**Search frame:** the frozen 90-term set, manifest v1.4.

**THIS IS NOT THE FINAL SUB-TRANCHE OF THIS DOCUMENT.** T1S01a4 takes section
23's steps 6-10; T1S01a5 takes Appendix E and is the final one, where
cross-entry consistency is checked.

**Status:** PROPOSED ADJUDICATIONS. Nothing here is decided.
**Encoding:** US-ASCII; CRLF.

---

# 0. COVERAGE DECLARATION

```text
ADJUDICATED HERE, EXACTLY:
  section 0   the seventeen numbered items (lines 62-215), plus the
              TARGET-DEVICE REALITY block between items 4 and 5 (lines 84-104)
  header      the ratified-status declaration (lines 8-11); the single-source
              rule (13-22); the provenance-tag discipline (33-43); the
              closing GAIS statement (line 45)

ALREADY ADJUDICATED, NOT REPEATED:
  section 0   the STATUS AT date-stamp and next-work sentence -> LED-007
              the no-filtering prohibition -> LED-008
  header      the supersession/de-duplication paragraph -> LED-011

DEFERRED, ASSIGNED:
  section 23 steps 6-10, with the DEC-32 ordering finding -> T1S01a4
  Appendix E v1.04 down to v1.00                          -> T1S01a5
  sections 1-22 and Appendices A-D                        -> later sub-tranches
                                                             of T1S01a
```

---

# 1. THE GOVERNING FINDING - and the question it raises

Every one of the seventeen items is a **summary of a decision recorded formally
elsewhere in the same document**. Verified by tracing the decision tags:

```text
item 1  [D4-D01] -> also section 5 (a full derivation) and the D4-D register
                     at line 1609
item 6  [D4-D06] -> also the D4-D register at line 1633, and section 21's
                     fmParallel determinism basis at line 1732
item 7  [D4-D08] -> also the D4-D register at line 1641
item 9  [D4-D12] -> also sections 10 and 11 (the full topology mathematics)
item 12 [D4-D12] -> also section 11 (Architecture D in full)
item 13          -> also section 12 and Appendix C (the rejection proof)
```

So the strict answer for all seventeen is CURRENT-DUPLICATE. But that answer,
applied naively, would be actively harmful, and the reason is the substance of
this sub-tranche:

```text
SECTION 0 IS A DELIBERATE READ-FIRST SUMMARY. Its redundancy is its FUNCTION,
not an accident of drafting. Every orientation document in this project directs
a successor to read it FIRST precisely because it compresses a 1,983-line
document into something a cold reader can hold.

T3's job is to reduce DUPLICATED KNOWLEDGE to pointers. If T3 treats a designed
summary as accidental duplication and hollows it out, it destroys the thing
that makes the authority usable - and it would do so while following the rule
correctly.
```

**This is proposed as a distinction the disposition vocabulary does not
currently carry**, and it is raised rather than assumed. See the derived
proposition at LED-025.

---

# LED-013  Section 0 items 1-8 - the settled geometry and contract items

```text
DOCUMENT     authority v1.05, section 0, items 1-8, lines 62-121
CLAIM        item 1 whole-frame input only [D4-D01]; item 2 three source-mode
             semantics [D4-D02, F7]; item 3 4:2:0 Case-(a) chroma normative,
             4:2:2/4:4:4 follow luma [F4]; item 4 luma Case-(a) is the hard
             geometry [F5, F6]; item 5 vertical edges geometry-invariant at
             x=8k [D4-D12]; item 6 no hidden temporal state [D4-D06]; item 7
             Deblock4 gets its own oracle and proof chain [D4-D08]; item 8 v1
             filters nominal transform-grid blockiness only [D4-D09, D4-Q11].
ASSERTS      the settled input contract and geometry facts.
CLASS        W3X-RATIFIED; items 3 and 4 rest on H.262-VERIFIED findings.
DISPOSITION  CURRENT-DUPLICATE
REASON       All eight are current and correct. All eight restate decisions
             recorded formally elsewhere in this same document - the D4-D
             register at lines 1600-1660, and for item 1 the full derivation
             at section 5.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: the D4-D decision register and the body sections
             that derive each item, both inside THIS document.
             THIS COPY IS A DELIBERATE SUMMARY AND SHOULD STAY. It is not a
             stray duplicate in another document; it is this document's own
             read-first compression of itself. See LED-025.
             The copies in Project Status, both introductions, both blurbs and
             the concise summary ARE the non-canonical duplicates, and they
             are what T3 adjudicates.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-014  Section 0 - the TARGET-DEVICE REALITY block

```text
DOCUMENT     authority v1.05, section 0, lines 84-104
CLAIM        the LG recorder measured frame_pred_frame_dct = 0 in XP/SP/LP/EP;
             MLS measured 1 and supplies a uniform-frame-DCT control; this
             proves per-macroblock adaptation is PERMITTED and does NOT prove
             both dct_type values occur in every picture; mediainfo
             --Details=1 is picture-level triage, not per-MB truth.
ASSERTS      the target-device evidence and its exact limit.
CLASS        MEASURED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, correct, and unusually careful - the evidence limit is
             stated in the same breath as the evidence, which is why the claim
             has survived three chat generations without being overstated. It
             restates section 6.2 (the measurements) and section 3.1 (the
             triage route).
CONFLICTS    none.
PREVAILS     CANONICAL HOME: sections 6.2 and 3.1 of this document.
             THIS COPY STAYS as summary. The evidence-limit sentence in
             particular must survive any future compression: it is the
             difference between "B2 is warranted" and "B2 is proven
             necessary", and the project has repeatedly had to restate it.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-015  Section 0 items 9-11 - the B2 architecture summary

```text
DOCUMENT     authority v1.05, section 0, items 9-11, lines 128-163
CLAIM        item 9 the per-macroblock FRAME/FIELD/UNKNOWN classification and
             the full edge-topology table, including the four macroblock-row
             boundary cases and the UNKNOWN no-filter policy; item 10 where
             the map is produced and where geometry is fixed instead; item 11
             geometry-homogeneous spans as the SIMD scheduling unit, with
             classification never a per-lane branch.
ASSERTS      the primary candidate architecture in compressed form.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Item 9's topology table restates section 10's
             mathematics; item 11 restates section 19's SIMD consequences.
             NOTE what item 9 does that a pointer would not: it states the
             mixed FRAME/FIELD boundary as an EXPLICIT EDGE TYPE rather than a
             detector seam. That framing is the core of why B2 replaced
             Architecture B, and losing it to compression would lose the
             design's central idea.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: sections 10, 11 and 19 of this document.
             THIS COPY STAYS as summary.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-016  Section 0 item 12 - Architecture D, including its known approximation

```text
DOCUMENT     authority v1.05, section 0, item 12, lines 165-174
CLAIM        D's whole-frame topology without a classifier; that D is
             deterministic with no UNKNOWN state; that "an A-derived
             threshold-scaling IDEA may be measured here"; and that D's known
             approximation is using the conservative pitch-2 pair at
             FRAME/FRAME macroblock-row boundaries instead of the exact
             pitch-1 frame edge.
ASSERTS      the comparator architecture and its cost.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, restating section 11.
             TWO THINGS HERE MATTER BEYOND THE SUMMARY, and both were live in
             earlier adjudications. First, the threshold-scaling clause is
             where the surviving idea from rejected Architecture A actually
             lives - the outgoing designer flagged it as at risk of silent
             loss and it is NOT lost. Second, D's stated approximation at
             FRAME/FRAME boundaries is the quality cost that D's independent
             viability bar must measure; it is not a footnote.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: section 11 of this document, with D4-Q05 holding
             the threshold-scaling experiment question.
             THIS COPY STAYS as summary.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-017  Section 0 items 13-14 - the rejected architectures

```text
DOCUMENT     authority v1.05, section 0, items 13-14, lines 176-192
CLAIM        item 13 Architecture A is rejected, with four stated reasons -
             the union property depended on separated-field coordinates; a
             literal transposition tests the wrong frame-DCT edge; a faithful
             union double-writes at macroblock-row boundaries; the
             local-threshold false-activation tradeoff is irreducible in
             principle. Item 14 Architecture C remains rejected because static
             field-DCT material makes motion metrics ambiguous.
ASSERTS      what was rejected and why.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Item 13 compresses section 12 and Appendix C; item 14
             compresses section 9.4.
             RELEVANT TO THE EARLIER PR-1 ADJUDICATION: item 13's fourth
             reason - the irreducible false-activation tradeoff - is stated
             here as an A-rejection reason, exactly as it is in section 12.5.
             The general principle that constrains ALL architectures lives at
             section 13.1. This summary does not restate 13.1, which is
             consistent with 13.1 being the general rule and 12.5 its
             A-specific application.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: section 12 and Appendix C for A; section 9.4 for
             C. THIS COPY STAYS as summary.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-018  Section 0 items 15-16 - the Q14 gate and the no-forced-fallback rule

```text
DOCUMENT     authority v1.05, section 0, items 15-16, lines 194-211
CLAIM        item 15 the ground-truth discriminator experiment, what each leg
             is measured on, and that NO_DCT/skipped/motion-only macroblocks
             are their own truth class never fabricated into FRAME/FIELD
             labels. Item 16, marked [W3X-RATIFIED], the no-forced-binary
             rule: B2 if viable; else D if viable; else REOPEN - and that the
             experiment selects what enters kernel work, it cannot make an
             unimplemented filter ship.
ASSERTS      the architecture gate and its integrity rules.
CLASS        W3X-RATIFIED - item 16 carries the tag inline.
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, restating section 15.
             ITEM 15's TRUTH-CLASS RULE IS LOAD-BEARING and easy to lose in
             compression: fabricating a FRAME or FIELD label for a macroblock
             that has neither would corrupt the ground truth the whole
             experiment rests on.
             ITEM 16 IS THE SAFETY RULE the outgoing designer proposed and W3X
             ratified. It is the reason D must earn viability rather than
             inherit it.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: section 15 of this document.
             THIS COPY STAYS as summary.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-019  Section 0 item 17 - the still-open list

```text
DOCUMENT     authority v1.05, section 0, item 17, lines 213-215+
CLAIM        that luma kernel mathematics, exact footprint and eligibility,
             threshold design, the UNKNOWN-policy revisit, proper-chroma
             vertical siting and processing order remain OPEN after the
             architecture gate.
ASSERTS      what is NOT settled.
CLASS        PENDING
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, restating Appendix D.
             THIS IS THE MOST DANGEROUS ITEM IN SECTION 0 TO LOSE, and it is
             the one most likely to be dropped by a future compression,
             because a summary naturally keeps what IS decided. An open item
             that disappears from the read-first section becomes an open item
             a successor believes is settled.
             DIRECTLY RELEVANT TO DEC-32: "threshold design" being open is one
             half of W3C's second warning about section 23 step 7, which says
             to FREEZE thresholds before the later quality decision.
CONFLICTS    none here. The tension with section 23 step 7 is a section 23
             finding and belongs to T1S01a4.
PREVAILS     CANONICAL HOME: Appendix D of this document.
             THIS COPY STAYS as summary.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-020  Header - the ratified-status declaration

```text
DOCUMENT     authority v1.05, header, lines 8-11
CLAIM        "W3X-RATIFIED. PREVAILING SINGLE SOURCE OF TRUTH for MPEG-2
             deblocking matters in Deblock4. This v1.05 records the
             already-made W3X ratification of v1.04 and reconciles
             status/sequence wording only; it makes no new MPEG-2 algorithm or
             architecture decision."
ASSERTS      the document's authority status and the nature of the v1.05
             revision.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       Current. A document's own declaration of its authority status
             belongs in that document and is not a duplicate of anything -
             other documents POINT AT this status, which is a different act
             from restating it.
CONFLICTS    none.
PREVAILS     n/a.
SWEPT        To establish uniqueness: searched Project Status v1.29, the task
             register v1.11, both chat introductions and both blurbs for a
             statement DECLARING this document's status as opposed to
             REFERRING to it. All five refer; none declares. Terms used:
             "PREVAILING", "single source of truth", "W3X-RATIFIED",
             "authority" - frozen-frame groups 5 and 9 plus the phrase search.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-021  Header - the single-source rule

```text
DOCUMENT     authority v1.05, header, lines 13-22
CLAIM        verified MPEG-2 geometry, measurements, architecture mathematics,
             decisions, open questions and quality gates live HERE; other
             documents retain short pointers; GAIS captures and W3C reports
             are EVIDENCE not competing authorities; and "global project rules
             that are not MPEG-2-specific [...] remain in their existing
             authorities and are referenced rather than duplicated here."
ASSERTS      the document's own scope boundary, in both directions.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       Current, and load-bearing in a way that has already been
             exercised: this is the rule under which sections 0 and 23's
             sequencing statements were adjudicated as work-queue content
             that does not belong here. THE DOCUMENT SUPPLIED THE STANDARD BY
             WHICH IT WAS FOUND WANTING, which is the best possible reason to
             keep the rule exactly as written.
CONFLICTS    none. It is in TENSION with sections 0 and 23 carrying
             non-MPEG-2 work-queue content - but that tension is a defect in
             those sections, already ledgered at LED-003, LED-004 and LED-007,
             not a defect in this rule.
PREVAILS     n/a.
SWEPT        To establish uniqueness: searched the task register v1.11 and
             Project Status v1.29 for an equivalent statement of THIS
             document's scope boundary. The register states domain separation
             operationally in DEC-02's reasoning and DEC-24's; neither states
             the general rule. Terms: "single-source", "authority",
             "duplicated", "referenced", "boundary".
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-022  Header - the provenance-tag discipline

```text
DOCUMENT     authority v1.05, header, lines 33-43
CLAIM        the seven-tag vocabulary and its rules: [H.262-VERIFIED] read
             directly in authoritative ITU-T H.262 text by W3C and never
             sourced from GAIS; [SPEC-VERIFIED]; [SOURCE-VERIFIED];
             [MEASURED]; [DERIVED]; [PENDING]; [W3X-RATIFIED].
ASSERTS      how every factual claim in the document is to be traced.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       Current and, in this project, unusually valuable: it is what
             lets a reader distinguish a standards fact from a project
             inference at a glance, and the explicit "no such tag is sourced
             from GAIS" clause is what keeps external research from silently
             becoming authority.
CONFLICTS    none.
PREVAILS     n/a.
SWEPT        To establish uniqueness: searched the whole live corpus for the
             tag definitions, using the tag strings themselves as terms. The
             tags are USED in the D0 Binding Knowledge Index and referred to
             in the coder introduction, but DEFINED only here.
             NOTE FOR A LATER SUB-TRANCHE: because the tags are used
             elsewhere, retiring or renaming any tag would break those uses.
             That is a dependency, not a defect, and is recorded so a future
             adjudication does not treat the definitions as freely editable.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-023  Header - the closing GAIS statement

```text
DOCUMENT     authority v1.05, header, line 45
CLAIM        "Nothing in this document rests on unverified GAIS testimony."
ASSERTS      a completeness claim about the document's provenance.
CLASS        DERIVED
DISPOSITION  CURRENT-UNIQUE
REASON       Current as a statement of the document's own discipline.
             BUT NOTE WHAT KIND OF CLAIM IT IS: it asserts that a property
             holds across the WHOLE document. W3D has adjudicated roughly a
             tenth of the document so far and therefore CANNOT confirm it.
             It is recorded as current because there is no evidence against
             it, not because it has been verified.
CONFLICTS    none known.
PREVAILS     n/a.
SWEPT        To establish uniqueness: searched the corpus for an equivalent
             blanket provenance claim; found only pointers to this document's
             discipline.
             NOT SWEPT, AND THIS IS THE POINT: the claim's TRUTH has not been
             swept. Confirming it requires checking every factual assertion in
             1,983 lines against its provenance tag, which is exactly what the
             remaining sub-tranches of T1S01a do. FLAGGED FOR THE FINAL
             SUB-TRANCHE: this claim should be re-examined at T1S01a5 once the
             body has been adjudicated, and confirmed or qualified then.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-024  Derived proposition - designed summary versus accidental duplicate

## WHAT THE DESIGNER INFERRED

```text
DERIVED        The five dispositions cannot currently distinguish a DESIGNED
               SUMMARY from an ACCIDENTAL DUPLICATE, and T3 will act on that
               distinction whether or not the vocabulary carries it.

               Section 0 restates decisions recorded formally elsewhere in the
               same document. Strictly that is CURRENT-DUPLICATE. But its
               redundancy is its FUNCTION: it is the read-first compression
               that every orientation document in the project points a cold
               successor at. Reducing it to pointers would follow the rule
               correctly and destroy the document's usability.

               PROPOSED, for W3X to decide and not for W3D to adopt: when an
               entry is CURRENT-DUPLICATE and this copy is NOT the canonical
               home, the entry must additionally state whether the copy is
               DESIGNED (a deliberate summary, index or orientation
               restatement that stays) or INCIDENTAL (drift, to be reduced to
               a pointer by T3). Ten entries in this sub-tranche alone need
               that field.

DERIVED-BASIS  Traced six of the seventeen items to their formal homes by
               decision tag - D4-D01 to section 5 and the register at line
               1609, D4-D06 to line 1633, D4-D08 to line 1641, D4-D12 to
               sections 10/11, item 13 to section 12 and Appendix C - and
               found every one restated. So the duplication is systematic, not
               occasional, and section 0's entire purpose is to be that
               restatement.
               The corrected CURRENT-DUPLICATE rule in scope v1.8 asks which
               copy survives. It does not ask WHY a non-canonical copy might
               legitimately survive, which is the question section 0 poses.

               LIMIT: this is a proposal about the disposition vocabulary,
               made from one sub-tranche, and it changes a criterion applied
               to W3D's own ledger - charter I7 shape. W3D recommends W3C
               verify it independently before W3X decides, and recommends NOT
               applying it retroactively to the entries above, which stand or
               fall on their stated canonical homes regardless.
```

```text
TIER     A (carries a derived proposition)
VERDICT  [W3C]
```

---

# What W3C is asked here

```text
1. THE COVERAGE DECLARATION AT SECTION 0 IS THE FIRST THING TO CHECK, since
   that is what failed last time. Is every statement in the declared ranges
   either ledgered or explicitly assigned onward?

2. THREE ENTRIES CARRY SWEPT FIELDS (LED-020, LED-021, LED-022) and one
   carries a deliberately PARTIAL one (LED-023, where the claim's truth is
   explicitly NOT swept). Attack the searches. LED-023 in particular: is
   recording a blanket provenance claim as CURRENT-UNIQUE acceptable when its
   truth is unverified, or should it carry a different disposition until
   T1S01a5 confirms it?

3. THE DESIGNED-VERSUS-INCIDENTAL PROPOSAL AT LED-024 is the substance of this
   sub-tranche. If the distinction is unnecessary - if T3 can be trusted to
   see that a read-first summary should stay - say so, because adding a field
   to every duplicate entry is not free.

4. LED-013 through LED-019 all take the same disposition and the same
   canonical-home form. That uniformity is either correct or a sign that
   seventeen items were adjudicated with one judgement. Test at least one item
   against its stated home independently.
```

---

*Revision history*
```text
v1.0 (2026-08-18) First issue of T1S01a3. Adjudicates section 0's seventeen
     numbered architecture items, the target-device evidence block, and the
     header's ratified-status declaration, single-source rule, provenance-tag
     discipline and closing GAIS statement. Seven CURRENT-DUPLICATE with
     canonical homes inside this same document, four CURRENT-UNIQUE with SWEPT
     fields, one derived proposition asking whether the disposition vocabulary
     must distinguish a designed summary from an accidental duplicate. Not the
     final sub-tranche.
```
