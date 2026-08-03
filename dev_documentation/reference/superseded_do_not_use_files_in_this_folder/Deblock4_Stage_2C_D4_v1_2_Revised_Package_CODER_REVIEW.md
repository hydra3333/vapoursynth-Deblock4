# Deblock4 - Stage 2C Revised Package W3C Review

**Deliverable:** W3C-2C-REVISED-PACKAGE-REVIEW  
**Package reviewed:** `reference(8).zip`  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Status:** DOCUMENTATION REVIEW ONLY. D4 remains unreleased. No implementation
has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Current documents reviewed

Only the highest-version, non-superseded files in the archive were used:

```text
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_6.md
holywu_r9/README_provenance_v1_1__replaces_holywu_r9_README_provenance.md
holywu_r9/SHA256SUMS.txt and the four pinned upstream files
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_3.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_4.md
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_2.md
Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_0.md
Deblock4_Creation_Error_Message_Table_v1_2.md
```

Everything under `superseded_do_not_use_files_in_this_folder/` was excluded.

# 2. Confirmed corrections and independent checks

The package resolves most findings from the D3 v1.3 / D4 v1.1 combined
review.

Confirmed:

- the four D1 SHA-256 checks pass;
- D0 now carries K27 and K28;
- creation-error table v1.2 contains the two agreed Classic rows;
- S5 settles implemented-tier availability as recommended;
- S6 advances the stage identity to `0.1.0-dev+2C`;
- S7 adopts the non-speculative K24 position;
- D3 O-1c is now unambiguous and covers bits 8..16;
- D3 O-8 adds production-path and crosswalk obligations;
- H0-H6 are substantially more precise;
- generated-reference evidence ownership is defined;
- the authorised integration surfaces are enumerated;
- the K26 sentinel addendum is technically sound.

W3C independently re-ran the Addendum-A model. All six fixtures produce
exactly the documented four changed samples and no other changed sample:

```text
V-B2 / H-B2 -> 109 107 103 101
V-B4 / H-B4 ->   1   3   6   8
V-B5 / H-B5 -> 160 158  42  40
```

The remaining issues are package-coherence and acceptance-contract issues, not
new errors in the scalar formula derivations.

# 3. Numbered findings

## F1 - BLOCKER: D4 v1.2 still normatively binds the superseded D0/D3 set

**Evidence:**

- D4 header lines 7-11 say review/build from D0 v1.5 and D3 v1.3.
- D4 section 1 line 49 requires every D3 v1.3 obligation.
- D4 section 5 lines 278-286 defines the acceptance basis as D3 v1.3 and
  stops at O-7/G.
- D4 section 11 lines 531-540 again instructs review with D3 v1.3.
- The current package is D0 v1.6 and D3 v1.4.
- D3 v1.4 adds O-8 production-path routing and the mandatory O/G-to-test
  crosswalk.

This is not a cosmetic version-number issue. A literal delivery under D4's
current acceptance section can omit O-8 and the crosswalk even though the
current D3 requires them.

**Required correction:**

Update D4 throughout to:

```text
D0 v1.6
D3 v1.4
```

and enumerate in section 5:

```text
O-8 a-h;
the complete O/G-to-test crosswalk;
the corrected strength-zero and G4 property semantics;
the exhaustive bit-depth checks added in D3 v1.4.
```

The Addendum-A fixture document should be named explicitly as a read-together
part of the released D4 authority set.

## F2 - BLOCKER: the exact Stage 1C runner cannot pass after the mandatory +2C identity change

**Evidence:**

- D4 S6 requires the single-homed identity to change from
  `0.1.0-dev+1C` to `0.1.0-dev+2C`.
- D4 section 7c requires `build_2C_v1.bat` first to invoke the exact,
  immutable `build_1C_v1.bat` and fail on any 1C failure.
- Accepted Stage 1C and Stage 1C.1 evidence shows that the existing runner
  performs a `Single-homed identity 0.1.0-dev+1C` gate.

The exact historical runner is identity-bound. Once the current tree correctly
moves to `+2C`, that runner must fail before the additive 2C gates run.

W3C's earlier wrapper recommendation did not account for this identity-bound
gate and must be corrected.

**Required correction:**

Do not run the complete historical `build_1C_v1.bat` against the Stage 2C
tree.

Use a successor-matrix model:

```text
build_1C_v1.bat:
    remains immutable historical Stage 1C evidence.

build_2C_v1.bat:
    re-executes every still-applicable Stage 1C invariant/regression gate
    against the current Stage 2C tree;
    expects the +2C identity;
    then runs the additive Stage 2C gates.
```

