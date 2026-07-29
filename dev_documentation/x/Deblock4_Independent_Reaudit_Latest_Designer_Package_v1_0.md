# Deblock4 - Independent Reaudit of Latest Designer Package

**Version:** 1.0  
**Date:** 2026-07-29  
**Status:** Independent W3C coder/adviser review. Findings and recommendations
only; this report does not amend any controlling document.  
**Input packages:** `files_1.zip` and `files_2.zip`, supplied by W3X as the
latest designer files  
**Encoding:** US-ASCII only

---

# 1. Package reconciliation

This review starts from zero and treats the two newly uploaded ZIP files as the
sole source of truth for the package under review.

`files_1.zip` contains five documents:

```text
AI_Charter_and_Invariants_Card_v1_13.md
README_Deblock4_Design_Spec_v1_6.md
Deblock4_Verification_And_Tiering_Decisions_v1_4.md
Deblock4_Project_Status_v1_5.md
Deblock4_Forward_Roadmap_v1_5.md
```

`files_2.zip` contains two documents:

```text
AI_Charter_and_Invariants_Card_v1_13.md
Deblock4_Verification_And_Tiering_Decisions_v1_4.md
```

The two duplicated files are byte-for-byte identical across the ZIPs. There is
therefore no conflict between the uploads.

Reviewed unique-file SHA-256 values:

```text
AI_Charter_and_Invariants_Card_v1_13.md
0a10c1dfe2c3d61325a42de9782946a78d7d82c9b94a22e77d4e8880bae013bb

README_Deblock4_Design_Spec_v1_6.md
85866164cac56ad8cb4606be08d6b2e53ac5fb6df496132c9204144e8b51a575

Deblock4_Verification_And_Tiering_Decisions_v1_4.md
7ceee90f6933093cda501f26f1639a94c52368aa98444145ab5aaa1d7b5f3e38

Deblock4_Project_Status_v1_5.md
27f9f699cb423a91133bd9164bcc650e857820a60fbf69eb01f67061fd7bf1e3

Deblock4_Forward_Roadmap_v1_5.md
1b66aa8328f2564ba9f2963ac6dace7ef2c71bd2b811eb21440682775f033f1f
```

All five unique files are US-ASCII.

The review does not assume any content from an earlier ZIP or earlier audit
except when identifying whether a previously known issue is now resolved.

---

# 2. Overall verdict

The latest designer package is substantially improved and the central project
direction is now coherent.

The following important matters are now aligned across the five reviewed
documents:

- two core filters in one DLL;
- `deblock4.Classic` first and `deblock4.Deblock4` second;
- Classic as a faithful HolyWu reproduction, including luma-on-chroma;
- proper chroma as a Deblock4-only feature;
- removal of `grid_mode="h264"` from Deblock4;
- one canonical mathematical kernel per filter;
- integer cross-backend exactness;
- float same-algorithm differential tolerance;
- exact structural results with separately bounded float numeric-activation
  differences;
- one production build per backend;
- named full v1/v2/v3 tiers;
- verbose public backend tokens;
- no native-host distributed target;
- `ReleaseFast` plus explicit `.strict`;
- no current `@mulAdd` requirement;
- shared Stage 1 followed by Classic 2C..5C and Deblock4 2D..5D.

However, the package is **not yet ready to be used verbatim for the next formal
coding scope**.

Two scope-blocking defects remain:

1. the charter's mandatory bootstrap template still reinstates the superseded
   universal byte-identity rule;
2. the oracle sequencing wording is circular and, read literally, forbids
   writing the scalar deblocking code needed to create the oracle.

Several high-priority consistency issues also remain in stage ownership,
document versions, CPU-level descriptions, diagnostic cadence, and detection
mechanism wording.

---

# 3. Scope blocker C1 - the mandatory charter bootstrap is internally wrong

The bootstrap is the most dangerous residual area because a future scope is
expected to copy it.

## C1.1 Companion internal revision is wrong

Charter metadata says:

```text
AI_Charter_and_Invariants_Card_v1_13.md:L6-L7

Companion specification: README_Deblock4_Design_Spec_v1_6.md
Companion internal revision: Design specification revision: 1.1
```

