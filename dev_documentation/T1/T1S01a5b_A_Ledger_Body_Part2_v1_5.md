# Deblock4 - T1S01a5b Adjudication Ledger - Authority Body Part 2

**Deliverable:** T1S01a5b_A - LEDGER BODY PART 2
**Version:** 1.5
**Date:** 2026-08-22
**Author:** W3D
**Status:** ADJUDICATION LEDGER, BATCH 1 COMPLETE - W3C REVIEW CYCLE
CLOSED. All 29 entries carry recorded AGREE verdicts across four review
rounds (T1S01a5b_B, B v2, B v3, B v4). This version adopts W3C's v4
verdict stamps as the verdicts of record and adds no adjudication content.
BATCH 1 RETURNS TO W3X FOR CLOSURE. Nothing here is ratified: the
PROPOSED ACTIONs, the map amendment and the authority's one-word fix all
await W3X - authority
sections 9 and 10, lines 716-876, 29 entries: LED-064..081 plus eleven
ratified-rule split/coverage entries (066a, 066b, 067a, 070a, 070b, 073a,
074a, 074b, 078a, 078b, 081a). THIS DOCUMENT IS THE ARTIFACT OF RECORD
and supersedes v1.2.  ratification. No further W3C round is requested by either
party.
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_15.md`
**Source:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Population:** the 38-file a5b population declared at
`T1S01a5b_A_Population_Delta_v1_1.md` (which supersedes map A.3).
**Coverage frame:** `T1/T1S01a5b_A_Population_and_Coverage_Map_v1_0.md` Part B.
**Encoding:** US-ASCII; CRLF.

---

# 0. DECLARATIONS THIS INCREMENT MAKES, IN TESTABLE FORM

## 0.1 Coverage declaration (DEC-50 / DEC-56 form)

```text
DECLARED RANGE OF THIS BATCH: authority lines 716-876 EXACTLY - sections 9
and 10 complete. Lines 716-717 (section-9 title) and 804-805 (rule + blank)
are the map's recorded NO-PROPOSITION segments; every other line belongs to
exactly one entry below, per the map's Part B segmentation, which this batch
follows except for the four explicitly recorded v1.2 amendment rows
(738-745, 762-785, 796-803, 806-817) marked below:

    SECTION 9                          SECTION 10
    718-726 -> LED-064                 806-817 -> LED-074 / 074a / 074b
    727-737 -> LED-065                 818-832 -> LED-075
    738-745 -> LED-066 / 066a / 066b   833-834 -> LED-076
    746-747 -> LED-067 / 067a          835-849 -> LED-077
    748-756 -> LED-068                 850-854 -> LED-078 / 078a / 078b
    757-761 -> LED-069                 855-862 -> LED-079
    762-785 -> LED-070 / 070a / 070b   863-871 -> LED-080
    786-788 -> LED-071                 872-876 -> LED-081 / LED-081a
    789-795 -> LED-072
    796-803 -> LED-073 / 073a

No line of 716-876 is unassigned. Lines 877-1098 (sections 11-13,
LED-082..097) belong to LATER a5b BATCHES and are not covered here.
The four amended segment rows above (738-745, 762-785, 796-803, 806-817)
record a MAP PART-B AMENDMENT per T1S01a5b_B F1/F3/F5/F6, pending the
map's own v1.1 bump (W3X commits tree artifacts).
```

## 0.2 Overlap statement

```text
No entry below adjudicates any line outside 716-876. Where evidence for a
disposition lies in a5's settled range 223-715, the occurrence is CITED AS
SETTLED a5 GROUND with its location, and is not re-adjudicated. Where
evidence lies in a6's range (sections 14-22, section 24, Appendices A-D),
the entry carries a CITED-OUTSIDE-RANGE record per scope 0.6. Where evidence
lies elsewhere in a5b's own range but in a LATER BATCH (sections 11-13,
LED-082..097), the entry carries an IN-RANGE CROSS-NOTE naming the owning
reserved entry; that later entry must reconcile with this one when its
batch is adjudicated, and neither is final until both are. Cross-notes
BETWEEN entries of THIS batch are reconciled inside it.
```

## 0.3 Method statement (DEC-67, in the ratified bounded form)

```text
For every entry: the proposition was declared; a bounded probe family was
declared covering its material concepts, including the source wording and
independent reformulations; the family was run CASE-INSENSITIVELY over the
WHITESPACE-NORMALISED text of all 38 population files (Rule 2 - the corpus
wraps sentences, so all whitespace was collapsed to single spaces before
matching, with matches mapped back to original line numbers); EVERY hit was
opened and its matched passage read in surrounding context; each occurrence
was classified CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE / MIXED.
No exhaustiveness is claimed beyond the declared population and families.
The harness and the exact probe expressions are reproducible from the SWEPT
fields; W3X holds the run transcript.

ENTRY COUNT OF THIS BATCH, DERIVED BY ENUMERATING THE ENTRIES BELOW, NOT
CARRIED FROM A PLAN: 29 - eighteen map segments, eight of which split
under the atomic-claim rule or gained coverage entries, adding eleven
(LED-066/066a/066b, LED-067/067a, LED-070/070a/070b, LED-073/073a,
LED-074/074a/074b, LED-078/078a/078b, LED-081/081a). The 067, 070, 074
and 078 splits were map-pre-flagged; 081 was rule-driven at v1.1; 066a,
070b, 073a and 074b were added at v1.2 per W3C findings F3, F1.3, F5 and
F6; 066b was added at v1.3 per T1S01a5b_B v2 F10 (token-level split of
line 743). There is no target entry count.
```

## 0.4 Two standing notes so nobody re-derives them per entry

```text
NOTE A - THE README. The README asserts substantial parts of the old
Architecture A mechanism AS SETTLED LIVE DESIGN (its status tables literally
mark the step-4 primary/midpoint grid "Settled"). That is the known DEC-07
condition: the README contains ratified Architecture A design, is
UNADJUDICATED, is owned by T1S02/T1S03, and is stripped at T3; on every
MPEG-2 matter the ratified authority prevails (charter Part 0 bootstrap
note). Entries below therefore record README passages as evidence of
DUPLICATION or of a KNOWN, ALREADY-DECIDED precedence conflict - they do not
adjudicate the README's own statements, and no entry proposes a README edit.

