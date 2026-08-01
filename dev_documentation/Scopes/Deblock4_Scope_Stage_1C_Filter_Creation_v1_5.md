# Deblock4 - Scope: Stage 1C - Filter Creation

**Version:** 1.5
**Date:** 2026-08-01
**Author:** W3D
**Status:** RATIFIED AND BINDING. All decisions (D-1..D-7 as amended), all
coder findings (R1-R6 and architecture-review C1-C9), all module names, and
all README gaps (P1-P5) are settled by W3X. This document supersedes scope
v1.2 and resolves the W3C architecture review v1.0; the coder builds against
THIS version. No source transformation from any earlier version. v1.4 is
a document-only correction of v1.3 (header date; exact .vpy names pinned).
**Against:** charter v1.19; README_Deblock4_Design_Spec_v1_9.md (the
CONTROLLING README - the v1.2 pin in scope v1.2 referenced a superseded copy
and is corrected here, C1); Project Status v1_14; Forward Roadmap v1_12; W3C
proposal v1_1; W3D review v1.1; W3C architecture review v1.0.
**Starting point:** the PREVAILING source on branch main (the accepted Stage
1B.3 state). Per W3X's standing preference, the anchor is the prevailing
source itself, NOT a pinned commit id: W3X does not track HEAD SHAs (branch
main also receives unrelated document/test-material commits over time, so a
SHA would drift without any code change). If the coder is UNSURE whether it
holds the current source, it ASKS W3X to upload the source rather than
inferring or transcribing a commit id. GitHub project: hydra3333/vapoursynth-
Deblock4.
**Encoding/EOL:** US-ASCII; CRLF for all repository files (charter v1.19
C-DELIV-06). This stage retires the remaining LF scaffolding holdouts.

---

# 1. Objective

Turn the proven Stage 1B.3 infrastructure into a loadable VapourSynth plugin:
register the plugin and both filters, create filter instances that freeze their
full validated configuration and selected tier at creation, return frames
(pass-through placeholder), write the settled frame properties, and retire the
scaffolding under C-STY-10's sweep test.

NO pixel arithmetic, NO deblocking, NO algorithmic plane construction. G5
continues to govern: gated (v2/v3) code is not executed; each filter's real
processing arrives only with its 2C/2D scalar oracle.

# 2. External naming (settled)

```text
namespace   : deblock4            (configPlugin)
identifier  : com.hydra3333.deblock4   (configPlugin; reverse-DNS, matches
                                        the HolyWu com.<author>.<name> shape)
functions   : Classic, Deblock4   (registerFunction, one per filter)
user calls  : core.deblock4.Classic(...)  and  core.deblock4.Deblock4(...)
```

Internal filenames (classic_*, deblock4_*, common_*) are decoupled from the
external names; the ONLY place they meet is deblock4_plugin.zig, where
registerFunction wires "Classic" to classic_instance_creation.create and
"Deblock4" to deblock4_instance_creation.create.

REQUIRED CODE COMMENT in deblock4_plugin.zig: the function name "Deblock4" and
the namespace "deblock4" differ only by capitalisation; this is deliberate and
legal (core.deblock4.Deblock4). The comment exists so nobody "fixes" it.

# 3. Dispatch architecture (settled; supersedes the v1.1 D-5 sketch)

RATIFIED MODEL - separation IS the dispatch:

```text
1. Each filter registers ITS OWN getFrame/free callbacks (via its own
   instance-creation module). A Classic instance therefore inherently runs
   Classic code; there is NO filter_kind branch anywhere in the frame path.
2. filter_kind remains a field of the instance record for DIAGNOSTICS and
   frame-property writing ONLY. It is never consulted for routing.
3. The only dispatcher in the plugin is the TIER switch inside each filter's
   own ar_all_frames_ready, reading the immutable BackendSelection frozen at
   creation. In 1C every tier branch calls the shared pass-through placeholder
   (real classic_vN / deblock4_vN backends arrive at 2C/2D under G5).
4. Per-frame code NEVER calls detection, tier selection, or the environment.
   The selection is made once at creation and stored (S1 proof, section 11).
```

THE NAMING/OWNERSHIP RULE (binding, stated so it cannot be quietly re-merged):

