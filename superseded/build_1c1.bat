@echo on
@setlocal ENABLEEXTENSIONS
@setlocal ENABLEDELAYEDEXPANSION

cd /d "E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"

REM Debug:

call :do_prep
zig test src\deblock4_version.zig -target x86_64-windows-msvc -mcpu=x86_64 -O Debug
zig test src\common_instance_data_structure.zig -target x86_64-windows-msvc -mcpu=x86_64 -O Debug
zig test src\filter_call_parameters.zig -target x86_64-windows-msvc -mcpu=x86_64 -O Debug
zig test src\classic_instance_data.zig -target x86_64-windows-msvc -mcpu=x86_64 -O Debug
zig test src\deblock4_instance_data.zig -target x86_64-windows-msvc -mcpu=x86_64 -O Debug
pause

REM ReleaseSafe:

call :do_prep
zig test src\deblock4_version.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseSafe
zig test src\common_instance_data_structure.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseSafe
zig test src\filter_call_parameters.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseSafe
zig test src\classic_instance_data.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseSafe
zig test src\deblock4_instance_data.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseSafe
pause

REM ReleaseFast:

call :do_prep
zig test src\deblock4_version.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseFast
zig test src\common_instance_data_structure.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseFast
zig test src\filter_call_parameters.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseFast
zig test src\classic_instance_data.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseFast
zig test src\deblock4_instance_data.zig -target x86_64-windows-msvc -mcpu=x86_64 -O ReleaseFast
pause

REM Existing first-class regression (unchanged build graph):

call :do_prep
zig build selftest -Doptimize=Debug
zig build selftest -Doptimize=ReleaseSafe
zig build selftest -Doptimize=ReleaseFast

REM Expected result:
REM - every zig test command exits 0;
REM - the version module reports 1 test passed;
REM - the common-instance module reports 2 tests passed;
REM - filter_call_parameters reports 7 tests passed;
REM - the two instance-data roots compile and report no failures;
REM - all three existing selftest builds exit 0;
REM - no VS core or VS-facing module is required;
REM - no existing file is modified or removed.
pause

REM Final repository checks:

git diff --check
git status --short

REM Expected git status --short additions only:
REM ?? src/classic_instance_data.zig
REM ?? src/common_instance_data_structure.zig
REM ?? src/deblock4_instance_data.zig
REM ?? src/deblock4_version.zig
REM ?? src/filter_call_parameters.zig

pause
goto :eof

:do_prep
set "zig_cache=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\.zig-cache"
if exist "!zig_cache!" rmdir /s /q "!zig_cache!"

set "zig_out=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\zig-out"
if exist "!zig_out!" rmdir /s /q "!zig_out!"
goto :eof

