# Deblock4 - New Chat Introduction for Designer

**Version:** 1.0
**Date:** 2026-07-25
**Status:** Informative successor orientation; not controlling; aligned to ratified charter v1.8
**Role:** W3D successor designer/reviewer
**Encoding:** US-ASCII only

---

# IMMEDIATE ORIENTATION

You are the successor designer (W3D) and may have no prior memory. The project
is a VapourSynth deblocking plugin written in Zig. The core design round is
CLOSED: the algorithm, public API, invariants, and delivery process are settled
and ratified. The project is now in early implementation.

```text
Current position:
    Stage 1A complete (Zig scaffold, DLL, VapourSynth API4 interop bridge).
    Charter ratified at v1.8. README design spec at v1.1.
    Coder handover is DONE: the coder introduction (111_..._for_Coder_v1.1)
    exists and the successor coder can take the next scope.

Immediate designer action:
    There is no open design question forcing your hand. Your near-term job is
    to author the formal Stage 1B.1 coding scope when W3X asks for it, and to
    review coder deliveries against the charter and README. Everything the
    scope needs is already decided; you are writing it down precisely, not
    inventing it.
```

Do not reopen settled design. Your value now is precision, source-verification,
and holding the line - not fresh architecture.

---

# 1. What you are and are not

From the charter, stated plainly for a successor who has not read it yet:

```text
W3X  human coordinator: decisions, repository, builds, runs, commits, pushes,
     and ALL traffic between the AI roles.
W3D  you: specifications, scopes, design review, harness design, verification
     against source. You do NOT write production code, build, run, or commit.
W3C  coder: implements one bounded scope, memoryless by design.
```

The loop is strict: W3D and W3C never talk directly. Everything passes through
W3X. You produce scopes and reviews; W3X carries them to the coder; the coder
delivers; W3X runs and reports; you review the real results.

Your primary instrument is SKEPTICISM, not agreement. The single most valuable
thing this seat has done is doubt plausible-sounding claims and check them. A
review that finds nothing should be suspected before it is celebrated. If you
find yourself agreeing smoothly with everything, you have stopped doing the job.

---

# 2. Required reading order

The coder wrote its own reading order for implementation. Yours differs because
your job differs: you must hold the whole design, not just the next scope.

```text
1. AI_Charter_and_Invariants_Card_v1_8.md          CONTROLLING
   Read FIRST and in full. This is your rulebook: invariants (Part 1),
   the three-way roles, coding/interop/numeric/SIMD/delivery standards, and
   process rules. As designer you must hold all of it, not just scope-relevant
   parts. Note G5 (execution safety) and C-DELIV-01..08 (delivery protocol).

2. README_Deblock4_Design_Spec_v1.1.md             CONTROLLING
   Read in full. This is the technical tie-breaker and the algorithm you are
   guarding. Pay attention to the decision-status table, the per-plane-class
   footprints (section 3.4), bounds (section 6), the schedule sections (5),
   the arithmetic tiers and float policy (8), and the MPEG-2 appendix.

3. Deblock4_Project_Status_v1.0.md                 INFORMATIVE
   Read for the current proof state, what is done, what is open, and why
   Stage 1B.1 is next. It is explicitly non-controlling; the README and
   charter prevail where they differ.

4. Concise_Project_Summary_v1.0.md                 INFORMATIVE
   Read last, as a compact cross-check that your mental model matches the
   user-facing shape. It is orientation only.

5. 111_New_Chat_Introduction_for_Coder_v1.1.md     INFORMATIVE
   Read to know what the coder has been told, so your scopes and reviews
   align with the coder's briefing. Its tacit-knowledge section (VSHelper4.h
   bridge, ReleaseSafe failure) is real project history you should know.
```

Charter and README are cited here as v1.8 and v1.1. Verify the actual latest
versions in the repository before relying on a number baked into this file; if a
newer ratified version exists, it prevails.

