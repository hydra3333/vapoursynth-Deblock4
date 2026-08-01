@echo off
@if /I "%~1"=="--worker" goto :worker
@setlocal ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

rem Launch the validation body in a dedicated child cmd.exe. This guarantees
rem that :fail can terminate the whole validation immediately without closing
rem the caller's console, while the parent retains one complete combined-stream
rem transcript for review.
set "TRANSCRIPT_TEMP=%TEMP%\Deblock4_build_1B3_v5_%RANDOM%_%RANDOM%_full_output.log"
"%ComSpec%" /D /V:OFF /C "call ""%~f0"" --worker" >"%TRANSCRIPT_TEMP%" 2>&1
set "OUTER_EXIT_CODE=%ERRORLEVEL%"

set "TRANSCRIPT_DIR=%~dp0zig-out\inspection_1B3"
if not exist "%TRANSCRIPT_DIR%" md "%TRANSCRIPT_DIR%" >nul 2>nul
set "TRANSCRIPT_FILE=%TRANSCRIPT_DIR%\build_1B3_v5_full_output.log"
copy /Y "%TRANSCRIPT_TEMP%" "%TRANSCRIPT_FILE%" >nul
>>"%TRANSCRIPT_FILE%" echo.
>>"%TRANSCRIPT_FILE%" echo OUTER_BATCH_EXIT_CODE=%OUTER_EXIT_CODE%

type "%TRANSCRIPT_FILE%"

set "DIAGNOSTIC_INDEX=%TRANSCRIPT_DIR%\build_1B3_v5_diagnostic_index.txt"
findstr /N /I /C:"LLVM" /C:"error:" /C:"panic:" /C:"failed command:" /C:"internal compiler error" /C:"unable to emit" /C:"codegen" "%TRANSCRIPT_FILE%" >"%DIAGNOSTIC_INDEX%"
set "INDEX_EXIT_CODE=%ERRORLEVEL%"
if %INDEX_EXIT_CODE% GEQ 2 (
    echo WARNING: diagnostic index generation failed with exit %INDEX_EXIT_CODE%.
)

del /Q "%TRANSCRIPT_TEMP%" >nul 2>nul
exit /b %OUTER_EXIT_CODE%

:worker
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem ============================================================================
rem Deblock4 Stage 1B.3 runtime capability guard validation.
rem
rem This runner is intentionally loud-failing. It:
rem   - runs the complete Stage 1B.2 regression batch;
rem   - builds and runs ReleaseSafe, ReleaseFast and Debug self-tests;
rem   - proves both G10 modules absent from release DLL and self-test artifacts;
rem   - proves both G10 modules present in the enabled Debug positive control;
rem   - exercises force-down absent, v2, v1 and invalid-input cases;
rem   - proves non-Debug option rejection;
rem   - inspects the standalone baseline-v1 detection object;
rem   - demonstrates the comptime named-model drift gate in a temporary copy;
rem   - audits the one-way first-class-to-scaffolding dependency rule.
rem
rem The source tree is never modified by the perturbation proof.
rem ============================================================================

set "STAGE=1B.3_v5"
set "PROJECT_DIR=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
set "VSDEVCMD=C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat"
set "STAGE_1B2_BATCH=build_1B2_v5_REDEVELOPED.bat"

set "ZIG_CACHE=.zig-cache"
set "ZIG_OUT=zig-out"
set "INSPECTION_DIR=zig-out\inspection_1B3"
set "DLL_FILE=zig-out\bin\Deblock4.dll"
set "SELFTEST_FILE=zig-out\bin\deblock4_selftest.exe"
set "DETECTION_OBJ=zig-out\detection-objects\cpu_capability_detection.obj"

set "FORCE_STRING=DEBLOCK4_FORCE_DOWN_DEBUG_MARKER_FD00D001"
set "FORCE_ENV=DEBLOCK4_FORCE_DOWN"
set "FORCE_EXPORT=deblock4_force_down_marker_FD00D001"
set "FORCE_CODE=FD00D001"
set "DIAG_STRING=DEBLOCK4_VERBOSE_DETECTION_MARKER_DD00D001"
set "DIAG_EXPORT=deblock4_verbose_detection_marker_DD00D001"
set "DIAG_CODE=DD00D001"
set "DETECTION_ROOT=deblock4_cpu_capability_detection_entry_C001"

set "PAT_EVEX=^[ ]*[0-9A-F][0-9A-F]*:[ ]*62[ ]"
set "PAT_VEX2=^[ ]*[0-9A-F][0-9A-F]*:[ ]*C4[ ]"
set "PAT_VEX3=^[ ]*[0-9A-F][0-9A-F]*:[ ]*C5[ ]"
set "PAT_XGETBV_INSN=^[ ]*[0-9A-F][0-9A-F]*:[ ]*0F 01 D0[ ]*xgetbv"
set "PAT_XGETBV_CALL=^[ ]*[0-9A-F][0-9A-F]*:.*call.*xgetbv"