Version-neutral helper scripts may be reused where they already exist, but the
identity-bound full Stage 1C runner cannot be the current-tree prerequisite.

If W3X also wants proof that the historical Stage 1C runner remains
reproducible, run it only against a separate byte-pinned Stage 1C baseline.
That does not replace regression proof on the current Stage 2C tree.

## F3 - BLOCKER: the package still contains contradictory no-touch and authority statements

### F3a - D0

D0 section 5 lines 328-335 adds a narrow exception for the two new error rows,
but its later no-touch block still says:

```text
No change to ... validation, creation-error strings, tier selection ...
```

S5 requires a narrow Classic tier-resolution change, not merely a new error
row.

D0 K16 also still names creation-error table v1.1 and says 2C must not alter
creation strings.

**Required correction:**

D0 must expressly allow exactly:

```text
the float refusal;
the unimplemented-backend refusal;
the Classic-only implemented-tier availability cap;
the associated exact precedence test.
```

Detection and the using-echo remain unchanged.

Update K16 to creation-error table v1.2 and describe the two additions.

### F3b - D4

D4 section 1 lines 58-65 still puts parameter validation, creation-error
strings and tier selection out of scope, while S1, S5 and section 7b explicitly
authorise those changes.

Replace the blanket exclusion with the same narrow exceptions.

D4's K16 checklist lines 488-490 mentions only the float row, although table
v1.2 and S5 add a second backend-availability row.

### F3c - D3 and the error table

D3's K16 checklist still says no creation string is altered.

Creation-error table v1.2 is marked W3X-ratified in its status block, but its
purpose section still says it is a draft and is not controlling until W3X
ratifies it. That creates avoidable authority ambiguity.

The table should state plainly that v1.2 is ratified and controlling, and its
proof-status section should identify the Stage 2C tests for both new rows,
including the EFFECTIVE-tier-versus-availability precedence case.

## F4 - BLOCKER: D1 provenance still contradicts D4 H0's narrow build exception

D4 H0 correctly says the isolated `tools/holywu_reference` build may read and
compile the byte-pinned D1 source after verifying its hashes, while never
placing it in the Deblock4 production build graph.

D1 provenance v1.1 still says:

```text
nothing in the build may include these files;
coder deliveries never read [the directory] as input.
```

The checklist wording is literal enough to prohibit the D4 tool that is now
required.

**Required correction:**

Amend D1 provenance narrowly:

```text
The snapshot is never production build input and is never copied into the
deliverable/S3 tree.

The released D4 external-reference tool is the sole exception: it may read the
exact files after SHA-256 verification and compile them in an external
temporary workspace, without modifying or normalising them.
```

This preserves the read-only rule while making H0 implementable.

## F5 - BLOCKER: A1 retains the superseded K24 requirement and an element-type ambiguity

D4 S7 explicitly resolves Q5:

```text
one canonical non-duplicated formula body now;
no width-generic/vector interface required in Stage 2C.
```

D4 A1 lines 190-196 nevertheless retains the old requirement that the body be
structured so a later width parameter can instantiate the same logic. That is
the exact wording S7 says was non-objective and superseded.

A1 also says comptime element type `u8..u16`, while A1b correctly says the
actual storage element types are:

```text
8-bit       -> u8
9..16-bit   -> u16
```

Two reasonable implementations can still read A1 differently.

**Required correction:**

Replace A1 with S7's ratified form and state:

```text
comptime storage element type is exactly u8 or u16;
bitsPerSample is a separate runtime/immutable arithmetic parameter in 8..16;
one canonical formula body;
no duplicated per-bit-depth formula;
no width/vector API required in Stage 2C.
```

## F6 - BLOCKER: the external comparison does not explicitly force the Deblock4 scalar backend

H2 correctly forces HolyWu `opt=1`.

H5 says to compare `deblock4.Classic` with HolyWu but does not require:

```text
backend="x86_64_v1_baseline"
```

In Stage 2C, `auto` happens to resolve to v1. After 4C/5C, the standing harness
would silently compare a vector backend if it used `auto`, although K19
layer-(b) defines the primary comparison as Classic scalar versus HolyWu
C/scalar.

**Required correction:**

Every H5 invocation must explicitly force:

```text
Classic backend = x86_64_v1_baseline
HolyWu opt       = 1
```

H4 must inspect and record both actual request values.

Additional vector-versus-HolyWu runs may be added later, but they do not
replace the scalar-versus-scalar layer-(b) gate.

### Negative-control proof surfaces

