@echo off
setlocal enableextensions
REM ============================================================================
REM run_vs.cmd  --  run a .vpy through PORTABLE VapourSynth R78
REM
REM Portable VapourSynth (with its portable Python) REQUIRES its own folder as
REM the current working directory so python3xx.dll / VapourSynth.dll / plugins
REM resolve. Calling vspipe.exe by absolute path from elsewhere FAILS.
REM
REM This wrapper sets the CWD via pushd (handles the drive change with no /d),
REM runs vspipe with whatever args you pass, restores the CWD via popd, and
REM propagates vspipe's exit code so callers (incl. Claude Code) see pass/fail.
REM
REM Usage:
REM   tools\run_vs.cmd <vspipe args...>
REM
REM Examples:
REM   tools\run_vs.cmd --info myscript.vpy
REM   tools\run_vs.cmd -c y4m myscript.vpy -            (y4m to stdout; pipe it)
REM   tools\run_vs.cmd -c y4m myscript.vpy - | x264 --demuxer y4m - -o out.mkv
REM
REM NOTE: because CWD is forced to VSROOT, any RELATIVE paths inside the .vpy
REM resolve against VSROOT, not this repo. Use absolute paths in scripts.
REM ============================================================================
set "VSROOT=D:\TEST\Vapoursynth_x64_R78"
set "VSPIPE_EXE=%VSROOT%\Lib\site-packages\vapoursynth\vspipe.exe"

if not exist "%VSPIPE_EXE%" (
    echo [run_vs] ERROR: vspipe.exe not found: '%VSPIPE_EXE%' 1>&2
    exit /b 9009
)
pushd "%VSROOT%" || (echo [run_vs] ERROR: cannot 'cd /d' to "%VSROOT%" 1>&2 & exit /b 1)
echo "%VSPIPE_EXE%" %*
"%VSPIPE_EXE%" %*
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
