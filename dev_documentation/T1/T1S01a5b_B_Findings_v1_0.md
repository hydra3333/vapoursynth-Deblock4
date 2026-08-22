# Deblock4 - T1S01a5b Batch 1 W3C Review Findings

**Deliverable:** T1S01a5b_B - CODER RESPONSE / BATCH 1 FINDINGS
**Version:** 1.0
**Date:** 2026-08-21
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** `T1S01a5b_A_Designer_Batch_v1.zip`
**Primary ledger:** `T1S01a5b_A_Ledger_Body_Part2_v1_1.md`
**Reference corpus:** `dev_documentation(20260821-104439).zip`
**Binding scope:** `Deblock4_T1_W3C_Review_Scope_v1_15.md`
**Nature:** DOCUMENT REVIEW ONLY. No source, build, test, patch or git.
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

The declared 38-file a5b population reproduces exactly from the supplied
2026-08-21 documentation tree, so the population prerequisite passes. The
batch's overall architecture reading is also broadly sound: sections 9-10
mostly describe rejected/superseded designs as history, B2 remains the primary
candidate, D remains the detector-free comparator/fallback, and the near-zero
Tier-A expectation is not overturned.

The ledger nevertheless requires reissue. The largest problems are source
coverage and atomicity: the substantive `Architecture B2 - PRIMARY CANDIDATE`
statement at authority line 763 has no disposition; several heading/status
propositions are assigned to the wrong entry; LED-066, LED-073 and LED-074
combine clauses whose uniqueness/duplication evidence differs; and two sweeps
miss applicable current-corpus material. LED-081a is a real authority defect,
but W3C does not agree that it is CONFLICTING: the line-873 pointer is
ERRONEOUS and should be SUPERSEDED/ERRONEOUS under the binding propagation
rule, with the one-word `Section 15` -> `Section 16` repair retained.

Result: 13 AGREE / 11 DISAGREE. No a5 work is reopened, no source/code work is
requested, and no cross-entry consistency pass is attempted beyond defects
inside this declared Batch-1 range.

---

# DECISIONS/QUESTIONS FOR W3X

None at this review stage.

LED-081a's proposed authority correction is technically supported, but W3C
recommends W3X wait for W3D's corrected ledger entry and propagation record
before ratifying the authority bump. No other W3X decision is needed to let W3D
repair this batch.

---

# 1. Review basis and population verification

W3C used:
- the authority v1.05;
- Review Scope v1.15;
- the Population Delta v1.0;
- the Population and Coverage Map v1.0;
- the complete `dev_documentation(20260821-104439).zip` tree.

W3C reproduced the population mechanically under DEC-60 / DEC-63 / DEC-66.

```text
DECLARED a5b POPULATION: 38 files
W3C REPRODUCED:          38 files
RESULT:                  AGREE
```

The population is therefore accepted for this batch. W3C did NOT inherit the
historical a5 46-file snapshot.

Knowledge-base reliance:
- MPEG-2 authority v1.05 is the prevailing MPEG-2/Deblock4 authority.
- Review Scope v1.15 supplies the binding review/evidence rules.
- The 38-file current corpus was used for duplicate/unique/conflict checks.
- No source repository, build, test or code implementation was needed because
  this batch contains no OPERATIVE-SPEC / Tier-B entry.

---

# 2. Verdict summary

```text
AGREE (13):
    LED-065
    LED-069
    LED-070a
    LED-071
    LED-072
    LED-074a
    LED-075
    LED-076
    LED-077
    LED-078
    LED-078a
    LED-078b
    LED-080

DISAGREE (11):
    LED-064
    LED-066
    LED-067
    LED-067a
    LED-068
    LED-070
    LED-073
    LED-074
    LED-079
    LED-081
    LED-081a

UNSURE:   0
MISSING:  0
```

These are per-entry Batch-1 verdicts, not the final a5b cross-entry consistency
pass.

---

# 3. F1 - Source-coverage / segmentation defects
## Affects LED-067, LED-068, LED-070

The population/coverage prerequisite passed, but the actual claim coverage of
authority lines 716-876 is not complete.

## F1.1 Authority line 718 - Architecture A REJECTED heading

Authority line 718 is:

```text
Architecture A - old separated-field union grid - REJECTED
```

That is a substantive status proposition, not merely a decorative heading.

The map/ledger assigns 718-726 wholly to LED-064, whose claim is the old
step-4 primary/midpoint mechanism. The rejection status itself belongs with
LED-067's proposition (`The geometry mechanism itself is rejected`) or an
equivalent atomic status entry/occurrence.