The actual README says:

```text
README_Deblock4_Design_Spec_v1_6.md:L74

Design specification revision: 1.6
```

The filename and internal revision therefore do not match in the controlling
charter metadata.

## C1.2 Bootstrap permits an unfixed "later prevailing version"

The bootstrap says:

```text
AI_Charter_and_Invariants_Card_v1_13.md:L79-L81

filename          README_Deblock4_Design_Spec_v1_6.md
internal revision Design specification revision: 1.1 or later prevailing version
```

This contradicts the revision-matching rule immediately below it, which says
the filename version and internal version must agree exactly.

"1.1 or later prevailing version" is not a revision pin and cannot detect a
wrong or stale attachment.

## C1.3 Bootstrap reinstates universal byte identity

The bootstrap says:

```text
AI_Charter_and_Invariants_Card_v1_13.md:L117-L122

If this scope touches any pixel-producing or frame-construction path,
including any plane copy, acceptance REQUIRES byte-identity against the
ReleaseSafe scalar oracle for every affected plane.
```

This contradicts charter A1/A2/G7 and README 1.1:

```text
INTEGER:
    byte-exact

FLOAT:
    same specified algorithm;
    structural results exact;
    final magnitudes and approved near-threshold numeric activation decisions
    accepted under the differential contract
```

A scope author copying the mandatory bootstrap would reintroduce the exact
policy the latest documents intentionally removed.

## Required correction

Issue a corrected charter before issuing a pixel-producing or frame-producing
scope.

Suggested metadata:

```text
Companion specification: README_Deblock4_Design_Spec_v1_7.md
Companion internal revision: Design specification revision: 1.7
```

Suggested bootstrap form:

```text
Charter:
    filename          AI_Charter_and_Invariants_Card_v1_14.md
    internal version  1.14

Controlling specification:
    filename          README_Deblock4_Design_Spec_v1_7.md
    internal revision Design specification revision: 1.7
```

Suggested pixel-path acceptance:

```text
If this scope touches an existing pixel-producing or frame-construction path:

INTEGER:
    acceptance requires byte identity against the applicable ReleaseSafe
    scalar oracle for every affected plane.

FLOAT:
    acceptance requires the same specified algorithm, exact structural results,
    and satisfaction of the approved magnitude and numeric-activation
    differential contract against the applicable ReleaseSafe scalar oracle.

A pure copy/share path whose specified result is unchanged source data remains
byte-exact for every format.
```

The oracle-construction exception required by C2 must also be stated.

---

# 4. Scope blocker C2 - oracle sequencing is circular

The documents correctly want the scalar oracle established before later copy,
frame, SIMD, or optimisation paths are accepted.

The current wording goes further and accidentally forbids construction of the
oracle itself.

## C2.1 Roadmap literally forbids deblocking code before the oracle exists

```text
Deblock4_Forward_Roadmap_v1_5.md:L109-L116

- No pixel, frame-construction, copy, or deblocking code until the relevant
  filter's ReleaseSafe scalar oracle exists (charter; Stage 2C/2D).
```

But Stage 2C and Stage 2D create the scalar deblocking code that becomes the
oracle.

Read literally:

```text
no deblocking code may be written until the deblocking code already exists
```

## C2.2 Bootstrap also catches the oracle-construction scope

The charter bootstrap applies to **any** pixel-producing path and says the scope
cannot be accepted until the oracle exists to diff against.

A scope implementing the first ReleaseSafe scalar oracle cannot compare its
whole-plane output against an oracle that does not yet exist.

## C2.3 Status wording is better but still lacks the exception

```text
Deblock4_Project_Status_v1_5.md:L199-L201

No pixel-producing or frame-construction scope, including a copy path, may pass
acceptance before the relevant filter's ReleaseSafe scalar oracle exists...
```

This again includes the oracle-building scope unless an exception is stated.

## Correct intended rule

The intended sequencing appears to be:

```text
ORACLE-CONSTRUCTION SCOPE:
    may implement the canonical ReleaseSafe scalar deblocking algorithm;
    accepted against independently specified arithmetic vectors, bounds,
    canaries, threshold tables, schedule cases, and the external HolyWu oracle
    where applicable;
    establishes the whole-plane scalar oracle.

ALL SUBSEQUENT PIXEL/FRAME/COPY/SIMD SCOPES:
    cannot pass until compared against that established scalar oracle under the
    integer-exact / float-differential contract.
```

## Required correction

Suggested charter/roadmap rule:

```text
The bounded Stage 2C/2D scope that constructs a filter's first ReleaseSafe
scalar oracle is the sole exception to the pre-existing-oracle comparison rule.
It must satisfy the independent scalar arithmetic, geometry, schedule, bounds,
canary, and external-reference obligations defined by its scope.

After that oracle is accepted, every subsequent pixel-producing,
frame-construction, copy/share, ReleaseFast scalar, v2, or v3 scope must be
differentially validated against it before acceptance.
```

Without this correction, the next Stage 2 scope would be impossible to write
without contradicting the charter or roadmap.

---

# 5. High finding H1 - Stage 1B.2 and 1B.3 remain conflated in charter G3

The intended split is correctly stated in the roadmap, status section 8, and
README section 12.3:

```text
Stage 1B.2:
    inspect compiled objects;
    confirm that each remains within its named level;
    settle vzeroupper;
    record the exact requirements Stage 1B.3 must enforce.

Stage 1B.3:
    implement and prove CPU/OS level detection, forced-tier rejection,
    fallback, and guarded dispatch.
```

Charter G3 still says:

```text
AI_Charter_and_Invariants_Card_v1_13.md:L375-L377

Stage 1B.2 CONFIRMS each compiled object stays WITHIN its declared level
and that the guard checks the whole level...
```

The guard is a Stage 1B.3 artifact and does not yet exist at Stage 1B.2.

## Required correction

```text
Stage 1B.2 confirms each compiled object stays within its declared level and
records the complete level and operating-system-state requirements that
Stage 1B.3 must enforce.

Stage 1B.3 implements and proves that runtime guard.
```

## Related Status wording

Status immediate-next-action text says:

```text
Deblock4_Project_Status_v1_5.md:L454-L457

Stage 1B.2 therefore CONFIRMS each object emits nothing outside its level and
that dispatch produces the whole-level feature requirements...
```

This should be:

```text
Stage 1B.2 confirms each object emits nothing outside its level and produces
the whole-level feature requirements that Stage 1B.3 dispatch must enforce.
```

Dispatch does not produce the requirements.

---

# 6. High finding H2 - Project Status v1.5 still contains stale package state

The status document's opening authority list is mostly current, but several
later live sections remain stale.

## H2.1 Completed table names charter v1.12

```text
Deblock4_Project_Status_v1_5.md:L148-L150

Recorded in charter (current v1.12)
```

The supplied charter is v1.13.

## H2.2 Documentation package names Project Status v1.3

```text
Deblock4_Project_Status_v1_5.md:L383-L392

...
Deblock4_Project_Status_v1_3.md
...
```

The current file is v1.5.

## H2.3 Readiness checks require old controlling versions

```text
Deblock4_Project_Status_v1_5.md:L406-L410

the charter ... both say v1.12;
the README ... both say v1.5;
```

The supplied files are charter v1.13 and README v1.6.

## H2.4 Unversioned "current" chat introduction

The package list includes:

```text
111_New_Chat_Introduction_for_Coder (current)
```

The charter's revision discipline requires exact identification. If this file is
part of a scope package, give its exact filename and revision or explicitly mark
it non-controlling and outside revision matching.

## Recommendation

Regenerate Project Status after the controlling charter/README correction.

Do not patch only three numbers. Search every live occurrence of:

```text
current v...
documentation package
readiness
authority
next action
```

and make the package self-consistent.

---

# 7. High finding H3 - CPU-level feature descriptions are not internally uniform

The project correctly says the authoritative contract is the named x86-64
microarchitecture level, not a hand-copied list.

That principle is sound. The current duplicated reading-aid lists nevertheless
disagree and could be copied into a Stage 1B.3 detector.

