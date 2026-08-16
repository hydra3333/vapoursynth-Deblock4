# Deblock4 - Scope - Post-5C Maintenance M1 - SSE4.1 Commentary Reconciliation

**Deliverable:** W3D-M1-SCOPE (for W3X ratification, then release to W3C)
**Version:** 1.0
**Date:** 2026-08-15
**Author:** W3D (designer)
**Route:** W3D -> W3X (ratification) -> W3C
**Base:** the committed Stage 5C tree (identity 0.1.0-dev+5C), confirmed with
W3X per charter C-DELIV-01. No commit hash recorded.
**Authority set:** the charter (AI_Charter_and_Invariants_Card v1_29 or later)
PREVAILS on conflict; D0 Binding Knowledge Index v1_14 (note K33, K34, K30);
Stage 5C scope v1_2 section 9 and 5C-RAT-7, which REGISTERED this work;
Project Status v1_27.
**Status:** DRAFT v1.0 - awaiting W3X ratification; NOT released to W3C.
**Encoding:** US-ASCII; CRLF.

---

# 0. KNOWLEDGE SWEEP (standing, two-sided - D0 section 6.1, verbatim)

```text
KNOWLEDGE SWEEP (standing, two-sided): Before implementation, W3C must
independently search the committed documentation set (excluding
superseded/) for relevant non-superseded, non-withdrawn knowledge,
rules, or decisions bearing on this scope, WITHOUT starting from the
checklist below, and report as numbered findings anything relevant that
the checklist or the Stage 2C+ Binding Knowledge Index does not carry.
Withdrawn alternatives are reportable only as do-not-revisit
confirmations. W3D verifies; confirmed items become new index K-numbers;
W3X adopts any scope amendment.
```

# 1. Mission, in one paragraph

Bring the accepted Classic v2 (SSE4.1) unit up to the same human-maintainer
commentary standard as its v3 sibling, and correct the tail terminal wording
in BOTH units to the ratified K33 fact. This is a COMMENTS-ONLY change to
ONE production file. No executable statement, no declaration, no identifier
and no build input may change. The acceptance basis is therefore unusual and
strict: the change must be proven INERT - the emitted v2 object and the
production DLL must be byte-identical to the committed 5C artefacts - and the
retained proof matrix must remain green. If any byte of emitted code moves,
the delivery has changed something it was not permitted to change.

# 2. Why this exists (do not skip - it is the whole point)

```text
At Stage 5C, W3X mandated prominent human-facing commentary in the new v3
unit (5C-RAT-7). It was delivered: 50 comment lines covering N-as-lanes,
storage-width arithmetic, i32 widening versus machine width, horizontal
scaling versus the fixed four-row vertical pack, C1 vs C2 tails, the
descending decomposition and its V1 terminal, the right-edge over-read
prohibition, AVX2 masked-I/O granularity, stride slack, object-export
versus PE-export semantics, exact named-level targeting, and the
whole-level runtime guard.

The v2 unit was FROZEN throughout 5C and still carries its original
6-line header. The two sibling files therefore now differ sharply in
explanatory quality, and a maintainer who opens v2 first - the older,
more established file - gets the thinner picture of the very invariants
that are easiest to break. W3X registered the reconciliation as a
post-5C follow-up rather than letting 5C touch a frozen accepted file.
This scope discharges that obligation.

Verified state at scoping (W3D, against the committed tree): v2 header
comment block = 6 lines; v3 = 50 lines, ALL in the header block, with no
inline comments below it. The work is therefore a single-block authoring
job in v2, not a scattered edit.
```

# 3. Frozen, forbidden, and authorised

