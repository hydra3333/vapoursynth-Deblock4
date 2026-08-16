# Deblock4 - Post-5C M1 - W3D Round Outcome to W3C v1.0

**From:** W3D (designer), relayed by W3X
**To:** W3C (coder)
**Date:** 2026-08-15
**Re:** your Pre-Implementation Response R1-R4 v1.0
**Controlling now:** Deblock4_Scope_PostM1_v2_Commentary_Reconciliation_v1_2.md

## Outcome

R1, R2 and R3 are ACCEPTED. Your M1-W3C-Q1 is ACCEPTED and the scope is
amended. R4 stays open until W3X supplies the current package (below).
Implementation is released the moment your delta sweep closes R4 clean.

## M1-W3C-Q1 - you were right; the scope was wrong

W3D wrote "SSE4.1 has no byte/word masked-I/O mechanism either". That is too
absolute and must not go into the file. MASKMOVDQU (SSE2-era,
_mm_maskmoveu_si128) does conditionally store selected BYTES. What the SSE
tiers lack is the corresponding safe masked byte/word LOAD - and the load is
the illegal half of the shortcut, since it is the read that can cross the
valid row, eat stride slack that is not pixel storage, or overrun the final
backing row.

Write it that way: a byte-selected masked store exists; there is no matching
safe masked byte/word load; therefore it cannot legalise an over-wide
right-edge read and cannot replace exact-span descending decomposition. Keep
it short enough for the header, but keep the distinction. The safety rule and
the accepted mechanism do NOT change - only the ISA claim is corrected.

This matters because the block's entire value is being trustworthy on
precisely these details; a maintainer who finds one over-claim starts
discounting the rest.

## R1 - mechanism ratified as proposed

Manual CMD only, no new repository file, no PowerShell added, no git, no
staging: base artefacts built and RETAINED first from their own prefix/cache,
M1 applied, candidate built from a separate prefix/cache, fc /b on the v2
object (primary gate) and on the DLL, fc /n source transcripts plus
comment-stripped projections for the shape audit, then the retained
build_5C_v1.bat matrix. Your DLL caveat handling is correct: report it as
evidence if whole-file identity is defeated, never weaken the object gate.

W3D note on the projection: findstr /v /b /c:"//" strips only comments
starting at column zero. W3D verified both authorised files currently carry
ZERO indented comment lines, so the projection is exact today - and if an
indented comment ever appeared it would surface as a difference rather than
hide one, which fails safe. No change needed.

## R2 - confirmations verified

W3D independently re-verified your source claims against the frozen tree:
v2 calls processPlane(u8, 16, ...) and processPlane(u16, 8, ...) so both are
128-bit; the vertical segment takes no backend N and computes at
filterLanes(T, 4, ...); filterLanes widens to @Vector(L, i32); and your V1
terminal trace matches K33. M1-C1..C6, C8, C9 stand as written.

## R3 - the one v3 correction is confirmed needed

Your reading is right: the existing v3 sentence is semantically correct and
already free of the superseded "scalar 1" phrasing, but it does not name
filterHorizontalLanes(T, 1, ...) nor distinguish V1 from the defensive
scalar-column branch. Make that ONE correction; no other edit to v3.

## R4 - what you need

W3X is supplying the current post-5C documentation generation: charter
v1_29, D0 Binding Knowledge Index v1_14 (note the NEW K33 and K34), Project
Status v1_27, Forward Roadmap v1_20, Documentation Currency Audit v1_3, coder
introduction v1_27. Perform the delta sweep against that, then either report
NIL or the numbered findings.

Declining to file a NIL sweep you could not honestly support was the correct
call.

## Then

On a clean R4, author the commentary per M1-C1..C9 as amended, and deliver
per scope section 7. No execution or PASS claims; W3X runs validation and
W3D artifact-reviews the evidence.

## DECISIONS/QUESTIONS FOR W3C

None. Raise anything the sweep turns up rather than absorbing it.
