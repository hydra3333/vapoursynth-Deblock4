# Deblock4 - Stage 2C D2 Independent Verification Report

**Deliverable:** W3C-2C-D2-VERIFY  
**Version:** 1.0  
**Date:** 2026-08-02  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Reviewed document:** `Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_1.md`  
**Pinned source:** `holywu_r9/`  
**Status:** DOCUMENTATION REVIEW FINDINGS. No implementation, no code change,
no scope release, and no change to HolyWu behaviour is proposed.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Review method and independence record

The required source-first order was followed.

1. D0 v1.3 sections 1, 4 (including K19), and 6 were read first.
2. `holywu_r9/SHA256SUMS.txt` was checked before source inspection:
   - `deblock.cpp` PASS
   - `deblock.h` PASS
   - `deblock_sse4.cpp` PASS
   - `LICENSE` PASS
3. `holywu_r9/deblock.cpp` was read in full, lines 1-448, before D2's
   account of any source section was read.
4. D2 v1.1 was then compared claim by claim with those pinned bytes.
5. Appendix A was independently parsed and compared element by element with
   the three source arrays.
6. A separate knowledge sweep used independently chosen search terms and
   direct reading across the current non-superseded documentation set.
7. Nothing under `superseded_do_not_use_files_in_this_folder/` was read or
   used. `deblock_sse4.cpp` was not inspected algorithmically.

Pinned hashes verified:

```text
600585ee46c783db5bc47ea22fcaadbbef48cd60caa8bf850e44a40b0de86367  deblock.cpp
6d59551e80b1f2e6ea246eb07fa09558c62fae17e2cfa83907e4f70aaf4b7cba  deblock.h
43249d76636f8255f9c40ed6b4b3bd45629517d30a10b0d6c98c38d05479c62e  deblock_sse4.cpp
39db8f9acf036595a2566ea3fe560bc7bd65d8749f088e0f4a4ef2f8a6cb4b34  LICENSE
```

# 2. Overall result

D2's central scalar source transcription is substantially correct:

- registration and source-side parameter handling;
- threshold-table indexing and bit-depth scaling;
- literal C/scalar traversal order;
- horizontal and vertical taps and footprints;
- integer activation and side-activity gates;
- integer formulas, biases, shifts, clamp bounds and gated writes as written;
- float formulas as written;
- the structural pad-filter-crop call sequence;
- all Appendix A table values.

D2 v1.1 should nevertheless NOT yet become the unqualified normative
layer-(b) oracle description. Findings F1-F12 require W3D resolution.
The most material issues are:

- the document does not bind the external reference run to the C/scalar path;
- the source pin does not pin the C++ integer-shift or float-contraction
  execution semantics on which exact expected values depend;
- HolyWu's float non-finite behaviour is omitted;
- D2 treats two already-settled project policies as open or opposite:
  non-mod-8 boundary handling and Classic offset resolution.

# 3. Numbered findings

## F1 - `opt` is an oracle-path selector; C/scalar is not the default on capable x86

**Classification:** algorithm-bearing source behaviour understated; K19
application gap.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockCreate:326,331-359`
- D2 section 1, lines 31-33
- D0 K19, lines 147-167

The source first installs `filterC`, but under `DEBLOCK_X86` it replaces that
function pointer with `filterSSE4` when:

```text
(opt == 0 and detected instruction set >= 5) OR opt == 2
```

Therefore:

```text
opt=0  is auto and commonly selects SSE4.1;
opt=1  leaves the C/scalar path selected;
opt=2  forces the SSE4.1 path.
```

D2 says `opt` maps to Classic's backend concept and is "not otherwise
algorithm-bearing." That is too weak for a document whose layer-(b) oracle is
specifically HolyWu C/scalar. The differential harness must explicitly force
`opt=1`, or otherwise prove that the reference build has no `DEBLOCK_X86`
path. Merely omitting `opt` does not select the required oracle on a capable
x86 host.

No comparison with `deblock_sse4.cpp` is needed to establish this finding.

## F2 - WP-1's exact negative-shift semantics are not established by the pinned bytes

**Classification:** D2 claim not confirmable from cited bytes; external-oracle
reproducibility gap.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockHorEdge<int>:106-109`
- `holywu_r9/deblock.cpp:deblockVerEdge<int>:179-182`
- D2 WP-1, lines 151-156
- `holywu_r9/README_provenance.md:38-45`