```text
classic_* / deblock4_*  = per-filter modules. A handler whose CONTENT is
                          defined by the algorithm (which frames to request,
                          what processing to run) is per-filter EVEN IF the 1C
                          bodies are near-identical. Near-identical now is
                          accepted deliberately: it buys easy later divergence
                          (e.g. a temporal frame window for Deblock4) and
                          reduces cognitive load following one filter's path.
                          The coder must NOT merge classic_ar_initial and
                          deblock4_ar_initial "because they are the same".
common_*                = filter-neutral modules. VS-mechanical steps and the
                          shared error path. A common_* module must serve both
                          filters WITHOUT caller-distinguishing parameters or
                          per-filter branches; if such a parameter becomes
                          necessary, the module is not common - split it.
```

# 4. Module map (settled names; N1 ratified)

```text
== Plugin root (once, at DLL load) ==
src/deblock4_plugin.zig
    VapourSynthPluginInit2; configPlugin (identifier, namespace, version from
    deblock4_version); registerFunction for Classic and Deblock4; the
    capitalisation comment (section 2). Thin: no parsing, no frame logic.

== Per-filter: creation (once per instance) ==
src/classic_instance_creation.zig
src/deblock4_instance_creation.zig
    Full-signature VSMap extraction; calls filter_call_parameters (validate)
    and backend_tier_selection (tier); clip-dependent checks: CONSTANT
    format/dimensions REQUIRED (refuse variable clips with the settled
    message, per README v1_9 section 11.3 - C6), planes upper bound for the
    clip's format, P2 step bounds vs the relevant plane dimensions; builds
    THIS filter's immutable instance record (classic_instance_data /
    deblock4_instance_data); createVideoFilter(fmParallel) with THIS
    filter's router callbacks; settled error messages on refusal.

== Per-filter: callback routing (per frame) ==
src/classic_callback_router.zig
src/deblock4_callback_router.zig
    This filter's getFrame and free bodies; the activation-reason switch
    routing to this filter's ar_* handlers (arError -> common_ar_error).

== Per-filter: activation-reason handlers ==
src/classic_ar_initial.zig
src/deblock4_ar_initial.zig
    Which frames this filter requests. In 1C: frame n only, via the shared
    request mechanism in common_frame_mechanics. Separate by design.
src/classic_ar_all_frames_ready.zig
src/deblock4_ar_all_frames_ready.zig
    This filter's per-frame work, in the BINDING order (C5, preserving the
    2C/2D backend seam):
        1. obtain the requested source frame (common_frame_mechanics);
        2. TIER switch over the frozen BackendSelection calls the branch
           target and yields the final writable output frame (in 1C every
           branch calls the shared pass-through placeholder, which produces
           the writable copy);
        3. THIS filter's property module annotates that final frame
           (classic_frame_properties / deblock4_frame_properties);
        4. return the final frame.
    At 2C/2D only the branch targets change; the property/return tail is
    stable regardless of whether a backend modifies a copy or constructs a
    different output.

== Shared, filter-neutral ==
src/common_instance_data_structure.zig
    Defines CommonInstanceFields ONLY (C3 option B): source node + video
    info, immutable instance_id allocated from the process-wide monotonic
    atomic counter at creation (C4), filter_kind (diagnostics/properties
    only), BackendSelection. May carry init/deinit lifecycle helpers for the
    common fields (node release stays single-homed with the node holder).
    No parameter records here.

== Per-filter instance records (C3 option B) ==
src/classic_instance_data.zig
    ClassicInstanceData = CommonInstanceFields + ClassicParameters.
src/deblock4_instance_data.zig
    Deblock4InstanceData = CommonInstanceFields + Deblock4Parameters.
    Each callback router and ar_* handler receives ITS OWN exact instance
    type; no tagged union, no kind-dependent access in frame code. Immutable
    after creation; each instance gets its own copy.
src/common_ar_error.zig
    Shared bounded error-path handler (intrinsically filter-neutral).
src/common_frame_mechanics.zig
    VS-mechanical helpers both filters call: request-source-frame,
    obtain-frame, writable-copy-for-properties, release/transfer idioms.
    Parameter-clean (no caller-distinguishing arguments) per section 3.
src/common_frame_property_helpers.zig
    Filter-NEUTRAL mechanical property-set helpers only (set-data/set-int/
    set-float idioms via the bridge). No property names, no filter branches.

== Per-filter property policy (C2) ==
src/classic_frame_properties.zig
    Classic's property policy and values (section 7 Classic set).
src/deblock4_frame_properties.zig
    Deblock4's property policy: the common set plus the grid properties and
    the conditional midpoint property (section 7 Deblock4 set).

== Pure (no VapourSynth; DLL + selftest + unit-test reachable) ==
src/backend_tier_selection.zig
    The startup tier choice (runs at creation only): resolves the backend
    argument against the EFFECTIVE record - auto -> highest effective tier;
    explicit <= effective -> honoured; explicit > effective -> refuse;
    unknown string -> refuse. Produces the immutable BackendSelection record
    (requested_backend, selected_tier, provenance for properties/trace).
    Consumes cpu_capability_detection; never re-runs per frame. NOTE: this
    is deliberately NOT named "resolution" (overloaded in video context) and
    is a startup task, not a dispatcher.
src/filter_call_parameters.zig
    ONE sectioned pure module (COMMON / CLASSIC / DEBLOCK4 sections): every
    call parameter's type, default, range, and SELF-CONTAINED validation
    (checks a parameter can answer about itself). Extracted `backend` string
    is syntax-checked here, then handed to backend_tier_selection by the
    creation module. Clip-dependent checks (planes upper bound) are
    consumer-side in the instance-creation modules. ClassicParameters and
    Deblock4Parameters immutable records + tests.

== Shared identity and debug seam ==
src/deblock4_version.zig
    Single-homed version identity (N3 ratified): semantic "0.1.0-dev",
    stage marker "1C", identity "0.1.0-dev+1C", VS packed version 0.1.
    Consumed by: configPlugin, the always-on summary line, the selftest
    banner, lifecycle trace, and the Deblock4Version frame property. The
    coder collapses any existing duplicate version strings to this home,
    EXCEPT build.zig.zon, which remains as the explicitly permitted manifest
    mirror verified by gate V1(c) (C9).
src/lifecycle_trace_debug.zig
    The THIRD G10 seam, build option enable_trace_lifecycle (Debug-only
    hard-reject in release; three-surface proven absence; loud marker
    string). One physical line per event, instance-numbered and
    frame-numbered: plugin init; creation enter/exit (exit dumps the full
    resolved instance config on one line); getFrame enter/exit per reason;
    free. Wired via the C-1C-6 conditional-import pattern.

== Retained first-class (unchanged) ==
src/cpu_capability_detection.zig     (settled; consumed, never modified)
src/deblock4_config.zig              (extended per C-STY-09 as needed)
src/deblock4_selftest.zig            (gains a 1C section: pure tier-selection
                                      and parameter-validation exercises)
src/force_down_debug.zig
src/print_helper_functions.zig
src/print_diag_helper_functions.zig
src/vapoursynth_api4.h
src/vapoursynth_helper_bridge.c      (the zig_vsh_* bridge; EXTEND for any
                                      new API calls, never fork)
```

