# Deblock4 - Stage 2C Combined W3C Review: D3 v1.3 + D4 v1.1

**Deliverable:** W3C-2C-D3-D4-COMBINED-REVIEW  
**Primary documents:**  
- `Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_3.md`  
- `Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_1.md`  

**Context reviewed:** D0 v1.5 sections 4-6 first; D1 `holywu_r9/` plus
provenance v1.1 and verified SHA-256 values; D2 v1.3; current controlling
README v1.9, charter v1.26, Verification and Tiering Decisions v1.10,
Toolchain Findings v1.3, creation-error table v1.1, and the accepted Stage 1C
architecture/proof records.  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Status:** DOCUMENTATION REVIEW ONLY. D4 is not released. No implementation
has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Overall verdict

D3 v1.3's scalar arithmetic core is strong. W3C independently reconfirmed:

- all O-1 threshold tuples;
- A1-A5 and B1-B8;
- the O-4 8x8 Schedule-A matrix and swapped-order discriminator;
- the literal native-16-bit matrix;
- O-7 10x10, 12x6, 6x6 and 11x7 outputs;
- the G reference metrics and negative-control rationale.

The D4 scope is not yet ready for W3X release. The remaining findings are
mostly production-integration and proof-contract issues, not formula errors.
Several required behaviours currently admit two reasonable implementations
with materially different user-visible or audit-visible results.

Findings F1-F9 should be resolved before release. F10 is an Open Rule Question
proposal that should be either resolved or made concrete in A1 before coding.

# 2. Numbered findings

## F1 - BLOCKER: scalar-only Stage 2C has no defined backend-selection or audit-property behaviour

**Evidence:**

- D4 section 1: integer scalar is wired into the production path; v2/v3 code is
  out of scope (`D4:33-68`).
- D4 A8 and checklist K13/K23 preserve the existing tier infrastructure
  (`D4:162-167, 290-305`).
- README 12.6 says `auto` chooses the highest available backend, explicit
  named backends are honoured or refused, and scalar is a production backend.
- README 13.5 says `Deblock4Tier` records the named level **actually used**.
- The accepted Stage 1C architecture freezes a selected v1/v2/v3 tier at
  creation and switches on it in the frame path, while every branch is still
  the inert pass-through placeholder.

D4 does not say what happens on a v3-capable machine when:

```text
backend=auto
backend=x86_64_v2_with_sse41
backend=x86_64_v3_with_avx2
```

Reasonable implementations currently include:

1. all three branches execute the scalar kernel while `Deblock4Tier` still says
   v2/v3 - misleading and contrary to "actually used";
2. only the v1 branch filters while v2/v3 remain pass-through - wrong output;
3. creation forces every request to v1 - changes settled selection behaviour;
4. `auto` falls back to v1 and explicit unimplemented v2/v3 requests fail -
   coherent, but requires tier-selection and creation-error changes currently
   declared out of scope.

**Required resolution:**

Define an implementation-availability rule before coding.

W3C's provisional recommendation:

```text
auto:
    choose the highest tier that is BOTH hardware/EFFECTIVE-supported AND
    implemented for this filter; in Stage 2C that is v1 scalar.

explicit v1:
    execute scalar.

explicit v2/v3 before their stages:
    fail creation; never silently substitute scalar for an explicit request.

Deblock4Tier:
    report v1 because v1 is the implementation actually executed.

summary/fallback:
    report that auto selected a lower implemented tier where applicable.
```

A suitable exact new error candidate for explicit unavailable tiers is:

```text
Classic: requested backend is not available in this build
```

This is a public API/design decision and should be added to the Open Rule
Questions register as proposed Q4 if W3D/W3X do not resolve it directly in the
next D4 revision.

## F2 - BLOCKER: the accepted integer-format contract and storage dispatch are incomplete

**Evidence:**

- D4 S1 says Stage 2C accepts integer formats 8..16 and rejects float
  (`D4:74-102`).
- D4 A1 says "element type (u8..u16)" but does not distinguish logical bit
  depth from physical storage type (`D4:133-139`).
- D3 has exact 8-bit and 16-bit composite obligations, but no obligation that
  discriminates every intermediate bit depth 9..15.
- README 13.3 requires actual per-plane bytes per sample and format dispatch.

Two reasonable implementations could interpret A1 as:

```text
u8 storage for 8-bit and u16 storage for every 9..16-bit format;
```

or as arbitrary Zig `u9`..`u16` element types. Only the first describes the
VapourSynth plane storage representation.

