@echo off
@if /I "%~1"=="--worker" goto :worker
@setlocal ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

rem Run the validation body in a dedicated child cmd.exe. The parent retains
rem one complete combined-stream transcript and returns the worker exit code.
set "TRANSCRIPT_TEMP=%TEMP%\Deblock4_build_1C_v1_%RANDOM%_%RANDOM%_full_output.log"
"%ComSpec%" /D /V:OFF /C call "%~f0" --worker >"%TRANSCRIPT_TEMP%" 2>&1
set "OUTER_EXIT_CODE=%ERRORLEVEL%"

set "TRANSCRIPT_DIR=%~dp0zig-out\inspection_1C"
if not exist "%TRANSCRIPT_DIR%" md "%TRANSCRIPT_DIR%" >nul 2>nul
set "TRANSCRIPT_FILE=%TRANSCRIPT_DIR%\build_1C_v1_full_output.log"
copy /Y "%TRANSCRIPT_TEMP%" "%TRANSCRIPT_FILE%" >nul
>>"%TRANSCRIPT_FILE%" echo.
>>"%TRANSCRIPT_FILE%" echo OUTER_BATCH_EXIT_CODE=%OUTER_EXIT_CODE%

type "%TRANSCRIPT_FILE%"

set "DIAGNOSTIC_INDEX=%TRANSCRIPT_DIR%\build_1C_v1_diagnostic_index.txt"
findstr /N /I /C:"LLVM" /C:"error:" /C:"panic:" /C:"failed command:" /C:"internal compiler error" /C:"unable to emit" /C:"codegen" "%TRANSCRIPT_FILE%" >"%DIAGNOSTIC_INDEX%"
set "INDEX_EXIT_CODE=%ERRORLEVEL%"
if %INDEX_EXIT_CODE% GEQ 2 echo WARNING: diagnostic index generation failed with exit %INDEX_EXIT_CODE%.

del /Q "%TRANSCRIPT_TEMP%" >nul 2>nul
exit /b %OUTER_EXIT_CODE%

:worker
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem ============================================================================
rem Deblock4 Stage 1C complete proof matrix.
rem
rem Implements scope v1.5 section 11: B1-B2, G1-G2, E1-E6, V1, S1-S3,
rem N1, plus the retained Stage 1B.3 detection-object drift proof.
rem Exit-code gating is primary. Zig's known --listen "failed command:" context
rem may appear when a passing test writes expected stderr; it is indexed but is
rem not itself a failure signal.
rem ============================================================================

set "STAGE=1C_v1"
set "DEBLOCK4_PROJECT_PREFIX=%~dp0"
set "DEBLOCK4_PROJECT_ROOT=%~dp0."
set "VSDEVCMD=C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat"

set "FORCE_STRING=DEBLOCK4_FORCE_DOWN_DEBUG_MARKER_FD00D001"
set "FORCE_ENV=DEBLOCK4_FORCE_DOWN"
set "FORCE_EXPORT=deblock4_force_down_marker_FD00D001"
set "FORCE_CODE=FD00D001"
set "DIAG_STRING=DEBLOCK4_VERBOSE_DETECTION_MARKER_DD00D001"
set "DIAG_EXPORT=deblock4_verbose_detection_marker_DD00D001"
set "DIAG_CODE=DD00D001"
set "TRACE_STRING=DEBLOCK4_LIFECYCLE_TRACE_DEBUG_MARKER_1C71FE01"
set "TRACE_EXPORT=deblock4_lifecycle_trace_marker_1C71FE01"
set "TRACE_CODE=1C71FE01"
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

cd /d "%DEBLOCK4_PROJECT_ROOT%" || exit /b 1

if not exist "%VSDEVCMD%" (
    echo ERROR: VsDevCmd.bat not found: %VSDEVCMD%
    exit /b 1
)
set "MARKER=Configure Visual Studio environment"
set "CMD=call "!VSDEVCMD!" -arch=amd64 -host_arch=amd64"
call :run

set "MARKER=Restore project directory after VsDevCmd"
set "CMD=cd /d "!DEBLOCK4_PROJECT_ROOT!""
call :run

rem Define all runner-owned filesystem state only after VsDevCmd returns. The
rem DEBLOCK4_ prefix prevents collisions with Visual Studio environment names.
set "DEBLOCK4_INSPECTION_DIR=zig-out\inspection_1C"
set "DEBLOCK4_BUILD_ROOT=zig-out\stage_1c"
set "DEBLOCK4_CACHE_ROOT=.zig-cache\stage_1c"
set "DEBLOCK4_CLASSIC_SCRIPT=!DEBLOCK4_PROJECT_PREFIX!tests\stage_1c_classic_passthrough.vpy"
set "DEBLOCK4_FILTER_SCRIPT=!DEBLOCK4_PROJECT_PREFIX!tests\stage_1c_deblock4_passthrough.vpy"

echo === Runner paths after VsDevCmd
echo project_root=!DEBLOCK4_PROJECT_ROOT!
echo cache_root=!DEBLOCK4_CACHE_ROOT!
echo build_root=!DEBLOCK4_BUILD_ROOT!
echo inspection_dir=!DEBLOCK4_INSPECTION_DIR!

