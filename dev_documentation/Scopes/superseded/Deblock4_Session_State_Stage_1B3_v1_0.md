# Deblock4 - Session State and Handover: Stage 1B.3 era

Version: v1.0
Date: 2026-07-30
Encoding: US-ASCII only
Purpose: compact continuity record so a successor W3D chat (or a documentation
refresh) can pick up without re-deriving decisions. This SUPPLEMENTS the
charter and scope; where wording differs, the ratified charter v1.17 and scope
v1.3 win. A full documentation refresh across all intro/design docs is planned
AFTER Stage 1B.3 completes (W3X will supply the current doc set as a zip).

## 1. Where the project is

- Stage 1B.2 (named psABI level migration, within-level proof): COMPLETE,
  committed and pushed. Standing batch: build_1B2_v5_REDEVELOPED.bat (root).
- Charter: AI_Charter_and_Invariants_Card_v1_17.md, internal 1.17,
  W3X-ratified (W3X edit-fixed the W3D draft; W3X copy is authoritative).
  G1-G10. G10 = debug-only code structurally absent by the ratified
  three-layer pattern.
- Debug-module pattern: Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md;
  empirically ratified 2026-07-30 by gate_pattern_test_v2 (coder-redesigned
  two-module kit with isolation control; ten tests PASS on the real Zig
  0.16.0 Windows toolchain; evidence retained by W3X under gate-results).
- Stage 1B.3 scope: Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md
  is the issue document (v1.0 -> v1.1 GAIS pins -> v1.2 resolved W3C review
  B1-B7/P1-P3 -> v1.3 resolved W3C follow-up R1-R5). Implementation NOT yet
  begun; W3X to assemble the session package (P2) and hand off.

## 2. Ratified decisions this era (with one-line rationale)

- G10 three-layer pattern: C-3 source-visible conditional import is Layer 1
  (condition legible where the maintainer reads, not hidden in build.zig);
  gated content is Layer 2 (proven breach-fallback, never licenses an
  unconditional import); three-surface proven absence is Layer 3.
  Empirical facts proven: comptime exclusion identical across
  Debug/ReleaseSafe/ReleaseFast; bare conditional declaration does not leak;
  stray refs fail compile ("no member named ... in struct"); untaken prongs
  of a comptime-known switch are not analysed.
- Force-down seam: explicit opt-in enable_force_down, default OFF, DEBUG-ONLY
  (build.zig hard-rejects otherwise); env var DEBLOCK4_FORCE_DOWN, values
  exactly "v1"/"v2"; NO "v3" value ("if it misses on my 3900X it needs a fix
  not a force" - W3X); absent=inert, invalid=LOUD InvalidForceDownValue,
  other acquisition failure=@panic; non-allocating bounded-buffer read;
  effective = actual INTERSECT ceiling (structurally cannot raise).
- BOTH debug options (enable_force_down, enable_verbose_detection) are
  hard-rejected outside Debug (B2 option A). README 13.6 always-on
  version/tier/reason stderr line is PRODUCTION, not debug, and carries the
  fallback reason (v1.2 correction).
- Two-record model (B1): ACTUAL (process-wide, once, immutable) vs EFFECTIVE
  (per-instance, immutable). Dispatch will consume EFFECTIVE.
- Detection contract: coder's SDM-cross-checked 25-bit set-A table (all bits
  independently verified by W3D); leaf guards; set-B XGETBV/XCR0 (XCR0 & 0x6)
  == 0x6 gates the WHOLE v3 tier; v1 unconditional fallback; OSFXSR/SCE are
  policy_assumed_present provenance, never "detected" (B7).
- G3 one-mechanism reconciliation (B6): comptime membership cross-check in
  cpu_capability_detection.zig against std.Target.x86.cpu.x86_64/_v2/_v3
  named models via explicit name map + approved exclusion list;
  @compileError on mismatch (FAIL not complain - W3X). Seed map: x87<->FPU,
  cx16<->CMPXCHG16B, sahf<->LAHF-SAHF, bmi<->BMI1; exclusions 64bit, crc32,
  xsave, tuning props; coder completes against 1B.2 model captures,
  W3X/W3D approve before commit.
- Module architecture ("skeleton fully now, content minimally now,
  extend-don't-fork" - W3X-agreed): deblock4_config.zig (declarations-only
  switchboard, shallow namespaces, holds plugin.version_string),
  print_helper_functions.zig (always-on), print_diag_helper_functions.zig
  (gated, verbose per-bit forensics), force_down_debug.zig (gated, separate
  module, own gate, announcement lives here), cpu_capability_detection.zig
  (detection core + comptime cross-check), deblock4_selftest.zig (first-class
  self-test exe root - the CNR3 model: DLL + selftest from the same source
  modules). Options module import name: deblock4_build_options.
