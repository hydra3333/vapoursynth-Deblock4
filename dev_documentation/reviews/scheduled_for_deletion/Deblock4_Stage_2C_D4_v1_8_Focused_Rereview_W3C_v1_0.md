# Deblock4 - Stage 2C D4 v1.8 Focused W3C Re-Review

**Deliverable:** W3C-2C-D4-V1.8-FOCUSED-REREVIEW  
**Version:** 1.0  
**Date:** 2026-08-05  
**Author:** W3C (coder; focused pre-implementation reviewer)  
**Route:** W3C -> W3X -> W3D  
**Responds to:** W3D response v1.1 and the W3X-ratified amended Stage 2C set  
**Reviewed scope:** `Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_8.md`  
**Reviewed source base:** the attached `src(20260805-120210).zip` tree  
**Status:** FORMAL THREE-WAY SCOPE REVIEW REMAINS ACTIVE. This is the focused
re-review requested after resolution of W3C review v1.0. No implementation,
test-authoring, reference build, or delivery work has begun. W3C stops after
this report. Implementation release remains a separate explicit W3X act after
these findings resolve.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Focused mandate and materials

W3X directed W3C to review only:

```text
- the amended D4/D0/D3/bootstrap/manifest/status lines;
- the amended source boundary;
- K30 and K31;
- the W3D response v1.1 and W3X reason-token amendment
  ("intentionally-capped").
```

No D2, formula, matrix, boundary, K26 sentinel, or differential-corpus
re-derivation was performed.

Current amended files reviewed:

```text
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_8.md
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_10.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_9.md
Deblock4_Stage_2C_Session_Bootstrap_Header_v1_1.md
Deblock4_Stage_2C_Issuance_Bundle_Manifest_v1_1.md
Deblock4_Project_Status_v1_22.md
Deblock4_W3D_Response_to_W3C_Stage_2C_Preimplementation_Review_v1_1.md
```

All six amended issue files in `files(4).zip` are US-ASCII, CRLF-only, and
their filename/internal versions agree.

Attached archive hashes:

```text
files(4).zip
7ed6a36a66e038eb22ed774d69e2fec12bafce458e3fdebd8a7475af376d74c0

dev_documentation(20260805-120212).zip
5b3c96e200ae8c5818e0be5a42e898a26a4db70e2afc31e9341c05eb16602dfd

src(20260805-120210).zip
2132b44a993e01686aaa5347aba5be9a642ddf565792ea786e663ae62dd066b2
```

The current extracted source tree is byte-for-byte identical to the earlier
reviewed `src(44).zip` tree. The archive SHA-256 differs because the zip was
repacked, not because source content changed.

# 2. Amended S5 source-seam feasibility

The ratified D-2C seam is implementable within a suitably precise version of
the amended boundary:

```text
- cpu_capability_detection can stop printing while retaining all detection,
  force-down and G10 logic;
- its existing EffectiveCapabilities already carries the ACTUAL record, and
  the existing summary-reason computation can be exposed without changing
  detection semantics;
- backend_tier_selection can apply an optional filter-neutral implemented-tier
  ceiling, preserve EFFECTIVE-before-availability precedence, calculate the
  auto-resolved tier for refused explicit requests, and emit once;
- print_helper_functions can remain the sole formatting home and add the
  intentionally_capped union variant/line;
- deblock4_config can remain declarations-only and hold the ceiling data;
- Classic can use a ceiling-aware selector entry point while the existing
  no-cap Deblock4 call remains source-compatible and untouched.
```

That last point is an implementation constraint imposed by the authorised
boundary: the shared selector API must be evolved without requiring an edit to
`deblock4_instance_creation.zig`, which remains forbidden. This is feasible;
no extra existing source file is inherently required.

The exact token:

```text
reason=intentionally-capped(x86_64_v1_baseline)
```

is internally consistent across the W3X message, D4 v1.8, bootstrap v1.1,
manifest v1.1, and Project Status v1.22.

# 3. Numbered findings

## F1 - BLOCKER: T-S5-1 directly contradicts D-2C-6

D4 v1.8 correctly settles two different creation classes:

```text
D-2C-4:
    exactly one summary for attempts that reach tier selection, including
    selection refusals;

D-2C-6:
    float and 17..32-bit clip-format refusals occur before tier selection and
    emit no summary.
```

The fixed corpus consequences are explicit:

```text
N01a/N01b/N01c1/N01c2 -> no summary;
N02a/N02b/N03          -> one summary;
N04                    -> one summary.
```

However T-S5-1 currently requires:

```text
"Summary ONCE per creation attempt ... in every 2C case, success and refusal."
```

That gate would require one line for N01a/N01b/N01c1/N01c2, contrary to
D-2C-6. A conforming implementation cannot satisfy both statements, and W3C
must not choose which normative text to weaken.

### Required correction

Replace T-S5-1 with an exact split, for example:

```text
T-S5-1a  Exactly one summary for every creation attempt that reaches
          backend tier selection, whether selection succeeds or refuses.

T-S5-1b  No summary for attempts refused before tier selection, including
          N01a, N01b, N01c1 and N01c2.
```

Alternatively retain one identifier but enumerate the same two expected-count
classes. The O/G crosswalk and batch assertions must test both count 1 and
count 0.

**Disposition:** implementation release remains blocked until the proof
contract is single-valued.

## F2 - BLOCKER: D0 v1.10 still prohibits the newly authorised detection-module edit

D4 v1.8 D-2C-1 and section 7b now explicitly authorise the narrow edit:

```text
src/cpu_capability_detection.zig:
    move the summary emission out;
    expose ACTUAL tier + existing SummaryReason;
    no detection-logic change.
```

D0 v1.10 section 5 still says:

```text
"NO other validation, creation-string, detection or using-echo change."

"No change to registration, detection, G10 modules, or the using-echo
surfaces..."
```

Its narrow-exception list records the refusals, cap and precedence test but
does not record the summary-emission relocation or the new
`intentionally-capped` presentation reason.

D4 is more specific, so the intended result can be inferred, but the current
read-together authority set remains internally contradictory. A memoryless
coder could reasonably stop because D0 forbids the exact file change D4
requires.

D4 section 9 K13 also says the "1B.3 capability guard [is] untouched", which
is too broad now that its module is deliberately edited; the intended
invariant is that the guard and detection **logic/semantics** remain untouched.

### Required correction

Amend D0 section 5 to add the narrow ratified exception:

```text
- relocation of the existing summary emission from capability detection to
  final backend selection;
- exposure/transport of the already-computed ACTUAL/reason data;
- the intentionally-capped reason presentation;
- no change whatsoever to detection tables, instructions, ACTUAL/EFFECTIVE
  semantics, force-down intersection, or G10 paths.
```

Change D4 K13 to say the `1B.3 capability-detection/guard logic` is untouched,
with the D-2C-1 print-seam relocation explicitly excepted.

**Disposition:** this authority conflict should be corrected before
implementation release, not left to precedence inference.

## F3 - REQUIRED: K30's "empty" audit is not objectively defined against the attached source

K30 correctly applies C-STY-10 to the three new permanent modules. It also
requires the textual first-class audit to return empty over:

```text
the three new modules plus every existing module the scope edits.
```

The attached authorised existing files already contain permanent Stage 1C
identifiers, for example:

```text
src/classic_instance_creation.zig:
    "// Stage 1C Classic instance creation."

src/deblock4_selftest.zig:
    runStage1CPureContracts
    Stage1CAutoSelectionFailed
    stage_1c=PASS
    and further Stage1C* permanent regression identifiers

build.zig:
    multiple Stage 1C descriptions and build-step names

src/deblock4_version.zig:
    Stage 1C comment text
```

Charter C-STY-10 says first-class files/symbols/artifacts carry no stage
numbers and that stage/probe/smoke vocabulary is scaffolding vocabulary.
The amended K30 does not define the identifiers searched by the new audit.

Two materially different gates therefore fit the present text:

```text
A. search the whole stated domain for generic stage/probe/smoke vocabulary;
   this fails the unmodified attached base and would require unauthorised
   cleanup/renaming of accepted regression identifiers;

B. search only for an enumerated set of retired scaffolding file/symbol/
   marker/artifact identifiers;
   this can pass, but it does not by itself enforce the generic permanent-name
   rule on the three new modules.
```

The existing Stage 1C S2 audit uses option B for a fixed retired-filename list;
K30 says it is a distinct, fuller delivery obligation, so silently reusing S2
is not enough.

### Required correction

Define the K30 audit contract before coding, including:

```text
- exact token/identifier classes;
- exact file domain;
- case sensitivity and whether comments/strings/symbols are scanned;
- treatment of pre-existing accepted Stage 1C regression identifiers;
- the named runner gate and expected empty result.
```

A narrow non-cleanup formulation would be:

```text
1. New 2C first-class modules:
   audit filenames, declarations, symbols, marker strings and references for
   stage-number/probe/smoke vocabulary and every enumerated scaffolding
   identifier; expected empty.

2. Existing edited modules:
   prove the 2C changes introduce no new scaffolding reference and contain no
   reference to the enumerated retired scaffolding files/symbols/artifacts.
   Pre-existing accepted Stage 1C regression identifiers are not silently
   renamed in this scope unless W3D/W3X deliberately authorise that cleanup.
```

W3D/W3X may instead authorise the broader cleanup, but the present `NOTHING
ELSE` boundary does not.

**Disposition:** K30 is a sound rule, but its current proof gate is not yet
decisive or safely implementable.

## F4 - REQUIRED CLARIFICATION: K31's proof wording does not exactly match its two permitted implementations

K31 correctly offers two valid addressing models:

```text
(a) byte addressing, with byte units named at the point of use; or
(b) conversion to typed sample stride, naming both units and asserting exact
    divisibility by bytesPerSample.
```

