# Deblock4 - T1S01a5 Ledger: Authority Body Part 1, Sections 1 to 8

**Deliverable:** T1S01a5_A - LEDGER
**Version:** 1.4 - W3C reconstruction of W3D's intended post-repair rewrite from delivered v1.3 plus Classification Repair v1.1 and accepted W3C findings. 39 atomic entries; tier fields recomputed from disposition.
**Date:** 2026-08-19
**Author:** W3C reconstruction of W3D ledger after W3D session limit
**Route:** W3C -> W3X -> successor W3D / W3C
**Adjudicates:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`, sections 1 to 8, lines 223-715
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_29.md`
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

THE SPLIT IS NOW RATIFIED. W3X ratified the section-8/9 boundary at DEC-68
on 2026-08-19. T1S01a5 therefore remains sections 1-8, lines 223-715, and
T1S01a5b is the separately named later sub-tranche for sections 9-13,
lines 716-1098. This v1.4 does not reopen that decision.
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

## 0.4a POST-REPAIR REWRITE CHECK - WHAT v1.4 CHANGES

```text
THIS IS A RECONSTRUCTION OF THE DELIVERED DESIGNER STATE, NOT A NEW SEARCH
ROUND.

SOURCE CHAIN:
    delivered ledger v1.3
    -> W3X-selected Tier C sample and W3C response v1.1
    -> W3D re-sweep evidence
    -> W3C re-sweep cross-check
    -> W3D Classification Repair v1.1
    -> W3C substantive PASS of repair v1.0 subject to three mechanical fixes
    -> W3D v1.1, which visibly contains those exact fixes.

THE DEAD W3D SESSION SAID THE LEDGER REWRITE MUST CARRY:
    six original-entry disposition-structure changes;
    eight rebuilt carrier/application lists;
    four changed findings;
    the 28 unchanged original disposition structures ENUMERATED, not asserted.

THE SIX ORIGINAL ENTRIES WHOSE DISPOSITION STRUCTURE CHANGES:
    LED-043, LED-051, LED-053, LED-055, LED-058, LED-061.

FIVE REQUIRE AN ATOMIC SUFFIX ENTRY:
    LED-043a, LED-053b, LED-055a, LED-058a, LED-061a.
LED-051 changes from CURRENT-UNIQUE to CURRENT-DUPLICATE without a suffix.

THEREFORE:
    34 entries at v1.3
    + 5 atomic suffix entries
    = 39 entries at v1.4.

THE 28 ORIGINAL ENTRIES WHOSE DISPOSITION STRUCTURE SURVIVES UNCHANGED:
    LED-033, LED-034, LED-035, LED-036, LED-037, LED-038, LED-039,
    LED-040, LED-041, LED-042, LED-044, LED-045, LED-046, LED-047,
    LED-048, LED-049, LED-050, LED-051a, LED-052, LED-052a, LED-053a,
    LED-054, LED-056, LED-057, LED-059, LED-060, LED-062, LED-063.

TIER FIELDS ARE NOW DERIVED FROM DISPOSITION, PER DEC-62:
    CURRENT-UNIQUE / CURRENT-DUPLICATE -> Tier C
    CONFLICTING / SUPERSEDED           -> Tier A
    OPERATIVE-SPEC                     -> Tier B
This ledger therefore has no designer-chosen review-depth tiers.

INTENTIONAL SOURCE-RANGE OVERLAP:
    the five new suffix entries split propositions that share source sentences
    with their parent entry. This is an ATOMIC proposition split, not duplicate
    adjudication. A range-overlap check must therefore distinguish these
    declared shared-source splits from accidental tranche overlap.
```

## 0.5 SEARCH AND ADJUDICATION POPULATIONS USED BY THIS REWRITE

