# Deblock4 - Post-5C Maintenance M1 - W3C Pre-Implementation Response R1-R4 v1.0

**From:** W3C (coder)
**Route:** W3C -> W3X -> W3D
**Scope reviewed:** `Deblock4_Scope_PostM1_v2_Commentary_Reconciliation_v1_1.md`
**Handover reviewed:** `Deblock4_PostM1_W3D_Handover_to_W3C_v1_0.md`
**Base:** committed Stage 5C tree, identity `0.1.0-dev+5C`, as confirmed by W3X
**Status:** PRE-IMPLEMENTATION RESPONSE ONLY - no M1 commentary authored and no repository file changed

## DECISIONS/QUESTIONS FOR W3X

### M1-W3C-Q1 - Narrow M1-C7 masked-I/O wording before authoring

The safety conclusion in M1-C7 is correct: a C2 tail must never be implemented
by a full-width read followed by a partial/masked store, because the read itself
may pass the proven live row span. The wording that "SSE4.1 has no byte/word
masked-I/O mechanism either", however, is too absolute.

Intel documents `MASKMOVDQU` / `_mm_maskmoveu_si128` as a masked memory-store
operation inherited from SSE2, with byte selection. It does NOT provide the
corresponding safe masked byte/word load needed to make an otherwise over-wide
right-edge read legal. Therefore it does not alter the project's exact-span tail
rule, but the maintainer comment should not imply that no byte-masked store
instruction exists.

**Current M1-C7 wording to change:**

> SSE4.1 has no byte/word masked-I/O mechanism either.

**W3C proposed replacement concept:**

> SSE4.1 has no general byte/word masked load-and-store tail mechanism suitable
> here. MASKMOVDQU can conditionally store selected bytes, but it supplies no
> corresponding safe masked byte/word load; therefore it cannot make an
> over-wide right-edge read legal and cannot replace exact-span decomposition.

The exact final header prose can be kept shorter, but it should preserve that
technical distinction.

**Recommendation:** W3D amend/clarify M1-C7 in the ratified round outcome; no
algorithm, scope surface, or proof change is required.

### M1-W3C-Q2 - Current committed documentation generation is needed to close R4

The M1 authority set names D0 Binding Knowledge Index v1.14 and Project Status
v1.27. Those post-5C files were not supplied with this handover and the exact
versions are not available in W3C's accessible conversation/library files; the
highest D0 located there is v1.13.

R4 requires an independent sweep of the committed, non-superseded documentation
set. W3C therefore cannot honestly issue a NIL R4 finding yet.

**Recommendation:** W3X supply the current post-5C documentation package, or at
minimum D0 v1.14 and Project Status v1.27 plus any other current files added or
revised at the Stage 5C close. W3C will then perform the required independent
delta sweep before implementation.

No M1 implementation should start until Q1 is resolved and R4 is closed.

---

# R1 - Inertness and source-shape proof mechanism

W3C proposes a MANUAL W3X proof sequence rather than a new `build_M1_v1.bat`.
This is the cleanest fit with the M1 scope: no new repository file, no
repository-operating script, no PowerShell addition, no git-dependent
machinery, and no staging.

All build commands below are run manually from the Visual Studio 2026 x64
developer prompt. Generated evidence lives only under `zig-out/` and
`.zig-cache/`; neither is an M1 source delivery.

## R1.1 Build and retain the committed 5C base artefacts BEFORE applying M1

W3X first confirms the tree is the committed `0.1.0-dev+5C` base.

Retain exact source copies for M1-T3:

```cmd
mkdir zig-out\inspection_M1
mkdir zig-out\inspection_M1\base_source
copy /b src\classic_backend_v2_sse41.zig zig-out\inspection_M1\base_source\classic_backend_v2_sse41.zig
copy /b src\classic_backend_v3_avx2.zig zig-out\inspection_M1\base_source\classic_backend_v3_avx2.zig
```

Build the ReleaseFast base v2 inspection object and production DLL into their
own prefix/cache:

```cmd
zig build classic-v2-object --prefix "zig-out\M1_base" --cache-dir ".zig-cache\M1_base" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
zig build --prefix "zig-out\M1_base" --cache-dir ".zig-cache\M1_base" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
```

The retained base artefacts are:

```text
zig-out\M1_base\backend-objects\classic_backend_v2_sse41.obj
zig-out\M1_base\bin\Deblock4.dll
```