Dependency direction (binding; the structural half of S1):

```text
instance-creation  -> filter_call_parameters, backend_tier_selection,
                      common_instance_data_structure, deblock4_version
callback-routers   -> their own ar_* handlers, common_ar_error
ar_* handlers      -> common_frame_mechanics, their own instance-data type,
                      and their own property module (which uses
                      common_frame_property_helpers)
FORBIDDEN: any callback-router or ar_* module importing
           backend_tier_selection or cpu_capability_detection;
           any pure module importing VapourSynth;
           cpu_capability_detection importing any filter module.
```

# 5. Decisions of record (all RATIFIED)

```text
D-1  Stage designation 1C.
D-2  BOTH filters registered now, each with its FULL settled signature.
D-3  Pass-through placeholder: pixel pass-through with zero algorithmic
     plane construction. The placeholder is the 1C tier-branch target (C5):
     it produces the final writable output frame via the standard API4
     copyFrame idiom (metadata-level; plane data untouched and
     bit-identical -> gate E1 checksum equality holds); the per-filter
     property module then annotates that frame. References released/
     transferred on every path including errors.
D-4  Frame-property writes now (section 7), including Deblock4Version.
D-5  Superseded by the section 3 dispatch architecture: per-filter
     registration IS the filter dispatch; tier selection frozen at creation
     into BackendSelection; the only runtime dispatcher is each filter's
     tier switch; callable per-filter backend tables arrive at 2C/2D (R6).
D-6  Sweep Option A (section 8), verified against the real tree.
D-7  FULL parameter signatures up-front (AMENDED): parse, type/range/
     default-validate, and store every parameter at creation into the
     immutable record. Semantic validation waits for the 2C/2D oracles.
     Gap rule executed: P1-P5 settled below.
```

