# Deblock4 - W3D Static Review of the Stage 4C Implementation Delivery v1.0

**Deliverable:** W3D-4C-STATIC-REVIEW-OF-DELIVERY
**Version:** 1.0
**Date:** 2026-08-12
**Author:** W3D (designer)
**Route:** W3D -> W3X
**Reviews:** Deblock4_Stage_4C_Implementation_Delivery_v1_0.zip + manifest
**Against:** scope v1_2 (controlling), D0 v1_13 checklist, charter v1_27,
the committed 2C tree (held), the ratified 4C-RAT-1..8 set.
**Status:** W3D static review INCLUDING independent W3D execution of the
vector unit suite and a full-graph cross-compile for the real target. No
end-to-end execution claim; W3X runs validation.
**Encoding:** US-ASCII; CRLF.

---

# 1. VERDICT

```text
ZERO blocking findings. The delivery conforms to scope v1_2 and every
ratified 4C-RAT decision. RECOMMENDED for W3X validation as soon as the
W3D differential harness (the one remaining owed input, W3D's own) is
supplied. Two conformance NOTES are recorded in section 3 so future
readers do not misread ratified rules as violated.
```

# 2. Verification record (performed cold, this session)

```text
MECHANICAL   8 = 5 REPLACES + 3 NEW exactly as manifested; restore_to_base
             (5) BYTE-IDENTICAL to the committed 2C tree; the three frozen
             oracle files and backend_tier_selection ABSENT from the
             payload (frozen surfaces honoured); all US-ASCII CRLF; no
             .ps1, no .patch, no repository-operating machinery.
EXECUTION    W3D NATIVELY EXECUTED the vector suite on the merged tree:
(NEW)        28/28 including ALL 12 vector tests - scalar-vs-vector A/B,
             16-bit and strong-delta discriminators, EXHAUSTIVE 8-bit
             p0/q0 sweep, seeded lane properties (u8+u16), the exact D3
             A/B + O-4 + O-5d + O-7 fixtures, whole-plane schedule
             differential, EVERY u8 horizontal remainder 1..15, EVERY u16
             remainder 1..7 at bits 9..16, and the four-row vertical lane
             pack with 1..3-row bottom underfills. All PASS against the
             frozen scalar oracle.
CROSS-BUILD  The full build graph (default test suite AND test-classic-v2)
(NEW)        CROSS-COMPILES CLEANLY for the pinned x86_64-windows-msvc
             target in the W3D sandbox - the only failure is the host's
             inability to SPAWN a Windows exe. The comptime v2 feature-set
             equality check compiled, i.e. passed. The 2C first-run
             compile-failure class is PRE-CLEARED for the entire graph.
DESIGN       RAT-2 traversal implemented (top vertical band; full
             horizontal edge then band verticals in strict increasing x)
             with edge_step/edgeEligible IMPORTED from the frozen schedule,
             never duplicated. RAT-3 four-row lane pack with per-row
             contiguous 6-read/4-write and in-register repack; scalar
             cleanup uses the FROZEN scalar edge body. RAT-4 descending
             same-body tails, no masked loads/stores. RAT-5 loads/stores by
             slice <-> vector VALUE coercion. i32 lanes; multiply-by-four;
             explicit final clamps; K31 single byte-to-sample cast with
             width slicing excluding stride slack.
OBJECT       classic_backend_v2_sse41: Windows-only guard; COMPLETE
             feature-set EQUALITY iteration against Zig's named x86_64_v2
             (drift names the feature in the compile error); C-ABI export
             roots taking only pointers/usize/i32 - NO vector type crosses
             the boundary; baseline reaches them via extern; threshold
             RESOLUTION stays caller-side in the frozen module.
DISPATCH     ar_all_frames_ready: selected-tier switch at the existing
             choke point; v1 branch calls the frozen schedule VERBATIM;
             v3 = BackendInvariant. Config diff = the ceiling line ONLY.
             Version = single-homed +4C advance + test. Selftest = ceiling
             contract update.
BATCH        build_4C_v1.bat: inherited 2C mechanics; explicit 85/85
             gates; test-classic-v2 in all three modes; T3 assembly gates
             (v2 roots present, XMM evidence required, EVEX/VEX/above-v2
             rejected, baseline object re-checked); RS==RF retained; T5
             temporary OUT-OF-REPO mutated-copy control per RAT-6; the
             W3D-harness JOIN CONTRACT (env vars; RUN_KIND positive /
             tail-mutant-expected-failure) instead of inventing W3D
             filenames; NO HolyWu invocation, stated honestly in the
             summary; exit-nonzero-on-first-failure discipline.
K30 / S2     W3D INDEPENDENT re-verification: parts 1 and 2 EMPTY;
             whole-tree S2 simulation ZERO hits.
```

# 3. Conformance notes (recorded so ratified rules are not misread)

```text
NOTE-1  @select appears in the vector kernel (lane-wise conditional
        c-increments and conditional p1/q1 results). This is the
        branchless vector expression of the FROZEN FORMULA's per-pixel
        conditionals - kernel semantics, proven byte-identical by the
        executed differential suite. RAT-4's "no masked lanes" governs
        TAIL I/O (no masked loads/stores for underfill), which the
        implementation honours via descending same-body widths. No
        conflict.
NOTE-2  Line ~399's @ptrCast to [*]T is the K31 single byte-to-sample
        cast (the same pattern as the frozen oracle), NOT a
        vector-pointer overlay; vector values are formed from row
        slices by value coercion. RAT-5 honoured.
```

# 4. The one remaining input, and the W3X path

```text
1. W3D delivers the Stage-4C differential harness (.vpy/.cmd) honouring
   the delivery's join contract: DEBLOCK4_PLUGIN_PATH /
   _STAGE4C_INSPECTION_DIR / _EXPECTED_VERSION / _EXPECTED_V1 /
   _EXPECTED_V2 / _RUN_KIND {positive | tail-mutant-expected-failure};
   corpus per scope section 7 (tail-forcing dims; u8/u16; 420/422/444/
   GRAY; plane subsets; corner offsets; underfilled eligible segments
   both orientations); decisive markers + JSON evidence; nonzero exit
   on any difference; the tail-mutant kind MUST report failure.
2. W3X: manual copy of apply_to_tree\ over the repo; set
   DEBLOCK4_STAGE4C_DIFFERENTIAL_RUNNER to the W3D .cmd; run
   build_4C_v1.bat from an x64 MSVC prompt; expect exit 0.
3. Evidence to W3D for the acceptance review; commit only after.
```

---

*Revision history*
```text
v1.0 (2026-08-12) Static review of the 4C implementation delivery: zero
     blocking findings; independent W3D native execution of the full
     vector suite (28/28 incl. all remainders and the lane pack) and a
     clean full-graph cross-compile for the pinned target; K30/S2
     re-verified EMPTY/zero; two conformance notes recorded; awaiting
     only the W3D harness.
```