Required:
- capture line 718 explicitly as an occurrence of the A-rejection proposition;
- do not let LED-064's mechanism-history claim silently absorb the status word
  `REJECTED`.

This is why LED-067 is DISAGREE even though its substantive CURRENT-DUPLICATE
rejection disposition is sound.

## F1.2 Authority line 749 - Architecture B SUPERSEDED BY B2 heading

Authority line 749 is:

```text
Architecture B - generic region phase - SUPERSEDED BY B2
```

That status proposition is not the same proposition as LED-068's historical
description of B's phase-energy pipeline.

The supersession belongs with LED-069's "B2 replaces it" proposition or an
equivalent atomic status occurrence.

Required:
- record line 749 under the supersession proposition;
- keep LED-068 limited to what Architecture B was.

This is why LED-068 is DISAGREE while LED-069's substantive supersession
disposition remains AGREE.

## F1.3 Authority line 763 - B2 PRIMARY CANDIDATE is unadjudicated

Authority line 763 is:

```text
Architecture B2 - PRIMARY CANDIDATE
```

This is a current architectural-status proposition and no Batch-1 entry
dispositions it.

LED-070 begins at the four-layer architecture structure. It does not adjudicate
B2's `PRIMARY CANDIDATE` status.

This is a genuine omission under the exact-source-coverage rule.

Required:
- create an atomic entry for B2 PRIMARY-CANDIDATE status, or explicitly add
  that proposition to a compatible entry only if the disposition/action/evidence
  are truly the same;
- do not use entry count as a target.

The proposition is visibly duplicated in current continuity/design material,
so W3C expects CURRENT-DUPLICATE / Tier C, subject to W3D's proper bounded
probe/classification.

This is the principal reason LED-070 is DISAGREE: its declared source segment
contains an unadjudicated current status proposition.

---

# 4. F2 - Architecture-A sweep missed current Grid Knowledge
## Affects LED-064 and LED-067

The ledger treats the README as the important current-corpus contradiction for
old Architecture A. That is not the only one.

`Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_2.md` remains in the 38-file
applicable corpus and still carries the old separated-field pitch/midpoint
model as current knowledge.

Material examples include:

```text
lines 20-28:
    field separation determines edge_step_y;
    "midpoint machinery exists";
    practical modes -> "midpoint machinery is confirmed required"

lines 53-70:
    FIELD-DCT -> pitch-8 after separation;
    FRAME-DCT -> pitch-4 after separation;
    pitch-4-only rows are "midpoints"

lines 124-150:
    "The midpoint machinery (the regime-3 answer)";
    filter pitch-8 always;
    conditionally filter pitch-4-only midpoints

lines 233-258:
    practical XP/SP/LP/EP -> midpoint machinery "CONFIRMED REQUIRED";
    mixed regime expected to validate the midpoint machinery.
```

Those passages are semantically central to the rejected A-era separated-field
geometry. They were not classified in LED-064/067's sweeps.

Required:
- open/classify Grid Knowledge v1.2 explicitly in the Architecture-A mechanism
  and rejection evidence;
- record that it carries the old mechanism while presenting it as current
  knowledge, rather than treating README as the only applicable current
  contradiction;
- route its retirement/correction through the project's existing knowledge
  cleanup path; do not adjudicate an unrelated future file silently.

W3C does NOT reopen the settled authority decision that A is rejected. The
finding is about the applicable corpus and propagation of stale A-era
knowledge.

---

# 5. F3 - LED-066 is non-atomic / duplicate evidence does not support all five clauses

LED-066 claims one retained-from-A proposition consisting of five items:

```text
creation-time fixed-point conversion
immutable threshold sets
no float/multiply in the pixel loop
deterministic/stateless operation
uncertainty should be measurable and explicit
```

It then proves duplication by citing Re-Decision Evaluation recommendation 4
as:

```text
CARRIER, a subset of the five
```

A subset does not establish duplication of the five-item proposition.

The Evaluation does support several of the retained engineering ideas:
- fixed-point / immutable / no-float discipline;
- deterministic/stateless operation;
- final recommendation to retain A's good engineering ideas.

W3C did not find an equivalent second carrier for the distinct proposition
that `uncertainty should be measurable and explicit` was retained FROM A.

Required:
- split/narrow the retained-practices proposition atomically;
- classify the duplicated retained-engineering subset separately;
- give the uncertainty/measurability clause its own bounded evidence and
  disposition;
- do not infer uniqueness or duplication of that clause from the conjunction.

The broad architectural point "good engineering ideas survive A" remains
sound. The disagreement is with the atomic claim and evidence, not with that
project direction.

---

