# Deblock4 - Stage 1C Phase 3b Coder Resume Brief

**Version:** 1.1
**Date:** 2026-08-02
**Author:** W3D (designer), issued by W3X
**Audience:** the NEW W3C coder chat resuming Phase 3b. Read AFTER the durable
coder introduction (111_New_Chat_Introduction_for_Coder_v1_19.md) and the
Phase 3a review trio it names. This brief carries the VOLATILE current state;
the introduction carries the durable orientation. Where they differ on current
state, THIS BRIEF prevails (it is newer).
**Encoding:** US-ASCII; CRLF.

---

# 1. Where the project stands

- Phases 1, 2 and 3a of Stage 1C are ACCEPTED AND COMMITTED. The plugin
  genuinely registers both filters and passes frames byte-identically under
  VapourSynth R78 on W3X's machine.
- Phase 3b (sweep + permanent build/proof surface + full proof matrix) was
  delivered and then debugged across deliveries v1_0..v1_12 (all applied; the
  repository currently holds the v1_12 state). The proof matrix now runs
  END TO END and passes EVERYTHING except ONE final gate:

```text
PASS   S1 structural audit, G10 import audit, S2 sweep, S3 (deliverable-tree
       domain), V1 single-home, initial whitespace gate
PASS   ReleaseSafe: build, 40/40 unit tests, selftest, ALL vspipe cases
       (valid + error, byte-identical SHA in/out), G10 three-surface absence,
       export exclusions
PASS   ReleaseFast: same, in full
PASS   Debug (all three G10 seams enabled): build, 40/40, selftest with full
       capability dump, G10 three-surface POSITIVE controls
FAIL   Debug: "DLL export table excludes deblock4_force_down_marker_FD00D001"
```

The v1_12 run transcript is preserved (zig-out\inspection_1C plus W3X's
console capture) and is valid partial evidence for everything above.

# 1a. Concrete orientation: tree, environment, evidence (leg-up facts)

## 1a.1 The v1_12-applied deliverable tree you are working on

```text
repo root: build.zig, build.zig.zon, build_1C_v1.bat (the ONE standing runner)
src/  (29 files)
  deblock4_plugin.zig            plugin root; registers Classic + Deblock4
  classic_instance_creation.zig  deblock4_instance_creation.zig
  classic_callback_router.zig    deblock4_callback_router.zig
  classic_ar_initial.zig         deblock4_ar_initial.zig
  classic_ar_all_frames_ready.zig deblock4_ar_all_frames_ready.zig
  classic_frame_properties.zig   deblock4_frame_properties.zig
  common_ar_error.zig  common_frame_mechanics.zig
  common_frame_property_helpers.zig  common_instance_data_structure.zig
  classic_instance_data.zig  deblock4_instance_data.zig
  backend_tier_selection.zig  cpu_capability_detection.zig
  filter_call_parameters.zig  deblock4_config.zig  deblock4_version.zig
  force_down_debug.zig  print_diag_helper_functions.zig
  lifecycle_trace_debug.zig      <- the three G10 marker homes (section 2.1)
  print_helper_functions.zig  deblock4_selftest.zig
  vapoursynth_api4.h  vapoursynth_helper_bridge.c
tests/ stage_1c_classic_passthrough.vpy  stage_1c_deblock4_passthrough.vpy
tools/ run_vs.cmd (W3X-owned) + audit_stage_1c_{s1_structure,g10_imports,
       s2_sweep,s3_eol}.ps1 (the four -File audits)
third_party/vapoursynth/include/ (four R78 headers, W3X-owned)
designer_interaction/deliveries/ holds the v1_11 and v1_12 zips + manifests +
resume instructions = your delivery history and BASE (v1_12).
```

## 1a.2 W3X environment facts (do not rediscover)

```text
repo:  E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4
VS2026 v18.8.1: "C:\Program Files\Microsoft Visual Studio\18\Community\
  Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64
Zig 0.16.0: C:\SOFTWARE\zig
VapourSynth R78 (portable): D:\TEST\Vapoursynth_x64_R78, driven ONLY via
  tools\run_vs.cmd (W3X-owned)
Runner invocation: call build_1C_v1.bat  (self-relaunches as --worker and
  types the transcript at the end; direct worker run for live tracing:
  build_1C_v1.bat --worker)
Build matrix: ReleaseSafe + ReleaseFast with all -Denable_*=false;
  Debug with -Denable_force_down=true -Denable_verbose_detection=true
  -Denable_trace_lifecycle=true
Inspection outputs: zig-out\inspection_1C\<Mode>\ (dumpbin exports/symbols/
  disasm captures, selftest + unit-test transcripts)
```

## 1a.3 The standing E-series case set (post-F6/empty-planes retirements)

