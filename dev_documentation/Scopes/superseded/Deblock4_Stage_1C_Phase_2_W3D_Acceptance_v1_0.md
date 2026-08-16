# Deblock4 - Stage 1C Phase 2 W3D Acceptance Review

Version: v1.0
Date: 2026-08-01
Reviews: Deblock4_Stage_1C_Phase_2_W3C_delivery_v1_0.zip
Against: scope v1.5; delivery addendum v1.1 (the Phase 2/3 boundary ruling).
Encoding: US-ASCII; CRLF.
Status: PHASE 2 ACCEPTED by W3D subject to W3X running the validation batch on
   the real Zig 0.16 toolchain (W3D cannot run Zig here; verification is static,
   as for Phase 1 and the 1B.3 artifacts). No code or boundary defects found.

## 1. Method and its limit

Static source review, as for Phase 1. W3D cannot run the toolchain here
(ziglang.org not in the allowlist; 0.16 is a dev build). The authoritative
compile/test/smoke pass is W3X's, via the delivered
build_1c2_phase2_validation.bat. W3D's finding is "no defects on static review",
not "observed green".

## 2. Completeness - all five Phase 2 modules present

```text
backend_tier_selection.zig          present (pure)
classic_instance_creation.zig       present
deblock4_instance_creation.zig      present
classic_callback_router.zig         present (permanent skeleton)
deblock4_callback_router.zig        present (permanent skeleton)
```
Plus additive bridge extensions and a validation-only mock-VS smoke harness.

## 3. The Phase 2/3 boundary (addendum v1.1) - VERIFIED HELD

This was the risk. It is clean:

```text
- The callback routers are on their PERMANENT path. The switch STRUCTURE
  (arInitial / arAllFramesReady / arError) is present, with a header comment
  stating Phase 3 replaces the handlers and "must not restructure this switch".
- phase2AllFramesReady is pure pass-through: it returns
  zig_vs_get_frame_filter(...) for frame n UNCHANGED. NO property writes, NO
  tier switch. Exactly the addendum v1.1 minimal-body rule.
- No Phase-3 module leaked: common_frame_mechanics, common_frame_property_
  helpers, the two per-filter property modules, deblock4_plugin,
  lifecycle_trace_debug, common_ar_error (as its own module), and build_1C_v1
  are all ABSENT. Confirmed by scan.
```

So the createVideoFilter wiring is real and permanent from Phase 2, and Phase 3
is additive into existing branches (the C5 order) rather than a rework - which
is the whole point of the ruling.

## 4. Tier selection - VERIFIED against the four ratified rules

```text
- auto        -> selected_tier = effective_tier, provenance .automatic;
- explicit <= effective -> honoured;
- explicit >  effective -> error.RequestedBackendUnavailable (by tierRank
                           comparison);
- invalid/force-down error -> preserved as a selection error.
```
Consumes cpu_capability_detection.initInstanceCapabilities (the real 1B.3
detector) exactly once. PURITY held: imports only std, common_instance, and
cpu_capability_detection - no VapourSynth. Tests present and named for all four
rules.

## 5. Creation modules - VERIFIED

```text
- C6 constant format/dimensions: zig_vsh_isConstantVideoFormat == 0 -> refuse
  with the settled message "input clip must have constant format and
  dimensions"; plus width/height/colorFamily and areValidDimensions sanity.
- P3 consumer-side completion: validatePlanes bounds indices by the clip's
  num_planes (plane >= num_planes -> PlaneIndexOutOfRange) - the exact check
  the scope deferred from the pure module to creation, now correctly here.
- Full-signature VSMap extraction with WrongType on peSuccess failures;
  settled error messages; builds THIS filter's exact instance record type
  (classic_instance_data / deblock4_instance_data).
- free releases the source-node reference and destroys the instance (manifest
  P2-11; matches the fmParallel immutable-instance model).
```

## 6. Bridge extension (C-1C-5) - VERIFIED CORRECT

The two "edited" existing files (vapoursynth_api4.h, vapoursynth_helper_bridge.c)
are PURE ADDITIONS: a Phase-2-banner block of new zig_vs_* wrapper declarations
(map extraction, video info, createVideoFilter-single-dependency, request/get
frame, free node). No existing wrapper modified; the bridge self-test remains
intact (manifest). This is "extend the zig_vsh_* bridge, never fork" done
correctly - not a first-class logic edit.

## 7. Delivery form and hygiene

```text
- All five .zig modules and the bridge deltas: CRLF-pure, US-ASCII.
- Patch is additive (five new files from /dev/null) plus the two additive
  bridge deltas; manifest reports git apply --check clean against src(40).zip +
  accepted Phase 1, whitespace=error-all clean, CR-at-EOL clean.
- Mock-VS smoke is explicitly validation-only, "not a production plugin root" -
  correctly NOT the Phase-3 deblock4_plugin. It exercises both creation
  callbacks, request/pass-through/error, and free.
```

## 8. Disposition and next step

```text
Phase 2 design/content/boundary:   ACCEPTED (static; no defects).
Compile/test/smoke green:          W3X to confirm on the real toolchain.
Proceed to Phase 3:                RECOMMENDED once W3X confirms green.
```

W3X action: run build_1c2_phase2_validation.bat. If green, accept Phase 2 and
release Phase 3 (the frame path: common_frame_mechanics, the property modules,
the tier-switch bodies, common_ar_error, lifecycle_trace_debug, deblock4_plugin
registration, the scaffolding sweep, build_1C_v1.bat, the two .vpy harnesses,
and the full proof matrix). W3X releases phases, not W3C.

## 9. One line for W3X

Phase 2 is clean on static review - five modules, the permanent-router boundary
held exactly per addendum v1.1 (pass-through only, no properties/tier), the four
tier-selection rules and C6/P3 consumer checks correct, the bridge extended not
forked; run the validation batch to confirm green, then release Phase 3.
