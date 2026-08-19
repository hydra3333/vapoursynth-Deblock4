# Deblock4 - W3C Tier C Sample Review for T1S01a5

**Deliverable:** T1S01a5_B - W3C TIER C SAMPLE REVIEW
**Version:** 1.1
**Date:** 2026-08-19
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**W3X-selected Tier C sample:** LED-034, LED-037, LED-040, LED-043,
LED-046, LED-049, LED-051a, LED-053, LED-055, LED-058, LED-061
**Entry text reviewed from:** `T1S01a5_A_Ledger_Body_Part1_v1_3.md`
**Tier selection supplied in:** `Deblock4 - Tier Briefing for W3X, and the
T1S01a5 Tier C Sample v1.0`
**Binding five-question procedure:** `Deblock4_T1_W3C_Review_Scope_v1_11.md`,
section 8
**Common documentation base:** `dev_documentation(20260819-042914).zip`
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

W3X selected eleven of the thirty-three Tier C entries. W3C reviewed exactly
those eleven and did not substitute or expand the sample.

The sample found real entry-level defects that the earlier method review could
not expose. Three entries are clean on substance. Eight need correction, but
most corrections are local: an inadequate CURRENT-UNIQUE SWEPT field, one
wrong cross-reference, several atomic-status failures, and two searches whose
conclusions do not survive inspection of the applicable knowledge corpus.

The strongest findings are LED-043, LED-053, LED-055, LED-058 and LED-061.
Each contains propositions that cannot honestly share the one disposition or
the one uniqueness/duplication story currently recorded. LED-058 additionally
says the old "regime 3, mixed" exposure is latent, but the live Grid Knowledge
document actually uses that wording.

The W3X search-population direction supplied during this review is applied
here: `dev_documentation/T1/**` is process material and is not searched as
applicable knowledge; `dev_documentation/GAIS_investigations/**` is
evidence-only and is likewise excluded. W3X also stated that the two raw GAIS
files formerly at documentation root have now been moved into that excluded
GAIS tree. Ordinary existing retired-tree exclusions remain in force. This
population change removes old T1 ledgers and raw GAIS material from
uniqueness/duplication evidence; it does not remove the entry-level defects
reported below.

No source was modified. No build, execution, test, patch, delivery machinery
or git operation was performed.

---

# DECISIONS/QUESTIONS FOR W3X

None.

The selected Tier C sample produces ledger corrections for W3D. No new
architecture decision is required from W3X here.

---

# Sample result

```text
ENTRY      VERDICT

LED-034    DISAGREE
LED-037    DISAGREE
LED-040    AGREE
LED-043    DISAGREE
LED-046    DISAGREE
LED-049    AGREE
LED-051a   AGREE
LED-053    DISAGREE
LED-055    DISAGREE
LED-058    DISAGREE
LED-061    DISAGREE

AGREE       3
DISAGREE    8
UNSURE      0
MISSING     0
```

A DISAGREE does not necessarily mean the main factual proposition is wrong.
Several sampled entries have the right factual conclusion but an incorrect
disposition boundary, SWEPT basis, provenance split or cross-reference.

The old v1.3 TIER labels are not used to select or limit this review. The
current Tier Briefing identifies these entries as Tier C and W3X selected the
sample.

---

# LED-034 - four-layer statement taxonomy

**VERDICT: DISAGREE as recorded. The CURRENT-UNIQUE finding is independently
supported; the DERIVED proposition is not.**

## Q-A - source support

AGREE.

Authority section 1 explicitly separates:

```text
CODEC FACT
PIXEL GEOMETRY
ARCHITECTURE
KERNEL
```

and states that confusing those layers caused earlier design errors.

## Q-B - disposition

AGREE with `CURRENT-UNIQUE`.

W3C independently searched the applicable knowledge population for the
four-way taxonomy using the entry's own terms and direct variants. The
four-layer taxonomy is stated only in authority section 1. Section 9.3 and
section 13.1 are applications or narrower schedule/kernel distinctions, not
second copies of the same taxonomy.

The exclusion of T1 process material reinforces rather than weakens this
finding: an old ledger copy is not applicable knowledge and does not refute
uniqueness.

