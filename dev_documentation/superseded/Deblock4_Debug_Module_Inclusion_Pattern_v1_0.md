# Deblock4 - Debug Module Inclusion Pattern (Standing Rule)

Version: v1.0
Encoding: US-ASCII only
Status: settled W3X design decisions establishing the project-standard pattern
for including debug-only code that MUST NOT exist in a release binary. This is a
STANDING RULE for all debug modules, not just the Stage 1B.3 force-down seam.
It does not itself authorise production code; it constrains how such code is
structured and proven.

## Purpose

Debug/test code (the force-down seam, debug printing, test-only diagnostics,
etc.) must be genuinely ABSENT from a release binary: no machine code, no
symbols, no strings. "Not compiled in" is a strictly stronger guarantee than
"present but disabled at runtime" (the G6 principle). This document fixes the
required structure and the required proof.

## The pattern - three layers

### Layer 1 (PRIMARY, load-bearing): C-3 source-level conditional import

A debug module is included via a top-level conditional DECLARATION, in the
conventional import location, so the conditional nature is visible where a
maintainer reads the source:

```zig
const build_options = @import("build_options");

const fd = if (build_options.enable_force_down)
    @import("force_down_debug.zig")
else
    struct {};
```

Properties:
- The `if` is at the top of the file among the imports; a reader sees at a
  glance that the module is debug-only. No hunting in build.zig.
- When the option is false the true branch is an untaken comptime branch; the
  real module is not analyzed and not emitted. This is the PRIMARY omission
  guarantee.
- The false branch is `struct {}` (an empty namespace; files are structs under
  the hood, so this is the natural empty-module stand-in). A stray reference to
  a member of `fd` in ungated code then FAILS TO COMPILE
  (`error: no member named '...' in 'struct {}'`), giving a structural boundary
  against accidental active references.

Rationale for choosing C-3 over the build-side module-swap alternative: the
build-side swap hides the real-vs-stub decision in build.zig, so source readers
see a plain unconditional import with no local signal it is conditional and must
chase the build script to understand it. C-3 keeps the condition legible at the
point of use. Legibility of a safety-relevant condition, where it acts, is
preferred over minimising file count. (Both mechanisms are equivalent for
omission; the decision is on maintainability.)

STATUS: C-3 is the chosen mechanism, pending empirical confirmation on the Zig
0.16.0 toolchain (compile with the option on and off; scan the binary for the
module's unique marker to confirm true omission when off). Ratified once that
test is green.

### Layer 2 (SECONDARY, defence in depth): per-feature inner gates

Inside a debug module, individual debug features are ALSO wrapped in their own
`if (build_options.enable_...)` gates, and call sites that use them are gated
too.

This is NOT required for omission - Layer 1 already omits the entire module when
disabled. Its value is:
- Independent per-feature provability: each debug feature can be shown absent in
  release by its own marker, so one leaking feature cannot hide behind others in
  a module that holds several tools.
- Robustness if Layer 1 is ever breached: if a future refactor imports the debug
  module UNCONDITIONALLY (the exact mistake to guard against), the inner gates
  still keep the feature code out of a release build.

CAVEAT (important): the inner gates are a secondary layer. They must NEVER be
treated as the thing that licenses an unconditional import. The primary omission
guarantee is the Layer 1 conditional import. Reasoning of the form "the inner
ifs make it safe, so the import can be unconditional" is backwards and is
precisely the trap this rule exists to prevent.

### Layer 3 (PROOF): absence is verified, not assumed

Release builds must be PROVEN clean by scanning the artifact for unique markers
belonging to each debug feature - function symbol names, override token strings,
diagnostic strings - in symbols, strings, and disassembly. Absence is
machine-checkable and is a required gate, consistent with the project's
"prove absence, do not assume it" posture (as in the Stage 1B.1 gating).

Each debug feature should carry at least one unique, greppable marker so its
presence/absence is individually testable.

## Scope of this rule

Applies to ALL debug/test-only modules in the project, not only the force-down
seam. Any such module: included via Layer 1 (C-3), internally gated per feature
via Layer 2, and proven absent in release via Layer 3.

## Build-side requirements (recorded, detail deferred to scope)

- The enabling option is an EXPLICIT opt-in build option, default OFF, not tied
  to Debug mode (recorded W3X decision).
- The option must be structurally prevented from enabling the seam in a
  release-production profile; exact spelling settled at scope time.
- The options module feeding `build_options` is created with `b.addOptions` /
  `addOption` / `root_module.addOptions("build_options", options)` and imported
  as a comptime-known value (per Stage 1B.3 prep findings).

## Open confirmation items (before ratification)

- O1: empirical confirmation that the C-3 conditional DECLARATION omits in
  release on the Zig 0.16.0 toolchain (the gate_pattern_test), including that a
  bare unreferenced C-3 declaration does not leak, and that a stray ungated
  reference fails to compile against `struct {}`.
- These carry into the Stage 1B.3 scope's proof requirements regardless.
