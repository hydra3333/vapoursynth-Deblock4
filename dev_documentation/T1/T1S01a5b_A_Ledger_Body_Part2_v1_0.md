# Deblock4 - T1S01a5b Adjudication Ledger - Authority Body Part 2

**Deliverable:** T1S01a5b_A - LEDGER BODY PART 2
**Version:** 1.0
**Date:** 2026-08-21
**Author:** W3D
**Status:** ADJUDICATION LEDGER, batch 1, INCREMENT 1 of ~2 (charter
C-DELIV-09). This increment covers SECTION 9 ONLY, authority lines 716-805,
entries LED-064 through LED-073 plus two ratified-rule splits (LED-067a,
LED-070a). Section 10 (LED-074..081) follows as increment 2; the complete
batch-1 package is then re-emitted whole as the artifact of record.
**Binding review scope:** `Deblock4_T1_W3C_Review_Scope_v1_15.md`
**Source:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Population:** the 38-file a5b population declared at
`T1S01a5b_A_Population_Delta_v1_0.md` (which supersedes map A.3).
**Coverage frame:** `T1/T1S01a5b_A_Population_and_Coverage_Map_v1_0.md` Part B.
**Encoding:** US-ASCII; CRLF.

---

# 0. DECLARATIONS THIS INCREMENT MAKES, IN TESTABLE FORM

## 0.1 Coverage declaration (DEC-50 / DEC-56 form)

```text
DECLARED RANGE OF THIS INCREMENT: authority lines 716-805 EXACTLY - section 9
complete. Lines 716-717 (title) and 804-805 (rule + blank) are the map's
recorded NO-PROPOSITION segments; every other line belongs to exactly one
entry below, per the map's Part B segmentation, which this increment follows
without deviation:

    718-726 -> LED-064        757-761 -> LED-069
    727-737 -> LED-065        762-785 -> LED-070 / LED-070a
    738-745 -> LED-066        786-788 -> LED-071
    746-747 -> LED-067 / 067a 789-795 -> LED-072
    748-756 -> LED-068        796-803 -> LED-073

Lines 806-876 (section 10, LED-074..081) are NOT covered by this increment
and are owed by increment 2. No line of 716-805 is unassigned.
```

## 0.2 Overlap statement