where zig >nul 2>nul || (echo ERROR: zig.exe not found & exit /b 1)
where dumpbin >nul 2>nul || (echo ERROR: dumpbin.exe not found & exit /b 1)
where powershell >nul 2>nul || (echo ERROR: powershell.exe not found & exit /b 1)
if not exist "tools\run_vs.cmd" (echo ERROR: tools\run_vs.cmd missing & exit /b 1)
if not exist "%DEBLOCK4_CLASSIC_SCRIPT%" (echo ERROR: Classic .vpy missing & exit /b 1)
if not exist "%DEBLOCK4_FILTER_SCRIPT%" (echo ERROR: Deblock4 .vpy missing & exit /b 1)
if not exist "tools\audit_stage_1c_s1_structure.ps1" (echo ERROR: S1 audit script missing & exit /b 1)
if not exist "tools\audit_stage_1c_g10_imports.ps1" (echo ERROR: G10 audit script missing & exit /b 1)
if not exist "tools\audit_stage_1c_s2_sweep.ps1" (echo ERROR: S2 audit script missing & exit /b 1)
if not exist "tools\audit_stage_1c_s3_eol.ps1" (echo ERROR: S3 audit script missing & exit /b 1)

for /f "usebackq delims=" %%V in (`zig version`) do set "OBSERVED_ZIG_VERSION=%%V"
echo === Observed Zig version !OBSERVED_ZIG_VERSION!
if /I not "!OBSERVED_ZIG_VERSION!"=="0.16.0" (
    echo ERROR: Stage 1C requires Zig 0.16.0.
    exit /b 1
)

echo === Prepare Stage 1C proof directories
call :remove_tree "!DEBLOCK4_CACHE_ROOT!"
if errorlevel 1 goto :fail
call :remove_tree "!DEBLOCK4_BUILD_ROOT!"
if errorlevel 1 goto :fail
call :remove_tree "!DEBLOCK4_INSPECTION_DIR!"
if errorlevel 1 goto :fail
call :make_dir "!DEBLOCK4_INSPECTION_DIR!"
if errorlevel 1 goto :fail
echo === Stage 1C proof directories ready

rem Extract the single-homed identity without introducing a second literal.
for /f "usebackq delims=" %%V in (`powershell -NoProfile -Command "$s=[IO.File]::ReadAllText('src/deblock4_version.zig'); if($s -notmatch 'semantic_version\s*=\s*\x22([^\x22]+)\x22'){exit 2}; $Matches[1]"`) do set "SEMANTIC_VERSION=%%V"
if errorlevel 1 exit /b 1
for /f "usebackq delims=" %%V in (`powershell -NoProfile -Command "$s=[IO.File]::ReadAllText('src/deblock4_version.zig'); if($s -notmatch 'stage_marker\s*=\s*\x22([^\x22]+)\x22'){exit 2}; $Matches[1]"`) do set "STAGE_MARKER=%%V"
if errorlevel 1 exit /b 1
set "IDENTITY_STRING=!SEMANTIC_VERSION!+!STAGE_MARKER!"
set "DEBLOCK4_EXPECTED_VERSION=!IDENTITY_STRING!"
echo === Single-homed identity !IDENTITY_STRING!

rem ============================================================================
rem Static source, sweep, EOL and version gates.
rem ============================================================================

call :audit_source_structure
if errorlevel 1 goto :fail
call :audit_sweep
if errorlevel 1 goto :fail
call :audit_eol
if errorlevel 1 goto :fail
call :audit_version_sources
if errorlevel 1 goto :fail

set "MARKER=Initial CRLF-aware whitespace check"
set "CMD=git -c core.whitespace=cr-at-eol diff --check"
call :run

rem ============================================================================
rem ReleaseSafe and ReleaseFast complete builds/tests/e2e and G10 absence.
rem ============================================================================

call :run_release_mode ReleaseSafe
if errorlevel 1 goto :fail
call :run_release_mode ReleaseFast
if errorlevel 1 goto :fail

rem ============================================================================
rem Debug build with all three G10 seams explicitly enabled.
rem ============================================================================

set "MODE=Debug"
set "MODE_DIR=!DEBLOCK4_INSPECTION_DIR!\Debug"
set "MODE_PREFIX=!DEBLOCK4_BUILD_ROOT!\Debug"
set "MODE_CACHE=!DEBLOCK4_CACHE_ROOT!\Debug"
call :make_dir "!MODE_DIR!"
if errorlevel 1 goto :fail

set "MARKER=Build Debug with all G10 seams enabled"
set "CMD=zig build --prefix "!MODE_PREFIX!" --cache-dir "!MODE_CACHE!" -Doptimize=Debug -Denable_force_down=true -Denable_verbose_detection=true -Denable_trace_lifecycle=true --error-style verbose"
call :run

set "MARKER=Run complete Debug unit-test suite"
set "CMD=zig build test --prefix "!MODE_PREFIX!" --cache-dir "!MODE_CACHE!" -Doptimize=Debug -Denable_force_down=true -Denable_verbose_detection=true -Denable_trace_lifecycle=true --error-style verbose --summary all"
set "OUT=!MODE_DIR!\unit_tests.txt"
call :run_test_command

set "DLL_FILE=!MODE_PREFIX!\bin\Deblock4.dll"
set "SELFTEST_FILE=!MODE_PREFIX!\bin\deblock4_selftest.exe"
if not exist "!DLL_FILE!" (set "MARKER=Locate Debug DLL" & set "CMD=if exist DLL" & set "exit_code=1" & goto :fail)
if not exist "!SELFTEST_FILE!" (set "MARKER=Locate Debug selftest" & set "CMD=if exist selftest" & set "exit_code=1" & goto :fail)