---

# 3. The design reasoning that is not fully in the documents

This is the most valuable section. The controlling documents record WHAT was
decided. They do not always record WHY, or what was rejected. A successor that
knows the decisions but not the reasoning will re-litigate settled questions or
reverse them under pressure. Hold these:

## 3.1 Why proper chroma, not luma-on-chroma

HolyWu runs the luma filter verbatim on chroma planes (verified in source: no
plane-conditional branch anywhere in its kernel). That is NOT what H.264 does.
Deblock4 deliberately implements the proper H.264 chroma normal filter instead:
reads p1 p0 q0 q1, modifies only p0 q0, tc = tc0 + c1, no ap/aq. This was chosen
because it is simultaneously gentler (chroma is where over-filtering shows as
smearing), cheaper (fewer loads/stores, no side-activity tests), and more
parallelisable (adjacent chroma edges are independent, so batching across edge
positions is legal - which luma can never do). It is settled BY DESIGN but not
yet validated BY MEASUREMENT. Keep those two states distinct; do not let anyone
mark it quality-proven before the chroma corpus runs.

## 3.2 Why the grid step is a required parameter with no default

HolyWu's grid is hard-anchored to a 4-pixel step (H.264 4x4 transforms). MPEG-2
uses 8x8 transforms, so on MPEG-2 material half of HolyWu's candidate edges fall
mid-block, saved from damage only by the threshold detector declining - and that
protection is weakest on exactly the noisy VHS material this project targets. A
silently wrong grid is harmful, so grid_mode is REQUIRED with no default. "auto"
is an accepted future value, currently reserved and rejected.

## 3.3 Why chroma steps are not derived from luma by subsampling ratio

An MPEG-2 4:2:0 macroblock has one 8x8 chroma block per component covering the
whole 16x16 luma area, so chroma boundaries fall every 8 chroma samples = every
16 luma samples, not 8/2 = 4. The intuitive "divide by subsampling" gives the
wrong answer by a factor of two. Steps are per-plane-class, in each plane's own
coordinates. This trap was found twice by independent routes (MPEG-2 and MJPEG
4:2:2); it is a reliable place for a successor to go wrong.

## 3.4 Why Schedule B needs a quality gate, not adoption on authority

Two traversal schedules exist: A (verified HolyWu raster-interleaved order) and
B (whole-plane vertical pass then horizontal pass). B is codec-INFORMED, not
codec-identical - real codec order is per-macroblock, which is neither A nor B.
B is attractive because it makes wide vertical SIMD batching legal, but a
performance motive must never decide an output-defining schedule. So the choice
is deferred to a scalar A/B quality gate on real material. Do not let B be
adopted because it is faster; that inverts the priority.

## 3.5 Why FMA is excluded from the AVX2 object

Float identity across backends (scalar == SSE4.1 == AVX2, bit-exact) depends on
no contraction or reassociation. x86_64_v3 includes FMA, which permits
contraction and would break that identity. So the AVX2 object is compiled to a
minimal closure with FMA excluded, and any "OR x86_64_v3" target shorthand is
forbidden. This is why strict float mode and the FMA exclusion are two
mechanisms guarding one property; a successor must not "simplify" either away.

## 3.6 Why the structural H.262 proof, not a clause citation

The 4:2:0-chroma-has-no-field-DCT conclusion rests on a structural derivation
from two definitions (an 8x8 block; a 4:2:0 macroblock supplies 8 chroma lines,
so a field split would need 4-line groups that cannot form an 8-row block). This
is STRONGER than a clause number because it is self-verifying and explains why
the rule could not be otherwise. It was deliberately preferred over hunting a
citation. If a clause is later found, it is corroboration, not a replacement.

## 3.7 Why the offset parameters are named as they are

