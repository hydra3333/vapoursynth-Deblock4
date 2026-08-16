# Deblock4 - W3D Review of the Stage 4C Pre-Implementation Response (W3C v1.1)

**Deliverable:** W3D-4C-PREIMPL-RESPONSE-REVIEW
**Version:** 1.0
**Date:** 2026-08-12
**Author:** W3D (designer)
**Route:** W3D -> W3X (decision items in section 4)
**Reviews:** Deblock4_Stage_4C_Preimplementation_Response_W3C_v1_1.md
**Against:** 4C scope v1_1; D0 v1_12; charter v1_27; the frozen scalar
sources; the W3X P2 concern of 2026-08-12 ("leverage the full power of
SSE/AVX2 if available provided it does not cost more than it saves").
**Status:** W3D review; verdicts and recommendations for W3X ratification.
**Encoding:** US-ASCII; CRLF.

---

# 1. Overall verdict

```text
A HIGH-QUALITY response that does exactly what section 6 demanded.
R3 is answered expressly and unqualified; P3 is confirmed with a
precise dependency proof from the frozen source; P4 contains a
GENUINE LANGUAGE-LEVEL CORRECTNESS CATCH (Zig vectors have no defined
byte layout; a vector-pointer overlay on frame memory is Illegal
Behavior - the load/store mechanism must be defined-layout
array/slice <-> vector VALUE coercion); P5's descending same-body
power-of-two tail decomposition is exact and elegant, with complete
per-width tables; the R4 parametrisation plan is concrete and makes
the 5C slot-in structural. F1 is a REAL BLOCKER and it is a W3D
authoring defect, acknowledged: D0 v1_12's two-sided sweep mechanism
(W3D-authored) requires every scope to carry a W3D Binding Knowledge
Checklist, and 4C v1_1 embeds the sweep block without the checklist.
The coder correctly declined to manufacture W3D's side and supplied a
candidate; W3D spot-checked its K-number attributions against D0
v1_12 (K1, K7, K11, K19, K25, K28) - ALL FAITHFUL.
```

# 2. The P2 question (W3X-flagged), assessed carefully

The amendment IS in v1.1: direct four-row lane packing as primary,
transpose not mandatory, scalar 1..3-row cleanup, full-scalar verticals
as fallback. W3D's assessment, addressing the W3X concern directly:

```text
(1) THE VERTICAL CAP IS THE ALGORITHM'S, NOT THE IMPLEMENTATION'S.
    A vertical segment has exactly four independent rows (frozen
    edge_step=4). Adjacent vertical edges are DEPENDENT - V(x) writes
    column x+1, V(x+4) reads it (the response proves this from the
    frozen constants; it matches W3D's own analysis) - and vertical
    segments in different bands are separated by interleaved
    horizontal work. NO byte-identical implementation can ever run
    more than four vertical lanes in parallel, on ANY vector width.
    AVX2's extra width is structurally unreachable on verticals; its
    full power IS reachable, and is taken, on horizontal edges where
    lanes = columns scale to N=16 (4C) and N=32 (5C).

(2) THE COMPUTE STAGE IS NOT UNDERUTILISED AT 128-BIT. The frozen
    kernel arithmetic is i32. @Vector(4, i32) IS a full 128-bit XMM
    register. The response's stated tradeoff ("four lanes underuse a
    128-bit register") is true ONLY of the u8/u16 load/store stage;
    the ALU work - the bulk of the kernel - runs at full register
    width in 4C. At 5C the same four i32 lanes fill half a YMM, and
    per (1) no legal design can do better.

(3) LANE-PACK vs TRANSPOSE IS A MATERIALISATION DETAIL, NOT A
    CAPABILITY DIFFERENCE. Both roads end at the identical
    @Vector(4,i32) compute. The transpose may load faster; the
    lane-pack is simpler and its hand-bookkeeping surface is smaller
    (where HUMAN bugs cluster, complementing G9's compiler-bug
    concern). 4C's charter is reliability; performance is 5C's. The
    response's own criterion is correct: T3 ASSEMBLY EVIDENCE decides,
    with fallback if lowering is poor. W3D REGISTERS "vertical
    materialisation strategy (lane-pack vs small transpose)" as a 5C
    performance-round measurement item - the shared compute body makes
    a later upgrade non-structural.

(4) ONE REFINEMENT (improvement, not blocker, folded into scope v1_2):
    a vertical segment's per-row memory traffic is CONTIGUOUS - reads
    are 6 adjacent samples (x-3..x+2), writes are 4 adjacent samples
    (x-2..x+1) per row. The lane-pack's steps 1 and 5 should be
    expressed as PER-ROW contiguous small loads/stores with
    in-register repack, not 24 independent per-tap scalar loads and a
    per-lane scatter; LLVM then has the freedom to lower well, and T3
    judges. Semantics unchanged; byte-identity gate unchanged.

W3D RECOMMENDATION: APPROVE amended P2 (4C-RAT-3) with refinement (4).
The W3X "full power" objective is genuinely met: the design takes all
the parallelism the frozen schedule's dependencies permit, at both
widths, and defers the remaining micro-choice to measured evidence in
the stage whose charter is performance.
```

# 3. Findings adopted and their remedies (all W3D-owned)

```text
F1 (BLOCKER)  W3D authors the 4C Binding Knowledge Checklist (using
              the coder candidate as verified input, line-checked
              against D0 v1_12) and reissues the scope as v1_2, also
              folding: the P4 defined-coercion load/store rule, the
              P2 refinement above, the ratified P3 reordering, the
              P5 tail tables by reference, and the RAT-6 T5 decision.
F2            W3D authors D0 K32 (charter v1_27 delivery mechanics
              supersede the K17/K18-era wording) -> D0 v1_13.
F3            W3D issues Project Status v1_25: the 3C collapse + T-1
              deferral + identifier-cleanup ruling (already in the
              W3D-side v1_24 working copy that post-dated the commit),
              plus 4C released and this response round. The committed
              v1_24 predates the collapse ruling - a version-sync
              artifact of same-day work, now closed by v1_25.
F4            Accepted as the coder's own correct reclassification.
```

# 4. Decision items for W3X (recommendation first, per convention)

```text
4C-RAT-2  APPROVE (recommended): the proven band reordering - one
          full horizontal edge, then that band's vertical edges in
          strict increasing-x. Both parties derived it independently
          from the frozen source; the O-4 tripwire and T2 guard it.
4C-RAT-3  APPROVE (recommended): four-row vertical lane pack primary,
          scalar cleanup 1..3 rows, scalar-verticals fallback on T3
          evidence; per section 2 above.
4C-RAT-4  APPROVE (recommended): descending same-body tails
          N/2..2, scalar 1; no masked inactive lanes; the tables of
          response 6.4/6.5 adopted into the scope.
4C-RAT-5  APPROVE EMPHATICALLY (recommended): defined-layout
          array/slice <-> vector value coercion ONLY; vector-pointer
          overlay on frame memory is forbidden as Illegal Behavior.
          This is the response's best catch.
4C-RAT-6  APPROVE the temporary out-of-repo copied-tree mutation as
          satisfying T5's "test-only seam" (recommended): it proves
          the differential catches one-lane tail corruption without
          shipping corruption code, avoids any G10 surface expansion,
          and performs no repository operation (C-DELIV-10/11 clean).
          The scope v1_2 rewords T5 accordingly.
4C-RAT-7  APPROVE K32 into D0 v1_13 (recommended).
4C-RAT-8  NOTED; closed by Project Status v1_25 (F3 remedy).
4C-RAT-1  Closed by the scope v1_2 reissue carrying the W3D checklist.
```

On W3X approval of the above, W3D produces: scope v1_2 (checklist +
ratified points), D0 v1_13 (K32), status v1_25 - and implementation is
released. No further design round is expected before code.

---

*Revision history*
```text
v1.0 (2026-08-12) Review of the W3C pre-implementation response v1.1:
     overall verdict high quality; the W3X-flagged P2 amendment
     assessed in depth and recommended for approval with one
     refinement; F1 checklist omission acknowledged as a W3D defect
     with the v1_2 reissue as remedy; all eight RAT items given
     recommendations.
```
