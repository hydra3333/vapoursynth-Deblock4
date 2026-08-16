# Deblock4 Stage 1C Scope v1.2 - W3C Architecture Review

Version: v1.0
Date: 2026-08-01
Reviewed scope: Deblock4_Scope_Stage_1C_Filter_Creation_v1_2.md
Reviewed scope SHA-256:
c62a74e3c80e8036ebb8aaeb05d61570b382dc13f1836a527b68d44b2f006a43
Status: ARCHITECTURE ACCEPTED; NARROW BINDING CLARIFICATIONS REQUIRED BEFORE CODING
Encoding: US-ASCII only
EOL: CRLF

## 1. Headline

Scope v1.2 is a substantial architectural improvement over v1.1 and the W3C
proposal.

The decisive improvement is that filter identity is structural rather than a
runtime routing decision:

```text
- Classic creation installs Classic callbacks.
- Deblock4 creation installs Deblock4 callbacks.
- Each filter owns its own router and activation-reason handlers.
- filter_kind is diagnostic/property data only.
- the only per-frame dispatch is that filter's tier switch over the immutable
  BackendSelection frozen at creation.
```

This is the correct direction for future divergence. A later Deblock4 temporal
window, different source-frame requests, or different output construction does
not require inserting a central filter-kind dispatcher or dismantling shared
callbacks.

The classic_* / deblock4_* / common_* ownership rule is also valuable. In
particular, the explicit prohibition on merging near-identical per-filter
handlers merely because their Stage 1C bodies match prevents short-term
deduplication from creating long-term coupling.

W3C accepts that architecture.

A small number of remaining statements conflict with that same ownership rule
or leave proof mechanics internally inconsistent. They should be resolved by a
binding v1.3 scope or a short ratified addendum before source transformation.

## 2. Prior W3C findings resolved

Scope v1.2 resolves the earlier W3C review items:

```text
- D-2 now requires full signatures for both filters.
- D-3 now pins copyFrame-compatible writable metadata output and complete
  ownership handling.
- all three G10 seams are counted.
- exact module names and version placement are W3X-ratified.
- BackendSelection is a data record now; callable backend tables wait for
  2C/2D.
- the test total is observed rather than prematurely pinned.
- P1-P5 are addressed.
- the sweep list is concrete.
- S1 is structural + symbol + runtime.
```

No earlier W3C filename proposal remains controlling where scope v1.2 differs.

## 3. Remaining binding issues

### C1. The controlling README pin appears stale or regressed

The scope header says:

```text
README design spec v1.2
```

The immediately preceding controlling material named README design spec v1.9.
A move from v1.9 to v1.2 would be a version regression unless a different
document series is intended.

Required action:

```text
Pin the exact current README filename and version.
```

W3C will not infer whether `v1.2` is a typographical error or a newly renamed
series.

### C2. common_frame_properties conflicts with the common_* ownership rule

The binding rule says a common_* module must serve both filters:

```text
- without caller-distinguishing parameters;
- without per-filter branches;
- otherwise it must be split.
```

The settled module map assigns all audit-property writing to:

```text
src/common_frame_properties.zig
```

The property sets are not filter-neutral:

```text
Classic:
- Deblock4Filter = Classic
- Deblock4Tier
- Deblock4Version

Deblock4:
- Deblock4Filter = Deblock4
- Deblock4Tier
- Deblock4Version
- Deblock4GridMode
- Deblock4LumaStepX
- Deblock4LumaStepY
- Deblock4ChromaStepX
- Deblock4ChromaStepY
- conditional Deblock4MidpointScale
```

A single writer therefore needs either:

```text
- a filter discriminator;
- a tagged/optional per-filter property record;
- caller-distinguishing arguments; or
- a per-filter branch.
```

Each conflicts with the literal common_* rule.

W3C recommendation:

```text
src/common_frame_property_helpers.zig
    filter-neutral mechanical property-set helpers only;

src/classic_frame_properties.zig
    Classic property policy and values;

src/deblock4_frame_properties.zig
    Deblock4 property policy, grid properties, and conditional midpoint
    property.
```

The two per-filter ar_all_frames_ready modules call their matching property
module.

These filenames are a W3C recommendation only. Because scope v1.2 declares its
module names final, W3X approval is required before adopting them.

Alternative: amend the common_* rule to explicitly permit a data-driven
superset writer. W3C does not recommend that alternative because it weakens the
new ownership boundary and makes future property divergence less obvious.

### C3. The single common instance-record type needs an explicit representation

`common_instance_data_structure.zig` is defined as the single instance-record
type and contains:

```text
- common node/video fields;
- filter_kind;
- BackendSelection;
- validated parameter config.
```

ClassicParameters and Deblock4Parameters are different types and are expected
to diverge further.

The scope must state whether the record is:

```text
A. a tagged union containing both parameter records; or
B. a common field block embedded in two per-filter instance-record types.
```

Option A introduces a filter-specific union into the common record and risks
tag-dependent access in frame code.

W3C recommends option B:

```text
common_instance_data_structure.zig
    defines CommonInstanceFields only;

classic_instance_data.zig
    CommonInstanceFields + ClassicParameters;

deblock4_instance_data.zig
    CommonInstanceFields + Deblock4Parameters.
```

