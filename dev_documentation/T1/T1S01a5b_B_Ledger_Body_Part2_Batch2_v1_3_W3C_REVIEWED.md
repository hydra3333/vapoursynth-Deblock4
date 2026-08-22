# Deblock4 - T1S01a5b BATCH 2 Adjudication Ledger (Part 2, Batch 2)

**Deliverable:** T1S01a5b_A - ADJUDICATION LEDGER, BATCH 2
**Version:** 1.3
**Date:** 2026-08-22
**Author:** W3D
**Status:** ADJUDICATION LEDGER, BATCH 2, FIRST CORRECTION GENERATION per
W3C review T1S01a5b_B Batch2 v1 (10 AGREE / 11 DISAGREE, findings
F18-F28). W3D verified every finding against the corpus at exact lines and
ACCEPTED ALL ELEVEN; none was contested. Covers the FULL BATCH-2 RANGE,
authority lines 877-1098, entries LED-082..097 plus six atomic-claim
splits (LED-082a, LED-091a, LED-091b, LED-092a, LED-097a, LED-097b).
NOTHING HERE IS RATIFIED.

TWO SUBSTANTIVE OUTCOMES, not evidence bookkeeping:
  - LED-091a's CURRENT-UNIQUE claim is OVERTURNED (F23). It is
    CURRENT-DUPLICATE.
  - LED-092 is SPLIT (F25, W3X-ruled). Its README-PROVENANCE limb is
    SUPERSEDED / SUPERSEDED-KIND ERRONEOUS at LED-092a - the second real
    ERRONEOUS case after LED-081a - with DEC-84 propagation executed and
    a proposed authority repair. Its RETENTION limb stands at LED-092.
**Naming note:** batch 1 closed as Ledger_Body_Part2 v1.5. a5b remains ONE
Part-2 ledger for the final cross-entry pass (scope 4.0a), so this document
is Part2_Batch2; at a5b's end an integrated Part 2 is assembled from both
closed batches. W3X may override the naming.
**Binding review scope:** Deblock4_T1_W3C_Review_Scope_v1_15.md
**Population of record:** T1S01a5b_A_Population_Delta_v1_1.md - 38 files.
**Source:** MPEG-2 authority v1.05, section 11, lines 877-914.
**Encoding:** US-ASCII; CRLF.

---

# 0. DECLARATIONS

## 0.1 Coverage declaration (DEC-50 / DEC-56 form)

DECLARED RANGE OF THIS VERSION: authority lines 877-1098 EXACTLY -
sections 11, 12 and 13 complete: THE FULL BATCH-2 RANGE. Every line belongs to exactly one entry or
to one recorded no-proposition segment, per coverage map v1.1's Part B.4
and B.5 segmentation, which these increments follow without deviation:

    INCREMENT 1 - section 11 (877-914)
    877-898 -> LED-082 / LED-082a
    899-902 -> LED-083
    903-909 -> LED-084
    910-914 -> LED-085

    INCREMENT 2 - section 12 (915-1048)
    915-920  -> LED-086
    921-952  -> LED-087
    953-978  -> LED-088
    979-1009 -> LED-089
    1010-1019 -> LED-090
    1020-1046 -> LED-091 / LED-091a / LED-091b
    1047-1048 -> NO-PROPOSITION (separator, recorded with rationale)

    INCREMENT 3 - section 13 (1049-1098)
    1049-1053 -> LED-092 / LED-092a
    1054-1068 -> LED-093
    1069-1074 -> LED-094
    1075-1081 -> LED-095
    1082-1088 -> LED-096
    1089-1098 -> LED-097 / LED-097a / LED-097b (the closing hrule and
                 blank lines 1096-1098 belong to this segment per map
                 B.6)

No line of 877-1098 is unassigned.

## 0.2 Overlap statement

No entry below adjudicates any line outside 877-914. Batch 1 (716-876) is
CLOSED at ledger Part2 v1.5 and is not reopened; where a batch-1 entry
left a cross-note owed to this range, the owing entry below RECONCILES it
and says so. Where evidence lies in a5's settled range (223-715) or the
settled a3 layer, it is cited as settled ground. Where evidence lies in
a6's range (sections 14 onward, Appendices), the entry carries a
CITED-OUTSIDE-RANGE record per scope 0.6. Where evidence lies in this
batch's LATER increments (sections 12-13), the entry carries an in-batch
cross-note naming the owning reserved entry.

## 0.3 Method statement

For every entry: the proposition was declared; a bounded probe family was
declared and run over the 38-file population (normalised, case-insensitive
regex mapped to original line numbers); EVERY hit was OPENED AND READ at
its exact lines before classification (the batch-1 F11 lesson: probe line
mapping locates, it does not cite); occurrences classified CARRIER /
APPLIES / DIFFERENT / IDENTIFIER / NOISE with MIXED where needed. Counts
below are derived by enumeration, never remembered.

ENTRY COUNT OF THIS VERSION, DERIVED BY ENUMERATING THE ENTRIES BELOW,
NOT CARRIED FROM A PLAN: 22 - sixteen map segments, four of which carry
atomic-claim splits (LED-082/082a; the THREE-WAY splits LED-091/091a/091b
and LED-097/097a/097b; and LED-092/092a, added at v1.3 per F25 and NOT
pre-flagged by the map or by W3D), plus one recorded no-proposition
segment. There is no target entry count. The map reserved SIXTEEN entries
for sections 11-13 and adjudication produced TWENTY-TWO; the
planning-figures caution holds again, and the extra entry came from
review, not from authoring - as four of batch 1's did.

---

# 1. THE ENTRIES

--------------------------------------------------------------------------

