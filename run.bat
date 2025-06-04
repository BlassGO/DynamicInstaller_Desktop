@echo off
setlocal

set "SCRIPT_DIR=%~dp0"

:: Check for WSL
wsl.exe -l -q >NUL 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Trying to install WSL - admin required...
    powershell.exe Start-Process cmd.exe -Verb RunAs -ArgumentList '/c "wsl --install && pause || (echo [ERROR] WSL install failed. Please install manually. && pause)"'
    echo [INFO] Restart if prompted. Rerun this script after install.
    goto :eof
)

:: Check for bash
where /q bash.exe
if %errorlevel% neq 0 (
    echo [ERROR] 'bash' command missing. Ensure WSL distribution is set up.
    echo [INFO] Try 'wsl --set-default <DistroName>' in admin CMD/PowerShell.
    goto :eof
)

cd /d "%SCRIPT_DIR%"
echo [INFO] Running via WSL...

bash -c "sudo bash run.sh"

endlocal
goto :eof