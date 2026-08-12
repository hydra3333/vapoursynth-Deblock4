# Deblock4 - Stage 4C Mandatory Pre-Implementation Response (W3C)

**Deliverable:** W3C-4C-PREIMPLEMENTATION-RESPONSE
**Version:** 1.1
**Date:** 2026-08-12
**Author:** W3C (coder)
**Route:** W3C -> W3X -> W3D -> W3X ratification before implementation
**Scope reviewed:** `Deblock4_Scope_Stage_4C_Classic_v2_SSE41_Backend_v1_1.md`
**Source base inspected:** `src(20260812-025856).zip` (accepted Stage 2C tree, identity `0.1.0-dev+2C`)
**Documentation base inspected:** `dev_documentation(20260812-100318).zip`
**Status:** PRE-IMPLEMENTATION RESPONSE ONLY. NO STAGE 4C CODE AUTHORED.
**Encoding:** US-ASCII; CRLF.
**Supersedes:** `Deblock4_Stage_4C_Preimplementation_Response_W3C_v1_0.md`

---

# 0. Why v1.1 supersedes v1.0

The first response was written before W3C had the current `dev_documentation`
tree. That tree is now supplied and has been re-read using only
NON-SUPERSEDED material.

The complete current set contains the previously missing documents, including:

```text
AI_Charter_and_Invariants_Card_v1_27.md
Deblock4_Project_Status_v1_24.md
Deblock4_Verification_And_Tiering_Decisions_v1_11.md
Deblock4_Toolchain_Findings_v1_4.md
README_Deblock4_Design_Spec_v1_10.md
reference/Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_12.md
reference/Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_6.md
reference/Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_11.md
reference/Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_10.md
Scopes/Deblock4_Scope_Stage_4C_Classic_v2_SSE41_Backend_v1_1.md
```

No `superseded/` content was used.

The v1.0 "charter v1.27 unavailable" qualification is therefore WITHDRAWN.

Charter v1.27 explicitly records that its new C-DELIV-01/10/11 changes are
delivery-process changes and make **no Part-1 invariant or project-design
change** (`AI_Charter...v1_27.md:33-43`). Therefore R3 can now be answered
without qualification.

The complete set also exposes one scope-level process defect that v1.0 could
not see: the 4C scope carries the D0 knowledge-sweep block but omits the
mandatory Binding Knowledge Checklist to which that block refers. That finding
is described first below because it affects whether implementation may begin.

---

# 1. Reconsidered document/sweep findings

## F1 - BLOCKER: 4C v1.1 omits the mandatory Binding Knowledge Checklist

Current D0 v1.12 says:

```text
1. W3D (authoring): every scope carries a Binding Knowledge Checklist
   naming the K-items of this index that govern it, produced by
   re-searching the doc set during authoring.
```

Source:
`reference/Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_12.md:477-500`.

It also says the standing mechanism applies to **every scope issued from
Stage 2C onward** (`D0 v1.12:477-482`).

The current 4C scope correctly embeds the verbatim knowledge-sweep block at
lines 43-55. That block itself says W3C searches "WITHOUT starting from the
checklist below" and reports knowledge absent from "the checklist or the
Stage 2C+ Binding Knowledge Index".

But 4C v1.1 contains no `Binding Knowledge Checklist` heading and no equivalent
checklist anywhere in the file.

This is not a mathematical objection to 4C. It is a direct mismatch between
the released scope and the standing D0 process that the scope itself invokes.
W3C cannot silently manufacture W3D's authoring-side checklist and treat that
as satisfying the two-sided mechanism.

**Disposition:** amend/reissue the scope, or otherwise obtain an explicit
W3D recommendation + W3X decision that lawfully resolves the omission, before
implementation release after this response round.

A candidate checklist is supplied in section 2 for W3D's use; W3D remains its
author/verifier.

## F2 - HIGH, non-algorithmic: D0's old delivery K17 is stale against charter v1.27

D0 v1.12 K17 still says, among other things:

```text
every existing target it patches must match its declared base hash
```

and describes the older restore-to-base command model
(`D0 v1.12:349-358`).

Charter v1.27 now says the opposite for current delivery mechanics:

```text
- no commit-hash or per-file base-hash requirement;
- base is the prevailing repository state confirmed with W3X;
- no staging/committing/repository mutation by machinery;
- no PowerShell machinery;
- application and backout are manual W3X acts.
```