NOTE B - AUTHORITY SECTION 0. Section 0's restatements of section-9 material
were adjudicated at T1S01a3 under the ratified RETAIN-SUMMARY exception
(DEC-36; seven genuine uses confirmed at DEC-39). Entries below cite section
0 occurrences as the settled summary layer and do not re-adjudicate them.
```

---

# 1. ENTRIES

--------------------------------------------------------------------------

LED-064

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, lines 718-726
  CLAIM        "Original design: separated-field luma candidate row step =
               4 field rows; primary: r mod 8 == 0; midpoint: r mod 8 == 4"
  ASSERTS      A historical fact: the rejected Architecture A used a
               separated-field step-4 luma candidate grid with two position
               classes, primary rows at multiples of 8 and midpoint rows
               offset by 4.
  CLASS        Project design-history record - a recorded fact about a
               formerly ratified design, preserved inside the rejection
               record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       The statement is TRUE (it describes what A was, not what the
               design is) and it is written in more than one place. Section
               9.1, as the head of the authority's options-and-re-decision
               record, is the right canonical home for what A WAS: section
               12 and Appendix C exist precisely so rejected A "is not
               rediscovered as forgotten good design", and 9.1 opens that
               complex. Known non-canonical copies include: the D4
               Architecture Re-Decision Brief section 2.1, lines 49-54
               (CARRIER - states the same historical mechanism); the D4
               Re-Decision W3C Evaluation section 3.5, lines 305-313
               (CARRIER); the designer introduction v1_33 line 67 names the
               "old union step-4/midpoint architecture" (CARRIER, compressed).
  CONFLICTS    The README asserts the SAME mechanism as SETTLED LIVE design
               (status line 93 "luma uses a step-4 candidate set with
               primary/midpoint classes"; decision table line 331 "Settled
               geometry"; sections 3.11-3.13). That is a live corpus
               contradiction of A's rejected status - and it is the KNOWN,
               ALREADY-DECIDED one (section 0 Note A).
  PREVAILS     The authority prevails (charter Part 0; DEC-07). The
               README's copies await T1S02 adjudication and the T3 strip;
               nothing here changes that route.
  SWEPT        Population: the 38 files of Delta v1.0. Probe family:
               {"separated-field ... step/row ... 4", "row step = 4",
               "step-4", "r mod 8", "mod 8 == 0", "mod 8 == 4",
               "primary ... midpoint", "midpoint ... class/candidate/
               position"}, whitespace-normalised, case-insensitive. Files
               with hits, each opened and classified:
                 authority (self): 9.1 in-range; section 0 item 13 line 178
                   (settled a3 summary layer); section 12.1 lines 921-952
                   and Appendix C lines 1873-1876 - see OCCURRENCES;
                 Re-Decision Brief: CARRIER (lines 49-54, 119-121);
                 Re-Decision Evaluation: CARRIER (305-313 and passim);
                 README: MIXED - carries the mechanism description AND
                   asserts its currency (93, 140, 281-285, 331, 573-580,
                   2947, 3318, 3518);
                 Project Status: CARRIER (line 551, "the README union
                   step-4 grid", historical framing);
                 designer introduction: CARRIER (line 67); coder
                   introduction: CARRIER-as-superseded-warning (line 175);
                 Concise Summary: DIFFERENT at 182 (the live
                   luma_midpoint_enabled custom-mode parameter, not A's
                   grid) and CARRIER-historical at 221-222;
                 Stage 2C D2 HolyWu Real Schedule lines 122-123: DIFFERENT
                   (H.264 4-pixel step-4 schedule - the word "step 4" about
                   a different grid entirely);
                 designer-intro authoring instructions line 68: DIFFERENT
                   ("the step-4 grid" as a caught-error anecdote, H.264
                   context);
                 charter 1959: DIFFERENT ("Midpoint class" glossary row
                   defines the live custom-mode concept, not A).
  OCCURRENCES  (scope 0.5 - same-file multiplicity is material here)
               9.1 lines 718-726        CANONICAL occurrence
               section 0 item 13, 178   CARRIER - settled a3 RETAIN-SUMMARY
               section 12.1, 921-952    CARRIER - in-range, owned by
                                        LED-087 (a later a5b batch)
               Appendix C, 1873-1876    CARRIER - OUTSIDE RANGE, see below
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1873-1876
               proposition: A's step-4 primary/midpoint mechanism (history)
               evidence use here: establishes same-file duplication
               owning tranche: T1S01a6
               a6 must reconcile Appendix C's copy with this STAY-CANONICAL
               adjudication of 9.1.
  REPAIR-v1_2  (per T1S01a5b_B F1.1 and F2; extends OCCURRENCES,
               CONFLICTS and SWEPT)
               F1.1 - the segment's heading, line 718 ("## 9.1
               Architecture A - old separated-field union grid -
               REJECTED"), carries the REJECTED status proposition
               adjudicated at LED-067 and is recorded there as an
               in-range occurrence; cross-recorded here so the segment's
               coverage is exact.
               F2 - CONFLICTS is amended: the current Grid Knowledge v1.2
               still asserts the old-A separated-field midpoint machinery
               AS CURRENT KNOWLEDGE - lines 9 and 24 (machinery framing),
               28 ("confirmed required, not hypothetical"), 124-150
               (section 4, "The midpoint machinery"), 233-258 including
               235 ("The midpoint machinery is CONFIRMED REQUIRED for
               real target footage"). These contradict the authority's
               rejection of that mechanism. THE AUTHORITY PREVAILS: Grid
               Knowledge is superseded-declared by the authority itself
               and already on its T2 retirement route - a decided
               conflict recorded in the same pattern as the README DEC-07
               case, not a new decision. SWEPT is correspondingly
               extended: Grid Knowledge's A-mechanism passages are
               reclassified from historical-problem-statement to STALE
               CURRENT-KNOWLEDGE ASSERTION, conflict recorded, cleanup
               already routed.
  TIER         C (derived from disposition, DEC-62)
  PROPOSED
  ACTION       None on the authority. The README copies follow their
               existing DEC-07 route; no new action is created here.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-065

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, lines 727-737
  CLAIM        "Midpoint alpha and beta were scaled once at creation: S =
               round_half_up(midpoint_threshold_scale * 65536);
               scale_threshold(t,S) = (i64(t)*i64(S) + 32768) >> 16. tc0
               and the one-sample correction addition were deliberately not
               scaled..."
  ASSERTS      A historical fact: A's midpoint thresholds were scaled once
               at creation by the stated fixed-point formula; detection
               thresholds only - correction strength deliberately unscaled,
               so an activated midpoint was corrected at normal strength.
  CLASS        Project design-history record (as LED-064).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True as history; written in more than one place. Canonical
               home 9.1, with LED-064's reasoning. Known non-canonical
               copies include: the Re-Decision Brief lines 55-64 (CARRIER -
               formula, immutability, tc0-unscaled, all restated); the
               Re-Decision Evaluation lines 529-531 (CARRIER, attributed to
               "the old README"); README 3.13 lines 626-652 (MIXED - same
               formula and rules asserted as live design).
  CONFLICTS    As LED-064: the README asserts the mechanism as live
               (section 0 Note A). Decided precedence; not new.
  PREVAILS     The authority (charter Part 0; DEC-07).
  SWEPT        Population: 38 files. Probe family: {"65536",
               "round_half_up", "scale_threshold", "32768 ... >> 16",
               "tc0 ... not scaled/unscaled/deliberately",
               "not/never scaled ... tc0", "corrected at normal strength"}.
               Files with hits, opened and classified:
                 authority (self): 9.1 in-range; 12.5 lines 1020-1046
                   discuss midpoint_threshold_scale's limits - DIFFERENT
                   proposition (what scaling CANNOT do), owned by LED-091,
                   a-later-a5b-batch cross-note;
                 Re-Decision Brief: CARRIER (55-64);
                 Re-Decision Evaluation: CARRIER (529-531);
                 README 3.13: MIXED (626-652 - same mechanism as live);
                 Project Status: CARRIER-historical (line 464, PR-2
                   narrative restates the tc0-unscaled rule as A's);
                 no other file matched.
               A DELIBERATE NEGATIVE finding, recorded because the
               distinction guards a known trap: the LIVE public parameter
               `midpoint_threshold_scale` (charter 6.3 line 1922; README
               3.14) is a DIFFERENT proposition - a surviving parameter
               surface, currently legacy scaffolding per authority section
               20 - and no occurrence of it was counted as a carrier of A's
               historical mechanism.
  OCCURRENCES  9.1 lines 727-737        CANONICAL occurrence
               12.5 lines 1020-1046     DIFFERENT (limits of scaling),
                                        owned by LED-091, a later a5b batch
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-066   (re-reissued at v1.3 per T1S01a5b_B v2 F10: the Evaluation
           citation range now includes the retention verb at line 655,
           and the no-multiply token of item 3 - which has no external
           carrier - is split to LED-066b. Token-level split of line 743
           (v1.3 said 741 - that is the fixed-point item; the
           float/multiply item is 743; corrected per T1S01a5b_B v3 F16),
           declared per the atomic-claim rule; precedent: the clause- and
           sentence-level splits at LED-067a and LED-081a.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, lines 738-744 (items
               1-4 of the retention list; item 5 at line 745 is LED-066a;
               the "/multiply" token of item 3 at line 743 is LED-066b)
  CLAIM        "Good engineering ideas retained from A: creation-time
               fixed-point conversion; immutable threshold sets; no
               float/multiply in the pixel loop; deterministic/stateless
               operation" - of which THIS entry adjudicates the retention
               of: fixed-point conversion (item 1), immutable threshold
               sets (item 2), the NO-FLOAT discipline of item 3, and
               deterministic/stateless operation (item 4).
  ASSERTS      A retention claim: these practices survive A's rejection
               and remain adopted project practice.
  CLASS        Reasoned project decision record (a recorded retention,
               not a codec fact).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       The retention claim for these limbs is true and carried
               elsewhere, PER LIMB, with the carrier lines opened and
               read:
                 items 1 and 2: Re-Decision Evaluation lines 1072-1073 -
                   "RETAIN A's good engineering ideas - immutable
                   creation-time threshold sets, fixed-point scaling, no
                   hidden state" (recommendation 4);
                 item 3 (no-float): Evaluation lines 654-655 - "The
                   fixed-point creation-time scaling, immutable threshold
                   sets and no-float kernel discipline remain excellent
                   patterns." - the sentence whose retention verb sits on
                   line 655, which the v1.2 range (633-654) truncated
                   (T1S01a5b_B v2 F10);
                 item 4: 1072-1073 "no hidden state" with the
                   determinism/statelessness argument at 633-654.
               The no-MULTIPLY token of item 3 has NO carrier in the
               Evaluation or anywhere else on the declared search; it is
               adjudicated separately at LED-066b so a subset carrier is
               not used to prove a conjunction (the F3/F10 lesson,
               applied at its final boundary).
               DISTINCTION HELD DELIBERATELY (unchanged): the practices
               are separately asserted as live rules in their own homes
               (charter E2/G4/F-series; README kernel rules). Those are
               the practices THEMSELVES, not the retention-from-A claim,
               and were classified DIFFERENT.
  CONFLICTS    None found.
  PREVAILS     n/a
  SWEPT        Population: 38 files (Population Delta v1.1). Probe
               family: {"retained from A", "ideas retained",
               "creation-time fixed-point", "immutable threshold", "no
               float ... pixel loop", "no-float", "deterministic ...
               stateless"}. Files with hits, opened and classified:
                 authority (self): 9.1 in-range; section 8 lines 690-696
                   (research-reasoning retention list - DIFFERENT
                   subject, settled a5 ground);
                 Re-Decision Evaluation: CARRIER per limb as enumerated
                   in REASON (1072-1073; 654-655; 633-654);
                 Re-Decision Brief: APPLIES (164-172 and line 60 -
                   describe A's virtues pre-decision);
                 README: DIFFERENT throughout (live rules: 333, 652-653,
                   1009, 3373);
                 PreScope coder response line 52: APPLIES.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v4, 2026-08-22)

--------------------------------------------------------------------------

LED-066a  (new at v1.2 per T1S01a5b_B F3: fifth clause of the 9.1
           retention list, split for atomicity - its evidence differs in
           kind from items 1-4)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, line 745
  CLAIM        "uncertainty should be measurable and explicit." (fifth
               item of "Good engineering ideas retained from A")
  ASSERTS      That the measurable-and-explicit-uncertainty principle is a
               practice retained FROM A.
  CLASS        Reasoned project decision record.
  DISPOSITION  CURRENT-UNIQUE
  REASON       The principle-as-retained-from-A is stated here and, on the
               declared search, nowhere else. W3C's independent search
               (T1S01a5b_B F3) reached the same result. The corpus is full
               of the principle APPLIED - D's diagnostics counters, the
               DIAG arc, Q14's confidence-margin reporting - but an
               application of a principle is not a statement that the
               principle was retained from A, exactly the distinction
               LED-066 holds for the other four items.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Per scope 5.3 this uniqueness claim
               records family AND reformulations: {"measurable and
               explicit", "uncertainty ... measurable", "uncertainty ...
               explicit", "explicit uncertainty"}. One hit: the in-range
               line itself. Adjacent material opened and classified:
               UNKNOWN/diagnostics counting (authority 10.4, section 16,
               D4-D07 register) - DIFFERENT (application); Re-Decision
               Evaluation confidence-margin and by-type reporting material
               (136-141 area) - DIFFERENT (Q14 measurement design);
               charter F-series determinism/diagnostics rules - DIFFERENT
               (live rules, per LED-066's held distinction).
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-066b  (new at v1.3 per T1S01a5b_B v2 F10: the no-multiply token of
           retention-list item 3, split from LED-066 because its
           evidence status differs from the no-float token it shares a
           line with)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, line 743 (the
               "/multiply" token of "no float/multiply in the pixel
               loop")
  CLAIM        That the NO-MULTIPLY discipline of the pixel loop is a
               practice retained FROM A.
  ASSERTS      As above: multiplication is excluded from the pixel loop
               as an engineering practice carried over from A (whose
               design converted thresholds once at creation precisely so
               the loop needs no runtime threshold/midpoint multiplies).
  CLASS        Reasoned project decision record.
  DISPOSITION  CURRENT-UNIQUE
  REASON       The no-multiply-as-retained-from-A proposition is stated
               here and, on the declared search, nowhere else. W3C's
               independent search (T1S01a5b_B v2 F10) reached the same
               result: the Evaluation carries no-FLOAT retention (654-
               655) but never the multiply token; the README carries the
               live no-midpoint-multiply practice, not its A provenance.
  CONFLICTS    None asserted. See DERIVED for a recorded wording-scope
               observation that is deliberately NOT treated as a
               conflict.
  PREVAILS     n/a
  SWEPT        Population: 38 files (Population Delta v1.1). Per scope
               5.3, family AND reformulations: {"multiply",
               "multiplication"}. ELEVEN LOCI IN SEVEN FILES, every one
               opened and classified. The locus set below is unchanged
               from v1.3; only the distinct-FILE count was wrong there -
               v1.3 said eight, and its own enumeration proves seven
               (T1S01a5b_B v3 F17):
                 authority 743 - the in-range token (sole CARRIER);
                 authority 1328 - kernel delta-core "multiply-by-4
                   spelling" discussion (a6 range) - DIFFERENT
                   (arithmetic-construction doctrine, below);
                 Re-Decision Brief 60 - "no multiply, conversion..."
                   describing A's existing threshold design, pre-decision
                   - APPLIES (the source of the practice, not a statement
                   of its retention);
                 README 653 and 1923 - "performs no midpoint multiply" /
                   "does not multiply thresholds" - DIFFERENT (the LIVE
                   RULE, per LED-066's held distinction);
                 D0 Preface 252, D2 Real Schedule 187/245/410 - the
                   Classic delta-core obligation to use well-defined i32
                   multiply-by-4 arithmetic - DIFFERENT (see DERIVED);
                 Grid Knowledge 141 - old adaptive-strength multiply
                   discussion - DIFFERENT (superseded design talk);
                 dispatch explainer 397 - FMA accuracy note - DIFFERENT.
  --- WHAT THE DESIGNER INFERRED ---
  DERIVED      A wording-scope observation, recorded without proposing
               action: read literally, "no ... multiply in the pixel
               loop" is broader than the practice it names. The practice,
               per its A-era source (Brief 60) and its live README form,
               excludes runtime THRESHOLD/MIDPOINT multiplies by doing
               creation-time conversion; it does not prohibit
               well-defined integer arithmetic such as the delta-core
               multiply-by-4 that D0/D2 mandate for Classic. The two
               doctrines have distinct scopes and do not presently
               collide (no D4 kernel exists), but the literal breadth of
               line 743 is a latent ambiguity a future authority bump
               could tighten. Flagged for a6/T3 attention; no action
               proposed here, as none is in this correction's bounds.
  DERIVED-BASIS  The classified occurrence set above; scope boundaries
               of D0/D2 (Classic) vs section 9.1 (D4 retention).
  TIER         C (derived, DEC-62: CURRENT-UNIQUE -> C)
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v4, 2026-08-22)

--------------------------------------------------------------------------

LED-067   (split under the atomic-claim rule; map pre-flagged the
           Appendix-C mapping question. Two propositions, two entries.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, line 746 (first clause
               of lines 746-747)
  CLAIM        "The geometry mechanism itself is rejected."
  ASSERTS      Architecture A's geometry mechanism is rejected as the
               whole-frame architecture.
  CLASS        W3X-ratified decision (D4-D12 records the ratification).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and very widely duplicated - the map's advance warning
               that rejection statements repeat held. Canonical home for
               the body-narrative statement of A's rejection: 9.1, which
               heads the options record the rejection concludes. Known
               non-canonical copies include: designer introduction v1_33
               line 67 (CARRIER); Project Status lines 26/104/551
               (CARRIER); Forward Roadmap line 41 (CARRIER); Concise
               Summary line 43 (CARRIER); both chat blurbs (CARRIER);
               coder introduction lines 124-126 (CARRIER); Re-Decision
               Evaluation section 1 line 21 (CARRIER, as the originating
               recommendation).
  CONFLICTS    The README's "Settled" framing of A's grid (Note A). Known,
               decided, routed.
  PREVAILS     The authority.
  SWEPT        Population: 38 files. Probe family: {"geometry mechanism ...
               rejected", "Architecture A ... rejected/REJECTED",
               "A and C ... rejected", "A/C rejected", "old union ...
               rejected"}. Every file listed under REASON was opened at its
               hits and classified CARRIER; the README's hits classified
               MIXED per Note A; no other classes arose. Same-file
               occurrences under OCCURRENCES.
  OCCURRENCES  9.1 line 746             CANONICAL occurrence
               section 0 item 13, 178-185   CARRIER - settled a3 layer
               section 12, 915-1048     CARRIER (the in-range PROOF),
                                        owned by LED-086..091, later a5b batches
               D4-D12, lines 1657-1661  CARRIER - OUTSIDE RANGE (a6)
               Appendix A, line 1804    CARRIER - OUTSIDE RANGE (a6)
               Appendix C, line 1865    CARRIER - OUTSIDE RANGE (a6)
  CITED-OUTSIDE-RANGE
               locations: D4-D12 (section 22, 1657-1661); Appendix A
               terminology (1803-1804); Appendix C heading (1865)
               proposition: A is rejected
               evidence use here: establishes duplication breadth
               owning tranche: T1S01a6
               a6 must reconcile those copies with this STAY-CANONICAL
               adjudication - IN PARTICULAR the open canonical-home
               question flagged under DERIVED.
  --- WHAT THE DESIGNER INFERRED ---
  DERIVED      There is a genuine canonical-home question this entry
               deliberately does NOT settle: whether the DECISION "A is
               rejected" canonically lives in the ratified decision
               register (D4-D12, section 22) with 9.1 as narrative, or in
               9.1 with D4-D12 as the register's restatement. This entry
               adjudicates the 9.1 copy as canonical FOR THE BODY
               NARRATIVE; the register question belongs to a6, which owns
               section 22, and the CITED-OUTSIDE-RANGE record above carries
               the reconciliation duty.
  DERIVED-BASIS  Scope 0.5's own note that a6 holds the registers "all of
               which restate body propositions"; the tranche boundary rule
               (scope 0.6); DEC-56's exact-range discipline.
  REPAIR-v1_2  (per T1S01a5b_B F1.1 and F2; extends OCCURRENCES and
               CONFLICTS)
               F1.1 - occurrence added: authority line 718, the section
               9.1 heading (within LED-064's segment), is an in-range
               CARRIER of this entry's rejection proposition
               ("Architecture A ... REJECTED"); cross-recorded at
               LED-064.
               F2 - CONFLICTS is amended: Grid Knowledge v1.2 asserts the
               rejected old-A midpoint machinery as current knowledge
               (lines 9/24/28, 124-150, 233-258 incl. 235 "CONFIRMED
               REQUIRED") - contradicting the rejection this entry homes.
               THE AUTHORITY PREVAILS; Grid Knowledge is superseded-
               declared and retirement-routed (T2) - a decided conflict,
               recorded, not a new decision. Same record at LED-064.
  TIER         C
  PROPOSED
  ACTION       None here; a6 resolves the register-vs-body home.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-067a  (reissued at v1.2 per T1S01a5b_B F4: the pointer's truth is now
           recorded as VERIFIED by direct reading; the v1.1 claim that
           this could not be determined without adjudicating Appendix C
           is RETRACTED as over-restrictive)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, line 747 (second clause
               of lines 746-747)
  CLAIM        "Appendix C gives the exact proof."
  ASSERTS      A cross-reference claim: the exact proof of A's rejection is
               carried by Appendix C.
  CLASS        Internal cross-reference (a claim about the document's own
               structure).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       The pointer is duplicated (section 0 item 13 line 185,
               "Appendix C contains the exact derivation", settled a3
               layer) AND its content claim is now VERIFIED: W3C opened
               Appendix C lines 1873-1901 (T1S01a5b_B F4) and found the
               compact permanent rejection proof - old A's machinery
               (separated-field candidate step 4, primary r mod 8 = 0,
               midpoint r mod 8 = 4, creation-scaled midpoint alpha/beta),
               the whole-frame transposition defect, the wrong frame-DCT
               footprint, the write collision, the irreducible threshold
               ambiguity, and the conclusion that A's engineering ideas
               survive while its geometry does not. W3D confirms the same
               lines read the same way.
               RETRACTION: v1.1 said the content question "cannot be
               adjudicated without opening Appendix C, which is out of
               range". That conflated reading with adjudicating. Scope 0.6
               permits reading out-of-range material AS EVIDENCE; what a6
               owns is Appendix C's own occurrence disposition and the
               proof-division question against section 12 - both still
               carried below.
  CONFLICTS    None established at this tranche. The v1.1 recorded tension
               (two proofs, 9.1's pointer and section 12's in-range
               mathematics) is NARROWED, not closed: the two are distinct
               in granularity - Appendix C is the compact permanent
               record, section 12 the full in-range mathematics - and
               whether that division is deliberate duplication is a6's
               formal call.
  PREVAILS     n/a at this tranche.
  SWEPT        Population: 38 files. Probe family: {"Appendix C",
               "exact proof", "exact derivation", "rejection proof"}.
               Hits: authority self (185, 747, 916 area, 1865-1901, 1964);
               Project Status 460 (APPLIES - narrates 12.5's proof role);
               both blurbs (DIFFERENT - "Appendix C" as an a6 work item,
               process context); PreScope coder response 676 (APPLIES).
               All opened; no external document asserts the Appendix-C
               pointer, so duplication rests on the same-file section 0
               copy - sufficient under 5.4a.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1865-1901
               proposition: Appendix C carries the exact rejection proof
               evidence use here: CONTENT READ AS EVIDENCE (heading and
               proof body, 1873-1901); the occurrence itself was NOT
               adjudicated
               owning tranche: T1S01a6
               a6 must adjudicate Appendix C's own occurrence AND the
               section-12/Appendix-C proof-division question the map
               pre-flagged.
  TIER         C
  PROPOSED
  ACTION       None until a6 reports.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-068

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.2, lines 748-756
  CLAIM        "The first 2026-08-16 design used: measure two phase
               energies per region -> phase + confidence + UNKNOWN ->
               compile geometry spans -> filter."
  ASSERTS      A historical fact: intermediate Architecture B was a
               region-level phase-energy pipeline emitting phase,
               confidence and UNKNOWN, compiled into spans.
  CLASS        Project design-history record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True as history; duplicated. Canonical home 9.2. Known
               non-canonical copies include: the Re-Decision Brief section
               2.2, lines 91-96 (CARRIER - the same pipeline, stated as
               the then-current proposal); the Re-Decision Evaluation R2,
               lines 50-53 (CARRIER, "generic per-region phase spans").
  CONFLICTS    None: no live document asserts B as current.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"region-phase",
               "region phase", "phase energ-", "phase + confidence",
               "two phase"}. Files with hits, opened and classified:
                 authority (self): 9.2 in-range; D4-Q09 line 1560 uses the
                   phrase in NEGATION ("not a generic per-region phase") -
                   APPLIES, OUTSIDE RANGE (a6); D4-D04 line 1621 ("old
                   regional phase wording is RETIRED") - CARRIER of B's
                   retirement, OUTSIDE RANGE (a6); Appendix A line 1962
                   area - OUTSIDE RANGE (a6);
                 Re-Decision Brief: CARRIER (91-96, 142);
                 Re-Decision Evaluation: CARRIER (50-53, 88-90);
                 PreScope round brief and coder response: APPLIES
                   (203-236, 539-764 - discuss the proposal in review).
  CITED-OUTSIDE-RANGE
               locations: D4-Q09 (1558-1561), D4-D04 (1620-1625),
               Appendix A (~1962)
               proposition: B's region-phase model and its retirement
               evidence use here: duplication breadth for the disposition
               owning tranche: T1S01a6
               a6 reconciles the register/appendix copies with this entry.
  REPAIR-v1_2  (per T1S01a5b_B F1.2; extends OCCURRENCES)
               The segment's heading, line 749 ("## 9.2 Architecture B -
               generic region phase - SUPERSEDED BY B2"), carries the
               supersession status proposition adjudicated at LED-069 and
               is recorded there as an in-range occurrence;
               cross-recorded here so the segment's coverage is exact.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-069

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.2, lines 757-761
  CLAIM        "The good detector/pre-pass/span ideas survive. The vague
               'region phase' model did not say enough about mixed
               macroblock-row boundaries and encouraged an incorrect
               parity-split interpretation of vertical SIMD. B2 replaces it
               with macroblock topology."
  ASSERTS      Why B was superseded: its region model was under-specified
               at mixed boundaries and encouraged the (wrong) parity-split
               vertical-SIMD reading; B2's macroblock topology replaces it,
               and B's detector/pre-pass/span ideas survive.
  CLASS        Reasoned project decision record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       The SUPERSESSION-WITH-REASONS statement is true and its
               material parts are each carried elsewhere; per the atomic
               lesson, uniqueness was NOT argued from the conjunction.
               Canonical home 9.2. Known non-canonical copies include: the
               Re-Decision Evaluation R2, lines 50-53 and 88-90 (CARRIER of
               the supersession and of the mixed-boundary rationale - "more
               precise than an arbitrary 'region phase' map and gives mixed
               boundaries an explicit home"). The parity-split limb is
               additionally carried at authority 4.3, lines 510-513, in
               a5's SETTLED range ("corrects an early pre-B2 W3C SIMD
               description that suggested a parity-split vertical four-row
               pack; that description is RETIRED") - cited as settled a5
               ground, not re-adjudicated.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"SUPERSEDED BY B2",
               "parity-split", "region phase ... vague/superseded/
               replace-", "B2 replaces", "mixed ... boundaries ...
               explicit"}. Files with hits, opened and classified:
                 authority (self): 9.2 in-range; 4.3 line 510-513 (settled
                   a5 ground, CARRIER of the parity-split limb); section 0
                   item 5 line 109-110 (APPLIES - "no parity split ...
                   required", the consequence, settled a3 layer); D4-D05
                   line 1628-1631 and D4-D12 line 1658 - OUTSIDE RANGE
                   (a6);
                 Re-Decision Evaluation: CARRIER (50-53, 88-90);
                 no other population file states the supersession
                 rationale.
  CITED-OUTSIDE-RANGE
               locations: D4-D05 (1626-1631), D4-D12 (1657-1661)
               proposition: B superseded by B2; no parity-split vertical
               pack
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  REPAIR-v1_2  (per T1S01a5b_B F1.2; extends OCCURRENCES)
               Occurrence added: authority line 749, the section 9.2
               heading (within LED-068's segment), is an in-range CARRIER
               of this entry's supersession proposition ("Architecture B
               ... SUPERSEDED BY B2"); cross-recorded at LED-068.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-070   (split under the atomic-claim rule; map pre-flagged the
           side-data sentence. Two propositions, two entries.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.3, lines 762-785,
               EXCLUDING the layer-B side-data sentence (lines 775-776),
               which is LED-070a
  CLAIM        "B2 separates four layers: A. MODE POLICY ... B. MAP
               PRODUCER ... C. EDGE-TOPOLOGY COMPILER / SPAN SCHEDULER ...
               D. DEBLOCK4-OWNED EDGE PREDICATE + KERNEL"
  ASSERTS      B2's structure is a four-layer separation: declared-mode
               policy; Case-(a) luma map producer (FRAME/FIELD/UNKNOWN +
               confidence); topology compiler producing geometry-
               homogeneous spans; and the independently derived Deblock4
               edge predicate and kernel.
  CLASS        Reasoned, W3X-ratified architecture record (D4-D12 family).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 9.3 - the only place
               the four layers are stated AS the four-layer contract.
               Known non-canonical copies include: the designer
               introduction v1_33, lines 63-65 (CARRIER, compressed:
               classify macroblocks, derive topology, compile spans);
               section 0 items 9-11, lines 127-162 (CARRIER - settled a3
               summary layer); Project Status lines 548-550 (CARRIER,
               compressed).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"four layers",
               "MODE POLICY", "MAP PRODUCER", "TOPOLOGY COMPILER",
               "SPAN SCHEDULER", "EDGE PREDICATE"}. Files with hits,
               opened and classified:
                 authority (self): 9.3 in-range; section 0 (settled a3);
                 13.1 lines 1054-1068 - the scheduler/kernel separation is
                   an APPLICATION of the layering, not a copy of it (the
                   0f warning held) - IN-RANGE, owned by LED-093,
                   a-later-a5b-batch cross-note; D4-D04/D4-D05 lines 1620-1631 -
                   OUTSIDE RANGE (a6); section 19 line ~1411 - OUTSIDE
                   RANGE (a6);
                 Project Status: CARRIER (459 area, 548-550);
                 PreScope coder response 518: CARRIER (restates the
                   separation while reviewing);
                 designer introduction: CARRIER (63-65).
  CITED-OUTSIDE-RANGE
               locations: D4-D04 (1620-1625), D4-D05 (1626-1631),
               section 19 (~1409-1440)
               proposition: the B2 layer contract
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  REPAIR-v1_2  (per T1S01a5b_B F1.3; coverage note)
               The segment's heading, line 763 ("## 9.3 Architecture B2 -
               PRIMARY CANDIDATE"), carries a current architectural-
               status proposition that no v1.1 entry adjudicated - a
               genuine coverage omission. It is now adjudicated at
               LED-070b (new at v1.2); this entry's four-layer-contract
               adjudication is unchanged.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-070a

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.3 layer B, lines 775-776
  CLAIM        "Future trusted decoder side-data may replace/bypass the
               pixel detector without changing the downstream topology
               contract."
  ASSERTS      A forward design constraint: trusted side data, if it ever
               arrives, substitutes for the pixel detector BEHIND the same
               map contract; downstream layers are unaffected.
  CLASS        Reasoned design constraint.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  POINTER (provisional - see below)
  REASON       True, and the SAME constraint is stated in fuller form at
               section 13.5, lines 1089-1098 ("trusted side data must feed
               the SAME FRAME/FIELD/UNKNOWN map contract ..."), which owns
               side-data policy in detail, with D4-Q13 as its register
               item. The 9.3 sentence is a one-line contextual mention
               inside the layer description; 13.5 is the natural canonical
               home. This copy is NOT the home and is NOT a designated
               summary layer, so under 5.4 the default applies: POINTER.
               PROVISIONAL BY DECLARED RULE, not by hedging: 13.5 is
               IN-RANGE FOR a5b but owned by LED-097 in a LATER a5b
               BATCH (section 13). This duplicate-action is final only
               when that batch's LED-097 confirms 13.5 as canonical home;
               until then the POINTER stands as provisional, the covering
               note flags the open condition to W3C, and if LED-097's
               adjudication moves the home this entry is corrected at the
               ledger's next version.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"side-data/side data
               ... replace/bypass", "trusted ... side data", "map
               contract", "D4-Q13"}. Files with hits, opened and
               classified:
                 authority (self): 9.3 in-range; 13.5 lines 1089-1098
                   (IN-RANGE for a5b; LED-097, a later batch); section 0 item 10's map-producer
                   note and item 4's side-data mention (settled a3 layer,
                   APPLIES); D4-Q13 register - OUTSIDE RANGE (a6);
                 designer introduction: APPLIES (deferred-list mention of
                   trusted per-MB side data);
                 no other carriers found.
  CITED-OUTSIDE-RANGE
               location: D4-Q13 (section 21 register)
               proposition: side-data trust contract remains open
               evidence use here: confirms the constraint is tracked live
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       At T3, reduce the 9.3 side-data sentence to a pointer to
               13.5 - CONDITIONAL on LED-097 confirming the home. A
               proposal, awaiting W3X at T3 as all ledger remedies do.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-070b  (new at v1.2 per T1S01a5b_B F1.3: authority line 763's B2
           PRIMARY CANDIDATE status heading was unadjudicated - a genuine
           coverage omission in segment 762-785)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.3 heading, line 763
  CLAIM        "Architecture B2 - PRIMARY CANDIDATE"
  ASSERTS      B2's current architectural status: the primary candidate
               (not a concluded architecture; candidacy pending Q14
               discrimination and kernel-scope decisions).
  CLASS        W3X-ratified architecture status (D4-D12 family).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and among the most widely duplicated status
               propositions in the corpus, as W3C's F1.3 anticipated.
               Canonical home: the authority - section 9.3's heading with
               section 0's PRIMARY ARCHITECTURE CANDIDATE block (line 125,
               settled a3 layer) as the summary-layer statement. Known
               non-canonical copies, opened at the cited lines: Concise
               Summary 41 and 52; Project Status 24 and 102; Forward
               Roadmap 40; designer introduction 63, 87, 735, 849; coder
               introduction 124 and 840; coder blurb 212; designer blurb
               159. Same-file out-of-range copies (D4-D12 register 1658-1659;
               Appendix material 1806-1808) are carried below, their
               exact lines opened and read at v1.3 (T1S01a5b_B v2 F11:
               the v1.2 citations, taken from approximate probe line
               mapping, stopped one line short of the proposition); revision-
               history mentions (1976) are history, not carriers.
  CONFLICTS    None. (The candidacy qualification - primary CANDIDATE, not
               concluded - is stated consistently across all opened
               copies; the designer introduction's "not a conclusion"
               phrasing at line 87 is the same proposition.)
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"PRIMARY CANDIDATE",
               "B2 ... primary", "primary ... candidate/architecture/B2"}.
               Files with hits, opened and classified: the carriers named
               in REASON; authority self-occurrences at 125 (a3 layer),
               179 (a5 ground, A-rejection context - APPLIES), 763
               (canonical, in-range), 1658-1659/1806-1808 (a6, below), 1976
               (revision history - DIFFERENT/history); Re-Decision
               Evaluation recommendation section (B2 adoption
               recommendation - APPLIES, the pre-decision proposal).
  CITED-OUTSIDE-RANGE
               locations: D4-D12 register (1658-1659: "B2 / macroblock-
               topology architecture PRIMARY candidate"); Appendix
               material (1806-1808: "Architecture B2 / Primary current
               candidate: ...")
               proposition: B2 is the primary candidate
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v3, 2026-08-22)

--------------------------------------------------------------------------

LED-071

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.3, lines 786-788
  CLAIM        "This keeps 'where is the transform edge?' separate from
               'does this local edge look like a compression artifact?'."
  ASSERTS      The governing separation principle: geometry location and
               artifact judgement are distinct questions answered by
               distinct layers.
  CLASS        Reasoned design principle.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home for THIS two-question
               formulation: 9.3, where it is the stated purpose of the
               layering. Known non-canonical copy: the PreScope coder
               response, lines 518-520 (CARRIER - restates the separation
               in the same two-question form while endorsing it).
               THE SAME-DOCUMENT SWEEP WAS RUN FIRST, deliberately - this
               is the founding-incident shape (PR-1): section 13.1 states
               the RELATED principle "schedule decides WHERE; predicate
               decides filterable; kernel decides HOW ... do not let the
               predicate become an implicit geometry classifier", and 12.5
               holds the supporting proof. Under the SETTLED PR-1
               resolution (DEC-24/DEC-54: 13.1 holds the general
               principle, 12.5 uniquely holds the proof - not reopened
               here), 13.1's formulation and 9.3's formulation are
               RELATED BUT DISTINCT propositions: 9.3 separates geometry
               from artifact-judgement; 13.1 separates schedule from
               predicate from kernel. Each is adjudicated in its own
               entry; neither is counted as a copy of the other.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"where is the
               (transform) edge", "look(s) like a (compression) artifact",
               "geometry ... separate ... artifact"}. Files with hits,
               opened and classified:
                 authority (self): 9.3 in-range; 13.1 (IN-RANGE, related-
                   but-distinct - owned by LED-093 in a later a5b batch, with this
                   entry's relationship note carried there); 12.5 (IN-
                   RANGE, LED-091);
                 PreScope coder response: CARRIER (518-520);
                 no other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-072

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.4, lines 789-795
  CLAIM        "Motion similarity is not a reliable dct_type classifier.
               Static field-DCT content can have little frame/field motion
               difference while the block geometry is still
               field-organised. It can therefore miss real staggered
               boundaries and probe non-boundaries simultaneously."
  ASSERTS      Why Architecture C is rejected: motion metrics are
               unreliable proxies for dct_type; the static-field-DCT case
               defeats them, producing simultaneous misses and false
               probes.
  CLASS        Reasoned rejection record (W3X-ratified via D4-D12).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 9.4. Known
               non-canonical copies include: the Re-Decision Brief section
               2.3, lines 100-103 (CARRIER - "REJECTED: fails on static
               ..."); section 0 item 14, lines 187-189 (CARRIER - settled
               a3 summary layer); the static-field-DCT limb also appears
               at authority section 8, line 693, inside the retained-
               reasoning list - settled a5 ground, cited not
               re-adjudicated; designer and coder introductions carry the
               compressed "C motion-classification remains rejected"
               (CARRIER).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"motion
               similarity/classif-/metric/based ... not/unreliable",
               "motion ... dct_type", "static field-DCT"}. Files with
               hits, opened and classified:
                 authority (self): 9.4 in-range; section 0 item 14
                   (settled a3); section 8 line 693 (settled a5);
                 Re-Decision Brief: CARRIER (100-103);
                 introductions/status/summary/roadmap: CARRIER of the
                   compressed rejection statement (adjudicated breadth
                   shared with LED-067's sweep);
                 no other classes arose.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-073   (reissued at v1.2 per T1S01a5b_B F5: the section-11 pointer
           clause is split to LED-073a for atomicity)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.5, lines 796-802 (the
               role/origin statement; the pointer at line 803 is LED-073a)
  CLAIM        "D was created during the re-decision as a better
               detector-free fallback than literal old A. It uses the
               actual whole-frame internal frame edge and avoids A's
               competing pitch-1/pitch-2 union collision."
  ASSERTS      What D is and why it exists: a detector-free fallback and
               comparator created at the re-decision, superior to literal
               A because it uses the real internal frame edge and has no
               union collision.
  CLASS        Reasoned, W3X-ratified architecture record (D4-D12 family).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and the most widely duplicated proposition in this
               batch - the map's advance warning held exactly. The 0f
               caution that D's HIGH-LEVEL ROLE and its DETAILED TOPOLOGY
               have different canonical homes is adopted as the
               adjudication structure: THIS entry homes the ROLE-AND-
               ORIGIN statement at 9.5; the TOPOLOGY's home is section 11,
               owned by LED-082 (a later a5b batch); the deferral pointer
               itself is now LED-073a. Known non-canonical copies of the
               role statement: Re-Decision Evaluation section 13, lines
               776-780 and 814-819 (CARRIER); Project Status lines
               25/103/187/549-550 (CARRIER); Forward Roadmap line 40
               (CARRIER); Concise Summary line 42 (CARRIER); designer
               introduction line 66 (CARRIER); coder introduction lines
               124-125 and 493 (CARRIER); both chat blurbs (CARRIER).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"detector-free ...
               fallback/comparator", "literal old A", "pitch-1/pitch-2
               union", "union collision", "created during the
               re-decision", "mandatory ... comparator"}. Files with hits,
               opened and classified: all files named in REASON, CARRIER
               at the cited lines; authority self-occurrences under
               OCCURRENCES; no DIFFERENT/IDENTIFIER/NOISE cases arose in
               this family.
  OCCURRENCES  9.5 lines 796-802        CANONICAL occurrence (role/origin)
               section 0 item 12, 164-174  CARRIER - settled a3 layer
               section 11, 877-914      the TOPOLOGY, owned by LED-082,
                                        a later a5b batch - in-range cross-note
               D4-D12, 1657-1661        CARRIER - OUTSIDE RANGE (a6)
               Appendix A, 1810-1811    CARRIER - OUTSIDE RANGE (a6)
  CITED-OUTSIDE-RANGE
               locations: D4-D12 (1657-1661), Appendix A (1810-1811)
               proposition: D is the mandatory detector-free
               fallback/comparator
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-073a  (new at v1.2 per T1S01a5b_B F5: the section-11 pointer clause,
           split from LED-073 - its evidence differs in kind from the
           widely-duplicated role statement)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.5, line 803
  CLAIM        "Its exact Case-(a) luma topology is in section 11."
  ASSERTS      A cross-reference claim: D's exact Case-(a) luma topology
               lives in section 11.
  CLASS        Internal cross-reference (a claim about the document's own
               structure).
  DISPOSITION  CURRENT-UNIQUE
  REASON       The pointer is stated here and, on the declared search,
               nowhere else - W3C's independent search (T1S01a5b_B F5)
               reached the same result. The pointer's TARGET is real and
               in a5b's own range: section 11 (lines 877-914) is D's
               Case-(a) topology per the ratified map, owned by LED-082 in
               a later a5b batch; that entry must confirm the target
               carries what this pointer promises (in-range cross-note,
               reconciliation owed). Unlike LED-081a's pointer, nothing
               contradicts this one: the target section exists at the
               named location with the named content per the map's own
               segmentation.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Per scope 5.3, family AND
               reformulations: {"topology is in section 11", "luma
               topology ... section 11", "section 11"}. The generic
               "section 11" term returned 4 hits: the in-range line 803
               (sole carrier) and Verification-and-Tiering v1.11 lines
               215, 552, 865 - all three opened: they reference THAT
               document's own internal section numbering, DIFFERENT. No
               other file matched.
  TIER         C
  PROPOSED
  ACTION       None; LED-082 reconciles the target on its batch.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-074   (reissued at v1.2 per T1S01a5b_B F6: the CLAIM is narrowed to
           the ownership rule; the duplicated geometry clause is split to
           LED-074b. The v1.1 split of the coalescing condition to
           LED-074a stands.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10 preamble, lines 815-816
               (the ownership clause only; the row-origin and segment
               geometry at 809-815 are LED-074b)
  CLAIM        "A horizontal boundary descriptor is owned exactly once for
               each half-open x interval [16*n,16*(n+1))"
  ASSERTS      B2's ownership guarantee: for every half-open 16-pixel x
               interval there is exactly one horizontal boundary
               descriptor owner - the constructive exclusion of double
               ownership.
  CLASS        Reasoned, W3X-ratified architecture mathematics (D4-D12
               family).
  DISPOSITION  CURRENT-UNIQUE
  REASON       The exactly-once / half-open ownership formulation is
               stated here and, on the declared search, nowhere else. W3C
               attacked this uniqueness independently with a broader
               exactly-once/single-owner/half-open/descriptor-ownership
               search over the 38 files (T1S01a5b_B F6) and found only the
               authority - the claim survives review. The nearest
               neighbours are all DIFFERENT propositions, classified in
               SWEPT: the Evaluation's double-write material concerns old
               A's collision defect and D's parity-disjoint writes - the
               DISEASE and a different cure - not B2's per-interval
               ownership guarantee, which is the constructive rule that
               makes the disease impossible.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Per scope 5.3, family AND
               reformulations: {"owned exactly once", "exactly once for
               each", "single owner", "one owner", "duplicate descriptor",
               "double-own", "no two jobs/descriptors", "half-open"} and
               the collision family {"double-write", "same samples
               twice/by two", "two jobs ... same"}. Every hit opened and
               classified:
                 authority (self): the in-range clause (sole CARRIER);
                   line 1964 "preserves the full A transposition/
                   double-write rejection proof" - DIFFERENT (A's defect,
                   a6);
                 Re-Decision Evaluation: 43 (A overlap/double-write -
                   DIFFERENT); 115 (D no-collision - DIFFERENT); 447 (D
                   parity-disjoint writes - DIFFERENT); 664 (comparison
                   header - IDENTIFIER);
                 no other file matched either family. W3C's independent
                 family reproduced this result.
  TIER         C (derived, DEC-62: CURRENT-UNIQUE -> C)
  PROPOSED
  ACTION       None. The unique statement stays where it is.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-074a

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10 preamble, lines 816-817
               (second clause of the descriptor sentence)
  CLAIM        "adjacent segments may be coalesced only when their
               resolved edge kind/geometry match."
  ASSERTS      The coalescing condition: adjacent x segments merge into
               one span only under matching resolved edge kind and
               geometry - the homogeneity requirement.
  CLASS        Reasoned, W3X-ratified architecture mathematics.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: the section 10
               preamble, which states the condition in its precise
               mathematical form. Known non-canonical copies: the
               Re-Decision Evaluation lines 88-90 (CARRIER - "Consecutive
               x macroblocks with the same resolved edge mode are
               coalesced into contiguous horizontal SIMD spans", the
               originating proposal); and IN-BATCH, section 9.3 layer C
               (lines 762-785, LED-070) whose "geometry-homogeneous
               spans" phrase carries the same homogeneity requirement in
               architectural form - the two entries are reconciled here:
               LED-070 homes the LAYER CONTRACT, this entry homes the
               COALESCING CONDITION, and neither counts the other's
               canonical text as a stray copy.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"coalesce-",
               "contiguous ... spans", "geometry-homogeneous", "same
               resolved edge mode/kind"}. Hits, opened and classified:
                 authority (self): in-range sentence; 9.3 layer C
                   (IN-BATCH, LED-070, reconciled above); section 0 items
                   9-10 per-segment/span framing (settled a3 layer,
                   APPLIES);
                 Re-Decision Evaluation: CARRIER (88-90);
                 no other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-074b  (re-reissued at v1.3 per T1S01a5b_B v2 F12: the declared
           geometry family is now actually executed in full, adding
           Evaluation 257 and four further loci the v1.2 sweep never
           ran)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10 preamble, lines 809-815
               (first two sentences of the descriptor passage)
  CLAIM        "Let one luma macroblock row begin at M = 16*m. Each
               macroblock occupies a 16-pixel x segment."
  ASSERTS      The base geometry: macroblock rows originate at multiples
               of 16; each macroblock spans a 16-pixel x segment.
  CLASS        Spec-anchored geometry (macroblock dimensions per H.262),
               stated as the working coordinate frame.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: the section 10
               preamble, where the coordinate frame anchors the ownership
               rule and the tables. Known non-canonical copies, each
               opened at its exact lines: section 0 item 9 line 137 ("per
               16-pixel x segment" - settled a3 layer, CARRIER);
               Re-Decision Evaluation line 71 ("For each 16-pixel
               horizontal macroblock segment" - CARRIER, the originating
               proposal) and line 257 ("Within a 16-row macroblock
               beginning at `M = 16*m`:" - CARRIER of the row-origin
               limb, stated as the working premise of the Evaluation's A
               analysis; the v1.2 sweep declared the M = 16*m probe but
               never executed it - T1S01a5b_B v2 F12). The M = 16*m
               formulae in section 4.3 (line 463 area) are settled a5
               ground, cited not re-adjudicated.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files (Population Delta v1.1). Probe
               family, EXECUTED IN FULL this time: {"M = 16*m", "16*m",
               "16-pixel ... segment", "occupies a 16-pixel"}. Ten loci
               in two files, every one opened and classified:
                 authority: 137 (a3 CARRIER); 463 (settled a5, cited);
                   812 and 815 (the in-range canonical text); 861
                   (section 10.3's "for that 16-pixel segment" -
                   IN-RANGE usage inside LED-079's segment, APPLIES,
                   cross-noted);
                 Re-Decision Evaluation: 71 (CARRIER); 257 (CARRIER,
                   row-origin limb, per REASON); 701 ("different
                   16-pixel macroblock segments can legitimately resolve
                   to different [modes]" - CARRIER, secondary: states
                   the segment geometry while arguing mode resolution);
                   793 and 804 (D-analysis usages of the segment frame -
                   APPLIES).
               No other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v3, 2026-08-22)

--------------------------------------------------------------------------

LED-075

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.1, lines 819-832
               (excluding line 833-834, which is LED-076)
  CLAIM        "Internal edge at M+8: FRAME -> edge e = M + 8, pitch s =
               1; FIELD -> no transform edge at M + 8; UNKNOWN -> current
               D4-D07 v1 policy: no filter; increment diagnostics"
  ASSERTS      The internal-edge topology table: a frame-DCT macroblock
               has a pitch-1 internal transform edge at M+8; a field-DCT
               macroblock has none; UNKNOWN falls under the settled
               D4-D07 no-filter-and-count policy.
  CLASS        Reasoned, W3X-ratified architecture mathematics; the
               FRAME/FIELD halves rest on spec-verified DCT organisation
               (H.262 6.1.3, settled at a5).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 10.1 - the table in
               its decided form. Known non-canonical copies: section 0
               item 9, lines 132-135 (CARRIER - settled a3 summary
               layer); the Re-Decision Evaluation lines 73-76 (CARRIER -
               the originating proposal, with ONE recorded historical
               variance: its UNKNOWN row reads "policy to be measured",
               the pre-decision state later settled as D4-D07 no-filter.
               The Evaluation is a point-in-time record; the variance is
               EVOLUTION, not conflict, and is recorded so nobody
               rediscovers it as one). Related same-file occurrences:
               section 4.3 line 466 states e = M + 8 within settled a5
               ground (cited, not re-adjudicated); the Evaluation also
               restates the FRAME-has/FIELD-hasn't fact at 690-691 and
               793-796 within its D analysis (CARRIER, secondary).
  CONFLICTS    None (the Evaluation UNKNOWN-row variance is historical,
               per REASON).
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"M + 8", "mb_y + 8",
               "internal (horizontal) edge at", "FIELD ... no (transform)
               edge"}. Files with hits, opened and classified:
                 authority (self): 10.1 in-range; section 0 item 9
                   (settled a3); 4.3 line 466 (settled a5); section 0
                   item 12 line 169 (D contrast, settled a3, APPLIES);
                 Re-Decision Evaluation: CARRIER (73-76, 690-691,
                   793-796); line 259 restates e = M + 8 inside its A
                   analysis (APPLIES - A context);
                 no other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-076

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.1, lines 833-834
  CLAIM        "This is the most direct observable difference between
               FRAME and FIELD topology."
  ASSERTS      A significance claim: the presence/absence of the M+8
               internal edge is the most direct observable discriminator
               between the two topologies.
  CLASS        Reasoned design judgement.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       The significance claim is carried elsewhere in reformulated
               words: the Re-Decision Evaluation lines 688-691 - "Frame/
               field DCT changes one thing vertically: FRAME has an
               internal horizontal block edge at mb_y+8; FIELD does not"
               - asserts the same discriminator-significance of the same
               difference (its "one thing" framing is if anything the
               stronger form). Classified CARRIER by semantic
               reformulation, deliberately and visibly: the alternative -
               calling 833 CURRENT-UNIQUE because no other document uses
               the words "most direct" - is precisely the paid-for a5
               failure mode of claiming uniqueness of a formulation while
               the corpus states the proposition another way. If W3C
               reads the Evaluation sentence as a different proposition
               (a count of differences rather than a significance claim),
               that disagreement is a finding and the entry moves to
               CURRENT-UNIQUE without further consequence: same tier,
               same action.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"most direct
               observable difference"} plus reformulations {"one thing
               vertically", "changes one thing", "only vertical
               difference", "most direct/reliable/observable",
               "clearest ... difference/signal", "distinguishes/
               distinguishing ... FRAME"}. Every hit opened and
               classified:
                 authority (self): 833 in-range (sole exact match); line
                   359 (chroma-organisation distinction, V4.1 territory -
                   DIFFERENT);
                 Re-Decision Evaluation: CARRIER (688-691, per REASON);
                 Grid Knowledge v1.2 line 67 ("The distinguishing signal
                   for frame-DCT is the EXTRA seams at the mod-4-but-not-
                   mod-8 positions") - DIFFERENT: the OLD separated-field
                   pitch-4/pitch-8 signal model that the authority
                   superseded; recorded so the superseded model is not
                   mistaken for a carrier;
                 PreScope coder response line 426 (chroma organisation -
                   DIFFERENT);
                 no other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-077

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.2, lines 835-849
  CLAIM        "Macroblock-row boundary at M+16 ... U/L table: FRAME/FRAME
               -> one pitch-1 edge at e; FIELD/FIELD -> pitch-2 edge at e
               plus pitch-2 edge at e+1; FRAME/FIELD -> pitch-2 at e plus
               e+1; FIELD/FRAME -> pitch-2 at e plus e+1; UNKNOWN any /
               any UNKNOWN -> current v1 policy: unresolved -> no
               filtering"
  ASSERTS      The row-boundary topology table over the (U,L) neighbour
               pair: homogeneous FRAME gives one pitch-1 edge; every
               other resolved pairing gives the two pitch-2 edges at e
               and e+1; any UNKNOWN participant falls under the no-filter
               policy.
  CLASS        Reasoned, W3X-ratified architecture mathematics.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 10.2 - the table in
               its decided, complete form. Known non-canonical copies:
               section 0 item 9, lines 137-143 (CARRIER - settled a3
               layer; ONE recorded naming variance: it labels FIELD/FIELD
               "two pitch-2 parity edges" and mixed "two pitch-2
               mixed-boundary edges" where 10.2 writes both as "pitch-2
               edge at e plus pitch-2 edge at e+1" - identical topology,
               different labels; naming variance, not conflict); the
               Re-Decision Evaluation lines 78-83 (CARRIER - originating
               proposal, with TWO recorded historical variances: its
               mixed row says "two pitch-2 parity edges", the same
               topology under the pre-decision label, and its UNKNOWN row
               says "explicit fallback policy, measured before freezing",
               the pre-decision state settled since as D4-D07 no-filter.
               Evolution, not conflict, as at LED-075). Related same-file
               occurrences: 4.3 lines 467-470 and the worked example at
               493-497 state the row-16 edge positions within settled a5
               ground (cited, not re-adjudicated); 9.2 line 759 (IN-BATCH,
               LED-069) references mixed boundaries in the supersession
               rationale.
  CONFLICTS    None (both variances are recorded as history/naming, per
               REASON).
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"M + 16", "mb_y +
               16", "macroblock-row boundar-", "two pitch-2
               parity/mixed", "pitch-2 edge at e", "FRAME/FRAME",
               "FIELD/FIELD"}. Files with hits, opened and classified:
                 authority (self): 10.2 in-range; section 0 item 9
                   (settled a3); 4.3 (settled a5); 9.2 (IN-BATCH,
                   LED-069); section 0 items 12/13 D-contrast lines
                   168-184 (settled a3, APPLIES);
                 Re-Decision Evaluation: CARRIER (78-83); its lines
                   101-119 give D's conservative pitch-2 treatment of the
                   same boundary (DIFFERENT - D's policy, not B2's
                   table); 138-141 lists boundary types for the
                   experiment (APPLIES, see LED-078a); 257-284 restate
                   row positions in A/D analyses (APPLIES); 460 (A's
                   union at the same boundary - DIFFERENT); 670
                   (comparison-table row - IDENTIFIER);
                 no other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-078   (split under the atomic-claim rule; map pre-flagged this
           segment. Provenance claim, Q14-statistics limb and fixture
           limb have three different evidence pictures.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.2, lines 851-852
  CLAIM        "The mixed rule is an independently adopted Deblock4
               topology choice, informed by the verified H.264 MBAFF
               concept but not inherited from H.264 code/math."
  ASSERTS      A provenance claim: the mixed-boundary rule is Deblock4's
               own adoption; H.264 MBAFF contributed the verified CONCEPT
               only, no code or mathematics.
  CLASS        Reasoned decision record resting on a spec-verified prior-
               art finding (H.264 clause 8.7, settled at a5).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 10.2, where the rule
               itself lives. Known non-canonical copy: the Re-Decision
               Evaluation lines 85-86 (CARRIER - "The mixed rule is the
               useful H.264/MBAFF analogy, but Deblock4 must derive and
               quality-prove it independently"). The provenance's
               spec-verified footing is section 7 P2, lines 653-657, in
               settled a5 ground ("[SPEC-VERIFIED] ... The useful
               carry-forward is the CONCEPT") - cited, not
               re-adjudicated. The four Scopes round briefs interrogate
               and verify the underlying H.264 facts and are classified
               below, not as carriers of the adoption claim.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"MBAFF",
               "independently adopted", "not inherited from H.264"}.
               Files with hits, opened and classified:
                 authority (self): 10.2 in-range; section 7 P2 (settled
                   a5, footing); section 24 R2 lines 1725-1726 ("Verified
                   MBAFF mixed-boundary conceptual precedent only" -
                   CARRIER, OUTSIDE RANGE, a6);
                 Re-Decision Evaluation: CARRIER (85-86);
                 PreScope Round Brief v1_2 and Verification Round Briefs
                   v1_0 AND v1_1 (both R-B members): the V2 items pose
                   VERIFY-or-refute tasks on the MBAFF description -
                   APPLIES (they interrogate the spec facts, they do not
                   assert the adoption);
                 PreScope coder response, V2 sections (173-206): asserts
                   the VERIFIED H.264 facts themselves - DIFFERENT
                   proposition (what H.264 does, not what Deblock4
                   adopted).
  CITED-OUTSIDE-RANGE
               location: section 24 references, R2 (lines 1725-1726)
               proposition: MBAFF is conceptual precedent only
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-078a

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.2, lines 853-854 (first
               limb)
  CLAIM        "It must be covered explicitly by Q14 truth statistics"
  ASSERTS      A coverage obligation: the mixed-boundary rule must be
               explicitly covered by the D4-Q14 experiment's ground-truth
               statistics.
  CLASS        Reasoned obligation record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 10.2, with the rule
               the obligation covers. Known non-canonical copy: the
               Re-Decision Evaluation lines 136-141 (CARRIER - "The
               experiment should also report by boundary type:
               frame/frame, field/field, mixed frame/field, frame-only
               internal edge" - the same by-type coverage obligation in
               its originating form). Whether section 15's experiment
               specification actually implements the by-type reporting is
               a6's verification, carried below.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"truth statistics",
               "report by boundary type", "by boundary type", "covered
               explicitly"}. Hits: authority 10.2 in-range and section 15
               (OUTSIDE RANGE, a6 - the experiment spec, whose per-type
               reporting content this sweep did NOT adjudicate);
               Re-Decision Evaluation CARRIER (136-141); no other file
               matched.
  CITED-OUTSIDE-RANGE
               location: section 15 (D4-Q14 experiment specification,
               lines 1157-1260)
               proposition: the Q14 spec is where this coverage
               obligation is discharged
               evidence use here: routing only - the spec's content was
               not adjudicated
               owning tranche: T1S01a6
               a6 must verify section 15 actually specifies mixed-
               boundary/by-type reporting, or record the gap.
  TIER         C
  PROPOSED
  ACTION       None here; a6 verifies fulfilment.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-078b

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.2, lines 853-854
               (second limb)
  CLAIM        "and later scalar quality fixtures."
  ASSERTS      A second coverage obligation: the mixed-boundary rule must
               also be covered by later scalar quality fixtures.
  CLASS        Reasoned obligation record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated - but ONLY within the authority
               itself, in a6 territory, which is why this limb is split
               from LED-078a rather than sharing its entry: its evidence
               picture is different in kind. Same-file copies: line 1696
               (the forward-sequence item "mixed-boundary fixtures") and
               line 1915 ("exact mixed-boundary kernel fixtures/quality
               evidence"), both OUTSIDE RANGE (a6). No document other
               than the authority carries the mixed-boundary-specific
               fixture obligation; the general fixture programme in the
               verification-and-tiering document is a DIFFERENT, broader
               proposition and was not counted.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"scalar quality
               fixture", "quality fixture", "fixtures ... mixed/boundary
               type/frame-field", "mixed ... fixture"}. Hits: authority
               10.2 in-range, line 1696 (a6), line 1915 (a6) - all three
               opened and read; no other file matched. The
               verification-and-tiering document's general fixture
               material did not match the mixed-specific family and was
               deliberately not swept in as a carrier.
  CITED-OUTSIDE-RANGE
               locations: line 1696 (forward sequence, section 23 area);
               line 1915 (appendix material)
               proposition: mixed-boundary fixtures are owed
               evidence use here: the duplication this disposition rests
               on
               owning tranche: T1S01a6
               a6 must reconcile both copies with this STAY-CANONICAL.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-079

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.3, lines 856-862
  CLAIM        "A change from FRAME to FIELD classification is not a
               region boundary that the filter hopes will behave. It is
               input to a table that creates one explicit boundary type.
               The scheduler performs exactly ONE chosen topology for
               that 16-pixel segment; it never schedules competing
               pitch-1 and pitch-2 hypotheses on the same samples."
  ASSERTS      Why B2 eliminates the old seam ambiguity: classification
               change is table input producing an explicit boundary
               type; per segment exactly one topology is performed;
               competing hypotheses are never scheduled on the same
               samples.
  CLASS        Reasoned, W3X-ratified architecture record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 10.3 - the full
               elimination argument. Known non-canonical copies: section
               0 item 9, line 145 (CARRIER - "The mixed boundary is
               therefore an EXPLICIT EDGE TYPE, not a detector seam",
               settled a3 layer); Project Status lines 548-549 (CARRIER -
               "the mixed-neighbour seam becomes an explicit edge
               type"); Concise Summary lines 223-225 (CARRIER - "the
               mixed-neighbour boundary is an explicit edge type rather
               than a hoped-for seam"); the Re-Decision Evaluation's
               comparison row "mutual exclusion by schedule" (line 669,
               CARRIER of the never-competing-hypotheses limb, compressed).
               THE WORD "SEAM" CARRIES THREE OTHER MEANINGS in this
               corpus, and the sweep classified all of them out
               explicitly rather than silently: see SWEPT.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"seam", "exactly ONE
               (chosen) topology", "competing pitch/hypotheses", "table
               (that creates/input)", "explicit edge type"}. The "seam"
               term returned 81 raw hits in 18 files; every one was
               opened and classified. Carriers are the four named in
               REASON plus the canonical text. The remainder:
                 DIFFERENT, meaning 1 - true compression seams in the
                   threshold-ambiguity argument: Re-Decision Evaluation
                   596-627 and authority 12.5 lines 1023, 1039-1042
                   (IN-RANGE for a5b, owned by LED-091 in a later a5b
                   batch) and Appendix C line 1896 (OUTSIDE RANGE, a6);
                 DIFFERENT, meaning 2 - the OLD separated-field
                   seam-problem framing: Grid Knowledge v1.2 lines 62-67
                   and 130-149 (the superseded-by-authority knowledge
                   model; the PROBLEM this section's proposition answers,
                   not the answer);
                 DIFFERENT, meaning 3 - debug/build vocabulary: charter
                   capability seams (415-766, 2276-2295), the 1B3
                   runtime-guard and session-state documents, the debug
                   module pattern, dispatch explainer, Stage 1C briefs,
                   D0 preface, toolchain findings, and coder introduction
                   line 389 (linker seam) - all test/debug/build seams,
                   unrelated;
                 APPLIES - Re-Decision Brief 79/165 (seam ambiguity as
                   re-decision motivation).
               The scheduler exactly-ONE limb additionally relates to
               section 13.1's schedule/predicate/kernel contract
               (IN-RANGE for a5b, owned by LED-093 in a later a5b batch)
               - related-but-distinct, relationship note owed to LED-093,
               as recorded for LED-071.
  CITED-OUTSIDE-RANGE
               location: Appendix C, line 1896 (threshold-ambiguity
               failure record)
               proposition: threshold seam ambiguity (meaning 1 -
               DIFFERENT from this entry's proposition)
               evidence use here: negative classification only, recorded
               so a6 sees the term was met and excluded
               owning tranche: T1S01a6
  REPAIR-v1_2  (per T1S01a5b_B F7; DEC-50 evidence enumeration)
               The v1.1 SWEPT asserted "81 raw hits in 18 files all
               opened and classified" without printing the population.
               The enumerated result set, reproduced under the declared
               normalisation (case-insensitive, whitespace-normalised
               matching; loci deduplicated per line), every file opened:
                   authority                          5 loci
                   coder introduction v1.37           1
                   AI charter v1.31                  10  (11 raw;
                   Concise Summary v1.8               1   line 757
                   dispatch explainer v1.4            5   twice)
                   debug module pattern v1.1          6
                   Grid Knowledge v1.2                8
                   Project Status v1.35               7
                   1B3 runtime guard v1.3            14
                   1B3 session state v1.0             2
                   Stage 1C 3a briefing v1.2          2
                   Stage 1C 3b resume brief v1.1      1
                   D0 preface v1.14                   1
                   toolchain findings v1.4            1
                   Re-Decision brief v1.0             2
                   Re-Decision evaluation v1.0        6
                   PreScope brief v1.2                2
                   PreScope coder response v1.2       2
                   ------------------------------------
                   18 files, 76 matched loci
               COUNT BASES, stated exactly (T1S01a5b_B v2 F13): the
               table is a LINE-LOCUS table; it sums to 76. Raw substring
               matches number 77 - the charter's line 757 carries the
               term twice. v1.1's "81" was produced in the prior session
               under a probe family whose exact regex basis was not
               recorded; it is NOT reproducible from the stated method
               and is SUPERSEDED by the enumerated basis here rather
               than explained - inventing a basis for it would repeat
               the very defect DEC-50 exists to prevent. Classification
               classes and conclusions are unchanged. W3C independently
               reproduced 18 files / 77 raw / 76 loci.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B v3, 2026-08-22)

--------------------------------------------------------------------------

LED-080

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.4, lines 864-871
  CLAIM        "Current D4-D07 is intentionally conservative: UNKNOWN ->
               leave blockiness unchanged rather than apply a confidently
               wrong geometry that may blur real detail."
  ASSERTS      The UNKNOWN policy and its asymmetric-cost rationale:
               unresolved topology is left unfiltered because residual
               blockiness is the reversible status quo while wrong
               geometry destroys detail.
  CLASS        W3X-ratified decision (D4-D07) with its recorded
               rationale.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home 10.4 for the
               policy-with-rationale statement in the topology
               mathematics. Known non-canonical copies: section 0 item
               9, lines 135 and 143 (CARRIER - settled a3 layer, policy
               without the rationale); section 16, lines 1263-1270
               (CARRIER - the policy AND the same asymmetric-cost
               rationale, OUTSIDE RANGE, a6); Appendix A UNKNOWN entry,
               lines 1781-1784 (CARRIER - policy, OUTSIDE RANGE, a6).
               The Re-Decision Evaluation's UNKNOWN rows (76, 83) are the
               pre-decision "to be measured" state - historical, per
               LED-075/077.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"leave blockiness
               unchanged", "confidently wrong", "blur real detail",
               "intentionally conservative", "no filter ...
               count/increment/diagnos-"}. Hits: authority 10.4 in-range,
               section 0 item 9 (settled a3), section 16 (a6), Appendix A
               (a6) - all opened; Re-Decision Evaluation historical rows
               (76, 83) classified as at LED-075/077; no other file
               matched.
  CITED-OUTSIDE-RANGE
               locations: section 16 (1261-1284); Appendix A (1781-1784)
               proposition: D4-D07 UNKNOWN no-filter policy and rationale
               evidence use here: duplication breadth
               owning tranche: T1S01a6
               a6 must reconcile both copies with this STAY-CANONICAL,
               noting the canonical-home question recorded at LED-081
               DERIVED.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B, 2026-08-21)

--------------------------------------------------------------------------

LED-081   (split under the atomic-claim rule. The map did not pre-flag
           this segment, but its two clauses have different truth
           status, which is the rule's own trigger: one entry cannot
           carry two dispositions.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.4, line 873 (first
               sentence)
  CLAIM        "That is a current policy, not a timeless truth."
  ASSERTS      A status claim: the D4-D07 UNKNOWN policy is provisional,
               not permanent.
  CLASS        Reasoned decision-status record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. The provisionality is carried by
               section 0 item 9 ("current v1 policy" at 135; "revisit
               after Q14" at 143 - settled a3 layer) and, in full, by
               section 16 (lines 1261-1284, OUTSIDE RANGE, a6), whose
               opening "Current D4-D07 remains" and revisit-with-measured-
               inputs list are the fuller statement of the same
               provisionality. STAY-CANONICAL is PROVISIONAL AS THE BODY-
               NARRATIVE HOME, in the same shape as LED-067's register
               question: see DERIVED.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"current policy, not
               a timeless truth", "not a timeless truth", "current v1
               policy", "revisit ... UNKNOWN/policy", "UNKNOWN
               prevalence"}. Hits: authority 873 in-range, section 0 item
               9 (settled a3), section 16 lines 1261-1284 (a6); no other
               file matched.
  CITED-OUTSIDE-RANGE
               location: section 16 (1261-1284)
               proposition: the policy is provisional and will be
               revisited with measured inputs
               evidence use here: duplication breadth AND the open
               canonical-home question
               owning tranche: T1S01a6
  --- WHAT THE DESIGNER INFERRED ---
  DERIVED      A genuine canonical-home question is left to the owning
               tranche, deliberately: whether provisionality-and-revisit
               canonically lives at section 16 (the dedicated UNKNOWN
               POLICY REVISIT section) with 10.4's sentence as narrative,
               or at 10.4 with section 16 as elaboration. a6 owns section
               16 and resolves it; the CITED-OUTSIDE-RANGE record above
               carries the duty.
  DERIVED-BASIS  Tranche boundary (scope 0.6); the LED-067 precedent in
               this same ledger.
  REPAIR-v1_2  (per T1S01a5b_B F8; extends REASON and SWEPT)
               CARRIER ADDED: designer introduction v1.33 line 779 -
               "UNKNOWN-policy revisit using Q14 data" - a current
               orientation document carrying the provisionality/revisit
               proposition. The v1.1 statement "no other file matched" is
               RETRACTED as mechanically false for the declared family:
               the full revisit-family enumeration, every locus opened
               and classified, is printed at LED-081a's repaired SWEPT
               (same family, shared basis) - carriers: authority 143,
               215, 1638 (a3 ground / register a6), intro v1.33:779;
               DIFFERENT: authority 1126, Grid Knowledge 172, D0 preface
               432/551/564/626, Verification-and-Tiering 364. Disposition
               and duplicate-action unchanged.
  TIER         C
  PROPOSED
  ACTION       None here; a6 resolves the home.
  VERDICT      AGREE (T1S01a5b_B v2, 2026-08-22)

--------------------------------------------------------------------------

LED-081a  (reissued at v1.2 per T1S01a5b_B F9: disposition corrected from
           CONFLICTING to SUPERSEDED / ERRONEOUS under DEC-84; mandatory
           PROPAGATION added; the false sweep statement repaired. W3D
           concurs with W3C's correction: sections 15 and 16 are not
           competing policies from which one must prevail - the sentence
           is simply a false internal pointer.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10.4, lines 873-874
               (second sentence). SOURCE TEXT VERBATIM, as Tier A
               requires:
                   "Section 15 requires a revisit after measured UNKNOWN
                    prevalence/error costs are known."
  CLAIM        As above.
  ASSERTS      A cross-reference claim: the revisit requirement lives in
               section 15.
  CLASS        Internal cross-reference (a claim about the document's own
               structure).
  DISPOSITION  SUPERSEDED
  SUPERSEDED-KIND  ERRONEOUS
  REASON       The statement is false as written, verified by reading both
               targets rather than pattern match:
                 SECTION 15 (lines 1157-1260, "D4-Q14 ARCHITECTURE-
                 DISCRIMINATOR EXPERIMENT") contains NO revisit
                 requirement. A semantic sweep of its full range for
                 {revisit, reconsider, re-decide, freeze/freezing,
                 policy} found only measurement outputs - it specifies
                 the experiment that PRODUCES the measured inputs.
                 SECTION 16 (lines 1261-1284) is titled "UNKNOWN POLICY
                 REVISIT" and imposes the requirement in this sentence's
                 own terms: "After D4-Q14, revisit using measured:
                 UNKNOWN prevalence; false-confident rate; ..."
               W3C independently reproduced both readings (T1S01a5b_B
               F9). Under DEC-84 (scope 0.11, ratified exact wording,
               cited not paraphrased): ERRONEOUS is "The statement was
               false, materially misleading, or otherwise invalid in the
               context in which project work may have relied on it." That
               is this case exactly - and project work DID rely on it
               (PROPAGATION below). The v1.1 disposition CONFLICTING was
               wrong: sections 15 and 16 do not present competing
               prevailing statements; there is nothing to prevail over a
               pointer that is simply false. A benign reading ("[the
               experiment of] section 15 necessitates a revisit") exists
               and is recorded; it does not rescue the sentence, whose
               function in a navigable authority is to route the reader,
               and it routes them wrongly.
  CONFLICTS    n/a - reclassified. The defect is error, not conflict.
  PREVAILS     n/a - no prevails question arises for an erroneous pointer;
               section 16 simply IS where the requirement lives.
  SWEPT        Population: 38 files. Family: {"section 15 requires", "not
               a timeless truth", "revisit"} plus the section-15 semantic
               sweep in REASON. The v1.1 statement "Hits outside the
               authority: none" was MECHANICALLY FALSE (the declared
               family includes "revisit") and is REPLACED by the full
               enumeration, every locus opened:
                 authority: 143 (section 0 item 9 "revisit after Q14" -
                   CARRIER of the revisit obligation, settled a3 layer);
                   215 (section 1 open-questions list "UNKNOWN-policy
                   revisit" - CARRIER, settled a3/a5 ground); 873 (the
                   erroneous sentence itself); 1126 (SA/SB ordering
                   "reason to revisit it" - DIFFERENT proposition); 1261,
                   1272 (section 16 - the requirement's actual home, a6);
                   1638 (D4-D07 register "Revisit after Q14" - CARRIER,
                   a6);
                 designer introduction v1.33 line 779 ("UNKNOWN-policy
                   revisit using Q14 data" - CARRIER, current orientation
                   document);
                 Grid Knowledge v1.2 line 172 ("if ever revisited", an
                   FFmpeg-oracle aside - DIFFERENT);
                 D0 Preface v1.14 lines 432, 551, 564, 626 ("do-not-
                   revisit" withdrawn-alternatives vocabulary -
                   DIFFERENT);
                 Verification-and-Tiering v1.11 line 364 ("not revisited",
                   same vocabulary - DIFFERENT).
               No document other than the authority repeats the DEFECTIVE
               POINTER itself; the reliance it seeded is recorded under
               PROPAGATION, which is the correct instrument for it.
  PROPAGATION  REQUIRED FOR ERRONEOUS - executed per DEC-84 scope 0.11,
               steps followed in its exact ratified structure:
               1. DECLARED SCOPE / POPULATION: the 38-file current
                  population (Population Delta v1.1, the population of
                  record for this generation; its 38 files are unchanged
                  from v1.0); the batch-1 T1 process artifacts
                  (Population Delta - the v1.0 issue, which held the
                  faulty routing - and Population and Coverage Map v1.0);
                  the src tree (code reliance check).
               2. SEARCH FOR RELIANCE ON THE PROPOSITION, NOT MERELY ITS
                  WORDING, using the method appropriate to the
                  proposition: the proposition is a ROUTING claim (where
                  the revisit obligation lives), so the search was for
                  every current reference that ROUTES the LED-081/revisit
                  obligation to section 15 - normalised regex over
                  "section 15" and the revisit family, every candidate
                  opened and read for reliance.
               3. CANDIDATES ENUMERATED AND CLASSIFIED:
                    coder blurb v1.7 line 49 - ACTUAL RELIANCE (lists
                      section 15 as the pre-identified LED-081
                      CITED-OUTSIDE-RANGE obligation);
                    designer blurb v1.9 line 40 - ACTUAL RELIANCE (states
                      "LED-081 -> section 15" as the pre-identified
                      obligation);
                    Population Delta v1.0 line 208 - ACTUAL RELIANCE
                      (same routing, T1 process artifact);
                    Population and Coverage Map v1.0 lines 232-234 and
                      332 - ACTUAL RELIANCE (segment note and Part D
                      routing);
                    authority v1.05 line 873 - SOURCE DEFECT / SELF
                      (the erroneous pointer being propagated);
                    authority v1.05 line 1580 - NON-RELIANCE (D4-Q14
                      register row "OPEN - NEXT ARTIFACT, section 15" -
                      a correct reference to section 15 as the
                      experiment's home; opened and read);
                    README v1.12 line 3072 - DIFFERENT / NON-RELIANCE
                      (RFC 6386 section 15: external VP8 loop-filter
                      ordering material; opened and read);
                    README v1.12 line 3289 - DIFFERENT / NON-RELIANCE
                      (RFC 6386 section 15: external VP8 reference-list
                      entry; opened and read);
                      [the v1.2 aggregate "all other references" line is
                      replaced by this occurrence-level list per DEC-84
                      step 3 and T1S01a5b_B v2 F14.2 - its blanket
                      reason was false for the two README candidates];
                    src tree - NONE FOUND (scope: full src/; method: grep
                      for section-15/revisit routing; no kernel exists,
                      identity 0.1.0-dev+5C is pass-through).
               4. EACH ACTUAL DEPENDENCY ROUTED:
                    both blurbs -> NEEDS CORRECTION at the deferred
                      orientation bump round (rides with the Q8/Q9 fixes,
                      W3X-ruled);
                    Population Delta -> CORRECTED THIS GENERATION as
                      v1.1 (issued alongside this ledger);
                    Coverage Map -> NEEDS CORRECTION at the map v1.1
                      bump (W3X commits tree artifacts).
               5. (n/a - dependencies were found.)
               6. NO EXHAUSTIVENESS is claimed beyond the declared
                  scope/method above.
  CITED-OUTSIDE-RANGE
               locations: section 15 (1157-1260) and section 16
               (1261-1284), both read as error evidence
               proposition: where the revisit requirement lives
               evidence use here: the error determination itself
               owning tranche: T1S01a6
               a6, which owns both sections, must confirm this reading
               when it adjudicates them; if a6 finds a revisit
               requirement inside section 15 that both sweeps missed,
               this entry is overturned and the correction below is
               cancelled.
  TIER         A (derived, DEC-62: SUPERSEDED -> A; full W3C review,
               source verbatim included above)
  PROPOSED
  ACTION       One-word correction at the authority's next W3X-ratified
               bump: line 873 "Section 15" -> "Section 16". Nothing else
               changes. Proposal only - the authority is edited by W3X
               ratification, never by the ledger. Both W3C and W3D
               recommend ratifying only after this correction generation
               is accepted.
  VERDICT      AGREE (T1S01a5b_B v3, 2026-08-22)

--------------------------------------------------------------------------

# 2. BATCH SUMMARY - DERIVED BY ENUMERATION FROM THE ENTRIES ABOVE

```text
ENTRIES THIS BATCH: 29 (v1.2's 28 plus LED-066b, added at v1.3)

    LED-064  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-065  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-066  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v4)
    LED-066a CURRENT-UNIQUE     n/a              C   AGREE (B v2)
    LED-066b CURRENT-UNIQUE     n/a              C   AGREE (B v4)
    LED-067  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-067a CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-068  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-069  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-070  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-070a CURRENT-DUPLICATE  POINTER (prov.)  C   AGREE (B)
    LED-070b CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v3)
    LED-071  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-072  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-073  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-073a CURRENT-UNIQUE     n/a              C   AGREE (B v2)
    LED-074  CURRENT-UNIQUE     n/a              C   AGREE (B v2)
    LED-074a CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-074b CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v3)
    LED-075  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-076  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-077  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-078  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-078a CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-078b CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-079  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v3)
    LED-080  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B)
    LED-081  CURRENT-DUPLICATE  STAY-CANONICAL   C   AGREE (B v2)
    LED-081a SUPERSEDED (ERRONEOUS)  n/a         A   AGREE (B v3)