## H3.1 Decisions section 4.1 omits v2 members

```text
Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L185-L190
```

It lists v2 as:

```text
SSE3, SSSE3, SSE4.1, SSE4.2, POPCNT
```

but its own later section 11.2 also lists:

```text
CMPXCHG16B
LAHF-SAHF
```

The decisions record is internally inconsistent.

## H3.2 README F10 says XSAVE where the named v3 level uses OSXSAVE

```text
README_Deblock4_Design_Spec_v1_6.md:L2984-L2987
```

It describes v3 as adding `XSAVE`.

The official x86-64 microarchitecture-level table names `OSXSAVE` in v3.
Runtime AVX safety may also require checking CPU XSAVE capability and XCR0, but
the named level member should not be silently changed from OSXSAVE to XSAVE.

## H3.3 Some lists treat OSXSAVE as a level member; others as only an external
runtime condition

Examples:

```text
Charter G3 reading aid:
    v3 list omits OSXSAVE, then says AVX/AVX2 need OSXSAVE and XCR0.

Charter Part 3.2:
    full-v3 list omits OSXSAVE, then adds required OSXSAVE/XCR0 detection.

Decisions 11.2:
    explicitly lists OSXSAVE as a v3 feature.

README 12.3:
    omits OSXSAVE from the "includes" list but mentions it parenthetically.
```

The practical runtime check can be correct, but the wording should be uniform.

## Recommendation

Create one authoritative project table, preferably by reference to Zig's named
target/feature representation plus the official level definition.

All other prose lists should say:

```text
non-exhaustive reading aid; never use this paragraph to implement detection
```

The Stage 1B.3 scope should distinguish:

```text
named v3 feature membership:
    includes OSXSAVE under the level definition

runtime AVX/YMM safety:
    verify relevant CPU feature bits;
    verify OSXSAVE;
    execute XGETBV;
    verify XCR0 XMM and YMM state;
    verify every remaining v3 feature through the authoritative level mechanism
```

This review verified Zig 0.16 documentation still treats target CPU features as
part of the target contract and verified the official psABI table's OSXSAVE
entry.

---

# 8. High finding H4 - "one mechanism" and the expected CPUID implementation are
not yet reconciled

Charter G3 says:

```text
AI_Charter_and_Invariants_Card_v1_13.md:L352-L359

the implementation must derive both the compile TARGET and runtime DETECTION
from ONE mechanism that encodes the psABI standard
```

Decisions section 4.6 gives an investigation order:

```text
prefer Zig std.Target level definitions / a level-satisfaction helper;
otherwise use a std feature-set constant plus runtime CPUID;
otherwise construct a detector that is psABI-compliant by construction.
```

README F9 says:

```text
README_Deblock4_Design_Spec_v1_6.md:L2964-L2982

The expected landing point is a small explicit CPUID/XGETBV unit.
```

These can be reconciled, but they are not equivalent by themselves.

A separately written compile target and hand-written CPUID detector can drift,
which is exactly what the charter's "one mechanism" invariant is meant to
prevent.

## Recommendation for Stage 1B.3 design

```text
First:
    investigate whether Zig 0.16 exposes one stable level definition that can be
    used for both compile targeting and runtime satisfaction.

If not:
    define one project-owned canonical per-level feature descriptor;
    derive or validate both the compile target and runtime detector against it;
    test the detector with synthetic CPUID/XCR0 records;
    add a standing assertion/test that the object tier name and detector tier
    name cannot diverge.
```

README F9 should not call the explicit hand-written unit the expected landing
point until this relationship is specified.

This does not block Stage 1B.2 assembly inspection, but it should be resolved
before Stage 1B.3 is scoped.

---

# 9. High finding H5 - stderr emission cadence is contradictory

The README deliberately resolved the ambiguity as once per filter-instance
creation:

```text
README_Deblock4_Design_Spec_v1_6.md:L2297-L2301

ONCE PER FILTER-INSTANCE CREATION ... not per-frame.
"Once per run" would be ambiguous in a graph with several filter instances.
```

The decisions record still says:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L30-L39
    selected level emitted to stderr on every run.

Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L326-L330
    emitted to stderr on every run.
