# Deblock4 - Stage 2C D3 Independent Review

**Deliverable:** W3C-2C-D3-REVIEW  
**Reviewed document:** `Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_1.md`  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Scope:** Substantive review of D3 against current D0 v1.5, D2 v1.3,
the pinned `holywu_r9/deblock.cpp`, and the current non-superseded governing
documentation.  
**Status:** DOCUMENTATION REVIEW ONLY. No implementation, code change, or
scope release is implied.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Review method

The review independently:

1. recomputed all O-1 threshold vectors from the pinned 61-entry tables;
2. recomputed every A/B single-edge expected result;
3. recomputed the O-4 8x8 Schedule-A matrix;
4. independently ran the deliberately swapped crossing order;
5. recomputed the 16-bit O-4 case from native 16-bit arithmetic;
6. recomputed the G checkerboard metric and tested the gate against a gross
   corruption counterexample;
7. compared the obligation set with D0 v1.5, D2 v1.3, README v1.9 and
   Verification and Tiering Decisions v1.10 section 20.2;
8. excluded all material under `superseded/`.

# 2. Overall result

The core arithmetic derivations are strong:

- O-1 V1-V6 threshold tuples are correct.
- A1-A3 and B1-B6 expected edge results are correct.
- The O-4 8x8 output matrix is correct.
- The swapped-order first row-major difference is correctly identified at
  `(row 2, col 5)`, correct 110 versus swapped 109.
- The G source boundary discontinuity is exactly 8.0 and the documented
  reference-model result is 1.703125, a 78.7109375% reduction.
- The mod-8 corner statement is correct for the tested schedule.

D3 v1.1 is not yet sufficient as the complete oracle-construction acceptance
basis. Eight substantive findings require resolution.

# 3. Numbered findings

## F1 - O-5d is false: the complete 16-bit O-4 result is NOT the 8-bit result multiplied by 256

**Classification:** incorrect expected-result obligation.

**Evidence:**

- D3 section 6 O-5d, lines 165-167.
- D3 Appendix B `full`, lines 276-294.
- D2 section 4.3 WP-2/WP-3, especially integer biases and scaled thresholds.
- `holywu_r9/deblock.cpp:deblockHorEdge<int>:105-116`
- `holywu_r9/deblock.cpp:deblockVerEdge<int>:178-189`

The single-edge B6 vector happens to scale exactly, but that does not make the
sequential in-place whole-frame schedule homogeneous. Later edges consume
earlier rounded writes. The integer `+1` average bias, `+4` delta bias and
floor shifts produce intermediate values that are not all multiples of 256.

Independent native-16-bit evaluation of the scaled O-4 input gives:

```text
25600 25600 25856 26368 27392 27904 28160 28160
25600 25600 25856 26368 27392 27904 28160 28160
25856 25856 26112 26624 27648 28096 28288 28288
26368 26368 26624 27136 27872 28192 28352 28352
27904 27904 27976 27988 28108 28264 28480 28480
28416 28416 28416 28408 28424 28480 28544 28544
28672 28672 28672 28672 28672 28672 28672 28672
28672 28672 28672 28672 28672 28672 28672 28672
```

This differs from `O-4 output * 256` at eighteen positions.

Required correction:

- replace O-5d's scale-the-expecteds claim with the literal native-16-bit
  matrix above, independently rechecked by W3D;
- retain B6 as the single-edge threshold-scaling vector;
- explicitly state that threshold scaling does not imply whole-schedule
  output homogeneity because the schedule is sequential and rounded.

## F2 - The settled non-mod-8 and small-plane boundary policy has no operative D3 obligation

**Classification:** binding-knowledge omission; geometry/footprint acceptance
gap.

**Evidence:**

- D0 v1.5 K3 and section 5.
- README v1.9 sections 6.1, 6.2 and 6.5.
- D3 O-6, lines 170-180.
- D3 Binding Knowledge Checklist, lines 207-229.
- D3 Appendix B `full`, lines 276-294.

D0 expressly says K3 applies to D3 and requires boundary obligations.
D3 only tests mod-8 geometry and says that mod-8 guarantees in-frame taps.
It does not test the settled Classic rule:

```text
process each candidate edge whose complete footprint is in-plane;
skip unsupported extreme edges;
do not pad/filter/crop;
allow one orientation to operate when the other has no eligible edge;
pass through when neither orientation qualifies.
```

The Appendix B loops are also only safe for the mod-8 derivation frames; for
a non-mod-8 width such as 10 they attempt the candidate at x=8 even though
q2 would be outside the plane. That is acceptable for a derivation record
limited to O-4, but it cannot serve as the boundary model.

