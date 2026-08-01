@echo on
@setlocal ENABLEEXTENSIONS
@setlocal ENABLEDELAYEDEXPANSION

REM CD into the github root folder

cd /d "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"

REM dir /s /b "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\deliveries\Deblock4_Stage_1C_Phase_2_W3C_delivery_v1_0"

REM use XCOPY on a bit of the extracted delivery zip
REM /E: Copies all subdirectories, including empty ones.
REM /H: Copies hidden and system files (specific to xcopy).
REM /C: Continues copying even if errors occur (specific to xcopy).
REM /I: If the destination folder doesn't exist, it assumes it is a directory and creates it (specific to xcopy).
REM /F: Displays the full source and destination filenames while copying

REM opy the patch from delivery to root
copy /Y "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\deliveries\Deblock4_Stage_1C_Phase_2_W3C_delivery_v1_0\Deblock4_Stage_1C_Phase_2_W3C_v1_0.patch" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\"

REM Copy validation_support folder from delivery to root
xcopy "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\deliveries\Deblock4_Stage_1C_Phase_2_W3C_delivery_v1_0\validation_support" "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\validation_support"  /E /H /C /I /F

REM Apply patch

git status --short
if errorlevel 1 exit /b 1

git apply --check --whitespace=error-all Deblock4_Stage_1C_Phase_2_W3C_v1_0.patch
if errorlevel 1 exit /b 1

git apply Deblock4_Stage_1C_Phase_2_W3C_v1_0.patch
if errorlevel 1 exit /b 1

git -c core.whitespace=cr-at-eol diff --check
if errorlevel 1 exit /b 1

git status --short
if errorlevel 1 exit /b 1


REM Run this as updated in delivery by W3X
REM @echo off
REM setlocal EnableExtensions
REM cd /d "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
REM for %%O in (Debug ReleaseSafe ReleaseFast) do (
REM     echo ================================================================
REM     echo Phase 2 compile + tests: %%O
REM     echo ================================================================
REM     @echo on
REM     zig build --build-file validation_support\build_phase2_validation.zig phase2-test -Doptimize=%%O
REM     if errorlevel 1 exit /b 1
REM     @echo off
REM )
REM for %%O in (Debug ReleaseSafe ReleaseFast) do (
REM     echo ================================================================
REM     echo Existing selftest regression: %%O
REM     echo ================================================================
REM     @echo on
REM     zig build selftest -Doptimize=%%O
REM     if errorlevel 1 exit /b 1
REM     @echo off
REM )
REM @echo on
REM git -c core.whitespace=cr-at-eol diff --check
REM if errorlevel 1 exit /b 1
REM git status --short
REM @echo off
REM exit /b 0

call :do_prep

call .\validation_support\build_1c2_phase2_validation.bat

pause
goto :eof

:do_prep
set "zig_cache=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\.zig-cache"
if exist "!zig_cache!" rmdir /s /Q "!zig_cache!"

set "zig_out=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\zig-out"
if exist "!zig_out!" rmdir /s /Q "!zig_out!"
goto :eof

