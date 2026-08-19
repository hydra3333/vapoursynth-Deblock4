# Deblock4 - T1S01a5 Ledger: Authority Body Part 1, Sections 1 to 8

**Deliverable:** T1S01a5_A - LEDGER
**Version:** 1.1 - LED-057's DERIVED-BASIS corrected. No other entry field changed.
**Date:** 2026-08-19
**Author:** W3D
**Route:** W3D -> W3X -> W3C
**Adjudicates:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`, sections 1 to 8, lines 223-715
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`
**Binding work queue:** `Deblock4_Standing_Task_Register_T_Series_v1_23.md`
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
  THE P-08 MISUSE WAS SEARCHED FOR RATHER THAN ASSUMED ISOLATED. Every
  charter citation in the batch was enumerated and each was checked against
  the charter text: B1, B2, B3, B4, B5, C-SIMD-03, Part 6.4, P-06 and I7 all
  hold. P-08 was the only overreach, and it appeared at FOUR sites - two in
  this ledger and two in the covering note's Q4. All four are corrected.
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
SWEPT        Searched the live corpus (excluding superseded/,
             Scopes/superseded/, reference/superseded_do_not_use_files_in_
             this_folder/ and reviews/scheduled_for_deletion/) for
             "single source" and "prevailing authority": found the header of
             this document, the Session Bootstrap Header v1.3, the designer
             and coder introductions, both chat blurbs, Project Status and
             the task register. The orientation documents' copies are
             pointers to this authority rather than competing statements of
             it, so they are not treated as duplicates of THIS proposition.

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

DERIVED      THIS TAXONOMY IS THE MOST REUSABLE THING IN SECTION 1 AND IS
             CURRENTLY FINDABLE ONLY BY READING SECTION 1. If T3 reduces
             section 1 the taxonomy must not travel with it, and if the
             README is later stripped to user-facing documentation the
             taxonomy has no other home.
DERIVED-BASIS  DEC-07 makes the README user-facing and holding no controlling
             information; T3 strips duplicates into pointers. Neither
             process has a rule that protects a CURRENT-UNIQUE statement
             sitting inside a section whose other propositions become
             pointers.
```

```text
TIER     A
PROPOSED
ACTION   RETAIN IN PLACE, and flag as protected against T3 reduction of
         section 1. No wording change.
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
SWEPT        Searched the live corpus for "acceptance basis" and "design or
             acceptance": 14 files carry the phrase family. Excluding T1's
             own process artifacts (excluded from adjudication at manifest
             2.0a) the live carriers are this authority (2 hits), Project
             Status (5), the designer introduction (2), the coder
             introduction (1), the D0 index (1), the Forward Roadmap (1),
             the designer chat blurb (1) and the D4 PreScope coder response
             (4, a Scopes/ document belonging to T1S01b). Each hit was
             opened far enough to confirm it states the same rule rather than
             merely using the words.

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
SWEPT        Searched this document for every occurrence of "Schedule A",
             "Schedule B", "Schedule C", "Schedule-SA", "Schedule-SB" and
             "Schedule-SC": 15 hit lines, at 216, 254, 258, 259, 262, 263,
             1107, 1113, 1123, 1594, 1698, 1813, 1920, 1951 and 1970. Only
             lines 254 and 263 use the bare old names, and both are
             explicitly identifying the old README's vocabulary. Then
             searched the live corpus for bare "Schedule A" / "Schedule B" as
             whole words: hits in ten files, of which six use them as ACTIVE
             current vocabulary. See LED-037, which adjudicates the audit
             claim that rests on this search.

DERIVED      THIS IS THE FIRST ENTRY IN T1 TO CLAIM STAY-CANONICAL. The
             action has been ratified since DEC-38 and its evidence
             requirement refined at DEC-43, and no entry has yet exercised
             either. The named copy above is offered specifically so the
             requirement can be tested rather than assumed satisfied.
DERIVED-BASIS  Resume brief section 0a: "no entry anywhere in T1 has yet
             claimed STAY-CANONICAL, so the evidence rule ratified for it has
             never been exercised. a5 is where that first happens."