D0 then states:

```text
"Proof: code inspection plus the conversion assertion..."
```

Under model (a), there is intentionally no typed-stride conversion and
therefore no conversion assertion. Also, "exactly ONE conversion" should be
scoped explicitly; the natural architecture is once per plane-view/stride
construction, not one global conversion for all planes or both storage types.

### Required correction

Use wording such as:

```text
- Byte-addressing implementation:
  proof by code inspection plus O-6e/O-8c/O-8h; no conversion assertion is
  applicable.

- Typed-sample-stride implementation:
  exactly one checked conversion for each plane stride/view construction,
  naming byte and sample units and asserting stride_bytes % bytesPerSample == 0;
  proof by inspection/assertion plus O-6e/O-8c/O-8h.
```

This does not change the algorithm or acceptance values; it makes K31's
alternative proof surfaces single-valued.

## F5 - NON-BLOCKING ISSUANCE AND NUMBERING CLEANUP

These do not alter the intended S5 implementation, but should be corrected in
the reissued set so the next memoryless handoff is mechanically consistent.

### F5a - bootstrap still requires retired per-file base hashes

Bootstrap v1.1 says the authorised existing files have:

```text
"declared base hashes in the manifest"
```

D4 v1.8 section 8 and manifest v1.1 explicitly retire per-file base hashes in
favour of the attached prevailing source tree. The manifest contains no such
hashes.

Replace that bootstrap phrase with:

```text
identified by the attached prevailing source tree; no per-file base hashes.
```

### F5b - the D-2C-5 label is lost in D4

W3D response v1.1 labels the amended source boundary `D-2C-5`. Project Status
v1.22 refers to D-2C-1..5 and separately to D-2C-6. D4 incorporates the
D-2C-5 content in section 7b but does not label it D-2C-5; its revision note
instead says D-2C-1..4 and D-2C-6.

Label section 7b's amended boundary as D-2C-5 or consistently remove that
identifier from the response/status. Preserving it is preferable because the
nine-decision record already cites it.

### F5c - bootstrap's broad `deblock4_*` prohibition overlaps explicit permissions

Bootstrap v1.1 explicitly permits:

```text
src/deblock4_config.zig
src/deblock4_selftest.zig
src/deblock4_version.zig
```

but later forbids "every deblock4_* filter module." Clarify that the
prohibition means the `deblock4.Deblock4` filter-path modules, with the three
explicit shared/identity exceptions above.

### F5d - manifest retains two stale current-version pointers

Manifest v1.1 still says:

```text
the bootstrap and D4 v1_7 prevail;
Project Status v1_21 section 0 prevails.
```

The current references should be D4 v1.8 and Project Status v1.22.

### F5e - response placement differs from the manifest

The manifest lists the W3D response at:

```text
dev_documentation/reviews/Deblock4_W3D_Response_to_W3C_Stage_2C_Preimplementation_Review_v1_1.md
```

In the supplied full tree, it was available only under
`reviews/scheduled_for_deletion/`, while `files(4).zip` contained the six
amended documents but not the response file. W3X's message unambiguously
identified the response, so this review could proceed. The retained review
record should be placed at the manifest's stated non-deletion path before the
next handoff.

# 4. Confirmed resolutions / no findings

The following amendments resolve the original W3C review findings in
substance:

```text
- the S5 summary seam now has an implementable owner and call order;
- implemented-tier ceiling is filter-neutral data;
- EFFECTIVE refusal retains precedence over implementation availability;
- the W3X-amended intentionally-capped token is exact and consistently used;
- failed selection attempts retain one truthful summary;
- pre-selection format refusals retain zero summaries;
- the source boundary now includes the four genuinely required shared files;
- README v1.9 is correctly recorded as fallback general guidance;
- scope release and implementation release are explicitly separated;
- per-file source-base hashes are retired while D1/K26 identity hashes remain;
- D3 v1.9 changes only its K30/K31 checklist mirror;
- no edit to `deblock4_instance_creation.zig` is inherently required;
- no additional algorithm, arithmetic, schedule, fixture or corpus work is
  introduced by the amended decisions.
```

No new Open Rule Question is proposed. F1-F5 are direct consistency and proof-
definition corrections.

# 5. Focused re-review disposition and stopping point

The original F1 source-boundary blocker is **substantively solved**, but the
amended package is not yet ready for implementation release because:

```text
- T-S5-1 contradicts D-2C-6;
- D0 still forbids D-2C-1's exact narrow source edit;
- K30's empty audit is not objectively defined against the existing tree;
- K31's alternative proof wording needs a narrow clarification.
```

W3C recommends a line-focused W3D amendment and W3X decision. No further
review of D2, formulas, matrices, boundaries, sentinels or corpus is needed
unless those materials are changed.

**W3C STOPS HERE. NO IMPLEMENTATION IS AUTHORISED OR UNDERWAY.**

---

*End of W3C Stage 2C D4 v1.8 focused pre-implementation re-review.*