```text
DO NOT RECOMPUTE THE a5 RE-SWEEP FROM A LATER HYGIENE STATE.

THE SEARCH EVIDENCE INCORPORATED BY THIS LEDGER IS THE SETTLED a5 RE-SWEEP /
CLASSIFICATION-REPAIR POPULATION:

    46 searchable files.

That population was independently reproduced by W3C after applying W3X's
declared relocation of the two raw GAIS response files into the ignored
GAIS_investigations/ tree. All 22 recorded probe counts were reproduced
exactly. Classification Repair v1.1 then prints the exact candidate file list
for all 22 probes and leaves zero returned files unclassified.

THE CURRENT MECHANICAL EXCLUSIONS GOVERNING THAT POPULATION:
    - any folder whose name begins "superseded" or
      "scheduled_for_deletion"                         DEC-60
    - everything under T1/                            DEC-63
    - everything under GAIS_investigations/          DEC-66

T1/ IS A WORKSHOP, NOT A KNOWLEDGE SHELF.
Material in T1/ is process/review material and cannot establish or refute a
CURRENT-UNIQUE / CURRENT-DUPLICATE result merely by existing there.

GAIS_investigations/ IS IGNORED FOR T1 SEARCH AND ADJUDICATION.
Raw GAIS captures remain historical files but are not used to prove, refute or
adjudicate propositions in this ledger.

THE CURRENT T1 ADJUDICATION POPULATION IS 41 DOCUMENTS.
That is a different population from the 46-file a5 search population and from
the historical frozen T1S00 survey count of 47. Do not reconcile those numbers
by rewriting history.

THREE RATIFIED SWEEP RULES APPLY, DEC-67:
    1. OPEN EVERY HIT.
    2. NORMALISE WHITESPACE FOR PHRASE SEARCHES.
    3. SEARCH THE PROPOSITION, NOT MERELY THE SOURCE SENTENCE, using W3C's
       bounded probe-family formulation.

AND THE FAILURE MODE THAT SURVIVED ALL THREE:
    OPENING A HIT IS NOT THE SAME AS READING IT.
A candidate file is not a carrier until the matched passage has been read and
classified by meaning.

Where this v1.4 rebuilds a SWEPT/carrier field from Classification Repair
v1.1, that repaired field supersedes v1.3's older population wording.
```

---

# LED-033  Section 1 - the document's stated purpose

```text
DOCUMENT     authority v1.05, section 1, lines 226-229
CLAIM        "The purpose of this document is to hold the complete current
             MPEG-2-specific knowledge and design state so a successor
             designer/coder does not have to reconstruct it from the README,
             old grid notes, GAIS captures and chat history."
ASSERTS      that this document is the consolidated home of MPEG-2 knowledge.
CLASS        W3X-RATIFIED (the document's ratified self-definition)
DISPOSITION  CURRENT-DUPLICATE
REASON       Current in intent, but it restates the header's normative
             single-source rule. The word "complete" remains a coverage claim
             that T1 itself exists to test.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: the header single-source rule, lines 13-24,
             adjudicated at T1S01a3 LED-021.
DUPLICATE-ACTION  POINTER.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             PROBE FAMILY: single source | prevailing authority |
             single source of truth | PREVAILING MPEG-2 AUTHORITY.
             11 candidate files:
               CARRIER   coder introduction
               CARRIER   designer introduction - found only after Rule-3
                         expansion
               CARRIER   coder chat blurb
               CARRIER   designer chat blurb
               CARRIER   Documentation Currency Audit
               CARRIER   Forward Roadmap
               CANONICAL this authority's header
               CARRIER   Project Status
               DIFFERENT Stage-1B3 scope - VERSION STRING proposition
               CARRIER   Session Bootstrap Header
               CARRIER   Scopes/T1 W3C Review Scope v1.7 - process stray

DERIVED      "complete current MPEG-2-specific knowledge" remains unverified
             until the consolidation sweep has actually closed.
DERIVED-BASIS  Standing Task Register T1 description of the authority as a
             targeted reconstruction whose full sweep is still being done.
```

```text
TIER     C
ACTION   At T3, reduce the duplicate purpose statement to a pointer to the
         header rule. Reconsider "complete" only when T1 closes.
VERDICT  [W3C]
```

---

# LED-034  Section 1 - the four-layer statement taxonomy

```text
DOCUMENT     authority v1.05, section 1, lines 231-240
CLAIM        The document deliberately separates CODEC FACT, PIXEL GEOMETRY,
             ARCHITECTURE and KERNEL statements, and records that confusing
             those layers caused earlier design errors.
ASSERTS      the four-layer taxonomy and its historical lesson.
CLASS        DERIVED, W3X-RATIFIED as part of v1.04/v1.05
DISPOSITION  CURRENT-UNIQUE
REASON       Current. The bounded proposition-level search found the full
             four-layer taxonomy only here.
CONFLICTS    none.
PREVAILS     n/a - unique; this section is canonical.
SWEPT        The applicable-knowledge search used the source terms and
             independent variants for the four-way taxonomy. No second carrier
             was found.

DERIVED      none. v1.3's claimed T3 protection gap is WITHDRAWN: T3 does not
             instruct anyone to delete CURRENT-UNIQUE content from its
             canonical authority merely because nearby duplicates become
             pointers.
```

```text
TIER     C
ACTION   RETAIN IN PLACE. No new protection rule is required.
VERDICT  [W3C]
```

---

# LED-035  Section 1 - Classic is not a Deblock4 design or acceptance basis

