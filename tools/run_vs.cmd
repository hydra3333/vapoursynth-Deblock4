@echo off
setlocal enableextensions
REM ============================================================================
REM run_vs.cmd  --  run through PORTABLE VapourSynth
REM
REM Portable VapourSynth (with its portable Python) REQUIRES its own folder as
REM the current working directory so python3xx.dll / VapourSynth.dll / plugins
REM resolve. Calling its executables by absolute path from elsewhere FAILS.
REM
REM This wrapper sets the CWD via pushd (handles the drive change with no /d),
REM runs vspipe normally, or one direct Python script when --python-script is
REM requested, restores the CWD, and propagates the child exit code.
REM
REM Usage:
REM   tools\run_vs.cmd <vspipe args...>
REM   tools\run_vs.cmd --python-script <absolute-script.vpy>
REM
REM Examples:
REM   tools\run_vs.cmd --info myscript.vpy
REM   tools\run_vs.cmd -c y4m myscript.vpy -            (y4m to stdout; pipe it)
REM   tools\run_vs.cmd -c y4m myscript.vpy - | x264 --demuxer y4m - -o out.mkv
REM
REM NOTE: because CWD is forced to VSROOT, any RELATIVE paths inside the .vpy
REM resolve against VSROOT, not this repo. Use absolute paths in scripts.
REM ============================================================================
set "VSROOT=D:\TEST\Vapoursynth_x64_R79"
set "VSPIPE_EXE=%VSROOT%\Lib\site-packages\vapoursynth\vspipe.exe"
set "PYTHON_EXE=%VSROOT%\python.exe"

if /I "%~1"=="--python-script" goto :run_python_script

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

:run_python_script
if "%~2"=="" (
    echo [run_vs] ERROR: --python-script requires one script path. 1>&2
    exit /b 2
)
if not "%~3"=="" (
    echo [run_vs] ERROR: --python-script accepts exactly one script path. 1>&2
    exit /b 2
)
if not exist "%PYTHON_EXE%" (
    echo [run_vs] ERROR: python.exe not found: '%PYTHON_EXE%' 1>&2
    exit /b 9009
)
if not exist "%~2" (
    echo [run_vs] ERROR: Python script not found: '%~2' 1>&2
    exit /b 2
)
pushd "%VSROOT%" || (echo [run_vs] ERROR: cannot 'cd /d' to "%VSROOT%" 1>&2 & exit /b 1)
echo "%PYTHON_EXE%" "%~2"
"%PYTHON_EXE%" "%~2"
set "RC=%ERRORLEVEL%"
popd
exit /b %RC%
