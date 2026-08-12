@echo off
setlocal EnableExtensions DisableDelayedExpansion

if "%~1"=="" goto :usage
if "%~2"=="" goto :usage
if "%~3"=="" goto :usage

set "REFERENCE_SOURCE_ROOT=%~f1"
set "VAPOURSYNTH_INCLUDE_ROOT=%~f2"
set "OUTPUT_ROOT=%~f3"

set "EXPECTED_DEBLOCK_CPP=600585ee46c783db5bc47ea22fcaadbbef48cd60caa8bf850e44a40b0de86367"
set "EXPECTED_DEBLOCK_H=6d59551e80b1f2e6ea246eb07fa09558c62fae17e2cfa83907e4f70aaf4b7cba"
set "EXPECTED_DEBLOCK_SSE4_CPP=43249d76636f8255f9c40ed6b4b3bd45629517d30a10b0d6c98c38d05479c62e"
set "EXPECTED_LICENSE=39db8f9acf036595a2566ea3fe560bc7bd65d8749f088e0f4a4ef2f8a6cb4b34"

where cl.exe >nul 2>nul
if errorlevel 1 (
    echo ERROR: cl.exe is not on PATH; run from an x64 MSVC developer prompt.
    exit /b 2
)
where link.exe >nul 2>nul
if errorlevel 1 (
    echo ERROR: link.exe is not on PATH; run from an x64 MSVC developer prompt.
    exit /b 2
)
where certutil.exe >nul 2>nul
if errorlevel 1 (
    echo ERROR: certutil.exe is not on PATH.
    exit /b 2
)

if not exist "%REFERENCE_SOURCE_ROOT%\SHA256SUMS.txt" (
    echo ERROR: missing SHA256SUMS.txt: "%REFERENCE_SOURCE_ROOT%\SHA256SUMS.txt"
    exit /b 2
)
if not exist "%REFERENCE_SOURCE_ROOT%\deblock.cpp" (
    echo ERROR: missing pinned source: "%REFERENCE_SOURCE_ROOT%\deblock.cpp"
    exit /b 2
)
if not exist "%REFERENCE_SOURCE_ROOT%\deblock.h" (
    echo ERROR: missing pinned source: "%REFERENCE_SOURCE_ROOT%\deblock.h"
    exit /b 2
)
if not exist "%REFERENCE_SOURCE_ROOT%\deblock_sse4.cpp" (
    echo ERROR: missing pinned source: "%REFERENCE_SOURCE_ROOT%\deblock_sse4.cpp"
    exit /b 2
)
if not exist "%REFERENCE_SOURCE_ROOT%\LICENSE" (
    echo ERROR: missing pinned source: "%REFERENCE_SOURCE_ROOT%\LICENSE"
    exit /b 2
)
if not exist "%VAPOURSYNTH_INCLUDE_ROOT%\VapourSynth4.h" (
    echo ERROR: missing header: "%VAPOURSYNTH_INCLUDE_ROOT%\VapourSynth4.h"
    exit /b 2
)
if not exist "%VAPOURSYNTH_INCLUDE_ROOT%\VSHelper4.h" (
    echo ERROR: missing header: "%VAPOURSYNTH_INCLUDE_ROOT%\VSHelper4.h"
    exit /b 2
)

echo === H0 verify pinned HolyWu source hashes before build
call :verify_hash "%REFERENCE_SOURCE_ROOT%\deblock.cpp" "%EXPECTED_DEBLOCK_CPP%" PRE_DEBLOCK_CPP
if errorlevel 1 exit /b 1
call :verify_hash "%REFERENCE_SOURCE_ROOT%\deblock.h" "%EXPECTED_DEBLOCK_H%" PRE_DEBLOCK_H
if errorlevel 1 exit /b 1
call :verify_hash "%REFERENCE_SOURCE_ROOT%\deblock_sse4.cpp" "%EXPECTED_DEBLOCK_SSE4_CPP%" PRE_DEBLOCK_SSE4_CPP
if errorlevel 1 exit /b 1
call :verify_hash "%REFERENCE_SOURCE_ROOT%\LICENSE" "%EXPECTED_LICENSE%" PRE_LICENSE
if errorlevel 1 exit /b 1

