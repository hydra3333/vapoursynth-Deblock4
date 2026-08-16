# Deblock4 Bounded Coding Scope Issuance Format

## Reusable format and Stage 2C worked example

**Deliverable:** PROPOSED-DEBLOCK4-SCOPE-ISSUANCE-FORMAT
**Version:** 1.0
**Date:** 2026-08-03
**Status:** Draft for W3X/W3D discussion. Informative process proposal; it
does not amend the charter, release a scope, report the pending Stage 2C
review, or authorise implementation.
**Encoding:** US-ASCII; CRLF.

---

# 1. Purpose

This document proposes a repeatable way for W3D, through W3X, to initiate a
bounded Deblock4 coding scope for a memoryless W3C session.

It is designed to make the first coder response deterministic:

```text
1. identify the exact authority and source base;
2. verify package/version currency;
3. perform any mandatory independent sweep or pre-implementation review;
4. report findings and stop when the scope requires a review gate;
5. implement only after W3X explicitly releases implementation.
```

The format is derived from:

```text
AI_Charter_and_Invariants_Card_v1_26.md
    session bootstrap header;
    roles and interaction rules;
    scope currency;
    harness ownership;
    C-DELIV-01 through C-DELIV-09;
    process rules.

Deblock4_Scope_Header_CDELIV09_Reminder_Block_v1_1.md
    mandatory verbatim scope-header reminder.

The released Stage 2C authority set
    as a worked example of a source-pinned, oracle-construction,
    external-differential scope.
```

The charter and released scope always prevail over this proposed format.

# 2. Scope-initiation artifact set

A coding scope should be issued as an explicit set of artifacts with mixed but
declared authority.

## 2.1 Required artifacts

```text
A. Completed session bootstrap header
   One-page operational authority: role, current scope, exact source base,
   permitted/forbidden files, supplied inputs, validation, expected result,
   acceptance basis and stop point.

B. Released bounded scope
   The binding implementation and delivery authority.

C. Independent acceptance contract
   Vectors, matrices, properties, errors, geometry, safety, source
   immutability, differential expectations and test routing that judge the
   implementation independently of the implementation itself.

D. Scope-specific addenda
   Exact fixtures, corpus, harness, build-record, external-reference or
   delivery-order details too large or specialised for the main scope.
   Every addendum declares whether it is binding or informative and names
   the scope section it completes.

E. Binding knowledge index
   The relevant K-items and their authoritative homes. It is a verification
   index, not the starting point for an independent sweep.

F. Source provenance package
   Exact external source, licence, hashes, read-only/EOL rules, citation
   convention and executable-result limitations.

G. Creation/error/API table when user-visible strings are involved
   Exact plugin-owned rows, reachability, proof surface and precedence.

H. Issuance bundle manifest
   What W3X saves, what is attached, actual archive names, archive hashes,
   folder layout, stale-document caveats and the exact issuance message.

I. Exact source package
   Commit hash or a byte-identified attached source tree. Every file required
   by the scope and proof must be present.

J. Current state record
   Informative orientation only. It must clearly say that the scope and
   controlling authorities prevail.
```

## 2.2 Controlling-specification currency

Never label an old specification as controlling merely because a historical
charter template names it.

Before issuance, W3D/W3X must do one of:

```text
1. attach the current controlling specification;
2. reissue the scope against the newer specification;
3. record a charter-2.3b compatibility decision;
4. explicitly mark the older specification historical/background only and
   ensure the scope quotes every relied-on requirement inline.
```

If materiality is uncertain, stop and reissue. A coder should never have to
decide whether a likely stale specification silently supersedes a released
scope.

# 3. Packaging rules

## 3.1 Recommended archive layout

```text
01_bootstrap_header.md          loose first attachment where practical

02_stage_reference.zip
    active scope;
    acceptance contract;
    addenda;
    knowledge index;
    current error/API tables;
    pinned external source and provenance;
    issuance manifest.

03_dev_documentation.zip
    complete current non-superseded documentation sweep domain.

04_source_base.zip
    exact source tree, tests, tools, build files and pinned headers needed by
    the scope.
```

Three archives are also acceptable when the bootstrap is inside the reference
archive, provided the issuance message says exactly where it is and instructs
W3C to read it first.

## 3.2 Superseded content

Best practice is to omit superseded folders from the issued archives.

When they are present, the message and bootstrap must say:

```text
Do not read, search, move, delete or use them.
Their presence does not put them inside the knowledge-sweep domain.
```

