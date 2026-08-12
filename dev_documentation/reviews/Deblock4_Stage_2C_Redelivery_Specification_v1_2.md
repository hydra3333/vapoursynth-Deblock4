# Deblock4 - Stage 2C Redelivery Specification (No-Script Package Form)

**Deliverable:** W3D-2C-REDELIVERY-SPEC
**Version:** 1.2
**Date:** 2026-08-11
**Author:** W3D (designer)
**Route:** W3D -> W3X -> W3C
**Status:** W3X-RATIFIED redelivery instruction (W3X decisions Q1/Q2/Q3,
2026-08-10). Supersedes the consolidated-round list of the S2 incident
document and the open items of the rider re-review: delivery v1.0 and the
F-1 rider are RETIRED WHOLESALE; the W3X tree is verified reset to HEAD
(empty git status). This document specifies the complete replacement
package. The scope itself (D4 v1_9 authority set) is UNCHANGED.
**Encoding:** US-ASCII; CRLF.

---

# 1. The ratified shape (W3X Q1)

```text
SCOPE OF THE NO-POWERSHELL RULING (precise form per W3C review F-1;
W3X-confirmed): NO Stage-2C-AUTHORED-OR-SHIPPED .ps1 machinery of any
kind - specifically no apply, restore, K30-audit or HolyWu-build .ps1,
and no patch files. PRE-EXISTING, ALREADY-REVIEWED PowerShell usage is
retained unchanged: build_2C_v1.bat's inline scans/hash comparisons
and its invocations of the Stage 1C audit scripts resident in the base
repository (S1/G10/S2/S3) remain exactly as reviewed, minus ONLY the
K30 step. The single NEW script authored this round is the MSVC
reference-build driver as a .cmd (section 4); the package also carries
the retained build_2C_v1.bat and the minimally-adjusted HolyWu runner
.cmd.

THE REFINED W3X GIT RULE (ruled 2026-08-11; PREVAILS over every broader
statement in earlier documents of this arc): FORBIDDEN in machinery -
git stash, any automatic staging or committing, and any proof/audit
machinery whose CORRECTNESS depends on a particular local git
index/staging/HEAD state (the retired K30 audit's index mode, correct
only in the applied-but-unstaged state, is the defining example).
PERMITTED - non-destructive git reads (git diff --check, git status,
git ls-files enumeration robust across normal states, e.g. the 1C S3
audit) and W3X-MANUAL git workflows including git apply and the
per-file backout block. The retained batch's git reads (diff --check
at two gates; final status display) are explicitly compliant and stay
byte-identical.

PACKAGE LAYOUT:
  Deblock4_Stage_2C_Implementation_Delivery_v2_0/
    Deblock4_Stage_2C_Implementation_Delivery_Manifest_v2_0.md
    apply_to_tree/        (mirrors the repo layout; 21 files = 16
                           byte-identical + 5 changed/authored)
    restore_to_base/      (pre-change copies of the 10 REPLACES files)

APPLICATION (manual W3X act): copy the CONTENTS of apply_to_tree/ over
the repository root. Nothing else. The manifest lists every file with
NEW/REPLACES so the result can be eyeballed against git status.

BACKOUT (manual W3X acts, manifest-carried): the per-file command
block (10x git restore + 12x del + rd tools\holywu_reference,
static-review v1_3 section 5b form), AND/OR manual copy-back from
restore_to_base/. The folder's three ruled purposes are stated:
delivery base record; W3D verification input; manual backout resource.
```

# 2. Byte-identity requirements (this is what makes the round small)

The reviewed core took ZERO findings and its mathematics is verified
digit-for-digit against the independent W3D model. It returns
BYTE-IDENTICAL, and W3D will verify that mechanically against retained
copies before anything else is read.

