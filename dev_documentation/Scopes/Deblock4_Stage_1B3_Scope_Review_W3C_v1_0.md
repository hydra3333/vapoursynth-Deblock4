# Deblock4 Stage 1B.3 Scope Review - W3C Response

Version: v1.0
Date: 2026-07-30
Reviewed scope: Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_1.md
Status: DESIGN CLARIFICATION REQUIRED BEFORE IMPLEMENTATION
Encoding: US-ASCII only

## 1. Overall disposition

The technical direction is accepted:

```text
- whole-level v3 -> v2 -> v1 detection;
- complete Set-A membership plus Set-B XCR0 state;
- v1-only detection code;
- immutable capability results;
- G10-gated debug diagnostics and force-down seam;
- three-surface release-absence proof;
- no backend invocation in this stage.
```

However, v1.1 is not yet safe to implement under the normal W3C process. The
items below require W3D clarification or a reissued scope. W3C will not choose
among the unresolved designs locally.

## 2. Blocking issues

### B1. Process-wide actual record versus per-instance effective record

Section 3.1 requires one immutable capability record populated once, consistent
with G1. Section 5.1 reads `DEBLOCK4_FORCE_DOWN` once at instance
initialisation and lowers an effective capability record.

Those are two different lifetimes:

```text
actual capabilities:
    detected once process/plugin-wide;
    immutable;
    describe hardware and OS truth.

effective capabilities:
    derived at each instance construction;
    actual intersected with the optional force-down ceiling;
    immutable for that instance.
```

The scope currently uses "the capability record" for both. It must explicitly
pin the two-record model, their types, ownership and API, or instead state a
different single-lifetime design.

The always-on and verbose diagnostics must also state whether they receive the
actual record, the effective record, or both.

### B2. `enable_verbose_detection` is debug-only but is not barred from release

Sections 2.3 and 4.2 classify verbose detection as debug-only G10 code that is
structurally absent from production.

Section 5.3 and section 6 hard-reject only:

```text
enable_force_down=true with optimize != Debug
```

They do not reject:

```text
enable_verbose_detection=true with ReleaseSafe/ReleaseFast/ReleaseSmall
```

As written, a release build can deliberately compile the debug-only diagnostic
module, contradicting the stated G10 classification.

W3D must choose and pin one of these:

```text
A. Hard-reject BOTH debug options outside Debug; or
B. Reclassify verbose detection as an authorised diagnostic production mode
   and amend G10/scope wording accordingly.
```

W3C recommends A, but will not make that policy decision.

### B3. The force-down proof requires a case impossible on the stated host/input

Section 5.1 accepts only environment values `v1` and `v2`.

Section 7.1 requires proof that a request above the actual tier clamps to the
actual tier. The stated W3X host is v3. Neither accepted value is above v3, so
the required live-host case cannot occur.

The scope must authorise and pin a deterministic proof mechanism, for example:

```text
- module-local tests of the pure intersection/ceiling function using fabricated
  v1 and v2 actual records; or
- a separately gated test-only synthetic actual-record input.
```

The production environment variable must remain limited to the pinned values.
The proof must not depend on finding another physical host.

### B4. The force-down module boundary is not pinned

Section 2.3 places both verbose diagnostics and the force-down announcement in
`print_diag_helper_functions.zig`, but section 2.4 imports that module under
`enable_verbose_detection`.

Force-down is independently enabled by `enable_force_down`. Section 5.3 then
allows the force-down seam to live in the diagnostic module "or its own gated
module".

That leaves a production module-boundary choice to W3C. The scope must pin:

```text
- the exact force-down module filename;
- the exact C-3 import site;
- whether the announcement helper shares that module or remains in the
  diagnostic-print module;
- how the two independent gates avoid importing debug content under the wrong
  option.
```

A separate `force_down_debug.zig` module would be clear, but W3D must decide.

### B5. No exact integration point is authorised

The scope requires:

```text
- actual detection once process/plugin-wide;
- environment read at instance construction;
- once-per-instance summary emission;
- immutable result exposed for later dispatch.
```

