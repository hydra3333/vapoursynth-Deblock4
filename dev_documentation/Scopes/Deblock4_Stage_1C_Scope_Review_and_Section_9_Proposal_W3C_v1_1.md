# Deblock4 Stage 1C Scope Review and Section 9 Proposal - W3C Response

Version: v1.1
Date: 2026-07-31
Supersedes: Deblock4_Stage_1C_Scope_Review_W3C_v1_0.md
Reviewed scope: Deblock4_Scope_Stage_1C_Filter_Creation_v1_1.md
Reviewed source archive: src(38).zip
Source archive SHA-256:
b7ebc9f1ab375513fd17255dbe6c6246351974f4c416b879f957aef969a3177c
Reviewed documentation archive: dev_documentation(6).zip
Documentation archive SHA-256:
b0d137592802529613c40e4ebf6352ec7383ddab5f109689779be4a935b3d840
Status: SCOPE CORRECTIONS AND W3X DECISIONS REQUIRED BEFORE CODING
Encoding: US-ASCII only
EOL: CRLF

## 1. Correction to the W3C process interpretation

W3X was correct that the coder response was expected to contain more than a
scope-defect review.

Scope v1.1 section 9 requires one pre-coding proposal round in which W3C:

```text
- enumerates the actual tree;
- identifies all retention anchors and sweep candidates;
- extracts the settled property and parameter surfaces;
- identifies every current version-string home;
- proposes permanent module names and boundaries;
- proposes the version-identity placement;
- proposes the structural proof mechanics.
```

The prior W3C v1.0 response addressed the scope contradictions but deferred the
proposal round. That was incomplete for the intended handoff.

This v1.1 response therefore supersedes v1.0 and combines:

```text
A. the binding scope corrections required before implementation; and
B. the complete Section 9 read-only enumeration and W3C proposal.
```

Everything in Part B that names a new file, relocates a responsibility, deletes
a file, or chooses version placement is explicitly:

```text
PROPOSED - REQUIRES W3X APPROVAL
```

No transformation is authorised by this document alone.

## 2. Overall scope disposition

The Stage 1C architecture is accepted in concept:

```text
- register Classic and Deblock4 as real API4 filters;
- parse and store their full approved parameter surfaces once;
- consume the EFFECTIVE capability record once at creation;
- store immutable per-instance selection/configuration;
- operate under fmParallel;
- return pixel-identical placeholder output;
- write the settled audit frame properties;
- add the third G10 lifecycle-trace seam;
- retire the old probe scaffolding;
- retain the first-class capability detector, selftest, and pure unit tests.
```

Scope v1.1 is not yet safe as executable coding authority because several
ratified passages conflict or leave required values unsettled.

## 3. Binding corrections still required in the scope

### R1. D-2 minimal signature conflicts with amended D-7

D-2 still says both filters register a minimal:

```text
(clip, backend="auto")
```

signature.

D-7, as amended and ratified, requires the complete README-settled signature
for each filter in Stage 1C.

Required correction:

```text
D-2 must state that BOTH filters register now with their FULL approved
signatures. D-7 supersedes the earlier minimal-signature wording.
```

### R2. D-3 return-by-reference conflicts with property writes

D-3 says:

```text
BY REFERENCE
addFrameRef-equivalent
zero new frames
```

but also requires properties to be written through a writable frame obtained by
the API4 copyFrame/property-write idiom.

Those are different object-ownership paths.

Required correction:

```text
Pin the exact API4 ownership path:

arInitial requests the source frame;
arAllFramesReady obtains it;
copyFrame creates the writable output frame object;
no Deblock4 processing reads or writes plane samples;
only settled frame properties are changed;
source/output references are released or transferred on every path.
```

The intended invariant should be expressed as:

```text
pixel-pass-through; no algorithmic plane construction; zero plane writes.
```

It should not claim an addFrameRef-only return if copyFrame is mandatory.

### R3. G10 still counts only two debug seams

The scope adds lifecycle tracing as the third G10 seam but section 6 still says:

```text
Both debug seams stay Debug-only.
```

Required correction:

```text
All three debug seams stay Debug-only:
force-down, verbose detection, and lifecycle trace.
```

### R4. Section 9 omits explicit W3X approval before transformation

The binding sequence must be:

```text
1. W3C submits this enumeration and proposal.
2. W3D reviews it.
3. W3X explicitly approves or amends all proposed filenames, module
   boundaries, version placement, sweep decisions, and proof mechanics.
4. Only then may W3C create, rename, relocate, or delete files.
5. W3C prepares the Stage 1C implementation delivery.
```

