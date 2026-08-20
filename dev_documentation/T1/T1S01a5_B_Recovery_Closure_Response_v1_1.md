# Deblock4 - W3C Recovery-Closure Delta Review of Ledger v1.7

**Deliverable:** T1S01a5_B - RECOVERY CLOSURE RESPONSE
**Version:** 1.1
**Date:** 2026-08-20
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** `T1S01a5_A_Recovery_Closure_Batch_v3.zip`
**Primary review target:** `T1S01a5_A_Ledger_Body_Part1_v1_7.md`
**Covering note:** `T1S01a5_A_Covering_Note_for_W3C_v1_6.md`
**Method document reviewed:** `Deblock4_T1_W3C_Review_Scope_v1_12.md`
**Work queue checked:** `Deblock4_Standing_Task_Register_T_Series_v1_32.md`
**Manifest checked:** `T1S00_A_Scope_Manifest_v1_7.md`
**Authority checked:** `Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md`
**Nature:** DOCUMENT REVIEW ONLY. No source, build, test, patch or git.
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

Ledger v1.7 is materially better than v1.6 and this review does NOT reopen the
settled a5 Tier C sample, the settled 22-probe search/classification round, the
search methodology or the architecture. Several requested repairs are now
correct: LED-061 is internally reconciled; LED-047's literal-string count is
eight; LED-059 correctly abandons section 15 as the file-level corpus-
composition home; LED-060 reaches line 674; and the two previously omitted
source propositions at authority lines 225-226 and 269 now have entries.

a5 nevertheless cannot close yet. The remaining defects are bounded but real:
LED-043 still contradicts itself in the repaired SWEPT field; LED-055a bundles
two different qualifier propositions and incorrectly calls both unique even
though the Scopes PreScope brief carries the progressive-material generality;
LED-059 still contains stale duplicate/action prose; and the full Tier-A review
of LED-063 establishes that the W3C report CONTENT survives, so the entry is no
longer properly framed as a CONFLICT between section 8 and section 24. The two
new CURRENT-UNIQUE claims also need proposition-specific uniqueness evidence,
and the recovery self-check still contains several v1.6 statements that v1.7
itself disproves.

Review Scope v1.12 is directionally the right consolidation and W3C accepts the
new occurrence-level, cited-outside-range and entry-sweep refinements in
principle. It is not correct as issued, however: it says all rules in section 0
were already ratified while 0.5-0.7 are new criteria still completing their I7
chain, and it immediately omits the new DEC-77 source-coverage rule and the
DEC-64/78 SUPERSEDED propagation refinement. A corrected scope generation
should make those statuses explicit before a5b begins.

This is one more bounded correction generation, not another methodology round.
After those corrections, W3C can review only the changed entries/process
surfaces. Nothing found here supports a new search of the old 22 probes or a
new Tier C sample.

---

# DECISIONS/QUESTIONS FOR W3X

## Q1 - Review Scope v1.12 as a binding consolidation

**Question:** Should Review Scope v1.12 be ratified/treated as the completed
binding consolidation in its present wording?

**Why it matters:** v1.12 was created precisely to stop successors having to
assemble the current method from several documents. As issued, it says every
rule in new section 0 was already binding through a ratified decision, although
0.5 occurrence-level evidence, 0.6 CITED-OUTSIDE-RANGE and 0.7 the entry-sweep
gate are new W3C-originated criteria still completing the W3C-verifies /
W3X-ratifies chain. It also omits DEC-77's exact source-coverage-map rule, even
though DEC-77 explicitly binds a5b, and it does not yet consolidate the
DEC-64/78 SUPERSEDED-KIND / PROPAGATION refinement.

**W3C recommendation:** **Do not ratify v1.12 as-is.** Have W3D issue a
corrected scope generation which:
1. distinguishes previously ratified consolidated rules from the new
   W3C-originated refinements;
2. records W3C verification of the new refinements from this response;
3. includes DEC-77's source-coverage-map requirement;
4. incorporates DEC-64/78 once W3X ratifies that wording;
5. then comes to W3X for ratification as the genuinely consolidated method.

**Options:**
A. Reissue/correct, then ratify - **W3C recommends A**.
B. Ratify v1.12 unchanged - not recommended because it records an I7/status
   chain as already complete when it is not and leaves current method outside
   the supposedly consolidated scope.

Refs: charter I7; DEC-64, DEC-76, DEC-77, DEC-78, DEC-79.

## Q2 - DEC-64 / DEC-78 refined SUPERSEDED propagation wording

