@echo off
@if /I "%~1"=="--worker" goto :worker
@setlocal ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

rem Run the validation body in a dedicated child cmd.exe. The parent retains
rem one complete combined-stream transcript and returns the worker exit code.
set "TRANSCRIPT_TEMP=%TEMP%\Deblock4_build_5C_v1_%RANDOM%_%RANDOM%_full_output.log"
"%ComSpec%" /D /V:OFF /C call "%~f0" --worker >"%TRANSCRIPT_TEMP%" 2>&1
set "OUTER_EXIT_CODE=%ERRORLEVEL%"

set "TRANSCRIPT_DIR=%~dp0zig-out\inspection_5C"
if not exist "%TRANSCRIPT_DIR%" md "%TRANSCRIPT_DIR%" >nul 2>nul
set "TRANSCRIPT_FILE=%TRANSCRIPT_DIR%\build_5C_v1_full_output.log"
copy /Y "%TRANSCRIPT_TEMP%" "%TRANSCRIPT_FILE%" >nul
>>"%TRANSCRIPT_FILE%" echo.
>>"%TRANSCRIPT_FILE%" echo OUTER_BATCH_EXIT_CODE=%OUTER_EXIT_CODE%

type "%TRANSCRIPT_FILE%"

set "DIAGNOSTIC_INDEX=%TRANSCRIPT_DIR%\build_5C_v1_diagnostic_index.txt"
findstr /N /I /C:"LLVM" /C:"error:" /C:"panic:" /C:"failed command:" /C:"internal compiler error" /C:"unable to emit" /C:"codegen" "%TRANSCRIPT_FILE%" >"%DIAGNOSTIC_INDEX%"
set "INDEX_EXIT_CODE=%ERRORLEVEL%"
if %INDEX_EXIT_CODE% GEQ 2 echo WARNING: diagnostic index generation failed with exit %INDEX_EXIT_CODE%.

del /Q "%TRANSCRIPT_TEMP%" >nul 2>nul
exit /b %OUTER_EXIT_CODE%

:worker
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem ============================================================================
rem Deblock4 Stage 5C complete proof matrix.
rem
rem Charter v1.29 C-DELIV-11: the already-reviewed 2C inline PowerShell and
rem resident prior-stage audit calls are retained, not rewritten. Stage 5C
rem adds no new PowerShell machinery; new 5C controls below use CMD plus the
rem existing portable-Python runner only for temporary-tree mutation.
rem
rem Implements Stage 5C scope v1.2 section 7 (5C-T1..T6) and retains the
rem D4 v1.10 Stage 2C B1-B2, G1-G2, E1-E6, V1, S1-S3, N1 matrix, plus
rem the retained Stage 1B.3 detection-object drift proof.
rem Exit-code gating is primary. Zig's known --listen "failed command:" context
rem may appear when a passing test writes expected stderr; it is indexed but is
rem not itself a failure signal.
rem ============================================================================

set "STAGE=5C_v1"
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
set "DEBLOCK4_INSPECTION_DIR=zig-out\inspection_5C"
set "DEBLOCK4_BUILD_ROOT=zig-out\stage_5c"
set "DEBLOCK4_CACHE_ROOT=.zig-cache\stage_5c"
set "DEBLOCK4_CLASSIC_SCRIPT=!DEBLOCK4_PROJECT_PREFIX!tests\stage_2c_classic_obligations.vpy"
set "DEBLOCK4_FILTER_SCRIPT=!DEBLOCK4_PROJECT_PREFIX!tests\stage_1c_deblock4_passthrough.vpy"
set "DEBLOCK4_CROSSWALK=!DEBLOCK4_PROJECT_PREFIX!tests\Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md"

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
if not exist "%DEBLOCK4_CROSSWALK%" (echo ERROR: D3 O/G crosswalk missing & exit /b 1)
if not exist "tools\audit_stage_1c_s1_structure.ps1" (echo ERROR: S1 audit script missing & exit /b 1)
if not exist "tools\audit_stage_1c_g10_imports.ps1" (echo ERROR: G10 audit script missing & exit /b 1)
if not exist "tools\audit_stage_1c_s2_sweep.ps1" (echo ERROR: S2 audit script missing & exit /b 1)
if not exist "tools\audit_stage_1c_s3_eol.ps1" (echo ERROR: S3 audit script missing & exit /b 1)
if not defined DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER (
    echo ERROR: DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER must name the W3D-supplied absolute .cmd path.
    exit /b 1
)
if not exist "!DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER!" (
    echo ERROR: W3D Stage 5C differential runner not found: !DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER!
    exit /b 1
)
if not defined DEBLOCK4_STAGE5C_BENCHMARK_RUNNER (
    echo ERROR: DEBLOCK4_STAGE5C_BENCHMARK_RUNNER must name the W3D-supplied absolute .cmd path.
    exit /b 1
)
if not exist "!DEBLOCK4_STAGE5C_BENCHMARK_RUNNER!" (
    echo ERROR: W3D Stage 5C benchmark runner not found: !DEBLOCK4_STAGE5C_BENCHMARK_RUNNER!
    exit /b 1
)

for /f "usebackq delims=" %%V in (`zig version`) do set "OBSERVED_ZIG_VERSION=%%V"
echo === Observed Zig version !OBSERVED_ZIG_VERSION!
if /I not "!OBSERVED_ZIG_VERSION!"=="0.16.0" (
    echo ERROR: Stage 5C requires Zig 0.16.0.
    exit /b 1
)

echo === Prepare Stage 5C proof directories
call :remove_tree "!DEBLOCK4_CACHE_ROOT!"
if errorlevel 1 goto :fail
call :remove_tree "!DEBLOCK4_BUILD_ROOT!"
if errorlevel 1 goto :fail
call :remove_tree "!DEBLOCK4_INSPECTION_DIR!"
if errorlevel 1 goto :fail
call :make_dir "!DEBLOCK4_INSPECTION_DIR!"
if errorlevel 1 goto :fail
echo === Stage 5C proof directories ready

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
call :audit_stage2_scope
if errorlevel 1 goto :fail

rem ============================================================================
rem ReleaseSafe and ReleaseFast complete builds/tests/e2e and G10 absence.
rem ============================================================================