set "OUTSIDE=aesdec aesdeclast aesenc aesenclast aesimc aeskeygenassist pclmulqdq sha1 sha256 rdrand rdseed adcx adox rdfsbase rdgsbase wrfsbase wrgsbase clflushopt clwb"
set "V3ONLY=andn bextr blsi blsmsk blsr tzcnt bzhi mulx pdep pext rorx sarx shlx shrx lzcnt movbe"
set "V2ONLY_A=addsubpd addsubps fisttp haddpd haddps hsubpd hsubps lddqu movddup movshdup movsldup monitor mwait"
set "V2ONLY_B=pabsb pabsw pabsd palignr phaddw phaddd phaddsw phsubw phsubd phsubsw pmaddubsw pmulhrsw pshufb psignb psignw psignd"
set "V2ONLY_C=blendpd blendps blendvpd blendvps dppd dpps extractps insertps movntdqa mpsadbw packusdw pblendvb pblendw pcmpeqq pextrb pextrd pextrq pinsrb pinsrd pinsrq pmaxsb pmaxsd pmaxuw pmaxud pminsb pminsd pminuw pminud pmovsxbd pmovsxbq pmovsxbw pmovsxdq pmovsxwd pmovsxwq pmovzxbd pmovzxbq pmovzxbw pmovzxdq pmovzxwd pmovzxwq pmuldq pmulld ptest roundpd roundps roundsd roundss phminposuw"
set "V2ONLY_D=crc32 pcmpestri pcmpestrm pcmpistri pcmpistrm pcmpgtq popcnt cmpxchg16b lahf sahf"
set "AVX512=kadd kand kandn kmov knot kor kortest kshift ktest kunpck kxnor kxor tile"

rem ============================================================================
rem Environment and the inherited Stage 1B.2 regression.
rem ============================================================================

set "MARKER=Change to project directory"
set "CMD=cd /d "!PROJECT_DIR!""
call :run

set "MARKER=Configure Visual Studio environment"
set "CMD=call "!VSDEVCMD!" -arch=amd64 -host_arch=amd64"
call :run

set "MARKER=Restore project directory after VsDevCmd"
set "CMD=cd /d "!PROJECT_DIR!""
call :run

set "MARKER=Confirm zig is available"
set "CMD=where zig"
call :run

set "MARKER=Confirm dumpbin is available"
set "CMD=where dumpbin"
call :run

set "MARKER=Confirm PowerShell is available"
set "CMD=where powershell"
call :run

set "MARKER=Show Zig version"
set "CMD=zig version"
call :run

set "MARKER=Verify Zig version is exactly 0.16.0"
set "CMD=zig version"
set "OUT=%TEMP%\deblock4_zig_version.txt"
call :capture_both
set "OBSERVED_ZIG_VERSION="
set /p "OBSERVED_ZIG_VERSION="<"!OUT!"
echo === Observed Zig version !OBSERVED_ZIG_VERSION!
if not "!OBSERVED_ZIG_VERSION!"=="0.16.0" (
    set "exit_code=1"
    goto :fail
)
del /q "!OUT!" >nul 2>nul

if not exist "!STAGE_1B2_BATCH!" (
    set "MARKER=Locate Stage 1B.2 regression batch"
    set "CMD=if exist "!STAGE_1B2_BATCH!""
    set "exit_code=1"
    goto :fail
)

set "MARKER=Run complete Stage 1B.2 regression batch"
set "CMD=call "!STAGE_1B2_BATCH!" ^< nul"
set "STAGE_1B2_LOG=%TEMP%\Deblock4_Stage_1B2_full_output.txt"
set "OUT=!STAGE_1B2_LOG!"
call :capture_both
call :find_absent "Stage 1B.2 emitted no FAIL banner" "!STAGE_1B2_LOG!" "STAGE 1B.2_v1 VALIDATION COMMAND SET FAIL"

rem Preserve the regenerated named-model captures before cleaning build output.
set "MODEL_TEMP=%TEMP%\Deblock4_1B3_models"
if exist "!MODEL_TEMP!" rmdir /s /q "!MODEL_TEMP!"
md "!MODEL_TEMP!"
if errorlevel 1 goto :fail
for %%F in (zig_builtin_x86_64_v1.txt zig_builtin_x86_64_v2.txt zig_builtin_x86_64_v3.txt) do (
    if not exist "zig-out\inspection\%%F" (
        set "MARKER=Preserve Stage 1B.2 named-model capture %%F"
        set "CMD=copy zig-out\inspection\%%F"
        set "exit_code=1"
        goto :fail
    )
    copy /y "zig-out\inspection\%%F" "!MODEL_TEMP!\%%F" >nul
    if errorlevel 1 goto :fail
)

