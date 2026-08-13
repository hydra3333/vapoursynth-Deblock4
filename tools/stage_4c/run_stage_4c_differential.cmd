@echo off
setlocal enableextensions
rem run_stage_4c_differential.cmd - W3D-owned Stage 4C differential runner.
rem Join contract per Deblock4_Stage_4C_Implementation_Delivery_Manifest s4:
rem invoked with NO arguments; reads DEBLOCK4_* environment variables set by
rem build_4C_v1.bat; RUN_KIND selects acceptance semantics.
rem Plain CMD. No PowerShell. No git. No repository operation.

set "HERE=%~dp0"
set "VPY=%HERE%stage_4c_scalar_v2_diff.py"
set "RUNVS=%HERE%..\run_vs.cmd"

if not exist "%VPY%" echo STAGE_4C_RUNNER_FAIL missing %VPY% & exit /b 4
if not exist "%RUNVS%" echo STAGE_4C_RUNNER_FAIL missing %RUNVS% & exit /b 4
if "%DEBLOCK4_PLUGIN_PATH%"=="" echo STAGE_4C_RUNNER_FAIL DEBLOCK4_PLUGIN_PATH unset & exit /b 4
if "%DEBLOCK4_STAGE4C_INSPECTION_DIR%"=="" echo STAGE_4C_RUNNER_FAIL inspection dir unset & exit /b 4
if "%DEBLOCK4_STAGE4C_EXPECTED_VERSION%"=="" echo STAGE_4C_RUNNER_FAIL expected version unset & exit /b 4
if "%DEBLOCK4_STAGE4C_EXPECTED_V1%"=="" echo STAGE_4C_RUNNER_FAIL expected v1 unset & exit /b 4
if "%DEBLOCK4_STAGE4C_EXPECTED_V2%"=="" echo STAGE_4C_RUNNER_FAIL expected v2 unset & exit /b 4
if "%DEBLOCK4_STAGE4C_RUN_KIND%"=="" set "DEBLOCK4_STAGE4C_RUN_KIND=positive"

echo === Stage 4C differential runner: kind=%DEBLOCK4_STAGE4C_RUN_KIND%
call "%RUNVS%" --python-script "%VPY%"
set "RC=%ERRORLEVEL%"
echo === differential python exit code %RC%

if /I "%DEBLOCK4_STAGE4C_RUN_KIND%"=="tail-mutant-expected-failure" goto :mutant

rem ---- positive kind: require clean pass -------------------------------
if not "%RC%"=="0" (
    echo STAGE_4C_DIFFERENTIAL_RUNNER_FAIL positive run returned %RC%
    exit /b 1
)
echo STAGE_4C_DIFFERENTIAL_RUNNER_PASS
exit /b 0

:mutant
rem ---- mutant kind: require DIFFERENCE detection, exit code 2 exactly --
if "%RC%"=="2" (
    echo STAGE_4C_TAIL_MUTANT_CORRECTLY_REJECTED
    exit /b 0
)
if "%RC%"=="0" (
    echo STAGE_4C_TAIL_MUTANT_NOT_DETECTED differential passed a corrupted DLL
    exit /b 1
)
echo STAGE_4C_TAIL_MUTANT_WRONG_FAILURE_CLASS exit code %RC% is not a difference detection
exit /b 1