```text
BYTE-FROZEN (any delta is an automatic blocking finding):
    EVERY file in the repository except the two named below.
    In particular: src/classic_scalar_kernel.zig,
    src/classic_edge_schedule.zig, src/classic_thresholds.zig,
    src/classic_vector_backend.zig, build.zig, every batch, every
    test file, every tools/ file.

AUTHORISED - COMMENTS ONLY, two files:
    MOD  src/classic_backend_v2_sse41.zig
         The header comment block is REPLACED by a v2-appropriate
         maintainer guide (section 4). NOTHING ELSE IN THE FILE MAY
         CHANGE - not one token of code, not one blank line inside the
         code body, not the import order, not the guard, not the export
         names.
    MOD  src/classic_backend_v3_avx2.zig
         ONE comment correction only (section 4, item C9): the tail
         sentence must name V1 in the K33 terms. If W3C judges the
         existing v3 wording already fully K33-correct, it reports that
         as a finding and ships the file UNCHANGED - do not edit for
         style.

FORBIDDEN, explicitly:
    - Any code change of any kind in either file, however trivially
      "equivalent" it appears. Comment-only means comment-only.
    - Reformatting, re-wrapping or re-ordering existing CODE lines.
    - Any change to build.zig, the batches, the harnesses, or any test.
    - Any new file.
    - Any identifier rename (that is the SEPARATE registered
      identifier-cleanup pass; do not anticipate it here).
```

# 4. Commentary content required in the v2 header (M1-C series)

```text
W3C authors the v2 block; it is NOT a copy-paste of the v3 block with
tokens swapped, because several v3 statements are v3-specific. Each item
below must be covered in plain English, correct FOR V2:

M1-C1  This unit is one of two thin target-specific siblings; it does
       NOT contain a second Classic algorithm. Both units call the same
       frozen width-generic body; this unit fixes only the named CPU
       target and the compile-time storage-lane count.
M1-C2  N IS A SAMPLE-LANE COUNT, NOT A BYTE COUNT, with the v2
       arithmetic shown explicitly (u8 N=16 -> 16 lanes x 1 byte = 128
       bits; u16 N=8 -> 8 lanes x 2 bytes = 128 bits) AND the warning
       that u8 N=16 and u16 N=16 are different physical widths - the
       v2/v3 comparison is exactly where this confusion bites.
M1-C3  The canonical arithmetic widens samples to i32 internally, so a
       logical vector may exceed one XMM register and lower to several
       machine instructions; the generated-code audit, not the source
       vector spelling, proves the emitted tier.
M1-C4  Only HORIZONTAL batching scales with N. The vertical Schedule-A
       path is an algorithmically fixed four-row lane pack and stays at
       four lanes at EVERY tier. Do not widen it.
M1-C5  C1 versus C2 tails: C1 = incomplete algorithmic six-sample edge
       footprint, edge ineligible, samples untouched; C2 = valid
       footprint with fewer than N horizontal samples left, and those
       samples MUST still be processed.
M1-C6  The C2 mechanism is exact descending same-body decomposition -
       16,8,4,2,1 for u8 at this tier and 8,4,2,1 for u16 - terminating
       in the ONE-LANE VECTOR path V1 (K33).
M1-C7  Never replace that cleanup with a full-width read plus a partial
       or masked store: near the right edge such a read can cross the
       valid row, consume stride slack that is NOT pixel storage, or
       overrun the final backing row. State that this prohibition is
       tier-independent - it is not an AVX2-only concern - and that
       SSE4.1 has no byte/word masked-I/O mechanism either.
M1-C8  Safety boundary: this is its own exact named x86-64-v2 object;
       its `export fn` roots force object emission and linker
       visibility ONLY and must NOT become public Deblock4.dll PE
       exports; the frame path reaches them through matching externs
       only after whole-level runtime selection has proven the complete
       v2 contract. A bare "CPU has SSE4.1" test is not an execution
       licence.
M1-C9  (BOTH FILES) The tail terminal is named per K33: the descending
       chain ends in a one-lane VECTOR application of the same body,
       filterHorizontalLanes(T, 1, ...) - "V1" - NOT the scalar-column
       function, whose N==1 branch is defensive and unreachable from
       any ratified entry width. The superseded Stage 4C phrasing
       "... 2, then scalar 1" must not appear in either file.

STYLE: match the v3 block's register - plain English, no acronym
soup, wrapped to the file's existing comment width, US-ASCII. Length is
not a target; completeness and correctness are.
```

# 5. Proof surface (build_M1_v1.bat, or a ratified alternative)