The source expressions are transcribed correctly, but they include:

```text
(q0 - p0) << 2
(dstp[0] - dstp[-1]) << 2
```

where the signed left operand may be negative, followed by right shifts of
possibly negative signed intermediates.

D2 goes beyond the pinned bytes when it states that C++ right shift is
necessarily floor division and therefore defines exact expected negative
results. The snapshot deliberately excludes `meson.build` and other build
metadata. It does not pin:

- C++ language mode;
- compiler and version;
- optimisation flags;
- the implementation's signed-right-shift rule;
- the treatment of negative signed left shift.

Negative signed left shift is not a portable defined oracle operation across
the C++ language modes that can build this source. The right-shift result for a
negative value also cannot be inferred from these bytes without the applicable
language/compiler contract.

This does NOT propose changing HolyWu arithmetic. It means the external oracle
must pin an execution environment or executable whose observed semantics are
the intended layer-(b) result. D3 vectors B2/B4/B5 and the Python derivation
currently assume floor-shift semantics, so they inherit this unresolved
dependency.

## F3 - HolyWu float operation ordering/contraction is not pinned; D0 K6 is omitted

**Classification:** D2 claim boundary incomplete; checklist omission.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockHorEdge<float>:146-149`
- `holywu_r9/deblock.cpp:deblockVerEdge<float>:214-217`
- `holywu_r9/README_provenance.md:38-45`
- D0 K6, lines 108-113
- D2 section 5, lines 192-211
- D2 checklist, lines 260-277

The source confirms the written float expression tree, including ordinary
multiply/add chains. It does not contain an explicit C++ floating-point mode or
an intrinsic that itself settles contraction. Because the build metadata is
excluded, the pinned bytes alone do not establish whether the external build
contracts, reassociates, or otherwise changes evaluation.

D0 K6 explicitly says the non-fused float issue applies to D2, but D2's
Binding Knowledge Checklist omits K6. D2 should distinguish:

```text
source-expression fact:
    the C++ source spells ordinary multiply/add expressions and no explicit
    fused intrinsic is present;

external-execution fact:
    the actual operation sequence depends on the pinned compiler and flags.
```

Deblock4's own `.strict` rule must not be silently projected onto an
un-pinned HolyWu C++ build.

## F4 - HolyWu float non-finite behaviour is algorithm-bearing and omitted

**Classification:** algorithm-bearing source behaviour omitted; K22 only
partially honoured.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockHorEdge<float>:135-156`
- `holywu_r9/deblock.cpp:deblockVerEdge<float>:203-224`
- README v1.9 section 8.6, lines 1505-1519
- D2 section 5, lines 192-211
- D0 K22, lines 227-236

HolyWu has no complete-footprint finite-value guard.

The activation gate reads only `p1,p0,q0,q1`. `p2` and `q2` enter later through
`ap` and `aq`. Therefore a non-finite outer tap does not necessarily suppress
the core `p0/q0` filter:

```text
non-finite p2:
    ap < beta is false;
    p-side c widening and p1 write are suppressed;
    the core p0/q0 delta may still be computed and written.

non-finite q2:
    symmetric q-side behaviour.
```

This differs materially from the project's settled canonical float policy,
which leaves an edge position unchanged if ANY sample in the complete read
footprint is non-finite and preserves all original bit patterns.

D2 correctly records the lack of integer-style output clamp, but it does not
record this non-finite behaviour. If Classic float support is retained, D2
must describe the HolyWu layer-(b) behaviour before D4 can define the
comparison contract. This is a factual distinction, not a proposal to
"improve" HolyWu.

