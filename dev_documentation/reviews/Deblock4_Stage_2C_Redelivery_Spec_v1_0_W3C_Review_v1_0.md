# Deblock4 - Stage 2C Redelivery Specification v1.0 W3C Review

**Deliverable:** W3C-2C-REDELIVERY-SPEC-REVIEW  
**Version:** 1.0  
**Date:** 2026-08-10  
**Author:** W3C  
**Route:** W3C -> W3X -> W3D  
**Reviews:** `Deblock4_Stage_2C_Redelivery_Specification_v1_0.md`  
**Status:** PRE-AUTHORING REVIEW. W3C has not begun the replacement delivery.
The underlying D4 v1_9 Stage 2C technical scope is not reopened.  
**Encoding:** US-ASCII; CRLF.

---

# 1. Overall assessment

The redelivery direction is strongly preferred and is technically compatible
with the already-reviewed Stage 2C implementation:

```text
- manual W3X copy of apply_to_tree;
- no apply/restore/K30 PowerShell machinery;
- no patch package;
- restore_to_base retained as inert data only;
- K30 discharged as authoring evidence plus independent W3D verification;
- external HolyWu scalar build driver converted to CMD;
- reviewed Classic implementation retained byte-identical.
```

K30's new evidence routing is clear and implementable. The canonical
thirteen-name source is objectively available in the retained Stage 1C S2
audit, so W3C does not need a new policy decision there.

Three specification inconsistencies should be corrected before W3C authors the
replacement package.

# 2. Findings

## F-1 - BLOCKER: "NO POWERSHELL ANYWHERE" / "ONE script total" conflicts with the pinned build runner

Section 1 says:

```text
NO POWERSHELL ANYWHERE IN THE PACKAGE.
...
ONE script total: the MSVC reference-build driver, as a .cmd.
```

Section 2 simultaneously requires:

```text
build_2C_v1.bat:
    REMOVE the K30-audit invocation step and its preflight existence check.
    NOTHING ELSE CHANGES.

run_stage_2c_holywu_reference.cmd:
    remains in the package and is minimally changed.
```

The retained, reviewed `build_2C_v1.bat` contains multiple PowerShell
invocations unrelated to K30, including:

```text
- semantic-version/stage-marker extraction;
- lifecycle trace scan;
- perturbation-file edit;
- scalar-only source scan;
- Classic no-padding source scan;
- K31 source scan;
- crosswalk-completeness scan;
- ReleaseSafe/ReleaseFast hash comparison;
- existing Stage 1C S1/G10/S2/S3 .ps1 audit invocations;
- version/identity scan.
```

Therefore W3C cannot both:

```text
(a) leave build_2C_v1.bat unchanged except for K30; and
(b) deliver a package with no PowerShell use anywhere.
```

Also, the package necessarily contains at least:

```text
build_2C_v1.bat
tools/holywu_reference/run_stage_2c_holywu_reference.cmd
tools/holywu_reference/build_holywu_r9_scalar.cmd
```

so "ONE script total" is not literally compatible with sections 2 and 4.

### Required W3D/W3X ruling

Please state which meaning is intended.

The small-round interpretation appears to be:

```text
- no Stage-2C-authored/shipped .ps1 machinery;
- specifically no apply, restore, K30-audit, or HolyWu-build .ps1;
- existing already-reviewed PowerShell calls inside build_2C_v1.bat, and its
  calls to pre-existing Stage 1C audit scripts in the repository, remain
  unchanged except that the K30 invocation/preflight is removed;
- build_holywu_r9_scalar.cmd is the one NEW replacement build-driver script,
  not the only script in the package.
```

If W3X instead means literally no PowerShell invocation/dependency anywhere in
the Stage 2C runner, the redelivery ceases to be the specified small round:
`build_2C_v1.bat` and several retained proof gates require substantial
translation and re-review.

W3C will not choose between those meanings.

## F-2 - BLOCKER: package counts and the stated W3C authoring surface do not reconcile

Section 1 says:

```text
apply_to_tree/ (22 files)
```

