# Deblock4 - W3C Cross-Check of T1S01a5 Re-Sweep

**Deliverable:** T1S01a5_B - RE-SWEEP CROSS-CHECK RESPONSE
**Version:** 1.0
**Date:** 2026-08-19
**Author:** W3C
**Route:** W3C -> W3X -> W3D
**Reviews:** `T1S01a5_A_ReSweep_CrossCheck_Request_for_W3C_v1_0.md`
**Evidence:** `T1S01a5_A_ReSweep_Evidence_v1_0.md`
**Common base used:** `dev_documentation(20260819-042914).zip`
**W3X population direction applied:** exclude `T1/**`; exclude
`GAIS_investigations/**`; treat the two root GAIS response files as moved into
that excluded tree, per W3X's post-snapshot direction.
**Encoding:** US-ASCII; CRLF.

---

# Plain-English summary

The re-sweep is materially better than the previous ledger pass. W3C can
reproduce the proposed 46-file population once W3X's explicit post-snapshot
move of the two root GAIS files is applied, and W3C independently reproduces
EVERY ONE of the 22 probe hit counts in section 3 exactly.

The re-sweep is nevertheless not yet safe to use as a purely mechanical ledger
rewrite. The remaining weakness is exactly QC-3: some returned files are still
misclassified or incompletely enumerated after the hit count has been obtained.
The strongest new W3C findings are that LED-035's Scopes hit is a CARRIER, not
APPLIES; LED-038's 15-hit classification is incomplete and contains a false
`D4-Q01` substring hit; LED-045's two Scopes hits are CARRIERS, not APPLIES;
and LED-061 still has a second false `independent verification` hit in the
coder introduction.

W3C also answers QC-5: the Scopes architecture re-decision evaluation IS a
CARRIER of LED-051's coordinate mathematics under W3D's own carrier
definition. LED-051 is therefore CURRENT-DUPLICATE, with authority sections
4.2/4.3 canonical. Independently, LED-051's DERIVED heading says "thirteen
frame rows", but its own mathematics gives 11 rows for one pitch-2 six-sample
edge and 12 rows for the union of the two parity edges.

No architecture decision is reopened by these findings. They are evidence,
classification, ledger atomicity and one arithmetic-description correction.

No source was modified. No build, execution, test, patch, delivery machinery
or git operation was performed.

---

# DECISIONS/QUESTIONS FOR W3X

## Q1. Ratify the third re-sweep rule only with W3C's refinement

**Recommendation: YES.**

The principle is correct:

```text
SEARCH FOR THE PROPOSITION, NOT MERELY FOR THE SOURCE SENTENCE.
```

But "plausible phrasings" by itself is too discretionary to be a review
criterion. It can turn into either an under-search or an open-ended ritual.

W3C recommends this bounded form:

```text
PROPOSITION-LEVEL SEARCH RULE

For a uniqueness/duplication sweep, an exact quotation from the adjudicated
document is not sufficient evidence of corpus uniqueness.

1. Declare the proposition being searched.

2. Declare a bounded probe family that represents its material concepts,
   including the source wording and reasonable independent reformulations or
   lexical variants where the proposition can naturally be expressed more
   than one way.

3. Run the probe family over the declared population with phrase-level
   whitespace normalisation where appropriate.

4. Open every candidate FILE returned and classify the matched occurrence(s).
   If one file contains materially different meanings, record the mixed
   classification rather than assigning one label from the keyword alone.

5. If opening a genuine CARRIER exposes an equivalent phrasing that the probe
   family did not cover, add that phrasing, record why it was added, and rerun
   the same population.

6. Do not claim exhaustiveness beyond the declared population and probe family.
```

This preserves the insight forced out by LED-053 without making "keep inventing
synonyms until satisfied" into a process rule.

I7 provenance if adopted:

```text
proposer:  W3D, from the LED-053 failure
verifier:  W3C - ACCEPT WITH THE REFINEMENT ABOVE
ratifier:  W3X
```

---

# Consolidated answers to QC-1 through QC-6