**Question:** Does W3X ratify the exact refined SUPERSEDED-KIND / PROPAGATION
wording transcribed at register DEC-78?

**Why it matters:** W3C supplied that refinement in the knowledge-capture
response and has now checked the DEC-78 transcription. It materially preserves
the verified wording: OVERTAKEN versus ERRONEOUS; ERRONEOUS triggers a bounded
search for RELIANCE rather than merely wording; candidate dependencies are
classified and routed; "none found" carries scope/method; no exhaustiveness is
claimed beyond the declared scope. a5 itself has no valid SUPERSEDED entry that
depends on it, but a5b/T3 will meet rejected architecture material.

**W3C recommendation:** **YES.** Ratify DEC-78's refined wording, preferably
while the corrected Review Scope generation incorporates it.

Refs: DEC-64; DEC-78; W3C Knowledge Capture response, Capture 6.

---

# 1. Overall verdict

```text
TIER C SAMPLE                              CLOSED / SETTLED - DO NOT REOPEN
22-PROBE SEARCH / CLASSIFICATION           CLOSED / SETTLED - DO NOT RERUN
CLASSIFICATION REPAIR v1.1                 SETTLED

Review Scope v1.12 consolidation           DISAGREE AS ISSUED
  substantive older-rule consolidation     AGREE
  occurrence-level refinement 0.5          AGREE IN PRINCIPLE / W3C VERIFIED
  CITED-OUTSIDE-RANGE 0.6                  AGREE IN PRINCIPLE / W3C VERIFIED
  entry-sweep gate 0.7                     AGREE IN PRINCIPLE / W3C VERIFIED
  I7 / "already ratified" status wording   DISAGREE
  complete-current-method claim            DISAGREE - DEC-77/78 not consolidated

v1.6 -> v1.7 bounded delta                 REISSUE REQUIRED

LED-043 end-to-end repair                  DISAGREE
LED-055 / LED-055a repair                  DISAGREE
LED-061 end-to-end repair                  AGREE

Q-A source coverage                        SUBSTANTIVE COVERAGE RESTORED,
                                           BUT RANGE/EVIDENCE DEFECTS REMAIN
LED-047 literal-hit correction             AGREE
LED-047 CURRENT-UNIQUE evidence             DISAGREE - inherited method gap
LED-059 section-15 correction              AGREE IN CORE / ENTRY STILL STALE
LED-063 full Tier-A review                 DISAGREE - disposition/frame now wrong

recovery self-check / delta provenance     DISAGREE
register current-state cleanup             DISAGREE
manifest current a5/Tier-C status          AGREE

a5 FORMAL CLOSURE                          NOT YET
a5b START                                  NOT YET
```

---

# 2. Review Scope v1.12 - consolidation review

## 2.1 What is correct

W3C independently checked the consolidated older method against the settled
records.

Correctly carried:
- a5 Tier C is complete: eleven selected, 3 AGREE / 8 DISAGREE, no resampling;
- 47 frozen-survey / 41 adjudication / 46 a5-search-snapshot distinction;
- DEC-60 / DEC-63 / DEC-66 path exclusions;
- DEC-67: open every hit, normalise whitespace, bounded proposition search,
  expand only when a genuine carrier exposes a missed equivalent phrasing,
  rerun the same population, no exhaustiveness beyond population/probe;
- "opening a hit is not the same as reading it";
- "right total can still have wrong members";
- classification labels:
    CANONICAL = home marker
    CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE / MIXED;
- MIXED retains "one file carries more than one meaning";
- DEC-50 check-evidence rule;
- DEC-51 partial-replacement rule;
- DEC-62 tier derivation;
- atomic-claim, SWEPT, STAY-CANONICAL, RETAIN-SUMMARY and POINTER rules from
  the existing v1.11 body.

The working CARRIER/APPLIES test is correctly marked as guidance rather than a
binding mechanical criterion.

## 2.2 The three new refinements are technically sound

W3C VERIFIES IN PRINCIPLE:

### 0.5 occurrence-level evidence

Correct principle:

```text
A FILE-LEVEL SEARCH HIT DOES NOT ESTABLISH OCCURRENCE-LEVEL UNIQUENESS
INSIDE THAT FILE.
```

The proposed FILE / FILE-CLASS / OCCURRENCES representation is appropriate.
MIXED should not be stretched to mean "same proposition twice".

### 0.6 CITED-OUTSIDE-RANGE

Correct principle:
an out-of-range occurrence may be used as evidence for the current
disposition without adjudicating that occurrence early. Its owner/reconciliation
obligation must be recorded so the later tranche cannot silently disagree.