# 6. README gap resolutions (P1-P5, RATIFIED)

```text
P1  midpoint_threshold_scale: registered OPTIONAL with NO default in 1C.
    Absent means "not set"; the empirical default is settled at 2D where the
    oracle can justify it. Range when present: 0.0..1.0 per README.
P2  Custom luma/chroma steps (luma_step_x/y, chroma_step_x/y): integers,
    REQUIRE >= 1 (zero/negative refused). Upper bound: the RELEVANT PLANE
    DIMENSION at creation (settled - C6). This is well-defined because 1C
    REQUIRES constant-format/constant-dimension clips (README v1_9 s11.3
    "validate constant format"): variable clips are refused at creation
    with the settled message. The former fallback-constant path is DELETED;
    there is no unratified implementation authority.
P3  planes: int[] of plane INDICES per VapourSynth convention (0=Y, 1=U,
    2=V for YUV; letters are NOT accepted - ecosystem-standard indices;
    the mapping is documented in help/error text). Rules: reject
    out-of-range for the clip's format (consumer-side check in instance
    creation, per the self-contained rule); reject duplicates; reject empty
    array; order-independent (treated as a set). Never silently clamped or
    deduped (README line 601 principle).
P4  Exact creation-error message table: drafted by the coder as part of the
    delivery from the README's required meanings; W3D reviews; W3X ratifies
    at delivery review. Not a coding blocker.
P5  Plugin identifier com.hydra3333.deblock4 (section 2).
```

# 7. Frame properties (D-4; complete enumeration per README v1_9 s13.5 - C7)

COMMON set (both filters, every returned frame):

```text
Deblock4Filter   : data  = "Classic" | "Deblock4"
Deblock4Tier     : data  = "x86_64_v3_with_avx2" | "x86_64_v2_with_sse41"
                         | "x86_64_v1_baseline"   (the frozen selected tier)
Deblock4Version  : data  = the deblock4_version identity string
                           ("0.1.0-dev+1C")
```

DEBLOCK4-ONLY additions (every Deblock4 frame):

```text
Deblock4GridMode      : data   the RESOLVED mode (e.g. "mpeg2_field_separated")
Deblock4LumaStepX     : int
Deblock4LumaStepY     : int
Deblock4ChromaStepX   : int
Deblock4ChromaStepY   : int
Deblock4MidpointScale : float  PRESENT only when a luma midpoint class
                               applies; ABSENT otherwise (both directions
                               proven, gate E2)
```

The property names are SETTLED by README v1_9 section 13.5; no additions or
renames without W3X. Classic writes the common set only; Deblock4 writes the
common set plus its additions, via the per-filter property modules (C2).

# 8. Scaffolding sweep (D-6, Option A; list verified against the real tree)

```text
RETIRE (zero first-class importers, W3D-verified):
    src/backend_isolation_smoke_test.zig
    src/backend_probe_avx2.zig
    src/backend_probe_generic.zig
    src/backend_probe_scalar.zig
    src/backend_probe_sse41.zig
    src/backend_retention_anchor.zig   (the OLD DLL root; replaced by
                                        deblock4_plugin.zig - this IS the
                                        anchor relocation)
    src/build_probe.zig
    src/dll_probe.zig
    src/dll_smoke_test.zig
    src/vapoursynth_header_probe.zig
    build_1B1_v7_3.bat, build_1B2_v5_REDEVELOPED.bat, build_1B3_v5.bat
        (superseded standing batches; archived in the stage record, replaced
        by build_1C_v1.bat)
    probe-only build.zig steps; all remaining LF-holdout scaffolding files.

RETAIN:
    the detection INSPECTION object build target and its drift checks (the
    G3/7.4 safety regression; provably independent of the probes);
    deblock4_selftest (first-class, extended with the 1C section);
    all first-class modules listed in section 4;
    committed inspection evidence sets (stage records, not live code).

POST-SWEEP OBLIGATIONS: G10 three-surface absence and the export-table gate
re-proven on the new binary (gates G1/G2); repo-wide reference scan proves
zero first-class references to retired files (gate S2); repo ends the stage
with ZERO LF text files (gate S3).
```

