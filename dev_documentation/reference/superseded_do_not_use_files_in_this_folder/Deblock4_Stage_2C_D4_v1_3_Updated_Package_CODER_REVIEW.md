# Deblock4 - Stage 2C Updated Package W3C Review

**Deliverable:** W3C-2C-UPDATED-PACKAGE-REVIEW  
**Package reviewed:** `reference(9).zip`  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Status:** DOCUMENTATION REVIEW ONLY. D4 remains unreleased. No implementation
has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Current package reviewed

Only the highest-version, non-superseded files were used:

```text
Deblock4_Creation_Error_Message_Table_v1_3.md
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_7.md
holywu_r9/README_provenance_v1_2__replaces_holywu_r9_README_provenance.md
holywu_r9/SHA256SUMS.txt and the four pinned upstream files
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_3.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_5.md
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_3.md
Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_0.md
Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_0.md
```

Everything under `superseded_do_not_use_files_in_this_folder/` was excluded.

# 2. Confirmed corrections and independent checks

The package resolves the major findings from the preceding review:

- D4 now names D0 v1.7, D3 v1.5, provenance v1.2 and Addenda A+B as
  read-together authority;
- the impossible Stage 1C wrapper was replaced by the feasible successor-
  matrix model;
- the provenance document now admits exactly the H0 external-build reader
  while retaining the production-build and EOL prohibitions;
- A1 now uses the ratified non-speculative K24 form and exact u8/u16 storage;
- H5 explicitly forces both scalar paths;
- H4 negative controls are assigned proof surfaces;
- Addendum B supplies an authority-fixed, subsampling-discriminating,
  non-vacuous differential corpus.

Independent verification completed:

```text
D1 upstream hashes:
    all four match SHA256SUMS.txt exactly.

D1 upstream EOL:
    byte-pinned LF files remain LF-only and unchanged.

Current Markdown files:
    US-ASCII and CRLF-only.

Addendum A:
    all six sentinel fixtures reproduce the documented four output samples
    and change no other sample.

Addendum B:
    every stated changed-sample count was independently reproduced:
      C01 3028; C03 3287;
      C09 1596; C10 2881; C11 1596; C12 2881;
      C13 3311; C14 3367; C15 3591;
      YUV420P8 chroma 32x32: 680;
      YUV422P8 chroma 32x64: 1442.
    The unprinted C16/C17 counts are also nonzero on every selected plane.
```

The scalar formula and matrix derivations do not need another review unless
they are changed.

# 3. Numbered findings

## F1 - BLOCKER: valid 17..32-bit integer video input is API-reachable

D4 A1b deliberately leaves a release condition:

```text
If an integer depth outside 8..16 is API-reachable, a further ratified
creation-error row is required before release.
```

That condition is now confirmed TRUE.

The official VapourSynth API contract for `queryVideoFormat` permits video
`bitsPerSample` from 8 through 32. Float is restricted to 16 or 32 bits, but
integer formats may use every valid depth in that 8..32 range. The official
core implementation correspondingly accepts integer 17..32-bit formats and
assigns `bytesPerSample == 4`.

Therefore a valid constant-format integer node above 16 bits can reach Classic
unless Classic rejects it. It is not inconsistent metadata and must not use:

```text
Classic: input video metadata is invalid
```

That row has a different meaning.

### Required correction

Add and ratify a third Stage 2C Classic creation row:

```text
Classic: integer input must be between 8 and 16 bits
```

Update:

```text
creation-error table;
D0 K16 and section 5;
D3 section 8/K16 as applicable;
D4 S1/A1b/section 1/K16;
the production creation-path proof surface.
```

Add an otherwise-valid 17-bit or 32-bit integer creation case asserting the
exact plugin-owned row. A 17-bit or 32-bit Gray/YUV/RGB format can be created
through the normal VapourSynth format API, so this is an invocation-level
case, not merely a synthetic-metadata unit test.