set "DEBLOCK4_FORCE_DOWN="
set "MARKER=Run Debug selftest with all G10 seams"
set "CMD="!SELFTEST_FILE!""
set "OUT=!MODE_DIR!\selftest.txt"
call :capture_both
call :find_present "Debug selftest version banner" "!OUT!" "deblock4_selftest: version=!IDENTITY_STRING!"
call :find_present "Debug selftest PASS" "!OUT!" "deblock4_selftest: PASS"
call :find_present "Debug selftest Stage 1C section" "!OUT!" "stage_1c=PASS"
call :find_present "Debug selftest lifecycle marker" "!OUT!" "!TRACE_STRING!"

call :capture_artifacts "!MODE_DIR!" "!DLL_FILE!" "!SELFTEST_FILE!"
if errorlevel 1 goto :fail
call :assert_debug_present "!MODE_DIR!"
if errorlevel 1 goto :fail
call :assert_export_table "!MODE_DIR!"
if errorlevel 1 goto :fail

rem E1/E2/E4/E5 Debug normal cases.
set "DEBLOCK4_FORCE_DOWN="
call :run_debug_normal_e2e
if errorlevel 1 goto :fail

rem E3 Debug force-down: v1 and v2, plus invalid input.
set "DEBLOCK4_FORCE_DOWN=v1"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_auto x86_64_v1_baseline STAGE_1C_CLASSIC_PASS "!MODE_DIR!\classic_force_v1.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_auto x86_64_v1_baseline STAGE_1C_DEBLOCK4_PASS "!MODE_DIR!\deblock4_force_v1.txt"
set "DEBLOCK4_FORCE_DOWN=v2"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_auto x86_64_v2_with_sse41 STAGE_1C_CLASSIC_PASS "!MODE_DIR!\classic_force_v2.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_auto x86_64_v2_with_sse41 STAGE_1C_DEBLOCK4_PASS "!MODE_DIR!\deblock4_force_v2.txt"
set "DEBLOCK4_FORCE_DOWN=V2"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" error_invalid_force_down x86_64_v3_with_avx2 STAGE_1C_EXPECTED_ERROR_PASS "!MODE_DIR!\classic_force_invalid.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" error_invalid_force_down x86_64_v3_with_avx2 STAGE_1C_EXPECTED_ERROR_PASS "!MODE_DIR!\deblock4_force_invalid.txt"

rem E4 above-effective refusal is made observable by the valid force-down seam.
set "DEBLOCK4_FORCE_DOWN=v1"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" error_above_effective x86_64_v1_baseline STAGE_1C_EXPECTED_ERROR_PASS "!MODE_DIR!\classic_above_effective.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" error_above_effective x86_64_v1_baseline STAGE_1C_EXPECTED_ERROR_PASS "!MODE_DIR!\deblock4_above_effective.txt"
set "DEBLOCK4_FORCE_DOWN="

rem E6 lifecycle proof and S1 runtime proof from one captured run per filter.
call :assert_lifecycle_trace "!MODE_DIR!\classic_valid_auto.txt" Classic
if errorlevel 1 goto :fail
call :assert_lifecycle_trace "!MODE_DIR!\deblock4_valid_auto.txt" Deblock4
if errorlevel 1 goto :fail

rem ============================================================================
rem S1 stable frame-path objects and retained detection-object proof.
rem ============================================================================

call :inspect_frame_path_objects
if errorlevel 1 goto :fail
call :inspect_detection_object
if errorlevel 1 goto :fail
call :run_membership_perturbation
if errorlevel 1 goto :fail

rem ============================================================================
rem N1: target/CPU override rejection and 9/9 release debug-option rejection.
rem ============================================================================

call :run_negative_build_controls
if errorlevel 1 goto :fail

rem Final source gates after all runs.
call :audit_sweep
if errorlevel 1 goto :fail
call :audit_eol
if errorlevel 1 goto :fail

set "MARKER=Final CRLF-aware whitespace check"
set "CMD=git -c core.whitespace=cr-at-eol diff --check"
call :run

set "MARKER=Show final git working tree status"
set "CMD=git status --short"
call :run

>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo IDENTITY=!IDENTITY_STRING!
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo ZIG_VERSION=!OBSERVED_ZIG_VERSION!

>"!DEBLOCK4_INSPECTION_DIR!\manual_review_required.txt" echo W3D must independently review raw exports, strings, disassembly, e2e output, properties, lifecycle traces, sweep and S1 evidence.
>>"!DEBLOCK4_INSPECTION_DIR!\manual_review_required.txt" echo W3C concurrence and W3X acceptance remain required; this batch does not self-accept the stage.

echo.
echo ================================================================================
echo STAGE %STAGE% FULL PROOF MATRIX COMPLETED SUCCESSFULLY
echo Evidence retained under !DEBLOCK4_INSPECTION_DIR!
echo W3D ARTIFACT REVIEW AND W3X ACCEPTANCE ARE STILL REQUIRED
echo ================================================================================
echo.
exit /b 0

rem ============================================================================
rem Release-mode body.
rem ============================================================================

:run_release_mode
set "MODE=%~1"
set "MODE_DIR=!DEBLOCK4_INSPECTION_DIR!\!MODE!"
set "MODE_PREFIX=!DEBLOCK4_BUILD_ROOT!\!MODE!"
set "MODE_CACHE=!DEBLOCK4_CACHE_ROOT!\!MODE!"
call :make_dir "!MODE_DIR!"
if errorlevel 1 exit /b 1