Required D3 cases should include at least:

1. a non-mod-8 plane such as 10x10, proving only x/y=4 are eligible and the
   would-be x/y=8 edges are skipped;
2. a geometry where only one orientation qualifies;
3. a plane too small for either orientation, proving byte-identical pass-through;
4. unchanged extreme regions and no padding/crop graph insertion.

K3 must be present in D3's checklist.

## F3 - The whole-image sanity gate does not catch the gross corruption it is required to catch

**Classification:** oracle-construction acceptance gap.

**Evidence:**

- D3 G1-G4, lines 189-205.
- Verification and Tiering Decisions v1.10 section 20.2, lines 751-779.

Section 20.2 requires a loose corruption tripwire covering:

- bounded per-pixel change;
- changes concentrated consistently with edge-local deblocking;
- no wholesale global shift or gross image change.

D3's current gate checks only boundary-discontinuity reduction, legal sample
range, four unchanged corner blocks and determinism.

A grossly incorrect implementation can pass all four tests:

```text
set every non-corner sample of G to 104;
restore only the four 2x2 source corners.
```

That output has:

```text
G1 boundary discontinuity = 0.0       -> passes by 100% reduction
G2 all samples in 0..255              -> passes
G3 four 2x2 corners unchanged         -> passes
G4 deterministic                      -> passes
```

but it globally destroys the checkerboard and has mean absolute source change
3.984375.

The gate therefore does not fulfil its ratified purpose. Add at least one
aggregate/global-change bound, selected deliberately loosely from the verified
reference result. For reference, the intended output has:

```text
maximum absolute per-sample change = 5
mean absolute change over 64x64    = 1.667236328125
sum absolute change                = 6829
```

The final bounds are W3D/W3X decisions, but they must reject the constant-fill
counterexample while remaining a sanity tripwire rather than a quality metric.

## F4 - The threshold-table obligation samples six points but never binds all 61 entries

**Classification:** independent-oracle completeness gap.

**Evidence:**

- D3 O-1, lines 39-72.
- D3 Appendix B tables, lines 253-259.
- D2 Appendix A.
- Verification and Tiering Decisions v1.10 section 20.2, lines 761-765.

The acceptance doctrine explicitly requires threshold-table obligations.
D3 includes the complete arrays only inside the derivation model, but no
O-item requires the delivery to assert all 61 entries of `alphas`, `betas`
and `cs`.

An implementation can contain a wrong unused table entry and pass V1-V6,
all edge vectors, O-4 and G.

Add an obligation that the production table data or the table-construction
result matches all three 61-entry arrays element by element. Also test the
derived tuple across the full legal index domain, not only six selected
indices.

## F5 - Strict-comparison coverage is incomplete for the q-side activation and side-activity gates

**Classification:** discriminating-vector gap.

**Evidence:**

- D3 section 1, lines 27-30.
- D3 O-2 A1-A4, lines 74-84.
- D3 O-3 B3, lines 105-108.
- D2 sections 4.1/4.2.

A1 distinguishes `<` from `<=` for `|p0-q0|`.
A3 distinguishes it for `|p1-p0|`.
No vector places `|q0-q1|` exactly at beta.

Likewise, B3 proves a clearly inactive p-side (`ap=100 >= beta`) but does not
distinguish `<` from `<=` at `ap==beta`, and there is no equality vector for
`aq==beta`.

Mutations using `<=` for any of these missing gates pass the current O-4 and G
frames as well as all listed direct vectors.

Add direct vectors for:

1. `|q0-q1| == beta` -> activation must fail;
2. `ap == beta` -> no p-side c widening and no p1 write;
3. `aq == beta` -> no q-side c widening and no q1 write.

For example, at defaults:

```text
p-side equality:
(104,100,100,110,110,110)
strict result -> (100,102,108,109)

q-side equality:
(100,100,100,110,110,106)
strict result -> (101,102,108,110)
```

W3D should independently confirm and choose the final vector set.

## F6 - Required range/overflow, memory-canary and source-immutability obligations are absent

**Classification:** explicit section-20.2 acceptance requirements omitted.

**Evidence:**

- Verification and Tiering Decisions v1.10 section 20.2, lines 761-765.
- README v1.9 sections 8.2-8.5.
- V&T v1.10 section 20.1, lines 740-748.
- D3 O-3 structural note, lines 118-120.
- D3 O-6, lines 170-180.

D3 has arithmetic examples but no complete i32 range proof for all legal
8-16-bit inputs and thresholds. It also has no memory-canary obligation.
Checking that named samples outside a write footprint remain unchanged is not
equivalent to proving no read/write escapes the logical plane, row, or
allocated test buffer.