```text
The acceptance question is NOT "does it still work" but "did anything
move". Order:

  M1-T1  INERTNESS, PRIMARY GATE. Build the Classic v2 inspection
         object (zig build classic-v2-object) and the ReleaseFast
         production DLL from the M1 tree, and compare BYTE-FOR-BYTE
         against the same artefacts built from the committed 5C base.
         The v2 object MUST be byte-identical. The DLL SHOULD be
         byte-identical; if the toolchain embeds any build-varying
         data that defeats whole-file DLL comparison, W3C reports that
         as a finding and the object-level identity plus M1-T2/T3 carry
         the proof - W3C does NOT weaken the object gate.
         Mechanism note: this is a comparison of emitted binaries, so
         the base artefacts must be built first, retained, then the
         M1 tree built. W3C proposes the exact mechanism in R1.
  M1-T2  Full retained matrix re-execution: the Stage 5C proof matrix
         green end to end, OUTER_BATCH_EXIT_CODE=0, including 35/35
         v3 legs, the W3D differentials (positive and 4C regression),
         containment, selection, and all negative controls. The
         benchmark step runs and records as usual (non-gating).
  M1-T3  Source-shape audit: a mechanical demonstration that the ONLY
         differing lines between base and M1 trees, in both authorised
         files, are comment lines - no code line differs, and no line
         count change occurs outside comment blocks. W3C proposes the
         form in R1 (a plain diff-with-context transcript retained as
         evidence is acceptable; no repository-operating script,
         C-DELIV-11).
  M1-T4  Encoding: both files remain US-ASCII with CRLF (the standing
         S3 audit already covers this and must stay green).

There is NO new differential corpus and NO new unit test in M1. Adding
either would be scope creep: nothing executable changes.
```

# 6. MANDATORY PRE-IMPLEMENTATION RESPONSE (short round)

```text
This scope is small, so the round is correspondingly short, but it is
NOT waived - the inertness mechanism needs agreeing before code.

R1  MECHANISM for M1-T1 and M1-T3: exactly how base-versus-M1 artefacts
    are produced, retained and compared, within C-DELIV-10/11 (no
    repository-operating script, no PowerShell beyond the accepted
    retained set, no git in machinery, no staging). State whether the
    production DLL is expected byte-stable under this toolchain and,
    if not, say why and what carries the proof instead.
R2  CONFIRMATION that the M1-C1..C9 content list is correct FOR V2 -
    in particular that the v2 storage arithmetic in M1-C2 and the
    descending chain in M1-C6 are right as stated, checked against the
    frozen body's source, not against the v3 comment text.
R3  ASSESSMENT of the v3 file: is its existing tail wording already
    K33-correct? If yes, say so and leave the file untouched.
R4  KNOWLEDGE SWEEP findings per section 0, or an explicit nil report.

W3X ratifies (with W3D review); only then does implementation start.
```

# 7. Delivery and process (charter v1_29 rules bind)

```text
No-script package per C-DELIV-10/11: apply_to_tree/ mirror applied by one
manual W3X copy; restore_to_base/ pre-change copies; manifest with the
manual per-file backout block; no PowerShell, no git in machinery, no
patch files; base confirmed with W3X. K30-style identifier audit is
TRIVIAL here and must report "no identifier added, removed or renamed" -
W3D re-verifies. Harness ownership unchanged (W3D owns .vpy/.cmd);
M1 needs no new harness. C-DELIV-07: no execution or PASS claims by W3C;
W3X runs validation; W3D artifact-reviews the evidence.
```

# 8. Out of scope

```text
Identifier renaming or any naming hygiene       -> the SEPARATE registered
                                                   identifier-cleanup pass
                                                   (next in the queue)
Any code change, however equivalent-looking     -> not this scope; a code
                                                   change would require its
                                                   own scope and full proof
Commentary in the frozen body, schedule,        -> those files stay frozen;
kernel or thresholds                               propose separately if
                                                   genuinely needed
New tests, corpora or harnesses                 -> nothing executable
                                                   changes, so none are
                                                   warranted
```

---

*Revision history*
```text
v1.0 (2026-08-15) Initial M1 scope discharging the 5C-RAT-7 registered
     follow-up: v2 SSE4.1 unit brought to the v3 maintainer-commentary
     standard (M1-C1..C8, v2-correct rather than token-swapped), K33
     V1-terminal wording corrected in both units (M1-C9), comments-only
     with byte-level inertness as the primary acceptance gate. Verified
     at scoping against the committed tree: v2 header 6 comment lines,
     v3 50, all in the header block.
```