```text
DOCUMENT     authority v1.05, section 1, lines 242-244
CLAIM        Classic is engineering contrast only; nothing in Classic's
             algorithm or vector source is a Deblock4 design or acceptance
             basis.
ASSERTS      the D4-D08 separation rule.
CLASS        W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       Current and binding.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: D4-D08 in section 22.
DUPLICATE-ACTION  POINTER.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             Nine candidate hits resolve to six proposition-bearing files:
               CARRIER    coder introduction
               CARRIER    designer introduction
               CARRIER    designer chat blurb
               DIFFERENT  Forward Roadmap - deferred Stage-3C acceptance basis
               CANONICAL  authority / D4-D08
               DIFFERENT  Project Status - status/acceptance-basis distinction
               DIFFERENT  D0 index - oracle-construction acceptance basis
               CARRIER    Scopes re-decision W3C evaluation
               CARRIER    Scopes PreScope coder response

DERIVED      none.
```

```text
TIER     C
ACTION   At T3, reduce this prose copy to a pointer to D4-D08.
VERDICT  [W3C]
```

---

# LED-036  Section 1.1 - the Schedule-SA/SB/SC renaming rule

```text
DOCUMENT     authority v1.05, section 1.1, lines 246-259
CLAIM        Architecture A/B/C/D and old processing Schedule A/B/C are
             different naming families; this document renames the latter
             Schedule-SA/SB/SC to prevent conflation.
ASSERTS      the distinction, renaming and collision-avoidance reason.
CLASS        DERIVED, W3X-RATIFIED as part of v1.04/v1.05
DISPOSITION  CURRENT-DUPLICATE
REASON       Current. Appendix A restates the terminology distinction.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: THIS SECTION.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             Three candidate files:
               CARRIER   designer introduction - states renaming and reason
               CANONICAL authority section 1.1
               APPLIES   Project Status - uses SA/SB spelling only
             Old bare Schedule A/B vocabulary elsewhere is a collision
             finding, not automatically a copy of this renaming rule.

DERIVED      WITHDRAWN HISTORICAL FIRST-USE CLAIM. T1S01a3 already used
             STAY-CANONICAL; only that framing was wrong.
```

```text
TIER     C
ACTION   RETAIN IN PLACE as canonical.
VERDICT  [W3C]
```

---

# LED-037  Section 1.1 - the v1.04 naming-consistency audit claim

```text
DOCUMENT     authority v1.05, section 1.1, lines 261-265
CLAIM        Every ACTIVE processing-order reference in this authority uses
             Schedule-SA/SB/SC; bare Schedule A/B/C survives only where the
             old README vocabulary is explicitly identified.
ASSERTS      a whole-document naming-consistency audit result.
CLASS        DERIVED
DISPOSITION  CURRENT-UNIQUE
REASON       The audit is true as written AND a separate corpus uniqueness
             search found no second document reporting the same audit result.
             v1.3's "no other document can hold it" reasoning is withdrawn.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        TRUTH CHECK: whole-authority search for old/new schedule names;
             only the explicit old-vocabulary identifications use bare A/B/C.
             UNIQUENESS CHECK: Classification Repair probe
             "naming-consistency audit | No ambiguous active A/B" returned
             one candidate only - this authority.

DERIVED      The rename is complete here but old Schedule A/B vocabulary
             remains active elsewhere; route those copies to their own T1
             steps.
DERIVED-BASIS  whole-authority audit plus opened corpus matches.
```

```text
TIER     C
ACTION   RETAIN the true audit claim unchanged.
VERDICT  [W3C]
```

---

# LED-038  Section 1.2 - the edge-position symbol `e`

```text
DOCUMENT     authority v1.05, section 1.2, line 272
CLAIM        "e = first sample on the q side of an edge"
ASSERTS      the edge-position convention.
CLASS        SPEC-VERIFIED project convention
DISPOSITION  CURRENT-DUPLICATE
REASON       Same convention as charter B1.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: charter B1.
DUPLICATE-ACTION  POINTER, subject to the later T3 presentation question.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             15 candidates:
               APPLIES    designer introduction
               CANONICAL  charter B1
               APPLIES    Concise Summary
               CARRIER    authority local restatement
               APPLIES    Project Status
               APPLIES    D0
               APPLIES    D2
               CARRIER    README
               IDENTIFIER Scopes re-decision brief - substring in D4-Q01
               CARRIER    Scopes re-decision W3C evaluation - defines e/q0
               APPLIES    Scopes PreScope coder response
               NOISE      T1 evidence archive
               IDENTIFIER HolyWu provenance
               IDENTIFIER holywu_r9/deblock.cpp
               IDENTIFIER holywu_r9/deblock_sse4.cpp

DERIVED      A local one-line restatement may still be preferable for readable
             mathematics; that remains a T3 presentation question.
DERIVED-BASIS  later geometry sections use e/s while charter B1 owns the
             project convention.
```

