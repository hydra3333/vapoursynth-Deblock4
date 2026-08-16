# Deblock4 - Stage 1C Phase 1 W3D Acceptance Review

Version: v1.0
Date: 2026-08-01
Reviews: Deblock4_Stage_1C_Phase_1_W3C_delivery_v1_0.zip
Against: scope v1.5; delivery addendum v1.0 (Phase 1).
Encoding: US-ASCII; CRLF.
Status: PHASE 1 ACCEPTED by W3D subject to W3X running the compile+test on the
   real Zig 0.16 toolchain (W3D cannot run Zig here; verification is static, as
   for the 1B.3 artifacts). No code defects found; recommend proceeding to
   Phase 2 once W3X confirms the green build.

## 1. Verification method and its limit

W3D reviewed the five delivered modules statically (source read), exactly as it
verified the 1B.3 disassembly artifacts. W3D CANNOT run the Zig toolchain in
this environment: ziglang.org is not in the network allowlist and Zig 0.16 is a
dev build. Therefore the authoritative compile+test pass is W3X's, using the
manifest's stated per-module `zig test ... -target x86_64-windows-msvc` commands
in Debug and ReleaseSafe. W3D's finding is "no defects visible on static
review", not "observed green". W3X's run is the acceptance gate.

## 2. Phase-1 completeness - all five modules present

```text
deblock4_version.zig                  present
common_instance_data_structure.zig    present
filter_call_parameters.zig            present
classic_instance_data.zig             present
deblock4_instance_data.zig            present
```

## 3. Purity (C-1C-2) - VERIFIED

No VapourSynth imports, calls, or type references in any module. The single
textual "VSMap" occurrence is a comment explaining that a type models
future-VSMap-derived data. The modules compile and test with NO VS core, which
is the whole point of the twin-testable pure layer. Clean.

## 4. Structural decisions - VERIFIED against the ratified scope

```text
C3 option B  CommonInstanceFields defined once in common_instance_data_
             structure; ClassicInstanceData and Deblock4InstanceData each
             EMBED it (common: CommonInstanceFields) plus their own parameter
             record. NO tagged union. Each per-filter record is its own exact
             type. Correct.
C4           instance_id is a plain immutable u64 field; the process-wide
             monotonic counter (next_instance_id) is separate, incremented via
             allocateInstanceId() using @atomicRmw(u64, ptr, .Add, 1,
             .monotonic) - correct fetch-add, no mutex, returns pre-increment
             value. A comment states the stored id "is an ordinary u64, not an
             atomic field". Exactly the C4 wording.
Version      semantic_version "0.1.0-dev"; stage_marker "1C"; identity_string
             computed as semantic ++ "+" ++ marker = "0.1.0-dev+1C";
             vs_packed_version an i32 = (major<<16)|minor. C8's string-vs-
             numeric distinction is built in. The header comments that
             build.zig.zon remains the permitted manifest mirror (C9), verified
             later by the whole-plugin proof.
Backend types  BackendRequest/BackendTier/BackendSelection TYPES live in the
             common module (so parameters and instance records share them);
             filter_call_parameters re-exports BackendRequest for one-import
             convenience. The VALUE-producing logic correctly does NOT appear
             here - it is Phase 2's backend_tier_selection. Type-here,
             value-later is the right seam.
Dependency   filter_call_parameters -> common (one-way; no cycle: common
             imports only std). Matches the scope dependency direction.
```

## 5. Parameter validation - VERIFIED against P1/P2/P3

```text
P1  midpoint_threshold_scale is ?f64 (nullable, no default), with a .missing
    sentinel and a MidpointScaleNotApplicable error for the conditional case.
    No default baked in; deferred to 2D. Correct.
P2  custom steps rejected below 1 (if (actual < 1 or actual > maxInt(u32))).
    The clip-dimension upper bound is correctly NOT here (it is consumer-side
    at creation, Phase 2, where the clip exists). Correct.
P3  planes: EmptyPlanes, DuplicatePlaneIndex, NegativePlaneIndex errors;
    canonical ascending sort for order-independence (with an explaining
    comment); the clip-format upper-bound check correctly deferred to the
    consumer. All four ratified rules present.
```

## 6. Tests - coverage matches the addendum's Phase-1 list

```text
Classic valid call applies settled defaults
strength and independent offsets reject out-of-range values
wrong parameter types are rejected in the pure layer
plane arrays reject empty and duplicate and ignore order
Deblock4 custom steps reject values below one
backend tokens are recognised exactly
midpoint scale has no default and is conditional
+ version representations remain internally consistent
```

This is the exact set the addendum specified (valid/defaults, out-of-range,
wrong-type, plane rules, step<1, backend-token, midpoint-conditional, version
consistency). W3X's run should show all of them passing in Debug and
ReleaseSafe.

## 7. Hygiene

All five files CRLF-pure and US-ASCII. Full files delivered (full_files/src/).
Manifest present with per-module test commands.

## 8. Disposition and next step

```text
Phase 1 design/content:    ACCEPTED (static review; no defects).
Compile+test green:        W3X to confirm on the real toolchain.
Proceed to Phase 2:        RECOMMENDED once W3X confirms the green build.
```

W3X action: run the manifest's `zig test` commands (Debug + ReleaseSafe) on the
prevailing branch-main source with these five modules added. If green, accept
Phase 1 and release Phase 2 (backend_tier_selection + the two
instance_creation modules + the constant-format refusal) per the addendum. If
any test fails, report the failure - it will be a real code defect this time
(not a harness artifact), since these are direct `zig test` runs with no batch
harness in the loop.

## 9. One line for W3X

Phase 1 is clean on static review - five pure modules, no VS, C3-optionB/C4/
version/P1/P2/P3 all correctly implemented, tests match the plan; run the
`zig test` commands to confirm green, then release Phase 2.
