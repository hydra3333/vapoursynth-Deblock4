# Deblock4 - Scope Stage 1C.1 Rider: Effective-Invocation Echo ("using" line)

**Version:** 1.0
**Date:** 2026-08-02
**Author:** W3D
**Status:** DRAFT rider scope, W3X ratification pending. A small bounded
follow-up to Stage 1C, released by W3X only AFTER Stage 1C is accepted and
committed. It does not modify Stage 1C acceptance; the standing proof matrix
is extended and re-run.
**Controlling documents:** charter (prevailing per 2.3a; v1_26 at authoring),
README design spec v1_9, this rider. Stage 1C scope v1_5 conventions
(C-1C-1..8) carry forward unchanged.
**Encoding:** US-ASCII; CRLF.

**Incremental emission (charter C-DELIV-09) - standing reminder:** When this
scope/phase is large enough that withholding all output creates a material
interruption or review-continuity risk - normally multiple modules or more
than a few files - W3C EMITS complete modules or small coherent groups as they
are finished, each marked "increment N of ~M: <what>" (~M is an estimate and
may be revised). Each increment is a complete, self-identifying recovery and
review artifact against the stated base; it need not be independently
applyable. ONLY EMITTED ARTIFACTS SURVIVE an interruption: the recoverable
state is the last complete emitted increment(s); the current incomplete
increment AND any later un-emitted integration, reconciliation, validation, or
revision work may be lost, and earlier increments may be superseded by later
integration. W3C does not claim to preserve or resume un-emitted internal
work. The increments do NOT replace the final deliverable: at scope/phase end
W3C rebuilds and re-packages the complete integrated work against the
authoritative base as one deliverable of record meeting C-DELIV-01..08 in
full, validated as a whole - merely concatenating increments is not proof of
integration. W3X ordinarily applies only the final package, unless W3X
explicitly directs otherwise.

(This rider is expected to be SMALL - a single delivery without intermediate
increments is anticipated and acceptable under the risk-based trigger.)

---

# 1. Purpose and motivation (informative)

Toolchain finding F6: VapourSynth coerces numeric arguments to the registered
parameter type before the plugin sees them, so a user's strength=1.5 arrives
as 1 and cannot be detected plugin-side. Since coercion cannot be prevented,
it is made VISIBLE: each filter reports the invocation it actually resolved -
including defaulted parameters - so the user can see what the filter is
running with. The same mechanism also surfaces silently-defaulted parameters
generally.

# 2. Binding specification

## 2.1 The "using" line (stderr, release-visible)

At successful instance creation, immediately AFTER the existing one-line
version summary, each filter emits exactly ONE additional stderr line:

```text
deblock4: using Classic(strength=1, planes=[0,1,2], boundary_strength_offset=0, side_activity_offset=0, backend=auto)
deblock4: using Deblock4(strength=25, planes=[0,1,2], boundary_strength_offset=0, side_activity_offset=0, backend=auto, grid_mode=mpeg2_progressive, luma_step=8x8, chroma_step=8x8, midpoint_threshold_scale=absent)
```

Rules:
R1  The line begins with the stable prefix "deblock4: using " followed by the
    registered filter name and a parenthesised, comma-separated
    name=resolved-value list in call syntax. ONE physical line (C-1C-6
    discipline). Flush-per-line.
R2  RESOLVED values: what the instance will actually act on, post-coercion
    and post-defaulting. Parameters the user omitted appear WITH their
    resolved default values. Optional parameters with no value and no
    default (e.g. Deblock4 midpoint_threshold_scale when unset) appear as
    name=absent. The clip argument is omitted (not representable usefully).
R3  Exact member set: every registered public parameter of the filter, in
    registration order, plus backend. Deblock4 additionally reports the
    resolved grid family and per-plane-class steps as shown (these are the
    resolved consequences of grid_mode). Formats of values reuse the
    existing lifecycle-trace field formats where one exists.
R4  The EXISTING version-summary line is byte-unchanged. The "using" line is
    ADDITIVE with its own prefix so harnesses grep it independently.
R5  The line is RELEASE-VISIBLE (not G10-gated). It is emitted once per
    instance creation, only on SUCCESS (failed creation emits the error, not
    a using line).

## 2.2 The matching frame property

The identical string (from "Classic(" / "Deblock4(" onward, i.e. without the
"deblock4: using " prefix) is written as a frame property on every output
frame, alongside the existing audit properties, under the settled naming
convention of README 13.5 (proposed name: Deblock4Using; W3C may propose an
alternative consistent with the existing property family, W3D verifies, W3X
ratifies with the delivery). The property is the same for every frame of an
instance and is built once at creation (immutable instance data, C-1C-1).

## 2.3 Honesty semantics (binding)

The line reports what the filter RESOLVED, not what the user typed (which is
unknowable per F6). Wording anywhere near this feature must not claim to
echo the user's original arguments.

# 3. Proof (extends the standing matrix)

P1  Both .vpy harnesses add, for each existing valid case, an assertion that
    the "using" line appeared exactly once per created instance with the
    expected resolved values (including a defaulted-parameter check: at
    least one case per filter omits a parameter and asserts its default
    appears; the existing valid_auto cases already do this).
P2  One assertion that the frame property exists and equals the expected
    string (either filter, one case suffices).
P3  The full standing matrix (build_1C_v1.bat) re-runs green end-to-end -
    all fifteen gates. The E-series case set updated per P1/P2 is the only
    harness change.
P4  The existing version-summary assertions still pass unchanged (R4).

# 4. Boundaries

- No change to parameter registration, validation logic, tier selection,
  routers, frame path, or any accepted module beyond: building the using
  string at creation, emitting it (2.1), and attaching the property (2.2).
- No pixel code (G5/2C-2D unchanged). No new G10 seams. No doc-generation
  changes beyond the delivery's own records.
- Deliverable: the touched source files + updated .vpy harnesses + the
  re-run matrix transcript, packaged per C-DELIV-01..08.

# 5. Acceptance

W3D static review (string construction sites, R1-R5 conformance, property
plumbing, harness assertions) + W3X's green fifteen-gate matrix run + W3X
acceptance. W3X releases this rider only after Stage 1C acceptance is
committed.
