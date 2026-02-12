@echo off
chcp 65001 > nul

:: ============================================
:: Video Clipper - Main Launcher
:: ============================================
:: For use with VideoClipper.exe installer

echo ====================================
echo   Video Clipper - KoKo Isaac's Tool
echo ====================================
echo.
echo Checking installation...
echo.

:: Find Python
set "PYTHON_PATH="
for /d %%d in ("C:\Users\*\AppData\Local\Programs\Python\Python3*") do set "PYTHON_PATH=%%d\python.exe"
if "%PYTHON_PATH%"=="" (
    set "PYTHON_PATH=C:\Python313\python.exe"
)
if "%PYTHON_PATH%"=="" (
    set "PYTHON_PATH=python.exe"
)

if exist "%PYTHON_PATH%" (
    for /f "tokens=*" %%i in ('"%PYTHON_PATH%" --version 2^>^&1') do (
        echo    ✓ Python: %%i
    )
) else (
    echo    ✗ Python not found!
    echo.
    echo    Please run install.bat first to install dependencies.
    echo.
    pause
    exit /b 1
)

:: Find FFmpeg
set "FFMPEG_PATH="
set "FFMPEG_FOUND=0"

if exist "C:\Program Files\ffmpeg\bin\ffmpeg.exe" (
    set "FFMPEG_PATH=C:\Program Files\ffmpeg\bin\ffmpeg.exe"
    set "FFMPEG_FOUND=1"
)
if exist "C:\ffmpeg\bin\ffmpeg.exe" (
    set "FFMPEG_PATH=C:\ffmpeg\bin\ffmpeg.exe"
    set "FFMPEG_FOUND=1"
)
if "%FFMPEG_FOUND%"=="0" (
    winget list --name ffmpeg | findstr "Gyan.FFmpeg" >nul 2>&1
    if %errorlevel% equ 0 (
        set "FFMPEG_FOUND=1"
    )
)

if "%FFMPEG_FOUND%"=="1" (
    echo    ✓ FFmpeg: Installed
) else (
    echo    ✗ FFmpeg not found!
    echo.
    echo    Please run install.bat to install FFmpeg.
    echo.
    pause
    exit /b 1
)

echo.
echo Launching Video Clipper...
echo.

:: Run application
"%PYTHON_PATH%" "D:\video-clipper\main.py"

if %errorlevel% neq 0 (
    echo.
    echo Error occurred. Press any key to exit...
    pause >nul
)
