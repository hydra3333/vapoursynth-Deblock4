# Deblock4 - T1S01a5b Adjudication Ledger - Authority Body Part 2

**Deliverable:** T1S01a5b_A - LEDGER BODY PART 2
**Version:** 1.1
**Date:** 2026-08-21
**Author:** W3D
**Status:** ADJUDICATION LEDGER, BATCH 1 COMPLETE - authority sections 9
and 10, lines 716-876, reserved entries LED-064 through LED-081 plus six
ratified-rule split entries (LED-067a, 070a, 074a, 078a, 078b, 081a).
Emitted in two increments under charter C-DELIV-09; THIS INTEGRATED
DOCUMENT IS THE ARTIFACT OF RECORD and supersedes the v1.0 increment.
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
DECLARED RANGE OF THIS BATCH: authority lines 716-876 EXACTLY - sections 9
and 10 complete. Lines 716-717 (section-9 title) and 804-805 (rule + blank)
are the map's recorded NO-PROPOSITION segments; every other line belongs to
exactly one entry below, per the map's Part B segmentation, which this batch
follows without deviation:

    SECTION 9                          SECTION 10
    718-726 -> LED-064                 806-817 -> LED-074 / LED-074a
    727-737 -> LED-065                 818-832 -> LED-075
    738-745 -> LED-066                 833-834 -> LED-076
    746-747 -> LED-067 / 067a          835-849 -> LED-077
    748-756 -> LED-068                 850-854 -> LED-078 / 078a / 078b
    757-761 -> LED-069                 855-862 -> LED-079
    762-785 -> LED-070 / LED-070a      863-871 -> LED-080
    786-788 -> LED-071                 872-876 -> LED-081 / LED-081a
    789-795 -> LED-072
    796-803 -> LED-073

No line of 716-876 is unassigned. Lines 877-1098 (sections 11-13,
LED-082..097) belong to LATER a5b BATCHES and are not covered here.
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
CARRIED FROM A PLAN: 24 - eighteen map segments, five of which split under
the atomic-claim rule, adding six entries (LED-067/067a, LED-070/070a,
LED-074/074a, LED-078/078a/078b, LED-081/081a). The 067, 070, 074 and 078
splits were pre-flagged by the map; the 081 split is rule-driven, its two
clauses having different truth status. There is no target entry count.
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
  TIER         C (derived from disposition, DEC-62)
  PROPOSED
  ACTION       None on the authority. The README copies follow their
               existing DEC-07 route; no new action is created here.
  VERDICT      DISAGREE - see W3C findings F2

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
  VERDICT      AGREE

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
  VERDICT      DISAGREE - see W3C findings F3

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
  TIER         C
  PROPOSED
  ACTION       None here; a6 resolves the register-vs-body home.
  VERDICT      DISAGREE - see W3C findings F1/F2

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
  VERDICT      DISAGREE - see W3C findings F4

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
  VERDICT      DISAGREE - see W3C findings F1

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
  VERDICT      AGREE

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
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE - see W3C findings F1

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
               owned by LED-082 (a later a5b batch), and the deferral sentence
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
  VERDICT      DISAGREE - see W3C findings F5