## F5 - The loop order is correct, but the dependency prose is too absolute and misses exact links

**Classification:** source account wording correction; algorithm-bearing
dependency detail understated.

**Evidence:**

- `holywu_r9/deblock.cpp:filterC:240-254`
- `holywu_r9/deblock.cpp:deblockHorEdge:88-116`
- `holywu_r9/deblock.cpp:deblockVerEdge:168-192`
- D2 section 3, lines 84-102

The literal schedule in D2 is correct. The statement that "every edge reads
pixels ALREADY MODIFIED by earlier edges" is not literally true: the first
executed vertical edge has no earlier edge. "Any reordering ... changes
output" is also too absolute; the source establishes that reordering CAN
change output because dependencies exist.

The exact source-derived dependencies include:

1. A vertical edge at `x` can read column `x-3`, written by the preceding
   vertical edge at `x-4`.
2. At an interior crossing, `H(x,y)` runs immediately before `V(x,y)`;
   `V(x,y)` reads rows `y` and `y+1` and columns written by that horizontal
   call.
3. `V(x,y)` also reads columns written by `H(x-4,y)`.
4. A horizontal edge in the next row band can read rows written by horizontal
   and vertical calls in the preceding band.

D2's reference to column `x+1` is not the clearest load-bearing dependency.
The normative statement should be that later calls MAY read earlier writes
through the overlaps above, making the specified sequence output-defining.

## F6 - Several parameter/default and scheduling claims require host-API evidence, not only `deblock.cpp`

**Classification:** claims not confirmable from cited bytes; D0 K12/F7
coverage omission.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockCreate:301-326`
- `holywu_r9/deblock.cpp:deblockCreate:402-403`
- D2 section 1, lines 25-34
- D2 section 3, lines 71-74
- Toolchain Findings v1.3 F7, lines 239-258
- D0 K12, lines 173-178

The source itself confirms that:

- `quant` explicitly becomes 25 when `mapGetIntSaturated` reports an error;
- the error status for `aoffset`, `boffset`, and `opt` is ignored;
- all planes are selected when `mapNumElements(...) <= 0`;
- `fmParallel` and `rpStrictSpatial` are passed to `createVideoFilter`.

The source bytes alone do NOT establish:

- the value returned by `mapGetIntSaturated` for an absent or erroneous
  optional property;
- the exact `mapNumElements` value for absence;
- that a Python caller can deliver an explicit empty registered array;
- that execution actually occurs concurrently across frames.

Current project evidence F7 says `planes=[]` is rejected at the normal Python
invocation boundary before the callback. D2 should distinguish the source
branch (`num_planes <= 0`) from reachable Python-interface behaviour.

Likewise, the callback's loop body is sequential by source construction.
`fmParallel` permits framework scheduling; it does not prove that any given
run is parallel. `rpStrictSpatial` is the declared dependency pattern, not the
reason the intra-frame loop is sequential.

## F7 - The pad/filter/crop calls verify, but "edge replication" and historical rationale do not come from the cited bytes

**Classification:** D2 claim not confirmable from cited bytes.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockCreate:290-291`
- `holywu_r9/deblock.cpp:deblockCreate:375-395`
- `holywu_r9/deblock.cpp:deblockCreate:406-427`
- D2 section 6, lines 213-235

The source proves:

1. each non-mod-8 dimension is increased to the next multiple of 8;
2. `resize.Point` is invoked with enlarged output dimensions and enlarged
   `src_width/src_height`;
3. the deblock filter is created on that node;
4. `std.Crop` removes the right/bottom padding afterward.

