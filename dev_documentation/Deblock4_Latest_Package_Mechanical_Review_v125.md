# Deblock4 - Independent Mechanical Review of Designer v24 Package

**Version:** 1.0  
**Date:** 2026-07-29  
**Status:** Independent W3C coder/adviser review of `from_designer_v24.zip`.
Findings only; this report does not amend any controlling document.  
**Encoding:** US-ASCII only.

---

# 1. Package reviewed

```text
111_New_Chat_Introduction_for_Coder_v1_7.md
AI_Charter_and_Invariants_Card_v1_15.md
Deblock4_Concise_Project_Summary_v1.1.md
Deblock4_Forward_Roadmap_v1_7.md
Deblock4_Project_Status_v1_8.md
Deblock4_Verification_And_Tiering_Decisions_v1_8.md
README_Deblock4_Design_Spec_v1_8.md
```

SHA-256:

```text
111_New_Chat_Introduction_for_Coder_v1_7.md
fc6e541cf1a35b3580625fdafdc3c11a484e512a326a89712ab47fd4dfc651d0

AI_Charter_and_Invariants_Card_v1_15.md
2bcc148b16088526ec973be060421e2866f7c5e15f9306900490d011b3139bbb

Deblock4_Concise_Project_Summary_v1.1.md
baa0fe0c576b93875c51efa1dfea6b1945c7c769f40374a88fa2d2611bd50803

Deblock4_Forward_Roadmap_v1_7.md
da3cf36e231e426140268bebbe277787ca46e0f8d6d0bdcf993e84f1580a8b88

Deblock4_Project_Status_v1_8.md
25d5db5563fc3f6cb618bac3cfdb10a7b373198eb3148d4bdcca0451abeca36e

Deblock4_Verification_And_Tiering_Decisions_v1_8.md
5515835c8666a82c0633be8acf098600605ff7b960c989fb4049a791413de6ca

README_Deblock4_Design_Spec_v1_8.md
9cd5ce5978587f22816481b228b4ff0076ffde2282061d2042d093cf68951923
```

All seven files are US-ASCII.

---

# 2. Verdict

The package is very close.

The architectural and controlling-rule reconciliation remains sound. No new
objection was found to:

- Stage 1B.1 complete / Stage 1B.2 active;
- the proven object-mode `export fn` plus no-gated-PE-export mechanism;
- Classic first and Deblock4 second;
- integer exactness and float differential equivalence;
- the Stage 2C/2D oracle-construction exception;
- full named v1/v2/v3 levels;
- Stage 1B.2 within-level inspection and Stage 1B.3 runtime guarding;
- `.strict`, FMA included but not relied upon, and no present `@mulAdd`
  requirement;
- OSXSAVE level membership plus the separate XGETBV/XCR0 runtime check.

Two live inconsistencies should still be corrected before treating the package
as final:

1. Project Status reintroduces the circular pre-existing-oracle rule without
   its exception.
2. The README decision-status table still says an explicit CPUID/XGETBV unit is
   expected, contradicting the controlling detection section.

The remaining findings are mechanical successor-orientation and terminology
cleanup.

No further architectural review should be required after these corrections.

---

# 3. High finding H1 - Project Status reintroduces the circular oracle rule

Current live text:

```text
Deblock4_Project_Status_v1_8.md:L199-L201

No pixel-producing or frame-construction scope, including a copy path, may pass
acceptance before the relevant filter's ReleaseSafe scalar oracle exists and
proves the integer-exact / float-tolerance contract for every affected plane.
```

Read literally, this again forbids the first Stage 2C/2D scope from constructing
the scalar oracle, because that scope is itself pixel-producing and no oracle
exists yet.

The controlling charter, README, roadmap, and decisions record correctly include
the sole oracle-construction exception. Project Status must not restate only
half of the rule.

## Required correction

Replace the paragraph with:

```text
After a filter's ReleaseSafe scalar oracle has been accepted, no subsequent
pixel-producing or frame-construction scope, including a copy/share path, may
pass without validation against that oracle under the integer-exact /
float-differential contract.

The first bounded Stage 2C/2D scope that constructs that oracle is the sole
exception: it is accepted against the independently authored scalar obligations
and corruption-sanity gate defined by the charter and decisions section 20.
```

This is in an informative document, so the controlling package is not logically
broken, but the status record is intended to guide the next scopes and should
not contain the former blocker.

---

# 4. High finding H2 - README decision table still presumes an explicit detector

Current decision-status row:

```text
README_Deblock4_Design_Spec_v1_8.md:L326

| Zig 0.16 runtime CPU detection | Open implementation spike |
  Small explicit CPUID/XGETBV unit is expected |
```

This contradicts the controlling text in README section 12.4 and F9, which now
correctly require this investigation order:

```text
1. first seek one stable named-level mechanism serving both compile targeting
   and runtime satisfaction;
2. only if unavailable, use one project-owned canonical level descriptor from
   which target construction and an explicit CPUID/XGETBV detector are derived
   or validated;
3. an explicit detector is a possible fallback, not the presumed outcome.
```

The stale table row is especially risky because the decision-status table is
designed to be read before the detailed sections.

## Required correction

Use:

```text
| Zig 0.16 runtime CPU detection | Open implementation spike |
  Prefer one named-level mechanism for target + detection; explicit
  CPUID/XGETBV is a possible canonical-descriptor fallback |
```

