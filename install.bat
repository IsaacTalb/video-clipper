@echo off
echo ============================================
echo   Video Clipper - Full Setup & Installation
echo ============================================
echo.

:: Check Admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Please run as Administrator for best results
    echo Press any key to continue anyway...
    pause >nul
    echo.
)

echo ============================================
echo   Step 1/4: Install Python 3.13
echo ============================================
python --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('python --version') do set PYTHON_VER=%%i
    echo [1/4] Python is already installed: %PYTHON_VER%
    goto :python_done
) else (
    echo Installing Python 3.13...
    winget install Python.Python.3.13 --silent --accept-package-agreements --accept-source-agreements --override "--quiet --passive --installuri https://www.python.org/ftp/python/3.13.12/python-3.13.12-amd64.exe"
    if %errorlevel% equ 0 (
        echo Python installation complete!
    ) else (
        echo Warning: Python installation may have issues
        echo Please install manually from: https://www.python.org/downloads/
    )
)

:python_done
echo.

echo ============================================
echo   Step 2/4: Install FFmpeg
echo ============================================
ffmpeg -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [2/4] FFmpeg is already installed
) else (
    echo Installing FFmpeg...
    winget install Gyan.FFmpeg --silent --accept-package-agreements --accept-source-agreements --override "--override" --exact
    if %errorlevel% equ 0 (
        echo FFmpeg installation complete!
    ) else (
        echo Warning: FFmpeg installation may have issues
        echo Please install manually using: winget install Gyan.FFmpeg
    )
)
echo.

echo ============================================
echo   Step 3/4: Install PyInstaller
echo ============================================
pyinstaller --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [3/4] PyInstaller is already installed
) else (
    echo Installing PyInstaller...
    pip install pyinstaller
    if %errorlevel% equ 0 (
        echo PyInstaller installation complete!
    ) else (
        echo Warning: PyInstaller installation may have failed
        echo PyInstaller may be needed to build the installer
    )
)
echo.

echo ============================================
echo   Step 4/4: Build Installer (EXE)
echo ============================================
echo Building Video Clipper EXE...
echo This may take a few minutes...
echo.

cd /d "%~dp0"
set "PYTHON_PATH=C:\Users\Asus\AppData\Local\Programs\Python\Python313"
set "EXE_PATH=D:\video-clipper\VideoClipper.exe"

:: Build the EXE with PyInstaller
"%PYTHON_PATH%\python.exe" -m PyInstaller --noconfirm ^
    --onefile ^
    --windowed ^
    --name "Video Clipper" ^
    --icon "" ^
    --add-data "requirements.txt;." ^
    main.py

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo   ✓ EXE Built Successfully!
    echo ============================================
    echo.
    echo EXE Location: D:\video-clipper\VideoClipper.exe
    echo.
    echo This EXE will:
    - Detect Python automatically
    - Detect FFmpeg automatically
    - Create output folder
    - Clip videos
    - No installation needed!
    echo.
) else (
    echo.
    echo ============================================
    echo   ✗ EXE Build Failed
    echo ============================================
    echo.
    echo The Python script was created successfully,
    but building the EXE failed.
    echo.
    echo You can still run the project using:
    echo   - launcher.bat
    echo   - run.bat
    echo   - python main.py
    echo.
)

echo.
echo ============================================
echo   Installation Complete!
echo ============================================
echo.
echo To use Video Clipper:
echo   1. Double-click: VideoClipper.exe (installed)
echo   2. Or use: launcher.bat (in source)
echo   3. Or use: run.bat (in source)
echo.
echo Output clips will be saved to: D:\video_clips
echo.
pause