```text
WHOLE-FILE BYTE-IDENTICAL (16 apply files - any difference is a
finding; the mechanically unambiguous set per W3C review F-2):
  the 10 REPLACES sources:
    build.zig, src/backend_tier_selection.zig,
    src/classic_ar_all_frames_ready.zig,
    src/classic_instance_creation.zig, src/classic_instance_data.zig,
    src/cpu_capability_detection.zig, src/deblock4_config.zig,
    src/deblock4_selftest.zig, src/deblock4_version.zig,
    src/print_helper_functions.zig
  the 3 new first-class modules:
    src/classic_scalar_kernel.zig, src/classic_edge_schedule.zig,
    src/classic_thresholds.zig
  tests/stage_2c_classic_obligations.vpy
  tools/holywu_reference/stage_2c_holywu_diff.vpy
  tools/holywu_reference/reference-build-record-schema.json

CHANGED/AUTHORED (5 apply files - the entire W3C authoring surface):
  tests/Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md:
    the single K30 row re-routed per section 3; EVERY OTHER ROW
    byte-equal to the reviewed copy (W3D diff-verifies).
  build_2C_v1.bat - EXACTLY FOUR authorised deltas against the
    retained reviewed copy (any other delta is a finding):
    (1) REMOVE the K30 preflight existence-check line (reviewed copy
        line 115);
    (2) REMOVE the K30 audit step block (MARKER/CMD/invocation and its
        exit-code handling, reviewed copy lines ~652-656);
    (3) proof-summary token change, exactly as W3X directed:
        CURRENT:     STAGE2_D3_O_G K30 K31 S5 H0_H6 PASS
        REPLACEMENT: STAGE2_D3_O_G K31 S5 H0_H6 PASS
    (4) nothing else. EXPLICITLY RETAINED: the crosswalk-completeness
        scan's ID list KEEPS 'K30' (reviewed copy line 684) because
        the crosswalk RETAINS its K30 row, re-routed to delivery
        evidence - removing that ID would itself be a finding.
  tools/holywu_reference/build_holywu_r9_scalar.cmd: NEW, replacing
    the .ps1 (section 4).
  tools/holywu_reference/run_stage_2c_holywu_reference.cmd: invokes
    the new .cmd instead of powershell; otherwise minimal.
  tools/holywu_reference/README.md: references the .cmd; documents
    the K30 evidence routing (section 3); otherwise minimal.

SEPARATELY: restore_to_base/ = the 10 pre-change base copies,
byte-equal to HEAD (W3D verifies against the held base).

TOTAL: 16 + 5 = 21 apply_to_tree files, + 10 restore_to_base copies.

DROPPED (do not ship): apply_delivery.ps1, restore_to_base.ps1,
  tools/audit_stage_2c_k30_first_class.ps1, any .patch.
```

# 3. K30 routing (W3X Q2, ratified as compatible with the ratified
contract wording "a delivery obligation ... named in the crosswalk")

```text
The K30 two-part audit is discharged as DELIVERY EVIDENCE, not as an
in-tree gate:
  (a) W3C performs the audit with its OWN tooling at authoring time
      and reports the results in the delivery manifest: part 1 (new
      modules + build wiring + test names, full scan, generic
      vocabulary + the CANONICAL thirteen S2 basenames, expected
      EMPTY) and part 2 (existing edited modules, ADDED LINES ONLY,
      no new scaffolding reference, no retired identifier; accepted
      Stage 1C identifiers untouched). The canonical list is the S2
      sweep's thirteen names - NOT the seven-entry list of the retired
      v1.0 audit.
  (b) W3D independently re-verifies both parts at review time with
      the W3D-held tooling (the transliterated sweep + LCS
      changes-only comparator already proven in the S2 incident).
The crosswalk's K30 row routes to this evidence pair. build_2C_v1.bat
carries NO K30 step. CONSEQUENCE, VERIFIED: with no in-tree audit
script, the tree contains no retired literal anywhere and the S2
collision class is dissolved at the root (W3D whole-tree simulation:
zero hits).
D4/D0's K30 wording ("named in the O/G crosswalk with this exact
two-part domain") remains satisfied; the phrasing that implies an
in-tree audit gets its touch-up on the end-of-phase pass, per the
recorded W3X compatibility ruling of 2026-08-10.
```

# 4. The one script: build_holywu_r9_scalar.cmd (W3X Q3)

