# Deblock4 - Stage 5C - W3C Pre-Implementation Response

**Role:** W3C (coder) response to W3D (designer), through W3X (coordinator)  
**Scope reviewed:** `Deblock4_Scope_Stage_5C_Classic_v3_AVX2_Backend_v1_0.md`  
**Source base inspected:** W3X-supplied `0.1.0-dev+4C` tree  
**Status:** PROVISIONAL REVIEW - no implementation performed  
**Reason provisional:** the scope names charter v1.29 or later, while the newest documentation package presently available to W3C contains charter v1.28.

## DECISIONS/QUESTIONS FOR W3X

### Q1. The declared authority set is one charter generation ahead of the package I possess.

The Stage 5C draft says charter v1.29 or later prevails. The newest documentation package available to me contains charter v1.28.

Why it matters: version currency and generation consistency are STOP-class project rules. I can inspect the source and assess the design now, but I cannot represent this as the completed mandatory authority-set review without reading the charter generation the scope actually names.

**Recommendation:** provide the updated documentation package containing ratified charter v1.29 before Stage 5C is released for implementation. I do not recommend changing the scope back to v1.28 unless the v1.29 reference was itself an error.

Options:

- **Provide v1.29 package - RECOMMENDED.** Preserves the scope as written and permits the final delta knowledge sweep.
- **Correct scope to v1.28.** Appropriate only if no charter v1.29 actually exists.

(refs: charter 2.3a; Stage 5C authority-set header)

### Q2. The proof wording for "both orientations" should distinguish the 256-bit horizontal path from the fixed four-row vertical path.

The scope correctly says the vertical Classic path does not scale with N: it remains a four-row lane pack. Later, however, the corpus asks for a case where an eligible segment is "shorter than a full 256-bit vector at BOTH orientations."

Why it matters: there is no 256-bit vertical batch to underfill. Leaving that wording could encourage a future harness or maintainer to manufacture a vertical 256-bit condition that the ratified algorithm explicitly forbids.

**Recommendation:** amend the corpus obligation to require:

- horizontal: a valid C2 tail shorter than the full Stage 5C N=32/N=16 batch; and
- vertical: legal bottom underfill of the width-invariant four-row path, covering row counts 1, 2 and 3 as appropriate.

Options:

- **Correct the wording - RECOMMENDED.** Matches the frozen source and the accepted Stage 4C reasoning.
- **Retain the wording with an explicit interpretation note.** Technically salvageable, but unnecessarily ambiguous.

(refs: S5C-1; S5C-4; section 4 Face 4; section 7 corpus; 4C-RAT-3)

### Q3. Add a dedicated Stage 5C unit-test root and make near-edge memory guards explicit.

The frozen vector-body file cannot be edited. Its existing tests are primarily instantiated at the accepted Stage 4C widths. Stage 5C therefore needs a clean home for the N=32/N=16-specific differential, tail, alignment and canary tests.

There is also a durable verification requirement not stated explicitly enough in the Stage 5C proof text: memory safety is tested with realistic minimal sample alignment, non-vector-aligned rows/strides, canaries, and no assumed padding.

Why it matters: the principal Stage 5C hazard is precisely a right-edge over-read. A byte-identical result alone is weaker evidence if an accidental over-read merely lands harmlessly in allocated stride slack.

**Recommendation:** authorise one new W3C test-only file:

`tests/classic_vector_backend_5c_tests.zig`

It should import the frozen vector body and scalar oracle, never be imported by production code, and exercise:

- u8 N=32 and u16 N=16;
- every remainder;
- sample-valid but deliberately non-16/32-byte-aligned base positions;
- non-vector-aligned stride values;
- row-slack, prefix and suffix canaries;
- strong edge data so tail execution is non-vacuous.

Options:

- **Dedicated test file - RECOMMENDED.** Keeps the new production v3 unit a clean mirror of v2.
- **Put the tests in `classic_backend_v3_avx2.zig`.** Fewer files, but damages the thin-unit mirror and mixes production object responsibilities with substantial test fixtures.

(refs: C-SIMD-03; Concise Project Summary section 7; S5C-4; R5)

### Q4. I recommend a more repeatable form for the non-gating benchmark.

A plain batch-file wall-clock calculation is possible, but the project already has a proven Python-based W3D harness pattern.

Why it matters: the benchmark is intentionally non-gating, but poor timing methodology would still produce weak knowledge about whether AVX2 helped.