if not exist "%OUTPUT_ROOT%" mkdir "%OUTPUT_ROOT%"
if errorlevel 1 (
    echo ERROR: failed to create output directory: "%OUTPUT_ROOT%"
    exit /b 1
)

set "WORKSPACE=%OUTPUT_ROOT%\temporary_build_workspace"
if exist "%WORKSPACE%" rmdir /s /q "%WORKSPACE%"
if exist "%WORKSPACE%" (
    echo ERROR: failed to remove old workspace: "%WORKSPACE%"
    exit /b 1
)
mkdir "%WORKSPACE%"
if errorlevel 1 (
    echo ERROR: failed to create workspace: "%WORKSPACE%"
    exit /b 1
)

set "DLL=%OUTPUT_ROOT%\holywu_deblock_r9_scalar.dll"
set "OBJ=%WORKSPACE%\deblock.obj"
set "COMPILE_PDB=%WORKSPACE%\holywu_compile.pdb"
set "IMPLIB=%WORKSPACE%\holywu_deblock_r9_scalar.lib"
set "LINK_PDB=%WORKSPACE%\holywu_deblock_r9_scalar.pdb"
set "SRC=%REFERENCE_SOURCE_ROOT%\deblock.cpp"

echo === H0 build HolyWu r9 scalar reference from deblock.cpp only
cl.exe /nologo /std:c++17 /O2 /EHsc /MD /LD /W3 /I"%VAPOURSYNTH_INCLUDE_ROOT%" /Fo"%OBJ%" /Fd"%COMPILE_PDB%" "%SRC%" /link /NOLOGO /OUT:"%DLL%" /IMPLIB:"%IMPLIB%" /PDB:"%LINK_PDB%"
set "BUILD_EXIT=%ERRORLEVEL%"
if not "%BUILD_EXIT%"=="0" (
    echo ERROR: HolyWu scalar reference build failed with exit %BUILD_EXIT%.
    exit /b %BUILD_EXIT%
)
if not exist "%DLL%" (
    echo ERROR: reference DLL was not produced: "%DLL%"
    exit /b 1
)

echo === H0 re-verify pinned HolyWu source hashes after build
call :verify_hash "%REFERENCE_SOURCE_ROOT%\deblock.cpp" "%EXPECTED_DEBLOCK_CPP%" POST_DEBLOCK_CPP
if errorlevel 1 exit /b 1
call :verify_hash "%REFERENCE_SOURCE_ROOT%\deblock.h" "%EXPECTED_DEBLOCK_H%" POST_DEBLOCK_H
if errorlevel 1 exit /b 1
call :verify_hash "%REFERENCE_SOURCE_ROOT%\deblock_sse4.cpp" "%EXPECTED_DEBLOCK_SSE4_CPP%" POST_DEBLOCK_SSE4_CPP
if errorlevel 1 exit /b 1
call :verify_hash "%REFERENCE_SOURCE_ROOT%\LICENSE" "%EXPECTED_LICENSE%" POST_LICENSE
if errorlevel 1 exit /b 1

if /I not "%PRE_DEBLOCK_CPP%"=="%POST_DEBLOCK_CPP%" (
    echo ERROR: deblock.cpp changed during reference build.
    exit /b 1
)
if /I not "%PRE_DEBLOCK_H%"=="%POST_DEBLOCK_H%" (
    echo ERROR: deblock.h changed during reference build.
    exit /b 1
)
if /I not "%PRE_DEBLOCK_SSE4_CPP%"=="%POST_DEBLOCK_SSE4_CPP%" (
    echo ERROR: deblock_sse4.cpp changed during reference build.
    exit /b 1
)
if /I not "%PRE_LICENSE%"=="%POST_LICENSE%" (
    echo ERROR: LICENSE changed during reference build.
    exit /b 1
)