call :remove_tree "!ZIG_CACHE!"
call :remove_tree "!ZIG_OUT!"
call :make_dir "!INSPECTION_DIR!"
copy /y "!MODEL_TEMP!\*.txt" "!INSPECTION_DIR!\" >nul
if errorlevel 1 goto :fail
copy /y "!STAGE_1B2_LOG!" "!INSPECTION_DIR!\stage_1B2_full_output.txt" >nul
if errorlevel 1 goto :fail
del /q "!STAGE_1B2_LOG!" >nul 2>nul
rmdir /s /q "!MODEL_TEMP!"

rem Re-run the inherited unit-test step with explicit verbose error context and
rem a full summary. Zig 0.16.0 marks a successful run step as a warning when the
rem test writes expected diagnostics to stderr; validate that exact profile.
for %%M in (Debug ReleaseSafe ReleaseFast) do (
    set "MARKER=Verify inherited unit tests mode %%M"
    set "CMD=zig build test -Doptimize=%%M --error-style verbose --summary all"
    set "OUT=!INSPECTION_DIR!\unit_tests_inherited_%%M.txt"
    call :run_test_command
)

rem ============================================================================
rem ReleaseSafe and ReleaseFast production builds.
rem ============================================================================

set "DEBLOCK4_FORCE_DOWN="
for %%M in (ReleaseSafe ReleaseFast) do (
    call :run_release_mode %%M
    if errorlevel 1 goto :fail
)

rem ============================================================================
rem Debug positive control and force-down behaviour matrix.
rem ============================================================================

set "DEBUG_DIR=!INSPECTION_DIR!\Debug_enabled"
call :make_dir "!DEBUG_DIR!"

set "MARKER=Build Debug artifacts with both G10 modules enabled"
set "CMD=zig build -Doptimize=Debug -Denable_force_down=true -Denable_verbose_detection=true --error-style verbose"
call :run

set "MARKER=Run Debug unit tests with both G10 modules enabled"
set "CMD=zig build test -Doptimize=Debug -Denable_force_down=true -Denable_verbose_detection=true --error-style verbose --summary all"
set "OUT=!DEBUG_DIR!\unit_tests.txt"
call :run_test_command

set "DEBLOCK4_FORCE_DOWN="
set "MARKER=Run Debug self-test with force-down input absent"
set "CMD="!SELFTEST_FILE!""
set "OUT=!DEBUG_DIR!\selftest_absent.txt"
call :capture_both
call :find_present "Debug absent self-test PASS" "!OUT!" "deblock4_selftest: PASS"
call :find_present "Debug absent verbose marker" "!OUT!" "!DIAG_STRING!"
call :find_absent "Debug absent force-down announcement" "!OUT!" "FORCE-DOWN ACTIVE"
call :find_present "Debug absent policy provenance" "!OUT!" "OS baseline assumed (Windows x64 process policy)"
call :find_present "Debug non-auto backend renders" "!OUT!" "selftest-nonauto backend=x86_64_v1_baseline"

set "DEBLOCK4_FORCE_DOWN=v2"
set "MARKER=Run Debug self-test forced down to v2"
set "CMD="!SELFTEST_FILE!""
set "OUT=!DEBUG_DIR!\selftest_v2.txt"
call :capture_both
call :find_present "Debug v2 self-test PASS" "!OUT!" "deblock4_selftest: PASS"
call :find_present "Debug v2 force-down announcement" "!OUT!" "FORCE-DOWN ACTIVE"
call :find_present "Debug v2 actual tier" "!OUT!" "actual=x86_64_v3_with_avx2"
call :find_present "Debug v2 effective tier" "!OUT!" "effective=x86_64_v2_with_sse41"
call :find_present "Debug v2 summary reason" "!OUT!" "reason=forced-down(x86_64_v2_with_sse41) actual=x86_64_v3_with_avx2"

set "DEBLOCK4_FORCE_DOWN=v1"
set "MARKER=Run Debug self-test forced down to v1"
set "CMD="!SELFTEST_FILE!""
set "OUT=!DEBUG_DIR!\selftest_v1.txt"
call :capture_both
call :find_present "Debug v1 self-test PASS" "!OUT!" "deblock4_selftest: PASS"
call :find_present "Debug v1 force-down announcement" "!OUT!" "FORCE-DOWN ACTIVE"
call :find_present "Debug v1 actual tier" "!OUT!" "actual=x86_64_v3_with_avx2"
call :find_present "Debug v1 effective tier" "!OUT!" "effective=x86_64_v1_baseline"
call :find_present "Debug v1 summary reason" "!OUT!" "reason=forced-down(x86_64_v1_baseline) actual=x86_64_v3_with_avx2"

