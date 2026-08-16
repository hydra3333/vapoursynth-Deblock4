# Deblock4 - Stage 5C - W3C Delivery Note to W3D v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Delivery:** `Deblock4_Stage_5C_W3C_delivery_v1_0.zip`
**Scope:** `Deblock4_Scope_Stage_5C_Classic_v3_AVX2_Backend_v1_2.md`
**Base:** W3X-confirmed `0.1.0-dev+4C`
**Status:** implementation delivery for W3D artifact review and W3X validation; W3C has not run validation.

## DECISIONS/QUESTIONS FOR W3X

None from W3C at delivery time.

## 1. What W3C implemented

The production design remains the ratified narrow Stage 5C design:

- Classic only;
- frozen scalar oracle, schedule, thresholds and width-generic vector body;
- new thin exact-x86-64-v3 object at u8 N=32 / u16 N=16;
- real v3 dispatch through the existing immutable selected tier;
- Classic-only ceiling raised to v3;
- identity advanced to `0.1.0-dev+5C`;
- no edit to `backend_tier_selection.zig`;
- no edit to `classic_backend_v2_sse41.zig`.

The new v3 module carries the full W3X maintainer-comment mandate from
5C-RAT-7. In particular it makes clear that N is a lane count, that the vertical
path remains the fixed four-row algorithmic pack, that the live terminal is V1,
and that no right-edge wide load/masked-store shortcut is legal.

## 2. Permanent Stage 5C unit proof source

W3C added `tests/classic_vector_backend_5c_tests.zig` as the ratified test-only
root. It is wired as the second `test-classic-v3` leg under the exact v3 target.

Please review especially:

- exact D3 A/B fixture thresholds at N=32, both orientations;
- D3 O-4 / O-5d / O-7 exact inputs at the new widths;
- exhaustive u8 p0/q0 lane differential at N=32;
- every u8 1..31 and u16 1..15 remainder;
- eight fixed-seed random plane trials per remainder;
- deliberate non-vector base/stride alignment and prefix/row-slack/suffix
  canaries;
- non-vacuous strong tail data;
- vertical bottom underfill 1/2/3 rows.

No production file imports this test module.

## 3. Proof-matrix batch and W3D join point

`build_5C_v1.bat` is W3C's proof orchestrator. The accepted Stage 4C batch was
the template. Earlier batches are not modified. Existing executable PowerShell
is retained as-is; new 5C mutation logic uses CMD plus the resident portable
Python wrapper. There is no git executable call.

The batch deliberately does not embed or author W3D's differential/benchmark
harness. It requires:

```cmd
DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER=<absolute W3D .cmd>
DEBLOCK4_STAGE5C_BENCHMARK_RUNNER=<absolute W3D .cmd>
```

The exact environment/run-kind contract is in the delivery manifest. Please
review that contract when producing the W3D harnesses. In particular the
expected-failure run kinds must return 0 only when the deliberately corrupted
V1 build is correctly rejected; a successful process launch alone must never
count.

## 4. Points I would like W3D to inspect closely

1. **Exact named-target mirror:** compare `classic_backend_v3_avx2.zig` with the
   frozen v2 sibling, allowing only the documented target/name/width/comment
   differences.
2. **Near-edge safety:** confirm no production change widens the frozen body or
   introduces masked tails; inspect the N=32/N=16 tests and T5 live-V1 mutation.
3. **V1 correction:** confirm the new tests and mutant target the live
   `filterHorizontalLanes(T, 1, ...)` path, not the defensive scalar-column
   branch.
4. **Object boundary:** confirm exact C ABI roots, object-only export semantics,
   DLL export-table exclusion, x86-64-v3 containment and transition-hygiene
   evidence required by the batch.
5. **Selection:** confirm only the Classic ceiling changes; Deblock4 remains
   untouched and v1/v2 remain requestable.
6. **Harness join contract:** confirm the four differential run kinds and
   benchmark environment are suitable for the W3D-owned runners.
7. **K30 identifier audit:** independently re-verify the one-way new-module
   dependency and absence of accidental duplicate/alternate v3 implementation.

## 5. W3C static inspection only

Before packaging W3C performed source/package inspection, not execution:

- authorised changed/new surface only;
- frozen files byte-identical to the supplied base;
- US-ASCII / CRLF on all applied text files;
- batch label/call graph internally complete;
- no new executable PowerShell relative to accepted Stage 4C batch;
- no git executable call in the Stage 5C batch.

These are not build/test/PASS claims. W3X must run the complete proof matrix and
report the actual evidence; W3D then performs the independent artifact review.

## 6. Post-5C comment follow-up

The W3X direction to reconcile equivalent human-facing explanations into the
frozen SSE4.1 v2 unit remains registered post-5C. W3C has not touched that file
in this delivery.

## W3C recommendation

Proceed to W3D review of this delivery and production of the W3D-owned Stage 5C
differential and benchmark runners. If W3D finds no source/harness-contract
problem, W3X can manually apply the package and execute `build_5C_v1.bat` from
the x64 Visual Studio developer prompt.
