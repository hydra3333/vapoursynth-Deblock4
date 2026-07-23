@echo off
setlocal EnableExtensions DisableDelayedExpansion

REM This File: 000-SET_USER_PATH_PERMANENTLY.BAT

REM Define where the zig zip files were was extracted to (zig.exe)

set "ZIGDIR=C:\SOFTWARE\zig"

REM 1. Create a temporary .ps1 file
REM set the PS1 to a similar filename
set "this_filename_part=%~n0"
set "PS1_FILE=%TEMP%\%this_filename_part%_%COMPUTERNAME%_%USERNAME%_%RANDOM%_%RANDOM%.ps1"
set "BACKUP_FILE=%TEMP%\%this_filename_part%_BACKUP_%COMPUTERNAME%_%USERNAME%_%RANDOM%_%RANDOM%.txt"

if not exist "%ZIGDIR%\zig.exe" (
    echo ERROR: Zig not found: %ZIGDIR%\zig.exe
    echo        Exiting with nothing done.
    pause
    exit /b 1
)

REM 2. This line finds where the PowerShell code starts and saves it to the temp .ps1 file
for /f "tokens=1 delims=:" %%n in ('findstr /n "#==BEGIN_PS==" "%~f0"') do set /a "start=%%n"
more +%start% "%~f0" > "%PS1_FILE%"

REM 3. Execute the .ps1 file and pass variables as arguments
REM powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%PS1_FILE%" -ZigDir "%ZIGDIR%" -BackupFile "%BACKUP_FILE%" -DryRun
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%PS1_FILE%" -ZigDir "%ZIGDIR%" -BackupFile "%BACKUP_FILE%"
if errorlevel 1 (
    echo ERROR: PowerShell script failed.
    pause
    exit /b 1
)

REM 4. Cleanup
if exist "%PS1_FILE%" del "%PS1_FILE%"

echo.
pause
exit /b

REM===========================================================================
REM EVERYTHING BELOW THIS LINE IS PURE POWERSHELL COPIED TO THE TEMPORARY .PS1
REM===========================================================================
#==BEGIN_PS==
Param(
    [string]$ZigDir,
    [string]$BackupFile,
    [switch]$DryRun
)
Write-Host ""
Write-Host "================================================================"
Write-Host " Zig set PATH setting for this User which persists across logins"
Write-Host "================================================================"
Write-Host ""
Write-Host "Purpose:"
Write-Host "  For the current user only, (re)set the PATH which endures across logins:"
Write-Host "  Remove existing PATH entries containing 'zig'."
Write-Host "  Append the selected Zig installation path at the end of PATH."
Write-Host ""
Write-Host "Remember:"
Write-Host "  The updated User PATH is written to the Registry immediately."
Write-Host "  Existing applications will continue using their current environment."
Write-Host "  New applications usually see the change immediately, although in some"
Write-Host "  cases logging out/in or restarting Explorer may be required."
Write-Host ""
Write-Host "Selected NEW Zig directory:"
Write-Host "  $ZigDir"
Write-Host ""
Write-Host "BACKUP FILE containing current pre-change PATH:"
Write-Host "  $BackupFile"
Write-Host ""
$old = [Environment]::GetEnvironmentVariable('Path', 'User')
# Save backup
$old | Out-File -Encoding UTF8 $BackupFile
Write-Host "Backup created at: $BackupFile" -ForegroundColor Gray
Write-Host "Containing the pre-change PATH:"
Write-Host $old
Write-Host ""
Write-Host "Existing Zig-related PATH entries:"
#
$pathParts = $old -split ';'
#
$zigEntries = $pathParts | Where-Object { $_ -and ($_.IndexOf('zig',[StringComparison]::OrdinalIgnoreCase) -ge 0) }
if ($zigEntries) {
    $zigEntries | ForEach-Object { Write-Host "  REMOVING: $_" }
} else {
    Write-Host "  None found."
}
# Split and filter out existing paths containing the string 'zig'
$parts = $pathParts | Where-Object { $_ -and ($_.IndexOf('zig',[StringComparison]::OrdinalIgnoreCase) -lt 0) }
#
# Combine. NEVER EVER EVER PUT SOMEONE ELSES FOLDER AT THE TOP OF OUR PATH
$newPath = ($parts + @($ZigDir) | Select-Object -Unique) -join ';'
Write-Host ""
Write-Host "New Zig PATH entry will be added to the end of PATH:"
Write-Host "  $ZigDir"
# Display
Write-Host ""
Write-Host "New PATH:" -ForegroundColor Cyan
Write-Host $newPath
# Confirm
Write-Host ""
if ($DryRun) {
    Write-Host ""
    Write-Host "DRY RUN ONLY - no PATH change will be made." -ForegroundColor Yellow
    Write-Host ""
}
$answer = Read-Host "Write this PATH to User Environment Registry entry? (Y/N)"
if ($answer -ieq 'Y') {
    if ($DryRun) {
        Write-Host "DRY RUN: PATH not changed from:"
        Write-Host $old
        Write-Host "DRY RUN: to:"
        Write-Host $newPath
    } else {
        [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
        $verify = [Environment]::GetEnvironmentVariable('Path','User')
        if ($verify -ieq $newPath) {
            Write-Host ""
            Write-Host "Verified OK." -ForegroundColor Green
            Write-Host ""
        } else {
            Write-Host ""
            Write-Host "ERROR: Verification failed." -ForegroundColor Red
            Write-Host ""
            Write-Host "  PATH not changed from:"
            Write-Host $old
            Write-Host "  to:"
            Write-Host $newPath
            Write-Host ""
            Write-Host "  It is currently set to:"
            Write-Host $verify
            Write-Host ""
            exit 1
        }
        Write-Host ""
        Write-Host "Success: Path updated." -ForegroundColor Green
        Write-Host ""
        Write-Host "User PATH now contains:"
        Write-Host ([Environment]::GetEnvironmentVariable('Path','User'))
        Write-Host ""
        Write-Host "AFTER Logout/Login then verify using DOS commands:"
        Write-Host "  where zig"
        Write-Host "  zig version"
        Write-Host ""
    }
} else {
    Write-Host ""
    Write-Host "Cancelled: No changes made to PATH." -ForegroundColor Yellow
    Write-Host ""
}