### 0.7 entry-sweep gate

Correct principle:

```text
AFTER EDITING ANY FIELD OF AN ENTRY, RE-READ THE WHOLE ENTRY AND CHECK THAT
NO OTHER FIELD CONTRADICTS THE EDIT.
```

That is a justified new explicit criterion derived from repeated DEC-51-shaped
failures.

## 2.3 What must change before the scope is honestly binding

The header says:

```text
... is verified by W3C and ratified by W3X
```

before this W3C verification and W3X ratification have occurred.

Section 0 also says:

```text
Every rule below was already binding through a ratified decision
```

which is false for new sections 0.5, 0.6 and 0.7. The revision history itself
correctly calls those three "ADDITIONS", which exposes the contradiction.

Use status wording such as:

```text
0.1-0.4 and 0.8 consolidate already-ratified rules.
0.5-0.7 are W3C-originated refinements, drafted by W3D, verified by W3C in
T1S01a5_B_Recovery_Closure_Response_v1_1, and become binding only when W3X
ratifies the corrected scope generation.
```

## 2.4 The "one place" consolidation is already incomplete

DEC-77 says every sub-tranche owes:
- prior-entry overlap protection; AND
- an exact walk of the SOURCE RANGE proving propositions were not skipped,
  with a5b's coverage map produced BEFORE adjudication.

That rule is absent from Review Scope v1.12.

DEC-78 also holds the refined SUPERSEDED-KIND / PROPAGATION wording, which
matters before rejected architecture is adjudicated. If W3X ratifies it, the
binding scope should carry it too rather than immediately recreating the
fragmentation v1.12 exists to remove.

Required: corrected consolidated scope before a5b.

---

# 3. Delta review - what actually changed v1.6 -> v1.7

Mechanical comparison of the supplied ledgers gives:

```text
v1.6 entries: 39
v1.7 entries: 42

ADDED:
    LED-032a
    LED-037a
    LED-055a

EXISTING ENTRIES CHANGED:
    LED-043
    LED-047
    LED-055
    LED-059
    LED-060
    LED-061
    LED-063

NO ENTRY REMOVED.
```

The top/recovery self-check and closing-question material also changed.

That is a useful bounded population for the next correction review.

---

# 4. LED-043 - DISAGREE, still not end-to-end

Most of the required repair is correct.

Correct now:
- GAIS_investigations/ is removed from the applicable (a)/(b) search framing;
- section 3's regime table is correctly named as a noncanonical (a)/(b) copy;
- the Scopes re-decision evaluation is correctly identified as a carrier of
  (c2), the no-fabrication rule.

But the same SWEPT field ends by saying:

```text
IT APPEARS IN THE SCOPES/EVALUATION. That is the concrete non-canonical copy
the (a)/(b) STAY-CANONICAL claim needs...
```

Three lines earlier it correctly says the opposite:

```text
NOT the Scopes evaluation - that carries (c2) only...
```

That is exactly the entry-sweep failure v1.12 section 0.7 is intended to catch.

Required correction:
- remove the stale sentence at the end of the c2 subsection;
- keep section 3 as the (a)/(b) concrete duplicate;
- keep Scopes evaluation attached only to c2.

If the occurrence-level / CITED-OUTSIDE-RANGE refinements are ratified in the
same correction, also record the authority's two c2 occurrences explicitly:
F5 is this noncanonical occurrence; section 15 is the canonical c2 occurrence
owned by a6. Do not use one file-level label to hide that.

No probe rerun is required.

---

# 5. LED-055 / LED-055a - DISAGREE, the most important remaining Tier-C repair

v1.7 correctly recognises that W3C's Tier C finding required atomic treatment
of the derivation qualifiers. That is a real improvement.

But LED-055a still bundles TWO propositions under one CURRENT-UNIQUE
disposition:

```text
(i) progressive/frame-DCT GENERALITY;
(ii) "correctness requirement, not performance preference".
```

The argument used to make the pair unique is:

```text
no other applicable document states BOTH in the same complete form
```

That does not prove either proposition is unique. It proves only that the
CONJUNCTION may be unique.

More importantly, the existing candidate material already refutes uniqueness
of proposition (i). The current Scopes PreScope brief states, in its D4-D01
reason:

```text
SeparateFields tears frame-organised blocks across two clips, so for Case (a)
and for progressive material no field-clip instance can deblock 4:2:0 chroma
at all.
```

That is a direct carrier of the progressive-material generality.

Therefore:

```text
LED-055a proposition (i) is CURRENT-DUPLICATE, not CURRENT-UNIQUE.
```

Proposition (ii), the correctness-versus-performance characterisation, may
still be unique. It needs its OWN bounded proposition-specific uniqueness
evidence before it can receive CURRENT-UNIQUE.

Required:
1. split/narrow LED-055a by proposition;
2. classify the progressive generality as duplicate using the already-open
   Scopes PreScope carrier;
3. run only the bounded proposition-specific check needed for the
   correctness-versus-performance proposition if W3D wants to retain
   CURRENT-UNIQUE;
4. count entries only after the proposition structure is settled.

This is NOT a rerun of the settled 22-probe round. It is evidence for a newly
created CURRENT-UNIQUE proposition which did not exist as an atomic entry in
that round.

### Range defect

LED-055a records:

```text
DOCUMENT ... lines 585-587
```

The quoted qualifier text is actually authority lines:

```text
562-564
```

Lines 585-587 belong to section 6.1. Correct the range.

### Parent LED-055 wording

After the qualifier split, the parent still says:

```text
STAY-CANONICAL for the derivation
```

That is too broad. The parent no longer owns "the derivation" as one
proposition. State the action for the row-projection mechanism / Case-(a)
consequence specifically, and keep the D4-D01 conclusion as its POINTER limb.

---

# 6. LED-061 - AGREE

This requested repair is now applied end-to-end.

The coder introduction and D2 HolyWu schedule:
- remain DIFFERENT in SWEPT;
- are removed from REASON as carriers;
- are removed from DUPLICATE-ACTION as noncanonical copies.

The designer introduction and chat-blurb carriers remain.

No further LED-061 correction is required by the v1.6 finding.

Minor editorial caution only: PREVAILS should not imply that LED-061's standing
rule itself includes LED-061a's unique nuanced instrument assessment. The split
entries already make that distinction visible.

---

# 7. Q-A coverage and ranges - PARTIAL PASS, bounded corrections remain

W3C performed an exact mechanical source-range walk of authority lines 223-715
against all 42 ledger DOCUMENT ranges.

The two substantive omissions W3C found in v1.6 are now represented:
- line 225-226 project-scope/target statement -> LED-032a;
- line 269 default-scope qualification -> LED-037a.

LED-060 now correctly reaches line 674, which its own claim includes.

The remaining uncovered nonblank strings in the mechanical range map are code
fence markers, not source propositions. So the original missing-proposition
coverage defect is substantively repaired.

Three corrections remain.

## 7.1 LED-032a range

The quoted sentence is physically split across authority lines 225-226:

```text
225 Deblock4 is ... initially aimed at PAL
226 576i material recorded by consumer DVD recorders. The purpose ...
```

LED-032a says `line 225`.

Required:

```text
lines 225-226
```

The intentional overlap with LED-033 at line 226 is acceptable because line
226 contains the tail of one proposition and the beginning of another; record
that overlap explicitly rather than hiding it.

## 7.2 LED-032a canonical mapping

ASSERTS says there are two propositions:
- project identity;
- initial PAL-576i consumer-recorder target.

PREVAILS explicitly names the charter for the identity but does not map the
target proposition with equal clarity.

The charter's project definition carries both identity and immediate/originating
purpose. Map the canonical home per proposition, or narrow the entry so one
combined project-scope proposition has one clearly stated home/action.

## 7.3 LED-037a CURRENT-UNIQUE has not earned uniqueness

LED-037a correctly captures the missing source qualification, but its SWEPT
field says:
- no new search was run;
- it relies on LED-038's coordinate-convention probe;
- a document expressing the scoping qualification in different vocabulary
  would not have been returned.

That is an explicit admission that the probe did not search the proposition
whose uniqueness is being claimed.

Under the settled SWEPT + DEC-67 rules, CURRENT-UNIQUE requires a bounded
proposition-specific check. Run one bounded probe for this NEW proposition,
declare the population/method, open/classify its candidates, and then retain or
change the disposition.

Again: this is not a reopening of the old 22 probes.

---

# 8. LED-047 tested-count repair - COUNT PASS; inherited uniqueness gap remains

## 8.1 The requested literal-hit correction passes

A literal whole-authority search for `H.262-VERIFIED` returns EIGHT lines:

```text
33
286
291
298
304
310
338
366
```

v1.7 now reports all eight and correctly distinguishes line 291's compound
`[DERIVED FROM H.262-VERIFIED FACTS]` tag from the standalone verified-tag
population.

