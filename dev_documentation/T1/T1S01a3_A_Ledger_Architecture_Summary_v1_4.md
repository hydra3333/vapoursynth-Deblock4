# Deblock4 - T1S01a3 Ledger: the Architecture Summary and Header Statements

**Deliverable:** T1S01a3_A - LEDGER
**Version:** 1.4 - as v1.3, PLUS a designer error in LED-020a corrected
**Date:** 2026-08-18
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Step:** T1S01a, sub-tranche 3
**Document adjudicated:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Template:** review scope v1.9 - atomic claims, SWEPT field, canonical-home
CURRENT-DUPLICATE.
**Search frame:** the frozen 90-term set, manifest v1.4.

**WHY THIS WAS REISSUED.** v1.0 proposed a new duplicate-handling exception,
wrote that it must not be applied retroactively, and had ALREADY APPLIED IT in
seven entries' PREVAILS fields, which said "THIS COPY STAYS as summary" - an
outcome possible only under a rule W3X had not ratified. W3C found it. That is
derived reasoning leaking into the findings half, the exact failure the
two-part template exists to prevent, and the fourth instance of this designer
asserting a conclusion the evidence in front of it did not yet support.
The rule has since been ratified in W3C's wording, not W3D's, as review scope
v1.9 section 5.4 RETAIN-SUMMARY. Every affected entry below now carries an
explicit DUPLICATE-ACTION field resting on that ratified rule.

**WHY v1.4 EXISTS.** v1.3 was built but never issued. While it sat with the
designer, W3D reported the reversed T1/T5 sequence in Appendix E as a fresh
find and proposed assigning it to T1S01a5. It was already adjudicated in
T1S01a2 - at LED-012, whose proposed action is DO NOT TOUCH, and whose own
text says it was flagged precisely so a later sweep would not pattern-match
the phrase and rewrite history. The designer swept the specification and did
not sweep the decision record, which is the other half of the standing rule.
LED-020a's SWEPT field is corrected accordingly. NOTHING ELSE CHANGED FROM
v1.3, and no entry other than LED-020a differs in any field.

**WHAT v1.3 CHANGED, AND WHAT IT DID NOT.** W3C reviewed v1.2 and PASSED
every question it was asked - coverage, the seven genuine RETAIN-SUMMARY
uses each tested against the three conditions separately, the
per-proposition canonical homes, the two changed dispositions, the swept
fields, and the uniformity of LED-013 to LED-019, which it checked by
sampling propositions across seven subject areas. Three narrow corrections
came back and all three are applied here:

```text
1. LED-020 and LED-021 are relabelled STAY-CANONICAL. W3C confirmed W3D's
   reading of the ledger's own question 2: a copy that IS the canonical
   home does not need the RETAIN-SUMMARY exception. W3C then found the
   cause - the action vocabulary had no value for the canonical case - and
   W3X ratified STAY-CANONICAL at review scope v1.10, with the requirement
   W3D added as verifier that an entry claiming it must NAME WHERE THE
   NON-CANONICAL COPIES ARE. Both entries do.
2. LED-020 is SPLIT. It carried two propositions with two different
   canonical homes and two different actions. Mapping them per proposition
   inside one entry is not a substitute for splitting under the
   atomic-claim rule. The revision-nature proposition is now LED-020a.
3. LED-013 item 2's canonical home is refined: the RETIREMENT IN PRINCIPLE
   of `mpeg2_field_separated` maps to D4-Q16 as well as the token
   spelling.
```

Nothing else moved. LED-013's disposition, LED-014 to LED-019 entire,
LED-021 apart from its action label, LED-022, LED-023 and LED-024 are
unchanged from v1.2.

**WHY v1.2 EXISTED, AND WHAT IT DID NOT TOUCH.** v1.1 rewrote the entries and
the header and left the closing section as it stood in v1.0, where it still
asked W3C to settle two questions this document had already settled - whether
LED-023 should stay CURRENT-UNIQUE, which LED-023 itself withdraws, and whether
the designed-versus-incidental distinction is needed, which LED-024 records as
closed and superseded by the ratified RETAIN-SUMMARY rule. As written it
invited the independent reviewer to reopen two W3X ratifications. v1.2 replaces
that section and NOTHING ELSE: no disposition, claim, reason, conflict,
prevails, swept, canonical home, duplicate-action or derived field differs from
v1.1. W3C does not need to re-review the entries it has not yet seen changed.

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