See charter v1.27 header `:33-43` and C-DELIV-10/11.

The 4C scope's section 8 is already correct and follows v1.27:

```text
apply_to_tree/ manual copy;
restore_to_base/ pre-change data;
no PowerShell;
no git in machinery;
no patch files;
base confirmed with W3X; no hashes.
```

Therefore this does **not** create an implementation ambiguity: charter v1.27
prevails, and 4C v1.1 already states the correct current process.

It is nevertheless exactly the kind of new committed knowledge that the D0
living index is meant to absorb. W3D should consider appending the next
K-number (candidate `K32`) to record that charter v1.27 supersedes the old
K17/K18 delivery mechanics for current/future scopes, rather than allowing a
future reader to re-derive the conflict.

## F3 - INFORMATIONAL: Project Status v1.24 still names Stage 3C as next

Project Status v1.24 is explicitly informative, not controlling
(`Deblock4_Project_Status_v1_24.md:3-5`), but its state advance still says
Stage 3C is next (`:65-70`).

The later ratified 4C scope says Stage 3C was collapsed by W3X on 2026-08-12
and no 3C identity exists (`4C v1.1:205-209`).

No coding ambiguity follows because the active ratified scope is explicit and
later. This should be corrected in the next Project Status currency refresh.

## F4 - RECLASSIFICATION: the G6 object rule and G10 seam rule are not new K-items

v1.0 reported the object-mode emission/linkage rule and the G10 consequence for
a permanent T5 seam as independent sweep discoveries.

With current D0 v1.12 available, they are already indexed:

```text
K12  Toolchain export/object facts
K14  G10 three-layer debug/test-seam obligations
K15  Backend-object dispatch architecture; backend objects re-enter at 4C/5C
```

See `D0 v1.12:323-348`.

They remain load-bearing implementation duties, but they are **not** new
knowledge-index findings. This correction matters because the two-sided sweep
should append only genuinely missing knowledge, not duplicate existing K-items.

---

# 2. Candidate 4C Binding Knowledge Checklist for W3D to author/verify

This is W3C's proposed content only. It does not substitute for the missing
W3D checklist.

```text
K1     N is vector ELEMENT count, never vector bytes. 4C: u8 N=16,
       u16 N=8. 5C later: u8 N=32, u16 N=16.

K2     v2 integer output is byte-identical to the accepted scalar oracle;
       vector width never defines output.

K3     Keep algorithmic/frame-boundary tails distinct from SIMD batch tails.
       C1 complete footprint remains unchanged; C2 underfill remains valid work.

K5/G9 Explicit @Vector work plus the standing scalar-vs-SIMD differential;
       edge/tail-forcing corpus is acceptance-critical.

K7     Frozen edge footprint: reads e-3..e+2; writes e-2..e+1.

K9     The accepted 2C scalar oracle is now the mandatory reference for every
       4C pixel/backend path; integer differential is exact.

K10    ReleaseSafe/ReleaseFast scalar identity remains a standing re-run gate.

K11    Classic remains Schedule A only. No adjacent-edge batching and no
       Schedule-B/MPEG-2 import.

K12    Retain settled toolchain object/export/linkage facts.

K13    G5: v2 instructions execute only after the proven whole-level guard and
       immutable per-instance selection.

K14    Any permanent test/debug seam is subject to the complete G10
       three-layer absence discipline.

K15    v2 is a separate target-specific object using the settled object-mode
       emission/linkage architecture; no PE-export doorway.

K16    Existing creation-error strings and using-echo surfaces stay byte-stable;
       v2 availability changes only where the 4C scope expressly authorises it.

K19(c) Internal Classic scalar-vs-v2 integer equivalence is merciless
       byte-identity; no tolerance and no HolyWu re-differential.

K21    Do-not-revisit: no twin-build model, no bespoke feature closure, no
       identity-driven feature subtraction.

K23    Diagnostics/reproducibility contract remains: selected tier is the
       actually executed tier; integer output deterministic and exact.

K24    4C may mechanically generalise the call boundary but may not fork or
       rewrite the frozen scalar formulas.

K25    Selection/detection remains whole named psABI level, never feature-grained.

K27    Destination starts copyFrame-equivalent and preserves source properties
       before Deblock4 audit properties are written.

K28    Use actual per-plane width/height/stride/storage. Never infer chroma
       geometry from luma, and never use stride slack as valid pixels.

K29    Format domain remains integer 8..16 only. 17..32 remains the dedicated
       refusal; float remains refused.

K30    New 4C first-class modules have permanent names and one-way dependency;
       the K30-style new-module/added-line audit is delivery evidence.

K31    Strides remain BYTE counts; retain byte-row navigation or a single
       checked conversion, never silent division.

K32?   Proposed new index item from this review: charter v1.27 current delivery
       mechanics supersede the older K17/K18 base-hash/PowerShell-era mechanics;
       no hashes, no repository-operating script, no PowerShell, no staging,
       manual W3X apply/backout.
```