```

It also uses the vaguer phrase "always-on stderr emission" elsewhere.

## Required correction

The decisions record should use the same contract as the README:

```text
At each filter-instance creation, emit once:
    plugin version;
    filter name;
    requested backend token;
    selected tier;
    fallback reason, where applicable.

Do not emit per frame.
```

"Always-on" may remain, but define it as "not behind a debug switch," not "on
every run" or "per frame."

---

# 10. High finding H6 - decisions section 4.5 is syntactically broken

Current text:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L230-L255

The term is "full declared tier", not "unconstrained"...
Distributed objects are NEVER built for

## 4.5.1 Public backend tokens
    ...

W3X's native CPU; each backend targets its declared psABI level.
```

A heading and an entire subsection split one sentence.

## Required correction

Move the complete sentence before section 4.5.1:

```text
The term is "full declared tier", not "unconstrained." Distributed objects are
never built for W3X's native CPU; each backend targets its declared psABI level.

## 4.5.1 Public backend tokens
...
```

This is editorial but is located in a durable decision of record.

---

# 11. Moderate finding M1 - FMA examples still imply a current numerical path

The settled policy is:

```text
ReleaseFast
.strict
full v3 target including FMA
ordinary a*b+c is not automatically contracted
no current @mulAdd requirement
Stage 1B.2 must not expect FMA emission
```

Charter A1/G7 and README 1.1 now describe this accurately.

Two older live passages still say that v3 may be more accurate "e.g. via FMA":

```text
Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L73-L79
README_Deblock4_Design_Spec_v1_6.md:L897-L907
```

Under the current no-`@mulAdd` algorithm, FMA is not the expected cause of
cross-backend differences.

## Recommendation

Use:

```text
legitimate backend evaluation differences, including any future explicitly
approved fused operation
```

Do not present FMA as a current Stage 1B.2 or Stage 2 expectation.

A further precision improvement is to replace categorical
"FMA is present-but-unused" with:

```text
FMA is included in the v3 target but is not relied upon and ordinary a*b+c must
not be result-changing contracted under .strict.
```

That avoids declaring that no FMA instruction can ever appear in any
strict-semantics circumstance.

Zig 0.16 documentation confirms `.strict` is the default and `.optimized`
permits contraction; `@mulAdd` explicitly requests one-rounding fused
semantics.

---

# 12. Moderate finding M2 - residual "identity" wording can reintroduce the old
policy

Many occurrences are historical or correctly refer to integer/non-pixel
identity. Several live pixel-contract uses are still ambiguous.

## Examples needing precision

```text
AI_Charter_and_Invariants_Card_v1_13.md:L649-L654
    "differential-identity harness"

README_Deblock4_Design_Spec_v1_6.md:L826
    "backend-identity failure"

README_Deblock4_Design_Spec_v1_6.md:L1349
    "essential for backend identity"

README_Deblock4_Design_Spec_v1_6.md:L1496
    "backend identity is required under the same inherited MXCSR state"

README_Deblock4_Design_Spec_v1_6.md:L1544
    "range/identity proof"

README_Deblock4_Design_Spec_v1_6.md:L2159
    "backend identity failure"
```

The MXCSR sentence is the most problematic because it appears to require float
identity again.

## Recommended terminology

```text
differential-identity harness
    -> independent differential correctness harness

backend-identity failure
    -> backend structural/differential-equivalence failure

essential for backend identity
    -> essential for exact structural and integer equivalence

backend identity required under the same inherited MXCSR state
    -> per-backend determinism and cross-backend differential validation are
       evaluated under the same inherited floating-point environment

range/identity proof
    -> range and per-type differential proof
```

Keep "identity" where it genuinely means:

- integer byte identity;
- unchanged-plane/copy identity;
- non-pixel marker identity;
- historical wording in revision history.

---

# 13. Moderate finding M3 - fallback prose assumes failure of v3 always means v2

Several sections say, in substance:

```text
A CPU with AVX2 but missing any other v3 feature is v2, not v3.
```

Examples:

```text
AI_Charter_and_Invariants_Card_v1_13.md:L368-L373
Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L207-L214
README_Deblock4_Design_Spec_v1_6.md:L2063-L2069
```

The formal rule elsewhere is better:

```text
select the highest fully satisfied level: v3, else v2, else v1
```

A machine failing v3 is not logically guaranteed by that fact alone to satisfy
v2. Real AVX2 CPUs are expected to satisfy v2, but the invariant should not rely
on the example becoming a theorem.

## Recommendation

Replace with:

```text
A CPU exposing AVX2 but failing any other v3 requirement is not v3. Dispatch
must select the highest lower level it fully satisfies, normally v2 and
otherwise v1.
```

---

# 14. Moderate finding M4 - README concise baseline is ambiguous about the two
filters

README section 19 says:

```text
README_Deblock4_Design_Spec_v1_6.md:L3155-L3159

Deblock4 defines one canonical scalar-specified algorithm...
HolyWu remains the initial quality baseline but is not an absolute output
oracle.
```

That is correct for the `deblock4.Deblock4` MPEG-2 filter, but not for
`deblock4.Classic`, where the pinned HolyWu C/scalar implementation is the
normative external algorithm oracle.

Because "Deblock4" names both the project/plugin and one filter, the paragraph
can be read as applying to both.

## Recommendation

Title or begin the baseline explicitly:

```text
For the deblock4.Deblock4 MPEG-2 filter:
    ...

For deblock4.Classic:
    the separate Classic oracle contract in section 3.15 applies.
```

---

# 15. Moderate finding M5 - exact public call spelling is not fully uniform

The README opening uses:

```text
Deblock4.Classic
Deblock4.Deblock4
```

Most controlling sections use:

```text
deblock4.Classic
deblock4.Deblock4
```

If the intended VapourSynth invocation is:

```python
core.deblock4.Classic(...)
core.deblock4.Deblock4(...)
```

show that exact spelling once in the public API section and use the namespace
case consistently where a callable API is meant.

Project-name prose may still use "Deblock4" normally.

---

# 16. Moderate finding M6 - Decisions metadata/date and current pointers

The decisions record is version 1.4 but dated 2026-07-28, while its v1.4
second-audit reconciliation belongs to the 2026-07-29 document set.

Its status text correctly points to current charter v1.13 and README v1.6, but
some live contextual text still points to old README revisions, for example:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_4.md:L393-L402
    "(README v1.4 sections...)"
```

Historical revision references may remain, but current applicability pointers
should use the current controlling versions or omit version numbers and cite
section names.

---

# 17. Informational finding I1 - latest review package is not the entire durable
package

Project Status lists additional durable/orientation files:

```text
Deblock4_Concise_Project_Summary_v1.0.md
Deblock4_Toolchain_Findings_v1_1.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
111_New_Chat_Introduction_for_Coder
```

They were not supplied in these latest ZIPs.

This review therefore certifies only the five unique files listed in section 1.
It cannot conclude that the complete durable package is cross-consistent.

Before final scoping, supply the complete intended session package for one
last filename/version/reference check, especially the backend explainer and new
chat introduction.

---

# 18. Resolved findings - no further concern

The following former concerns appear resolved in the latest files.

## R1. Filter inventory

Consistent:

```text
two core filters:
    Classic first
    Deblock4 second

QED variants:
    later separate workstreams