**At v1.0 this was proposed as a distinction the vocabulary did not carry.** It
has since been SETTLED: W3X ratified the RETAIN-SUMMARY exception in W3C's
wording at review scope v1.9 section 5.4, and every affected entry below now
carries a DUPLICATE-ACTION field resting on that ratified rule. The derived
proposition is at LED-024. (v1.0 pointed at "LED-025", which does not exist -
W3C caught it.)

---

# LED-013  Section 0 items 1-8 - the settled geometry and contract items

```text
DOCUMENT     authority v1.05, section 0, items 1-8, lines 62-121
CLAIM        item 1 whole-frame input only, SeparateFields not a supported
             MPEG-2 contract because it tears frame-organised transform blocks
             between two clips [D4-D01].
             item 2 three source-mode semantics - progressive, frame
             picture/interlaced Case (a), field pictures Case (b) - AND that
             exact public tokens remain a D4-Q16 decision, AND that the
             `mpeg2_field_separated` name is retired in principle, AND that
             TFF/BFF is not a grid parameter because field order does not move
             transform-block boundaries [D4-D02, F7].
             item 3 4:2:0 Case-(a) chroma is normative not detected, staying
             frame-organised even under field-DCT luma; 4:2:2 and 4:4:4 FOLLOW
             luma organisation and cannot inherit that simplification [F4].
             item 4 luma Case-(a) is the hard geometry - dct_type is
             macroblock-level, may vary within one frame picture, and is
             invisible to a post-decode filter absent trusted side data
             [F5, F6].
             item 5 vertical transform-block edges are geometry-invariant,
             frame-vs-field DCT changes HORIZONTAL row adjacency only, luma
             vertical boundaries stay at x = 8*k, no parity split or DCT-phase
             classification is required for vertical luma, AND the same
             principle applies to plane-relative vertical block boundaries in
             chroma [D4-D12].
             item 6 no hidden temporal state in v1; detector output is a pure
             function of the frame, its immutable parameters and the declared
             source mode; no hysteresis under fmParallel [D4-D06].
             item 7 Deblock4 gets its own oracle, mathematics and proof chain;
             Classic supplies engineering patterns only, and Classic code,
             thresholds, formulas and acceptance evidence are not a Deblock4
             design or acceptance basis [D4-D08].
             item 8 v1 filters nominal transform-grid blockiness only; motion-
             predicted or inherited blockiness shifted off the nominal grid is
             a documented limitation [D4-D09, D4-Q11].
             (EXPANDED at v1.1: v1.0's CLAIM compressed away item 2's D4-Q16
             token deferral, the retirement-in-principle and the TFF/BFF rule,
             and item 5's plane-relative chroma consequence. W3C found the
             omissions. A CLAIM must visibly account for every material
             proposition in a declared item.)
ASSERTS      the settled input contract and geometry facts.
CLASS        W3X-RATIFIED; items 3 and 4 rest on H.262-VERIFIED findings.
DISPOSITION  CURRENT-DUPLICATE
REASON       All eight are current and correct. All eight restate decisions
             recorded formally elsewhere in this same document - the D4-D
             register at lines 1600-1660, and for item 1 the full derivation
             at section 5.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION - v1.0 named "the register and
             the body sections" generically, which the corrected rule
             forbids:
                 item 1 -> section 5 (the tearing derivation) and D4-D01 in
                           the decision register
                 item 2 -> D4-D02 and F7; BOTH the token-spelling question
                           AND the retirement in principle of
                           `mpeg2_field_separated` -> D4-Q16, whose own
                           text requires that no public name invite
                           SeparateFields input, which IS that retirement
                           (REFINED at v1.3; W3C found the narrower
                           mapping)
                 item 3 -> F4
                 item 4 -> F5 and F6
                 item 5 -> D4-D12, with sections 10-11 for the topology
                 item 6 -> D4-D06, with section 21 for the fmParallel basis
                 item 7 -> D4-D08
                 item 8 -> D4-D09, with D4-Q11 for the open question
DUPLICATE-ACTION  RETAIN-SUMMARY
             Justified under review scope v1.9 section 5.4: section 0 is an
             explicitly designated read-first layer INSIDE this canonical
             authority; each proposition's canonical source is named above;
             and the summary introduces no unique normative content - every
             clause traces to a source clause.
             The copies in Project Status, both introductions, both blurbs and
             the concise summary are OUTSIDE the authority, are non-canonical,
             and are POINTER candidates for T3.
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
PREVAILS     CANONICAL HOME, PER PROPOSITION:
                 the LG/MLS measurements -> section 6.2
                 the mediainfo triage route -> section 3.1
                 the evidence LIMIT -> section 6.2, which states the same
                     precision distinction
DUPLICATE-ACTION  RETAIN-SUMMARY
             The evidence-limit sentence in particular must survive any future
             compression: it is the difference between "B2 is warranted" and
             "B2 is proven necessary", and the project has repeatedly had to
             restate it. W3C independently confirmed section 6.2 makes the
             same distinction, so the summary adds nothing normative.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-015  Section 0 items 9-11 - the B2 architecture summary

```text
DOCUMENT     authority v1.05, section 0, items 9-11, lines 128-163
CLAIM        item 9 per-macroblock FRAME/FIELD/UNKNOWN classification with
             confidence, and the full edge-topology table: internal edge at
             mb_y+8 (FRAME one pitch-1 edge, FIELD none, UNKNOWN none and
             counted); macroblock-row boundary at mb_y+16 per 16-pixel x
             segment (FRAME/FRAME one pitch-1; FIELD/FIELD two pitch-2 parity;
             FRAME/FIELD and FIELD/FRAME two pitch-2 MIXED-BOUNDARY edges;
             UNKNOWN involved -> D4-D07 no filtering, counted, revisit after
             Q14) - and that the mixed boundary is an EXPLICIT EDGE TYPE, not
             a detector seam.
             item 10 where the map is produced and where geometry is fixed
             instead: progressive fixed frame; Case (b) fixed field; Case (a)
             luma detector; Case (a) 4:2:0 chroma fixed frame from F4; Case
             (a) 4:2:2/4:4:4 chroma FOLLOW resolved luma with no independent
             chroma detector.
             item 11 geometry-homogeneous spans as the SIMD scheduling unit;
             classification never a per-lane SIMD branch; AND that horizontal
             span descriptors carry at least PLANE, X BOUNDS, EDGE ROW, EDGE
             KIND, PITCH and PARITY where applicable; AND that vertical work
             does not gain a fake pitch-2/parity split merely because
             neighbouring luma macroblocks were field-DCT.
             (EXPANDED at v1.1: v1.0 omitted item 11's descriptor contents and
             the no-fake-split rule. W3C found it and is right that these are
             implementation-facing architecture requirements, not decoration.)
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
PREVAILS     CANONICAL HOME, PER PROPOSITION:
                 item 9's topology table -> section 10
                 item 9's UNKNOWN policy -> D4-D07
                 item 10's map-production rules -> section 10, with F4 for
                     the 4:2:0 chroma case
                 item 11's spans, descriptors and no-fake-split rule ->
                     section 19