call :run_release_mode ReleaseSafe
if errorlevel 1 goto :fail
call :run_stage4c_vector_tests ReleaseSafe
if errorlevel 1 goto :fail
call :run_release_mode ReleaseFast
if errorlevel 1 goto :fail
call :run_stage4c_vector_tests ReleaseFast
if errorlevel 1 goto :fail
call :compare_release_outputs
if errorlevel 1 goto :fail
call :run_stage4c_regression_differential
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
call :find_present "Debug retained Stage 2C exact test count" "!OUT!" "85/85 tests passed"
if errorlevel 1 goto :fail
call :run_stage4c_vector_tests Debug
if errorlevel 1 goto :fail

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
call :find_present "Debug selftest selection and creation contract" "!OUT!" "selection_and_creation_contract=PASS"
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

rem T-S5-3/T-S5-5 Debug force-down cases under the raised Classic v3 ceiling.
set "DEBLOCK4_FORCE_DOWN=v1"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_auto x86_64_v1_baseline STAGE_2C_CLASSIC_PASS "!MODE_DIR!\classic_force_v1.txt" 1 1
call :find_present "Classic force-v1 summary byte stability" "!MODE_DIR!\classic_force_v1.txt" "tier=x86_64_v1_baseline reason=forced-down(x86_64_v1_baseline) actual=x86_64_v3_with_avx2"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_auto x86_64_v1_baseline STAGE_1C_DEBLOCK4_PASS "!MODE_DIR!\deblock4_force_v1.txt" 1 1
set "DEBLOCK4_FORCE_DOWN=v2"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_auto x86_64_v2_with_sse41 STAGE_2C_CLASSIC_PASS "!MODE_DIR!\classic_force_v2.txt" 1 1
call :find_present "Classic force-v2 reaches implemented v2" "!MODE_DIR!\classic_force_v2.txt" "tier=x86_64_v2_with_sse41 reason=forced-down(x86_64_v2_with_sse41) actual=x86_64_v3_with_avx2"
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_auto x86_64_v2_with_sse41 STAGE_1C_DEBLOCK4_PASS "!MODE_DIR!\deblock4_force_v2.txt" 1 1
set "DEBLOCK4_FORCE_DOWN=V2"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" error_invalid_force_down x86_64_v1_baseline STAGE_2C_EXPECTED_ERROR_PASS "!MODE_DIR!\classic_force_invalid.txt" 0 0
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" error_invalid_force_down x86_64_v3_with_avx2 STAGE_1C_EXPECTED_ERROR_PASS "!MODE_DIR!\deblock4_force_invalid.txt" 0 0

rem T-S5-4 EFFECTIVE refusal precedes implementation availability.
set "DEBLOCK4_FORCE_DOWN=v1"
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" n03 x86_64_v1_baseline STAGE_2C_EXPECTED_ERROR_PASS "!MODE_DIR!\classic_n03.txt" 1 0
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" error_above_effective x86_64_v1_baseline STAGE_1C_EXPECTED_ERROR_PASS "!MODE_DIR!\deblock4_above_effective.txt" 1 0
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
call :inspect_stage4c_v2_object
if errorlevel 1 goto :fail
call :run_membership_perturbation
if errorlevel 1 goto :fail
call :run_stage4c_tail_regression
if errorlevel 1 goto :fail

rem ============================================================================
rem Stage 5C T1-T5 after the complete retained 1C/2C/4C proof surface.
rem ============================================================================

call :run_stage5c_vector_tests ReleaseSafe
if errorlevel 1 goto :fail
call :run_stage5c_vector_tests ReleaseFast
if errorlevel 1 goto :fail
call :run_stage5c_vector_tests Debug
if errorlevel 1 goto :fail
call :run_stage5c_w3d_differential
if errorlevel 1 goto :fail
call :inspect_stage5c_v3_object
if errorlevel 1 goto :fail
call :run_stage5c_named_model_perturbations
if errorlevel 1 goto :fail
call :run_stage5c_tail_perturbation
if errorlevel 1 goto :fail

rem ============================================================================
rem N1: target/CPU override rejection and 9/9 release debug-option rejection.
rem ============================================================================

call :run_negative_build_controls
if errorlevel 1 goto :fail

rem Final source gates after all runs.
call :audit_stage2_scope
if errorlevel 1 goto :fail
call :audit_sweep
if errorlevel 1 goto :fail
call :audit_eol
if errorlevel 1 goto :fail

rem 5C-T6 is deliberately last and non-gating with respect to speed. The runner
rem must succeed in recording the raw timings, but no duration is a pass/fail bar.
call :run_stage5c_benchmark
if errorlevel 1 goto :fail

>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo STAGE1_REEXEC B1 B2 G1 G2 E1 E2 E3 E4 E5 E6 V1 S1 S2 S3 N1 PASS
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo IDENTITY=!IDENTITY_STRING!
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo ZIG_VERSION=!OBSERVED_ZIG_VERSION!
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo STAGE2_D3_O_G K31 S5 PASS H0_H6=NOT_RERUN_2C_HISTORY
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo STAGE4C_REEXEC T1 T2 T3 T4 T5 P3 K30 K31 PASS
>>"!DEBLOCK4_INSPECTION_DIR!\proof_matrix_summary.txt" echo STAGE5C T1 T2 T3 T4 T5 T6 K30 K31 PASS

>"!DEBLOCK4_INSPECTION_DIR!\manual_review_required.txt" echo W3D must independently review raw exports, strings, disassembly, e2e output, properties, lifecycle traces, sweep and S1 evidence.
>>"!DEBLOCK4_INSPECTION_DIR!\manual_review_required.txt" echo W3D artifact review and W3X acceptance remain required; this batch does not self-accept the stage.

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
call :find_present "!MODE! retained Stage 2C exact test count" "!OUT!" "85/85 tests passed"
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
call :find_present "!MODE! selftest selection and creation contract" "!OUT!" "selection_and_creation_contract=PASS"
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
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_auto x86_64_v3_with_avx2 STAGE_2C_CLASSIC_PASS "!E2E_DIR!\classic_valid_auto.txt" 1 1
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_full x86_64_v1_baseline STAGE_2C_CLASSIC_PASS "!E2E_DIR!\classic_valid_full.txt" 1 1
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" valid_coercion x86_64_v3_with_avx2 STAGE_2C_CLASSIC_PASS "!E2E_DIR!\classic_valid_coercion.txt" 1 1
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_auto x86_64_v3_with_avx2 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_valid_auto.txt" 1 1
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" valid_full x86_64_v2_with_sse41 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_valid_full.txt" 1 1
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" midpoint_present x86_64_v3_with_avx2 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_midpoint_present.txt" 1 1
call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" midpoint_absent x86_64_v3_with_avx2 STAGE_1C_DEBLOCK4_PASS "!E2E_DIR!\deblock4_midpoint_absent.txt" 1 1
call :find_present "Deblock4 normal summary remains hardware v3" "!E2E_DIR!\deblock4_valid_auto.txt" "tier=x86_64_v3_with_avx2"
call :run_validation_error_cases "!E2E_DIR!"
if errorlevel 1 exit /b 1
call :run_stage2_obligation_cases "!E2E_DIR!"
exit /b !ERRORLEVEL!