--------------------------------------------------------------------------
LED-074   (split under the atomic-claim rule; map pre-flagged this
           segment. Ownership rule and coalescing condition are distinct
           propositions with different evidence pictures.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 10 preamble, lines 809-816
               (first clause of the descriptor sentence)
  CLAIM        "Let one luma macroblock row begin at M = 16*m. Each
               macroblock occupies a 16-pixel x segment. A horizontal
               boundary descriptor is owned exactly once for each
               half-open x interval [16*n,16*(n+1))"
  ASSERTS      B2's ownership guarantee: for every half-open 16-pixel x
               interval there is exactly one horizontal boundary
               descriptor owner - the constructive exclusion of double
               ownership.
  CLASS        Reasoned, W3X-ratified architecture mathematics (D4-D12
               family).
  DISPOSITION  CURRENT-UNIQUE
  REASON       The exactly-once / half-open ownership formulation is
               stated here and, on the declared search, nowhere else. The
               nearest neighbours are all DIFFERENT propositions and are
               classified in SWEPT: the Evaluation's double-write
               material concerns old A's collision defect and D's
               parity-disjoint writes - the DISEASE and a different cure -
               not B2's per-interval ownership guarantee, which is the
               constructive rule that makes the disease impossible.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Per scope 5.3 this uniqueness claim
               records its family AND reformulations: {"owned exactly
               once", "exactly once for each", "single owner", "one
               owner", "duplicate descriptor", "double-own",
               "no two jobs/descriptors", "half-open"} and the collision
               family {"double-write", "same samples twice/by two",
               "two jobs ... same"}. Every hit opened and classified:
                 authority (self): the in-range sentence (sole CARRIER);
                   Appendix C-adjacent line 1964 "preserves the full A
                   transposition/double-write rejection proof" -
                   DIFFERENT (A's defect, outside range, a6);
                 Re-Decision Evaluation: line 43 (A's operations
                   "overlap and double-write pixels" - DIFFERENT, A's
                   defect); line 115 (D "has no pitch-1/pitch-2
                   double-write collision" - DIFFERENT, D's property);
                   line 447 (D's parity jobs "write disjoint parity
                   rows" - DIFFERENT, D's mechanism); line 664
                   (comparison-table column header "Overlap/double-write"
                   - IDENTIFIER);
                 no other file matched either family.
  TIER         C (derived, DEC-62: CURRENT-UNIQUE -> C)
  PROPOSED
  ACTION       None. The unique statement stays where it is.
  VERDICT      DISAGREE - see W3C findings F6

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  VERDICT      AGREE

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
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE - see W3C findings F7

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
  VERDICT      AGREE

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
  TIER         C
  PROPOSED
  ACTION       None here; a6 resolves the home.
  VERDICT      DISAGREE - see W3C findings F8

--------------------------------------------------------------------------

LED-081a

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
  DISPOSITION  CONFLICTING
  REASON       The sentence conflicts with the document's own structure,
               VERIFIED BY READING BOTH TARGETS rather than pattern
               match:
                 SECTION 15 (lines 1157-1260, "D4-Q14 ARCHITECTURE-
                 DISCRIMINATOR EXPERIMENT") contains NO revisit
                 requirement. A semantic sweep of its full range for
                 {revisit, reconsider, re-decide, freeze/freezing,
                 policy} found only measurement outputs ("predicted
                 state FRAME/FIELD/UNKNOWN", "UNKNOWN rate") - it
                 specifies the experiment that PRODUCES the measured
                 inputs.
                 SECTION 16 (lines 1261-1284) is titled "UNKNOWN POLICY
                 REVISIT" and states the requirement this sentence
                 describes, in this sentence's own terms: "After D4-Q14,
                 revisit using measured: UNKNOWN prevalence;
                 false-confident rate; ..."
               The requirement the sentence points at exists; the
               sentence names the wrong section for it. A benign reading
               exists ("[the experiment of] section 15 necessitates a
               revisit") and is recorded, but as written the sentence
               directs a reader to section 15 for a requirement that
               section 16 imposes - in a document whose stated function
               is to be the single navigable authority, a wrong internal
               pointer is a real defect, not a nicety.
  CONFLICTS    With the authority's own sections 15 and 16 as they stand
               (an internal conflict; both targets read in full range).
  PREVAILS     Section 16. It states the revisit requirement; the 10.4
               sentence mis-names its location and loses.
  SWEPT        Population: 38 files. Probe family: {"section 15 requires",
               "not a timeless truth", "revisit"} with the section-15
               semantic sweep described in REASON run over lines
               1157-1260 in full. Hits outside the authority: none - no
               other document repeats the defective pointer, so the
               defect is singular and the fix is one location.
  CITED-OUTSIDE-RANGE
               locations: section 15 (1157-1260) and section 16
               (1261-1284), both read as conflict evidence
               proposition: where the revisit requirement lives
               evidence use here: the conflict determination itself
               owning tranche: T1S01a6
               a6, which owns both sections, must confirm this reading
               when it adjudicates them; if a6 finds a revisit
               requirement inside section 15 that this sweep missed, this
               entry is overturned and the correction below is cancelled.
  TIER         A (derived, DEC-62: CONFLICTING -> A; full W3C review,
               source verbatim included above)
  PROPOSED
  ACTION       One-word correction at the authority's next W3X-ratified
               bump: line 873 "Section 15" -> "Section 16". Nothing else
               changes. Proposal only - the authority is edited by W3X
               ratification, never by the ledger.
  VERDICT      DISAGREE - see W3C findings F9

--------------------------------------------------------------------------

# 2. BATCH SUMMARY - DERIVED BY ENUMERATION FROM THE ENTRIES ABOVE

```text
ENTRIES THIS BATCH: 24
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
    LED-074  CURRENT-UNIQUE     n/a              C
    LED-074a CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-075  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-076  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-077  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-078  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-078a CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-078b CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-079  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-080  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-081  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-081a CONFLICTING        n/a              A

DISPOSITIONS, derived by counting the table: 22 CURRENT-DUPLICATE,
1 CURRENT-UNIQUE (LED-074), 1 CONFLICTING (LED-081a), zero SUPERSEDED,
zero OPERATIVE-SPEC.
TIERS (derived, DEC-62): 23 C, 1 A (LED-081a - full review, source
verbatim in the entry).

ON THE NEAR-ZERO TIER-A OUTCOME AGAINST THE 0f EXPECTATION, stated so it
can be attacked rather than discovered: 0f warned to expect more Tier A
because this half "deliberately contains rejected and superseded
material". Sections 9-10 DESCRIBE rejected architectures; they do not
ASSERT them. A true historical statement about a rejected design is
CURRENT, not SUPERSEDED, and nothing in 716-876 contradicts a prevailing
document in a way not already decided: the README's live assertions of old
A are the decided DEC-07 case, routed to T1S02 and recorded in CONFLICTS
fields, not converted into dispositions of the authority's own true
statements. The batch's one Tier A (LED-081a) is an internal
cross-reference defect - the revisit requirement attributed to section 15
when section 16 imposes it - found by reading both target sections, not
by pattern match. The larger Tier-A pressure, if it comes, is expected at
section 12's rejection-proof mathematics (a later a5b batch) and at the
README's own adjudication (T1S02). If W3C reads any line of 716-876 as an
ASSERTION of rejected design rather than a description of it, that is a
finding and belongs at the top of the response.

CITED-OUTSIDE-RANGE RECORDS CARRIED: 15, derived by enumerating the
entries that carry one: LED-064, 067, 067a, 068, 069, 070, 070a and 073
(section 9) and LED-078, 078a, 078b, 079, 080, 081 and 081a (section 10).
The other nine entries carry none - their out-of-body evidence is settled
a3/a5 ground, population documents, or in-range cross-notes.

IN-RANGE CROSS-NOTES OWED TO LATER a5b BATCHES (sections 11-13), each to
be reconciled by the named entry when its batch is adjudicated:
    LED-064 -> LED-087            LED-070a -> LED-097 (POINTER condition
    LED-065 -> LED-091                        remains OPEN across batches)
    LED-067 -> LED-086..091       LED-071  -> LED-093 and LED-091
    LED-070 -> LED-093            LED-073  -> LED-082
                                  LED-079  -> LED-091 and LED-093

IN-BATCH RECONCILIATION COMPLETED: LED-070 <-> LED-074a (layer contract
vs coalescing condition; recorded in both entries).

DECISION MATERIAL THIS BATCH SURFACES FOR W3X, VIA W3C REVIEW FIRST:
LED-081a's proposed one-word correction to the authority (line 873,
"Section 15" -> "Section 16") - a proposal only, ratifiable at the
authority's next W3X-approved bump.

NOTHING HERE IS RATIFIED. Every PROPOSED ACTION is a proposal awaiting T3
(or, for LED-081a, the authority's next ratified bump).
```

---

*Revision history*

```text
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
