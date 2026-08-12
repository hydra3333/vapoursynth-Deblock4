# Deblock4 - Stage 4C Mandatory Pre-Implementation Response (W3C)

**Deliverable:** W3C-4C-PREIMPLEMENTATION-RESPONSE
**Version:** 1.0
**Date:** 2026-08-12
**Author:** W3C (coder)
**Route:** W3C -> W3X -> W3D -> W3X ratification before implementation
**Scope reviewed:** `Deblock4_Scope_Stage_4C_Classic_v2_SSE41_Backend_v1_1.md`
**Source base inspected:** `src(20260812-025856).zip` (accepted Stage 2C tree, identity `0.1.0-dev+2C`)
**Status:** PRE-IMPLEMENTATION RESPONSE ONLY. NO STAGE 4C CODE AUTHORED.
**Encoding:** US-ASCII; CRLF.

---

# 0. Document-availability note

The supplied Stage 4C v1.1 scope is exact and ratified, and the attached accepted
Stage 2C source tree has been inspected directly.

The independent knowledge sweep also retrieved the non-superseded project
documentation available to W3C, including charter v1.26 and the Stage 1B
object-isolation/runtime-guard records. The scope names charter v1.27 or later
as prevailing. The exact charter v1.27 file was not present in the supplied
source archive and was not retrievable in the available document set. The
scope itself restates the v1.27-specific no-script delivery rules.

For the Part-1 safety and SIMD clauses below, this response therefore uses the
retrievable v1.26 text plus the v1.1 scope's explicit v1.27 statements. W3D
should verify during this response round that v1.27 did not alter G3/G5/G6/G9/
G10, C-STY-09/10, or C-SIMD-01..05 relative to v1.26. If it did, the changed
text must be supplied and this response rechecked before implementation.

This is a document-availability qualification, not a proposal to alter the 4C
scope.

---

# 1. Independent knowledge sweep findings

The sweep was performed without using the Stage 4C checklist as the search
index, as required by the scope's standing knowledge-sweep rule.

## KS-1 - G6 object-mode emission/linkage is load-bearing in 4C

The settled Stage 1B mechanism distinguishes three separate properties:

1. emission is decided inside each compilation unit;
2. cross-object linkage uses `export`/`@export` on the definition side and
   `extern`/`@extern` on the reference side; and
3. a Zig `export fn` compiled in an OBJECT-mode unit does not, by itself, make
   that symbol a PE export of the final DLL.

A reference from a different compilation does not force the target-specific
function to be emitted. Therefore the new v2 backend unit must contain its own
semantic linkage root, normally an `export fn`, and the baseline DLL unit must
reach it through the settled extern boundary. The v2 entry point must remain
absent from the DLL PE export table and unreachable before the already-proven
capability/selection guard.

This is more specific than S4C-5's general "own object" wording and should be
carried explicitly into the 4C implementation and T3 inspection.

## KS-2 - A permanent T5 test seam would itself be governed by G10

G10 governs code whose EXISTENCE is conditional, including test seams. A
permanent source seam used to corrupt one vector tail lane could not simply be
hidden behind an ordinary branch or a test flag. It would require the complete
three-layer G10 pattern: explicit opt-in/default-off build option, non-Debug
hard rejection, source-visible gated inclusion and use, and production
three-surface absence proof.

A safer alternative is proposed under R5: perform the deliberate bad-lane
perturbation only in a temporary copied source tree from `build_4C_v1.bat`.
That leaves no test seam in first-class production source.

## KS-3 - Zig 0.16.0 vector memory layout constrains the load/store design

Zig 0.16.0 gives arrays a defined byte layout but does not give vectors a
defined byte layout. Pointer-casting between an array/sample-memory location
and a vector is therefore not a valid load/store mechanism.

The same language reference explicitly supports conversion between fixed
arrays and vectors, and loading a vector from a slice when the extracted
length is comptime-known.

Consequently 4C should not implement "unaligned vector loads/stores" as
`*@Vector` pointer casts. The safe interpretation is:

- retain K31 byte-row navigation;
- retain only the already-proved sample alignment needed to obtain a typed
  sample row;
- obtain horizontal vector values through fixed-array/slice-to-vector
  coercion;
- convert vector results back to fixed arrays for stores; and
- use lane-by-lane scalar loads/stores for strided vertical rows.

The generated machine instructions still require T3 inspection; source
`@Vector` syntax alone proves neither SIMD emission nor efficient lowering.

## KS-4 - Current tier-selection source already supports the raised ceiling

The accepted `src/backend_tier_selection.zig` is already parameterised by an
implementation ceiling. It already implements:

- `auto` as the lower of EFFECTIVE capability and implementation ceiling;
- EFFECTIVE-capability refusal before implementation-availability refusal; and
- `intentionally-capped(...)` reporting when the implementation ceiling is
  below effective capability.

No v2-specific selection algorithm is required. On the inspected +2C source,
`src/backend_tier_selection.zig` should remain byte-stable unless later
integration exposes a concrete need that is not presently visible.

## Do-not-revisit confirmations

The sweep found no reason to reopen any of these settled decisions:

- full named x86-64 psABI levels, not bespoke feature closures;
- the committed Classic scalar oracle and its frozen arithmetic/schedule;
- integer byte identity across scalar/v2/v3;
- no HolyWu re-differential in 4C;
- no float work in 4C;
- no vzeroupper proof before Stage 5C;
- no adjacent Classic edge batching that violates the uniform Schedule-A.

W3D may assign K-numbers to confirmed KS findings in the normal manner.

---

# 2. R1 - Assessment of designer proposals P1-P5

## P1 - Horizontal-edge segments: CONFIRM, with the P3 ordering amendment

The frozen scalar schedule processes a horizontal edge in 4-column segments,
but within one horizontal edge every column is independent: each lane reads the
same six rows at its own column and writes only that column in four of those
rows.

Therefore a complete eligible horizontal edge may be processed across
contiguous columns in full-width `N` chunks, followed by its C2 tail. This is
not batching adjacent horizontal EDGES; it is widening the independent
positions along ONE edge.

Recommended 4C forms:

- u8: `N = 16`;
- u16: `N = 8`.

The six horizontal tap rows are natural contiguous source ranges. The memory
mechanism is amended by P4 below: typed fixed-array/slice conversion into
vectors, not vector pointer casts.

## P2 - Vertical-edge segments: AMEND

I do not recommend making a 6x4 in-register transpose the primary 4C design.

The frozen schedule gives each vertical segment at most four rows. Those four
rows are independent WITHIN the segment, but the next vertical edge is not
independent of the current vertical edge.

Recommended 4C vertical implementation:

1. for a full four-row segment, load each row's six scalar taps;
2. pack the corresponding taps into six `@Vector(4, T)` values (or fixed
   `[4]T` arrays coerced to those vectors);
3. run the SAME generic lane arithmetic used by the horizontal path;
4. convert the four result vectors to arrays; and
5. scatter the four rows' p1/p0/q0/q1 stores.

This is explicit vector arithmetic inside the legal four-row segment without
claiming a hardware gather and without adding a transpose whose only purpose
would be to manufacture a layout that the source does not naturally have.

For a bottom vertical segment containing 1, 2, or 3 rows, scalar cleanup is my
recommended 4C choice. It is simple, exact, and cannot overread.

The scope's P2-alt (scalar verticals throughout 4C) remains a reliable fallback
if inspection shows the four-lane vector form scalarises pathologically, but it
is not my first choice because the four-lane design keeps one vector arithmetic
path active for both orientations and requires no 5C structural rewrite.

## P3 - Traversal reordering: CONFIRM, with a precise dependency proof

The proposed reordering is valid in this exact form:

> for one row band, process all horizontal positions of the eligible horizontal
> edge first, then process the band's vertical edges in increasing x order.

Frozen source facts:

- `edge_step = 4`;
- vertical edge `V(x)` reads columns `x-3 .. x+2`;
- `V(x)` writes columns `x-2 .. x+1`;
- the later horizontal scalar segment beginning at `x+4` touches columns
  `x+4 .. x+7` only.

Therefore moving `H(x+4)` (and all still-later horizontal positions) ahead of
`V(x)` is safe: their column sets are disjoint.

However successive vertical edges are NOT independent:

- `V(x)` writes through column `x+1`;
- `V(x+4)` reads starting at `(x+4)-3 = x+1`.

Thus `V(x+4)` reads a value written by `V(x)`. Vertical edges must remain in
increasing-x order and must not be batched across edge boundaries.

The top-band vertical-only pass remains unchanged.

This confirms W3D's proposed P3 transformation while preserving S4C-3 exactly.

## P4 - Memory discipline: CONFIRM the invariant, AMEND the concrete vector load/store mechanism

Confirmed:

- VapourSynth strides remain byte counts.
- Row navigation remains in bytes.
- The existing one-cast-per-row/sample-type model is retained.
- No stronger alignment assumption or `@alignCast` is introduced for vector
  alignment.
- No hardware gather is claimed without assembly evidence.

Amended concrete mechanism:

- do not cast a sample pointer to a vector pointer;
- horizontal full chunks use typed sample slices/fixed arrays converted to
  `@Vector`;
- result vectors convert back to fixed arrays before sample stores;
- verticals use lane-by-lane row loads and scatter stores.

This follows Zig 0.16.0's defined array/vector coercions while respecting its
lack of defined vector byte layout.

## P5 - Tails: CONFIRM with narrower same-body decomposition; request one wording clarification

Recommended horizontal C2 tail mechanism is a descending power-of-two
decomposition of the same generic lane body:

- try `N/2`, then `N/4`, continuing to 2 lanes;
- process a final one lane with scalar cleanup.

Examples:

- N=16, remainder 15 -> 8 + 4 + 2 + 1;
- N=16, remainder 9  -> 8 + 1;
- N=8,  remainder 7  -> 4 + 2 + 1.

There are no inactive lanes, no masks that need independent validity proof, no
undefined fill values, and no read or write beyond the exact C2 span.

### Clarification requested: "every tail remainder" and vertical orientation

For a horizontal width loop, every remainder `1 .. N-1` is meaningful and can
be exercised.

A vertical Schedule-A segment, however, has a maximum legal row count of four
because `edge_step == 4`. Its only underfill row counts are 1, 2, and 3 (with 4
as the full segment). It cannot naturally possess remainders 5..15 at N=16 or
5..7 at N=8 without illegally batching across dependent vertical edge
segments.

I therefore read section 7 as requiring:

- horizontal: exercise every remainder `1 .. N-1` for the backend width; and
- vertical: exercise every legal segment row count 1, 2, 3, 4, including an
  underfilled vertical edge in end-to-end corpus evidence.

Please ratify that interpretation. If "every N remainder at both orientations"
was intended literally, it conflicts with S4C-3 and the frozen schedule.

---

# 3. R2 - Reliable alternatives and tradeoffs

## Alternative A - Four-row vertical lane-pack (RECOMMENDED)

This is the P2 amendment above.

**Advantages**

- exact dependency model;
- no cross-edge batching;
- no gather claim;
- no transpose dependency;
- same arithmetic body as horizontal vector work;
- simple bottom-tail fallback;
- straightforward byte-identity proof.

**Tradeoff**

A four-lane vector underuses a 128-bit register for u8/u16 and may lower to a
less attractive instruction sequence. In 4C this is acceptable: correctness
and code-generation evidence outrank speed.

## Alternative B - Scalar verticals, vector horizontal edges

This is the scope's P2-alt and remains a valid conservative fallback.

**Advantages**

- minimum vertical-risk implementation;
- frozen scalar vertical semantics are already proven;
- all difficult SIMD work is concentrated in the naturally contiguous
  horizontal direction.

**Tradeoff**

- less 4C vector coverage;
- potential later desire to introduce vertical vector arithmetic in 5C.

No output argument distinguishes A from B: both must be byte-identical to the
scalar oracle. If A's assembly is poor, B is preferable to adding a complex
transpose merely to make the source look more SIMD-like.

---

# 4. R3 - Reliability cross-check of the ratified reasoning

Subject to the charter-v1.27 availability qualification in section 0:

**THE RATIFIED REASONING HOLDS UNCHANGED.**

The current position strengthens rather than weakens the earlier reasoning.

1. **Named-tier safety still binds.** The 4C object targets the complete
   `x86_64_v2` psABI level, not "whatever instructions happened to appear" and
   not a bespoke SSE4.1-only closure. Assembly inspection confirms
   within-level containment; it does not redefine the tier.

2. **G5 still binds at the call boundary.** The target-specific object may be
   linked into the DLL, but the v2 entry point is reached only after the
   immutable per-instance selection has resolved v2 on capable hardware. There
   is no hot-path CPUID test and no bypass.

3. **G6 is especially important now.** Emission, linkage, and PE export remain
   separate proofs. The v2 object must own its emission root; the baseline root
   must not accidentally become the target-specific compilation graph.

4. **G9 is now directly live.** Stage 2C gives 4C a byte-anchored scalar oracle.
   Because Zig/LLVM miscompiles can cluster at tails, width-nonmultiple,
   strong-edge corpus cases are acceptance-critical rather than performance
   tests.

5. **C-SIMD-01/02 remain literal.** `@Vector` source is not proof of SSE
   instructions. Widths are explicit backend contracts and assembly must show
   the intended vector paths while the v1 object remains free of v2-class
   instructions.

6. **C-SIMD-03 reads more concretely after source inspection.** The existing
   K31 byte-stride discipline is exactly the right base. Zig vector byte layout
   must not be overlaid on VapourSynth storage by pointer cast.

