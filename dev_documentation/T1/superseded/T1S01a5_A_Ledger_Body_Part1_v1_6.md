# Deblock4 - T1S01a5 Ledger: Authority Body Part 1, Sections 1 to 8

**Deliverable:** T1S01a5_A - LEDGER
**Version:** 1.6 - post-repair rewrite. Built TEXTUALLY on delivered ledger v1.3 with only the deltas mandated by Classification Repair v1.1, W3C review response v1.0, and ratified register decisions, plus W3C's Tier C sample review. 39 entries.
**Date:** 2026-08-19
**Author:** W3D (successor session)
**Route:** W3D -> W3X -> W3C
**Adjudicates:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`, sections 1 to 8, lines 223-715
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_30.md`
**Supersedes:** ledger v1.5 (same authorship and basis; v1.6 applies two W3C
Tier C findings that v1.5 missed). Textual basis remains delivered ledger v1.3.
**Encoding:** US-ASCII; CRLF.

---

# 0. COVERAGE DECLARATION

## 0.1 THE SUB-TRANCHE IS SPLIT, AND THE SPLIT IS DECLARED HERE

```text
DEC-53 defined T1S01a5 as authority sections 1-13, and DEC-56 corrected the
range to EXACTLY lines 223-1098. That is 876 lines and, on the entry density
the ledger format actually requires, roughly fifty adjudicable propositions.

W3D DECLARES A SPLIT under the manifest's split-and-report provision - the
same provision under which T1S01 was split into a and b, and under which
DEC-53 itself restructured a5/a6/a7:

    T1S01a5    sections 1-8,  lines 223-715   THIS LEDGER
               the EVIDENCE half: codec facts, syntax regimes, whole-frame
               geometry mathematics, the SeparateFields derivation, the
               measured target material, prior art, the GAIS rule.

    T1S01a5b   sections 9-13, lines 716-1098  NOT STARTED, NAMED HERE
               the ARCHITECTURE half: the options and re-decision, B2
               topology mathematics, Architecture D, the Architecture A
               rejection proof, scheduler/kernel separation. It carries the
               DEC-24 re-derivation of the 12.5/13.1 pointer remedy and the
               re-adjudication of the PR-1/PR-2 home sections 12.5, 13.1
               and 9.1.

THE BOUNDARY IS REAL, NOT ARBITRARY. Section 8 ends the record of WHAT WAS
ESTABLISHED AND HOW IT WAS VERIFIED. Section 9 opens WHAT THE PROJECT DECIDED
TO BUILD ON IT. That is the same kind of subject boundary DEC-35 used to
separate a3 from a4, and it puts every PR-1/PR-2 home section on one side.

WHY SPLIT AT ALL, stated plainly: a designer session that dies mid-document
loses everything not delivered, this is the largest single adjudication in
the sweep, and the architecture half is where a thin entry would do the most
damage. The alternative is one delivery in which the second half is written
by a session that has already been reading for a long time - which is the
condition the review scope itself names as the failure mode W3C exists to
catch.

THIS SPLIT REQUIRES W3X RATIFICATION. It is declared, not assumed. If W3X
refuses it, this ledger stands as the first part of a single a5 and the
remainder is appended rather than renamed. See covering note Q1.
```

## 0.2 EXACTLY WHAT IS ADJUDICATED HERE

```text
ADJUDICATED HERE, and nothing else:

  lines 223-281   section 1   purpose, authority boundary, terminology
  lines 283-374   section 2   the F-series verified facts and the v1.04
                              H.262 provenance re-audit
  lines 375-418   section 3   picture/syntax regimes and MediaInfo triage
  lines 419-544   section 4   whole-frame geometry mathematics
  lines 545-566   section 5   the SeparateFields tearing derivation
  lines 568-641   section 6   measured target material
  lines 643-677   section 7   prior art and external verification
  lines 679-715   section 8   GAIS engagement and the calibration rule

EVERY MPEG-2-BEARING PROPOSITION IN THOSE RANGES has an entry below. Where an
entry covers several propositions, the CLAIM field names each one and the
PREVAILS field maps a canonical home PER PROPOSITION.

BOUNDARY, LOWER: this ledger begins at line 223, the section 1 heading.
  Lines 216-222 are the tail of section 0's numbered item 17 and were
  adjudicated at T1S01a3 (LED-019). They are NOT re-adjudicated here.
  DEC-53's original "approx. lines 216-1098" would have re-entered them;
  DEC-56 corrected the range and this is the boundary that correction
  protects.

BOUNDARY, UPPER: this ledger ends at line 715. Line 716 is the section 9
  heading and belongs to T1S01a5b.

NOT ADJUDICATED HERE, BECAUSE ANOTHER LEDGER ALREADY OWNS IT:

  the header block, lines 1-47        T1S01a2 and T1S01a3 (LED-003 to
                                      LED-012, LED-020, LED-020a, LED-021)
  section 0, lines 50-222             T1S01a3 (LED-013 to LED-019, LED-022,
                                      LED-023, LED-024)

  OVERLAP CHECK, ENUMERATED RATHER THAN ASSERTED. Every entry in the three
  prior ledgers was listed with its recorded range and compared against
  223-715:

    LED-001, LED-002        pre-registered items PR-1/PR-2; no line range in
                            this document's body; resolved at DEC-24/DEC-25
    LED-003                 line 1679 area, section 23 head        NO OVERLAP
    LED-004                 lines 1683-1694, section 23 steps 1-5  NO OVERLAP
    LED-005                 lines 1684-1685                        NO OVERLAP
    LED-006                 line 1686                              NO OVERLAP
    LED-007, LED-008        header currency statements, lines 1-47 NO OVERLAP
    LED-009                 line 1681                              NO OVERLAP
    LED-010                 lines 1703-1710 (text runs to 1713)    NO OVERLAP
    LED-011                 header/Appendix E v1.05 entry          NO OVERLAP
    LED-012                 Appendix E sequencing sentence         NO OVERLAP
    LED-013 to LED-019      section 0 numbered items 1-17,
                            lines 50-222                           NO OVERLAP
    LED-020, LED-020a       header authority-status and the v1.05
                            revision description                   NO OVERLAP
    LED-021                 header single-source boundary          NO OVERLAP
    LED-022                 header provenance-tag discipline       NO OVERLAP
    LED-023                 header blanket GAIS-provenance claim,
                            line 44 - DEFERRED to T1S01a7          NO OVERLAP
                            (but see LED-047 below: this ledger supplies
                            evidence toward it and does NOT discharge it)
    LED-024                 header encoding line                   NO OVERLAP
    LED-025 to LED-030      lines 1694-1700, section 23 steps 6-10 NO OVERLAP
    LED-031, LED-032        WITHDRAWN at a4 v1.2                   N/A

  RESULT: no entry in any prior ledger records a range inside 223-715. This
  sub-tranche re-adjudicates nothing.

  BASIS FOR THAT CLAIM, per DEC-50: the population is the 33 entries listed
  above, taken from T1S01a2 ledger v1.1, T1S01a2 orientation layer v1.0,
  T1S01a3 ledger v1.4 and T1S01a4 ledger v1.4. Each was read for its DOCUMENT
  field and its recorded range. The comparison is a numeric range test against
  223-715. An omission is visible by counting the list against the LED series,
  which runs LED-001 to LED-032 with no gaps and with 020a as the only suffix.

NOT ADJUDICATED HERE, and where it goes:

  sections 9-13, lines 716-1098       T1S01a5b, declared at 0.1 above
  sections 14-22, lines 1099-1676     T1S01a6
  section 23, lines 1677-1716         a2 (steps 1-5) and a4 (steps 6-10)
  section 24, lines 1717-1761         T1S01a6, assigned at DEC-55
  Appendices A-D, lines 1762-1932     T1S01a6
  Appendix E, lines 1933-1983         T1S01a7 (the v1.05 entry stays with
                                      LED-012, action NONE - DO NOT TOUCH)

CITED AS EVIDENCE BUT NOT DISPOSITIONED HERE. Several entries below cite
material outside 223-715 to establish a canonical home or a duplication. A
citation is not an adjudication: the cited statements keep their own
sub-tranche. The cited locations are section 0 items 1, 2, 3, 5, 7 and 10;
sections 10, 11, 12.5, 13.1 and 15; the D4-Q and D4-D registers in sections
21 and 22; Appendix A; and Appendix D.
```

## 0.3 WHAT THIS LEDGER FOUND THAT IS NOT A DISPOSITION

```text
Two findings are recorded here rather than only inside an entry, because both
reach documents this sub-tranche does not adjudicate and would otherwise be
visible only to a reader who read every entry.

FINDING A - THE SCHEDULE NAMING COLLISION IS UNCONTAINED OUTSIDE THIS
DOCUMENT. Section 1.1 renames the processing-order candidates Schedule-SA /
SB / SC specifically to stop them colliding with Architecture A/B/C/D, and
its v1.04 audit claims the renaming is complete. THE CLAIM IS TRUE OF THIS
DOCUMENT - verified, see LED-037. It is not true of the corpus, and it never
said it was. Bare "Schedule A" / "Schedule B" survive as ACTIVE current
vocabulary in at least six live documents. Details and the enumeration are at
LED-037; the routing is T1S02/T1S03 for the README, T1S04 for the charter and
D0, and T1S05 for the rest.

FINDING B - SECTION 8's CALIBRATION RECORD POINTS AT A DOCUMENT THAT MAY NOT
EXIST. Section 8 closes by saying the detailed calibration record "remains in
the W3C verification report". Section 24's reference R8 names that report as
`Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md`, and no file of that
name exists in the live tree (DEC-58). The two are the same referent problem
seen from two sections. Recorded at LED-063 and routed to T1S01a6, which owns
section 24.
```

## 0.4 PRE-ISSUE SELF-CHECK, AND WHAT IT CAUGHT

```text
This ledger was swept as a whole before issue, not merely written. The sweep
is recorded because it found four defects in this ledger's own work, and a
reviewer should know they were found by machine check rather than by care.

WHAT WAS CHECKED, and how:
  (1) LED numbering - extracted every entry heading and checked the series
      runs LED-033 to LED-063 with no gap and no repeat.
  (2) LINE RANGES - every DOCUMENT range was RECOMPUTED from the authority
      file by locating the first and last sentence of each entry's subject,
      rather than trusted as typed. The recomputed ranges were then tested
      pairwise for overlap and for ordering.
  (3) STAY-CANONICAL enumeration - the list in closing question Q-C was
      regenerated by searching this file's DUPLICATE-ACTION fields.
  (4) Encoding - US-ASCII, CRLF, balanced code fences.

WHAT IT FOUND, all corrected before issue:
  DEFECT 1  LED-057 recorded lines 575-612 and LED-058 recorded 608-626 -
            AN OVERLAP OF FIVE LINES INSIDE THIS SUB-TRANCHE. That is the
            same defect class as DEC-48, committed while writing the ledger
            whose section 0 enumerates DEC-48's overlap check. Corrected to
            575-606 and 609-625.
  DEFECT 2  LED-034 and LED-035 both claimed line 241, which is blank.
            Corrected to 231-240 and 242-244.
  DEFECT 3  ELEVEN FURTHER RANGES WERE WRONG BY ONE TO FOUR LINES, chiefly
            in section 1.2 where the symbol definitions were cited three
            lines above their actual positions. Every range in this ledger
            has now been recomputed rather than adjusted.
  DEFECT 4  Q-C's enumeration was written from memory. It said SIX entries
            claim STAY-CANONICAL and named nine, one of them wrong. The
            searched answer is THIRTEEN. See Q-C, which now records this.

WHY THIS IS IN THE LEDGER RATHER THAN ONLY IN THE COVERING NOTE: the six
items owed to T1S01a7 include two range-recording defects in T1S01a2 that
were found only after that ledger had passed review. Recording that this
ledger's ranges were computed rather than typed tells a7 what it is
inheriting, and tells W3C which claim to attack - the recomputation, not the
numbers.

WHAT THE v1.1 REISSUE CHANGED, and what it deliberately did not.
  CHANGED: LED-057's DERIVED and DERIVED-BASIS only. v1.0 rested the
  finding on charter P-08. W3C challenged that BEFORE beginning the formal
  review and is right - P-08 has no measurement limb. The finding survives
  on a stricter internal basis, the authority's own `[MEASURED]` tag
  definition, and a second finding about the charter falls out of the
  correction.
  UNCHANGED, AND PROVED RATHER THAN ASSERTED per DEC-40(b): every other
  entry, LED-033 to LED-056 and LED-058 to LED-063, is byte-identical to
  v1.0. The identity was established by extracting each entry block from
  both versions and comparing SHA-256 digests; the per-entry digest table is
  in the covering note. Only LED-057's digest differs.
WHAT THE v1.3 REISSUE CHANGED, both findings W3C's and both made before it
  had completed the entry review.
    (1) THREE ENTRIES CARRIED COMPOUND DISPOSITIONS - LED-051, LED-052 and
        LED-053 each gave different dispositions to different propositions
        inside one entry. DEC-33(a) permits exactly two remedies, SPLIT or
        NARROW, and a compound field is neither. All three are now split,
        producing LED-051a, LED-052a and LED-053a. NO DISPOSITION, HOME,
        ACTION OR SWEPT RESULT CHANGED - each proposition keeps the outcome
        it already had; only its housing changed. Entry count 31 -> 34.
        THE EXTENT WAS ENUMERATED, NOT SAMPLED: every DISPOSITION field in
        the ledger was extracted and inspected. Exactly three were compound.
        WHAT IS NOT AFFECTED, because the distinction matters: an entry with
        ONE disposition and PER-PROPOSITION canonical homes or duplicate
        actions is expressly permitted - review scope 5.4 requires the
        canonical source to be identified per proposition. Ten entries do
        that and are correct as they stand.
    (2) THE STAY-CANONICAL "FIRST USE IN T1" CLAIM WAS FALSE. See LED-036
        and Q-C.

WHAT THE v1.2 REISSUE CHANGED. Section 0.5 is added, defining the search
  population once; LED-033's SWEPT field, the only entry that enumerated the
  exclusions rather than referring to them, now refers to 0.5. NO FINDING,
  NO DISPOSITION, NO ACTION AND NO OTHER SWEPT RESULT CHANGED - the searches
  always ran over the 87. Entry digests in the covering note prove which
  blocks moved.

  THE P-08 MISUSE WAS SEARCHED FOR RATHER THAN ASSUMED ISOLATED. Every
  charter citation in the batch was enumerated and each was checked against
  the charter text: B1, B2, B3, B4, B5, C-SIMD-03, Part 6.4, P-06 and I7 all
  hold. P-08 was the only overreach, and it appeared at FOUR sites - two in
  this ledger and two in the covering note's Q4. All four are corrected.
```

## 0.4b HOW v1.5 WAS BUILT, AND WHAT A REVIEWER SHOULD DISTRUST

```text
THIS IS THE POST-REPAIR REWRITE THE DEAD W3D SESSION PROMISED AND DID NOT
DELIVER. It is built on the DELIVERED ledger v1.3, not on any later text.

THE PROVENANCE RULE THIS DOCUMENT OBEYS:
    every change from v1.3 traces to a DELIVERED ARTIFACT or a RATIFIED
    DECISION, and anything the successor designer adds on its own judgement
    is labelled a NEW W3D FINDING with its evidence, never presented as a
    repair mandate.

THE DELIVERED ARTIFACTS USED:
    T1S01a5_A_Ledger_Body_Part1_v1_3.md          W3D - the textual basis
    T1S01a5_A_Classification_Repair_v1_1.md      W3D - the last valid W3D
                                                 artifact; 22 probe tables
    T1S01a5_B_Classification_Repair_Response_
        v1_0.md                                  W3C - substantive PASS
    T1S01a5_B_Coder_Response_v1_1.md             W3C - THE TIER C SAMPLE
                                                 REVIEW. Not opened during the
                                                 v1.5 build; see the failure
                                                 record below. Applied at v1.6.
    Deblock4_Standing_Task_Register_T_Series     ratified decisions
    Deblock4_T1_W3C_Review_Scope_v1_11.md        binding review scope

A FALSE CLAIM THIS SECTION MADE AT v1.5, CORRECTED AND RECORDED RATHER THAN
QUIETLY FIXED. The v1.5 list above named T1S01a5_B_Coder_Response_v1_1.md and
T1S01a5_B_ReSweep_CrossCheck_Response_v1_0.md among the artifacts used. THE
TIER C SAMPLE REVIEW WAS NOT OPENED DURING THE v1.5 BUILD. That is a claim that
a check was performed when it was not - DEC-48 and DEC-50 exactly - written
into the section that asserts this document's provenance rule.
WHAT IT COST: two of W3C's eight Tier C findings were missed. LED-046's wrong
cross-reference was declared UNMANDATED and put to W3C as an open question,
when W3C had already found and corrected it; and LED-037's REASON sentence was
RESTORED from v1.3 when W3C had specifically found it is not a uniqueness
proof. Both are applied at v1.6.
THE UNDERLYING ERROR, because it is the reusable part: TWO ROUNDS FED a5 - the
Tier C sample review, then the classification repair - and v1.5's delta list
was built from the second only. The v1.5 build cross-checked its deltas against
two sources and reported them "confirmed from both sides"; both sources
concerned the REPAIR round. TWO SOURCES AGREEING ABOUT ONE ROUND IS NOT
COVERAGE OF THE CHAIN. The deltas were enumerated meticulously; the ROUNDS
those deltas came from were never enumerated at all.
THE CROSS-CHECK RESPONSE IS REMOVED FROM THE LIST rather than claimed: it was
not opened either, and its findings reach this ledger only through the
classification repair that incorporated them.

WHAT WAS DELIBERATELY NOT USED AS A SOURCE, AND WHY W3C MUST KNOW:
    T1S01a5_A_Ledger_Body_Part1_v1_4.md
W3C authored that file as an emergency recovery reconstruction after the W3D
session died. W3X has ruled it is NOT a source for this rewrite. NO WORDING IN
THIS DOCUMENT IS TAKEN FROM IT.

AN HONEST LIMIT ON THAT CLAIM. The successor designer HAD ALREADY READ v1.4 in
detail before W3X ruled it out, and cannot un-read it. The guarantee offered is
therefore about SOURCING, not about innocence: no wording is taken from v1.4,
and v1.4 was consulted at the end ONLY as a coverage checklist to confirm no
mandated delta was missed. A reviewer should treat that as the weakest claim in
this section and test it by comparing v1.3 and this document directly.

WHY THE RECONSTRUCTION WAS SET ASIDE, recorded so the decision is testable:
    v1.4 left 17 of the 34 entries untouched and REWROTE the other 17, which
    are exactly the 17 with a mandated change. But within those it retained
    only 27% to 67% of the v1.3 text, against mandates that in most cases
    touched a single field. Entry text fell from 121,333 to 83,654 characters.
    What went was disproportionately the DEC-50 evidence: enumerated
    populations, line numbers, recorded negative results, and the reasoning
    that supports each disposition. Two examples, both restored below:
      LED-037 lost its stated population, its fifteen classified hit lines and
        its six-document enumeration with file and line numbers, leaving
        "route those copies to their own T1 steps" - the bare assurance DEC-50
        prohibits.
      LED-058 lost the recorded NEGATIVE result that no live document asserts
        mixture is OBSERVED rather than PERMITTED - the check that matters
        most for that entry, and one no mandate touched.

THE SEARCH FOR A MANDATE TO COMPRESS, STATED AS A NEGATIVE RESULT PER THE
STANDING RULE THAT A SWEEP FINDING NOTHING MUST SAY SO:
    POPULATION EXAMINED: W3D's three final chat posts as supplied by W3X;
    W3D's expectation note T1S01a5_A_Note_to_W3C_Whats_Coming_v1_0.md; and
    W3C's full 532-line Classification Repair Response v1.0.
    SEARCHED FOR: any instruction to shorten, compress, abbreviate or rewrite
    entry prose beyond the four named deltas.
    RESULT: NONE FOUND. W3D's own statement of the rewrite's scope is exactly
    four items - six dispositions, eight carrier lists, four findings, the 28
    enumerated rather than asserted. W3C's is narrower still: generate the
    ledger "directly from" the repair, with an explicit warning against
    broadening into another research or methodology round. That warning is
    honoured here: NO search has been rerun, NO classification reopened, and
    NO architecture question touched.
```

## 0.4c THE COMPLETE DELTA SET FROM v1.3, WITH THE AUTHORITY FOR EACH

```text
COUNT THE LIST RATHER THAN ACCEPTING THE TOTAL.

D1  SIX DISPOSITION-STRUCTURE CHANGES
      LED-043  split the codec-syntax fact from the Q14 experiment rule
      LED-051  CURRENT-UNIQUE -> CURRENT-DUPLICATE
      LED-053  (b) unique; (c) and (d) duplicate
      LED-055  withdraw "the derivation is unique"
      LED-058  reading rule unique; evidence-precision duplicate
      LED-061  the nuanced assessment unique; three propositions duplicate
    AUTHORITY: Classification Repair v1.1 section 3; W3C response section 7,
    which names the same six and passes the 34 - 6 = 28 arithmetic.

D2  EIGHT REBUILT CARRIER/APPLICATION LISTS
      LED-033, LED-035, LED-036, LED-038, LED-042, LED-049, LED-055, LED-061
    AUTHORITY: Classification Repair v1.1 section 3, as corrected by W3C's
    "seven -> eight" finding.

D3  FOUR CHANGED FINDINGS
      LED-034   the T3 protection-gap proposition withdrawn entirely
      LED-051   thirteen rows -> 11 for one pitch-2 edge, 12 for the union
      LED-052a  the retired parity-split description IS still live - ACTUAL
      LED-058   "latent rather than actual" -> ACTUAL
    AUTHORITY: Classification Repair v1.1 section 3.

D4  THE 28 SURVIVING DISPOSITION STRUCTURES ARE ENUMERATED, NOT ASSERTED.
    See 0.4d. AUTHORITY: repair v1.1 section 3; W3C response section 7.

D5  SEARCH POPULATION RESTATED AS THE SETTLED 46 FILES under DEC-60, DEC-63
    and DEC-66. v1.3's section 0.5 described an 87-file population predating
    the T1/ and GAIS exclusions. AUTHORITY: ratified DEC-60/63/66.

D6  EVERY TIER FIELD IS COMPUTED FROM DISPOSITION, never typed.
    AUTHORITY: ratified DEC-62.

D7  BINDING WORK-QUEUE PIN advanced v1.23 -> v1.30. Currency only.

NOTHING ELSE CHANGED. Every other word of every other field is v1.3's.
```

