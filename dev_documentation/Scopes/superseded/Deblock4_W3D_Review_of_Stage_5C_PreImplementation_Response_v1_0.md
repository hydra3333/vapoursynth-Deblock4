# Deblock4 - W3D Review of the Stage 5C Pre-Implementation Response

**Deliverable:** W3D-5C-PREIMPL-REVIEW (for W3X ratification)
**Version:** 1.0
**Date:** 2026-08-14
**Author:** W3D (designer)
**Reviewed artifact:** Deblock4_Stage_5C_Pre-Implementation_Response_-_W3C
v1_0 (PROVISIONAL, no implementation performed)
**Verification basis:** every load-bearing source claim independently
re-verified against the live 0.1.0-dev+4C tree on 2026-08-14 (never against
archives or memory). Knowledge-base reliances are labelled inline.
**Status:** RECOMMENDS RATIFICATION of 5C-RAT-1..8 below, then scope v1_1.
**Encoding:** US-ASCII; CRLF.

---

# 1. Verification record (what I checked, cold)

```text
V1  BackendInvariant occurs at EXACTLY two sites, both in
    src/classic_ar_all_frames_ready.zig (line 36: the error-set
    member; line 141: the v3 placeholder arm). Coder claim CONFIRMED
    by repository-wide search. Removing the member with the arm is
    safe.
V2  The frozen tail recursion (classic_vector_backend.zig:191-216)
    matches the coder's restatement: bounds-guarded half-descent, no
    widened access. CONFIRMED - with one terminal-step correction,
    section 2 below.
V3  edgeEligible is edge >= 3 and edge + 2 < extent via the named
    radius constants (classic_edge_schedule.zig:10-11,58). CONFIRMED.
V4  The vertical path takes no N and computes at filterLanes(T, 4,..)
    (classic_vector_backend.zig:310). Width-invariance CONFIRMED.
V5  requireBackendWidth already ratifies u8 {16,32} / u16 {8,16}
    (classic_vector_backend.zig:425-431). CONFIRMED.
V6  tests/ and tools/stage_4c/ both EXIST in the live tree; tests/
    holds .vpy harnesses and a crosswalk doc (no Zig test file yet);
    tools/stage_4c holds the accepted Python diff harness the coder
    cites. The proposed test file is precedented in location; its
    build wiring is new.
V7  Concise Project Summary v1.3 section 7 does state the
    memory-safety doctrine verbatim as claimed: "memory-safety
    (arbitrary strides/alignments, canaries, no assumed padding)".
    Coder Finding 1 CONFIRMED. [Knowledge-base reliance:
    Deblock4_Concise_Project_Summary_v1.3.md section 7.]
V8  The coder's corpus arithmetic spot-checks correctly (705->r1,
    719->r15, 720->r16, 721->r17, 735->r31 at N=32; the 4:2:0 chroma
    frame-width derivations divide correctly).
```

# 2. W3D finding: the normative tail table's terminal step is
mislabelled (correct before adoption)

```text
W3D-F1  The response's R4 tables write every odd remainder as ending
        "+ S1" with S1 defined as filterHorizontalScalarColumn. The
        LIVE SOURCE terminates differently: for any power-of-two
        entry width N >= 2, a final remainder of 1 is processed by
        filterHorizontalLanes(T, 1, ...) - a ONE-LANE VECTOR
        application of the same body - because at N=2 the half=1
        branch fires (left >= 1) and the recursion then returns on
        remaining == 0. The N == 1 scalar-column branch
        (classic_vector_backend.zig:200-205) is a DEFENSIVE terminal
        reachable only by direct N == 1 entry, which no ratified
        width produces.

        CONSEQUENCE: byte-identity is unaffected (filterLanes at L=1
        is the identical i32 arithmetic; the 4C unit sweep proved
        remainders 1..15 green through exactly this path). But the
        table is offered for adoption AS NORMATIVE, and this project
        does not adopt tables that misname what executes. The same
        mislabel appears in the response's section 7 prose ("then
        exactly 1 scalar") and traces back to the 4C-era wording
        ("... 2, then scalar 1" in 4C-RAT-4): the mislabel is
        HISTORICAL, first introduced at 4C, and is corrected now
        rather than inherited again.

        CORRECTION (5C-RAT-6): define V1 = filterHorizontalLanes(T,1)
        and rewrite every terminal "S1" as "V1"; add the note that
        the scalar-column branch is defensive and unreachable at
        ratified widths; record the corrected fact as a candidate D0
        knowledge item so no later stage re-imports the old wording.
```

# 3. Assessment of the coder's four questions

```text
Q1 (charter generation)  CORRECT AND EXPECTED. The scope names
   charter v1_29 because v1_29 is ratified and exists; the coder's
   package predates today's batch. The remedy is W3X supplying the
   current package (5C-RAT-1), never rewording the scope backwards.
   The coder's STOP-not-guess behaviour is exactly charter 2.3a.

Q2 (both-orientations wording)  CORRECT; ACCEPT. My v1_0 corpus line
   carried the 4C phrasing forward; at 256-bit it is misreadable
   exactly as the coder says (there is no vertical 256-bit batch to
   underfill). Adopt their split obligation verbatim (5C-RAT-2).

Q3 (dedicated test root + explicit memory-safety proof)  ACCEPT.
   Verified V6/V7: the location is precedented, the doctrine is
   already project law, and the AVX2 hazard is precisely where
   "byte-identical but landed in stride slack" is weak evidence.
   One boundary made explicit (5C-RAT-3): the Zig unit-test file is
   W3C SOURCE (delivered, reviewed, applied like any source file);
   the .vpy/.cmd harnesses in tests/ remain W3D deliverables.
   Ownership does not blur because both live under tests/.

Q4 (benchmark methodology)  ACCEPT. The Python perf_counter runner
   with one discarded warm-up and three recorded runs per backend is
   better measurement at zero acceptance risk (still non-gating,
   S5C-3 unchanged). It is a W3D harness deliverable; the batch only
   invokes it (5C-RAT-4).
```

