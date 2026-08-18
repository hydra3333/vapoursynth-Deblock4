# Deblock4 - T1S00_B W3C Review of Scope Manifest v1.0

**Deliverable:** T1S00_B - CODER RESPONSE
**Version:** 1.0
**Date:** 2026-08-18
**From:** W3C
**Route:** W3C -> W3X -> W3D
**Reviewed:** `T1S00_A_Scope_Manifest_v1_0.md`
**Reference set used:** current supplied `dev_documentation` corpus, current supplied
`src` tree, T1 review scope v1.4, and most-recently supplied Task Register v1.4.
**Scope:** PR-4 / manifest-frame review only. No document adjudication for T1S01
or later has been performed here.
**Encoding:** US-ASCII; CRLF.

---

# Summary

I independently checked the manifest against the supplied corpus rather than
accepting its document list or term set at face value.

The manifest has done valuable work. I independently confirm the important
historical finding that the earlier ROOT-only survey omitted the live `Scopes/`
and `GAIS_investigations/` folders; the six architecture-record files and six
GAIS files now identified there genuinely belong in the reference frame.

However, I do **not** recommend starting T1S01 from manifest v1.0 unchanged.
There are two frame-level issues to correct first:

1. the current manifest is not a mechanically complete/consistent inventory of
   the most-recently supplied live corpus; and
2. the 42-term set is a good first pass but is not broad enough to identify all
   load-bearing MPEG-2/Deblock4 statements inside the documents it finds.

The cheapest correction is a manifest v1.1 before T1S01. No architecture
decision changes.

---

# DECISIONS/QUESTIONS FOR W3X

## Q1 - Should W3D issue manifest v1.1 before beginning T1S01?

**Recommendation: YES.**

The manifest itself says corrections found by W3X/W3C are folded in before
T1S01. I found population/count/version defects plus PR-4 term gaps. They are
cheap to fix now and expensive after ledger numbering/adjudication starts.

### Required v1.1 changes

- make the document population an explicit recursive inventory rather than a
  search-result population;
- state every deliberate exclusion from that inventory;
- reconcile live version families / T1 self-artifacts;
- use the current Task Register generation or explicitly exclude the evolving
  Task Register from T1 adjudication;
- correct the 48-versus-49 document count;
- correct the T1S01 exact hit total;
- extend the term set as described under PR-4 below.

**Refs:** T1S00-F1, T1S00-F2, PR-4.

## Q2 - Should document selection and term searching be separated as two distinct mechanisms?

**Recommendation: YES.**

Use:

```text
POPULATION:
    recursively enumerate every file in the supplied live documentation tree;
    then apply only EXPLICIT, recorded exclusions.

SEARCH:
    run the registered term set across that already-known population to find
    candidate lines/statements and to quantify coverage.
```

This is stronger than "the search builds the list". A zero-hit document then
cannot disappear, and adding a new folder cannot silently remove it from the
population. It directly addresses the folder-selection failure that produced
PR-5.

The manifest already behaves partly this way because it deliberately retains
zero-hit root documents. v1.1 should make that logic formal instead of leaving
inventory and search conflated.

**Refs:** T1S00-F1, PR-5.

## Q3 - Should the retired-folder assumption get one additional cheap mechanical guard?

**Recommendation: YES, but this need not become a 350-file adjudication.**

I do **not** recommend reading all retired material. I recommend one mechanical
check in addition to the existing live-citation check:

```text
For each retired text-document family with MPEG-2/Deblock4 hits, verify that
there is either:
    (a) an obvious live successor/current home; or
    (b) an explicit historical/superseded reason.

Flag only families with no live successor/current home for targeted review.
```

The manifest itself correctly calls retired-folder exclusion its largest
remaining assumption. Given this project's history, a cheap orphan-family
check is proportionate insurance. It should not delay T1S01 if W3X expressly
accepts the existing exclusion instead.

**Refs:** T1S00-F4.

---

# PR-4 - independent review of the term set

## Verdict: DISAGREE WITH SUFFICIENCY; AGREE WITH THE DIRECTION

The current 42-term set is substantially better than the outgoing designer's
seven-term search and catches the known old blind spots such as bare `8x8`,
macroblocks, `frame_pred_frame_dct`, SeparateFields, pitch, chroma formats and
the rejected midpoint vocabulary.

