@echo off
setlocal enableextensions
rem run_stage_5c_benchmark.cmd - W3D-owned Stage 5C NON-GATING benchmark runner.
rem Join contract per Deblock4_Stage_5C_W3C_Delivery_Manifest s4: invoked with
rem NO arguments; reads DEBLOCK4_* environment variables set by build_5C_v1.bat.
rem Exit 0 means the required raw numbers were RECORDED. No speed threshold
rem exists anywhere (S5C-3 / 5C-RAT-4).
rem Plain CMD. No PowerShell. No git. No repository operation.

set "HERE=%~dp0"
set "PY=%HERE%stage_5c_benchmark.py"
set "RUNVS=%HERE%..\run_vs.cmd"

if not exist "%PY%" echo STAGE_5C_BENCH_FAIL missing %PY% & exit /b 4
if not exist "%RUNVS%" echo STAGE_5C_BENCH_FAIL missing %RUNVS% & exit /b 4
if "%DEBLOCK4_PLUGIN_PATH%"=="" echo STAGE_5C_BENCH_FAIL DEBLOCK4_PLUGIN_PATH unset & exit /b 4
if "%DEBLOCK4_STAGE5C_BENCHMARK_DIR%"=="" echo STAGE_5C_BENCH_FAIL benchmark dir unset & exit /b 4
if "%DEBLOCK4_STAGE5C_EXPECTED_VERSION%"=="" echo STAGE_5C_BENCH_FAIL expected version unset & exit /b 4
if "%DEBLOCK4_STAGE5C_EXPECTED_V1%"=="" echo STAGE_5C_BENCH_FAIL expected v1 unset & exit /b 4
if "%DEBLOCK4_STAGE5C_EXPECTED_V2%"=="" echo STAGE_5C_BENCH_FAIL expected v2 unset & exit /b 4
if "%DEBLOCK4_STAGE5C_EXPECTED_V3%"=="" echo STAGE_5C_BENCH_FAIL expected v3 unset & exit /b 4

echo === Stage 5C benchmark runner (non-gating record)
call "%RUNVS%" --python-script "%PY%"
set "RC=%ERRORLEVEL%"
echo === benchmark python exit code %RC%
if not "%RC%"=="0" (
    echo STAGE_5C_BENCHMARK_RUNNER_FAIL numbers were not recorded, code %RC%
    exit /b 1
)
echo STAGE_5C_BENCHMARK_RUNNER_PASS raw numbers recorded
exit /b 0