DISPOSITIONS, derived by counting the table: 24 CURRENT-DUPLICATE,
4 CURRENT-UNIQUE (LED-066a, LED-066b, LED-073a, LED-074), 1 SUPERSEDED
with SUPERSEDED-KIND ERRONEOUS (LED-081a), zero CONFLICTING, zero
OPERATIVE-SPEC.
TIERS (derived, DEC-62): 28 C, 1 A (LED-081a).

REVIEW STATE: CLOSED. All 29 entries carry recorded AGREE verdicts -
12 from T1S01a5b_B (2026-08-21), 11 from B v2, 4 from B v3 (LED-070b,
074b, 079, 081a) and 2 from B v4 (LED-066, LED-066b), all 2026-08-22.
Zero DISAGREE, zero UNSURE, zero MISSING, zero open verdict fields. No
further W3C round is requested by W3C or W3D.

REVIEW HISTORY OF THIS BATCH, for anyone auditing how the verdicts were
reached: four rounds, 34 findings raised (F1-F17 plus their sub-items),
every one verified against the corpus before acceptance, and every one
accepted - W3D contested none. Round results: 13/11, 11/5, 4/2, 2/0
(AGREE/DISAGREE). No disposition or tier survived unchallenged by
assertion alone; the two that changed did so on evidence (LED-081a
CONFLICTING -> SUPERSEDED/ERRONEOUS; LED-074's uniqueness narrowed to
the ownership clause). Four entries exist only because review found
uncovered propositions (066a, 070b, 073a, 074b) and three more from
atomicity splits (066b, 067a, 081a).