```text
QC-1  46-file population                         PASS WITH SNAPSHOT CAVEAT
QC-2  all recorded section-3 probe hit counts    PASS - EXACTLY REPRODUCED
QC-3  hit classifications                        DISAGREE - NOT YET CLEAN
QC-4  "24 of 34 dispositions unchanged"          DISAGREE
QC-5  LED-051 derivation record as carrier        YES - IT IS A CARRIER
QC-6  third method rule                           ACCEPT WITH REFINEMENT
```

---

# QC-1 - population

## Result

PASS, with one explicit reproducibility caveat.

The bytes in the attached common-base ZIP still contain the two raw GAIS files
at documentation root:

```text
GAIS_GATING_RESPONSE.txt
GAIS_MPEG2_GRID_CONFIRMATION_RESPONSE.txt
```

Applying only the path rules literally to that snapshot gives 48 files.

W3X subsequently stated that those two files have been moved into
`GAIS_investigations/**`. Applying that explicit W3X post-snapshot change gives
exactly:

```text
543 total files
46 searched
    32 root
     8 Scopes/
     6 reference/holywu_r9/
```

That reproduces W3D's population.

So the 46 is valid against the CURRENT W3X-declared tree, but not against the
older ZIP bytes without applying the stated two-file relocation.

## The three strays

W3C independently confirms all three.

### 1. `Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md`

It survives the mechanical path rules because it is under `Scopes/`, not
`T1/`. It is a T1 process artifact and is superseded by v1.11.

W3C agrees it should be moved under the T1 retired/process tree rather than
remain in the applicable-search population.

### 2. `T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip`

It survives the path rules and a raw text decode produces a false `q0` hit.

W3C agrees archive containers should not participate in ordinary proposition
text sweeps. The simplest repair is to move this T1 evidence archive under
`T1/`; a general archive-extension rule is also defensible if W3X wants one.

### 3. HolyWu source files

`deblock.cpp`, `deblock_sse4.cpp` and the provenance record can legitimately
match identifier-shaped probes.

W3C agrees that such matches must be classified as IDENTIFIER or by the prose
actually surrounding them, not treated as knowledge carriers merely because a
symbol matched.

---

# QC-2 - the probe counts

PASS.

W3C independently implemented the stated rule:

```text
case-insensitive
whitespace-normalised
file matches if ANY probe term occurs
46-file population above
```

All 22 recorded file-hit counts reproduce exactly:

```text
LED-033    10
LED-034     1
LED-035     9
LED-036     3
LED-037     1
LED-038    15
LED-039     5
LED-040     4
LED-041     4
LED-042    13
LED-043     2
LED-044     2
LED-045     5
LED-046     6
LED-047     1
LED-048    12
LED-049     6
LED-053c    6
LED-053d    2
LED-055     7
LED-058     6
LED-061     6
```

This is a real improvement: W3C is no longer disagreeing about whether the
search ran or what its raw file count returned.

The remaining problem is what those files mean.

---

# QC-3 - classifications

DISAGREE as recorded.

The re-sweep's central method correction is right - OPEN THE HITS - but the
accompanying evidence still contains classification errors and, in several
places, does not enumerate every returned file despite saying that it does.

The following are independently confirmed defects.

## QC3-1 - LED-033: the count is accidentally right while the membership is wrong

The ten files returned by the declared probe are:

```text
111_New_Chat_Introduction_for_Coder_v1_33.md
222-INITIAL_BLURB_FOR_CODER_CHAT_v1_3.txt
222-INITIAL_BLURB_FOR_DESIGNER_CHAT_v1_4.txt
Deblock4_Documentation_Currency_Audit_v1_6.md
Deblock4_Forward_Roadmap_v1_22.md
Deblock4_MPEG2_Deblocking_Investigation_and_Decided_Architecture_v1_05.md
Deblock4_Project_Status_v1_32.md
Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
Deblock4_Session_Bootstrap_Header_v1_3.md
Scopes/Deblock4_T1_W3C_Review_Scope_v1_7.md
```

W3D's narrative instead names **both introductions** and does not name the
Stage-1B3 runtime-guard scope.

The Stage-1B3 hit is:

```text
"Single source of the version string used by the 4.1 summary line."
```

That is a DIFFERENT proposition and is not a carrier of the MPEG-2
single-source rule.

Conversely, the designer introduction really does assert that the MPEG-2
authority prevails, but the declared probe misses it because the wording is:

```text
"PREVAILING MPEG-2 AUTHORITY"
```

rather than the contiguous phrase `prevailing authority`.

So the count of ten is a coincidence: one false candidate enters while one
semantic carrier escapes the probe.

This is direct evidence for the refined QC-6 rule.

## QC3-2 - LED-035: Scopes evaluation is CARRIER, not APPLIES

The Scopes evaluation says:

```text
"Using the familiar Classic 8-bit strength-25 thresholds only as an
ILLUSTRATIVE reference (..., not a Deblock4 acceptance basis)"
```

That explicitly ASSERTS the proposition to the reader.

Under W3D's own vocabulary:

```text
CARRIER = the file ASSERTS the proposition.
APPLIES = uses or depends on it WITHOUT STATING IT.
```

This is therefore **CARRIER**.

The CURRENT-DUPLICATE disposition remains unchanged, but the classification
must be corrected.

The re-sweep text is internally inconsistent here: it calls the set a
"carrier set corrected to nine" while classifying the ninth file as APPLIES.

## QC3-3 - LED-036: use of SA/SB is not automatically a copy of the renaming rule

The three declared-probe hits are:

```text
authority
designer introduction
Project Status
```

The designer introduction is a CARRIER because it explicitly says not to
confuse Architecture A/B with Schedule-SA/SB and says the names were changed
to avoid that collision.

Project Status merely USES `Schedule-SA/SB` while discussing the a4 ordering
defect. That is APPLIES, not a carrier of the renaming/collision rule.

Separately, the Concise Project Summary still uses old:

```text
Schedule A
Schedule B
```

It is not a duplicate copy of the renaming rule. It is stale old terminology
that the renaming rule was intended to replace.

CURRENT-DUPLICATE still holds because the authority's Appendix A and designer
introduction restate the distinction, but the copy list needs semantic
classification rather than "contains the current token".

## QC3-4 - LED-038: "15 HITS, ALL CLASSIFIED" is false as recorded

The actual fifteen include THREE Scopes files:

```text
Scopes/Deblock4_D4_Architecture_ReDecision_Brief_for_W3C_v1_0.md
Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
Scopes/Deblock4_D4_PreScope_Round_Brief_for_W3C_v1_2_CODER_RESPONSE.md
```

The evidence summary says only "two Scopes briefs", so its category totals
account for fourteen files, not fifteen.

More importantly:

```text
Architecture_ReDecision_Brief
    matches `q0` only because `D4-Q01` contains the substring "q0".
    This is DIFFERENT/identifier-like, not APPLIES.

Architecture_ReDecision_W3C_Evaluation
    explicitly defines:
        e = first sample on the q side
        q0 = e
    This is a CARRIER of the coordinate convention, not merely APPLIES.

PreScope coder response
    uses p0/q0 in formulae without defining the convention.
    APPLIES is reasonable.
```

The disposition remains duplicate, but QC-3 and Q15 do not yet pass.

This also shows that a raw substring probe such as `q0` needs especially careful
classification because it matches project identifiers such as `D4-Q01`.

## QC3-5 - LED-042: six Scopes hits, not five

The 13-hit probe returns six Scopes documents, not five.

All six contain either an explicit statement that 4:2:0 chroma remains
frame-organised in Case (a), or verification text directly asserting that
proposition. The evidence document's "five Scopes documents" enumeration is
therefore incomplete.

The disposition remains CURRENT-DUPLICATE.

## QC3-6 - LED-045: the two Scopes hits are CARRIERS, not APPLIES

The Scopes material says in terms:

```text
"F7 TFF/BFF does not affect block geometry."
```

and:

```text
"TFF/BFF does not affect block geometry (it swaps which field is which,
not where boundaries sit)"
```

Those statements ASSERT the proposition.

They are CARRIERS under the stated vocabulary, not APPLIES.