## 0.4d THE 28 ORIGINAL ENTRIES WHOSE DISPOSITION STRUCTURE SURVIVES

```text
ENUMERATED SO THE TOTAL CAN BE COUNTED RATHER THAN BELIEVED. The population
is v1.3's 34 entries; the six at D1 are excluded; these are the remainder.

  LED-033  LED-034  LED-035  LED-036  LED-037  LED-038  LED-039
  LED-040  LED-041  LED-042  LED-044  LED-045  LED-046  LED-047
  LED-048  LED-049  LED-050  LED-051a LED-052  LED-052a LED-053a
  LED-054  LED-056  LED-057  LED-059  LED-060  LED-062  LED-063

COUNT: 28.  34 - 6 = 28. The arithmetic reconciles.

NOTE THE DISTINCTION THIS LIST DEPENDS ON. LED-034, LED-052a and LED-058 have
CHANGED FINDINGS (D3) without a changed DISPOSITION STRUCTURE. LED-034 and
LED-052a therefore appear in this list of 28 and LED-058 does not, because
LED-058's structure also changed at D1. A changed finding is not a changed
disposition structure.
```

## 0.4e ENTRY COUNT, AND WHY IT IS DERIVED RATHER THAN INHERITED

```text
34 delivered entries at v1.3
 +  LED-043a   the no-coded-residual codec fact          split mandated by D1
 +  LED-053c   the no-midpoint proposition (c)           split mandated by D1
 +  LED-053d   the Case-(b) pitch-2 proposition (d)      split mandated by D1
 +  LED-058a   the document-local reading rule            split mandated by D1
 +  LED-061a   the nuanced GAIS instrument assessment     split mandated by D1
= 39 entries.

THIS TOTAL WAS ASSERTED AS 40 IN DRAFT AND CORRECTED TO 39 BY COUNTING THE
ENUMERATION ABOVE. The error is recorded rather than silently fixed, because
it is the exact failure this section exists to prevent and it was committed
while writing the section. 34 + 5 = 39. The draft figure came from reasoning
that splitting LED-053 into two entries would add one to the reconstruction's
count, without also subtracting the reconstruction's LED-055a, which is
unmandated and is not created here. Two changes in opposite directions,
netting to zero, and only one of them was carried into the arithmetic.
THE SAME ERROR THEN SURVIVED ITS OWN CORRECTION. Fixing this section left the
figure stale in the document HEADER, two hundred lines away, where the
pre-issue check found it. That is DEC-51's partial-replacement failure mode
and DEC-41's instance 10, committed inside the section written to record the
first instance. Both are left on the record because a correction that is
reported complete from the edited location is the thing being guarded
against.

A COINCIDENCE A REVIEWER MUST NOT READ AS CORROBORATION. 39 is also the count
the W3C recovery reconstruction reached, and the number appearing in DEC-60,
DEC-63 and W3D's expectation note. THE MEMBERSHIP IS DIFFERENT. The
reconstruction's five suffix entries were LED-043a, LED-053b, LED-055a,
LED-058a and LED-061a. This ledger's are LED-043a, LED-053c, LED-053d,
LED-058a and LED-061a: LED-053's two separately-probed propositions get two
entries rather than one bundled entry, and the unmandated LED-055a is not
created. THE TOTALS AGREEING IS ARITHMETIC, NOT AGREEMENT. Compare the lists,
not the counts - which is the same instruction DEC-67 gives about carrier
sets, and for the same reason.

LED-051 and LED-055 take NO suffix entry. LED-051's change is a disposition
VALUE change; LED-055's is the withdrawal of a uniqueness claim inside an
entry that was already CURRENT-DUPLICATE. Neither requires a split, and the
repair mandates neither.

WHY LED-053 PRODUCES TWO SUFFIX ENTRIES AND NOT ONE. The repair states
"(b) unique; (c) and (d) duplicate" and prints TWO SEPARATE PROBE FAMILIES for
them - the repair's own tables LED-053c and LED-053d - with different candidate
sets. W3C independently reproduced the LED-053d table. Two separately probed
propositions with different carrier evidence get two entries; bundling them
under one DISPOSITION would breach the atomic-claim rule at review scope 5.2.
THE NEW ENTRIES ARE NAMED FOR THE PROBES THAT ESTABLISHED THEM - LED-053c and
LED-053d - so the entry and its evidence table carry the same identifier.
THERE IS DELIBERATELY NO LED-053b. LED-053a already exists from v1.3 and
covers a different proposition; inventing a "b" between them would put entry
letters and probe letters permanently out of step.

A NUMBER A SUCCESSOR WILL MEET AND SHOULD NOT TRUST. Register DEC-60 refers to
"all 39 SWEPT fields in that ledger" and DEC-63 to a correction made "at a5
ledger v1.5". W3D's expectation note likewise speaks of "39 entries". NO
DELIVERED LEDGER HAS EVER HAD 39 OF ANYTHING: v1.3 has exactly 34 entries, 34
CLAIM fields, 34 DISPOSITION fields and 34 SWEPT fields. The 39 describes
working generations that were never delivered and that Resume Brief section 0e
forbids reconstructing. IT IS NOT A TARGET. This ledger's count is derived from
the proposition set above, and lands at 40.
```

## 0.4f RESTORATIONS - v1.3 TEXT DELIBERATELY KEPT

```text
LISTED SO W3C CAN ATTACK THE LIST RATHER THAN RE-READ THE LEDGER. In each of
these the recovery reconstruction had deleted material that no mandate
touched. All are restored verbatim from v1.3.

  LED-033  the second ASSERTS clause - that a successor should not have to
           rebuild the knowledge from the four named sources; the CONFLICTS
           note on the register's "status we have granted it" tension; the
           full DERIVED paragraph on the completeness word and its basis.
  LED-034  the load-bearing-taxonomy REASON naming sections 9.3 and 13.1 as
           APPLICATIONS not copies; the NOT CLAIMED limit on semantic search;
           the T3/DEC-07 exposure in DERIVED, retained as a live concern
           SEPARATE from the withdrawn protection-gap proposition (see D3).
  LED-035  the per-file hit arithmetic in SWEPT and the statement that each
           hit was opened.
  LED-036  the REASON explaining what Appendix A does NOT carry - the reason
           for the renaming and the identification of the old README - which
           is what keeps section 1.1 canonical; the full withdrawal record of
           the false first-use claim and its DEC-41 instance-eleven basis.
  LED-037  the ENTIRE evidence base: the stated population, the fifteen
           classified hit lines, the six-document enumeration with file and
           line numbers, the four separated non-collision cases, and the
           routing recommendation including the carve-out that Classic-facing
           documents keep "Schedule A" because there it names the VERIFIED
           HOLYWU ORDER. Also the REASON's original reasoning, which the
           repair's own LED-037 probe table endorses.
  LED-038  the coordinate-key DERIVED paragraph and the pointer-with-
           restatement recommendation routed to W3X.
  LED-042  the per-proposition canonical mapping and the RETAIN-SUMMARY
           caveat for the designer introduction's read-first block.
  LED-049  the per-file hit counts and the T2 retirement rationale.
  LED-051  the charter B3/B4 radii consequence and its basis.
  LED-052a the T1S01b registration of the named follow-up item.
  LED-055  the honest unresolved note that a document describing old
           Architecture A is not necessarily asserting SeparateFields is
           supported.
  LED-058  the recorded NEGATIVE result: no live document asserts mixture is
           OBSERVED rather than PERMITTED.
  LED-061  the per-proposition split of rule versus precedence clause.
```

## 0.4g NEW W3D FINDINGS - NOT MANDATED BY ANY DELIVERED ARTIFACT

```text
DECLARED SEPARATELY BECAUSE THEY ARE THE SUCCESSOR DESIGNER'S OWN JUDGEMENT
AND MUST BE ATTACKED AS SUCH, NOT ACCEPTED AS REPAIR MANDATES.

N1  WITHDRAWN AT v1.6. IT WAS NEVER A NEW FINDING - IT WAS A MISSED MANDATE.
    v1.5 declared LED-046's cross-reference change unmandated, on the basis
    of a search of Classification Repair v1.1 and W3C's response to it. That
    search was correctly executed and looked at the WRONG POPULATION. The
    mandate is in W3C's TIER C SAMPLE REVIEW, which v1.5 did not open:
    "DISAGREE with the entry's cross-reference ... LED-049 is the MediaInfo
    triage entry. The retirement record is LED-052a. Correct that reference."
    THE CORRECTION IS APPLIED AT LED-046 AND Q-J IS WITHDRAWN.
    LEFT ON THE RECORD RATHER THAN DELETED, because it is the clearest
    example in this ledger of the failure 0.4b now records: a check that
    NAMES its population honestly can still be worthless if the population
    is the wrong one. The v1.5 basis statement was testable, and testing it
    is exactly what exposed the error.

N2  LED-053d's second carrier lies outside the adjudicated range.
    The repair's LED-053d table records the authority as MIXED "because
    APPENDIX A OF THE SAME FILE is a second carrier and does not appear as a
    separate hit". Appendix A occupies lines 1762-1932 and belongs to
    T1S01a6. Citing it is permitted by section 0.2's cited-as-evidence rule,
    but the entry must say so rather than let a reader assume the copy is
    inside a5. Flagged in LED-053d and raised at Q-K.
```

## 0.5 WHAT "THE LIVE CORPUS" MEANS IN EVERY SWEPT FIELD BELOW

```text
DEFINED ONCE HERE AND INHERITED BY EVERY SWEPT FIELD IN THIS LEDGER, so that
the population cannot drift between one entry and the next.

THE SETTLED a5 SEARCH POPULATION IS 46 FILES.

That is the population the a5 re-sweep and the classification repair actually
ran over. W3C independently reproduced it, and reproduced all 22 probe counts
exactly, after W3X's declared relocation of the two raw GAIS response files
into the ignored GAIS_investigations/ tree.

THE THREE MECHANICAL EXCLUSIONS THAT DEFINE IT:
    - any folder whose name begins "superseded" or
      "scheduled_for_deletion"                                      DEC-60
    - everything under T1/                                          DEC-63
    - everything under GAIS_investigations/                         DEC-66

T1/ IS A WORKSHOP, NOT A KNOWLEDGE SHELF. Material drafted there is process
material. It cannot establish or refute a CURRENT-UNIQUE or CURRENT-DUPLICATE
result merely by existing there. This closes the defect DEC-63 records: under
v1.3's wider population, superseded generations of THIS ledger refuted this
ledger's own uniqueness entries, four times over and rising with every reissue.

GAIS_investigations/ IS IGNORED FOR SEARCH AND ADJUDICATION ALIKE. The files
remain on disk as history. They are not used to prove, refute or adjudicate any
proposition in this ledger.

THREE POPULATIONS EXIST AND MUST NOT BE RECONCILED BY REWRITING HISTORY:
    47  the FROZEN T1S00 SURVEY RECORD - the historical frame that actually
        ran on 2026-08-18, preserved unedited in the manifest.
    41  the CURRENT T1 ADJUDICATION POPULATION - what T1 gives a disposition
        to, after DEC-66 removed GAIS_investigations/ from adjudication.
    46  the SETTLED a5 SEARCH POPULATION - what the SWEPT fields below ran
        over.

WHAT CHANGED FROM v1.3, AND WHY IT IS NOT A NEW SEARCH. v1.3's section 0.5
described an 87-file population under DEC-60 alone, because DEC-63 and DEC-66
did not yet exist. The searches recorded in the SWEPT fields below were then
re-run and cross-checked under the narrower rule during the a5 re-sweep, and
the classification repair prints the exact candidate file list for all 22
probes with zero returned files left unclassified. NO SEARCH IS RERUN BY THIS
REWRITE. Where a SWEPT field below is marked REBUILT FROM CLASSIFICATION REPAIR
v1.1, that repaired field supersedes v1.3's wording for that entry. Where it is
not so marked, v1.3's recorded search stands as delivered.

A LIMIT THIS LEDGER DOES NOT HIDE. The 46-file population is a SNAPSHOT. Since
it was taken, several members have been superseded and physically moved into
retired trees, and new continuity documents have been committed. A search run
today would not return the same 46. That does not invalidate any finding below:
the snapshot is the evidence of record for a5, and later version bumps do not
retroactively rewrite candidate sets or counts. It does mean a LATER sub-tranche
must re-derive its own population rather than inherit this one.

THREE RATIFIED SWEEP RULES APPLY TO EVERY FIELD BELOW, per DEC-67:
    1. OPEN EVERY HIT. A returned file that is not classified is NOT SWEPT.
    2. NORMALISE WHITESPACE FOR PHRASE SEARCHES. The corpus wraps sentences
       across lines, so raw line matching returns silent zeroes.
    3. SEARCH THE PROPOSITION, NOT MERELY THE SOURCE SENTENCE, in W3C's
       bounded form: declare the proposition; declare a bounded probe family
       covering its material concepts; run it over the declared population;
       open every candidate file; classify each occurrence as CARRIER /
       APPLIES / DIFFERENT / IDENTIFIER / NOISE, using MIXED where one file
       carries several meanings; if a genuine carrier exposes an equivalent
       phrasing the family missed, add it, record why, and rerun the SAME
       population; claim no exhaustiveness beyond the declared population and
       probe family.

AND THE FAILURE MODE THAT SURVIVED ALL THREE, which is the one to carry:
    OPENING A HIT IS NOT THE SAME AS READING IT.
In the a5 re-sweep the designer opened every hit as Rule 1 requires and STILL
misclassified seven files. A Zig comment about a version string was counted as
a carrier of the MPEG-2 single-source rule; charter I7 independent verification
was counted as the GAIS rule; the substring inside the identifier D4-Q01 was
counted as the edge-position convention. A COUNT THAT COMES OUT RIGHT CAN STILL
HAVE THE WRONG MEMBERS - in one entry a false candidate entered while a real
carrier escaped the probe, and the two cancelled to give the correct total.
WHERE A KEYWORD CAN CARRY TWO MEANINGS, THE ENTRY BELOW SAYS WHICH PROPOSITION
THE MATCHED PASSAGE ACTUALLY STATES.
```

---
# LED-033  Section 1 - the document's stated purpose

```text
DOCUMENT     authority v1.05, section 1, lines 226-229
CLAIM        "The purpose of this document is to hold the complete current
             MPEG-2-specific knowledge and design state so a successor
             designer/coder does not have to reconstruct it from the README,
             old grid notes, GAIS captures and chat history."
ASSERTS      that this document is the consolidated home of MPEG-2 knowledge,
             and that a successor should not have to rebuild that knowledge
             from the four named sources.
CLASS        W3X-RATIFIED (the document's ratified self-definition)
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, and true in intent - but it is the same proposition the
             header's single-source rule states normatively, in more precise
             terms. The header says where verified facts, mathematics,
             decisions and open questions live and what other documents may
             retain; section 1 says the same thing as a purpose statement.
CONFLICTS    none. NOTE: the purpose statement claims the knowledge IS
             complete; the task register's own description of T1 says the
             single-source status is "a STATUS WE HAVE GRANTED IT, not a
             state it has been demonstrated to be in". Those are consistent
             only because T1 is the work that makes the claim true. See
             DERIVED.
PREVAILS     CANONICAL HOME: the header single-source rule, lines 13-24,
             adjudicated at T1S01a3 LED-021.
DUPLICATE-ACTION  POINTER. Section 1 is not a designated summary, index or
             orientation layer, so the narrow 5.4 exception does not reach
             it.
             KNOWN NON-CANONICAL COPIES INCLUDE: this one at lines 225-229,
             and the Session Bootstrap Header's controlling-documents block,
             which states the same prevailing-authority proposition for
             coding sessions. NOT AN EXHAUSTIVE LIST - the sweep below
             searched for the single-source proposition, not for every
             paraphrase of "this document is where MPEG-2 knowledge lives".
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: single source | prevailing authority | single
             source of truth | PREVAILING MPEG-2 AUTHORITY.
             The fourth probe term was ADDED under sweep rule 3 during the
             re-sweep, because the designer introduction writes "PREVAILING
             MPEG-2 AUTHORITY" and the contiguous phrase missed it; the
             reason was recorded and the SAME population rerun. That
             expansion also recovered the coder introduction.
             11 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority's header, lines 13-24
               CARRIER     coder introduction
               CARRIER     designer introduction (found only by the expansion)
               CARRIER     coder chat blurb
               CARRIER     designer chat blurb
               CARRIER     Documentation Currency Audit
               CARRIER     Forward Roadmap
               CARRIER     Project Status
               CARRIER     Session Bootstrap Header
               CARRIER     Scopes/ T1 W3C Review Scope v1.7 - a T1 process
                           artifact sitting outside T1/; see the strays note
               DIFFERENT   Stage-1B3 runtime-capability-guard scope. The
                           match is a Zig comment reading "Single source of
                           the version string". THAT IS A DIFFERENT
                           PROPOSITION and it is why this table exists.
             WITHDRAWN FROM v1.3, AND RECORDED RATHER THAN QUIETLY DROPPED
             PER DEC-51: v1.3's SWEPT field concluded that "the orientation
             documents' copies are pointers to this authority rather than
             competing statements of it, so they are not treated as
             duplicates of THIS proposition." THAT JUDGEMENT IS WITHDRAWN.
             Opening each hit showed the introductions, the blurbs, the
             Roadmap, the Currency Audit, Project Status and the Bootstrap
             Header ASSERT the single-source status to a reader rather than
             merely referring to it. They are CARRIERS. The withdrawal does
             not change this entry's DISPOSITION or its canonical home; it
             makes the duplication wider than v1.3 recorded.

DERIVED      THE COMPLETENESS WORD IS DOING WORK THE DOCUMENT CANNOT YET
             SUPPORT. "the complete current MPEG-2-specific knowledge" is a
             coverage claim about a document that, by T1's own premise, has
             never been fed by a full sweep. It is not false - it is
             UNVERIFIED, and it is the same class of statement as LED-023's
             blanket provenance claim.
DERIVED-BASIS  Task register section T1: "authority document v1.05 ... was
             built from the investigation rounds plus a TARGETED recovery
             during the v1.03-v1.05 passes. It has never been fed by the full
             sweep." The register is a ratified document making an explicit
             statement about this one.
```

```text
TIER     C
PROPOSED
ACTION   At T3, reduce to a pointer to the header rule. SEPARATELY, W3D
         recommends the word "complete" be reconsidered when T1 closes - not
         now. It becomes true at T1 closure and is misleading until then, so
         the honest fix is sequenced with the sweep rather than applied to a
         document the sweep has not finished reading.
VERDICT  [W3C]
```

---
# LED-034  Section 1 - the four-layer statement taxonomy

```text
DOCUMENT     authority v1.05, section 1, lines 231-240
CLAIM        The document "deliberately separates four kinds of statements":
             CODEC FACT (what MPEG-2/H.262 actually signals/organises), PIXEL
             GEOMETRY (where the reconstructed-frame block boundaries/taps
             are), ARCHITECTURE (how Deblock4 decides/schedules candidate
             edges), KERNEL (whether/how a scheduled candidate is filtered);
             and "Confusing these layers caused several earlier design
             errors."
ASSERTS      two propositions: (a) the four-layer taxonomy exists and governs
             how this document's statements are to be read; (b) layer
             confusion is a recorded historical cause of design error in this
             project.
CLASS        DERIVED, W3X-RATIFIED as part of v1.04/v1.05
DISPOSITION  CURRENT-UNIQUE
REASON       Both propositions are current, and neither is stated anywhere
             else in the live corpus. The taxonomy is load-bearing well
             beyond this section: section 9.3's four-layer B2 decomposition,
             section 13.1's schedule-decides-WHERE / kernel-decides-WHETHER
             rule, and the standing instruction not to let a local edge
             predicate become an implicit geometry classifier are all
             instances of it. Those are APPLICATIONS of the taxonomy, not
             copies of it.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for "CODEC FACT", "PIXEL GEOMETRY" as a
             paired term, and for the four-way layer separation as a
             proposition (terms: "four kinds of statements", "layers",
             "codec fact"). Found only here. The nearest relatives are
             section 13.1 in this document and the designer introduction's
             section 3 reasoning notes, both of which state the
             schedule/kernel two-layer split without the four-layer
             taxonomy. NOT CLAIMED: that no document expresses the taxonomy
             in wholly different vocabulary; a semantic search over 47
             documents for an unnamed concept is not a search this entry
             performed.

DERIVED      WITHDRAWN IN PART AT v1.5, AND THE WITHDRAWAL IS RECORDED
             RATHER THAN THE PARAGRAPH SIMPLY DELETED, PER DEC-51.

             THE PROPOSITION WITHDRAWN: v1.3 asserted a PROTECTION GAP -
             that neither T3 nor DEC-07 has a rule protecting a
             CURRENT-UNIQUE statement sitting inside a section whose other
             propositions become pointers, and that a new protection rule
             was therefore needed. THAT PROPOSITION IS WITHDRAWN ENTIRELY.
             It does not follow: T3 reduces NON-CANONICAL DUPLICATES to
             pointers. It does not instruct anyone to delete CURRENT-UNIQUE
             content from its own canonical authority. The gap was inferred
             from a rule the entry had not tested against its own wording.

             WHAT SURVIVES, AND IT IS NOT THE SAME CLAIM: the taxonomy is
             the most reusable thing in section 1 and is currently findable
             only by reading section 1. That remains true and remains worth
             recording as an input to T3's presentation decisions. It is an
             OBSERVATION ABOUT DISCOVERABILITY, not a claim that any process
             threatens the text.
DERIVED-BASIS  The surviving observation rests on this entry's own SWEPT
             result - no second carrier of the four-layer taxonomy exists in
             the live corpus - and on DEC-07, which makes the README
             user-facing so that it cannot become an alternative home.
             THE WITHDRAWN PROPOSITION'S BASIS IS ALSO WITHDRAWN: it rested
             on a reading of T3 that T3's own scope does not support.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE. No wording change, and NO NEW PROTECTION RULE IS
         REQUIRED - the v1.3 proposal for one is withdrawn with the
         proposition behind it. W3D records the discoverability observation
         as an input to T3's presentation decisions, not as a constraint on
         them.
VERDICT  [W3C]
```

