# Deblock4 - Document Consistency Audit for Designer

**Version:** 1.0  
**Date:** 2026-07-29  
**Status:** Independent W3C coder/adviser review. Findings and recommendations
only; no controlling document is amended by this report.  
**Input package:** `docs(2).zip` supplied by W3X  
**Encoding:** US-ASCII only

---

# 1. Scope and method

This review checks the six supplied documents for:

1. internal consistency within each document;
2. consistency across the document set;
3. consistent incorporation of the new two-core-filter direction:
   `deblock4.Classic` first, then `deblock4.Deblock4`;
4. consistency of the revised verification model:
   integer exactness, float same-algorithm tolerance;
5. consistency of the revised CPU-tiering model:
   full named x86-64 v1/v2/v3 levels and whole-level dispatch;
6. consistency of stage ordering, public APIs, diagnostics, and current-status
   metadata.

Files reviewed:

```text
AI_Charter_and_Invariants_Card_v1_11.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md
Deblock4_Forward_Roadmap_v1_3.md
Deblock4_Project_Status_v1_3.md
Deblock4_Verification_And_Tiering_Decisions_v1_2.md
README_Deblock4_Design_Spec_v1_4.md
```

All six supplied files satisfy the project ASCII-only requirement.

This is a document-consistency audit. It does not independently validate the
H.264 or MPEG-2 algorithms, Zig code generation, CPU-population claims, or the
current repository source.

---

# 2. Overall conclusion

The updated direction is visible and mostly well captured in the newest
sections, especially:

- README v1.4 section 1.0;
- Verification and Tiering Decisions v1.2 section 8.1;
- Project Status v1.3 immediate-next-action section;
- Forward Roadmap v1.3 opening status note.

However, the package is **not yet internally or cross-document consistent**.

The main problem is not one missing sentence. New decisions were inserted into
documents without fully replacing older live requirements. Several controlling
sections now state mutually incompatible rules.

The package should not be used as the basis of a new coding scope until the
designer resolves the four policy blockers in section 3 and then applies the
document-specific corrections in sections 4-9.

---

# 3. Designer-level blockers

These require an explicit W3D/W3X decision before prose can be made fully
consistent.

## B1. Initial filter set versus eventual filter set is undefined

### Evidence

The charter still says three filters are planned, with `Deblock4` as the current
work:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L18-L24
```

The README opening says the DLL contains:

```text
Deblock4
Deblock4_qed
Deblock4_qed_autoadjust
```

and says `Deblock4` is developed first:

```text
README_Deblock4_Design_Spec_v1_4.md:L46-L55
```

The new controlling design section instead says the DLL registers two filters,
with `Classic` first:

```text
README_Deblock4_Design_Spec_v1_4.md:L109-L154
```

The roadmap, status record, and decisions record also say two filters and
Classic first:

```text
Deblock4_Forward_Roadmap_v1_3.md:L21-L28
Deblock4_Project_Status_v1_3.md:L437-L441
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L309-L334
```

The README later says the QED filters remain future workstreams:

```text
README_Deblock4_Design_Spec_v1_4.md:L3112
```

### Why this matters

The documents currently support three incompatible readings:

1. the final plugin has only two filters: Classic and Deblock4;
2. the initial release has two filters, with QED variants added later;
3. the final plugin has four filters:
   Classic, Deblock4, Deblock4_qed, Deblock4_qed_autoadjust.

W3X's stated direction appears to be reading 2 or 3, but the controlling
documents do not say which.

### Recommendation

W3D should define two terms explicitly:

```text
INITIAL CORE DELIVERY
    deblock4.Classic
    deblock4.Deblock4

LATER PLANNED WORKSTREAMS
    deblock4.Deblock4_qed
    deblock4.Deblock4_qed_autoadjust
```

Then state whether the eventual DLL is expected to expose four calls, or whether
the later workstreams may replace or wrap one of the initial calls.

Every document should use the same exact public names and the same sequence.

---

## B2. The charter still mandates universal bit identity

### Evidence

The session bootstrap requires byte identity for every pixel-producing path:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L87-L92
```

Charter A1 requires:

```text
scalar == SSE4.1 == AVX2
```

for every supported format and explicitly says float is bit-exact:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L140-L147
```

A2 says output must never depend on which backend ran:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L149-L151
```

