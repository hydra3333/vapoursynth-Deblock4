# Deblock4 - Designer Reconciliation Response for Coder

**Version:** 1.0
**Date:** 2026-07-29
**Status:** W3D designer response to the W3C consistency audit
(zzz_Deblock4_Document_Consistency_Audit_for_Designer_v1_0). Informative;
records what was reconciled and what was deliberately NOT done, so the coder can
verify the package is now internally consistent. No controlling document is
amended by THIS file.
**Encoding:** US-ASCII only.

---

# 1. Summary

The audit was substantially correct. Its core finding - new decisions were
inserted without removing superseded live text, leaving several controlling
sections mutually contradictory - was accurate and is the thing that has now
been fixed. Thank you; it caught real defects, including two places (charter
A1/A2 and README section 12.8) where live prose instructed the OPPOSITE of a
committed decision.

W3X ruled the four blocker questions. All six documents were then reconciled in
the audit's recommended order (decisions -> charter -> README -> roadmap ->
status -> explainer). The package is now internally consistent and safe to quote
as a whole.

Current controlling/durable set (supersedes everything earlier):

```text
AI_Charter_and_Invariants_Card_v1_12.md
README_Deblock4_Design_Spec_v1_5.md
Deblock4_Verification_And_Tiering_Decisions_v1_3.md
Deblock4_Forward_Roadmap_v1_4.md
Deblock4_Project_Status_v1_4.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
```

---

# 2. The four W3X decisions (these drove the reconciliation)

```text
D1  Filter inventory: TWO core filters this project - deblock4.Classic (built
    FIRST) and deblock4.Deblock4 (the MPEG-2 end goal, SECOND). QED variants
    (Deblock4_qed, Deblock4_qed_autoadjust) are SEPARATE later workstreams and
    do not change the two-core sequence.

D2  Classic definition: Classic is a FAITHFUL reproduction of HolyWu's Deblock,
    INCLUDING its luma-formula-on-chroma behaviour. Rationale (W3X): Classic's
    value is being the known, externally-verifiable reference (HolyWu as an
    oracle on ALL planes); "improving" its chroma would break that cross-check.
    "Proper chroma" is a DEBLOCK4-ONLY feature. (Recorded as D-CLASSIC-1/2 in
    the decisions record.)

D3  Activation masks: the decision-mask "contradiction" is resolved by SPLITTING
    two things the old wording conflated. STRUCTURAL results stay EXACT always
    (integer and float). The NUMERIC ACTIVATION decision (does a float value
    fall below its threshold) is NOT structural; for FLOAT paths only, it may
    flip near the threshold within a decision-boundary tolerance, which W3X
    accepts for this material. Integer paths show ZERO activation differences.
    The harness reports/bounds flips separately from magnitudes.

D4  Public backend tokens (verbose, unmisreadable):
        "auto"
        "x86_64_v3_with_avx2"
        "x86_64_v2_with_sse41"
        "x86_64_v1_baseline"
    These govern the backend parameter, frame properties, stderr emission, test
    selectors, and error text. Prose may add an "AVX2-class" gloss; the token is
    authoritative.
```

Also settled: D-CLASSIC-3 - grid_mode="h264" is REMOVED from Deblock4 (Classic
owns the H.264 grid use case).

---

# 3. What W3D DID (per audit finding)