---
# LED-035  Section 1 - Classic is not a Deblock4 design or acceptance basis

```text
DOCUMENT     authority v1.05, section 1, lines 242-244
CLAIM        "Classic is referenced only for engineering contrast. The
             standing rule remains: nothing in Classic's algorithm or vector
             source is a Deblock4 design or acceptance basis."
ASSERTS      that Classic's algorithm and vector source may inform
             engineering only, and are excluded from Deblock4 design and
             acceptance.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current and binding, and stated in at least three places in this
             document alone - here, at section 0 item 7, and as ratified
             decision D4-D08 in the section 22 register. The register entry
             is the decision; this is a restatement inside a terminology
             section.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: D4-D08 in the section 22 ratified decision
             register. A ratified decision's home is the decision register,
             not a prose restatement.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: this one at lines 241-243;
             section 0 item 7 of this document (which is the designated
             read-first summary layer and was dispositioned RETAIN-SUMMARY at
             T1S01a3 LED-016 - it is not affected by this entry); the
             designer introduction's section 6.5 REJECTED list; Project
             Status; the Forward Roadmap; the coder introduction; and the D0
             Binding Knowledge Index. NOT EXHAUSTIVE.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: acceptance basis | design or acceptance.
             9 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority, D4-D08
               CARRIER     coder introduction
               CARRIER     designer introduction
               CARRIER     designer chat blurb
               CARRIER     Scopes/ D4 Architecture ReDecision W3C Evaluation
                           - it STATES the rule while using it
               CARRIER     Scopes/ D4 PreScope Round Brief coder response
               DIFFERENT   Forward Roadmap - Stage 3C's DEFERRED acceptance
                           basis, a different proposition
               DIFFERENT   Project Status - "separation of STATUS AND
                           ACCEPTANCE BASIS", a different proposition
               DIFFERENT   D0 Preface and Binding Knowledge Index - the
                           oracle-construction exception's acceptance basis
             THE ARITHMETIC, STATED IN W3C's OWN WORDING BECAUSE THE EARLIER
             PHRASING WAS THE DEFECT: the NINE CANDIDATE HITS W3C reproduced
             RESOLVE TO SIX PROPOSITION-BEARING FILES - the canonical
             authority plus five non-canonical carriers. Nine is a count of
             HITS, never of carriers. v1.3's per-file hit arithmetic counted
             the phrase family rather than the proposition, and the three
             DIFFERENT files above are exactly what that conflation hid.
             THREE PROPOSITIONS SHARING TWO WORDS. Found by classifying
             rather than counting; W3C had not challenged these three.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   At T3, reduce to a pointer to D4-D08.
VERDICT  [W3C]
```

---
# LED-036  Section 1.1 - the Schedule-SA/SB/SC renaming rule

```text
DOCUMENT     authority v1.05, section 1.1, lines 246-259
CLAIM        Two unrelated historical A/B pairs exist - "Architecture A / B /
             C / D = MPEG-2 GEOMETRY-ARCHITECTURE alternatives in the
             2026-08-16 re-decision" and "Processing Schedule A / B / C in the
             old README = ORDER OF FILTERING already-selected edges" - and
             "This document calls the latter Schedule-SA, Schedule-SB and
             Schedule-SC to prevent accidental conflation."
ASSERTS      two propositions: (a) the two A/B families are distinct and name
             different things; (b) this document adopts the SA/SB/SC spelling
             for the processing-order family, and the reason is collision
             avoidance.
CLASS        DERIVED, W3X-RATIFIED as part of v1.04/v1.05
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Appendix A's terminology list restates the renaming and
             the distinction, at lines 1813-1814: "Schedule-SA / Schedule-SB
             / Schedule-SC ... Processing ORDER alternatives, unrelated to
             Architecture A/B/C/D." That is the same proposition in glossary
             form. What Appendix A does NOT carry is the REASON for the
             renaming or the identification of the old README as the source
             of the colliding names, both of which are here.
PREVAILS     CANONICAL HOME: THIS COPY. Section 1.1 is the canonical home
             because it states the rule, its origin and its purpose;
             Appendix A is a terminology restatement that omits all three.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED AS THE EVIDENCE REQUIREMENT
             REQUIRES: Appendix A of this same document, lines 1813-1814.
             KNOWN NON-CANONICAL COPIES ALSO INCLUDE: the Concise Project
             Summary lines 211-212, which define Schedule A and Schedule B
             under the OLD names. NOT AN EXHAUSTIVE LIST - the sweep recorded
             below searched for the SA/SB/SC spelling and for bare
             Schedule A/B, and did not attempt every paraphrase of "the two
             A/B families are different".
SWEPT        TWO SEARCHES, AND THEY ANSWER DIFFERENT QUESTIONS. Both are
             recorded because collapsing them is how a whole-document audit
             gets mistaken for a corpus claim.

             (i) WITHIN-DOCUMENT, retained from v1.3 as delivered. Searched
             this document for every occurrence of "Schedule A", "Schedule
             B", "Schedule C", "Schedule-SA", "Schedule-SB" and
             "Schedule-SC": 15 hit lines, at 216, 254, 258, 259, 262, 263,
             1107, 1113, 1123, 1594, 1698, 1813, 1920, 1951 and 1970. Only
             lines 254 and 263 use the bare old names, and both are
             explicitly identifying the old README's vocabulary.

             (ii) CORPUS-LEVEL, REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: Schedule-SA | Schedule-SB | naming collision.
             3 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority, section 1.1 - it states the rule,
                           its origin and its purpose
               CARRIER     designer introduction - states the renaming AND
                           the collision it prevents
               APPLIES     Project Status - uses the SA/SB spelling without
                           stating the rule
             THE DISTINCTION THE REBUILD ENFORCES: bare "Schedule A" and
             "Schedule B" surviving elsewhere in the corpus is a COLLISION
             FINDING, not automatically a copy of this renaming rule. The
             enumeration of those surviving uses belongs to LED-037, which
             adjudicates the audit claim resting on search (i).

DERIVED      WITHDRAWN AT v1.3 AS FALSE. v1.0 to v1.2 stated "THIS IS THE
             FIRST ENTRY IN T1 TO CLAIM STAY-CANONICAL". IT IS NOT.
             T1S01a3 ledger v1.4 already claims it twice, at LED-020
             (line 535) and LED-021 (line 654), both as DUPLICATE-ACTION
             fields, both recorded as corrected from RETAIN-SUMMARY at
             ledger v1.3 per DEC-38. W3C found this.
             THE SUBSTANTIVE RESULT OF THIS ENTRY IS UNAFFECTED: section 1.1
             is still the canonical home, Appendix A lines 1813-1814 is still
             a concrete non-canonical copy, and the DEC-43 evidence
             requirement is still satisfied. Only the first-use framing goes.
             WHY THE WITHDRAWAL IS RECORDED RATHER THAN THE SENTENCE SIMPLY
             DELETED: the claim was inherited from the resume brief and
             repeated with the brief cited as its basis, which made an
             unchecked statement look sourced. That is worth leaving visible.
DERIVED-BASIS  WITHDRAWN. The basis cited was resume brief section 0a: "no
             entry anywhere in T1 has yet claimed STAY-CANONICAL ... a5 is
             where that first happens." THE RESUME BRIEF WAS WRONG, and W3D
             repeated it without opening the a3 ledger it was a claim about.
             The brief is corrected at v1.7 and the failure is recorded at
             register DEC-41 as instance eleven.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as the canonical home. At T3, Appendix A's entry may
         remain as a glossary line provided it points here for the reason.
VERDICT  [W3C]
```

---
# LED-037  Section 1.1 - the v1.04 naming-consistency audit claim

```text
DOCUMENT     authority v1.05, section 1.1, lines 261-265
CLAIM        "v1.04 naming-consistency audit: every ACTIVE processing-order
             reference in this document uses Schedule-SA/Schedule-SB/
             Schedule-SC. Bare historical Schedule A/B/C wording appears only
             where the old README names are being identified explicitly.
             Architecture A/B/B2/C/D remains reserved for the
             geometry-architecture alternatives. No ambiguous active A/B
             shorthand remains."
ASSERTS      a coverage claim about this document's own text: that the
             renaming at LED-036 was applied completely, with the only
             surviving old-name uses being explicit identifications of the
             README vocabulary.
CLASS        DERIVED (a self-audit result recorded at v1.04)
DISPOSITION  CURRENT-UNIQUE
REASON       No second document in the applicable knowledge population reports
             the same naming-consistency audit result. See SWEPT (iii), which
             is the search that establishes it.
             WITHDRAWN AT v1.6, AND RECORDED RATHER THAN DELETED PER DEC-51:
             v1.3 and v1.5 reasoned "it is an audit record about this document,
             so no other document can hold it." THAT IS NOT A UNIQUENESS PROOF.
             W3C found it in the Tier C sample review and the objection is
             plainly right - ANOTHER DOCUMENT CAN REPEAT OR REPORT AN AUDIT
             RESULT. The disposition survives, but on a searched basis rather
             than an a-priori one.
             The entry remains, unusually for a coverage claim in this project,
             TESTABLE BY A READER - and W3D tested the claim itself rather than
             accepting it. See SWEPT (i)/(ii).
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        THE CLAIM WAS TESTED, NOT ACCEPTED, and the test is recorded so
             it can be attacked.
             POPULATION: every line of authority v1.05 matching "Schedule A",
             "Schedule B", "Schedule C", "Schedule-SA", "Schedule-SB" or
             "Schedule-SC", case-sensitive, whole document, 1983 lines.
             RESULT: 15 hit lines - 216, 254, 258, 259, 262, 263, 1107, 1113,
             1123, 1594, 1698, 1813, 1920, 1951, 1970.
             CLASSIFICATION OF EACH: lines 254 and 263 carry bare old names,
             and both are inside section 1.1 itself, explicitly identifying
             the old README vocabulary - which is exactly the exception the
             claim states. All thirteen others use the SA/SB/SC spelling.
             VERDICT ON THE CLAIM: TRUE as written, for this document.
             SCOPE NOT CLAIMED BY THE CLAIM AND NOT ESTABLISHED BY THIS
             CHECK: anything about other documents. See DERIVED.

             (iii) THE UNIQUENESS SEARCH, ADDED AT v1.6 FROM CLASSIFICATION
             REPAIR v1.1. W3C's Tier C review found that searches (i) and (ii)
             test whether the audit is TRUE and expressly establish nothing
             about other documents - so the CURRENT-UNIQUE disposition had no
             search behind it. This is that search.
             PROBE FAMILY: naming-consistency audit | No ambiguous active A/B.
             POPULATION: the settled 46-file a5 search population at 0.5.
             1 CANDIDATE FILE, CLASSIFIED:
               CANONICAL   this authority - the audit record itself
             NO SECOND DOCUMENT REPORTS AN EQUIVALENT AUDIT RESULT. W3C
             independently reached the same result in the Tier C review.
             CLAIMED SCOPE, PER DEC-50: uniqueness within the declared
             population under the declared probe family. It does not claim
             that no document reports such an audit in wholly different
             vocabulary.

DERIVED      THE RENAMING IS COMPLETE INSIDE THIS DOCUMENT AND UNCONTAINED
             OUTSIDE IT. Bare "Schedule A" / "Schedule B" survive as ACTIVE
             CURRENT vocabulary in six live documents, enumerated here so the
             finding can be tested rather than believed:

               AI_Charter_and_Invariants_Card v1.31 line 1767 - "Schedule A
                   versus B remains an open quality decision" (P-10's worked
                   example) and line 1865 - the stage 3C/3D description.
               README_Deblock4_Design_Spec v1.12 lines 92, 265, 319, 320 -
                   the schedule-status line, the Stage 2C obligation, and two
                   decision-status table rows.
               Deblock4_Concise_Project_Summary v1.5 lines 211-212 - full
                   DEFINITIONS of Schedule A and Schedule B under the old
                   names - and line 345.
               Deblock4_Forward_Roadmap v1.22 line 133.
               Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index v1.14
                   lines 157, 160, 164, 329 - knowledge item K11 is stated
                   entirely in the old vocabulary.
               Deblock4_Project_Status v1.32 lines 424, 532, 1183, 1245.

             Four further files matched and are NOT counted as active
             collisions: the holywu_r9 provenance document and
             Deblock4_Stage_2C_D2_HolyWu_Real_Schedule v1.7 use "Schedule A"
             as the name of the VERIFIED HOLYWU ORDER for Classic, which is a
             legitimate historical use in a Classic-specific document; the
             designer-introduction instructions file and this authority are
             accounted for above.

             WHY IT MATTERS RATHER THAN BEING A TIDINESS POINT: section 1.1
             gives the reason for the renaming as preventing accidental
             conflation with Architecture A/B. The charter and the Concise
             Summary both discuss Architecture A/B/D and Schedule A/B in the
             same document, and the Concise Summary DEFINES Schedule A and
             Schedule B two hundred lines from its architecture material.
             The collision the authority renamed to prevent is live in the
             corpus.
DERIVED-BASIS  The enumeration above, produced by whole-word search across
             the live corpus with the four non-collision cases separated by
             opening each hit.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN the audit claim unchanged - it is true as written.
         SEPARATELY, register the corpus-wide collision as a T1 finding with
         routing: README -> T1S02/T1S03; charter and D0 -> T1S04; Concise
         Summary, Roadmap and Project Status -> T1S05. W3D recommends the
         later steps propose the SA/SB spelling in each, EXCEPT in
         Classic-specific documents where "Schedule A" names the verified
         HolyWu order and the rename would lose that meaning.
VERDICT  [W3C]
```

---
# LED-038  Section 1.2 - the edge-position symbol `e`

```text
DOCUMENT     authority v1.05, section 1.2, line 272
CLAIM        "e = first sample on the q side of an edge"
ASSERTS      the edge-position convention used throughout this document.
CLASS        SPEC-VERIFIED (project convention, ratified in the charter)
DISPOSITION  CURRENT-DUPLICATE
REASON       Identical in substance to charter invariant B1, which states the
             convention with its full p2 p1 p0 | q0 q1 q2 expansion and
             declares it is "used everywhere without exception". The charter
             is the controlling document and the convention is not
             MPEG-2-specific.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: charter invariant B1.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: this one at line 269, and
             Appendix A of this document. NOT EXHAUSTIVE.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: first sample on the q side | q0 | p2 p1 p0.
             15 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   charter invariant B1
               CARRIER     this authority - the local restatement adjudicated
               CARRIER     README - the kernel sections
               CARRIER     Scopes/ D4 Architecture ReDecision W3C Evaluation
                           - it DEFINES e = first sample on the q side
               APPLIES     designer introduction
               APPLIES     Concise Project Summary
               APPLIES     Project Status
               APPLIES     D0 Preface and Binding Knowledge Index
               APPLIES     D2 HolyWu Real Schedule
               APPLIES     Scopes/ D4 PreScope Round Brief coder response -
                           uses p0/q0 in formulae without defining them
               IDENTIFIER  Scopes/ D4 Architecture ReDecision Brief. THE "q0"
                           MATCH IS THE SUBSTRING INSIDE THE IDENTIFIER
                           D4-Q01. This is the misclassification that gave
                           the sweep rules their sharpest lesson.
               IDENTIFIER  holywu_r9 provenance record - quotes C++ symbols
               IDENTIFIER  holywu_r9/deblock.cpp - C++ symbol
               IDENTIFIER  holywu_r9/deblock_sse4.cpp - C++ symbol
               NOISE       T1_Evidence_Old_Designer_3_Answers zip - a binary
                           archive decoded as text; see the strays note
             WHAT THE REBUILD CHANGED, AND IT IS THE POINT OF THE EXERCISE:
             v1.3's search reported the D0 index and the README as though
             they carried the convention equally. Opening every hit separates
             four files that DEFINE it from five that merely USE it and five
             that match on a symbol or an identifier substring. The README
             and D0 copies remain Classic-facing and belong to T1S02/T1S03
             and T1S04 respectively.

DERIVED      A POINTER HERE HAS A COST THE DEFAULT RULE DOES NOT SEE. Section
             1.2 is the coordinate key for every geometry statement in
             sections 4, 10, 11 and 12; replacing `e` with a cross-document
             pointer makes the authority's mathematics unreadable without the
             charter open beside it. W3D raises this rather than resolving
             it, because the general question - whether a coordinate key
             inside a mathematical authority is a duplicate or a necessary
             local definition - is one T3 will meet repeatedly.
DERIVED-BASIS  Sections 4.1-4.6, 10.1-10.2, 11 and 12.1-12.3 all use `e` and
             `s` without redefining them; section 1.2 is the only definition
             inside this document's body.
```

```text
TIER     C
PROPOSED
ACTION   W3D recommends POINTER-WITH-RESTATEMENT at T3: keep the one-line
         definition and add "(charter B1)". If W3X prefers the strict rule,
         a bare pointer is correct and this entry does not resist it.
         This is a W3X decision - see covering note Q3.
VERDICT  [W3C]
```

---
# LED-039  Section 1.2 - the MPEG-2 coordinate symbols and the pitch generalisation

```text
DOCUMENT     authority v1.05, section 1.2, lines 273-275
CLAIM        "k,m = non-negative integer grid indices"; "p = woven-frame row
             parity, p in {0,1}"; "s = row pitch of a horizontal filter
             footprint in frame-memory rows"
ASSERTS      three symbol definitions, of which two - woven-frame parity and
             row pitch in frame-memory rows - are MPEG-2-specific and have no
             equivalent in the charter's H.264-derived convention.
CLASS        DERIVED, W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       `p` and `s` exist because a woven frame carries field-organised
             transform blocks at row pitch 2, which is the whole subject of
             sections 4.3, 10.2, 11 and 12. Nothing in the charter, the
             README or any other live document defines them. `k,m` is generic
             but is defined here as part of the same key.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for "row pitch", "pitch-2", "parity" as
             a coordinate term, and "woven": `s` as row pitch and `p` as
             woven-frame parity appear only in this document and in the
             Scopes/ architecture re-decision material, which is T1S01b and
             is the working record behind this document rather than a
             competing definition. The charter uses "pitch" only in the
             stride/alignment sense (C-SIMD-03), which is a different
             quantity with the same English word.

DERIVED      THE WORD "PITCH" IS OVERLOADED ACROSS THE PROJECT AND THE
             OVERLOAD IS NOT FLAGGED ANYWHERE. Here it means the row step of
             a filter footprint, in rows. In the charter and the source it
             means the byte or sample stride of a plane. A reader moving
             between the authority and a coding scope meets both.
DERIVED-BASIS  Charter C-SIMD-03 ("VapourSynth frame strides are byte
             counts"); charter Part 6.4's terms table, which does not list
             pitch; this section's definition.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE. W3D recommends adding one clause distinguishing
         footprint row pitch from plane stride, at T3 or at the next
         authority version bump, whichever comes first. Wording is not
         proposed here because it would be an authority edit.
VERDICT  [W3C]
```

---
# LED-040  Section 1.2 - the plane-relative chroma coordinate rule

```text
DOCUMENT     authority v1.05, section 1.2, lines 278-279
CLAIM        "All chroma coordinates are in that chroma plane's own sample
             grid. Never derive a chroma block step mechanically by dividing
             a luma step by subsampling."
ASSERTS      that chroma geometry is expressed in chroma sample coordinates,
             and that deriving a chroma step by dividing a luma step is
             forbidden.
CLASS        W3X-RATIFIED (charter invariant)
DISPOSITION  CURRENT-DUPLICATE
REASON       This is charter invariant B5, verbatim in substance: "Chroma
             steps are in CHROMA SAMPLE coordinates. They are never derived
             by dividing luma steps by a subsampling ratio." The charter
             additionally carries the worked 4:2:0 macroblock justification.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: charter invariant B5.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: this one at lines 279-281;
             section 4.5's opening line, which restates it as "All
             coordinates below are CHROMA-PLANE coordinates"; the designer
             introduction section 3.4; and the README's chroma geometry
             material. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "subsampl" combined with "divid",
             and for "chroma sample coordinates": found charter B5, this
             section, section 4.5 of this document, the designer introduction
             3.4, the coder introduction, the README, and the D4 PreScope
             coder response in Scopes/ (T1S01b).

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   At T3, reduce to a pointer to charter B5. The same decision W3X
         makes at LED-038 about coordinate keys applies here; if the answer
         there is pointer-with-restatement, it should be the answer here too.
VERDICT  [W3C]
```

---
# LED-041  Section 2 - F1, F2 and F3, the block and macroblock composition facts