Never say superseded folders were omitted when the actual archives contain
them.

## 3.3 Package identity

Record SHA-256 for each archive. For an attached-source-tree base, also record
the hashes of every existing file the scope authorises for modification.

This protects against accidental repackaging and gives the final delivery a
mechanical base for precondition checking and scoped restoration.

# 4. Bootstrap-header format

Use the charter header but make every field concrete.

```text
Project
Charter filename and internal version
Current controlling specification or explicit compatibility/historical note
Repository and branch
Exact starting commit OR exact attached source package and SHA-256
Active scope identifier, version, status and one-sentence objective
Permitted new files - exact paths/patterns
Permitted existing files - exact paths and exact change class
Forbidden files - all others, with important categories enumerated
Inputs supplied - exact filenames and versions
Required validation - exact runner/commands/modes/gates
Expected result - exact pass/fail/skip and changed-file result
Known open measurement gates - scope-relevant only
Implementation acceptance - independent definition of done
Review-before-implementation gate and explicit stopping point
Session-package contents
Revision-matching instructions
```

Avoid category-only permissions such as:

```text
"each identity-asserting file"
"any required test file"
"other integration surfaces as needed"
```

Where possible, expand them into exact paths before issuance. A category may
be retained only when the scope gives a deterministic discovery rule and
requires the coder to report the resulting exact list before coding.

# 5. Main-scope document format

## Header

```text
Title
Deliverable ID
Version
Date
Author
Status:
    DRAFT / FOR W3X RATIFICATION / RELEASED / WITHDRAWN
Authority set:
    exact highest-version members read together;
    authority of each member;
    rule that more-specific companion text prevails.
Encoding/EOL
Verbatim C-DELIV-09 reminder block
```

The header must distinguish:

```text
technical reissue;
issuance-hygiene reissue;
acceptance change;
scope-boundary change;
documentation pointer refresh.
```

## Section 0 - Mandatory independent knowledge sweep

Embed the standing two-sided sweep block verbatim when applicable.

State:

```text
sweep domain;
excluded folders;
whether the sweep begins before or after any index/checklist;
required finding format;
how confirmed omissions become new K-items;
the stop/reissue rule.
```

## Section 1 - Objective, deliverables and boundaries

State one independently reviewable objective.

Enumerate:

```text
NEW files;
EXISTING files and exact authorised change class;
OUT-OF-SCOPE files and behaviours;
explicitly forbidden adjacent work;
source/reference folders that are read-only;
whether documentation changes are authorised.
```

A scope is incomplete when correct implementation necessarily requires an
unnamed existing integration surface.

## Section 2 - Ratified decisions

For each decision:

```text
identifier;
exact behaviour;
rationale;
proposer/verifier where criteria changed;
W3X ratification/release state;
exact user-visible text if any;
precedence against nearby rules;
future work carried forward;
do-not-revisit boundary.
```

Do not hide decisions inside acceptance prose.

## Section 3 - Architecture requirements

State the internal contracts that permit only one reasonable implementation
at the behavioural level:

```text
data model;
ownership and lifetime;
format/storage representation;
geometry and stride source;
source/destination contract;
schedule and dependency order;
numeric width, rounding, overflow and clamp policy;
threading/determinism;
dispatch and feature boundaries;
diagnostic and property contracts.
```

Where source organisation is intentionally flexible, say what is not frozen.

## Section 4 - Implementation obligations

Quote or reproduce the exact formulas, table derivation, schedule, footprints,
eligibility and write order the coder implements.

Do not make the coder locate algorithm-bearing requirements only in a large
background specification.

## Section 5 - Acceptance basis

Enumerate every obligation family and its proof surface.

State:

```text
exact vectors/matrices;
exhaustive domains;
boundary and small-plane cases;
production routing;
source immutability and canaries;
range/overflow proof;
properties and copy semantics;
sanity/negative control;
ReleaseSafe/ReleaseFast relationship;
external differential relationship;
mandatory O/G-to-test crosswalk.
```

For oracle construction, state why the construction exception applies and
what becomes the oracle after acceptance.

## Section 6 - External-reference harness

When present, specify:

```text
H0 source-pin exception and ownership;
H1 build-record fields and source hashing;
H2 forced reference path;
H3 behavioural sentinel fixtures and mismatch hard stop;
H4 actual-input domain assertions and negative controls;
H5 decisive PASS/FAIL/difference-report contract;
H6 exact mandatory corpus and reproducibility record.
```