A defective implementation that uses 16-bit scale/peak for every >8-bit clip
could pass the present 8-bit and 16-bit matrices while failing 9..15-bit input.

D4 also specifies no explicit handling for an integer format outside 8..16 or
for inconsistent `sampleType` / `bitsPerSample` / `bytesPerSample` metadata.

**Required correction:**

State explicitly:

```text
sample type:
    stInteger only in Stage 2C.

storage:
    8-bit integer -> u8 samples, bytesPerSample == 1;
    9..16-bit integer -> u16 samples, bytesPerSample == 2.

arithmetic bit depth:
    bitsPerSample drives scale and peak independently of the u16 storage type.

validation:
    bitsPerSample must be 8..16 and metadata must be internally consistent.
```

The immutable instance or frame-processing contract must identify where
`sampleType`, `bitsPerSample` and `bytesPerSample` are obtained and stored.
D4's current explicit file list does not make that data-model change clear.

D3 should add an exhaustive pure test for `bits=8..16` over scale, peak and
representative resolved thresholds, plus production-path cases at least for
8-bit, one intermediate u16-stored depth (10 or 12), and 16-bit.

If out-of-range integer bit depths are API-reachable, add a separate exact
creation error, for example:

```text
Classic: integer input must be between 8 and 16 bits
```

Do not hide an unsupported sample domain behind a generic arithmetic failure.

## F3 - BLOCKER: S1 conflicts with D0 and D4's own no-touch boundary; error wording should omit "yet"

**Evidence:**

- D0 section 5 says Stage 2C makes no validation or creation-error-string
  change.
- D4 section 1 puts registration, validation and creation-error strings out of
  scope (`D4:58-68`).
- D4 S1 requires new sample-type validation and a new exact creation-error row
  (`D4:74-102`).

S1's policy rationale is sound: float must not enter an integer-only pixel
path without the ratified float verification regime. The authority and
boundary text must nevertheless agree before release.

**Required correction:**

1. Amend D0 section 5/K16 or record an explicit W3X scope-currency exception.
2. Change D4's out-of-scope block to permit only the specifically ratified
   Stage 2C format refusals and no other validation/string changes.
3. Ratify creation-error table v1.2 before D4 is released.
4. Test the float row with an otherwise-valid constant-format call; do not
   create an accidental validation-precedence obligation by combining several
   invalid conditions in that case.

**Exact wording feedback:**

Prefer:

```text
Classic: float input is not supported
```

over:

```text
Classic: float input is not supported yet
```

The shorter form is stable, factual and does not make a user-facing promise
about future scheduling. The design documents already carry the intended
future float work item. When float support lands, the row is retired.

## F4 - BLOCKER / KNOWLEDGE-SWEEP FINDING: two controlling frame contracts are absent from D0/D4

D4 section 0 reproduces the D0 section-6.1 knowledge-sweep block verbatim.
That header is PASS. The independent sweep found two relevant controlling
README duties not adequately represented in the D0 index or D4 checklist.

### F4a - destination initial state and frame-property preservation

README 13.2 requires the destination initially to be semantically identical to
the source for all pixels and frame properties that should be preserved.
Classic then writes its own audit properties.

D3 O-5c currently says the "whole output frame" is byte-identical at strength
zero (`D3:181-190`). Taken literally, that conflicts with the existing
`Deblock4Filter`, `Deblock4Tier`, `Deblock4Version` and `Deblock4Using`
properties.

Required wording:

```text
At strength zero, every output PLANE BYTE is identical to the corresponding
source plane byte. Existing source frame properties are preserved, except that
the plugin's ratified audit-property keys are written to their required values.
```

G4 should likewise define whether its comparison is:

```text
plane bytes only;
or plane bytes plus an explicit exact audit-property set.
```

Do not compare opaque frame-object memory.

D4 should explicitly retain the copyFrame-equivalent destination-initial-state
contract before selected-plane filtering.

### F4b - actual per-plane geometry/stride/storage, never inferred chroma bounds

README 13.3 requires, for every selected plane:

```text
actual plane width and height;
actual stride;
actual bytes per sample;
the correct format family;
no inference of chroma bounds or steps from luma subsampling ratios.
```

D4 A5/A6 discusses extent and stride but never says the extent is obtained
from the actual frame plane, and D3 does not judge the complete production
format/plane access path.

Required correction:

