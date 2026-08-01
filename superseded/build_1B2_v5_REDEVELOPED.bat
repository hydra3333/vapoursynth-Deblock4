@echo off
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem ============================================================================
rem Stage 1B.2 validation batch.
rem Shape: the body is a flat list of steps. Each step does
rem   1. set MARKER and CMD    for this step
rem   2. call one shape routine passing the marker as a quoted parameter
rem Each step overwrites the single CMD variable, so there is nothing to clear
rem and no value can leak between steps.
rem The shape routines echo the marker and the command, run it, and on any
rem failure jump to :fail which prints the banner. Anything awkward is done
rem inline. No parentheses or special characters in any echoed text.
rem ============================================================================

set "STAGE=1B.2_v1"
set "PROJECT_DIR=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
set "VSDEVCMD=C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat"
set "MODES=Debug ReleaseSafe ReleaseFast"

set "ZIG_CACHE=.zig-cache"
set "ZIG_OUT=zig-out"
set "INSPECTION_DIR=zig-out\inspection"
set "DLL_FILE=zig-out\bin\Deblock4.dll"
set "GENERIC_OBJ=zig-out\backend-objects\deblock4_backend_probe_generic.obj"
set "SCALAR_OBJ=zig-out\backend-objects\deblock4_backend_probe_scalar.obj"
set "SSE41_OBJ=zig-out\backend-objects\deblock4_backend_probe_sse41.obj"
set "AVX2_OBJ=zig-out\backend-objects\deblock4_backend_probe_avx2.obj"

set "EXPORTS_FILE=zig-out\inspection\Deblock4_exports.txt"
set "SSE41_SYMBOLS_FILE=zig-out\inspection\deblock4_backend_probe_sse41_symbols.txt"
set "AVX2_SYMBOLS_FILE=zig-out\inspection\deblock4_backend_probe_avx2_symbols.txt"
set "DLL_DISASM_FILE=zig-out\inspection\Deblock4_disasm.txt"
set "GENERIC_DISASM_FILE=zig-out\inspection\deblock4_backend_probe_generic_disasm.txt"
set "SCALAR_DISASM_FILE=zig-out\inspection\deblock4_backend_probe_scalar_disasm.txt"
set "SSE41_DISASM_FILE=zig-out\inspection\deblock4_backend_probe_sse41_disasm.txt"
set "AVX2_DISASM_FILE=zig-out\inspection\deblock4_backend_probe_avx2_disasm.txt"
set "V1_BUILTIN_FILE=zig-out\inspection\zig_builtin_x86_64_v1.txt"
set "V2_BUILTIN_FILE=zig-out\inspection\zig_builtin_x86_64_v2.txt"
set "V3_BUILTIN_FILE=zig-out\inspection\zig_builtin_x86_64_v3.txt"
set "NOTICE_FILE=zig-out\inspection\within_level_manual_review_required.txt"

rem Regex and literal search patterns. Kept as vars so no special characters
rem ever travel as a call parameter.
set "PAT_EVEX=^[ ]*[0-9A-F][0-9A-F]*:[ ]*62[ ]"
set "PAT_VEX2=^[ ]*[0-9A-F][0-9A-F]*:[ ]*C4[ ]"
set "PAT_VEX3=^[ ]*[0-9A-F][0-9A-F]*:[ ]*C5[ ]"
set "PAT_INSTRUCTION=^[ ]*[0-9A-F][0-9A-F]*:"
set "PAT_ZERO_TEXT=^[ ]*0 [.]text"
set "PAT_SSE41_SYMBOL=SECT[0-9A-F][0-9A-F]*.*deblock4_backend_probe_sse41_marker"
set "PAT_AVX2_SYMBOL=SECT[0-9A-F][0-9A-F]*.*deblock4_backend_probe_avx2_marker"

set "PAT_BUILD_EXPORT=deblock4_build_probe_value"
set "PAT_GENERIC_EXPORT=deblock4_backend_probe_generic_marker"
set "PAT_SCALAR_EXPORT=deblock4_backend_probe_scalar_marker"
set "PAT_SSE41_EXPORT=deblock4_backend_probe_sse41_marker"
set "PAT_AVX2_EXPORT=deblock4_backend_probe_avx2_marker"
set "PAT_SSE41_ANCHOR=sse41_marker_anchor"
set "PAT_AVX2_ANCHOR=avx2_marker_anchor"
set "PAT_GENERIC_ANCHOR=marker_anchor"