Clarify H4's metadata mapping:

```text
valid integer depth 17..32:
    invocation-level refusal test using the new exact row;

structurally inconsistent metadata:
    direct guard/unit test unless a real API path is demonstrated.
```

The parenthetical `W3C review confirms reachability` should attach only to the
valid out-of-domain integer depth, not to arbitrary inconsistent metadata.

## F2 - REQUIRED PROOF ADDITION: float16 is accepted by VapourSynth but is not tested

S1 correctly refuses every float input by sample type. Addendum B N01 tests
only:

```text
YUV444PS
```

which is 32-bit float.

VapourSynth also supports 16-bit float video formats (`YUV444PH`, `GRAYH`,
`RGBH`). A faulty implementation that refuses only 32-bit float could pass N01
while allowing float16 into the integer-only frame path.

### Required correction

Exercise both accepted float storage widths with otherwise-valid clips:

```text
N01a  YUV444PH -> Classic: float input is not supported
N01b  YUV444PS -> Classic: float input is not supported
```

Equivalent Gray/RGB cases are not additionally required if the production
test proves the refusal is sample-type based before colour-specific pixel
dispatch.

No new error wording is needed; both use the existing ratified float row.

## F3 - REQUIRED PROOF ADDITION: explicit v3 availability is not separately proved

The creation-error table says the availability row is proved through explicit
v2 **and v3** requests on the Stage 2C build.

Addendum B currently has:

```text
N02 explicit v2 on the v3-capable host
    -> backend unavailable;

N03 explicit v3 under DEBLOCK4_FORCE_DOWN=v1
    -> above EFFECTIVE tier.
```

N03 proves precedence, not the normal v3 availability branch. A defect that
handles explicit v2 correctly but permits or misreports explicit v3 could pass
the current matrix.

### Required correction

Add:

```text
N02b backend="x86_64_v3_with_avx2"
     on the normal v3-capable host
     -> "Classic: requested backend is not available in this build"
```

Retain N03 separately as the EFFECTIVE-over-availability precedence proof.

## F4 - BLOCKER: D4 still contains contradictory normative authority and K24 wording

Although D4's header and acceptance section now use the current package, other
operative text still says:

```text
status review with D3 v1.3;
S4 accepted against D3 v1.3;
implementation judged by D3 v1.3;
the new scalar kernel is authored so a later width parameter can instantiate
the same body;
the checklist is headed D0 v1.5;
K1/K24 requires a future width instantiation shape.
```

Those statements conflict with:

```text
D3 v1.5;
S7's ratified no-speculative-vector-API decision;
A1's corrected storage/call-boundary requirement;
the current D0 v1.7 index.
```

Two reasonable implementations could still differ: one could build a
speculative width-generic API to satisfy the old in-scope/checklist text, while
another correctly follows S7 and A1.

### Required correction

Update all operative D4 references, especially:

```text
header status;
section 1 item 1;
S4;
section 4 introduction;
section 9 heading and K1/K24 entry.
```

The governing form should be:

```text
D0 v1.7;
D3 v1.5;
one canonical non-duplicated formula body;
exact u8/u16 storage element instantiations;
no speculative width/vector interface in 2C.
```

Also remove S1's stale statement that error-table ratification is still
required: table v1.3 now states that it is W3X-ratified and controlling.

## F5 - BLOCKER: D0 remains internally contradictory after the narrow exception

D0 v1.7 correctly adds the narrow Stage 2C exception for:

```text
float refusal;
backend-unavailable refusal;
implemented-tier cap;
precedence test.
```

The same section later still says, without qualification:

```text
No change to registration, validation, creation-error strings, tier selection,
G10 modules, or the using-echo surfaces.
```

That directly cancels the preceding exception if read literally.

D0 K24 also still requires the old BackendConfig/width-instantiation model,
contrary to ratified D4 S7.

### Required correction

Rewrite the final no-touch list to say:

