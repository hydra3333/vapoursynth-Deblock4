# Deblock4 - Stage 2C Session Bootstrap Header (Classic Scalar Oracle)

**Deliverable:** W3D-2C-BOOTSTRAP
**Version:** 1.1
**Date:** 2026-08-05
**Author:** W3D (drafted for W3X completion and issuance)
**Status:** v1.1 reissue after the pre-implementation review round (all
nine W3X ratifications of 2026-08-05 applied). Fields marked <W3X: ...> are
completed by W3X at issuance; everything else is filled from the amended
Stage 2C authority set. SCOPE RELEASE and IMPLEMENTATION RELEASE are
separate W3X acts; implementation awaits the explicit release after the
focused re-review resolves.
This is the charter session-bootstrap header (charter, "Session bootstrap
header") completed for the Stage 2C scope. The charter and the scope prevail
on any difference.
**Encoding:** US-ASCII; CRLF.

---

Project:
    Deblock4

Charter:
    filename          AI_Charter_and_Invariants_Card_v1_26.md
                      (the prevailing version per charter 2.3a; verify with
                      W3X that nothing newer exists before relying)
    internal version  1.26

Controlling documents (W3X-ratified authority wording, 2026-08-05):
    the charter (prevailing per 2.3a), the active scope D4 v1_8, and its
    read-together authority set (D0 v1_10, D2 v1_6, D3 v1_9, Addenda A/B
    v1_2, creation-error table v1_6, D1 pin + provenance v1_4).
    README_Deblock4_Design_Spec_v1_9.md is FALLBACK GENERAL GUIDANCE:
    the above PREVAIL on any conflict; consult it only on an IDENTIFIED
    MATTER they do not settle, naming the matter and section in the
    report. SUPERSEDED for 2C: README 12.5/12.6 (superseded by S5) and
    8.1 (superseded by S1).

Repository:
    https://github.com/hydra3333/vapoursynth-Deblock4

Branch:
    main

Starting commit:
    RATIFIED ALTERNATIVE (charter v1.18, session bootstrap header): the base
    is the exact ATTACHED SOURCE TREE, not a commit hash and not a
    filename (browsers rename downloads; the base is identified by
    CONTENT). The attached tree IS the base; treat it as exact; no
    branch/commit commands are needed. Content identity: the Stage 1C +
    rider 1C.1 accepted tree - build_1C_v1.bat present,
    effective_invocation_text.zig present, identity 0.1.0-dev+1C. If
    unsure the tree is current, ASK W3X to re-upload rather than
    inferring.
    Attached base package: <W3X: src package as attached at issuance>

Active scope:
    W3D-2C-D4 v1_8 (RELEASED as the review authority) - construct the
    deblock4.Classic ReleaseSafe
    scalar oracle, wire it into the Classic production frame path for
    integer formats, and deliver the external HolyWu differential harness
    that validates it (Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_8.md,
    read together with its authority set per its header and charter 2.3a).

Permitted changed files:
    NEW (D4 section 1):
        src/classic_scalar_kernel.zig
        src/classic_edge_schedule.zig
        src/classic_thresholds.zig
        tests/stage_2c_classic_*.vpy        (the 2C end-to-end harnesses)
        build_2C_v1.bat                     (the 2C proof matrix runner)
        tools/holywu_reference/**           (harness scripts, hash
                                             verification, reference-build-
                                             record schema/template, guard
                                             tests - W3C-delivered per H0)
        scope-required unit-test files for the new modules
    EXISTING (D4 section 7b, AUTHORISED NARROWLY - declared base hashes in
    the manifest; only the stated change class per file):
        src/classic_instance_creation.zig   (ONLY the three ratified
                                             refusals S1/K29/S5 + the A1b
                                             format/storage contract)
        src/classic_instance_data.zig       (ONLY sampleType/bitsPerSample/
                                             bytesPerSample + resolved
                                             implemented tier)
        src/classic_ar_all_frames_ready.zig (ONLY call the oracle instead of
                                             pass-through, retaining A1d)
        src/classic_frame_properties.zig    (ONLY Deblock4Tier = implemented
                                             tier actually executed; key set
                                             and formats unchanged)
        src/backend_tier_selection.zig      (the S5 implementation-
                                             availability cap; becomes
                                             the SINGLE summary emission
                                             point per D-2C-1/D-2C-2)
        src/cpu_capability_detection.zig    (D-2C-1 NARROW: move the
                                             summary emission out; expose
                                             ACTUAL tier + SummaryReason;
                                             NO detection-logic change)
        src/print_helper_functions.zig      (D-2C-3 NARROW: add the
                                             intentionally_capped variant
                                             + its format; existing
                                             variants byte-unchanged)
        src/deblock4_config.zig             (D-2C-2 NARROW: declare the
                                             per-filter ceilings + reason
                                             token; declarations only)
        src/deblock4_selftest.zig           (NARROW: extend the 1C pure
                                             section with D-2C-2/D-2C-3
                                             cases; existing unchanged)
        build.zig                           (ONLY module and unit-test
                                             wiring for the new files)
        src/deblock4_version.zig and each file that ASSERTS the identity
        marker (selftest banner, always-on line, Deblock4Version property,
        matrix identity gates) - ONLY the S6 marker advance
        0.1.0-dev+1C -> 0.1.0-dev+2C, each site named in the manifest.
    NOTHING ELSE. Anything further is a finding to raise BEFORE coding, not
    a judgement call at implementation time (D4 7b).

Forbidden changed files:
    All others. Explicitly (D4 section 1 OUT OF SCOPE):
        superseded/ anywhere (never read, move or delete - K17)
        dev_documentation/reference/holywu_r9/  (W3X-owned, READ-ONLY,
            never modified or EOL-normalised; the H0 external-reference
            tool is the SOLE authorised reader, hash-verified, external
            workspace only)
        registration and the using-echo surfaces
            (src/effective_invocation_text.zig and the rider 1C.1
            byte-stable "using" line and Deblock4Using property)
        the 1B.3 guard machinery and ALL detection LOGIC (the D-2C-1
            authorisation above covers ONLY relocating the summary
            emission; tables, comptime cross-check, CPUID/XGETBV/XCR0,
            ACTUAL/EFFECTIVE, force-down, G10 announce stay untouched)
        G10 debug modules (src/force_down_debug.zig,
            src/lifecycle_trace_debug.zig,
            src/print_diag_helper_functions.zig)
        every deblock4_* filter module (deblock4.Deblock4 stays
            pass-through and unchanged in 2C)
        build_1C_v1.bat (IMMUTABLE HISTORICAL EVIDENCE - never modified,
            never renamed, never run against the 2C tree - D4 7c)
        ANY @Vector code, SIMD intrinsic, or backend object (4C/5C)

Inputs supplied:
    The complete issuance bundle per
    Deblock4_Stage_2C_Issuance_Bundle_Manifest_v1_1.md: this header; the
    charter; the README (fallback guidance); D4 v1_8 with its full read-together
    authority set (D3 v1_9, Addenda A/B v1_2, D0 v1_10, D2 v1_6,
    creation-error table v1_6, provenance v1_4 + the byte-pinned holywu_r9
    snapshot with SHA256SUMS.txt); the knowledge documents for the
    section-0 sweep; and the exact attached source tree named above.

Required validation (W3X runs; W3C does not claim execution - C-DELIV-07):
    build_2C_v1.bat per D4 section 7/7c: re-executes every still-applicable
    Stage 1C invariant/regression gate against the CURRENT tree (three
    modes, unit tests, G10 three-surface absence, negative controls,
    S1/S2/S3/V1 audits, using-echo cases, error-table cases) EXPECTING the
    +2C identity, THEN the additive 2C gates: the full D3 v1_9 obligation
    unit-test run in all three modes; the 2C vspipe end-to-end cases
    including the creation-path cases (Addendum B N01a/N01b, N01c1/N01c2 +
    the exhaustive 17..32 guard, N02a/N02b, N03, N04); the whole-image
    sanity gate G1-G6 INCLUDING its constant-fill negative control; the
    ReleaseSafe-vs-ReleaseFast byte-identity check for every O-vector and
    composite frame (K10); and the differential harness run, gated on the
    reference-build record being present, its DLL hash matching, and all
    six Addendum A sentinel observations equal to the ratified expected
    values (mismatch = HARD STOP per H3(c)). Judge benign artifacts by
    EXIT CODE (P2); never findstr /X on CRLF-mixed captures (P3).
    Reference evidence (DLL, completed record, sentinel observations,
    comparison logs) is W3X-GENERATED, retained under the inspection
    output area, NOT committed source (D4 H0/7d).

Expected result:
    Debug, ReleaseSafe and ReleaseFast builds green; the full successor
    matrix green end to end with OUTER_BATCH_EXIT_CODE=0; every D3 v1_9
    O-item and G-item mapped in the mandatory 7d crosswalk to a passing
    test on its routed proof surface; the 17-case Addendum B differential
    corpus byte-exact against the hashed opt=1 reference (or every nonzero
    difference W3X-ratified per H5); files changed exactly per the
    permitted list above; no file on the forbidden list changed.

Known open measurement gates (none blocks this scope - charter P-10):
    Float tolerance NUMBERS (float is REFUSED in 2C per S1; the K22/V&T 3.8
    duty transfers to the later bounded float step). The Stage 3C
    compatibility/quality corpus gate. T-1 (WP-5 c0-from-aIndex quality
    question) is TABLED to 3C; 2C stays FAITHFUL.

Implementation acceptance for this scope:
    Per the charter bootstrap acceptance clause: this IS the FIRST bounded
    Stage 2C scope that CONSTRUCTS deblock4.Classic's ReleaseSafe scalar
    oracle, so the ORACLE-CONSTRUCTION EXCEPTION applies (charter G7;
    V&T 20.2; D0 K9; D4 S4). Acceptance is against the INDEPENDENTLY
    AUTHORED scalar obligations of D3 v1_9 IN FULL (per D4 section 5,
    including O-1c's 73 enumerated tuples and exhaustive bits=8..16 checks,
    O-1d, O-7 a/b/c/c2, O-8 a-h, the mandatory O/G-to-test crosswalk, and
    O-6d/e/f source-immutability/canaries/i32-range-proof), PLUS the loose
    whole-image sanity gate G1-G6 with its mandatory negative control,
    PLUS the pinned external HolyWu C/scalar oracle over the Addendum B
    legal-shared-domain corpus under the K26 execution pin (hashed binary,
    opt=1 forced, Addendum A sentinels validated). AFTER acceptance the
    delivered scalar path BECOMES the oracle and every later Classic
    pixel/frame/copy/backend scope is accepted only by per-type
    differential against it (integer byte-identical; K19 layer (c)).

The session package contains:
    1. this completed header;
    2. the charter (Part 1 at minimum; the full charter is attached);
    3. the controlling README/specification;
    4. the active scope D4 v1_8 and its read-together authority set;
    5. all files the scope touches (the attached source tree);
    6. the scope-specific test-vector and harness contracts (D3 v1_9,
       Addendum A v1_2, Addendum B v1_2, creation-error table v1_6).

Revision history:
    v1.1 (2026-08-05) reissue after the pre-implementation review round:
        authority wording (README fallback per Q5); pointers advanced to
        D4 v1_8 / D0 v1_10 / D3 v1_9; permitted-file list extended per
        D-2C-5 and the blanket detection prohibition corrected to
        logic-only (the v1_0 listing was W3D's pre-understanding error);
        base identified by content not filename (Q7); the two release
        states adopted (Q6).
    v1.0 (2026-08-03) initial issuance header.

Revision-matching check (W3C performs before beginning work):
    For every controlling document above, verify the filename version and
    the internal version string agree; STOP on any mismatch (charter,
    "Revision matching"). Scope currency against later controlling-document
    changes is governed by charter 2.3b.
