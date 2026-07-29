@echo off
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set "STAGE=1B.2 v1"
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

set "PAT_EVEX=^[ ]*[0-9A-F][0-9A-F]*:[ ]*62[ ]"
set "PAT_VEX2=^[ ]*[0-9A-F][0-9A-F]*:[ ]*C4[ ]"
set "PAT_VEX3=^[ ]*[0-9A-F][0-9A-F]*:[ ]*C5[ ]"
set "PAT_INSTRUCTION=^[ ]*[0-9A-F][0-9A-F]*:"
set "PAT_ZERO_TEXT=^[ ]*0 [.]text"
set "PAT_SSE41_SYMBOL=SECT[0-9A-F][0-9A-F]*.*deblock4_backend_probe_sse41_marker"
set "PAT_AVX2_SYMBOL=SECT[0-9A-F][0-9A-F]*.*deblock4_backend_probe_avx2_marker"

set "DESC_BUILD_EXPORT=Verify required build probe export"
set "DESC_GENERIC_EXPORT=Verify required generic marker export"
set "DESC_SCALAR_EXPORT=Verify required scalar marker export"
set "DESC_SSE41_EXPORT=Verify gated SSE41 marker export is absent"
set "DESC_AVX2_EXPORT=Verify gated AVX2 marker export is absent"
set "DESC_SSE41_ANCHOR=Verify SSE41 anchor export is absent"
set "DESC_AVX2_ANCHOR=Verify AVX2 anchor export is absent"
set "DESC_GENERIC_ANCHOR=Verify generic anchor name export is absent"
set "DESC_SSE41_SYMBOL=Verify SSE41 marker is defined on a section line"
set "DESC_AVX2_SYMBOL=Verify AVX2 marker is defined on a section line"
set "DESC_SSE41_TEXT=Verify SSE41 object text is nonzero"
set "DESC_AVX2_TEXT=Verify AVX2 object text is nonzero"
set "DESC_GENERIC_DISASM=Verify generic object disassembly has instruction lines"
set "DESC_SCALAR_DISASM=Verify scalar object disassembly has instruction lines"
set "DESC_SSE41_DISASM=Verify SSE41 object disassembly has instruction lines"
set "DESC_AVX2_DISASM=Verify AVX2 object disassembly has instruction lines"

set "PAT_BUILD_EXPORT=deblock4_build_probe_value"
set "PAT_GENERIC_EXPORT=deblock4_backend_probe_generic_marker"
set "PAT_SCALAR_EXPORT=deblock4_backend_probe_scalar_marker"
set "PAT_SSE41_EXPORT=deblock4_backend_probe_sse41_marker"
set "PAT_AVX2_EXPORT=deblock4_backend_probe_avx2_marker"
set "PAT_SSE41_ANCHOR=sse41_marker_anchor"
set "PAT_AVX2_ANCHOR=avx2_marker_anchor"
set "PAT_GENERIC_ANCHOR=marker_anchor"

call :change_dir
call :setup_vs
call :change_dir

set "CMD=where dumpbin"
call :run_command CMD

set "CMD=git status --short"
call :run_command CMD

set "CMD=git rev-parse --short HEAD"
call :run_command CMD

call :remove_tree ZIG_CACHE
call :remove_tree ZIG_OUT

for %%M in (%MODES%) do (
    echo.
    echo ----------------------------------------------------------------
    echo Starting %STAGE% mode %%M

    set "CMD=zig build -Doptimize=%%M"
    call :run_command CMD

    set "CMD=zig build run -Doptimize=%%M"
    call :run_command CMD

    set "CMD=zig build vs-header-run -Doptimize=%%M"
    call :run_command CMD

    set "CMD=zig build test -Doptimize=%%M"
    call :run_command CMD

    set "CMD=zig-out\bin\deblock4_dll_smoke_test.exe"
    call :run_command CMD

    set "CMD=zig build backend-isolation-run -Doptimize=%%M"
    call :run_command CMD

    echo Finished %STAGE% mode %%M PASS
    echo ----------------------------------------------------------------
)