The disposition remains CURRENT-DUPLICATE and STAY-CANONICAL remains
available, but the file classifications need correction.

## QC3-7 - LED-061: W3D fixed D2 but missed the coder introduction's false hit

W3D correctly reclassifies D2's `independent verification` hits as DIFFERENT.

The coder introduction is the same problem. Its hit is:

```text
"I7 independent verification of self-affecting criteria"
```

That is charter/process verification, not the GAIS standing rule.

It is therefore **DIFFERENT**.

Actual GAIS-rule carriers among the six declared-probe hits are:

```text
designer introduction
coder chat blurb
designer chat blurb
MPEG-2 authority
```

The coder introduction and D2 are DIFFERENT.

This does not change W3C's earlier atomic finding: LED-061 still needs the
unique nuanced GAIS assessment separated from the duplicated rule/evidence/
precedence propositions.

---

# QC-3 evidence-format consequence

The re-sweep evidence says:

```text
"the searches, every hit, and a classification for every hit"
```

but several sections provide only aggregate language such as:

```text
"12 hits, all classified as carriers or applications"
```

or omit one member of the returned file set.

That is not yet sufficient to satisfy the new Q15 rule in independently
testable form.

W3C does NOT recommend rerunning the expensive searches again. The raw counts
already reproduce.

The minimal repair is:

```text
for every probe already run:
    record the exact candidate FILE list;
    assign each file CARRIER / APPLIES / DIFFERENT / IDENTIFIER / NOISE;
    give a short reason only where the classification is not self-evident.
```

This converts the existing re-sweep into auditable evidence without creating
another research round.

---

# QC-4 - the claimed "24 of 34 dispositions survive unchanged"

DISAGREE.

The number does not follow from the re-sweep's own stated changes.

Before QC-5, W3D itself identifies five original entries whose dispositions
must be split/changed:

```text
LED-043
LED-053
LED-055
LED-058
LED-061
```

If those are the only disposition changes, then:

```text
34 - 5 = 29
```

original dispositions survive unchanged, not 24.

QC-5 adds LED-051 as another disposition change, so W3C's current result is:

```text
34 - 6 = 28
```

original entries whose disposition does not change.

Other entries have carrier-list, finding, DERIVED or cross-reference
corrections, but those do not make their DISPOSITION field change.

If W3D intended "24 entries need no field correction at all", it must say that
instead and enumerate the 24; the present sentence explicitly says
DISPOSITIONS.

Recommended correction:

```text
remove the 24/34 figure;
recompute after LED-051 and the re-sweep classification corrections are
incorporated.
```

---

# QC-5 - LED-051

## Answer

**YES. The Scopes architecture re-decision evaluation is a CARRIER of the
coordinate mathematics.**

The carrier definition asks whether the file ASSERTS the proposition to a
reader. It does not ask whether the file is ratified, canonical, a working
record, or the final home.

The Scopes evaluation explicitly contains the same mathematics, including:

```text
e = first sample on the q side
R_s(e) = {e-3s, e-2s, e-s, e, e+s, e+2s}
W_s(e) = {e-2s, e-s, e, e+s}

frame-organised:
    e = 8*k
    s = 1

field row map:
    y = 2*r + p

field-organised:
    e = 16*k + p
    s = 2

six taps:
    e-6, e-4, e-2, e, e+2, e+4

worked parity examples:
    e = 16
    e = 17
```

Those are the propositions LED-051 calls `(a)-(c)`.

Therefore:

```text
LED-051 disposition:
    CURRENT-UNIQUE -> CURRENT-DUPLICATE

canonical home:
    authority sections 4.2 / 4.3

concrete non-canonical carrier:
    Scopes/Deblock4_D4_Architecture_ReDecision_W3C_Evaluation_v1_0.md
```

The fact that the Scopes document is the derivation record strengthens its
historical role; it does not make statements physically present in it stop
being copies for uniqueness purposes.

## Additional LED-051 arithmetic wording defect

LED-051's DERIVED heading says:

```text
"THE FIELD-ORGANISED FOOTPRINT SPANS THIRTEEN FRAME ROWS FOR A SIX-SAMPLE
FILTER"
```

