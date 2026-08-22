# Deblock4 - W3C Live Checkpoint for T1S01a5b Batch v2

**Date:** 2026-08-22
**Author:** W3C
**Purpose:** Durable continuation point before substantive v2 delta verification.
**Encoding:** US-ASCII; CRLF.

## Current task

Continue the delta-only W3C review of:

`T1S01a5b_A_Designer_Batch_v2.zip`

Extracted batch path in-session:
`/mnt/data/a5b_batch_v2/`

Primary files:
- `T1S01a5b_A_Covering_Note_for_W3C_v1_1.md`
- `T1S01a5b_A_Ledger_Body_Part2_v1_2.md`
- `T1S01a5b_A_Population_Delta_v1_1.md`
- `T1S01a5b_A_Population_and_Coverage_Map_v1_0.md`
- `Deblock4_T1_W3C_Review_Scope_v1_15.md`

Current complete documentation corpus already supplied:
`dev_documentation(20260821-104439).zip`

## Prior W3C baseline

Prior reviewed Batch-1 package:
- `T1S01a5b_B_Coder_Response.zip`
- `T1S01a5b_B_Findings_v1_0.md`
- `T1S01a5b_B_Ledger_Body_Part2_v1_1_W3C_REVIEWED.md`

Prior result:
- 38-file population reproduced exactly;
- 24 entries reviewed;
- 13 AGREE / 11 DISAGREE;
- findings F1-F9.

Prior substantive findings:
F1 source-coverage defects at A/B headings and missing B2 PRIMARY CANDIDATE;
F2 Grid Knowledge v1.2 missed in Architecture-A sweep;
F3 LED-066 non-atomic retained-practices claim;
F4 LED-067a Appendix-C pointer directly supportable;
F5 LED-073 non-atomic role/origin + section-11 pointer;
F6 LED-074 exactly-once ownership unique but 16-pixel clause non-atomic;
F7 LED-079 DEC-50 candidate enumeration incomplete;
F8 LED-081 missed revisit carrier;
F9 LED-081a should be SUPERSEDED / ERRONEOUS, not CONFLICTING; Section 15 ->
Section 16 repair technically correct; mandatory propagation required.

## Batch-v2 correction-round scope already established

- delta-only correction review;
- 16 open `VERDICT (W3C)` fields;
- 12 prior AGREE entries carried forward;
- W3D says it accepted F1-F9 in full;
- highest-risk checks:
  - LED-081a propagation and corrected disposition;
  - all CURRENT-UNIQUE entries;
  - newly-created/split entries;
  - changed population/coverage evidence.

## Exact live position

The updated checkpoint is being created BEFORE substantive verification of the
v1.2 corrections.

No v2 verdict has yet been issued.
No v2 reviewed ledger has yet been generated.
No v2 findings ZIP has yet been generated.

Resume immediately by:
1. read v2 covering note;
2. diff ledger v1.2 against v1.1 reviewed baseline;
3. verify the 16 open verdict fields only;
4. check changed population/coverage evidence;
5. generate reviewed v1.2 ledger + findings + ZIP, US-ASCII/CRLF.

## Standing exclusions

Do NOT:
- reopen T1S01a5;
- rerun old a5 work;
- perform source/build/test/git work;
- perform final a5b cross-entry consistency unless explicitly in the v2 scope.