```

## R2. Classic definition

Consistent:

```text
faithful HolyWu algorithm
fixed H.264 4-pixel grid
luma formula used on chroma
pinned HolyWu C/scalar external oracle at Stage 2C
proper chroma excluded from Classic
```

## R3. Deblock4 H.264 grid token

`grid_mode="h264"` is removed from Deblock4. Classic owns the H.264-grid use
case.

## R4. Activation policy

The core policy is now coherent:

```text
exact structural results;
float-only bounded numeric activation differences near thresholds;
integer zero activation differences.
```

## R5. Backend tokens

Consistent public tokens:

```text
auto
x86_64_v3_with_avx2
x86_64_v2_with_sse41
x86_64_v1_baseline
```

## R6. Frame properties

The duplicate backend/tier property has been removed. The intended common
properties are:

```text
Deblock4Filter
Deblock4Tier
Deblock4Version
```

with filter-specific grid properties only for Deblock4.

## R7. One kernel per filter

The documents now distinguish:

```text
shared plugin/dispatch/vector utilities
from
one canonical mathematical kernel per filter
```

## R8. Development ordering

Consistent:

```text
shared Stage 1
Classic 2C..5C
Deblock4 2D..5D
shared Stage 6
```

## R9. Stage 4/5 differential policy

README Stage 4 and Stage 5 now use:

```text
integer exact
float differential tolerance
structural results exact
```

rather than universal equality.

---

# 19. Recommended correction order

## Step 1 - Charter v1.14

Correct before the next formal scope:

1. companion internal revision;
2. bootstrap exact README revision;
3. bootstrap per-type acceptance;
4. explicit oracle-construction exception;
5. G3 Stage 1B.2/1B.3 split;
6. H-OWN terminology;
7. fallback wording;
8. any duplicated CPU-level reading-aid wording.

## Step 2 - Decisions v1.5

Correct:

1. section 4.1 feature-list consistency;
2. section 4.5 broken sentence;
3. once-per-filter-instance stderr cadence;
4. FMA examples;
5. fallback wording;
6. issue date/current pointers.

## Step 3 - README v1.7

Correct:

1. oracle-construction exception and sequencing references;
2. CPU-level/OSXSAVE wording;
3. one-source detection versus explicit CPUID expectation;
4. FMA examples;
5. MXCSR and residual identity terminology;
6. Classic versus Deblock4 scope in section 19;
7. exact public call spelling.

## Step 4 - Project Status v1.6

Regenerate:

1. current charter version;
2. current README version;
3. status self-reference;
4. package readiness checks;
5. immediate-next-action sentence;
6. exact package file list.

## Step 5 - Roadmap v1.6

Only a small correction is required:

```text
replace the circular "no deblocking code until the oracle exists" rule with the
explicit Stage 2C/2D oracle-construction exception and the post-oracle rule.
```

## Step 6 - complete-package check

Supply all durable/session-package files together and run a final mechanical
check of:

```text
filenames
internal versions
current companion references
stage names
public backend tokens
public filter names
scope bootstrap
```

---

# 20. Proposed unified wording for the two scope-blocking rules

The following wording would reconcile the charter, roadmap, status, and future
scopes.

## 20.1 Per-type differential acceptance

```text
For any scope modifying an established pixel-producing or frame-construction
path:

INTEGER:
    every affected plane must be byte-identical to the applicable ReleaseSafe
    scalar oracle.

FLOAT:
    every affected plane must implement the same specified algorithm, preserve
    every exact structural result, and satisfy the approved final-magnitude and
    near-threshold numeric-activation differential contract against the
    applicable ReleaseSafe scalar oracle.

A path specified to preserve source pixels unchanged, including plane sharing
or copying, remains byte-exact for every format.
```

## 20.2 Oracle-construction exception

```text
The first bounded Stage 2C or 2D scope that constructs a filter's ReleaseSafe
scalar oracle is exempt from comparison against a pre-existing whole-plane
oracle, because it creates that oracle.

That scope is accepted only against independently authored scalar obligations:
arithmetic vectors, threshold tables, geometry, footprints, schedule,
range/overflow proof, memory canaries, exceptional-value cases, and the pinned
external oracle where applicable.

After acceptance of the ReleaseSafe scalar oracle, every subsequent
pixel-producing, frame-construction, copy/share, ReleaseFast scalar, v2, or v3
scope must be differentially validated against it.
```

---

# 21. Final assessment

The designer has resolved the difficult architectural questions correctly.
The remaining problems are principally reconciliation and scope wording, not a
need to reverse the new direction.

I have no objection to proceeding toward scoping after the corrections above.

I do object to using the current charter bootstrap verbatim, because it would:

- pin the wrong README internal revision;
- permit an unfixed "later prevailing" specification;
- restore universal byte identity;
- fail to distinguish creation of the oracle from subsequent comparison
  against it.

The package is close, but those points should be fixed before the first new
scope is issued.