echo.
echo ----------------------------------------------------------------
echo Starting %STAGE% release mode !MODE!

set "MARKER=Build !MODE! production DLL and selftest"
set "CMD=zig build --prefix "!MODE_PREFIX!" --cache-dir "!MODE_CACHE!" -Doptimize=!MODE! -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose"
call :run
if errorlevel 1 exit /b 1

set "MARKER=Run complete !MODE! unit-test suite"
set "CMD=zig build test --prefix "!MODE_PREFIX!" --cache-dir "!MODE_CACHE!" -Doptimize=!MODE! -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose --summary all"
set "OUT=!MODE_DIR!\unit_tests.txt"
call :run_test_command
if errorlevel 1 exit /b 1

set "DLL_FILE=!MODE_PREFIX!\bin\Deblock4.dll"
set "SELFTEST_FILE=!MODE_PREFIX!\bin\deblock4_selftest.exe"
if not exist "!DLL_FILE!" exit /b 1
if not exist "!SELFTEST_FILE!" exit /b 1

set "DEBLOCK4_FORCE_DOWN=v1"
set "MARKER=Run !MODE! selftest with force-down environment present"
set "CMD="!SELFTEST_FILE!""
set "OUT=!MODE_DIR!\selftest.txt"
call :capture_both
if errorlevel 1 exit /b 1
set "DEBLOCK4_FORCE_DOWN="
call :find_present "!MODE! selftest version banner" "!OUT!" "deblock4_selftest: version=!IDENTITY_STRING!"
call :find_present "!MODE! selftest PASS" "!OUT!" "deblock4_selftest: PASS"
call :find_present "!MODE! selftest Stage 1C section" "!OUT!" "stage_1c=PASS"
call :find_absent "!MODE! ignores force-down environment" "!OUT!" "FORCE-DOWN ACTIVE"
call :find_absent "!MODE! has no lifecycle marker" "!OUT!" "!TRACE_STRING!"

call :run_release_e2e "!MODE_DIR!"
if errorlevel 1 exit /b 1

call :capture_artifacts "!MODE_DIR!" "!DLL_FILE!" "!SELFTEST_FILE!"
if errorlevel 1 exit /b 1
call :assert_release_absent "!MODE_DIR!"
if errorlevel 1 exit /b 1
call :assert_export_table "!MODE_DIR!"
if errorlevel 1 exit /b 1

echo Finished %STAGE% release mode !MODE! PASS
echo ----------------------------------------------------------------
exit /b 0

rem ============================================================================
rem E1/E2/E4/E5 e2e groups.
rem ============================================================================

:run_release_e2e
set "E2E_DIR=%~1"
set "DEBLOCK4_FORCE_DOWN="
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_auto x86_64_v3_with_avx2 STAGE_1C_CLASSIC_PASS "!E2E_DIR!\classic_valid_auto.txt"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_full x86_64_v2_with_sse41 STAGE_1C_CLASSIC_PASS "!E2E_DIR!\classic_valid_full.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_auto x86_64_v3_with_avx2 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_valid_auto.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_full x86_64_v2_with_sse41 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_valid_full.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" midpoint_present x86_64_v3_with_avx2 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_midpoint_present.txt"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" midpoint_absent x86_64_v3_with_avx2 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_midpoint_absent.txt"
call :run_validation_error_cases "!E2E_DIR!"
exit /b !ERRORLEVEL!

:run_debug_normal_e2e
call :run_release_e2e "!MODE_DIR!"
exit /b !ERRORLEVEL!

:run_validation_error_cases
set "E2E_DIR=%~1"
for %%C in (error_strength error_duplicate_planes error_unknown_backend error_variable_format) do (
    call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" %%C x86_64_v3_with_avx2 STAGE_1C_EXPECTED_ERROR_PASS "!E2E_DIR!\classic_%%C.txt"
    if errorlevel 1 exit /b 1
)
for %%C in (error_strength error_duplicate_planes error_step_low error_step_high error_unknown_backend error_variable_format) do (
    call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" %%C x86_64_v3_with_avx2 STAGE_1C_EXPECTED_ERROR_PASS "!E2E_DIR!\deblock4_%%C.txt"
    if errorlevel 1 exit /b 1
)
exit /b 0

:run_vpy_case
set "DEBLOCK4_PLUGIN_PATH=!DEBLOCK4_PROJECT_PREFIX!!DLL_FILE!"
set "DEBLOCK4_TEST_CASE=%~2"
set "DEBLOCK4_EXPECTED_TIER=%~3"
set "VPY_MARKER=%~4"
set "OUT=%~5"
echo.
echo === vspipe case !DEBLOCK4_TEST_CASE! script %~nx1
echo call tools\run_vs.cmd --info "%~1"
call tools\run_vs.cmd --info "%~1" > "!OUT!" 2>&1
set "exit_code=!ERRORLEVEL!"
type "!OUT!"
echo === Exit code !exit_code!
if not "!exit_code!"=="0" (
    set "MARKER=vspipe case !DEBLOCK4_TEST_CASE!"
    set "CMD=call tools\run_vs.cmd --info %~1"
    goto :fail
)
call :find_present "vspipe case !DEBLOCK4_TEST_CASE! emitted PASS marker" "!OUT!" "!VPY_MARKER!"
if errorlevel 1 exit /b 1
call :find_absent "vspipe case !DEBLOCK4_TEST_CASE! emitted no Python traceback" "!OUT!" "Traceback (most recent call last)"
if errorlevel 1 exit /b 1
exit /b 0

