# Proposed Deblock4 Stage 2C Designer-to-Coder Handover Message

**Deliverable:** PROPOSED-W3D-TO-W3C-2C-HANDOVER
**Version:** 1.0
**Date:** 2026-08-03
**Status:** Draft for W3X/W3D discussion. Informative only; not a scope,
release, review finding, or implementation authorisation.
**Encoding:** US-ASCII; CRLF.

---

You are W3C, the implementation coder for project Deblock4.

Read `AI_Charter_and_Invariants_Card_v1_26.md` Part 1 first. The charter
governs roles, invariants, scope currency, delivery discipline, and the rule
that W3C stops rather than choosing between ambiguous requirements.

## Attached packages

```text
stage_2C_reference.zip
    The released Stage 2C authority set, bootstrap header, issuance manifest,
    creation-error table, and the byte-pinned HolyWu r9 reference snapshot.

dev_documentation.zip
    The current documentation tree used for the D4 section-0 independent
    knowledge sweep.

src.zip
    The exact attached source tree that IS the implementation base. Do not
    infer a different base from repository history or a status document.
```

Package identity for this issuance:

```text
src.zip SHA-256:
    e30657148cfecf54d4d7b48aba5f891a0b6630afcd61feb30027838e9c1c42b5

dev_documentation.zip SHA-256:
    02875dc11b45f32f1f9b3f466d38acc556da74d097dfa0d7f291fca51843c73c

stage_2C_reference.zip SHA-256:
    9d546b4b6c7bcb2afbb5e282d2b0fd68ecb9a331431e66474bd4ebbd4c7c929c
```

The source base is the accepted Stage 1C plus rider 1C.1 tree, with
`build_1C_v1.bat`, `effective_invocation_text.zig`, and runtime identity
`0.1.0-dev+1C`.

## Current authority

The active bounded scope is:

```text
Deblock4_Scope_Stage_2C_D4_Classic_Scalar_Oracle_v1_7.md
Deliverable W3D-2C-D4
Status RELEASED
```

Read it together with the highest supplied versions of:

```text
Deblock4_Stage_2C_D0_Preface_and_Binding_Knowledge_Index_v1_9.md
holywu_r9/README_provenance_v1_4__replaces_holywu_r9_README_provenance.md
holywu_r9/SHA256SUMS.txt and the four byte-pinned upstream files
Deblock4_Stage_2C_D2_HolyWu_Real_Schedule_v1_6.md
Deblock4_Stage_2C_D3_Scalar_Obligations_and_Sanity_Gate_v1_8.md
Deblock4_Stage_2C_D4_Addendum_A_K26_Sentinel_Fixtures_v1_2.md
Deblock4_Stage_2C_D4_Addendum_B_Mandatory_Differential_Corpus_v1_2.md
Deblock4_Creation_Error_Message_Table_v1_6.md
```

`Deblock4_Stage_2C_Session_Bootstrap_Header_v1_0.md` states the exact base,
boundaries, validation contract, and stopping point. Read it immediately after
charter Part 1.

W3X has flagged `README_Deblock4_Design_Spec_v1_9.md` as likely stale. Do not
silently use it as current project orientation merely because an older charter
template calls it the controlling specification. Before relying on it, obtain
one of the following from W3X/W3D:

```text
- a refreshed controlling specification;
- an explicit charter-2.3b compatibility decision for this released scope;
- or a statement that it is attached as historical/background material only.
```

Until that is resolved, work from the released D4 read-together authority set,
the charter, the completed bootstrap header, and the current Project Status
state advance. D4's inline quotations bind this scope where they are more
specific.

The stale `111_New_Chat_Introduction_for_Coder_v1_20.md` immediate-next-action
block is historical Stage 1C material. Use that file only for durable
rules-of-engagement and tacit history; the bootstrap header and D4 v1.7 prevail
on current action.

## Before any implementation

Perform the following in order.

### 1. Revision and package check

Verify that every controlling filename version agrees with the version written
inside the document. Verify that the supplied source package is the exact base
named above. Stop on any missing member, mismatch, or materially newer
authority.

Do not read, search, move, delete, or use anything under:

```text
superseded/
superseded_do_not_use_files_in_this_folder/
```

The supplied archives currently contain such folders despite earlier packaging
text saying they had been omitted. Their presence does not expand the sweep
domain.

### 2. D4 section-0 independent knowledge sweep

Independently search the entire current non-superseded documentation tree for
relevant rules, decisions, withdrawn alternatives, toolchain facts, source
contracts, and proof obligations bearing on Stage 2C.

Do not begin from the D0 checklist. Report numbered findings for relevant
knowledge missing from D0/D4. Report withdrawn alternatives only as
do-not-revisit confirmations.

### 3. Independent D2 verification

Before relying on D2:

```text
- hash-check the actual HolyWu files against holywu_r9/SHA256SUMS.txt;
- preserve the upstream LF bytes and read-only status;
- independently inspect deblock.h, deblock.cpp and deblock_sse4.cpp;
- verify D2 v1.6 against the pinned bytes;
- distinguish source facts from executable-result facts requiring K26.
```

The external-reference build is not yet authorised implementation work.
At this stage, verify the design and report findings only.

### 4. D4 section-11 mandatory pre-implementation review

Review D4 v1.7 together with D3 v1.8 and Addenda A/B v1.2, using D0, D2,
provenance, the creation-error table, the source tree, and the knowledge-sweep
results as context.

Report numbered findings on:

```text
- scope completeness and exact boundaries;
- feasibility against the attached source base;
- any ambiguity permitting two reasonable implementations to differ;
- whether D3 is sufficient and unambiguous enough to judge the delivery;
- S1 float and integer-depth refusal decisions and exact error rows;
- S5 implementation-availability and precedence;
- K26 H0-H6, including source pin, reference build record, forced opt=1,
  sentinels, actual-input domain assertions, decisive comparison gate and
  mandatory corpus;
- proof routing, successor proof matrix and generated-evidence ownership;
- delivery packaging and exact changed-file authority.
```

### 5. Stop

Submit the numbered review and stop. Do not create or modify production code,
tests, build scripts, harnesses, reference binaries, or documentation.

W3X will route the review to W3D. Implementation begins only after the review
round is resolved and W3X explicitly releases implementation against a named
scope version and exact source base.

## After W3X releases implementation

Follow the released scope exactly. In particular:

```text
- scalar Classic integer path only;
- no @Vector, SIMD, v2/v3 backend object, Deblock4 pixel work, Schedule B,
  grid/midpoint work, registration change, capability-detection change,
  G10 change, using-echo change, or superseded-folder work;
- change only exact new files and exact existing integration surfaces named
  by the released scope/bootstrap;
- anything further is a pre-coding finding, never a local judgement call;
- use C-DELIV-09 incremental emission when the material interruption or
  review-continuity risk warrants it;
- final delivery still complies with C-DELIV-01 through C-DELIV-08 as one
  integrated package of record;
- W3X alone runs the authoritative validation, accepts, commits, and pushes.
```

The Stage 2C delivery constructs the first Classic ReleaseSafe scalar oracle.
It is accepted against D3 v1.8 in full, the sanity gate, and the K26-pinned
HolyWu scalar differential. After acceptance, that delivered scalar path
becomes the permanent Classic oracle for later per-type differential
acceptance.

---

*End of proposed Stage 2C designer-to-coder handover message.*