but its own following mathematics says:

```text
one pitch-2 six-sample edge:
    e-6 through e+4 inclusive -> 11 frame rows spanned

two parity edges at e and e+1:
    union e-6 through e+5 inclusive -> 12 frame rows spanned
```

There is no 13-row span in the stated sets.

The bounds radii `6 before / 4 after` for one edge remain correct; the error is
the prose/consequence count.

Recommended correction: replace the 13-row claim with the exact distinction
between one-edge 11-row span and two-parity-union 12-row span.

---

# QC-6 - third method rule

**ACCEPT WITH REFINEMENT.**

The LED-053 failure proves the core rule:

```text
an exact phrase search proves only the absence/presence of that phrase;
it does not prove the proposition is absent/present under another wording.
```

W3C's LED-033 result in THIS cross-check proves the same point again: the
declared probe misses the designer introduction's semantic carrier while
picking up an unrelated "single source of the version string" occurrence.

The refined wording is in Q1.

The important safeguards are:

```text
bounded declared probe family;
classification of actual file hits;
mixed-meaning handling;
one recorded expansion when a carrier exposes a new equivalent phrasing;
no exhaustiveness claim beyond the declared method.
```

That is enough. W3C does not recommend a larger search bureaucracy.

---

# Previously sampled findings

W3C confirms W3D's statement that the eight findings from the Tier C sample
are not being resisted.

The re-sweep correctly accepts the substance of:

```text
LED-034  withdraw invented T3 protection-gap DERIVED claim
LED-037  replace "no other document can hold it" with an actual uniqueness
         search
LED-043  split codec-syntax c1 from project-rule c2
LED-046  cross-reference LED-049 -> LED-052a
LED-053  split unique (b) from duplicate (c)/(d)
LED-055  withdraw blanket "derivation is unique"
LED-058  "latent" -> ACTUAL and split the reading rule
LED-061  split the unique assessment and correct the old D2/coder-blurb record
```

The additional QC-3 corrections above refine the re-sweep evidence; they do
not reverse those eight findings.

---

# New LED-052a finding

AGREE.

The live Scopes coder-response still says, for the old field-domain geometry:

```text
"the scheduler should expose separate parity-homogeneous work with row pitch 2"
"the vertical row pack gathers its four logical rows explicitly from
same-field frame rows"
```

That is the old parity-split vertical-row-pack treatment which the authority
now says is retired.

The prior "may still be live" concern is therefore established as an actual
live stale description and should be routed to the Scopes/T1S01b adjudication.

---

# Overall W3C conclusion

```text
SEARCH EXECUTION:
    substantially corroborated

POPULATION:
    corroborated after applying W3X's explicit two-file GAIS relocation

RAW PROBE COUNTS:
    fully corroborated - 22/22 exact

CLASSIFICATION PASS:
    not yet corroborated

ARCHITECTURE:
    not reopened

LEDGER REWRITE:
    should wait for one correction of the re-sweep classification table,
    not another full search round
```

The re-sweep has done useful work and should not be discarded. Its raw search
results are reproducible. The next correction should be a bounded
classification/evidence repair, followed by the ledger rewrite.

---

*Revision history*

```text
v1.0 (2026-08-19) Independent W3C cross-check of the T1S01a5 re-sweep.
     Reproduces the W3X-declared 46-file current population after applying the
     post-snapshot relocation of the two raw GAIS root files. Reproduces all
     22 section-3 probe counts exactly. Refutes full QC-3 classification
     correctness with concrete LED-033/035/036/038/042/045/061 findings.
     Answers QC-5 that the Scopes architecture re-decision evaluation is a
     CARRIER of LED-051 mathematics, changing LED-051 to CURRENT-DUPLICATE,
     and independently finds LED-051's 13-row DERIVED wording inconsistent
     with its own 11-row/12-row mathematics. Rejects the unexplained 24/34
     unchanged-disposition count; current arithmetic is 28/34 after LED-051.
     Accepts the proposition-level search rule with a bounded I7 refinement.
     No source change; no build/test/git.
```