:run_debug_normal_e2e
call :run_release_e2e "!MODE_DIR!"
exit /b !ERRORLEVEL!

:run_validation_error_cases
set "E2E_DIR=%~1"
for %%C in (error_strength error_boundary_offset error_side_offset error_duplicate_planes error_unknown_backend error_variable_format n01a n01b n01c1 n01c2) do (
    call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" %%C x86_64_v1_baseline STAGE_2C_EXPECTED_ERROR_PASS "!E2E_DIR!\classic_%%C.txt" 0 0
    if errorlevel 1 exit /b 1
)
for %%C in (error_strength error_duplicate_planes error_step_low error_step_high error_unknown_backend error_variable_format) do (
    call :run_vpy_case "!DEBLOCK4_FILTER_SCRIPT!" %%C x86_64_v3_with_avx2 STAGE_1C_EXPECTED_ERROR_PASS "!E2E_DIR!\deblock4_%%C.txt" 0 0
    if errorlevel 1 exit /b 1
)
exit /b 0

:run_stage2_obligation_cases
set "E2E_DIR=%~1"
for %%C in (o4_gray8 o5d_gray16 o7_10x10 o7_12x6 o7_6x6 o7_11x7) do (
    call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" %%C x86_64_v1_baseline STAGE_2C_OBLIGATION_PASS "!E2E_DIR!\classic_%%C.txt" 1 1
    if errorlevel 1 exit /b 1
)
for %%C in (o8_yuv420_subset o8_yuv420p10_subset o8_yuv444p16_subset o8_yuv422_v o8_yuv444_all o8_rgb_subset o8_gray10 o8_gray16) do (
    call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" %%C x86_64_v1_baseline STAGE_2C_ROUTING_PASS "!E2E_DIR!\classic_%%C.txt" 1 1
    if errorlevel 1 exit /b 1
)
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" o5a_yuv420_chroma_o4 x86_64_v1_baseline STAGE_2C_CHROMA_O4_PASS "!E2E_DIR!\classic_o5a_yuv420_chroma_o4.txt" 1 1
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" strength_zero x86_64_v1_baseline STAGE_2C_STRENGTH_ZERO_PASS "!E2E_DIR!\classic_strength_zero.txt" 1 1
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" sanity x86_64_v1_baseline STAGE_2C_SANITY_PASS "!E2E_DIR!\classic_sanity.txt" 1 1
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" sanity_negative_control x86_64_v1_baseline STAGE_2C_SANITY_NEGATIVE_CONTROL_PASS "!E2E_DIR!\classic_sanity_negative_control.txt" 0 0
call :run_vpy_case "!DEBLOCK4_CLASSIC_SCRIPT!" n04 x86_64_v3_with_avx2 STAGE_2C_N04_PASS "!E2E_DIR!\classic_n04.txt" 1 1
call :find_present "N04 reaches implemented v3" "!E2E_DIR!\classic_n04.txt" "tier=x86_64_v3_with_avx2"
call :find_absent "N04 no longer reports the retired v2 implementation cap" "!E2E_DIR!\classic_n04.txt" "reason=intentionally-capped"
exit /b !ERRORLEVEL!