## Q-C - precedence

n/a.

## Q-D - omitted material

No material proposition in the declared source range was found unlogged by
this entry.

## Q-E - false reliance

No factual reliance problem found in the findings half.

## Q-F - DERIVED

DISAGREE.

The DERIVED block says the taxonomy needs special protection because T3 might
"reduce section 1" and neither T3 nor the README reclassification rule protects
a CURRENT-UNIQUE statement sitting beside propositions that become pointers.

That is not the current T3 rule.

T3 says to strip **duplicated** knowledge and decisions out of **other
documents** and replace them with pointers to the authority. It also says that
load-bearing content with no existing home is brought to W3X for rehoming.
Nothing in T3 instructs anyone to delete a CURRENT-UNIQUE proposition from its
canonical authority simply because neighbouring text is duplicated.

Recommended correction:

```text
retain CURRENT-UNIQUE;
retain the taxonomy in place;
withdraw the claimed T3-protection gap unless a later task actually proposes
removing unique authority content.
```

The proposed retained result is sensible. The stated reason that a new
protection rule is needed is not.

---

# LED-037 - v1.04 naming-consistency audit claim

**VERDICT: DISAGREE as recorded. The audit claim is TRUE and CURRENT-UNIQUE
appears correct, but the mandatory SWEPT field does not prove uniqueness.**

## Q-A - source support

AGREE.

The authority makes exactly the quoted self-audit claim.

W3C independently repeated the document-local test:

```text
bare old names:
    authority lines 254 and 263

both are explicit identifications of the old README vocabulary.

all other processing-order occurrences in the authority:
    Schedule-SA / Schedule-SB / Schedule-SC
```

So the audit claim is true as written for authority v1.05.

## Q-B - disposition

AGREE with `CURRENT-UNIQUE` as the independently observed outcome.

W3C also searched the applicable knowledge population for the audit
proposition itself and found no second document reporting the same
naming-consistency audit result.

However, the ledger entry's own mandatory SWEPT field does not establish that.
It records the whole-authority search that tests whether the audit is TRUE,
then expressly says it establishes nothing about other documents.

The REASON sentence:

```text
"It is an audit record about this document, so no other document can hold it."
```

is not a uniqueness proof. Another document can plainly repeat or report an
audit result.

Recommended correction: keep CURRENT-UNIQUE, but add the missing corpus search
for an equivalent audit-result proposition to SWEPT.

## Q-C - precedence

n/a.

## Q-D - omitted material

No material source proposition omitted from lines 261-265.

## Q-E - false reliance

No false factual reliance found.

## Q-F - DERIVED

AGREE in substance.

The corpus-wide old Schedule-A/B vocabulary really does survive outside the
authority. In the current applicable population, examples include the charter,
README, Concise Summary, D0 index and Project Status. The precise risk varies
by context - some uses are Classic-specific - but the broader collision the
authority's SA/SB/SC spelling was intended to avoid still exists.

The DERIVED proposal is correctly separated from the CURRENT-UNIQUE audit
finding. It does not leak into the disposition.

---

# LED-040 - plane-relative chroma coordinate rule

**VERDICT: AGREE.**

## Q-A - source support

AGREE.

The authority says chroma coordinates are in the chroma plane's own sample
grid and forbids mechanically deriving a chroma block step by dividing the
luma step by subsampling.

## Q-B - disposition

AGREE with `CURRENT-DUPLICATE`.

Charter invariant B5 states the same rule directly:

```text
Chroma steps are in CHROMA SAMPLE coordinates.
They are never derived by dividing luma steps by a subsampling ratio.
```

## Q-C - precedence

AGREE.

The charter is the canonical home for the project-wide invariant. The
authority copy is a local restatement and should point to B5 under T3.

## Q-D - omitted material

No material omission found in the selected source range.

## Q-E - false reliance

None found.

No DERIVED field.

Population note: the entry's duplicate result remains established without
T1 or GAIS evidence; charter B5 alone is sufficient.

---

# LED-043 - F5, dct_type semantics and the NO_DCT prohibition