LED-082   (split under the atomic-claim rule; map pre-flagged this
           segment: the experiment-candidate status sentence is a status
           claim separable from the geometry contract.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 11, lines 878-896 THROUGH
               THE CLAUSE "use a conservative local activation policy"
               (the heading and the Case-(a) topology contract). The
               remainder of line 896 from "an A-derived" onward, plus
               897, is LED-082a. BOUNDARY CORRECTED AT v1.3 per F18: v1.2
               said 878-895 while its own CLAIM quoted the 896 clause.
               Line 896 carries BOTH propositions, so this is a mid-line
               token split, declared in the form used at LED-066b.
  CLAIM        "For Case-(a) luma: VERTICAL: x = 8*k, geometry-invariant,
               process normally. HORIZONTAL MACROBLOCK-ROW BOUNDARY:
               e = 16*k, always process the two field-compatible pitch-2
               parity edges: e, s=2; e+1, s=2. HORIZONTAL INTERNAL
               CANDIDATE: e = 16*k + 8, one actual pitch-1 candidate,
               s=1, use a conservative local activation policy"
  ASSERTS      D's exact Case-(a) luma topology contract: invariant
               vertical edges; always-both pitch-2 parity edges at row
               boundaries; one true pitch-1 internal candidate under
               conservative activation.
  CLASS        Reasoned, W3X-ratified architecture mathematics (D4-D12
               family), resting on spec-verified DCT organisation.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: SECTION 11 - settled
               by construction in batch 1: LED-073 homes D's ROLE at 9.5
               and defers the TOPOLOGY here; this entry is the other half
               of that division. TWO BATCH-1 RECONCILIATIONS ARE
               DISCHARGED HERE: (1) LED-073's cross-note - the
               role/topology division is CONFIRMED, each home carrying
               its own proposition; (2) LED-073a's pointer-target
               confirmation - section 11 DOES carry the exact Case-(a)
               luma topology the line-803 pointer promises, verified by
               this entry's own source reading. Known non-canonical
               copies, opened at their exact lines: section 0 item 12,
               lines 166-172 (CARRIER - the settled a3 compressed form:
               vertical x = 8*k / always two pitch-2 parity edges / one
               TRUE pitch-1 candidate tested conservatively); the
               Re-Decision Evaluation lines 98-108 (CARRIER - the
               originating D proposal, same three-limb contract) and its
               D-analysis restatements at 244-248 and 764-766 (CARRIER,
               secondary - vertical limb); section 0 item 5, lines
               105-111 and the section 2 correction record at 330-332
               (settled a3/a5 ground for the VERTICAL-invariance limb,
               cited not re-adjudicated).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files (Population Delta v1.1). Probe
               family: {"x = 8*k", "e = 16*k", "16*k + 8", "parity
               edges", "field-compatible", "conservative local
               activation"}. 31 raw hits in 2 files plus settled-ground
               self-occurrences, every locus opened at its exact lines:
                 authority: 884-896 (canonical, in-range); 105-111,
                   166-172, 330-332 (settled a3/a5, per REASON); 483 and
                   507 (section 4's field-case and vertical geometry -
                   settled a5 ground, the GENERAL geometry, cited);
                   936-937 (section 12.1's literal-A candidate formulae -
                   IN-BATCH, owed to LED-087, increment 2: same lattice
                   notation, DIFFERENT proposition - A's candidates, not
                   D's contract);
                 Re-Decision Evaluation: 98-108 (CARRIER); 244-248,
                   764-766 (CARRIER, secondary); 786, 791-800, 802-809
                   (CARRIER - ADDED AT v1.3 per F18: a further material
                   occurrence of the D topology contract in the
                   Evaluation's D section, which v1.2's sweep did not
                   enumerate); 268, 290, 325, 328
                   (A-analysis projections - DIFFERENT, A's geometry);
                   460-466 (A's faithful union at e = 16*k - DIFFERENT);
                 no other file matched.
  TIER         C (derived, DEC-62: CURRENT-DUPLICATE -> C)
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23)

--------------------------------------------------------------------------

LED-082a

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 11, lines 896-897 (the
               final clause of the internal-candidate block)
  CLAIM        "an A-derived alpha/beta threshold scale is an experiment
               candidate, not yet a public parameter"
  ASSERTS      A status claim: the A-derived threshold-scaling idea is an
               EXPERIMENT CANDIDATE for D's internal-candidate gating -
               explicitly not (yet) a public parameter.
  CLASS        Reasoned decision-status record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 11, with the
               contract the status attaches to. Known non-canonical
               copies, opened at their exact lines: section 0 item 12,
               lines 169-171 (CARRIER - "an A-derived threshold-scaling
               IDEA may be measured here", the settled a3 compressed
               form; its "may be measured" carries experiment-candidate
               status, and "IDEA" - as against parameter - carries the
               not-public limb in compressed form, recorded as such
               rather than claimed as a verbatim match); Re-Decision
               Evaluation line 108 (CARRIER - "optionally gated with the
               old midpoint alpha/beta scaling idea", the pre-decision
               originating form). Related occurrences classified out:
               the Re-Decision Brief lines 54-59 DESCRIBE what
               midpoint_threshold_scale IS in old A (APPLIES - the
               mechanism this status claim borrows, not its D status);
               Appendix C line 1877 records A's creation-time scaling
               (OUTSIDE RANGE, a6 - A's machinery history, DIFFERENT);
               Evaluation 552 (A-analysis flicker argument - DIFFERENT).
               IN-BATCH CROSS-NOTE: section 12.5 (1020-1046, LED-091,
               increment 2) carries the two specific
               midpoint_threshold_scale claims (not-a-safety-proof,
               not-soft-confidence) - RELATED BUT DISTINCT propositions;
               LED-091 owes this entry a reconciliation note on
               adjudication.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"experiment
               candidate", "not (yet) a public parameter", "alpha/beta
               ... scale/threshold", "threshold-scale ...
               experiment/candidate"}. Six loci in three files, every one
               opened at its exact lines: authority 896-897 (canonical),
               1877 (a6, DIFFERENT per REASON); Evaluation 108 (CARRIER),
               552 (DIFFERENT); Brief 54-59 (APPLIES); section 0 item 12
               169-171 found by the family's scale-idea limb (CARRIER);
               register D4-Q05 1541-1544 (CARRIER, added at v1.3 per
               F19 - the v1.2 "no other file matched" statement was
               wrong and is withdrawn). No other file matched.
  CITED-OUTSIDE-RANGE
               locations: Appendix C, line 1877; register D4-Q05, lines
               1541-1544
               propositions: (Appendix C) A's midpoint alpha/beta scaled
               once at creation - A machinery history; (D4-Q05) "A
               threshold-scaling IDEA may be measured for D's single
               uncertain internal candidate, but the old parameter/name
               has no automatic right to survive"
               evidence use here: Appendix C is a NEGATIVE
               classification, DIFFERENT from this entry's proposition.
               D4-Q05 is a CARRIER - ADDED AT v1.3 per F19: it states
               both limbs of this entry (measurable idea; not a public
               parameter) in register form, and v1.2 wrongly recorded
               that no further match existed.
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F29)

--------------------------------------------------------------------------

LED-083

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 11, lines 900-902
  CLAIM        "D is exact for field/field macroblock-row boundaries and
               naturally conservative for mixed boundaries. It is
               approximate for frame/frame macroblock-row boundaries
               because the true topology there is one pitch-1 edge."
  ASSERTS      D's exactness characterisation over the three resolved
               boundary classes: exact / naturally conservative /
               approximate, with the frame/frame reason stated.
  CLASS        Reasoned, W3X-ratified architecture mathematics.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 11, where the
               characterisation completes the contract. Known
               non-canonical copies, opened at their exact lines: the
               Re-Decision Evaluation lines 811-812 (CARRIER - "This is
               exact for field/field and the natural conservative/mixed
               form for a mixed boundary. It approximates a frame/frame
               boundary." - the originating form, near-verbatim); section
               0 item 12, lines 172-174 (CARRIER of the frame/frame
               approximation limb WITH its reason - "Its known
               approximation is FRAME/FRAME macroblock-row boundaries: it
               uses the conservative pitch-2 pair instead of the exact
               pitch-1 frame edge" - settled a3 layer; the exact-for-
               field/field and conservative-for-mixed limbs are not
               separately restated there, which is compression, not
               conflict).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"exact for
               field/field", "conservative for mixed", "approximate for
               frame/frame", "naturally conservative"}, WIDENED AT v1.3
               per F20 with {"pitch-2 ... instead of ... pitch-1",
               "frame/frame ... approximat-"}: authority 900-901
               (canonical); Evaluation 811-812 (CARRIER); Evaluation
               117-119 (CARRIER - ADDED AT v1.3: states the
               pitch-2-conservative versus exact-pitch-1 FRAME/FRAME
               approximation directly); Evaluation 670 (CARRIER - ADDED
               AT v1.3: the comparison table records the same D main
               risk). The section 0 item 12 copy was found via the
               family's approximation limb and is classified in REASON.
               The v1.3 additions are required for CONSISTENCY: v1.2
               already accepted a single-limb approximation restatement
               as a CARRIER, so equivalent occurrences must be treated
               the same way.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F30)

--------------------------------------------------------------------------

LED-084

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 11, lines 904-909
  CLAIM        "D therefore has no classifier failure mode but does have
               two measurable quality risks: 1. false activation at the
               internal pitch-1 candidate in a FIELD macroblock;
               2. quality difference from using pitch-2 rather than exact
               pitch-1 at a FRAME/FRAME macroblock-row boundary."
  ASSERTS      Three limbs sharing one disposition: D has no classifier
               failure mode; risk 1 is internal false activation in FIELD
               macroblocks; risk 2 is the pitch-2-for-pitch-1 quality
               difference at FRAME/FRAME row boundaries.
  CLASS        Reasoned, W3X-ratified risk record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated PER LIMB, with each limb's carrier
               opened at its exact lines - the limbs are not split
               because every limb shares the same disposition, tier and
               action (the batch-1 lesson cuts the other way here: split
               where evidence status DIFFERS, not merely where clauses
               exist):
                 no-classifier-failure limb: Re-Decision Brief lines
                   78-82 (CARRIER - "no seams, no temporal flicker, no
                   classifier failure on static field-coded content",
                   the pre-decision D description) and section 0 item 12
                   line 172 (CARRIER, compressed - "D is deterministic
                   and has no UNKNOWN state");
                 risk 1: authority section 15's ground-truth category
                   list, line 1214 - "false internal candidates in FIELD
                   macroblocks" (CARRIER, OUTSIDE RANGE, a6: the Q14
                   specification measures exactly this risk; carried
                   below);
                 risk 2: section 0 item 12 lines 172-174 (CARRIER, with
                   reason) and the Evaluation lines 811-812 (CARRIER,
                   via the approximation characterisation adjudicated at
                   LED-083 - the risk is the characterisation's quality
                   consequence, and the two entries cross-reference
                   rather than double-count).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"no classifier
               failure", "classifier failure mode", "false activation",
               "internal ... FIELD macroblock", "measurable quality
               risk", "pitch-2 rather than", "quality difference from
               using"}. Every locus opened at its exact lines:
                 authority: 904-908 (canonical); 1214 (a6, CARRIER of
                   risk 1's measurement category); 1224-1225 (a6,
                   CARRIER of RISK 2 - ADDED AT v1.3 per F21: it requires
                   measurement of D's pitch-2 treatment versus exact
                   pitch-1 on FRAME/FRAME boundaries); 1221 (a6 -
                   viability/ROC framing, APPLIES);
                 Re-Decision Brief: 78-82 (CARRIER, lead limb);
                 Re-Decision Evaluation: 670 and 1041-1043 (CARRIER -
                   ADDED AT v1.3 per F21: both state the frame/frame
                   approximation and false-internal-activation costs);
                   527 (A2 - "false activation:
                   the strongest argument against A" - DIFFERENT: A's
                   false-activation defect, the disease; this entry's
                   risk 1 is D's residual exposure, a different
                   proposition); 811-812 (CARRIER, risk 2, per REASON);
                 no other file matched.
  CITED-OUTSIDE-RANGE
               locations: section 15 ground-truth categories, line 1214;
               section 15 measurement requirements, lines 1224-1225
               propositions: (1214) false internal candidates in FIELD
               macroblocks are a measured category; (1224-1225) D's
               pitch-2 treatment versus exact pitch-1 at FRAME/FRAME
               boundaries must be measured
               evidence use here: duplication of risk 1 and, added at
               v1.3 per F21, of risk 2
               owning tranche: T1S01a6
               a6 must reconcile the Q14 category list with this
               STAY-CANONICAL when it adjudicates section 15.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F31)

--------------------------------------------------------------------------

LED-085

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 11, lines 911-912
  CLAIM        "D must earn viability; it is not an automatic fallback
               simply because it is simpler."
  ASSERTS      D's viability is contingent: it must be earned against
               criteria, never inherited from simplicity or from B2's
               failure.
  CLASS        W3X-ratified decision-status record (the not-forced-binary
               family).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and among the most widely duplicated status
               propositions in the corpus - the viability-contingency
               family. Canonical home: section 11, the D-specific
               statement beside D's own contract. Known non-canonical
               copies, opened at their exact lines: section 1 item 16,
               lines 202-207 (CARRIER - the W3X-RATIFIED
               not-forced-binary rule with predeclared viability
               criteria, settled a3 ground); Concise Summary line 56
               (CARRIER - "must meet its own separate viability bar");
               Forward Roadmap lines 41-42 and 116-118 (CARRIER - "D may
               advance only if viable"); coder blurb lines 213-216 and
               designer blurb lines 161-162 (CARRIER - orientation
               statements of the same rule); designer introduction lines
               71-72 area and coder introduction 126-127 (CARRIER -
               orientation); authority section 14/15 lines 1246-1249 and
               section 23 lines 1668-1672, the register row 1596, and
               the authority revision record lines 1971-1972 (CARRIER -
               ADDED AT v1.3 per F22: it states that D is not a forced
               fallback if it also fails its viability criteria) - all
               OUTSIDE RANGE, a6, carried below.
               Classified out: Project Status line 53 ("the record that
               matters for viability" - process-viability of the
               adjudication, DIFFERENT) and line 83 (W3X's
               project-viability decision point - DIFFERENT); PreScope
               coder response line 537 ("forced binary phase" label -
               DIFFERENT: a classifier-output framing, not the
               architecture gate); Evaluation 822-823 ("the honest
               fallback if B2 does not earn its detector" - RELATED but
               a different subject: B2 earning its detector; classified
               DIFFERENT, recorded so nobody counts it as this claim).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"earn viability",
               "must earn", "automatic fallback", "simply because it is
               simpler"} plus reformulations {"forced binary", "neither
               B2 nor D", "viab-", "prove itself", "not the default"}.
               46 raw hits in 9 files, every locus opened at its exact
               lines and classified per REASON; the only non-carrier
               non-DIFFERENT case is README 3074 ("must earn its place
               on quality evidence" - Schedule B's gate, DIFFERENT
               subject).
  CITED-OUTSIDE-RANGE
               locations: sections 14/15 (1246-1249), section 23
               (1668-1672), register row 1596, revision record
               (1971-1972, added at v1.3)
               proposition: predeclared viability criteria gate both B2
               and D; nothing advances without meeting them
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23)

--------------------------------------------------------------------------


LED-086

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12, lines 916-920 (heading
               and purpose paragraph)
  CLAIM        "This section is intentionally detailed because the old A
               design was once ratified and must not be accidentally
               rediscovered as 'forgotten good design' without the reason
               it was rejected."
  ASSERTS      A rationale claim: section 12's detail is deliberate, and
               its purpose is to prevent A's accidental rediscovery as
               forgotten good design divorced from its rejection reason.
  CLASS        Reasoned process/record rationale.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated in compressed form. Canonical home:
               section 12, where the detail it justifies actually lives.
               Known non-canonical copy, opened at its exact lines:
               Appendix C, lines 1865-1871 - its title is "WHY
               ARCHITECTURE A WAS REJECTED - COMPACT PERMANENT RECORD" and
               its Trigger paragraph records that the old README design
               RESURFACED after an architecture had already been chosen
               (CARRIER, compressed: the permanent-record purpose and the
               resurfacing hazard are both present, though the specific
               "forgotten good design" injunction is worded only in
               section 12; recorded as a wording difference, not claimed
               as a verbatim match). Classified out, each opened:
               register line 1751 (R9's description - the resurfacing as
               bibliographic fact, IDENTIFIER); Re-Decision Evaluation
               line 1051 ("the resurfaced README architecture is
               valuable" - DIFFERENT, a value judgement not a
               record-keeping rationale); Stage 1C line 17 ("stable
               source obligations once ratified" - DIFFERENT subject,
               matched only on "once ratified").
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"forgotten good
               design", "once ratified", "intentionally detailed",
               "rediscovered as", "not be accidentally rediscovered"}
               plus reformulations {"resurfac-", "permanent record",
               "why ... was rejected", "compact permanent", "good
               design"}. 12 loci across 5 files, every one opened at its
               exact lines and classified above or in REASON.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1865-1871
               proposition: A's rejection is kept as a compact permanent
               record, triggered by the design resurfacing
               evidence use here: duplication of the rationale
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-087

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.1, lines 922-952
  CLAIM        Old A tested separated-field candidate rows r = 4*j
               (primary r = 8*k, midpoint r = 8*k + 4); mapping to frame
               rows by e = 2*r + p gives all literal-A candidates
               e = 8*j + p at s=2, primary e = 16*k + p, midpoint
               e = 16*k + 8 + p; the p=0 sequence is 8,16,24,32,... and
               the p=1 sequence is 9,17,25,33,...; "Every literal-A
               operation is pitch 2."
  ASSERTS      The literal transposition mathematics of old A into
               whole-frame coordinates, with the closing invariant that
               every resulting operation is pitch 2.
  CLASS        Derived mathematics on a stated mapping (e = 2*r + p),
               W3X-ratified.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 12.1 - the
               full derivation with both parity sequences. Known
               non-canonical copies, opened at their exact lines:
               Re-Decision Evaluation lines 311-316 (CARRIER - the same
               primary/midpoint field rows and the same e = 2*r + p
               mapping, the originating derivation), lines 344-346
               (CARRIER - the modular restatement "midpoint: e mod 16 ==
               8+p" and "Every one of these literal-A operations uses
               pitch 2"), lines 397-400 (CARRIER - the per-16-row
               candidate enumeration e = 8,16 and e = 9,17); Appendix C
               lines 1880-1883 (CARRIER, compressed - "field row r ->
               frame row 2r+p; literal A becomes e=8j+p, always pitch 2;
               primary e=16k+p; midpoint e=16k+8+p", OUTSIDE RANGE,
               carried below).
               IN-BATCH RECONCILIATION DISCHARGED: LED-082's cross-note
               on authority lines 936-937. Those lines are IN THIS
               ENTRY'S RANGE and state A's candidate lattice; they use
               the same 16*k / 16*k + 8 notation as D's contract at
               LED-082 but assert a DIFFERENT proposition - A's parity-
               projected candidates at pitch 2, not D's topology. No
               collision between the two entries; the shared notation is
               coincidence of lattice, not of claim.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"e = 2*r + p",
               "r = 4*j", "r = 8*k", "8*j + p", "literal-A", "every
               literal-A operation", "all literal-A candidates"}. 24 loci
               in 2 files, every one opened at its exact lines: authority
               927-952 (canonical, in-range), 964 and 976 (section 12.2,
               IN-RANGE, adjudicated at LED-088), 1013 (section 12.4,
               IN-RANGE, LED-090), 1882-1883 (Appendix C, CARRIER);
               Evaluation 313-316, 344-346, 397-400 (CARRIER), 350, 365,
               412, 453, 676, 1045, 1067 (A-analysis context - APPLIES,
               using the transposition rather than stating it). No other
               file matched.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1880-1883
               proposition: the whole-frame transposition of literal A
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-088

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.2, lines 954-978
  CLAIM        The actual frame-DCT edge at e=8, s=1 reads 5,6,7 | 8,9,10
               and writes 6,7,8,9; literal A instead schedules an even
               projection (e=8, s=2, reads 2,4,6 | 8,10,12, writes
               4,6,8,10) and an odd projection (e=9, s=2, reads
               3,5,7 | 9,11,13, writes 5,7,9,11); "Neither projection
               filters the actual adjacent p0/q0 pair 7/8. Therefore
               literal A is not a faithful coordinate transposition of
               the whole-frame frame-DCT edge. It is a different
               filtering algorithm."
  ASSERTS      A worked counterexample and its conclusion: literal A
               misses the true adjacent pair, so it is a DIFFERENT
               ALGORITHM, not a transposition.
  CLASS        Derived mathematics (worked counterexample), W3X-ratified.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 12.2 - the
               complete counterexample with both projections and the
               conclusion. Known non-canonical copies, opened at their
               exact lines: Re-Decision Evaluation lines 359-379 (CARRIER
               - the same actual edge, the same two projections, and
               "Neither projected operation contains the actual adjacent
               p0/q0 pair 7/8", with an additional footprint-width
               observation the authority does not carry); Appendix C
               lines 1885-1888 (CARRIER, compressed - "Failure 1 - wrong
               frame-DCT footprint", with the same read sets, OUTSIDE
               RANGE, carried below); Re-Decision Brief lines 141-146
               (APPLIES - W3D's originating question T4 identifying the
               7/8 versus 14/16 and 15/17 positions as nearby but not
               identical; the question this entry's mathematics answers,
               not a statement of the answer).
               Classified out: Project Status line 1804 (revision-history
               text matched on a numeric coincidence - NOISE).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"e = 8, s = 1", "even
               projection", "odd projection", "7/8", "faithful
               coordinate transposition", "different filtering
               algorithm", "not a faithful"}. 11 loci in 4 files, every
               one opened at its exact lines and classified above.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1885-1888
               proposition: Failure 1, the wrong frame-DCT footprint
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-089

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.3, lines 980-1009
  CLAIM        At e=16 a faithful union schedules frame hypothesis F
               (e=16, s=1, W1(16) = {14,15,16,17}), even-field hypothesis
               E (e=16, s=2, W2(16) = {12,14,16,18}) and odd-field
               hypothesis O (e=17, s=2, W2(17) = {13,15,17,19}); the
               overlaps are F intersect E = {14,16} and F intersect O =
               {15,17}; every frame-edge output pixel can also be written
               by one field hypothesis if both activate, read footprints
               overlap too, so canonical order changes later
               decisions/output; therefore "test the union and let the
               local edge gate decide" no longer defines a simple
               candidate superset - "it creates a new double-filter
               algorithm requiring mutual exclusion, competition or a
               composite kernel. The architecture was rejected rather
               than silently inventing that algorithm."
  ASSERTS      The collision proof and its architectural consequence: the
               faithful union is not a superset but a NEW algorithm, and
               rejection was chosen over silent invention.
  CLASS        Derived mathematics with a ratified architectural
               consequence.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 12.3 - the
               only place carrying the explicit write sets AND both
               intersections AND the consequence. Known non-canonical
               copies, opened at their exact lines: Appendix C lines
               1890-1894 (CARRIER, compressed - "Failure 2 - faithful
               real-geometry union collides: at e=16 the pitch1 write set
               {14,15,16,17} overlaps both pitch2 parity write sets
               {12,14,16,18} and {13,15,17,19}; ordering/double filtering
               becomes a new algorithm", OUTSIDE RANGE, carried below);
               section 0 item 13, lines 182-185 (CARRIER, compressed -
               "a faithful union of both real geometries creates
               overlapping/double-written operations at macroblock-row
               boundaries", settled a3 ground); Re-Decision Evaluation
               lines 458-466 and 486-491 (CARRIER - the union enumeration
               and the four escape routes: mutual exclusion, hypothesis
               competition, a new composite mixed-geometry kernel, or an
               explicit ordering whose double filtering is itself the new
               algorithm), line 730 (APPLIES - the SIMD consequence),
               line 667 (APPLIES - the comparison-table row recording
               collision YES at macroblock boundaries).
               Classified out, each opened: Evaluation line 453 ("W3D's
               feared pitch-1/pitch-2 collision does not occur in literal
               A") - DIFFERENT and worth recording explicitly, because it
               concerns LITERAL A, which never schedules the true pitch-1
               edge, whereas this entry concerns the FAITHFUL UNION,
               which does; the two must not be conflated. D2 Real
               Schedule lines 382 and 393 - NOISE (threshold-table
               numerals matched by digit coincidence).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"W1(16)", "W2(16)",
               "W2(17)", "14,16", "15,17", "double-filter", "mutual
               exclusion", "union and let the local edge gate", "faithful
               union"}. 22 loci in 4 files plus the section-0 copy found
               by the union limb, every one opened at its exact lines and
               classified above.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1890-1894
               proposition: Failure 2, the faithful union collision
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-090

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.4, lines 1011-1019
  CLAIM        "Per 16 frame rows, literal A performs four pitch-2
               horizontal operations (two parities at two candidate
               positions) whereas the true FRAME or FIELD geometry needs
               two horizontal operations. Its basic horizontal candidate
               cost is therefore about 2x before activation rejection. A
               faithful actual-geometry union likewise contains four
               hypotheses for two true operations in a pure FRAME or pure
               FIELD region."
  ASSERTS      The candidate-count cost result: 4-for-2 in both literal A
               and the faithful union, about 2x before activation
               rejection.
  CLASS        Derived arithmetic on the transposition, W3X-ratified.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 12.4, which
               carries BOTH cost limbs (literal A and faithful union) in
               one place. Known non-canonical copies, opened at their
               exact lines: Re-Decision Evaluation lines 397-404 (CARRIER
               of the literal-A limb - "= four pitch-2 operations" and "A
               correct geometry uses two horizontal operations per 16
               rows"), line 412 (CARRIER - "roughly 2x the
               horizontal-edge operations either way"), lines 433-436
               (CARRIER of the faithful-union limb - "= four operations
               for two true operations", "a faithful union is also 2x").
               Recorded as an evidence-completeness note, not a defect:
               the Evaluation's line 414-415 addendum (in a pure
               field-DCT region two of A's four operations are genuine
               false midpoint candidates: 50%) is NOT carried by the
               authority. It is an additional consequence, not a
               contradiction; it belongs to the false-activation family
               and is adjudicated at LED-091, not here.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"four pitch-2", "four
               hypotheses", "2x before activation", "candidate-count
               cost", "two horizontal operations"}. Seven loci in two
               files, every one opened at its exact lines: authority
               1011-1018 (canonical, in-range); Evaluation 402 and 404
               (CARRIER), with 412 and 433-436 reached through the same
               family's cost limb and classified above. No other file
               matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-091   (split under the atomic-claim rule; the map pre-flagged this
           segment. The split is THREE-WAY and is driven by DIFFERING
           EVIDENCE STATUS, not merely by the presence of separable
           clauses - the batch-1 LED-066/066b lesson applied
           deliberately: one limb of this segment has NO external
           carrier and would have been proved by a subset carrier had
           the segment stayed whole.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.5, lines 1021-1042 (the
               general limit; the two midpoint_threshold_scale claims at
               1044-1046 are LED-091a and LED-091b)
  CLAIM        For a harmless non-block step and a true compression seam
               presenting the same local samples (p2,p1,p0 = A,A,A;
               q0,q1,q2 = A+d,A+d,A+d) side activity is zero and a
               canonical boundary-vs-side-activity gate reduces to
               "d < alpha_candidate and side-flatness tests pass"; "No
               threshold can distinguish two different causes that
               generate the identical sample tuple. Lowering the
               candidate threshold trades false positives for weak seam
               misses; raising it trades the other way. Threshold scaling
               can tune the trade, not eliminate it."
  ASSERTS      The in-principle local false-activation limit: identical
               sample tuples from different causes are not
               threshold-separable, and scaling tunes the trade rather
               than eliminating it.
  CLASS        Reasoned in-principle argument on a constructed identical
               tuple, W3X-ratified.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: section 12.5, which
               carries the constructed tuple, the reduced gate condition
               and the two-way trade in one place. Known non-canonical
               copies, opened at their exact lines: Re-Decision
               Evaluation lines 596-604 (CARRIER, originating - "No local
               threshold can distinguish two physically different causes
               that produce the same pixel footprint", followed by "That
               is the irreducible A tradeoff" with the two-way
               lower-scale/higher-scale trade spelled out); Appendix C
               lines 1896-1898 (CARRIER, compressed - "Failure 3 -
               threshold ambiguity is irreducible: identical local pixel
               tuples can represent a true weak seam or harmless picture
               detail; no local threshold can distinguish identical
               observations", OUTSIDE RANGE, carried below); section 0
               item 13, line 185 (CARRIER, compressed - "Its
               local-threshold false-activation tradeoff is also
               irreducible in principle", settled a3 ground).
               Classified out, opened: Re-Decision Brief lines 178-182
               (APPLIES - W3D's originating question, whether
               midpoint_threshold_scale is a sufficient control "or is it
               a knob that merely trades one failure for another"; the
               question, not the finding); Toolchain Findings v1.4 line
               216 and its F6 Addendum line 25 (DIFFERENT - VapourSynth
               cannot distinguish 1.5 from 1 for an int parameter;
               matched on "cannot distinguish", entirely unrelated
               subject).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"identical sample
               tuple", "no threshold can distinguish", "side activity is
               zero", "trades false positives"} plus reformulations
               {"irreducible", "cannot distinguish", "no local
               threshold", "identical local pixel", "identical
               observations", "trades one failure"}. 10 loci in 6 files
               for the reformulation family, every one opened at its
               exact lines and classified above or in REASON.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1896-1898
               proposition: Failure 3, threshold ambiguity is irreducible
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-091a

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.5, line 1044 (first
               clause of the closing paragraph)
  CLAIM        "This is why `midpoint_threshold_scale` is not a proof of
               safety."
  ASSERTS      A specific negative claim about the named parameter: it
               does not constitute a safety proof.
  CLASS        Reasoned consequence of the in-principle limit at LED-091.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       OVERTURNED AT v1.3 per F23. v1.2 claimed CURRENT-UNIQUE.
               IT WAS WRONG, and wrong in an instructive way: v1.2 had
               the carrier in hand and reasoned it away in its own
               nearest-miss note. Re-Decision Evaluation lines 595-607
               are a threshold-scale/tuning analysis ending "This does
               not prove A gives bad pictures. It proves tuning cannot
               remove the failure class in principle." v1.2 fixated on
               the FIRST sentence - which is indeed the converse
               proposition - and treated the SECOND as part of it. The
               second sentence affirmatively states that tuning cannot
               establish safety, which under scope 0.4's cold-reader
               carrier test IS this entry's proposition. CLASSIFIED
               CARRIER. Canonical home: section 12.5, which states the
               claim about the named parameter directly rather than
               about tuning in general.
               THE REST OF THE v1.2 SWEEP STANDS as negative
               classification and is retained, because it remains true
               that the parameter's many other occurrences do not carry
               this claim:
                 PARAMETER MECHANISM/API, all DIFFERENT (they define what
                 the parameter IS, not what it fails to prove): authority
                 732-733 (the S conversion) and 1476; README 284, 614,
                 626, 675, 2938, 3191; Charter 1922-1923; Concise Summary
                 148, 179; Re-Decision Brief 54-59;
                 STATUS/FATE, DIFFERENT: authority 1502 (the name should
                 not survive by inertia) and D4-Q05 at 1541-1544 (the
                 parameter's fate is OPEN) - both OUTSIDE RANGE, a6, and
                 both about the parameter's FUTURE, not its evidential
                 weight; Concise Summary 31 and 397-399 (part of the
                 rejected design; no longer an open item) - DIFFERENT;
                 SAFETY-PROOF REFORMULATIONS, all DIFFERENT: README 2522
                 ("Memory-safety proof" harness) and 3061 (Schedule B
                 safety); Charter 1223 (naming a function "SIMD" does not
                 prove the instruction sequence); authority 590 (regime
                 permission does not prove both dct_type values present);
                 Debug Module 92.
               LESSON RECORDED (DEC-41 family): writing a nearest-miss
               caveat is not the same as APPLYING the carrier test to it.
               v1.2 quoted the passage, labelled it DIFFERENT and moved
               on. The uniqueness claim survived authoring and three gate
               batteries and was overturned by the first reader who
               applied the test cleanly. This is the third W3D
               uniqueness claim overturned across a5b.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe families: {"proof of safety",
               "safety proof", "proves safe", "not a proof"} - two loci,
               authority 1044 (this claim) and README 2522 (DIFFERENT);
               reformulations {"makes it safe", "safety argument",
               "guarantees safety", "does not prove", "no guarantee",
               "not safe by"} - eight loci in seven files, all opened and
               all DIFFERENT per REASON; and the full
               `midpoint_threshold_scale` occurrence set, 15+ loci across
               8 files, opened and classified above.
  CITED-OUTSIDE-RANGE
               locations: authority 1502; D4-Q05 at 1541-1544
               proposition: the parameter's name and fate are open
               questions for the D4 register
               evidence use here: negative classification only - both are
               DIFFERENT from this entry's evidential claim
               owning tranche: T1S01a6
               a6 should note when adjudicating D4-Q05 that the
               not-a-safety-proof finding lives at section 12.5 and is
               CURRENT-UNIQUE.
  TIER         C (derived, DEC-62: CURRENT-DUPLICATE -> C. Tier is
               UNCHANGED by the overturn; only the disposition moved.)
  PROPOSED
  ACTION       None. The v1.2 warning that this proposition would be lost
               with section 12.5 is WITHDRAWN - the Evaluation carries
               it.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F32)

--------------------------------------------------------------------------

LED-091b

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 12.5, lines 1044-1046
               (second clause of the closing paragraph)
  CLAIM        "It is also not 'soft confidence' in the output: it
               changes the hard pass/fail activation threshold and the
               old A design then applies normal correction strength."
  ASSERTS      The parameter is not soft confidence in the output; it
               moves a hard pass/fail threshold, after which normal
               correction strength applies.
  CLASS        Reasoned correction of a specific mistaken reading.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated - and split from LED-091a precisely
               because its evidence status differs: this limb has
               carriers, its neighbour has none. Canonical home: section
               12.5, beside the limit that motivates it. Known
               non-canonical copies, opened at their exact lines:
               Re-Decision Evaluation lines 535-540 (CARRIER, originating
               - "W3D's 'continuous uncertainty' description is
               overstated"; the parameter "is continuous as a PARAMETER,
               but the per-edge decision remains a strict binary
               comparison: pass / do not pass"), lines 645-648 (CARRIER -
               "each edge still makes a hard pass/fail decision and, once
               active, receives normal correction strength", carrying
               BOTH limbs including normal correction strength); Project
               Status lines 576-578 (CARRIER - the recorded W3D failure
               list names "threshold scaling is a hard decision, not soft
               confidence" as one of two wrong pro-A arguments W3C
               caught; a process record that nonetheless states this
               proposition).
               ADDED AT v1.3 per F24, each opened at its exact lines:
               README line 652 (CARRIER - "A midpoint that passes the
               stricter evidence test is filtered at normal correction
               strength"); README line 694 (CARRIER - the scale
               "multiplies only midpoint alpha/beta activation
               thresholds. It does not reduce correction strength after
               activation"); Appendix C lines 1877-1878 (CARRIER,
               OUTSIDE RANGE - "midpoint alpha/beta scaled once at
               creation; normal correction strength after activation",
               carried below). The v1.2 probe family missed all three
               because it used the AUTHORITY's vocabulary ("hard
               pass/fail", "soft confidence", "strict binary") and never
               the phrase the README and Appendix C actually use -
               "normal correction strength". Family widened accordingly.
               Classified out, opened: PreScope Brief line 231
               ("per-edge decision" in a Classic B_metric question -
               DIFFERENT subject, matched on the phrase).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"soft confidence",
               "continuous as a parameter", "strict binary", "hard
               pass/fail", "per-edge decision"}, WIDENED AT v1.3 per F24
               with {"normal correction strength", "does not reduce
               correction strength"}. Eleven loci in six files, every one
               opened at its exact lines and classified above.
  CITED-OUTSIDE-RANGE
               location: Appendix C, lines 1877-1878
               proposition: midpoint alpha/beta scaled once at creation;
               normal correction strength after activation
               evidence use here: duplication (added at v1.3 per F24)
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F33)

--------------------------------------------------------------------------

NO-PROPOSITION SEGMENT, RECORDED WITH RATIONALE (scope 0.10 form)

  LINES        1047-1048 - horizontal rule and blank line closing
               section 12.
  RATIONALE    Typographic separator only. It carries no proposition,
               asserts nothing, and duplicates nothing. Recorded rather
               than skipped so the coverage tiling of 915-1048 is
               complete and auditable.

--------------------------------------------------------------------------


LED-092   (SPLIT AT v1.3 per F25, on W3X's ruling. The source sentence
           makes TWO claims of different truth value: the rules are
           RETAINED as current and load-bearing - true, this entry - and
           they are of older README ORIGIN - false for two of the five,
           LED-092a. Neither the map nor W3D flagged this segment; the
           split exists because review found it.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13, lines 1050-1053, the
               RETENTION limb only ("must retain ... because they are
               still exactly right and load-bearing"). The
               "older README rules" provenance limb is LED-092a.
  CLAIM        "The architecture must retain the following ... rules
               because they are still exactly right and load-bearing."
  ASSERTS      A retention meta-claim about the five 13.x rules: they are
               still exactly right, load-bearing, and retained by
               decision.
  CLASS        W3X-ratified retention decision.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True as narrowed. The RETENTION limb is sound: the five
               rules are current and load-bearing, and LED-093..097b
               each establish their own carriers. (The v1.2 REASON
               claimed this limb was "duplicate-exposed by construction"
               via README provenance - that reasoning is withdrawn to
               LED-092a, where it fails. Retention stands on its own
               evidence.) Known non-canonical copies of the retention
               claim, opened at their exact lines: Re-Decision Evaluation lines 858-872 (CARRIER -
               its A5 section is headed "additional load-bearing README
               / knowledge content W3D should consolidate" and
               enumerates README 976-1017's rules as already stating
               the ANALYSER-DISCIPLINE CLUSTER - note, corrected at v1.3
               per F25: that section covers 13.2-13.4, NOT all five
               rules); Project Status lines 458-461 (CARRIER - the PR-1
               record quotes 13.1 as being "among rules retained because
               they are 'still exactly right'", which supports RETENTION
               of 13.1 and says nothing about its provenance); designer
               introduction lines 647-649 (CARRIER of the same retention
               phrase, opened at v1.3 during the LED-092a propagation
               enumeration).
               CANONICAL-HOME RULING, which the coverage map's own note
               asked this entry to make: section 13 STAYS CANONICAL for
               the retained rules as ratified architecture; the README
               remains their historical ORIGIN, and the eventual
               de-duplication of the README copies is T3's work, not
               this ledger's. Classified out: the fourteen further
               "load-bearing"/"still exactly right" loci across ten
               files (charter, toolchain, briefs, intros, D2, Stage 1C,
               Status 296) - every one opened, every one a DIFFERENT
               subject using the same idiom; none states this retention
               claim.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"still exactly
               right", "load-bearing", "older README rules", "must
               retain the following"}. 32 raw hits in 16 files, every
               locus opened at its exact lines and classified above or
               in REASON.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F34)

--------------------------------------------------------------------------

LED-092a   (new at v1.3 per F25, on W3X's ruling: the provenance limb of
            authority 1052, split from LED-092 because its truth value
            differs from the retention limb it shares a sentence with.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13, line 1052, the clause
               "the following older README rules"
  CLAIM        That all five section-13 rules are of older README origin.
  ASSERTS      README provenance for 13.1, 13.2, 13.3, 13.4 and 13.5.
  CLASS        Statement of record provenance - checkable, and checked.
  DISPOSITION  SUPERSEDED
  SUPERSEDED-KIND  ERRONEOUS (DEC-84)
  DUPLICATE-ACTION  n/a
  REASON       FALSE AS STATED. The claim is true for three of the five
               rules and false for two. Verified by opening the README
               in full and by broad probes over the declared population:
                 13.2 detector pre-pass reads unmodified source -
                   README 987-997 CARRIES it (see LED-094);
                 13.3 per-call scratch, no cross-frame state -
                   README 997-999 and 2277-2281 CARRY it (LED-095);
                 13.4 detector itself needs proof -
                   README 976-985 CARRIES it (LED-096);
                 13.1 scheduler/kernel separation - NO README CARRIER.
                   Probes for the separation concepts (geometry
                   classifier, decides WHERE, whether to filter,
                   schedule versus kernel, separation of concerns)
                   return NOTHING in the README. Its carriers are the
                   register D4-D03, the PreScope material and Project
                   Status (see LED-093) - none of them the README;
                 13.5 future trusted side data - NO README CARRIER, and
                   the README's dct_type material runs the OTHER WAY:
                   lines 338, 3173 and 3746 record that decoders do not
                   expose a per-macroblock dct_type map. It states the
                   PROBLEM, never the same-map-contract requirement or
                   the no-runtime-dependence rule (see LED-097a,
                   LED-097b).
               This is the SECOND real ERRONEOUS case in a5b, after
               LED-081a. As there, the error is a checkable statement
               about the corpus that no one had checked.
  CONFLICTS    None - nothing else asserts this provenance (see
               PROPAGATION).
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"older README
               rules", "README rules", "retain the following", "rules
               retained", "from the README", "README-origin", "README
               provenance"} plus a section-13-cluster family. Six loci
               in four files for the provenance family, every one opened
               at its exact lines - enumerated under PROPAGATION.
  PROPAGATION  (DEC-84, Review Scope 0.11 - MANDATORY, EXECUTED, cited
               not paraphrased)
               DEPENDENTS FOUND: ZERO. Four candidates were opened at
               their exact lines and every one carries the RETENTION
               phrase only, never the provenance claim:
                 designer introduction 647-649 - "among rules retained
                   because they are 'still exactly right'". Retention
                   only. NOT a dependent;
                 Project Status 458-461 - the same retention phrase in
                   the PR-1 record. NOT a dependent;
                 authority 228 - says this document exists so a
                   successor need not reconstruct state "from the
                   README, old grid notes, GAIS captures and chat
                   history". A statement about THIS DOCUMENT's purpose,
                   not about section 13's rules. NOT a dependent;
                 Re-Decision Brief 66 - quotes the README for the
                   step-4 rationale, an unrelated subject. NOT a
                   dependent.
               THE ERROR IS CONFINED TO AUTHORITY LINE 1052. That is a
               reportable result in its own right: unlike LED-081a,
               whose false pointer had four dependents, this one
               propagated nowhere, because every downstream repetition
               happened to quote the true limb.
  TIER         A (derived, DEC-62: SUPERSEDED/ERRONEOUS -> A)
  PROPOSED
  ACTION       Narrow the provenance clause at line 1052 so it claims
               only what is true. A minimal repair preserving the
               sentence's shape:
                 "The architecture must retain the following older
                  README rules because they are still exactly right and
                  load-bearing."
               becomes
                 "The architecture must retain the following rules
                  because they are still exactly right and load-bearing.
                  13.2 to 13.4 are older README rules; 13.1 and 13.5 are
                  not."
               W3X may prefer simply deleting "older README" and losing
               the provenance entirely - cheaper, and provenance is
               recoverable from this ledger. PROPOSAL ONLY; nothing is
               ratified, and this joins the authority-repair queue
               behind LED-081a's staged one-word fix.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F35)

--------------------------------------------------------------------------

LED-093

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.1, lines 1055-1068
  CLAIM        The three-layer division - "geometry/map/topology layer:
               selects candidate edge topology; local artifact
               predicate: decides whether the candidate looks
               filterable; kernel: applies the independently specified
               Deblock4 correction" - and the injunction "Do not let a
               local edge predicate become an implicit geometry
               classifier."
  ASSERTS      Schedule decides WHERE, the predicate decides FILTERABLE,
               the kernel decides HOW; and the predicate must never
               become an implicit geometry classifier.
  CLASS        W3X-ratified separation rule (retained per LED-092).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: 13.1, the retained-
               rule statement. Known non-canonical copies, opened at
               their exact lines: register D4-D03, lines 1617-1618
               (CARRIER, near-verbatim - "Topology says WHERE. Local
               predicate/kernel says WHETHER/HOW.", OUTSIDE RANGE,
               carried below); PreScope Brief line 201 (CARRIER,
               pre-decision - "SCHEDULE decides WHERE candidate edges
               are"); PreScope coder response lines 518-521 (CARRIER -
               component D: "independently decide whether the local
               discontinuity looks like a compression artifact, then
               apply the independently specified D4" correction) and
               line 69 (APPLIES - "independent local artifact
               predicate"); Project Status lines 458-459 (CARRIER - the
               PR-1 record quotes the injunction verbatim).
               SETTLED PRECEDENT APPLIED, NOT RE-ADJUDICATED: PR-1
               (recorded at Project Status 457-463) already ruled that
               13.1 states the general PRINCIPLE while 12.5 uniquely
               holds the PROOF, and that W3D's earlier
               unique-but-misfiled reading was WRONG. This entry's
               disposition conforms to that precedent, and the in-batch
               relation to LED-091 is exactly PR-1's division:
               principle here, proof there, no collision and no
               double-count. PR-1's own remedy idea (a pointer from
               13.1 to 12.5) remains PR-1's parked proposal, not this
               entry's action.
               THREE BATCH-1 RECONCILIATIONS DISCHARGED HERE: LED-070
               (B2's four-layer separation at 9.3, lines 762-785),
               LED-071 (the governing "where is the edge" vs "does it
               look like an artifact" principle at 786-788) and LED-079
               (the seam-ownership sweep) each noted 13.1 territory.
               Ruling: the section-9/10 statements are B2-ARCHITECTURE
               forms and 13.1 is the retained GENERAL rule; each home
               carries its own proposition, division confirmed, no
               collision. Authority lines 782-784 (layer D: "EDGE
               PREDICATE + KERNEL - independently decide whether a
               scheduled candidate is an artifact") were re-opened for
               this ruling and are settled batch-1 ground, cited not
               re-adjudicated.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"decides WHERE",
               "schedule decides", "geometry classifier", "implicit
               geometry", "looks filterable", "artifact predicate",
               "candidate edge topology"} plus reformulations {"decides
               whether", "selects candidate", "edge predicate",
               "detector/kernel", "schedule/kernel"}. Every locus
               opened at its exact lines and classified above; the
               Stage 1B3 line 448 hit is a runtime-guard subject
               (DIFFERENT).
  CITED-OUTSIDE-RANGE
               location: register D4-D03, lines 1617-1618
               proposition: the same separation rule in register form
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-094

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.2, lines 1070-1074
  CLAIM        "Any B2 detector that can affect output is part of the
               canonical algorithm. Its map must be computed from the
               unmodified input before filtering writes begin. Do not
               let earlier filtered pixels influence later geometry
               classification."
  ASSERTS      Output-affecting detectors are canonical; the map is a
               pre-pass over unmodified input, completed before writes;
               filtered pixels must not feed later classification.
  CLASS        W3X-ratified analyser rule (retained per LED-092).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: 13.2. Known
               non-canonical copies, opened at their exact lines: README
               lines 976-978 (CARRIER - "If an analyser can affect
               output, its scalar and vector forms are subject to the
               same per-type requirement as the filter kernels") and
               987-997 (CARRIER - "computed in a pre-pass over the
               unmodified input plane; completed before any filtering
               begins"); Re-Decision Evaluation lines 868-870 (CARRIER -
               the A5 enumeration: "an analyser that affects output is
               part of the canonical algorithm ... analysis occurs as an
               unmodified-source pre-pass"); Charter line 369 (CARRIER -
               "unmodified-source per-call pre-pass"); register 19.2 at
               line 1411 ("Classification occurs before filtering",
               OUTSIDE RANGE, carried below).
               RECLASSIFIED AT v1.3 per F26: designer introduction lines
               134-136 - "Any output-affecting analyser is part of the
               canonical algorithm, runs as an unmodified-source
               pre-pass, uses per-call scratch under fmParallel, and gets
               its own proof obligations" - is a CARRIER, not APPLIES. It
               states this entry's central proposition directly, in
               compressed form. v1.2 filed the intro loci as
               implementation/configuration uses; that was wrong. The
               line survives unchanged in designer introduction v1.34.
               Classified as APPLIES, opened: Evaluation 640 (B2
               deterministic when the detector is a per-frame pure
               pre-pass - uses the rule); authority 758 (settled batch-1
               ground, "the good detector/pre-pass/span ideas survive");
               the further README/charter pre-pass loci (occurrences
               applying or configuring the rule rather than stating
               it).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"unmodified source",
               "unmodified input", "before filtering writes", "earlier
               filtered pixels", "canonical algorithm", "pre-pass"}. 36
               raw hits in 5 files, every locus opened at its exact
               lines and classified above.
  CITED-OUTSIDE-RANGE
               location: authority 19.2, line 1411
               proposition: classification occurs before filtering
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F36)

--------------------------------------------------------------------------

LED-095

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.3, lines 1076-1081
  CLAIM        "Under fmParallel, detector maps/scratch are per-frame
               activation/per-call data. Immutable configuration may be
               per instance; output-affecting previous-frame state is
               forbidden in v1 unless a later scope explicitly models
               temporal frame dependencies."
  ASSERTS      Per-call scratch under fmParallel; immutable per-instance
               configuration allowed; output-affecting cross-frame state
               forbidden in v1, with the explicit later-scope escape.
  CLASS        W3X-ratified state rule (retained per LED-092).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: 13.3. Known
               non-canonical copies, opened at their exact lines:
               section 0 item 6, lines 113-115 (CARRIER, settled a3 -
               "NO HIDDEN TEMPORAL STATE in v1 ... No previous-call/
               request-history hysteresis under fmParallel [D4-D06]");
               README lines 997-999 (CARRIER - "per-call scratch, never
               per-instance mutable state, because one filter instance
               may serve concurrent fmParallel calls") and 2277-2281
               (CARRIER - no cross-frame cache; fmParallel-suitable when
               state is immutable or per-call); Charter G4, lines
               503-504 (CARRIER - "All scratch is per-call, never
               per-instance"); Re-Decision Evaluation line 871 (CARRIER
               - the A5 enumeration); register D4-D06, lines 1633-1635
               (CARRIER, OUTSIDE RANGE, carried below). Classified as
               ADDED/RECLASSIFIED AT v1.3 per F27, each opened at its
               exact lines: designer introduction lines 134-136 and
               731-732 (CARRIER - per-call scratch under fmParallel and
               no hidden temporal state in v1, stated directly); the
               prior W3C PreScope response lines 42-56 and 552-569
               (CARRIER, and the fullest form in the corpus - it states
               the request-history hazard, requires explicit temporal
               modelling, and identifies a later explicitly designed
               temporal dependency as the permitted escape, which is
               precisely this entry's "unless a later scope explicitly
               models temporal frame dependencies" limb). v1.2 filed
               these as APPLIES; that was wrong.
               APPLIES or DIFFERENT, opened: Project Status line 579
               (the recorded W3D temporal-hysteresis failure - a process
               record of the rule being enforced, APPLIES); the D2
               schedule and remaining README/charter/intro loci
               (implementation and configuration references applying the
               rule).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"per-call scratch",
               "cross-frame", "per-frame activation", "previous-frame
               state", "fmParallel", "immutable configuration",
               "temporal frame dependenc-"}. 46 raw hits in 11 files,
               every locus opened at its exact lines and classified
               above.
  CITED-OUTSIDE-RANGE
               location: register D4-D06, lines 1633-1635
               proposition: no hidden temporal state in v1
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      DISAGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23; F37)

--------------------------------------------------------------------------

LED-096

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.4, lines 1083-1088
  CLAIM        "If B2 proceeds, its scalar definition becomes part of the
               oracle-level structural algorithm. Integer scalar/v2/v3
               detector classifications must be structurally exact under
               the project's per-type verification rules. Do not hide the
               detector in an unproved convenience helper."
  ASSERTS      The detector itself needs proof: scalar definition joins
               the oracle-level algorithm; classifications structurally
               exact per per-type rules; no unproved convenience helpers.
  CLASS        W3X-ratified proof-obligation rule (retained per LED-092).
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: 13.4. Known
               non-canonical copies, opened at their exact lines: README
               lines 976-985 (CARRIER, near-verbatim origin - the
               analyser gets "the same per-type requirement as the
               filter kernels", INTEGER scalar==v2==v3 byte-exact, FLOAT
               structural classifications exact, and "It belongs under
               spec.zig/canonical validation, not in an unproved
               convenience helper"); Re-Decision Evaluation lines
               868-869 (CARRIER - the A5 enumeration: "it gets the same
               scalar/vector correctness obligations"). Classified as
               APPLIES, opened: section 0 item 7, lines 117-119 (the
               broader own-oracle/proof-chain rule, settled a3 - the
               umbrella this rule instantiates, not the same
               proposition).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"structurally
               exact", "unproved convenience", "detector ... proof",
               "scalar definition", "oracle-level", "per-type
               verification"}, WIDENED AT v1.3 per F28 with {"proof
               obligations", "its own proof"} and rerun over the same
               38-file population. Loci in three files plus the settled
               a3 umbrella, every one opened at its exact lines and
               classified above or here.
               ADDED AT v1.3 per F28: designer introduction lines
               134-136 - an output-affecting analyser "gets its own
               proof obligations" - is a compressed CARRIER of the
               detector-needs-proof proposition. The v1.2 family omitted
               the reformulation that finds it; F28 supplied it.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 correction review 1, 2026-08-23)

--------------------------------------------------------------------------

LED-097   (split under the atomic-claim rule; the map pre-flagged this
           segment as three separable claims, and the split is confirmed
           because their EVIDENCE STATUS differs: two limbs are carried
           by the D4-Q13 register entry, the third is carried by nothing.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.5, lines 1090-1092
               (heading and first clause)
  CLAIM        "D4-Q13 remains open."
  ASSERTS      A status claim: the trusted-side-data question is OPEN.
  CLASS        Decision-status record.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: 13.5, beside the
               rules the open question conditions. Known non-canonical
               copy, opened at its exact lines: register D4-Q13, lines
               1575-1577 (CARRIER - "OPEN", OUTSIDE RANGE, carried
               below).
               BATCH-1 RECONCILIATION DISCHARGED ACROSS LED-097/097a:
               LED-070a (the layer-B side-data sentence at 9.3, batch 1)
               was recorded as POINTER, PROVISIONAL on this segment
               proving to be the substantive canonical home. CONFIRMED:
               13.5 carries the full side-data rule cluster - the open
               status here, the same-contract requirement at LED-097a
               and the no-dependence rule at LED-097b - and the 9.3
               sentence is a forward pointer to it. LED-070a's
               provisional condition is RESOLVED-CONFIRMED; no batch-1
               verdict changes, and the condition's closure is recorded
               here because scope forbids editing a closed ledger.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"D4-Q13", "side
               data", "dct_type metadata"}. All loci opened at their
               exact lines; the section 0 item 4 (81-83) and section 2
               F6 (320-323) statements that a filter cannot KNOW
               dct_type without trusted side data are settled a3/a5
               ground for WHY the question exists (APPLIES); designer
               intro line 791 lists trusted side data as future work
               (APPLIES); Status 548 and Evaluation 930/1004 use the
               FRAME/FIELD/UNKNOWN contract vocabulary (adjudicated at
               LED-097a and LED-082, not here).
  CITED-OUTSIDE-RANGE
               location: register D4-Q13, lines 1575-1577
               proposition: the question is OPEN
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-097a

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.5, lines 1092-1094
  CLAIM        "If a source/decoder later supplies trustworthy dct_type
               metadata, that producer should feed the SAME
               FRAME/FIELD/UNKNOWN macroblock-map contract so the
               topology compiler/kernel do not change."
  ASSERTS      The same-contract requirement: future side data plugs into
               the existing map contract rather than forking the
               compiler or kernel.
  CLASS        W3X-ratified interface rule.
  DISPOSITION  CURRENT-DUPLICATE
  DUPLICATE-ACTION  STAY-CANONICAL
  REASON       True and duplicated. Canonical home: 13.5. Known
               non-canonical copy, opened at its exact lines: register
               D4-Q13, lines 1576-1577 (CARRIER - "Future decoder/source
               dct_type map should plug into the same B2 map contract,
               not fork the kernel", OUTSIDE RANGE, carried below).
               Classified as APPLIES, opened: the FRAME/FIELD/UNKNOWN
               contract statements at section 0 (line 64 area of the
               designer intro and the map-producer descriptions at
               D4-D04 1621-1623, Status 548, Evaluation 930 and 1004) -
               they state the CONTRACT itself, which LED-082 and the
               batch-1 entries own; this entry owns only the
               side-data-joins-it requirement.
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"FRAME/FIELD/
               UNKNOWN", "topology compiler", "not fork the kernel",
               "same ... map contract"}. All loci opened at their exact
               lines and classified above.
  CITED-OUTSIDE-RANGE
               location: register D4-Q13, lines 1576-1577
               proposition: side data plugs into the same B2 map
               contract
               evidence use here: duplication
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

LED-097b

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 13.5, lines 1094-1095
  CLAIM        "Runtime correctness must not depend on side data until
               its format/lifetime/trust contract is scoped."
  ASSERTS      The no-dependence rule: side data cannot become a
               correctness dependency before its contract is scoped.
  CLASS        W3X-ratified safety rule.
  DISPOSITION  CURRENT-UNIQUE
  DUPLICATE-ACTION  n/a
  REASON       SOLE CARRIER ON THE DECLARED POPULATION - and split from
               LED-097/097a precisely because of it: the register's
               D4-Q13 entry carries the open status and the
               same-contract requirement but NOT this rule, so a whole
               segment would have let the carried limbs prove the
               uncarried one (the batch-1 F10 defect class, avoided at
               authoring time as at LED-091a). Every candidate opened at
               its exact lines and classified out: register D4-Q13
               1575-1577 (carries limbs one and two only - the decisive
               negative, recorded so nobody upgrades it to a carrier of
               this limb); README lines 922-937 ("must not depend" in
               the SIMD-width-must-not-define-output rule - DIFFERENT
               subject entirely); section 0 item 4 (81-83) and section 2
               F6 (320-323) - the filter cannot KNOW dct_type without
               side data (the FACT motivating the rule, not the rule);
               designer intro 791 (future-work list - APPLIES).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"depend on side
               data", "must not depend", "until ... scoped", "trust
               contract", "format/lifetime", "not fork the kernel"}.
               Four files matched, every locus opened at its exact lines
               and classified in REASON. No carrier exists outside line
               1094-1095.
  CITED-OUTSIDE-RANGE
               location: register D4-Q13, lines 1575-1577
               proposition: the register entry's scope (status and
               contract limbs)
               evidence use here: negative classification - the register
               does NOT carry this limb
               owning tranche: T1S01a6
               a6 should note when adjudicating D4-Q13 that the
               no-dependence rule lives ONLY at 13.5 and would be lost
               with it.
  TIER         C (derived, DEC-62: CURRENT-UNIQUE, no proposed action,
               no conflict)
  PROPOSED
  ACTION       None. Recorded so any future move or rewording of 13.5
               knows this safety rule has no second home.
  VERDICT      AGREE (T1S01a5b_B Batch2 v1, 2026-08-22)

--------------------------------------------------------------------------

# 2. INCREMENT SUMMARY - DERIVED BY ENUMERATION FROM THE ENTRIES ABOVE

```text
ENTRIES IN THIS VERSION: 22
    LED-082  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-082a CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-083  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-084  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-085  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-086  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-087  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-088  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-089  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-090  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-091  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-091a CURRENT-DUPLICATE  STAY-CANONICAL   C   overturned (F23)
    LED-091b CURRENT-DUPLICATE  STAY-CANONICAL   C   repaired (F24)
    LED-092  CURRENT-DUPLICATE  STAY-CANONICAL   C   narrowed (F25)
    LED-092a SUPERSEDED (ERRONEOUS)  n/a         A   new (F25)
    LED-093  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-094  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-095  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-096  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-097  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-097a CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-097b CURRENT-UNIQUE     n/a              C

DISPOSITIONS: 20 CURRENT-DUPLICATE, 1 CURRENT-UNIQUE (LED-097b),
1 SUPERSEDED/ERRONEOUS (LED-092a); zero CONFLICTING, zero POINTER.
TIERS (derived, DEC-62): 21 C, 1 A.

WHAT REVIEW CHANGED (v1.3): batch 2 was authored claiming TWO
CURRENT-UNIQUE findings and NO Tier A. Review overturned one uniqueness
claim (LED-091a - the carrier was in W3D's own nearest-miss note) and
found a Tier-A ERRONEOUS provenance claim W3D had asserted rather than
checked (LED-092a). ONE uniqueness finding survives: LED-097b, the
no-dependence-on-side-data rule, which W3C independently confirmed. The
remaining nine findings were missed occurrences and probe families built
from the authority's vocabulary rather than the corpus's.

BATCH-1 CROSS-NOTES DISCHARGED SO FAR: LED-073 -> LED-082 (role/topology
canonical division CONFIRMED) and LED-073a -> LED-082 (pointer target
CONFIRMED). Recorded inside LED-082.

IN-BATCH CROSS-NOTES DISCHARGED BY INCREMENT 2: LED-082 -> LED-087 (the
authority 936-937 lattice loci: same notation, DIFFERENT proposition -
no collision) and LED-082a -> LED-091/091a/091b (the
midpoint_threshold_scale relation: D's experiment-candidate STATUS at
LED-082a is distinct from A's parameter claims here, and the two entry
families do not double-count). Both recorded inside their owning entries.

BATCH-1 CROSS-NOTES: ALL DISCHARGED. LED-064 -> LED-087 and
LED-065/067 -> LED-086..091 discharged by increment 2; LED-070, LED-071
and LED-079 -> LED-093 discharged inside LED-093 (section-9/10
B2-architecture forms versus the retained 13.1 general rule - division
confirmed, no collision); LED-070a -> LED-097 RESOLVED-CONFIRMED inside
LED-097: section 13.5 is the substantive canonical home the batch-1
POINTER was provisional on. No batch-1 verdict changes; the closures are
recorded here because scope forbids editing a closed ledger.

CITED-OUTSIDE-RANGE RECORDS CARRIED: 15 (LED-082a, LED-084, LED-085,
LED-086, LED-087, LED-088, LED-089, LED-091, LED-091a, LED-093, LED-094,
LED-095, LED-097, LED-097a, LED-097b - LED-097b's being a recorded
NEGATIVE; none at LED-082/083/090/091b/092/096), all owned by T1S01a6. Appendix
C is cited by five and the D4 registers by seven; a6 inherits a real
reconciliation load from this batch and the obligation list should
travel with the a6 planning artifact.

SETTLED PRECEDENT APPLIED: PR-1 (Project Status 457-463) governed
LED-093's relation to LED-091 - principle at 13.1, proof at 12.5 -
without re-adjudication. W3C AGREED with that application.

REVIEW STATE: 10 entries carry recorded AGREE verdicts from T1S01a5b_B
Batch2 v1 (LED-086, 087, 088, 089, 090, 091, 093, 097, 097a, 097b) and
are NOT reopened. TWELVE items are open for correction review 1: the
eleven entries disagreed at F18-F28, plus the new LED-092a.

DEC-84 PROPAGATION RESULT (LED-092a): ZERO dependents. Four candidates
opened; every one quotes the retention limb, never the false provenance
limb. The error is confined to authority line 1052 - unlike LED-081a,
whose false pointer had four dependents.

NOTHING HERE IS RATIFIED. Every PROPOSED ACTION is a proposal awaiting T3.
```

---

*Revision history*

```text
v1.3 (2026-08-22) FIRST CORRECTION GENERATION per W3C review T1S01a5b_B
     Batch2 v1 (10 AGREE / 11 DISAGREE, F18-F28). W3D verified every
     finding at exact lines and accepted all eleven; none contested.
     SUBSTANTIVE: LED-091a's CURRENT-UNIQUE is OVERTURNED to
     CURRENT-DUPLICATE (F23) - Re-Decision Evaluation 606-607 does carry
     the not-a-safety-proof proposition, and v1.2 had quoted that very
     passage in a nearest-miss note and reasoned it away instead of
     applying the carrier test; and LED-092 is SPLIT on W3X's ruling
     (F25), its README-provenance limb becoming LED-092a, SUPERSEDED /
     SUPERSEDED-KIND ERRONEOUS, Tier A - the second real ERRONEOUS case
     after LED-081a - because the README carries 13.2-13.4 but has no
     carrier for 13.1's separation rule or 13.5's side-data rules.
     Mandatory DEC-84 propagation executed: ZERO dependents, error
     confined to line 1052; an authority repair is PROPOSED, not
     ratified. EVIDENCE: added the Evaluation D-section occurrence and
     corrected the mid-line 896 boundary at LED-082 (F18); added the
     D4-Q05 carrier and withdrew a false no-other-match statement at
     LED-082a (F19); added two approximation carriers at LED-083 (F20);
     added risk-2's a6 carrier and two Evaluation occurrences at LED-084
     (F21); added the revision-record occurrence at LED-085 (F22); added
     README 652/694 and Appendix C 1877-1878 at LED-091b, widening a
     probe family that had used only the authority's vocabulary (F24);
     reclassified the designer introduction's compressed line 134-136
     from APPLIES to CARRIER at LED-094, LED-095 and LED-096, and added
     the PreScope response's temporal-state carriers (F26-F28). Entry
     count 21 -> 22. Ten AGREE verdicts recorded and not reopened.
v1.2 (2026-08-22) Increment 3 added: section 13 complete (LED-092..096
     plus the three-way split LED-097/097a/097b), lines 1049-1098.
     BATCH-2 AUTHORING IS COMPLETE at 21 entries. LED-097b is the
     batch's second CURRENT-UNIQUE: the register's D4-Q13 entry carries
     the open status and the same-contract requirement but NOT the
     no-dependence safety rule, so the segment was split by evidence
     status before review, as at LED-091a. All eight batch-1 cross-notes
     are now discharged, including LED-070a's provisional POINTER,
     RESOLVED-CONFIRMED at LED-097. PR-1's settled precedent governed
     LED-093 without re-adjudication. Increments 1-2 unchanged. A
     summary defect was caught by the gate battery before issue: the
     C-O-R count was written as 16 against an enumeration of 15;
     corrected here, with the fifteen carriers named and the six
     entries without one named too.
v1.1 (2026-08-22) Increment 2 added: section 12 complete (LED-086..091
     plus the three-way split LED-091/091a/091b), lines 915-1048, with
     the 1047-1048 separator recorded as a no-proposition segment.
     LED-091a is the increment's only CURRENT-UNIQUE: the corpus defines
     and configures midpoint_threshold_scale in fifteen-plus places but
     nowhere else states that it is not a proof of safety, and the
     nearest miss (the Evaluation's converse claim) is recorded
     explicitly so it is not miscounted as a carrier. The split was made
     because evidence status DIFFERS across the segment's limbs - had it
     stayed whole, its carried limbs would have proved the uncarried one,
     the exact defect batch 1's F10 caught at LED-066. Increment 1
     (section 11) is unchanged.
v1.0 (2026-08-22) First issue: batch 2 increment 1 of 3, section 11
     complete (LED-082..085 plus split 082a), adjudicated against the
     38-file population of Population Delta v1.1 under Review Scope
     v1.15 and coverage map v1.1, authored in section order per the
     batch-2 delivery protocol. Discharges the two batch-1 cross-notes
     owed to LED-082.
```
