@echo off
chcp 65001 > nul

echo ============================================
echo   Video Clipper - Setup Check
echo ============================================
echo.

:: Check Python
echo [1/3] Checking Python...
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
    echo    Install with: install.bat
)

:: Check FFmpeg
echo.
echo [2/3] Checking FFmpeg...
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
    echo    Install with: install.bat
)

:: Check Python Script
echo.
echo [3/3] Checking Python Script...
if exist "D:\video-clipper\main.py" (
    echo    ✓ main.py found
) else (
    echo    ✗ main.py not found!
)

echo.
echo ============================================
echo   Launching Video Clipper...
echo ============================================
echo.
echo Press any key to start...
pause >nul

"%PYTHON_PATH%" "D:\video-clipper\main.py"
