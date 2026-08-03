# Deblock4 - Stage 2C v1.4 Package W3C Review

**Deliverable:** W3C-2C-V1.4-PACKAGE-REVIEW  
**Package reviewed:** `reference(10).zip`  
**Version:** 1.0  
**Date:** 2026-08-03  
**Author:** W3C (coder, independent reviewer)  
**Route:** W3C -> W3X -> W3D  
**Status:** DOCUMENTATION REVIEW ONLY. D4 remains unreleased. No implementation
has begun.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Current package reviewed

Only the highest-version, non-superseded files were used:

```text
Deblock4_Creation_Error_Message_Table_v1_4.md
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_8.md
holywu_r9/README_provenance_v1_3__replaces_holywu_r9_README_provenance.md
holywu_r9/SHA256SUMS.txt and the four pinned upstream files
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_4.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_6.md
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_4.md
Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_1.md
Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_1.md
```

Everything under `superseded_do_not_use_files_in_this_folder/` was excluded.

The independent section-0 sweep also re-used the available complete
non-superseded documentation set from `dev_documentation(12).zip`, with the
current reference package taking precedence wherever it is newer.

# 2. Confirmed corrections and independent checks

The package resolves the main findings from the preceding review:

- valid 17..32-bit integer input now has a dedicated refusal policy and row;
- both 16-bit and 32-bit float refusals are represented;
- normal explicit-v3 unavailability is separate from EFFECTIVE-tier
  precedence;
- D0 K24 now carries the ratified non-speculative S7 model;
- D2 marks the Stage 2C float decision resolved;
- D3 adds O-1d/K29 and names all three Stage 2C creation rows;
- provenance and Addendum A use the accurate K26 signed-shift distinction.

Independent verification completed:

```text
D1 upstream hashes:
    all four match SHA256SUMS.txt exactly.

D1 upstream EOL:
    byte-pinned LF files remain LF-only and unchanged.

Current Markdown:
    every current file is US-ASCII and CRLF-only.

Addendum A:
    all six fixtures reproduce the exact documented four changed samples;
    no unintended sample changes.

Addendum B:
    all printed non-vacuity counts reproduce exactly:
      C01 3028; C03 3287;
      C09 1596; C10 2881; C11 1596; C12 2881;
      C13 3311; C14 3367; C15 3591;
      YUV420P8 chroma 32x32: 680;
      YUV422P8 chroma 32x64: 1442.

    unprinted selected-plane counts are also nonzero:
      C16 Y=3311, U=747, V=747;
      C17 Y=1061, U=215, V=215.
```

No scalar formula, exact vector, schedule, boundary matrix, sentinel fixture,
or comparison-corpus count needs correction.

# 3. Numbered findings

## F1 - BLOCKER: the third Stage 2C creation row is not consistently authorised

The package now contains THREE Stage 2C Classic additions:

```text
Classic: float input is not supported
Classic: integer input must be between 8 and 16 bits
Classic: requested backend is not available in this build
```

Several current operative passages still say or authorise only two:

### Creation-error table v1.4

```text
status:
    v1.2 ADDS two Classic rows

purpose:
    v1.2/v1.3 add and document the two Stage 2C Classic rows

section 2a:
    "These two rows exist ..."

proof status:
    "both rows are exercised ..."
```

The table itself then contains three rows. This creates an authority ambiguity:
the new integer-depth row is present, but the controlling status/purpose text
does not clearly ratify it as the third addition.

### D4 v1.4

The section-1 no-touch exception enumerates:

```text
float refusal;
backend-unavailable refusal;
implementation-availability cap;
precedence test.
```

It omits the integer-depth refusal.

Section 7b authorises Classic creation/validation only to add "the two
ratified refusals (S1, S5)", again omitting K29/O-1d.

The K16 checklist says "the TWO added Classic rows" while listing all three.

### Required correction

Remove the numeric ambiguity and enumerate the exact authorised set
consistently:

```text
1. float-input refusal;
2. valid 17..32-bit integer-depth refusal;
3. explicit unimplemented-backend refusal;
4. Classic implemented-tier availability cap;
5. EFFECTIVE-tier-over-availability precedence proof.
```

The first three are creation-error rows. Items 4-5 are resolution/proof
changes, not additional strings.

Correct the creation-error table status, purpose, section heading/text and
proof-status wording to say THREE rows and identify v1.4 as the revision that
adds the third.

Correct D4 section 1, section 7b and K16 so the integer-depth validation change
is unmistakably in scope.

## F2 - BLOCKER: Addendum B's "exact" integer-depth case is neither exact nor sufficient to judge 17..32

Addendum B promises an EXACT authority-fixed invocation matrix, but N01c says:

```text
GRAY17 or GRAY32
```

D3 O-1d likewise requires an otherwise-valid 17-bit **or** 32-bit case.

This leaves the coder to choose the test after scope release and does not judge
the full required refusal domain. A defective implementation that rejects only
the chosen depth can pass.

### Required correction

Fix exact cases, preferably:

```text
N01c1  GRAY17 integer -> exact integer-depth refusal
N01c2  GRAY32 integer -> exact integer-depth refusal
```

These prove the first unsupported depth and the highest valid VapourSynth
integer depth.

Also add a direct validation/guard test enumerating every integer depth
17..32. The two end-to-end boundary cases prove the real creation path and
exact message; the exhaustive direct test closes the internal range.

Specify the clip construction instead of relying on an assumed preset alias,
for example the exact equivalent of:

```python
fmt17 = core.query_video_format(vs.GRAY, vs.INTEGER, 17, 0, 0)
fmt32 = core.query_video_format(vs.GRAY, vs.INTEGER, 32, 0, 0)
```