:run_vpy_case
set "DEBLOCK4_PLUGIN_PATH=!DEBLOCK4_PROJECT_PREFIX!!DLL_FILE!"
set "DEBLOCK4_TEST_CASE=%~2"
set "DEBLOCK4_EXPECTED_TIER=%~3"
set "VPY_MARKER=%~4"
set "OUT=%~5"
set "EXPECTED_SUMMARY_COUNT=%~6"
set "EXPECTED_USING_COUNT=%~7"
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
call :count_literal_zero_ok "summary count for !DEBLOCK4_TEST_CASE!" "!OUT!" "deblock4: !IDENTITY_STRING!" !EXPECTED_SUMMARY_COUNT!
if errorlevel 1 exit /b 1
call :count_literal_zero_ok "using count for !DEBLOCK4_TEST_CASE!" "!OUT!" "deblock4: using " !EXPECTED_USING_COUNT!
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
for %%S in (deblock4_backend_probe deblock4_dll_probe deblock4_classic_v2_process_u8 deblock4_classic_v2_process_u16 deblock4_classic_v3_process_u8 deblock4_classic_v3_process_u16 !FORCE_EXPORT! !DIAG_EXPORT! !TRACE_EXPORT!) do (
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
rem Stage 4C vector unit, differential, assembly and tail-negative controls.
rem ============================================================================

:run_stage4c_vector_tests
set "VEC_MODE=%~1"
set "VEC_DIR=!DEBLOCK4_INSPECTION_DIR!\!VEC_MODE!"
set "VEC_PREFIX=!DEBLOCK4_BUILD_ROOT!\!VEC_MODE!"
set "VEC_CACHE=!DEBLOCK4_CACHE_ROOT!\!VEC_MODE!"
set "MARKER=4C-T1 !VEC_MODE! Classic v2 vector differential unit suite"
set "CMD=zig build test-classic-v2 --prefix "!VEC_PREFIX!" --cache-dir "!VEC_CACHE!" -Doptimize=!VEC_MODE! -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose --summary all"
if /I "!VEC_MODE!"=="Debug" set "CMD=zig build test-classic-v2 --prefix "!VEC_PREFIX!" --cache-dir "!VEC_CACHE!" -Doptimize=Debug -Denable_force_down=true -Denable_verbose_detection=true -Denable_trace_lifecycle=true --error-style verbose --summary all"
set "OUT=!VEC_DIR!\classic_v2_unit_tests.txt"
call :run_test_command
exit /b !ERRORLEVEL!

:run_stage5c_vector_tests
set "VEC_MODE=%~1"
set "VEC_DIR=!DEBLOCK4_INSPECTION_DIR!\!VEC_MODE!"
set "VEC_PREFIX=!DEBLOCK4_BUILD_ROOT!\!VEC_MODE!"
set "VEC_CACHE=!DEBLOCK4_CACHE_ROOT!\!VEC_MODE!"
set "MARKER=5C-T1 !VEC_MODE! Classic v3 two-leg vector proof"
set "CMD=zig build test-classic-v3 --prefix "!VEC_PREFIX!" --cache-dir "!VEC_CACHE!" -Doptimize=!VEC_MODE! -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose --summary all"
if /I "!VEC_MODE!"=="Debug" set "CMD=zig build test-classic-v3 --prefix "!VEC_PREFIX!" --cache-dir "!VEC_CACHE!" -Doptimize=Debug -Denable_force_down=true -Denable_verbose_detection=true -Denable_trace_lifecycle=true --error-style verbose --summary all"
set "OUT=!VEC_DIR!\classic_v3_unit_tests.txt"
call :run_test_command
exit /b !ERRORLEVEL!

:run_stage5c_w3d_differential
set "MARKER=5C-T2/T4 W3D-owned scalar-v2-v3 differential and selection proof"
echo === !MARKER!
set "DEBLOCK4_PLUGIN_PATH=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_BUILD_ROOT!\ReleaseFast\bin\Deblock4.dll"
set "DEBLOCK4_STAGE5C_INSPECTION_DIR=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\T2_T4_W3D_differential"
set "DEBLOCK4_STAGE5C_EXPECTED_VERSION=!IDENTITY_STRING!"
set "DEBLOCK4_STAGE5C_EXPECTED_V1=x86_64_v1_baseline"
set "DEBLOCK4_STAGE5C_EXPECTED_V2=x86_64_v2_with_sse41"
set "DEBLOCK4_STAGE5C_EXPECTED_V3=x86_64_v3_with_avx2"
set "DEBLOCK4_STAGE5C_RUN_KIND=positive"
set "DEBLOCK4_STAGE5C_REQUIRE_STAGE4C_REGRESSION=1"
call :make_dir "!DEBLOCK4_STAGE5C_INSPECTION_DIR!"
set "CMD=call "!DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER!""
set "OUT=!DEBLOCK4_INSPECTION_DIR!\T2_T4_W3D_differential\runner_output.txt"
call :capture_both
set "DEBLOCK4_STAGE5C_RUN_KIND="
set "DEBLOCK4_STAGE5C_REQUIRE_STAGE4C_REGRESSION="
exit /b !ERRORLEVEL!

:run_stage4c_regression_differential
set "MARKER=4C-T2/T4 retained W3D scalar-v2 regression under the 5C selection surface"
echo === !MARKER!
set "DEBLOCK4_PLUGIN_PATH=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_BUILD_ROOT!\ReleaseFast\bin\Deblock4.dll"
set "DEBLOCK4_STAGE5C_INSPECTION_DIR=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\4C_reexec_T2_T4"
set "DEBLOCK4_STAGE5C_EXPECTED_VERSION=!IDENTITY_STRING!"
set "DEBLOCK4_STAGE5C_EXPECTED_V1=x86_64_v1_baseline"
set "DEBLOCK4_STAGE5C_EXPECTED_V2=x86_64_v2_with_sse41"
set "DEBLOCK4_STAGE5C_EXPECTED_V3=x86_64_v3_with_avx2"
set "DEBLOCK4_STAGE5C_RUN_KIND=stage4c-regression"
call :make_dir "!DEBLOCK4_STAGE5C_INSPECTION_DIR!"
set "CMD=call "!DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER!""
set "OUT=!DEBLOCK4_INSPECTION_DIR!\4C_reexec_T2_T4\runner_output.txt"
call :capture_both
set "DEBLOCK4_STAGE5C_RUN_KIND="
exit /b !ERRORLEVEL!

:inspect_stage4c_v2_object
set "V2_PREFIX=!DEBLOCK4_BUILD_ROOT!\ClassicV2Inspection"
set "V2_CACHE=!DEBLOCK4_CACHE_ROOT!\ClassicV2Inspection"
set "V2_OBJ=!V2_PREFIX!\backend-objects\classic_backend_v2_sse41.obj"
set "V2_DIR=!DEBLOCK4_INSPECTION_DIR!\T3_classic_v2_object"
call :make_dir "!V2_DIR!"
set "MARKER=4C-T3 build Classic named-v2 inspection object"
set "CMD=zig build classic-v2-object --prefix "!V2_PREFIX!" --cache-dir "!V2_CACHE!" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose"
call :run
if not exist "!V2_OBJ!" exit /b 1
set "MARKER=4C-T3 capture Classic v2 object symbols"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!V2_OBJ!""
set "OUT=!V2_DIR!\classic_backend_v2_sse41_symbols.txt"
call :capture
call :find_present "Classic v2 u8 linkage root present" "!OUT!" "deblock4_classic_v2_process_u8"
call :find_present "Classic v2 u16 linkage root present" "!OUT!" "deblock4_classic_v2_process_u16"
set "MARKER=4C-T3 capture Classic v2 object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!V2_OBJ!""
set "OUT=!V2_DIR!\classic_backend_v2_sse41_disasm.txt"
call :capture
call :find_present "Classic v2 vector path uses XMM registers" "!OUT!" "xmm"
call :deny_regex "Classic v2 object has no EVEX" "!OUT!" PAT_EVEX
call :deny_regex "Classic v2 object has no VEX C4" "!OUT!" PAT_VEX2
call :deny_regex "Classic v2 object has no VEX C5" "!OUT!" PAT_VEX3
call :deny_list "Classic v2 object" "!OUT!" "!OUTSIDE!"
call :deny_list "Classic v2 object" "!OUT!" "!V3ONLY!"
call :deny_list "Classic v2 object" "!OUT!" "!AVX512!"
set "BASELINE_DISASM=!DEBLOCK4_INSPECTION_DIR!\S1_frame_path\classic_ar_all_frames_ready_disasm.txt"
call :deny_list "Classic v1 frame-path object" "!BASELINE_DISASM!" "!V2ONLY_A!"
call :deny_list "Classic v1 frame-path object" "!BASELINE_DISASM!" "!V2ONLY_B!"
call :deny_list "Classic v1 frame-path object" "!BASELINE_DISASM!" "!V2ONLY_C!"
call :deny_list "Classic v1 frame-path object" "!BASELINE_DISASM!" "!V2ONLY_D!"
exit /b 0

:inspect_stage5c_v3_object
set "V3_PREFIX=!DEBLOCK4_BUILD_ROOT!\ClassicV3Inspection"
set "V3_CACHE=!DEBLOCK4_CACHE_ROOT!\ClassicV3Inspection"
set "V3_OBJ=!V3_PREFIX!\backend-objects\classic_backend_v3_avx2.obj"
set "V3_DIR=!DEBLOCK4_INSPECTION_DIR!\T3_classic_v3_object"
call :make_dir "!V3_DIR!"
set "MARKER=5C-T3 build Classic named-v3 inspection object"
set "CMD=zig build classic-v3-object --prefix "!V3_PREFIX!" --cache-dir "!V3_CACHE!" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose"
call :run
if not exist "!V3_OBJ!" exit /b 1
set "MARKER=5C-T3 capture Classic v3 object symbols"
set "CMD=dumpbin /NOLOGO /SYMBOLS "!V3_OBJ!""
set "OUT=!V3_DIR!\classic_backend_v3_avx2_symbols.txt"
call :capture
call :find_present "Classic v3 u8 linkage root present" "!OUT!" "deblock4_classic_v3_process_u8"
call :find_present "Classic v3 u16 linkage root present" "!OUT!" "deblock4_classic_v3_process_u16"
set "MARKER=5C-T3 capture Classic v3 object disassembly"
set "CMD=dumpbin /NOLOGO /DISASM:BYTES "!V3_OBJ!""
set "OUT=!V3_DIR!\classic_backend_v3_avx2_disasm.txt"
call :capture
call :find_present "Classic v3 256-bit vector path uses YMM registers" "!OUT!" "ymm"
call :find_present "Classic v3 transition hygiene contains vzeroupper" "!OUT!" "vzeroupper"
call :deny_regex "Classic v3 object has no EVEX" "!OUT!" PAT_EVEX
call :deny_list "Classic v3 object" "!OUT!" "!OUTSIDE!"
call :deny_list "Classic v3 object" "!OUT!" "!AVX512!"
exit /b 0

:run_stage4c_tail_regression
set "PERTURB_DIR=%TEMP%\Deblock4_5C_4C_tail_regression"
if exist "!PERTURB_DIR!" rmdir /s /q "!PERTURB_DIR!"
echo.
echo === 4C-T5 retained one-lane vector-tail regression in a temporary copy
robocopy "!DEBLOCK4_PROJECT_ROOT!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP
set "copy_code=!ERRORLEVEL!"
if !copy_code! GTR 7 (set "MARKER=4C-T5 copy regression tree" & set "CMD=robocopy" & set "exit_code=!copy_code!" & goto :fail)
set "DEBLOCK4_STAGE5C_MUTATE_FILE=!PERTURB_DIR!\src\classic_vector_backend.zig"
set "MUTATE_SCRIPT=%TEMP%\Deblock4_5C_4C_tail_mutate_%RANDOM%_%RANDOM%.py"
>"!MUTATE_SCRIPT!" echo import os
>>"!MUTATE_SCRIPT!" echo from pathlib import Path
>>"!MUTATE_SCRIPT!" echo p = Path(os.environ["DEBLOCK4_STAGE5C_MUTATE_FILE"])
>>"!MUTATE_SCRIPT!" echo data = p.read_bytes()
>>"!MUTATE_SCRIPT!" echo old = b"    storeContiguous(T, L, row_q1, column_start, result.q1);"
>>"!MUTATE_SCRIPT!" echo new = old + b"\r\n    if (L == 1) {\r\n        row_p0[column_start] = row_p0[column_start] ^ 1;\r\n    }"
>>"!MUTATE_SCRIPT!" echo assert data.count(old) == 1
>>"!MUTATE_SCRIPT!" echo p.write_bytes(data.replace(old, new, 1))
set "MARKER=4C-T5 apply retained V1 mutation to temporary copy"
set "CMD=call tools\run_vs.cmd --python-script "!MUTATE_SCRIPT!""
call :run
del /Q "!MUTATE_SCRIPT!" >nul 2>nul
set "OUT=!DEBLOCK4_INSPECTION_DIR!\4C_reexec_T5_mutant_T1_expected_failure.txt"
pushd "!PERTURB_DIR!"
zig build test-classic-v2 --prefix "zig-out\stage_4c_regression_mutant" --cache-dir ".zig-cache\stage_4c_regression_mutant" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose --summary all > "!DEBLOCK4_PROJECT_PREFIX!!OUT!" 2>&1
set "mutant_t1_code=!ERRORLEVEL!"
popd
if "!mutant_t1_code!"=="0" (set "MARKER=4C-T5 retained mutant T1 expected rejection" & set "CMD=zig build test-classic-v2" & set "exit_code=1" & goto :fail)
set "MUTANT_PREFIX=!PERTURB_DIR!\zig-out\stage_4c_regression_mutant_dll"
set "MUTANT_CACHE=!PERTURB_DIR!\.zig-cache\stage_4c_regression_mutant_dll"
pushd "!PERTURB_DIR!"
zig build --prefix "!MUTANT_PREFIX!" --cache-dir "!MUTANT_CACHE!" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose > "!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\4C_reexec_T5_mutant_build.txt" 2>&1
set "mutant_build_code=!ERRORLEVEL!"
popd
if not "!mutant_build_code!"=="0" (set "MARKER=4C-T5 retained mutant production build" & set "CMD=zig build" & set "exit_code=!mutant_build_code!" & goto :fail)
set "DEBLOCK4_PLUGIN_PATH=!MUTANT_PREFIX!\bin\Deblock4.dll"
set "DEBLOCK4_STAGE5C_INSPECTION_DIR=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\4C_reexec_T5_mutant_T2"
set "DEBLOCK4_STAGE5C_EXPECTED_VERSION=!IDENTITY_STRING!"
set "DEBLOCK4_STAGE5C_EXPECTED_V1=x86_64_v1_baseline"
set "DEBLOCK4_STAGE5C_EXPECTED_V2=x86_64_v2_with_sse41"
set "DEBLOCK4_STAGE5C_EXPECTED_V3=x86_64_v3_with_avx2"
set "DEBLOCK4_STAGE5C_RUN_KIND=stage4c-tail-mutant-expected-failure"
call :make_dir "!DEBLOCK4_STAGE5C_INSPECTION_DIR!"
set "OUT=!DEBLOCK4_INSPECTION_DIR!\4C_reexec_T5_mutant_T2\runner_expected_failure.txt"
call "!DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER!" > "!OUT!" 2>&1
set "mutant_t2_code=!ERRORLEVEL!"
type "!OUT!"
set "DEBLOCK4_STAGE5C_RUN_KIND="
if not "!mutant_t2_code!"=="0" (set "MARKER=4C-T5 retained mutant T2 expected rejection" & set "CMD=call W3D Stage 5C differential runner" & set "exit_code=!mutant_t2_code!" & goto :fail)
rmdir /s /q "!PERTURB_DIR!"
if exist "!PERTURB_DIR!" exit /b 1
exit /b 0

rem ============================================================================
rem Stage 5C named-model and live-V1 tail negative controls.
rem ============================================================================

:run_stage5c_named_model_perturbations
set "PERTURB_DIR=%TEMP%\Deblock4_5C_named_model_perturb"
if exist "!PERTURB_DIR!" rmdir /s /q "!PERTURB_DIR!"
echo.
echo === 5C-T5 copy project to temporary named-model perturbation tree
robocopy "!DEBLOCK4_PROJECT_ROOT!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP
set "copy_code=!ERRORLEVEL!"
if !copy_code! GTR 7 (set "MARKER=5C-T5 copy named-model perturbation tree" & set "CMD=robocopy" & set "exit_code=!copy_code!" & goto :fail)
set "MUTATE_SCRIPT=%TEMP%\Deblock4_5C_named_model_mutate_%RANDOM%_%RANDOM%.py"
>"!MUTATE_SCRIPT!" echo import os
>>"!MUTATE_SCRIPT!" echo from pathlib import Path
>>"!MUTATE_SCRIPT!" echo p = Path(os.environ["DEBLOCK4_STAGE5C_MUTATE_FILE"])
>>"!MUTATE_SCRIPT!" echo old = os.environ["DEBLOCK4_STAGE5C_MUTATE_OLD"].encode("ascii")
>>"!MUTATE_SCRIPT!" echo new = os.environ["DEBLOCK4_STAGE5C_MUTATE_NEW"].encode("ascii")
>>"!MUTATE_SCRIPT!" echo data = p.read_bytes()
>>"!MUTATE_SCRIPT!" echo assert data.count(old) == 1
>>"!MUTATE_SCRIPT!" echo p.write_bytes(data.replace(old, new, 1))

set "MARKER=5C-T5 perturb Classic v2 named-model guard"
set "DEBLOCK4_STAGE5C_MUTATE_FILE=!PERTURB_DIR!\src\classic_backend_v2_sse41.zig"
set "DEBLOCK4_STAGE5C_MUTATE_OLD=x86_64_v2.features"
set "DEBLOCK4_STAGE5C_MUTATE_NEW=x86_64_v3.features"
set "CMD=call tools\run_vs.cmd --python-script "!MUTATE_SCRIPT!""
call :run
set "OUT=!DEBLOCK4_INSPECTION_DIR!\T5_v2_named_model_expected_failure.txt"
pushd "!PERTURB_DIR!"
zig build classic-v2-object -Doptimize=ReleaseFast > "!DEBLOCK4_PROJECT_PREFIX!!OUT!" 2>&1
set "v2_perturb_code=!ERRORLEVEL!"
popd
if "!v2_perturb_code!"=="0" (set "MARKER=5C-T5 v2 named-model expected failure" & set "CMD=zig build classic-v2-object" & set "exit_code=1" & goto :fail)
call :find_present "Classic v2 perturbation names feature drift" "!OUT!" "Classic v2 named-model feature drift"

rmdir /s /q "!PERTURB_DIR!"
robocopy "!DEBLOCK4_PROJECT_ROOT!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP
set "copy_code=!ERRORLEVEL!"
if !copy_code! GTR 7 (set "MARKER=5C-T5 recopy named-model perturbation tree" & set "CMD=robocopy" & set "exit_code=!copy_code!" & goto :fail)
set "MARKER=5C-T5 perturb Classic v3 named-model guard"
set "DEBLOCK4_STAGE5C_MUTATE_FILE=!PERTURB_DIR!\src\classic_backend_v3_avx2.zig"
set "DEBLOCK4_STAGE5C_MUTATE_OLD=x86_64_v3.features"
set "DEBLOCK4_STAGE5C_MUTATE_NEW=x86_64_v2.features"
set "CMD=call tools\run_vs.cmd --python-script "!MUTATE_SCRIPT!""
call :run
set "DEBLOCK4_STAGE5C_MUTATE_FILE="
set "DEBLOCK4_STAGE5C_MUTATE_OLD="
set "DEBLOCK4_STAGE5C_MUTATE_NEW="
del /Q "!MUTATE_SCRIPT!" >nul 2>nul
set "OUT=!DEBLOCK4_INSPECTION_DIR!\T5_v3_named_model_expected_failure.txt"
pushd "!PERTURB_DIR!"
zig build classic-v3-object -Doptimize=ReleaseFast > "!DEBLOCK4_PROJECT_PREFIX!!OUT!" 2>&1
set "v3_perturb_code=!ERRORLEVEL!"
popd
if "!v3_perturb_code!"=="0" (set "MARKER=5C-T5 v3 named-model expected failure" & set "CMD=zig build classic-v3-object" & set "exit_code=1" & goto :fail)
call :find_present "Classic v3 perturbation names feature drift" "!OUT!" "Classic v3 named-model feature drift"
rmdir /s /q "!PERTURB_DIR!"
if exist "!PERTURB_DIR!" exit /b 1
exit /b 0

:run_stage5c_tail_perturbation
set "PERTURB_DIR=%TEMP%\Deblock4_5C_tail_perturb"
if exist "!PERTURB_DIR!" rmdir /s /q "!PERTURB_DIR!"
echo.
echo === 5C-T5 copy project to temporary V1-tail perturbation tree
robocopy "!DEBLOCK4_PROJECT_ROOT!" "!PERTURB_DIR!" /E /XD .git .zig-cache zig-out /NFL /NDL /NJH /NJS /NP
set "copy_code=!ERRORLEVEL!"
if !copy_code! GTR 7 (set "MARKER=5C-T5 copy tail perturbation tree" & set "CMD=robocopy" & set "exit_code=!copy_code!" & goto :fail)
set "DEBLOCK4_STAGE5C_MUTATE_FILE=!PERTURB_DIR!\src\classic_vector_backend.zig"
set "MUTATE_SCRIPT=%TEMP%\Deblock4_5C_tail_mutate_%RANDOM%_%RANDOM%.py"
>"!MUTATE_SCRIPT!" echo import os
>>"!MUTATE_SCRIPT!" echo from pathlib import Path
>>"!MUTATE_SCRIPT!" echo p = Path(os.environ["DEBLOCK4_STAGE5C_MUTATE_FILE"])
>>"!MUTATE_SCRIPT!" echo data = p.read_bytes()
>>"!MUTATE_SCRIPT!" echo old = b"    storeContiguous(T, L, row_q1, column_start, result.q1);"
>>"!MUTATE_SCRIPT!" echo new = old + b"\r\n    if (L == 1) {\r\n        row_p0[column_start] = row_p0[column_start] ^ 1;\r\n    }"
>>"!MUTATE_SCRIPT!" echo assert data.count(old) == 1
>>"!MUTATE_SCRIPT!" echo p.write_bytes(data.replace(old, new, 1))
>>"!MUTATE_SCRIPT!" echo print("STAGE_5C_T5_V1_MUTATION_APPLIED")
set "MARKER=5C-T5 apply one-lane V1 mutation to temporary copy"
set "CMD=call tools\run_vs.cmd --python-script "!MUTATE_SCRIPT!""
call :run
del /Q "!MUTATE_SCRIPT!" >nul 2>nul
set "OUT=!DEBLOCK4_INSPECTION_DIR!\T5_v1_mutant_T1_expected_failure.txt"
pushd "!PERTURB_DIR!"
zig build test-classic-v3 --prefix "zig-out\stage_5c_mutant" --cache-dir ".zig-cache\stage_5c_mutant" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose --summary all > "!DEBLOCK4_PROJECT_PREFIX!!OUT!" 2>&1
set "mutant_t1_code=!ERRORLEVEL!"
popd
if "!mutant_t1_code!"=="0" (set "MARKER=5C-T5 mutant T1 expected rejection" & set "CMD=zig build test-classic-v3" & set "exit_code=1" & goto :fail)
type "!OUT!"
set "MUTANT_PREFIX=!PERTURB_DIR!\zig-out\stage_5c_mutant_dll"
set "MUTANT_CACHE=!PERTURB_DIR!\.zig-cache\stage_5c_mutant_dll"
pushd "!PERTURB_DIR!"
zig build --prefix "!MUTANT_PREFIX!" --cache-dir "!MUTANT_CACHE!" -Doptimize=ReleaseFast -Denable_force_down=false -Denable_verbose_detection=false -Denable_trace_lifecycle=false --error-style verbose > "!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\T5_v1_mutant_build.txt" 2>&1
set "mutant_build_code=!ERRORLEVEL!"
popd
if not "!mutant_build_code!"=="0" (set "MARKER=5C-T5 mutant production build" & set "CMD=zig build" & set "exit_code=!mutant_build_code!" & goto :fail)
set "DEBLOCK4_PLUGIN_PATH=!MUTANT_PREFIX!\bin\Deblock4.dll"
set "DEBLOCK4_STAGE5C_INSPECTION_DIR=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\T5_tail_mutant_T2"
set "DEBLOCK4_STAGE5C_EXPECTED_VERSION=!IDENTITY_STRING!"
set "DEBLOCK4_STAGE5C_EXPECTED_V1=x86_64_v1_baseline"
set "DEBLOCK4_STAGE5C_EXPECTED_V2=x86_64_v2_with_sse41"
set "DEBLOCK4_STAGE5C_EXPECTED_V3=x86_64_v3_with_avx2"
set "DEBLOCK4_STAGE5C_RUN_KIND=tail-mutant-expected-failure"
call :make_dir "!DEBLOCK4_STAGE5C_INSPECTION_DIR!"
set "OUT=!DEBLOCK4_INSPECTION_DIR!\T5_tail_mutant_T2\runner_expected_failure.txt"
call "!DEBLOCK4_STAGE5C_DIFFERENTIAL_RUNNER!" > "!OUT!" 2>&1
set "mutant_t2_code=!ERRORLEVEL!"
type "!OUT!"
set "DEBLOCK4_STAGE5C_RUN_KIND="
if not "!mutant_t2_code!"=="0" (set "MARKER=5C-T5 mutant T2 expected rejection" & set "CMD=call W3D Stage 5C differential runner" & set "exit_code=!mutant_t2_code!" & goto :fail)
rmdir /s /q "!PERTURB_DIR!"
if exist "!PERTURB_DIR!" exit /b 1
exit /b 0

:run_stage5c_benchmark
set "MARKER=5C-T6 W3D-owned non-gating benchmark record"
echo === !MARKER!
set "DEBLOCK4_PLUGIN_PATH=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_BUILD_ROOT!\ReleaseFast\bin\Deblock4.dll"
set "DEBLOCK4_STAGE5C_BENCHMARK_DIR=!DEBLOCK4_PROJECT_PREFIX!!DEBLOCK4_INSPECTION_DIR!\T6_benchmark"
set "DEBLOCK4_STAGE5C_EXPECTED_VERSION=!IDENTITY_STRING!"
set "DEBLOCK4_STAGE5C_EXPECTED_V1=x86_64_v1_baseline"
set "DEBLOCK4_STAGE5C_EXPECTED_V2=x86_64_v2_with_sse41"
set "DEBLOCK4_STAGE5C_EXPECTED_V3=x86_64_v3_with_avx2"
call :make_dir "!DEBLOCK4_STAGE5C_BENCHMARK_DIR!"
set "CMD=call "!DEBLOCK4_STAGE5C_BENCHMARK_RUNNER!""
set "OUT=!DEBLOCK4_INSPECTION_DIR!\T6_benchmark\runner_output.txt"
call :capture_both
exit /b !ERRORLEVEL!

rem ============================================================================
rem Static audits.
rem ============================================================================

:audit_stage2_scope
set "MARKER=K1 K24 scalar-only canonical source audit"
echo === !MARKER!
set "CMD=powershell scalar-only source scan"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$files=@('src/classic_scalar_kernel.zig','src/classic_edge_schedule.zig','src/classic_thresholds.zig'); $hits=Select-String -Path $files -SimpleMatch -Pattern '@Vector','@mulAdd'; if($hits){$hits;exit 1}; $kernel=[IO.File]::ReadAllText('src/classic_scalar_kernel.zig'); if(([regex]::Matches($kernel,'pub fn filterEdge\(')).Count -ne 1){exit 2}; Write-Host 'STAGE_2C_SCALAR_CANONICAL_BODY_PASS'"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "MARKER=O-7d no padding resize crop graph audit"
echo === !MARKER!
set "CMD=powershell Classic source graph scan"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$files=@('src/classic_instance_creation.zig','src/classic_ar_all_frames_ready.zig','src/classic_edge_schedule.zig'); $hits=Select-String -Path $files -Pattern '(?i)\b(Point|Crop|resize)\b'; if($hits){$hits;exit 1}; Write-Host 'STAGE_2C_NO_PADDING_GRAPH_PASS'"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "MARKER=K31 byte-row navigation source audit"
echo === !MARKER!
set "CMD=powershell K31 source scan"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$s=[IO.File]::ReadAllText('src/classic_edge_schedule.zig'); if(-not $s.Contains('stride_bytes')){exit 1}; if($s -match 'stride_bytes\s*/' -or $s -match '/\s*@sizeOf'){exit 2}; if(-not $s.Contains('plane.base + y * plane.stride_bytes')){exit 3}; if(-not $s.Contains('@ptrCast(@alignCast(row_bytes))')){exit 4}; Write-Host 'STAGE_2C_K31_BYTE_ROW_PASS'"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "MARKER=D3 O/G crosswalk completeness audit"
echo === !MARKER!
set "CMD=powershell crosswalk identifier scan"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$s=[IO.File]::ReadAllText('tests/Deblock4_Stage_2C_D3_v1_10_O_G_to_Test_Crosswalk.md'); $ids=@('O-1','O-1b','O-1c','O-1d','O-2','O-3','O-4','O-5a','O-5b','O-5c','O-5d','O-6a','O-6b','O-6c','O-6d','O-6e','O-6f','O-7a','O-7b','O-7c','O-7c2','O-7d','O-8a','O-8b','O-8c','O-8d','O-8e','O-8f','O-8g','O-8h','G1','G2','G3','G4','G5','G6','T-S5-1a','T-S5-1b','T-S5-2','T-S5-3','T-S5-4','T-S5-5','K30','K31','H0-H6'); $missing=$ids|Where-Object{-not $s.Contains($_)}; if($missing){$missing;exit 1}; Write-Host 'STAGE_2C_CROSSWALK_COMPLETE_PASS'"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

:compare_release_outputs
set "MARKER=ReleaseSafe versus ReleaseFast production byte identity"
echo === !MARKER!
set "CMD=powershell compare Stage 2C hash markers"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$cases=@('valid_auto','valid_full','valid_coercion','o4_gray8','o5d_gray16','o7_10x10','o7_12x6','o7_6x6','o7_11x7','o5a_yuv420_chroma_o4','o8_yuv420_subset','o8_yuv420p10_subset','o8_yuv444p16_subset','o8_yuv422_v','o8_yuv444_all','o8_rgb_subset','o8_gray10','o8_gray16','strength_zero','sanity','n04'); foreach($c in $cases){$a=[IO.File]::ReadAllText('!DEBLOCK4_INSPECTION_DIR!/ReleaseSafe/classic_'+$c+'.txt');$b=[IO.File]::ReadAllText('!DEBLOCK4_INSPECTION_DIR!/ReleaseFast/classic_'+$c+'.txt');$ma=[regex]::Match($a,'hash=([0-9a-f]{64})');$mb=[regex]::Match($b,'hash=([0-9a-f]{64})');if(-not($ma.Success -and $mb.Success)){Write-Host 'missing hash' $c;exit 2};if($ma.Groups[1].Value -ne $mb.Groups[1].Value){Write-Host 'hash mismatch' $c;exit 1}};Write-Host 'STAGE_2C_RS_RF_BYTE_IDENTITY_PASS'"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
exit /b 0

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
set "CMD=deny mnemonic-token list in %~2"
for %%I in (%~3) do (
    rem Match the decoded mnemonic as a token, not as a substring of another
    rem mnemonic (for example pext must not reject pextrb/pextrw/pextrd,
    rem and movbe must not reject cmovbe).
    findstr /I /R /C:"[ ]%%I[ ]" /C:"[ ]%%I$" "%~2" >nul <nul
    if "!ERRORLEVEL!"=="0" (echo === forbidden %%I & findstr /I /R /C:"[ ]%%I[ ]" /C:"[ ]%%I$" "%~2" <nul & set "exit_code=1" & goto :fail)
)
set "exit_code=0"
exit /b 0

:count_literal_zero_ok
set "COUNT_FILE=%TEMP%\deblock4_2c_literal_count.txt"
findstr /I /C:"%~3" "%~2" > "!COUNT_FILE!" <nul
set "scan_code=!ERRORLEVEL!"
if !scan_code! GEQ 2 (set "MARKER=%~1" & set "CMD=findstr literal count" & set "exit_code=1" & goto :fail)
set /a observed_count=0
for /f "usebackq delims=" %%L in ("!COUNT_FILE!") do set /a observed_count+=1
del /q "!COUNT_FILE!" >nul 2>nul
echo === %~1 observed !observed_count! expected %~4
if not "!observed_count!"=="%~4" (set "MARKER=%~1" & set "CMD=count literal" & set "exit_code=1" & goto :fail)
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