```text
No entry below adjudicates any line outside 716-805. Where evidence for a
disposition lies in a5's settled range 223-715, the occurrence is CITED AS
SETTLED a5 GROUND with its location, and is not re-adjudicated. Where
evidence lies in a6's range (sections 14-22, section 24, Appendices A-D),
the entry carries a CITED-OUTSIDE-RANGE record per scope 0.6. Where evidence
lies elsewhere in a5b's own range (sections 10-13), the entry carries an
IN-RANGE CROSS-NOTE naming the owning reserved entry; the two entries are
reconciled when the second is written, and neither is final until both are.
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

ENTRY COUNT OF THIS INCREMENT, DERIVED BY ENUMERATING THE ENTRIES BELOW,
NOT CARRIED FROM A PLAN: 12 (ten map segments, of which two split under the
atomic-claim rule: LED-067/067a and LED-070/070a - both splits were
pre-flagged by the map). There is no target entry count.
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
                                        LED-087 (increment 2 cross-note)
               Appendix C, 1873-1876    CARRIER - OUTSIDE RANGE, see below
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1873-1876
               proposition: A's step-4 primary/midpoint mechanism (history)
               evidence use here: establishes same-file duplication
               owning tranche: T1S01a6
               a6 must reconcile Appendix C's copy with this STAY-CANONICAL
               adjudication of 9.1.
  TIER         C (derived from disposition, DEC-62)
  PROPOSED
  ACTION       None on the authority. The README copies follow their
               existing DEC-07 route; no new action is created here.
  VERDICT      (W3C)

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
                   increment 2 cross-note;
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
                                        owned by LED-091, increment 2
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

--------------------------------------------------------------------------

LED-066

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.1, lines 738-745
  CLAIM        "Good engineering ideas retained from A: creation-time
               fixed-point conversion; immutable threshold sets; no
               float/multiply in the pixel loop; deterministic/stateless
               operation; uncertainty should be measurable and explicit."
  ASSERTS      A retention claim: five named engineering practices survive
               A's rejection and remain adopted project practice.
  CLASS        Reasoned project decision record (a recorded retention, not
               a codec fact).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       The RETENTION claim (that these ideas survive FROM A) is
               true and stated in more than one place. Canonical home 9.1.
               Known non-canonical copy: the Re-Decision Evaluation's final
               recommendation 4, lines 1072-1073 - "RETAIN A's good
               engineering ideas - immutable creation-time threshold sets,
               fixed-point scaling, no hidden state" (CARRIER, a subset of
               the five).
               DISTINCTION HELD DELIBERATELY: the five underlying PRACTICES
               are separately asserted as live rules in their own homes
               (charter E2/G4/F-series; README kernel rules). Those
               assertions are the practices THEMSELVES, not the claim that
               they were retained FROM A, and were classified DIFFERENT.
               This entry adjudicates the retention claim only.
  CONFLICTS    None found.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"retained from A",
               "ideas retained", "creation-time fixed-point", "immutable
               threshold", "no float ... pixel loop", "deterministic ...
               stateless", "uncertainty ... measurable/explicit"}. Files
               with hits, opened and classified:
                 authority (self): 9.1 in-range; section 8 lines 690-696
                   lists REASONING ideas retained from the external
                   research assessment - a DIFFERENT list with a different
                   subject (research reasoning, not A's engineering), in
                   a5's settled range; NOT a carrier;
                 Re-Decision Evaluation: CARRIER (1072-1073); also lines
                   633-654 argue A's determinism/statelessness is not
                   exclusive - APPLIES (uses the ideas, does not state the
                   retention);
                 Re-Decision Brief: APPLIES (164-172 - argues A's virtues
                   during the re-decision; predates the retention);
                 README: DIFFERENT throughout (asserts the practices as
                   live rules: 333, 652-653, 1009, 3373 - not the
                   retention-from-A claim);
                 PreScope coder response line 52: APPLIES.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
                                        owned by LED-086..091, increment 2
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
  TIER         C
  PROPOSED
  ACTION       None here; a6 resolves the register-vs-body home.
  VERDICT      (W3C)

--------------------------------------------------------------------------

LED-067a

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
  REASON       The pointer is duplicated: section 0 item 13 line 185 states
               "Appendix C contains the exact derivation" (settled a3
               summary layer). Appendix C EXISTS at line 1865 as "WHY
               ARCHITECTURE A WAS REJECTED - COMPACT PERMANENT RECORD", so
               the reference is not dangling - but whether its content IS
               "the exact proof", and how it divides the proof labour with
               the IN-RANGE section 12 rejection proof (which section 0
               line 185 also attributes to Appendix C territory), is a6's
               content verification, carried below.
  CONFLICTS    None established at this tranche. A POTENTIAL tension is
               recorded, not asserted: both "Appendix C gives the exact
               proof" (9.1) and the existence of a full in-range rejection
               proof (section 12) are true only if the two proofs are
               distinct or deliberately duplicated; which it is cannot be
               adjudicated without opening Appendix C, which is out of
               range.
  PREVAILS     n/a at this tranche.
  SWEPT        Population: 38 files. Probe family: {"Appendix C",
               "exact proof", "exact derivation", "rejection proof"}.
               Hits: authority self (185, 747, 916 area, 1865, 1964);
               Project Status 460 (APPLIES - narrates 12.5's proof role);
               both blurbs (DIFFERENT - "Appendix C" as an a6 work item,
               process context); PreScope coder response 676 (APPLIES).
               All opened; no external document asserts the Appendix-C
               pointer, so duplication rests on the same-file section 0
               copy - which is sufficient under 5.4a (one concrete
               non-canonical copy, the settled a3 layer at line 185).
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1865 onward
               proposition: Appendix C carries the exact rejection proof
               evidence use here: existence check only (the heading was
               read; the content was NOT adjudicated)
               owning tranche: T1S01a6
               a6 must verify Appendix C's content against this pointer AND
               adjudicate the section-12/Appendix-C proof-division
               question the map pre-flagged.
  TIER         C
  PROPOSED
  ACTION       None until a6 reports.
  VERDICT      (W3C)

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
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
                   increment 2 cross-note; D4-D04/D4-D05 lines 1620-1631 -
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
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
               IN-RANGE and owned by LED-097 (increment 2). This
               duplicate-action is final only when LED-097 confirms 13.5
               as canonical home; if LED-097's adjudication moves the home,
               this entry is reconciled in the same increment - the two
               entries travel to W3C together in the packaged batch.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"side-data/side data
               ... replace/bypass", "trusted ... side data", "map
               contract", "D4-Q13"}. Files with hits, opened and
               classified:
                 authority (self): 9.3 in-range; 13.5 lines 1089-1098
                   (IN-RANGE, LED-097); section 0 item 10's map-producer
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
  VERDICT      (W3C)

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
                   but-distinct - owned by LED-093, increment 2, with this
                   entry's relationship note carried there); 12.5 (IN-
                   RANGE, LED-091);
                 PreScope coder response: CARRIER (518-520);
                 no other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
  VERDICT      (W3C)

--------------------------------------------------------------------------

LED-073

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 9.5, lines 796-803
  CLAIM        "D was created during the re-decision as a better
               detector-free fallback than literal old A. It uses the
               actual whole-frame internal frame edge and avoids A's
               competing pitch-1/pitch-2 union collision. Its exact
               Case-(a) luma topology is in section 11."
  ASSERTS      What D is and why it exists: a detector-free fallback and
               comparator created at the re-decision, superior to literal
               A because it uses the real internal frame edge and has no
               union collision; detailed topology deferred to section 11.
  CLASS        Reasoned, W3X-ratified architecture record (D4-D12 family).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and the most widely duplicated proposition in this
               increment - the map's advance warning held exactly. The 0f
               caution that D's HIGH-LEVEL ROLE and its DETAILED TOPOLOGY
               may have different canonical homes is adopted as the
               adjudication structure: THIS entry homes the ROLE-AND-
               ORIGIN statement at 9.5; the TOPOLOGY's home is section 11,
               owned by LED-082 (increment 2), and the deferral sentence
               at line 803 is an in-range pointer, correct as written.
               Known non-canonical copies of the role statement include:
               the Re-Decision Evaluation section 13, lines 776-780 and
               814-819 (CARRIER - D's role and its superiority-to-A list);
               Project Status lines 25/103/187/549-550 (CARRIER);
               Forward Roadmap line 40 (CARRIER); Concise Summary line 42
               (CARRIER); designer introduction line 66 (CARRIER); coder
               introduction lines 124-125 and 493 (CARRIER); both chat
               blurbs (CARRIER).
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
  OCCURRENCES  9.5 lines 796-803        CANONICAL occurrence (role/origin)
               section 0 item 12, 164-174  CARRIER - settled a3 layer
               section 11, 877-914      the TOPOLOGY, owned by LED-082,
                                        increment 2 - in-range cross-note
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
  VERDICT      (W3C)

--------------------------------------------------------------------------

# 2. INCREMENT SUMMARY - DERIVED BY ENUMERATION FROM THE ENTRIES ABOVE

```text
ENTRIES THIS INCREMENT: 12
    LED-064  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-065  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-066  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-067  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-067a CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-068  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-069  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-070  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-070a CURRENT-DUPLICATE  POINTER (prov.)  C
    LED-071  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-072  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-073  CURRENT-DUPLICATE  STAY-CANONICAL   C