```text
DOCUMENT     authority v1.05, section 2, lines 286-302
CLAIM        THREE propositions, each accounted for separately below.
             F1 [H.262-VERIFIED]: "The DCT operates on 8x8 blocks of SAMPLES
             in the coded plane. An 8x8 chroma block is eight chroma samples
             by eight chroma samples, not an 8x8 luma-coordinate rectangle."
             F2 [DERIVED FROM H.262-VERIFIED FACTS]: "Block coordinates are
             plane-relative. In 4:2:0, one 8x8 chroma block spans the area
             corresponding to 16x16 luma samples, but the transform still
             acts on 8x8 actual chroma samples."
             F3 [H.262-VERIFIED]: blocks per macroblock - 4:2:0 -> 6,
             4:2:2 -> 8, 4:4:4 -> 12, with the Y/Cb/Cr composition.
ASSERTS      that transform blocks are defined in samples of their own plane;
             that 4:2:0 chroma block coverage is plane-relative rather than
             luma-relative; and the per-format block counts of a macroblock.
CLASS        F1 and F3 H.262-VERIFIED; F2 DERIVED and explicitly labelled so.
DISPOSITION  CURRENT-DUPLICATE
REASON       All three are current and none is disputed. All three are also
             stated in Deblock4_MPEG2_Grid_Field_DCT_Knowledge v1.2, which
             this document's header supersedes and which T2 will retire.
             Superseded-by-declaration is not the same as retired: that
             document is still in the live tree and still in T1's population,
             so its copies are real copies today.
CONFLICTS    none. Charter B5's parenthetical states the same 4:2:0 geometry
             consequence as F2 in different words ("An MPEG-2 4:2:0
             macroblock has one 8x8 chroma block per component covering the
             whole 16x16 luma area: chroma pitch 8 = luma pitch 16"). That
             is agreement, not conflict.
PREVAILS     CANONICAL HOME, PER PROPOSITION: F1 -> this F-series entry;
             F2 -> this F-series entry, with charter B5's parenthetical as a
             non-canonical restatement of its 4:2:0 consequence; F3 -> this
             F-series entry. The F-series IS the project's home for verified
             MPEG-2 block-geometry facts, by the header's single-source rule.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPIES, NAMED: Deblock4_MPEG2_Grid_Field_
             DCT_Knowledge v1.2 states the 8x8-samples definition and the
             4:2:0 chroma coverage; charter B5's parenthetical states F2's
             4:2:0 consequence. KNOWN NON-CANONICAL COPIES ALSO INCLUDE the
             README's MPEG-2 geometry material. NOT AN EXHAUSTIVE LIST - the
             sweep below searched for the geometry propositions, not for
             every place a document mentions 8x8 blocks.
SWEPT        Searched the live corpus for "8x8" combined with "chroma", for
             "plane-relative", and for the block-count sets "4Y+1Cb" and
             "6 blocks": found this document, the Grid Knowledge document,
             the charter (B5 parenthetical only), the README, the GAIS
             investigation briefs and answers (T1S01b), and the Scopes/
             re-decision material (T1S01b). The GAIS files are evidence
             captures and are not treated as competing copies.

DERIVED      F2's PROVENANCE LABEL IS THE MODEL THE REST OF THE PROJECT
             SHOULD FOLLOW, and it is worth saying so while adjudicating it.
             F2 could have been written as a verified fact - it follows
             inevitably from F1 and F3 plus the sampling matrices - and
             instead it is labelled DERIVED with the clause numbers of the
             definitions it combines. That is the discipline the discredited
             GAIS citation set at section 8 exists to enforce.
DERIVED-BASIS  Section 2.1's F2 record: "6.1.1.8 defines 4:2:0 Cb/Cr matrices
             as half the Y dimensions; 6.1.1.9 and 6.1.1.10 define the
             4:2:2/4:4:4 component-matrix relationships; combining those
             facts with F1/F3 yields the plane-relative geometry statement."
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. At T2, the Grid Knowledge copies are
         retired with that document. At T3, the README copies become
         pointers. Charter B5's parenthetical is a charter invariant's own
         justification and W3D recommends it STAYS - stripping a rule's
         reason to a pointer weakens the rule.
VERDICT  [W3C]
```

---
# LED-042  Section 2 - F4, the 4:2:0 chroma frame-organisation asymmetry

```text
DOCUMENT     authority v1.05, section 2, lines 304-308
CLAIM        F4 [H.262-VERIFIED - CENTRAL ASYMMETRY]: "For a FRAME PICTURE in
             4:2:0, chrominance blocks SHALL remain organised in frame
             structure for DCT coding even when the luma macroblock uses
             field DCT. In 4:2:2 and 4:4:4, chroma follows the luma
             frame/field DCT organisation."
ASSERTS      two coupled propositions: (a) 4:2:0 chroma stays frame-organised
             in a frame picture regardless of luma dct_type; (b) 4:2:2 and
             4:4:4 chroma follow luma organisation and therefore cannot
             inherit the 4:2:0 simplification.
CLASS        H.262-VERIFIED, clause 6.1.3, re-verified at v1.04 (section 2.1)
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, verified, and the single most-restated fact in the
             corpus. It is stated at section 0 item 3 (the designated summary
             layer), at sections 4.5 and 4.6 as geometry consequences, at
             section 5 as the reason SeparateFields is fatal, at section 9.3
             item 10's mode table, and in at least seven live documents
             outside this one.
CONFLICTS    none. It is the fact that REFUTES the GAIS-alleged libpostproc
             behaviour at P1; that refutation is adjudicated at LED-060.
PREVAILS     CANONICAL HOME, PER PROPOSITION: both (a) and (b) -> this F4
             entry. Sections 4.5 and 4.6 hold the GEOMETRY CONSEQUENCES in
             chroma-plane coordinates, which are separate propositions with
             their own entries (LED-050, LED-052) and are not copies of F4.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPIES, NAMED: the designer introduction
             v1.28, which states the rule four times, including in its
             IMMEDIATE ORIENTATION block and its section 6.1 SETTLED list;
             and Project Status v1.32. KNOWN NON-CANONICAL COPIES ALSO
             INCLUDE the designer chat blurb, the Grid Knowledge document,
             and the Scopes/ re-decision documents (T1S01b). NOT AN
             EXHAUSTIVE LIST.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: remain organised in frame structure |
             frame-organised | 6.1.3.
             13 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority, F4
               CARRIER     designer introduction - states the rule and its
                           H.262 6.1.3 source
               CARRIER     designer chat blurb
               CARRIER     Concise Project Summary
               CARRIER     Grid Knowledge v1.2 - quotes 6.1.3 verbatim
               CARRIER     Project Status
               CARRIER     Scopes/ D4 Architecture ReDecision Brief
               CARRIER     Scopes/ D4 Architecture ReDecision W3C Evaluation
               CARRIER     Scopes/ D4 PreScope Round Brief
               CARRIER     Scopes/ D4 PreScope Round Brief coder response
               CARRIER     Scopes/ D4 Verification Round Brief v1.0
               CARRIER     Scopes/ D4 Verification Round Brief v1.1
               APPLIES     Designer Chat 2 Death Resume Brief - records that
                           the conclusion is CLOSED citing 6.1.3; does not
                           state the rule
             CHANGED FROM v1.3: the GAIS investigation files no longer appear
             at all. DEC-66 removes GAIS_investigations/ from search and
             adjudication alike, so they are not candidates and are not
             counted. This is a population change, not a reclassification.
             Section 0 item 3 of this document was dispositioned
             RETAIN-SUMMARY at T1S01a3 LED-013 and is unaffected by this
             entry.

DERIVED      none. The temptation here is to derive that F4 makes B2's
             chroma handling free, and section 9.3 item 10 already states
             that consequence. Deriving it again in a findings entry would be
             the leak the two-part template exists to prevent.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. At T3, the orientation documents'
         copies become pointers - with the caveat that the designer
         introduction's IMMEDIATE ORIENTATION block is a read-first layer and
         W3D expects a RETAIN-SUMMARY argument to be made for it when T1S05
         reaches that document. Not decided here.
VERDICT  [W3C]
```

---
# LED-043  Section 2 - F5, dct_type semantics and the NO_DCT prohibition

```text
DOCUMENT     authority v1.05, section 2, lines 310-317
CLAIM        F5 [H.262-VERIFIED]: "`dct_type` is macroblock-level syntax where
             applicable. With frame_pred_frame_dct == 0, relevant coded
             macroblocks in one frame picture may choose frame or field DCT
             independently. With frame_pred_frame_dct == 1, frame DCT
             organisation is forced/inferred. Macroblocks with no coded
             transform residual do not necessarily carry a meaningful
             `dct_type` bit and MUST NOT be fabricated into a truth class
             merely to make an experiment table rectangular."
ASSERTS      three propositions: (a) dct_type is macroblock-level and varies
             where signalled; (b) frame_pred_frame_dct forces or permits;
             (c2) a macroblock without a usable truth label MUST NOT be
             fabricated into a FRAME or FIELD class for the Q14 experiment.
             NARROWED AT v1.5 under the atomic-claim rule. v1.3's proposition
             (c) bundled TWO things: a CODEC-SYNTAX FACT - that a macroblock
             with no coded residual does not necessarily carry a meaningful
             dct_type bit - and a DEBLOCK4 EXPERIMENT RULE forbidding its
             fabrication into a truth class. They have different classes,
             different provenance and different canonical homes. The codec
             fact is now (c1) at LED-043a; the experiment rule stays here as
             (c2).
CLASS        (a) and (b) H.262-VERIFIED (W3C report V4.3, re-checked v1.04);
             (c2) is a PROJECT RULE about experiment integrity carried inside
             a verified-fact entry.
DISPOSITION  CURRENT-DUPLICATE
REASON       All current. (a) and (b) are restated at section 0 item 4, at
             the section 3 regime table and at section 6.2. (c2) is restated
             at section 0 item 15's Q14 description ("NO_DCT/skipped/
             motion-only macroblocks are their own truth class; they are never
             fabricated into FRAME/FIELD labels"), in section 15, and in the
             Scopes/ D4 Architecture ReDecision W3C Evaluation, and it belongs
             with the Q14 experiment definition.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: (a) and (b) -> this F5 entry,
             as verified codec facts. (c2) -> the D4-Q14 experiment definition
             in section 15, which is where experiment integrity rules belong.
             (c2) IS NOT CANONICAL HERE.
DUPLICATE-ACTION  STAY-CANONICAL for (a) and (b); POINTER for (c2).
             CONCRETE NON-CANONICAL COPY OF (a)/(b), NAMED: the section 3
             regime table at lines 377-392, which restates the
             frame_pred_frame_dct semantics in tabular form. KNOWN
             NON-CANONICAL COPIES ALSO INCLUDE Project Status, both
             introductions and the Grid Knowledge document. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "dct_type" and for
             "frame_pred_frame_dct": found this document (many), the Grid
             Knowledge document, both introductions, Project Status, both
             chat blurbs, the Concise Summary, the GAIS files and the Scopes/
             re-decision documents. REBUILT FROM CLASSIFICATION REPAIR v1.1 for the
             fabrication prohibition. PROBE FAMILY: no coded transform
             residual | fabricated into | truth class.
             2 CANDIDATE FILES, BOTH CLASSIFIED:
               CANONICAL   this authority - F5 for (a)/(b); section 15 is
                           canonical for (c2)
               CARRIER     Scopes/ D4 Architecture ReDecision W3C Evaluation
                           - states the no-fabrication rule: do not force a
                           no-residual macroblock into a false FRAME or FIELD
                           ground-truth class
             CHANGED FROM v1.3, which recorded the prohibition as appearing
             "nowhere else in the live corpus". IT APPEARS IN THE SCOPES/
             EVALUATION. That is the concrete non-canonical copy the (a)/(b)
             STAY-CANONICAL claim needs in order to be testable, and it is
             named here rather than left to inference.

DERIVED      A VERIFIED-FACT ENTRY IS CARRYING A PROJECT RULE, AND THE
             PROVENANCE LABEL COVERS BOTH. F5 is tagged [H.262-VERIFIED].
             Propositions (a) and (b) are, and so is (c1) at LED-043a.
             Proposition (c2) - "MUST NOT be
             fabricated into a truth class merely to make an experiment table
             rectangular" - is a Deblock4 experiment-integrity rule that
             H.262 does not state and could not state. The tag is therefore
             broader than the verified content of the entry it labels.
             THIS IS A PROVENANCE DEFECT, not a factual one: the rule is
             right, it is just not H.262-verified.
DERIVED-BASIS  Section 2.1's F5 record cites "W3C verification report V4.3,
             H.262 macroblock syntax / dct_type semantics" - syntax and
             semantics, not experiment methodology. H.262 has no concept of a
             Deblock4 truth class.
```

```text
TIER     C
PROPOSED
ACTION   SPLIT F5 at the next authority version bump: keep (a), (b) and
         (c1) as F5 [H.262-VERIFIED], and move (c2) to the D4-Q14 experiment
         definition in section 15, where section 0 item 15 already states it.
         W3D does NOT propose the edit here - the authority is not edited by
         a ledger - and flags that this is exactly the atomic-claim defect
         (DEC-33a) occurring in the SOURCE DOCUMENT rather than in a ledger
         entry.
VERDICT  [W3C]
```

---
# LED-043a  Section 2 - F5, the no-coded-residual codec fact

```text
SPLIT FROM LED-043 AT v1.5 under the atomic-claim rule. Proposition (c1),
formerly bundled with the Q14 experiment rule under one disposition. The
substantive position is UNCHANGED; only its housing and its provenance label
change.

DOCUMENT     authority v1.05, section 2, lines 315-317
CLAIM        "Macroblocks with no coded transform residual do not necessarily
             carry a meaningful `dct_type` bit"
ASSERTS      (c1) a CODEC-SYNTAX LIMITATION: the presence of a meaningful
             dct_type bit is conditional on there being a coded transform
             residual. This is a fact about what MPEG-2 signals, not a rule
             about what Deblock4 may do with it.
CLASS        H.262-VERIFIED, from the same W3C report V4.3 basis as F5's
             other syntax propositions
DISPOSITION  CURRENT-UNIQUE
REASON       The classification repair's probe for the no-residual /
             fabrication / truth-class family returned two files, and the only
             one stating this MEANINGFULNESS QUALIFICATION is this authority.
             The Scopes/ evaluation carries the EXPERIMENT RULE (c2), not the
             codec fact. Two propositions in adjacent sentences, one carrier
             each, and only the rule is duplicated.
CONFLICTS    none.
PREVAILS     n/a - unique. Canonical home is F5, and it belongs there: unlike
             (c2) this IS an H.262 syntax fact and the [H.262-VERIFIED] tag
             covers it correctly.
SWEPT        FROM CLASSIFICATION REPAIR v1.1. PROBE FAMILY: no coded transform
             residual | fabricated into | truth class. 2 candidate files, both
             classified - this authority (CANONICAL) and the Scopes/ D4
             Architecture ReDecision W3C Evaluation (CARRIER of the
             fabrication rule only). No second carrier of the meaningfulness
             qualification was found.
             CLAIMED SCOPE, PER DEC-50: this establishes uniqueness within the
             46-file settled a5 search population under the declared probe
             family. It does not claim that no document states the same codec
             fact in wholly different vocabulary.

DERIVED      THE SPLIT REPAIRS A PROVENANCE DEFECT RATHER THAN A FACTUAL ONE,
             AND THAT IS WHY IT MATTERS. LED-043 records that F5's
             [H.262-VERIFIED] tag was broader than its verified content,
             because the tag covered an experiment rule H.262 could not state.
             Separating (c1) from (c2) is what makes the tag honest: (c1) is
             genuinely H.262-verified and stays under it; (c2) moves to
             section 15 where it is a project rule and is labelled as one.
DERIVED-BASIS  Section 2.1's F5 record cites "W3C verification report V4.3,
             H.262 macroblock syntax / dct_type semantics". Syntax and
             semantics cover (c1). They do not reach (c2), which is Deblock4
             experiment methodology.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as part of F5. When F5 is split at the next
         authority version bump per LED-043's action, (c1) stays with (a) and
         (b) under the H.262-VERIFIED tag and only (c2) moves to section 15.
VERDICT  [W3C]
```

---
# LED-044  Section 2 - F6, the post-decode knowledge limit

```text
DOCUMENT     authority v1.05, section 2, lines 319-323
CLAIM        F6 [DERIVED]: "A normal post-decode VapourSynth filter sees
             reconstructed pixels, not the MPEG-2 macroblock syntax. It
             cannot KNOW per-macroblock dct_type unless a trusted
             decoder/source supplies side data. Pixel inference and bitstream
             truth are different things."
ASSERTS      that dct_type is not available to this filter at runtime, and
             that inference from pixels and truth from the bitstream are
             categorically different.
CLASS        DERIVED, and correctly labelled - it is a consequence of the
             VapourSynth filter contract, not an H.262 statement.
DISPOSITION  CURRENT-UNIQUE
REASON       Current, and the F-series is the only place it is stated as a
             fact. Everything else in the corpus that touches it is a
             CONSEQUENCE of it rather than a copy: section 0 item 4's closing
             sentence, the whole existence of the B2 detector at section 9.3,
             D4-Q13's side-data question at section 13.5, and D4-Q14's need
             for bitstream-side extraction. Those are applications.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for the proposition (terms: "side
             data", "post-decode", "bitstream truth", "cannot know"):
             the hits are this document's F6, section 13.5, section 15, the
             designer introduction's Q14 material and the Scopes/ re-decision
             documents. Each was read far enough to classify it: all state a
             CONSEQUENCE (a detector is needed; side data is a future option;
             Q14 needs bitstream extraction) rather than restating the
             knowledge limit itself. The nearest thing to a second statement
             is section 0 item 4, "A post-decode pixel filter does not know
             that bit unless trusted side data is supplied", which is the
             read-first summary layer's compression of THIS entry and was
             dispositioned RETAIN-SUMMARY at T1S01a3 LED-013.

DERIVED      F6 IS THE PREMISE THE ENTIRE ARCHITECTURE RESTS ON, AND IT IS
             LABELLED DERIVED WITH NO STATED BASIS. F1-F5 carry clause
             numbers or a named verification report at section 2.1. F6 has
             neither - section 2.1 audits only the [H.262-VERIFIED] claims,
             so F6, F7 and F8 have no recorded derivation basis anywhere.
             The claim is almost certainly correct, and "almost certainly
             correct with no recorded basis" is the condition the SWEPT field
             and the provenance discipline exist to remove.
DERIVED-BASIS  Section 2.1's scope: "W3C therefore re-audited every active
             `[H.262-VERIFIED]` F-series claim". F6, F7 and F8 are tagged
             [DERIVED] and are outside that audit's declared population.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE. W3D recommends the F6/F7/F8 derivation bases be
         recorded at the next authority version bump - for F6, the
         VapourSynth API4 filter contract and the absence of any dct_type
         frame property. This is a GAP TO FILL, not an error to correct, and
         it is registered rather than fixed here.
VERDICT  [W3C]
```

---
# LED-045  Section 2 - F7, TFF/BFF is not a grid parameter

```text
DOCUMENT     authority v1.05, section 2, lines 325-327
CLAIM        F7 [DERIVED]: "TFF/BFF changes temporal field order, not spatial
             transform-block boundary locations. It is not a Deblock4 grid
             parameter."
ASSERTS      that field order is temporal, that it does not move transform
             block boundaries, and that it therefore has no place in the grid
             parameter surface.
CLASS        DERIVED, no recorded basis (see LED-044's DERIVED).
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Restated at section 0 item 2, which is tagged
             "[D4-D02, F7]" and therefore explicitly points here; and at
             section 4.3's closing line, "TFF/BFF does not alter these
             spatial row sets", which is the same proposition applied to the
             field-organised row mathematics.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this F7 entry. Section 0's copy is the
             designated summary layer and already cites F7 by name.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED: section 4.3 of this
             document, line 500, "TFF/BFF does not alter these spatial row
             sets" - adjudicated separately at LED-048. KNOWN NON-CANONICAL
             COPIES ALSO INCLUDE the designer introduction's SETTLED list
             ("three source-mode semantics; TFF/BFF irrelevant to block
             geometry") and Project Status. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "TFF" and "BFF" and for "field
             order": found this document at F7, section 0 item 2 and section
             4.3; the designer introduction's section 6.1; Project Status;
             the Concise Summary; and the Scopes/ re-decision material
             (T1S01b). No live document contradicts it, and no live document
             lists TFF/BFF as a grid parameter.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. Section 4.3's restatement is
         adjudicated at LED-048.
VERDICT  [W3C]
```

---
# LED-046  Section 2 - F8, vertical edges are geometry-invariant

```text
DOCUMENT     authority v1.05, section 2, lines 329-332
CLAIM        F8 [DERIVED]: "Frame-vs-field DCT changes vertical SAMPLE
             ADJACENCY for HORIZONTAL edges. It does not move vertical block
             columns. Vertical luma edges stay at x=8*k and filter across
             columns within one row."
ASSERTS      that the frame/field distinction affects horizontal edges only,
             and that vertical luma edges are invariant at x=8k.
CLASS        DERIVED, no recorded basis (see LED-044's DERIVED).
DISPOSITION  CURRENT-DUPLICATE
REASON       Current, and load-bearing for the whole architecture: it is why
             the hard problem is horizontal topology and why B2's classifier
             is needed only for horizontal decisions. Restated at section 0
             item 5 [D4-D12], at section 4.4, and at section 11's
             Architecture D topology where vertical is listed as
             "geometry-invariant; process normally".
CONFLICTS    none. It CORRECTS a superseded statement - the pre-B2 W3C SIMD
             description that proposed a parity-split vertical four-row pack.
             That correction is recorded at section 4.4 and adjudicated at
             LED-052a.
             CORRECTED AT v1.6. v1.3 and v1.5 both pointed at LED-049, which is
             the MediaInfo triage entry. W3C found this in the Tier C sample
             review: the retirement record is LED-052a - LED-052 carries the
             current vertical geometry consequence, LED-052a carries the
             explicit retirement of the old parity-split description.
PREVAILS     CANONICAL HOME: this F8 entry, for the FACT. Section 4.4 holds
             the geometry statement in coordinates and the retirement record;
             section 11 holds Architecture D's use of it.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED: section 0 item 5 of this
             document, "VERTICAL TRANSFORM-BLOCK EDGES ARE GEOMETRY-
             INVARIANT" - the designated summary layer, dispositioned
             RETAIN-SUMMARY at T1S01a3 LED-014. KNOWN NON-CANONICAL COPIES
             ALSO INCLUDE the designer introduction's ACTIVE ARCHITECTURE
             block ("Vertical edges remain geometry-invariant x=8k") and
             Project Status. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "geometry-invariant", "x = 8*k" /
             "x=8k", and "vertical luma": found this document at F8, section
             0 item 5, section 4.4, section 11 and section 19; the designer
             introduction; Project Status; the designer chat blurb; and the
             Scopes/ re-decision evaluation (T1S01b), which is where the
             superseded parity-split description originated.

DERIVED      F8 IS THE REASON THE ARCHITECTURE PROBLEM IS TRACTABLE AT ALL,
             AND IT IS THE WEAKEST-EVIDENCED OF THE EIGHT. If vertical edges
             moved with dct_type, B2 would need a classifier for both axes
             and Architecture D's "process normally" vertical rule would be
             wrong. It is tagged DERIVED, has no recorded basis, and is
             assumed by every architecture in the register including the
             rejected ones. W3D believes it is correct - it follows directly
             from field organisation being a REORDERING OF ROWS, which cannot
             move a column boundary - but believing it is the position this
             sub-tranche is supposed to distrust.
DERIVED-BASIS  F1 (blocks are 8x8 samples in the coded plane) plus section
             4.3's row mapping y = 2*r + p, which permutes rows only. The
             derivation is short and sound; the point is that it is not
             WRITTEN DOWN in the document that depends on it.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. RECORD the one-line derivation basis
         at the next authority version bump, alongside F6's and F7's. W3D
         recommends this be treated as the highest-value of the three,
         because F8 is the load-bearing one.
VERDICT  [W3C]
```

