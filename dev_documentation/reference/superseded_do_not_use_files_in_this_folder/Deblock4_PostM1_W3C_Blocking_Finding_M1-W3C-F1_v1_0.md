# Deblock4 - Post-5C M1 - W3C Blocking Finding M1-W3C-F1 v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Date:** 2026-08-16
**Scope:** `Deblock4_Scope_PostM1_v2_Commentary_Reconciliation_v1_2.md`
**Delivery under validation:** `Deblock4_PostM1_W3C_delivery_v1_0`
**Base:** committed Stage 5C tree, identity `0.1.0-dev+5C`
**Status:** BLOCKING proof-specification finding at M1-T1; no evidence of executable-code drift

## DECISIONS/QUESTIONS FOR W3X

### M1-W3C-F1 - raw v2 object byte identity is incompatible with the ratified
comments-only header expansion under the current Zig/COFF output

W3X correctly stopped at M1-T1.

The committed v2 source and the delivered restore copy compared byte-identical
before application. The applied v2 and v3 files also compared byte-identical
to the delivered apply copies. Both pre-M1 and post-M1 ReleaseFast builds
completed.

The first mandatory inertness comparison then failed:

`classic_backend_v2_sse41.obj` base vs candidate is not byte-identical.

This is a failure of the currently stated M1-T1 raw-object gate and must not be
waived silently.

## Evidence that the observed object movement is source-location/debug metadata

The v2 M1 edit expands the header by exactly 46 physical lines:

- committed v2 first code line: line 7;
- M1 v2 first code line: line 53;
- displacement: +46 lines.

W3X's `fc /b` object comparison reports, among its first differences:

- 0x23 -> 0x51 = 35 -> 81 = +46
- 0x36 -> 0x64 = 54 -> 100 = +46
- 0x54 -> 0x82 = 84 -> 130 = +46
- 0x55 -> 0x83 = 85 -> 131 = +46
- 0x62 -> 0x90 = 98 -> 144 = +46
- 0x63 -> 0x91 = 99 -> 145 = +46

That exact correspondence is highly diagnostic of source-line/debug metadata
moving because executable statements now occupy source lines 46 lines later.

The remaining four-byte object difference is consistent with metadata/checksum
material derived from changed debug/source-location content. It is not, by
itself, evidence that machine instructions changed.

The production DLL also differs. This is not surprising once the linked input
object contains changed source/debug metadata. In a deterministic PE/COFF
image, metadata/hash fields can change when an input changes even when runtime
machine code does not. Scope M1-T1 already anticipated that whole-DLL identity
might be defeated by build metadata; the object-level gate, however, was stated
as absolute and therefore requires a scope-level remedy.

## Why this is a proof-design problem, not permission to ignore the mismatch

The scope's acceptance basis is inertness, and the v2 object was required to be
byte-identical. W3C therefore does NOT reinterpret the failed comparison as a
PASS.

At the same time, retaining raw whole-object byte identity while adding a
substantial header is structurally incompatible with object formats that retain
source-location/debug information. The source line numbers are legitimate
compiler inputs to that metadata.

Trying to satisfy the old gate by compressing the maintainer guide back into
the original six physical lines would defeat M1's readability purpose and its
commentary/style requirements. Moving or deleting non-comment lines merely to
preserve source line numbers would also violate the comments-only surface.

## Recommended remedy

W3C recommends amending M1-T1 narrowly, without weakening the executable
inertness requirement:

1. Preserve the current raw-object `fc /b` result as evidence. It is EXPECTED
   to differ only because source/debug metadata legitimately tracks the moved
   source lines.

2. Replace raw whole-object identity as the primary executable gate with a
   mechanical comparison that excludes ONLY source-location/debug metadata and
   proves all executable/non-debug object content unchanged.

3. Require, at minimum:
   - machine-code/disassembly identity for every v2 emitted function;
   - identity of non-debug code/data/relocation content;
   - no symbol/export/section-layout change except debug/source-location
     metadata attributable to the comments;
   - the already-ratified M1-T3 source-shape proof showing every source
     difference is a comment line and the non-comment projection is
     byte-identical;
   - full retained Stage 5C matrix re-execution.

4. Keep the DLL treatment already present in M1-T1: raw DLL byte identity is
   attempted and recorded; if metadata prevents identity, executable/non-debug
   equivalence plus the object/source-shape proof and retained matrix carry the
   inertness proof.

W3C recommends that W3D choose and specify the exact Windows/Zig inspection
commands for item 2 before W3X resumes validation. A post-build strip/normalize
comparison may be suitable if it is shown to remove only debug/source-location
metadata; alternatively, section-level and disassembly comparison can be made
the normative mechanism. W3C does not choose that proof boundary silently.

## Current tree / evidence handling

W3X should:

- STOP at the current point;
- NOT run the full Stage 5C matrix yet;
- NOT commit;
- NOT back out the M1 comments yet;
- preserve:
  - `zig-out\inspection_M1\base_binary\classic_backend_v2_sse41.obj`
  - `zig-out\inspection_M1\base_binary\Deblock4.dll`
  - `zig-out\M1_candidate\backend-objects\classic_backend_v2_sse41.obj`
  - `zig-out\M1_candidate\bin\Deblock4.dll`
  - the current M1 source tree.

No evidence presently indicates a production arithmetic, dispatch, or generated
machine-code defect. The blocking issue is that the ratified raw-object proof
predicate cannot distinguish executable movement from expected source-line
metadata movement caused by the very comment expansion M1 requires.

## Knowledge / external-format cross-check

The Microsoft PE/COFF specification documents source line-number information in
object files and debug-directory metadata in PE images. Zig 0.16.0 documents
ReleaseFast builds as reproducible; reproducibility means unchanged inputs
produce reproducible outputs, not that an intentionally changed source file
must produce the same metadata-bearing object.

No charter or project invariant authorises W3C to silently weaken a failed
acceptance gate. A scope/proof amendment is therefore required before
validation resumes.