**VERDICT: DISAGREE. The provenance diagnosis is directionally correct, but
the entry still hides different statuses and different provenance inside its
proposition (c).**

## Q-A - source support

PARTLY AGREE.

The source supports all quoted text. The problem is how the entry groups it.

F5 contains:

```text
(a) dct_type is macroblock-level where applicable;
(b) frame_pred_frame_dct forces or permits the frame/field choice;
(c1) a macroblock with no coded transform residual does not necessarily carry
     a meaningful dct_type bit;
(c2) such a macroblock MUST NOT be fabricated into a Deblock4 truth class.
```

The ledger currently treats c1+c2 as one proposition "(c)" and calls that
whole proposition a PROJECT RULE.

That is too coarse.

c1 is a codec-syntax/signalling fact. c2 is the Deblock4 experiment-integrity
rule.

## Q-B - disposition

DISAGREE with one `CURRENT-DUPLICATE` disposition covering all of it.

W3C's applicable-corpus search gives:

```text
(a)/(b)
    CURRENT-DUPLICATE
    restated elsewhere in the authority and orientation material

(c1) "no coded residual -> dct_type not necessarily meaningful"
    CURRENT-UNIQUE in project knowledge as presently written
    found only in F5

(c2) "do not fabricate a FRAME/FIELD truth class"
    CURRENT-DUPLICATE
    restated at section 0 item 15 and section 15
```

Under the atomic-claim rule, c1 and c2 cannot remain hidden under one status.

Recommended split:

```text
F5 codec fact:
    (a), (b), and c1
    preserve the H.262-verification provenance as justified

Q14 experiment rule:
    c2
    canonical home section 15
```

If W3D wants c1 separately dispositioned from (a)/(b), that is cleaner still,
because its uniqueness differs from theirs.

## Q-C - precedence

AGREE for the pieces that are genuinely duplicates:

```text
(a)/(b) canonical at F5
(c2) canonical at section 15
```

c1 needs its own unique-status treatment rather than a precedence choice.

## Q-D - omitted material

No missing source sentence, but the internal boundary between c1 and c2 is
missing from the ledger's atomic decomposition.

## Q-E - false reliance

The entry's CLASS says proposition (c) as a whole is a project rule. That is
not correct for c1.

The new W3X population rule also means GAIS material named in the old SWEPT
population is evidence-only and must be removed from the applicable-knowledge
search record. That mechanical refresh does not alter the status result above.

## Q-F - DERIVED

AGREE with the central diagnosis:

```text
the [H.262-VERIFIED] tag currently visually covers a Deblock4 experiment rule
that H.262 cannot possibly state.
```

DISAGREE with the proposed coarse remedy of moving all of "(c)" to section 15.

The clean remedy is finer: retain the codec-syntax part as verified fact and
move/restatement-link only the "must not fabricate truth class" rule to its
Q14 home.

---

# LED-046 - F8, vertical edges are geometry-invariant

**VERDICT: DISAGREE as recorded, for a narrow but concrete traceability error.
The factual disposition and derivation are otherwise sound.**

## Q-A - source support

AGREE.

The source states that frame-vs-field DCT changes row adjacency for horizontal
edges but does not move vertical block columns; vertical luma edges remain
x=8*k.

## Q-B - disposition

AGREE with `CURRENT-DUPLICATE`.

The same geometry rule is restated at section 0 item 5, section 4.4, section
11, and current orientation/status material.

## Q-C - precedence

AGREE.

F8 is a reasonable canonical fact home; later sections express coordinate or
architecture consequences.

## Q-D - omitted material

No material source omission found.

## Q-E - false reliance / record error

DISAGREE with the entry's cross-reference.

It says the retired parity-split vertical description is:

```text
"recorded at section 4.4 and adjudicated at LED-049."
```

LED-049 is the MediaInfo triage entry.

The retirement record is **LED-052a**. LED-052 carries the current vertical
geometry consequence; LED-052a carries the explicit retirement of the old
parity-split description.

Correct that reference.

## Q-F - DERIVED

AGREE.

The short derivation is sound:

```text
F1 gives 8x8 block columns;
field organisation changes row mapping;
a row permutation cannot move a column boundary.
```

