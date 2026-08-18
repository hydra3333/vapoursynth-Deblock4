# Deblock4 - Session Bootstrap Header (stage-agnostic)

**Version:** 1.2
**Date:** 2026-08-18
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
    v1_29 at this writing) PREVAILS over everything, including this header.
    The stage scope names the stage's authority set.

    For ALL MPEG-2 matters - geometry, field/frame coding, chroma
    organisation, architecture, prior art, the D4 registers - the PREVAILING
    AUTHORITY is Deblock4_MPEG2_Deblocking_Investigation_and_Decided_
    Architecture (highest version). It SUPERSEDES
    Deblock4_MPEG2_Grid_Field_DCT_Knowledge, which earlier versions of this
    header wrongly listed as holding established facts. DO NOT reason from
    that document.

    The remaining knowledge documents (Binding Knowledge Index; Toolchain
    Findings) hold established facts in their own domains; the
    pre-implementation knowledge sweep is a duty, not background.

Repository and branch:
    github.com/hydra3333/vapoursynth-Deblock4, branch main (W3X names the
    branch at issuance if different).

BASE IDENTIFICATION (charter C-DELIV-01 - replaces all earlier base-hash and
commit-hash provisions):
    There is NO commit-hash and NO per-file base-hash requirement. The base
    is the prevailing repository state as CONFIRMED WITH W3X at issuance and
    again at delivery time; W3X GUARANTEES the local repository IS the base
    at patching time. If W3X supplies an attached source tree, that tree IS
    the base, identified by content. If unsure you hold the current base,
    ASK W3X to confirm or re-supply - never infer it from earlier
    conversations, from the status document, or from any recorded hash.

Delivery and repository discipline (charter C-DELIV-10/11):
    No git commands, no staging, no PowerShell, and no repository-operating
    scripts in any delivery or validation machinery. Application is a manual
    W3X copy of apply_to_tree\ (or a W3X-manual git apply); backout is a
    manual W3X act using the delivery's restore_to_base\ folder and per-file
    command block. Commit is a manual W3X act after W3D review and W3X
    acceptance. The coder never claims PASS; W3X runs all validation
    (C-DELIV-07).

Environment (constant; W3X corrects at issuance if changed):
    Zig 0.16.0. Builds and proof matrices run from the Visual Studio 2026
    x64 developer prompt (VsDevCmd -arch=amd64). The source EDITOR is VS
    Code with the Zig extensions (the Visual Studio Zig extension is not
    used); this affects editing only - every build/validation command in
    this project assumes the Visual Studio developer prompt.
    Portable VapourSynth R79 at D:\TEST\Vapoursynth_x64_R79 (in-tree API4
    compile headers unchanged; the R78-era header set remains the compile
    contract). Test invocation via tools\run_vs.cmd. US-ASCII CRLF for all
    deliverable text files.

Identity at this writing:
    0.1.0-dev+5C (Stage 5C accepted 2026-08-15; post-5C maintenance M1 and M2
    are complete as commits on top of it). The stage scope states the identity
    its stage must advance to.

State at this writing:
    Classic is COMPLETE for the ratified integer tier set. deblock4.Deblock4
    has NO filtering kernel - its dispatch arms are pass-through copies. No
    Deblock4 kernel scope may be drafted before the D4-Q14 experiment reports
    and W3X ratifies the architecture allowed to enter kernel/oracle
    development. If a session is issued while the T1 documentation sweep is
    running, the work is document review rather than code.

What arrives with the stage scope (not in this header):
    the bounded objective; the authorised and forbidden file lists; the
    binding-knowledge checklist; the acceptance gates and proof matrix; the
    delivery package shape; and any stage-specific hazards (Stage 5C, now
    complete, made the AVX2 near-edge behaviour fully explicit in its scope -
    that is the pattern a future scope follows).
```

---

*Revision history*
```text
v1.2 (2026-08-18) Currency correction. The charter pointer said v1.27 and the
     identity said 0.1.0-dev+4C; both were stale (v1.29 and 0.1.0-dev+5C with
     M1/M2 complete). Charter version numbers removed from the two rule
     citations entirely, since the rules are cited by their C-DELIV
     identifiers and pinning a version only creates a second thing to go
     stale. MORE SERIOUSLY: the controlling-documents block listed
     Deblock4_MPEG2_Grid_Field_DCT_Knowledge among the documents that "hold
     the established facts". That document is SUPERSEDED by the ratified
     MPEG-2 authority, so the header was directing a coder at retired MPEG-2
     knowledge during the pre-implementation sweep - the exact failure mode
     the T1 sweep exists to eliminate. Replaced with an explicit pointer to
     the prevailing authority and a do-not-use instruction. Added the current
     project state, since a header that states an identity but not whether a
     kernel exists invites the wrong assumption.
v1.1 (2026-08-14) Environment clarification (W3X): Visual Studio 2026
developer prompt for builds; VS Code with Zig extensions as the editor.
v1.0 (2026-08-13) First issue under this stage-agnostic filename. Content
     aligned to charter v1.27: base is confirmed-with-W3X (no hashes);
     delivery discipline restated from C-DELIV-10/11; environment pins
     carried forward with the R79 runtime. Supersedes the differently-named
     Deblock4_Stage_2C_Session_Bootstrap_Header v1_0/v1_1, whose 2C file
     lists now live in each stage's scope.
```