call :make_dir INSPECTION_DIR

set "CMD=dumpbin /NOLOGO /EXPORTS !DLL_FILE!"
call :capture_command CMD EXPORTS_FILE
call :show_file EXPORTS_FILE

call :assert_literal_present EXPORTS_FILE PAT_BUILD_EXPORT DESC_BUILD_EXPORT
call :assert_literal_present EXPORTS_FILE PAT_GENERIC_EXPORT DESC_GENERIC_EXPORT
call :assert_literal_present EXPORTS_FILE PAT_SCALAR_EXPORT DESC_SCALAR_EXPORT
call :assert_literal_absent EXPORTS_FILE PAT_SSE41_EXPORT DESC_SSE41_EXPORT
call :assert_literal_absent EXPORTS_FILE PAT_AVX2_EXPORT DESC_AVX2_EXPORT
call :assert_literal_absent EXPORTS_FILE PAT_SSE41_ANCHOR DESC_SSE41_ANCHOR
call :assert_literal_absent EXPORTS_FILE PAT_AVX2_ANCHOR DESC_AVX2_ANCHOR
call :assert_literal_absent EXPORTS_FILE PAT_GENERIC_ANCHOR DESC_GENERIC_ANCHOR

echo.
echo Export table gates PASS

set "CMD=dumpbin /NOLOGO /SYMBOLS !SSE41_OBJ!"
call :capture_command CMD SSE41_SYMBOLS_FILE
call :show_file SSE41_SYMBOLS_FILE
call :assert_regex_present SSE41_SYMBOLS_FILE PAT_SSE41_SYMBOL DESC_SSE41_SYMBOL
call :assert_regex_absent SSE41_SYMBOLS_FILE PAT_ZERO_TEXT DESC_SSE41_TEXT

set "CMD=dumpbin /NOLOGO /SYMBOLS !AVX2_OBJ!"
call :capture_command CMD AVX2_SYMBOLS_FILE
call :show_file AVX2_SYMBOLS_FILE
call :assert_regex_present AVX2_SYMBOLS_FILE PAT_AVX2_SYMBOL DESC_AVX2_SYMBOL
call :assert_regex_absent AVX2_SYMBOLS_FILE PAT_ZERO_TEXT DESC_AVX2_TEXT

echo.
echo Symbol and text gates PASS

set "CMD=dumpbin /NOLOGO /DISASM:BYTES !DLL_FILE!"
call :capture_command CMD DLL_DISASM_FILE

set "CMD=dumpbin /NOLOGO /DISASM:BYTES !GENERIC_OBJ!"
call :capture_command CMD GENERIC_DISASM_FILE

set "CMD=dumpbin /NOLOGO /DISASM:BYTES !SCALAR_OBJ!"
call :capture_command CMD SCALAR_DISASM_FILE

set "CMD=dumpbin /NOLOGO /DISASM:BYTES !SSE41_OBJ!"
call :capture_command CMD SSE41_DISASM_FILE

set "CMD=dumpbin /NOLOGO /DISASM:BYTES !AVX2_OBJ!"
call :capture_command CMD AVX2_DISASM_FILE

set "CMD=zig build-exe --show-builtin -target x86_64-windows-msvc -mcpu=x86_64"
call :capture_command CMD V1_BUILTIN_FILE

set "CMD=zig build-exe --show-builtin -target x86_64-windows-msvc -mcpu=x86_64_v2"
call :capture_command CMD V2_BUILTIN_FILE

set "CMD=zig build-exe --show-builtin -target x86_64-windows-msvc -mcpu=x86_64_v3"
call :capture_command CMD V3_BUILTIN_FILE