**Recommendation:** W3D owns a small Python benchmark runner using `time.perf_counter()` around the exact `vspipe` process. Run one unrecorded warm-up per backend, then three recorded runs per scalar/v2/v3 backend, with output discarded identically and every raw duration printed. The W3C `build_5C_v1.bat` only invokes that W3D-owned runner.

No speed threshold, no acceptance criterion, and no normative benchmark number.

Options:

- **W3D Python timing runner - RECOMMENDED.** Higher-resolution and easier to audit.
- **Plain CMD timing.** Simpler artifact count, but less robust timing.

(refs: S5C-3; P4; charter P-10; H-OWN)

---

# 1. Knowledge sweep

I independently swept the non-superseded documentation available in the supplied package rather than starting from the Stage 5C checklist.

Because Q1 remains open, this sweep is provisional and must receive a final delta check against charter v1.29 and any companion documents supplied with it.

## Finding 1 - explicit memory-safety proof is stronger than the Stage 5C checklist currently says

`Deblock4_Concise_Project_Summary_v1.3.md`, section 7, expressly includes memory-safety testing with arbitrary host-valid strides/alignments, canaries, and no assumed padding.

The Stage 5C scope strongly forbids padding-based over-read, but the T1 wording does not explicitly say that canaries and deliberately non-vector-aligned memory are part of the new-width proof.

This is relevant to the exact AVX2 near-edge hazard. I therefore carry it into Q3 and R5.

**Knowledge-base reliance:** `Deblock4_Concise_Project_Summary_v1.3.md`, section 7; charter C-SIMD-03 and B6.

## Finding 2 - the accepted Stage 4C review already predicted the Stage 5C tail ladder

The accepted Stage 4C pre-implementation reasoning records:

- u8 N=32 starts with V16 and then 8/4/2/scalar;
- u16 N=16 is the same remainder table previously used by u8 N=16;
- vertical underfill is independent of N.

The frozen Stage 4C source now implements exactly that descending recursion.

This supports the Stage 5C proposal, but also exposes the wording issue in Q2.

**Knowledge-base reliance:** accepted Stage 4C pre-implementation response v1.1 and 4C-RAT-3/4.

## Finding 3 - retain the accepted Stage 4C tail-region non-vacuity principle

The W3D-owned Stage 4C differential harness does more than compare whole frames. For tail-named cases it checks that actual changed samples occur in the named tail region, preventing a nominal "tail case" from succeeding simply because something elsewhere in the frame changed.

That is useful paid-for evidence and should be retained/extended in the W3D Stage 5C differential harness for its 256-bit tail cases.

The T5 corrupted-copy control is additional evidence; it should not replace positive tail-region non-vacuity.

**Knowledge/source reliance:** accepted `tools/stage_4c/stage_4c_scalar_v2_diff.py`; Stage 4C proof precedent.

## No other uncaptured knowledge found

Apart from Findings 1-3, I found no non-superseded knowledge item in the currently available package that materially changes the Stage 5C design proposed by W3D.

The Stage 5C checklist otherwise carries the relevant durable rules correctly: lane counts vs bytes, scalar-oracle authority, fixed footprint, Schedule A, target-object confinement, whole-level runtime guard, no masked byte/word AVX2 tail, exact integer identity, byte strides, and the single canonical vector body.

---

# 2. R1 - Assessment of P1-P5

## P1 - Thin v3 unit mirrors v2: CONFIRM, with W3X commentary addition

Source inspection supports the proposed structure.

The accepted v2 unit has four clear parts:

1. named-model compile-time verification;
2. `processU8`;
3. `processU16`;
4. object-mode-only exported C entry points plus retention address-takes.

`src/classic_backend_v2_sse41.zig:11-107`

The new v3 unit should preserve this structural shape.

The width substitutions are exactly:

```text
Classic v2, 128-bit storage batches:
    u8  N=16    16 lanes * 1 byte  = 16 bytes = 128 bits
    u16 N=8      8 lanes * 2 bytes = 16 bytes = 128 bits

Classic v3, 256-bit storage batches:
    u8  N=32    32 lanes * 1 byte  = 32 bytes = 256 bits
    u16 N=16    16 lanes * 2 bytes = 32 bytes = 256 bits
```

The frozen body explicitly permits these four combinations:

`src/classic_vector_backend.zig:425-431`

### Important source clarification for maintainers