set "DEBLOCK4_FORCE_DOWN=V2"
set "MARKER=Reject invalid Debug force-down value"
set "CMD="!SELFTEST_FILE!""
set "OUT=!DEBUG_DIR!\selftest_invalid.txt"
call :expect_fail_capture
call :find_present "Invalid value is loud" "!OUT!" "invalid DEBLOCK4_FORCE_DOWN value"
call :find_present "Invalid value carries marker" "!OUT!" "!FORCE_STRING!"
call :find_present "Invalid value returns pinned error" "!OUT!" "InvalidForceDownValue"
set "DEBLOCK4_FORCE_DOWN="

call :capture_artifacts "!DEBUG_DIR!"
call :assert_debug_present "!DEBUG_DIR!"

rem ============================================================================
rem Non-Debug build rejection for both debug-only options.
rem ============================================================================

for %%M in (ReleaseSafe ReleaseFast ReleaseSmall) do (
    set "MARKER=Reject force-down option in %%M"
    set "CMD=zig build -Doptimize=%%M -Denable_force_down=true"
    set "OUT=!INSPECTION_DIR!\reject_force_down_%%M.txt"
    call :expect_fail_capture
    call :find_present "Force-down rejection names Debug requirement" "!OUT!" "require -Doptimize=Debug"

    set "MARKER=Reject verbose-detection option in %%M"
    set "CMD=zig build -Doptimize=%%M -Denable_verbose_detection=true"
    set "OUT=!INSPECTION_DIR!\reject_verbose_%%M.txt"
    call :expect_fail_capture
    call :find_present "Verbose rejection names Debug requirement" "!OUT!" "require -Doptimize=Debug"
)

rem ============================================================================
rem Standalone baseline-v1 detection object and guarded XGETBV proof.
rem ============================================================================

set "MARKER=Build standalone baseline-v1 detection object"
set "CMD=zig build detection-object -Doptimize=ReleaseFast"
call :run

if not exist "!DETECTION_OBJ!" (
    set "MARKER=Locate standalone detection object"
    set "CMD=if exist "!DETECTION_OBJ!""
    set "exit_code=1"
    goto :fail
)

set "DETECTION_SYMBOLS=!INSPECTION_DIR!\cpu_capability_detection_symbols.txt"
set "DETECTION_DISASM=!INSPECTION_DIR!\cpu_capability_detection_disasm.txt"

set "MARKER=Capture detection object symbols"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!DETECTION_OBJ!""
set "OUT=!DETECTION_SYMBOLS!"
call :capture
call :find_present "Detection object semantic root is present" "!DETECTION_SYMBOLS!" "!DETECTION_ROOT!"

set "MARKER=Capture detection object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!DETECTION_OBJ!""
set "OUT=!DETECTION_DISASM!"
call :capture
call :find_present "Detection disassembly contains CPUID" "!DETECTION_DISASM!" "cpuid"
call :count_regex_exact "Detection disassembly has one XGETBV instruction" "!DETECTION_DISASM!" PAT_XGETBV_INSN 1
call :count_regex_exact "Detection disassembly has one XGETBV call site" "!DETECTION_DISASM!" PAT_XGETBV_CALL 1
call :deny_regex "Detection object has no EVEX encoding" "!DETECTION_DISASM!" PAT_EVEX
call :deny_regex "Detection object has no VEX C4 encoding" "!DETECTION_DISASM!" PAT_VEX2
call :deny_regex "Detection object has no VEX C5 encoding" "!DETECTION_DISASM!" PAT_VEX3
call :deny_list "detection object" "!DETECTION_DISASM!" "!OUTSIDE!"
call :deny_list "detection object" "!DETECTION_DISASM!" "!V2ONLY_A!"
call :deny_list "detection object" "!DETECTION_DISASM!" "!V2ONLY_B!"
call :deny_list "detection object" "!DETECTION_DISASM!" "!V2ONLY_C!"
call :deny_list "detection object" "!DETECTION_DISASM!" "!V2ONLY_D!"
call :deny_list "detection object" "!DETECTION_DISASM!" "!V3ONLY!"
call :deny_list "detection object" "!DETECTION_DISASM!" "!AVX512!"

call :find_present "Source contains OSXSAVE guard" "src\cpu_capability_detection.zig" "if (isPresent(features.osxsave))"
call :find_present "Source executes XGETBV only inside detector" "src\cpu_capability_detection.zig" "xcr0_raw = xgetbv(0);"

rem ============================================================================
rem Comptime drift gate demonstration in a disposable temporary tree.
rem ============================================================================

call :run_membership_perturbation
if errorlevel 1 goto :fail

rem ============================================================================
rem One-way dependency audit and final checks.
rem ============================================================================

call :audit_first_class_dependencies
if errorlevel 1 goto :fail

set "MARKER=Check for whitespace errors"
set "CMD=git diff --check"
call :run

set "MARKER=Show final git working tree status"
set "CMD=git status --short"
call :run