- Naming + ONE-WAY DEPENDENCY rule + SWEEP TEST (W3X "Danger, Will Robinson"
  condition): first-class modules NEVER reference scaffolding; scaffolding
  may use first-class modules; new names carry no stage/probe vocabulary;
  scaffolding cleanup deferred to the filter-creation stage in ONE sweep
  requiring zero first-class edits; textual audit is a 7.5 proof obligation.
- Forward contract (5A): ResolvedTier enum, ActualCapabilities,
  EffectiveCapabilities, detectActualOnce(), RequestedBackend enum
  (auto/v1/v2/v3; carried+reported only in 1B.3, honoured by dispatch in a
  later stage), initInstanceCapabilities(instance_name, requested),
  InstanceInitError{InvalidForceDownValue}. Filter stage will CALL this, not
  redesign it.
- Deterministic reason rule (R1): force-down active -> reason=forced-down
  with actual shown, precedence over hardware; else ALL missing features of
  the level immediately above resolved actual, table order, XCR0 failure as
  pseudo-feature XCR0.YMM; else no clause.
- Validation deliverable (R5): ONE root-level batch, family
  build_1B3_v<N>.bat, initial build_1B3_v1.bat (runner + standing
  three-surface gate + selftest matrix + build-reject + no-regression).
- Detection inspection (R2): standalone addObject of the detection unit at
  the baseline named model x86_64 (v1), step detection-object, for the
  dumpbin v1-only proof; plus a proper `test` step for the fabricated-record
  clamp unit tests (B3: nine actual x ceiling combinations, pure functions,
  no synthetic seam in production).

## 3. Working-relationship facts worth preserving

- Three-party model: W3X = human coordinator (Dave); W3D = designer chat
  (this role); W3C = memoryless coder chat. GAIS = auxiliary research AI;
  W3X policy: GAIS output is gap-analysis/thoughts only, never binding;
  it has been valuable on research and got API spellings wrong (e.g. its
  std.Thread.Once sketch is unverified; once-construct choice is coder
  latitude, stated in the response).
- Verification culture: assertions about toolchain/std behaviour are tested,
  not trusted (this era alone: the coder found W3D's original gate test
  non-discriminating - missing isolation control - and the fix was adopted;
  W3D found GAIS's asm block needed the EBX/Win64 caveat and kept it
  non-normative; the comptime-switch prong question was resolved empirically
  by the test rather than argued).
- Batch/cmd.exe discipline: proven rules live in the 1B.2 batch work
  (by-name deref !%~N!, <nul stdin guards on findstr, Form A quoting,
  findstr exit-code 1 ambiguity protected by existence-checks-before-assert).
- All docs US-ASCII; repo files CRLF; scopes quote what they rely on
  (charter 2.3); scopes list permitted AND forbidden files.

## 4. Immediate pending flow (in order)

1. W3X assembles the P2 session package: exact commit/branch, charter v1.17,
   sources named in scope 2.1, README/design spec (13.6), 1B.2 batch, the
   1B.2 named-model capture files, scope v1.3.
2. W3C implements per its stated sequence: verify base -> isolated asm spike
   (verify CPUID/XGETBV constraints incl. EBX handling; reference shape is
   non-normative) -> bounded production changes -> deliver build_1B3_v1.bat.
3. W3C delivery must include: the completed 3.6 mapping/exclusion proposal
   (for approval BEFORE commit), the demonstrated-then-reverted @compileError
   firing (7.4), and the one-way dependency audit (7.5).
4. W3X runs; W3C reviews actual output; W3D reviews implementation+evidence;
   W3X accepts/commits/pushes.
5. AFTER 1B.3: full documentation refresh (all intro/design docs) from the
   W3X-supplied zip; ratify the section 8 standing rules into the charter
   (single-homes rule; naming/one-way-dependency/sweep rule) if 1B.3 proves
   them out.

## 5. Key artifacts and where they live

- Charter v1.17 (W3X's edit-fixed copy is authoritative) - repo docs.
- Deblock4_Debug_Module_Inclusion_Pattern_v1_1.md - repo docs.
- Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_3.md - the issue doc.
- gate_pattern_test_v2 kit + gate-results evidence - committed by W3X.
- W3C research/reviews: Deblock4_Stage_1B3_Prep_W3C_Research_v1_0.md,
  Scope_Review_W3C_v1_0.md, Scope_Review_W3C_v1_1.md.
- Repo: github.com/hydra3333/vapoursynth-Deblock4, main; src/ currently =
  probes + smoke tests + dll_probe.zig (no filter source yet - the filter
  stage creates the VS entry point and performs the scaffolding sweep).