call :assert_regex_present GENERIC_DISASM_FILE PAT_INSTRUCTION DESC_GENERIC_DISASM
call :assert_regex_present SCALAR_DISASM_FILE PAT_INSTRUCTION DESC_SCALAR_DISASM
call :assert_regex_present SSE41_DISASM_FILE PAT_INSTRUCTION DESC_SSE41_DISASM
call :assert_regex_present AVX2_DISASM_FILE PAT_INSTRUCTION DESC_AVX2_DISASM

call :gate_v1 GENERIC_DISASM_FILE generic
call :gate_v1 SCALAR_DISASM_FILE scalar
call :gate_v2 SSE41_DISASM_FILE sse41
call :gate_v3 AVX2_DISASM_FILE avx2

call :write_manual_notice

echo.
echo Automated within level deny list gates PASS
echo Manual review of all four disassembly files is still required

set "CMD=zig build -Doptimize=ReleaseFast -Dcpu=native"
set "DESC=Verify native CPU override is rejected"
call :run_expected_rejection CMD DESC

set "CMD=zig build -Doptimize=ReleaseFast -Dtarget=native"
set "DESC=Verify native target override is rejected"
call :run_expected_rejection CMD DESC

set "CMD=git diff --check"
call :run_command CMD

set "CMD=git status --short"
call :run_command CMD

echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET COMPLETED
echo W3C REVIEW OF THE ACTUAL OUTPUT IS REQUIRED BEFORE STAGE PASS
echo ================================================================================
echo.

pause
exit /b 0

:change_dir
set "current_command=CD /D !PROJECT_DIR!"
echo !current_command!
cd /d "!PROJECT_DIR!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:setup_vs
set "current_command=CALL !VSDEVCMD! -arch amd64 -host_arch amd64"
echo CALL "!VSDEVCMD!" -arch=amd64 -host_arch=amd64
call "!VSDEVCMD!" -arch=amd64 -host_arch=amd64
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:run_command
set "current_command=!%~1!"
echo.
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:capture_command
set "current_command=!%~1!"
set "output_file=!%~2!"
echo.
echo !current_command!
!current_command! > "!output_file!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:show_file
set "current_command=TYPE !%~1!"
echo.
echo !current_command!
type "!%~1!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:remove_tree
set "tree_path=!%~1!"
if not exist "!tree_path!" exit /b 0
set "current_command=RMDIR /S /Q !tree_path!"
echo !current_command!
rmdir /s /q "!tree_path!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
if exist "!tree_path!" (
    set "current_command=Verify removal of !tree_path!"
    set "exit_code=1"
    goto :fail
)
exit /b 0

:make_dir
set "dir_path=!%~1!"
if exist "!dir_path!" exit /b 0
set "current_command=MD !dir_path!"
echo !current_command!
md "!dir_path!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:assert_literal_present
set "scan_file=!%~1!"
set "scan_pattern=!%~2!"
set "current_command=!%~3!"
echo !current_command!
findstr /C:"!scan_pattern!" "!scan_file!" >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:assert_literal_absent
set "scan_file=!%~1!"
set "scan_pattern=!%~2!"
set "current_command=!%~3!"
echo !current_command!
findstr /C:"!scan_pattern!" "!scan_file!" >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:assert_regex_present
set "scan_file=!%~1!"
set "scan_pattern=!%~2!"
set "current_command=!%~3!"
echo !current_command!
findstr /I /R /C:"!scan_pattern!" "!scan_file!" >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:assert_regex_absent
set "scan_file=!%~1!"
set "scan_pattern=!%~2!"
set "current_command=!%~3!"
echo !current_command!
findstr /I /R /C:"!scan_pattern!" "!scan_file!" >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:run_expected_rejection
set "current_command=!%~2!"
echo.
echo !%~1!
!%~1!
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
set "exit_code=0"
echo !current_command! PASS
exit /b 0

