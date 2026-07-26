## Assessment

The scope is substantially improved and its central architecture is sound: one existing DLL, separately targeted probe objects, no SSE4.1/AVX2 exports or calls, and structural non-reachability rather than relying on disassembly. 

I **do not recommend producing the implementation patch yet**. Two matters need designer ratification, one of which is a genuine G2/G5 gap.

### 1. The generic baseline target is under-specified

Cold inspection of the supplied source shows that the current `build.zig` begins from:

```zig
const target = b.standardTargetOptions(.{});
```

Without an explicit target selection, Zig’s standard target options use the native host target and CPU characteristics. That means the existing DLL root module—and potentially the generic, scalar and smoke-test code—could be compiled using instructions supported by W3X’s machine rather than a deliberately safe x86-64 baseline. ([Zig Programming Language][1])

That conflicts with the scope’s requirement that generic and scalar code be baseline-safe and executable on any supported x86-64 machine.  

The scope should expressly require a fixed provisional baseline target for:

```text
Deblock4.dll root module
generic probe object
scalar probe object
backend-isolation smoke test
preferably the existing DLL smoke test as well
```

It must also prevent `-Dcpu=native`, another CPU override, or a build-option route from silently contaminating those baseline units. That is necessary to satisfy G5’s no-bypass rule.

### 2. Retention needs one exact, ratified mechanism

Zig 0.16 supports separate object compilation with `b.addObject`, followed by adding the emitted object to another compile step. ([Zig Programming Language][1])

The strongest candidate is:

```text
1. Compile four separate backend objects.
2. Add all four objects to Deblock4.dll.
3. Give the SSE4.1 and AVX2 objects stable linker-visible marker symbols.
4. Call dll.forceUndefinedSymbol() for those two symbols.
5. Install copies of the emitted .obj files at stable paths.
6. Use dumpbin /SYMBOLS on those installed objects.
7. Use dumpbin /EXPORTS on Deblock4.dll to prove the target symbols are absent.
```

Zig’s `forceUndefinedSymbol` maps to the COFF/PE linker’s `/include:<symbol>` operation, so a successful link proves that the linker resolved and consumed the symbol without adding any call path. ([git.medv.io][2]) The emitted object path can be obtained through `getEmittedBin()` and installed at a predictable inspection location. ([git.medv.io][2])

This is stronger than merely proving that an intermediate `.obj` exists. The designer should explicitly accept it as the scope’s fallback “evidence the linker consumed them.”

A Windows toolchain result must remain an acceptance gate: if the object-level marker technique unexpectedly places an SSE4.1 or AVX2 symbol in the DLL export table, validation must stop and the design must be revised.

### 3. “Code linked” conflicts with the data-only alternative

The scope says target-specific **code** must be retained, but also allows a data-only marker.  A data marker can prove that an object contributed data to the DLL; it does not necessarily prove that target-specific executable code survived dead stripping.

I recommend retaining an actual non-exported marker function through the forced-symbol mechanism and removing the data-only alternative for this phase. Otherwise, the acceptance wording should be weakened from “code linked” to “object contribution retained.”

Here is the response for W3D:

I have completed the first cold technical review of Stage 1B.1 scope v1.1.

ORIENTATION CHECK

Received and applied:

```
Controlling charter:
    AI_Charter_and_Invariants_Card_v1_8.md
    internal version 1.8

Controlling design specification:
    README_Deblock4_Design_Spec_v1.1.md
    design revision 1.1

Active coding scope:
    Deblock4_Scope_Stage_1B1_Backend_Object_Isolation_v1_1.md

Starting commit:
    8b6779c4d39d96622825e0454e1cc23974de4a9a
```

Current milestone:

```
Stage 1A.1 accepted and committed.
Stage 1B.1 is proposed as the active implementation scope.
```

The central G5 consequence is understood:

```
SSE4.1 and AVX2 objects may be compiled and linked into Deblock4.dll, but
before Stage 1B.3 they must never be exported, called, executed, or otherwise
reachable through startup, registration, static-initialisation, test, import,
command-line, environment or manual-bypass paths.
```

GENERAL ASSESSMENT

I endorse the following scope decisions:

* extend the existing Deblock4.dll rather than create a second probe DLL;
* compile generic, scalar, SSE4.1 and AVX2 probes as separate objects;
* allow generic and scalar probes to execute;
* prohibit execution and export of SSE4.1 and AVX2 probe code;
* prove non-execution structurally rather than by treating disassembly as a
  reachability proof;
* defer exact feature closures and emitted-instruction analysis to Stage 1B.2;
* complete build_1B1.bat only after W3D accepts the implementation patch.

I am not yet ready to issue the implementation patch because one blocking target
contract and one retention-proof mechanism need to be ratified.

