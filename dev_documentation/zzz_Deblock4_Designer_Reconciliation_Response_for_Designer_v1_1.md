Yes. The designer corrected most of the major architectural drift, but I still have several concerns after checking the **actual six revised documents**, not merely the reconciliation response.

I would **not yet accept the statement that the package is “internally consistent and safe to quote as a whole.”** 

## 1. The activation-mask contradiction remains

The intended decision is clear: structural masks remain exact, while a float-only numeric activation decision may differ very close to its threshold. 

That rule is correctly expressed in:

* `Deblock4_Verification_And_Tiering_Decisions_v1_3.md`, lines 86-124;
* charter A2, lines 186-191.

But conflicting live requirements remain:

* Charter G7, lines 520-524, says **decision masks remain exact** and tolerance applies **only to final float magnitudes**.
* README lines 190-197 says structural and decision results remain exact.
* README lines 866-869 says which edges are filtered and decision masks cannot depend on the backend.
* README line 1461 says structural/decision results stay exact.
* README lines 2457-2465 requires activation-mask agreement to match exactly and again says only final magnitudes receive tolerance.
* Decisions record lines 555-567 lists filter-activation masks and branch choices as exact, immediately before saying an activation decision may flip.

This is still a direct contradiction and affects the harness design.

**Required correction:** consistently distinguish:

```text
Exact:
    structural masks
    finite/non-finite masks
    bounds and tail masks
    plane selection
    lane mapping
    schedule and geometry

Potentially different for float only:
    numeric activation decision when the controlling value lies within the
    approved decision-boundary tolerance
```

## 2. Stage 1B.2 and Stage 1B.3 responsibilities are conflated

The designer response correctly says:

* 1B.2 confirms object code stays within each named level;
* 1B.3 implements whole-level detection and guarded dispatch. 

However:

* README lines 2048-2050 says Stage 1B.2 confirms that the guard checks the whole level.
* Roadmap lines 43-49 assigns whole-level dispatch checking to 1B.2, while lines 51-56 then assigns capability detection and dispatch to 1B.3.
* Project Status lines 436-444 also says 1B.2 confirms that dispatch checks the whole level.

Stage 1B.2 cannot prove an unimplemented Stage 1B.3 guard.

**Required correction:**

```text
Stage 1B.2:
    confirm object targets and emitted instructions remain within v1/v2/v3;
    settle vzeroupper by inspection;
    produce the exact feature requirements that 1B.3 must enforce.

Stage 1B.3:
    implement and prove whole-level CPU/OS detection, forced-backend rejection,
    fallback, and guarded dispatch.
```

## 3. Project Status v1.4 remains substantially stale

Despite its revision note saying the authority and package sections were updated, the live content still contains:

* line 37: `Deblock4_Forward_Roadmap_v1_1.md`, not v1.4;
* line 52: `Deblock4_Project_Status_v1_2.md`, inside v1.4;
* line 377: `Deblock4_Project_Status_v1_3.md`, not v1.4;
* lines 214 and 305: old “feature-closure spike” terminology;
* line 315: **FMA exclusion**, now superseded;
* lines 324-329: “after compiled feature closures are known” and old backend values `scalar`, `sse41`, `avx2`;
* lines 224-227: old generic Stage 4/5 “identity proof” names rather than the Classic/Deblock4 split;
* lines 416 and 420: “feature closures frozen” and backend “identity proved.”

This document should be **regenerated**, not patched piecemeal.

## 4. README Stage 4 still mandates universal equality

README lines 3171-3176 currently say:

```text
Stage 4 - SSE4.1 backend
...
prove scalar == SSE4.1 for all supported formats
```

That contradicts the float-tolerance decision.

It should say:

```text
INTEGER:
    scalar == v2 exactly

FLOAT:
    v2 satisfies the differential magnitude and decision-boundary contract
    against the scalar oracle, with all structural results exact
```

Stage 5 already uses the revised split more accurately.

## 5. The charter’s psABI feature lists are incomplete

