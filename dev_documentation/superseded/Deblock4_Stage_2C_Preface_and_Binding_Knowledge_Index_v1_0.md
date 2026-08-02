# Deblock4 - Stage 2C Preface and Binding Knowledge Index

**Deliverable:** W3D-2C-D0
**Version:** 1.0
**Date:** 2026-08-02
**Author:** W3D (designer), ratified by W3X
**Status:** Living index; updated as 2C deliverables land (extend, do not rewrite).
**Encoding:** US-ASCII; CRLF.

---

# 1. Purpose

Stage 2C introduces the first real deblocking mathematics into Deblock4: the
Classic ReleaseSafe scalar oracle and the HolyWu external-reference
differential harness. A large body of prior research, experimentation, and
hard-won findings governs this work. All of it is captured in committed
repository documents; NONE of it lives only in any chat's memory.

This preface (a) records the Stage 2C plan and its pinned reference, and
(b) indexes every binding knowledge item with its home document/section and
the 2C-family point at which it applies - so that no participant (W3X, W3D,
W3C, or any successor chat) can lose it by forgetfulness. Every 2C-family
deliverable MUST carry a Binding Knowledge Checklist naming the items from
section 4 that it touches and stating how each is honoured (or why it is out
of scope for that deliverable). Reviewers check the deliverable against its
checklist AND the checklist against this index.

# 2. Pinned external reference (D-CLASSIC-4, RATIFIED)

```text
Reference:  HolyWu VapourSynth-Deblock, tag r9
Ratified:   W3X, 2026-08-02
Verified:   r9 src/ is byte-identical to master src/ as of 2026-08-02
Contents:   src/deblock.cpp (448 lines, scalar core = oracle reference)
            src/deblock_sse4.cpp (169 lines; THEIR SIMD - later 4C reference
            reading only, never our implementation source)
            src/deblock.h (17 lines)
Snapshot:   to be archived read-only in-repo by deliverable W3D-2C-D1
            (W3X-owned once committed, like the VapourSynth R78 headers).
Rule:       all schedule/formula citations in 2C documents reference THIS
            snapshot by file/function/line (README requirement: inspect the
            real source; never compare against an assumed schedule).
```

# 3. Stage 2C deliverable plan (short-boundary, extensible)

```text
W3D-2C-D0  This preface + binding knowledge index. (this document)
W3D-2C-D1  Pin record + read-only source snapshot committed to the repo.
W3D-2C-D2  HolyWu Real Schedule document: line-by-line inspection of
           deblock.cpp - actual edge order, formulas, rounding, clipping,
           threshold derivation from strength, frame-boundary behaviour,
           and the faithful luma-on-chroma path - with file/function/line
           citations into the D1 snapshot.
W3D-2C-D3  Independent scalar obligations + loose whole-image sanity gate
           (the acceptance basis under the oracle-construction exception).
W3D-2C-D4  Stage 2C coder scope draft, assembled from D1-D3, checklist
           embedded, for W3X ratification and release.
Then:      W3C implementation delivery/deliveries; W3D review; W3X run,
           acceptance, commit - per the established Stage 1C process.
```

Each boundary is a valid stopping point; a successor designer resumes from
the committed deliverables alone (the Stage 1C dead-coder recovery proved
this model).

# 4. Binding knowledge index

Authority note: the charter and the README prevail where any summary here
is imprecise. Section references are to the CURRENT committed versions
(README_Deblock4_Design_Spec_v1_9, AI_Charter_and_Invariants_Card_v1_26,
Deblock4_Verification_And_Tiering_Decisions_v1_10,
Deblock4_Toolchain_Findings_v1_3); "or later" always applies.

## 4.1 Vector semantics and SIMD discipline (the "@Vector" lessons)

```text
K1  Vector BYTES vs vector ELEMENTS must never be conflated.
      README 3.6 (SIMD batch), 3.7 (Vector bytes), 3.8 (Vector lanes).
      Applies: D3 obligations wording; 4C/5C backend scopes; any coder text
      that mentions @Vector widths.
K2  SIMD width must not define output: scalar, v2, v3 byte-identical for
      integer formats regardless of batch width.
      README 4.3.  Applies: D3 (obligation), 2C differential harness
      definition, 4C/5C acceptance.
K3  The TWO TAIL CLASSES are different things and must never be confused:
      ALGORITHMIC boundary tail (frame-edge behaviour of the algorithm,
      README 3.10 + section 6 corrected frame-boundary policy) vs SIMD
      BATCH tail (vector-width remainder handling, README 3.12 + section 7
      corrected SIMD-tail policy, esp. 7.2 "Never confuse the two tail
      classes").  Applies: D2 (document HolyWu's actual frame-boundary
      behaviour), D3 (state boundary obligations), 4C/5C (batch tails).
K4  AVX2 masked load/store warning: README 7.4. AVX2 backend notes 7.3.
      Applies: 5C primarily; recorded here so 2C documents do not
      accidentally promise masked-IO semantics.
```

## 4.2 Miscompile guard and float semantics