The explicit file lists instead yield 21 repository files.

After the retired K30 PS1 is dropped, the apply tree is:

```text
10 REPLACES
 3 new first-class modules
 1 crosswalk
 1 Stage 2C obligations VPY
 1 HolyWu differential VPY
 1 reference-build schema
 1 build_2C_v1.bat
 1 new HolyWu build CMD
 1 HolyWu run CMD
 1 HolyWu README
---------------------------
21 files
```

There is a second related mismatch.

Section 2 labels:

```text
BYTE-IDENTICAL (18 files)
CHANGED (4 files - the entire W3C authoring surface this round)
```

But the crosswalk is explicitly required to change its single K30 row.
Therefore it cannot be a whole-file byte-identical member, and it is part of
the W3C authoring surface.

Using the enumerated requirements, the mechanically consistent split is:

```text
16 whole-file byte-identical apply files:

    10 REPLACES sources
     3 first-class modules
     1 stage_2c_classic_obligations.vpy
     1 stage_2c_holywu_diff.vpy
     1 reference-build-record-schema.json

 5 changed/authored apply files:

     tests/Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md
       (K30 row only)

     build_2C_v1.bat
       (K30 invocation + preflight only)

     tools/holywu_reference/build_holywu_r9_scalar.cmd
       (new replacement for the retired .ps1)

     tools/holywu_reference/run_stage_2c_holywu_reference.cmd
       (minimal .cmd invocation delta)

     tools/holywu_reference/README.md
       (minimal reference-build/K30 evidence-routing delta)

---------------------------
21 apply_to_tree files
```

Separately:

```text
restore_to_base/ = 10 byte-identical HEAD base copies
```

Section 6's "18-file identical set + restore_to_base" repeats the same count
problem.

### Required correction

Please confirm/correct the intended counts and authoring surface. W3C
recommends the 16 + 5 = 21 formulation above if it reflects W3D's intent.

This matters because the specification expressly makes any unexpected
byte-difference a review finding; the byte-identity set therefore needs to be
mechanically unambiguous.

## F-3 - REQUIRED WORDING CORRECTION: "git appears nowhere" conflicts with the mandatory manual backout block

Sections 1 and 5 correctly establish the process distinction:

```text
- no git in package machinery;
- manual W3X backout is carried in the manifest;
- the manual block includes ten `git restore`/`git checkout` commands.
```

However section 5 also requires the manifest to state:

```text
"git appears nowhere."
```

That literal statement cannot coexist with the mandatory git-based manual
backout command block in the same manifest.

### Required correction

Use the narrower statement:

```text
No executable delivery/validation machinery invokes git.
Git commands appear only in the manifest's optional MANUAL W3X backout block.
```

No policy decision appears necessary; this looks like wording only.

# 3. No-finding areas

W3C finds no ambiguity requiring designer action in:

```text
- wholesale retirement of delivery v1.0 and the F-1 rider;
- continued authority of D4 v1_9 and its read-together set;
- manual copy application model;
- inert restore_to_base three-purpose model;
- K30 two-part evidence domain and W3D independent re-verification;
- use of all thirteen canonical S2 retired basenames;
- removal of K30 from build_2C_v1.bat;
- HolyWu CMD requirements: pre-hash, scalar-only deblock.cpp /O2 build,
  post-hash, DLL hash and preliminary record;
- C-DELIV-07 ownership: W3X alone executes validation and supplies evidence.
```

# 4. Disposition

The new redelivery design is substantially simpler and preferable to the
retired package machinery.

W3C requests resolution of F-1 and F-2 before authoring because each presently
gives mutually incompatible mechanical instructions. F-3 can be corrected in
the same line-focused response.

Once those three points are resolved, W3C expects the replacement authoring
round to be small and deterministic; no Stage 2C algorithm or proof-mathematics
re-review should be necessary.

**W3C STOPS BEFORE AUTHORING pending W3D/W3X response.**

---

*End of W3C Stage 2C Redelivery Specification v1.0 review.*