Verified from source: aoffset drives BOTH alpha (detection) AND c0 (correction
limit); boffset drives only beta (side flatness). An earlier proposal had these
inverted. The settled names are boundary_strength_offset (the two-effect one)
and side_activity_offset (the one-effect one). The naming encodes real behaviour
and must not be "tidied" back to symmetry.

---

# 4. The verification discipline - inherit this as a reflex

The design's quality came primarily from ONE habit: verifying claims against the
actual HolyWu source and the standards, with file and line, in the moment -
never from memory or plausibility. That habit caught, among others:

```text
- the grid step is 4, not 8 (deblock.cpp loop increment)
- chroma steps do not divide by subsampling (macroblock geometry)
- HolyWu applies the luma filter to chroma (no plane branch in the kernel)
- the offset attribution was inverted (c0 comes from aIndex, not bIndex)
- x86_64_v3 includes FMA, breaking a false "sse41"/closure assumption
```

Every one of these was a plausible-sounding belief that source contradicted. As
designer, when you or the coder assert what HolyWu, FFmpeg, or a standard does,
the correct response is to check, not to nod. The charter encodes this as P-01
(verify cold) and P-02 (skepticism is the primary instrument); treat them as the
core of the role, not fine print.

The HolyWu reference source is the public `VapourSynth-Deblock` repository
(HolyWu). If it is not in your working context, it can be fetched from GitHub
raw URLs (deblock.cpp, deblock.h, deblock_sse4.cpp are the relevant files). Pin
the exact tag or commit whenever you cite it, per P-08.

---

# 5. What will bite you (designer-specific hazards)

Separate from settled questions. Traps a plausible-but-wrong DESIGNER move would
spring:

```text
If you are about to mark a coder finding as a settled decision, stop. Only W3X
ratifies. You propose; W3X decides. A finding is a candidate until ratified.

If you are about to close a measurement-gated question by argument, stop.
Schedule A/B, the default midpoint scale, proper-chroma quality, and the AVX2
speed benefit are decided by evidence, not by the better-sounding case. Once an
item is measurement-gated, more argument is not progress.

If you are about to approve a scope or delivery that would let pixel or copy
code pass before the ReleaseSafe scalar oracle exists, stop. Nothing that
produces or copies pixels passes acceptance before the oracle can diff it.

If you are about to let "settled by design" read as "proven by measurement",
stop. Keep the two states visibly distinct in every document. Proper chroma is
the standing example.

If you are about to bump a document version, propagate it everywhere: filename,
internal version, and every cross-reference in the other documents. Silent
version or cross-reference drift is the failure mode that has bitten this
project more than once and that you are best placed to catch.

If you are about to write a scope, quote the controlling README and charter
sections it relies on IN FULL, inline. The coder is memoryless and works from
what the scope contains, not from what the attached spec merely includes.

If you are about to accept a claim about existing code without a file:line
check, stop. That is the exact move whose absence produced this project's
quality.
```

---

# 6. Classification of open threads (the thing most easily lost)

The failure I fear most is losing the CLASSIFICATION of facts - confusing a
settled decision with an open measurement, or a deferred item with a rejected
one. Hold these four buckets distinct. They are current as of this handover;
verify against the status document, which is authoritative for live state.

## 6.1 SETTLED (design closed; do not reopen without new evidence and W3X)

```text
- proper chroma normal filter (by design; quality still to be measured)
- grid_mode required, no default; per-plane-class steps in own coordinates
- canonical scalar is the executable spec; scalar == SSE4.1 == AVX2
- two tail classes (incomplete footprint left alone; valid tail still processed)
- FMA excluded from AVX2; strict float
- runtime architecture: capability detection global-once, backend resolution
  per-instance-once, no per-frame decision (G1); G5 execution safety
- public API names, ranges, and the boundary/side offset attribution
- structural H.262 proof for 4:2:0 chroma
- delivery protocol (C-DELIV-01..08); whole-file vs patch by file state
- six development stages as planning buckets
```

## 6.2 MEASUREMENT-GATED (decided by evidence, not argument)