:assert_lifecycle_trace
set "TRACE_FILE=%~1"
set "TRACE_FILTER=%~2"
call :find_present "Lifecycle plugin-init present for %~2" "!TRACE_FILE!" "lifecycle plugin-init version=!IDENTITY_STRING!"
call :find_present "Lifecycle creation-enter present for %~2" "!TRACE_FILE!" "lifecycle creation-enter filter=%~2"
call :find_present "Lifecycle one-line creation-exit present for %~2" "!TRACE_FILE!" "lifecycle creation-exit filter=%~2 instance="
call :find_present "Lifecycle arInitial present for %~2" "!TRACE_FILE!" "reason=0 returned=0"
call :find_present "Lifecycle arAllFramesReady returns frame for %~2" "!TRACE_FILE!" "reason=1 returned=1"
call :find_present "Lifecycle free present for %~2" "!TRACE_FILE!" "lifecycle free filter=%~2 instance="
call :count_literal_exact "Selection summary occurs once for %~2 instance" "!TRACE_FILE!" "deblock4: !IDENTITY_STRING! %~2 backend=" 1
set "MARKER=Verify frame events contain no selection fields for %~2"
set "CMD=powershell lifecycle frame-event scan"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$l=Get-Content -LiteralPath '!TRACE_FILE!' | Where-Object {$_ -match 'lifecycle getFrame-'}; if(-not $l){exit 2}; if($l -match 'backend=|tier=|DEBLOCK4_FORCE_DOWN'){ $l; exit 1 }" >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

rem ============================================================================
rem G1/G2 artifact capture and gates.
rem ============================================================================

:capture_artifacts
set "CAPTURE_DIR=%~1"
set "CAPTURE_DLL=%~2"
set "CAPTURE_SELFTEST=%~3"
copy /Y "!CAPTURE_DLL!" "!CAPTURE_DIR!\Deblock4.dll" >nul || exit /b 1
copy /Y "!CAPTURE_SELFTEST!" "!CAPTURE_DIR!\deblock4_selftest.exe" >nul || exit /b 1

set "MARKER=Capture DLL exports for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /EXPORTS "!CAPTURE_DLL!""
set "OUT=!CAPTURE_DIR!\Deblock4_exports.txt"
call :capture
set "MARKER=Capture selftest exports for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /EXPORTS "!CAPTURE_SELFTEST!""
set "OUT=!CAPTURE_DIR!\deblock4_selftest_exports.txt"
call :capture
set "MARKER=Capture DLL symbols for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!CAPTURE_DLL!""
set "OUT=!CAPTURE_DIR!\Deblock4_symbols.txt"
call :capture
set "MARKER=Capture selftest symbols for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!CAPTURE_SELFTEST!""
set "OUT=!CAPTURE_DIR!\deblock4_selftest_symbols.txt"
call :capture
set "MARKER=Capture DLL disassembly for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!CAPTURE_DLL!""
set "OUT=!CAPTURE_DIR!\Deblock4_disasm.txt"
call :capture
set "MARKER=Capture selftest disassembly for !CAPTURE_DIR!"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!CAPTURE_SELFTEST!""
set "OUT=!CAPTURE_DIR!\deblock4_selftest_disasm.txt"
call :capture
exit /b 0

:assert_release_absent
set "CHECK_DIR=%~1"
for %%B in (Deblock4.dll deblock4_selftest.exe) do (
    for %%S in (!FORCE_STRING! !DIAG_STRING! !TRACE_STRING!) do (
        call :find_absent "Release raw binary has no G10 marker %%S" "!CHECK_DIR!\%%B" "%%S"
        if errorlevel 1 exit /b 1
    )
)
for %%F in (Deblock4_exports.txt deblock4_selftest_exports.txt Deblock4_symbols.txt deblock4_selftest_symbols.txt) do (
    for %%S in (!FORCE_EXPORT! !DIAG_EXPORT! !TRACE_EXPORT!) do (
        call :find_absent "Release symbol surface has no %%S" "!CHECK_DIR!\%%F" "%%S"
        if errorlevel 1 exit /b 1
    )
)
for %%F in (Deblock4_disasm.txt deblock4_selftest_disasm.txt) do (
    for %%S in (!FORCE_CODE! !DIAG_CODE! !TRACE_CODE!) do (
        call :find_absent "Release disassembly has no code marker %%S" "!CHECK_DIR!\%%F" "%%S"
        if errorlevel 1 exit /b 1
    )
)
echo Release G10 three-surface absence PASS for !CHECK_DIR!
exit /b 0

:assert_debug_present
set "CHECK_DIR=%~1"
for %%B in (Deblock4.dll deblock4_selftest.exe) do (
    for %%S in (!FORCE_STRING! !DIAG_STRING! !TRACE_STRING!) do (
        call :find_present "Debug raw binary contains G10 marker %%S" "!CHECK_DIR!\%%B" "%%S"
        if errorlevel 1 exit /b 1
    )
)
rem Debug positive controls are the seam-unique raw strings and code
rem immediates. G2 simultaneously requires the marker function names to stay
rem OUT of the linked DLL export table; linked-PE COFF symbol retention is not
rem an acceptance dependency. S1 uses stable .obj files where /SYMBOLS is
rem authoritative.
for %%F in (Deblock4_disasm.txt deblock4_selftest_disasm.txt) do (
    for %%S in (!FORCE_CODE! !DIAG_CODE! !TRACE_CODE!) do (
        call :find_present "Debug disassembly contains code marker %%S" "!CHECK_DIR!\%%F" "%%S"
        if errorlevel 1 exit /b 1
    )
)
echo Debug G10 positive controls PASS for !CHECK_DIR!
exit /b 0