7. **C-SIMD-04 is not active in 4C.** This scope is integer u8/u16 only. It must
   not be used to justify or anticipate float shortcuts.

8. **C-SIMD-05 remains a claim-discipline rule.** Four strided vertical row
   loads may be assembled into a vector, but that is not called a hardware
   gather unless emitted assembly proves one.

9. **R79 changes no 4C arithmetic or memory guarantee.** The Stage 2C R79
   integration repairs affected Python fixture/plugin-loading mechanics, not
   the Classic pixel algorithm, host alignment contract, or dispatch tier
   contract.

10. **The uniform Schedule-A fact narrows vector freedom.** It permits
    horizontal widening inside an edge and the proven P3 ordering only; it does
    not permit adjacent edge batching.

---

# 5. R4 - Concrete parametrisation plan

## 5.1 Tier-neutral generic source

`src/classic_vector_backend.zig` remains free of x86-tier assumptions.

Conceptual shape:

```zig
pub fn processPlane(
    comptime T: type,
    comptime N: usize,
    plane: Plane,
    thresholds: Thresholds,
) void

fn filterLanes(
    comptime T: type,
    comptime L: usize,
    samples: LaneSamples(T, L),
    thresholds: Thresholds,
) LaneResult(T, L)
```

`N` is the backend's full horizontal lane width.

`L` is the current lane-pack width. It is derived only from `N` for horizontal
tails, or from the frozen four-row vertical segment geometry. The arithmetic
body remains one implementation.

Inside `filterLanes`:

- storage lanes are u8 or u16;
- every arithmetic operand is widened to `@Vector(L, i32)`;
- thresholds are splatted to i32 vectors;
- comparisons produce lane masks;
- shifts and clamps reproduce the scalar i32 semantics exactly;
- output lanes are explicitly range-clamped before narrowing to T.

No saturating shortcut replaces the scalar expressions unless separately
proved byte-identical.

## 5.2 4C thin instantiation object

`src/classic_backend_v2_sse41.zig` is the only 4C target-specific source root.

It binds:

```text
u8  -> processPlane(u8, 16, ...)
u16 -> processPlane(u16, 8, ...)
```

The object is compiled under Zig's named `x86_64_v2` CPU model. It contains
per-object comptime target-membership checks consistent with the established
named-model Set-A/Set-B discipline.

The object exposes permanent C-ABI linkage roots for u8 and u16 processing.
The baseline frame path declares matching externs. The cross-object ABI passes
pointers and scalar geometry/threshold values, not Zig vector types and not an
unstable vector-memory representation.

The exact ABI declaration spelling is compile-gated during implementation; no
new shared ABI module is presently necessary.

## 5.3 5C slot-in

Stage 5C adds only the sibling target-specific instantiation root and build
target:

```text
u8  -> processPlane(u8, 32, ...)
u16 -> processPlane(u16, 16, ...)
```

`src/classic_vector_backend.zig` is unchanged.

The vertical four-row lane-pack is also unchanged because its lane geometry is
derived from Schedule-A's `edge_step`, not from the machine register width.
This is desirable: 5C changes backend width without inventing illegal
cross-edge vertical batching.

## 5.4 Horizontal tail table

| Stage/backend | T | Full N | Tail chunks for any remainder r |
|---|---:|---:|---|
| 4C v2 | u8  | 16 | 8, 4, 2, 1 in descending applicable combination |
| 4C v2 | u16 | 8  | 4, 2, 1 in descending applicable combination |
| 5C v3 | u8  | 32 | 16, 8, 4, 2, 1 in descending applicable combination |
| 5C v3 | u16 | 16 | 8, 4, 2, 1 in descending applicable combination |

Thus every `r` in `1 .. N-1` is exactly the sum of the processed chunk sizes.
No chunk crosses the remaining valid span.

The `1` lane is scalar cleanup. All larger tail chunks instantiate the same
`filterLanes` arithmetic with a smaller comptime `L`.

## 5.5 Vertical tail table

The vertical segment's legal row count is independent of backend N:

| Rows remaining in the legal segment | Action |
|---:|---|
| 4 | `filterLanes(T, 4, ...)` |
| 3 | scalar cleanup for 3 rows |
| 2 | scalar cleanup for 2 rows |
| 1 | scalar cleanup for 1 row |

A later ratified refinement may use `L=2` for the two-row case, but 4C does not
need it for correctness and I do not recommend adding it before assembly
evidence establishes a reason.

---

# 6. Dispatch and object-boundary plan

The accepted baseline frame path currently hard-rejects any selected Classic
tier other than v1 and then calls the frozen scalar schedule.