# 9. Settled conventions (C-1C-1..8, binding; carried from v1.1)

```text
C-1C-1  fmParallel from the start. Immutable instance data; concurrent
        getFrame across frames AND instances; instance ids via a monotonic
        atomic counter at creation (@atomicRmw .Add, no mutex); frame
        numbers are the getFrame n argument.
C-1C-2  DLL + selftest twin. The selftest never links VapourSynth; pure
        modules (backend_tier_selection, filter_call_parameters,
        deblock4_version, config) are DLL-, selftest-, and unit-test-
        reachable; VS-facing modules are DLL-only.
C-1C-3  Thin root; purpose-grouped single-homed modules per the section 4
        map; declaration-only shared-definition modules extend the settled
        deblock4_config switchboard (extend, never fork).
C-1C-4  Explicit compilation tiers: every module in section 4 compiles in
        the baseline v1 object set (G2); only nominated backend objects
        compile at v2/v3 (none exist in 1C).
C-1C-5  All VS API access via the zig_vsh_* bridge; extend, never fork or
        re-derive raw @cImport alternatives.
C-1C-6  G10 three-layer gating for all debug code: source-visible
        conditional import (the import IS the namespace), dedicated debug
        modules, three-surface proven absence. Printing split maintained:
        print_helper_functions always-on vs print_diag_helper_functions
        gated; flush-per-line; one physical line per record.
C-1C-7  Single-homed version identity (deblock4_version, section 4);
        every emission consumes it; duplicates collapsed.
C-1C-8  enable_trace_lifecycle third G10 seam (section 4).
```

# 10. Out of scope (hard exclusions)

```text
- Any pixel-producing, algorithmic plane-construction, or deblocking code.
- Execution of gated v2/v3 code (G5). Address-taking remains permitted.
- Real classic_vN / deblock4_vN backends and callable dispatch tables
  (2C/2D).
- Any change to the detection contract, Set-A/Set-B, the comptime
  cross-check, or the two existing G10 seams (settled and chartered).
- Per-frame mutable instance state (fmParallel; immutable after creation).
- Semantic parameter validation (2C/2D oracle territory).
```

# 11. Proof matrix (build_1C_v1.bat gates)

Modes: Debug, ReleaseSafe, ReleaseFast unless stated. The batch inherits the
1B.3 harness rules: exit-code gating primary; positive present-checks over
absent-scans; no findstr /X or fragile multi-word absent-scans against
captured (LF) tool output; whitespace/multi-line-tolerant source scans;
combined stdout+stderr capture with a diagnostic index; child-cmd
self-launch; fresh temp files.

