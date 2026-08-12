# Deblock4 - W3D Static Review of the Stage 2C Implementation Delivery v2.0

**Deliverable:** W3D-2C-STATIC-REVIEW-OF-DELIVERY-V2
**Version:** 1.0
**Date:** 2026-08-11
**Author:** W3D (designer)
**Route:** W3D -> W3X
**Reviews:** Deblock4_Stage_2C_Implementation_Delivery_v2_0.zip (manifest
v2.0, 21 apply files + 10 restore copies)
**Against:** Redelivery Specification v1_2 (W3X-ratified); D4 v1_9 authority
set; the held Stage 1C + 1C.1 base; the retained reviewed v1.0 delivery
copies; the W3X process rulings of 2026-08-06/10/11.
**Status:** W3D static review; no execution performed or claimed by W3D
beyond sandbox simulation. W3X runs all validation.
**Encoding:** US-ASCII; CRLF.

---

# 1. VERDICT

```text
ZERO findings. The v2.0 package conforms to the ratified redelivery
specification exactly, and W3D RECOMMENDS PROCEEDING TO W3X VALIDATION.
```

# 2. Verification record (all performed cold this session)

```text
STRUCTURE      21 apply files (16 + 5) + 10 restore copies + manifest,
               exactly the spec's shape. No .ps1, no patch, no apply/
               restore machinery anywhere in the package.
BYTE-IDENTITY  All 16 whole-file members BYTE-IDENTICAL to the retained
               reviewed v1.0 copies (the zero-findings, model-verified
               core returns untouched). All 10 restore copies
               BYTE-IDENTICAL to the held base tree.
CROSSWALK      Diff vs reviewed copy = the SINGLE K30 row, re-routed to
               "delivery-manifest W3C K30 evidence + independent W3D
               re-verification"; the K30 identifier retained (so the
               batch completeness scan stays satisfied); every other
               row byte-equal.
BATCH          Diff vs reviewed copy = EXACTLY the four authorised
               deltas: preflight line removed; seven-line K30 step
               block removed; summary token exactly the W3X-directed
               replacement (STAGE2_D3_O_G K31 S5 H0_H6 PASS); the
               'K30' ID retained in the crosswalk-completeness list.
               Nothing else.
NEW .CMD       build_holywu_r9_scalar.cmd reviewed in full: the four
               embedded expected hashes match the pinned SHA256SUMS
               byte-for-byte; pre-build verification, deblock.cpp-only
               /O2 in-place compile, POST-build re-verification with
               pre/post equality comparison (tamper window closed);
               DLL + header hashes captured; complete preliminary
               record with the exact command line; exit-code
               discipline throughout; JSON block expansions verified
               quote-protected against cmd block parsing (the MSVC
               "(R)" banner case checked specifically). LINK
               FEASIBILITY verified statically: deblock.cpp's sse4
               references are entirely #ifdef DEBLOCK_X86-guarded
               (lines 34, 349-357), no define is passed, so the
               standalone scalar compile/links cleanly and the
               record's "DEBLOCK_X86 ABSENT" claim is accurate.
RUNNER/README  Deltas exactly as specified: the runner calls the .cmd
               with the same three inputs and preserved log flow; the
               README names the .cmd and records the K30 evidence
               routing; nothing else moved.
K30 EVIDENCE   The manifest's two-part report INDEPENDENTLY
               RE-VERIFIED with the W3D tooling proven in the S2
               incident: PART 1 (three modules, 16 test names, 31
               wiring lines; vocabulary + all 13 canonical basenames)
               = EMPTY; PART 2 (added lines of all 10 edited modules)
               = EMPTY. Dependency direction confirmed
               (thresholds <- kernel <- schedule; no scaffolding
               reference). NOTE, cosmetic: two per-file added-line
               counts differ by one between the parties' tools
               (backend_tier_selection 115 vs 114; selftest 37 vs 36)
               - a boundary-line counting definition difference; the
               load-bearing EMPTY results agree and the audited line
               SETS produce identical scan outcomes.
SWEEP SIM      The full 1C S2 sweep, transliterated exactly, over the
               ENTIRE merged post-apply tree: ZERO retired-literal
               hits - the incident's collision class is dissolved at
               the root, as the specification designed.
ENCODING       Every file in the package US-ASCII, CRLF-only.
PROCESS        Manifest carries the manual application instruction,
               the full manual backout command block (both routes:
               per-file git restore/del list AND restore_to_base
               hand-copy), the three ruled folder purposes, the
               refined git rule verbatim, and clean C-DELIV-07
               ownership statements.
```

# 3. W3X runbook to acceptance (simpler than ever)

```text
1. Copy the CONTENTS of apply_to_tree\ over the repository root
   (one manual copy). Sanity: git status --short --untracked-files=all
   should show exactly 10 " M" and 11 "??" entries.
   (No delivery_base preparation exists or is needed - the K30 audit
   script is gone by design.)
2. From an x64 MSVC developer prompt: build_2C_v1.bat.
   Expect OUTER_BATCH_EXIT_CODE=0.
3. ADDENDUM A SENTINEL MISMATCH = HARD STOP per H3(c): stop, report;
   never adjust D3.
4. Retain zig-out\inspection_2C evidence; supply the console capture
   and evidence to W3D for the acceptance-evidence review.
5. Commit is your separate manual act, only after that review and
   your acceptance.
```

---

*Revision history*
```text
v1.0 (2026-08-11) Static review of the v2.0 redelivery: zero findings;
     full conformance to Redelivery Specification v1_2; K30 evidence
     independently re-verified EMPTY/EMPTY; whole-tree sweep
     simulation zero hits; recommendation to proceed to validation.
```