At 16-bit, the complete proof should at minimum bound:

```text
sample                              0 .. 65535
alpha                               0 .. 65280
beta                                0 .. 6912
c0                                  0 .. 8960
c                                   0 .. 9472
p0+q0+1                             1 .. 131071
4*(q0-p0)+p1-q1+4             -327671 .. 327679
p2+avg-2*p1                   -131070 .. 131070
pre-final p0/q0 with delta       -9472 .. 75007
pre-final p1/q1 with side delta  -8960 .. 74495
```

All fit i32, but the accepted document must carry or require the complete
proof rather than rely on a representative vector.

Add canary tests around:

- the complete plane allocation;
- each logical row versus stride;
- single-edge buffers;
- non-mod-8 and small-plane cases.

Also assert that the original source frame remains byte-unchanged after
processing selected planes. O-5b currently proves only unprocessed output
planes, not source-frame immutability for processed planes.

## F7 - K26 handling is stale relative to D0 v1.5 and D2 v1.3

**Classification:** execution-oracle pin incomplete.

**Evidence:**

- D3 B2 note, lines 98-104.
- D3 checklist K26, lines 210-213.
- D3 Appendix B line 271.
- D0 v1.5 K26.
- D2 v1.3 WP-1.

D3 records an `opt=1` build with fixed compiler/flags, but the current K26
requires more because negative signed left shift is C++ undefined behaviour:

- mandatory exact reference DLL/executable SHA-256;
- recorded negative-delta behavioural sentinels;
- rebuild creates a new oracle artefact;
- fresh hash and sentinel revalidation after every rebuild.

B2/B4/B5 are suitable candidate negative-delta sentinels, but D3 must say
that their observed outputs are recorded from the exact hashed reference
binary before they become reproduced layer-(b) facts.

Appendix B should also use:

```python
(q0 - p0) * 4
```

rather than Python's defined negative `<< 2`. The current Python expression
produces the intended mathematical value, but multiplication better preserves
K26's explicit no-negative-left-shift corollary for the Zig implementation
and avoids presenting the hazardous C++ idiom as the model expression.

## F8 - The proof-surface mapping and format wording are internally inconsistent

**Classification:** acceptance-routing ambiguity.

**Evidence:**

- D3 section 1, lines 21-26.
- D3 O-1b, lines 57-63.
- D3 O-5b, lines 161-162.
- D3 section 8, lines 182-187.
- D0 K2/K3/K23/K26.

D3 says every O-item maps to at least one Zig unit test, but O-1b explicitly
requires a 1C-style creation-path error proof. Exact public creation errors
must be exercised through the appropriate creation/integration harness, not
silently reduced to only a private parser unit test.

Rewrite the routing rule as, for example:

```text
kernel/math/geometry O-items -> Zig unit tests;
public creation/error O-items -> vspipe/batch end-to-end cases;
frame/property/copy obligations -> the narrowest test that exercises the
actual production path.
```

O-5b also says copy output is byte-identical "for every format" while section
8 leaves Classic float acceptance undecided. Use "every accepted format,
with float conditional on T-2"; source-copy immutability remains unconditional
for every path actually exercised.

The Binding Knowledge Checklist should be updated substantively:

- K2: these integer vectors become permanent scalar/v2/v3 exact regression
  obligations when later backends arrive;
- K3: non-mod-8 and small-plane obligations are required now;
- K23: G4 and source/backend reproducibility conditions;
- K26: full binary-hash/sentinel/rebuild rule, not only compiler/flags.

# 4. Confirmed material

No substantive correction is required for:

- O-1 V1-V6 tuple values;
- O-1b's Classic rejection policy;
- A1-A3 expected results;
- B1-B6 expected single-edge results;
- B2/B4/B5 as intended floor-semantics discriminators on the Zig side;
- O-4's exact 8x8 matrix;
- O-4's swapped-order first difference;
- O-4's top-band statement;
- luma-on-chroma plane-coordinate semantics;
- strength-zero identity;
- the mod-8 four-corner statement;
- the stated G reference-model discontinuity reduction.

# 5. Recommendation

Revise D3 before it is used as the Stage 2C oracle-construction acceptance
basis.

F1 is a direct expected-value correction. F2, F3, F4, F5 and F6 are acceptance
coverage gaps required by existing governing policy. F7 aligns D3 with the
current K26 doctrine. F8 removes ambiguity about which proof surface must
exercise each obligation.

After those corrections, D3 should be reviewed once more before D4 is judged
against it.

---

*End of W3C Stage 2C D3 independent review.*
