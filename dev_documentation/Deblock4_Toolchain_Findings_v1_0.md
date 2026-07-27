# Deblock4 - Toolchain Findings

**Version:** 1.0
**Date:** 2026-07-27
**Status:** Informative knowledge record; not controlling. Durable capture of
empirically established Zig/linker toolchain facts, so they are not re-derived.
**Encoding:** US-ASCII only
**Provenance:** Each finding records how it was established (build test, source
read, or inference) per the project's verify-cold discipline.

---

# F1. Zig 0.16 omits an unreferenced non-exported function entirely

**Status: established by build test (W3X Debug build, Stage 1B.1) plus dumpbin
/SYMBOLS on the resulting cache objects. Conclusive.**

Context: Stage 1B.1 needed the SSE4.1/AVX2 backend marker functions to be
present and linked in the DLL but NOT exported (charter G6) and NOT called
(charter G5). The first attempt declared them as ordinary non-exported
functions and tried to retain them with Zig's forceUndefinedSymbol (which emits
a COFF /INCLUDE-class linker requirement):

```zig
pub fn deblock4_backend_probe_sse41_marker() callconv(.c) u32 { return ...; }
```

with, in build.zig:

```zig
dll.forceUndefinedSymbol("deblock4_backend_probe_sse41_marker");
```

Result: the DLL link FAILED with "undefined symbol". dumpbin /SYMBOLS on the
gated cache objects showed:

- `.text` section length ZERO;
- no marker symbol present at all - not under the requested name, not mangled;
- only static build-metadata symbols (builtin.cpu, Target.x86.cpu.x86_64,
  anonymous constants) and the source filename in debug metadata.

Conclusion: **a top-level `pub fn ... callconv(.c)` that is never semantically
referenced (never called, never address-taken) and not declared `export` is
NOT EMITTED by Zig 0.16.** Zig's lazy analysis/codegen omits it. Therefore
forceUndefinedSymbol has nothing to retain - it correctly requests a symbol that
was never generated.

Consequences / rules of thumb:
- `callconv(.c)` sets the calling convention; it does NOT force emission and
  does NOT guarantee an unmangled external COFF symbol name.
- `export` DOES force emission and an external name - but also creates a PE
  export-table entry, which G6 forbids for gated code. So `export` is not a
  usable retention mechanism for non-exported code.
- forceUndefinedSymbol / COFF /INCLUDE can only retain a symbol that actually
  exists in an input object. It cannot cause emission.

# F2. Retention-without-export is achieved by an explicit reference-graph anchor

**Status: ratified design consequence of F1; the mechanism itself to be
confirmed by the next Stage 1B.1 build.**

To make a gated function present (emitted + linker-retained) while non-exported
and non-executed, give it a genuine SEMANTIC reference that is an ADDRESS
reference, taken by retained baseline code:

```text
- baseline (generic-target) code takes the address of each gated marker and
  stores it into an internal, non-exported pointer or pointer table;
- taking the address forces Zig to EMIT the function (it is now referenced);
- the address reference puts the function in the linker reachability graph, so
  /OPT:REF RETAINS it;
- the address is TAKEN, never CALLED - so no execution path exists (G5 holds);
- nothing is declared export, and the pointer table is internal - so nothing
  enters the PE export table (G6 holds, structurally).
```

The G5-critical distinction: ADDRESS-TAKEN retains code without creating an
execution path; a CALL would create one and is forbidden until the Stage 1B.3
capability guard exists. The anchor must achieve emission + retention +
non-export + non-execution simultaneously.

This is also the shape of the eventual real dispatch mechanism (a
capability-populated function-pointer table, the FFmpeg/dav1d idiom identified
in the retention/export research), so the anchor is a step toward the real
architecture, not a throwaway.

Verification the anchor works (contrast with F1's failure):
- DLL links successfully;
- dumpbin /SYMBOLS on the gated objects shows each marker present with
  NON-ZERO .text;
- dumpbin /EXPORTS on the DLL shows NEITHER gated marker.

# F3. Windows binary inspection tooling

**Status: established by environment inspection (W3X machine).**

- Zig 0.16 ships only a flagless objdump passthrough (lib/compiler/objdump.zig);
  no standalone llvm-objdump or llvm-nm is bundled. `zig objdump --help` shows
  only -h/--help. Inadequate for targeted symbol/export inspection.
- The usable inspector is MSVC `dumpbin`, present in the VS 2026 install under
  `C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC\<ver>\
  bin\Hostx64\x64\dumpbin.exe` (VS product year 2026 = internal version 18;
  two toolsets seen, 14.44.x and 14.51.x).
- dumpbin is reached WITHOUT hard-coding the MSVC version by calling VsDevCmd to
  set the environment, then relying on PATH:
  `CALL "C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64`
  (note: VsDevCmd changes directory, so restore the working directory after).
- Commands in use: `dumpbin /EXPORTS <dll>` (export-table check),
  `dumpbin /SYMBOLS <obj>` (symbol/emission check),
  `dumpbin /DISASM <dll>` (supplementary only - shows instructions PRESENT, not
  whether any path REACHES them, so never the load-bearing non-execution proof).

---

*This file is informative knowledge capture so hard-won toolchain facts are not
re-derived in a later chat. The charter and README prevail for any controlling
rule.*
