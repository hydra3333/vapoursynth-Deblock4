# Deblock4 - Stage 2C D0-D2 Revision Review

**Deliverable:** W3C-2C-D0-D2-REVISION-REVIEW  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Scope:** Highest-version D0, D1 pin record/source snapshot, and D2 only.  
**Excluded:** D3 and later deliverables; all superseded material.  
**Status:** DOCUMENTATION REVIEW ONLY. No implementation, code change, or
scope release is implied.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Overall result

The revision pass resolves the substance of the prior D2 findings well.
The source formulas, threshold tables, traversal schedule, footprints,
offset-policy separation, non-mod-8 policy, host/source distinction, float
non-finite distinction, and corrected checklist are retained correctly.

The four pinned D1 hashes also verify against the supplied archive.

Seven substantive issues remain. None requires a change to HolyWu behaviour
or to the verified formula/table account.

# 2. Findings

## F1 - K26 and D2 WP-1 still misclassify negative signed left shift

**Evidence:**

- `Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_4.md`,
  K26, lines 173-194.
- `Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_2.md`, WP-1,
  lines 169-183.
- `holywu_r9/deblock.cpp:deblockHorEdge<int>:106`
- `holywu_r9/deblock.cpp:deblockVerEdge<int>:180`

K26 groups these together as implicit toolchain behaviours:

```text
signed right shift of a negative value;
left shift of a negative signed value;
float contraction/reassociation.
```

They are not the same class.

For the C++ language modes relevant to this source, right shift of a negative
signed value is an implementation/language-rule issue, but left shift of a
negative signed value is undefined behaviour. The language does not define a
result that becomes reliable merely by recording compiler/version/flags.

Required correction:

1. State explicitly that `(q0-p0)<<2` can invoke source-level C++ undefined
   behaviour when `q0-p0` is negative.
2. Make the exact HolyWu reference DLL hash mandatory, not merely
   "as applicable", because the executable is the practical layer-(b) oracle.
3. Add behavioural sentinel vectors that exercise negative delta inputs and
   record the observed external-binary output.
4. Treat any rebuilt reference DLL as a new oracle artefact requiring hash and
   sentinel revalidation.
5. Keep the Deblock4 Zig obligation explicit and defined, preferably avoiding
   any analogous negative-left-shift construction.

This is an oracle-reproducibility correction, not a proposed change to the
HolyWu result.

## F2 - D1 provenance remains inconsistent with the new K26 doctrine

**Evidence:**

- `holywu_r9/README_provenance.md`, lines 31-44.
- D0 K26, lines 173-194.

D1 still says:

```text
deblock.cpp = THE external oracle;
meson.build and other build metadata are excluded because they have no
schedule content.
```

After K26, the source is the byte-pinned source description, but it is not by
itself the executable result oracle. Build configuration is result-bearing for
the signed-shift and floating-point cases.

D1 need not import upstream packaging files. It should, however, distinguish:

```text
D1 source pin:
    normative source identity and schedule/formula evidence.

K26 reference-build record:
    independently pinned compiler, language mode, flags, VapourSynth/plugin
    environment, forced opt=1 path, exact DLL hash, and behavioural sentinels.
```

The phrase "THE external oracle" should be qualified accordingly. A versioned
D1 addendum is sufficient; the byte-pinned upstream files need not be altered.

## F3 - D2 section 6 still asserts the very edge-replication fact it later withdraws

**Evidence:**

- D2 section 6, lines 260-264.
- D2 section 6 bullet, lines 272-274.

The opening paragraph says the Point call performs:

```text
edge replication of the right/bottom border
```

The later bullet correctly says the extension rule is a host resize-plugin
contract and must not be asserted from `deblock.cpp`.

These statements conflict. Remove "edge replication of the right/bottom
border" from the opening paragraph, or attribute it explicitly to a separately
pinned and cited resize-plugin contract/runtime proof.

## F4 - D2 section 8 still reopens the settled padding policy

**Evidence:**

- D2 section 8, line 312.
- D2 T-3, lines 211-215.
- D2 section 6, lines 281-286.
- D0 section 5, lines 288-299.

The mapping table still says:

```text
pad -> no Classic equivalent yet (D4, section 6)
```

That wording implies an unresolved future equivalent. The same document now
correctly states that Classic's native complete-footprint handling is already
settled and that HolyWu's pad/filter/crop wrapper is external-only.

Replace the mapping with wording such as:

```text
pad -> HolyWu external-only wrapper; no Classic equivalent by settled policy.
```

## F5 - D2 section 3 retains the old fmParallel overstatement

**Evidence:**

- D2 section 3, lines 81-84.
- D2 section 7, lines 291-298.

Section 3 still says:

```text
fmParallel with rpStrictSpatial - parallel across frames
```

Section 7 correctly says `fmParallel` permits concurrent frame scheduling but
does not prove that a particular run is concurrent.

Use the corrected formulation in both places:

```text
fmParallel permits concurrent frame callbacks; the source-constructed
intra-frame loop is sequential.
```

## F6 - D0 K17 conflicts with W3X's settled delivery precondition model

**Evidence:**

- D0 K17, lines 222-227.
- W3X's Stage 1C.1 correction: unrelated cleanup or working-tree changes are
  not part of the delivery contract; only the delivery's actual target paths
  are preconditioned and verified.

K17 currently says a delivery "presumes a clean tree". That is broader than
the settled W3X rule and can incorrectly reject unrelated coordinator-owned
changes.

Replace that phrase with a touched-path rule:

```text
A delivery does not require a globally clean tree. Every existing target it
patches must match the declared base; every new destination must satisfy its
declared precondition; unrelated W3X-owned paths are neither inspected nor
constrained.
```

The remaining K17 requirements, especially never touching `superseded/`, are
sound.

## F7 - D1 lacks the mandatory Binding Knowledge Checklist

**Evidence:**

- D0 section 1, lines 20-27: every 2C-family deliverable MUST carry a
  Binding Knowledge Checklist.
- `holywu_r9/README_provenance.md`: no checklist is present.

This is now material because D1 must explicitly distinguish the byte-pinned
source identity from the K26 executable-oracle pin.

A D1 addendum/checklist should at minimum account for:

- K11: source is Schedule-A reference material;
- K19: source pin is layer-(b) evidence, not an absolute cross-layer rule;
- K21: upstream SIMD/vectorclass is read-only and not implementation source;
- K26: source bytes do not pin executable arithmetic results;
- K17: reference files are W3X-owned and never modified by coder deliveries.

# 3. Confirmed areas

No further substantive discrepancy was found in:

- D0's corrected K3 and K6 applicability;
- D0's settled non-mod-8 and offset-rejection policies;
- D2's `opt=1` scalar-oracle requirement;
- D2's exact loop schedule and dependency overlaps;
- D2's integer formulas, gates, biases, shifts as source expressions, clamp
  bounds, and K7 footprints;
- D2's float formula and non-finite divergence account;
- D2's source-branch versus Python-host distinction;
- D2's corrected error-prefix scope;
- Appendix A: all three 61-entry tables remain exact.

# 4. Recommendation

Resolve F1-F7 before closing D0-D2.

F3-F5 are local D2 edits. F6 is a local D0 process correction. F2 and F7 can
be resolved by a versioned D1 provenance addendum without modifying any
byte-pinned upstream source file. F1 should be reflected consistently in D0
K26, D2 WP-1, and the future D4 external-reference build/proof requirements.

No D3 review was performed in this pass.

---

*End of W3C Stage 2C D0-D2 revision review.*
