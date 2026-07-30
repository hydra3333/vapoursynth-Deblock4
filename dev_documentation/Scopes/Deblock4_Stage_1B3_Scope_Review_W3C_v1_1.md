# Deblock4 Stage 1B.3 Scope Review - W3C Response

Version: v1.1
Date: 2026-07-30
Reviewed scope: Deblock4_Scope_Stage_1B3_Runtime_Capability_Guard_v1_2.md
Status: SUBSTANTIALLY CORRECT; BINDING CLARIFICATIONS STILL REQUIRED
Encoding: US-ASCII only

## 1. Overall disposition

Scope v1.2 successfully resolves the central architectural blockers raised
against v1.1:

```text
B1  actual process-wide record vs effective per-instance record       RESOLVED
B2  both debug options barred from non-Debug builds                  RESOLVED
B3  above-actual clamp proof via fabricated pure-function tests       RESOLVED
B4  force-down and verbose-diagnostic module boundaries               RESOLVED
B5  forward API and first-class self-test integration                 MOSTLY RESOLVED
B6  target/detection drift check against Zig named models             MOSTLY RESOLVED
B7  OSFXSR/SCE provenance rather than false "detected" claims         RESOLVED
P1  exact production source file inventory                            MOSTLY RESOLVED
P3  public record/API names and principal output contract             MOSTLY RESOLVED
```

The overall design is accepted. The remaining items are narrow, but they affect
pinned APIs, permitted files, or executable proof obligations. W3C must not
choose their resolution locally.

## 2. Remaining blocking clarifications

### R1. The pinned instance API cannot emit the pinned summary line

Section 4.1 requires:

```text
deblock4: <version> <instance-name> backend=<requested> tier=<effective-tier>
```

and requires a reason when the effective tier is below the requested backend.

Section 5A pins:

```text
initInstanceCapabilities(instance_name: []const u8)
```

That function receives neither:

```text
the requested backend; nor
the version string.
```

The required `backend=<requested>` field and the comparison against the
requested backend therefore cannot be implemented from the pinned arguments.

The scope also does not identify an authorised source for `<version>`:

```text
deblock4_config.zig's required declarations contain no version;
the generated build-options content lists only the two debug booleans;
no other permitted first-class module is named as the version authority.
```

Binding clarification required:

```text
1. Pin the source of the version string.
2. Either add the requested backend to initInstanceCapabilities(...), or pin
   Stage 1B.3 to backend=auto and defer the final requested-backend argument
   without claiming that the filter stage can inherit this exact signature.
3. Pin a deterministic fallback-reason rule when more than one requirement is
   absent: ordering, first missing feature versus complete list, and wording.
```

A likely forward-safe shape would include a requested-backend value in the
instance initialisation contract, but W3D/W3X must choose the exact type and
signature.

### R2. The exhaustive build changes do not authorise all required test artifacts

Section 7.1 requires:

```text
zig build test
```

for the pure-function tests.

Section 6, explicitly labelled exhaustive, creates only:

```text
selftest
selftest-run
```

It does not authorise or define:

```text
a test compile artifact;
a `test` build step;
the modules that the test artifact receives through
`deblock4_build_options`.
```

Similarly, section 7.2 requires inspection of:

```text
the detection unit's compiled object
```

but section 6 does not create a separately inspectable detection object. If
the detection source is compiled only inside the DLL and self-test roots, there
is no standalone detection object matching the stated proof method.

Binding clarification required:

```text
1. Add the `test` artifact/step to section 6, including options-module wiring.
2. Pin one of:
   A. a separately built v1 detection inspection object and named build step; or
   B. inspection of the bounded detection symbols inside an existing artifact,
      replacing the "compiled object" requirement.
```

The validation harness may not silently add build-graph artifacts that section
6 calls exhaustive.

### R3. The comptime model mapping/exclusion contract is not yet executable

Section 3.6 says that additions to the exclusion list require W3X approval.
Therefore W3C cannot invent the initial exclusion list while implementing the
assertion.