The source bytes do not themselves define the resize plugin's out-of-source
extension rule. Therefore "edge replication" requires an authoritative
VapourSynth resize contract or a pinned runtime observation. The source also
does not establish the stated historical rationale ("original block size /
SSE4 path convenience").

The statement that the path "NEVER runs for the project's real material" is
also broader than the evidence. The named PAL examples are mod-8, but the
public filter can receive other geometries.

D2 may keep the verified structural call sequence while identifying the
resize extension semantics as separately sourced host behaviour.

## F8 - T-3 is not an open D4 policy choice under the prevailing boundary specification

**Classification:** controlling-document conflict; D0 K3 misclassified in
D2's checklist.

**Evidence:**

- D2 T-3, lines 184-189
- D2 section 6, lines 230-234
- D2 checklist, lines 273-275
- D0 K3, lines 87-93
- README v1.9 section 6.1, lines 1216-1227
- README v1.9 section 6.3, lines 1277-1288
- Concise Project Summary v1.2, lines 168-175

D2 treats Classic non-mod-8 handling as a future choice among:

```text
pad-filter-crop;
reject;
native complete-footprint handling.
```

The prevailing README already requires complete-footprint native bounds and
forbids a whole-frame padding/resize/crop wrapper merely to satisfy block or
vector multiples. The concise summary repeats that settled rule.

D0 K3 explicitly says the corrected frame-boundary policy applies to D2, yet
D2's checklist classifies K3 as not applying until D4. That classification is
incorrect.

D2 section 6 should continue to document HolyWu's external behaviour, but T-3
must not reopen the project's settled canonical boundary policy unless W3X
explicitly changes the controlling README.

## F9 - D2 section 8 reverses the settled Classic offset policy

**Classification:** controlling-document conflict; downstream D3 impact.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockCreate:334-337`
- D2 section 2, lines 41-53
- D2 section 8, lines 245-258
- README v1.9 section 3.14, lines 678-697
- Creation-Error Message Table v1.1, lines 38-40
- D0 K16, lines 191-194
- D3 O-1 V5, lines 50-55

D2 section 2 correctly records that HolyWu clamps `aoffset` and `boffset`.
That is a layer-(b) external-source fact.

D2 section 8 then says Classic "must clamp offsets the same way" and says the
Stage 1C table validates only strength. Both statements conflict with the
prevailing project documents:

```text
Classic legal offset range:
    -strength .. 60-strength

out-of-range Classic offset:
    creation error; never silently clamped.
```

The ratified creation-error table contains explicit Classic boundary-offset
and side-offset error obligations.

D2 must separate:

```text
HolyWu external behaviour:
    clamp before table indexing.

deblock4.Classic public resolver:
    reject an out-of-range request.
```

The external differential harness should compare legal shared-domain
invocations. D3 V5 currently imports HolyWu's out-of-range clamp as a Classic
obligation and therefore also requires W3D review.

This finding does not propose changing the pinned HolyWu result.

## F10 - D2's blanket error-prefix statement is incomplete

**Classification:** source-account correction; non-algorithmic.

**Evidence:**

- `holywu_r9/deblock.cpp:deblockCreate:383-388`
- `holywu_r9/deblock.cpp:deblockCreate:396-399`
- `holywu_r9/deblock.cpp:deblockCreate:415-420`
- D2 section 7, lines 237-243

Caught plugin validation exceptions are emitted as:

```text
Deblock: <message>
```

However, `resize.Point` and `std.Crop` invocation failures are copied from
`mapGetError(ret)` directly and are not prefixed by the catch block. D2 should
limit its statement to caught validation errors rather than all creation
errors.

## F11 - D2 Binding Knowledge Checklist requires correction

**Classification:** D0 section-6 checklist finding.

**Evidence:**

- D2 checklist, lines 260-277
- D0 K3, lines 87-93
- D0 K6, lines 101-113
- D0 K12, lines 172-178
- D0 K16, lines 191-194
- D0 K22, lines 227-236

Required checklist corrections:

1. **K3** is NOT out of scope for D2. D0 expressly applies it to documenting
   HolyWu's actual boundary behaviour, and it also exposes the T-3 conflict.
2. **K6** is omitted even though D0 expressly applies it to D2's float
   arithmetic account.
3. **K12/F7** is relevant because D2 states explicit-empty-array public
   behaviour that current VapourSynth rejects before the callback.
4. **K16** is relevant because D2 section 8 relies on and contradicts the
   ratified Classic offset-error obligations.
5. **K22** is only partially honoured: float existence and bias differences
   are recorded, but the non-finite structural behaviour is not.

These are mostly corrections to the D2 checklist or D2 text; K3, K6, K12,
K16, and K22 already exist in D0 and do not need duplicate K-numbers.

## F12 - New D0 index candidate: external-oracle execution environment

**Classification:** independent knowledge-sweep gap; candidate new K-item.

**Evidence:**

- D0 K19, lines 147-167
- `holywu_r9/README_provenance.md:38-45`
- `holywu_r9/deblock.cpp:deblockCreate:326-359`
- `holywu_r9/deblock.cpp:deblockHorEdge<int>:106-109`
- `holywu_r9/deblock.cpp:deblockHorEdge<float>:146-149`

D0 pins source bytes and names HolyWu C/scalar as the external oracle, but the
current index does not bind the execution environment needed to reproduce
that oracle where source, compiler and host semantics meet.

A candidate new K-item is:

```text
EXTERNAL ORACLE EXECUTION PIN:
A HolyWu layer-(b) comparison records and controls, as applicable:
- the byte-pinned source identity;
- forced C/scalar path selection (`opt=1`, or proved no-x86 build);
- compiler and version;
- C++ language mode and optimisation/FP flags;
- VapourSynth and invoked resize/std plugin versions;
- relevant floating-point environment;
- the exact built DLL/executable hash when a binary is the practical oracle.

Source pinning alone is insufficient where output depends on signed-shift,
floating contraction, or host-plugin semantics.
```

W3D should refine this wording and W3X decide whether it becomes the next D0
K-number.

# 4. Current-document succession findings

These do not change the source verdict, but they matter because the current
documentation set is used for successor chats.

## S1 - Current designer introduction contains stale D2/D3 and pin status

**Evidence:**

- `111_New_Chat_Introduction_for_Designer_v1_15.md:36-80`
- `111_New_Chat_Introduction_for_Designer_v1_15.md:487-493`

The current highest designer introduction correctly records the r9 pin in its
Stage 2C status block, but later still says the exact pin is owed. It also says
D3 is "NOT STARTED" although the current reference set contains D3 v1.0.

Its D2 summary repeats two findings from this review as settled facts:

- every edge reads previous writes / any reorder changes output;
- WP-1 floor-shift semantics are source-settled.

The next introduction revision should be generated after W3D resolves this
report.

## S2 - Concise summary still lists the HolyWu pin as open

**Evidence:**

- `Deblock4_Concise_Project_Summary_v1.2.md:243-251`

The summary correctly refers to the pinned HolyWu C/scalar oracle at line 243,
then lists the exact pin as a remaining open item at line 251. The latter is
stale after D-CLASSIC-4/r9 ratification.

# 5. Explicit section-by-section verification

## D2 section 1 - Identity, registration, parameters

**PARTIAL PASS.**

Confirmed exactly from source:

- plugin ID, namespace, function name and registration string;
- quant default assignment and 0..60 validation;
- plane range/duplicate checks;
- opt range 0..2;
- constant 8-16-bit integer / 32-bit float format validation.

Exceptions: F1 and F6.

## D2 section 2 - Threshold derivation

**SOURCE ACCOUNT PASS.**

Confirmed exactly:

- offset clamp bounds;
- second index clamp;
- alpha/beta/c0 table selection;
- c0 indexed by `aIndex`;
- integer scaling;
- float threshold division.

The source account is correct. F9 applies only to D2's later claim that
Classic's public resolver must copy HolyWu's clamp policy.

## D2 section 3 - Real processing schedule

**LOOP ORDER PASS; DEPENDENCY PROSE NEEDS F5 CORRECTION.**

Confirmed:

- first-band vertical sweep;
- `dstp += 4*stride`;
- each later row band begins with horizontal x=0;
- per interior x: horizontal then vertical;
- in-place processing on a copied source frame;
- 4-pixel plane-coordinate grid on every selected plane;
- full luma formula on chroma;
- interior-edge coverage.

## D2 sections 4.1 and 4.2 - Integer edge mathematics

**PASS.**

Every cited item matches source:

- tap mapping and footprints;
- all strict activation comparisons;
- `ap`/`aq`;
- c widening;
- average bias;
- delta and side-delta expressions;
- clamp bounds `+/-c` versus `+/-c0`;
- 0..peak result clamps;
- side-write gates;
- horizontal/vertical sign orientation.

K7 is confirmed:

```text
read  e-3 .. e+2
write e-2 .. e+1
```

for both orientations.

## D2 section 4.3 - Integer semantics watchpoints

**PARTIAL PASS.**

WP-2 through WP-6 accurately describe the source expressions and gates.

WP-1's intended arithmetic result is not established by the byte pin alone;
see F2.

WP-4's i32 range statement is correct for <=16-bit samples, independent of
the semantic issue in F2.

## D2 section 4.4 - Tabled decisions

**PARTIAL.**

- T-1 is a valid future quality-gate record and does not alter 2C fidelity.
- T-2 remains a D4 scope question under D0 K22.
- T-3 conflicts with the prevailing boundary policy; see F8.

## D2 section 5 - Float path

**FORMULAS PASS; DESCRIPTION INCOMPLETE.**

Confirmed:

- 32-bit float specialisations exist;
- no integer `+1` average bias;
- no integer `+4` delta bias;
- multiplication by 0.5/0.125;
- no 0..peak result clamp.

Exceptions: F3 and F4.

## D2 section 6 - Pad-filter-crop

**STRUCTURAL CALL SEQUENCE PASS; HOST SEMANTICS/POLICY PARTIAL.**

Confirmed:

- pad amounts to next multiple of 8;
- Point invocation before filter creation;
- Crop invocation after filter creation;
- no path when both dimensions are already mod-8.

Exceptions: F7 and F8.

## D2 section 7 - Execution model

**PARTIAL PASS.**

Confirmed:

- arInitial request;
- arAllFramesReady get/copy/filter/free/return;
- one-frame temporal footprint;
- `fmParallel` and `rpStrictSpatial` arguments;
- no explicit frame-property access in HolyWu.

Exceptions: F6 and F10.

## D2 section 8 - Correspondence to Classic

**MAPPING PASS; OFFSET POLICY FAIL.**

Confirmed naming meaning:

- quant -> strength;
- aoffset -> boundary-strength side and c0;
- boffset -> side-activity/beta side;
- planes correspondence;
- opt corresponds conceptually to backend selection.

The clamp prescription is contrary to controlling Classic API policy; see F9.

## D2 Appendix A

**PASS - NO DISCREPANCIES.**

Independent element-by-element comparison:

```text
alphas: 61/61 exact
betas:  61/61 exact
cs:     61/61 exact
```

No missing, extra, reordered, or differing value was found.

# 6. Final recommendation to W3X/W3D

D2 v1.1's scalar formulas, threshold tables, footprints and literal traversal
schedule are verified.

W3D should issue a revised D2 that resolves F1-F11 before treating it as the
normative layer-(b) oracle description. W3D should also decide whether F12
becomes a new D0 K-item and should update the current succession documents
after resolution.

Because F2, F3, F4, F8 and F9 affect downstream obligations, D3 v1.0 should
then be reviewed and versioned where necessary before it judges any future
coder delivery.

No HolyWu behaviour change is recommended. The corrections are about stating
that behaviour and its execution conditions faithfully, and about keeping the
external HolyWu layer distinct from Deblock4.Classic's already-ratified public
policy.

---

*End of W3C Stage 2C D2 independent verification report.*