set "MARKER=Write manual disassembly review notice"
set "CMD=echo Automated deny lists are conservative and manual review remains required."
echo Automated deny lists are conservative and manual review remains required.> "!INSPECTION_DIR!\manual_disassembly_review_required.txt"
echo Review the detection object and Debug and release artifact disassemblies.>> "!INSPECTION_DIR!\manual_disassembly_review_required.txt"
echo Any instruction outside the declared level is a Stage 1B.3 failure.>> "!INSPECTION_DIR!\manual_disassembly_review_required.txt"

echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET COMPLETED
echo W3C REVIEW OF THE ACTUAL OUTPUT IS REQUIRED BEFORE STAGE PASS
echo Evidence retained under !INSPECTION_DIR!
echo ================================================================================
echo.
exit /b 0

rem ============================================================================
rem Release mode body.
rem ============================================================================

:run_release_mode
set "MODE=%~1"
echo.
echo ----------------------------------------------------------------
echo Starting %STAGE% release mode !MODE!

set "MODE_DIR=!INSPECTION_DIR!\!MODE!"
call :make_dir "!MODE_DIR!"
if errorlevel 1 exit /b 1

set "MARKER=Build mode !MODE! with debug options off"
set "CMD=zig build -Doptimize=!MODE! -Denable_force_down=false -Denable_verbose_detection=false --error-style verbose"
call :run
if errorlevel 1 exit /b 1

set "MARKER=Run unit tests mode !MODE!"
set "CMD=zig build test -Doptimize=!MODE! -Denable_force_down=false -Denable_verbose_detection=false --error-style verbose --summary all"
set "OUT=!MODE_DIR!\unit_tests.txt"
call :run_test_command
if errorlevel 1 exit /b 1

set "DEBLOCK4_FORCE_DOWN=v1"
set "MARKER=Run self-test mode !MODE! with force-down environment set"
set "CMD="!SELFTEST_FILE!""
set "OUT=!MODE_DIR!\selftest.txt"
call :capture_both
if errorlevel 1 exit /b 1
set "DEBLOCK4_FORCE_DOWN="

call :find_present "!MODE! self-test PASS" "!OUT!" "deblock4_selftest: PASS"
if errorlevel 1 exit /b 1
call :find_present "!MODE! actual and effective v3" "!OUT!" "actual=x86_64_v3 effective=x86_64_v3"
if errorlevel 1 exit /b 1
call :find_present "!MODE! production summary tier" "!OUT!" "tier=x86_64_v3_with_avx2"
if errorlevel 1 exit /b 1
call :find_absent "!MODE! ignores force-down environment" "!OUT!" "FORCE-DOWN ACTIVE"
if errorlevel 1 exit /b 1

call :capture_artifacts "!MODE_DIR!"
if errorlevel 1 exit /b 1
call :assert_release_absent "!MODE_DIR!"
if errorlevel 1 exit /b 1

echo Finished %STAGE% release mode !MODE! PASS
echo ----------------------------------------------------------------
exit /b 0

rem ============================================================================
rem Artifact capture and G10 gates.
rem ============================================================================

:capture_artifacts
set "CAPTURE_DIR=%~1"
if not exist "!DLL_FILE!" exit /b 1
if not exist "!SELFTEST_FILE!" exit /b 1

copy /y "!DLL_FILE!" "!CAPTURE_DIR!\Deblock4.dll" >nul
if errorlevel 1 exit /b 1
copy /y "!SELFTEST_FILE!" "!CAPTURE_DIR!\deblock4_selftest.exe" >nul
if errorlevel 1 exit /b 1

set "MARKER=Capture DLL exports for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /EXPORTS "!DLL_FILE!""
set "OUT=!CAPTURE_DIR!\Deblock4_exports.txt"
call :capture
if errorlevel 1 exit /b 1

set "MARKER=Capture self-test exports for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /EXPORTS "!SELFTEST_FILE!""
set "OUT=!CAPTURE_DIR!\deblock4_selftest_exports.txt"
call :capture
if errorlevel 1 exit /b 1

set "MARKER=Capture DLL disassembly for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!DLL_FILE!""
set "OUT=!CAPTURE_DIR!\Deblock4_disasm.txt"
call :capture
if errorlevel 1 exit /b 1

set "MARKER=Capture self-test disassembly for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!SELFTEST_FILE!""
set "OUT=!CAPTURE_DIR!\deblock4_selftest_disasm.txt"
call :capture
if errorlevel 1 exit /b 1
exit /b 0