The point that this basis should be written down in the authority is
reasonable and remains a proposal rather than leaked findings.

---

# LED-049 - MediaInfo triage route

**VERDICT: AGREE.**

## Q-A - source support

AGREE.

The authority contains the specific command, its legitimate corpus-triage use,
and the explicit warning that it is not per-macroblock Q14 truth.

## Q-B - disposition

AGREE with `CURRENT-DUPLICATE`.

The Grid Knowledge document carries the same MediaInfo route, and the
not-per-MB-truth qualification is repeated in current orientation material.

## Q-C - precedence

AGREE.

The MPEG-2 authority supersedes Grid Knowledge and is the correct canonical
home for the surviving route.

## Q-D - omitted material

No selected-range omission found.

## Q-E - false reliance

None found.

No DERIVED field.

Population refresh only: under W3X's new exclusions the applicable
case-insensitive `mediainfo` carrier set is six files rather than the older
pre-change count. The six substantive non-T1 carriers named by the entry are
the relevant ones, so the disposition is unchanged.

---

# LED-051a - TFF/BFF does not move the spatial row sets

**VERDICT: AGREE.**

## Q-A - source support

AGREE.

Section 4.3 directly says:

```text
TFF/BFF does not alter these spatial row sets.
```

## Q-B - disposition

AGREE with `CURRENT-DUPLICATE`.

This is the local mathematical application of F7, which says field order is
temporal and does not move transform-block boundary locations.

## Q-C - precedence

AGREE.

F7 in section 2 is the canonical general fact. The line-500 copy is a
non-canonical restatement and POINTER is correct.

## Q-D - omitted material

No omitted proposition found in the selected line.

## Q-E - false reliance

None found.

LED-051a reuses LED-045's TFF/BFF population search. W3C independently
confirmed the duplication without needing T1 or GAIS material, so the new
population rule does not disturb this result.

No DERIVED field.

---

# LED-053 - 4:2:0 chroma geometry in chroma-plane coordinates

**VERDICT: DISAGREE. `CURRENT-UNIQUE` is false for at least propositions (c)
and (d).**

## Q-A - source support

AGREE that the authority states all three propositions.

## Q-B - disposition

DISAGREE.

The entry says (b), (c) and (d) are all CURRENT-UNIQUE.

W3C found direct counter-evidence inside the applicable knowledge population.

### Proposition (c) - no luma-style midpoint/phase ambiguity

This is not unique.

README v1.12 states the same surviving chroma fact multiple times, including:

```text
"chroma uses fixed per-plane steps, with no luma-style midpoint ambiguity"
```

and:

```text
"There is no luma-style primary/midpoint distinction for this chroma preset."
```

The Scopes architecture re-decision material also states that 4:2:0 chroma
rows have no midpoint class.

Those documents contain obsolete surrounding architecture, but this specific
chroma-no-midpoint proposition is the same current fact. It therefore refutes
uniqueness.

### Proposition (d) - Case-(b) woven-frame pitch 2

This is also not unique.

Appendix A of the SAME authority says:

```text
Case (b)
    MPEG-2 FIELD PICTURES. Each coded picture is one field; when represented
    as a woven frame, same-field horizontal filtering uses row pitch 2.
```

That is the same proposition.

### Proposition (b)

W3C did not find a second applicable document stating the full e_c/x_c
coordinate proposition in the same form. It remains a plausible
CURRENT-UNIQUE proposition.

Recommended split:

```text
(b)  CURRENT-UNIQUE

(c)  CURRENT-DUPLICATE
     canonical home: section 4.5
     lower/older copies point here

(d)  CURRENT-DUPLICATE
     canonical home: section 4.5
     Appendix A is the terminology-summary copy
```

## Q-C - precedence

For (c) and (d), section 4.5 is the detailed current geometry home and should
prevail over old README mechanism text and Appendix A's glossary
restatement.

## Q-D - omitted material

No source omission found; the defect is status decomposition.

## Q-E - false reliance

The SWEPT field says the no-phase-ambiguity proposition appears only here.
That is false. README and Scopes contain direct equivalents.

The new T1/GAIS exclusions do not affect this finding.

No DERIVED field.

---