```text
B1/P5  Filter inventory reconciled. Charter Part 0 and README opening rewritten
       to the two-core (Classic-first) + QED-later inventory. The old
       "Deblock4 = HolyWu, built first" opening and the "three filters" charter
       block are gone.

B2     Charter A1/A2 REWRITTEN. The pinned card no longer mandates universal
       float bit-identity. A1 now states per-filter: integer byte-exact across
       ReleaseSafe scalar / ReleaseFast scalar / v2 / v3; float same-algorithm
       within the approved differential contract. A2 restricts backend-visible
       effects to float magnitudes and the near-threshold numeric activation
       decision, never structural results. "differential identity harness" ->
       "independent differential correctness harness" throughout.

B3     Decision-mask contradiction resolved by the structural-vs-numeric-
       activation split (D3). Applied in the decisions record (3.4/3.5, and the
       tolerance metrics in 3.8), the charter (A2, G7), and the README
       (validation sections).

B4     Classic defined precisely (D2). Decisions record section 8.2 carries
       D-CLASSIC-1/2/3; README section 3.15 and the charter Part 0 scope the
       chroma/schedule per filter (Classic = HolyWu incl. luma-on-chroma;
       Deblock4 = proper chroma). A per-filter applicability note was added.

H1     Old CPU-tier policy removed from live text. Charter Part 3.2 rewritten to
       named psABI levels used in full; the "smallest tested closure" and
       "FMA excluded" language is superseded. F2 already prevented contraction
       via .strict.

H2     Backend tokens set to the D4 scheme in charter G1 + quick-ref, decisions
       record 4.5.1, and README (decision table, backend parameter, section
       12.6, test selectors, error/prose).

H3     Stages split. README section 20 now has shared Stage 1, then a Classic
       series (2C..5C) and a Deblock4 series (2D..5D); the existing stage bodies
       define the 2D..5D content. Charter and roadmap quick-refs match.

H4     README universal-identity clauses replaced with the integer-exact /
       float-tolerance split at every live occurrence (section 1.1 area, 4.2
       both identity blocks, the analyser section, the accidental-difference
       block, the section 19 summary, the Stage identity line).

H5     Roadmap regenerated (v1.4): 1A.1/1B.1 marked COMPLETE, 1B.2 reframed as
       named-level CONFIRMATION, whole-level dispatch, Classic-then-Deblock4
       stages, current metadata. Stale "1A.1 NEXT / source does not build",
       undefined "Stage 1C", and closure-derivation language removed.

H6/M3  Project status (v1.4): authority block and documentation-package section
       updated to the current versions (was stale at charter v1.9 / README v1.1
       and listed a "four-document package" of eight files). The "Not
       implemented" list split into shared / Classic / Deblock4 backend entries.

A1     grid_mode="h264" removed from Deblock4 everywhere (enum, grid table, the
       later named-choices list) with a pointer to Classic.

A3     Per-filter frame properties added (Deblock4Filter, Deblock4Tier,
       Deblock4Version; Classic omits the grid properties). stderr emission
       changed to ONCE PER FILTER-INSTANCE creation, naming filter, requested
       backend, selected tier, and fallback reason.

A4     Shared-kernel wording clarified: ONE canonical mathematical kernel PER
       FILTER (not one common_math for both algorithms); shared infrastructure
       and genuinely-neutral vector primitives are separate.

E1     Backend-object explainer (v1.3): verbatim Stage 1B.1 snippets kept, with
       a SUPERSESSION NOTICE before section 4 and a replacement of the section
       4.3 FMA-exclusion prose; section 7.1 -> within-level confirmation, 7.2 ->
       whole-level dispatch; new section 7.5 on the two-filter symbol pattern.

F2     Determinism wording now cites the inherited floating-point environment
       (including MXCSR) rather than "same machine", in the decisions record and
       README.

M1/M2/M4  Metadata refreshed: charter date 2026-07-29 and companion README
       reference to v1.5; README date 2026-07-29; roadmap aligned to charter
       v1.12 / README v1.5.

P1     Orphaned luma_midpoint table row removed from the README Classic section.
P2     Duplicate "Rules:" heading removed; stale force_sse41/force_avx2 test
       selectors renamed to the D4 tokens.
P6/P7  Charter quick-reference now lists both filters' APIs and the shared
       Stage 1 + per-filter Classic-then-Deblock4 sequence.
```

Additional live-contradiction W3D found and fixed while reconciling (not a
numbered audit item): README section 12.8 still carried the FALSIFIED v1.9 G6
story ("gated functions are NOT declared with the export keyword"). It was
rewritten to the corrected, proven mechanism (gated code IS export fn in its own
object, kept out of the DLL root graph, reached by @extern, never PE-exported),
matching charter v1.10+ and the explainer.

---

# 4. What W3D did NOT do, and why (so the coder "gets it")

