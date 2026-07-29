# Deblock4 - Designer Response to the Independent Re-audit

**Version:** 1.0
**Date:** 2026-07-29
**Status:** W3D designer response to the W3C independent re-audit
(Deblock4_Independent_Reaudit_Latest_Designer_Package_v1_0). Records what was
corrected and what was deliberately deferred. No controlling document is amended
by THIS file.
**Encoding:** US-ASCII only.

---

# 1. Summary

The re-audit was the most valuable of the three: it caught two SCOPE-BLOCKERS
that were logic defects in the rules themselves (not consistency drift), which a
consistency check alone would never have surfaced. Both are now fixed. All high
and moderate findings are also addressed.

W3X ratified the two blocker-rule rewrites (the section 20 wording) before they
were baked in. The three previously-missing durable files were supplied and
reconciled.

The full corrected package (supersedes all earlier versions):

```text
AI_Charter_and_Invariants_Card_v1_14.md
README_Deblock4_Design_Spec_v1_7.md
Deblock4_Verification_And_Tiering_Decisions_v1_5.md
Deblock4_Forward_Roadmap_v1_6.md
Deblock4_Project_Status_v1_6.md
Deblock4_Concise_Project_Summary_v1.1.md
111_New_Chat_Introduction_for_Coder_v1_5.md
Deblock4_Toolchain_Findings_v1_1.md            (unchanged; already correct)
Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3.md  (unchanged this pass)
```

Internal versions and cross-references were verified consistent across the set.

---

# 2. Scope-blockers - FIXED

```text
C1  Charter mandatory bootstrap was internally wrong and would be COPIED into
    every future scope, reinstating removed policy:
    - C1.1 companion revision "1.1" -> "1.7" (matches README v1.7);
    - C1.2 removed "1.1 or later prevailing version"; self-versions fixed to
      charter v1.14 / README v1.7;
    - C1.3 the pixel-path acceptance clause REWRITTEN from universal byte-
      identity to the per-type contract (INTEGER byte-identical; FLOAT within
      the differential contract; pure copy/share byte-identical), WITH the
      oracle-construction exception (C2) and a loose whole-image sanity gate.

C2  Oracle sequencing was CIRCULAR ("no deblocking code until the oracle exists"
    vs "Stage 2C/2D writes the code that BECOMES the oracle"). Fixed by the
    oracle-construction exception: the first Stage 2C/2D scope that CONSTRUCTS a
    filter's ReleaseSafe scalar oracle is exempt from comparison against a
    pre-existing oracle, accepted instead against independently authored scalar
    obligations plus a sanity gate; after that, all subsequent scopes are
    differentially validated against it. Applied in charter bootstrap, roadmap
    standing constraints, README section 4.2, and status. Full wording is
    decisions record section 20 (W3X-ratified).
```

# 3. High findings - FIXED

```text
H1  Charter G3 still said "1B.2 confirms the guard checks the whole level".
    Corrected: 1B.2 CONFIRMS within-level and RECORDS the requirements; the
    guard is a 1B.3 artifact. Status "dispatch produces requirements" also fixed
    (1B.2 produces them; dispatch does not).

H2  Project Status regenerated (not patched): authority block, evidence basis,
    documentation package, and readiness checks now name charter v1.14 / README
    v1.7 / decisions v1.5 / roadmap v1.6 / concise v1.1 / status v1.6; the coder
    intro is named with its exact filename+revision, not "(current)".

H3  CPU-level lists made uniform. v2 gains CMPXCHG16B and LAHF-SAHF; v3 lists
    OSXSAVE as a level MEMBER. README F10 corrected from XSAVE to OSXSAVE. A
    stated distinction now separates NAMED-LEVEL MEMBERSHIP (OSXSAVE is a v3
    member) from RUNTIME SAFETY (the guard additionally runs XGETBV and checks
    XCR0). All hand-lists marked reading aids; the authoritative source is one
    mechanism (prefer Zig std.Target).

H4  Charter "one mechanism" vs README F9 "explicit CPUID unit" reconciled: F9
    now says the explicit unit is a POSSIBLE landing point, not presumed; Stage
    1B.3 must first seek one mechanism for both target and detection, with a
    standing assertion that object tier name and detector tier name cannot
    diverge. Does not block 1B.2.

H5  stderr cadence unified to ONCE PER FILTER-INSTANCE creation across README
    and the decisions record (the decisions record's "on every run" removed).
    "Always-on" now means "not behind a debug switch", not "per frame".

H6  Decisions section 4.5 broken sentence (a heading split it) reunited.
```

