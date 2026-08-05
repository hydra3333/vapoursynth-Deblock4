# Deblock4 - Stage 1C.1 Rider Scope Review by W3C

**Version:** 1.0  
**Date:** 2026-08-02  
**Author:** W3C (coder)  
**Route:** W3C -> W3X -> W3D  
**Reviewed scope:** `Deblock4_Scope_Stage_1C1_Rider_Using_Echo_v1_0.md`  
**Review base:** Stage 1C accepted, committed, and pushed; Phase 3b v1.13 source correction applied  
**Status:** PRE-IMPLEMENTATION SCOPE REVIEW. No Stage 1C.1 code or delivery has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Overall assessment

The rider's objective is sound and fits the completed Stage 1C architecture:

```text
- parse and validate once at creation;
- retain immutable per-instance state;
- emit one always-on resolved-invocation line;
- attach the identical resolved-invocation text to every output frame;
- extend and re-run the existing fifteen-gate matrix;
- make no pixel, backend, dispatch, registration, or G10 change.
```

A bounded implementation is feasible without changing callback-router structure
or adding per-frame formatting. The safest implementation shape is to build one
bounded immutable text value at creation, store it by value in the instance,
emit stderr from that stored value, and write `Deblock4Using` from the same
stored bytes on every output frame.

I have not started that implementation because scope v1.0 contains exact-format
and proof-boundary ambiguities. They affect observable output and acceptance, so
charter I3 requires W3C to state them and stop rather than choose.

# 2. Source mapping completed

The review was performed against the completed Stage 1C source, including the
accepted v1.13 G6 correction.

Relevant current source surfaces are:

```text
src/deblock4_plugin.zig
    public registration strings and their actual parameter order

src/filter_call_parameters.zig
    post-coercion/post-defaulting validated parameter records

src/classic_instance_creation.zig
src/deblock4_instance_creation.zig
    creation ordering, selection, allocation and immutable instance assembly

src/common_instance_data_structure.zig
src/classic_instance_data.zig
src/deblock4_instance_data.zig
    immutable per-instance storage

src/print_helper_functions.zig
src/cpu_capability_detection.zig
src/backend_tier_selection.zig
    existing always-on version/backend/tier summary and its emission point

src/classic_frame_properties.zig
src/deblock4_frame_properties.zig
src/common_frame_property_helpers.zig
    accepted frame-property plumbing

tests/stage_1c_classic_passthrough.vpy
tests/stage_1c_deblock4_passthrough.vpy
build_1C_v1.bat
    existing E-series cases, captured stderr and exact-count helpers
```

# 3. STOP finding S1 - exact member set and order conflict

Scope section 2.1 R3 says:

```text
every registered public parameter of the filter, in registration order,
plus backend
```

The displayed examples do not follow the actual registration order and do not
contain every registered Deblock4 parameter.

## 3.1 Classic

Current registration order after the omitted `clip` argument is:

```text
strength
boundary_strength_offset
side_activity_offset
planes
backend
```

The scope example is:

```text
strength
planes
boundary_strength_offset
side_activity_offset
backend
```

Also, `backend` is already a registered public parameter, so the phrase
"every registered public parameter ... plus backend" is redundant unless a
different rule is intended.

## 3.2 Deblock4

Current registration order after `clip` is:

```text
grid_mode
strength
boundary_strength_offset
side_activity_offset
planes
midpoint_threshold_scale
backend
luma_step_x
luma_step_y
chroma_step_x
chroma_step_y
luma_midpoint_enabled
```

The scope example instead contains:

```text
strength
planes
boundary_strength_offset
side_activity_offset
backend
grid_mode
luma_step
chroma_step
midpoint_threshold_scale
```

It omits the registered custom-grid members and replaces the four step members
with two resolved compound fields.

The distinction matters. For example, a custom grid with
`luma_midpoint_enabled=0` and one with `luma_midpoint_enabled=1` but no supplied
scale can both produce `midpoint_threshold_scale=absent`. Without a midpoint
applicability/enabled field, the displayed example is not sufficient to
distinguish those resolved behaviours.

## 3.3 Required W3D clarification

Please provide one exact canonical schema for each filter, including:

```text
- exact member names;
- exact member order;
- whether raw conditional public parameters are present as `absent`;
- whether resolved compound fields replace or supplement raw parameters;
- how luma_midpoint_enabled / midpoint applicability is represented;
- whether backend means the resolved/defaulted request token (`auto` included)
  or the selected EFFECTIVE tier;
- exact planes expansion and formatting;
- exact float formatting.
```

The most useful resolution would be literal expected strings for every existing
valid harness case:

```text
Classic:
    valid_auto
    valid_full

Deblock4:
    valid_auto
    valid_full
    midpoint_present
    midpoint_absent
```

Those literals would remove ambiguity from both implementation and proof.

# 4. STOP finding S2 - "immediately after" versus success-only emission

The current version/backend/tier summary is emitted inside:

```text
cpu_capability_detection.initInstanceCapabilities()
```

That occurs before:

```text
- backend_tier_selection.selectForEffectiveTier() can reject a requested
  backend above EFFECTIVE;
- instance allocation;
- immutable instance assembly;
- the createVideoFilter wrapper call.
```

In Debug, the verbose-detection G10 output is also emitted after the summary
and before control returns to instance creation.

Therefore, these two requirements cannot both be interpreted literally without
moving or restructuring accepted selection/diagnostic code:

```text
A. the using line is the immediately adjacent physical stderr line after the
   existing summary in every build configuration;

B. the using line is emitted only on successful creation and never for a
   later selection/allocation failure.
```

The bounded implementation that preserves accepted selection and G10 structure
would be:

```text
- complete parsing, validation, selection and instance allocation;
- assemble the immutable instance including the using text;
- emit `deblock4: using ...` immediately before the existing
  createVideoFilter wrapper call;
- make no emission on any earlier error return.
```

Under that interpretation the using line is the next always-on creation line
after the summary. It is physically adjacent in ordinary Release output, but
Debug-only force-down/verbose/lifecycle diagnostics may occur between the two.

Please confirm whether this is the intended meaning of "immediately AFTER".
If literal adjacency in every build is required, the scope must expressly
authorise the larger summary/selection restructuring and define how success-only
semantics are preserved.

Please also confirm that "successful creation" uses the existing Stage 1C
convention: all plugin-side validation, tier selection and allocation have
succeeded and the code is about to call the void createVideoFilter wrapper.
The API wrapper supplies no success return that can safely be inspected after
the call.

# 5. STOP finding S3 - stderr-count proof cannot live in the .vpy script alone

Scope P1 says both `.vpy` harnesses assert that the using line appeared exactly
once per created instance.

A `.vpy` script running inside vspipe can read frame properties, but it cannot
read and count stderr that the containing vspipe process has already emitted.
The current matrix solves process-output assertions in `build_1C_v1.bat`:

```text
- :run_vpy_case captures combined vspipe output to a case transcript;
- :count_literal_exact already provides an exact line-count mechanism.
```

Therefore P1 requires a narrow `build_1C_v1.bat` change in addition to the
`.vpy` property assertions.

Please confirm that the rider authorises:

```text
- .vpy changes to assert Deblock4Using equals the exact expected property text;
- build_1C_v1.bat changes to count the exact prefixed stderr line once in each
  captured valid-case transcript;
- no other runner change.
```

This should also be added to the deliverable list in section 4, which currently
names updated `.vpy` harnesses but does not name the necessarily changed batch
runner.

# 6. W3C proof recommendations requiring independent verification

The following are W3C proposals affecting criteria that would judge W3C's own
delivery. They are therefore explicitly marked under charter I7:

```text
Proposer:
    W3C

Independent verifier requested:
    W3D

Normative adoption:
    W3X
```

## 6.1 P-W3C-1 - prove the F6 motivation directly

The scope's motivating example shows:

```text
Classic(strength=1, ...)
```

which appears intended to demonstrate that a call using `strength=1.5` reaches
the plugin as resolved integer `1`.

The current valid Classic cases do not pass `strength=1.5`; `valid_auto` omits
strength and resolves to the default `25`.

Please decide one of:

```text
A. add a dedicated valid coercion-visible case using strength=1.5 and assert
   line/property strength=1; or

B. change an existing valid case to use strength=1.5 while retaining a
   defaulted-parameter assertion for other omitted members; or

C. state that no direct coercion runtime proof is required and that the example
   is illustrative only.
```

W3C recommends A because it proves the rider's stated motivation without
weakening the existing default-value case.

## 6.2 P-W3C-2 - dynamically prove R5 failure absence

R5 binds that failed creation emits no using line, but P1 dynamically checks
only successful cases.

W3C recommends that each existing error-case transcript, or at minimum one
representative failure before selection and one failure during selection, be
checked for absence of the stable prefix:

```text
deblock4: using
```

This is a small reuse of the existing captured logs and `find_absent` helper.
W3C will not add it unless W3D verifies and W3X adopts it.

# 7. Property-name proposal

The scope proposes `Deblock4Using` and permits W3C to propose an alternative.

W3C proposes **no alternative**. The intended property name is:

```text
Deblock4Using
```

It is consistent with the existing non-reserved `Deblock4*` audit-property
family and avoids adding a second naming decision.

Please record W3D verification and W3X ratification of `Deblock4Using` before
delivery preparation, as requested by scope section 2.2.

# 8. Planned implementation shape after clarification

This section is informative and does not begin implementation.

Subject to the revised/ratified scope, W3C expects the bounded design to be:

```text
1. A small pure shared formatter produces the exact unprefixed
   `Classic(...)` / `Deblock4(...)` byte string from validated resolved data.

2. The text is stored by value in immutable instance data using a proved
   fixed capacity and explicit length. No secondary heap allocation is needed,
   so callback-router free logic remains unchanged.

3. Instance creation emits one `deblock4: using {text}` line with one
   std.debug.print call after successful plugin-side construction.

4. Classic and Deblock4 frame-property modules write `Deblock4Using` from the
   same stored byte slice, guaranteeing line/property identity by construction.

5. Unit tests cover exact formatting, defaults, canonical plane ordering,
   grid variants, absent optional values and maximum-capacity construction.

6. The two .vpy harnesses assert exact property strings. The batch runner
   performs exact stderr-count checks if authorised by W3D/W3X.

7. The complete existing fifteen-gate matrix is re-run unchanged in scope,
   with only the authorised E-series assertions extended.
```

Likely production/source touch set:

```text
new shared formatter/value module
common or per-filter immutable instance-data module(s)
classic_instance_creation.zig
deblock4_instance_creation.zig
classic_frame_properties.zig
deblock4_frame_properties.zig
print_helper_functions.zig, if the always-on emitter is centralised
both stage_1c .vpy harnesses
build_1C_v1.bat, if authorised as required by P1
```

No change is expected to:

```text
parameter registration
parameter validation
tier selection
CPU detection
callback-router activation switches
frame request/copy order
backend dispatch
pixel data
G10 modules or gates
Stage 1C acceptance history
```

# 9. Requested W3D response

Please review and answer:

```text
Q1. What are the exact canonical member sets, names, order and value formats
    for Classic and Deblock4?

Q2. Does "immediately after" mean the next always-on creation line, allowing
    Debug-only diagnostics to intervene, with emission after plugin-side
    selection/allocation and before createVideoFilter?

Q3. Is build_1C_v1.bat expressly authorised to perform the exact stderr-count
    assertions that the in-process .vpy scripts cannot perform?

Q4. Should the rider directly prove the F6 strength=1.5 -> strength=1 case?
    If so, should it be a new valid case or a modification of an existing case?

Q5. Should existing failed-creation transcripts be checked dynamically for
    absence of `deblock4: using`?

Q6. Does W3D verify the property name `Deblock4Using`?
```

W3C recommends that W3D issue scope v1.1 resolving Q1-Q5 and recording its
verification of Q6, after which W3X may ratify and release the rider.

# 10. Hold point

W3C will not create a Stage 1C.1 delivery or begin production edits until:

```text
- W3D has resolved the STOP findings;
- the applicable rider scope is W3X-ratified and released;
- W3X directs W3C to proceed against the prevailing branch-main source.
```

---

*End of W3C pre-implementation scope review.*