That requested DEC-50 correction is correct.

## 8.2 Separate method defect exposed while reviewing the entry

LED-047 remains CURRENT-UNIQUE and says this is:

```text
the only provenance record for the F-series in the live corpus
```

But its SWEPT field tests the truth/completeness of the tag audit INSIDE THE
AUTHORITY. It does not search the live corpus for another F-series provenance
record.

That is the same distinction previously corrected at LED-037:
- truth of an audit;
- corpus uniqueness of the audit/provenance record.

Required: either supply bounded proposition-level uniqueness evidence for the
CURRENT-UNIQUE claim or narrow/change the claim/disposition accordingly.

This finding arises from the explicitly requested LED-047 review; it is not a
Tier C resampling exercise.

---

# 9. LED-059 - core correction AGREE; entry-sweep still FAILS

The important adjudication correction is right.

W3C re-read authority section 15. It does NOT contain the file-level corpus
composition:
- LG MLS;
- LG XP/SP/LP/EP;
- home_576i;
- home_576p.

v1.7 correctly:
- withdraws section 15 as canonical home;
- makes section 6.3 the canonical home for the composition;
- maps the significance sentence to section 6.2 / LED-058.

But two stale pieces remain.

## 9.1 DUPLICATE-ACTION calls the canonical copy noncanonical

After correctly naming Grid Knowledge as a concrete noncanonical copy, the
entry says:

```text
KNOWN NON-CANONICAL COPIES INCLUDE: this section ...
```

"This section" is now the canonical home. Remove it from the noncanonical list.

The designer introduction is also described as naming corpus classes without
the file names. That does not by itself assert the FILE-LEVEL composition.
Unless it actually states the proposition, classify it as APPLIES/related
rather than a duplicate.

## 9.2 PROPOSED ACTION contains stale superseded v1.6 action prose

The current ACTION says:

```text
SUPERSEDED v1.6 TEXT ... W3D specifically does not want this one
ratified as written - see covering note Q5.
```

Historical correction notes belong in REASON/revision history, not in the live
action field. The live action should state only the current proposed action.

Closing Q-F is also still framed around the old conditional section-15 mapping.
Withdraw/update it.

No further section-15 investigation is required.

---

# 10. LED-063 - FULL TIER-A REVIEW: DISAGREE

This is the most important adjudication correction after LED-055.

## Q-A - does the source support the entry's underlying proposition?

YES.

Authority lines 711-712 say the detailed calibration record remains in:
- the W3C verification report;
- raw GAIS evidence files.

Both classes of record exist.

## The W3C report content is now established, not merely "strong likely"

W3C opened:

```text
Scopes/
Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
```

Its header is:

```text
Deblock4 - D4 Pre-Scope - W3C Verification and Independent Design Review
Deliverable: W3C-D4-VERIFY-1
Version: 1.0
From: W3C
Route: W3C -> W3X -> W3D
```

It contains the exact provenance sections the authority cites:

```text
V4.1 Chroma organisation
    Classification: VERIFIED
    H.262 6.1.3
    4:2:0 chrominance always frame-organised for DCT coding

V4.3 dct_type signalling and semantics
    Classification: VERIFIED
    macroblock-level syntax;
    frame_pred_frame_dct conditions;
    dct_type 0 frame / 1 field organisation.
```

Its summary table likewise records V4.1 and V4.3 as VERIFIED.

W3C therefore confirms that the **report content referenced by the authority's
V4.1/V4.3 shorthand survives in this W3C-authored deliverable**.

What remains wrong is the exact filename in section 24 R8:

```text
Deblock4_D4_W3C_Verification_and_Design_Review_v1_0.md
```

No file of that name is present.

That is a reference/filename reconciliation problem for a6, not missing report
content.

## Q-B - is CONFLICTING the right disposition for section 8 lines 711-712?

W3C says **NO**.

CONFLICTING means the proposition contradicts another document and a decision
is needed about which statement wins.

Section 8's proposition:
"the detailed calibration record remains in the W3C verification report and
raw GAIS evidence files"

does not contradict section 24. Section 24 contains a stale/wrong filename for
what the evidence now identifies as surviving report content.

The wrong R8 filename is a separate proposition/reference defect in a6's
territory. It should not make the section-8 pointer itself CONFLICTING.

Required:
- re-disposition LED-063 as a CURRENT proposition after determining whether
  its pointer is unique or duplicated;
- leave the exact R8 filename correction for a6;
- carry a CITED-OUTSIDE-RANGE reconciliation record to section 24.

