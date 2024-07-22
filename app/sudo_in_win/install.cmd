@echo off
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    setlocal DisableDelayedExpansion
    set "batchPath=%~dpnx0"
    setlocal EnableDelayedExpansion
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "!batchPath!", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

copy "%~dp0\sudo.exe" "C:\Windows\System32\sudo.exe"
reg import "%~dp0\config.reg"

if exist "%~dp0\..\..\sudo_for_windows.zip" (
    del "%~dp0\..\..\sudo_for_windows.zip"
    rd /s /q "%~dp0\.."
) else (
    del "%~dp0\..\sudo_for_windows.zip"
    rd /s /q "%~dp0"
)

