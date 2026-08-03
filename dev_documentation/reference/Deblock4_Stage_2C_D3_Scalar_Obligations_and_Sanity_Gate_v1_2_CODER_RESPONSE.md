# Deblock4 - Stage 2C D3 v1.2 Follow-up Coder Review

**Deliverable:** W3C-2C-D3-V1.2-FOLLOW-UP  
**Reviewed document:** `Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_2.md`  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Status:** DOCUMENTATION REVIEW ONLY. No implementation, code change, or
scope release is implied.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Overall result

D3 v1.2 resolves the eight findings from the prior W3C review thoroughly.

The corrected native-16-bit matrix, O-7 boundary model and vectors,
full-table binding, strict-equality probes, K26 sentinel discipline,
memory canaries, source-frame immutability, i32 range proof, proof-surface
routing, and strengthened whole-image sanity gate are substantively sound.

One remaining substantive boundary error should be corrected before D3 closes.
One D4 open-rule question is also worth recording for three-way discussion.

# 2. Remaining substantive finding

## F1 - O-6a is too broad for all accepted non-mod-8 geometries

**Evidence:**

- D3 section 7 O-6a.
- D3 section 7b O-7 eligibility rule.
- README boundary policy: process every candidate edge whose complete
  footprint is in-plane; leave samples outside eligible write footprints
  unchanged.

O-6a currently says the four 2x2 corner blocks of **any** processed plane are
byte-identical to the source because no vertical edge writes columns
`0,1,W-2,W-1` and no horizontal edge writes rows `0,1,H-2,H-1`.

That is true for the mod-8 O-4 and G frames, but it is false for some accepted
non-mod-8 dimensions, specifically extents congruent to `3 mod 4`.

For width 7:

```text
candidate vertical edge e = 4
read footprint            = columns 1..6
write footprint           = columns 2..5
W-2                       = column 5
```

The edge is eligible because its complete read footprint is in-plane, and its
write footprint includes column `W-2`. Therefore the rightmost two-column
corner region is not generally guaranteed unchanged.

The same issue occurs vertically for heights 7, 11, 15, and so on.

### Required correction

Use one of these formulations:

1. Scope O-6a explicitly to the mod-8 O-4 and G composite frames; or
2. Replace it with the exact general invariant:

```text
Every sample outside the union of all eligible edge write footprints remains
byte-identical to the source.
```

The second formulation is preferable because it directly expresses the
settled native complete-footprint boundary policy.

### Additional discriminating case

Add a `7x7` or `11x7` boundary case. The current `10x10`, `12x6`, and `6x6`
cases do not expose the `extent mod 4 == 3` geometry class.

The O-7 eligibility rule itself is correct; the issue is only the overly broad
corner-block consequence stated in O-6a.

# 3. D4 open rule question

## Q1 - Must explicit final output clamps be present in source?

D3 requires the integer `0..peak` result clamps to be present in source and
asserted structurally, while also noting that no natural legal vector reaches
them at the default parameters.

This may be more constraining than an output-only obligation because it
requires a particular implementation structure rather than only a proven
observable result.

The D4 `Open Rule Questions` section should record:

```text
Must the ReleaseSafe scalar kernel retain explicit final sample clamps for
direct HolyWu structural fidelity and defensive safety, or may those clamps be
omitted if a complete proof establishes that every legal integer input and
parameter combination keeps all pre-final writes within 0..peak?
```

### W3C provisional position

Retain the explicit clamps.

Reasons:

- they are cheap;
- they mirror the reference source;
- they make the legal output-range guarantee locally obvious;
- they protect against future maintenance errors or changed preconditions;
- they avoid making acceptance depend on a subtle global proof remaining
  intact forever.

However, this should be recorded as an intentional architecture and safety
decision reached by W3X/W3D/W3C, not stated as though byte-equivalence alone
necessarily requires that exact source expression.

# 4. Confirmed material

No further substantive defect was found in D3 v1.2 concerning:

- O-1 threshold tuples and full 61-entry table binding;
- O-1b public Classic offset rejection;
- A1-A5 strict activation vectors;
- B1-B8 arithmetic, floor-semantics and side-gating vectors;
- K26 exact-binary hash, sentinels and rebuild discipline;
- O-4 Schedule-A matrix and swapped-order discriminator;
- the corrected native 16-bit whole-frame matrix;
- plane-selection and source-frame immutability obligations;
- O-6 memory canaries and i32 range bounds;
- O-7 eligibility formula and the stated 10x10, 12x6 and 6x6 cases;
- conditional float scoping;
- G1-G6 and the mandatory corruption negative control;
- proof-surface routing.

# 5. Recommendation

Correct O-6a and add one `extent mod 4 == 3` boundary case.

Carry Q1 into D4's short `Open Rule Questions` section for explicit three-way
resolution. No other D3 v1.2 revision appears materially necessary.

---

*End of W3C Stage 2C D3 v1.2 follow-up coder review.*