```text
TIER     C
ACTION   W3D recommendation retained: POINTER-WITH-RESTATEMENT at T3.
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
CLAIM        For a frame picture in 4:2:0, chroma remains frame-organised even
             when luma uses field DCT; in 4:2:2/4:4:4 chroma follows luma.
ASSERTS      the central chroma asymmetry.
CLASS        H.262-VERIFIED, clause 6.1.3
DISPOSITION  CURRENT-DUPLICATE
REASON       Current and widely restated.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this F4 entry.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             13 candidates:
               CARRIER    designer introduction
               CARRIER    designer chat blurb
               CARRIER    Concise Summary
               APPLIES    old designer-death resume brief
               CANONICAL  authority F4
               CARRIER    Grid Knowledge
               CARRIER    Project Status
               CARRIER    six Scopes re-decision/verification documents
             GAIS_investigations/ is not part of the population.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN IN PLACE as canonical.
VERDICT  [W3C]
```

---

# LED-043  Section 2 - F5 signalling semantics and no-fabrication rule

```text
ATOMIC REWRITE AT v1.4. The no-coded-residual meaningfulness fact is split to
LED-043a because its disposition differs.

DOCUMENT     authority v1.05, section 2, lines 310-317
CLAIM        (a) dct_type is macroblock-level where applicable;
             (b) frame_pred_frame_dct==0 permits per-MB frame/field choice,
                 while ==1 forces/infers frame organisation;
             (c2) a macroblock without a usable truth label MUST NOT be
                  fabricated into FRAME or FIELD for Q14.
ASSERTS      codec signalling plus the no-fabrication project rule.
CLASS        (a)/(b) H.262-VERIFIED; (c2) PROJECT RULE
DISPOSITION  CURRENT-DUPLICATE
REASON       (a)/(b) are restated in section 0/3/6.2; (c2) is restated at
             section 0 item 15, section 15 and a Scopes evaluation.
CONFLICTS    none.
PREVAILS     (a)/(b) -> this F5 entry; (c2) -> section 15 Q14 definition.
DUPLICATE-ACTION  STAY-CANONICAL for (a)/(b); POINTER for (c2).
SWEPT        Classification Repair's no-residual/fabrication/truth-class probe
             returns this authority plus the Scopes W3C evaluation as a
             carrier of the no-fabrication rule.

DERIVED      F5's H.262 provenance presentation is too broad if it appears to
             cover the Deblock4 experiment rule (c2).
DERIVED-BASIS  section 2.1 F5 provenance records H.262 syntax/semantics, not
             experiment methodology.
```

```text
TIER     C
ACTION   RETAIN (a)/(b); point (c2) to section 15 and narrow provenance
         presentation accordingly.
VERDICT  [W3C]
```

---

# LED-043a  Section 2 - F5 no-coded-residual dct_type meaningfulness

```text
SPLIT FROM LED-043 AT v1.4.

DOCUMENT     authority v1.05, section 2, lines 310-317
CLAIM        A macroblock with no coded transform residual does not
             necessarily carry a meaningful dct_type bit.
ASSERTS      a codec-syntax limitation distinct from Q14's classification rule.
CLASS        codec-syntax fact
DISPOSITION  CURRENT-UNIQUE
REASON       No second applicable project-knowledge carrier of this specific
             meaningfulness qualification was found.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        W3C separated this fact from the duplicated no-fabrication rule;
             no non-T1/non-GAIS second carrier was found.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN IN PLACE.
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
ACTION   RETAIN IN PLACE as canonical. Section 4.3's restatement is
         adjudicated at LED-048.
VERDICT  [W3C]
```

---

# LED-046  Section 2 - F8, vertical edges are geometry-invariant

```text
DOCUMENT     authority v1.05, section 2, lines 329-332
CLAIM        Frame-vs-field DCT changes row adjacency for horizontal edges but
             not vertical block columns; vertical luma edges remain x=8*k.
ASSERTS      the vertical-edge geometry invariant.
CLASS        DERIVED, no recorded basis
DISPOSITION  CURRENT-DUPLICATE
REASON       Current and load-bearing.
CONFLICTS    none. v1.3's cross-reference to LED-049 was wrong.
PREVAILS     CANONICAL HOME: this F8 entry.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        Classification Repair probe returns:
               CARRIER   designer introduction
               CARRIER   designer chat blurb
               CARRIER   Concise Summary
               CANONICAL authority F8
               CARRIER   Project Status
               CARRIER   Scopes re-decision W3C evaluation

DERIVED      F8 remains the highest-value provenance gap. The retired
             parity-split description is handled at LED-052a, not LED-049.
DERIVED-BASIS  F1 plus row map y=2*r+p; T8 owns provenance-gap closure.
```