DUPLICATE-ACTION  RETAIN-SUMMARY
             Note what the summary does that a bare pointer would not: it
             states the mixed FRAME/FIELD boundary as an EXPLICIT EDGE TYPE.
             That framing is why B2 replaced Architecture B, and it is a
             restatement of section 10, not new normative content.
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
PREVAILS     CANONICAL HOME, PER PROPOSITION:
                 D's detector-free topology and its FRAME/FRAME pitch-2
                     approximation -> section 11
                 the A-derived threshold-scaling experiment idea -> D4-Q05
DUPLICATE-ACTION  RETAIN-SUMMARY
             W3C independently confirmed section 11 carries all four
             propositions and that D4-Q05 keeps the threshold-scaling idea
             open without preserving the old parameter name.
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
PREVAILS     CANONICAL HOME, PER PROPOSITION - and W3C is right that a
             DECISION home and its supporting PROOF are different things:
                 the A rejection DECISION -> section 12
                 the A rejection PROOF/derivation -> Appendix C
                 A's local false-activation application -> section 12.5
                 the GENERAL no-implicit-geometry-classifier principle ->
                     section 13.1 - NOT summarised in item 13, which is
                     correct and consistent with the earlier PR-1 correction
                 the C rejection -> section 9.4
DUPLICATE-ACTION  RETAIN-SUMMARY
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
PREVAILS     CANONICAL HOME, PER PROPOSITION:
                 the experiment design and both measurement legs -> section 15
                 the truth-class rule (NO_DCT/skipped/motion-only are their
                     own class, never fabricated into FRAME/FIELD) -> section
                     15
                 the no-forced-fallback decision rule -> section 15.3