`N` is the number of sample lanes, not a byte count.

There is a second subtle point which should also be documented: the canonical lane arithmetic widens samples to i32 internally. Therefore, for example:

```text
@Vector(32, u8)   = 256 bits of stored input samples

but after widening:

@Vector(32, i32)  = 1024 logical vector bits
```

That does NOT mean Stage 5C needs a 1024-bit hardware register. Zig may lower that logical vector to multiple YMM operations. The same phenomenon already existed at the Stage 4C width.

This is exactly why the charter says vector syntax is not machine-code proof and why T3 reads the generated code.

`src/classic_vector_backend.zig:55-82`

### W3X-mandated top-of-module commentary

W3X has now directed that `classic_backend_v3_avx2.zig` contain prominent, detailed, human-facing commentary explaining at least:

- `N` is element/lane count, not bytes;
- the v2 and v3 u8/u16 calculations above;
- "256-bit backend" describes the storage batch and named target tier, not a promise that every internal logical vector has exactly 256 bits;
- integer arithmetic widens lanes to i32 and may lower to multiple YMM operations;
- horizontal width scales with N;
- vertical processing remains the fixed four-row algorithmic lane pack;
- C1 invalid-footprint vs C2 valid-underfilled-tail distinction;
- why full-width right-edge over-read is forbidden;
- why AVX2 masked dword/qword I/O cannot be substituted for u8/u16 tail safety;
- why the descending same-body cleanup exists;
- stride slack is never valid pixel storage;
- object-mode `export fn` is emission/linkage, not a public DLL PE export;
- the v3 object is full named x86-64-v3, not a bare "has AVX2" target;
- runtime execution remains behind the already-proven whole-level capability selection.

These comments are part of maintainability and safety, not decorative prose.

### W3X follow-up direction for the SSE4.1 sibling

W3X further directs that once the AVX2 implementation and wording are finalised, equivalent commentary must be retro-fitted/reconciled into `classic_backend_v2_sse41.zig`.

The current Stage 5C scope freezes that file, so I record this as a mandatory post-5C follow-up rather than silently violating the 5C frozen set.

**Assessment of P1:** CONFIRM with the commentary requirement above.

---

## P2 - Build wiring mirrors v2: CONFIRM, with dedicated test-root amendment

The current build graph gives a clean template:

- baseline target at `build.zig:6-11`;
- named v2 target at `build.zig:12-17`;
- v2 module/object at `build.zig:95-105`;
- object linked into the DLL at `build.zig:107-113`;
- inspection-object install/step at `build.zig:115-123`;
- v2 vector test step at `build.zig:378-390`.

The analogous v3 construction is technically straightforward and consistent with the existing architecture.

The existing frozen vector-body tests, however, are largely instantiated with the Stage 4C widths. For example, the current exhaustive/remainder suites use u8 N=16 and u16 N=8.

Therefore I recommend two v3-target test legs:

1. compile/run the existing frozen `classic_vector_backend.zig` tests under the exact v3 target, preserving the scope's "same file under v3" requirement; and
2. compile/run the new `tests/classic_vector_backend_5c_tests.zig` for the explicit N=32/N=16 proof.

This keeps the vector body frozen.

I find no source reason to edit `src/backend_tier_selection.zig`. It already implements all three tiers, full effective-tier ordering, implementation ceilings, automatic selection and explicit v3 requests generically.

`src/backend_tier_selection.zig:38-127, 138-186`

**Assessment of P2:** CONFIRM, amended by Q3/R5 test placement.

---

## P3 - Replace the v3 placeholder with real calls: CONFIRM

The live Classic frame path currently has:

```text
v1 -> scalar
v2 -> v2 extern calls
v3 -> error.BackendInvariant
```

`src/classic_ar_all_frames_ready.zig:132-142`

The v2 C boundary is a direct template:

`src/classic_ar_all_frames_ready.zig:9-31, 146-178`

Repository-wide source inspection found `BackendInvariant` in exactly two places:

```text
src/classic_ar_all_frames_ready.zig:36
src/classic_ar_all_frames_ready.zig:141
```

No other code depends on it.

Therefore after the v3 arm becomes real, I recommend also removing the now-dead `BackendInvariant` member from the local `ProcessingError` set. Retaining an unreachable historical error name would mislead future maintainers.

The v1 and v2 arm bodies can remain byte-verbatim.