rem ============================================================================
rem Environment setup
rem ============================================================================

set "MARKER=Change to project directory"
set "CMD=cd /d "!PROJECT_DIR!""
call :run "Change to project directory"

set "MARKER=Configure Visual Studio environment"
set "CMD=call "!VSDEVCMD!" -arch=amd64 -host_arch=amd64"
call :run "Configure Visual Studio environment"

set "MARKER=Restore project directory after VsDevCmd"
set "CMD=cd /d "!PROJECT_DIR!""
call :run "Restore project directory after VsDevCmd"

set "MARKER=Confirm dumpbin is on the path"
set "CMD=where dumpbin"
call :run "Confirm dumpbin is on the path"

set "MARKER=Show git working tree status"
set "CMD=git status --short"
call :run "Show git working tree status"

set "MARKER=Show current git commit"
set "CMD=git rev-parse --short HEAD"
call :run "Show current git commit"

rem ============================================================================
rem Clean build outputs. Only .zig-cache and zig-out are removed. Both are
rem relative to the fixed project directory entered above and are regenerable
rem build output. Nothing else is deleted.
rem ============================================================================

call :remove_tree "!ZIG_CACHE!"
call :remove_tree "!ZIG_OUT!"

rem ============================================================================
rem Build, run and test in every optimize mode
rem ============================================================================

for %%M in (%MODES%) do (
    echo.
    echo ----------------------------------------------------------------
    echo Starting %STAGE% mode %%M

        set "MARKER=Build mode %%M"
    set "CMD=zig build -Doptimize=%%M"
    call :run "Build mode %%M"

        set "MARKER=Run build probe mode %%M"
    set "CMD=zig build run -Doptimize=%%M"
    call :run "Run build probe mode %%M"

        set "MARKER=Run header probe mode %%M"
    set "CMD=zig build vs-header-run -Doptimize=%%M"
    call :run "Run header probe mode %%M"

        set "MARKER=Run unit tests mode %%M"
    set "CMD=zig build test -Doptimize=%%M"
    call :run "Run unit tests mode %%M"

        set "MARKER=Run DLL smoke test mode %%M"
    set "CMD=zig-out\bin\deblock4_dll_smoke_test.exe"
    call :run "Run DLL smoke test mode %%M"

        set "MARKER=Run backend isolation test mode %%M"
    set "CMD=zig build backend-isolation-run -Doptimize=%%M"
    call :run "Run backend isolation test mode %%M"

    echo Finished %STAGE% mode %%M PASS
    echo ----------------------------------------------------------------
)

call :make_dir "!INSPECTION_DIR!"

rem ============================================================================
rem Export table gates. Capture the export table once, then assert the
rem required exports are present and the gated and anchor names are absent.
rem ============================================================================

set "MARKER=Capture DLL export table"
set "CMD=dumpbin /NOLOGO /EXPORTS "!DLL_FILE!""
set "OUT=!EXPORTS_FILE!"
call :capture "Capture DLL export table"

set "MARKER=Show DLL export table"
set "IN=!EXPORTS_FILE!"
call :show "Show DLL export table"

call :find_present "Verify required build probe export"     "!EXPORTS_FILE!" PAT_BUILD_EXPORT
call :find_present "Verify required generic marker export"   "!EXPORTS_FILE!" PAT_GENERIC_EXPORT
call :find_present "Verify required scalar marker export"    "!EXPORTS_FILE!" PAT_SCALAR_EXPORT
call :find_absent  "Verify gated SSE41 marker is absent"     "!EXPORTS_FILE!" PAT_SSE41_EXPORT
call :find_absent  "Verify gated AVX2 marker is absent"      "!EXPORTS_FILE!" PAT_AVX2_EXPORT
call :find_absent  "Verify SSE41 anchor name is absent"      "!EXPORTS_FILE!" PAT_SSE41_ANCHOR
call :find_absent  "Verify AVX2 anchor name is absent"       "!EXPORTS_FILE!" PAT_AVX2_ANCHOR
call :find_absent  "Verify generic anchor name is absent"    "!EXPORTS_FILE!" PAT_GENERIC_ANCHOR

echo.
echo Export table gates PASS

rem ============================================================================
rem Symbol and text gates for the two gated objects
rem ============================================================================