REQUIRED AMENDMENT 1 - EXPLICIT BASELINE TARGET CONTRACT

The current build.zig obtains its main target through:

```
const target = b.standardTargetOptions(.{});
```

When no explicit target/CPU is supplied, this can resolve to the native host CPU.
On an AVX2-capable development machine, that does not establish that the DLL root,
generic object, scalar object or smoke-test code is free from gated instructions.

Stage 1B.1 must therefore require a deliberate provisional x86-64 baseline target
for at least:

```
- the Deblock4.dll root module;
- backend_probe_generic;
- backend_probe_scalar;
- backend_isolation_smoke_test;
- preferably the existing DLL smoke-test executable as well.
```

The scope should also state that no `-Dcpu=native`, CPU override, environment
route or other build option may silently replace that baseline for these units.
An unsupported or conflicting target request must be rejected rather than
turning generic code into native-host code.

This is not a Stage 1B.2 feature-closure decision. It is the minimum structural
contract needed to satisfy G2 and G5 during Stage 1B.1.

Please specify the semantic requirement and leave the exact Zig 0.16 target-query
syntax to W3C, subject to W3X compilation proof.

REQUIRED CONFIRMATION 2 - FORCED-SYMBOL RETENTION PROOF

I propose this implementation and evidence chain:

```
1. Build the generic, scalar, SSE4.1 and AVX2 probes using separate
   `b.addObject` compile steps under their respective provisional targets.

2. Add all four emitted objects to the existing Deblock4.dll.

3. Give each target-specific object a stable linker-visible marker symbol,
   with no startup registration, pointer table or call reference.

4. Apply `dll.forceUndefinedSymbol()` to the SSE4.1 and AVX2 marker symbols.

   On Windows COFF/PE this supplies the linker `/include:<symbol>`
   requirement. The DLL link must therefore fail if either object or symbol
   is absent. Successful linking proves that the linker consumed the
   target-specific object contribution without creating a call path.

5. Install copies of all four emitted `.obj` files to stable inspection paths
   under zig-out so build_1B1.bat does not depend on Zig cache filenames.

6. Run `dumpbin /SYMBOLS` against the installed SSE4.1 and AVX2 objects to
   prove the expected definitions exist.

7. Run `dumpbin /EXPORTS zig-out\bin\Deblock4.dll` and require that neither
   target-specific marker appears in the PE export table.

8. Establish non-reachability by source/build-graph inspection:
   no generic/scalar call, no function-pointer table, no startup hook, no
   static initialiser, no registration path and no smoke-test call references
   either target-specific function.
```

Please confirm that `forceUndefinedSymbol` plus object-symbol inspection and the
successful DLL link satisfies the scope's fallback requirement for "evidence the
linker consumed them."

The implementation must remain toolchain-gated. If W3X's DUMPBIN result shows
that the chosen object-level symbol form unexpectedly becomes a public DLL
export, Stage 1B.1 must stop and the retention mechanism must be revised rather
than accepting the export.

REQUIRED CLARIFICATION 3 - CODE RETENTION VERSUS DATA-ONLY MARKERS

The current scope simultaneously requires target-specific code to be linked and
allows a data-only marker.

A retained data marker proves an object contributed data, but it does not
necessarily prove that executable target-specific code survived link-time dead
stripping.

My preference is:

```
- retain a real, trivial, non-exported target-specific marker function using
  the forced-symbol mechanism above;
- remove the data-only alternative from this phase's accepted implementation.
```

Alternatively, change the scope's acceptance language from "target-specific code
is retained" to "a contribution from each target object is retained." The first
option gives the stronger and more useful Stage 1B.1 proof.

VALIDATION DETAIL

After the three-mode loop, the representative structural-inspection artifacts
should be identified as the final ReleaseFast outputs, because ReleaseFast is the
last mode built by build_1B1.bat.

The exact additions to build_1B1.bat will be supplied by W3C only after:

```
- this target/retention design is ratified;
- the implementation patch is issued;
- W3D accepts that patch.
```

REQUEST

Please issue Stage 1B.1 scope v1.2 incorporating the explicit baseline/no-override
contract and resolving the retention-marker question above.

Once those points are settled, I expect to be able to produce the Stage 1B.1
implementation delivery against commit:

```
8b6779c4d39d96622825e0454e1cc23974de4a9a
```

No change to `build_1B1.bat` should be made yet. Its exact per-mode and DUMPBIN blocks remain correctly deferred until the implementation design and patch are accepted.

[1]: https://ziglang.org/documentation/0.16.0/ "https://ziglang.org/documentation/0.16.0/"
[2]: https://git.medv.io/zig/blob/master/lib/std/Build/Step/Compile.zig.html "https://git.medv.io/zig/blob/master/lib/std/Build/Step/Compile.zig.html"