Later in the same charter, G7 instead allows measured float differences:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L463-L486
```

The harness section and quick reference still call the central artifact a
"differential identity harness":

```text
AI_Charter_and_Invariants_Card_v1_11.md:L582-L603
AI_Charter_and_Invariants_Card_v1_11.md:L1411-L1416
```

### Why this matters

Part 1 is the pinned invariant card. A coding session following A1/A2 must reject
a float-tolerant implementation, while a session following G7 must accept one.
The conflict cannot safely be resolved by choosing the later paragraph.

### Recommendation

Rewrite A1 and A2 rather than merely adding another qualification.

Suggested substance:

```text
A1
    Each filter's canonical ReleaseSafe scalar implementation is its executable
    algorithm specification.

    Integer:
        ReleaseSafe scalar == ReleaseFast scalar == v2 == v3 exactly.

    Float:
        ReleaseFast scalar, v2, and v3 implement the same specified algorithm
        and satisfy the approved differential contract against the ReleaseSafe
        scalar oracle.

A2
    Batch width, alignment, stride, thread scheduling, and grouping must never
    alter output within one selected backend.

    Backend selection may affect only float final magnitudes in the specifically
    approved tolerance regime. It may not affect geometry, bounds, schedule,
    lane mapping, tails, or other exact structural results.
```

Also rewrite the session-bootstrap acceptance clause and replace "identity
harness" with a term such as:

```text
independent differential correctness harness
```

---

## B3. Activation/decision masks are both required exact and allowed to differ

### Evidence

The decisions record says decision masks are exact:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L86-L92
```

Its tolerance-methodology section again calls for exact decision-mask agreement:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L120-L137
```

The same document then says a near-threshold float difference may flip the
filter on/off decision and that this is accepted:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L94-L100
```

The charter says decision masks remain exact:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L478-L482
```

The README repeats exact activation-mask requirements:

```text
README_Deblock4_Design_Spec_v1_4.md:L183-L190
README_Deblock4_Design_Spec_v1_4.md:L850-L853
README_Deblock4_Design_Spec_v1_4.md:L2428-L2437
```

### Why this matters

A threshold decision is itself a decision mask. It cannot both flip and match
exactly.

This is the most important unresolved verification contradiction because it
changes the acceptance harness.

### Recommendation

W3D should choose one of two coherent models.

### Model A - all activation masks exact

Delete the near-threshold-flip acceptance decision. Float tolerance applies only
after the exact activation decision has selected the same branch.

### Model B - limited numeric activation flips accepted

This appears closer to W3X's stated end-use judgement. If adopted, distinguish:

```text
EXACT structural masks:
    edge eligibility;
    finite/non-finite mask;
    plane selection;
    valid-tail mask;
    bounds mask;
    lane mapping;
    clipping/saturation class where not numerically threshold-derived.

POTENTIALLY DIFFERENT numeric activation masks:
    only a filter on/off or branch decision whose controlling scalar value lies
    inside a separately derived decision-boundary tolerance.