set "MARKER=Capture SSE41 object symbols"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!SSE41_OBJ!""
set "OUT=!SSE41_SYMBOLS_FILE!"
call :capture "Capture SSE41 object symbols"

set "MARKER=Show SSE41 object symbols"
set "IN=!SSE41_SYMBOLS_FILE!"
call :show "Show SSE41 object symbols"

call :grep_present "Verify SSE41 marker is defined on a section line" "!SSE41_SYMBOLS_FILE!" PAT_SSE41_SYMBOL
call :grep_absent  "Verify SSE41 object text is nonzero"              "!SSE41_SYMBOLS_FILE!" PAT_ZERO_TEXT

set "MARKER=Capture AVX2 object symbols"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!AVX2_OBJ!""
set "OUT=!AVX2_SYMBOLS_FILE!"
call :capture "Capture AVX2 object symbols"

set "MARKER=Show AVX2 object symbols"
set "IN=!AVX2_SYMBOLS_FILE!"
call :show "Show AVX2 object symbols"

call :grep_present "Verify AVX2 marker is defined on a section line" "!AVX2_SYMBOLS_FILE!" PAT_AVX2_SYMBOL
call :grep_absent  "Verify AVX2 object text is nonzero"             "!AVX2_SYMBOLS_FILE!" PAT_ZERO_TEXT

echo.
echo Symbol and text gates PASS

rem ============================================================================
rem Capture disassembly for the DLL and each of the four backend objects,
rem and capture the Zig resolved feature set for each named level.
rem ============================================================================

set "MARKER=Capture DLL disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!DLL_FILE!""
set "OUT=!DLL_DISASM_FILE!"
call :capture "Capture DLL disassembly"

set "MARKER=Capture generic object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!GENERIC_OBJ!""
set "OUT=!GENERIC_DISASM_FILE!"
call :capture "Capture generic object disassembly"

set "MARKER=Capture scalar object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!SCALAR_OBJ!""
set "OUT=!SCALAR_DISASM_FILE!"
call :capture "Capture scalar object disassembly"

set "MARKER=Capture SSE41 object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!SSE41_OBJ!""
set "OUT=!SSE41_DISASM_FILE!"
call :capture "Capture SSE41 object disassembly"

set "MARKER=Capture AVX2 object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!AVX2_OBJ!""
set "OUT=!AVX2_DISASM_FILE!"
call :capture "Capture AVX2 object disassembly"

set "MARKER=Capture Zig resolved feature set for x86_64_v1"
set "CMD=zig build-exe --show-builtin -target x86_64-windows-msvc -mcpu=x86_64"
set "OUT=!V1_BUILTIN_FILE!"
call :capture "Capture Zig resolved feature set for x86_64_v1"

set "MARKER=Capture Zig resolved feature set for x86_64_v2"
set "CMD=zig build-exe --show-builtin -target x86_64-windows-msvc -mcpu=x86_64_v2"
set "OUT=!V2_BUILTIN_FILE!"
call :capture "Capture Zig resolved feature set for x86_64_v2"

set "MARKER=Capture Zig resolved feature set for x86_64_v3"
set "CMD=zig build-exe --show-builtin -target x86_64-windows-msvc -mcpu=x86_64_v3"
set "OUT=!V3_BUILTIN_FILE!"
call :capture "Capture Zig resolved feature set for x86_64_v3"

rem Each disassembly file must actually contain instruction lines, otherwise
rem a later absence check would pass on an empty file.
call :grep_present "Verify generic disassembly has instruction lines" "!GENERIC_DISASM_FILE!" PAT_INSTRUCTION
call :grep_present "Verify scalar disassembly has instruction lines"  "!SCALAR_DISASM_FILE!"  PAT_INSTRUCTION
call :grep_present "Verify SSE41 disassembly has instruction lines"   "!SSE41_DISASM_FILE!"   PAT_INSTRUCTION
call :grep_present "Verify AVX2 disassembly has instruction lines"    "!AVX2_DISASM_FILE!"    PAT_INSTRUCTION