- add the README 13.2 and 13.3 duties to D4 A5/A6 and its checklist;
- add them to D0 as new K-items under the section-6 process;
- test Gray, RGB and YUV production paths, including a selected chroma plane;
- test omitted `planes` (all planes) and an explicit subset on the actual
  production path.

These are not requests for new algorithms. They prevent a correct scalar
kernel being wired to the wrong plane geometry, storage or property contract.

## F5 - REQUIRED D3 CLARIFICATION: several obligations are not yet uniquely judgeable

### F5a - O-1c's offset-extreme set is ambiguous

D3 says:

```text
the four offset-extreme corners at strengths 0, 25, 60
```

This can mean four cases total or four `(aoffset,boffset)` corners at each of
three strengths (twelve cases).

Enumerate the exact tuples. W3C reads the likely intent as four corners at each
listed strength, but the judge must not infer that.

### F5b - production plane-routing proof is not explicitly mapped

D3 proves plane-neutral mathematics and copy semantics, but a delivery could
satisfy those with direct module tests while wiring production incorrectly
(for example: omitted planes processes only plane 0, RGB is skipped, or an
explicit subset is ignored).

D4 should require an obligation-to-test crosswalk containing at least:

```text
planes omitted -> every plane processed;
explicit one-plane subset -> only that plane processed;
YUV chroma selected -> same full algorithm in plane coordinates;
Gray selected -> processed;
RGB selected plane -> processed;
unselected planes -> exact plane-byte copy;
source frame -> unchanged;
audit properties -> exact required values.
```

The crosswalk should name the test and mode for every D3 O-item and G-item.
"Every obligation is tested somewhere" is not as auditable as an explicit
O/G-to-test index.

## F6 - BLOCKER: H1 conflicts with D1's reference-snapshot rules and does not define artefact ownership

**Evidence:**

- D1 provenance v1.1 says the snapshot is W3X-owned, read-only, not production
  build input, and coder deliveries never read it as input.
- D4 H1 says to build the pinned D1 bytes as a VapourSynth plugin
  (`D4:201-209`).
- D4 section 8 requires self-contained packaging but does not say whether the
  reference DLL and record are W3C-delivered files or W3X-generated evidence.

The intended isolated external-reference build is feasible, but the current
documents conflict literally.

**Required correction:**

Define the exception narrowly:

```text
The D1 source remains read-only and is never part of the Deblock4 production
build graph. The isolated tools/holywu_reference build may read those exact
bytes, after verifying SHA256SUMS.txt, and may compile them in an external
temporary workspace. It must not modify/EOL-normalise them or copy LF sources
into the S3-audited deliverable tree.
```

Define ownership:

```text
W3C delivers:
    build scripts, hash checks, harness, record schema/template and guard tests.

W3X generates locally:
    reference DLL, completed reference-build record, sentinel observations and
    run evidence.

Delivery package:
    states whether generated DLL/record are evidence attachments, ignored
    build products, or committed artefacts. Do not leave this implicit.
```

H1 must automatically hash the actual source bytes before compiling, not merely
copy the expected D1 hashes into the record.

The record should also capture enough build identity to audit a rebuild:

```text
OS/architecture;
compiler and linker versions;
complete compile/link command lines;
C++ language mode;
optimisation and FP flags;
all preprocessor definitions, especially DEBLOCK_X86 present/absent;
exact source-file set;
VapourSynth header hashes/version;
runtime/plugin versions;
exact DLL SHA-256;
D1 source hashes.
```

D0 K26's MXCSR/FP-environment field should either be recorded or explicitly
marked not applicable to the integer-only H4 domain.

## F7 - BLOCKER: H2-H4 do not yet define a reproducible sentinel test or a complete domain guard

### F7a - B2/B4/B5 are not all the same semantic class

D4 H3 says B2/B4/B5 cover the negative-left-shift C++ UB region
(`D4:214-219`).

Correct classification:

```text
B2 and B5:
    q0-p0 is negative; the C++ core expression left-shifts a negative signed
    value and enters the UB region.

B4:
    q0-p0 is positive; it does NOT exercise that negative-left-shift UB.
    It exercises a negative signed RIGHT shift in the side-delta calculation.
```

Keep all three, but record what each proves accurately.

### F7b - abstract edge vectors are not directly invokable through the plugin

HolyWu exposes a frame filter, not an `edge6` function. H3 must specify exact
plugin-level sentinel fixtures:

```text
frame dimensions and format;
plane and plane-selection arguments;
strength and offsets;
all surrounding sample values;
orientation;
edge/lane coordinates read back;
expected output bytes;
how other Schedule-A edges are made inactive or accounted for.
```