# LED-055 - SeparateFields tearing derivation

**VERDICT: DISAGREE. The one-disposition treatment and the claim that the
derivation is unique do not survive the applicable-corpus search.**

## Q-A - source support

AGREE that section 5 states the tearing mechanism, its 4:2:0 consequence, its
progressive/frame-DCT generality and the whole-frame-input conclusion.

## Q-B - disposition

DISAGREE with the entry as atomically recorded.

The conclusion is plainly duplicated:

```text
whole-frame input only / SeparateFields unsupported
    -> D4-D01, section 0 and multiple orientation/status copies
```

The entry then says the DERIVATION is unique.

That is not true as a blanket statement.

README v1.12 Appendix A.9.3 contains the same key row-projection mechanism:

```text
An MPEG-2 transform block is eight rows.
A 4:2:0 macroblock supplies eight chroma frame rows.
Separating the two fields projects those eight frame rows into four rows in
each field.
```

That is the mechanism the authority uses to explain why one field-clip
instance cannot possess the original frame-organised 8-row block.

Other pieces of the authority's derivation are more specific. W3C did not find
another applicable document stating, in the same complete form, both the
progressive/frame-DCT generality and the final "correctness requirement, not
performance preference" qualification.

So the current bundle contains at least:

```text
duplicated mechanism;
possibly unique derivation qualifiers;
duplicated D4-D01 conclusion.
```

That is exactly the atomic-claim situation the ledger must not hide under one
status.

Recommended correction: split/re-sweep the derivation propositions instead of
calling "the derivation" unique as a unit.

## Q-C - precedence

AGREE that the authority's section 5 is the canonical detailed derivation home
and D4-D01 is the canonical decision home for the conclusion.

But PREVAILS must stop saying:

```text
"the DERIVATION -> this section, uniquely"
```

because the README carries part of that derivation.

## Q-D - omitted material

No source-text omission found. The missing work is atomic decomposition of the
derivation.

## Q-E - false reliance

The SWEPT field found the README as a SeparateFields hit but expressly left
the hit unclassified. Opening that hit reveals the row-projection mechanism
that refutes the entry's blanket uniqueness statement.

This is the exact kind of counter-evidence a SWEPT field exists to force open.

No DERIVED field.

---

# LED-058 - REGIME 3, decision significance and evidence precision

**VERDICT: DISAGREE. The reading-rule clause is unique inside a
CURRENT-DUPLICATE bundle, and the claimed "latent rather than actual"
exposure is false.**

## Q-A - source support

AGREE that section 6.2 states all three quoted propositions.

## Q-B - disposition

DISAGREE with one CURRENT-DUPLICATE disposition covering the whole claim.

The applicable search shows:

```text
(a) REGIME-3/adaptive-capable mapping
    duplicated in section 0, Appendix E and Grid Knowledge

(b) B2 target-device significance
    duplicated in section 0 and orientation/status material

(c1) evidence limit - capability/permission is not proof of actual mixture
    duplicated in section 0 and orientation material

(c2) document-local reading rule:
     historical "regime-3 mix" means adaptive-capable unless Q14 later proves
     actual mixture
    CURRENT-UNIQUE as written
```

The entry itself already admits that the reading rule is unique to section
6.2. Under the atomic-claim rule, that unique clause cannot remain hidden
inside the same CURRENT-DUPLICATE disposition as c1.

Recommended split: separate c2 as CURRENT-UNIQUE.

## Q-C - precedence

AGREE that section 6.2 is the detailed canonical home for the measured
significance/evidence-precision material.

For c2 there is no competing canonical copy because it is unique.

## Q-D - omitted material

No source sentence omitted. The missing ledger item is the separate status of
the reading rule.

## Q-E - false reliance

Two problems.

First, under the new W3X population rule, T1 task-register/resume-brief copies
must not be counted as applicable-knowledge carriers. The substantive
duplication remains established by authority/orientation/status files.

Second, and more important, the SWEPT conclusion says:

```text
"No live document was found asserting that mixture is OBSERVED rather than
PERMITTED"
```

and DERIVED calls the exposure "latent rather than actual".