# 6. F4 - LED-067a pointer is directly supportable from Appendix C

LED-067a says:

```text
Appendix C gives the exact proof.
```

The ledger verifies only Appendix C's existence/heading and defers the content
question because Appendix C is outside the current adjudication range.

That is unnecessarily weak. Review Scope 0.6 permits out-of-range material to
be READ as evidence without adjudicating that occurrence.

W3C read Appendix C lines 1873-1901. It gives the compact permanent rejection
proof:

```text
Old A:
    step 4 / primary mod-8 / midpoint mod-8+4;
whole-frame transposition;
Failure 1 - wrong frame-DCT footprint;
Failure 2 - faithful real-geometry union collides / double filtering;
Failure 3 - threshold ambiguity is irreducible;
Conclusion - A's engineering patterns survive; union-grid geometry does not.
```

Therefore the pointer is supported: Appendix C does carry the compact exact
Architecture-A rejection proof.

Required:
- change LED-067a's evidence from "existence check only / content not verified"
  to the actual evidence check;
- retain CITED-OUTSIDE-RANGE so a6 still owns Appendix C's own disposition;
- do not treat reading Appendix C as adjudicating it early.

W3C does not object to CURRENT-DUPLICATE if the settled section-0 pointer is
the concrete second occurrence. The DISAGREE is with the under-verified
REASON/CITED record.

---

# 7. F5 - LED-073 combines duplicated role/origin with an apparently unique pointer

LED-073 contains two materially different propositions:

1. D's role/origin:
   detector-free fallback/comparator created during the re-decision, better
   than literal A because it uses the actual whole-frame internal frame edge
   and avoids the union collision.

2. Internal pointer:
   `Its exact Case-(a) luma topology is in section 11.`

The first proposition is widely duplicated and CURRENT-DUPLICATE is sound.

W3C searched the 38-file applicable corpus for semantic and literal forms of
the section-11 pointer. The only applicable project-knowledge statement of the
specific "D's exact Case-(a) topology lives in section 11" pointer was the
authority itself. Other `section 11` references were different propositions or
T1 workshop material.

Required:
- split the line-803 pointer from D's duplicated role/origin proposition;
- give the pointer its own bounded uniqueness evidence;
- W3C presently expects CURRENT-UNIQUE / Tier C for the pointer, while the
  role/origin remains CURRENT-DUPLICATE.

Do not make section 11's later topology content a second carrier of the POINTER
merely because the target exists.

---

# 8. F6 - LED-074's exactly-once ownership is supportably unique, but the entry is non-atomic

W3C attacked LED-074's uniqueness family using exactly-once, single-owner,
half-open, duplicate-descriptor and double-write/collision reformulations.

The core ownership proposition survives:

```text
A horizontal boundary descriptor is owned exactly once for each half-open
x interval [16*n,16*(n+1)).
```

No second carrier of that constructive exactly-once descriptor-ownership rule
was found in the 38-file population. The Re-Decision Evaluation's double-write
material concerns old A's collision or D's disjoint parity writes and is
DIFFERENT.

However, LED-074's CLAIM also includes:

```text
Each macroblock occupies a 16-pixel x segment.
```

That is a separate geometry fact and is duplicated elsewhere in current
architecture material.

Required:
- narrow LED-074 to the exactly-once / half-open descriptor ownership rule;
- move or separately disposition the 16-pixel-segment geometry clause;
- CURRENT-UNIQUE can remain for the narrowed ownership proposition.

Thus LED-074 is DISAGREE on atomicity, not because its central uniqueness
conclusion failed.

---

# 9. F7 - LED-079's disposition is sound; DEC-50 evidence record is incomplete

LED-079's `seam` family is deliberately broad and the semantic classification
structure is good. W3C independently reproduced 18 applicable files with
literal `seam` hits.

The ledger says:

```text
81 raw hits in 18 files; every one was opened and classified.
```

but does not enumerate the 18-file candidate/result population. Under DEC-50,
a bounded/result-count claim must be independently attackable; the reader must
be able to tell which 18 files made up the result.

Required:
- enumerate the 18 candidate files or provide an equivalent attackable
  candidate/result table;
- keep the existing carrier / DIFFERENT-meaning / APPLIES classifications;
- no disposition change is presently indicated.

CURRENT-DUPLICATE / STAY-CANONICAL remains substantively sound.

---

# 10. F8 - LED-081 sweep missed a current semantic carrier

LED-081's proposition is:

```text
D4-D07 UNKNOWN policy is current/provisional, not timeless, and is to be
revisited using measured evidence.
```

The declared probe family includes `revisit`.

The current designer introduction v1.33 explicitly contains:

```text
UNKNOWN-policy revisit using Q14 data
```

at line 779.

That is a semantic carrier of the revisit/provisionality proposition and must
be classified. Several other `revisit` hits are DIFFERENT and likewise cannot
be replaced by a blanket "no other file matched" statement.

Required:
- expand/correct the LED-081 candidate table;
- classify designer introduction v1.33 as a CARRIER of the revisit concept;
- classify remaining returned `revisit` candidates by their actual proposition;
- retain CURRENT-DUPLICATE; the additional carrier strengthens, rather than
  overturns, that disposition.

No new broad search methodology is needed; apply the already-binding rule.

---

# 11. F9 - LED-081a is ERRONEOUS/SUPERSEDED, not CONFLICTING
## Tier A full review

Source text:

```text
Section 15 requires a revisit after measured UNKNOWN prevalence/error costs
are known.
```

W3C read both targets in full.

Section 15, lines 1157-1257, defines the D4-Q14 discriminator experiment:
truth extraction, B2 metrics, D comparator metrics, dataset discipline and the
architecture decision rule. It produces the measurements.

Section 16, lines 1261-1281, is literally titled:

```text
UNKNOWN POLICY REVISIT
```

and states:

```text
After D4-Q14, revisit using measured:
- UNKNOWN prevalence;
- false-confident rate;
- blockiness cost of skipping;
- measured D fallback behaviour;
- whether different UNKNOWN locations deserve different policies.
```

The line-873 sentence therefore names the wrong section.

## F9.1 Disposition

W3C does NOT agree with CONFLICTING.

Section 15 and section 16 are not competing policies from which one must
prevail. Section 15 provides measurements; section 16 contains the revisit
requirement. The line-873 cross-reference is simply false/materially
misleading.

Under the binding SUPERSEDED-KIND rule:

```text
DISPOSITION        SUPERSEDED
SUPERSEDED-KIND    ERRONEOUS
TIER               A
```

The entry remains Tier A because SUPERSEDED is Tier A.

## F9.2 Authority remedy

The proposed one-word correction is technically correct:

```text
line 873:
    Section 15
->
    Section 16
```

No architecture decision changes.

## F9.3 PROPAGATION is mandatory

Because the statement is ERRONEOUS, the binding propagation rule requires a
bounded search for reliance on the false `section 15` routing, not merely a
search for the original wording.

W3C found current applicable orientation/process propagation:

```text
222-INITIAL_BLURB_FOR_CODER_CHAT_v1_7.txt
    line 49: section 15 is listed as a preidentified LED-081
    CITED-OUTSIDE-RANGE obligation.

222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_9.txt
    line 40: LED-081 -> section 15 is stated as the preidentified
    CITED-OUTSIDE-RANGE obligation.
```

The current T1 Batch-1 process material also inherited the same route:
- Population Delta v1.0;
- Population/Coverage Map v1.0.

Those process files are T1 workshop material rather than applicable knowledge,
but they demonstrate the immediate repair surface for the current workflow.

No source/code/kernel dependency was found or is implied.

Required:
- replace CONFLICTING with SUPERSEDED / ERRONEOUS;
- add the required PROPAGATION population/method/candidate classification;
- correct current orientation/process references from section 15 to section 16;
- retain CITED-OUTSIDE-RANGE to section 16/a6 for later adjudication of that
  target occurrence.

## F9.4 The existing SWEPT field is mechanically false

LED-081a's family includes `revisit` but says:

```text
Hits outside the authority: none
```

That is false. The designer introduction alone contains a direct
`UNKNOWN-policy revisit using Q14 data` hit; other files contain DIFFERENT
`revisit` uses.

Every returned candidate must be classified. The corrected PROPAGATION and
SWEPT records can share evidence where appropriate, but they test different
propositions:
- whether another file repeats the wrong section-15 pointer;
- whether current work relies on the wrong routing;
- whether another file carries the valid revisit concept.

Do not collapse those three questions.

---

# 12. LED-076 semantic carrier check

W3C specifically attacked the covering note's requested semantic call.

The Re-Decision Evaluation says frame/field DCT changes one thing vertically:
FRAME has the internal `mb_y+8` edge and FIELD does not.

The authority says:

```text
This is the most direct observable difference between FRAME and FIELD topology.
```

W3C reads the Evaluation passage as a legitimate semantic CARRIER of that
proposition, not merely APPLIES. A cold reader can recover the distinguishing
topology fact from it.

Result:

```text
LED-076 AGREE.
```

No correction is needed.

---

# 13. Historical/naming variances

W3C accepts the recorded handling at LED-075 and LED-077.

