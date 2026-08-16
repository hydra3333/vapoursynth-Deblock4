# Deblock4 - Post-5C M1 - W3C Delivery Note to W3D v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Scope:** `Deblock4_Scope_PostM1_v2_Commentary_Reconciliation_v1_2.md`
**Base:** committed Stage 5C tree, identity `0.1.0-dev+5C`
**Delivery:** `Deblock4_PostM1_W3C_delivery_v1_0.zip`
**Status:** implementation delivery; W3C static review only; no execution/PASS claim

## DECISIONS/QUESTIONS FOR W3X

None.

## Delivered change

W3C has implemented the ratified comments-only M1 scope.

`src/classic_backend_v2_sse41.zig` receives a replacement header maintainer
block covering M1-C1..C9 in v2-specific terms. It explicitly records:

- the two thin target-specific siblings and one frozen vector body;
- N as a sample-lane count, not bytes;
- v2 u8 N=16 and u16 N=8 as 128-bit storage batches;
- the u8-N16 versus u16-N16 physical-width warning;
- i32 internal widening and generated-code inspection authority;
- horizontal-only N scaling and the fixed four-row vertical path;
- C1 versus C2 tails;
- the v2 descending chains and live V1 terminal;
- the K33 function name and defensive scalar-branch distinction;
- the tier-independent right-edge over-read prohibition;
- the ratified MASKMOVDQU correction: byte-selected store exists, but no
  matching safe masked byte/word load legalises an over-wide read;
- exact-span decomposition and stride-slack discipline;
- exact named x86-64-v2 object confinement, object-mode export semantics, and
  whole-level runtime-selection requirement.

`src/classic_backend_v3_avx2.zig` receives only the one authorised K33 comment
completion. The prior semantically-correct V1 sentence now additionally names
`filterHorizontalLanes(T, 1, ...)` and states that the defensive N==1
scalar-column branch is unreachable from the ratified entry widths. No other
v3 comment is changed.

## Static source-shape result

W3C mechanically compared the prepared base and candidate bytes without
executing the project toolchain:

- both files remain US-ASCII / CRLF;
- their comment-stripped projections are byte-identical;
- their complete code suffixes beginning at `const std = @import("std");` are
  byte-identical;
- no identifier is added, removed, or renamed;
- no other repository file is delivered.

Thus the delivery is structurally comments-only. This is not the M1 inertness
PASS: W3X still performs the ratified binary identity gates and retained 5C
matrix; W3D reviews that evidence.

## Delivery mechanics

The ZIP contains `apply_to_tree/`, exact `restore_to_base/` pre-M1 copies, and
a manifest with manual CMD apply/backout commands. No repository-operating
script, patch, PowerShell addition, git machinery, staging, test, harness, or
build input is delivered.