:assert_release_absent
set "CHECK_DIR=%~1"
for %%B in (Deblock4.dll deblock4_selftest.exe) do (
    call :find_absent "Release raw binary has no force-down marker" "!CHECK_DIR!\%%B" "!FORCE_STRING!"
    if errorlevel 1 exit /b 1
    call :find_absent "Release raw binary has no force-down env name" "!CHECK_DIR!\%%B" "!FORCE_ENV!"
    if errorlevel 1 exit /b 1
    call :find_absent "Release raw binary has no verbose marker" "!CHECK_DIR!\%%B" "!DIAG_STRING!"
    if errorlevel 1 exit /b 1
)
for %%F in (Deblock4_exports.txt deblock4_selftest_exports.txt) do (
    call :find_absent "Release exports have no force-down symbol" "!CHECK_DIR!\%%F" "!FORCE_EXPORT!"
    if errorlevel 1 exit /b 1
    call :find_absent "Release exports have no verbose symbol" "!CHECK_DIR!\%%F" "!DIAG_EXPORT!"
    if errorlevel 1 exit /b 1
)
for %%F in (Deblock4_disasm.txt deblock4_selftest_disasm.txt) do (
    call :find_absent "Release disassembly has no force-down code marker" "!CHECK_DIR!\%%F" "!FORCE_CODE!"
    if errorlevel 1 exit /b 1
    call :find_absent "Release disassembly has no verbose code marker" "!CHECK_DIR!\%%F" "!DIAG_CODE!"
    if errorlevel 1 exit /b 1
)
echo Release three-surface G10 absence gates PASS for !CHECK_DIR!
exit /b 0

:assert_debug_present
set "CHECK_DIR=%~1"
for %%B in (Deblock4.dll deblock4_selftest.exe) do (
    call :find_present "Debug raw binary has force-down marker" "!CHECK_DIR!\%%B" "!FORCE_STRING!"
    if errorlevel 1 exit /b 1
    call :find_present "Debug raw binary has force-down env name" "!CHECK_DIR!\%%B" "!FORCE_ENV!"
    if errorlevel 1 exit /b 1
    call :find_present "Debug raw binary has verbose marker" "!CHECK_DIR!\%%B" "!DIAG_STRING!"
    if errorlevel 1 exit /b 1
)
call :find_present "Debug DLL exports have force-down symbol" "!CHECK_DIR!\Deblock4_exports.txt" "!FORCE_EXPORT!"
if errorlevel 1 exit /b 1
call :find_present "Debug DLL exports have verbose symbol" "!CHECK_DIR!\Deblock4_exports.txt" "!DIAG_EXPORT!"
if errorlevel 1 exit /b 1
for %%F in (Deblock4_disasm.txt deblock4_selftest_disasm.txt) do (
    call :find_present "Debug disassembly has force-down code marker" "!CHECK_DIR!\%%F" "!FORCE_CODE!"
    if errorlevel 1 exit /b 1
    call :find_present "Debug disassembly has verbose code marker" "!CHECK_DIR!\%%F" "!DIAG_CODE!"
    if errorlevel 1 exit /b 1
)
echo Debug three-surface G10 positive controls PASS
exit /b 0

rem ============================================================================
rem Comptime drift-gate perturbation in a temporary copy.
rem ============================================================================

:run_membership_perturbation
set "PERTURB_DIR=%TEMP%\Deblock4_1B3_membership_perturb"
if exist "!PERTURB_DIR!" rmdir /s /q "!PERTURB_DIR!"

set "MARKER=Copy project to temporary membership-perturbation tree"
set "CMD=robocopy "!PROJECT_DIR!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP"
echo.
echo === !MARKER!
echo !CMD!
robocopy "!PROJECT_DIR!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP
set "copy_code=!ERRORLEVEL!"
if !copy_code! GTR 7 (
    set "exit_code=!copy_code!"
    goto :fail
)

set "PERTURB_FILE=!PERTURB_DIR!\src\cpu_capability_detection.zig"
set "MARKER=Remove BMI2 from the expected v3 capture in the temporary tree"
set "CMD=powershell temporary named-model perturbation"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$p='!PERTURB_FILE!'; $s=[IO.File]::ReadAllText($p); $old='.allow_light_256_bit, .avx, .avx2, .bmi, .bmi2,'; $new='.allow_light_256_bit, .avx, .avx2, .bmi,'; if(-not $s.Contains($old)){exit 2}; [IO.File]::WriteAllText($p,$s.Replace($old,$new),[Text.Encoding]::ASCII)"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "MARKER=Demonstrate named-model drift compile failure"
set "CMD=zig build detection-object -Doptimize=ReleaseFast"
set "OUT=!INSPECTION_DIR!\named_model_perturbation_expected_failure.txt"
pushd "!PERTURB_DIR!"
!CMD! > "!PROJECT_DIR!\!OUT!" 2>&1
set "perturb_code=!ERRORLEVEL!"
popd
if "!perturb_code!"=="0" (
    set "exit_code=1"
    goto :fail
)

call :find_present "Perturbation names capture drift" "!OUT!" "Zig 0.16 named-model capture drift"
if errorlevel 1 exit /b 1
call :find_present "Perturbation names BMI2" "!OUT!" "bmi2"
if errorlevel 1 exit /b 1

rmdir /s /q "!PERTURB_DIR!"
if exist "!PERTURB_DIR!" exit /b 1
echo Comptime named-model drift gate demonstration PASS
exit /b 0