```text
B1  Build green, all modes; ALL tests green, all modes (existing suite plus
    the new tier-selection and parameter-validation tests; report the
    observed totals, do not pin counts in advance).
B2  Selftest green all modes, including the new 1C section (pure tier
    selection: auto/explicit-ok/explicit-too-high/invalid; parameter
    validation: per-filter valid/invalid cases incl. P2/P3 rules).
G1  G10 three-surface absence post-sweep for ALL THREE gated markers
    (force-down, verbose-detection, trace-lifecycle) on DLL + selftest in
    both release modes; Debug positive controls present for all three.
G2  Export table: VapourSynthPluginInit2 PRESENT; every probe export
    ABSENT; no gated symbol present (dumpbin gate, updated expectations).
E1  vspipe e2e per filter: BlankClip -> filter(backend="auto") -> completes;
    output checksum EQUALS input checksum (D-3 bit-identity).
E2  Frame properties per filter, against the FULL section 7 enumeration:
    common set correct on both filters (Deblock4Filter, Deblock4Tier =
    host's expected effective tier, Deblock4Version = identity string);
    Deblock4 additionally: Deblock4GridMode equals the resolved mode and
    the four step properties equal the resolved grid values; the
    conditional Deblock4MidpointScale is PRESENT with the set value when a
    luma midpoint class applies and ABSENT when it does not (both
    directions exercised).
E3  Debug force-down e2e: DEBLOCK4_FORCE_DOWN=v1 -> Deblock4Tier
    x86_64_v1_baseline; =v2 -> x86_64_v2_with_sse41; invalid -> creation
    refused with the settled message. Proves EFFECTIVE consumption with
    zero filter-side special code.
E4  Explicit backend per filter: ="x86_64_v2_with_sse41" honoured (property
    reports it); above-effective refused; unknown string refused.
E5  Full-signature validation e2e per filter: one valid full-parameter
    invocation creates; out-of-range, wrong-type, duplicate-plane,
    empty-planes, (Deblock4) step<1, and (Deblock4) step>plane-dimension
    invocations each refuse with the settled message; a variable-format
    clip is refused at creation with the settled message (C6).
E6  Lifecycle trace (Debug, enable_trace_lifecycle=on): captured e2e output
    contains creation enter/exit (with the one-line config dump), getFrame
    enter/exit with instance id + frame n, free, and the version identity
    in the trace banner.
V1  Version single-home, per representation (C8/C9), all scripted:
    (a) NUMERIC: the configPlugin-registered packed version equals
        deblock4_version.vs_packed_version;
    (b) STRING: the always-on summary line, the selftest banner, the
        lifecycle-trace banner, and the Deblock4Version property all equal
        deblock4_version.identity_string;
    (c) MANIFEST: build.zig.zon's .version equals deblock4_version's
        semantic version ("0.1.0-dev"). build.zig.zon is the one PERMITTED
        manifest mirror of the version identity (a .zon manifest cannot
        consume a runtime module); this gate keeps it honest.
S1  No-per-frame-selection proof, three parts:
    (a) STRUCTURAL: the section 4 forbidden-import list holds (whitespace/
        multi-line-tolerant source scan);
    (b) SYMBOL: dumpbin /SYMBOLS + disasm of the router and ar_* objects
        show zero references to backend_tier_selection,
        cpu_capability_detection, or DEBLOCK4_FORCE_DOWN symbols
        (optional noinline on the selection function permitted as a proof
        aid);
    (c) RUNTIME: the E6 trace shows selection logged exactly once per
        instance (at creation), never in frame events.
S2  Sweep test: repo-wide reference scan finds ZERO references to retired
    files from first-class code; build + all tests green post-deletion.
S3  EOL: repo-wide check reports ZERO LF text files.
N1  Negative controls: -Dcpu/-Dtarget rejected; release build-reject of all
    THREE G10 options panics across the three release modes (9/9).
```

# 12. Deliverables

```text
12.1  All new modules per the section 4 map, exact names as listed.
12.2  build.zig: probe steps removed; DLL/selftest/test/inspection steps
      per section 8; every object's target stated explicitly (C-1C-4).
12.3  Deleted scaffolding per section 8.
12.4  build_1C_v1.bat implementing section 11 (N5 ratified name).
12.5  Two minimal .vpy harness scripts (BlankClip-based, one per filter),
      with these EXACT pinned names (W3X-approved 2026-08-01):
          tests/stage_1c_classic_passthrough.vpy
          tests/stage_1c_deblock4_passthrough.vpy
12.6  Unit tests per B1/B2.
12.7  The creation-error message table draft (P4) for delivery review.
12.8  Delivery per C-DELIV: CRLF, full files, dual-form rules as chartered.
```

# 13. Sequencing