```

Under Model B the harness must report and bound separately:

```text
number of activation-mask differences;
distance of each scalar decision value from its threshold;
maximum final output difference caused by each flip;
coordinates and complete source footprint;
a hard maximum permitted flip count or rate, if any;
confirmation that no structural mask differed.
```

A broad final-output tolerance alone is insufficient.

---

## B4. `Classic` is not yet defined precisely enough

### Evidence

The README calls `deblock4.Classic` the same H.264 in-loop algorithm as HolyWu:

```text
README_Deblock4_Design_Spec_v1_4.md:L702-L708
```

It also says HolyWu is an external oracle and Classic is a known algorithm:

```text
README_Deblock4_Design_Spec_v1_4.md:L143-L154
README_Deblock4_Design_Spec_v1_4.md:L731-L752
```

Elsewhere the specification requires a proper chroma filter that deliberately
differs from HolyWu's luma-on-chroma implementation:

```text
README_Deblock4_Design_Spec_v1_4.md:L397-L420
README_Deblock4_Design_Spec_v1_4.md:L1465-L1502
```

The broad geometry, schedule, chroma, and quality sections are not consistently
scoped to `Classic` or `Deblock4`.

### Why this matters

At least three possible definitions remain:

1. Classic is an observable-output compatibility implementation of HolyWu;
2. Classic is the H.264-standard algorithm, including proper H.264 chroma, and
   HolyWu is only a partial reference;
3. Classic uses HolyWu's schedule/formulas but deliberately corrects selected
   behaviours such as chroma, bounds, or tails.

These alternatives produce different kernels, test oracles, and acceptance
criteria.

### Recommendation

Add a normative per-filter applicability table before the common algorithm
sections.

W3D should explicitly settle, for Classic:

```text
grid and origin;
luma formula;
chroma formula;
strong/normal-filter scope;
processing schedule;
frame-edge and tail behaviour;
format coverage;
integer relationship to HolyWu;
float relationship to HolyWu;
whether any deliberate HolyWu differences are permitted;
which README sections apply unchanged;
which Deblock4-only sections do not apply.
```

If Classic is meant to reproduce HolyWu, proper chroma cannot silently apply to
it. If Classic is standards-clean rather than HolyWu-compatible, stop calling
HolyWu a ground-truth oracle and describe it as a comparison implementation.

---

# 4. Cross-document high-priority findings

## H1. Old and new CPU-tier policies coexist as live requirements

### Current decision

The new policy is full named levels:

```text
v1 -> scalar/generic
v2 -> SSE4.1-class backend
v3 -> AVX2-class backend
```

with whole-level dispatch and no FMA exclusion:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L295-L321
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L147-L187
README_Deblock4_Design_Spec_v1_4.md:L1966-L2033
```

### Contradictory live text

The charter target section still requires smallest measured closures and
explicitly excludes FMA:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L625-L650
```

The roadmap says Stage 1B.2 derives the smallest exact closure:

```text
Deblock4_Forward_Roadmap_v1_3.md:L56-L59
Deblock4_Forward_Roadmap_v1_3.md:L82-L90
```

The status document repeats the old work:

```text
Deblock4_Project_Status_v1_3.md:L176-L180
Deblock4_Project_Status_v1_3.md:L205-L219
Deblock4_Project_Status_v1_3.md:L296-L320
```

The backend-object explainer states that SSE4.1 forbids AVX/FMA and AVX2
forbids FMA, and gives the old build targets as current explanatory policy:

```text
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L180-L216
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L276-L306
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L369-L384
```

### Recommendation

Update all live target-policy prose to:

```text
Stage 1B.2 confirms that each object stays inside its declared named level.
It does not derive a bespoke closure.
FMA is not subtracted from v3.
```

Historical Stage 1B.1 snippets may remain verbatim, but they need a prominent
banner:

```text
HISTORICAL PROVISIONAL TARGETS USED ONLY FOR THE STAGE 1B.1 LINKAGE PROOF.
SUPERSEDED FOR PRODUCTION TIERING BY CHARTER G3.
```

The historical proof that the Stage 1B.1 AVX2 probe excluded FMA may remain in
the status record, but it must be labelled historical and non-normative.

---

## H2. Public backend tokens do not clearly name the full level contract

### Evidence

The public API currently uses:

```text
"auto" | "avx2" | "sse41" | "scalar"
```

in the charter and README:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L279-L284
README_Deblock4_Design_Spec_v1_4.md:L2054-L2072
README_Deblock4_Design_Spec_v1_4.md:L2104-L2112
README_Deblock4_Design_Spec_v1_4.md:L2220-L2227
```

G3 now defines those implementations as full v2 and v3 levels, not bare
SSE4.1 and AVX2:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L295-L317
```

The charter's own revision history previously identified `"sse41"` as
misleading when it requires the extra v2 features:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L1721-L1725
```

### Recommendation

W3D should choose one public contract.

Preferred unambiguous form:

```text
backend = "auto" | "v3" | "v2" | "v1"
```

or:

```text
backend = "auto" | "x86_64_v3" | "x86_64_v2" | "x86_64_v1"
```

A user-facing display name may still say AVX2-class or SSE4.1-class.

If `"avx2"` and `"sse41"` are retained for familiarity, every API and error
section must state explicitly:

```text
"sse41" means the complete x86_64_v2 contract, not merely SSE4.1.
"avx2" means the complete x86_64_v3 contract, not merely AVX2.
```

That choice should also govern frame properties, stderr diagnostics, test
selectors, and unsupported-backend errors.