It is **not sufficient as a statement-level search set** for the current
architecture. Important statements can be written using only schedule,
detector, threshold, topology, crop/origin or Q14 vocabulary without using any
of the 42 registered terms on the same line.

This matters because T1's completion claim is about every MPEG-2-bearing
statement, not merely every document.

## Recommended additions

I recommend adding a second set, grouped by reason rather than simply adding
generic `edge` or generic `detector`, which would create excessive unrelated
hits.

```text
GROUP 8 - general geometry and scheduling
    \bgrid\b
    \bdct\b
    frame pictur
    frame.coded
    field.coded
    whole.frame
    interleav
    schedule
    processing order
    block boundar
    candidate edge
    topology
    mixed.boundar

GROUP 9 - B2 / Q14 detector vocabulary
    \bB2\b
    classifier
    confidence
    \bUNKNOWN\b
    NO_DCT
    D4-Q
    Q14

GROUP 10 - activation / correction / analyser vocabulary
    threshold
    activat
    alpha
    beta
    full strength
    half.correct
    strength map
    pre.pass
    unmodified source
    fmparallel
    proper chroma
    luma.on.chroma

GROUP 11 - known load-bearing residual topics
    grid origin
    crop
    nominal grid
    grid.shift
    motion compens
    MBAFF
    regime
```

The dot notation above follows the manifest's existing regex convention.

### Why these are not speculative additions

Independent scans of the supplied corpus found, outside the current 42-term
line set, substantial current material using exactly this vocabulary. Examples
include:

- `schedule`: current schedule/output-order rules and HolyWu schedule material;
- `threshold` / `activation`: PR-1/PR-2-adjacent kernel-gating statements;
- `B2`, `Q14`, `confidence`, `UNKNOWN`, `NO_DCT`: the present classifier and
  experiment architecture;
- `pre-pass`, `unmodified source`, `fmParallel`: the detector/analyser
  determinism rules;
- `crop` / `grid origin`: a known load-bearing grid-origin/pipeline constraint;
- `proper chroma`: a separately settled-by-design quality area;
- `nominal grid`, `grid shift`, `motion compensation`: the D4-Q11 limitation;
- `regime`: the target LG measurement and triage language;
- bare `DCT`, `frame picture`, `frame-coded` / `field-coded`: standard/geometry
  discussion that need not contain `dct_type` or `field DCT` on the same line.

I would **not** add bare `boundary` or bare `detector`: in this repository they
also describe delivery boundaries and CPU detection and would add large
quantities of unrelated material. The more specific phrases above preserve the
manifest's deliberate bias toward over-inclusion without making the search
needlessly noisy.

---

# PR-5 - folder-selection finding

## Verdict: AGREE, independently confirmed, with one present-generation qualification

I independently confirm the substance of PR-5.

The outgoing Q4 evidence shows that the earlier command was a root-level
`for %f in (*.md)` search. A recursive scan of the supplied current corpus
shows that the architecture-record files under `Scopes/` and the six
`GAIS_investigations/` files are outside that old selection domain. Under the
manifest's current 42 terms they account for:

```text
Scopes architecture record:     6 documents, 486 hit lines
GAIS_investigations:            6 documents, 233 hit lines
                                ---------------------------
                                12 documents, 719 hit lines
```

So this was indeed a **folder/population-selection failure**, not a weakness of
the old seven search terms.

### Qualification

The current supplied `Scopes/` folder now contains additional live **T1 process
artifacts** as well as the six architecture-record documents. The manifest
lists only the six architecture records while describing the earlier problem
as an entire-folder omission.

That may be completely intentional: T1 should not recursively adjudicate its
own evolving review scopes and response documents. But the exclusion must be
explicit in the population rules. Otherwise "every live document" is false as
written and a future reviewer cannot tell an intentional self-artifact
exclusion from another missed file.

PR-5 therefore stands, but v1.1 should formalise the self-artifact policy.

---

# T1S00-F1 - METHOD / POPULATION DEFECT: the stated 49-document population does not reconcile

## Verdict: MISSING / METHOD CORRECTION REQUIRED BEFORE T1S01

The explicit tables in section 3 contain:

```text
root                         34 entries
Scopes architecture record   6 entries
GAIS investigations          6 entries
HolyWu provenance             2 entries
                             ----------
                              48 entries
```

not 49.

The revision history repeats "49 live documents", so this is not merely a
single heading typo.