```

```text
TIER     A
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
REASON       It is an audit record about this document, so no other document
             can hold it. It is also, unusually for a coverage claim in this
             project, TESTABLE BY A READER - and W3D tested it rather than
             accepting it. See SWEPT.
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
TIER     A
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
SWEPT        Searched the live corpus for the edge-position convention
             (terms: "first sample on the q side", "q0", "p0 | q0"): found
             charter B1, this section, Appendix A of this document, the
             README's kernel sections, and the D0 Binding Knowledge Index.
             The README and D0 copies are Classic-facing and belong to T1S02/
             T1S03 and T1S04 respectively.

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
TIER     B
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
TIER     B
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
TIER     B
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
TIER     A
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
SWEPT        Searched the live corpus for the frame-organised-chroma
             proposition (terms: "frame-organis" and "chroma" on the same
             line, "Case-(a) chroma", "6.1.3"): 13 files carry it. Excluding
             T1 process artifacts, the live carriers are this authority (3
             hits), the designer introduction (4), Project Status (1), the
             designer chat blurb (1), the four GAIS investigation files
             (T1S01b) and six Scopes/ files (T1S01b). Section 0 item 3 of
             this document was dispositioned RETAIN-SUMMARY at T1S01a3
             LED-013 and is unaffected by this entry.

DERIVED      none. The temptation here is to derive that F4 makes B2's
             chroma handling free, and section 9.3 item 10 already states
             that consequence. Deriving it again in a findings entry would be
             the leak the two-part template exists to prevent.
```

```text
TIER     A
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
             (c) macroblocks with no coded residual have no meaningful
             dct_type and must not be fabricated into a truth class.
CLASS        (a) and (b) H.262-VERIFIED (W3C report V4.3, re-checked v1.04);
             (c) is a PROJECT RULE about experiment integrity carried inside
             a verified-fact entry.
DISPOSITION  CURRENT-DUPLICATE
REASON       All three current. (a) and (b) are restated at section 0 item 4,
             at the section 3 regime table and at section 6.2. (c) is
             restated at section 0 item 15's Q14 description ("NO_DCT/skipped/
             motion-only macroblocks are their own truth class; they are never
             fabricated into FRAME/FIELD labels") and belongs with the Q14
             experiment definition.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: (a) and (b) -> this F5 entry,
             as verified codec facts. (c) -> the D4-Q14 experiment definition
             in section 15, which is where experiment integrity rules belong.
             (c) IS NOT CANONICAL HERE.