```text
TIER     C
ACTION   RETAIN; record the short derivation basis through T8.
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
CLAIM        The specific mediainfo --Details=1 picture-level triage route,
             its legitimate triage use, and the fact that it is NOT Q14's
             per-macroblock truth extractor.
ASSERTS      invocation, permitted use and evidence limit.
CLASS        MEASURED tool usage / evidence rule
DISPOSITION  CURRENT-DUPLICATE
REASON       Current.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this section.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             Six candidates:
               CARRIER   coder introduction
               CARRIER   designer introduction
               CARRIER   designer chat blurb
               CANONICAL authority
               MIXED     Grid Knowledge - route plus separate general
                         MediaInfo/ffprobe evidence statement
               APPLIES   Scopes re-decision W3C evaluation - reports the old
                         document's check but does not state the route

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN IN PLACE as canonical.
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
CLAIM        (a) frame-organised horizontal edges e=8*k, s=1;
             (b) internal/macroblock row boundary coordinates;
             (c) field row map y=2*r+p, e=16*k+p, s=2, six-tap footprint and
                 worked parity examples.
ASSERTS      exact whole-frame horizontal luma geometry.
CLASS        DERIVED from F1/F5/F8; W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE
REASON       W3C QC-5 established that the Scopes architecture re-decision
             W3C evaluation physically carries the same mathematics.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: authority sections 4.2/4.3.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        Concrete non-canonical carrier:
             Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md,
             which states e/q0, R_s/W_s, e=8*k/s=1, y=2*r+p,
             e=16*k+p/s=2, the six taps and worked parity examples.

DERIVED      One pitch-2 six-sample edge spans 11 frame rows in memory
             (e-6 through e+4). The union of the two parity edges spans
             12 frame rows (e-6 through e+5). v1.3's "thirteen" wording was
             arithmetically wrong. Eligibility radii remain 6 before / 4 after.
DERIVED-BASIS  section 4.3 footprint; charter B3/B4.
```

```text
TIER     C
ACTION   RETAIN IN PLACE as canonical; carry the corrected 11/12-row result
         into the future bounds proof.
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
ACTION   At T3, reduce to a pointer to F8.
VERDICT  [W3C]
```

---

# LED-052a  Section 4.4 - retirement of the parity-split vertical description

```text
DOCUMENT     authority v1.05, section 4.4, lines 511-513
CLAIM        The early pre-B2 parity-split vertical four-row-pack description
             is RETIRED.
ASSERTS      retirement of that earlier description.
CLASS        Retirement record
DISPOSITION  CURRENT-UNIQUE
REASON       The retirement statement is unique.
CONFLICTS    none in the authority; the stale description itself remains in a
             live Scopes process document.
PREVAILS     n/a - unique.
SWEPT        W3C opened the Scopes coder-response and established that it still
             presents separate parity-homogeneous work / row pitch 2 and a
             four-logical-row same-field vertical pack. The earlier "may still
             be live" wording is therefore replaced by an actual finding.

DERIVED      The stale Scopes description is ACTUAL and must be dispositioned
             when the Scopes-only T1S01b tranche reaches it.
DERIVED-BASIS  current Scopes coder-response plus this retirement sentence.
```

```text
TIER     C
ACTION   RETAIN the retirement statement; route the stale Scopes text to
         T1S01b.
VERDICT  [W3C]
```

---

# LED-053  Section 4.5 - 4:2:0 frame-picture chroma edge coordinates

```text
ATOMIC REWRITE AT v1.4. LED-053a keeps the line-517 coordinate declaration;
LED-053b receives the duplicated no-midpoint and pitch-2 propositions.

DOCUMENT     authority v1.05, section 4.5, lines 519-529
CLAIM        (b) progressive/Case-(a) 4:2:0 chroma edges use e_c=8*k,
             pitch 1 horizontally, and x_c=8*k vertically.
ASSERTS      exact frame-picture chroma edge coordinates.
CLASS        DERIVED from F1/F2/F4
DISPOSITION  CURRENT-UNIQUE
REASON       No second applicable carrier of the e_c/x_c coordinate statement
             was found.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Classification Repair separated the old bundled propositions;
             carriers were found for (c)/(d), not for this coordinate form.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN IN PLACE.
VERDICT  [W3C]
```

---

