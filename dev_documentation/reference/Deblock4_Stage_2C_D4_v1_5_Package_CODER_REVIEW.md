# Deblock4 - Stage 2C v1.5 Package W3C Review

**Deliverable:** W3C-2C-V1.5-PACKAGE-REVIEW  
**Package reviewed:** `reference(11).zip`  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Status:** DOCUMENTATION REVIEW ONLY. No implementation has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Current package reviewed

Only the highest-version, non-superseded files were used:

```text
Deblock4_Creation_Error_Message_Table_v1_5.md
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_8.md
holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
holywu_r9/SHA256SUMS.txt and the four pinned upstream files
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_5.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_7.md
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_5.md
Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_2.md
Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_2.md
```

Everything under `superseded_do_not_use_files_in_this_folder/` was excluded.

# 2. Overall result

The package is substantively converged.

W3C found no new defect in:

- the scalar formulas or threshold tables;
- Schedule A or its sequential in-place ordering;
- exact 8-bit or 16-bit matrices;
- non-mod-8 and small-plane behaviour;
- u8/u16 storage and bitsPerSample separation;
- source immutability, properties, plane routing or actual-plane geometry;
- K26 source pin, build record, signed-shift classification or sentinel
  fixtures;
- implemented-tier policy or precedence;
- the mandatory external differential corpus.

The remaining points are document-authority and proof-wording corrections.
They do not require any mathematical re-derivation or new Open Rule Question.

# 3. Independent checks

```text
D1 hashes:
    deblock.cpp       PASS
    deblock.h         PASS
    deblock_sse4.cpp  PASS
    LICENSE           PASS

Pinned-source EOL:
    upstream LF bytes preserved exactly.

Current documentation:
    US-ASCII PASS;
    CRLF-only PASS.

Addendum A:
    fixture body is unchanged from the independently verified version;
    all six sentinels remain the exact four-write fixtures.

Addendum B:
    all stated non-vacuity counts independently recomputed and confirmed:
      C01 3028; C03 3287;
      C09 1596; C10 2881; C11 1596; C12 2881;
      C13 3311; C14 3367; C15 3591;
      YUV420P8 chroma 680;
      YUV422P8 chroma 1442;
      C16 Y/U/V 3311/747/747;
      C17 Y/U/V 1061/215/215.
```

The fixed `core.query_video_format(...)` plus BlankClip-style construction in
Addendum B is feasible according to the official VapourSynth Python and
BlankClip interfaces.

# 4. Numbered findings

## F1 - REQUIRED BEFORE RELEASE: D4's operative authority set still names the preceding versions

D4 v1.5's revision record correctly says the current authority is:

```text
D0 v1.8
D2 v1.5
D3 v1.7
provenance v1.4
Addendum A v1.2
Addendum B v1.2
creation-error table v1.5
```

Its operative text still names the preceding package in several places:

```text
header status                  D3 v1.6
Built from                     provenance v1.3; D2 v1.4; D3 v1.6;
                               Addenda A/B v1.1
in-scope test item             D3 v1.6
S4 acceptance                  D3 v1.6
section 4 implementation       D2 v1.4; D3 v1.6
section 5 acceptance           D3 v1.6
K16                            error table v1.4
section 11 review set          D3 v1.6; Addenda A/B v1.1
```

The general sentence `ALWAYS the highest committed version of each` points to
the right result, but it conflicts with these specific versioned directions.
Two reasonable readers could give priority to different text.

This matters because D3 v1.7 and Addendum B v1.2 strengthen the integer-depth
proof from an optional choice to:

```text
N01c1 fixed 17-bit creation case;
N01c2 fixed 32-bit creation case;
exhaustive direct validation/guard coverage for every depth 17..32.
```

### Required correction

Update every operative D4 authority reference to the current set listed above.

Also replace D4's residual singular `N01c` references in S1, A1b and K29 with:

```text
N01c1 and N01c2, plus the exhaustive 17..32 direct guard test.
```

Update the current cross-document pointers consistently:

```text
D0 K16 / K29 / section 5:
    creation-error table v1.5;
    K29 applies to D3 O-1d, not D3 section 8.

D3 O-1d / section 8 / K16:
    creation-error table v1.5.

D2's unchanged offset-error citations:
    preferably point to current table v1.5 rather than superseded v1.1.
```

This is a release-authority correction, not a new implementation obligation.

## F2 - REQUIRED PROOF-WORDING CORRECTION: error table v1.5 still says "17-bit or 32-bit"

The creation-error table correctly ratifies all three Stage 2C Classic rows.
Its `PROOF STATUS` still describes the integer-depth row as proved by:

```text
an otherwise-valid 17-bit or 32-bit integer creation case
```

That is the superseded proof. Current D3 v1.7 and Addendum B v1.2 require all
of:

```text
an otherwise-valid fixed 17-bit creation case;
an otherwise-valid fixed 32-bit creation case;
an exhaustive direct validation/guard test for every depth 17..32.
```

### Required correction

Replace that one proof-status sentence with the current three-part proof.

The stronger D3/Addendum-B authority already prevents a conforming delivery
from using only one boundary case, so this is not a new technical blocker.
It is nevertheless required to keep the controlling error-table record from
describing a weaker proof than the released scope.

## F3 - NON-BLOCKING GOVERNANCE CLEANUP: Q1's ratification state differs

Current text says both:

```text
D3:
    Q1 is W3X-ratified/resolved and leaves the register on D4 release.

D4:
    Q1 is resolved by S2 but pending W3X ratification of the scope.
```

The required implementation is unambiguous in either reading: retain the
explicit clamps. Only the governance state differs.

### Required cleanup

Choose the actual current status:

```text
before W3X releases/ratifies D4:
    agreed by W3C/W3D; pending W3X ratification;

after release/ratification:
    W3X-ratified and removed from the open register.
```

This does not block implementation once the scope is released.

# 5. Open Rule Questions

No new Open Rule Question is proposed.

The current findings concern internal authority consistency and proof wording,
not a rule that appears wrong or over-constraining.

Q2 and Q3 have not reached their stated triggers because this pass still found
corrections, although no new technical design or arithmetic defect was found.

# 6. Recommendation

No significantly material technical issue remains.

Before release:

1. update D4 and the current cross-document authority pointers;
2. correct the single weaker integer-depth proof sentence;
3. align Q1's governance status.

After those edits, a focused inspection of the changed lines is sufficient.
There is no reason to repeat the formula, matrix, boundary, K26-fixture or
differential-corpus derivations unless those contents are changed.

---

*End of W3C Stage 2C v1.5 package review.*
