@echo off
echo.
echo ========================================
echo  OpenCode Jailbreak Agent Installer
echo ========================================
echo.

REM Detect OpenCode config directory
set "OPENCODE_DIR="
if exist "%USERPROFILE%\.config\opencode" (
    set "OPENCODE_DIR=%USERPROFILE%\.config\opencode"
    goto :found
)
if exist "%USERPROFILE%\.opencode" (
    set "OPENCODE_DIR=%USERPROFILE%\.opencode"
    goto :found
)
echo ERROR: OpenCode config directory not found
pause
exit /b 1

:found
echo Found OpenCode config at: %OPENCODE_DIR%

set "AGENTS_DIR=%OPENCODE_DIR%\agents"
if not exist "%AGENTS_DIR%" mkdir "%AGENTS_DIR%"

REM Download from GitHub using PowerShell
echo Downloading latest jailbreak.md...
powershell -Command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Sunny-son-sahur/opencode-jailbreak/main/windows/jailbreak.md' -OutFile '%AGENTS_DIR%\jailbreak.md' -UseBasicParsing } catch { Write-Host 'Download failed'; exit 1 }"

if %errorlevel% neq 0 (
    echo ERROR: Download failed. Check your internet connection.
    pause
    exit /b 1
)

if exist "%AGENTS_DIR%\jailbreak.md" (
    echo.
    echo ========================================
    echo  Done! Restart OpenCode.
    echo ========================================
    echo.
    echo Desktop:  Press Ctrl+. to switch to jailbreak
    echo Console:  opencode --agent jailbreak
) else (
    echo ERROR: Install failed
)

echo.
pause