```text
classic:  valid_auto valid_full error_strength error_duplicate_planes
          error_unknown_backend error_variable_format
deblock4: valid_auto valid_full midpoint_present midpoint_absent
          error_strength error_duplicate_planes error_step_low
          error_step_high error_unknown_backend error_variable_format
All valid cases assert byte-identical input/output SHA-256 and Deblock4's own
one-line summary; all error cases assert Deblock4's OWN message text.
```

## 1a.4 Evidence of the v1_12 run (your starting proof state)

W3X holds the full v1_12 console transcript; zig-out\inspection_1C\ holds the
per-mode captures, including Debug\Deblock4_exports.txt whose export rows are
quoted verbatim in section 2. The v1_12 resume helper also preserved the prior
partial evidence at zig-out\inspection_1C_v1_11_partial_evidence.

## 1a.5 Delivery numbering and helper conventions for your correction

Your correction is delivery v1_13 (Deblock4_Stage_1C_Phase_3b_W3C_delivery_
v1_13.zip) into designer_interaction/deliveries/. Follow the established
resume-helper pattern (see the v1_12 helper): fail-closed preconditions on
APPLIED-STATE evidence, install exactly the changed files, byte-verify each
with fc /B, run the git cr-at-eol diff gate, then launch the runner. Include
manifest, SHA256SUMS, and a diff from the v1_12-applied state.

# 2. THE OPEN ISSUE: a REAL G6 violation (harness verdict CORRECT)

W3X inspected zig-out\inspection_1C\Debug\Deblock4_exports.txt. The Debug
production DLL's PE export table contains REAL export rows:

```text
ordinal hint RVA      name
      1    0 00002560 VapourSynthPluginInit2
      2    1 00002540 _DllMainCRTStartup
      3    2 00134410 deblock4_force_down_marker_FD00D001
      4    3 00138750 deblock4_lifecycle_trace_marker_1C71FE01
      5    4 00134170 deblock4_verbose_detection_marker_DD00D001
```

The three G10 debug markers are PE-EXPORTED from the Debug DLL. This is
exactly what charter G6 forbids: gated debug code reachable through the DLL
export surface is a call path that bypasses the dispatch guard. The failing
check did its job. THE GATE MUST NOT BE RELAXED, SUPPRESSED, OR SCOPED AROUND.
The fix is at the source/build layer. (The selftest.exe capture is the
harmless empty one - executables here have no export table; only the DLL is
at issue.)

## 2.1 Verified root cause

All three markers are declared with the export keyword:

```text
src/force_down_debug.zig:42          pub export fn deblock4_force_down_marker_FD00D001() u32
src/print_diag_helper_functions.zig:14  pub export fn deblock4_verbose_detection_marker_DD00D001() u32
src/lifecycle_trace_debug.zig:22     pub export fn deblock4_lifecycle_trace_marker_1C71FE01() u32
```

In Zig, `export fn` compiled into a Windows DLL means dllexport: the symbol
enters the PE export table. Release builds pass only because the gated
modules are compiled out entirely, so there is nothing to export. The
`export` idiom was correct in the Stage 1B.1 OBJECT-mode context (object
files have no PE export table; export there = external COFF symbol for
dumpbin evidence). Carried into the DLL compilation it silently became
dllexport. Emission, linkage and PE-export are distinct properties (charter
G6 corollary); the keyword conflated the last two.

## 2.2 Directed fix (verify, do not assume)

1. Remove `export` from the three marker declarations (`pub export fn` ->
   `pub fn`). No other logic change.
2. VERIFY PER MARKER that it remains retained and observable in Debug on all
   three proof surfaces (raw-string, symbol/disasm immediates) AFTER
   de-exporting. Evidence says all three are reachable on enabled paths (all
   three marker strings print at runtime in the v1_12 Debug selftest
   transcript, and the selftest calls the lifecycle marker directly at
   deblock4_selftest.zig:22; force_down and verbose print their marker
   strings on their enabled paths), so
   Debug emission should survive on reachability alone; but if any marker
   turns out to be retention-only, give it an explicit call or address-taken
   anchor ON ITS ENABLED PATH (the proven 1B.1 pattern), never `export`.
3. Expected result: Debug DLL export table contains ONLY
   VapourSynthPluginInit2 and _DllMainCRTStartup; ALL Debug G10 positive
   controls still pass; both release modes unchanged; the final gate and the
   full fifteen-gate matrix go green:

```text
B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
STAGE 1C_v1 FULL PROOF MATRIX COMPLETED SUCCESSFULLY
```

4. Deliver as the next numbered Phase 3b correction (source files + any
   consequential runner change - none expected) with a resume helper in the
   established pattern (see section 4). This finding is also a Toolchain
   Findings candidate (export-in-object vs export-in-DLL); note it in the
   delivery manifest for W3D to fold into the Findings document.