**Assessment of P3:** CONFIRM, including removal of the now-unused local error-set member.

---

## P4 - Benchmark: AMEND methodology, not purpose

The scope is correct that performance is measured and recorded, never accepted/rejected by threshold.

I recommend the W3D-owned Python timing runner described in Q4:

```text
per backend:
    1 warm-up run, not recorded
    3 recorded runs

backends:
    x86_64_v1_baseline
    x86_64_v2_with_sse41
    x86_64_v3_with_avx2

same:
    clip
    frames
    strength/parameters
    output sink
    VapourSynth/vspipe environment
```

Record every raw wall-clock number.

No minimum percentage improvement and no pass/fail performance rule.

**Assessment of P4:** CONFIRM purpose; AMEND timing mechanism as recommended.

---

## P5 - Existing recursive tails need proof, not a new mechanism: CONFIRM

The frozen source is decisive.

Full horizontal chunks:

`src/classic_vector_backend.zig:177-189`

Tail recursion:

`src/classic_vector_backend.zig:191-216`

The logic is:

```text
remaining == 0
    -> done

N == 1
    -> process exactly one scalar column

otherwise
    half = N / 2

    if remaining >= half
        process exactly half lanes
        advance exactly half

    recurse at half width on what remains
```

The actual memory load/store functions accept the exact compile-time lane count L and slice exactly L samples:

`src/classic_vector_backend.zig:218-246, 376-394`

Consequently a Stage 5C tail never needs to issue a full N=32 read and mask it afterward.

The source-bound argument is straightforward:

```text
main loop:
    x + N <= plane.width
    therefore a full N-lane access is in range

tail:
    remaining = plane.width - x

recursive half access:
    executed only when left >= half
    therefore column_start + offset + half <= plane.width
```

This is exactly the desired near-edge property.

**Assessment of P5:** CONFIRM.

---

# 3. R2 - Reliable alternatives

I do not recommend an alternative production algorithm or AVX2-specific tail algorithm. The frozen same-body design is safer than introducing one.

I recommend two structural alternatives only.

## Alternative A - dedicated 5C test root - RECOMMENDED

Use:

`tests/classic_vector_backend_5c_tests.zig`

Advantages:

- preserves the v3 production unit as a true v2 structural mirror;
- does not touch the frozen vector body;
- gives the N=32/N=16 memory-safety fixtures a permanent explicit home;
- production source never imports test code;
- can intentionally construct minimally aligned/canary-backed test planes.

Trade-off: one additional test file.

## Alternative B - W3D-owned Python benchmark runner - RECOMMENDED

Use a small W3D-owned Python timing harness invoked by the W3C batch.

Advantages:

- reliable high-resolution monotonic clock;
- existing Python harness precedent;
- no PowerShell;
- no repository mutation;
- clean separation between W3C proof orchestration and W3D benchmark methodology.

Trade-off: one additional W3D harness artifact.

---

# 4. R3 - Reliability cross-check

**The ratified technical reasoning holds unchanged at 256-bit.**

I re-read the currently available charter sections governing the two tail classes, schedule/dependencies, guarded execution, miscompile detection, vector code generation and memory units, together with the accepted Stage 4C reasoning and current source.

Nothing justifies relaxing or changing the design.

### Tail distinction

Incomplete algorithmic footprint remains unchanged.

`edgeEligible()` is still:

```text
edge >= 3
edge + 2 < extent
```

`src/classic_edge_schedule.zig:57-59`

Widening N changes horizontal batching only. It does not alter that eligibility.

Valid C2 underfill remains processable by the existing smaller-vector/scalar descent.

### Schedule

The horizontal complete-edge-before-band-verticals ordering remains frozen:

`src/classic_vector_backend.zig:152-174`

No AVX2 width argument licences adjacent vertical-edge batching or schedule changes.

### Vertical path

The vertical function takes no N parameter:

`src/classic_vector_backend.zig:275-295`

A full vertical segment calls:

```text
filterLanes(T, 4, ...)
```

`src/classic_vector_backend.zig:297-328`

That is direct source confirmation that the vertical path is width-invariant.

### Guarded execution

The v3 target-specific object remains a separate linked object. Selection already knows the full v3 tier.

No bare AVX2 test is required or permitted.

The existing creation-time whole-level selection remains the authority; Stage 5C merely changes Classic's implementation ceiling and gives the already-existing selected v3 enum value a real implementation.