```text
1. W3X confirms the coder is working from the prevailing branch-main source
   (uploading it if the coder is unsure); no commit id is recorded or
   required.
2. Coder builds against THIS scope (v1.4; the C1-C9 review is resolved and
   no earlier version is coding authority). Any conflict between this
   scope and the tree as found: state it and stop (I5); no silent
   adaptation. Module names are FINAL as listed, including the C2/C3
   additions (W3X-approved 2026-08-01); any proposed deviation requires
   W3X approval BEFORE transformation.
3. Delivery; W3D delivery review; W3X runs build_1C_v1.bat; artifact
   review (W3D independent verification of raw artifacts + coder
   concurrence); fix cycles distinguishing harness defects from code
   defects per the 1B.3 discipline; P4 message table ratified.
4. W3X commits. Stage complete. Next: Stage 2C (Classic scalar oracle).
```

# 14. Acceptance

The stage is accepted when the full section 11 matrix passes on the W3X
host, W3D has independently verified the raw artifacts (export table,
absence scans, e2e outputs and properties, trace capture, sweep scan, S1
symbol evidence), the coder concurs, the P4 table is ratified, and W3X has
committed. The commit message records the retired-file list and
build_1C_v1.bat as the new standing regression.

---

*Revision history*
```text
v1.5 (2026-08-01) Corrected the starting-point discipline to match W3X's
     standing preference (stated earlier this design round): the anchor is the
     PREVAILING branch-main source verified by upload when unsure, NOT a
     pinned HEAD SHA (main receives unrelated doc/test commits, so a SHA would
     drift without code change). Removed the "record the exact HEAD SHA"
     requirement from the header and sequencing. No design change. Supersedes
     v1.4.
v1.4 (2026-08-01) Document-only corrections (no design change): header date
     07-31 -> 08-01 to match the C1-C9 resolution and W3X approval; the
     section 13 sequencing self-reference corrected v1.3 -> v1.4 (copy
     residue from the v1.3 body); the two
     .vpy harness filenames pinned exactly in deliverable 12.5
     (tests/stage_1c_classic_passthrough.vpy and
     tests/stage_1c_deblock4_passthrough.vpy) for self-containment, since
     the N5 round approved "the two .vpy names" without fixing the exact
     strings. Supersedes v1.3.
v1.3 (2026-08-01) Resolves W3C architecture review C1-C9 (all ratified by
     W3X): C1 controlling README pin corrected to
     README_Deblock4_Design_Spec_v1_9.md (v1.2 had pinned a superseded
     copy; parameter surfaces re-verified identical, property list newly
     settled); C2 property writing split into common_frame_property_helpers
     + classic_frame_properties + deblock4_frame_properties (the single
     common writer violated the parameter-clean rule); C3 instance record
     option B - CommonInstanceFields + classic_instance_data +
     deblock4_instance_data, exact types per router, no tagged union; C4
     immutable instance_id from the atomic allocator (wording); C5 binding
     ar_all_frames_ready order (obtain -> tier switch yields output ->
     property annotate -> return) preserving the 2C/2D seam; C6 constant
     format/dimensions REQUIRED at creation per README v1_9 s11.3, P2
     bound = plane dimension, fallback constant deleted; C7 full property
     enumeration from README s13.5 with E2 extended incl. MidpointScale
     presence/absence; C8 V1 split per representation; C9 build.zig.zon as
     the permitted manifest mirror with gate V1(c). Supersedes v1.2.
v1.2 (2026-07-31) Full regeneration incorporating: the ratified dispatch
     architecture (per-filter registration is the dispatch; no filter_kind
     routing; tier switch per filter; BackendSelection frozen at creation -
     R6); the settled module map and naming/ownership rule (classic_/
     deblock4_/common_ with the do-not-merge and parameter-clean rules);
     external-vs-internal naming with the capitalisation comment; R1-R6
     corrections (full signatures in D-2; copyFrame idiom in D-3; three
     seams in G-gates; W3X-approval-before-transformation; observed test
     totals; data-record-now/callable-tables-later); gap resolutions P1-P5
     including integer plane indices and the four planes rules; N1-N8
     ratified values (version identity 0.1.0-dev+1C, identifier
     com.hydra3333.deblock4, build_1C_v1.bat); S1 restated as structural +
     symbol + runtime; sweep list locked as W3D-verified. Supersedes v1.1.
v1.1 (2026-07-31) Ratifications incorporated; conventions C-1C-1..8 added;
     proof matrix extended (three markers, E5/E6/V1, 9/9).
v1.0 (2026-07-31) Initial draft for W3X ratification.
```