The Re-Decision Evaluation's earlier UNKNOWN-policy rows are pre-decision
history, not a present contradiction of the later conservative D4-D07 policy.

Likewise the section-0 `parity edges` wording versus the body `e` / `e+1`
description is a naming/representation variance over the same topology, not an
architectural contradiction.

Result:

```text
LED-075 AGREE.
LED-077 AGREE.
```

---

# 14. LED-078a section-15 cross-note

W3C opened section 15 for evidence only.

Section 15.2 requires Q14 reporting:

```text
results around FRAME/FRAME, FIELD/FIELD and MIXED macroblock-row boundaries.
```

That directly supports the current section-10 requirement that the mixed rule
be covered explicitly by Q14 truth statistics.

The later section remains owned by its later tranche/a6 process as declared;
using it as evidence here does not adjudicate it early.

Result:

```text
LED-078a AGREE.
```

---

# 15. Near-zero Tier-A assessment

W3C agrees with the designer's core distinction:

- Architecture A/B/C sections mostly state historical facts about what those
  designs were and that they were rejected/superseded.
- A statement can remain CURRENT as a true history record even when the design
  it describes is rejected.
- Rejected design text is not automatically a live assertion of that design.

The one Tier-A defect in this batch remains LED-081a, but its correct Tier-A
route is:

```text
SUPERSEDED / ERRONEOUS
```

rather than CONFLICTING.

The discovered Grid Knowledge problem is propagation/stale-current-knowledge
evidence; it does not change the authority's A-rejection status.

---

# 16. Required W3D reissue, bounded

W3C recommends one normal Batch-1 correction generation containing only:

```text
1. Coverage:
   - line 718 A-REJECTED occurrence -> LED-067/rejection proposition;
   - line 749 B-SUPERSEDED-BY-B2 occurrence -> LED-069/supersession;
   - line 763 B2 PRIMARY CANDIDATE -> new atomic disposition.

2. LED-064/067:
   - classify current Grid Knowledge v1.2 as stale A-era mechanism/current
     knowledge evidence; route its cleanup.

3. LED-066:
   - atomicise retained-A practices;
   - do not let a "subset of five" prove the whole five-item proposition;
   - separately test the uncertainty/measurability retention clause.

4. LED-067a:
   - record W3C's Appendix-C content verification;
   - keep a6 ownership of Appendix C's own disposition.

5. LED-073:
   - split D role/origin from the section-11 exact-topology pointer;
   - bounded uniqueness evidence for the pointer.

6. LED-074:
   - narrow CURRENT-UNIQUE to exactly-once / half-open descriptor ownership;
   - separate the duplicated 16-pixel-segment geometry clause.

7. LED-079:
   - enumerate the 18-file candidate/result population for the seam check.

8. LED-081:
   - include/classify designer intro v1.33 and other returned revisit hits.

9. LED-081a:
   - CONFLICTING -> SUPERSEDED;
   - SUPERSEDED-KIND -> ERRONEOUS;
   - Tier A remains;
   - retain Section 15 -> Section 16 proposed authority correction;
   - add mandatory PROPAGATION evidence;
   - correct current orientation/process reliance;
   - repair the false "no outside hits" statement.
```

No a5 reopening.
No old a5 Tier C sampling.
No source/build/test/git.
No final a5b cross-entry consistency pass yet.

---

# 17. W3C state after Batch 1 review

```text
38-file population                 PASS
sections 9-10 architecture reading BROADLY SOUND
Batch-1 ledger                     REISSUE REQUIRED

AGREE                              13
DISAGREE                           11
UNSURE                              0
MISSING                             0

Tier-A expectation after repair    still one Tier-A entry:
                                    LED-081a as SUPERSEDED/ERRONEOUS

next W3D act                       bounded Batch-1 ledger/map reissue
next W3C act                       delta review of corrected Batch 1
later                              continue a5b sections 11-13
```

---

*Revision history*

```text
v1.0 (2026-08-21) First W3C review of a5b Batch 1 against the complete
     2026-08-21 38-file corpus. Reproduces the population exactly and returns
     13 AGREE / 11 DISAGREE. Finds a missing B2 PRIMARY-CANDIDATE proposition,
     heading/status coverage defects at A/B, stale Architecture-A Grid
     Knowledge omitted from the sweep, atomicity defects at LED-066/073/074,
     inadequate LED-079 DEC-50 result enumeration, missed LED-081 revisit
     carrier, and reclassifies LED-081a from CONFLICTING to
     SUPERSEDED/ERRONEOUS while confirming the Section-15 -> Section-16
     authority correction and identifying mandatory propagation.
```