rem ============================================================================
rem Within level classification, inlined.
rem
rem This is a conservative deny list, not an exhaustive x86 classifier. For each
rem object it fails if any forbidden encoding or mnemonic for a HIGHER level than
rem the object's own level appears. Complete disassembly is retained for the
rem manual review that remains required.
rem
rem Level rules
rem   generic and scalar are x86_64_v1  no v2 or higher instruction
rem   sse41 is x86_64_v2                no v3 or higher instruction
rem   avx2 is x86_64_v3                 no instruction above v3
rem
rem Family lists
rem   OUTSIDE  optional extensions outside the named levels, forbidden in all
rem   V2ONLY   SSE3 SSSE3 SSE4.1 SSE4.2 and v2 legacy, forbidden below v2 i.e in v1
rem   V3ONLY   AVX BMI and v3 legacy mnemonics, forbidden below v3 i.e in v1 and v2
rem   AVX512   EVEX opmask and tile families, forbidden in all named levels
rem ============================================================================

set "OUTSIDE=aesdec aesdeclast aesenc aesenclast aesimc aeskeygenassist pclmulqdq sha1 sha256 rdrand rdseed adcx adox rdfsbase rdgsbase wrfsbase wrgsbase clflushopt clwb"
set "V3ONLY_MNEM=andn bextr blsi blsmsk blsr tzcnt bzhi mulx pdep pext rorx sarx shlx shrx lzcnt movbe"
set "V2ONLY_A=addsubpd addsubps fisttp haddpd haddps hsubpd hsubps lddqu movddup movshdup movsldup monitor mwait"
set "V2ONLY_B=pabsb pabsw pabsd palignr phaddw phaddd phaddsw phsubw phsubd phsubsw pmaddubsw pmulhrsw pshufb psignb psignw psignd"
set "V2ONLY_C=blendpd blendps blendvpd blendvps dppd dpps extractps insertps movntdqa mpsadbw packusdw pblendvb pblendw pcmpeqq pextrb pextrd pextrq pinsrb pinsrd pinsrq pmaxsb pmaxsd pmaxuw pmaxud pminsb pminsd pminuw pminud pmovsxbd pmovsxbq pmovsxbw pmovsxdq pmovsxwd pmovsxwq pmovzxbd pmovzxbq pmovzxbw pmovzxdq pmovzxwd pmovzxwq pmuldq pmulld ptest roundpd roundps roundsd roundss phminposuw"
set "V2ONLY_D=crc32 pcmpestri pcmpestrm pcmpistri pcmpistrm pcmpgtq popcnt cmpxchg16b lahf sahf"
set "AVX512=kadd kand kandn kmov knot kor kortest kshift ktest kunpck kxnor kxor tile"

echo.
echo Classifying generic object as x86_64_v1
call :deny_all_outside  "!GENERIC_DISASM_FILE!" generic
call :deny_regex "Verify generic object has no EVEX encoding"   "!GENERIC_DISASM_FILE!" PAT_EVEX
call :deny_regex "Verify generic object has no VEX C4 encoding" "!GENERIC_DISASM_FILE!" PAT_VEX2
call :deny_regex "Verify generic object has no VEX C5 encoding" "!GENERIC_DISASM_FILE!" PAT_VEX3
call :deny_list generic "!GENERIC_DISASM_FILE!" "!V3ONLY_MNEM!"
call :deny_list generic "!GENERIC_DISASM_FILE!" "!V2ONLY_A!"
call :deny_list generic "!GENERIC_DISASM_FILE!" "!V2ONLY_B!"
call :deny_list generic "!GENERIC_DISASM_FILE!" "!V2ONLY_C!"
call :deny_list generic "!GENERIC_DISASM_FILE!" "!V2ONLY_D!"

echo.
echo Classifying scalar object as x86_64_v1
call :deny_all_outside  "!SCALAR_DISASM_FILE!" scalar
call :deny_regex "Verify scalar object has no EVEX encoding"   "!SCALAR_DISASM_FILE!" PAT_EVEX
call :deny_regex "Verify scalar object has no VEX C4 encoding" "!SCALAR_DISASM_FILE!" PAT_VEX2
call :deny_regex "Verify scalar object has no VEX C5 encoding" "!SCALAR_DISASM_FILE!" PAT_VEX3
call :deny_list scalar "!SCALAR_DISASM_FILE!" "!V3ONLY_MNEM!"
call :deny_list scalar "!SCALAR_DISASM_FILE!" "!V2ONLY_A!"
call :deny_list scalar "!SCALAR_DISASM_FILE!" "!V2ONLY_B!"
call :deny_list scalar "!SCALAR_DISASM_FILE!" "!V2ONLY_C!"
call :deny_list scalar "!SCALAR_DISASM_FILE!" "!V2ONLY_D!"