ON THE NEAR-ZERO TIER-A OUTCOME (twice reviewed, unchallenged): sections
9-10 DESCRIBE rejected architectures; they do not ASSERT them. The
batch's one Tier A (LED-081a) is an erroneous internal cross-reference
under DEC-84 with mandatory propagation executed in the entry. The Grid
Knowledge v1.2 stale-currency conflict is recorded at LED-064/067
(authority prevails; T2 retirement already routed).

CITED-OUTSIDE-RANGE RECORDS CARRIED: 16 - LED-064, 067, 067a, 068, 069,
070, 070a, 070b, 073 (section 9) and LED-078, 078a, 078b, 079, 080, 081,
081a (section 10). The other thirteen entries carry none.

IN-RANGE CROSS-NOTES OWED TO LATER a5b BATCHES (sections 11-13), each to
be reconciled by the named entry when its batch is adjudicated:
    LED-064 -> LED-087            LED-070a -> LED-097 (POINTER condition
    LED-065 -> LED-091                        remains OPEN across batches)
    LED-067 -> LED-086..091       LED-071  -> LED-093 and LED-091
    LED-070 -> LED-093            LED-073  -> LED-082
    LED-073a -> LED-082           LED-079  -> LED-091 and LED-093
    (target confirmation)

IN-BATCH RECONCILIATIONS COMPLETED: LED-070 <-> LED-074a; LED-066 <->
LED-066a <-> LED-066b, LED-073 <-> LED-073a, LED-074 <-> LED-074b
(atomicity splits, recorded in each direction); LED-064/067 and
LED-068/069 heading-occurrence cross-records.