### Miscompile risk

The move to a larger storage batch increases the importance of the standing scalar-vs-vector differential and exhaustive tail forcing.

It does not justify a new implementation technique.

### Zig 0.16.0 vector semantics

The accepted Stage 4C reasoning remains applicable:

- fixed arrays/slices and vectors may participate in supported value coercions;
- vector pointers are not overlaid directly on VapourSynth frame memory;
- byte-row navigation remains explicit;
- `@Vector` does not prove one particular machine instruction;
- logical vectors may split into multiple physical instructions.

Toolchain Finding F9 remains particularly important: LLVM loop autovectorisation is disabled in the pinned Zig 0.16.0 environment. The vector backend therefore depends on explicit vector source plus generated-code inspection, not on accidental loop transformation.

### Runtime R79

The move of the portable runtime to R79 does not alter any Stage 5C arithmetic, vector, dispatch, target or tail premise. The in-tree API4 compile contract remains the established one.

### Additional source-derived clarification

The widened i32 arithmetic vectors discussed under P1 make the generated-code inspection even more important, but they do not change the ratified reasoning. They are an expected consequence of retaining one lane of i32 arithmetic per sample.

---

# 5. R4 - Per-width horizontal-tail behaviour

Notation:

```text
V16 = filterHorizontalLanes(T, 16, ...)
V8  = filterHorizontalLanes(T, 8, ...)
V4  = filterHorizontalLanes(T, 4, ...)
V2  = filterHorizontalLanes(T, 2, ...)
S1  = filterHorizontalScalarColumn(...)
```

These are not different formulas. Every vector width executes the same canonical `filterLanes` mathematics.

A full N-sized chunk is handled before this table. The table describes only the final remainder.

## u8, N=32

```text
r= 1 -> S1
r= 2 -> V2
r= 3 -> V2 + S1
r= 4 -> V4
r= 5 -> V4 + S1
r= 6 -> V4 + V2
r= 7 -> V4 + V2 + S1
r= 8 -> V8
r= 9 -> V8 + S1
r=10 -> V8 + V2
r=11 -> V8 + V2 + S1
r=12 -> V8 + V4
r=13 -> V8 + V4 + S1
r=14 -> V8 + V4 + V2
r=15 -> V8 + V4 + V2 + S1
r=16 -> V16
r=17 -> V16 + S1
r=18 -> V16 + V2
r=19 -> V16 + V2 + S1
r=20 -> V16 + V4
r=21 -> V16 + V4 + S1
r=22 -> V16 + V4 + V2
r=23 -> V16 + V4 + V2 + S1
r=24 -> V16 + V8
r=25 -> V16 + V8 + S1
r=26 -> V16 + V8 + V2
r=27 -> V16 + V8 + V2 + S1
r=28 -> V16 + V8 + V4
r=29 -> V16 + V8 + V4 + S1
r=30 -> V16 + V8 + V4 + V2
r=31 -> V16 + V8 + V4 + V2 + S1
```

## u16, N=16

```text
r= 1 -> S1
r= 2 -> V2
r= 3 -> V2 + S1
r= 4 -> V4
r= 5 -> V4 + S1
r= 6 -> V4 + V2
r= 7 -> V4 + V2 + S1
r= 8 -> V8
r= 9 -> V8 + S1
r=10 -> V8 + V2
r=11 -> V8 + V2 + S1
r=12 -> V8 + V4
r=13 -> V8 + V4 + S1
r=14 -> V8 + V4 + V2
r=15 -> V8 + V4 + V2 + S1
```

This is simply the binary decomposition of the remainder in descending power-of-two order.

## Corpus dimensions - luma / GRAY / 4:4:4 boundaries

For u8 N=32:

```text
width 705 -> remainder  1
width 719 -> remainder 15
width 720 -> remainder 16
width 721 -> remainder 17
width 735 -> remainder 31
```

These agree with the examples in the draft scope.

For u16 N=16:

```text
width 705 -> remainder  1
width 711 -> remainder  7
width 712 -> remainder  8
width 713 -> remainder  9
width 719 -> remainder 15
```

Odd widths are naturally suited to GRAY or 4:4:4 cases.

## Useful subsampled-frame dimensions

For 4:2:0 or 4:2:2, use legal even frame widths and force the remainder on the chroma plane as well.

u8 N=32 chroma examples:

```text
frame 706 -> chroma width 353 -> remainder  1
frame 734 -> chroma width 367 -> remainder 15
frame 736 -> chroma width 368 -> remainder 16
frame 738 -> chroma width 369 -> remainder 17
frame 766 -> chroma width 383 -> remainder 31
```

u16 N=16 chroma examples:

```text
frame 706 -> chroma width 353 -> remainder  1
frame 718 -> chroma width 359 -> remainder  7
frame 720 -> chroma width 360 -> remainder  8
frame 722 -> chroma width 361 -> remainder  9
frame 734 -> chroma width 367 -> remainder 15
```

The actual W3D corpus need not use every one of these exact numbers, but its plane dimensions must cross-check to the claimed remainder after subsampling.

## Vertical underfill

Vertical coverage is separate from the N=32/N=16 table.

The frozen behaviour is:

```text
4 legal rows -> V4 lane pack
3 legal rows -> 3 scalar rows
2 legal rows -> 2 scalar rows
1 legal row  -> 1 scalar row
```

Suitable frame heights with final partial four-row bands can force these cases, for example heights whose final band leaves 1, 2 or 3 rows.

That is the interpretation I recommend writing explicitly into section 7 per Q2.

---

# 6. R5 - Authorised-surface assessment

## Existing authorised files I expect Stage 5C to need

```text
NEW  src/classic_backend_v3_avx2.zig

MOD  build.zig

MOD  src/deblock4_config.zig

MOD  src/classic_ar_all_frames_ready.zig

MOD  src/deblock4_version.zig

MOD  src/deblock4_selftest.zig

NEW  build_5C_v1.bat
```

## Proposed additional W3C surface

```text
NEW  tests/classic_vector_backend_5c_tests.zig
```

Reason: this is the cleanest location for all new-width module-local verification without editing the frozen vector body or bloating the thin production v3 unit.

## File I currently see no reason to modify

```text
src/backend_tier_selection.zig
```

The current implementation is already generic across v1/v2/v3 and implementation ceilings.

If implementation inspection later reveals a genuine wiring need, the scope's conditional authorisation remains available. At present, I recommend leaving it untouched.

## Frozen files remain frozen

No amendment is proposed to:

```text
src/classic_scalar_kernel.zig
src/classic_edge_schedule.zig
src/classic_thresholds.zig
src/classic_vector_backend.zig
src/classic_backend_v2_sse41.zig
```

The requested SSE4.1 comment reconciliation occurs only after Stage 5C is finalised, under a separately authorised follow-up.

---

# 7. AVX2 near-edge hazard - source conclusion

The hazard identified by the scope is real, but the accepted frozen implementation already has the correct structural answer.

The dangerous shortcut would be:

```text
remaining < 32
load 32 lanes anyway
mask/partially store valid lanes
```

The frozen body does not do this.

It instead reads only:

```text
16 if 16 valid
then 8 if 8 valid
then 4
then 2
then exactly 1 scalar
```

Likewise for u16 beginning at 8 after a 16-lane full width.

Therefore the Stage 5C implementation should add **no AVX2-specific tail mechanism**.

The burden of Stage 5C is to prove that Zig 0.16.0 emits suitable v3 machine code for that frozen source and that the end-to-end result remains byte-identical and memory-safe.

Any implementation proposal to widen the final read, manufacture inactive lanes, use VPMASKMOV-style dword/qword masking for u8/u16 tails, depend on stride slack, or change edge eligibility would be a scope violation.

---

# 8. Overall W3C assessment

Technically, I support the central Stage 5C design.

The source confirms the intended architecture:

- this remains `deblock4.Classic`;
- no new Classic mathematics is introduced;
- the Stage 4C vector body already accepts u8 N=32 and u16 N=16;
- the vertical path is genuinely independent of N;
- the horizontal recursive tail already handles every Stage 5C remainder without widened memory access;
- the accepted v2 target-specific unit is an appropriate structural template for v3;
- the current backend-selection module already understands v3;
- the present `BackendInvariant` is only the deliberate v3 placeholder and has no hidden dependent site.

I recommend W3D amend the draft for Q2 and Q3, incorporate the W3X commentary/follow-up direction, consider the Q4 benchmark refinement, and supply the charter v1.29 generation named by the scope.

After that authority package is available, W3C should perform a final delta knowledge sweep against it. If that produces no new conflict, I see no present technical reason not to ratify the Stage 5C implementation plan.

**No implementation has begun.**