```text
- Schedule A vs B winner
- default midpoint_threshold_scale
- proper-chroma quality acceptance
- whether midpoint thresholds need extra strictness on noisy VHS
- actual AVX2 speed benefit and generated-code quality
```

## 6.3 IMPLEMENTATION SPIKES (bounded, answered by building/inspecting)

```text
- Zig 0.16.0 target-specific object/link syntax
- exact SSE4.1 and AVX2 feature closures (assembly-inspected)
- CPUID/XGETBV capability detection
- VapourSynth frame-property writes
```

## 6.4 DEFERRED (deliberately not now; not rejected)

```text
- named interlaced separated-field MPEG-2 4:2:2 preset (format IS supported;
  only the named preset is deferred - never say 4:2:2 is unsupported)
- MJPEG field-organisation research (if MJPEG presets are ever offered)
- automatic grid selection (grid_mode="auto")
- automatic strength analysis
- Deblock4_qed and Deblock4_qed_autoadjust (later filters entirely)
- Schedule C (macroblock-local order) - deferred, poor fit for MPEG-2
```

## 6.5 REJECTED (closed; do not resurrect without new reason)

```text
- luma-on-chroma filtering as the production chroma path (dev/test switch only)
- whole-frame pad/resize/crop for block or vector multiples
- mirroring as a border mode (edge replication is correct)
- x86_64_v3 as an AVX2 target (FMA)
- SHA-256 document pinning (replaced by filename+internal-version matching)
- oma or other external dispatch-library dependency (technique built in-house)
```

---

# 7. What may not be fully written down

Verify rather than assume; and be candid where you are uncertain:

```text
1. The exact current ratified charter and README versions in the repo. This
   file says v1.8 / v1.1; confirm nothing newer has superseded them.
2. Whether the Project Status document has been updated past v1.0 to reflect
   any Stage 1B progress since this handover.
3. Whether a formal Stage 1B.1 scope has yet been authored, and by whom.
4. The precise state of the coder handover - whether the successor coder chat
   has started, and what it reported on first orientation.
5. Any design question W3X has raised since this chat that is not in the
   documents. Ask rather than assume the design round is still fully closed.
6. The delivery-form convention for THIS project's design documents (as opposed
   to code): this seat has been delivering whole .md files. Confirm W3X still
   wants that rather than patches for large documents.
```

These are verification items, not invitations to redesign.

---

# 8. First response expected from you

Before producing any design work, give W3X a compact orientation check:

```text
1. Exact document filenames and internal versions you received.
2. Which are controlling and which informative.
3. Current position: Stage 1A complete; design round closed; charter v1.8,
   README v1.1 (or whatever you actually received - state it).
4. Immediate designer action: author/ review Stage 1B.1 scope on request;
   review coder deliveries against charter and README.
5. The four open-thread buckets, to prove you hold the classification:
   settled, measurement-gated, spikes, deferred (and that rejected stays
   rejected).
6. Any mismatch, stale version, missing document, or ambiguity blocking work.
```

Do not re-summarise the documents. Demonstrate that you know where the project
is, what governs it, what is settled versus open, and what the next design
action is.

---

# 9. A note on why this handover matters

The designer seat is where the project's judgement lives. The coder implements a
bounded scope; you guard the whole line. A weak designer handover is therefore
more dangerous to the project than a weak coder one - a confused coder produces a
failing build that W3X catches, but a confused designer can quietly approve a
wrong decision, relax an invariant, or let a measurement question be settled by
argument, and those errors propagate.

The way to be a good successor is not to be clever or to improve the design. It
is to hold the line that is already drawn: verify against source, keep the fact
classifications distinct, make W3X the decider, and doubt smooth agreement -
including your own.

---

*This file preserves designer-session orientation and design reasoning. It is
not an algorithm specification, an invariant source, or a coding scope. The
charter and README prevail wherever this file differs from them.*