They should be copied into `zig-out\inspection_M1\base_binary\` before M1 is
manually applied, so the comparison inputs cannot be overwritten.

## R1.2 After W3X ratifies the round, apply only the authorised comments

Application is the ordinary manual W3X copy of the M1 delivery. There is no
automated repository operation. The only permissible source changes are the
ratified comment block in v2 and, if retained after R3 review, the single K33
comment correction in v3.

## R1.3 Build candidate artefacts from a separate prefix/cache

```cmd
zig build classic-v2-object --prefix "zig-out\M1_candidate" --cache-dir ".zig-cache\M1_candidate" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
zig build --prefix "zig-out\M1_candidate" --cache-dir ".zig-cache\M1_candidate" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose
```

Candidate artefacts are:

```text
zig-out\M1_candidate\backend-objects\classic_backend_v2_sse41.obj
zig-out\M1_candidate\bin\Deblock4.dll
```

## R1.4 M1-T1 byte identity

Use ordinary binary comparison and retain the console transcript:

```cmd
fc /b zig-out\inspection_M1\base_binary\classic_backend_v2_sse41.obj zig-out\M1_candidate\backend-objects\classic_backend_v2_sse41.obj
fc /b zig-out\inspection_M1\base_binary\Deblock4.dll zig-out\M1_candidate\bin\Deblock4.dll
```

The v2 object comparison is the absolute primary gate and must report no byte
difference.

W3C expects the ReleaseFast production DLL also to be byte-stable under this
pinned Zig/toolchain setup because M1 changes comments only and the build
inputs, executable tokens and optimisation settings are unchanged. The DLL
comparison should therefore also report no byte difference. If Zig/COFF embeds
build-varying metadata that unexpectedly defeats whole-file DLL identity, that
is reported as evidence exactly as the scope states; it does NOT weaken the
mandatory v2-object identity gate. M1-T2 and M1-T3 then provide the companion
proof.

## R1.5 M1-T3 source-shape audit

Retain ordinary line-numbered source diffs:

```cmd
fc /n zig-out\inspection_M1\base_source\classic_backend_v2_sse41.zig src\classic_backend_v2_sse41.zig > zig-out\inspection_M1\v2_source_diff.txt
fc /n zig-out\inspection_M1\base_source\classic_backend_v3_avx2.zig src\classic_backend_v3_avx2.zig > zig-out\inspection_M1\v3_source_diff.txt
```

Those transcripts must show only `//` header-comment lines changing.

For the mechanical non-comment equality check, make generated comment-stripped
projections and binary-compare them:

```cmd
findstr /v /b /c:"//" zig-out\inspection_M1\base_source\classic_backend_v2_sse41.zig > zig-out\inspection_M1\base_v2_noncomment.txt
findstr /v /b /c:"//" src\classic_backend_v2_sse41.zig > zig-out\inspection_M1\m1_v2_noncomment.txt
fc /b zig-out\inspection_M1\base_v2_noncomment.txt zig-out\inspection_M1\m1_v2_noncomment.txt

findstr /v /b /c:"//" zig-out\inspection_M1\base_source\classic_backend_v3_avx2.zig > zig-out\inspection_M1\base_v3_noncomment.txt
findstr /v /b /c:"//" src\classic_backend_v3_avx2.zig > zig-out\inspection_M1\m1_v3_noncomment.txt
fc /b zig-out\inspection_M1\base_v3_noncomment.txt zig-out\inspection_M1\m1_v3_noncomment.txt
```

At the scoped starting state all authorised comments are in the header blocks;
there are no inline comments below them. Thus equality of the non-comment
projections plus the retained `fc /n` transcript proves that no executable or
declarative source line moved.

The identifier audit is correspondingly trivial and must report:

```text
no identifier added, removed or renamed
```

## R1.6 Retained matrix

After M1-T1/T3 source and binary checks, W3X re-runs the already-accepted
`build_5C_v1.bat` with the same W3D differential and benchmark runner paths.
No new M1 harness, corpus, test, or batch is proposed.

W3C makes no execution or PASS claim.

---

# R2 - M1-C1..C9 assessment against the frozen source

## M1-C1 - CONFIRM

The accepted v2 unit is a thin target-specific object. It imports
`classic_vector_backend.zig` and calls the same `processPlane` body used by v3.
The v2-specific differences are its named x86-64-v2 target/guard and the
compile-time N values.

## M1-C2 - CONFIRM

The live v2 source calls:

```text
processPlane(u8, 16, ...)
processPlane(u16, 8, ...)
```

Therefore:

```text
u8:  16 lanes x 1 byte = 16 bytes = 128 bits
u16:  8 lanes x 2 bytes = 16 bytes = 128 bits
```

The warning is also correct: `u8 N=16` is 128 bits, while the v3 `u16 N=16`
storage batch is 256 bits. N is a lane count, not a byte count.