# LED-053b  Section 4.5 - 4:2:0 no-midpoint rule and Case-(b) pitch 2

```text
SPLIT FROM LED-053 AT v1.4.

DOCUMENT     authority v1.05, section 4.5, lines 519-529
CLAIM        (c) no luma-style midpoint/phase ambiguity in 4:2:0 Case (a);
             (d) Case-(b) woven-frame horizontal chroma uses row pitch 2.
ASSERTS      no-midpoint and pitch-2 consequences.
CLASS        DERIVED from F1/F2/F4
DISPOSITION  CURRENT-DUPLICATE
REASON       (c) is restated in README and Scopes re-decision evaluation;
             (d) is restated in Appendix A and a Scopes PreScope response.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: authority section 4.5.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        LED-053c probe: authority canonical; README and Scopes evaluation
             are CARRIERs; luma-only midpoint hits are DIFFERENT.
             LED-053d probe: authority is MIXED because Appendix A is a second
             same-file carrier; Scopes PreScope coder response is a CARRIER.

DERIVED      none.
```

```text
TIER     C
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
ACTION   At T3, this follows whatever W3X decides at LED-038 and LED-040
         about local restatements of coordinate rules - see covering note Q3.
         It must NOT be decided separately from those two.
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
ACTION   RETAIN (c) in place as canonical; the rest become pointers at T3.
         Carry the DERIVED paragraph to T6 as an input to Q14's metric
         design: the cost of a false-confident classification is not uniform
         across chroma formats.
VERDICT  [W3C]
```

---

# LED-055  Section 5 - SeparateFields tearing mechanism and whole-frame conclusion

```text
ATOMIC REWRITE AT v1.4. The two unique qualifiers are split to LED-055a.

DOCUMENT     authority v1.05, section 5, lines 547-564
CLAIM        SeparateFields splits alternate rows so one field clip sees only
             four rows of an original frame-organised eight-row block;
             therefore SeparateFields cannot be the general MPEG-2 contract
             and whole-frame input is required.
ASSERTS      tearing mechanism plus D4-D01 conclusion.
CLASS        DERIVED; conclusion ratified as D4-D01
DISPOSITION  CURRENT-DUPLICATE
REASON       The conclusion is widely copied. The mechanism is also carried by
             README and the Scopes architecture re-decision brief.
CONFLICTS    none.
PREVAILS     detailed mechanism -> section 5; decision conclusion -> D4-D01.
DUPLICATE-ACTION  STAY-CANONICAL for mechanism; POINTER for conclusion.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             Seven candidates:
               CARRIER   designer introduction - conclusion only
               CARRIER   Concise Summary - conclusion only
               CANONICAL authority - mechanism
               CARRIER   Project Status - conclusion only
               CARRIER   README - mechanism
               CARRIER   Scopes re-decision brief - mechanism
               CARRIER   Scopes PreScope brief - conclusion/compressed reason
             v1.3's blanket "derivation uniquely" statement is withdrawn.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN the detailed mechanism; point decision copies to D4-D01.
VERDICT  [W3C]
```

---

# LED-055a  Section 5 - SeparateFields generality and correctness qualification

```text
SPLIT FROM LED-055 AT v1.4.

DOCUMENT     authority v1.05, section 5, lines 547-564
CLAIM        The same geometry problem exists for progressive/frame-DCT
             material, and whole-frame input is a codec-geometry correctness
             requirement rather than a performance preference.
ASSERTS      the derivation's generality and normative-strength qualification.
CLASS        DERIVED
DISPOSITION  CURRENT-UNIQUE
REASON       The opened seven-file candidate set found other carriers of the
             mechanism and conclusion, but no second carrier of these
             qualifiers in the authority's form.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Same classified candidate population as LED-055.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN IN PLACE.
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

# LED-058  Section 6.2 - REGIME 3 mapping, significance and evidence limit

```text
ATOMIC REWRITE AT v1.4. The unique reading rule is split to LED-058a.

DOCUMENT     authority v1.05, section 6.2, lines 609-625
CLAIM        (a) XP/SP/LP/EP are adaptive-capable REGIME-3 /
                 frame_pred_frame_dct=0, MLS is the frame-DCT control;
             (b) this is normal target-device operation and motivates B2;
             (c1) it proves permission/capability, not observed per-picture
                  FRAME/FIELD mixture; Q14 must obtain per-MB truth.
ASSERTS      mapping, significance and evidence precision.
CLASS        (a) MEASURED; (b)/(c1) DERIVED
DISPOSITION  CURRENT-DUPLICATE
REASON       These propositions are repeated in section 0 and current
             orientation/status material.
