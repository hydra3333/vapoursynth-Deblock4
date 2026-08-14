# Deblock4 - Session Bootstrap Header (stage-agnostic)

**Version:** 1.0
**Date:** 2026-08-13
**Supersedes:** Deblock4_Stage_2C_Session_Bootstrap_Header v1_0/v1_1 (a
DIFFERENT FILENAME - this stage-agnostic document starts fresh at v1.0;
the old Stage-2C-named headers' base-identification provisions predate
charter v1.27 and their file lists were 2C-specific; per-stage file lists
now live in each stage's scope).
**Purpose:** the standing header W3X issues at the start of a coding session,
ahead of (or alongside) the stage scope. Everything stage-specific arrives
with the scope; this header carries only what is constant.
**Encoding:** US-ASCII; CRLF.

---

```text
Project:
    Deblock4 - a Zig 0.16.0 VapourSynth API4 plugin (one Windows x64 DLL,
    two filters: deblock4.Classic and deblock4.Deblock4).

Controlling documents:
    The charter (AI_Charter_and_Invariants_Card, HIGHEST committed version;
    v1_27 at this writing) PREVAILS over everything, including this header.
    The stage scope names the stage's authority set. The knowledge documents
    (Binding Knowledge Index; Toolchain Findings; MPEG-2 Grid Knowledge)
    hold the established facts; the pre-implementation knowledge sweep is a
    duty, not background.

Repository and branch:
    github.com/hydra3333/vapoursynth-Deblock4, branch main (W3X names the
    branch at issuance if different).

BASE IDENTIFICATION (charter v1.27, C-DELIV-01 - replaces all earlier
base-hash and commit-hash provisions):
    There is NO commit-hash and NO per-file base-hash requirement. The base
    is the prevailing repository state as CONFIRMED WITH W3X at issuance and
    again at delivery time; W3X GUARANTEES the local repository IS the base
    at patching time. If W3X supplies an attached source tree, that tree IS
    the base, identified by content. If unsure you hold the current base,
    ASK W3X to confirm or re-supply - never infer it from earlier
    conversations, from the status document, or from any recorded hash.

Delivery and repository discipline (charter v1.27, C-DELIV-10/11):
    No git commands, no staging, no PowerShell, and no repository-operating
    scripts in any delivery or validation machinery. Application is a manual
    W3X copy of apply_to_tree\ (or a W3X-manual git apply); backout is a
    manual W3X act using the delivery's restore_to_base\ folder and per-file
    command block. Commit is a manual W3X act after W3D review and W3X
    acceptance. The coder never claims PASS; W3X runs all validation
    (C-DELIV-07).

Environment (constant; W3X corrects at issuance if changed):
    Zig 0.16.0. Visual Code 2026 x64 developer prompt (VsDevCmd -arch=amd64).
    Portable VapourSynth R79 at D:\TEST\Vapoursynth_x64_R79 (in-tree API4
    compile headers unchanged; the R78-era header set remains the compile
    contract). Test invocation via tools\run_vs.cmd. US-ASCII CRLF for all
    deliverable text files.

Identity at this writing:
    0.1.0-dev+4C (Stage 4C accepted 2026-08-13). The stage scope states the
    identity its stage must advance to.

What arrives with the stage scope (not in this header):
    the bounded objective; the authorised and forbidden file lists; the
    binding-knowledge checklist; the acceptance gates and proof matrix; the
    delivery package shape; and any stage-specific hazards (for Stage 5C:
    the AVX2 near-edge behaviour, made fully explicit there).
```

---

*Revision history*
```text
v1.0 (2026-08-13) First issue under this stage-agnostic filename. Content
     aligned to charter v1.27: base is confirmed-with-W3X (no hashes);
     delivery discipline restated from C-DELIV-10/11; environment pins
     carried forward with the R79 runtime. Supersedes the differently-named
     Deblock4_Stage_2C_Session_Bootstrap_Header v1_0/v1_1, whose 2C file
     lists now live in each stage's scope.
```