The Stage 1B.2 model evidence already contains known naming and membership
differences that the cross-check must classify explicitly, including at least:

```text
Zig `x87`      <-> psABI FPU
Zig `cx16`     <-> psABI CMPXCHG16B
Zig `sahf`     <-> psABI LAHF-SAHF
Zig `bmi`      <-> psABI BMI1

Zig `64bit`    architecture precondition, not a level-table member
Zig `crc32`    not a separate psABI v2 row; covered by SSE4.2
Zig `xsave`    not a separate psABI v3 row; OSXSAVE is the level row
Zig tuning/codegen properties, including those captured in the 1B.2 dumps
```

OSFXSR and SCE are additional psABI policy rows not obtained from the Zig CPU
model feature differences.

Binding clarification required:

```text
Provide the reviewed initial name-mapping table and exact approved exclusion
list, or attach the three Stage 1B.2 model captures and explicitly authorise
W3C to propose the complete initial list for W3X/W3D approval BEFORE it is used
in production code.
```

Without this, a compile error is guaranteed until W3C makes an unapproved
classification decision.

### R4. The environment-read failure contract is incomplete

The pinned public error set is:

```text
error{ InvalidForceDownValue }
```

The scope does not pin how failures while acquiring the environment value are
handled if the selected Zig/Windows mechanism can fail for a reason other than:

```text
variable absent; or
value syntactically invalid.
```

W3C must not decide whether such a failure is:

```text
mapped inaccurately to InvalidForceDownValue;
reported through another error;
treated as a fatal invariant failure;
or avoided through a specifically selected non-allocating API.
```

Binding clarification required:

```text
Pin the environment-reading mechanism or the handling/mapping of every
non-absence acquisition failure, and adjust InstanceInitError if necessary.
```

### R5. P1 is still incomplete for the validation deliverables

Section 2.1 calls its inventory exact and exhaustive. Section 9 nevertheless
authorises:

```text
the G10 absence-proof standing gate;
a .bat harness;
```

without exact repository-relative filenames.

Those files are changed deliverables and must be uniquely identifiable under
the charter delivery process.

Binding clarification required:

```text
Pin the exact new validation script/harness paths and filenames.
```

For example, whether the standing gate and the complete Stage 1B.3 runner are
one batch or separate files is a design/delivery decision, not something W3C
should infer.

## 3. Session package still required before coding

This does not necessarily require another scope revision, but implementation
cannot begin until W3X supplies the normal exact-base package:

```text
- repository and branch;
- exact starting commit;
- corrected charter v1.17;
- controlling README/design specification containing the cited README 13.6;
- current build.zig;
- current src/dll_probe.zig;
- all existing modules imported by either permitted existing file;
- the Stage 1B.2 validation batch or approved successor;
- the Stage 1B.2 named-model capture files needed by section 3.6;
- confirmation of the exact new harness filenames after R5 is resolved.
```

The scope itself states that the session package will be assembled at handoff;
this review does not treat its present absence as a defect in the source tree.

## 4. Accepted implementation latitude

The following remain appropriate coder responsibilities once R1-R5 are bound:

```text
- exact thread-safe once construct in Zig 0.16.0;
- corrected CPUID/XGETBV inline-assembly constraints;
- internal private field layout consistent with the pinned public records;
- helper decomposition inside the authorised modules;
- exact loud-failing batch implementation;
- exact test vectors beyond the mandatory matrix;
- exact unique marker spellings once the permitted validation files are pinned.
```

The raw inline-assembly candidate remains correctly labelled non-normative and
is not a scope blocker. W3C will verify it by compilation and disassembly.

## 5. Requested W3D response

Please issue either:

```text
A. scope v1.3 resolving R1-R5; or
B. a binding addendum that becomes part of the W3C session package.
```

After that and receipt of the exact source package, Stage 1B.3 is ready to move
from scope review to implementation.

No production code has been written from scope v1.2.