Separate source identity from executable-result identity.

## Section 7 - Proof surface

Name:

```text
runner;
build modes;
unit/selftest/vspipe/static/inspection gates;
successor-regression gates;
negative controls;
expected exit codes;
identity checks;
host-owned text that must not be asserted.
```

## Section 7b - Authorised integration surfaces

List exact existing paths, base hashes and narrow change classes.

## Section 7c - Proof-runner composition

State whether the runner:

```text
wraps a predecessor;
re-implements still-applicable predecessor gates;
uses a pinned historical baseline;
or retires/replaces a prior runner.
```

Do not require an identity-bound historical runner to pass against a later
identity.

## Section 7d - Generated evidence

Classify every DLL, record, log, capture, comparison file and inspection
artifact as:

```text
committed source;
delivery attachment;
or generated W3X evidence.
```

State preservation and restore behaviour.

## Section 8 - Delivery packaging

Restate the scope-specific C-DELIV rules:

```text
self-contained file set;
per-file patch/replacement/new-file form;
base hashes and new-file preconditions;
scoped restore-to-base block;
no global-clean-tree assumption;
no unrelated W3X-path inspection;
final manifest and application sequence.
```

## Section 9 - Binding knowledge checklist

Map each touched K-item to the scope section and proof.

Do not use this as the starting point for the section-0 independent sweep.

## Section 10 - Open Rule Questions

Record:

```text
open;
watch;
tabled;
resolved;
withdrawn/do-not-revisit;
trigger for reopening;
current positions and ratification state.
```

New rule questions belong here rather than being raised ad hoc during coding.

## Section 11 - Mandatory pre-implementation review

State exactly:

```text
documents read together;
issues W3C must assess;
required numbered-findings format;
ambiguity test: whether two reasonable implementations could differ;
source-verification duty;
implementation prohibition;
who resolves and who releases implementation.
```

# 6. Issuance-manifest format

The manifest should make W3X's packaging and message mechanical.

```text
1. W3X actions before issuance
   ratification;
   W3X fields;
   file placement;
   archive creation;
   package hashes.

2. Repository files added/replaced
   exact paths;
   predecessor moved to superseded after ratification;
   technical versus hygiene change.

3. Attachment list
   actual filenames;
   contents;
   omissions/exclusions;
   read order;
   stale-document caveats.

4. Exact source-base identity
   archive SHA-256;
   runtime identity;
   important present files;
   existing authorised-file hashes.

5. Suggested issuance message
   complete and ready to paste.

6. Known cosmetic lags
   narrowly enumerated;
   explicit statement that they are not hidden material differences.

7. Completion checklist
   no missing read-together member;
   no version mismatch;
   no falsely claimed omission;
   no unfilled W3X placeholder;
   no stale "next action";
   no implementation authorisation before review.
```

# 7. Designer-to-coder message format

The message should be shorter than the scope but operationally complete.

```text
Role and first document
Attachment map
Exact source base
Active scope and authority set
Stale/historical caveats
Pre-implementation sequence
Required review topics
Explicit stop point
Who releases implementation
Post-release boundary reminder
```

Avoid relying on:

```text
"read the manifest and work it out";
"latest documents attached";
"all relevant files";
"do the usual review";
"superseded folders omitted"
```

unless each statement is literally true and mechanically verifiable.

# 8. Stage 2C worked example

This section populates the proposed format with the current Stage 2C issuance.
It restates the released authority; it does not perform the pending review.

## 8.1 Objective

```text
Construct deblock4.Classic's first ReleaseSafe scalar deblocking oracle for
integer formats, wire it into the production Classic frame path, and deliver
the K26-pinned external HolyWu C/scalar differential harness.
```

## 8.2 Exact packages

```text
Source base:
    src(44).zip
    SHA-256 e30657148cfecf54d4d7b48aba5f891a0b6630afcd61feb30027838e9c1c42b5

Documentation:
    dev_documentation(13).zip
    SHA-256 02875dc11b45f32f1f9b3f466d38acc556da74d097dfa0d7f291fca51843c73c

Stage reference:
    stage_2C_reference.zip
    SHA-256 9d546b4b6c7bcb2afbb5e282d2b0fd68ecb9a331431e66474bd4ebbd4c7c929c
```

The source base carries identity `0.1.0-dev+1C`. Stage 2C advances the
single-homed identity to `0.1.0-dev+2C`.

## 8.3 Authority set