W3D review alone is not authority to transform the tree.

### R5. B1 understates the new test inventory

B1 says:

```text
10/10 existing plus the new resolution tests.
```

Stage 1C also requires parameter-validation tests and version/lifecycle
integration evidence.

Required correction:

```text
all existing tests plus all approved Stage 1C resolution and
parameter-validation tests; report the observed final total.
```

### R6. "Permanent dispatch-record type" lacks a settled callable ABI

D-5 says the permanent dispatch-record type is created now and 2C/2D later
populate its per-filter function-pointer slots.

No Classic or Deblock4 processing function signature is settled for Stage 1C,
and pixel-processing function types are explicitly out of scope.

W3C must not invent an opaque or provisional backend function-pointer ABI and
call it permanent.

Recommended binding interpretation:

```text
Stage 1C creates a permanent pure BackendSelection record containing:
- requested backend;
- selected tier;
- immutable selection provenance needed by diagnostics/properties.

Per-filter callable DispatchTable types are added at 2C/2D when their scalar
oracle and backend function signatures are settled.
```

Alternative: W3D/W3X must provide the exact permanent function-pointer
signatures now.

W3C recommends the BackendSelection interpretation.

## 4. Current-tree enumeration

The attached source tree contains no .git metadata. W3X must still record the
exact accepted post-Stage-1B.3 HEAD before coding.

### 4.1 Current DLL root and retention graph

Current DLL root:

```text
src/backend_retention_anchor.zig
```

Current imported baseline modules:

```text
src/dll_probe.zig
src/backend_probe_generic.zig
src/backend_probe_scalar.zig
```

Current separately linked targeted objects:

```text
src/backend_probe_sse41.zig
src/backend_probe_avx2.zig
```

Current @extern retention anchors, both in the DLL root:

```text
deblock4_backend_probe_sse41_marker
deblock4_backend_probe_avx2_marker
```

The accepted capability detector is entered from the DLL only through
`dll_probe.zig`.

### 4.2 Current first-class modules to retain

```text
src/cpu_capability_detection.zig
src/deblock4_config.zig
src/deblock4_selftest.zig
src/force_down_debug.zig
src/print_diag_helper_functions.zig
src/print_helper_functions.zig
src/vapoursynth_api4.h
src/vapoursynth_helper_bridge.c
build.zig
build.zig.zon
tools/run_vs.cmd
third_party/vapoursynth/include/*
```

`cpu_capability_detection.zig` is consumed, not redesigned.

`deblock4_config.zig` remains the declarations-only build-option/tier/diagnostic
switchboard and must be extended, not forked.

### 4.3 Current scaffolding proposed for retirement

PROPOSED - REQUIRES W3X APPROVAL:

```text
src/backend_isolation_smoke_test.zig
src/backend_probe_avx2.zig
src/backend_probe_generic.zig
src/backend_probe_scalar.zig
src/backend_probe_sse41.zig
src/backend_retention_anchor.zig
src/build_probe.zig
src/dll_probe.zig
src/dll_smoke_test.zig
src/vapoursynth_header_probe.zig

build_1B1_v7_3.bat
build_1B2_v5_REDEVELOPED.bat
build_1B3_v5.bat
```

The historical batches and Stage 1B evidence remain in the stage record, not as
live standing build drivers.

The following unrelated local utilities are proposed to remain:

```text
000-SET_USER_PATH_PERMANENTLY.BAT
dump_mpeg2_info_01.bat
tools/run_vs.cmd
```

### 4.4 Build-graph items proposed for retirement

PROPOSED - REQUIRES W3X APPROVAL:

```text
- standalone build-probe executable and run/check steps;
- four backend probe objects and their installed inspection copies;
- probe-root DLL graph;
- DLL smoke-test executable and steps;
- backend-isolation smoke-test executable and steps;
- standalone VapourSynth header-probe executable and steps;
- unit-test artifacts whose only roots are retired probes.
```

Proposed retention:

```text
- API4 translate-C module and C helper bridge;
- production DLL build/install/check;
- first-class selftest build/run;
- first-class unit-test step;
- standalone capability-detection inspection object and its drift checks.
```

The detection inspection object is not backend-probe scaffolding; it remains a
load-bearing safety regression unless W3X explicitly retires it.

## 5. Exact README surfaces

### 5.1 Classic full signature

```text
clip                        vnode   REQUIRED
strength                    int     optional; default 25; range 0..60
boundary_strength_offset    int     optional; default 0;
                                    dynamic range -strength..60-strength
side_activity_offset        int     optional; default 0;
                                    dynamic range -strength..60-strength
planes                      int[]   optional; default all
backend                     data    optional; default "auto"
```

