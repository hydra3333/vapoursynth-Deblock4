@echo off
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set "STAGE=1B.1"
set "dset=Debug ReleaseSafe ReleaseFast"

REM --------------------------------------------------------------------------------------------
echo.
echo ---------- START Setting up %STAGE% environment ...
echo.
set "current_command=CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4""
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "current_command=CALL ^"C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat^" -arch=amd64 -host_arch=amd64"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

rem VsDevCmd may affect the current directory, so restore it explicitly.
echo.
set "current_command=CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4""
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "current_command=where dumpbin"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

set "current_command=dumpbin /?"
echo !current_command!
!current_command! >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

echo.
echo ---------- END Setting up %STAGE% environment
echo.
REM --------------------------------------------------------------------------------------------

echo.
set "current_command=CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4""
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail

echo.
echo CD
CD
echo.

echo.
echo ***
set "current_command=git status --short"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo.
echo ***
set "current_command=git rev-parse --short HEAD"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

if exist ".\.zig-cache" (
    set "current_command=RMDIR /S /Q ".\.zig-cache""
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    if exist ".\.zig-cache" (
        set "current_command=Verify removal of .\.zig-cache"
        set "exit_code=1"
        goto :fail
    )
) else (
    echo Project-local Zig cache does not exist: .\.zig-cache
)
if exist ".\zig-out" (
    set "current_command=RMDIR /S /Q ".\zig-out""
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    if exist ".\zig-out" (
        set "current_command=Verify removal of .\zig-out"
        set "exit_code=1"
        goto :fail
    )
) else (
    echo Zig installation output does not exist: .\zig-out
)

echo.
echo *** START OF STAGE %STAGE% MODES: %dset%
for %%b in (%dset%) do (
    echo.
    echo ------------------------------------------------------------------------------------
    echo --- START STAGE %STAGE% mode "%%b"

    echo ***
    set "current_command=zig build -Doptimize=%%b"
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    echo ***

    echo ***
    set "current_command=zig build run -Doptimize=%%b"
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    echo ***

    echo ***
    set "current_command=zig build vs-header-run -Doptimize=%%b"
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    echo ***

    echo ***
    set "current_command=zig build test -Doptimize=%%b"
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    echo ***

    echo ***
    set "current_command=zig-out\bin\deblock4_dll_smoke_test.exe"
    echo !current_command!
    !current_command!
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
    echo ***

    echo --- END STAGE %STAGE% mode "%%b": PASS
    echo ------------------------------------------------------------------------------------
    echo.
)
echo *** END OF STAGE %STAGE% MODES: %dset%

echo.
echo ***
set "current_command=git diff --check"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo ***
set "current_command=git status --short"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET: PASS
echo ================================================================================
echo.

pause
exit /b 0

:fail
echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET: FAIL
echo Failed command: !current_command!
echo Exit code: !exit_code!
echo ================================================================================
echo.
pause
exit /b !exit_code!