MAP AMENDMENT RECORDED (pending map v1.1, W3X commits tree artifacts):
Part B segments 738-745, 762-785, 796-803 and 806-817 map to
LED-066/066a/066b, LED-070/070a/070b, LED-073/073a and
LED-074/074a/074b respectively; Part D's "LED-081 -> section 15" routing
is corrected to section 16 per DEC-84 propagation.

DEC-84 PROPAGATION (LED-081a, ERRONEOUS): four actual dependencies found
and routed - coder blurb v1.7:49 and designer blurb v1.9:40 (correction
at the deferred orientation bump round), Population Delta v1.0:208
(corrected as Delta v1.1, the population of record), Coverage Map
v1.0:232-234/332 (correction at map v1.1). Candidate list is
occurrence-level at v1.3, including the two README RFC-6386 candidates.
No code/kernel reliance. Full record in the entry.

DECISION MATERIAL FOR W3X, VIA W3C CORRECTION REVIEW 2 FIRST: LED-081a's
one-word authority correction (line 873, "Section 15" -> "Section 16"),
ratifiable at the authority's next W3X-approved bump after this
generation is accepted - W3C and W3D concur on that sequencing.

NOTHING HERE IS RATIFIED. Every PROPOSED ACTION is a proposal awaiting T3
(or, for LED-081a, the authority's next ratified bump).
```

---

*Revision history*

```text
v1.5 (2026-08-22) BATCH 1 CLOSED FOR W3C REVIEW. Adopts W3C's v4 verdict
     stamps (LED-066 and LED-066b AGREE, T1S01a5b_B v4) as the verdicts of
     record; all 29 entries now carry AGREE. Status, review-state and
     summary rewritten to closed form; a four-round review history added
     for auditability. NO adjudication content changed at any entry - the
     reviewed base was verified byte-identical to v1.4 apart from the two
     verdict lines. Returns to W3X for closure; the map v1.1 amendment,
     the orientation bumps and the authority's one-word fix (line 873,
     "Section 15" -> "Section 16") remain unratified and await W3X.