If CURRENT-UNIQUE is proposed, it needs the normal bounded uniqueness evidence.
If another live document carries the same provenance pointer, use
CURRENT-DUPLICATE and identify the canonical home/action.

## Q-C - what prevails?

There is no "which statement wins" conflict to resolve between section 8 and
section 24.

The evidence supports:
- section 8's substantive pointer survives;
- section 24's exact filename is wrong/stale;
- a6 should correct/reconcile that reference metadata.

## Q-D - anything missing?

Yes: the actual report content was not yet compared in v1.7. That comparison
has now been done above.

## Q-E - reliance on something untrue?

v1.7 still begins REASON by saying:

```text
six documents in GAIS_investigations/ plus two response captures in the root,
all live and in T1's population at T1S01b and T1S05
```

and later says exactly that description is stale under DEC-66.

The entry still contradicts itself. Remove the stale first statement.

Also:
- DERIVED-BASIS says "the four searches above" although SWEPT now enumerates
  five checks/items;
- PROPOSED ACTION still asks whether the report survives, which is now answered;
- DERIVED's conditional consequence for an unlocatable report should be
  updated because V4.1/V4.3 content is retrievable.

## Tier consequence

If CONFLICTING is removed, LED-063 may cease to be Tier A. Do not preserve a
Tier-A count as a target. Recompute tier mechanically from the corrected
disposition.

---

# 11. Occurrence-level / out-of-range handling - W3C answer to Q-K

The principle proposed in Review Scope 0.5/0.6 is correct.

For LED-053d, do NOT use:

```text
MIXED this authority
```

merely because section 4.5 and Appendix A carry the same proposition.

Instead record occurrence-level evidence:

```text
FILE: authority v1.05
FILE-CLASS: CARRIER
OCCURRENCES:
    section 4.5 / lines 528-529     CANONICAL occurrence of pitch-2 proposition
    Appendix A / precise location   CARRIER occurrence of same proposition
```

and:

```text
CITED-OUTSIDE-RANGE:
    Appendix A occurrence
    proposition: Case-(b) woven-frame chroma row pitch 2
    evidence use: establishes duplication in a5
    owning tranche: a6
    obligation: a6 adjudicates that occurrence consistently; a7 reconciles
```

The same pattern is useful at LED-043 for the c2 occurrence in section 15.

This does NOT adjudicate a6 early and does NOT permit a6 to ignore evidence
already used by a5.

---

# 12. Recovery self-check / provenance - DISAGREE

v1.7 still contains multiple statements disproved by v1.7 itself.

## 12.1 Section 0.4c is not the "complete delta set from v1.3"

It lists D1-D7 and then says:

```text
NOTHING ELSE CHANGED.
```

But v1.7 itself adds:
- LED-032a;
- LED-037a;
- LED-055a;
- changes to LED-043, 047, 055, 059, 060, 061, 063;
- new recovery-closure/self-check material.

Either:
- make the delta set genuinely complete through v1.7; or
- rename D1-D7 to the specific post-repair/v1.5 delta class it actually
  describes and separately enumerate the v1.6/v1.7 deltas.

Do not retain "NOTHING ELSE CHANGED".

## 12.2 Section 0.4e still carries mutually impossible entry-count history as live logic

The opening correctly says:
- 39 at v1.6;
- + LED-032a + LED-037a + LED-055a = 42.

But later the same section still says:
- LED-055a was "unmandated and is not created here";
- this ledger's suffix set excludes LED-055a;
- "LED-051 and LED-055 take NO suffix entry";
- the count "lands at 40".

All are false in v1.7.

If historical failed arithmetic is worth retaining, label it as HISTORICAL
FAILED DRAFT TEXT and separate it from the live derivation. Do not leave
present-tense statements that contradict the current entry set.

## 12.3 Section 0.4f contradicts live LED-037

It says the restored LED-037 material includes:

```text
the REASON's original reasoning, which the repair's own probe table endorses.
```

But live LED-037 correctly withdraws the original "no other document can hold
this audit record" reasoning as invalid uniqueness proof.

State exactly what evidence was restored and what old reasoning was deliberately
NOT restored.

## 12.4 Closing questions are a generation behind

At minimum:
- Q-F still asks the old conditional LED-059/section-15 question;
- Q-G still frames LED-063 as a missing-referent conflict;
- Q-H says LED-055 needs no suffix;
- Q-K still asks whether same-file out-of-range evidence needs different
  treatment although v1.12 now proposes the answer;
- Q-K2 says all three partial Tier C repairs are now end-to-end, which LED-043
  and LED-055a show is false.