---
# LED-047  Section 2.1 - the H.262 provenance re-audit and its result

```text
DOCUMENT     authority v1.05, section 2.1, lines 335-371
CLAIM        TWO propositions. (a) THE PER-FACT PROVENANCE RECORDS: F1 direct
             re-verification against definition 3.12 and 6.1.4; F2
             reclassified DERIVED with 6.1.1.8, 6.1.1.9, 6.1.1.10 named;
             F3 direct re-verification against 6.1.3; F4 direct verification
             via W3C report V4.1 and 6.1.3; F5 direct verification via W3C
             report V4.3. (b) THE AUDIT RESULT: "no active
             `[H.262-VERIFIED]` claim in this document depends on GAIS",
             with the explanation that F1 and F3 were not explicit enough in
             the original V4 report and F2 is deliberately labelled DERIVED
             rather than overstating a direct quotation.
ASSERTS      that every tagged H.262 claim has a recorded standard citation
             or named verification report, and that none rests on GAIS.
CLASS        SPEC-VERIFIED provenance record
DISPOSITION  CURRENT-UNIQUE
REASON       Both propositions are current, and this is the only provenance
             record for the F-series in the live corpus. The W3C verification
             reports it cites are evidence behind it, not copies of it - and
             see LED-063 on whether one of them can still be located.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        THE AUDIT RESULT WAS TESTED WITHIN ITS OWN POPULATION, because
             it is a coverage claim and this ledger can check it exactly.
             POPULATION: every occurrence of the string "H.262-VERIFIED" in
             authority v1.05, whole document, 1983 lines.
             RESULT: seven hit lines - 33 (the tag definition in the header),
             286 (F1), 298 (F3), 304 (F4), 310 (F5), 338 (the audit's own
             scope sentence) and 366 (the audit result sentence).
             THEREFORE the tagged population is exactly F1, F3, F4 and F5 -
             four claims, all inside this sub-tranche's range, all with a
             provenance record at 2.1. F2 carries the compound tag
             "[DERIVED FROM H.262-VERIFIED FACTS]" at line 291 and is
             correctly outside the audited set.
             VERDICT ON THE CLAIM: TRUE as written, and now testable by
             counting rather than by trusting the audit.
             NOT ESTABLISHED BY THIS CHECK, and stated so it is not mistaken
             for more than it is: that no UNTAGGED assertion in this document
             rests on GAIS. That is LED-023's blanket claim and it is owed to
             T1S01a7.

DERIVED      THIS LEDGER SUPPLIES EVIDENCE TOWARD LED-023 AND MUST NOT BE
             READ AS DISCHARGING IT. LED-023 asks whether "Nothing in this
             document rests on unverified GAIS testimony" is true across
             1,983 lines. What is now established is narrower and worth
             recording precisely: the TAGGED population is four claims, all
             audited, none GAIS-dependent; and within lines 223-715, the
             untagged assertions this ledger examined - the F6/F7/F8
             derivations, the section 3 regime semantics, the section 4
             geometry mathematics, the section 5 derivation, the section 6
             measurements and the section 7 prior-art records - contain no
             claim whose only support is a GAIS output. Section 7 is the
             opposite case: P1 and P2 record GAIS claims that were REFUTED or
             CORRECTED by independent checking.
             SECTIONS 9-13 AND 14-24 ARE NOT COVERED BY THAT STATEMENT.
DERIVED-BASIS  The tag census above; the reading of lines 223-715 performed
             for this ledger; and section 8's discredited-citation set, which
             records the GAIS claims that were rejected rather than absorbed.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE. Carry the DERIVED paragraph above to T1S01a7 as
         partial evidence for LED-023's discharge, covering lines 223-715
         only. T1S01a5b and T1S01a6 owe the same statement for their ranges;
         without all three, a7 can only qualify LED-023, not confirm it.
VERDICT  [W3C]
```

---
# LED-048  Section 3 - the picture/syntax regime table

```text
DOCUMENT     authority v1.05, section 3, lines 377-399
CLAIM        The four-row regime table mapping picture_structure and
             frame_pred_frame_dct to geometry knowledge - progressive/frame
             geometry -> fixed frame grid; frame picture with
             frame_pred_frame_dct = 1 -> frame DCT forced, no field-DCT
             choice; frame picture with frame_pred_frame_dct = 0, Case (a) ->
             per-MB dct_type MAY vary where signalled; field pictures,
             Case (b) -> field geometry inherent to the picture - together
             with the opening statement that "The cheap picture-level flags
             are useful for corpus triage but are not a runtime substitute
             for per-macroblock truth", and the closing qualification that
             frame_pred_frame_dct = 0 "means that per-macroblock adaptation
             is PERMITTED. It does not prove that a particular picture
             actually contains both FRAME and FIELD macroblocks."
ASSERTS      three propositions: (a) the four-way regime mapping; (b)
             picture-level flags are triage, not runtime truth; (c) permitted
             is not observed - the evidence qualification.
CLASS        (a) H.262-VERIFIED in substance via F5, presented here as a
             derived mapping; (b) and (c) DERIVED.
DISPOSITION  CURRENT-DUPLICATE
REASON       All three current. (a) restates F5's semantics in tabular form
             and adds the Case (a) / Case (b) naming. (c) is stated three
             times in this document - here, in section 0's target-device
             block, and at section 6.2's "Evidence precision" paragraph - and
             again in both introductions and both chat blurbs.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION:
             (a) the regime mapping -> THIS TABLE. F5 states the syntax
                 semantics; the table states the project's Case (a)/(b)
                 vocabulary and the geometry-knowledge column, which F5 does
                 not.
             (b) triage-not-runtime -> section 3.1, which is where the triage
                 route is specified (LED-049).
             (c) permitted-is-not-observed -> section 6.2's "Evidence
                 precision" paragraph, lines 619-625, which states it against
                 the actual measurement and adds the reading rule for
                 historical shorthand. That is the fullest form and the one a
                 reader needs when looking at the numbers.
DUPLICATE-ACTION  STAY-CANONICAL for (a); POINTER for (b) and (c).
             CONCRETE NON-CANONICAL COPY OF (a), NAMED: section 0 item 4 and
             the target-device block of this document, which compress the
             same mapping for the read-first layer and were dispositioned
             RETAIN-SUMMARY at T1S01a3 LED-013. KNOWN NON-CANONICAL COPIES
             ALSO INCLUDE the Grid Knowledge document's regime material and
             the designer introduction's TARGET-DEVICE FACT block. NOT
             EXHAUSTIVE.
SWEPT        Searched the live corpus for "picture_structure",
             "frame_pred_frame_dct", "Case (a)" and "Case (b)": found this
             document, the Grid Knowledge document, both introductions, both
             chat blurbs, Project Status, the Concise Summary, the GAIS
             investigation files and the Scopes/ re-decision documents. Then
             searched specifically for the permitted-not-observed
             qualification (terms "PERMITTED", "does NOT prove", "adaptive-
             capable"): found at three places in this document as stated
             above, in both introductions, in both chat blurbs and in
             Project Status. No live document asserts the stronger claim that
             mixture is observed.

DERIVED      none. The temptation is to derive what the regime table implies
             for B2's necessity; section 6.2 already states that and it is
             adjudicated at LED-055.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN the table in place as canonical. At T3, reduce the external
         copies of (c) to pointers - but W3D recommends that the
         permitted-is-not-observed qualification be treated as PROTECTED
         wherever the LG measurement is quoted, because a measurement quoted
         without it is the exact overstatement the project has repeatedly
         had to correct.
VERDICT  [W3C]
```

---
# LED-049  Section 3.1 - the MediaInfo triage route

```text
DOCUMENT     authority v1.05, section 3.1, lines 401-415
CLAIM        The command form `mediainfo --Details=1 <file.mpg> | findstr
             /C:"frame_pred_frame_dct" /C:"picture_structure"`, with the
             instruction to "Use it to triage/categorise corpus material, not
             to generate B2 ground truth", the statement that this is the
             practical ground-truth triage route referred to elsewhere, and
             the statement that "MediaInfo/ffprobe do not provide the
             required labelled per-macroblock dct_type map for the
             experiment; D4-Q14 needs bitstream/decoder-side extraction for
             that."
ASSERTS      three propositions: (a) the specific tool invocation; (b) its
             legitimate use is corpus triage; (c) it is NOT the Q14 per-MB
             truth source, which needs bitstream/decoder-side extraction.
CLASS        MEASURED tool usage - the invocation was actually run during the
             grid-knowledge work.
DISPOSITION  CURRENT-DUPLICATE
REASON       All three current. The invocation and its interpretation
             originate in Deblock4_MPEG2_Grid_Field_DCT_Knowledge v1.2, which
             this document supersedes and T2 will retire; the
             not-per-MB-truth qualification is also stated at section 0's
             target-device block and in both introductions.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: all three -> THIS SECTION. The
             Grid Knowledge document is superseded by this one's own header
             and is scheduled for retirement at T2; a superseded source is
             not a canonical home.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED: Deblock4_MPEG2_Grid_Field_
             DCT_Knowledge v1.2, which carries the MediaInfo route in four
             places. KNOWN NON-CANONICAL COPIES ALSO INCLUDE the designer
             introduction (three mentions, including the explicit "it is NOT
             Q14's per-MB truth source"), the coder introduction (two), and
             the designer chat blurb. NOT EXHAUSTIVE.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: mediainfo | --Details=1.
             6 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority - the surviving triage route
               CARRIER     coder introduction
               CARRIER     designer introduction
               CARRIER     designer chat blurb
               MIXED       Grid Knowledge v1.2. It carries the triage route
                           AND, separately, a general evidence-discipline
                           statement about measuring real files with
                           MediaInfo/ffprobe. TWO MEANINGS IN ONE FILE, so it
                           is MIXED rather than a plain carrier.
               APPLIES     Scopes/ D4 Architecture ReDecision W3C Evaluation
                           - it REPORTS that the old document records the
                           check; it does not state the route
             CHANGED FROM v1.3, AND BOTH CHANGES CAME FROM READING RATHER
             THAN COUNTING: the Grid Knowledge hit is MIXED, not a plain
             carrier, and the Scopes evaluation APPLIES rather than carries.
             v1.3's per-file hit counts measured occurrences of the word;
             they did not measure how many propositions those occurrences
             state. Neither change affects the DISPOSITION or the canonical
             home.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. At T2 the Grid Knowledge copies retire
         with that document - and this entry is the record that the route
         survives here, which is what T2 needs in order to retire it safely.
VERDICT  [W3C]
```

---
# LED-050  Section 4 - the scope statement and the horizontal footprint notation

```text
DOCUMENT     authority v1.05, section 4 opening and 4.1, lines 421-445
CLAIM        TWO propositions. (a) "This section freezes the architecture
             geometry, not the still-open final luma kernel mathematics."
             (b) The pitch-parameterised six-sample footprint notation
             p2 = e-3*s through q2 = e+2*s, with R_s(e) = {e-3s, e-2s, e-s,
             e, e+s, e+2s} and W_s(e) = {e-2s, e-s, e, e+s}, together with
             the qualification that these are "the CURRENT architecture-
             analysis footprint used to prove that old Architecture A does
             not transpose faithfully", that "D4-Q02/Q04 still own the final
             Deblock4 luma formula and final footprint", that a changed
             kernel footprint means bounds and proofs are re-derived, and
             that "The pitch-1 versus pitch-2 adjacency distinction itself
             does not depend on the eventual exact filter coefficients."
ASSERTS      that this section fixes geometry and not kernel mathematics;
             that the analysis footprint is defined as above; and that the
             pitch distinction survives any future change of kernel
             coefficients.
CLASS        DERIVED, W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       The pitch-parameterised notation exists nowhere else in the live
             corpus. Charter B2 states the per-plane-class READ and WRITE
             footprints for luma and proper chroma, but at pitch 1 only and
             without the R_s/W_s parameterisation; it is the H.264-derived
             footprint contract, not this analysis instrument. The
             settled-by-design versus proven-by-measurement separation in (a)
             is a project-wide rule (charter P-06) but this instance is a
             statement about THIS SECTION's scope, which is unique to it.
CONFLICTS    none. Charter B2's footprint and this R_s/W_s notation agree at
             s=1 and the document says so implicitly by using the same six
             samples.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for "R_s", "W_s", "row-pitch notation"
             and "e - 3*s": found only in this document, at 4.1 and in
             sections 11 and 12 which USE the notation. Separately searched
             the charter for its footprint definition (B2, B3, B4) and
             confirmed it is stated at fixed pitch with named radii, not
             parameterised by s. Separately searched for the
             coefficients-independence claim (terms "does not depend on the
             eventual", "filter coefficients"): found only here.

DERIVED      THE INDEPENDENCE CLAIM IN (b) IS THE ONE THAT MATTERS AND IT IS
             THE ONE MOST EASILY MISREAD. "The pitch-1 versus pitch-2
             adjacency distinction itself does not depend on the eventual
             exact filter coefficients" is TRUE and is what lets sections 10
             to 12 do topology mathematics before the kernel exists. What it
             does NOT say, and what a reader in a hurry could take it to say,
             is that the FOOTPRINT EXTENT is independent of the coefficients.
             It is not: the same paragraph says a changed kernel footprint
             means bounds and proofs are re-derived. Adjacency is invariant;
             extent is not.
DERIVED-BASIS  The two sentences sit adjacent in the same paragraph, lines
             441-445, and say different things about different quantities.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE. No change. Recorded because a later kernel scope
         that changes the footprint must re-derive bounds, and this entry is
         where a reader is told that the topology work survives while the
         bounds do not.
VERDICT  [W3C]
```

---
# LED-051  Section 4.2 and 4.3 - frame-organised and field-organised luma geometry

```text
DOCUMENT     authority v1.05, sections 4.2 and 4.3, lines 447-499
CLAIM        THREE propositions.
             (a) FRAME-ORGANISED: horizontal transform-block edges at e = 8*k
                 with s = 1; the worked example at frame row 8 reading rows
                 5,6,7 | 8,9,10 and writing 6,7,8,9.
             (b) WITHIN A MACROBLOCK at M = 16*m: internal block edge at
                 e = M + 8, macroblock-row boundary at e = M + 16, "Both are
                 pitch 1 when the relevant topology is FRAME/FRAME".
             (c) FIELD-ORGANISED: the row map y = 2*r + p with p in {0,1};
                 a boundary every 8 field rows becoming e = 16*k + p with
                 s = 2; the six-tap footprint e-6, e-4, e-2 | e, e+2, e+4;
                 and the worked parities e = 16 and e = 17 at the
                 macroblock-row boundary.
             NARROWED AT v1.3: the TFF/BFF sentence at line 500, formerly
             carried here as proposition (d), is now LED-051a. This entry
             covers only (a), (b) and (c).
ASSERTS      the exact whole-frame coordinates of horizontal luma transform
             edges under both organisations.
CLASS        DERIVED from F1, F5 and F8, W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
             CHANGED AT v1.5 FROM CURRENT-UNIQUE. W3C's cross-check answer
             establishes that the Scopes/ architecture re-decision evaluation
             does not merely USE these coordinates - it STATES them. The
             uniqueness claim therefore fails and the entry is a duplicate
             whose canonical home is still this section.
REASON       (a)-(c) are the mathematics itself and are canonical here.
             Sections 10, 11 and 12 of this document USE these coordinates
             and are consumers rather than copies. The Scopes/ evaluation is
             different in kind: it is the derivation record in which the
             whole-frame transposition was first worked out, and it carries
             the coordinate forms themselves.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: authority sections 4.2 and 4.3, for all three
             propositions. The Scopes/ evaluation is the working derivation
             record behind the ratified statement, not a competing home.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED AS DEC-43 REQUIRES:
             Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md,
             which states e and q0, the R_s/W_s footprint sets, e = 8*k with
             s = 1, the row map y = 2*r + p, e = 16*k + p with s = 2, the six
             taps, and worked parity examples. NOT EXHAUSTIVE - the sweep
             below searched for the coordinate forms, not for every
             paraphrase of the geometry. That document is adjudicated in its
             own right at T1S01b, and the relationship between a derivation
             record and a ratified statement is a question for that step.
SWEPT        For the uniqueness claim on (a)-(c): searched the live corpus
             for "16*k", "16\*m", "2\*r", "e = 8\*k", "s = 2" and "six-tap":
             the coordinate forms appear in this document (sections 4, 10, 11
             and 12) and in the Scopes/ architecture re-decision evaluation
             (T1S01b), which is the working record in which the whole-frame
             transposition was first derived. That document is adjudicated in
             its own right at T1S01b and its relationship to this section -
             derivation record versus ratified statement - is a question for
             that step, not this one. No other live document states the
             coordinates.

DERIVED      THE FIELD-ORGANISED FOOTPRINT SPANS ELEVEN FRAME ROWS FOR A
             SIX-SAMPLE FILTER, AND TWELVE FOR THE TWO-PARITY UNION. THAT IS
             THE FACT WITH SIMD AND BOUNDS CONSEQUENCES.
             CORRECTED AT v1.5. v1.3's heading said THIRTEEN while its own
             next sentence said eleven - an internal contradiction inside one
             paragraph, found by W3C and accepted by W3D without argument.
             The correct figures: at s = 2 the read set e-6 .. e+4 spans rows
             e-6 to e+4 inclusive, which is ELEVEN frame rows touched to
             reach six samples; the two parity edges at e and e+1 together
             span e-6 through e+5, which is TWELVE. Charter B4's eligibility test is
             stated in terms of read_radius_before and read_radius_after,
             which at pitch 2 are 3*s = 6 and 2*s = 4 rather than 3 and 2.
             The authority does not state that consequence here and charter
             B3 forbids literal radii, so a future implementation must derive
             the radii from the pitch rather than from the sample count.
DERIVED-BASIS  Section 4.3's footprint listing; charter B3 ("Radii are named
             constants selected by plane class ... The literal 7 (minimum
             extent) is specifically forbidden: it is correct only for
             edge_step = 4") and B4's eligibility formula.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE. Register the DERIVED paragraph as an input to the
         future kernel/bounds scope rather than as an authority edit - it is
         a consequence of ratified geometry, not a new decision, and the
         place it must not be forgotten is the eligibility proof.
VERDICT  [W3C]
```

---
# LED-051a  Section 4.3 - TFF/BFF does not move the spatial row sets

```text
SPLIT FROM LED-051 AT v1.3 under the atomic-claim rule (DEC-33(a)). v1.0 to
v1.2 carried this proposition inside LED-051 with its own disposition in a
compound DISPOSITION field. The rule permits two remedies - split the entry,
or narrow the claim - and a compound field is neither. W3C found it. The
substantive result is unchanged; only its housing is.

DOCUMENT     authority v1.05, section 4.3, line 500
CLAIM        "TFF/BFF does not alter these spatial row sets."
ASSERTS      that field order does not move the field-organised row sets
             derived immediately above it in section 4.3.
CLASS        DERIVED from F7
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. It is F7 restated as a closing qualification on the
             section 4.3 mathematics. F7 states the general fact; this states
             its application to the row sets just derived.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: F7 in section 2.
DUPLICATE-ACTION  POINTER. Section 4.3 is not a designated summary layer, so
             the narrow 5.4 exception does not reach it.
             KNOWN NON-CANONICAL COPIES INCLUDE: this line 500 - which
             LED-045 names as the concrete copy its STAY-CANONICAL evidence
             requirement depends on - and section 0 item 2's "[D4-D02, F7]"
             tag line. NOT EXHAUSTIVE.
SWEPT        See LED-045's sweep, which enumerated the TFF/BFF population
             across the live corpus as defined at section 0.5. No separate
             search is claimed here, and none is needed: this entry's
             duplication rests on the same enumeration.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   At T3, reduce to a pointer to F7. NOTE THE DEPENDENCY: LED-045
         claims STAY-CANONICAL for F7 and names THIS line as the concrete
         non-canonical copy that proves F7 is a duplicate at all. If this
         copy is removed entirely rather than made a pointer, LED-045's
         evidence must be re-established from another copy.
VERDICT  [W3C]
```

---
# LED-052  Section 4.4 - vertical luma edges, and the retirement of the parity-split description