# 4. Moderate findings - FIXED

```text
M1  FMA examples softened everywhere: FMA is included in the v3 target but not
    relied upon; ordinary a*b+c is not result-changing contracted under .strict;
    no @mulAdd currently required; 1B.2 must not expect FMA emission. Replaces
    the categorical "present-but-unused" with the more precise statement.
M2  Residual "identity" wording reworded (charter and README), including the
    problematic MXCSR sentence: per-backend determinism and cross-backend
    differential validation are evaluated under the same inherited float
    environment - this is NOT a cross-backend float bit-identity requirement.
M3  Fallback restated from "AVX2-but-not-v3 is v2" to "select the highest lower
    level fully satisfied, normally v2 else v1" (charter, decisions, README).
M4  README section 19 concise baseline scoped explicitly to deblock4.Deblock4;
    a note directs deblock4.Classic to its section 3.15 oracle contract (HolyWu
    is Classic's normative oracle).
M5  Public call spelling unified: lowercase deblock4.Classic / deblock4.Deblock4
    for callable filters; core.deblock4.Classic(...) shown once in section 3.15;
    "Deblock4" capitalised only as the project name.
M6  Decisions date -> 2026-07-29; the live "README v1.4" pointer de-versioned to
    a section reference.
```

# 5. Informational

```text
I1  The three previously-missing durable files were supplied and reconciled:
    - Concise summary v1.0 -> v1.1 (was a pre-session snapshot; near-total
      refresh: two-filter/Classic-first, named tiers, integer/float split,
      tokens, proper-chroma-Deblock4-only, removed h264 grid_mode);
    - 111_New_Chat_Introduction_for_Coder v1.4 -> v1.5 (charter/README/concise/
      roadmap version refs; Stage 1B.2 within-level framing; two-filter context;
      G6 PE-export phrasing corrected);
    - Deblock4_Toolchain_Findings v1.1 - reviewed, UNCHANGED. It carries only
      empirical F1-F5 toolchain facts and no stale identity/tier/filter
      language; its single version reference is historical.
```

# 6. What W3D did NOT do, and why

```text
1. Did NOT pin a specific sanity-gate metric or numeric bound for the oracle-
   construction scope. W3X's intent (catch wild corruption; goal is to reduce
   blocking, not wholesale-change) is captured as a REQUIRED but deliberately
   LOOSE tripwire with the method selected at Stage 2 - pinning one now would
   repeat the "nothing untested becomes normative" trap (charter A3). Candidate
   tooling (block-boundary discontinuity measures; change-magnitude proxies) is
   named for investigation, not adopted.

2. Did NOT change the Toolchain Findings document. It is already correct; a
   version bump with no content change would be noise.

3. Did NOT pin the HolyWu commit/tag for the Classic oracle. Still owed from
   W3X at Stage 2C (D-CLASSIC-4). Recorded as provisional.

4. Did NOT treat the sanity gate as an acceptance/quality metric. It is a
   corruption safety net only; HolyWu remains Classic's real acceptance oracle,
   and Deblock4's novel algorithm has no external oracle by design.

5. Did NOT edit historical revision-history entries. Where an old entry names a
   superseded state (e.g. charter v1.10, FMA-excluded), the current sections and
   newest revision entry carry the change; the old entry stays as history.
```

# 7. Owed / next

```text
- W3X: pin the HolyWu commit/tag for Classic's oracle (D-CLASSIC-4), by Stage 2C.
- A final mechanical package check across ALL durable files (this pass supplied
  and reconciled the three that were missing; the backend explainer v1.3 was
  unchanged this pass and should be confirmed consistent).
- Stage 1B.2 remains the active next coding scope, unchanged in substance:
  confirm each object stays within its named level, settle vzeroupper, and
  produce the whole-level requirements for 1B.3. No pixel/backend-execution code.
```

---

*W3D designer response. The charter and README prevail for any controlling rule.*