Accepted backend strings:

```text
auto
x86_64_v3_with_avx2
x86_64_v2_with_sse41
x86_64_v1_baseline
```

PROPOSED VapourSynth registration string - REQUIRES W3X APPROVAL:

```text
clip:vnode;strength:int:opt;boundary_strength_offset:int:opt;
side_activity_offset:int:opt;planes:int[]:opt;backend:data:opt;
```

The physical registration string would be one line with no whitespace/newline.

### 5.2 Deblock4 full signature

```text
clip                        vnode   REQUIRED
grid_mode                   data    REQUIRED; no default
strength                    int     optional; default 25; range 0..60
boundary_strength_offset    int     optional; default 0;
                                    dynamic range -strength..60-strength
side_activity_offset        int     optional; default 0;
                                    dynamic range -strength..60-strength
planes                      int[]   optional; default all
midpoint_threshold_scale    float   optional and conditional; range 0.0..1.0
backend                     data    optional; default "auto"

custom-only:
luma_step_x                 int     required with grid_mode="custom"
luma_step_y                 int     required with grid_mode="custom"
chroma_step_x               int     required with grid_mode="custom"
chroma_step_y               int     required with grid_mode="custom"
luma_midpoint_enabled       int     required with grid_mode="custom"; 0 or 1
```

Accepted grid modes:

```text
mpeg2_progressive
mpeg2_field_separated
custom
auto  (reserved token; creation must reject it)
```

PROPOSED VapourSynth registration string - REQUIRES W3X APPROVAL:

```text
clip:vnode;grid_mode:data;strength:int:opt;
boundary_strength_offset:int:opt;side_activity_offset:int:opt;
planes:int[]:opt;midpoint_threshold_scale:float:opt;
backend:data:opt;luma_step_x:int:opt;luma_step_y:int:opt;
chroma_step_x:int:opt;chroma_step_y:int:opt;
luma_midpoint_enabled:int:opt;
```

### 5.3 README gaps that block D-7 implementation

The D-7 gap rule applies. W3C found these unsettled items:

```text
GAP-P1  midpoint_threshold_scale is optional/conditional but its default is
        not settled. README states that the default remains quality tuning.

GAP-P2  custom luma/chroma step parameters have no explicit accepted numeric
        range or zero/negative-value rule.

GAP-P3  planes defaults to all, but exact validation is not settled:
        accepted indices by format, duplicate handling, ordering, empty array,
        and invalid-plane error behaviour.

GAP-P4  the complete exact creation-error message set is not pinned. README
        gives examples and required meaning, not a full stable message table.

GAP-P5  plugin configPlugin identifier is not settled.
```

W3C must stop before coding these decisions.

## 6. Settled frame-property enumeration

Classic always writes:

```text
Deblock4Filter
Deblock4Tier
Deblock4Version
```

Deblock4 always writes:

```text
Deblock4Filter
Deblock4Tier
Deblock4Version
Deblock4GridMode
Deblock4LumaStepX
Deblock4LumaStepY
Deblock4ChromaStepX
Deblock4ChromaStepY
```

Deblock4 conditionally writes:

```text
Deblock4MidpointScale
```

only when a luma midpoint class applies.

No `Deblock4Backend` property is written.

## 7. Proposed module graph

Every item in this section is:

```text
PROPOSED - REQUIRES W3X APPROVAL
```

### 7.1 Recommended new DLL root

```text
src/deblock4_plugin.zig
```

Responsibility:

```text
- VapourSynthPluginInit2;
- configPlugin;
- registration of Classic and Deblock4;
- import/wiring of the two per-filter registration modules;
- no argument parsing;
- no frame-property logic;
- no activation-reason implementation;
- no capability detection or backend resolution call in any frame path.
```

This replaces the scaffold root `backend_retention_anchor.zig`.

### 7.2 Recommended version authority

```text
src/deblock4_version.zig
```

Recommendation: a dedicated pure module rather than extending
`deblock4_config.zig`.

Rationale:

```text
- version identity is independent of generated debug build options;
- build.zig, DLL, selftest, tests, properties, and lifecycle trace can all
  consume it without importing the configuration switchboard;
- numeric components and strings have one responsibility and one home;
- deblock4_config.zig remains the declarations-only build-option/tier/diag
  switchboard established in 1B.3.
```

Proposed contents:

```text
major
minor
patch
prerelease token
optional stage marker
semantic_version_string
emitted_identity_string
packed VS major/minor version
```

PROPOSED current values - REQUIRES W3X APPROVAL:

```text
semantic version: 0.1.0-dev
stage marker:     1C
identity string:  0.1.0-dev+1C
VS packed version: major 0, minor 1
```

`build.zig.zon` necessarily contains package metadata. Proposal:

```text
deblock4_version.zig is the runtime/emission authority;
build.zig.zon remains a manifest mirror;
build_1C verifies that its semantic version equals the module value.
```

### 7.3 Pure backend selection

```text
src/backend_resolution.zig
```

Responsibility:

```text
- parse the exact production backend strings;
- call/consume the EFFECTIVE record once at creation;
- enforce explicit-request <= EFFECTIVE;
- return immutable BackendSelection;
- define settled unknown/unsupported-backend errors;
- contain no VapourSynth types.
```

Proposed permanent record:

```text
BackendSelection {
    requested_backend
    selected_tier
}
```

Later 2C/2D modules add their own callable dispatch tables after the processing
function ABI is settled.

### 7.4 Pure parameter modules

```text
src/filter_parameter_common.zig
src/classic_parameters.zig
src/deblock4_parameters.zig
```

Responsibilities:

```text
filter_parameter_common.zig
    shared strength/offset/backend/planes value types and validation helpers;

classic_parameters.zig
    ClassicParameters immutable record, defaults, validation, and tests;

deblock4_parameters.zig
    Deblock4Parameters immutable record, GridMode, resolved grid policy,
    conditional custom/midpoint validation, and tests.
```

These modules import no VapourSynth API and are usable by the DLL, selftest, and
unit tests.

### 7.5 VS-facing per-filter modules

```text
src/filter_classic.zig
src/filter_deblock4.zig
```

Responsibilities:

```text
- exact registerFunction signature;
- creation callback;
- VSMap extraction;
- call into the pure validation/resolution modules;
- construct immutable instance data;
- call createVideoFilter with fmParallel.
```

The two modules do not contain frame processing.

### 7.6 Shared VS instance and callbacks

```text
src/filter_instance.zig
src/filter_callbacks.zig
```

Responsibilities:

```text
filter_instance.zig
    VS-facing immutable instance-data declarations, source node/video info,
    instance id, filter kind, BackendSelection, and typed parameter config;

filter_callbacks.zig
    common getFrame callback and free callback; activation-reason switch;
    no detection or backend resolution.
```

### 7.7 Activation-reason modules

```text
src/filter_ar_initial.zig
src/filter_ar_all_frames_ready.zig
src/filter_ar_error.zig
```

Responsibilities:

```text
filter_ar_initial.zig
    request the source frame only;

filter_ar_all_frames_ready.zig
    obtain the requested source frame, create the writable metadata copy,
    write audit properties, and return it;
    future 2C/2D processing dispatch lands here;

filter_ar_error.zig
    bounded error-path handling and lifecycle trace.
```

These names deliberately encode the API activation reason while using normal
repository snake_case.

### 7.8 Frame-property writer

```text
src/frame_properties.zig
```

Responsibility:

```text
write only the README 13.5 properties from immutable instance data;
no plane access; no parameter resolution; no capability detection.
```

### 7.9 VS-facing shared helpers

```text
src/vapoursynth_filter_helpers.zig
```

Responsibility:

```text
shared VSMap extraction, node/video-info checks, map error setting, and
small API4 helper wrappers that are not already provided by the C bridge.
```

It must not become a miscellaneous dumping ground.

### 7.10 Lifecycle trace gated module

```text
src/lifecycle_trace_debug.zig
```

Responsibility:

```text
third G10 module; marker and lifecycle records only.
```

`deblock4_config.zig` is extended with:

```text
debug.enable_trace_lifecycle
```

The import follows the existing conditional-import namespace pattern.

## 8. Proposed dependency direction

```text
deblock4_plugin
    -> filter_classic
    -> filter_deblock4

filter_classic / filter_deblock4
    -> vapoursynth_filter_helpers
    -> filter_instance
    -> filter_callbacks
    -> classic_parameters / deblock4_parameters
    -> backend_resolution

filter_callbacks
    -> filter_ar_initial
    -> filter_ar_all_frames_ready
    -> filter_ar_error

filter_ar_all_frames_ready
    -> frame_properties

backend_resolution
    -> cpu_capability_detection
    -> deblock4_version only if version is required in its diagnostics

classic_parameters / deblock4_parameters
    -> filter_parameter_common

lifecycle_trace_debug
    -> deblock4_version
    -> print helpers
```

Forbidden dependency direction:

```text
cpu_capability_detection must not import any filter module;
pure parameter/resolution/version modules must not import VapourSynth;
frame-path modules must not import cpu_capability_detection or
backend_resolution;
first-class modules must not import retired probes.
```

## 9. Proposed plugin and public registration names

Settled:

```text
namespace: deblock4
filters:   Classic, Deblock4
plugin display name: Deblock4
```

PROPOSED identifier - REQUIRES W3X APPROVAL:

```text
com.hydra3333.deblock4
```

Proposed return declaration for both filters:

```text
clip:vnode;
```

## 10. Proposed standing batch and proof files

PROPOSED - REQUIRES W3X APPROVAL:

```text
build_1C_v1.bat

tests/stage_1c_classic_passthrough.vpy
tests/stage_1c_deblock4_passthrough.vpy
```

The two `.vpy` files use BlankClip and absolute plugin loading through the
settled portable-VapourSynth wrapper.

The batch inherits all v5 harness rules:

```text
- child-cmd self-launch;
- combined stdout/stderr master log;
- immediate exit-code capture;
- fail-closed helper calls;
- expected-negative classification;
- no findstr /X against LF tool output;
- diagnostic index;
- fresh bounded cleanup with retry;
- no final COMPLETED after an earlier FAIL.
```

## 11. Proposed S1 no-per-frame-resolution proof

### Source dependency proof

Require exact import/call scans showing:

```text
backend_resolution and cpu_capability_detection are imported only by
creation-side modules and the selftest/tests.

filter_callbacks, filter_ar_initial, filter_ar_all_frames_ready, and
filter_ar_error contain zero imports or references to:
- backend_resolution;
- cpu_capability_detection;
- detectActualOnce;
- initInstanceCapabilities;
- resolveBackendSelection;
- DEBLOCK4_FORCE_DOWN.
```

### Object/symbol proof

Build stable baseline inspection objects for:

```text
filter_callbacks
filter_ar_initial
filter_ar_all_frames_ready
filter_ar_error
```

Use `dumpbin /SYMBOLS` and disassembly to prove those objects have no reference
to the detection/resolution/environment symbols.

The creation-side resolution function may be `noinline` if W3D/W3X approve
that as a proof aid; performance is irrelevant because it runs once per
instance.

### Runtime trace proof

With lifecycle tracing enabled, creation records the selected tier once.
Per-frame trace contains no detection/resolution event.

## 12. Sweep and EOL proposal

### Delete after approved anchor removal

Use the retirement list in section 4.3.

### Convert retained LF repository files to CRLF

The attached tree contains retained LF files including:

```text
build.zig.zon
tools/run_vs.cmd
third_party/vapoursynth/include/VSConstants4.h
third_party/vapoursynth/include/VSHelper4.h
third_party/vapoursynth/include/VSScript4.h
third_party/vapoursynth/include/VapourSynth4.h
```

The remaining LF scaffold files are deleted rather than converted.

The final Stage 1C EOL gate scans the complete repository and reports zero bare
LF text files.

## 13. Required W3X decisions

W3X approval or amendment is required for:

```text
N1   every filename in section 7;
N2   dedicated deblock4_version.zig placement;
N3   proposed version/stage-marker values;
N4   plugin identifier com.hydra3333.deblock4;
N5   build_1C_v1.bat and .vpy filenames;
N6   complete retirement list;
N7   BackendSelection now / callable dispatch tables at 2C/2D;
N8   S1 proof mechanics;
N9   GAP-P1 midpoint_threshold_scale default;
N10  GAP-P2 custom-step numeric ranges;
N11  GAP-P3 planes validation;
N12  GAP-P4 exact error-message table.
```

## 14. Requested W3D response

W3D should:

```text
1. correct R1-R6 in scope v1.2 or a binding addendum;
2. review the current-tree enumeration;
3. review the proposed module graph, names, version placement, sweep, and S1
   mechanics;
4. identify any preferred amendments;
5. return the reviewed proposal to W3X for explicit approval.
```

## 15. Final disposition

```text
Stage 1C architecture:              ACCEPTED IN CONCEPT
Scope v1.1 as coding authority:     NOT YET ACCEPTED
Section 9 enumeration:              PROVIDED
Module names:                       PROPOSED; W3X APPROVAL REQUIRED
Version placement:                  DEDICATED MODULE PROPOSED;
                                    W3X APPROVAL REQUIRED
Sweep/delete list:                  PROPOSED; W3X APPROVAL REQUIRED
README D-7 gaps:                    ENUMERATED; W3X DECISIONS REQUIRED
Production coding:                  BLOCKED
```

No production code has been written from Stage 1C scope v1.1.
