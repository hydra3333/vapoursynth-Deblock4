@echo off
setlocal EnableExtensions DisableDelayedExpansion

if not defined DEBLOCK4_REFERENCE_SOURCE_ROOT goto :missing_source
if not defined DEBLOCK4_VS_INCLUDE_ROOT goto :missing_headers
if not defined DEBLOCK4_PLUGIN_PATH goto :missing_plugin
if not defined DEBLOCK4_HOLYWU_INSPECTION_DIR set "DEBLOCK4_HOLYWU_INSPECTION_DIR=%CD%\zig-out\inspection_2C\holywu_reference"
set "DEBLOCK4_INSPECTION_DIR=%DEBLOCK4_HOLYWU_INSPECTION_DIR%"
if not exist "%DEBLOCK4_INSPECTION_DIR%" mkdir "%DEBLOCK4_INSPECTION_DIR%"

set "DEBLOCK4_HOLYWU_BUILD_LOG=%DEBLOCK4_INSPECTION_DIR%\build.log"
call "%~dp0build_holywu_r9_scalar.cmd" ^
  "%DEBLOCK4_REFERENCE_SOURCE_ROOT%" ^
  "%DEBLOCK4_VS_INCLUDE_ROOT%" ^
  "%DEBLOCK4_INSPECTION_DIR%" > "%DEBLOCK4_HOLYWU_BUILD_LOG%" 2>&1
set "DEBLOCK4_HOLYWU_BUILD_EXIT=%ERRORLEVEL%"
type "%DEBLOCK4_HOLYWU_BUILD_LOG%"
if not "%DEBLOCK4_HOLYWU_BUILD_EXIT%"=="0" exit /b %DEBLOCK4_HOLYWU_BUILD_EXIT%

set "DEBLOCK4_HOLYWU_PLUGIN_PATH=%DEBLOCK4_INSPECTION_DIR%\holywu_deblock_r9_scalar.dll"
set "DEBLOCK4_HOLYWU_RECORD_PATH=%DEBLOCK4_INSPECTION_DIR%\reference-build-record.preliminary.json"
set "DEBLOCK4_HOLYWU_COMPLETED_RECORD_PATH=%DEBLOCK4_INSPECTION_DIR%\reference-build-record.completed.json"

call :run_mode guard_selftests
if errorlevel 1 exit /b 1
call :run_mode sentinels
if errorlevel 1 exit /b 1
call :run_mode corpus
if errorlevel 1 exit /b 1

echo STAGE_2C_HOLYWU_REFERENCE_ALL_PASS
exit /b 0

:run_mode
set "DEBLOCK4_HOLYWU_MODE=%~1"
set "DEBLOCK4_HOLYWU_MODE_LOG=%DEBLOCK4_INSPECTION_DIR%\%~1.log"
call "%~dp0..\run_vs.cmd" --python-script "%~dp0stage_2c_holywu_diff.vpy" > "%DEBLOCK4_HOLYWU_MODE_LOG%" 2>&1
set "DEBLOCK4_HOLYWU_MODE_EXIT=%ERRORLEVEL%"
type "%DEBLOCK4_HOLYWU_MODE_LOG%"
if not "%DEBLOCK4_HOLYWU_MODE_EXIT%"=="0" exit /b %DEBLOCK4_HOLYWU_MODE_EXIT%
exit /b 0

:missing_source
echo ERROR: DEBLOCK4_REFERENCE_SOURCE_ROOT must name the pinned holywu_r9 directory.
exit /b 2
:missing_headers
echo ERROR: DEBLOCK4_VS_INCLUDE_ROOT must contain VapourSynth4.h and VSHelper4.h.
exit /b 2
:missing_plugin
echo ERROR: DEBLOCK4_PLUGIN_PATH must name the Stage 2C Deblock4 DLL.
exit /b 2