and use their format IDs to construct otherwise-valid constant-format clips.

Addendum B N04 also says `auto (any case above C01-C17)`. Since the addendum
claims an exact matrix and D4 H6 requires the exact invocation list, choose one
fixed case, such as the C01 source with `backend="auto"`.

### H4 proof-surface correction

D4 H4 currently groups "unsupported or inconsistent format metadata" and then
says W3C confirmed reachability. Split the cases:

```text
valid integer 17..32:
    invocation-level; exact dedicated refusal row;

internally inconsistent metadata:
    direct guard/unit test unless a real API path is separately shown;
    existing metadata-invalid row.
```

Only the valid out-of-domain integer format has been confirmed reachable.

## F3 - REQUIRED D3 CORRECTION: D3 still does not fully state the proof that judges the delivery

D3 is explicitly the independent document that judges the constructed oracle.
Its current proof language is less complete than the read-together D4 package.

### F3a - proof routing names only O-1b

Section 1 says:

```text
public creation/error O-items (O-1b) -> vspipe/batch end-to-end
```

It must include O-1d and the section-8 float refusals.

### F3b - float proof still requires only one case

D3 section 8 says the float row is proved by an otherwise-valid
constant-format float-input case. The current controlling proof requires both
16-bit and 32-bit float so a storage-width-specific bug cannot pass.

State explicitly:

```text
YUV444PH (or another fixed 16-bit-float format);
YUV444PS (or another fixed 32-bit-float format);
both produce the same exact float-refusal row.
```

Prefer the exact Addendum-B formats rather than alternatives.

### F3c - integer-depth proof uses "17-bit or 32-bit"

Align O-1d with F2: fixed 17-bit and 32-bit creation cases plus the exhaustive
17..32 direct guard test.

After these edits, D3 itself is sufficient and unambiguous rather than relying
on a reader to merge stronger proof details from Addendum B.

## F4 - BLOCKER: D4's first in-scope item still carries the superseded K24 requirement

D4 section 1 item 1 still requires the scalar kernel to be:

```text
authored per K24 so the SAME body can later be instantiated for v2/v3
widths WITHOUT rewriting it
```

Later S7 and A1 correctly say:

```text
one canonical non-duplicated formula body;
clean scalar boundary;
NO speculative width/vector API in 2C;
4C may mechanically generalise the boundary.
```

The section-1 wording is operative and can reasonably be read as requiring a
width-instantiation shape now - the exact requirement S7 superseded.

### Required correction

Replace section-1 item 1 with the S7/A1 form, for example:

```text
src/classic_scalar_kernel.zig - one canonical, non-duplicated edge-formula
body, instantiated only for the exact u8/u16 scalar storage types in Stage
2C, behind a clean scalar boundary. No width-generic or vector API is required
or authorised in 2C.
```

D3 K24 should also point directly to the ratified S7 form rather than saying
D4 is free to author an unspecified "shared-kernel comptime shape".

## F5 - MATERIAL: one K26 classification error remains in D2

D2 v1.4 WP-1 correctly explains that negative signed right shift and negative
signed left shift are different classes. Its summary line still says:

```text
K26: mandatory DLL hash + negative-delta behavioural sentinels + rebuild rule
```

That is the stale terminology the current package otherwise corrected. B4 is
not a negative-`q0-p0` / negative-left-shift case.

### Required correction

Use the package-wide wording:

```text
K26 signed-shift behavioural sentinels:
    B2/B5 negative-left-shift UB probes;
    B4 negative-right-shift side-delta probe.
```

This is a local D2 wording correction; no arithmetic or fixture changes are
required.

## F6 - NON-BLOCKING GOVERNANCE / AUTHORITY CLEANUP

These do not change implementation behaviour, but should be cleaned before the
package is called final:

1. D3 Q1 says the clamp question is resolved and W3X-ratified, but its retained
   historical block still ends `STATUS: open for W3X ratification`. Mark the
   historical status explicitly as superseded, or set current status to
   `RESOLVED; remove from register on D4 release`.

2. Addendum A's purpose points to D4 v1.2 H3(b), and Addendum B points to D4
   v1.3 H6. Use version-neutral `D4 H3(b)` / `D4 H6`, or the current v1.4
   authority.

3. The current D2/D3/provenance checklist headings still name old D0 versions.
   Since their bodies already use K29/current decisions, update the headings
   to D0 v1.8 to avoid suggesting an obsolete index baseline.

4. The creation-error table metadata still attributes Stage 2C additions only
   to v1.2 and its section heading remains "v1.2" despite the v1.4 third row.
   This overlaps F1's authority correction.

# 4. Knowledge sweep and Open Rule Questions

The independent sweep found no new missing technical K-item beyond K29, which
is now present.

No new Open Rule Question is warranted. The findings above are direct
authority, scope-boundary and proof-completeness corrections, not competing
design policies.

Q2 and Q3 have not reached their triggers because this review found
corrections rather than only optional additions.

# 5. Release recommendation

Do not release D4 v1.4 yet.

The bounded corrections are:

1. consistently ratify and authorise all THREE creation rows;
2. make the integer-depth refusal proof exact and cover the 17..32 domain;
3. align D3's judging/routing language with the current proof matrix;
4. remove the remaining superseded K24 width-instantiation wording;
5. correct D2's final `negative-delta` K26 summary;
6. clean the residual governance/version pointers.

No formula, vector, matrix, boundary, sentinel, provenance hash, EOL, or
differential non-vacuity calculation needs another derivation review unless it
is changed.

---

*End of W3C Stage 2C v1.4 package review.*