---

## H3. Stage 2-5 cannot simply run twice using their present contents

### Evidence

The README says Stages 2-5 run twice, Classic first and Deblock4 second:

```text
README_Deblock4_Design_Spec_v1_4.md:L3041-L3050
```

But the actual Stage 2 and Stage 3 contents include Deblock4-only work:

```text
README_Deblock4_Design_Spec_v1_4.md:L3065-L3084
```

Examples include:

- `grid_mode` and custom grids;
- Schedule A versus Schedule B selection;
- midpoint threshold scaling;
- proper-chroma quality selection.

Classic has no grid selection or midpoint machinery:

```text
README_Deblock4_Design_Spec_v1_4.md:L702-L729
```

### Recommendation

Do not say the existing stage text runs twice unchanged.

Use either:

```text
Stage 2C / 3C / 4C / 5C    Classic
Stage 2D / 3D / 4D / 5D    Deblock4
```

or a stage applicability table.

Suggested sequence:

```text
Stage 1
    shared DLL, objects, tiering, detection, registration scaffold

Stage 2C
    Classic scalar oracle and HolyWu/reference differential harness

Stage 3C
    Classic compatibility/quality decision closure, if any

Stage 4C
    Classic v2 backend

Stage 5C
    Classic v3 backend

Stage 2D
    Deblock4 scalar core, grids, schedules, midpoint, proper chroma

Stage 3D
    Deblock4 quality gates and canonical-algorithm freeze

Stage 4D
    Deblock4 v2 backend

Stage 5D
    Deblock4 v3 backend

Stage 6
    integration and release validation for both core filters
```

If Classic has no open quality decision, Stage 3C may be a short compatibility
and corpus gate rather than an algorithm-selection phase.

---

## H4. The README still contains multiple live universal-identity requirements

### Evidence

The following current sections conflict with the revised float-tolerance model:

```text
README_Deblock4_Design_Spec_v1_4.md:L203-L220
    says all backends must produce the same deliberate new result and accidental
    backend differences are never acceptable.

README_Deblock4_Design_Spec_v1_4.md:L816-L823
    says scalar == SSE4.1 == AVX2 is mandatory without a type qualification.

README_Deblock4_Design_Spec_v1_4.md:L887-L895
    applies universal identity to a future analyser.

README_Deblock4_Design_Spec_v1_4.md:L3031-L3035
    still says targeted bit-identical float output.

README_Deblock4_Design_Spec_v1_4.md:L3086-L3100
    Stage 4 and Stage 5 still require unqualified equality.
```

### Recommendation

Replace each with the same type-split wording used in README section 1.1.

For future analysers, distinguish integer and float just as for the filter
kernels. The analyser's structural classifications may be exact even if a
float magnitude is tolerant.

---

## H5. The roadmap is internally stale

### Evidence

The roadmap opening says Stage 1A.1 and 1B.1 are complete:

```text
Deblock4_Forward_Roadmap_v1_3.md:L18-L19
```

Its stage arc still labels Stage 1A.1 as `NEXT` and says the source does not
build:

```text
Deblock4_Forward_Roadmap_v1_3.md:L40-L49
```

Its metadata says it is aligned to charter v1.8 and README v1.1:

```text
Deblock4_Forward_Roadmap_v1_3.md:L3-L6
```

It refers once to Stage 1C, which is not defined elsewhere:

```text
Deblock4_Forward_Roadmap_v1_3.md:L21-L25
```

It uses the superseded closure-derivation model:

```text
Deblock4_Forward_Roadmap_v1_3.md:L56-L59
Deblock4_Forward_Roadmap_v1_3.md:L82-L90
```

### Recommendation

Issue a new roadmap that:

- removes the obsolete "NEXT" Stage 1A.1 block or marks it completed;
- removes the stale non-building-source explanation from the live arc;
- replaces 1B/1C with the actual defined shared-infrastructure stages;
- changes 1B.2 from closure derivation to named-level confirmation;
- shows the Classic-first per-filter sequence explicitly;
- references the current charter and README versions.

---

## H6. The project-status record contains mutually inconsistent current states

### Evidence

The authority list names old files:

```text
Deblock4_Project_Status_v1_3.md:L21-L53
```

Examples:

- roadmap v1.1 rather than v1.3;
- project status v1.2 described as current inside project status v1.3.

The completed table still calls charter v1.9 current:

```text
Deblock4_Project_Status_v1_3.md:L141-L146
```

The open-work and stage sections still use identity and bespoke-closure
language:

```text
Deblock4_Project_Status_v1_3.md:L164-L189
Deblock4_Project_Status_v1_3.md:L193-L223
Deblock4_Project_Status_v1_3.md:L294-L323
```

The immediate-next-action section correctly uses named full levels:

```text
Deblock4_Project_Status_v1_3.md:L423-L435
```

The documentation-package section says "four-document package" but lists eight
files, many at old versions, and then instructs W3X to confirm charter v1.9 and
README v1.1:

```text
Deblock4_Project_Status_v1_3.md:L358-L390
```

### Recommendation

Project Status should be regenerated from the current controlling documents
rather than patched locally.

Retain the historical Stage 1B.1 evidence, including the fact that its
provisional AVX2 probe excluded FMA, but add:

```text
This was a Stage 1B.1 provisional probe contract and is not the production
tiering policy adopted later in charter G3.
```

Add separate not-yet-implemented entries for:

```text
Classic registration and creation;
Classic scalar oracle;
Classic v2 and v3 backends;
Deblock4 registration and creation;
Deblock4 scalar oracle;
Deblock4 v2 and v3 backends.
```

---

# 5. Per-filter architecture and API findings

## A1. `grid_mode="h264"` overlaps conceptually with a separate Classic filter

### Evidence

`deblock4.Deblock4` accepts `grid_mode="h264"`:

```text
README_Deblock4_Design_Spec_v1_4.md:L619-L643
README_Deblock4_Design_Spec_v1_4.md:L757-L765
```

The new architecture says Classic and Deblock4 are different algorithms and are
not selected by a parameter:

```text
README_Deblock4_Design_Spec_v1_4.md:L124-L129
```

### Recommendation

W3D should state one of:

```text
A. Deblock4(grid_mode="h264") remains valid and means:
   the Deblock4 algorithm on a 4-pixel grid. It is NOT Classic.

B. The h264 grid token is removed from Deblock4 because Classic now owns that
   public use case.
```

If A is retained, explain the observable algorithm differences prominently.
Otherwise users will reasonably assume the two calls are aliases.

---

## A2. Public call spelling and casing should be frozen

The supplied documents consistently use:

```text
deblock4.Classic
deblock4.Deblock4
```

W3X described the new call informally as `deblock4_classic`.

The final documentation should show the exact VapourSynth invocation, including
the plugin namespace and function case, for example:

```python
core.deblock4.Classic(...)
core.deblock4.Deblock4(...)
```

if that is the intended registration.

The README opening and charter quick-reference sections should use the same
names.

---

## A3. Audit frame properties are not fully defined for two filters

### Evidence

The README requires every output frame to contain grid and backend properties:

```text
README_Deblock4_Design_Spec_v1_4.md:L2210-L2229
```

There is no property identifying whether Classic or Deblock4 produced the
frame.

Classic has a fixed grid and no midpoint parameter, while Deblock4 has
grid-specific properties.

### Recommendation

Define a per-filter property contract.

Suggested common properties:

```text
Deblock4Filter       "Classic" | "Deblock4"
Deblock4Tier         "v1" | "v2" | "v3"
Deblock4Version
```

For Classic, either:

```text
Deblock4GridMode = "h264"
steps = 4
midpoint property omitted
```

or explicitly omit all Deblock4-grid properties and document that difference.

Also define when stderr emission occurs. "On every run" is ambiguous in a
plugin with multiple filter instances. Prefer once per filter-instance creation,
including filter name, requested backend, selected tier, and fallback reason.

---

## A4. Shared-kernel wording is ambiguous after adding a second algorithm

The decisions record says the shared kernel defaults to one
`common_math.zig`:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L295-L304
```

It later says each filter has its own algorithm and three backends:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L309-L323
```

The README says algorithm kernels and backend bodies are separate per filter:

```text
README_Deblock4_Design_Spec_v1_4.md:L131-L141
```

### Recommendation

Clarify the source layering:

```text
shared plugin/tiering/dispatch infrastructure;
shared low-level vector utility primitives where genuinely algorithm-neutral;
one canonical mathematical kernel source per filter;
v1/v2/v3 instantiations of that filter's kernel;
filter-specific movement adapters where required.
```

Do not imply one mathematical `common_math.zig` serves two different
algorithms unless that is actually intended.

---

# 6. Float-policy findings

## F1. FMA is repeatedly described as a current source of backend differences,
but current policy does not request its use

### Evidence

The tolerance rationale cites FMA accuracy gains:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L471-L476
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L72-L78
README_Deblock4_Design_Spec_v1_4.md:L183-L190
README_Deblock4_Design_Spec_v1_4.md:L850-L858
```

The strict-mode rule says ordinary `a*b+c` is not fused and there is no current
`@mulAdd` requirement:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L488-L496
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L191-L197
README_Deblock4_Design_Spec_v1_4.md:L1424-L1432
```

### Assessment

This is not necessarily a logical contradiction because explicit fused
semantics may be adopted later. It is, however, misleading as a description of
the current production plan.

### Recommendation

Use future-conditional wording:

```text
The tolerance model permits legitimate backend rounding differences and leaves
room for a future explicitly measured fused operation. Under the current
.strict/no-@mulAdd policy, FMA is part of v3 but is not expected to alter an
ordinary a*b+c expression.
```

---

## F2. Determinism wording should retain the MXCSR qualification

The charter correctly says the plugin inherits and does not modify MXCSR:

```text
AI_Charter_and_Invariants_Card_v1_11.md:L265-L266
```

The README says backend identity is required under the same inherited MXCSR
state:

```text
README_Deblock4_Design_Spec_v1_4.md:L1446
```

The decisions record more broadly promises deterministic output for a backend
on the same machine:

```text
Deblock4_Verification_And_Tiering_Decisions_v1_2.md:L282-L291
```

### Recommendation

Replace "same machine" with:

```text
same binary, selected backend, input, parameters, and inherited floating-point
environment, including relevant MXCSR state
```

Also replace the README word "identity" at line 1446 with the approved
integer-exact/float-tolerance terminology.

---

# 7. Backend-object explainer findings

## E1. The linkage mechanism remains useful, but target-policy prose is obsolete

The document accurately labels its snippets as verbatim Stage 1B.1 source:

```text
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L9-L13
```

That historical preservation is useful.

The problem is that the prose presents provisional target exclusions and FMA
removal as current design requirements:

```text
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L212-L216
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L280-L306
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L369-L384
```

Its Stage 1B.2 description also uses the obsolete closure-derivation model:

```text
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_2.md:L498-L507
```

### Recommendation

Retain the emission/linkage/PE-export explanation and verbatim historical
snippets, but add a large supersession box before section 4:

```text
The following target definitions are historical Stage 1B.1 provisional probes.
They prove object isolation and retention only. Production targets are now the
full named v1/v2/v3 levels under charter G3. FMA is not excluded from v3.
```

Delete or replace the current FMA-exclusion rationale.

Update section 7.1 to say Stage 1B.2 confirms within-level code generation.

Add a short section explaining that the same object pattern is reused for two
filters, with distinct per-filter symbol names.

---

# 8. Metadata and reference drift

## M1. Charter metadata is stale

```text
AI_Charter_and_Invariants_Card_v1_11.md:L3-L7
```

Problems:

- document date says 2026-07-25 while v1.11 history says 2026-07-28;
- companion specification says README v1.1, not supplied README v1.4;
- bootstrap header also names README v1.1.

The phrase "v1.1 or later prevailing version" conflicts with the charter's own
rule that filename and internal version are matched exactly.

### Recommendation

Issue charter v1.12 with exact current companion names and revisions.

---

## M2. Roadmap metadata is stale

```text
Deblock4_Forward_Roadmap_v1_3.md:L3-L6
```

It says aligned to charter v1.8 and README v1.1.

### Recommendation

Issue a new roadmap only after the controlling charter and README are revised.

---

## M3. Status authority and readiness lists are stale

```text
Deblock4_Project_Status_v1_3.md:L21-L53
Deblock4_Project_Status_v1_3.md:L358-L390
```

The status document references old roadmap/status versions and old charter and
README checks.

### Recommendation

Regenerate these sections from the actual handover package after the controlling
documents are final.