Each callback router then receives its own exact instance type. This best
matches the ratified no-filter_kind-routing architecture and avoids later
conversion from a common union when one filter gains new state.

Again, the two proposed filenames require W3X approval.

### C4. "atomic instance id" should be an immutable id from an atomic allocator

The common instance description says:

```text
atomic instance id
```

C-1C-1 correctly says that a monotonic atomic counter allocates the id at
creation.

The instance field itself should be a plain immutable integer value. The
process-wide allocator is atomic; an individual stored id is not.

Required wording:

```text
immutable instance_id allocated from the process-wide monotonic atomic counter
at creation.
```

### C5. The ar_all_frames_ready order should preserve the future backend seam

The module description currently orders the work as:

```text
obtain source -> writable copy -> property writes -> tier switch
```

For 2C/2D, the tier branch will become the operation that produces or modifies
the final output frame. Writing properties before that branch assumes every
future backend uses and returns the same pre-created frame object.

That callable/output contract is intentionally not settled until 2C/2D.

To avoid later restructuring, Stage 1C should pin this order instead:

```text
1. obtain the requested source frame;
2. tier switch calls the filter's pass-through placeholder and returns the
   final writable output frame;
3. the filter-specific property writer annotates that final frame;
4. return the final frame.
```

At 2C/2D only the branch target changes. The property and return tail remains
stable regardless of whether a backend later modifies a copy or constructs a
different output.

### C6. P2 is not fully settled, and variable-clip policy is unstated

P2 says custom steps are bounded by the relevant frame dimension if cheaply
checkable, otherwise by a constant proposed at delivery for later W3X
ratification.

That leaves implementation authority unresolved despite the scope status
saying P1-P5 are settled.

It also assumes that the relevant plane dimensions are available and fixed at
creation. The scope does not say whether variable-format or variable-dimension
clips are accepted or refused.

Required decision before coding:

```text
- pin the Stage 1C policy for variable-format/variable-dimension clips;
- if accepted, define when P2/P3 validation occurs;
- if refused, pin the exact creation check and message;
- remove the unapproved fallback-constant path or approve its exact value
  before implementation.
```

W3C must not invent the fallback constant during delivery.

### C7. Section 7 and E2 do not enumerate or prove all settled properties

Section 7 lists the three common properties and says:

```text
plus any further names README 13.5 settles.
```

The scope already knows that Deblock4 has additional settled grid and midpoint
properties. A binding scope should enumerate them rather than delegate them
back to the coder.

E2 currently proves only:

```text
Deblock4Filter
Deblock4Tier
Deblock4Version
```

Required correction:

```text
- enumerate the complete Classic and Deblock4 property sets in section 7;
- extend E2 to verify every always-present Deblock4 grid property;
- verify Deblock4MidpointScale presence and absence under its settled
  conditions.
```

Otherwise the implementation can omit the filter-specific properties while the
proof matrix still passes.

### C8. V1 compares two different version representations as though identical

The version module deliberately contains:

```text
identity string: 0.1.0-dev+1C
VS packed version: 0.1
```

V1 says the configPlugin-registered version, summary line, selftest banner, and
frame property all equal the same value.

The numeric packed API version cannot be textually equal to the identity
string.

Required correction:

```text
- configPlugin numeric version equals deblock4_version.vs_packed_version;
- summary, selftest, lifecycle trace, and Deblock4Version property equal
  deblock4_version.identity_string;
- the semantic package-manifest mirror is checked separately.
```

### C9. build.zig.zon remains a mandatory version mirror

The accepted tree contains package version metadata in build.zig.zon.

Scope v1.2 says all duplicate version strings are collapsed into
deblock4_version.zig, but a package manifest cannot necessarily consume a
runtime Zig module.

Required clarification:

```text
- deblock4_version.zig is the single runtime/emission authority;
- build.zig.zon is an explicitly permitted manifest mirror;
- build_1C_v1.bat verifies that the manifest semantic version matches the
  semantic version fields in deblock4_version.zig.
```

Without that exception and gate, the single-home requirement is either
impossible literally or leaves the manifest stale.

## 4. Architecture disposition

```text
Per-filter creation ownership:          ACCEPTED
Per-filter callback routers:            ACCEPTED
Per-filter activation handlers:         ACCEPTED
No filter_kind routing:                 ACCEPTED
Frozen BackendSelection:                ACCEPTED
Per-filter tier switch:                 ACCEPTED
Callable backend tables deferred:       ACCEPTED
Strict common_* neutrality rule:        ACCEPTED
Exact naming map as a whole:            ACCEPTED, subject to C2/C3 amendments
Version dedicated module:               ACCEPTED, subject to C8/C9
Scaffolding sweep:                      ACCEPTED
Scope v1.2 as immediate coding authority:
                                         BLOCKED PENDING C1-C9
```

The blocking items are narrow compared with the architectural work already
settled. C2, C3, and C5 are important because they determine whether the new
future-proof separation remains intact or is weakened by shared data/property
paths.

## 5. Requested response

W3D should issue either:

```text
Deblock4_Scope_Stage_1C_Filter_Creation_v1_3.md
```

or a binding addendum resolving C1-C9.

Where C2 or C3 changes a ratified filename, W3D should present the recommended
replacement to W3X for explicit approval before W3C transforms the tree.

No Stage 1C production source transformation should begin from v1.2 alone.