## M1-C3 - CONFIRM

The frozen `filterLanes(T,L,...)` converts all six storage vectors to
`@Vector(L, i32)` before the canonical arithmetic. Logical vector width
therefore need not equal one physical XMM register. Generated-code inspection,
not source spelling, remains the machine-tier proof.

## M1-C4 - CONFIRM

The horizontal path is parameterised by N. The vertical full segment is
hard-coded by algorithm to four rows and calls `filterLanes(T, 4, ...)`.
The vertical path takes no backend N. It must not be widened for v2 or v3.

## M1-C5 - CONFIRM

The C1/C2 distinction is correct. An incomplete six-sample algorithmic
footprint is ineligible; a valid footprint with fewer than N horizontal sample
positions remaining is still processed through the tail path.

## M1-C6 - CONFIRM, including K33 V1 terminal

For v2 entry widths the frozen recursive half-width mechanism yields:

```text
u8  N=16: 16, 8, 4, 2, 1
u16 N=8 :  8, 4, 2, 1
```

The live one-sample terminal is V1, not the defensive scalar-column branch.
At N=2 with one sample left, `half=1` and the code executes
`filterHorizontalLanes(T,1,...)`, consumes the sample, then recurses to N=1
with `remaining==0`, which returns before the scalar branch.

## M1-C7 - CONFIRM THE SAFETY RULE; AMEND THE ISA WORDING

The exact-span safety rule is correct and should be prominent. No tail may
perform an over-wide source read and attempt to repair only the store.

The final statement that SSE4.1 has "no byte/word masked-I/O mechanism either"
should be narrowed as set out in M1-W3C-Q1. A byte-selected masked store
(`MASKMOVDQU`) exists in the SSE2/SSE4-era instruction set, but it does not
provide the safe masked byte/word load required to legalise an over-wide read.
The project still has no suitable general masked load+store tail mechanism at
v2, so descending exact-span decomposition remains the correct design.

## M1-C8 - CONFIRM

The v2 unit has the named-model x86-64-v2 compile-time drift guard and object-
mode `export fn` roots. Those roots are object emission/linkage, not permission
to expose public DLL PE entry points. Runtime execution remains licensed only
by the full whole-level v2 selection contract, not a bare SSE4.1 feature test.

## M1-C9 - CONFIRM

K33 is consistent with the frozen source as described under C6. Both sibling
headers should name V1 as the one-lane vector terminal and distinguish it from
the defensive, unreachable scalar-column branch.

---

# R3 - Existing v3 tail wording against K33

The existing v3 header is SEMANTICALLY CORRECT but not fully K33-COMPLETE.
It currently says that the descending chain terminates in the "one-lane vector
V1 path". That correctly rejects the historical "scalar 1" description, but it
does not explicitly name `filterHorizontalLanes(T, 1, ...)` or distinguish V1
from the defensive scalar-column branch as M1-C9 requires.

W3C therefore recommends the authorised ONE comment correction in v3, with no
other style edit. The existing sentence should be replaced by a K33-complete
sentence along this shape:

```text
... terminating in the one-lane vector path
V1 = filterHorizontalLanes(T, 1, ...), not the defensive scalar-column
branch, which is unreachable from the ratified entry widths.
```

This is one factual comment correction, even if wrapped over multiple `//`
lines to match the existing width.

---

# R4 - Knowledge sweep

**R4 is NOT YET CLOSED.**

W3C independently searched the currently accessible non-superseded Deblock4
files rather than starting from the M1 content list. No additional M1-specific
committed knowledge finding was discovered in the accessible generation.
However, the M1 scope explicitly names later authority files D0 v1.14 and
Project Status v1.27; those exact post-5C documents are not currently available
to W3C. The accessible library contains D0 v1.13, which is superseded for this
scope.

Accordingly W3C does NOT report a false NIL sweep. Once W3X supplies the current
post-5C documentation generation, W3C will perform the required final delta
sweep and either:

```text
R4: NIL - no additional relevant non-superseded knowledge found
```

or report the numbered findings for W3D verification.

---

# Overall W3C recommendation

The M1 inertness-proof structure is workable without adding any repository
machinery. M1-C1..C6, C8 and C9 are confirmed against the frozen source. M1-C7
needs only a technical wording refinement; its safety conclusion and the
accepted tail mechanism do not change. The v3 header needs the one authorised
K33-completion sentence.

Implementation remains correctly blocked until W3X/W3D resolve M1-W3C-Q1 and
W3X supplies the current documentation generation so R4 can be closed.

**No M1 commentary has been authored and no repository file has been changed.**