:assert_export_table
set "CHECK_DIR=%~1"
call :find_present "DLL exports VapourSynthPluginInit2" "!CHECK_DIR!\Deblock4_exports.txt" "VapourSynthPluginInit2"
for %%S in (deblock4_backend_probe deblock4_dll_probe !FORCE_EXPORT! !DIAG_EXPORT! !TRACE_EXPORT!) do (
    call :find_absent "DLL export table excludes %%S" "!CHECK_DIR!\Deblock4_exports.txt" "%%S"
    if errorlevel 1 exit /b 1
)
exit /b 0

rem ============================================================================
rem S1 frame objects and retained detector proof.
rem ============================================================================

:inspect_frame_path_objects
set "OBJECT_PREFIX=!DEBLOCK4_BUILD_ROOT!\InspectionObjects"
set "OBJECT_CACHE=!DEBLOCK4_CACHE_ROOT!\InspectionObjects"
set "OBJECT_DIR=!OBJECT_PREFIX!\frame-path-objects"
set "EVIDENCE_DIR=!DEBLOCK4_INSPECTION_DIR!\S1_frame_path"
call :make_dir "!EVIDENCE_DIR!"
set "MARKER=Build stable frame-path inspection objects"
set "CMD=zig build frame-path-objects --prefix "!OBJECT_PREFIX!" --cache-dir "!OBJECT_CACHE!" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose"
call :run
for %%O in (classic_callback_router deblock4_callback_router classic_ar_initial deblock4_ar_initial classic_ar_all_frames_ready deblock4_ar_all_frames_ready) do (
    if not exist "!OBJECT_DIR!\%%O.obj" exit /b 1
    set "MARKER=Capture symbols for %%O"
    set "CMD=dumpbin /NOLOGO /SYMBOLS "!OBJECT_DIR!\%%O.obj""
    set "OUT=!EVIDENCE_DIR!\%%O_symbols.txt"
    call :capture
    set "MARKER=Capture disassembly for %%O"
    set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!OBJECT_DIR!\%%O.obj""
    set "OUT=!EVIDENCE_DIR!\%%O_disasm.txt"
    call :capture
    for %%S in (backend_tier_selection cpu_capability_detection DEBLOCK4_FORCE_DOWN) do (
        call :find_absent "%%O has no per-frame selection symbol %%S" "!EVIDENCE_DIR!\%%O_symbols.txt" "%%S"
        if errorlevel 1 exit /b 1
        call :find_absent "%%O disassembly has no per-frame selection name %%S" "!EVIDENCE_DIR!\%%O_disasm.txt" "%%S"
        if errorlevel 1 exit /b 1
    )
)
echo S1 frame-path object symbol/disassembly proof PASS
exit /b 0

:inspect_detection_object
set "DET_PREFIX=!DEBLOCK4_BUILD_ROOT!\DetectionInspection"
set "DET_CACHE=!DEBLOCK4_CACHE_ROOT!\DetectionInspection"
set "DETECTION_OBJ=!DET_PREFIX!\detection-objects\cpu_capability_detection.obj"
set "DET_DIR=!DEBLOCK4_INSPECTION_DIR!\detection"
call :make_dir "!DET_DIR!"
set "MARKER=Build retained baseline-v1 detection object"
set "CMD=zig build detection-object --prefix "!DET_PREFIX!" --cache-dir "!DET_CACHE!" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose"
call :run
if not exist "!DETECTION_OBJ!" exit /b 1
set "MARKER=Capture detection object symbols"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!DETECTION_OBJ!""
set "OUT=!DET_DIR!\symbols.txt"
call :capture
call :find_present "Detection semantic root present" "!OUT!" "!DETECTION_ROOT!"
set "MARKER=Capture detection object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!DETECTION_OBJ!""
set "OUT=!DET_DIR!\disasm.txt"
call :capture
call :find_present "Detection disassembly contains CPUID" "!OUT!" "cpuid"
call :count_regex_exact "Detection has one XGETBV instruction" "!OUT!" PAT_XGETBV_INSN 1
call :count_regex_exact "Detection has one XGETBV call site" "!OUT!" PAT_XGETBV_CALL 1
call :deny_regex "Detection has no EVEX encoding" "!OUT!" PAT_EVEX
call :deny_regex "Detection has no VEX C4 encoding" "!OUT!" PAT_VEX2
call :deny_regex "Detection has no VEX C5 encoding" "!OUT!" PAT_VEX3
call :deny_list "detection object" "!OUT!" "!OUTSIDE!"
call :deny_list "detection object" "!OUT!" "!V2ONLY_A!"
call :deny_list "detection object" "!OUT!" "!V2ONLY_B!"
call :deny_list "detection object" "!OUT!" "!V2ONLY_C!"
call :deny_list "detection object" "!OUT!" "!V2ONLY_D!"
call :deny_list "detection object" "!OUT!" "!V3ONLY!"
call :deny_list "detection object" "!OUT!" "!AVX512!"
exit /b 0