```text
NARROWED AT v1.3 under the atomic-claim rule (DEC-33(a)): the retirement
record, formerly proposition (b) with its own disposition in a compound
field, is now LED-052a.

DOCUMENT     authority v1.05, section 4.4, lines 502-511
CLAIM        "For FRAME and FIELD DCT alike: x = 8*k. Filtering is across
             columns within each row. There is no s=2 vertical-row footprint
             simply because the macroblock used field DCT."
ASSERTS      the vertical luma geometry rule in coordinates, and that field
             DCT does not create a pitch-2 vertical footprint.
CLASS        DERIVED from F8
DISPOSITION  CURRENT-DUPLICATE
REASON       F8 expressed in coordinates. Also stated at section 0 item 5 and
             applied at section 11.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: F8 in section 2, which states the fact. This
             section states the coordinate consequence; section 11 states
             Architecture D's use of it.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: section 0 item 5 of this
             document (RETAIN-SUMMARY at T1S01a3 LED-014), the designer
             introduction's ACTIVE ARCHITECTURE block, and Project Status.
             NOT EXHAUSTIVE. See LED-046's sweep.
SWEPT        See LED-046's sweep, run over the population at section 0.5.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   At T3, reduce to a pointer to F8.
VERDICT  [W3C]
```

---
# LED-052a  Section 4.4 - the retirement of the parity-split vertical description

```text
SPLIT FROM LED-052 AT v1.3 under DEC-33(a). Substantive result unchanged.

DOCUMENT     authority v1.05, section 4.4, lines 511-513
CLAIM        "This corrects an early pre-B2 W3C SIMD description that
             suggested a parity-split vertical four-row pack; that
             description is RETIRED."
ASSERTS      that a specific earlier description is retired, and what it
             said.
CLASS        Retirement record
DISPOSITION  CURRENT-UNIQUE
REASON       It is the only place in the live corpus that says the
             parity-split vertical description is retired.
CONFLICTS    none in this document. SEE DERIVED - the retired description IS
             still live in the document it came from. UPGRADED AT v1.5 from
             "may still be" to "IS": the classification repair opened the
             Scopes/ material and confirmed it.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus as defined at section 0.5 for the
             retired description (terms: "parity-split", "parity split",
             "four-row pack", "vertical" combined with "parity"). The
             retirement statement is here. The DESCRIPTION ITSELF was traced
             to the Scopes/ architecture re-decision material, which is
             T1S01b and is not adjudicated here.
             CHANGED AT v1.5. v1.3 recorded that the search DID NOT ESTABLISH
             whether that document's text was ever amended. The
             classification repair opened it: THE RETIRED PARITY-SPLIT
             VERTICAL DESCRIPTION IS STILL PRESENT AND UNMARKED in the
             Scopes/ re-decision material. The exposure is ACTUAL, not
             hypothetical. WHAT IS STILL NOT CLAIMED: that the text was never
             amended at some earlier point - only that it is live now.

DERIVED      A RETIREMENT RECORDED IN THE AUTHORITY DOES NOT AMEND THE
             DOCUMENT THAT CARRIES THE RETIRED TEXT, AND HERE IT HAS NOT.
             Section 4.4 says the parity-split vertical description is
             RETIRED. The document containing it is a live Scopes/ document
             in T1's population, and it STILL PRESENTS THAT DESCRIPTION
             WITHOUT A RETIREMENT MARKER. A reader of THAT document - the
             primary record of the architecture re-decision, and one a
             successor is directed to read - meets a retired SIMD description
             with nothing to warn them.
             STRENGTHENED AT v1.5: v1.3 framed this conditionally ("If it
             still presents that description"). The condition is satisfied.
DERIVED-BASIS  Manifest section 3.2, which lists the six Scopes/ documents as
             live and in scope at T1S01b; section 4.4's retirement sentence,
             which names a W3C SIMD description as its object.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN both propositions in place. REGISTER a named item for
         T1S01b: the retired parity-split vertical description IS still
         presented as current in the Scopes/ re-decision material and should
         be dispositioned SUPERSEDED there. Recorded here so T1S01b does not
         have to rediscover it. W3D notes for DEC-64's benefit that this is
         an ERRONEOUS rather than an OVERTAKEN supersession - the description
         was wrong, not merely superseded - so it is the class that requires
         a propagation search when that rule binds.
VERDICT  [W3C]
```

---
# LED-053  Section 4.5 - 4:2:0 chroma geometry in chroma-plane coordinates

```text
NARROWED TWICE, AND BOTH NARROWINGS KEEP THE ORIGINAL PROPOSITION LETTERS -
relettering would break alignment with notes W3C has already made.

AT v1.3 under the atomic-claim rule (DEC-33(a)): the chroma-plane coordinate
declaration at line 517, formerly proposition (a) with its own disposition in
a compound DISPOSITION field, became LED-053a.

AT v1.5, on the classification repair's finding that (c) and (d) are
DUPLICATE while (b) is UNIQUE: proposition (c), the no-midpoint rule, is now
LED-053c, and proposition (d), the Case-(b) woven-frame pitch, is now
LED-053d. THIS ENTRY NOW COVERS PROPOSITION (b) ALONE.

WHY TWO NEW ENTRIES AND NOT ONE. The repair ran TWO SEPARATE PROBE FAMILIES
for (c) and (d), with different candidate sets and different carriers, and
W3C independently reproduced the second. Housing two separately-evidenced
propositions under one DISPOSITION would be the compound-disposition defect
DEC-61(a) recorded against this very entry. THE NEW ENTRIES ARE NAMED FOR THE
PROBES THAT ESTABLISHED THEM so entry and evidence carry one identifier;
there is deliberately no LED-053b, because LED-053a already covers a
different proposition and inserting a "b" would put entry letters and probe
letters permanently out of step.

DOCUMENT     authority v1.05, section 4.5, lines 519-524
CLAIM        (b) For progressive and Case-(a) frame pictures: horizontal
             chroma block edges at e_c = 8*k, pitch 1; vertical chroma block
             edges at x_c = 8*k.
ASSERTS      the 4:2:0 frame-picture chroma edge coordinates, in chroma-plane
             coordinates.
CLASS        DERIVED from F1, F2 and F4, W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       (b) is the chroma geometry consequence of F4 expressed in
             coordinates, and exists nowhere else in the live corpus. The
             coordinate forms e_c and x_c appear only in this document.
             UNCHANGED FROM v1.3 IN SUBSTANCE - the repair's probes refuted
             the uniqueness of (c) and (d), not of (b).
CONFLICTS    none.
PREVAILS     n/a - unique. Canonical home is this section.
SWEPT        For the uniqueness of (b): searched the live corpus for "e_c",
             "x_c" and "chroma block edges". The coordinate forms e_c and x_c
             appear only in this document. The nearest relative is section 0
             item 3's statement that 4:2:0 chroma geometry is "NORMATIVE, NOT
             DETECTED", which is the F4 consequence rather than the
             coordinate statement.
             WITHDRAWN FROM THIS ENTRY AND RELOCATED, NOT DELETED: v1.3
             recorded the same search as establishing uniqueness for (c) and
             (d) as well. The classification repair refuted that for both.
             The evidence now lives at LED-053c and LED-053d, where the two
             rebuilt probe tables are recorded and can be attacked.
             RETAINED HERE BECAUSE IT IS STILL A LIVE NEGATIVE RESULT: a
             separate search for "midpoint" across the live corpus confirmed
             that NO LIVE DOCUMENT PROPOSES A CHROMA MIDPOINT CLASS. The term
             is live in the README, the charter's parameter list, the Concise
             Summary, the Roadmap and this document, and in every case it
             refers to the LUMA midpoint of rejected Architecture A. That
             result is what makes LED-053c's duplication harmless rather than
             contradictory, and it is recorded in both places.

DERIVED      none. The consequence for the parameter surface - that a
             chroma-facing midpoint parameter would have no referent - is
             D4-Q16's, and section 20 and the register own it.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical.
VERDICT  [W3C]
```

---
# LED-053a  Section 4.5 - the chroma-plane coordinate declaration

```text
SPLIT FROM LED-053 AT v1.3 under DEC-33(a). Substantive result unchanged.

DOCUMENT     authority v1.05, section 4.5, line 517
CLAIM        "All coordinates below are CHROMA-PLANE coordinates."
ASSERTS      that everything in section 4.5 is expressed in the chroma
             plane's own sample grid.
CLASS        W3X-RATIFIED (charter invariant, restated locally)
DISPOSITION  CURRENT-DUPLICATE
REASON       Charter invariant B5's rule restated as a local scope
             declaration for section 4.5.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: charter invariant B5.
DUPLICATE-ACTION  POINTER.
             KNOWN NON-CANONICAL COPIES INCLUDE: this line 517, and section
             1.2's statement of the same rule, adjudicated at LED-040. NOT
             EXHAUSTIVE. See LED-040's sweep.
SWEPT        See LED-040's sweep, run over the population at section 0.5.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   At T3, this follows whatever W3X decides at LED-038 and LED-040
         about local restatements of coordinate rules - see covering note Q3.
         It must NOT be decided separately from those two.
VERDICT  [W3C]
```

---
# LED-053c  Section 4.5 - the no-midpoint/phase-ambiguity rule for 4:2:0 Case (a)

```text
SPLIT FROM LED-053 AT v1.5. Proposition (c). The DISPOSITION CHANGES from
v1.3's CURRENT-UNIQUE: the classification repair found two carriers.

DOCUMENT     authority v1.05, section 4.5, line 526
CLAIM        "There is NO luma-style midpoint/phase ambiguity in 4:2:0
             Case (a)."
ASSERTS      (c) that 4:2:0 Case-(a) chroma has no counterpart to the luma
             midpoint/phase problem - which is why no chroma detector is
             needed and why the rejected Architecture A midpoint machinery has
             no chroma analogue.
CLASS        DERIVED from F1, F2 and F4, W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       CHANGED FROM CURRENT-UNIQUE AT v1.5. The repair's bounded probe
             returned six candidates and two of them STATE the proposition:
             the README in three places, and the Scopes/ architecture
             re-decision evaluation, which states it in chroma-plane
             coordinates as "no midpoint class and no phase detector". The
             uniqueness claim fails; the canonical home does not move.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this section. It states the proposition in the
             chroma-plane coordinate frame the surrounding mathematics uses,
             which is what makes it operative rather than descriptive.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED AS DEC-43 REQUIRES:
             README_Deblock4_Design_Spec v1.12 at lines 285, 658 and 3671 -
             W3C's finding. ALSO NAMED:
             Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md.
             NOT EXHAUSTIVE - the probe searched the midpoint/phase family,
             not every paraphrase of "chroma has no phase problem".
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: luma-style midpoint | corresponding midpoint |
             primary/midpoint | midpoint ambiguity | midpoint class and no
             phase detector.
             6 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority, section 4.5
               CARRIER     README - three places, lines 285, 658, 3671
               CARRIER     Scopes/ D4 Architecture ReDecision W3C Evaluation -
                           in CHROMA PLANE coordinates: no midpoint class and
                           no phase detector
               DIFFERENT   coder introduction - the old LUMA union grid
               DIFFERENT   Concise Project Summary - luma_midpoint_enabled, a
                           LUMA parameter
               DIFFERENT   Verification And Tiering Decisions - the LUMA
                           primary/midpoint grid
             THREE OF SIX MATCHES ARE THE LUMA MIDPOINT, NOT THE CHROMA
             PROPOSITION. That is why v1.3's search - which looked for the
             term rather than the proposition - read the entry as unique.
             THE NEGATIVE RESULT THAT STILL HOLDS, and it is what makes the
             duplication harmless: no live document proposes a CHROMA
             midpoint class. Every "midpoint" hit outside this document
             refers to the LUMA midpoint of rejected Architecture A. Recorded
             at LED-053 as well, because it is load-bearing for both.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. At T3 the README copies become
         pointers; the Scopes/ evaluation is T1S01b's and is not decided
         here.
VERDICT  [W3C]
```

---
# LED-053d  Section 4.5 - Case-(b) woven-frame chroma uses row pitch 2

```text
SPLIT FROM LED-053 AT v1.5. Proposition (d). The DISPOSITION CHANGES from
v1.3's CURRENT-UNIQUE.

DOCUMENT     authority v1.05, section 4.5, lines 528-529
CLAIM        "Case (b) FIELD PICTURES represented as a woven frame use field
             adjacency, hence pitch 2 in frame-memory rows for horizontal
             chroma filtering."
ASSERTS      (d) that Case-(b) horizontal chroma filtering operates at row
             pitch 2 in frame memory, because a woven frame interleaves the
             two fields.
CLASS        DERIVED from F1, F2 and F4, W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       CHANGED FROM CURRENT-UNIQUE AT v1.5. The repair's probe returned
             two candidates and both state the proposition: this authority,
             and a Scopes/ document giving the Case-(b) field-picture
             luma/chroma field grid at row pitch 2.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this section, as the geometry statement in
             chroma-plane coordinates.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED AS DEC-43 REQUIRES:
             Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md,
             which states the Case-(b) field-picture luma/chroma field grid at
             row pitch 2. NOT EXHAUSTIVE.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: row pitch 2 | pitch 2 in frame-memory.
             2 CANDIDATE FILES, BOTH CLASSIFIED:
               MIXED       this authority. Section 4.5 is the copy adjudicated
                           here; APPENDIX A OF THE SAME FILE is a SECOND
                           CARRIER and does not appear as a separate hit.
               CARRIER     Scopes/ D4 PreScope Round Brief coder response -
                           Case (b) field picture: luma/chroma field grid, row
                           pitch 2
             A LIMIT A READER MUST NOT MISS, AND THE ENTRY STATES IT RATHER
             THAN LEAVING IT TO INFERENCE: the same-file second carrier is
             APPENDIX A, at authority lines 1762-1932. THAT IS OUTSIDE THIS
             SUB-TRANCHE. Appendix A belongs to T1S01a6. Citing it here is
             permitted by section 0.2's cited-as-evidence rule, which keeps
             cited statements in their own sub-tranche, but this entry does
             NOT adjudicate Appendix A and must not be read as having done so.
             Raised for W3C at Q-K.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. REGISTER for T1S01a6: Appendix A's
         restatement of the Case-(b) pitch-2 rule is a non-canonical copy of
         this proposition and should be dispositioned there, consistently with
         this entry. Recorded so a6 does not have to rediscover it.
VERDICT  [W3C]
```

---
# LED-054  Section 4.6 - 4:2:2 and 4:4:4 chroma follow luma

```text
DOCUMENT     authority v1.05, section 4.6, lines 531-542
CLAIM        FOUR propositions. (a) "F4 is explicitly 4:2:0-specific." (b)
             "For Case (a), 4:2:2 and 4:4:4 chroma follow the luma
             macroblock's FRAME/FIELD DCT organisation. The B2 luma
             classification map therefore also controls their frame/field
             chroma topology, transformed into that chroma plane's own
             coordinates." (c) "There is no need for an independent chroma
             classifier, but there is also no legal 'always frame'
             simplification." (d) "Exact per-format chroma scheduler tables
             and D4-Q10 vertical-siting consequences remain to be frozen in
             the later kernel/scheduler scope; do not guess them from luma
             subsampling ratios."
ASSERTS      the scope limit of F4; the follow-luma rule and its architectural
             consequence; the two-sided conclusion about chroma classifiers;
             and the deferral of the per-format tables.
CLASS        (a) and (b) H.262-VERIFIED via F4; (c) and (d) DERIVED.
DISPOSITION  CURRENT-DUPLICATE
REASON       All four current. (a) and (b) restate F4's second half and its
             architectural consequence, which section 0 item 10 also states
             in its mode table ("Case (a) 4:2:2 / 4:4:4 chroma -> FOLLOW the
             resolved luma macroblock organisation; no independent chroma
             detector is required"). (d) restates the general
             don't-divide-by-subsampling rule of charter B5 and adds the
             D4-Q10 routing.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION:
             (a) and (b) the codec rule -> F4 in section 2.
             (b)'s ARCHITECTURAL consequence, that the B2 luma map controls
                 chroma topology -> section 9.3/10, the B2 definition. NOTE:
                 those sections are T1S01a5b's, so this entry maps the home
                 without adjudicating it.
             (c) -> THIS SECTION. The two-sided conclusion - no independent
                 classifier needed, no always-frame shortcut permitted - is
                 stated in full only here; section 0 item 10 carries only the
                 first half.
             (d) -> D4-Q10 in the section 21 register.
DUPLICATE-ACTION  POINTER for (a), (b) and (d); STAY-CANONICAL for (c).
             CONCRETE NON-CANONICAL COPY OF (c)'s FIRST HALF, NAMED: section
             0 item 10's mode table line, "no independent chroma detector is
             required", dispositioned RETAIN-SUMMARY at T1S01a3 LED-013. The
             SECOND half - that there is no legal "always frame"
             simplification - has no other copy found by the sweep below,
             which is why (c) stays canonical here rather than becoming a
             pointer to a summary that carries only half of it.
SWEPT        Searched the live corpus for "4:2:2" and "4:4:4": found this
             document (F3, F4, section 4.6, section 0 item 10, Appendix A),
             the Grid Knowledge document, the designer introduction, Project
             Status, the GAIS investigation files and the Scopes/ re-decision
             material. Then searched specifically for the always-frame
             prohibition (terms: "always frame", "always-frame",
             "simplification"): found ONLY at line 542 of this document.
             That single-copy result is the evidence for keeping (c) here.

DERIVED      THE ASYMMETRY IN (c) IS A COST STATEMENT AND IT IS EASY TO READ
             AS A SAVING. "No independent chroma classifier" sounds like
             simplification; combined with (b) it means the LUMA classifier's
             errors propagate into chroma topology for 4:2:2 and 4:4:4. In
             4:2:0 an incorrect luma classification costs a wrong luma edge;
             in 4:2:2 and 4:4:4 the same error costs the chroma planes too.
             Q14's false-confident statistics are therefore format-dependent
             in their consequences even though the classifier is not.
DERIVED-BASIS  (b) and (c) read together; F4's format split; section 0
             item 10's mode table. No claim is made here about what Q14
             should measure - that is T6's.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN (c) in place as canonical; the rest become pointers at T3.
         Carry the DERIVED paragraph to T6 as an input to Q14's metric
         design: the cost of a false-confident classification is not uniform
         across chroma formats.
VERDICT  [W3C]
```

---
# LED-055  Section 5 - the SeparateFields tearing derivation

```text
DOCUMENT     authority v1.05, section 5, lines 547-564
CLAIM        [DERIVED] "SeparateFields sends alternate rows to different
             clips", so a frame-organised 8-row transform block becomes four
             rows in each field clip and "No single field-clip filter
             instance has the original eight consecutive rows"; "For Case-(a)
             4:2:0 chroma this is fatal because H.262 F4 says the chroma DCT
             block remains frame-organised even while luma may be
             field-organised"; "The same problem exists for progressive/
             frame-DCT geometry. Therefore SeparateFields cannot be the
             general MPEG-2 input contract. Whole-frame input is a
             codec-geometry correctness requirement, not a performance
             preference."
ASSERTS      the tearing mechanism, its fatality for Case-(a) 4:2:0 chroma,
             its generality to progressive material, and the conclusion that
             whole-frame input is a correctness requirement.
CLASS        DERIVED from F4 and the VapourSynth SeparateFields contract,
             W3X-RATIFIED as D4-D01
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. The CONCLUSION is ratified decision D4-D01 and is
             stated at section 0 item 1, in the section 22 register, in both
             introductions, in Project Status and in the designer chat blurb.
             THE CLAIM THAT THE DERIVATION IS STATED IN FULL ONLY HERE IS
             WITHDRAWN AT v1.5. It was wrong by two documents. The README
             states the four-rows-each-clip MECHANISM in two places, and the
             Scopes/ D4 Architecture ReDecision Brief states it as well -
             "tears frame-organised blocks across two clips (4 rows each)".
             W3C found the README; the classification repair found the Scopes
             brief. Both propositions are therefore duplicated; what differs
             is which copy is canonical.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: the DERIVATION -> this section,
             uniquely. The CONCLUSION "whole-frame input only" -> D4-D01 in
             the section 22 ratified decision register.
DUPLICATE-ACTION  STAY-CANONICAL for the derivation; POINTER for the
             conclusion. The derivation stays because this section IS its
             canonical home - the fullest statement, with the chroma
             consequence - not because it is unique.
             CONCRETE NON-CANONICAL COPY OF THE DERIVATION, NAMED AS DEC-43
             REQUIRES: README_Deblock4_Design_Spec v1.12, which states the
             mechanism in two places including Appendix A.9.3. ALSO NAMED:
             Scopes/Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md.
             CONCRETE NON-CANONICAL COPY OF THE CONCLUSION, NAMED: section 0
             item 1 of this document, "WHOLE-FRAME INPUT ONLY for MPEG-2 ...
             SeparateFields input is not a supported MPEG-2 contract because
             it tears frame-organised transform blocks between two clips.
             [D4-D01]", dispositioned RETAIN-SUMMARY at T1S01a3 LED-013.
             KNOWN NON-CANONICAL COPIES OF THE CONCLUSION ALSO INCLUDE the
             designer introduction's ACTIVE ARCHITECTURE block, Project
             Status, the Concise Project Summary and the Scopes/ D4 PreScope
             Round Brief. NOT EXHAUSTIVE.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: four rows in each field | four-row projections |
             SeparateFields.
             7 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority - the DERIVATION. D4-D01 in the
                           section 22 register is canonical for the
                           CONCLUSION.
               CARRIER     README - THE MECHANISM, twice: Appendix A.9.3 and
                           an earlier passage. This is what refutes the
                           uniqueness claim. W3C's finding.
               CARRIER     Scopes/ D4 Architecture ReDecision Brief - states
                           the mechanism too: tears blocks across two clips,
                           4 rows each. Found by the classification repair;
                           W3C had not challenged this one.
               CARRIER     designer introduction - the CONCLUSION only
               CARRIER     Concise Project Summary - the conclusion only
               CARRIER     Project Status - the conclusion only
               CARRIER     Scopes/ D4 PreScope Round Brief - the conclusion
                           with a compressed reason
             THE DISTINCTION v1.3 RAISED AND COULD NOT RESOLVE IS RETAINED,
             BECAUSE IT IS STILL UNRESOLVED AND STILL MATTERS: a document
             that describes old Architecture A's separated-field mechanism is
             NOT necessarily asserting that SeparateFields is a supported
             contract. The classification above separates mechanism-carriers
             from conclusion-carriers for these seven files only. It does not
             adjudicate the wider set of documents that merely discuss
             rejected Architecture A; each is adjudicated at its own step.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN the derivation in place as canonical; the conclusion becomes
         a pointer to D4-D01 at T3 wherever it appears outside the register
         and the summary layer.
VERDICT  [W3C]
```