Without this, two reasonable harnesses can embed the six taps differently and
observe different results because the filter is sequential and in-place.

### F7c - sentinel mismatch handling is unspecified

State the gate:

```text
The exact hashed reference binary is usable only if its observed sentinel
outputs equal the ratified expected sentinel outputs.

Any mismatch:
    hard stop;
    no H5 comparison is trusted;
    report compiler/build identity and observed bytes to W3X/W3D;
    do not silently rewrite D3 to match the binary.
```

An alternative policy would be a material oracle change and needs explicit
three-way ratification.

### F7d - H2/H4 guards need negative controls and a fuller domain

H4 must inspect actual run inputs, not trust the generator. Add:

```text
constant format and dimensions;
sampleType == integer;
bitsPerSample in 8..16;
bytesPerSample consistent with bit depth;
mod-8 width and height for every compared plane/frame as applicable;
supported colour family and legal plane selection;
strength and offsets in the legal shared domain;
opt exactly 1 on every HolyWu call.
```

Add harness self-tests that deliberately present:

```text
missing opt;
wrong DLL hash;
non-mod-8 geometry;
float input;
out-of-range offset;
unsupported integer bit depth.
```

Each must fail before comparison.

D4's K26 checklist currently says "H1-H3" while D0 K26 also requires the H4
in-domain assertion. Correct the checklist to H1-H4.

## F8 - BLOCKER: H5/H6 do not define a decisive differential gate or a judgeable minimum corpus

**Evidence:**

- H5 says every difference is investigated and resolved
  (`D4:224-230`).
- P1 only says the harness must run (`D4:239-248`).
- H6 requires "several" strengths/offsets and optional PAL material
  (`D4:231-233`).

Two reasonable deliveries could both claim compliance while one compares only
two 8-bit frames and the other covers all accepted formats.

**Required gate semantics:**

```text
PASS:
    zero plane-byte differences over the mandatory corpus;
    OR every nonzero difference is named in a W3X-ratified deviation record
    satisfying K19(a)/K20.

FAIL:
    any unratified difference;
    any skipped mandatory case;
    any domain/hash/sentinel guard failure.

Process:
    emit nonzero exit code on FAIL;
    emit exact first-difference frame/plane/x/y and values;
    retain a machine-readable difference summary.
```

**Required minimum corpus must be enumerated, not "several":**

At minimum define:

- exact bit depths (preferably all 8..16; otherwise 8, an intermediate u16
  storage depth such as 10/12, and 16 plus exhaustive pure bit-depth tests);
- Gray, YUV with selected chroma, and RGB;
- planes omitted/all and explicit subsets;
- exact strengths including 0, default 25 and 60;
- exact asymmetric legal offset combinations including c0-from-alpha cases;
- fixed synthetic frame definitions, frame count and deterministic seed where
  generated;
- exact invocation list and output location.

Real 720x576 PAL material may remain an optional additional corpus in Stage 2C,
provided Stage 3C owns the later compatibility/quality corpus gate.

## F9 - BLOCKER: proof-runner composition, authorised changed files and stage identity are under-specified

### F9a - the file boundary is not an adequate implementation allowlist

D4 section 1 names three new algorithm modules, tests, tools and
`build_2C_v1.bat`, but the work necessarily reaches existing integration
surfaces such as:

```text
Classic creation/sample-format validation;
Classic immutable instance metadata;
Classic arAllFramesReady frame path;
frame/property handling;
build.zig unit-test/module wiring;
possibly version identity.
```

The scope must name the existing files or explicitly authorise the narrow
categories. Otherwise a correct delivery can be rejected for touching an
unlisted file, while a different coder may hide integration in an inappropriate
listed module.

### F9b - "extends the 1C matrix" is ambiguous

State whether `build_2C_v1.bat`:

```text
calls the accepted build_1C_v1.bat as an immutable, hash-checked prerequisite;
or incorporates a copied set of gates;
or modifies/renames the existing runner.
```

W3C recommends a wrapper model:

```text
build_2C_v1.bat first invokes the exact accepted 1C runner;
fails on any 1C failure;
then runs only the additive 2C gates.
```

The scope must then say how the unmodified 1C runner is represented in the
manifest: immutable hash-checked dependency versus staged delivery file.

### F9c - generated reference artefacts need packaging status

State whether the reference DLL, completed build record, comparison logs and
sentinel outputs are:

```text
committed;
delivery attachments only;
or generated inspection output excluded from source commits.
```