:run_membership_perturbation
set "PERTURB_DIR=%TEMP%\Deblock4_1C_membership_perturb"
if exist "!PERTURB_DIR!" rmdir /s /q "!PERTURB_DIR!"
echo.
echo === Copy project to temporary membership-perturbation tree
robocopy "!DEBLOCK4_PROJECT_ROOT!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP
set "copy_code=!ERRORLEVEL!"
if !copy_code! GTR 7 (set "MARKER=Copy perturbation tree" & set "CMD=robocopy" & set "exit_code=!copy_code!" & goto :fail)
set "PERTURB_FILE=!PERTURB_DIR!\src\cpu_capability_detection.zig"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='!PERTURB_FILE!'; $s=[IO.File]::ReadAllText($p); $old='.allow_light_256_bit, .avx, .avx2, .bmi, .bmi2,'; $new='.allow_light_256_bit, .avx, .avx2, .bmi,'; if(-not $s.Contains($old)){exit 2}; [IO.File]::WriteAllText($p,$s.Replace($old,$new),[Text.Encoding]::ASCII)"
if errorlevel 1 exit /b 1
set "OUT=!DEBLOCK4_INSPECTION_DIR!\named_model_perturbation_expected_failure.txt"
pushd "!PERTURB_DIR!"
zig build detection-object -Doptimize=ReleaseFast > "!DEBLOCK4_PROJECT_PREFIX!!OUT!" 2>&1
set "perturb_code=!ERRORLEVEL!"
popd
if "!perturb_code!"=="0" (set "MARKER=Named-model perturbation expected failure" & set "CMD=zig build detection-object" & set "exit_code=1" & goto :fail)
call :find_present "Perturbation names capture drift" "!OUT!" "Zig 0.16 named-model capture drift"
call :find_present "Perturbation names BMI2" "!OUT!" "bmi2"
rmdir /s /q "!PERTURB_DIR!"
if exist "!PERTURB_DIR!" exit /b 1
exit /b 0

rem ============================================================================
rem Static audits.
rem ============================================================================

:audit_source_structure
set "MARKER=S1 structural dependency audit"
echo === !MARKER!
set "CMD=powershell -File tools\audit_stage_1c_s1_structure.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "tools\audit_stage_1c_s1_structure.ps1"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "MARKER=G10 source-visible conditional-import audit"
echo === !MARKER!
set "CMD=powershell -File tools\audit_stage_1c_g10_imports.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "tools\audit_stage_1c_g10_imports.ps1"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:audit_sweep
set "MARKER=S2 retired-file and reference sweep"
echo === !MARKER!
set "CMD=powershell -File tools\audit_stage_1c_s2_sweep.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "tools\audit_stage_1c_s2_sweep.ps1"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:audit_eol
set "MARKER=S3 repository text CRLF and US-ASCII audit"
echo === !MARKER!
set "CMD=powershell -File tools\audit_stage_1c_s3_eol.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "tools\audit_stage_1c_s3_eol.ps1"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:audit_version_sources
set "MARKER=V1 source and manifest single-home audit"
echo === !MARKER!
set "CMD=powershell version scan"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$q=[char]34; $zon=[IO.File]::ReadAllText('build.zig.zon'); if($zon -notmatch ('\.version\s*=\s*'+$q+[regex]::Escape('!SEMANTIC_VERSION!')+$q)){exit 1}; $plugin=[IO.File]::ReadAllText('src/deblock4_plugin.zig'); if(-not $plugin.Contains('version.vs_packed_version')){exit 2}; $classic=[IO.File]::ReadAllText('src/classic_frame_properties.zig'); $deb=[IO.File]::ReadAllText('src/deblock4_frame_properties.zig'); $self=[IO.File]::ReadAllText('src/deblock4_selftest.zig'); if(-not($classic.Contains('version.identity_string') -and $deb.Contains('version.identity_string') -and $self.Contains('version.identity_string'))){exit 3}; $dupes=Get-ChildItem src -File | Where-Object {$_.Name -ne 'deblock4_version.zig'} | Select-String -SimpleMatch '!IDENTITY_STRING!'; if($dupes){$dupes;exit 4}; Write-Host 'V1_SOURCE_MANIFEST_PASS'"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

rem ============================================================================
rem N1 negative build controls.
rem ============================================================================

:run_negative_build_controls
set "NEG_DIR=!DEBLOCK4_INSPECTION_DIR!\negative_controls"
call :make_dir "!NEG_DIR!"
set "MARKER=Reject command-line CPU override"
set "CMD=zig build -Dcpu=x86_64_v3"
set "OUT=!NEG_DIR!\reject_cpu.txt"
call :expect_fail_capture
set "MARKER=Reject command-line target override"
set "CMD=zig build -Dtarget=x86_64-windows-msvc"
set "OUT=!NEG_DIR!\reject_target.txt"
call :expect_fail_capture
for %%M in (ReleaseSafe ReleaseFast ReleaseSmall) do (
    for %%O in (enable_force_down enable_verbose_detection enable_trace_lifecycle) do (
        set "MARKER=Reject %%O in %%M"
        set "CMD=zig build -Doptimize=%%M -D%%O=true"
        set "OUT=!NEG_DIR!\reject_%%O_%%M.txt"
        call :expect_fail_capture
        call :find_present "%%O %%M rejection names Debug requirement" "!OUT!" "require -Doptimize=Debug"
        if errorlevel 1 exit /b 1
    )
)
>"!NEG_DIR!\negative_control_summary.txt" echo cpu=REJECT target=REJECT release_debug_options=9/9_REJECT
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
if "!observed_code!"=="0" (set "exit_code=1" & goto :fail)
set "exit_code=0"
echo !MARKER! PASS observed exit !observed_code!
exit /b 0