DUPLICATE-ACTION  RETAIN-SUMMARY
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-019  Section 0 item 17 - the still-open list

```text
DOCUMENT     authority v1.05, section 0, item 17, lines 213-215+
CLAIM        that ALL TWELVE of the following remain OPEN after the
             architecture gate: luma kernel mathematics; exact luma
             footprint/eligibility; threshold design; the UNKNOWN-policy
             revisit; proper-chroma vertical siting; the processing-order
             Schedule-SA vs Schedule-SB quality winner; the proper-chroma
             QUALITY GATE; pipeline guidance; the SIDE-DATA INTERFACE; the
             FINAL PUBLIC PARAMETER/PROPERTY SURFACE; the SCALAR ORACLE; and
             the LATER SIMD BACKENDS.
             (EXPANDED at v1.1. v1.0 stopped after processing-order and
             silently dropped the last six. W3C called this the worst omission
             in the tranche and is right: item 17's entire purpose is stopping
             a successor believing open work is settled, and truncating the
             list of open work is the one error that does exactly the harm the
             item exists to prevent.)
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
PREVAILS     CANONICAL HOME: Appendix D of this document, which holds the
             open-items register in full.
DUPLICATE-ACTION  RETAIN-SUMMARY
             This is the entry where RETAIN-SUMMARY earns itself. A pointer
             saying "see Appendix D for open items" in the read-first section
             would be strictly correct and would lose the thing that matters -
             a successor scanning section 0 seeing, without a second lookup,
             that the scalar oracle and the public parameter surface are NOT
             settled.
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
ASSERTS      the document's authority status.
             (NARROWED at v1.3. The second proposition in the quoted sentence -
             what the v1.05 revision did - is now LED-020a. See below.)
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
             (CORRECTED at v1.1 from CURRENT-UNIQUE.)
REASON       Current, but NOT unique. W3D invented a distinction between
             DECLARING the status and REFERRING to it, and no such distinction
             exists in the five disposition definitions - which say plainly not
             to call a statement unique merely because this is its correct home
             while it also appears elsewhere. The coder introduction v1.32,
             both blurbs and Project Status v1.30 all restate that this
             W3X-ratified document is the prevailing MPEG-2 authority and
             single source of truth. W3C found this.
             SPLIT AT v1.3: v1.2 recognised that this entry bundled a
             second proposition and mapped the two homes separately inside one
             entry. W3C's finding is that recognising the bundle is not the
             same as splitting it - the atomic-claim rule requires two
             entries, and per-proposition mapping inside one entry is a second
             disposition hiding in a field. The revision-nature proposition is
             now LED-020a.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this authority header. A document's declaration
             of its own status belongs in that document.
DUPLICATE-ACTION  STAY-CANONICAL (CORRECTED at v1.3 from RETAIN-SUMMARY; this
             copy IS the home, so it stays because it is canonical, not by
             exception - review scope v1.10 section 5.4a).
             THE NON-CANONICAL COPIES, named as that rule requires: the coder
             introduction, the designer introduction, both chat blurbs and
             Project Status all restate that this W3X-ratified document is the
             prevailing MPEG-2 authority. All are outside the authority, all
             are non-canonical, and all are POINTER candidates for T3.
SWEPT        WITHDRAWN. The v1.0 search looked for a distinction that is not in
             the rules, so it could not have established anything. The correct
             search was for the PROPOSITION, and it appears in at least four
             live documents.
```

```text
TIER     C
VERDICT  [W3C]
```

---

# LED-020a  Header - what the v1.05 revision did