```text
Plain CMD, W3X house style (hard exit-code checks after every step,
no PowerShell, no git). Requirements, all carried over from the
reviewed .ps1 - the DISCIPLINE is unchanged, only the language:
  1. Verify the four pinned holywu_r9 files against SHA256SUMS.txt
     BEFORE the build: certutil -hashfile <file> SHA256, compare the
     computed hash against the expected constant (the expected values
     may be embedded as SET constants read from the committed
     SHA256SUMS.txt at authoring time, or parsed from the file);
     MISMATCH = hard stop, nonzero exit.
  2. Compile deblock.cpp ONLY (deblock_sse4.cpp never compiled -
     scalar by construction), in place by absolute path, never
     copying or EOL-normalising the pinned snapshot; /O2 per the
     recorded OBS-2 ruling; produce the reference DLL in the
     evidence area.
  3. Re-verify the four hashes AFTER the build (tamper window closed)
     - mismatch = hard stop.
  4. Hash the produced DLL (certutil) and write the preliminary
     reference-build record (schema unchanged) including the exact
     compile command line.
  5. Exit 0 only if every step succeeded. Assert by EXIT CODE per the
     standing P2/P3 rules; no findstr /X on mixed-EOL captures.
```

# 5. Manifest v2_0 requirements

```text
- Complete file list, NEW/REPLACES per file, no hashes (Q8 standing).
- The manual application instruction (one copy operation).
- The full manual backout command block + the restore_to_base/ triple
  purpose.
- The K30 evidence report per section 3(a).
- The statement (aligned to the refined W3X git rule): delivery and
  validation machinery uses NO git stash, NO automatic staging or
  committing, and NOTHING whose correctness depends on a particular
  index/staging/HEAD state; non-destructive git reads are permitted
  and present (batch diff --check / status); the manifest's MANUAL
  W3X backout block and any W3X-manual git workflow are outside
  machinery entirely.
- C-DELIV-07: no execution/PASS claims; W3X runs all validation.
```

# 6. W3D re-review scope on return (small by construction)

```text
1. Mechanical byte-check of the 16-file identical set + the 10
   restore_to_base copies against retained reviewed/held copies; the
   crosswalk diff-verified as K30-row-only.
2. Diff-review of build_2C_v1.bat (expected: exactly the K30 step +
   preflight line removed).
3. Full review of the new .cmd; delta review of the runner + README.
4. Manifest v2_0 review incl. the K30 evidence report, independently
   re-verified per section 3(b).
5. Whole-tree S2/S3 simulation re-run over the merged result.
```

---

*Revision history*
```text
v1.2 (2026-08-11) Applies the W3X clarifications relayed through the
     W3C mechanical reconciliation: (a) the REFINED GIT RULE recorded
     (forbidden: stash/auto-staging/committing/state-dependent
     correctness; permitted: non-destructive reads incl. the batch's
     own diff --check and status, S3's ls-files, and W3X-manual git
     workflows) - this prevails over the broader v1_1 wording, which
     had outlawed the already-reviewed batch; (b) the batch authoring
     surface enumerated as EXACTLY FOUR deltas incl. the W3X-directed
     proof-summary token change (K30 removed from the PASS line - the
     coder's catch: W3D's "nothing else changes" pin would have left
     a false K30 PASS claim) and the explicit retention of 'K30' in
     the crosswalk-completeness ID list. Proposer W3C/W3X; defect-
     owner W3D for the over-broad v1_1 wording and the summary-line
     omission.
v1.1 (2026-08-10) Resolves the W3C pre-authoring review v1_0 - all
     three findings were W3D spec defects, acknowledged: F-1 the
     no-PowerShell ruling scoped precisely (no Stage-2C-shipped .ps1
     machinery; the batch's pre-existing reviewed PowerShell usage and
     1C audit invocations retained, minus only K30) - W3X-confirmed;
     F-2 counts corrected to the coder's mechanically consistent
     16 + 5 = 21 split with the crosswalk moved to the authored set
     (K30 row only); F-3 the git statement narrowed to machinery-only
     with the manual backout block exempted. Proposer W3C, adopter
     W3X, defect-owner W3D.
v1.0 (2026-08-10) Redelivery specification implementing W3X rulings
     Q1 (no-script package, manual apply/backout), Q2 (K30 as
     delivery evidence + W3D verification; batch step removed; S2
     collision dissolved at root), Q3 (single .cmd reference-build
     driver with certutil hash guards). Delivery v1.0 + F-1 rider
     retired wholesale; tree reset verified; reviewed core pinned
     byte-identical to preserve the completed review.
```
