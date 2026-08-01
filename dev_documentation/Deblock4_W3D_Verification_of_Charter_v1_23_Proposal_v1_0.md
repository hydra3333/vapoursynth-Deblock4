# Deblock4 - W3D Verification of the W3C-Proposed Charter v1.23

**Version:** 1.0
**Date:** 2026-08-01
**Author:** W3D (independent verifier, per the proposal's own I7 discipline)
**Reviews:** the W3C review document "W3C Review - Proposed Charter v1.23" and
its accompanying v1.22 -> v1.23 diff.
**Verified against:** the W3D-held charter v1.22 AND W3X's confirmation of the
on-disk v1.22 (see item C3).
**Encoding:** US-ASCII; CRLF.
**Status:** VERIFIED WITH ONE CORRECTION. I7 and its placement are endorsed;
three of the four mechanical items are confirmed; C3 is NOT confirmed by either
independent copy and must be REMOVED from v1.23. A brief W3C recheck of its
remaining mechanical observations is requested before W3X ratifies.

---

## 1. Provenance (I7 applied to this very change)

```text
proposer:   W3C  (the charter rule will also govern W3C work)
verifier:   W3D  (this document)
ratifier:   W3X  (pending; nothing below is normative until W3X ratifies)
```

The proposal correctly marked itself and did not self-adopt. This verification
was performed independently against source, not by accepting the diff.

## 2. I7 - text and placement: ENDORSED

The proposed I7 wording is verified as capturing the settled principle without
overreach:

- It triggers ONLY on self-affecting criteria (a party changing criteria that
  will judge that same party's work). Routine cross-party authoring - e.g. W3D
  writing proof criteria for W3C deliveries - names different proposer and
  affected parties and is untouched.
- The one routine trigger is W3C-authored validation harnesses that judge W3C's
  own deliveries (charter 2.4 makes that normal). The EXISTING flow already
  satisfies I7: the harness arrives inside a delivery, W3D reviews it, W3X runs
  it; nothing is silently absorbed. I7 codifies practice; it does not add
  process.
- The closing sentence correctly preserves W3X ratification/release authority,
  so I7 cannot be read as an adoption bypass.

Placement in Part 2 section 2.2 as I7 (after I6) is correct: 2.3a is document-
version currency; this is an interaction/provenance rule, and I6 is the
adjacent trust rule. Not 2.3a.

The Part 6.1 quick-reference row (C4) is endorsed.

## 3. Mechanical corrections - verification results

### C1 - stale bootstrap self-pin: CONFIRMED; fix endorsed, improvement recommended

Verified in the v1.22 source: the session-bootstrap template pins
`AI_Charter_and_Invariants_Card_v1_17.md / internal version 1.17` - a genuine
defect that would direct a fresh session to a five-generations-stale charter.

The proposed literal fix (pin v1.23/1.23) is acceptable. RECOMMENDED
improvement at ratification: replace the hard number with self-referential
wording so this defect class cannot recur, e.g.:

```text
Charter:
    filename          this charter file (the prevailing version per 2.3a)
    internal version  as stated in this file's header
```

W3X's choice; either form passes verification.

### C2 - charter LF vs the CRLF rule: CONFIRMED; endorsed

Verified: v1.22 is LF-only (zero CRLF, 2236 bare LF). C-DELIV-06 (since v1.19)
requires CRLF for repository text files, and the Stage 1C S3 sweep gate targets
zero LF files. The charter is a repository text file; normalising it to CRLF
now is the ratified direction, merely earlier than the sweep. NOTE: this
supersedes W3D's own earlier choice to preserve the charter's found LF
convention - the coder's correction is right and W3D withdraws the LF
preservation.

### C3 - "duplicated revision-history sentence": NOT CONFIRMED - REMOVE FROM v1.23

The W3C review claims the v1.18 revision-history sentence
"G3 one-mechanism paragraph replaced with the ratified mechanism: targets"
appears twice consecutively. Verified independently:

```text
W3D-held v1.22:            the sentence appears EXACTLY ONCE (counted).
W3X's on-disk v1.22:       W3X inspected the file and confirms EXACTLY ONCE.
```

Two independent copies agree; the claimed duplicate does not exist in the
authoritative file. The observation is erroneous (misread, or an artifact of
how the file was viewed/extracted on the W3C side). Consequences:

```text
- The C3 change is REMOVED from v1.23 (it would be a no-op at best, and its
  presence in the revision history would record a correction that never
  happened).
- The v1.23 revision-history bullet describing C3 is deleted.
- The Status-line sentence "two mechanical document defects" becomes "one
  mechanical document defect" (C2; C1 is the bootstrap pin, listed separately).
```

### Consequential request - W3C recheck of its remaining observations

One claimed observation failing independent verification is the standing
trigger to recheck its siblings. W3C is asked to BRIEFLY re-verify, against the
actual prevailing v1.22 file (not a cached or re-extracted copy):

```text
1. C1: quote the exact bootstrap lines showing v1_17/1.17 (expected to stand -
   W3D confirmed it - but re-quote from your copy so we also confirm both
   parties hold the same file).
2. C2: state your copy's CRLF/LF counts (expected LF-only).
3. Re-state where your C3 "duplicate" was observed (which file, which tool),
   so the erroneous observation is understood, not just discarded.
4. Confirm no OTHER mechanical edit rode along in the diff beyond I7, C1, C2,
   C4, and the Status/revision-history text.
```

This is verification hygiene, not censure: the same discipline W3D applies to
its own withdrawn LF choice in C2.

## 4. W3D role wording: ENDORSED for inclusion in v1.23

Verified: the Part 2 role table (v1.22 line 727) reads
"Designer / reviewer (persistent AI session)". That is no longer factually
reliable - the current designer handover to a successor session proves it. The
proposed wording:

```text
Designer / reviewer (continuity-bearing AI role; successor sessions are
oriented by the current designer handover)
```

is accurate and endorsed for inclusion in v1.23 at ratification, marked:
W3C-proposed, W3D-concurred (this document), W3X-ratifies. W3C was correct not
to self-incorporate it; W3D notes for the record that W3D is the party the
wording describes, so the different-party chain here is W3C(propose) ->
W3D(concur) -> W3X(ratify).

## 5. Disposition for W3X

```text
I7 text + 2.2 placement + 6.1 row:   VERIFIED, endorse.
C1 bootstrap pin:                     CONFIRMED defect; fix endorsed
                                      (self-referential wording recommended).
C2 CRLF normalisation:                CONFIRMED; endorsed.
C3 duplicate sentence:                NOT CONFIRMED by two independent copies;
                                      REMOVE from v1.23.
Role wording:                         endorse folding into v1.23.
W3C recheck:                          requested (items 1-4 above) before
                                      ratification.
RATIFICATION:                         W3X's alone, after the recheck returns.
```

On the recheck returning clean (C1/C2 re-confirmed, C3 explained, no riders),
W3X may ratify v1.23 with: I7 + 6.1 row, the C1 fix (literal or
self-referential), the C2 CRLF normalisation, the role wording, and the C3
material removed - and strike "W3C-proposed" from the Status line of the final
prevailing file.
