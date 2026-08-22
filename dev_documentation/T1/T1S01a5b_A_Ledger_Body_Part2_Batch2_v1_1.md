# Deblock4 - T1S01a5b BATCH 2 Adjudication Ledger (Part 2, Batch 2)

**Deliverable:** T1S01a5b_A - ADJUDICATION LEDGER, BATCH 2
**Version:** 1.1
**Date:** 2026-08-22
**Author:** W3D
**Status:** ADJUDICATION LEDGER, BATCH 2, INCREMENTS 1 AND 2 of 3
(sections 11 -> 12 -> 13 per T1S01a5b_A_Batch2_Delivery_Protocol_v1_0).
This version covers SECTIONS 11 AND 12, authority lines 877-1048, reserved
entries LED-082..091 plus three atomic-claim splits (LED-082a, LED-091a,
LED-091b). Section 13 follows as increment 3; the complete batch-2
document is then re-emitted whole as the artifact of record.
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

DECLARED RANGE OF THIS VERSION: authority lines 877-1048 EXACTLY -
sections 11 and 12 complete. Every line belongs to exactly one entry or
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

No line of 877-1048 is unassigned. Lines 1049-1098 (section 13,
LED-092..097) are owed by increment 3.

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
NOT CARRIED FROM A PLAN: 13 - ten map segments, three of which carry
atomic-claim splits (LED-082/082a and the THREE-WAY LED-091/091a/091b,
both segments pre-flagged by the map), plus one recorded no-proposition
segment. There is no target entry count. The map reserved SIX entries for
sections 11-12 and adjudication produced THIRTEEN; the planning-figures
caution holds again.

---

# 1. THE ENTRIES

--------------------------------------------------------------------------