```text
K5  R76-class miscompile risk and its PERMANENT mitigations (charter G9):
      Verification_And_Tiering 5. Classic's 4-pixel grid is the
      HIGHER-EXPOSURE case (Roadmap, "why this ordering").
      Applies: D3 (obligations must be miscompile-detecting: independent
      vectors, not implementation-derived), 2C scope (the differential
      harness is itself a standing G9 guard), 4C/5C.
K6  Non-fused float semantics: a*b+c must retain non-fused semantics; no
      @mulAdd (README, section 3 rules; background in
      Deblock4_Floating_Exactness_and_Full_Declared_Tiers_Discussion_v1_3).
      Applies: D2 (note HolyWu's arithmetic type reality), D3, coder scope.
      Note: Classic integer paths dominate; float applies to threshold
      derivation if HolyWu uses it - D2 must establish the fact.
```

## 4.3 Oracle and differential doctrine

```text
K7  Classic oracle contract: README "Classic oracle contract" (section 4),
      including the e-relative read footprint e-3..e+2 and write footprint
      e-2..e+1 (p1,p0,q0,q1).
      Applies: D2 (verify against real source), D3 (footprint obligations),
      coder scope.
K8  Do not use HolyWu as the ONLY oracle: README 4.2. Independent scalar
      obligations + hand-derived vectors are mandatory, not optional.
      Applies: D3 is this requirement made concrete.
K9  Oracle sequencing (charter G7) + per-type differential acceptance +
      ORACLE-CONSTRUCTION EXCEPTION: Verification_And_Tiering 20.1/20.2 and
      Roadmap standing constraints. The 2C scope that CONSTRUCTS the oracle
      is accepted against D3 obligations + loose whole-image sanity gate,
      not against a pre-existing oracle. After acceptance, NO pixel/frame/
      copy/backend code for Classic is accepted except differentially
      validated against the oracle (integer byte-identical).
      Applies: D3, D4, and every Classic delivery after 2C.
K10 ReleaseFast-vs-ReleaseSafe scalar check: Verification_And_Tiering 3.7.
      Applies: 2C proof surface (the oracle is ReleaseSafe; RF must match
      byte-identically for integer).
K11 Schedule A (verified HolyWu-equivalent) vs Schedule B (Deblock4
      two-pass candidate): README 5.1-5.4. CLASSIC IS SCHEDULE A ONLY -
      faithful HolyWu including luma-on-chroma; no grid_mode, no midpoint,
      no Schedule B (Roadmap Stage 2C line). Schedule B and the MPEG-2
      grid/field knowledge (Deblock4_MPEG2_Grid_Field_DCT_Knowledge_v1_0)
      are 2D material - explicitly DEFERRED, listed here so nobody
      "helpfully" imports them into Classic.
      Applies: D2 (Schedule A verification IS the task), D3, D4 scope
      boundary.
```

## 4.4 Platform, build, and process findings already paid for

```text
K12 Toolchain Findings F1-F8 (Deblock4_Toolchain_Findings_v1_3): esp.
      F4/F8 (export fn: object-mode vs DLL-root are different properties),
      F5 (proven multi-feature-level idiom), F6 (VapourSynth numeric
      coercion pre-plugin), F7 (empty-array boundary; plugin defence
      retained).  Applies: any 2C source work touching modules/exports;
      harness design (no host-owned error text assertions).
K13 G5: no v2/v3 backend EXECUTION before the proven whole-level capability
      guard (charter). 2C is scalar-only; the guard machinery from 1B.3
      stands untouched.  Applies: D4 scope boundary, 4C/5C.
K14 G10 three-layer debug-seam obligations + the Debug Module Inclusion
      Pattern (Deblock4_Debug_Module_Inclusion_Pattern_v1_1): any new 2C
      diagnostics follow the pattern; the standing fifteen-gate matrix
      keeps its G10 gates green.  Applies: D4, coder deliveries.
K15 Backend-object dispatch architecture:
      Deblock4_DISPATCH_RELATED_Backend_Objects_Explained_v1_3 and
      Deblock4_S1B1_Retention_Export_Research_Package_v1_0. The oracle is
      scalar and lives in normal code; backend objects re-enter at 4C/5C.
      Applies: 4C/5C (indexed now so it is not re-derived).
K16 Creation-error message table v1_1 is ratified source obligation; 2C
      must not alter creation strings. Deblock4Using / the using-echo
      surfaces (rider 1C.1) must remain byte-stable.
      Applies: D4 no-touch list, coder deliveries.
K17 Delivery self-containment rule (Stage 1C.1 lesson): a delivery carries
      and stages EVERY file its proof touches; presumes a clean tree;
      preconditions hash only the files it touches; never reads, moves, or
      deletes anything under superseded/; ships a scoped restore-to-base
      command block derived from its own manifest.
      Applies: every 2C-family coder delivery.
K18 Proof-domain and audit discipline: S3 domain is the deliverable tree
      (allowlist); the four -File PowerShell audits; the cmd/quoting
      lessons; benign artifacts judged by exit code (Zig --listen context,
      negative-configure FileNotFound).  Homes: build_1C_v1.bat + Stage 1C
      scope v1_5 (amended) + Resume Brief v1_1 section 3.
      Applies: 2C proof-surface extensions.
```

# 5. What Stage 2C explicitly does NOT include

```text
- No grid_mode, no midpoint, no Schedule B, no field-DCT geometry (2D).
- No v2/v3 SIMD implementation (4C/5C); vectorclass in the HolyWu tree is
  THEIR dependency and is never imported.
- No change to registration, validation, creation-error strings, tier
  selection, G10 modules, or the using-echo surfaces.
```

---

Revision: v1.0 (2026-08-02) initial index; extend per deliverable, do not
rewrite. Items K1-K18.