DUPLICATE-ACTION  STAY-CANONICAL for (a) and (b); POINTER for (c).
             CONCRETE NON-CANONICAL COPY OF (a)/(b), NAMED: the section 3
             regime table at lines 377-392, which restates the
             frame_pred_frame_dct semantics in tabular form. KNOWN
             NON-CANONICAL COPIES ALSO INCLUDE Project Status, both
             introductions and the Grid Knowledge document. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "dct_type" and for
             "frame_pred_frame_dct": found this document (many), the Grid
             Knowledge document, both introductions, Project Status, both
             chat blurbs, the Concise Summary, the GAIS files and the Scopes/
             re-decision documents. Separately searched for the NO_DCT
             fabrication prohibition (terms "NO_DCT", "fabricat", "truth
             class"): found here and at section 0 item 15 and section 15 of
             this document, and nowhere else in the live corpus.

DERIVED      A VERIFIED-FACT ENTRY IS CARRYING A PROJECT RULE, AND THE
             PROVENANCE LABEL COVERS BOTH. F5 is tagged [H.262-VERIFIED].
             Propositions (a) and (b) are. Proposition (c) - "MUST NOT be
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
TIER     A
PROPOSED
ACTION   SPLIT F5 at the next authority version bump: keep (a) and (b) as
         F5 [H.262-VERIFIED], and move (c) to the D4-Q14 experiment
         definition in section 15, where section 0 item 15 already states it.
         W3D does NOT propose the edit here - the authority is not edited by
         a ledger - and flags that this is exactly the atomic-claim defect
         (DEC-33a) occurring in the SOURCE DOCUMENT rather than in a ledger
         entry.
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
TIER     A
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
TIER     B
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
             LED-049.
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
TIER     A
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
TIER     A
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
TIER     A
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
SWEPT        Searched the live corpus for "mediainfo", case-insensitive:
             eight files, of which the live non-T1-process carriers are this
             authority (7 hits), the Grid Knowledge document (4), the
             designer introduction (3), the coder introduction (2), the
             designer chat blurb (1) and the Scopes/ architecture re-decision
             evaluation (1, T1S01b). Each hit was opened far enough to
             confirm it refers to the same triage route.

DERIVED      none.
```

```text
TIER     B
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
TIER     A
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
DOCUMENT     authority v1.05, sections 4.2 and 4.3, lines 447-500
CLAIM        FOUR propositions.
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
             (d) "TFF/BFF does not alter these spatial row sets."
ASSERTS      the exact whole-frame coordinates of horizontal luma transform
             edges under both organisations, and that field order does not
             move them.
CLASS        DERIVED from F1, F5 and F8, W3X-RATIFIED
DISPOSITION  CURRENT-UNIQUE for (a), (b) and (c); CURRENT-DUPLICATE for (d).
REASON       (a)-(c) are the mathematics itself and exist nowhere else in the
             live corpus in this form. Sections 10, 11 and 12 USE these
             coordinates and are consumers rather than copies. (d) is F7
             restated - see LED-045, where this copy is named as the concrete
             non-canonical copy the STAY-CANONICAL evidence rule requires.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: (a), (b), (c) -> this section,
             unique. (d) -> F7 in section 2.
DUPLICATE-ACTION  POINTER, for (d) only. Section 4.3 is not a designated
             summary layer.
             KNOWN NON-CANONICAL COPIES OF (d) INCLUDE: this line 500, and
             section 0 item 2's "[D4-D02, F7]" tag line. NOT EXHAUSTIVE.
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
             FOR (d): see LED-045's sweep, which enumerated the TFF/BFF
             population across the live corpus.

DERIVED      THE FIELD-ORGANISED FOOTPRINT SPANS THIRTEEN FRAME ROWS FOR A
             SIX-SAMPLE FILTER, AND THAT IS THE FACT WITH SIMD AND BOUNDS
             CONSEQUENCES. At s = 2 the read set e-6 .. e+4 covers rows e-6
             to e+4 inclusive in frame memory - eleven rows spanned to touch
             six samples - and the two parity edges at e and e+1 together
             touch rows e-6 through e+5. Charter B4's eligibility test is
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
TIER     A
PROPOSED
ACTION   RETAIN IN PLACE. Register the DERIVED paragraph as an input to the
         future kernel/bounds scope rather than as an authority edit - it is
         a consequence of ratified geometry, not a new decision, and the
         place it must not be forgotten is the eligibility proof.
VERDICT  [W3C]
```

---

# LED-052  Section 4.4 - vertical luma edges, and the retirement of the parity-split description

```text
DOCUMENT     authority v1.05, section 4.4, lines 502-513
CLAIM        TWO propositions. (a) "For FRAME and FIELD DCT alike: x = 8*k.
             Filtering is across columns within each row. There is no s=2
             vertical-row footprint simply because the macroblock used field
             DCT." (b) "This corrects an early pre-B2 W3C SIMD description
             that suggested a parity-split vertical four-row pack; that
             description is RETIRED."
ASSERTS      (a) the vertical geometry rule in coordinates; (b) that a
             specific earlier description is retired, and what it said.
CLASS        (a) DERIVED from F8; (b) a retirement record.
DISPOSITION  CURRENT-DUPLICATE for (a); CURRENT-UNIQUE for (b).
REASON       (a) is F8 expressed in coordinates and is also at section 0
             item 5 and section 11. (b) is a record of a correction and
             exists only here; it is the only place in the live corpus that
             says the parity-split vertical description is retired.
CONFLICTS    none in this document. SEE DERIVED - the retired description may
             still be live in the document it came from.
PREVAILS     CANONICAL HOME, PER PROPOSITION: (a) -> F8 in section 2, which
             states the fact; this section states the coordinate consequence
             and section 11 states Architecture D's use of it. (b) -> this
             section, unique.
DUPLICATE-ACTION  POINTER, for (a) only.
             KNOWN NON-CANONICAL COPIES OF (a) INCLUDE: section 0 item 5 of
             this document (RETAIN-SUMMARY at T1S01a3 LED-014), the designer
             introduction's ACTIVE ARCHITECTURE block, and Project Status.
             NOT EXHAUSTIVE. See LED-046's sweep.
SWEPT        For (b), the retirement: searched the live corpus for the
             retired description (terms: "parity-split", "parity split",
             "four-row pack", "vertical" combined with "parity"). The
             retirement statement is here. The DESCRIPTION ITSELF was traced
             to the Scopes/ architecture re-decision material, which is
             T1S01b and is not adjudicated here. THE SEARCH DID NOT
             ESTABLISH whether that document's text was ever amended, and
             this entry does not claim it was.

DERIVED      A RETIREMENT RECORDED IN THE AUTHORITY DOES NOT AMEND THE
             DOCUMENT THAT CARRIES THE RETIRED TEXT. Section 4.4 says the
             parity-split vertical description is RETIRED. The document that
             contains it is a live Scopes/ document in T1's population. If it
             still presents that description without a retirement marker, a
             reader of THAT document - which is the primary record of the
             architecture re-decision, and which a successor is directed to
             read - meets a retired SIMD description with nothing to warn
             them.
DERIVED-BASIS  Manifest section 3.2, which lists the six Scopes/ documents as
             live and in scope at T1S01b; section 4.4's retirement sentence,
             which names a W3C SIMD description as its object.
```

```text
TIER     A
PROPOSED
ACTION   RETAIN both propositions in place. REGISTER a named item for
         T1S01b: check whether the retired parity-split vertical description
         is still presented as current in the Scopes/ re-decision material,
         and if so disposition it SUPERSEDED there. Recorded here so T1S01b
         does not have to rediscover it.
VERDICT  [W3C]
```

---

# LED-053  Section 4.5 - 4:2:0 chroma geometry in chroma-plane coordinates

```text
DOCUMENT     authority v1.05, section 4.5, lines 515-529
CLAIM        THREE propositions. (a) "All coordinates below are CHROMA-PLANE
             coordinates." (b) For progressive and Case-(a) frame pictures:
             horizontal chroma block edges at e_c = 8*k, pitch 1; vertical
             chroma block edges at x_c = 8*k. (c) "There is NO luma-style
             midpoint/phase ambiguity in 4:2:0 Case (a)." (d) "Case (b) FIELD
             PICTURES represented as a woven frame use field adjacency, hence
             pitch 2 in frame-memory rows for horizontal chroma filtering."
ASSERTS      the chroma-plane coordinate declaration, the 4:2:0 frame-picture
             chroma edge coordinates, the absence of phase ambiguity, and the
             Case (b) woven-frame pitch.
CLASS        DERIVED from F1, F2 and F4, W3X-RATIFIED
DISPOSITION  CURRENT-DUPLICATE for (a); CURRENT-UNIQUE for (b), (c) and (d).
REASON       (a) is charter B5's rule restated locally - see LED-040, where
             this copy is named. (b), (c) and (d) are the chroma geometry
             consequences of F4 expressed in coordinates, and exist nowhere
             else in the live corpus. (c) in particular is the statement that
             makes 4:2:0 Case-(a) chroma cheap: it is why no chroma detector
             is needed and why the rejected midpoint machinery has no chroma
             counterpart.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: (a) -> charter B5. (b), (c),
             (d) -> this section, unique.
DUPLICATE-ACTION  POINTER, for (a) only.
SWEPT        For the uniqueness of (b), (c) and (d): searched the live corpus
             for "e_c", "x_c", "chroma block edges", "midpoint/phase" and
             "phase ambiguity". The coordinate forms e_c and x_c appear only
             in this document. The no-phase-ambiguity proposition appears
             only here; the nearest relative is section 0 item 3's statement
             that 4:2:0 chroma geometry is "NORMATIVE, NOT DETECTED", which
             is the F4 consequence rather than the midpoint statement.
             Separately searched for "midpoint" across the live corpus to
             check that no document still asserts a CHROMA midpoint class:
             the term is live in the README, the charter's parameter list,
             the Concise Summary, the Roadmap and this document, and in every
             case it refers to the LUMA midpoint of rejected Architecture A.
             No live document proposes a chroma midpoint.

DERIVED      none. The consequence for the parameter surface - that a
             chroma-facing midpoint parameter would have no referent - is
             D4-Q16's, and section 20 and the register own it.
```

```text
TIER     A
PROPOSED
ACTION   RETAIN IN PLACE. At T3, (a) follows whatever W3X decides at LED-038
         and LED-040 about local restatements of coordinate rules.
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
TIER     A
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
             The DERIVATION - the four-rows-in-each-clip mechanism - is
             stated in full only here.
CONFLICTS    none.
PREVAILS     CANONICAL HOME, PER PROPOSITION: the DERIVATION -> this section,
             uniquely. The CONCLUSION "whole-frame input only" -> D4-D01 in
             the section 22 ratified decision register.
DUPLICATE-ACTION  STAY-CANONICAL for the derivation; POINTER for the
             conclusion.
             CONCRETE NON-CANONICAL COPY OF THE CONCLUSION, NAMED: section 0
             item 1 of this document, "WHOLE-FRAME INPUT ONLY for MPEG-2 ...
             SeparateFields input is not a supported MPEG-2 contract because
             it tears frame-organised transform blocks between two clips.
             [D4-D01]", dispositioned RETAIN-SUMMARY at T1S01a3 LED-013.
             KNOWN NON-CANONICAL COPIES ALSO INCLUDE the designer
             introduction's ACTIVE ARCHITECTURE block, Project Status and the
             designer chat blurb. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "SeparateFields" and "separatefields"
             (a registered term in manifest group 3): found this document
             (sections 0, 5, 20, 22 and Appendix A), the README, the designer
             introduction, the coder introduction, Project Status, the
             Concise Summary, the Roadmap, both chat blurbs, the GAIS files
             and the Scopes/ re-decision documents. NOT ALL of those state
             the conclusion - several discuss the rejected Architecture A
             which assumed separated fields. THE DISTINCTION MATTERS AND IS
             NOT RESOLVED BY THIS SEARCH: a document that describes old
             Architecture A's separated-field mechanism is not necessarily
             asserting that SeparateFields is a supported contract. Each such
             document is adjudicated at its own step.

DERIVED      none.
```

```text
TIER     A
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
TIER     A
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
TIER     A
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
             of the measurement; and the precise limit of what it proves,
             including a reading rule for historical shorthand.
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
             T1S01a3 LED-013; the summary carries (b) and (c) but not the
             reading rule for "regime-3 mix", which is unique to (c) here.
DUPLICATE-ACTION  STAY-CANONICAL.
             CONCRETE NON-CANONICAL COPY, NAMED: the designer introduction
             v1.28's TARGET-DEVICE FACT / SIGNIFICANCE block, which states
             (b) and (c) in three bullets. KNOWN NON-CANONICAL COPIES ALSO
             INCLUDE the coder introduction, both chat blurbs, Project Status
             and the resume brief's standing-facts section. NOT EXHAUSTIVE.
SWEPT        Searched the live corpus for "adaptive-capable", "REGIME 3" and
             "regime-3": the adaptive-capable formulation is live in this
             document, both introductions, both chat blurbs, Project Status,
             the task register and the resume brief. "REGIME 3" as a
             vocabulary term appears in this document at section 0, section
             6.2 and Appendix E, and in the Grid Knowledge document. No live
             document was found asserting that mixture is OBSERVED rather
             than PERMITTED - which is the specific error (c) exists to
             prevent, and the check that matters most for this entry.

DERIVED      THE READING RULE IN (c) IS SCOPED TO THIS DOCUMENT AND THE
             SHORTHAND IT GOVERNS IS NOT. "In this document, historical
             shorthand such as 'regime-3 mix' must be read as
             'adaptive-capable per-MB regime'" binds a reader of the
             authority. The Grid Knowledge document is where the REGIME
             vocabulary originates and it carries no such rule; it is live in
             T1's population until T2 retires it. The sweep above found no
             live document making the overstatement, so the exposure is
             latent rather than actual - but the rule's scope is narrower
             than the vocabulary's reach.
DERIVED-BASIS  (c)'s own wording, which begins "In this document"; the
             manifest's inclusion of Grid Knowledge v1.2 in the live
             population at step T1S05; task register T2, which is BLOCKED by
             T1 and therefore has not yet retired it.
```

```text
TIER     A
PROPOSED
ACTION   RETAIN IN PLACE as canonical. W3D recommends the reading rule be
         treated as a T1-wide rule rather than a document-local one when the
         sweep reaches Grid Knowledge at T1S05 - i.e. any surviving
         "regime-3 mix" phrasing anywhere is read as adaptive-capable, not as
         observed mixture.
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
TIER     B
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
TIER     A
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
ASSERTS      the assessment of GAIS as an instrument, the standing
             verification rule, the evidence-only status of raw outputs, and
             this document's precedence on MPEG-2 design facts.
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
SWEPT        Searched the live corpus for "independent verification" and
             "GAIS": six live files carry the rule - this document, both
             introductions, the designer chat blurb, the D2 document and the
             GAIS investigation brief itself. The GAIS_investigations/ files
             and the raw GAIS response captures in the root are EVIDENCE and
             are not treated as copies of the rule.

DERIVED      none.
```

```text
TIER     A
PROPOSED
ACTION   RETAIN the rule in place as canonical; the precedence clause becomes
         a pointer at T3. The orientation documents' copies are read-first
         layers and W3D expects a RETAIN-SUMMARY argument for them at T1S05.
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
TIER     A
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
     (sections 9-13). Is the boundary at line 715/716 the right one, and does
     anything in sections 1-8 depend on sections 9-13 in a way that makes
     adjudicating them separately unsound?

Q-C  STAY-CANONICAL, FIRST USE IN T1. THIRTEEN entries claim it in their
     DUPLICATE-ACTION field: LED-036, LED-041, LED-042, LED-043, LED-045,
     LED-046, LED-048, LED-049, LED-054, LED-055, LED-057, LED-058 and
     LED-061. Five of those claim it for SOME propositions only and POINTER
     for others in the same entry - LED-043, LED-048, LED-054, LED-055 and
     LED-061 - so check the per-proposition split as well as the action.
     Each names at least one concrete non-canonical copy with its location,
     per DEC-43. Test the named copies: do they exist, do they state the same
     proposition, and is the copy being adjudicated genuinely the canonical
     home rather than merely the one the designer was reading?
     THE ENUMERATION ABOVE WAS PRODUCED BY SEARCHING THE FINISHED LEDGER, NOT
     BY RECALLING WHICH ENTRIES USED IT. The first version of this question
     was written from memory, said SIX, and named nine of which one was
     wrong. It was corrected before issue by the post-write sweep. Recorded
     because DEC-51 says an enumeration written from recollection is the same
     assurance in a longer form, and this is that failure caught in flight.

Q-D  THE TWO TESTED CLAIMS. LED-037 and LED-047 both TEST a coverage claim
     made by the document rather than accepting it, and both report the claim
     TRUE. Attack the searches, not the conclusions: is the population each
     names the right population, and does the classification of each hit
     hold?

Q-E  DERIVED PROPOSITIONS. Fourteen entries carry a DERIVED field. Several
     are findings about the document's own discipline - F5's tag covering an
     unverified rule (LED-043), F6/F7/F8 having no recorded basis (LED-044,
     LED-046), the LG table having no recorded method (LED-057), the section
     8 rule being scoped to one named instrument (LED-062). Are any of these
     actually findings about existing text that have leaked into DERIVED, or
     conversely, has any inference leaked into a DISPOSITION or ASSERTS
     field?

Q-F  THE ONE CONDITIONAL DISPOSITION. LED-059 maps a canonical home into
     section 15, which this sub-tranche has not read, and says so. Is that an
     acceptable conditional, or should the entry simply defer?

Q-G  THE ONE UNDECIDED DISPOSITION. LED-063 dispositions the section 8
     calibration pointer CONFLICTING and declines to say which side prevails,
     because the other side is in section 24 and belongs to a6. Is
     CONFLICTING the right disposition when the conflict cannot be resolved
     within the sub-tranche, or should it have been deferred whole?
```

---

*End of T1S01a5 ledger v1.0. Nothing here is ratified. Every PROPOSED ACTION
is a proposal to W3X, and no authority document has been edited.*
