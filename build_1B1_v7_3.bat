@echo off
@setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set "STAGE=1B.1 v1.7"
set "dset=Debug ReleaseSafe ReleaseFast"

REM --------------------------------------------------------------------------------------------
echo.
echo ---------- START Setting up %STAGE% environment ...
echo.
echo ***
set "current_command=CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4""
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo ***
set "current_command=CALL "C:\Program Files\Microsoft Visual Studio\18\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

rem VsDevCmd may affect the current directory, so restore it explicitly.
echo.
echo ***
set "current_command=CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4""
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo ***
set "current_command=where dumpbin"
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

rem `where dumpbin` is the environment-resolution gate. DUMPBIN help may
rem return tool-specific nonzero codes even when the tool is available.

echo.
echo ---------- END Setting up %STAGE% environment
echo.
REM --------------------------------------------------------------------------------------------

echo.
echo ***
set "current_command=CD /D "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4""
echo !current_command!
!current_command!
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo.
echo ***
echo CD
CD
echo ***
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
    echo ***
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
    echo ***
) else (
    echo ***
    echo Project-local Zig cache does not exist: .\.zig-cache
    echo ***
)
if exist ".\zig-out" (
    echo ***
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
    echo ***
) else (
    echo ***
    echo Zig installation output does not exist: .\zig-out
    echo ***
)

REM --------------------------------------------------------------------------------------------
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

    echo ***
    set "current_command=zig build backend-isolation-run -Doptimize=%%b"
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
REM --------------------------------------------------------------------------------------------

echo.
echo ------------------------------------------------------------------------------------
echo Commencing ReleaseFast dumpbin proof gates
echo ------------------------------------------------------------------------------------
echo.

echo ***
set "inspection_dir=zig-out\inspection"
if not exist "!inspection_dir!" (
    set "current_command=Create !inspection_dir!"
    echo MD "!inspection_dir!"
    MD "!inspection_dir!"
    set "exit_code=!ERRORLEVEL!"
    if not "!exit_code!"=="0" goto :fail
)
echo ***

set "exports_file=!inspection_dir!\Deblock4_exports.txt"
set "sse41_symbols_file=!inspection_dir!\deblock4_backend_probe_sse41_symbols.txt"
set "avx2_symbols_file=!inspection_dir!\deblock4_backend_probe_avx2_symbols.txt"
set "disasm_file=!inspection_dir!\Deblock4_disasm.txt"

echo.
echo ***
set "current_command=dumpbin /NOLOGO /EXPORTS zig-out\bin\Deblock4.dll"
echo !current_command!
!current_command! > "!exports_file!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo.
echo TYPE "!exports_file!"
TYPE "!exports_file!"
echo ***

echo.
echo ***
set "current_command=Verify root inversion preserved export deblock4_build_probe_value"
set "current_commandx_zzz=findstr /C:"deblock4_build_probe_value" "!exports_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo.
echo ***
set "current_command=Verify required export deblock4_backend_probe_generic_marker"
set "current_commandx_zzz=findstr /C:"deblock4_backend_probe_generic_marker" "!exports_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo.
echo ***
set "current_command=Verify required export deblock4_backend_probe_scalar_marker"
set "current_commandx_zzz=findstr /C:"deblock4_backend_probe_scalar_marker" "!exports_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo ***

echo.
echo ***
set "current_command=Verify gated export deblock4_backend_probe_sse41_marker is absent"
set "current_commandx_zzz=findstr /C:"deblock4_backend_probe_sse41_marker" "!exports_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
echo ***

echo.
echo ***
set "current_command=Verify gated export deblock4_backend_probe_avx2_marker is absent"
set "current_commandx_zzz=findstr /C:"deblock4_backend_probe_avx2_marker" "!exports_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
echo ***

echo.
echo ***
set "current_command=Verify internal anchor storage is absent from the export table"
set "current_commandx_zzz=findstr /C:"sse41_marker_anchor" /C:"avx2_marker_anchor" /C:"marker_anchor" "!exports_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
echo ***

echo.
echo *********************************************************************
set "exit_code=0"
echo Existing and backend export-table gates: PASS
echo *********************************************************************
echo.

echo ***
set "current_command=dumpbin /NOLOGO /SYMBOLS zig-out\backend-objects\deblock4_backend_probe_sse41.obj"
echo !current_command! pipe "!sse41_symbols_file!"
!current_command! > "!sse41_symbols_file!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo.
echo TYPE "!sse41_symbols_file!"
TYPE "!sse41_symbols_file!"
echo ***

echo.
echo ***
set "current_command=Verify SSE4.1 marker is defined on a SECTn symbol line"
set "current_commandx_zzz=findstr /R /C:"SECT[0-9A-F][0-9A-F]*.*deblock4_backend_probe_sse41_marker" "!sse41_symbols_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
rem Storage class may be Static or External. SECTn, rather than UNDEF, proves
rem that the marker is defined in this object.
echo ***