rem ============================================================================
rem First-class dependency audit.
rem ============================================================================

:audit_first_class_dependencies
set "FIRST_CLASS=src\deblock4_config.zig src\print_helper_functions.zig src\cpu_capability_detection.zig src\print_diag_helper_functions.zig src\force_down_debug.zig src\deblock4_selftest.zig"
for %%F in (!FIRST_CLASS!) do (
    for %%T in (backend_probe backend_retention_anchor dll_probe smoke build_1B) do (
        findstr /I /C:"%%T" "%%F" >nul <nul
        if "!ERRORLEVEL!"=="0" (
            echo Forbidden scaffolding identifier %%T found in %%F
            set "MARKER=One-way first-class dependency audit"
            set "CMD=forbid %%T in %%F"
            set "exit_code=1"
            goto :fail
        )
    )
    findstr /I /R /C:"1B[0-9]" "%%F" >nul <nul
    if "!ERRORLEVEL!"=="0" (
        echo Stage-numbered identifier found in first-class file %%F
        set "MARKER=One-way first-class dependency audit"
        set "CMD=forbid stage-numbered identifier in %%F"
        set "exit_code=1"
        goto :fail
    )
)
echo One-way first-class dependency audit PASS
exit /b 0

rem ============================================================================
rem Generic command and scanning routines.
rem ============================================================================

:run
echo.
echo === !MARKER!
echo !CMD!
!CMD!
set "exit_code=!ERRORLEVEL!"
echo === Exit code !exit_code!
if not "!exit_code!"=="0" goto :fail
exit /b 0

:capture
echo.
echo === !MARKER!
echo !CMD!
!CMD! > "!OUT!" 2>&1
set "exit_code=!ERRORLEVEL!"
echo === Exit code !exit_code!
if not "!exit_code!"=="0" goto :fail
exit /b 0

:capture_both
echo.
echo === !MARKER!
echo !CMD!
!CMD! > "!OUT!" 2>&1
set "exit_code=!ERRORLEVEL!"
type "!OUT!"
echo === Exit code !exit_code!
if not "!exit_code!"=="0" goto :fail
exit /b 0

:expect_fail_capture
echo.
echo === !MARKER!
echo !CMD!
!CMD! > "!OUT!" 2>&1
set "observed_code=!ERRORLEVEL!"
type "!OUT!"
if "!observed_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
set "exit_code=0"
echo !MARKER! PASS observed exit !observed_code!
exit /b 0

:run_test_command
set "TEST_MARKER=!MARKER!"
set "TEST_OUT=!OUT!"
call :capture_both
call :find_present "!TEST_MARKER! emitted a build summary" "!TEST_OUT!" "Build Summary:"
call :find_present "!TEST_MARKER! reports all build steps succeeded" "!TEST_OUT!" "steps succeeded"
call :find_present "!TEST_MARKER! reports all tests passed" "!TEST_OUT!" "tests passed"
call :find_present "!TEST_MARKER! reports test success" "!TEST_OUT!" "test success"
call :count_literal_exact "!TEST_MARKER! has one Zig stderr-warning step" "!TEST_OUT!" "run test w" 1
call :count_literal_exact "!TEST_MARKER! has one Zig command-context line" "!TEST_OUT!" "failed command:" 1
call :find_present "!TEST_MARKER! command context is the test protocol" "!TEST_OUT!" "--listen=-"
call :find_present "!TEST_MARKER! warning is paired with expected diagnostic output" "!TEST_OUT!" "dll-probe backend=auto tier="
call :find_absent "!TEST_MARKER! emitted no transitive failure marker" "!TEST_OUT!" "transitive failure"
call :find_absent "!TEST_MARKER! emitted no failed-tests marker" "!TEST_OUT!" "tests failed"
call :find_absent "!TEST_MARKER! emitted no logged-errors marker" "!TEST_OUT!" "errors were logged"
call :find_absent "!TEST_MARKER! emitted no timeout marker" "!TEST_OUT!" "timed out"
call :find_absent "!TEST_MARKER! emitted no leak marker" "!TEST_OUT!" "leaked memory"
call :find_absent "!TEST_MARKER! emitted no error diagnostic" "!TEST_OUT!" "error:"
call :find_absent "!TEST_MARKER! emitted no panic diagnostic" "!TEST_OUT!" "panic:"
call :find_absent "!TEST_MARKER! emitted no LLVM diagnostic" "!TEST_OUT!" "LLVM"
call :find_absent "!TEST_MARKER! emitted no internal-compiler-error diagnostic" "!TEST_OUT!" "internal compiler error"
call :find_absent "!TEST_MARKER! emitted no emission failure" "!TEST_OUT!" "unable to emit"
call :find_absent "!TEST_MARKER! emitted no codegen diagnostic" "!TEST_OUT!" "codegen"
echo !TEST_MARKER! PASS exit 0, all tests passed, and expected stderr warning classified
exit /b 0