H4 lists six negative controls but does not designate how each is produced.
Some are plugin/invocation cases; others may be file-level or guard-unit cases.

In particular, an unsupported integer bit-depth clip may be rejected by the
VapourSynth format API before a real clip can exist.

The scope must map each negative control to its proof surface:

```text
missing opt / non-mod-8 / float / bad offset:
    invocation-level where constructible;

wrong DLL hash:
    file/record guard test;

unsupported or inconsistent format metadata:
    production validation test if API-reachable, otherwise direct guard/unit
    test with synthetic metadata.
```

No host-owned error text should be asserted.

## F7 - BLOCKER: H6 is still not a judgeable, non-vacuous mandatory corpus

H6 now enumerates several axes, but it does not state whether they form a
Cartesian product, a pairwise matrix, or a handful of independently chosen
cases.

It also lets the delivery choose the synthetic frame contents. A corpus of
flat frames would produce zero differences and pass H5 while proving almost
nothing about deblocking.

The phrase `YUV with a selected chroma plane` also does not require a
subsampled format. A YUV444 case cannot discriminate an implementation that
incorrectly reuses luma dimensions for chroma. D3 O-8c and K28 need a
subsampled chroma case to be meaningful.

**Required correction:**

Supply a D4 corpus addendum before release with the exact invocation matrix.

It must state:

```text
- exact format for each case;
- exact dimensions and plane dimensions;
- exact bit depth;
- exact plane-selection arguments;
- exact strength and offsets;
- exact synthetic pixels or deterministic seed;
- expected non-vacuity condition;
- exact output and comparison location.
```

At minimum include:

```text
Gray;
YUV420 selected chroma;
YUV422 selected chroma;
YUV444 or another full-resolution YUV case;
planar RGB;
8, 10, 12 and 16-bit coverage as already required;
planes omitted and explicit subsets;
strengths 0, 25 and 60;
the named asymmetric legal offset cases.
```

For every non-zero-strength selected-plane case, require at least one changed
plane sample, or a ratified expected changed-count/hash. Strength-zero cases
are the explicit identity exception.

The dimensions must avoid HolyWu's wrapper and satisfy the intended per-plane
fixture assumptions. The matrix need not be an unnecessarily huge Cartesian
product, but its pairings must be fixed by authority rather than selected by
the coder after seeing results.

## F8 - MATERIAL: D3 v1.4 is not fully aligned with the ratified D4 decisions

D3 remains the document that judges the delivery, but it still says:

```text
float obligations are deferred pending the D4 float decision;
float copy behaviour is conditional on T-2;
Q1 is open;
K16 says no creation string changed;
B2/B4/B5 are all called "negative-delta" sentinels.
```

D4 now records:

```text
S1: integer-only and exact float refusal;
S2: retain clamps;
S5: second creation-error row;
H3/Addendum A: B2/B5 are negative-left-shift-UB probes, while B4 is a
negative-right-shift side-delta probe.
```

**Required correction:**

Update D3 so its judging language matches the released scope:

```text
- float is outside the accepted Stage 2C format domain and must be refused
  with the ratified exact row;
- Q1 leaves the register once S2 is ratified/released;
- K16 names both v1.2 additions;
- call B2/B4/B5 the K26 signed-shift behavioural sentinels, not all
  negative-delta sentinels;
- identify Addendum A as the plugin-level fixture authority.
```

Also change O-7's `For all three` to `For all four` and update Appendix C's
verification statement to include c2, so the canary/no-wrapper obligation
unambiguously covers the 11x7 case.

# 4. Open Rule Questions

No new Open Rule Question is necessary from this review.

The findings above are direct scope/authority corrections, not competing
design policies. Q4 and Q5 were resolved appropriately. Q2 and Q3 have not
reached their stated triggers because this pass found corrections, including
two release-blocking proof-contract defects.

# 5. Release recommendation

Do not release D4 v1.2 yet.

The scalar mathematics and the K26 sentinel fixtures do not need another
derivation review unless changed. A focused package revision should address:

1. current D0/D3 authority and O-8 acceptance;
2. the impossible Stage 1C runner wrapper;
3. the D0/D3/D4/error-table no-touch contradictions;
4. the D1 external-build exception;
5. A1/S7/storage-type consistency;
6. explicit forcing of both scalar backends;
7. an exact, active, subsampling-discriminating H6 corpus;
8. D3's final alignment with the ratified decisions.

After those corrections, the next review can be limited to these eight items
and need not repeat the already verified formula, matrix, boundary or sentinel
arithmetic.

---

*End of W3C Stage 2C revised-package review.*