CONFLICTS    none.
PREVAILS     CANONICAL HOME: this section.
DUPLICATE-ACTION  STAY-CANONICAL.
SWEPT        Classification Repair probe returned both introductions, both
             chat blurbs, this authority and Grid Knowledge.
             Grid Knowledge carries the stale shorthand "regime 3, mixed",
             proving the exposure is ACTUAL.

DERIVED      The stale external shorthand is actual; the corrective reading
             rule is separated to LED-058a.
DERIVED-BASIS  opened Grid Knowledge hit.
```

```text
TIER     C
ACTION   RETAIN IN PLACE; route stale external wording to its own T1 step.
VERDICT  [W3C]
```

---

# LED-058a  Section 6.2 - reading rule for historical REGIME-3 shorthand

```text
SPLIT FROM LED-058 AT v1.4.

DOCUMENT     authority v1.05, section 6.2, lines 609-625
CLAIM        In this document, historical "regime-3 mix" shorthand means
             adaptive-capable per-MB regime unless later measured Q14 evidence
             explicitly proves actual mixture.
ASSERTS      a corrective reading rule.
CLASS        DERIVED
DISPOSITION  CURRENT-UNIQUE
REASON       Other files carry either the adaptive-capable proposition or the
             stale shorthand, not this explicit corrective rule.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Same six-file probe family as LED-058. Grid Knowledge has the
             stale shorthand but no equivalent corrective rule.

DERIVED      The rule's scope is narrower than the vocabulary's reach because
             stale shorthand exists outside this document.
DERIVED-BASIS  rule wording plus opened Grid Knowledge hit.
```

```text
TIER     C
ACTION   RETAIN; correct stale external wording at its owning T1 step.
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
ACTION   RETAIN all four in place. Mark P4's qualifying sentence as PROTECTED
         against summarisation at T3 - it must travel with P4 or P4 must not
         travel.
VERDICT  [W3C]
```

---

# LED-061  Section 8 - GAIS standing verification/evidence/precedence rules

```text
ATOMIC REWRITE AT v1.4. The unique instrument assessment is split to LED-061a.

DOCUMENT     authority v1.05, section 8, lines 681-687
CLAIM        (b) no GAIS factual claim/quotation/citation enters project
                 knowledge without independent verification;
             (c) raw GAIS outputs are evidence captures only;
             (d) this authority prevails on MPEG-2 design facts.
ASSERTS      standing verification, evidence-status and precedence rules.
CLASS        W3X-RATIFIED standing rules
DISPOSITION  CURRENT-DUPLICATE
REASON       These rules are repeated in applicable orientation material.
CONFLICTS    none.
PREVAILS     (b)/(c) -> this section; (d) -> header single-source rule.
DUPLICATE-ACTION  STAY-CANONICAL for standing rule; POINTER for precedence.
SWEPT        REBUILT FROM CLASSIFICATION REPAIR v1.1.
             Six candidates:
               DIFFERENT  coder introduction - charter I7 verification
               CARRIER    designer introduction
               CARRIER    coder chat blurb
               CARRIER    designer chat blurb
               CANONICAL  authority section 8
               DIFFERENT  D2 - independent verification of D2
             GAIS_investigations/ is ignored under DEC-66.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN the rule; point the precedence clause to the header at T3.
VERDICT  [W3C]
```

---

# LED-061a  Section 8 - GAIS instrument assessment

```text
SPLIT FROM LED-061 AT v1.4.

DOCUMENT     authority v1.05, section 8, lines 681-687
CLAIM        GAIS was useful as an option-generation/reasoning instrument but
             failed as a citation/factual authority.
ASSERTS      the project's nuanced calibration assessment of that instrument.
CLASS        W3X-RATIFIED calibration assessment
DISPOSITION  CURRENT-UNIQUE
REASON       The standing rules are duplicated, but this explanation of what
             GAIS was useful for and what it failed at was found only here.
CONFLICTS    none.
PREVAILS     n/a - unique.
SWEPT        Uses the LED-061 classified candidate family; orientation copies
             state the rule, not this full assessment.

DERIVED      none.
```

```text
TIER     C
ACTION   RETAIN IN PLACE.
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
ASSERTS      that a fuller calibration record exists outside this document.
CLASS        Provenance pointer
DISPOSITION  CONFLICTING
REASON       Raw GAIS files are retained only as ignored historical material
             under GAIS_investigations/. The separately named W3C verification
             report at section 24 R8 is not present under that filename.
CONFLICTS    section 24 R8 and section-2.1 V4.1/V4.3 report shorthands.
PREVAILS     UNDECIDED HERE. Section 24 belongs to T1S01a6.
SWEPT        Filename/content search found no file under the R8 report name.
             A Scopes verification-round brief exists but is a brief TO W3C,
             not self-evidently the report FROM W3C. DEC-66 does not create
             the missing report and ignored GAIS content is not a substitute.