Grid Knowledge v1.2, which remains in applicable knowledge until it is retired,
says:

```text
frame_pred_frame_dct "No" = 0 = adaptive per-MB (regime 3, mixed).
```

It also calls the MediaInfo-derived answer "authoritative, per-device" and
elsewhere treats REGIME 3 as confirming the old midpoint machinery.

That is exactly the historical shorthand for which the section-6.2 reading
rule exists. The exposure is therefore **actual in a currently searchable
knowledge document**, even though the prevailing authority supersedes that
document on MPEG-2 facts.

## Q-F - DERIVED

DISAGREE with "latent rather than actual".

AGREE with the broader concern that a document-local reading rule is narrower
than the older vocabulary's reach.

Recommended correction:

```text
record the Grid Knowledge hit as actual stale/ambiguous usage;
keep section 6.2's corrective reading rule;
route the Grid Knowledge occurrence to its existing T1/T2 retirement path
rather than describing the risk as hypothetical.
```

---

# LED-061 - GAIS calibration rule

**VERDICT: DISAGREE. The entry mixes a unique assessment with duplicated
rules, and its recorded sweep is wrong under both the old facts and the new
W3X population.**

## Q-A - source support

AGREE that section 8 states four distinguishable propositions:

```text
(a) GAIS was useful for option-generation/reasoning but failed as a
    citation/factual authority;

(b) no GAIS factual claim/quotation/citation enters project knowledge without
    independent verification;

(c) raw GAIS outputs are evidence captures only;

(d) the MPEG-2 authority prevails on MPEG-2 design facts.
```

## Q-B - disposition

DISAGREE with one CURRENT-DUPLICATE disposition covering all four.

The entry's own PREVAILS text says the section carries a justification
"what GAIS was good for and what it failed at - which no other copy carries."

W3C's applicable-population search agrees.

The nuanced assessment in (a) is stated only here in that form.

The other propositions are duplicated:

```text
(b) appears in current introductions/chat blurbs;
(c) appears in the chat blurbs and authority terminology/provenance material;
(d) appears in the authority header's single-source rule and orientation
    documents.
```

Recommended split:

```text
(a) CURRENT-UNIQUE

(b) CURRENT-DUPLICATE, STAY-CANONICAL here if W3X keeps section 8 as the
    standing-rule home

(c) CURRENT-DUPLICATE, canonical location to be stated explicitly

(d) CURRENT-DUPLICATE, POINTER to the header single-source rule
```

The exact housing of (b)/(c) can remain one duplicate entry only if their
canonical-home/action treatment is genuinely identical.

## Q-C - precedence

AGREE that the header is canonical for the MPEG-2 precedence proposition.

Section 8 is a reasonable canonical home for the GAIS-specific standing
verification rule because it carries the rule together with its calibration
context.

The unique assessment needs no precedence action.

## Q-D - omitted material

No source sentence omitted. The omission is the separate status of proposition
(a).

## Q-E - false reliance / SWEPT failure

The recorded SWEPT field does not survive inspection.

It says six live files carry the rule, including:

```text
the D2 HolyWu Real Schedule document
the GAIS investigation brief
```

W3C found no GAIS standing rule in D2.

Under W3X's new direction the GAIS investigation tree is evidence-only and is
not in the applicable-knowledge search population anyway.

The sweep also omits an actual applicable carrier:

```text
222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
```

which says:

```text
No GAIS factual claim, citation or quotation enters project knowledge without
independent verification.
```

The applicable carrier family W3C found is the authority, both chat blurbs,
the designer introduction and the coder introduction/general external-fact
rule context. The exact count should be regenerated by W3D under the formal
adjusted population rule.

The two raw GAIS files formerly at documentation root are also no longer
applicable-search carriers because W3X states they have been moved into the
excluded `GAIS_investigations/**` tree.

No DERIVED field.

---

# Effect of the W3X T1/GAIS search exclusion on this sample

The rule change matters, but it does not erase the sample findings.