---
# LED-056  Section 6 - the measurement absorption statement

```text
DOCUMENT     authority v1.05, section 6 opening, lines 570-573
CLAIM        "These measurements are absorbed from
             `Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md`. They survive
             because they are real target-corpus evidence that would
             otherwise be lost when that document is superseded."
ASSERTS      that the measurements originate in the Grid Knowledge document,
             that they are absorbed here, and that this is why they survive
             its supersession.
CLASS        Provenance statement
DISPOSITION  CURRENT-UNIQUE
REASON       Current, and it is the only statement in the live corpus that
             records WHY the measurements were carried across. The
             supersession itself is stated in the header (adjudicated at
             T1S01a2) and in T2's task definition; this is the absorption
             record, which is a different proposition.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for "absorb" combined with "measure",
             and for the Grid Knowledge filename: the filename appears in
             this document's header, section 6, section 24's R7 and Appendix
             E; in the task register's T2 definition; in both introductions;
             in the Session Bootstrap Header; and in Project Status. Only
             this section states the absorption-and-survival rationale.

DERIVED      THIS SENTENCE IS T2's SAFETY INTERLOCK AND NOTHING LABELS IT AS
             ONE. T2 retires the Grid Knowledge document. The only recorded
             reason it is safe to retire is that its measurements were
             absorbed HERE - and that record lives in the document doing the
             absorbing rather than in the task that performs the retirement.
             If this sentence were ever reduced as duplication, T2 would lose
             its evidence that nothing measured is lost.
DERIVED-BASIS  Task register T2 ("Retire the Grid Knowledge document",
             BLOCKED by T1); this section's absorption statement; the absence
             of any other absorption record found by the sweep above.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE and mark as PROTECTED against T3 reduction. W3D
         recommends T2's task definition cite this section explicitly as the
         evidence that retirement is safe.
VERDICT  [W3C]
```

---
# LED-057  Section 6.1 and 6.2 - the OTA and LG measurements

```text
DOCUMENT     authority v1.05, sections 6.1 and 6.2, lines 575-606
CLAIM        TWO measurement records.
             (a) OTA: `home_576i.mpg`, 720x576, 4:2:0, interlaced frame
                 pictures, about 5.2 Mb/s; 317 sampled pictures with
                 picture_structure = Frame and frame_pred_frame_dct = No / 0;
                 `home_576p.mpg` as a progressive control. With the three
                 interpretation bullets: all sampled pictures are in the
                 permitted-adaptation regime; this does NOT prove both
                 dct_type values are present; it justifies extracting per-MB
                 truth.
             (b) LG: the five-row mode table - XP, SP, LP at 720x576 with
                 frame_pred_frame_dct No / 0; EP at 352x576, No / 0; MLS at
                 352x288, Yes / 1 - with nominal durations and approximate
                 bitrates.
ASSERTS      the measured picture-level syntax state of the project's actual
             target and reference material.
CLASS        MEASURED
DISPOSITION  CURRENT-DUPLICATE
REASON       Both current. Both originate in Grid Knowledge v1.2, which still
             carries them and which T2 will retire. The LG table is also
             restated in compressed form in the designer introduction, the
             coder introduction, Project Status and the designer chat blurb -
             in each case as "XP/SP/LP/EP measured with
             frame_pred_frame_dct=0", which is the table's conclusion rather
             than the table.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: THIS SECTION, for both measurement records. The
             Grid Knowledge document is superseded and scheduled for
             retirement; the orientation documents carry the conclusion, not
             the data.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED: Deblock4_MPEG2_Grid_Field_
             DCT_Knowledge v1.2, which carries the LG mode table including
             the MLS row (6 hits on "MLS") and the home_576i figures (4
             hits). KNOWN NON-CANONICAL COPIES OF THE CONCLUSION ALSO
             INCLUDE the designer introduction, the coder introduction,
             Project Status, the designer chat blurb and the Scopes/
             architecture re-decision evaluation. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "MLS", for "home_576i" and
             "home_576p", and for "frame_pred_frame_dct" combined with mode
             names. Result: the full LG table exists in exactly two live
             documents - this one and Grid Knowledge v1.2. The OTA figures
             likewise. Every other live carrier states the conclusion without
             the numbers. The Scopes/ evaluation (T1S01b) references the
             regime but not the table.

DERIVED      THE MEASUREMENT SET HAS NO RECORDED METHOD OR DATE. The table
             gives modes, resolutions, approximate bitrates and the flag
             value. It does not record when the measurement was taken, on
             which recorder firmware, over how many pictures, or by what
             command - and the OTA record does say "317 sampled pictures",
             which is exactly the kind of detail the LG table lacks. The
             requirement it fails is the authority's OWN `[MEASURED]` tag
             definition, which the section 6.2 heading carries: "project
             measurement on named material/tooling".
             THIS IS NOT A DOUBT ABOUT THE RESULT. It is the observation that
             the project's single strongest architectural argument rests on a
             table that a successor cannot reproduce from what is written.
             BASIS CORRECTED AT v1.1, AND THE FINDING IS STRONGER FOR IT.
             v1.0 rested this on charter P-08. W3C challenged that before the
             formal review and is RIGHT: P-08 governs claims resting on
             SOFTWARE SOURCE and on STANDARDS, and has no measurement limb at
             all. Citing it here extended a rule to a category it does not
             cover - which is the same move P-08's own third paragraph warns
             against when it says not to invent a clause number to satisfy a
             citation format. The correct basis is INTERNAL and stricter, and
             is stated below.
DERIVED-BASIS  THE AUTHORITY'S OWN PROVENANCE DISCIPLINE, header lines 31-45,
             adjudicated at T1S01a3 LED-022: "`[MEASURED]` - project
             measurement on NAMED MATERIAL/TOOLING". Section 6.2's heading
             carries that tag. It names the material - the LG recorder and
             its five modes - and does NOT name the tooling, the sample size
             or the date. Section 6.1, two paragraphs above and carrying the
             same tag, names its material AND its sample size ("317 sampled
             pictures"), which is why the omission is not house style.
             Section 3.1's MediaInfo command is the probable method but is
             nowhere stated to be the method used for section 6.2.
             THE TAG'S OWN DEFINITION IS THEREFORE NOT SATISFIED by 6.2.

DERIVED-2    A SECOND FINDING FALLS OUT OF THE CORRECTION, AND IT IS ABOUT
             THE CHARTER RATHER THAN THIS DOCUMENT. Charter P-08 is titled
             SOURCE PROVENANCE IS PINNED and has two limbs, software source
             and standards. It has NO limb for measurement - yet this project
             rests an architectural argument on measurement, has a
             `[MEASURED]` provenance tag, and reruns a standing differential
             gate on every toolchain bump. The authority's tag set is
             stricter than the charter's process rule on exactly the evidence
             class that carries the most weight here.
DERIVED-2-BASIS  Charter P-08 read in full, lines 1746-1756 of charter v1.31;
             the authority's provenance tag list, header lines 31-45. Routed
             to T1S04, which adjudicates the charter. NOT proposed as a
             charter amendment here - that would be W3D amending the rules
             that judge W3D's own evidence, and charter I7 governs it.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN both records in place as canonical. REGISTER an item for W3X:
         the LG measurement's method, sample size and date should be recorded
         if they can still be established, and marked as unrecoverable if
         they cannot - which is what the `[MEASURED]` tag already requires of
         it. W3D recommends this be done BEFORE T6 rather than after, because
         Q14's corpus design cites this table. See covering note Q4.
         SEPARATELY, route DERIVED-2 to T1S04: the charter's provenance rule
         has no measurement limb.
VERDICT  [W3C]
```

---
# LED-058  Section 6.2 - REGIME 3, decision significance and evidence precision

```text
DOCUMENT     authority v1.05, section 6.2, lines 609-625
CLAIM        THREE propositions.
             (a) "Every practical restoration mode XP/SP/LP/EP therefore
                 operates in what the older project vocabulary called REGIME
                 3: frame pictures with frame_pred_frame_dct = 0, so
                 applicable macroblocks may choose FRAME or FIELD DCT
                 independently. MLS is a useful uniform-frame-DCT control."
             (b) "Decision significance: this adaptive-capable regime is the
                 NORMAL measured operating regime of the target LG recorder,
                 not an academic codec corner case. That is the strongest
                 existing target-device argument that B2's per-macroblock
                 topology work is warranted rather than gratuitous
                 complexity."
             (c) "Evidence precision: the measurement does NOT yet prove that
                 every practical recording, or every picture in it, actually
                 contains both dct_type values. `No / 0` proves
                 permission/capability at picture level. D4-Q14 exists
                 precisely to extract per-macroblock truth ... In this
                 document, historical shorthand such as 'regime-3 mix' must
                 be read as 'adaptive-capable per-MB regime' unless a later
                 measured Q14 result explicitly proves actual mixture."
ASSERTS      the REGIME 3 vocabulary mapping; the architectural significance
             of the measurement; and the precise limit of what it proves.
             NARROWED AT v1.5 under the atomic-claim rule: the DOCUMENT-LOCAL
             READING RULE for historical shorthand, formerly the tail of
             proposition (c) and sharing this entry's disposition, is now
             LED-058a because its disposition differs. The remaining
             propositions KEEP THEIR ORIGINAL LETTERS (a), (b), (c).
CLASS        (a) MEASURED plus vocabulary mapping; (b) and (c) DERIVED,
             W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       All three current. (b) and (c) are stated together at section
             0's TARGET-DEVICE REALITY block and again in both introductions
             and both chat blurbs. (a)'s REGIME 3 mapping appears here, at
             section 0's target-device block, and in Appendix E's revision
             record.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: all three -> THIS SECTION.
             Section 0's target-device block is the read-first compression of
             exactly this passage and was dispositioned RETAIN-SUMMARY at
             T1S01a3 LED-013; the summary carries (b) and (c). The reading
             rule the summary does NOT carry is adjudicated separately at
             LED-058a.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED: the designer introduction
             v1.28's TARGET-DEVICE FACT / SIGNIFICANCE block, which states
             (b) and (c) in three bullets. KNOWN NON-CANONICAL COPIES ALSO
             INCLUDE the coder introduction, both chat blurbs, Project Status
             and the resume brief's standing-facts section. NOT EXHAUSTIVE.
SWEPT        TWO RESULTS, AND THE SECOND IS A NEGATIVE ONE THAT MUST NOT BE
             DROPPED.

             (i) CARRIERS, REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: adaptive-capable | REGIME 3 | regime-3.
             6 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority, section 6.2
               CARRIER     designer introduction
               CARRIER     coder introduction
               CARRIER     designer chat blurb
               CARRIER     coder chat blurb
               CARRIER     Grid Knowledge v1.2 - the REGIME vocabulary
                           originates here, and it carries the stale
                           shorthand "regime 3, mixed". See LED-058a.
             Project Status, the task register and the resume brief appeared
             in v1.3's wider search; the task register and resume brief are
             now excluded under DEC-63 as T1/ process material.

             (ii) THE NEGATIVE RESULT, RETAINED FROM v1.3 AS DELIVERED AND
             UNCHANGED BY THE REPAIR, because a sweep that finds nothing must
             say so: NO LIVE DOCUMENT WAS FOUND ASSERTING THAT MIXTURE IS
             OBSERVED RATHER THAN PERMITTED. That is the specific error
             proposition (c) exists to prevent, and it is the check that
             matters most for this entry. Nothing in the classification
             repair touched this result, and it is recorded here rather than
             left implicit so a reviewer can attack the search that produced
             it.

DERIVED      MOVED TO LED-058a, where the reading rule is now adjudicated in
             its own right. The finding itself is UNCHANGED IN SUBSTANCE and
             STRENGTHENED IN FACT - see LED-058a's DERIVED, which records
             that the exposure is ACTUAL rather than latent.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. W3D recommends the reading rule be
         treated as a T1-wide rule rather than a document-local one when the
         sweep reaches Grid Knowledge at T1S05 - i.e. any surviving
         "regime-3 mix" phrasing anywhere is read as adaptive-capable, not as
         observed mixture.
VERDICT  [W3C]
```

---
# LED-058a  Section 6.2 - the document-local reading rule for REGIME-3 shorthand

```text
SPLIT FROM LED-058 AT v1.5 under the atomic-claim rule. Formerly the tail of
proposition (c), sharing LED-058's CURRENT-DUPLICATE disposition. Its
disposition differs, so it gets its own entry.

DOCUMENT     authority v1.05, section 6.2, lines 623-625
CLAIM        "In this document, historical shorthand such as 'regime-3 mix'
             must be read as 'adaptive-capable per-MB regime' unless a later
             measured Q14 result explicitly proves actual mixture."
ASSERTS      a READING RULE binding a reader of this authority: an inherited
             phrase that sounds like observed mixture is to be understood as
             permitted adaptation until Q14 measures otherwise.
CLASS        DERIVED, W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE
REASON       Current, and stated nowhere else. Section 0's TARGET-DEVICE
             REALITY block carries the evidence-precision proposition (c) that
             this rule serves, and both introductions and both chat blurbs
             carry the permitted-not-observed distinction - but NONE of them
             carries the READING RULE for the inherited shorthand. That is
             what makes this proposition unique while its parent is a
             duplicate, and it is why the two cannot share a disposition.
CONFLICTS    none.
PREVAILS     n/a - unique. Canonical home is this section.
SWEPT        The carrier search is LED-058's rebuilt probe table, inherited
             rather than restated. What is recorded here is the DIFFERENTIAL
             RESULT that this entry rests on: of the five non-canonical
             carriers of (b) and (c) - both introductions, both chat blurbs
             and Grid Knowledge - NOT ONE states the reading rule. Each was
             opened to establish that, rather than inferred from the absence
             of a phrase match.

DERIVED      THE RULE IS SCOPED TO THIS DOCUMENT AND THE SHORTHAND IT GOVERNS
             IS NOT - AND THE EXPOSURE IS ACTUAL, NOT LATENT.
             UPGRADED AT v1.5. v1.3 recorded this exposure as LATENT on the
             ground that the sweep had found no live document making the
             overstatement. The classification repair opened the Grid
             Knowledge hit and found it CARRIES THE STALE SHORTHAND "regime 3,
             mixed". The rule that would correct that reading says "In this
             document", and Grid Knowledge is a different document - live in
             T1's population until T2 retires it, and the place the REGIME
             vocabulary originates.
             WHAT IS STILL TRUE AND SHOULD NOT BE OVERSTATED: no live document
             asserts that mixture is OBSERVED rather than PERMITTED. The
             defect is inherited SHORTHAND that a reader could take that way,
             not an assertion. See LED-058's SWEPT result (ii).
DERIVED-BASIS  The claim's own wording, which begins "In this document"; the
             classification repair's opened Grid Knowledge hit carrying
             "regime 3, mixed"; the manifest's inclusion of Grid Knowledge
             v1.2 in the live population at T1S05; and task register T2, which
             is BLOCKED by T1 and has therefore not yet retired it.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical. W3D recommends the reading rule be
         treated as a T1-WIDE rule rather than a document-local one - any
         surviving "regime-3 mix" phrasing anywhere is read as
         adaptive-capable, not as observed mixture. The exposure is now known
         to be actual rather than hypothetical, which strengthens the case
         W3D made at v1.3 without changing it. Whether that widening is
         adopted is W3X's; if it is not, T1S05 must handle Grid Knowledge's
         shorthand explicitly when the sweep reaches it.
VERDICT  [W3C]
```

---
# LED-059  Section 6.3 - the corpus consequence

```text
DOCUMENT     authority v1.05, section 6.3, lines 627-639
CLAIM        "The Q14/quality corpus should preserve at least: uniform
             frame-DCT control - LG MLS; adaptive-capable target - LG
             XP/SP/LP/EP; adaptive-capable OTA - home_576i; progressive
             control - home_576p." Followed by "The target-device
             measurements make the B2/D decision a real restoration problem,
             not a theoretical codec corner case."
ASSERTS      a minimum corpus composition for Q14 and the quality work, and
             restates the significance conclusion.
CLASS        DERIVED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. The corpus requirement is stated here and again inside
             the D4-Q14 experiment definition at section 15, which is the
             experiment's own specification. The closing significance
             sentence is (b) of LED-058 restated.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: the CORPUS COMPOSITION ->
             D4-Q14's experiment definition in section 15, which is
             T1S01a6's range. A corpus requirement belongs with the
             experiment that consumes it, not with the measurement that
             motivated it. The SIGNIFICANCE sentence -> section 6.2 (b),
             LED-058.
DUPLICATE-ACTION  POINTER for both.
             KNOWN NON-CANONICAL COPIES INCLUDE: this section, and the
             designer introduction's Q14 material which names the corpus
             classes without the file names. NOT EXHAUSTIVE.
SWEPT        Searched this document for the corpus composition (terms
             "corpus", "MLS", "home_576"): found at 6.3 and in section 15's
             Q14 material. Searched the live corpus for the same: the
             file-level composition appears only in this document and in Grid
             Knowledge v1.2. NOTE THE LIMIT: section 15 is not adjudicated
             here, so this entry records where the canonical home SHOULD be
             without confirming what section 15 actually says about corpus
             composition. T1S01a6 must confirm it; if section 15 turns out
             not to state the composition, this entry's PREVAILS is wrong and
             6.3 is the canonical home after all.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   HOLD the pointer proposal until T1S01a6 confirms what section 15
         states. Recorded as a CONDITIONAL disposition, flagged so it cannot
         be applied unchecked. W3D specifically does not want this one
         ratified as written - see covering note Q5.
VERDICT  [W3C]
```

---
# LED-060  Section 7 - the prior-art records P1 to P4

```text
DOCUMENT     authority v1.05, section 7, lines 646-673
CLAIM        FOUR records.
             P1 [SOURCE-VERIFIED, REFUTING GAIS]: examined FFmpeg libpostproc
                did not expose the alleged interlaced deblocking flag that
                field-splits both luma and chroma by doubling stride;
                `pict_type` carries QP semantics (`PP_PICT_TYPE_QP2`); Y/U/V
                are passed at ordinary per-plane strides; therefore
                libpostproc is not evidence for the wrong Case-(a) 4:2:0
                chroma treatment.
             P2 [SPEC-VERIFIED]: H.264 clause 8.7 MBAFF genuinely defines
                mixed frame/field boundary filtering with field-spaced sample
                addressing; chroma follows MBAFF's macroblock-pair geometry;
                there is no MPEG-2-F4 chroma asymmetry; "The useful
                carry-forward is the CONCEPT that a mixed boundary can be an
                explicit topology, not the H.264 algorithm itself." Plus the
                corrected GAIS details: 8.7.2.2 is "Derivation process for
                the thresholds for each block edge", and no 2x2 chroma
                deblocking-edge concept was found in clause 8.7.
             P3 [SOURCE/PUBLICATION-VERIFIED]: Changick Kim, Signal
                Processing: Image Communication 17(7), 2002, records that
                inter-frame prediction can propagate prior blocking artifacts
                to non-nominal positions; supports D4-Q11's shifted-grid
                limitation.
             P4 [DERIVED]: no verified prior art directly solves MPEG-2
                Case-(a) 4:2:0 luma/chroma grid divergence - "This is NOT a
                claim that no such prior art exists."
ASSERTS      what survived independent verification from the prior-art
             investigation, and what each surviving item does and does not
             support.
CLASS        As tagged: P1 SOURCE-VERIFIED, P2 SPEC-VERIFIED, P3
             SOURCE/PUBLICATION-VERIFIED, P4 DERIVED.
DISPOSITION  CURRENT-UNIQUE
REASON       All four current. This is the only consolidated prior-art record
             in the live corpus. The underlying material exists in the GAIS
             investigation files and the Scopes/ verification-round briefs,
             but those are EVIDENCE - the raw claims and the verification
             work - not competing statements of what survived. The manifest
             classifies both folders as evidence and assigns them to T1S01b.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for "libpostproc" (9 files), "MBAFF",
             "Changick" and "8.7": the hits outside this document are the six
             GAIS investigation files and the six Scopes/ documents, all
             T1S01b, plus the H.264 MBAFF mention in the designer
             introduction. Each non-T1S01b hit was checked to confirm it is
             either a raw GAIS claim, a verification working record, or a
             pointer - not an independent statement of the surviving
             conclusions.

DERIVED      P4's SECOND SENTENCE IS THE MOST DISCIPLINED LINE IN THIS
             SECTION AND THE MOST FRAGILE. "This is NOT a claim that no such
             prior art exists" converts an absence of findings into an
             honest negative result rather than a proof of novelty. It is
             one sentence away from becoming, in a later summary, "no prior
             art solves this" - which is a patent-adjacent claim the project
             has no basis to make and, given the discredited citation set at
             section 8, has specific reason to avoid.
DERIVED-BASIS  Section 8's discredited citation table, in which five patent
             attributions and two paper citations were wrong; P4's own
             wording.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN all four in place. Mark P4's qualifying sentence as PROTECTED
         against summarisation at T3 - it must travel with P4 or P4 must not
         travel.
VERDICT  [W3C]
```

---
# LED-061  Section 8 - the GAIS calibration rule

