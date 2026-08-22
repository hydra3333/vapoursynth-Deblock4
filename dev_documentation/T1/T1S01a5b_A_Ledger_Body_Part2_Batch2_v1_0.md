# Deblock4 - T1S01a5b BATCH 2 Adjudication Ledger (Part 2, Batch 2)

**Deliverable:** T1S01a5b_A - ADJUDICATION LEDGER, BATCH 2
**Version:** 1.0
**Date:** 2026-08-22
**Author:** W3D
**Status:** ADJUDICATION LEDGER, BATCH 2, INCREMENT 1 of 3 (sections
11 -> 12 -> 13 per T1S01a5b_A_Batch2_Delivery_Protocol_v1_0). This
increment covers SECTION 11 ONLY, authority lines 877-914, reserved
entries LED-082..085 plus one ratified-rule split (LED-082a). Sections 12
and 13 follow as increments 2 and 3; the complete batch-2 document is then
re-emitted whole as the artifact of record.
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

DECLARED RANGE OF THIS INCREMENT: authority lines 877-914 EXACTLY -
section 11 complete. Line 877 (blank) opens the map's 877-898 segment;
lines 913-914 (blank + hrule) close the 910-914 segment. Every line
belongs to exactly one entry below, per coverage map v1.1's Part B.4
segmentation, which this increment follows without deviation:

    877-898 -> LED-082 / LED-082a
    899-902 -> LED-083
    903-909 -> LED-084
    910-914 -> LED-085

No line of 877-914 is unassigned. Lines 915-1098 (sections 12-13,
LED-086..097) are owed by increments 2 and 3.

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

ENTRY COUNT OF THIS INCREMENT, DERIVED BY ENUMERATING THE ENTRIES BELOW,
NOT CARRIED FROM A PLAN: 5 - four map segments, one of which splits under
the atomic-claim rule (LED-082/082a, pre-flagged by the map). There is no
target entry count.

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

# 2. INCREMENT SUMMARY - DERIVED BY ENUMERATION FROM THE ENTRIES ABOVE

```text
ENTRIES THIS INCREMENT: 5
    LED-082  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-082a CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-083  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-084  CURRENT-DUPLICATE  STAY-CANONICAL   C
    LED-085  CURRENT-DUPLICATE  STAY-CANONICAL   C

DISPOSITIONS: 5 CURRENT-DUPLICATE; zero of every other kind.
TIERS (derived, DEC-62): 5 C.

BATCH-1 CROSS-NOTES DISCHARGED BY THIS INCREMENT: LED-073 -> LED-082
(role/topology canonical division CONFIRMED) and LED-073a -> LED-082
(pointer target CONFIRMED: section 11 carries the exact Case-(a) luma
topology). Recorded inside LED-082.

CROSS-NOTES OWED WITHIN THIS BATCH: LED-082's literal-A lattice loci at
authority 936-937 -> LED-087 (increment 2); LED-082a's
midpoint_threshold_scale relation -> LED-091 (increment 2). Both named
entries must reconcile on adjudication.

CITED-OUTSIDE-RANGE RECORDS CARRIED: 3 (LED-082a, LED-084, LED-085), all
owned by T1S01a6.

STILL OWED BY LATER INCREMENTS: sections 12-13, LED-086..097, including
the batch-1 cross-notes to LED-086..091, LED-087, LED-091, LED-093 and
LED-097 (LED-070a's provisional POINTER condition remains OPEN until
LED-097 adjudicates).

NOTHING HERE IS RATIFIED. Every PROPOSED ACTION is a proposal awaiting T3.
```

---

*Revision history*

```text
v1.0 (2026-08-22) First issue: batch 2 increment 1 of 3, section 11
     complete (LED-082..085 plus split 082a), adjudicated against the
     38-file population of Population Delta v1.1 under Review Scope
     v1.15 and coverage map v1.1, authored in section order per the
     batch-2 delivery protocol. Discharges the two batch-1 cross-notes
     owed to LED-082.
```