# 4. Assessment of R1-R5 and the sweep findings

```text
R1/P1  CONFIRM stands, verified V5. The i32-widening clarification is
       correct and usefully documented (a logical @Vector(32,i32) may
       lower to multiple YMM ops; T3 reads generated code precisely
       because syntax is not machine-code proof). The W3X-mandated
       commentary list is adopted into the scope as a delivery
       requirement (5C-RAT-7); the v2-unit commentary reconciliation
       is registered as a bounded POST-5C follow-up (that file stays
       frozen in 5C - the coder's refusal to silently touch it was
       correct).
R1/P2  CONFIRM stands with the two-leg test wiring (frozen-body tests
       under the v3 target + the new 5C test file). Verified V6.
R1/P3  CONFIRM stands, verified V1, INCLUDING removal of the dead
       error-set member (5C-RAT-5).
R1/P4  Amendment accepted (5C-RAT-4).
R1/P5  CONFIRM stands, verified V2, subject to the W3D-F1 relabel.
R3     The reliability cross-check is substantive, source-grounded,
       and reaches the right conclusion: the ratified reasoning holds
       unchanged at 256-bit. I concur after independent re-reading of
       the same charter sections against the same source.
R4     Adopted as normative AFTER the W3D-F1 correction (5C-RAT-6),
       including the chroma-plane frame-width derivations - forcing
       the remainder classes ON CHROMA PLANES of legal even-width
       frames is a genuinely better corpus than odd-width-only.
R5     Surface agreed: the one addition is the test file; and
       backend_tier_selection.zig moves from "MOD if wiring requires"
       to EXPECTED-UNTOUCHED (verified generic across tiers), with
       the conditional authorisation retained (5C-RAT-8).
Sweep Finding 1  Verified V7; lands in 5C-RAT-3.
Sweep Finding 2  Consistent with the source; its "then scalar" is the
       same historical mislabel corrected by W3D-F1.
Sweep Finding 3  ACCEPTED AS A W3D OBLIGATION: the 5C differential
       harness retains and extends the 4C tail-region non-vacuity
       check (a tail-named case must show changed samples IN the
       named tail region); the T5 mutant control supplements, never
       replaces, it.
```

# 5. Ratification items (the 5C-RAT series, for W3X)

```text
5C-RAT-1  W3X supplies the coder the current documentation package
          (charter v1_29 generation, today's full batch); the coder
          then performs the final delta knowledge sweep. The scope's
          authority header stands as written.
5C-RAT-2  Corpus wording amended per coder Q2: horizontal - a valid
          C2 tail shorter than the full N=32/N=16 batch; vertical -
          legal bottom underfill of the width-invariant four-row
          path at row counts 1, 2 and 3.
5C-RAT-3  NEW authorised file tests/classic_vector_backend_5c_tests
          .zig (W3C source; test-only; never imported by production;
          wired in build.zig as a second v3-target test leg beside
          the frozen-body tests run under the v3 target). 5C-T1
          gains explicit memory-safety proof language: minimal
          sample-valid alignment, non-vector-aligned strides,
          prefix/suffix/row-slack canaries, no assumed padding,
          strong-edge data so tails are non-vacuous.
5C-RAT-4  The benchmark step is a W3D-owned Python runner
          (perf_counter, 1 discarded warm-up + 3 recorded runs per
          backend v1/v2/v3, identical clip/frames/parameters/sink,
          every raw duration printed); build_5C_v1.bat only invokes
          it. Non-gating, unchanged (S5C-3).
5C-RAT-5  The v3 dispatch arm becomes real calls mirroring v2; the
          now-dead BackendInvariant member is removed from the local
          error set (verified: no other site).
5C-RAT-6  The R4 tables are adopted as normative WITH the W3D-F1
          terminal-step correction (V1 = one-lane vector, not S1;
          defensive-branch note; historical 4C wording noted), plus
          the chroma-forcing corpus frame widths. The corrected
          terminal fact is recorded as a candidate D0 K-item at the
          5C documentation pass.
5C-RAT-7  The W3X commentary mandate for classic_backend_v3_avx2.zig
          is folded into the scope as a named delivery requirement;
          the equivalent v2-unit commentary reconciliation is
          REGISTERED as a bounded post-5C follow-up scope (the v2
          unit remains frozen in 5C).
5C-RAT-8  backend_tier_selection.zig is EXPECTED-UNTOUCHED (coder-
          verified generic; W3D-concurred); the scope's conditional
          authorisation is retained for genuine wiring discoveries.
```

On ratification, W3D issues scope v1_1 folding 5C-RAT-2/3/4/5/6/7/8 at
their homes, W3X supplies the current package (5C-RAT-1) and the coder's
delta sweep closes the round; implementation is then RELEASED. W3D
harness obligations before final validation: the 5C differential
.vpy/.cmd set with tail-region non-vacuity, and the benchmark runner.

---

*Revision history*
```text
v1.0 (2026-08-14) Initial review of the W3C pre-implementation response
     v1_0: eight verifications recorded; one W3D finding (terminal
     tail-step mislabel, historical from 4C, corrected before normative
     adoption); all four coder questions accepted with remedies;
     5C-RAT-1..8 put to W3X.
```