---

## M4. README date is inconsistent with its revision history

The README header says:

```text
README_Deblock4_Design_Spec_v1_4.md:L67-L73
```

with date 2026-07-24, while v1.4 contains decisions and companion documents dated
2026-07-28.

### Recommendation

Set the date to the actual v1.4 issue date when issuing the corrected revision.

---

# 9. Editorial and structural defects

These are not designer-policy blockers but should be corrected in the same
revision.

## P1. Stray table row in the Classic API section

A row concerning `luma_midpoint` appears after the Classic migration prose:

```text
README_Deblock4_Design_Spec_v1_4.md:L731-L755
```

Specifically line 753 belongs to the earlier Deblock4 translation table, not the
Classic section.

## P2. Duplicate `Rules:` heading

```text
README_Deblock4_Design_Spec_v1_4.md:L2095-L2098
```

## P3. "Four-document package" lists eight files

```text
Deblock4_Project_Status_v1_3.md:L358-L372
```

## P4. Undefined Stage 1C

```text
Deblock4_Forward_Roadmap_v1_3.md:L21-L25
```

No Stage 1C appears elsewhere in the supplied package.

## P5. README and charter top summaries omit Classic

The README opening and charter Part 0 need complete replacement, not a small
footnote:

```text
README_Deblock4_Design_Spec_v1_4.md:L44-L55
AI_Charter_and_Invariants_Card_v1_11.md:L12-L33
```

## P6. Charter quick-reference API covers only Deblock4

```text
AI_Charter_and_Invariants_Card_v1_11.md:L1451-L1480
```

Add both public filter names and either separate parameter summaries or a clear
reference to README sections 3.14 and 3.15.

## P7. Charter quick-reference stages omit Classic-first repetition

```text
AI_Charter_and_Invariants_Card_v1_11.md:L1420-L1429
```

Replace with the shared Stage 1 plus per-filter Classic-then-Deblock4 sequence.

---

# 10. Cross-document consistency matrix

| Topic | Charter v1.11 | README v1.4 | Decisions v1.2 | Roadmap v1.3 | Status v1.3 | Backend explainer v1.2 |
|---|---|---|---|---|---|---|
| Classic first | Missing/contradicted | New section yes; opening no | Yes | Yes | Yes, only at end | Missing |
| Initial vs eventual filter count | Says 3 old filters | Says 3, then 2, later QED | Says 2 | Says 2 | Says 2 | Algorithm count not addressed |
| Integer exact | Yes in G7; A1 broader | Yes | Yes | Not detailed | Old identity wording | Old bit-identity rationale |
| Float tolerance | G7 yes; A1/A2 no | Mixed | Yes | Not detailed | Mixed | No; old FMA-exclusion rationale |
| Decision-mask flips | Masks exact | Masks exact | Exact and allowed to flip | Not addressed | Not addressed | Not addressed |
| Full named v1/v2/v3 | G3 yes; Part 3.2 no | Yes | Yes | No, derives closures | Mixed | No |
| FMA not excluded | F2/G3/G8 yes; Part 3.2 no | Yes | Yes | Old closure text | Mixed | Explicitly no |
| One production build/backend | Implied | Yes | Yes | Not explicit | Old terms | Historical probes |
| Classic algorithm definition | Missing | Ambiguous chroma/schedule | High-level only | High-level only | High-level only | Missing |
| Per-filter stages | Missing | Says twice but contents do not fit | High-level only | High-level only | High-level only | Missing |
| Backend token semantics | Old SSE/AVX labels | Old labels | Named levels | Not settled | Old labels | Old labels |
| Current document versions | Stale companion | Self-current | Mostly current | Stale alignment | Stale authority list | Informative only |

---

# 11. Recommended designer amendment sequence

The safest order is decision-first, then controlling documents, then informative
documents.

## Step 1 - resolve four policy questions

W3D/W3X should issue explicit answers to:

```text
D1  Is the initial core delivery two filters and the eventual plugin four
    filters, or is another inventory intended?

D2  Is Classic HolyWu-compatible, H.264-standard-clean, or a specifically
    documented hybrid? What exact chroma and schedule does it use?

D3  Must numeric activation masks match exactly, or are narrowly bounded
    near-threshold activation flips accepted?

D4  What are the exact public backend tokens for v1/v2/v3?
```

