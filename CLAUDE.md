# Deblock4 — project guide for Claude Code

Deblock4 is a VapourSynth API4 deblocking plugin written in **Zig 0.16.0**,
targeting PAL 576i MPEG-2 tape restoration (regime-3 adaptive DCT is the
real-world target). This file tells you how to work in this repo. Read it,
then read the charter before proposing anything.

## Read first, every session

Before proposing or making any change, read the current design authority in
`dev_documentation/`:

1. **`dev_documentation/AI_Charter_and_Invariants_Card_v1_12.md`** — the
   binding charter and invariants. Treat every invariant as non-negotiable.
   In particular, **G6 prohibits relying on implicit toolchain behaviour for
   safety properties**: if a safety property depends on Zig 0.16 doing
   something implicitly, it must be made explicit (e.g. address-taken anchors
   to force object emission), not assumed.
2. The **latest** `Deblock4_Forward_Roadmap_v1_*.md`,
   `Deblock4_Project_Status_v1_*.md`, and
   `README_Deblock4_Design_Spec_v1_*.md` (highest version number wins).

Always use the highest-numbered version of a document. Ignore anything under
`dev_documentation/superseded/` — those are retired on purpose.

## Working conventions (binding)

- **Propose before you transform.** For any non-trivial change, state the plan
  and show the diff for review *before* editing. Do not make sweeping edits in
  one shot. When you want a change-free session (design/review), I will put you
  in plan mode — respect it.
- **Before/after block discipline.** Wrap every code change in clearly marked
  before/after blocks with a **unique phase/change identifier** so edits are
  auditable and reversible. Never make an unlabelled in-place edit.
- **Never delete superseded code — comment it out.** Prefix retired lines with
  `#OLD#` (or the language-appropriate equivalent) rather than removing them,
  unless I explicitly ask for deletion.
- **Superseded documents** move to `dev_documentation/superseded/`, they are
  not deleted.
- **Comment discipline.** Keep comments accurate and load-bearing; update them
  when the code they describe changes.

## Build

Zig 0.16.0 is on PATH. Build from the repo root:

```
zig build
```

Use `zig build -Doptimize=ReleaseFast` (or the flags in the roadmap/spec) for
release builds, `zig fmt` for formatting, and `zig test` for tests. Report the
exact compiler diagnostics on failure — the VS Code extension exposes them to
you directly.

## Running VapourSynth scripts

Portable VapourSynth lives at `D:\TEST\Vapoursynth_x64_R78` and **REQUIRES that
folder as the working directory** for its portable Python / DLLs / plugins to
resolve.

**NEVER call `vspipe.exe` directly by absolute path** — it will fail to resolve
portable Python and plugins. **ALWAYS** run `.vpy` scripts through the wrapper:

```
tools\run_vs.cmd <vspipe args...>
```

The wrapper sets the correct CWD via `pushd`, runs vspipe, restores the CWD,
and propagates the exit code. Examples:

```
tools\run_vs.cmd --info myscript.vpy
tools\run_vs.cmd -c y4m myscript.vpy - | x264 --demuxer y4m - -o out.mkv
```

Scripts should use **absolute paths** for sources/outputs, because the wrapper
forces the working directory to the VapourSynth root.

## Permissions

Tool permissions are in `.claude/settings.json`. Build (`zig …`), the VS
wrapper (`run_vs.cmd`), and read-only git commands run without prompting;
`git push` asks; destructive commands (`rm`, `del`, force-push, hard reset) are
denied. If a routine command keeps prompting, tell me and I'll add it.