But section 9 authorises only new module names, `build.zig`, and unspecified
harness files. It does not name the existing production file that:

```text
- owns the process-wide once initialisation;
- invokes detection;
- constructs the per-instance effective record;
- emits the summary;
- exposes/stores the record.
```

The exact existing integration file(s) and permitted edits must be listed.
Without them, the new modules can only remain unintegrated test code.

### B6. Charter G3 "one mechanism" is not reconciled

The charter requires compile targets and runtime detection to derive from one
mechanism encoding the psABI levels so they cannot drift.

Stage 1B.2 compile targets use Zig named CPU models. This scope separately
hard-codes a CPUID feature table in the detection source and calls it the
runtime contract.

The scope must explain the mechanical single-source relationship, for example:

```text
- one shared project level-definition module consumed by both build and runtime;
- a generated runtime table derived from the same source;
- or an explicit W3X-approved clarification/waiver of the charter wording.
```

Merely saying both sides implement the same published standard does not by
itself prevent drift.

### B7. OSFXSR/SCE and the "actual feature" diagnostic are inconsistent

Section 3.1 says the record stores, for each Set-A feature, whether the CPU
reports it. Sections 1.2 and 3.3 correctly state that OSFXSR and SCE are not
CPUID bits and will not be read.

Section 4.2 nevertheless requires each Set-A feature to be printed
present/absent.

The scope must define the truthful representation and output. Suitable choices
include:

```text
- a provenance/status enum: detected_present, detected_absent,
  policy_assumed_present, unavailable;
- separate CPU-bit fields and baseline-policy fields;
- explicit diagnostic labels such as "OS baseline assumed by Windows x64
  process policy", not "CPU present".
```

Plain booleans labelled as hardware observations would be misleading.

## 3. Scope/package completeness issues

### P1. Exact file paths are missing

Section 9 gives bare names for:

```text
deblock4_config.zig
print_helper_functions.zig
print_diag_helper_functions.zig
the force-down seam
the standing gate
the .vpy/.bat harness
```

Only `src/cpu_capability_detection.zig` has a pinned path.

Every changed file must have an exact repository-relative path. All other files
must be explicitly forbidden.

### P2. Exact starting base and source package are not supplied

Before implementation, W3C still requires the normal session package:

```text
- exact starting commit;
- branch;
- corrected charter v1.17 Part 1;
- controlling design specification and internal revision;
- current `build.zig`;
- every existing source file that may be changed or imported;
- current Stage 1B.2 validation batch/successor;
- any existing plugin/filter creation and diagnostic source;
- exact permitted and forbidden file lists.
```

### P3. Output/API shapes need enough detail to avoid local design invention

The scope should pin, or explicitly delegate within bounded constraints:

```text
- capability record field/type names;
- resolved-tier enum location;
- public constructor/accessor names;
- process-wide once mechanism;
- error type/path for invalid `DEBLOCK4_FORCE_DOWN`;
- instance-facing effective-record API;
- exact summary-line format and compact indication;
- exact diagnostic marker strings and machine-code markers;
- exact validation script filename.
```

Not all implementation spelling must be frozen, but the externally consumed
shape and error/lifetime contracts must be.

## 4. Non-blocking implementation note

The raw inline-assembly reference is correctly labelled non-normative. W3C can
verify and correct the Zig 0.16.0 operand constraints once the source package is
available. In particular, EAX/ECX are naturally in/out operands for CPUID and
EBX/RBX preservation must be confirmed from actual generated code.

This is an implementation proof task, not presently a scope defect.

## 5. Requested W3D response

Please reissue the scope, or provide binding addenda, resolving B1-B7 and P1-P3.

Once resolved and the complete source package is supplied, W3C will proceed in
the normal sequence:

```text
1. verify exact base and permitted files;
2. verify Zig 0.16 inline-assembly mechanics in an isolated spike;
3. implement the bounded production changes;
4. deliver the standing loud-failing proof harness;
5. W3X builds/runs;
6. W3C reviews actual output;
7. W3D reviews implementation/evidence;
8. W3X accepts, commits and pushes.
```

No production code has been written from scope v1.1.