```text
DOCUMENT     authority v1.05, header, lines 9-11
CLAIM        "This v1.05 records the already-made W3X ratification of v1.04
             and reconciles status/sequence wording only; it makes no new
             MPEG-2 algorithm or architecture decision."
ASSERTS      the NATURE of the v1.05 revision - what it did and, more
             importantly, what it did not do.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
             (NEW ENTRY at v1.3, split out of LED-020 under the atomic-claim
             rule. It is a different proposition, with a different canonical
             home and a different action, and one disposition cannot cover
             both.)
REASON       Current and accurate. But a statement about what a particular
             revision changed is REVISION HISTORY, and this document keeps its
             revision history in Appendix E, which carries the same
             characterisation of v1.05.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: Appendix E, the document's own revision history.
             The header copy is a non-canonical restatement.
DUPLICATE-ACTION  POINTER. It does not qualify for RETAIN-SUMMARY: the header
             is not a designated summary, index or orientation layer - section
             0 is - so the narrow exception at review scope 5.4 does not
             reach it.
             NOTE FOR T3, and the reason this is not a mechanical strip: a
             reader arriving at a ratified authority reasonably wants to know
             at the top whether the current revision changed any decision. If
             T3 reduces this to a pointer, the pointer should be specific -
             naming Appendix E - rather than a bare cross-reference.
SWEPT        The proposition's other home was established by reading Appendix
             E's v1.05 entry cold. It carries the same characterisation -
             "RATIFICATION-RECORDING / HANDOFF-CURRENCY ONLY [...] No geometry,
             architecture, mathematics or acceptance decision changed".
             AND THE LEDGER SET WAS SWEPT, WHICH IS WHERE THE FIRST ATTEMPT
             AT THIS ENTRY WENT WRONG. v1.3 reported that the same Appendix E
             entry also describes the reversed T1/T5 sequence, and treated
             that as an unadjudicated find to be assigned onward. IT IS
             ALREADY ADJUDICATED, in T1S01a2, which W3C has passed:
                 LED-012  the Appendix E sentence. CURRENT-UNIQUE, PROPOSED
                          ACTION NONE - DO NOT TOUCH. A revision-history
                          entry states what a revision DID on the day; it
                          stays true however often the sequence is later
                          reversed, and superseding it would falsify the
                          record. It was flagged there expressly so a later
                          sweep would not pattern-match the phrase and
                          rewrite history.
                 LED-003  the live section 23 paragraph. CONFLICTING against
                          register DEC-02, with a pointer remedy proposed and
                          W3C's qualification adopted that the same
                          paragraph's authority-boundary sentence must not be
                          deleted by a wholesale replacement.
             So there is nothing here to assign onward and nothing for
             T1S01a5 to inherit on this point. It does not affect this entry
             either way: the header copy asserts only what v1.05 did, and its
             home saying MORE than the copy is normal for a POINTER.
             NOT SWEPT: whether the same claim is restated OUTSIDE this
             document. That is T1S01a5 territory, where Appendix E itself is
             adjudicated, and the disposition here does not depend on the
             answer.
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
DISPOSITION  CURRENT-DUPLICATE
             (CORRECTED at v1.1 from CURRENT-UNIQUE.)
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
PREVAILS     CANONICAL HOME: this authority header. A document's statement of
             its own scope boundary belongs in that document, and this rule in
             particular supplied the standard by which sections 0 and 23 were
             found wanting.
DUPLICATE-ACTION  STAY-CANONICAL (CORRECTED at v1.3 from RETAIN-SUMMARY;
             this copy IS the home - review scope v1.10 section 5.4a).
             THE NON-CANONICAL COPIES, named as that rule requires: the
             operative single-source and pointer-only restatements in the coder
             introduction, the designer introduction, both chat blurbs and
             Project Status. All are outside the authority and are T3
             candidates.
SWEPT        INADEQUATE, AND WITHDRAWN AS A UNIQUENESS BASIS. The v1.0 search
             covered only the task register and Project Status v1.29 - a
             SUPERSEDED generation, with v1.30 live - and omitted the
             orientation documents entirely. W3C found both faults. The
             operative propositions are restated in the coder introduction,
             both blurbs and Project Status v1.30.
             THIS IS THE SWEPT FIELD DOING ITS JOB: the search was recorded,
             so the reviewer could attack the search rather than only the
             conclusion, and did.
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
DISPOSITION  DEFERRED TO T1S01a5 - NO DISPOSITION PROPOSED AT THIS TRANCHE.
             (CHANGED at v1.1. v1.0 proposed CURRENT-UNIQUE while admitting
             the claim's truth was unverified. W3C returned UNSURE and is
             right: CURRENT-UNIQUE requires the statement to be TRUE, not
             merely un-contradicted. No sixth disposition is invented; the
             entry stays open until the sweep can settle it.)
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
               a pointer by T3). Seven entries here are CURRENT-DUPLICATE and
               need such a field. (v1.0 said ten; W3C caught the miscount.)

               SETTLED AGAINST THIS PROPOSAL, AND CORRECTLY. W3C rejected the
               DESIGNED / INCIDENTAL axis: a stale duplicate can be
               deliberately designed too, so authorial intent is the wrong
               test. What matters is whether the copy has an APPROVED
               CONTINUING ROLE. W3C also showed the de-duplication danger was
               overstated - T3's actual wording strips duplicates out of OTHER
               documents into pointers to the authority, and never instructed
               anyone to hollow out the authority's own summary.
               W3X ratified W3C's narrower RETAIN-SUMMARY wording at review
               scope v1.9 section 5.4. This proposition is CLOSED; it is
               retained only as the record of how the rule was reached.

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

Your second review passed every question v1.2 asked. This version applies your
three corrections, so what is left is narrow.

```text
1. DID THE THREE CORRECTIONS LAND AS YOU MEANT THEM?
     - LED-020 and LED-021 now read STAY-CANONICAL, each naming where the
       non-canonical copies are, as the ratified rule now requires;
     - LED-020a is the split-out revision-nature proposition, CURRENT-
       DUPLICATE with Appendix E as its canonical home and POINTER as its
       action;
     - LED-013 item 2 now maps the retirement in principle to D4-Q16 as well
       as the token spelling.