Explicit non-4C items that should not be silently imported:

```text
K4     AVX2 masked-I/O warning -> primarily 5C.
K6/K22/F10 float semantics     -> later bounded float step.
K20    quality-divergence bar  -> deferred quality/enhancement phase.
K26    HolyWu external binary  -> 2C evidence history; 4C does not re-run it.
```

---

# 3. R1 - Assessment of P1-P5 after the full documentation sweep

## P1 - Horizontal-edge vectorisation: CONFIRM

Frozen source:
`src/classic_edge_schedule.zig:87-117`.

For one horizontal edge at y, every output column reads the same six row
positions at that column and writes only that column. Different columns are
independent.

Therefore vectorising across contiguous columns of the SAME horizontal edge is
valid:

```text
u8  -> N=16
u16 -> N=8
```

This is widening positions along one edge, not batching adjacent horizontal
edges. C1 eligibility remains exactly the scalar `edgeEligible()` rule.

## P2 - Vertical-edge vectorisation: AMEND

Frozen source:
`src/classic_edge_schedule.zig:61-85`.

One vertical segment processes at most four rows:

```zig
row_end = min(row_start + edge_step, height)
edge_step = 4
```

Those rows are independent within that one segment.

I recommend **direct four-row lane packing** rather than requiring a 6x4
transpose as the primary 4C structure:

1. load each row's six scalar taps;
2. assemble each corresponding tap into six `@Vector(4,T)` lane packs;
3. widen/run the same vector arithmetic body;
4. coerce results back to fixed arrays;
5. scatter p1/p0/q0/q1 to the four rows.

This does not claim a hardware gather and does not add transpose complexity
unless emitted assembly later proves a real reason for it.

For a bottom segment containing 1, 2, or 3 rows, use scalar cleanup.

P2-alt (scalar verticals throughout 4C) remains the reliable fallback if T3
shows that the four-lane form lowers badly. Reliability outranks making every
orientation look equally vectorised.

## P3 - Traversal reorder: CONFIRM precisely

Frozen source order:
`src/classic_edge_schedule.zig:31-54`.

The top band processes vertical edges only. Leave it unchanged.

For each later row band the scalar order is:

```text
H(0), H(4), V(4), H(8), V(8), ...
```

The proposed equivalent order is:

```text
all H positions for this one horizontal edge,
then V(4), V(8), ... in increasing x order.
```

Proof from the frozen footprint constants/source:

```text
V(x) reads  x-3 .. x+2
V(x) writes x-2 .. x+1

H(x+4) touches column x+4 only
(and later H positions are still farther right)
```

Therefore `H(x+4)` and every later horizontal column are disjoint from
`V(x)` and can move before it.

But successive vertical edges are dependent:

```text
V(x)   writes through x+1
V(x+4) reads from (x+4)-3 = x+1
```

So `V(x+4)` consumes a value written by `V(x)`.

**Result:** W3D's P3 analysis is correct exactly as stated: full horizontal
edge first, then vertical edges in strict increasing-x order. Vertical edges
must never be cross-edge batched or reordered.

## P4 - Memory discipline: CONFIRM the invariant, AMEND the concrete load/store form

K31 remains binding: byte-row navigation is the preferred base, and no silent
stride division is introduced.

C-SIMD-03 remains binding: no stronger alignment assumption without proof.

One Zig 0.16.0 language fact makes the source mechanism more precise than the
scope's phrase "unaligned vector loads/stores":

- fixed arrays and vectors have supported value coercions;
- fixed slices of comptime-known length may be loaded as vectors;
- arrays have defined byte layout but vectors do **not**;
- `@ptrCast` between array/sample memory and vector memory is Illegal Behavior.

Source: Zig 0.16.0 Language Reference, `Vectors` -> `Relationship with Arrays`.