```text
No change except the four narrowly authorised Stage 2C items stated above.
```

Update K24 to the ratified S7 form:

```text
one canonical non-duplicated mathematical body and clean scalar boundary now;
no speculative vector API or width-generic interface in 2C;
4C may generalise mechanically but may not fork the formulas.
```

The current creation-error authority should be named as table v1.3, whose
Stage 2C rows include the new F1 integer-depth row once ratified.

Because D0 is the binding index, these are release-blocking authority
corrections rather than cosmetic cleanup.

## F6 - MATERIAL ALIGNMENT: signed-shift sentinel and float wording remain stale in several operative places

The precise classification is now settled:

```text
B2/B5:
    negative signed left-shift UB region in the C++ reference;

B4:
    negative signed right-shift behaviour in a side delta;
    q0-p0 is positive and it is not a negative-left-shift probe.
```

D4 H3 and Addendum A section 7 state this correctly. However, current
operative text still calls all B2/B4/B5 `negative-delta` sentinels in:

```text
D0 K26;
D3 B2 execution-pin note;
Addendum A purpose;
provenance section 5.
```

D3's later checklist corrects the classification, creating an internal
contradiction in the document that judges the delivery.

Likewise:

```text
D3 K22 still says float is conditional;
D2 T-2 and its consequence/checklist still present the float decision as open;
D0's legal-shared-domain text still says integer unless T-2 opens float.
```

D3 section 8 and D4 S1 have already resolved the Stage 2C decision: float is
refused.

### Required correction

Use `K26 signed-shift behavioural sentinels` consistently and state the two
classes accurately wherever the group is named.

Update D3 K22 and D2's T-2 status to:

```text
Stage 2C decision resolved by D4 S1: float is refused now;
the documented HolyWu float facts and future Deblock4 float obligations remain
carried forward for the later bounded float step.
```

This does not alter D2's source facts or reopen float support.

# 4. Addendum B assessment

Subject to F1-F3, Addendum B is a suitable mandatory differential corpus.

Confirmed material strengths:

- fixed pairwise matrix rather than coder-selected cases;
- active non-zero-strength cases;
- subsampled YUV420 and YUV422 chroma;
- actual plane-coordinate content generation;
- explicit scalar backend and HolyWu `opt=1`;
- 8/10/12/16-bit coverage;
- Gray/YUV/RGB and omitted/subset routing;
- asymmetric offset cases;
- second geometry;
- per-selected-plane non-vacuity;
- retained invocation and machine-readable difference evidence.

The RGB plane statement is correct: VapourSynth plane 1 is G.

No corpus arithmetic correction is required.

# 5. Knowledge sweep and Open Rule Questions

The independent sweep found no new competing design policy requiring an Open
Rule Question.

The newly confirmed 17..32-bit integer-format reachability is an external API
fact, not a policy choice. It should be appended to K28 or recorded as the next
K-item so future format work does not repeat the discovery:

```text
VapourSynth valid video formats include integer depths 8..32;
storage is 1 byte at 8 bits, 2 bytes at 9..16, and 4 bytes above 16;
a filter supporting only 8..16 must explicitly refuse valid 17..32-bit
integer inputs rather than call them malformed metadata.
```

Q2/Q3 triggers are not met because this review found direct corrections.

# 6. Release recommendation

Do not release D4 v1.3 yet.

The remaining bounded corrections are:

1. add and ratify the 17..32-bit integer refusal row and production test;
2. test float16 as well as float32;
3. test normal explicit-v3 unavailability separately from precedence;
4. remove stale D3 v1.3 and old-K24 authority text from D4;
5. reconcile D0's no-touch block and K24 with its own ratified exception/S7;
6. align K26 sentinel and resolved-float wording across D0/D2/D3/provenance/
   Addendum A.

No formula, matrix, boundary, sentinel-fixture or Addendum-B count needs to be
re-derived in the next review unless changed.

---

*End of W3C Stage 2C updated-package review.*
