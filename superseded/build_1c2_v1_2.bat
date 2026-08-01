@echo on
@setlocal ENABLEEXTENSIONS
@setlocal ENABLEDELAYEDEXPANSION

set "REPO=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4"
set "DELIVERY=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\deliveries\Deblock4_Stage_1C_Phase_2_W3C_delivery_v1_2"

cd /d "%REPO%" || exit /b 1

call :do_prep

goto :after_apply

git status --short
if errorlevel 1 exit /b 1

copy /Y "%DELIVERY%\Deblock4_Stage_1C_Phase_2_W3C_interop_fix_v1_2.patch" ".\"
if errorlevel 1 exit /b 1

git apply --check --whitespace=error-all Deblock4_Stage_1C_Phase_2_W3C_interop_fix_v1_2.patch
if errorlevel 1 exit /b 1

git apply Deblock4_Stage_1C_Phase_2_W3C_interop_fix_v1_2.patch
if errorlevel 1 exit /b 1

git -c core.whitespace=cr-at-eol diff --check
if errorlevel 1 exit /b 1

:after_apply

if exist validation_support rmdir /s /q validation_support
if exist validation_support exit /b 1

xcopy "%DELIVERY%\validation_support" ".\validation_support\" /E /H /I /Y
if errorlevel 1 exit /b 1

call validation_support\build_1c2_phase2_validation.bat
if errorlevel 1 exit /b 1

if exist src\__phase2_validation_plugin_root.zig exit /b 1

git -c core.whitespace=cr-at-eol diff --check
if errorlevel 1 exit /b 1

git status --short
if errorlevel 1 exit /b 1

call :do_prep
pause
goto :eof

:do_prep
set "zig_cache=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\.zig-cache"
if exist "!zig_cache!" rmdir /s /Q "!zig_cache!"

set "zig_out=E:\SOFTWARE-Win11\MULTIMEDIA\vapoursynth-Deblock4\github\vapoursynth-Deblock4\zig-out"
if exist "!zig_out!" rmdir /s /Q "!zig_out!"
goto :eof