```text
1. Did NOT switch the public backend tokens to terse "v3"/"v2"/"v1".
   WHY: W3X chose the verbose, unmisreadable form (x86_64_v3_with_avx2, etc.).
   The audit offered terse tokens as preferred; W3X ruled otherwise because the
   tokens appear in error text and diagnostics a confused user reads, where
   "cannot be misconstrued" beats "short". The audit's fallback ("document that
   the token means the whole level") is honoured via the prose gloss.

2. Did NOT make Classic use "proper chroma" / standards-clean H.264.
   WHY: D2. Classic reproduces HolyWu FAITHFULLY, including luma-on-chroma, so
   HolyWu stays a valid external oracle on all planes. Proper chroma is a
   Deblock4 feature. If you implement Classic expecting spec-correct chroma,
   that is WRONG - match HolyWu, imperfections included.

3. Did NOT keep grid_mode="h264" on Deblock4 as an alias for Classic.
   WHY: D-CLASSIC-3. Different algorithms; an alias would mislead. The H.264
   grid is reached only via deblock4.Classic.

4. Did NOT fully duplicate every Stage 2..5 body into separate C and D copies.
   WHY: the existing stage bodies ARE the Deblock4 (2D..5D) content; the Classic
   (2C..5C) series is defined compactly alongside because Classic is the simpler
   algorithm (no grid_mode, no midpoint, no Schedule A/B, a short compatibility
   gate instead of an algorithm-selection phase). If you need a Classic stage
   spec, expand 2C..5C from that compact definition - do not assume the long
   Deblock4 stage text applies to Classic unchanged.

5. Did NOT freeze any tolerance NUMBERS.
   WHY: only the tolerance METHODOLOGY is settled (metrics, evidence set, the
   structural-exact / numeric-activation-bounded / magnitude-bounded split).
   The values require real kernels and are a Stage 2 (per-filter) task. Do not
   expect numeric tolerances in these documents yet.

6. Did NOT change any Stage 1B.2 / 1B.3 CODE requirement.
   WHY: the reconciliation was documentation-only. 1B.2 remains "confirm each
   object stays within its named level (and settle vzeroupper by inspection)";
   1B.3 remains "whole-level detection + guarded dispatch". No new retention or
   dispatch machinery was introduced. The next coding scope is unaffected in
   substance - only its target-policy vocabulary changed (named levels, not
   bespoke closures).

7. Did NOT alter the verbatim Stage 1B.1 source snippets in the explainer.
   WHY: they are the historical linkage/retention proof and remain accurate for
   what they prove. A SUPERSESSION NOTICE now marks their TARGET definitions as
   provisional; the emission/linkage/PE-export mechanism is unchanged. Do not
   "correct" the snippets to named levels - they are a historical record.

8. Did NOT touch G5, G6, the one-DLL object architecture, the @extern anchor
   mechanism, or integer/structural exactness.
   WHY: none of these changed. The reconciliation relaxed only cross-backend
   FLOAT bit-identity (to same-algorithm-within-tolerance) and replaced bespoke
   closures with named levels. Execution safety and export discipline are
   intact.

9. Did NOT edit historical revision-history entries in any document.
   WHY: they are the audit trail of what was decided when. Where an old entry
   describes a now-superseded state (e.g. an early FMA-exclusion note), the
   CURRENT sections and the newest revision entry record the change; the old
   entry stays as history. Read the latest revision entry, not an old one, for
   current policy.
```

---

# 5. Verification pointers for the coder

```text
- Integer vs float contract: charter A1/G7; decisions record 3.1/3.2; README 1.1.
- Structural-exact vs numeric-activation-flip: decisions 3.4/3.5; charter A2/G7;
  README validation sections.
- Named tiers + whole-level dispatch: charter G3/Part 3.2; decisions 4.1-4.3;
  README 12.3.
- Backend tokens: charter G1/quick-ref; decisions 4.5.1; README backend param.
- Two filters / Classic-first: charter Part 0; README 1.0/3.15/20; decisions 8.1/8.2.
- R76/G9 miscompile guard: charter G9; decisions section 5; README 14.3.
- Backend-object mechanism (unchanged): explainer v1.3 (with supersession note).
```

If any residual contradiction remains, flag it against this list - the intent is
that every item above now reads consistently across all six documents.

---

*W3D designer response. The charter and README prevail for any controlling rule.*