```text
DOCUMENT     authority v1.05, section 8, lines 681-687
CLAIM        "GAIS was useful as an option-generation/reasoning instrument but
             failed as a citation/factual authority. The adopted standing rule
             is: No GAIS factual claim, quotation or citation enters project
             knowledge without independent verification. GAIS raw outputs
             remain evidence captures only. This W3X-ratified document
             prevails on MPEG-2 design facts."
ASSERTS      the standing verification rule, the evidence-only status of raw
             outputs, and this document's precedence on MPEG-2 design facts.
             NARROWED AT v1.5 under the atomic-claim rule: the NUANCED
             ASSESSMENT OF GAIS AS AN INSTRUMENT - useful for option
             generation, failed as a citation authority - is now LED-061a,
             because its disposition differs from the three propositions
             remaining here.
CLASS        W3X-RATIFIED standing rule
DISPOSITION  CURRENT-DUPLICATE
REASON       Current and binding. Stated in the header's provenance
             discipline ("Nothing in this document rests on unverified GAIS
             testimony", adjudicated at T1S01a3 LED-023 and deferred to
             T1S01a7), in both introductions as a STANDING EXTERNAL-RESEARCH
             RULE, in both chat blurbs, and in the D2 HolyWu Real Schedule
             document.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: the STANDING RULE -> THIS
             SECTION. It is stated here with its justification - what GAIS
             was good for and what it failed at - which no other copy
             carries. The PRECEDENCE clause ("This W3X-ratified document
             prevails on MPEG-2 design facts") -> the header's single-source
             rule, adjudicated at T1S01a3 LED-021.
DUPLICATE-ACTION  STAY-CANONICAL for the rule; POINTER for the precedence
             clause.
             CONCRETE NON-CANONICAL COPY OF THE RULE, NAMED: the designer
             introduction v1.28's STANDING EXTERNAL-RESEARCH RULE block -
             "GAIS is a reasoning aid only. No factual claim, quotation or
             citation enters project knowledge without independent
             verification." KNOWN NON-CANONICAL COPIES ALSO INCLUDE the coder
             introduction, both chat blurbs and the D2 HolyWu Real Schedule
             document. NOT EXHAUSTIVE.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: no GAIS factual claim | independent verification.
             6 CANDIDATE FILES, EVERY ONE CLASSIFIED:
               CANONICAL   this authority, section 8 - the rule with its
                           calibration context
               CARRIER     designer introduction
               CARRIER     designer chat blurb
               CARRIER     coder chat blurb - OMITTED by W3D's original list,
                           found by W3C
               DIFFERENT   coder introduction. The match is charter I7
                           INDEPENDENT VERIFICATION OF SELF-AFFECTING
                           CRITERIA - a charter process rule, NOT the GAIS
                           rule. Two rules sharing two words.
               DIFFERENT   D2 HolyWu Real Schedule. The match is W3C's
                           independent verification OF THAT DOCUMENT under D0
                           section 6 - not the GAIS rule. W3D had listed it
                           as a carrier WITHOUT OPENING IT.
             TWO FALSE CARRIERS REMOVED AND ONE REAL CARRIER ADDED. The count
             is unchanged at six candidate files but the MEMBERSHIP IS
             DIFFERENT, which is precisely the failure DEC-67 records: a
             count that comes out right can still have the wrong members.
             THE GAIS INVESTIGATION BRIEF NO LONGER APPEARS AT ALL - not
             reclassified, but removed from the population by DEC-66. The
             GAIS_investigations/ tree is ignored for search and adjudication
             alike; the raw captures are history, not copies of the rule.

DERIVED      none.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN the rule in place as canonical; the precedence clause becomes
         a pointer at T3. The orientation documents' copies are read-first
         layers and W3D expects a RETAIN-SUMMARY argument for them at T1S05.
VERDICT  [W3C]
```

---
# LED-061a  Section 8 - the assessment of GAIS as a research instrument

```text
SPLIT FROM LED-061 AT v1.5 under the atomic-claim rule. Formerly bundled with
the standing verification rule under one disposition.

DOCUMENT     authority v1.05, section 8, lines 681-682
CLAIM        "GAIS was useful as an option-generation/reasoning instrument but
             failed as a citation/factual authority."
ASSERTS      a two-sided ASSESSMENT of one named external research instrument:
             what it was genuinely good for, and the specific way it failed.
CLASS        W3X-RATIFIED assessment
DISPOSITION  CURRENT-UNIQUE
REASON       Current, and stated in this two-sided form nowhere else. The
             copies elsewhere carry the RULE that follows from the assessment
             - no GAIS claim enters project knowledge without independent
             verification - and the designer introduction states it flatly as
             "GAIS is a reasoning aid only". NONE of them carries the
             assessment WITH ITS JUSTIFICATION: that the instrument earned its
             keep at option generation while failing at citation. That
             asymmetry is what the rule is calibrated against, and losing it
             would leave the rule looking like blanket distrust of a tool
             rather than a measured response to a specific failure mode.
CONFLICTS    none.
PREVAILS     n/a - unique. Canonical home is this section, which pairs the
             assessment with the discredited citation set at lines 698-709
             that evidences it.
SWEPT        The carrier search is LED-061's rebuilt probe table, inherited
             rather than restated. THE DIFFERENTIAL RESULT this entry rests
             on: of the three genuine non-canonical carriers there - the
             designer introduction and both chat blurbs - each was opened, and
             each states the verification RULE without the two-sided
             assessment behind it. The two DIFFERENT files, the coder
             introduction and the D2 document, do not reach either
             proposition.
             CLAIMED SCOPE, PER DEC-50: uniqueness within the 46-file settled
             a5 search population under LED-061's declared probe family. The
             probe searched the rule, so a document assessing GAIS in wholly
             different vocabulary would not have been returned.

DERIVED      none. The temptation is to derive a general rule about research
             instruments from a finding about one of them. Register DEC-66's
             record already notes a possible generalisation of the
             GAIS-specific rule as a POST-T1 question requiring its own
             independent-verification process. Deriving it here would be that
             question answered by a ledger entry.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN IN PLACE as canonical, together with the discredited citation
         set that evidences it. NOTE FOR T1S01a7 AND T8: DEC-66 has made
         LED-023's discharge CONSTRUCTIVE - every authority claim must show a
         recorded non-GAIS basis - so this assessment is now the record of WHY
         that stricter test exists, and should not be reduced to a pointer
         before a7 has used it.
VERDICT  [W3C]
```

---
# LED-062  Section 8 - retained reasoning ideas and the discredited citation set

```text
DOCUMENT     authority v1.05, section 8, lines 690-708
CLAIM        TWO propositions.
             (a) The five reasoning ideas retained after independent
                 assessment: Case-(a) versus Case-(b) framing; static
                 field-DCT failure of motion-only classifiers; texture/noise
                 masking and classifier-flicker failure modes; direct
                 phase/energy measurement as an option family; the grid-shift
                 warning, later independently corroborated by P3.
             (b) The discredited citation set: seven entries mapping a
                 claimed attribution to the true one or to absence -
                 US 6,633,612, US 7,139,437, US 6,167,157, US 7,031,552,
                 US 6,983,079, Kim/Kim/Cho 1999 IEEE TCE 45(3), and Han/Kim
                 2002 IEEE TCSVT.
ASSERTS      what was kept from the external research as reasoning, and what
             was rejected as citation.
CLASS        (a) DERIVED after assessment; (b) SOURCE/PUBLICATION-VERIFIED
             refutations.
DISPOSITION  CURRENT-UNIQUE
REASON       Both current. The discredited set is the calibration evidence
             for the rule at LED-061 - the reason the rule exists rather than
             being a general caution - and this is its only consolidated
             statement. The patent numbers appear in the GAIS files and the
             Scopes/ briefs, but there as the original claims and the
             verification work, not as the corrected table.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Searched the live corpus for the five patent numbers as literal
             strings: found in this document (5 hits), the two GAIS
             investigation answer files, the GAIS followup critique, and four
             Scopes/ documents - all T1S01b evidence. The corrected
             attribution table exists only here. Separately searched for
             "Kim/Kim/Cho" and "Han/Kim": same pattern.

DERIVED      (b) IS THE ONLY RECORD OF WHAT WENT WRONG, AND IT IS FILED UNDER
             A HEADING ABOUT ONE TOOL. Five wrong patent attributions and two
             unlocatable paper citations is a calibration result about
             AI-generated citations in general. It currently sits inside a
             section titled "GAIS ENGAGEMENT AND CALIBRATION RULE", which
             scopes the lesson to one named instrument. The rule at LED-061
             is written the same way. If a future round uses a different
             external research instrument, neither the rule nor its evidence
             names it.
DERIVED-BASIS  Section 8's heading and the rule's wording, both of which name
             GAIS specifically; the designer introduction's version, which
             also names GAIS specifically; the absence of any
             instrument-neutral form of the rule found by LED-061's sweep.
```

```text
TIER     C
PROPOSED
ACTION   RETAIN both in place. W3D RECOMMENDS a charter-level generalisation
         - no externally generated factual claim, quotation or citation from
         ANY research instrument enters project knowledge without independent
         verification - raised as a proper charter proposal under I7 rather
         than proposed as an authority edit here. See covering note Q6. The
         evidence for it is (b), which is already written.
VERDICT  [W3C]
```

---
# LED-063  Section 8 - the calibration record's location

```text
DOCUMENT     authority v1.05, section 8, lines 711-712
CLAIM        "The detailed calibration record remains in the W3C verification
             report and raw GAIS evidence files."
ASSERTS      that a fuller calibration record exists outside this document,
             in two named-by-description locations.
CLASS        Provenance pointer
DISPOSITION  CONFLICTING
REASON       THE RAW GAIS EVIDENCE FILES EXIST AND ARE LOCATABLE - six
             documents in GAIS_investigations/ plus two response captures in
             the root, all live and in T1's population at T1S01b and T1S05.
             THE "W3C VERIFICATION REPORT" MAY NOT. Section 24's reference R8
             names it as
             `Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md`, and no
             file of that name exists anywhere in the live tree. This entry
             therefore points at a record that cannot be retrieved by the
             name the document gives it.
CONFLICTS    section 24 reference R8, and by extension section 2.1, which
             rests the F4 and F5 provenance on "W3C verification report V4.1"
             and "V4.3" - the same report under a different shorthand.
PREVAILS     UNDECIDED HERE, and deliberately so. The conflict is between a
             pointer in section 8 and a reference in section 24, and section
             24 is T1S01a6's range under DEC-55. Resolving it requires
             establishing what the report actually is, which is DEC-58's
             open item. A disposition of the section 8 pointer that assumed
             an answer would be adjudicating a6's reference from a5.
SWEPT        POPULATION AND BASIS, per DEC-50. (1) Filename search of the
             whole supplied documentation tree for
             `*W3C_Verification_and_Design_Review*`: no match. (2) Content
             search of the whole tree for the string
             "Deblock4_D4_W3C_Verification_and_Design_Review": matches only
             in authority generations v1.00 through v1.05, i.e. only in the
             reference that names it. (3) Content search for "V4.1", "V4.3"
             and "verification report": the shorthand appears in this
             document at sections 2.1 and 8, and in the Scopes/ documents.
             (4) The candidate referent W3X supplied,
             `Scopes/Deblock4_D4_Verification_Round_Brief_for_W3C_v1_0.md`,
             EXISTS - but it is a BRIEF issued TO W3C, not a report FROM W3C,
             and this entry does NOT claim it is the referent. Establishing
             that requires reading it against the F4/F5 provenance claims,
             which is T1S01a6's work under DEC-58.

DERIVED      TWO SECTIONS DEPEND ON THIS DOCUMENT AND ONE OF THEM IS THE
             PROVENANCE AUDIT. Section 2.1's whole result - that no active
             H.262-VERIFIED claim depends on GAIS - rests for F4 and F5 on
             "W3C verification report V4.1" and "V4.3". If that report cannot
             be located, F4 and F5's provenance is recorded but not
             RETRIEVABLE, and the audit at LED-047 is verified as internally
             consistent rather than as externally checkable.
             THIS IS NOT A CLAIM THAT F4 OR F5 IS WRONG. F4 additionally
             carries a direct clause citation - H.262 6.1.3 - which is
             independently checkable without the report. F5 carries only the
             report reference.
DERIVED-BASIS  Section 2.1's F4 and F5 records; the four searches above;
             DEC-58.
```

```text
TIER     A
PROPOSED
ACTION   HOLD the disposition. Route to T1S01a6 with DEC-58: establish what
         the W3C verification report is, whether it survives, and under what
         filename. IF IT CANNOT BE ESTABLISHED, W3D recommends F5's
         provenance be re-verified against H.262 directly rather than left
         resting on an unretrievable report - which is a small, bounded piece
         of work and is exactly what the provenance discipline exists to
         force. Recorded here rather than deferred silently.
VERDICT  [W3C]
```

---

# 1. CLOSING QUESTIONS FOR W3C

```text
Q-A  COVERAGE. Section 0.2 declares lines 223-715 adjudicated and enumerates
     the 33 prior-entry ranges it checked for overlap. Is any proposition in
     that range without an entry? The places to look hardest are section
     4.1's notation block, section 6.1's interpretation bullets and section
     7's P2 corrected-GAIS-details paragraph, all of which are bundled inside
     larger entries.

Q-B  THE SPLIT. Section 0.1 declares a5 split into a5 (sections 1-8) and a5b
     (sections 9-13), ratified at DEC-68. Does anything in sections 1-8
     depend on sections 9-13 in a way that makes adjudicating them separately
     unsound?

Q-C  STAY-CANONICAL, AND THE COUNT IS NOW SIXTEEN.
     THE ENUMERATION BELOW WAS PRODUCED BY SEARCHING THE FINISHED LEDGER, NOT
     BY RECALLING WHICH ENTRIES USED IT - the same method v1.3 adopted after
     its first attempt was written from memory, said SIX, and named nine of
     which one was wrong. DEC-51's rule is that an enumeration written from
     recollection is the same assurance in a longer form.
     SIXTEEN entries claim STAY-CANONICAL in their DUPLICATE-ACTION field:
       LED-036, LED-041, LED-042, LED-043, LED-045, LED-046, LED-048,
       LED-049, LED-051, LED-053c, LED-053d, LED-054, LED-055, LED-057,
       LED-058, LED-061.
     WHY IT ROSE FROM v1.3's THIRTEEN, stated so the delta is testable:
     LED-051 gained the action when its disposition changed from
     CURRENT-UNIQUE to CURRENT-DUPLICATE, and LED-053c and LED-053d are new
     entries that both claim it. 13 + 3 = 16.
     FIVE of the sixteen claim STAY-CANONICAL for SOME propositions only,
     with POINTER for others in the same entry - LED-043, LED-048, LED-054,
     LED-055 and LED-061 - so check the per-proposition split as well as the
     action.
     Each names at least one concrete non-canonical copy with its location,
     per DEC-43. Test the named copies: do they exist, do they state the same
     proposition, and is the copy being adjudicated genuinely the canonical
     home rather than merely the one the designer was reading?

Q-D  THE TWO TESTED CLAIMS. LED-037 and LED-047 both TEST a coverage claim
     made by the document rather than accepting it, and both report the claim
     TRUE. Attack the searches, not the conclusions: is the population each
     names the right population, and does the classification of each hit
     hold? LED-037's evidence base is restored in full from v1.3 after the
     recovery reconstruction had removed it - see 0.4f.

Q-E  DERIVED PROPOSITIONS. Are any of these actually findings about existing
     text that have leaked into DERIVED, or conversely, has any inference
     leaked into a DISPOSITION or ASSERTS field? Note two DERIVED fields
     changed at v1.5: LED-034's protection-gap proposition is WITHDRAWN
     entirely, and LED-058a's exposure is upgraded from latent to ACTUAL.

Q-F  THE ONE CONDITIONAL DISPOSITION. LED-059 maps a canonical home into
     section 15, which this sub-tranche has not read, and says so. Is that an
     acceptable conditional, or should the entry simply defer?

Q-G  THE ONE UNDECIDED DISPOSITION. LED-063 dispositions the section 8
     calibration pointer CONFLICTING and declines to say which side prevails,
     because the other side is in section 24 and belongs to a6. Is
     CONFLICTING right when the conflict cannot be resolved within the
     sub-tranche, or should it have been deferred whole? Keep two things
     apart when answering: the MISSING REFERENT is a real provenance conflict
     (DEC-58), while DEC-66 merely removes GAIS_investigations/ from
     adjudication. They are not the same problem.

Q-H  THE SPLIT SET. Five suffix entries are new at v1.5 - LED-043a, LED-053c,
     LED-053d, LED-058a, LED-061a - and two entries that changed at D1 take
     NO suffix, LED-051 and LED-055. Is that the right allocation? The test
     is whether each new entry carries a proposition whose DISPOSITION
     genuinely differs from its parent's, and whether LED-051 and LED-055
     really need none.

Q-J  WITHDRAWN AT v1.6. v1.5 asked whether LED-046 should point at LED-049 or
     LED-052a. YOU HAD ALREADY ANSWERED IT in the Tier C sample review, and
     v1.5 had not opened that document. The correction is applied. Nothing is
     asked here; the question is left visible so the withdrawal is on the
     record rather than the item silently vanishing between generations.

Q-K  A CITATION THAT LEAVES THE SUB-TRANCHE. LED-053d's second carrier is
     APPENDIX A of the authority itself, at lines 1762-1932, which belongs to
     T1S01a6. The entry cites it under section 0.2's cited-as-evidence rule
     and does not adjudicate it. Is that the right handling, or does a
     same-file carrier outside the adjudicated range need a different
     treatment than an external one?

Q-K2 THE TIER C FINDINGS, ALL EIGHT. v1.6 exists because v1.5 applied six of
     your eight Tier C DISAGREE findings and missed two. The six applied are
     LED-034, LED-043, LED-053, LED-055, LED-058 and LED-061; the two missed
     and now applied are LED-046 and LED-037. PLEASE CHECK THAT ENUMERATION
     AGAINST YOUR OWN REVIEW rather than accepting it - if a seventh or ninth
     finding exists, or if any of the six is applied in a way that does not
     match what you actually found, that is the finding W3D most wants.

Q-L  THE PROVENANCE RULE ITSELF. Section 0.4b states that no wording in this
     ledger is taken from the W3C recovery reconstruction v1.4, while
     admitting the successor designer had already read it. That is the
     weakest claim in this document. TEST IT DIRECTLY by comparing v1.3
     against this file: every difference should appear in the 0.4c delta list
     or the 0.4f restoration list. A difference that appears in neither is a
     finding, and W3D wants it reported.
```

---

*End of T1S01a5 ledger v1.6. Nothing here is ratified. Every PROPOSED ACTION
is a proposal to W3X, and no authority document has been edited.*

---

*Revision history*

```text
v1.6 (2026-08-19) TIER C FINDING CORRECTIONS. Same author, same basis, same
     provenance rule as v1.5. Applies the two W3C Tier C sample findings that
     v1.5 missed, and records the miss rather than quietly fixing it.
     LED-046  cross-reference corrected LED-049 -> LED-052a. W3C found this in
              the Tier C review; v1.5 declared it unmandated and asked about
              it at Q-J. Q-J is withdrawn.
     LED-037  the REASON sentence "it is an audit record about this document,
              so no other document can hold it" is WITHDRAWN as not being a
              uniqueness proof - another document can repeat or report an audit
              result. CURRENT-UNIQUE survives on a searched basis: the
              Classification Repair probe for the audit-result proposition,
              added to SWEPT as result (iii). v1.5 had restored the a-priori
              reasoning from v1.3.
     WHY THEY WERE MISSED, recorded at 0.4b because the cause is reusable: TWO
     ROUNDS FED a5 - the Tier C sample review, then the classification repair -
     and v1.5's delta list was built from the second only. v1.5's section 0.4b
     also NAMED the Tier C review among the artifacts used when it had not been
     opened, which is DEC-48's false assurance written into the section
     asserting the provenance rule. Both are corrected and recorded.
     THE DELTAS WERE ENUMERATED; THE ROUNDS THEY CAME FROM WERE NOT. That is
     the lesson, and it is the same shape as DEC-50: name the population, and
     check that the population is the right one.
     NO search rerun, NO classification reopened, NO architecture question
     touched. Entry count unchanged at 39.
v1.5 (2026-08-19) POST-REPAIR REWRITE, by the successor W3D session.
     Built TEXTUALLY on delivered ledger v1.3 under a declared provenance
     rule: every change traces to a delivered artifact or a ratified
     decision, and anything the successor added on its own judgement is
     labelled a new W3D finding rather than presented as a repair mandate.
     W3X ruled the W3C recovery reconstruction v1.4 out as a source; no
     wording is taken from it, and section 0.4b records the honest limit of
     that claim.
     APPLIED: the six disposition-structure changes; the eight rebuilt
     carrier/application lists; the four changed findings; the 28 surviving
     disposition structures ENUMERATED at 0.4d rather than asserted; the
     settled 46-file search population under DEC-60/63/66 replacing v1.3's
     87-file description; and every TIER field COMPUTED from disposition per
     DEC-62 - which changed 31 of the 34 inherited entries, independently
     reproducing the figure DEC-62 records.
     ENTRY COUNT 34 -> 39 by five mandated splits: LED-043a, LED-053c,
     LED-053d, LED-058a, LED-061a. Section 0.4e records why the count is
     DERIVED from the proposition set rather than inherited, records that the
     total was ASSERTED AS 40 IN DRAFT AND CORRECTED BY COUNTING, and warns
     that the agreement with the recovery reconstruction's 39 is arithmetic
     coincidence with different membership rather than corroboration.
     RESTORED at 0.4f: material the recovery reconstruction had deleted with
     no mandate, most seriously LED-037's entire evidence base and LED-058's
     recorded negative result that no live document asserts mixture is
     OBSERVED rather than PERMITTED.
     DECLARED AS NEW W3D FINDINGS at 0.4g: the unmandated LED-046
     cross-reference change, which is NOT applied and is put to W3C at Q-J;
     and LED-053d's second carrier lying in Appendix A outside this
     sub-tranche, raised at Q-K.
     NO search was rerun, NO classification reopened, and NO architecture
     question touched, per W3C's explicit warning against broadening the
     correction into another methodology round.
v1.4 (2026-08-19) W3C recovery reconstruction produced after the W3D session
     limit. NOT A SOURCE FOR v1.5 by W3X ruling, and recorded here only so
     the generation is not mistaken for a gap in the sequence.
v1.3 (2026-08-19) Last physically delivered W3D ledger before the designer
     session died: three split-disposition entries split per DEC-33(a); the
     STAY-CANONICAL first-use claim withdrawn as false. No finding changed.
     THE TEXTUAL BASIS OF v1.5.
```
