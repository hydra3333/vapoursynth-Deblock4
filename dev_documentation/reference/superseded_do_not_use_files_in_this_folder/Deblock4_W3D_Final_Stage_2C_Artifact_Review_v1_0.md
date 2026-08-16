# Deblock4 - W3D Final Stage 2C Artifact Review and Acceptance Recommendation

**Deliverable:** W3D-2C-FINAL-ARTIFACT-REVIEW
**Version:** 1.0
**Date:** 2026-08-12
**Author:** W3D (designer)
**Route:** W3D -> W3X
**Reviews:** the PASSING validation evidence (inspection_2C, OUTER_BATCH_
EXIT_CODE=0) and the exact source tree that produced it, diffed against the
W3D-reviewed v2.0 delivery expectation.
**Against:** D4 v1_9 authority set (D0 v1_11, D2 v1_6, D3 v1_10, Addenda
A/B v1_2, error table v1_6, D1 pin + provenance v1_4); the W3D model
verification record; charter v1_26.
**Status:** This review completes the batch's own demand
("W3D ARTIFACT REVIEW AND W3X ACCEPTANCE ARE STILL REQUIRED").
**Encoding:** US-ASCII; CRLF.

---

# 1. VERDICT

```text
W3D RECOMMENDS W3X ACCEPTANCE OF STAGE 2C.

Zero findings against the passing tree or the evidence. The repair
deltas between the reviewed v2.0 delivery and the passing tree are five
files, all reviewed below, none touching the mathematics. Every
evidence value W3D checked equals its independently derived expected
value. The D3 obligations now hold under THREE independent
confirmations: the W3D Python derivation model, the W3X Windows proof
matrix, and W3D's own native Linux execution of the pure-module test
suites performed during this review (28/28).
```

# 2. Repair-delta review (the complete unreviewed surface, now reviewed)

```text
src/classic_instance_creation.zig   THREE LINES: video_info.format.X ->
    video_info.*.format.X - the minimal explicit C-pointer dereference,
    exactly the diagnosed fix shape; inside the authorised file; no
    logic change. CLEAN.
tests/stage_2c_classic_obligations.vpy   Access-idiom migration
    (frame.get_read_array(p) -> frame[p], one local rename) forced by
    the VapourSynth R79 Python API; assertion logic unchanged. CLEAN.
tools/holywu_reference/stage_2c_holywu_diff.vpy   STRENGTHENED, not
    merely repaired: a proper no-autoload EnvironmentPolicy (core
    created with DISABLE_AUTO_LOADING), guards that no policy
    pre-exists, that the core really has autoload off, and that
    neither the deblock4 nor deblock namespace is preloaded before the
    two manual, normalized-path loads. K26 isolation discipline
    improved. CLEAN.
tools/holywu_reference/run_stage_2c_holywu_reference.cmd   One line:
    --info -> --python-script, coherent with the policy registration
    requirement. CLEAN.
tools/run_vs.cmd   W3X-OWNED wrapper (not a delivery artifact): VSROOT
    advanced to the R79 portable runtime; a --python-script mode
    added. Recorded as W3X tooling change; no coder-boundary question
    arises. NOTED.
```

Re-verified over the passing tree: K30 part 2 (added lines, all ten
edited modules) EMPTY; the full S2 sweep simulation ZERO hits; the five
repaired files US-ASCII CRLF clean. The three mathematics modules,
selector, detection, config, print helpers, instance data, version,
selftest, build.zig, batch and crosswalk are BYTE-IDENTICAL to the
reviewed v2.0 delivery.

# 3. Independent execution performed by W3D (new in this review)

```text
Zig 0.16.0 (the pinned toolchain version, via the official PyPI wheel)
was stood up in the W3D workspace and the pure-module obligation suites
were EXECUTED NATIVELY on Linux against the passing tree:
    zig test src/classic_edge_schedule.zig    16/16  (O-4 composite +
        order-sensitivity, O-5d native 16-bit, O-7 boundary family,
        A/B vectors, clamps, i32 bounds, guard bands)
    zig test src/classic_scalar_kernel.zig     8/8
    zig test src/classic_thresholds.zig        4/4
28/28. Same digits as the Windows matrix and the Python model: the
scalar mathematics is now confirmed on two operating systems, by two
parties, against one paper derivation.
```

# 4. Evidence verification (every value checked against its source)