echo.
echo ***
set "current_command=Verify SSE4.1 object .text section length is non-zero"
set "current_commandx_zzz=findstr /R /C:"^[ ]*0 [.]text" "!sse41_symbols_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    rem A "0 .text" summary line means the object has no emitted code.
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
echo ***

echo.
echo *********************************************************************
set "exit_code=0"
echo SSE4.1 emitted-and-defined function gates: PASS
echo *********************************************************************
echo.

echo ***
set "current_command=dumpbin /NOLOGO /SYMBOLS zig-out\backend-objects\deblock4_backend_probe_avx2.obj"
echo !current_command! pipe "!avx2_symbols_file!"
!current_command! > "!avx2_symbols_file!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo.
echo TYPE "!avx2_symbols_file!"
TYPE "!avx2_symbols_file!"
echo ***

echo.
echo ***
set "current_command=Verify AVX2 marker is defined on a SECTn symbol line"
set "current_commandx_zzz=findstr /R /C:"SECT[0-9A-F][0-9A-F]*.*deblock4_backend_probe_avx2_marker" "!avx2_symbols_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
rem Storage class may be Static or External. SECTn, rather than UNDEF, proves
rem that the marker is defined in this object.
echo ***

echo.
echo ***
set "current_command=Verify AVX2 object .text section length is non-zero"
set "current_commandx_zzz=findstr /R /C:"^[ ]*0 [.]text" "!avx2_symbols_file!""
echo !current_commandx_zzz!
!current_commandx_zzz! >nul
set "exit_code=!ERRORLEVEL!"
if "!exit_code!"=="0" (
    rem A "0 .text" summary line means the object has no emitted code.
    set "exit_code=1"
    goto :fail
)
if not "!exit_code!"=="1" goto :fail
set "exit_code=0"
echo ***

echo.
echo *********************************************************************
set "exit_code=0"
echo AVX2 emitted-and-defined function gates: PASS
echo *********************************************************************
echo.

echo ***
set "current_command=dumpbin /NOLOGO /DISASM zig-out\bin\Deblock4.dll"
echo !current_command! pipe "!disasm_file!"
!current_command! > "!disasm_file!"
set "exit_code=!ERRORLEVEL!"
if not "!exit_code!"=="0" goto :fail
echo.
echo === Supplementary disassembly saved to "!disasm_file!"
echo.
echo ***

echo.
echo ------------------------------------------------------------------------------------
echo Finished ReleaseFast dumpbin proof gates: PASS
echo ------------------------------------------------------------------------------------
echo.

echo.
echo ------------------------------------------------------------------------------------
echo Commencing override-rejection proof gates
echo ------------------------------------------------------------------------------------
echo.

echo ***
set "current_command=zig build -Doptimize=ReleaseFast -Dcpu=native (expected rejection)"
set "current_command_zig=zig build -Doptimize=ReleaseFast -Dcpu=native"
echo !current_command_zig!
!current_command_zig!
set "exit_code=!ERRORLEVEL!"
echo exit_code = "!exit_code!"
if "!exit_code!"=="0" (
    set "current_command=Verify -Dcpu=native is rejected"
    set "exit_code=1"
    goto :fail
)
echo.
echo ------------------------------------------------------------------------------------
echo -Dcpu=native rejection gate: PASS
echo ------------------------------------------------------------------------------------
echo.
set "exit_code=0"
echo ***

echo ***
set "current_command=zig build -Doptimize=ReleaseFast -Dtarget=native (expected rejection)"
set "current_command_zig=zig build -Doptimize=ReleaseFast -Dtarget=native"
echo !current_command_zig!
!current_command_zig!
set "exit_code=!ERRORLEVEL!"
echo exit_code = "!exit_code!"
if "!exit_code!"=="0" (
    set "current_command=Verify -Dtarget=native is rejected"
    set "exit_code=1"
    goto :fail
)
echo.
echo ------------------------------------------------------------------------------------
echo -Dtarget=native rejection gate: PASS
echo ------------------------------------------------------------------------------------
echo.
set "exit_code=0"
echo ***

echo.
echo ------------------------------------------------------------------------------------
echo Finished override-rejection proof gates: PASS
echo ------------------------------------------------------------------------------------
echo.

REM --------------------------------------------------------------------------------------------
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
REM --------------------------------------------------------------------------------------------

echo.
echo ================================================================================
echo STAGE %STAGE% VALIDATION COMMAND SET: COMPLETED
echo W3C REVIEW OF THE ACTUAL OUTPUT IS REQUIRED BEFORE STAGE PASS
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
