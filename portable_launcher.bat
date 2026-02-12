@echo off
chcp 65001 > nul

:: ============================================
:: Video Clipper - Portable Launcher
:: ============================================
:: This launcher finds Python and FFmpeg automatically
:: No installation needed!

echo ====================================
echo   Video Clipper - KoKo Isaac's Tool
echo ====================================
echo.

:: Find Python
echo [1/3] Finding Python...
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
        echo    ✓ Found: %%i
    )
) else (
    echo    ✗ Python not found!
    echo    Please install Python 3.13 from:
    echo    https://www.python.org/downloads/
    echo.
    echo    Press any key to exit...
    pause >nul
    exit /b 1
)

echo.

:: Find FFmpeg
echo [2/3] Finding FFmpeg...
set "FFMPEG_PATH="
set "FFMPEG_FOUND=0"

:: Check common locations
if exist "C:\Program Files\ffmpeg\bin\ffmpeg.exe" (
    set "FFMPEG_PATH=C:\Program Files\ffmpeg\bin\ffmpeg.exe"
    set "FFMPEG_FOUND=1"
)
if exist "C:\ffmpeg\bin\ffmpeg.exe" (
    set "FFMPEG_PATH=C:\ffmpeg\bin\ffmpeg.exe"
    set "FFMPEG_FOUND=1"
)
if exist "%LOCALAPPDATA%\ffmpeg\bin\ffmpeg.exe" (
    set "FFMPEG_PATH=%LOCALAPPDATA%\ffmpeg\bin\ffmpeg.exe"
    set "FFMPEG_FOUND=1"
)

:: Check winget package location
winget list --name ffmpeg | findstr "Gyan.FFmpeg" >nul 2>&1
if %errorlevel% equ 0 (
    :: Try to find FFmpeg in Program Files
    for /f "delims=" %%a in ('dir "C:\Program Files" /b /s /ad 2^>nul ^| findstr /i ffmpeg') do (
        if exist "%%a\ffmpeg.exe" (
            set "FFMPEG_PATH=%%a\ffmpeg.exe"
            set "FFMPEG_FOUND=1"
            goto :ffmpeg_found
        )
    )
)

:ffmpeg_found
if "%FFMPEG_FOUND%"=="1" (
    if exist "%FFMPEG_PATH%" (
        echo    ✓ Found: %FFMPEG_PATH%
    ) else (
        echo    ✓ FFmpeg installed (location unknown)
    )
) else (
    echo    ✗ FFmpeg not found!
    echo.
    echo    Please install FFmpeg:
    echo    winget install Gyan.FFmpeg
    echo.
    echo    Or download from: https://www.gyan.dev/ffmpeg/builds/
    echo.
    echo    Press any key to exit...
    pause >nul
    exit /b 1
)

echo.
echo [3/3] Starting application...
echo.

:: Add Python to path temporarily
set "PATH=%PYTHON_PATH%;%PATH%"

:: Run the main application
"%PYTHON_PATH%" "D:\video-clipper\main.py"

if %errorlevel% neq 0 (
    echo.
    echo ============================================
    echo   Error occurred!
    echo ============================================
    echo.
    echo The application exited with an error code.
    echo Press any key to exit...
    pause >nul
)