v1.4 (2026-08-22) THIRD CORRECTION GENERATION per W3C correction review
     T1S01a5b_B v3 (4 AGREE / 2 DISAGREE, findings F16-F17), bounded to
     LED-066 and LED-066b. F16/F17: the no-multiply split token is at
     authority line 743, not 741 - v1.3 stated 741 at five sites
     (entry-count note, LED-066 annotation, LED-066 DOCUMENT, LED-066b
     DOCUMENT, LED-066b DERIVED); 741 is the fixed-point item. All five
     corrected. F17: LED-066b's SWEPT said "eleven loci in eight files";
     the enumeration it printed contains seven distinct files - corrected
     to seven, locus set unchanged. Verdicts: LED-070b, LED-074b,
     LED-079 and LED-081a stamped AGREE (v3); LED-066 and LED-066b open
     for correction review 3. No disposition, tier or evidence
     conclusion changed; CURRENT-UNIQUE at LED-066b remains supported on
     W3C's independent rerun.
v1.3 (2026-08-22) SECOND CORRECTION GENERATION per W3C correction review
     T1S01a5b_B v2 (11 AGREE / 5 DISAGREE, findings F10-F15), bounded
     exactly by its section 10. LED-066 re-reissued (Evaluation range now
     includes line 655; the uncarried no-multiply token split to new
     LED-066b, CURRENT-UNIQUE, with a DERIVED wording-scope note).
     LED-070b citation ranges corrected to the lines that carry the
     proposition (1658-1659, 1806-1808) - root cause recorded: v1.2
     cited approximate probe line mappings without opening exact lines.
     LED-074b re-reissued with the declared geometry family actually
     executed (adds Evaluation 257 CARRIER, 701, 793, 804, authority
     861). LED-079 REPAIR count bases fixed (line-locus table sums 76;
     raw 77; v1.1's "81" recorded as unreproducible and superseded, not
     explained). LED-081a PROPAGATION: step-1 current population now
     Delta v1.1; step-3 aggregate replaced by an occurrence-level
     candidate list including the two README RFC-6386 hits. F15: header
     population pointer -> Delta v1.1; 0.1 "without deviation" qualified
     by the four amendment rows. Verdicts: eleven v2 AGREEs stamped; six
     items open for correction review 2. No disposition or tier changed
     except the additions stated.