No prose-only revision can safely proceed without these answers.

## Step 2 - update the decisions record

Issue `Deblock4_Verification_And_Tiering_Decisions_v1_3.md` if D3 or D4 changes
or needs clarification.

At minimum:

- remove the decision-mask contradiction;
- make policy wording apply per filter;
- state public token semantics;
- make FMA examples future-conditional;
- replace stale "outstanding designer response" language.

## Step 3 - update the charter

Issue `AI_Charter_and_Invariants_Card_v1_12.md`.

Required areas:

- header date and companion versions;
- Part 0 filter inventory and sequence;
- bootstrap pixel-path acceptance;
- A1/A2;
- G1 backend tokens;
- Part 3.1 artifact shape per filter;
- Part 3.2 named-level tiers;
- harness terminology;
- quick-reference stages;
- quick-reference public APIs.

## Step 4 - update the controlling README/specification

Issue `README_Deblock4_Design_Spec_v1_5.md`.

Required areas:

- opening project description;
- filter inventory;
- Classic normative definition and applicability table;
- HolyWu relationship scoped separately for Classic and Deblock4;
- all stale bit-identity clauses;
- `grid_mode="h264"` decision;
- backend tokens;
- per-filter frame properties and diagnostics;
- Classic and Deblock4 stage sequences;
- concise baseline section 19;
- editorial defects.

## Step 5 - regenerate status and roadmap

Issue:

```text
Deblock4_Project_Status_v1_4.md
Deblock4_Forward_Roadmap_v1_4.md
```

These should be regenerated after the controlling documents, not patched before
them.

## Step 6 - revise the backend explainer

Issue `Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md`.

Keep the Stage 1B.1 mechanical proof, but separate:

```text
historical provisional target snippets
from
current production named-level target policy
```

Add the two-filter symbol/application note.

---

# 12. Recommended provisional architecture statement

Subject to the four decisions in section 11, the following wording is the most
internally coherent expression of the apparent current direction:

> Deblock4.dll initially registers two independent filters:
> `deblock4.Classic`, implemented first, and `deblock4.Deblock4`, implemented
> second. Classic is the known H.264-derived deblocking filter used to prove the
> shared infrastructure and verification machinery before the novel MPEG-2-aware
> Deblock4 algorithm. Later QED and automatic-strength filters remain separate
> future workstreams and do not alter the initial two-filter implementation
> sequence.
>
> Each filter has its own canonical ReleaseSafe scalar algorithm oracle and one
> ReleaseFast production implementation for each declared CPU level: v1, v2, and
> v3. Mathematical source is shared across that filter's backends as far as clear
> code generation permits; backend-specific source is limited to target-specific
> entry points and data movement where the hardware shape requires it.
>
> Integer output is exact across the ReleaseSafe scalar oracle, ReleaseFast
> scalar, v2, and v3. Float output implements the same specified algorithm and is
> accepted under a designer-approved differential contract. Geometry, bounds,
> schedule, lane mapping, tail handling, non-finite handling, dispatch, and other
> structural results remain exact. The policy for near-threshold numeric
> activation flips must be stated separately and unambiguously.
>
> Production uses ReleaseFast with explicit `.strict` floating-point mode.
> Backends target full declared x86-64 v1/v2/v3 levels; v3 includes FMA and no
> feature is subtracted merely for float identity. There is no present
> `@mulAdd` requirement. Runtime dispatch checks the entire selected level and
> the required operating-system vector state before any gated backend executes.

---

# 13. Final assessment

The document set contains a sound emerging architecture, but it presently has
too much live superseded text to be safe as a coding-session package.

The most serious contradictions are:

1. old filter inventory versus Classic-first;
2. universal bit identity versus float tolerance;
3. exact decision masks versus accepted threshold flips;
4. HolyWu-compatible Classic versus universal proper-chroma rules;
5. bespoke minimal closures/FMA exclusion versus full named levels;
6. "run stages twice" versus Deblock4-specific stage contents.

These are repairable without changing the underlying project direction. The
best course is to make the four designer decisions explicit, revise the
decisions record, then issue new charter and README versions before regenerating
the roadmap, status record, and backend explainer.

No production coding scope should quote the current package as a coherent whole
until that reconciliation is complete.