```text
SENTINELS (H3(c) gate)   6/6 observed == ratified Addendum A expected:
    V-B2/H-B2 [109,107,103,101]; V-B4/H-B4 [1,3,6,8];
    V-B5/H-B5 [160,158,42,40]; both orientations; changed_cells =
    exactly the written positions. completion_state =
    sentinels-validated.
REFERENCE RECORD         pre-build == post-build pinned hashes (all
    four files); compilation_units = [deblock.cpp] ONLY; DLL SHA-256
    recorded; VapourSynth runtime honestly recorded as R79.
DIFFERENTIAL (K19(b)/H5) 17/17 cases, differences = 0 in every case,
    first_difference null; non-vacuity visible in the data (e.g. C01:
    both plugins changed the SAME 3028 samples per plane and disagreed
    on none; C02 the mutual no-op case). Marker
    STAGE_2C_HOLYWU_REFERENCE_ALL_PASS present.
SANITY GATE (G1-G6)      boundary blockiness 8.0 -> 1.703125 (the
    ratified 78.7% reduction), max_change 5, mean_change
    1.667236328125, extremes 100/108 - each digit equal to the W3D
    model. NEGATIVE CONTROL correctly REJECTED (its mean 3.984375 is
    itself the model's predicted value; the gate's refusal is the
    control's pass).
S5/T-S5                  classic_n04 line BYTE-EXACT ratified shape:
    "deblock4: 0.1.0-dev+2C Classic backend=auto
    tier=x86_64_v1_baseline reason=intentionally-capped
    (x86_64_v1_baseline) actual=x86_64_v3_with_avx2" followed by the
    rider-1C.1 using line in the correct order.
TESTS                    85/85 in Debug, ReleaseSafe AND ReleaseFast
    (23/23 build steps each).
RS-vs-RF                 STAGE_2C_RS_RF_BYTE_IDENTITY_PASS present
    (K10 satisfied on the production surface).
NEGATIVE CONTROLS        target/CPU overrides and all nine
    release/debug-option combinations rejected; the named-model BMI2
    perturbation was caught AT COMPILE TIME by the comptime
    Set-A/Set-B membership cross-check - the strongest possible form
    of that catch.
SUMMARY                  proof_matrix_summary.txt truthful: 1C re-exec
    line, IDENTITY=0.1.0-dev+2C, ZIG_VERSION=0.16.0, and the
    K30-free "STAGE2_D3_O_G K31 S5 H0_H6 PASS".
OUTER RESULT             STAGE 2C_v1 FULL PROOF MATRIX COMPLETED
    SUCCESSFULLY; OUTER_BATCH_EXIT_CODE=0.
```

# 5. Environmental fact of record

```text
The portable VapourSynth RUNTIME moved R78 -> R79 during the W3X
repair iteration (run_vs.cmd VSROOT; the R79 Python API forced the
harness idiom change; the completed record says R79). The IN-TREE
COMPILE HEADERS are unchanged (third_party/ has no delta), so the
binary API4 contract and the K31 stride-bytes verification against the
R78-era header remain valid. CONSEQUENCE: project documents citing R78
as the runtime gain a currency item on the end-of-phase pass; Project
Status v1_24 records the fact at acceptance.
```

# 6. Acceptance and commit guidance (all manual W3X acts)

```text
COMMIT   the passing tree as validated: the 21 delivery files WITH the
         five repair deltas, plus the review-record documents under
         dev_documentation/reviews/.
EXCLUDE  the five temporary repair .patch files at the repository root
         (working aids, per the W3C housekeeping note - delete them);
         zig-out/ evidence remains uncommitted as always (D4 7d); the
         inspection pack is retained by W3X as the Stage 2C evidence
         of record.
IDENTITY 0.1.0-dev+2C remains the tree identity until the next stage's
         scope advances it (S6 discipline).
THEN     W3D issues Project Status v1_24 (validation success, the five
         repair deltas, the R79 runtime fact, acceptance) and the
         END-OF-PHASE UPDATE PASS activates: README currency audit,
         coder-intro refresh, F10 propagation, the identifier-cleanup
         candidate, the refined-git-rule consolidation - one bundle,
         as registered.
```

# 7. Closing assessment

Stage 2C set out to construct a scalar oracle whose every number was
derived on paper before implementation, and to prove it against an
independent, pinned, externally-authored reference. The evidence shows
exactly that: values ratified in D3 months before this code compiled
were observed unchanged through a Python model, a Windows proof matrix,
a Linux re-execution, and seventeen byte-exact comparisons against
HolyWu's binary. The delivered scalar path is now, per S4 and K19(c),
THE ORACLE: every later Classic pixel, frame, copy and backend scope is
accepted only by differential against it.

---

*Revision history*
```text
v1.0 (2026-08-12) Final Stage 2C artifact review of the passing tree
     and evidence: five repair deltas reviewed clean (mathematics
     byte-untouched); K30/S2/encoding re-verified on the final tree;
     28/28 native W3D test execution; all evidence values equal to
     their independently derived expectations; R79 runtime fact
     recorded; W3X ACCEPTANCE RECOMMENDED.
```