call :hash_file "%VAPOURSYNTH_INCLUDE_ROOT%\VapourSynth4.h" HASH_VS4
if errorlevel 1 exit /b 1
call :hash_file "%VAPOURSYNTH_INCLUDE_ROOT%\VSHelper4.h" HASH_VSH4
if errorlevel 1 exit /b 1
call :hash_file "%DLL%" HASH_DLL
if errorlevel 1 exit /b 1

set "CL_PATH="
for /f "delims=" %%P in ('where cl.exe 2^>nul') do if not defined CL_PATH set "CL_PATH=%%P"
if not defined CL_PATH (
    echo ERROR: could not resolve cl.exe path.
    exit /b 1
)
set "LINK_PATH="
for /f "delims=" %%P in ('where link.exe 2^>nul') do if not defined LINK_PATH set "LINK_PATH=%%P"
if not defined LINK_PATH (
    echo ERROR: could not resolve link.exe path.
    exit /b 1
)

set "CL_VERSION="
for /f "delims=" %%V in ('cl.exe 2^>^&1') do if not defined CL_VERSION set "CL_VERSION=%%V"
if not defined CL_VERSION set "CL_VERSION=UNKNOWN"
set "LINK_VERSION="
for /f "delims=" %%V in ('link.exe 2^>^&1') do if not defined LINK_VERSION set "LINK_VERSION=%%V"
if not defined LINK_VERSION set "LINK_VERSION=UNKNOWN"
set "OS_VERSION="
for /f "delims=" %%V in ('ver') do set "OS_VERSION=%%V"
if not defined OS_VERSION set "OS_VERSION=UNKNOWN"

set "CL_PATH_JSON=%CL_PATH:\=\\%"
set "LINK_PATH_JSON=%LINK_PATH:\=\\%"
set "VS4_JSON=%VAPOURSYNTH_INCLUDE_ROOT:\=\\%\\VapourSynth4.h"
set "VSH4_JSON=%VAPOURSYNTH_INCLUDE_ROOT:\=\\%\\VSHelper4.h"
set "DLL_JSON=%DLL:\=\\%"
set "VS_INCLUDE_JSON=%VAPOURSYNTH_INCLUDE_ROOT:\=\\%"
set "OBJ_JSON=%OBJ:\=\\%"
set "COMPILE_PDB_JSON=%COMPILE_PDB:\=\\%"
set "SRC_JSON=%SRC:\=\\%"
set "IMPLIB_JSON=%IMPLIB:\=\\%"
set "LINK_PDB_JSON=%LINK_PDB:\=\\%"