```text
Charter                         v1.26
D0 Binding Knowledge Index      v1.9
D1 HolyWu r9 pin                SHA256SUMS + provenance v1.4
D2 HolyWu Real Schedule         v1.6
D3 Scalar Obligations           v1.8
D4 Coder Scope                  v1.7 RELEASED
Addendum A K26 sentinels        v1.2
Addendum B differential corpus  v1.2
Creation-error table            v1.6
Bootstrap header                v1.0
Issuance manifest               v1.0
Project Status                  v1.21 informative
```

`README_Deblock4_Design_Spec_v1_9.md` requires an explicit currency decision
before it is called controlling in a new issuance.

## 8.4 Ratified decisions

```text
S1  integer formats 8..16 only; refuse float16 and float32;
    separately refuse valid integer 17..32.

S2  retain explicit final 0..peak clamps and retain the range proof.

S3  compare only the legal shared HolyWu domain.

S4  oracle-construction exception; accepted path becomes the oracle.

S5  backend resolution capped by EFFECTIVE capability and implementation
    availability; auto -> v1 in 2C; explicit v2/v3 fail; EFFECTIVE refusal
    precedes availability; Deblock4Tier reports actual implemented tier.

S6  identity +1C -> +2C; using-echo byte-stable.

S7  one canonical non-duplicated formula body over exact u8/u16 scalar
    storage; no speculative vector API.
```

Exact new Classic rows:

```text
Classic: float input is not supported
Classic: integer input must be between 8 and 16 bits
Classic: requested backend is not available in this build
```

## 8.5 New files

```text
src/classic_scalar_kernel.zig
src/classic_edge_schedule.zig
src/classic_thresholds.zig
tests/stage_2c_classic_*.vpy
build_2C_v1.bat
tools/holywu_reference/**
scope-required unit-test files at their final repository paths
```

## 8.6 Existing authorised integration surfaces

The final released bootstrap/manifest should expand every category to exact
paths and base hashes. Current principal paths and attached-base hashes are:

```text
build.zig
    d25e1920ff3664bcf3156e353fd3da1c51ea141bfa8391f957143ceee13978ca

src/backend_tier_selection.zig
    8158c4afcafaea7ed548a9ca0ad0c7d7a79ec7f92411f72f370537e7425b6861

src/classic_ar_all_frames_ready.zig
    f040d34ab80c5d0211c0e68e22cf89c9b4c9069df00eb8ec7ccf56599ce21711

src/classic_frame_properties.zig
    d6ca49b3a74f1488d96412ade8f6dbc5526004c62f564bd0bbbbf2b929a207e5

src/classic_instance_creation.zig
    8baf6922bee9aa151d36d41b4bd5d595dac226133a6861baa06a8e84f84307ca

src/classic_instance_data.zig
    aface41404d2b7ea7a0b767f09b10069bcc80f17fc3ccb52d7614423da0d93fd

src/deblock4_version.zig
    d5fb50f806cdaf47967dcbe7f0879581834a98a70c7c2280ca05368849c984f6

src/deblock4_selftest.zig
    1f5c6d398f1a03664d1adf952df4cc8ebc7df74fb3cb48760332679a98dacd4

src/print_helper_functions.zig
    2db78f6c6d91c419da7e16e6928e385978e481ec4efced3ee64e8e0203ae57c9
```

Narrow change classes:

```text
Classic creation:
    only the three refusals and format/storage validation.

Classic instance data:
    only sampleType/bitsPerSample/bytesPerSample and implemented tier.

Classic frame path:
    only replace pass-through with the oracle while retaining copyFrame-
    equivalent destination initial state.

Classic properties:
    only report the implementation actually executed; property key set and
    formats unchanged.

Tier selection:
    only S5 implementation-availability cap and precedence.

build.zig:
    only new-module and test wiring.

Version/identity surfaces:
    only the +1C -> +2C identity and exact gates/assertions required by S6.

Always-on creation report:
    only the S5 implementation-capped reason while retaining existing format
    discipline and leaving the rider 1C.1 using-echo byte-stable.
```

Before implementation release, the designer should enumerate every identity
and always-on-line file explicitly rather than leave the coder to infer the
final changed-file set.

## 8.7 Forbidden work

```text
all other files;
all deblock4.Deblock4 pixel/frame work;
registration;
effective_invocation_text.zig and the using-echo contract;
capability detection;
G10 debug modules;
build_1C_v1.bat;
HolyWu pinned files;
superseded folders;
SIMD, @Vector, v2/v3 backend objects;
Schedule B, grid mode, midpoint and 2D field-DCT work.
```

