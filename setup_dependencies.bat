@echo off
chcp 65001 > nul

echo ============================================
echo   Video Clipper - Dependency Setup
echo ============================================
echo.

:: Check Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Running as standard user. Some steps may fail.
    echo Press any key to continue anyway...
    pause >nul
    echo.
)

echo Step 1: Installing Python 3.13...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Python 3.13...
    winget install Python.Python.3.13 --silent --accept-package-agreements --accept-source-agreements --override "--quiet --passive --installuri https://www.python.org/ftp/python/3.13.12/python-3.13.12-amd64.exe" >nul 2>&1
    if %errorlevel% equ 0 (
        echo    ✓ Python installed
    ) else (
        echo    ! Python installation may have issues
        echo    Please install manually from: https://www.python.org/downloads/
    )
) else (
    echo    ✓ Python already installed
)
echo.

echo Step 2: Installing FFmpeg...
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing FFmpeg...
    winget install Gyan.FFmpeg --silent --accept-package-agreements --accept-source-agreements --override "--override" --exact >nul 2>&1
    if %errorlevel% equ 0 (
        echo    ✓ FFmpeg installed
    ) else (
        echo    ! FFmpeg installation may have issues
        echo    Please install manually using: winget install Gyan.FFmpeg
    )
) else (
    echo    ✓ FFmpeg already installed
)
echo.

echo Step 3: Installing PyInstaller...
pip install pyinstaller >nul 2>&1
if %errorlevel% equ 0 (
    echo    ✓ PyInstaller installed
) else (
    echo    ! PyInstaller installation failed
    echo    This is optional - needed for EXE builder
)
echo.

echo ============================================
echo   Setup Complete!
echo ============================================
echo.
echo To build the EXE installer:
echo   - Double-click: build_installer.bat
echo.
echo To run the application:
echo   - Double-click: launcher.bat
echo   - Or use: portable_launcher.bat
echo.
pause
