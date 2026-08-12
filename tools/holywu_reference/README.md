# Stage 2C isolated HolyWu r9 reference tooling

This directory is H0 tooling, not part of the Deblock4 production build graph.
W3C supplies the tooling; W3X generates and retains the DLL, completed build
record, sentinel observations and comparison logs under `inspection_2C`.

Run from an x64 MSVC developer command prompt. `build_2C_v1.bat` supplies
the standard repository paths for the first two variables; direct runs may set
them explicitly:

```text
DEBLOCK4_REFERENCE_SOURCE_ROOT  pinned read-only holywu_r9 directory
DEBLOCK4_VS_INCLUDE_ROOT        directory containing VapourSynth4.h/VSHelper4.h
DEBLOCK4_PLUGIN_PATH            built Stage 2C Deblock4 DLL
DEBLOCK4_HOLYWU_INSPECTION_DIR  optional evidence destination
```

Then run:

```text
tools\holywu_reference\run_stage_2c_holywu_reference.cmd
```

The runner calls `build_holywu_r9_scalar.cmd`, the Stage 2C plain-CMD MSVC
reference-build driver. No Stage-2C-authored PowerShell build script is
shipped.

The build hashes the actual pinned source immediately before compiling
`deblock.cpp` without `DEBLOCK_X86`. The run then executes H4 guard negative
controls, all six Addendum-A sentinels, and all 17 Addendum-B comparisons.
Every HolyWu invocation uses `opt=1`; every Classic comparison uses explicit
`backend="x86_64_v1_baseline"`. Any hash, domain, sentinel or byte-difference
failure exits nonzero. The build and each guard/sentinel/corpus invocation are
retained as separate logs under the H0 inspection directory. Generated evidence
is not committed and is not removed by the Stage 2C scoped restore block.

K30 is delivery evidence rather than an in-tree validation gate. W3C records
the ratified two-part K30 authoring audit in the delivery manifest; W3D
independently re-verifies that evidence. `build_2C_v1.bat` does not run K30.