## 8.8 Architecture and mathematics

```text
Canonical scalar formula body:
    exact u8/u16 storage;
    bitsPerSample separately drives scale and peak;
    i32 arithmetic;
    multiply by 4, never negative signed left shift;
    signed right shift with floor semantics;
    explicit final sample clamps.

Schedule:
    HolyWu Schedule A;
    top-band vertical pass;
    then each band horizontal-before-vertical sequence;
    sequential in-place;
    no intra-frame edge parallelism;
    per-position complete-footprint eligibility;
    no whole-frame padding/cropping.

Plane contract:
    actual per-plane width, height, stride and bytes per sample;
    chroma in its own coordinates;
    source immutable;
    destination starts as copyFrame-equivalent source;
    unselected and out-of-footprint samples remain exact copies;
    audit properties written separately.
```

## 8.9 Acceptance

D3 v1.8 in full, including:

```text
O-1/O-1b/O-1c 73 tuple cases and exhaustive bits 8..16;
O-1d fixed 17-bit and 32-bit creation cases plus exhaustive 17..32 guard;
A1-A5;
B1-B8 in both orientations;
O-4 exact whole schedule and order discriminator;
O-5 formats, copy and literal native-16-bit matrix;
O-6 footprints, source immutability, canaries and i32 range proof;
O-7 10x10, 12x6, 6x6 and 11x7;
O-8 production routing;
mandatory O/G-to-test crosswalk;
G1-G6 sanity gate and constant-fill negative control;
ReleaseSafe/ReleaseFast byte identity.
```

External K26 layer:

```text
hash actual HolyWu source before build;
complete build record;
exact reference binary SHA-256;
opt=1 forced;
all six Addendum A sentinels and whole-frame neutralisation checks;
hard stop on mismatch;
actual-input legal-domain assertions;
explicit Classic v1 backend;
17-case Addendum B byte comparison;
decisive PASS/FAIL and machine-readable first-difference evidence.
```

## 8.10 Proof runner

```text
build_1C_v1.bat remains immutable historical evidence and is not run against
the +2C tree.

build_2C_v1.bat re-executes every still-applicable Stage 1C invariant and
regression gate against the current +2C tree, then runs the additive Stage 2C
unit, vspipe, sanity, identity and K26 differential gates.
```

## 8.11 Evidence ownership

```text
W3C delivers:
    scripts, hash guards, harness, record schema/template and tests.

W3X generates:
    reference DLL, completed record, sentinel observations and run logs.

Generated evidence:
    retained in inspection output;
    not committed source;
    not deleted by scoped restoration.
```

## 8.12 Review and release sequence

```text
1. W3X issues exact packages.
2. W3C revision-matches.
3. W3C performs section-0 independent sweep.
4. W3C independently verifies D2 against the hash-pinned source.
5. W3C performs section-11 review and reports numbered findings.
6. W3C stops.
7. W3D reviews findings and revises/answers.
8. W3X explicitly releases implementation against a named scope/base.
9. W3C implements under C-DELIV-09 and produces a final C-DELIV-01..08
   integrated package.
10. W3D performs static review using the crosswalk.
11. W3X applies, runs, reports, accepts and commits.
```

# 9. Final designer issuance checklist

```text
[ ] Charter current and filename/internal version match.
[ ] Scope status says RELEASED only after W3X release.
[ ] Controlling-specification currency explicitly resolved.
[ ] Read-together authority set complete and current.
[ ] Bootstrap W3X placeholders filled.
[ ] Actual archive names and SHA-256 recorded.
[ ] Source base exact and runtime identity recorded.
[ ] Superseded folders omitted or explicitly forbidden.
[ ] New files exact.
[ ] Existing changed files exact, with base hashes and narrow change class.
[ ] Forbidden files exact.
[ ] User-visible strings exact.
[ ] Ratified decisions and precedence explicit.
[ ] Acceptance obligations independently authored and enumerable.
[ ] Proof surfaces and crosswalk required.
[ ] External source identity separated from executable-result identity.
[ ] Generated evidence ownership and preservation explicit.
[ ] Historical runner relationship feasible.
[ ] Stale next-action documents clearly caveated.
[ ] Issuance message states pre-implementation tasks and stop point.
[ ] W3X implementation release is a separate explicit event.
```

---

*End of proposed Deblock4 bounded coding scope issuance format and Stage 2C
worked example.*