```text
T1/**:
    excluded from applicable-knowledge uniqueness/duplication sweeps
    -> old ledgers/process notes cannot refute CURRENT-UNIQUE

GAIS_investigations/**:
    evidence-only, excluded from applicable-knowledge sweeps
    -> raw research captures cannot establish/refute uniqueness

two former root GAIS response files:
    W3X states they have been moved into GAIS_investigations/**
    -> treated as excluded for this review
```

Consequences for the selected sample:

```text
LED-034    CURRENT-UNIQUE still supported
LED-037    CURRENT-UNIQUE still supported independently; its own SWEPT field
           still needs the missing uniqueness search
LED-040    duplicate unchanged
LED-043    substantive atomic/provenance finding unchanged; remove GAIS from
           its applicable SWEPT population
LED-046    duplicate/cross-reference finding unchanged
LED-049    duplicate unchanged; old search count mechanically shrinks
LED-051a   duplicate unchanged
LED-053    uniqueness still refuted by README/Scopes/Appendix A - no T1/GAIS
           dependency
LED-055    derivation counterexample is README - no T1/GAIS dependency
LED-058    actual "regime 3, mixed" counterexample is Grid Knowledge - no
           T1/GAIS dependency
LED-061    materially affected: its search population and carrier list must be
           rebuilt, but the atomic-status defect remains independently
```

---

# Consolidated correction list for W3D

```text
LED-034
    keep CURRENT-UNIQUE
    withdraw unsupported T3-protection-gap DERIVED proposition

LED-037
    keep audit TRUE and CURRENT-UNIQUE
    add an actual corpus SWEPT basis for uniqueness

LED-040
    no substantive correction

LED-043
    split c1 codec fact from c2 experiment rule
    do not move the codec fact into Q14
    assign statuses atomically
    refresh SWEPT without GAIS/T1 evidence

LED-046
    LED-049 cross-reference -> LED-052a

LED-049
    no substantive correction
    refresh old corpus-count wording under W3X exclusions

LED-051a
    no substantive correction

LED-053
    split (b)/(c)/(d) statuses
    (c) duplicate in README/Scopes
    (d) duplicate in Appendix A

LED-055
    withdraw blanket "derivation uniquely" assertion
    classify the README row-projection duplicate
    split/re-sweep unique derivation qualifiers separately from duplicated
    mechanism/conclusion

LED-058
    split unique reading rule from duplicated evidence-precision proposition
    correct "latent rather than actual": Grid Knowledge already says
    "regime 3, mixed"
    refresh T1-excluded carrier list

LED-061
    split unique GAIS assessment from duplicated rule/evidence/precedence
    remove excluded GAIS evidence from SWEPT
    remove false D2 carrier
    add omitted coder-chat-blurb carrier
```

---

# Current W3C position

This is a **Tier C sample response**, not the complete T1S01a5 adjudication
response.

The sample demonstrates that the routine entries need another designer pass
before W3C should treat the a5 ledger as ready for closure. The defects are
mostly bounded and do not reopen the MPEG-2 architecture itself.

The pending designer formalisation of W3X's T1/GAIS search-population rule
should be applied to the complete ledger before the next full a5 package is
issued. W3C should then review the corrected sample entries by delta and
continue with the Tier A/full-review obligations required by the binding
scope.

---

*Revision history*

```text
v1.1 (2026-08-19) W3X-selected Tier C sample review. Reviews exactly
     LED-034, 037, 040, 043, 046, 049, 051a, 053, 055, 058 and 061 under the
     five Tier-C questions plus Q-F where applicable. Applies W3X's interim
     applicable-knowledge population direction excluding T1/** and
     GAIS_investigations/**, including the two raw GAIS files W3X states have
     now been moved there. Returns 3 AGREE and 8 DISAGREE. Key findings:
     LED-043 needs a finer codec-fact/project-rule split; LED-053's claimed
     uniqueness is refuted by README/Scopes/Appendix A; LED-055's supposedly
     unique tearing derivation is partly duplicated in README; LED-058's
     claimed latent "regime-3 mix" exposure is actual in Grid Knowledge; and
     LED-061 mixes unique and duplicate propositions while its SWEPT carrier
     list is materially wrong. No source change; no build/test/git.
v1.0 (2026-08-19) Earlier T1S01a5 method review; formal entry review stopped
     before Tier C sampling.
```