DERIVED      If the report cannot be established, F5 provenance should be
             re-verified directly rather than left non-retrievable.
DERIVED-BASIS  section 2.1, section 24 R8, DEC-58, DEC-66 and T8.
```

```text
TIER     A
ACTION   HOLD for T1S01a6; establish the referent or re-verify the affected
         provenance directly.
VERDICT  [W3C]
```

---

# 1. CLOSING QUESTIONS FOR W3C - v1.4 REWRITE REVIEW

```text
Q-A  RECONSTRUCTION / COVERAGE.
     Did this recovery rewrite preserve every proposition in authority
     lines 223-715 while making the five declared shared-source atomic splits
     explicit rather than hiding mixed dispositions?

Q-B  SIX ORIGINAL DISPOSITION-STRUCTURE CHANGES.
       LED-043 -> parent CURRENT-DUPLICATE + LED-043a CURRENT-UNIQUE
       LED-051 -> CURRENT-DUPLICATE
       LED-053 -> parent CURRENT-UNIQUE + LED-053b CURRENT-DUPLICATE
       LED-055 -> parent CURRENT-DUPLICATE + LED-055a CURRENT-UNIQUE
       LED-058 -> parent CURRENT-DUPLICATE + LED-058a CURRENT-UNIQUE
       LED-061 -> parent CURRENT-DUPLICATE + LED-061a CURRENT-UNIQUE
     Is any second disposition still hiding in prose?

Q-C  EIGHT REBUILT CARRIER/APPLICATION LISTS.
     LED-033, 035, 036, 038, 042, 049, 055 and 061 must match
     Classification Repair v1.1 semantically, not merely by hit count.

Q-D  FOUR CHANGED FINDINGS.
     LED-034 protection-gap claim withdrawn.
     LED-051 corrected to 11-row one-edge / 12-row parity-union span.
     LED-052a stale Scopes parity-split text is ACTUAL.
     LED-058 stale "regime 3, mixed" exposure is ACTUAL.
     Did any contrary live framing survive?

Q-E  TIER COMPUTATION.
     Every CURRENT entry is Tier C; LED-063 is the sole Tier A CONFLICTING
     entry; there are zero Tier B entries.

Q-F  POPULATION DISCIPLINE.
     The incorporated a5 repair search basis is 46 files. T1/ and
     GAIS_investigations/ do not participate in current uniqueness/duplicate
     adjudication. Has any rewritten field resurrected them as applicable
     evidence?

Q-G  28-OF-34.
     Section 0.4a enumerates the 28 original v1.3 entries whose disposition
     structure survives. Count the enumeration rather than accepting the total.

Q-H  LED-063.
     The missing W3C-report referent remains a real provenance conflict; DEC-66
     merely removes GAIS_investigations/ from adjudication. Does the entry keep
     those two facts separate?
```

---

# 2. RECONSTRUCTION STATUS

```text
THIS v1.4 IS A RECOVERY ARTIFACT PRODUCED AFTER THE DESIGNER CHAT DIED.

It does NOT claim that W3D physically delivered the promised rewritten ledger.
It reconstructs that next artifact from the delivered evidence chain so a
successor can review an explicit file rather than invent an unseen v1.5/v1.6.

NOTHING HERE IS RATIFIED.
No authority document has been edited.
Every PROPOSED ACTION remains a proposal until W3X decides it.
```

---

*Revision history*

```text
v1.4 (2026-08-19) W3C recovery reconstruction after W3D session limit.
     Starts from physically delivered ledger v1.3 and folds in W3D
     Classification Repair v1.1 plus the W3C findings W3D explicitly accepted.
     Produces 39 atomic entries; rebuilds the eight carrier/application lists;
     applies the four changed findings; enumerates the 28 original disposition
     structures that survive; derives every TIER from DISPOSITION per DEC-62;
     records the 46-file repair-search / 41-document adjudication distinction;
     excludes T1/ and GAIS_investigations/ under DEC-63/66; and records the
     a5/a5b split as ratified under DEC-68. Also corrects LED-037's uniqueness
     basis, LED-046's LED-052a cross-reference and LED-063's post-DEC-66
     framing. No new search round and no architecture reopening.
v1.3 (2026-08-19) Last physically delivered W3D ledger before the designer
     session died: 34 entries after the first three atomic splits and
     withdrawal of the false first-STAY-CANONICAL claim.
```

---

*End of T1S01a5 ledger v1.4 reconstruction. Nothing here is ratified.*