# 3. Lessons already paid for (do NOT re-litigate)

The v1_0..v1_12 debug arc settled the following; every one cost a cycle:

- VsDevCmd.bat takes -arch=amd64 -host_arch=amd64 (NOT x64) on W3X's VS2026.
- %~dp0 ends in a backslash; quote-safe root form is `%~dp0.` (the runner's
  DEBLOCK4_PROJECT_ROOT). Trailing-slash var only ever as a path PREFIX.
- Outer self-relaunch form: `"%ComSpec%" /D /V:OFF /C call "%~f0" --worker`
  (no doubled-quote wrapper).
- NO embedded `\"` inside cmd-quoted `powershell -Command` strings, ever.
  All four standing audits live in tools/audit_stage_1c_*.ps1 invoked via
  -NoProfile -ExecutionPolicy Bypass -File; remaining inline commands use
  single-quoted PS strings, \x22, or [char]34 only.
- S3's proof domain is the Stage 1C DELIVERABLE TREE (build.zig,
  build.zig.zon, build_1C_v1.bat, src/, tests/, tools/, third_party/) as an
  ALLOWLIST of roots - a W3X-ratified interpretation; scope text amends at
  next issuance. Do not widen it.
- Toolchain F6: VapourSynth coerces numeric args to the registered type
  before the plugin sees them; plugin-side wrong-type rejection for int
  params is unreachable; the error_wrong_type cases were retired.
- error_empty_planes: the binding rejects empty arrays pre-plugin; the case
  was retired from the harnesses, but the plugin's empty-array validation is
  RETAINED as low-level-API defence - do not delete it as dead code.
- deblock4_selftest.zig: Zig forbids `!=` on [3]u32; std.mem.eql form is in
  place.
- Zig's --listen "failed command:" stderr context on PASSING tests is a
  known benign artifact; exit codes, Zig summaries and explicit gate
  markers are authoritative.
- W3X-owned files (the four third_party VapourSynth headers, tools/
  run_vs.cmd, and any file W3X states it sourced/authored) must never be
  modified - even EOL-normalised - without flagging and W3X consent first.
- Resume helpers precondition on APPLIED-STATE evidence (harnesses present,
  deletions applied), never on the artifact the helper itself installs; a
  mixed retirement state fails closed.

# 4. Delivery discipline reminders (charter prevails)

- One bounded correction at a time; case-list/runner edits stay surgical.
- Deliveries go to designer_interaction/deliveries/ as
  Deblock4_Stage_1C_Phase_3b_W3C_delivery_v1_NN.zip with manifest, SHA256SUMS,
  diff from the prior applied state, and a resume helper that installs and
  byte-verifies exactly what changed. W3D reviews from GitHub; W3X applies
  and runs; W3X alone accepts and commits.
- C-DELIV-09 incremental emission is in force for larger work; this
  correction is expected to be a single small delivery.

# 5. After the fix: the path to Stage 1C closure and the next small step

1. Matrix fully green -> W3X accepts Phase 3b -> W3X commits (commit
   hygiene: the repository gains/retains exactly the deliverable tree; no
   delivery zips, no validation_support remnants, ONE runner named
   build_1C_v1.bat).
2. Stage 1C is then COMPLETE. Documentation follow-ups (W3D-led): Toolchain
   Findings v1_2 (F6 + empty-planes companion + this export finding),
   Project Status update, P4 creation-error message-table review (draft:
   Deblock4_Stage_1C_Phase_3b_Creation_Error_Message_Table_Draft_v1_0.md
   inside the Phase 3b v1_0 delivery zip; unreviewed).
3. NEXT SMALL STEP (released by W3X ONLY after 1C acceptance): rider Stage
   1C.1 "using" invocation echo - already fully specified in
   Deblock4_Scope_Stage_1C1_Rider_Using_Echo_v1_0.md (a second stderr line
   `deblock4: using Classic(...)` with resolved values incl. defaults, plus
   a matching frame property; matrix extended and re-run). DO NOT begin it
   until W3X releases it.

# 6. Your first response

Confirm, in order: (1) the documents you hold and their versions; (2) your
understanding of the open G6 finding and why the gate must not be relaxed;
(3) your planned fix per section 2.2 including the per-marker retention
verification; (4) that you will not begin 1C.1 or any other work until this
correction is accepted and W3X directs next steps. Then produce the
correction delivery.

---

Revision: v1.1 (2026-08-02) added section 1a (tree/environment/case-set/
evidence/delivery-conventions leg-up facts) and concrete marker call-site
detail; no change to the open finding, directed fix, or rulings. v1.0 was the
initial brief.