LED-082   (split under the atomic-claim rule; map pre-flagged this
           segment: the experiment-candidate status sentence is a status
           claim separable from the geometry contract.)

  --- WHAT THE DOCUMENT SAYS ---
  DOCUMENT     MPEG-2 authority v1.05, section 11, lines 878-895 (the
               heading and the Case-(a) topology contract; the
               experiment-candidate clause at 896-897 is LED-082a)
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
                   764-766 (CARRIER, secondary); 268, 290, 325, 328
                   (A-analysis projections - DIFFERENT, A's geometry);
                   460-466 (A's faithful union at e = 16*k - DIFFERENT);
                 no other file matched.
  TIER         C (derived, DEC-62: CURRENT-DUPLICATE -> C)
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
               169-171 found by the family's scale-idea limb (CARRIER).
               No other file matched.
  CITED-OUTSIDE-RANGE
               location: Appendix C, line 1877
               proposition: A's midpoint alpha/beta scaled once at
               creation (A machinery history)
               evidence use here: negative classification only -
               DIFFERENT from this entry's D-status proposition
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
               frame/frame", "naturally conservative"}. Four loci in two
               files, all opened: authority 900-901 (canonical); the
               Evaluation 811-812 (CARRIER). The section 0 item 12 copy
               was found via the family's approximation limb and is
               classified in REASON. No other file matched.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
                   risk 1's measurement category); 1221 (a6 -
                   viability/ROC framing, APPLIES);
                 Re-Decision Brief: 78-82 (CARRIER, lead limb);
                 Re-Decision Evaluation: 527 (A2 - "false activation:
                   the strongest argument against A" - DIFFERENT: A's
                   false-activation defect, the disease; this entry's
                   risk 1 is D's residual exposure, a different
                   proposition); 811-812 (CARRIER, risk 2, per REASON);
                 no other file matched.
  CITED-OUTSIDE-RANGE
               location: section 15 ground-truth categories, line 1214
               proposition: false internal candidates in FIELD
               macroblocks are a measured category
               evidence use here: risk 1's duplication
               owning tranche: T1S01a6
               a6 must reconcile the Q14 category list with this
               STAY-CANONICAL when it adjudicates section 15.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
               section 23 lines 1668-1672 and the register row 1596
               (CARRIER, OUTSIDE RANGE, a6 - carried below).
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
               (1668-1672), register row 1596
               proposition: predeclared viability criteria gate both B2
               and D; nothing advances without meeting them
               evidence use here: duplication breadth
               owning tranche: T1S01a6
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

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
  VERDICT      (W3C)

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
  VERDICT      (W3C)

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
  VERDICT      (W3C)

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
  VERDICT      (W3C)

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
  VERDICT      (W3C)

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
  VERDICT      (W3C)

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
  DISPOSITION  CURRENT-UNIQUE
  DUPLICATE-ACTION  n/a
  REASON       SOLE CARRIER ON THE DECLARED POPULATION. The corpus is
               dense with `midpoint_threshold_scale` occurrences, but
               they define or configure the PARAMETER; not one states
               that it is not a safety proof. Every occurrence of the
               parameter and every safety-proof reformulation was opened
               at its exact lines and classified:
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
               THE NEAREST MISS, recorded explicitly so no future reader
               counts it as a carrier: Re-Decision Evaluation lines
               606-607 - "This does not prove A gives bad pictures. It
               proves tuning cannot remove the failure class in
               principle." That is the CONVERSE proposition (the analysis
               does not prove A bad), not this one (the scale does not
               prove safety). Classified DIFFERENT.
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
  TIER         C (derived, DEC-62: CURRENT-UNIQUE with no proposed action
               and no conflict -> C; the entry records where a
               proposition solely lives, and proposes nothing)
  PROPOSED
  ACTION       None. Recorded so that any future move, retirement or
               rewording of section 12.5 knows this proposition has NO
               second home in the corpus and would be lost with it.
  VERDICT      (W3C)

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
               Classified out, opened: PreScope Brief line 231
               ("per-edge decision" in a Classic B_metric question -
               DIFFERENT subject, matched on the phrase).
  CONFLICTS    None.
  PREVAILS     n/a
  SWEPT        Population: 38 files. Probe family: {"soft confidence",
               "continuous as a parameter", "strict binary", "hard
               pass/fail", "per-edge decision"}. Eight loci in four
               files, every one opened at its exact lines and classified
               above.
  TIER         C
  PROPOSED
  ACTION       None.
  VERDICT      (W3C)

--------------------------------------------------------------------------

NO-PROPOSITION SEGMENT, RECORDED WITH RATIONALE (scope 0.10 form)

  LINES        1047-1048 - horizontal rule and blank line closing
               section 12.
  RATIONALE    Typographic separator only. It carries no proposition,
               asserts nothing, and duplicates nothing. Recorded rather
               than skipped so the coverage tiling of 915-1048 is
               complete and auditable.

--------------------------------------------------------------------------

# 2. INCREMENT SUMMARY - DERIVED BY ENUMERATION FROM THE ENTRIES ABOVE

```text
ENTRIES IN THIS VERSION: 13
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
    LED-091a CURRENT-UNIQUE     n/a              C
    LED-091b CURRENT-DUPLICATE  STAY-CANONICAL   C

DISPOSITIONS: 12 CURRENT-DUPLICATE, 1 CURRENT-UNIQUE; zero CONFLICTING,
zero SUPERSEDED, zero POINTER.
TIERS (derived, DEC-62): 13 C. No Tier A or B arose in section 12 - the
rejection proof is mathematics that the corpus carries consistently, and
the one uniqueness finding proposes no action.

BATCH-1 CROSS-NOTES DISCHARGED SO FAR: LED-073 -> LED-082 (role/topology
canonical division CONFIRMED) and LED-073a -> LED-082 (pointer target
CONFIRMED). Recorded inside LED-082.

IN-BATCH CROSS-NOTES DISCHARGED BY INCREMENT 2: LED-082 -> LED-087 (the
authority 936-937 lattice loci: same notation, DIFFERENT proposition -
no collision) and LED-082a -> LED-091/091a/091b (the
midpoint_threshold_scale relation: D's experiment-candidate STATUS at
LED-082a is distinct from A's parameter claims here, and the two entry
families do not double-count). Both recorded inside their owning entries.

BATCH-1 CROSS-NOTES STILL OWED: LED-064 -> LED-087 and LED-065/067 ->
LED-086..091 are DISCHARGED by increment 2's entries as written; LED-070
-> LED-093, LED-071 -> LED-093, LED-079 -> LED-093 and LED-070a ->
LED-097 remain OPEN and fall to increment 3. LED-070a's PROVISIONAL
POINTER condition is still open across batches.

CITED-OUTSIDE-RANGE RECORDS CARRIED: 9 (LED-082a, LED-084, LED-085,
LED-086, LED-087, LED-088, LED-089, LED-091, LED-091a), all owned by
T1S01a6. Appendix C is cited by five of them; a6 must reconcile Appendix
C's compact record against these STAY-CANONICALs when it adjudicates.

STILL OWED BY INCREMENT 3: section 13, lines 1049-1098, LED-092..097,
including the canonical-home adjudication the map flags at LED-092 and
the three-way split flagged at LED-097.

NOTHING HERE IS RATIFIED. Every PROPOSED ACTION is a proposal awaiting T3.
```

---

*Revision history*

```text
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