echo.
echo Classifying sse41 object as x86_64_v2
call :deny_all_outside  "!SSE41_DISASM_FILE!" sse41
call :deny_regex "Verify sse41 object has no EVEX encoding"   "!SSE41_DISASM_FILE!" PAT_EVEX
call :deny_regex "Verify sse41 object has no VEX C4 encoding" "!SSE41_DISASM_FILE!" PAT_VEX2
call :deny_regex "Verify sse41 object has no VEX C5 encoding" "!SSE41_DISASM_FILE!" PAT_VEX3
call :deny_list sse41 "!SSE41_DISASM_FILE!" "!V3ONLY_MNEM!"

echo.
echo Classifying avx2 object as x86_64_v3
call :deny_all_outside  "!AVX2_DISASM_FILE!" avx2
call :deny_regex "Verify avx2 object has no EVEX encoding" "!AVX2_DISASM_FILE!" PAT_EVEX
call :deny_list avx2 "!AVX2_DISASM_FILE!" "!AVX512!"

rem Manual review notice. Written inline because it needs three appends.
echo Manual review is required for all four per object disassembly files.> "!NOTICE_FILE!"
echo The automated deny lists are conservative and are not exhaustive classifiers.>> "!NOTICE_FILE!"
echo Any instruction requiring a higher psABI level is an overall scope failure.>> "!NOTICE_FILE!"

echo.
echo Automated within level deny list gates PASS
echo Manual review of all four disassembly files is still required

rem ============================================================================
rem Override rejection gates. These commands MUST fail.
rem ============================================================================

set "MARKER=Verify native CPU override is rejected"
set "CMD=zig build -Doptimize=ReleaseFast -Dcpu=native"
call :expect_fail "Verify native CPU override is rejected"

set "MARKER=Verify native target override is rejected"
set "CMD=zig build -Doptimize=ReleaseFast -Dtarget=native"
call :expect_fail "Verify native target override is rejected"

rem ============================================================================
rem Final clean tree checks
rem ============================================================================

set "MARKER=Check for whitespace errors"
set "CMD=git diff --check"
call :run "Check for whitespace errors"

set "MARKER=Show final git working tree status"
set "CMD=git status --short"
call :run "Show final git working tree status"

echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET COMPLETED
echo W3C REVIEW OF THE ACTUAL OUTPUT IS REQUIRED BEFORE STAGE PASS
echo ================================================================================
echo.

pause
exit /b 0

rem ============================================================================
rem Shape routines. Each is a variation on one theme
rem   echo the marker, echo the command, run it, check the result, fail loudly.
rem The caller has already set CMD and any IN OUT variables.
rem ============================================================================

rem Run the single CMD as a plain command.
:run
echo.
echo === !MARKER!
echo !CMD!
!CMD!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

rem Run CMD capturing its output to the file named in OUT.
:capture
echo.
echo === !MARKER!
echo !CMD!
!CMD! > "!OUT!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

rem TYPE the file named in IN to the console.
:show
echo.
echo === !MARKER!
echo TYPE !IN!
type "!IN!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

rem Run CMD which is EXPECTED to fail. A zero exit is the failure here.
:expect_fail
echo.
echo === !MARKER!
echo !CMD!
!CMD!
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
set "exit_code=0"
echo !MARKER! PASS
exit /b 0

rem ============================================================================
rem Findstr gate routines. Parameters are marker, file, pattern. The pattern
rem is passed by value here because it is already a clean quoted string set
rem from a PAT_ variable and contains no call breaking characters.
rem literal  fixed string match      regex  regular expression match
rem present  must be found           absent must not be found
rem ============================================================================

:find_present
rem %1 label   %2 file   %3 NAME of a literal pattern variable
rem By name for consistency with the regex routines. Literal patterns have no
rem caret so they would survive by value, but one convention is safer to edit.
echo === %~1
set "scan_pattern=!%~3!"
findstr /C:"!scan_pattern!" "%~2" >nul < nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:find_absent
rem %1 label   %2 file   %3 NAME of a literal pattern variable  (see :find_present)
echo === %~1
set "scan_pattern=!%~3!"
findstr /C:"!scan_pattern!" "%~2" >nul < nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:grep_present
rem %1 label   %2 file   %3 NAME of a regex pattern variable  (see :deny_regex)
echo === %~1
set "scan_pattern=!%~3!"
findstr /I /R /C:"!scan_pattern!" "%~2" >nul < nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:grep_absent
rem %1 label   %2 file   %3 NAME of a regex pattern variable  (see :deny_regex)
echo === %~1
set "scan_pattern=!%~3!"
findstr /I /R /C:"!scan_pattern!" "%~2" >nul < nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

