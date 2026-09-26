@echo off
echo.
echo ========================================
echo  OpenCode Jailbreak Agent Installer
echo ========================================
echo.

REM Create both directories
set "DIR1=%USERPROFILE%\.config\opencode\agents"
set "DIR2=%USERPROFILE%\.opencode\agents"
if not exist "%DIR1%" mkdir "%DIR1%"
if not exist "%DIR2%" mkdir "%DIR2%"

REM Download from GitHub API (bypasses CDN cache)
echo Downloading latest jailbreak.md...
powershell -Command "try { Invoke-WebRequest -Uri 'https://api.github.com/repos/Sunny-son-sahur/opencode-jailbreak/contents/windows/jailbreak.md' -Headers @{'Accept'='application/vnd.github.v3.raw'} -OutFile '%TEMP%\jailbreak.md' -UseBasicParsing } catch { Write-Host 'Download failed'; exit 1 }"

if %errorlevel% neq 0 (
    echo ERROR: Download failed. Check your internet connection.
    pause
    exit /b 1
)

REM Verify it downloaded
findstr /C:"morgan" "%TEMP%\jailbreak.md" >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Downloaded file is invalid.
    pause
    exit /b 1
)

REM Install to both locations
echo Installing to %DIR1% ...
copy /Y "%TEMP%\jailbreak.md" "%DIR1%\jailbreak.md" >nul

echo Installing to %DIR2% ...
copy /Y "%TEMP%\jailbreak.md" "%DIR2%\jailbreak.md" >nul

del /f /q "%TEMP%\jailbreak.md" 2>nul

echo.
echo ========================================
echo  Done! Installed to both locations:
echo ========================================
echo.
echo   %DIR1%\jailbreak.md
echo   %DIR2%\jailbreak.md
echo.
echo Restart OpenCode to load the update.
echo   Desktop:  Press Ctrl+. to switch to jailbreak
echo   Console:  opencode --agent jailbreak
echo.
pause