2. LED-020a IS A NEW ENTRY AND HAS NOT BEEN REVIEWED BY ANYONE. It is the
   only genuinely new adjudication in this version. Its POINTER action is the
   part to attack: is the header really NOT a designated summary layer for
   this purpose, or is that too clean a line? Section 0 is designated; the
   header block is not, and this entry rests on that distinction.

3. ONE THING THE NAMING REQUIREMENT MAY EXPOSE. Both STAY-CANONICAL entries
   now name their non-canonical copies. If either list is wrong or short,
   that is a finding - and under the new rule a STAY-CANONICAL entry whose
   named copies do not actually exist has not shown the statement is a
   duplicate at all, which would put the DISPOSITION back in question rather
   than only the action.

4. NOTHING ELSE CHANGED from v1.2, which you have already reviewed:
   LED-013's disposition, LED-014 to LED-019 entire, LED-021 apart from its
   action label, LED-022, LED-023 and LED-024. You do not need to re-read
   them.
```

---

*Revision history*
```text
v1.4 (2026-08-18) CORRECTS A DESIGNER ERROR IN LED-020a's SWEPT FIELD, before
     v1.3 was ever issued. v1.3 reported the reversed T1/T5 sequence in
     Appendix E as an unadjudicated find and assigned it to T1S01a5. It is
     already adjudicated in T1S01a2 - LED-012 (Appendix E sentence:
     CURRENT-UNIQUE, action NONE, do not touch, because a revision-history
     entry records what a revision did and stays true however often the
     sequence is later reversed) and LED-003 (the live section 23 paragraph:
     CONFLICTING, pointer remedy proposed). W3C had already passed both.
     LED-012's own text records that it was flagged to stop a later sweep
     pattern-matching the phrase and rewriting history; the designer did
     exactly that anyway.
     NO OTHER ENTRY DIFFERS FROM v1.3 IN ANY FIELD.
v1.3 (2026-08-18) Applies the three corrections from W3C's second review.
     (a) LED-020 and LED-021 relabelled STAY-CANONICAL. W3C confirmed the
     reading v1.2 put to it - a canonical-home copy does not need the
     RETAIN-SUMMARY exception - then found the cause, which was that the
     action vocabulary had no value for the canonical case at all. W3X
     ratified STAY-CANONICAL at review scope v1.10, with the requirement
     W3D added as verifier that an entry claiming it must name where the
     non-canonical copies are. Both entries now do.
     (b) LED-020 SPLIT, and LED-020a created for the revision-nature
     proposition. v1.2 recognised the bundle and mapped the two homes
     inside one entry; W3C's finding is that recognising a bundle is not
     splitting it, and per-proposition mapping inside one entry is a
     second disposition hiding in a field. LED-020a is numbered with a
     suffix rather than as LED-025 deliberately: v1.0 contained a pointer
     to a non-existent LED-025 that W3C caught, and creating one now would
     make that correction unreadable.
     (c) LED-013 item 2's canonical home refined so the retirement in
     principle of `mpeg2_field_separated` maps to D4-Q16 alongside the
     token spelling. Verified cold against the authority: D4-Q16's own
     text requires that no public name invite SeparateFields input, which
     is that retirement.
     THE ONLY NEW ADJUDICATION IS LED-020a. Everything else is a relabel,
     a split of existing content, or a mapping refinement, and no other
     entry's disposition, claim, reason, conflict, prevails or swept field
     changed.