v1.2 (2026-08-21) CORRECTION GENERATION per W3C review T1S01a5b_B
     (findings F1-F9; 13 AGREE / 11 DISAGREE), bounded exactly by the
     findings' section 16. Reissued whole: LED-066, 067a, 073, 074, 081a.
     New entries: LED-066a, 070b, 073a, 074b (atomicity/coverage). REPAIR
     blocks added: LED-064, 067, 068, 069, 070, 079, 081. Principal
     corrections: LED-081a CONFLICTING -> SUPERSEDED/ERRONEOUS with
     mandatory DEC-84 propagation (four dependencies found and routed);
     line-718/749 status headings recorded as occurrences of LED-067/069;
     line-763 B2 PRIMARY CANDIDATE adjudicated (LED-070b); Grid Knowledge
     v1.2's stale current-knowledge assertions recorded as decided
     conflicts at LED-064/067; LED-066/073/074 atomicised; LED-079's
     DEC-50 enumeration printed; LED-081's sweep completed (intro v1.33
     carrier). Verdict fields: "agreed" entries carry AGREE (T1S01a5b_B);
     reissued/new/repaired entries await correction review. No a5
     reopening; no cross-entry pass.
v1.1 (2026-08-21) Integrates the section-10 entries - LED-074..081 plus
     splits 074a, 078a, 078b and 081a - completing batch 1 coverage of
     lines 716-876, and rewrites header, coverage declaration, overlap
     statement, entry count and summary from single-section form to batch
     form. ALSO CORRECTS the v1.0 emission's cross-note routing, scope
     declared and enumerated per the replacement-declaration rule: ten
     sites across LED-064, LED-065 (two), LED-067, LED-070, LED-070a
     (two), LED-071 and LED-073 (two) described the owning entries
     (LED-082, LED-086..091, LED-087, LED-091, LED-093, LED-097) as
     arriving in this batch's second emission, when those entries in
     fact belong to LATER a5b BATCHES (sections 11-13); and LED-070a's
     provisional-POINTER wording wrongly claimed LED-097 travels in this
     batch. All ten sites now route to "a later a5b batch" and LED-070a's
     condition is restated as cross-batch. NO adjudication outcome
     (disposition, tier, action) changed at any corrected site.
v1.0 (2026-08-21) First issue: batch 1 increment 1 of ~2, section 9
     complete (LED-064..073 plus splits 067a and 070a), adjudicated
     against the 38-file population of Population Delta v1.0 under Review
     Scope v1.15, with the coverage map's Part B segmentation followed
     without deviation.
```