The restore block must not delete unrelated W3X evidence.

### F9d - Stage 2C identity is unspecified

The current project uses a single-homed stage identity in its version marker.
D4 should explicitly state whether the marker advances from `1C` to `2C` and
which existing summary/property proofs change.

Leaving a materially new pixel-producing implementation labelled `+1C` would
undermine the reproducibility/audit purpose. Changing it without scope text
would break exact identity gates unexpectedly.

The `Deblock4Using` format and resolved-request contents remain byte-stable;
that does not require the separate stage/version marker to remain `1C`.

# 3. Proposed Open Rule Questions additions

## Proposed Q4 - named backend availability during staged implementation

```text
Q4 (W3C) IMPLEMENTED-TIER AVAILABILITY. During Stage 2C only the Classic
scalar/v1 implementation exists, while the public API already accepts auto,
v1, v2 and v3 tokens and Deblock4Tier must report the implementation actually
used. Must backend resolution be capped by both EFFECTIVE hardware capability
and implementation availability?

W3C position:
    yes. auto selects the highest implemented-and-EFFECTIVE tier (v1 in 2C);
    explicit unimplemented v2/v3 requests fail clearly; no silent scalar
    substitution for an explicit named backend; Deblock4Tier reports v1.
    Add/ratify an accurate unavailable-in-this-build error row.

STATUS:
    open for W3D analysis and W3X ratification before D4 release.
```

## Proposed Q5 - how much vector-generic architecture Stage 2C must predesign

D4 A1/K24 requires the same mathematical body later to instantiate v2/v3, but
"structured so a later width parameter can instantiate the same logic" has no
objective Stage 2C acceptance test. Two reasonable source organizations can
both centralise the mathematics while exposing very different vector APIs.

```text
Q5 (W3C) K24 SAME-BODY REQUIREMENT. Must Stage 2C commit the final
BackendConfig/width-generic vector-instantiation interface before any v2 data
movement is designed, or is it sufficient to centralise every scalar formula
in one canonical helper and prohibit duplicated mathematics, with the thin
scalar/vector abstraction finalised in Stage 4C?

W3C position:
    do not force speculative vector API design in 2C. Require one canonical,
    non-duplicated mathematical source and a clean scalar call boundary.
    Stage 4C may generalise that boundary mechanically, but may not fork or
    rewrite the formulas. If W3X retains the stronger pre-instantiation rule,
    D4 must specify the concrete BackendConfig/width interface now so W3C can
    be judged objectively.

STATUS:
    open for three-way discussion.
```

# 4. Existing Open Rule Questions status

```text
Q1 explicit final clamps:
    substantively resolved by D4 S2; retain the clamps and the range proof.

Q2 review-loop termination:
    trigger not met. This combined review found production-contract and
    harness corrections, not merely optional additions.

Q3 knowledge-sweep narrowing:
    trigger not met. The independent sweep found the README 13.2/13.3 duties
    absent from the current D0/D4 checklist surface.
```

# 5. Confirmed / no-finding areas

No substantive correction is required for:

- D3's scalar arithmetic values and matrices;
- D3's corrected general write-footprint invariant;
- the settled native non-mod-8 eligibility policy;
- D4 S2's decision to retain explicit final clamps;
- D4's Schedule-A order and no-intra-frame-parallelism rule;
- the i32 multiplication-by-4 rule;
- the integer range bounds;
- the concept of forcing HolyWu `opt=1`;
- H5's investigate-before-deviation doctrine;
- the K17 principles of touched-path preconditions, no global clean-tree
  requirement, scoped restore and no use of `superseded/`;
- D4 section 0's verbatim knowledge-sweep header.

# 6. Recommendation

Do not release D4 v1.1 for implementation yet.

Revise D4 and, where noted, D0/D3/error-table authority so that:

1. backend availability and actual-tier reporting are settled;
2. the full integer format/storage domain is explicit and tested;
3. S1 is authority-consistent and the exact error wording is ratified;
4. README 13.2/13.3 frame contracts are indexed and scoped;
5. K26 fixtures, build ownership, guard failures and acceptance are exact;
6. the differential corpus and PASS/FAIL contract are enumerable;
7. the proof runner, changed-file boundary, generated artefacts and stage
   identity are unambiguous.

After those changes, one focused combined review should be sufficient; the
verified mathematics does not need to be re-derived again unless a revision
changes it.

---

*End of W3C Stage 2C combined D3 v1.3 + D4 v1.1 review.*