DISPOSITIONS: 12 CURRENT-DUPLICATE; zero CURRENT-UNIQUE; zero CONFLICTING;
zero SUPERSEDED; zero OPERATIVE-SPEC. TIERS (derived, DEC-62): 12 C.

ON THE ZERO-TIER-A OUTCOME AGAINST THE 0f EXPECTATION, stated so it can be
attacked rather than discovered: 0f warned to expect more Tier A because
this half "deliberately contains rejected and superseded material". Section
9 DESCRIBES rejected architectures; it does not ASSERT them. A true
historical statement about a rejected design is CURRENT, not SUPERSEDED,
and nothing in 716-805 contradicts a prevailing document in a way not
already decided (the README's assertions are the decided DEC-07 case,
routed to T1S02, and are recorded in CONFLICTS fields, not converted into
CONFLICTING dispositions of the authority's own true statements). The
Tier-A pressure in this batch, if it comes, is expected at section 12's
rejection-proof mathematics (increment 2) and later at the README's own
adjudication (T1S02) - not here. If W3C reads any section-9 line as an
ASSERTION of rejected design rather than a description of it, that is a
finding and belongs at the top of the response.

CITED-OUTSIDE-RANGE RECORDS CARRIED: 8, derived by enumerating the entries
that carry one: LED-064, 067, 067a, 068, 069, 070, 070a, 073. Entries
LED-065, 066, 071 and 072 carry none - their out-of-body evidence is either
settled a3/a5 ground or in-range cross-notes.

IN-RANGE CROSS-NOTES OWED TO INCREMENT 2: LED-064 -> LED-087;
LED-065 -> LED-091; LED-070 -> LED-093; LED-070a -> LED-097 (home
confirmation, POINTER conditional); LED-071 -> LED-093 and LED-091;
LED-073 -> LED-082. Increment 2 must reconcile each named pair.

NOTHING HERE IS RATIFIED. Every PROPOSED ACTION is a proposal awaiting T3.
```

---

*Revision history*

```text
v1.0 (2026-08-21) First issue: batch 1 increment 1 of ~2, section 9
     complete (LED-064..073 plus splits 067a and 070a), adjudicated against
     the 38-file population of Population Delta v1.0 under Review Scope
     v1.15, with the coverage map's Part B segmentation followed without
     deviation.
```
