# Deblock4 - Stage 1B.3 W3D Response to the W3C v2 Delivery

Version: v1.0
Date: 2026-07-31
Reviewed: Deblock4_Stage_1B3_W3C_delivery_v2.zip (report v2, repo_new_files,
   build.zig replacement, dll_probe patch, STATIC_VALIDATION_v2, MANIFEST v2)
Against: scope v1.3, charter v1.18, and the W3D v1 delivery review.
Encoding: US-ASCII only
Status: LOGIC ACCEPTED (unchanged and re-confirmed). Delivery form accepted
   EXCEPT the line-ending scheme, which requires one minimal v3 re-emission
   per the ruling in section 3. All section-7 build/run proofs remain owed.

---

## 1. Convergence confirmed - and commended

W3D diffed every v2 file against the reviewed v1 implementation with line
endings normalised: ALL NINE FILES ARE CONTENT-IDENTICAL. The successor coder
re-verified the settled detection design and retained it exactly - no
re-derivation drift, no reopening of chartered ground (the Set-A/Set-B
contract, whole-level resolution, the two-record model, the comptime
cross-check). That is precisely the correct handling of settled, chartered
material: verify, converge, retain. The re-verification itself has value as a
further independent witness to the contract.

## 2. The three v1 delivery-form findings - W3D assessment

The successor raised three defects in the v1 delivery FORM. W3D's assessment:

F1. The v1 instruction to apply with `--whitespace=nowarn` BYPASSED the
    mandatory `git apply --check --whitespace=error` gate (C-DELIV-03).
    GENUINE DEFECT, correctly repaired. W3D notes its own v1 review did not
    flag this; the successor's catch stands. The correct reconciliation is
    the one v2 itself used for build.zig: `core.whitespace=cr-at-eol`, which
    makes the mandatory gate compatible with CRLF content instead of
    bypassing the gate. See ruling R2 below.

F2. v1 supplied BOTH a patch and an overlay for the same existing files,
    violating C-DELIV-02 (one delivery form per file per revision).
    GENUINE DEFECT, correctly repaired: v2's build.zig complete replacement
    (dispersed additions justify whole-file) plus a single dll_probe patch is
    the right split. Retain this form.

F3. v1 delivered new files as CRLF where C-DELIV-06's text says LF-unless-
    existing-contract. The successor's reading of the charter TEXT is
    CORRECT AS WRITTEN - this was compliant, careful behaviour, not an
    error. However, the charter TEXT is itself the defect here: it
    contradicts the project's established repository practice (the committed
    Stage 1B.2 files, including build.zig and the standing batch, are CRLF)
    and it misfires FUNCTIONALLY on Windows batch files. The literal
    compliance surfaced a real charter/practice contradiction, which is
    useful - but the outcome (an LF batch file) cannot stand. See section 3.

Learning point, stated plainly because it generalises: when literal charter
text and established repository practice conflict, the coder's correct move
is to STATE the conflict and stop (charter H1 spirit), not to silently pick
either side. v2 picked the text side silently; v1 picked the practice side
silently (and W3D's v1 review blessed it without noticing the conflict -
that miss is W3D's). The conflict is now resolved by ruling below.

## 3. The line-ending ruling (W3D recommendation; W3X ratification pending)

R1. EVERY REPOSITORY TEXT FILE IS CRLF. Rationale: this is a Windows-only
    project (charter 3.1); cmd.exe REQUIRES CRLF batch files for reliable
    label/`goto`/`call :label` scanning - an LF-only 685-line batch with 19
    labels and 97 calls is a functional hazard regardless of any style
    policy; the committed repository practice is already CRLF; and one
    uniform rule with no per-file judgement is mechanically checkable, the
    same spirit as C-STY-01. Per-file cleverness is exactly what a generic
    rule exists to prevent.

R2. THE GIT CONFIGURATION IS PINNED so the mandatory whitespace gate and
    CRLF coexist: `core.autocrlf=false` and `core.whitespace=cr-at-eol` in
    the repository. With that, `git apply --check --whitespace=error` and
    `git diff --check` pass over CRLF content legitimately - no bypass
    needed. (v2 already demonstrated this mechanism for build.zig; it
    becomes the standing arrangement, stated as a prerequisite in delivery
    manifests rather than applied ad hoc.)

R3. EXISTING SCAFFOLDING FILES KEEP THEIR CURRENT ENDINGS until the
    filter-creation-stage sweep deletes them. src/dll_probe.zig is LF today
    and is scheduled for deletion at that sweep (C-STY-10); converting a
    doomed file is churn. The v2 LF patch against it therefore STANDS
    unchanged.

R4. C-DELIV-06 is amended to say CRLF at the next charter bump (a W3X
    documentation action, not a coder action; recorded here so the successor
    does not treat the current LF text as controlling once W3X ratifies).

## 4. Required v3 re-emission (minimal)

Re-emit ONLY the eight new files with CRLF line endings, bytes otherwise
identical:

```text
    build_1B3_v1.bat                     (FUNCTIONALLY REQUIRED - see R1)
    src/cpu_capability_detection.zig
    src/deblock4_config.zig
    src/deblock4_selftest.zig
    src/force_down_debug.zig
    src/print_diag_helper_functions.zig
    src/print_helper_functions.zig
```

plus the build.zig replacement unchanged (already CRLF) and the dll_probe
patch unchanged (R3). Keep every other aspect of the v2 delivery form: single
form per file, no whitespace-gate bypass, and state the R2 git configuration
as an explicit prerequisite line in the manifest. Update the manifest SHAs.

If W3X declines the R1 ruling (W3D does not expect this, but W3X decides),
the batch file ALONE must still be CRLF on functional grounds; W3D would then
accept mixed endings under whatever rule W3X states. Either way: one stated
rule, no silent per-file choices.

## 5. Everything else stands

- The v1 W3D review's findings and its section E action sequence remain in
  force unchanged: (1) verify the inline asm first via the baseline
  detection object and its dumpbin /DISASM; (2) run build_1B3_v1.bat and
  capture full output; (3) produce the demonstrated-then-reverted
  @compileError perturbation evidence; (4) submit the membership
  mapping/exclusion classification for formal W3X/W3D approval before the
  implementing commit.
- All scope section-7 runtime/inspection proofs remain OWED. Nothing in v2
  changed that, and v2 correctly claims no execution.
- The v2 report's exact-base discipline (attached-tree SHA, no inferred
  commit) matches the ratified charter v1.18 alternative and is correct.

## 6. One-line summary for W3X

Logic unchanged and re-confirmed by the successor (good); v2's delivery-form
fixes are genuine and kept, except the LF flip which followed defective
charter text - ratify CRLF-for-repository-files plus the pinned git
whitespace config (R1/R2), have the coder re-emit the eight new files as
CRLF (batch is functionally mandatory), leave the LF dll_probe patch alone,
amend C-DELIV-06 at the next charter bump, then proceed straight to the
build/run proof sequence.