Therefore 4C should NOT implement a vector load/store by overlaying a
`*@Vector(...)` on VapourSynth frame memory.

Recommended source model:

```text
row address: byte arithmetic, exactly as K31;
sample view: one existing/proven cast for u8/u16 indexing;
horizontal full chunk: fixed sample slice/array -> @Vector value coercion;
horizontal store: vector -> fixed array -> sample stores;
vertical: lane-by-lane row loads, vector arithmetic, lane-by-lane scatter.
```

T3 still decides what machine instructions Zig emits. `@Vector` source is not
itself SIMD proof (C-SIMD-01).

## P5 - Tails: CONFIRM with narrower same-body decomposition

Use P5(a), with a deterministic descending power-of-two decomposition of the
same body:

```text
N/2, N/4, ... 2, then scalar 1.
```

No inactive lanes are manufactured, no mask has to make out-of-range lanes
safe, and no read/write exceeds the exact C2 remaining span.

The v1.0 request for a separate ruling on "every remainder at both
orientations" is WITHDRAWN. The current scope is already clear:

- R4 asks for **width remainder 1..N-1** for both T/widths;
- T1 exercises u8/u16 at N and every tail remainder;
- the corpus separately requires an underfilled eligible segment at BOTH
  orientations.

Vertical Schedule-A segments naturally have legal row counts 1,2,3,4 only.
Nothing in the current R4 requires manufacturing impossible vertical
N-wide remainder classes by batching dependent edges.

---

# 4. R2 - Reliable alternatives

## Alternative A - Four-row vertical lane pack (recommended primary)

Advantages:

```text
- follows the exact scalar dependency shape;
- no cross-edge batching;
- no hardware-gather claim;
- no mandatory transpose;
- same arithmetic helper as horizontal vector work;
- scalar bottom cleanup is trivial and exact.
```

Tradeoff:

```text
Four lanes underuse a 128-bit register for u8/u16 and may not be the fastest
possible lowering. That is acceptable in 4C; assembly evidence, not aesthetics,
decides whether the form is worth retaining.
```

## Alternative B - Scalar verticals, vector horizontal edges

Advantages:

```text
- least-risk vertical implementation;
- horizontal path captures the naturally contiguous SIMD opportunity;
- scalar vertical semantics are already oracle-proven.
```

Tradeoff:

```text
- less vector coverage in 4C;
- later 5C may still choose to introduce the four-row vector form.
```

If Alternative A lowers pathologically, choose B rather than add an elaborate
transpose merely to force more SIMD-looking source.

---

# 5. R3 - Reliability cross-check of the prior ratified reasoning

**THE RATIFIED REASONING HOLDS UNCHANGED.**

This statement is now unqualified.

Charter v1.27 expressly says its new delivery rules make no Part-1 invariant or
project-design change. Re-reading the actual current charter, D0 v1.12,
V&T v1.11, Toolchain Findings v1.4, README v1.10 fallback guidance, and the
accepted source produces no reason to relax or reinterpret:

```text
G3       full named x86-64 psABI tiers; within-level assembly confirmation;
G5       target-specific instructions execute only after the proven guard;
G6       emission/linkage/PE-export are separate controlled properties;
G9       scalar-vs-SIMD differential is a standing toolchain gate;
G10      permanent debug/test seams require the three-layer absence pattern;
C-SIMD-01 @Vector syntax is not code-generation proof;
C-SIMD-02 vector width is explicit per backend/type;
C-SIMD-03 byte stride/alignment assumptions are explicit and proven;
C-SIMD-04 no semantic shortcut is licensed (integer 4C does not need float);
C-SIMD-05 lane-packed strided loads are not called hardware gather without
          assembly evidence.
```

Toolchain Findings v1.4 F9 confirms the pinned Zig 0.16.0 LLVM loop
autovectoriser is disabled. Therefore 4C must obtain vector code from explicit
`@Vector` work and verify it in T3; the scalar oracle remains genuinely scalar.

The accepted +2C oracle strengthens the reasoning: 4C no longer argues from a
paper algorithm but from a byte-anchored executable reference.

---

# 6. R4 - Concrete parametrisation plan

## 6.1 Tier-neutral source

`src/classic_vector_backend.zig`:

```zig
pub fn processPlane(
    comptime T: type,
    comptime N: usize,
    plane: BytePlane,
    thresholds: Thresholds,
) void
```