More importantly, the most-recently supplied corpus contains live files that
the manifest does not classify one way or the other:

- multiple live generations of the T-series task register;
- the live T1 review scopes / prior W3C scope review under `Scopes/`;
- the committed outgoing-designer evidence zip.

Some are likely intentional process/evidence exclusions. If so, say so
explicitly. T1 exists because implicit selection decisions are unsafe.

### Current Task Register mismatch

The manifest selects:

```text
Deblock4_Standing_Task_Register_T_Series_v1_1.md
```

but the preparation pack supplied with this step contains **v1.4**, which is
the most recently supplied copy and therefore wins under review-scope 4.2.0b.

The current corpus also contains v1.2/v1.3 outside a retired folder.

v1.1 must decide one of these cleanly:

```text
A. The T-series register is a T1 sweep target:
       use the current generation and record the stale live duplicates.

B. The T-series register is a self-updating T1 process-control artifact:
       exclude the family from T1 adjudication explicitly and audit its final
       pointers/currency at closure.
```

I recommend **B**. Sweeping an actively changing work-queue document during the
work it controls creates recursion and version churn. But the decision belongs
in the manifest, not in reviewer inference.

---

# T1S00-F2 - clerical count inconsistency in the T1S01 assignment

The 13 explicitly listed T1S01 documents sum to:

```text
authority document       395 hits
six Scopes documents     486 hits
six GAIS documents       233 hits
                         --------
                       1,114 hits
```

not the `1,109 hits` stated in section 6.

The approximate `~5,700 lines` is fine; the exact current line total is about
5,741 and is properly presented as approximate. The hit total is presented as
an exact count and should be corrected.

This is not a conceptual problem, but the ledger's whole purpose is auditable
coverage, so its population arithmetic should be exact before numbering starts.

---

# T1S00-F3 - evidence zip needs an explicit status in the manifest

`T1_Evidence_Old_Designer_3_Answers_to_Designer_4_Questions_files.zip` is a
live, intentionally relied-on reference artifact. Its contents include both
RECORD material and JUDGEMENT material.

The manifest currently treats binary/zip material generally as unsearched,
while simultaneously relying on this particular zip to establish the previous
survey and section map.

Recommended v1.1 wording:

```text
T1 outgoing-designer evidence zip:
    REFERENCE EVIDENCE, not a T1 knowledge-authority sweep target.
    Its named contents may be read where the task register/scope directs.
    Judgement files remain positions to test, never project findings.
    It is excluded from the 48/49 knowledge-document population explicitly,
    not merely because it is a zip.
```

That preserves the carefully designed evidence status and removes an otherwise
ambiguous live-file omission.

---

# T1S00-F4 - retired-folder assumption

## Verdict: UNSURE as a completeness guarantee; acceptable as a bounded cost decision if recorded

I agree with the manifest that retired folders must not be treated as current
authority merely because old text contains attractive reasoning.

I do **not** think folder placement alone proves that no unique still-current
fact was accidentally retired. That proposition is stronger than the evidence
we have, and it resembles the classification-as-skip failure this project is
trying to eliminate.

I therefore recommend the cheap orphan-family mechanical check in Q3, not a
full historical sweep.

If W3X deliberately accepts the residual risk without that extra check, record
that decision and continue; I would not make it an indefinite blocker.

---

# Additional observations

## A1 - the manifest's zero-hit policy is good

Keeping zero-hit documents on the inventory is exactly right. It demonstrates
why the population must come from inventory rather than search results.

## A2 - both live D4 Verification Round Brief generations are correctly flagged

Keeping v1.0 and v1.1 visible until supersession is adjudicated is the right
discipline. Do not silently choose the higher number merely because it is
higher.

## A3 - the T1S01 grouping is reasonable once the manifest is corrected

Authority + architecture working record + GAIS evidence is a coherent high-risk
first ledger-bearing step. I agree with W3D's reason for grouping them, and I
agree that the step may be split at a declared natural boundary if the actual
review load proves too large.

No T1S01 adjudication has been performed in this response.

---

# Release recommendation for the next step

**Do not begin T1S01 adjudication from manifest v1.0.**

Issue manifest v1.1 first, incorporating the population/version/count
corrections and the expanded PR-4 term set.

After that focused correction, I see no reason to repeat the whole T1S00
derivation. A short check that v1.1 absorbed the findings is sufficient, then
T1S01_A can proceed.
