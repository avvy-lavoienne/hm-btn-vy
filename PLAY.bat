@echo off
setlocal
cd /d "%~dp0"

if not exist "emulator\duckstation-qt-x64-ReleaseLTCG.exe" (
    echo [ERROR] Emulator belum ada. Jalankan dulu:
    echo         powershell -ExecutionPolicy Bypass -File .\scripts\setup.ps1
    pause
    exit /b 1
)

if not exist "local\disc-patched\HARVESTMOON.cue" (
    echo [ERROR] Game belum dipatch. Jalankan dulu:
    echo         powershell -ExecutionPolicy Bypass -File .\scripts\apply-patch.ps1
    pause
    exit /b 1
)

start "" "emulator\duckstation-qt-x64-ReleaseLTCG.exe" "local\disc-patched\HARVESTMOON.cue"
exit /b 0