The full horizontal width is `N`.

A narrow internal lane helper uses the same formula for any compile-time lane
count `L`:

```zig
fn filterLanes(
    comptime T: type,
    comptime L: usize,
    samples: LaneSamples(T, L),
    thresholds: Thresholds,
) LaneResult(T, L)
```

Rules:

```text
T is exactly u8 or u16.
Storage width and bitsPerSample remain distinct.
Arithmetic widens every lane to i32 before the scalar-equivalent formula.
Thresholds are i32 lane values.
The scalar shifts/clamps are reproduced exactly.
No saturating-instruction shortcut replaces the formula without independent
byte-identity proof.
```

## 6.2 4C thin target object

`src/classic_backend_v2_sse41.zig` binds:

```text
u8  -> processPlane(u8, 16, ...)
u16 -> processPlane(u16, 8, ...)
```

It is the standalone named-v2 compilation unit.

Per existing K12/K15/G6:

```text
- the target-specific object owns its emission root;
- cross-object linkage uses the established object-mode export/extern pattern;
- the vector ABI is not exposed across the object boundary;
- no v2 symbol becomes a public PE-export doorway;
- no registration/static-init path executes v2 instructions;
- the per-instance selected tier is the guard before the v2 call.
```

The external ABI should pass pointers plus scalar dimensions/stride/threshold
data, not Zig vector values.

## 6.3 5C slot-in

Stage 5C adds only the sibling target object and different N values:

```text
u8  -> N=32
u16 -> N=16
```

The shared `classic_vector_backend.zig` file is unchanged.

The vertical four-row lane geometry is also unchanged: it comes from the
frozen Schedule-A `edge_step=4`, not from register width. This is exactly what
prevents 5C from tempting the implementation into illegal cross-edge vertical
batching.

## 6.4 4C horizontal tail table

For u8, N=16:

```text
r= 1 -> 1 scalar
r= 2 -> V2
r= 3 -> V2 + 1
r= 4 -> V4
r= 5 -> V4 + 1
r= 6 -> V4 + V2
r= 7 -> V4 + V2 + 1
r= 8 -> V8
r= 9 -> V8 + 1
r=10 -> V8 + V2
r=11 -> V8 + V2 + 1
r=12 -> V8 + V4
r=13 -> V8 + V4 + 1
r=14 -> V8 + V4 + V2
r=15 -> V8 + V4 + V2 + 1
```

For u16, N=8:

```text
r=1 -> 1 scalar
r=2 -> V2
r=3 -> V2 + 1
r=4 -> V4
r=5 -> V4 + 1
r=6 -> V4 + V2
r=7 -> V4 + V2 + 1
```

Every `Vk` is the SAME `filterLanes(T,k,...)` body, not a second formula.

For future 5C:

```text
u8 N=32  -> start with V16, then the same 8/4/2/1 decomposition;
u16 N=16 -> exactly the N=16 table above.
```

## 6.5 Vertical underfill table

```text
legal rows in one Schedule-A vertical segment
4 -> V4 lane pack
3 -> scalar 3 rows
2 -> scalar 2 rows
1 -> scalar 1 row
```

This table is independent of N.

---

# 7. Dispatch/object-boundary plan

The inspected accepted `src/backend_tier_selection.zig` already implements the
generic lower-of(EFFECTIVE, implementation-ceiling) rule and the required
precedence:

```text
EFFECTIVE capability refusal before implementation-availability refusal;
intentionally-capped reporting when the implementation ceiling is lower.
```

Therefore source inspection currently gives no reason to edit that file in 4C.
The scope already authorises it only "if wiring requires".

The expected 4C change is the single config ceiling:

```text
classic_tier_ceiling:
    v1 -> v2
```

and the Classic frame-path dispatch:

```text
selected v1 -> existing scalar branch, retained verbatim;
selected v2 -> call the matching u8/u16 v2 object entry;
selected v3 -> unreachable/invariant failure in 4C because the ceiling is v2.
```

The build graph adds the standalone named-v2 object and retains it for T3
inspection. Detection logic is not altered.

---

# 8. R5 - Authorised-surface additions

## 8.1 Permanent production surface

No additional permanent production source file is presently required beyond
the exact section-2 authorisation.

In particular:

```text
- no new common ABI file is justified merely for two v2 entry points;
- backend_tier_selection.zig should remain byte-stable unless real wiring
  evidence requires its authorised conditional edit;
- no existing G10 debug module should be touched for ordinary vector work.
```