:deny_regex
set "scan_file=!%~1!"
set "scan_pattern=!%~2!"
set "current_command=Verify %~3 object has no %~4 encoding"
findstr /I /R /C:"!scan_pattern!" "!scan_file!" >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    echo !current_command!
    findstr /I /R /C:"!scan_pattern!" "!scan_file!"
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:deny_mnemonic
set "scan_file=!%~1!"
set "current_command=Verify %~3 object has no %~2 instruction"
findstr /I /C:"%~2" "!scan_file!" >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    echo !current_command!
    findstr /I /C:"%~2" "!scan_file!"
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:gate_common_outside
for %%I in (aesdec aesdeclast aesenc aesenclast aesimc aeskeygenassist pclmulqdq sha1 sha256 rdrand rdseed adcx adox rdfsbase rdgsbase wrfsbase wrgsbase clflushopt clwb) do call :deny_mnemonic %1 %%I %2
exit /b 0

:gate_v1
call :gate_common_outside %1 %2
call :deny_regex %1 PAT_EVEX %2 EVEX
call :deny_regex %1 PAT_VEX2 %2 VEX_C4
call :deny_regex %1 PAT_VEX3 %2 VEX_C5
for %%I in (andn bextr blsi blsmsk blsr tzcnt bzhi mulx pdep pext rorx sarx shlx shrx lzcnt movbe) do call :deny_mnemonic %1 %%I %2
for %%I in (addsubpd addsubps fisttp haddpd haddps hsubpd hsubps lddqu movddup movshdup movsldup monitor mwait) do call :deny_mnemonic %1 %%I %2
for %%I in (pabsb pabsw pabsd palignr phaddw phaddd phaddsw phsubw phsubd phsubsw pmaddubsw pmulhrsw pshufb psignb psignw psignd) do call :deny_mnemonic %1 %%I %2
for %%I in (blendpd blendps blendvpd blendvps dppd dpps extractps insertps movntdqa mpsadbw packusdw pblendvb pblendw pcmpeqq pextrb pextrd pextrq pinsrb pinsrd pinsrq pmaxsb pmaxsd pmaxuw pmaxud pminsb pminsd pminuw pminud pmovsxbd pmovsxbq pmovsxbw pmovsxdq pmovsxwd pmovsxwq pmovzxbd pmovzxbq pmovzxbw pmovzxdq pmovzxwd pmovzxwq pmuldq pmulld ptest roundpd roundps roundsd roundss phminposuw) do call :deny_mnemonic %1 %%I %2
for %%I in (crc32 pcmpestri pcmpestrm pcmpistri pcmpistrm pcmpgtq popcnt cmpxchg16b lahf sahf) do call :deny_mnemonic %1 %%I %2
exit /b 0

:gate_v2
call :gate_common_outside %1 %2
call :deny_regex %1 PAT_EVEX %2 EVEX
call :deny_regex %1 PAT_VEX2 %2 VEX_C4
call :deny_regex %1 PAT_VEX3 %2 VEX_C5
for %%I in (andn bextr blsi blsmsk blsr tzcnt bzhi mulx pdep pext rorx sarx shlx shrx lzcnt movbe) do call :deny_mnemonic %1 %%I %2
exit /b 0

:gate_v3
call :gate_common_outside %1 %2
call :deny_regex %1 PAT_EVEX %2 EVEX
for %%I in (kadd kand kandn kmov knot kor kortest kshift ktest kunpck kxnor kxor tile) do call :deny_mnemonic %1 %%I %2
exit /b 0

:write_manual_notice
set "NOTICE_FILE=zig-out\inspection\within_level_manual_review_required.txt"
set "current_command=Write manual review notice"
> "!NOTICE_FILE!" echo Manual review is required for all four per object disassembly files.
>> "!NOTICE_FILE!" echo The automated deny lists are conservative and are not exhaustive classifiers.
>> "!NOTICE_FILE!" echo Any instruction requiring a higher psABI level is an overall scope failure.
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:fail
echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET FAIL
echo Failed command !current_command!
echo Exit code !exit_code!
echo ================================================================================
echo.
pause
exit /b !exit_code!