4C should turn that point into a simple selected-tier switch:

```text
v1 -> existing scalar branch, retained verbatim
v2 -> call the correct u8/u16 extern linkage root from the v2 object
v3 -> invariant failure in 4C
```

The v1 branch remains the differential reference.

`src/backend_tier_selection.zig` does not need a 4C edit on the inspected
source. Raising only `deblock4_config.implementation.classic_tier_ceiling` to
v2 is sufficient for its generic selection logic.

The build graph gains:

- explicit baseline target exactly as today;
- explicit named `x86_64_v2` target;
- standalone `classic_backend_v2_sse41` object;
- linkage of that object into the Deblock4 DLL;
- install/copy of the object for T3 inspection; and
- vector/backend tests compiled under the v2 target.

The target-specific object is not called from any registration/static-init
path.

---

# 7. R5 - Authorised-surface additions and requested ratifications

## 7.1 No additional permanent production source file is presently required

I propose no permanent production file outside the scope's authorised list.

In particular:

- leave `src/backend_tier_selection.zig` byte-stable unless a real integration
  need appears;
- do not add a common ABI module solely for two backend calls;
- do not add a permanent tail-corruption debug module if T5 can be discharged
  by temporary copied-tree mutation.

## 7.2 T5 perturbation mechanism - ratification requested

Preferred mechanism:

1. `build_4C_v1.bat` creates a temporary copied source tree for the negative
   control;
2. it makes one narrowly identified one-lane tail-result mutation in the copied
   `classic_vector_backend.zig`;
3. it runs the relevant 4C-T1 and 4C-T2 differential checks and requires them
   to reject the mutant;
4. it discards the temporary tree.

This is analogous in spirit to the existing named-model perturbation: the bad
code is validation scaffolding and never exists in the production source tree.

Please ratify that this satisfies section 7's "test-only seam" wording.

If W3D/W3X instead require an in-tree conditional corruption seam, section 2's
authorised surface must be expanded before coding to include a dedicated G10
debug module plus its config/build gate and three-surface production-absence
proof. W3C will not add that surface without explicit ratification.

## 7.3 W3D-owned harness dependency

Section 8 assigns the `.vpy`/`.cmd` 4C differential harness to W3D. It was not
part of the supplied source archive. W3C does not invent it.

This does not prevent completion of the present pre-implementation response,
but the harness is required before final integrated 4C proof/delivery.

---

# 8. Points proposed for W3D verification / W3X ratification

For clarity, the response asks the round to settle these concrete points:

**4C-RAT-1 - P3 ordering proof**
Confirm: all horizontal positions of one eligible horizontal edge may be
processed before the band's vertical edges; vertical edges remain in strict
increasing-x order.

**4C-RAT-2 - Vertical vector shape**
Approve the four-row lane-pack as the primary 4C vertical vector form, with
scalar cleanup for 1..3 bottom rows; retain full-scalar verticals as fallback
if T3 shows pathological lowering.

**4C-RAT-3 - Tail mechanism**
Approve descending narrower same-body chunks (`N/2`, `N/4`, ..., 2, scalar 1)
instead of masked inactive lanes.

**4C-RAT-4 - Zig vector memory mechanism**
Approve fixed-array/slice <-> vector coercion and forbid vector pointer
overlay/casts on frame memory.

**4C-RAT-5 - Tail coverage interpretation**
Confirm every `1 .. N-1` horizontal width remainder is required, while vertical
coverage is every legal row count 1,2,3,4 rather than impossible N-wide
cross-edge remainder classes.

**4C-RAT-6 - T5 negative-control implementation**
Approve temporary copied-tree one-lane mutation rather than a permanent G10
production-source seam.

**4C-RAT-7 - Charter availability check**
W3D confirms charter v1.27 did not materially change the Part-1/C-SIMD safety
clauses used here relative to the retrievable v1.26 text, or supplies the delta
for re-review.

Once W3X ratifies the response outcome, W3C can begin implementation. Until
then, no 4C production code should be authored.

---

# 9. W3C disposition

The Stage 4C v1.1 scope is technically coherent against the accepted +2C
source. I find no algorithmic blocker.

The designer's core direction is accepted with three implementation-level
amendments:

1. direct four-row vertical lane packing instead of a required transpose;
2. defined-layout array/slice vector loads/stores instead of vector pointer
   overlays; and
3. binary-decomposed narrower-vector horizontal tails.

P3 is positively CONFIRMED by the frozen source dependency sets.

Implementation should remain on hold only for the mandatory W3D/W3X
ratification of the points in section 8, as required by scope section 6.