Apply the entry-sweep principle to the whole ledger's closing/self-check
sections, not only to entries.

---

# 13. Covering note v1.6 - DISAGREE as current review framing

The covering note correctly gives W3C's eight-part agenda and correctly says
the Tier C sample is settled.

But it retains pre-v1.7 recovery text that directly contradicts the supplied
target.

Required corrections include:

```text
Binding work queue:
    v1.30 -> supplied v1.32

Section 2 test:
    "diff v1.3 against v1.5" -> the actual requested v1.6 -> v1.7 delta,
    plus the separate preservation/provenance check against v1.3 where needed

D7:
    v1.30 is no longer current

Entry-count description:
    34 -> 39 is historical v1.6 state, not current v1.7 closure state

Section 3(a):
    says "unmandated LED-055a is not created"
    while v1.7 DOES create LED-055a in response to W3C's finding.
```

The revision history already says v1.7 has 42 entries, so the note contradicts
itself.

This is another DEC-51 / entry-sweep correction, not a new substantive issue.

---

# 14. Standing Task Register v1.32 and T1S00 manifest v1.7

## T1S00 manifest v1.7 - AGREE on the requested state check

The current status correctly says:
- a5 not closed;
- ledger v1.7 awaiting W3C delta review;
- Tier C complete, eleven selected/reviewed, 3 AGREE / 8 DISAGREE;
- no new a5 search/classification round indicated;
- a5b blocked until a5 closure;
- a5b must derive its own population rather than inherit 46.

The frozen T1S00 frame remains separated from current status.

## Standing Task Register v1.32 - current top status good, but stale recovery gate remains

Section 0.1 correctly says:
- ledger v1.7 delivered;
- awaiting W3C delta review;
- not closed;
- 42 entries.

DEC-62's old "W3X ACTION NOW OWED" Tier C instruction has been annotated as
resolved by DEC-73. That fixes the anomaly which previously made the sample
look owed.

However, section `0a. RECOVERY GATE AFTER THE 2026-08-19 W3D SESSION LIMIT`
still reads as a live instruction:
- successor W3D must verify recovery ledger v1.4;
- W3X then owes a special recovery route;
- "READY FOR SUCCESSOR-W3D RECOVERY VERIFICATION".

DEC-70/73 have already discharged that gate.

Required:
mark section 0a unmistakably:

```text
HISTORICAL / DISCHARGED BY DEC-70 AND DEC-73 - DO NOT FOLLOW AS CURRENT STATE
```

or move its useful history to the decision/history layer.

Also, DEC-75 presently says v1.7 completes the three partial Tier C repairs
end-to-end. That statement is disproved by LED-043 and LED-055a and must be
corrected on reissue rather than left as a live accepted claim.

---

# 15. Review of the two NEW coverage entries

## LED-032a

Disposition as duplicate is supportable. Concrete carriers exist.

Required:
- range -> lines 225-226;
- map both project identity and originating PAL-576i/consumer-recorder target
  clearly to their canonical source, or narrow the proposition.

No exhaustive search is needed merely to prove duplication.

## LED-037a

The proposition is worth logging and was genuinely missed.

But CURRENT-UNIQUE is not yet supported. The LED-038 convention search is not a
search for the default-scope proposition, and the entry itself admits that
different wording would escape it.

Required bounded uniqueness check before CURRENT-UNIQUE may stand.

---

# 16. What must be reissued - bounded correction list

W3D should make ONE further correction generation. No open-ended new review
methodology is required.