## 8.2 T5 one-lane corruption control requires one explicit W3D/W3X interpretation

The scope requires a deliberate one-lane tail perturbation "in a test-only
seam" that T1/T2 catches.

If that means a **permanent in-repository conditional seam**, G10 applies
verbatim because G10 expressly includes test seams. That would require:

```text
- explicit opt-in build option, default off;
- hard reject outside Debug;
- source-visible gated module inclusion;
- individually gated content;
- three-surface production-absence proof;
- an authorised G10 module/config/build surface.
```

The current 4C section-2 surface does not authorise that additional debug
module and explicitly forbids changes to G10 modules beyond their established
seams.

W3C therefore recommends the simpler negative-control mechanism:

```text
- build_4C_v1.bat creates a temporary copied source/build tree outside the repo;
- the copy receives one narrow one-lane tail-result mutation;
- the mutant is built/run only as the negative control;
- T1/T2 must reject it;
- no repository file is modified;
- no git, PowerShell, staging or repository operation is performed;
- the temporary copy is discarded.
```

This satisfies the purpose of T5 without shipping debug-only corruption code.

**W3D/W3X ratification is requested on whether this temporary-copy mutation
satisfies the scope's phrase "test-only seam".**

If the answer is no, W3D must expand the authorised surface and specify the G10
seam before W3C implements it.

## 8.3 W3D-owned differential harness

Section 8 assigns the `.vpy/.cmd` 4C differential harness to W3D. It is not in
the supplied accepted source tree.

That is not a defect in this pre-implementation response, but the W3D harness
must be available before the final integrated 4C proof package can be
validated by W3X.

---

# 9. Required W3D/W3X outcomes before implementation

The corrected round should resolve these items:

```text
4C-RAT-1  Fix the F1 checklist omission: W3D supplies the Binding Knowledge
          Checklist required by D0 v1.12; W3X ratifies the corrected scope
          state before implementation.

4C-RAT-2  Confirm P3: one horizontal edge may be completed across its full
          valid width before that band's vertical edges; vertical edges remain
          strict increasing-x.

4C-RAT-3  Approve direct four-row vertical lane packing as primary, with
          scalar 1..3-row cleanup and full-scalar verticals as fallback if T3
          proves poor lowering.

4C-RAT-4  Approve descending narrower same-body horizontal tails
          (N/2, N/4, ... 2, scalar 1), with no masked inactive lanes.

4C-RAT-5  Approve defined-layout array/slice <-> vector value coercion and
          forbid vector-pointer overlay on frame memory.

4C-RAT-6  Decide T5 seam mechanics: approve temporary copied-tree mutation, or
          amend the authorised surface for a full G10 in-tree test seam.

4C-RAT-7  W3D considers D0 update/new K32 for charter-v1.27 delivery mechanics
          superseding the older K17/K18 process wording.

4C-RAT-8  Informational currency cleanup: Project Status should no longer say
          Stage 3C is next after the later W3X 2026-08-12 collapse decision.
```

No separate "charter availability" ruling is needed; v1.0's request for that is
withdrawn.

No separate "vertical every N remainder" ruling is needed; v1.0's request for
that is also withdrawn.

---

# 10. W3C final disposition after reconsideration

The full documentation set does **not** overturn the technical vector design
conclusions.

Technical result:

```text
P1  CONFIRM.
P2  AMEND to direct four-row lane packing; scalar vertical fallback retained.
P3  CONFIRM from frozen source dependency sets.
P4  CONFIRM invariant; AMEND source load/store mechanism to Zig-defined
    array/slice <-> vector coercion, no vector pointer overlay.
P5  CONFIRM narrower same-body decomposition.
R3  THE RATIFIED REASONING HOLDS UNCHANGED.
```

Process result:

```text
The 4C scope is not yet implementation-ready because its own governing D0
v1.12 two-sided-sweep protocol requires a W3D-authored Binding Knowledge
Checklist, and the released 4C v1.1 file does not contain one.
```

That is the only newly found issue that I regard as a pre-implementation
blocker.

D0's stale delivery K17 wording and Project Status's stale Stage-3C-next text
are real currency findings but do not create a 4C coding ambiguity because
charter v1.27 and the active ratified 4C scope explicitly settle those matters.

No Stage 4C production code has been authored.