The charter says the complete named levels are used and that runtime dispatch checks the entire level. However, its v2 summaries list only SSE3, SSSE3, SSE4.1, SSE4.2 and POPCNT.

The official x86-64 psABI v2 level also includes:

```text
CMPXCHG16B
LAHF-SAHF
```

The decisions record lists these correctly at lines 537-543, but the controlling charter does not. The official psABI table confirms the complete definitions. ([GitLab][1])

Similarly, the charter’s v1 summary is abbreviated.

**Required correction:** either reproduce the complete authoritative lists or mark all parenthetical lists explicitly as non-exhaustive and direct the implementation to one authoritative level-definition mechanism.

This matters because the project has chosen **whole-level dispatch**.

## 6. Backend token and frame-property cleanup is incomplete

Two stale token references remain:

* Decisions record line 645: `backend="scalar"`;
* Project Status line 328: `auto`, `scalar`, `sse41`, `avx2`.

These should use the new authoritative tokens.

The README also defines both:

```text
Deblock4Tier
Deblock4Backend
```

with the same value at lines 2230-2248. The reconciliation response described the properties as `Deblock4Filter`, `Deblock4Tier`, and `Deblock4Version`, not two duplicate backend properties. 

Because no released compatibility contract exists yet, I recommend keeping only:

```text
Deblock4Filter
Deblock4Tier
Deblock4Version
```

Duplicating `Backend` and `Tier` creates needless ambiguity about whether they might later differ.

## 7. The Classic oracle contract needs one more operational decision

The high-level decision is coherent: Classic faithfully reproduces HolyWu, including luma-on-chroma. 

But the implementation contract should specify:

* the exact HolyWu repository commit/tag;
* which HolyWu backend is the normative external oracle—preferably its C/scalar path;
* whether integer comparison against HolyWu is byte-exact;
* how float comparison against HolyWu is bounded;
* whether HolyWu’s SSE4.1 path is a second comparison target or merely prior art.

README lines 763-767 currently say Classic provides “equal-or-better” output and HolyWu **may** be used as an external cross-check. That is weaker and less precise than “faithful reproduction” with HolyWu as the oracle on all planes.

I recommend:

```text
HolyWu C/scalar at pinned commit:
    normative external algorithm oracle for Classic

HolyWu SSE4.1:
    optional corroborating implementation comparison

Deblock4 Classic v2/v3:
    always accepted against Deblock4's own ReleaseSafe Classic scalar oracle
```

## 8. FMA wording remains somewhat misleading

This is not a blocker, but several sections still cite FMA as an example of why v3 might produce a more accurate result.

Under the settled policy:

```text
@setFloatMode(.strict)
no automatic contraction
no current @mulAdd requirement
```

ordinary `a * b + c` should not become a result-changing FMA. FMA is present in the v3 tier but is expected to remain unused unless a later explicit algorithm decision introduces fused semantics.

I would change examples from:

```text
hardware accuracy gains, e.g. FMA on v3
```

to:

```text
legitimate backend evaluation differences, including any future explicitly
approved fused operation
```

That prevents a coder from thinking Stage 1B.2 should prove actual FMA emission.

## Overall assessment

I have **no fundamental objection** to the major new decisions:

* two core filters, Classic first;
* faithful HolyWu Classic;
* proper chroma only in Deblock4;
* removal of `grid_mode="h264"`;
* full declared v1/v2/v3 tiers;
* verbose public tier tokens;
* integer exactness and float differential tolerance;
* one production build per backend;
* preservation of G5/G6 and the Stage 1B.1 object mechanism.

The package is much improved. Nevertheless, the activation-mask conflict, Stage 1B.2/1B.3 overlap, stale Project Status sections, and incomplete level summaries should be corrected **before the documents are treated as a unified coding baseline**.

[1]: https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/low-level-sys-info.tex?utm_source=chatgpt.com "x86-64-ABI/low-level-sys-info.tex · master · x86 psABIs / x86-64 psABI · GitLab"
