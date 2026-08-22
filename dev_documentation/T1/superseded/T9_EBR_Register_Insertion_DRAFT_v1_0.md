# DRAFT - Standing Task Register insertion for the EBR gate

**Date:** 2026-08-22
**Author:** W3D
**Status:** DRAFT FOR W3X. Two insertions for the register's next bump
(v1.37). The task number "T9" is provisional - W3X assigns register
numbering. Apply verbatim or amend; nothing here is committed until W3X
commits it.

---

## Insertion 1 - one line into section 0.1 THE FULL TASK LIST AND
## SEQUENCING, placed after T1's completion entry and before T3:

```text
T9      External Basis Revalidation gate         REGISTERED 2026-08-22
        (EBR)                                    (W3X-ruled; runs after
        Terminal cross-check of B2's external     T1 completes IN FULL;
        evidence against live primary sources     blocks T3 ratification
                                                  and Q14/kernel scope)
```

## Insertion 2 - new task section, placed after the T8 section:

```text
# T9 - External Basis Revalidation (EBR) gate

REGISTERED 2026-08-22 on W3X's ruling. NOT executed early.

PURPOSE. The T1 sweep proves the corpus is internally consistent; it
cannot prove the foundations. Architecture B2 stands on a bounded set of
EXTERNAL facts the corpus can only cite: H.262 subclause 6.1.3 (4:2:0
chroma DCT blocks always frame-organised - the chroma-defect resolution);
the H.264 clause 8.7 MBAFF concepts behind the mixed-boundary rule; the
RFC 6386 section 15 VP8 material cited in the README; and the section-8
external research-assessment retentions. EBR is the terminal cross-check
that none of these has been invalidated or superseded since verification.
If a foundation fails, the sweep's dependency map ([SPEC-VERIFIED] tags,
CITED-OUTSIDE-RANGE records, the D4 registers, DEC-84 propagation) must
trace what stood on it - a failure that routes cleanly is the process
working as intended, and one that cannot be traced is a process finding
that outranks the fact itself.

METHOD.
1. Enumerate every external-basis claim from the [SPEC-VERIFIED] tags,
   section 7 prior-art items, section 8 retentions, and README external
   citations - a declared population, per DEC-50.
2. Re-verify each against the LIVE primary source at execution time,
   independently of the corpus's record of it.
3. Classify each: VALID / INVALIDATED / SUPERSEDED / UNVERIFIABLE.
4. DEC-84 propagation (scope 0.11, cited not paraphrased) for anything
   not VALID.
5. W3X may need to supply ITU specification PDFs, as in the PreScope
   round; RFC 6386 is freely fetchable.

SEQUENCING. Runs after T1 completes IN FULL (all remaining a5b batches,
a6, T1S02) and BEFORE T3 edits are ratified and before T6/Q14 or any
kernel scope opens. It is the last gate before irreversible work stands
on the foundation.
```

---

Cross-references on application: resume brief v1.17 section 0-CURRENT
carries the same gate and points here; the register's revision note for
v1.37 should cite W3X's 2026-08-22 ruling as the gate's origin.