v1.2 (2026-08-18) CLOSING SECTION ONLY. NO ENTRY CHANGED FROM v1.1 - no
     disposition, claim, reason, conflict, prevails, swept, canonical home,
     duplicate-action or derived field differs, and W3C need not re-review
     them on that account.
     WHAT WAS WRONG: v1.1 rewrote the entries and the header and left the
     closing section arguing the pre-reissue position. It still asked W3C
     whether LED-023 should stay CURRENT-UNIQUE, which LED-023 in the same
     document had already withdrawn, and called the designed-versus-
     incidental proposal 'the substance of this sub-tranche' when LED-024
     records it as closed and superseded by W3C's ratified wording. A
     reviewer answering either in good faith would have produced findings
     contradicting a W3X ratification.
     WHAT REPLACED IT: six questions aimed at what is actually most likely
     to be wrong - the coverage declaration, the first use of the newly
     ratified RETAIN-SUMMARY rule, the new per-proposition canonical homes,
     the two changed dispositions, the swept fields, and the uniformity of
     LED-013 to LED-019. The two settled questions are removed, not
     softened.
     ONE NEW MATTER RAISED RATHER THAN FIXED: LED-020 and LED-021 assert
     that the copy IS the canonical home while also carrying
     DUPLICATE-ACTION: RETAIN-SUMMARY, which on one reading of the ratified
     rule is an exception those entries do not need. W3D did not correct it,
     because the rule is W3C's and the correction would be the designer
     adjudicating a criterion applied to its own ledger (charter I7 shape).
     It is question 2 to W3C.
     PATTERN NOTE, recorded because it is the fifth instance and the third
     since the countermeasures: the designer updated what it was thinking
     about and left the framing text behind. Found by the successor
     designer, not by the author and not by a rule.
v1.1 (2026-08-18) Reissued after W3C's review. THE METHOD DEFECT: v1.0
     proposed a duplicate-handling exception, stated it must not be applied
     retroactively, and had already applied it in seven entries' PREVAILS
     fields - derived reasoning leaking into the findings half, and the fourth
     instance of this designer asserting a conclusion the evidence did not yet
     support. The rule is now ratified in W3C's wording (review scope v1.9
     section 5.4 RETAIN-SUMMARY) and every affected entry carries an explicit
     DUPLICATE-ACTION field resting on it.
     CLAIMS EXPANDED where v1.0 compressed away material propositions:
     LED-013 (item 2's D4-Q16 token deferral, retirement-in-principle and the
     TFF/BFF rule; item 5's plane-relative chroma consequence), LED-015 (item
     11's span descriptor contents and the no-fake-pitch2/parity rule),
     LED-019 (item 17's last six open items - the worst omission in the
     tranche, since truncating a list of open work does exactly the harm that
     item exists to prevent).
     CANONICAL HOMES now mapped PER PROPOSITION rather than named as a cloud
     of possible sections, per the corrected rule.
     DISPOSITIONS CORRECTED: LED-020 and LED-021 from CURRENT-UNIQUE to
     CURRENT-DUPLICATE - W3D had invented a "declare versus refer" distinction
     absent from the definitions, and LED-021's SWEPT had searched a
     superseded Project Status generation while omitting the orientation
     documents entirely. LED-023's disposition WITHDRAWN and deferred to
     T1S01a5, since CURRENT-UNIQUE requires a statement to be TRUE and this
     blanket provenance claim is merely un-contradicted.
     Two clerical errors fixed: a pointer to a non-existent LED-025, and a
     miscount of ten entries where seven are CURRENT-DUPLICATE.
     Eleven of the twelve corrections came from W3C.
v1.0 (2026-08-18) First issue of T1S01a3. Adjudicates section 0's seventeen
     numbered architecture items, the target-device evidence block, and the
     header's ratified-status declaration, single-source rule, provenance-tag
     discipline and closing GAIS statement. Seven CURRENT-DUPLICATE with
     canonical homes inside this same document, four CURRENT-UNIQUE with SWEPT
     fields, one derived proposition asking whether the disposition vocabulary
     must distinguish a designed summary from an accidental duplicate. Not the
     final sub-tranche.
```