---

# 5. Moderate finding M1 - exact-version discipline remains inconsistent in the
successor introduction

The introduction correctly says:

```text
L381-L384:
the attached charter must identify ratified v1.15 exactly;
a future successor document is version-bumped when that exact pin changes,
rather than accepting an unspecified "or newer" attachment.
```

But it also says:

```text
L107-L108:
if a newer ratified charter exists in the repository, it prevails over the
number written here.

L479:
Deblock4_Project_Status_v1_8.md (or latest in the repository)

L481:
AI_Charter_and_Invariants_Card_v1_15.md (or newer ratified)
```

These instructions can cause a successor to combine a newer charter or status
with an introduction, README, roadmap, and decisions record that have not been
cross-reconciled to that newer version.

## Recommendation

Use exact versions throughout the handover list.

Suggested rule:

```text
If a newer ratified document exists, stop and obtain the correspondingly
version-bumped, reconciled successor package. Do not mix package generations.
```

Remove:

```text
(or latest in the repository)
(or newer ratified)
```

and replace the line 107-108 instruction with the stop-and-obtain-package rule.

---

# 6. Moderate finding M2 - Stage 1B.2 is misdescribed as an isolation/linkage
proof

Current:

```text
111_New_Chat_Introduction_for_Coder_v1_7.md:L364-L365

If you are about to perform broad cleanup or import utilities during Stage
1B.2, do not. It is an isolation/linkage proof, not a refactoring scope.
```

Isolation and one-DLL linkage were the completed Stage 1B.1 proof.

Stage 1B.2 is:

```text
within-level confirmation and assembly inspection;
vzeroupper inspection;
production of the complete requirements for Stage 1B.3.
```

## Required correction

```text
If you are about to perform broad cleanup or import utilities during Stage
1B.2, do not. It is a bounded within-level code-generation and assembly-
inspection proof, not a refactoring scope.
```

---

# 7. Moderate finding M3 - Project Status retains bespoke-closure terminology

Current historical-scope conclusion:

```text
Deblock4_Project_Status_v1_8.md:L301-L302

This scope does not freeze the final feature closures or vector widths. Those
remain measurement and code-generation questions for Stage 1B.2.
```

The named full v1/v2/v3 feature contracts are already settled. Stage 1B.2 does
not freeze or derive feature closures.

## Required correction

```text
This Stage 1B.1 scope did not freeze production vector widths or code-generation
choices. Those remain measurement and assembly-inspection questions for Stage
1B.2. The feature contracts themselves are the already-settled named full
v1/v2/v3 levels.
```

---

# 8. Minor finding P1 - duplicated Toolchain Findings reading entry

The successor introduction section 2.5 heading contains both:

```text
Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
Deblock4_Toolchain_Findings_v1_1.md
```

Then section 2.6 separately introduces
`Deblock4_Toolchain_Findings_v1_1.md` again.

Recommended structure:

```text
2.5  Retention/Export Research Package
2.6  Toolchain Findings
```

Remove Toolchain Findings from the 2.5 heading. The explanatory bodies can
otherwise remain.

---

# 9. Minor finding P2 - revision note names the wrong decisions target

The v1.7 revision note says:

```text
L505:
handover decisions ref v1.5 -> v1.7
```

The issued v1.7 body names decisions v1.8.

Use:

```text
handover decisions ref v1.5 -> v1.8
```

This is the current revision's own change record, not an older historical entry,
so it should describe the issued document accurately.

---

# 10. Package completeness

`from_designer_v24.zip` contains the seven changed/main reconciliation files.

The handover manifests also require:

```text
Deblock4_Toolchain_Findings_v1_1.md
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md
Scopes/Deblock4_S1B1_Retention_Export_Research_Package_v1_0.md
```

If v24 is only a changed-document delivery, this is acceptable.

If it is intended to be the actual Stage 1B.2 successor handover archive, it is
not complete. The final handover must also contain the formal Stage 1B.2 scope
and exact source/test baseline.

---

# 11. Confirmed resolved from the previous mechanical review

The v24 package correctly fixes:

- the README reading focus from Stage 1B.1 to Stage 1B.2;
- the active-stage cleanup warning number;
- the open "final feature closures" wording in the successor's current-position
  paragraph;
- the "freeze feature contracts" warning;
- the exact charter v1.15 verification item;
- the decisions record's required-reading entry;
- current status/decisions/introduction filenames in the Project Status package
  list;
- current charter v1.15 references in the Project Status completed table;
- the stale README v1.7 pointer in the decisions record.

These corrections are substantive and correct.

---

# 12. Recommended final correction set

A small revision set should be sufficient:

```text
111_New_Chat_Introduction_for_Coder_v1_8.md
    exact-version discipline;
    Stage 1B.2 description;
    duplicate reading entry;
    v1.7 revision-note decisions version.

Deblock4_Project_Status_v1_9.md
    oracle-construction exception;
    remove final-feature-closure wording.

README_Deblock4_Design_Spec_v1_9.md
    CPU-detection decision-table row.
```

The charter, roadmap, decisions record, and concise summary do not require
changes for the findings in this pass.

After those corrections, assemble the complete Stage 1B.2 handover archive and
perform one exact-string/version scan. I expect that to be the final mechanical
confirmation.