set "RECORD=%OUTPUT_ROOT%\reference-build-record.preliminary.json"
> "%RECORD%" (
echo {
echo   "schema": "deblock4-stage-2c-holywu-reference-build-record-v1",
echo   "completion_state": "built-awaiting-sentinel-validation",
echo   "os": "%OS_VERSION%",
echo   "process_architecture": "%PROCESSOR_ARCHITECTURE%",
echo   "compiler_path": "%CL_PATH_JSON%",
echo   "compiler_version": "%CL_VERSION%",
echo   "linker_path": "%LINK_PATH_JSON%",
echo   "linker_version": "%LINK_VERSION%",
echo   "cpp_language_mode": "c++17",
echo   "optimisation_flags": ["/O2"],
echo   "floating_point_flags": ["MSVC default; integer-only comparison domain"],
echo   "preprocessor_definitions": ["DEBLOCK_X86 ABSENT"],
echo   "complete_compile_link_command": "cl.exe /nologo /std:c++17 /O2 /EHsc /MD /LD /W3 /I\"%VS_INCLUDE_JSON%\" /Fo\"%OBJ_JSON%\" /Fd\"%COMPILE_PDB_JSON%\" \"%SRC_JSON%\" /link /NOLOGO /OUT:\"%DLL_JSON%\" /IMPLIB:\"%IMPLIB_JSON%\" /PDB:\"%LINK_PDB_JSON%\"",
echo   "exact_source_files": ["deblock.cpp", "deblock.h"],
echo   "compilation_units": ["deblock.cpp"],
echo   "included_project_headers": ["deblock.h"],
echo   "pinned_source_hashes": {
echo     "deblock.cpp": "%PRE_DEBLOCK_CPP%",
echo     "deblock.h": "%PRE_DEBLOCK_H%",
echo     "deblock_sse4.cpp": "%PRE_DEBLOCK_SSE4_CPP%",
echo     "LICENSE": "%PRE_LICENSE%"
echo   },
echo   "post_build_source_hashes": {
echo     "deblock.cpp": "%POST_DEBLOCK_CPP%",
echo     "deblock.h": "%POST_DEBLOCK_H%",
echo     "deblock_sse4.cpp": "%POST_DEBLOCK_SSE4_CPP%",
echo     "LICENSE": "%POST_LICENSE%"
echo   },
echo   "vapoursynth_api_contract": "4.0 (no VS_USE_API_41/42 preprocessor definition)",
echo   "vapoursynth_headers": {
echo     "VapourSynth4_h": {"path": "%VS4_JSON%", "sha256": "%HASH_VS4%"},
echo     "VSHelper4_h": {"path": "%VSH4_JSON%", "sha256": "%HASH_VSH4%"}
echo   },
echo   "reference_plugin": {
echo     "id": "com.holywu.deblock",
echo     "namespace": "deblock",
echo     "version": "r9 / plugin version 9.0",
echo     "dll_path": "%DLL_JSON%",
echo     "dll_sha256": "%HASH_DLL%"
echo   },
echo   "vapoursynth_runtime_version": "TO_BE_RECORDED_BY_SENTINEL_RUN",
echo   "mxcsr_fp_environment": "NOT APPLICABLE: Stage 2C H5 comparison domain is integer-only",
echo   "sentinel_observations": []
echo }
)
if errorlevel 1 (
    echo ERROR: failed to write preliminary reference-build record.
    exit /b 1
)
if not exist "%RECORD%" (
    echo ERROR: preliminary reference-build record was not produced.
    exit /b 1
)

echo STAGE_2C_HOLYWU_BUILD_PASS dll=%DLL% record=%RECORD% sha256=%HASH_DLL%
exit /b 0

:verify_hash
call :hash_file "%~1" ACTUAL_HASH
if errorlevel 1 exit /b 1
if /I not "%ACTUAL_HASH%"=="%~2" (
    echo ERROR: pinned source hash mismatch: "%~1"
    echo expected=%~2
    echo actual=%ACTUAL_HASH%
    exit /b 1
)
set "%~3=%ACTUAL_HASH%"
exit /b 0

:hash_file
set "HASH_VALUE="
set "HASH_TMP=%TEMP%\deblock4_stage2c_hash_%RANDOM%_%RANDOM%.txt"
certutil.exe -hashfile "%~1" SHA256 > "%HASH_TMP%" 2>&1
set "HASH_EXIT=%ERRORLEVEL%"
if not "%HASH_EXIT%"=="0" (
    type "%HASH_TMP%"
    del /q "%HASH_TMP%" >nul 2>nul
    echo ERROR: certutil hash failed for "%~1" with exit %HASH_EXIT%.
    exit /b %HASH_EXIT%
)
for /f "usebackq skip=1 tokens=1" %%H in ("%HASH_TMP%") do if not defined HASH_VALUE set "HASH_VALUE=%%H"
del /q "%HASH_TMP%" >nul 2>nul
if not defined HASH_VALUE (
    echo ERROR: could not parse SHA256 for "%~1".
    exit /b 1
)
set "%~2=%HASH_VALUE%"
exit /b 0

:usage
echo Usage: %~nx0 ^<holywu_r9_source_dir^> ^<vapoursynth_include_dir^> ^<output_dir^>
exit /b 2