rem ============================================================================
rem Deny routines for the within level classifier.
rem   deny_regex    fail if a regex encoding pattern is present
rem   deny_list     fail if any space separated mnemonic in the list is present
rem   deny_all_outside  the common OUTSIDE family, shared by every object
rem A hit prints the offending lines before failing so W3X can see them.
rem ============================================================================

:deny_regex
rem %1 label   %2 file   %3 NAME of a regex pattern variable
rem The pattern is passed by NAME and dereferenced with !%~3! so a leading
rem caret anchor is only ever expanded via delayed expansion. Passing the
rem pattern by VALUE would double the caret when re-parsed and break findstr.
rem The  ^< nul  stdin guard stops a malformed regex hanging findstr.
set "scan_pattern=!%~3!"
findstr /I /R /C:"!scan_pattern!" "%~2" >nul < nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    echo === %~1
    findstr /I /R /C:"!scan_pattern!" "%~2" < nul
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:deny_list
rem %1 object label   %2 disassembly file   %3 space separated mnemonic list
rem INVARIANT the list in %3 MUST be caret-free literal mnemonics only.
rem A caret or regex pattern here would be mangled by the for tokenizer and can
rem HANG findstr on stdin. Caret and regex patterns go through :deny_regex by
rem NAME, never here. The  ^< nul  stdin guard is defence in depth so a bad
rem pattern can only error, never hang.
rem NOTE on this system findstr returns exit 1 for BOTH no-match AND error
rem such as a bad regex or missing file  only a structurally invalid call with
rem no arguments returns 2. So the exit code CANNOT distinguish a broken pattern
rem from a clean no-match. The guarantee that %%I is always a well formed literal
rem comes from the caret-free invariant above, not from any runtime exit check.
for %%I in (%~3) do (
    findstr /I /C:"%%I" "%~2" >nul < nul
    if "!ERRORLEVEL!"=="0" (
        echo === Verify %~1 object has no %%I instruction
        findstr /I /C:"%%I" "%~2" < nul
        set "exit_code=1"
        goto :fail
    )
)
set "exit_code=0"
exit /b 0

:deny_all_outside
rem %1 disassembly file   %2 object label
rem INVARIANT OUTSIDE is caret-free literal mnemonics only  (see :deny_list).
rem See :deny_list note  exit code cannot distinguish error from no-match here.
for %%I in (%OUTSIDE%) do (
    findstr /I /C:"%%I" "%~1" >nul < nul
    if "!ERRORLEVEL!"=="0" (
        echo === Verify %~2 object has no %%I instruction
        findstr /I /C:"%%I" "%~1" < nul
        set "exit_code=1"
        goto :fail
    )
)
set "exit_code=0"
exit /b 0

rem ============================================================================
rem Utility routines
rem ============================================================================

:remove_tree
rem %1 is a relative path under the fixed project directory. Only build output
rem is ever passed here. No op if it does not exist. Verifies removal.
if "%~1"=="" exit /b 0
set "tree_path=%~1"
if not exist "!tree_path!" exit /b 0
echo.
echo === Remove build output "!tree_path!"
REM CMD is used in :fail
set "CMD=rmdir /S /Q "!tree_path!""
echo rmdir /S /Q "!tree_path!"
rmdir /s /q "!tree_path!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
if exist "!tree_path!" (
    set "exit_code=1"
    goto :fail
)
exit /b 0

:make_dir
if "%~1"=="" exit /b 0
set "dir_path=%~1"
if exist "!dir_path!" exit /b 0
echo.
echo === Create directory "!dir_path!"
REM CMD is used in :fail
set "CMD=md "!dir_path!""
echo md "!dir_path!"
md "!dir_path!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

rem ============================================================================
rem Failure banner. Any goto :fail lands here.
rem ============================================================================

:fail
echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET FAIL
echo Failed step !MARKER!
echo CMD !CMD!
echo Exit code !exit_code!
echo ================================================================================
echo.
pause
exit /b !exit_code!