```text
A. REVIEW SCOPE
   - correct I7/status wording: distinguish ratified consolidation from new
     0.5-0.7 refinements
   - include DEC-77 exact source-coverage rule
   - include DEC-64/78 after W3X ratifies it
   - then W3X ratifies the corrected consolidated scope

B. LEDGER HEADER / POINTERS
   - binding scope v1.11 -> corrected current scope
   - work queue v1.30 -> v1.32 or later
   - reconcile same stale pointers in 0.4b / D7

C. LED-032a
   - range 225-226
   - explicit per-proposition canonical mapping

D. LED-037a
   - bounded proposition-specific uniqueness evidence, or change disposition

E. LED-043
   - remove the surviving c2-carrier -> (a)/(b) evidence contradiction
   - apply occurrence/out-of-range format if the new scope is ratified

F. LED-047
   - literal-count repair retained
   - independently support or narrow CURRENT-UNIQUE provenance-record claim

G. LED-055 / 055a
   - LED-055a range 562-564
   - separate progressive-material generality from correctness-vs-performance
   - progressive generality is DUPLICATED by Scopes PreScope
   - bounded uniqueness check for correctness-vs-performance if claimed UNIQUE
   - narrow parent "derivation" action wording

H. LED-053d
   - replace stretched MIXED use with occurrence-level evidence
   - add CITED-OUTSIDE-RANGE record for Appendix A

I. LED-059
   - remove canonical "this section" from noncanonical-copy list
   - do not call class-only designer-intro material a file-composition copy
     without evidence
   - remove stale v1.6 action prose from live ACTION
   - withdraw/update stale Q-F

J. LED-061
   - no substantive correction from this review

K. LED-063
   - remove stale "root/live/T1S01b/T1S05" GAIS statement
   - record W3C-D4-VERIFY-1 content identity as established for V4.1/V4.3
   - CONFLICTING is not supported; re-disposition section-8 pointer as CURRENT
     after duplicate/unique evidence
   - carry wrong R8 filename to a6 as reference reconciliation
   - four-search -> five-check wording
   - remove "whether report survives" from current action/derived consequence

L. RECOVERY SELF-CHECK
   - fix 0.4c completeness claim
   - remove/relabel stale 0.4e 39/40/no-LED055a logic
   - reconcile 0.4f LED-037 wording
   - refresh Q-F/Q-G/Q-H/Q-K/Q-K2
   - update covering note's target/count/pins

M. REGISTER
   - mark old 0a recovery gate HISTORICAL/DISCHARGED
   - correct DEC-75 "all three end-to-end" statement
```

Only TWO small new proposition-specific searches are presently indicated:
1. LED-037a default-scope uniqueness;
2. LED-055 correctness-vs-performance uniqueness, if W3D wants to keep that
   proposition CURRENT-UNIQUE.

LED-047 also needs uniqueness evidence for its existing CURRENT-UNIQUE
provenance-record claim; this can be a bounded proposition-level check.

These are not a rerun of the settled 22-probe round.

---

# 17. What W3C should review after that reissue

The next W3C pass should be strictly limited to:

```text
1. corrected Review Scope status/consolidation;
2. LED-032a;
3. LED-037a;
4. LED-043;
5. LED-047;
6. LED-053d occurrence/out-of-range record;
7. LED-055 and qualifier split;
8. LED-059;
9. LED-063 re-disposition/reference reconciliation;
10. ledger self-check/closing-question delta;
11. register old-0a / DEC-75 correction;
12. covering-note currency.
```

No unchanged a5 entry needs another substantive review.

If those corrections are clean, W3C presently sees no reason for another
general a5 recovery round. W3X can then close a5 and a5b can begin under the
corrected consolidated method.

---

# 18. W3C state after this review

```text
a5 Tier C sample                    COMPLETE / SETTLED
old 22-probe search                 COMPLETE / SETTLED
classification repair              COMPLETE / SETTLED

v1.7 requested corrections:
    LED-061                         PASS
    LED-047 literal count           PASS
    LED-060 range to 674            PASS
    LED-059 section-15 core fix     PASS
    line-225/269 coverage presence  PASS

remaining bounded defects           PRESENT
a5 closure                          NO
a5b                                 NOT YET

NO architecture reopening.
NO Tier C resampling.
NO old-probe rerun.
NO source/build/test/git work.
```

---

*Revision history*

```text
v1.1 (2026-08-20) Delta review of W3D recovery ledger v1.7 and accompanying
     method/status artifacts. Confirms the settled a5 Tier C sample and 22-probe
     round remain closed. Passes LED-061's end-to-end reconciliation,
     LED-047's eight-hit literal count, LED-060's line-674 range correction,
     LED-059's core section-15 correction and capture of the line-225/269
     source omissions. Requires bounded reissue for: a surviving LED-043
     intra-entry contradiction; LED-055a's non-atomic/incorrect uniqueness
     treatment and wrong source range; new CURRENT-UNIQUE evidence gaps at
     LED-037a and LED-047; stale LED-059 action/duplicate prose; LED-063's
     incorrect CONFLICTING framing after W3C directly verifies that the
     W3C-D4-VERIFY-1 report contains the cited V4.1/V4.3 material; recovery
     self-check partial replacements; register old recovery-gate state; and
     covering-note currency. Verifies Review Scope v1.12's three W3C-originated
     refinements in principle but rejects its claim that they were already
     ratified and notes the supposedly consolidated method omits DEC-77 and
     DEC-64/78. No old search round, Tier C sample or architecture is reopened.
```
