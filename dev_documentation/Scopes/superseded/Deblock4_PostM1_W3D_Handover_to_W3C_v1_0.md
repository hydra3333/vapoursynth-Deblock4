# Deblock4 - Post-5C Maintenance M1 - W3D Handover to W3C v1.0

**From:** W3D (designer), relayed by W3X
**To:** W3C (coder)
**Date:** 2026-08-15
**Scope:** Deblock4_Scope_PostM1_v2_Commentary_Reconciliation_v1_1.md
          (W3X-RATIFIED; read it in full - this note does not replace it)
**Base:** the committed Stage 5C tree, identity 0.1.0-dev+5C, confirmed with
W3X per C-DELIV-01. No commit hash.
**Requested now:** the pre-implementation response R1-R4 ONLY. Do not write
the commentary yet.

## Context in one paragraph

Stage 5C is accepted and committed. During 5C, W3X mandated prominent
human-maintainer commentary in the new AVX2 unit, and it was delivered: 50
comment lines. The older, accepted SSE4.1 sibling was frozen throughout 5C
and still carries its original 6-line header, so the two files now differ
sharply in explanatory quality - and a maintainer opening the older file
first gets the thinner picture of exactly the invariants that are easiest to
break. W3X registered the reconciliation as a post-5C follow-up (5C-RAT-7)
rather than letting 5C edit a frozen accepted file. This scope discharges it.

## The one thing to understand before responding

The acceptance basis is INERTNESS, not correctness-of-behaviour. This is a
COMMENTS-ONLY change to accepted, byte-anchored production code. The gate is:

  - the emitted Classic v2 inspection OBJECT must be BYTE-IDENTICAL to the
    same object built from the committed 5C base;
  - the full retained proof matrix must remain green end to end;
  - a source-shape audit must show that EVERY differing line in both
    authorised files is a comment line.

If any byte of emitted code moves, the delivery changed something it was not
permitted to change. "It still works" is not the test.

## Authorised surface (comments only, two files)

    MOD  src/classic_backend_v2_sse41.zig   - header comment block replaced
                                              by a v2-correct maintainer
                                              guide (scope M1-C1..C9)
    MOD  src/classic_backend_v3_avx2.zig    - at most ONE comment change:
                                              the K33 tail-terminal wording.
                                              If you judge the existing v3
                                              wording already fully
                                              K33-correct, report that and
                                              ship the file UNCHANGED. Do
                                              not edit for style.

Everything else in the repository is byte-frozen. No code change of any kind
in either file - not one token, not an import reorder, not a reflow of an
existing code line. No new file. No identifier added, removed or renamed
(identifier hygiene is a SEPARATE registered scope, next in the queue; do
not anticipate it here).

## Authoring note (why this is not a copy-paste)

The v2 block must be v2-CORRECT, not the v3 block with tokens swapped.
Specifically:
  - the storage arithmetic differs: at v2, u8 N=16 and u16 N=8 are BOTH 128
    bits - and the warning that u8 N=16 and u16 N=16 are different physical
    widths is most useful precisely here, where the reader is comparing the
    two siblings;
  - the descending C2 chain at this tier is 16,8,4,2,1 for u8 and 8,4,2,1
    for u16;
  - the right-edge over-read prohibition must be stated as TIER-INDEPENDENT,
    not as an AVX2 concern: SSE4.1 has no byte/word masked-I/O mechanism
    either, so the reasoning is not "AVX2 masked I/O is awkward" but "no
    read or write may exceed the proven live lane span, at any tier".
Check M1-C2 and M1-C6 against the frozen body's SOURCE, not against the v3
comment text.

## What to return now (R1-R4)

R1  MECHANISM for the inertness proof (scope M1-T1) and the source-shape
    audit (M1-T3): exactly how base-versus-M1 artefacts are produced,
    retained and compared, within C-DELIV-10/11 - no repository-operating
    script, no PowerShell beyond the accepted retained set, no git in
    machinery, no staging. State whether the production DLL is expected
    byte-stable under Zig 0.16.0 on this toolchain; if it is not, say why
    and what carries the proof instead. Do NOT weaken the object-level gate.
R2  CONFIRMATION that M1-C1..C9 is correct for v2, checked against the
    frozen body's source.
R3  ASSESSMENT of the v3 file's existing tail wording against K33.
R4  Knowledge sweep findings per scope section 0, or an explicit nil report.

W3X ratifies the round outcome (with W3D review); only then do you author the
commentary.

## DECISIONS/QUESTIONS FOR W3X

None from W3D at handover. If the inertness mechanism cannot be built within
the delivery rules, say so in R1 rather than proceeding - that is a design
question, not an implementation detail.