:run_test_command
set "TEST_MARKER=!MARKER!"
set "TEST_OUT=!OUT!"
call :capture_both
call :find_present "!TEST_MARKER! emitted a build summary" "!TEST_OUT!" "Build Summary:"
call :find_present "!TEST_MARKER! reports successful steps" "!TEST_OUT!" "steps succeeded"
call :find_present "!TEST_MARKER! reports tests passed" "!TEST_OUT!" "tests passed"
call :find_absent "!TEST_MARKER! emitted no transitive failure" "!TEST_OUT!" "transitive failure"
call :find_absent "!TEST_MARKER! emitted no failed-tests marker" "!TEST_OUT!" "tests failed"
call :find_absent "!TEST_MARKER! emitted no timeout" "!TEST_OUT!" "timed out"
call :find_absent "!TEST_MARKER! emitted no leak" "!TEST_OUT!" "leaked memory"
call :find_absent "!TEST_MARKER! emitted no panic" "!TEST_OUT!" "panic:"
echo !TEST_MARKER! PASS by exit code and Zig summary; --listen context is non-authoritative
exit /b 0

:find_present
set "MARKER=%~1"
set "CMD=find required text in %~2"
if not exist "%~2" (set "exit_code=1" & goto :fail)
echo === %~1
findstr /I /C:"%~3" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:find_absent
set "MARKER=%~1"
set "CMD=verify forbidden text absent from %~2"
if not exist "%~2" (set "exit_code=1" & goto :fail)
echo === %~1
findstr /I /C:"%~3" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (set "exit_code=1" & goto :fail)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:deny_regex
set "MARKER=%~1"
set "CMD=deny regex in %~2"
set "scan_pattern=!%~3!"
findstr /I /R /C:"!scan_pattern!" "%~2" >nul <nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (findstr /I /R /C:"!scan_pattern!" "%~2" <nul & set "exit_code=1" & goto :fail)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
exit /b 0

:deny_list
set "MARKER=Verify %~1 instruction level"
set "CMD=deny mnemonic list in %~2"
for %%I in (%~3) do (
    findstr /I /C:"%%I" "%~2" >nul <nul
    if "!ERRORLEVEL!"=="0" (echo === forbidden %%I & findstr /I /C:"%%I" "%~2" <nul & set "exit_code=1" & goto :fail)
)
set "exit_code=0"
exit /b 0

:count_literal_exact
set "COUNT_FILE=%TEMP%\deblock4_1c_literal_count.txt"
findstr /I /C:"%~3" "%~2" > "!COUNT_FILE!" <nul
set "scan_code=!ERRORLEVEL!"
if not "!scan_code!"=="0" (set "MARKER=%~1" & set "CMD=findstr literal count" & set "exit_code=1" & goto :fail)
set /a observed_count=0
for /f "usebackq delims=" %%L in ("!COUNT_FILE!") do set /a observed_count+=1
del /q "!COUNT_FILE!" >nul 2>nul
echo === %~1 observed !observed_count! expected %~4
if not "!observed_count!"=="%~4" (set "MARKER=%~1" & set "CMD=count literal" & set "exit_code=1" & goto :fail)
set "exit_code=0"
exit /b 0

:count_regex_exact
set "scan_pattern=!%~3!"
set "COUNT_FILE=%TEMP%\deblock4_1c_regex_count.txt"
findstr /I /R /C:"!scan_pattern!" "%~2" > "!COUNT_FILE!" <nul
set "scan_code=!ERRORLEVEL!"
if not "!scan_code!"=="0" (set "MARKER=%~1" & set "CMD=findstr regex count" & set "exit_code=1" & goto :fail)
set /a observed_count=0
for /f "usebackq delims=" %%L in ("!COUNT_FILE!") do set /a observed_count+=1
del /q "!COUNT_FILE!" >nul 2>nul
echo === %~1 observed !observed_count! expected %~4
if not "!observed_count!"=="%~4" (set "MARKER=%~1" & set "CMD=count regex" & set "exit_code=1" & goto :fail)
set "exit_code=0"
exit /b 0

:remove_tree
if "%~1"=="" exit /b 0
if not exist "%~1" exit /b 0
set "MARKER=Remove build output %~1"
set "CMD=rmdir /s /q %~1 with bounded retry"
set /a remove_attempt=0
:remove_tree_retry
set /a remove_attempt+=1
echo === !MARKER! attempt !remove_attempt! of 5
rmdir /s /q "%~1"
set "exit_code=!ERRORLEVEL!"
if not exist "%~1" (set "exit_code=0" & exit /b 0)
if !remove_attempt! LSS 5 (ping 127.0.0.1 -n 2 >nul 2>nul & goto :remove_tree_retry)
dir /a /s "%~1"
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
if not defined exit_code set "exit_code=1"
if "!exit_code!"=="0" set "exit_code=1"
echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET FAIL
echo Failed step !MARKER!
echo CMD !CMD!
echo Exit code !exit_code!
echo ================================================================================
echo.
exit /b !exit_code!