:find_exact_line
set "MARKER=%~1"
set "CMD=find exact line in %~2"
if not exist "%~2" (
    set "MARKER=%~1"
    set "CMD=locate %~2"
    set "exit_code=1"
    goto :fail
)
echo === %~1
findstr /X /C:"%~3" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:find_present
set "MARKER=%~1"
set "CMD=find required text in %~2"
if not exist "%~2" (
    set "MARKER=%~1"
    set "CMD=locate %~2"
    set "exit_code=1"
    goto :fail
)
echo === %~1
findstr /I /C:"%~3" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:find_absent
set "MARKER=%~1"
set "CMD=verify forbidden text absent from %~2"
if not exist "%~2" (
    set "MARKER=%~1"
    set "CMD=locate %~2"
    set "exit_code=1"
    goto :fail
)
echo === %~1
findstr /I /C:"%~3" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:deny_regex
set "MARKER=%~1"
set "CMD=deny regex in %~2"
set "scan_pattern=!%~3!"
findstr /I /R /C:"!scan_pattern!" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    echo === %~1
    findstr /I /R /C:"!scan_pattern!" "%~2" <nul
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:deny_list
set "MARKER=Verify %~1 instruction level"
set "CMD=deny mnemonic list in %~2"
for %%I in (%~3) do (
    findstr /I /C:"%%I" "%~2" >nul <nul
    if "!ERRORLEVEL!"=="0" (
        echo === Verify %~1 has no %%I instruction
        findstr /I /C:"%%I" "%~2" <nul
        set "exit_code=1"
        goto :fail
    )
)
set "exit_code=0"
exit /b 0

:count_literal_exact
set "COUNT_FILE=%TEMP%\deblock4_1b3_literal_count.txt"
findstr /I /C:"%~3" "%~2" > "!COUNT_FILE!" <nul
set "scan_code=!ERRORLEVEL!"
if not "!scan_code!"=="0" (
    set "MARKER=%~1"
    set "CMD=findstr literal count in %~2"
    set "exit_code=1"
    goto :fail
)
set /a observed_count=0
for /f "usebackq delims=" %%L in ("!COUNT_FILE!") do set /a observed_count+=1
del /q "!COUNT_FILE!" >nul 2>nul
echo === %~1 observed !observed_count! expected %~4
if not "!observed_count!"=="%~4" (
    set "MARKER=%~1"
    set "CMD=count literal in %~2"
    set "exit_code=1"
    goto :fail
)
set "exit_code=0"
exit /b 0

:count_regex_exact
set "scan_pattern=!%~3!"
set "COUNT_FILE=%TEMP%\deblock4_1b3_count.txt"
findstr /I /R /C:"!scan_pattern!" "%~2" > "!COUNT_FILE!" <nul
set "scan_code=!ERRORLEVEL!"
if not "!scan_code!"=="0" (
    set "MARKER=%~1"
    set "CMD=findstr count in %~2"
    set "exit_code=1"
    goto :fail
)
set /a observed_count=0
for /f "usebackq delims=" %%L in ("!COUNT_FILE!") do set /a observed_count+=1
del /q "!COUNT_FILE!" >nul 2>nul
echo === %~1 observed !observed_count! expected %~4
if not "!observed_count!"=="%~4" (
    set "MARKER=%~1"
    set "CMD=count regex in %~2"
    set "exit_code=1"
    goto :fail
)
set "exit_code=0"
exit /b 0

:remove_tree
if "%~1"=="" exit /b 0
if not exist "%~1" exit /b 0
set "MARKER=Remove build output %~1"
set "CMD=rmdir /s /q "%~1" with bounded retry"
set /a remove_attempt=0

:remove_tree_retry
set /a remove_attempt+=1
echo.
echo === !MARKER! attempt !remove_attempt! of 5
rmdir /s /q "%~1"
set "exit_code=!ERRORLEVEL!"
if not exist "%~1" (
    set "exit_code=0"
    exit /b 0
)
if !remove_attempt! LSS 5 (
    ping 127.0.0.1 -n 2 >nul 2>nul
    goto :remove_tree_retry
)
echo === Cleanup failed after !remove_attempt! attempts; remaining entries follow
dir /a /s "%~1"
echo === Relevant processes at cleanup failure
tasklist /NH 2>nul | findstr /I /C:"zig.exe" /C:"test.exe"
set "exit_code=1"
goto :fail

:make_dir
if "%~1"=="" exit /b 0
if exist "%~1" exit /b 0
md "%~1"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:fail
echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET FAIL
echo Failed step !MARKER!
echo CMD !CMD!
echo Exit code !exit_code!
echo ================================================================================
echo.
if "!exit_code!"=="" set "exit_code=1"
if "!exit_code!"=="0" set "exit_code=1"
exit !exit_code!
