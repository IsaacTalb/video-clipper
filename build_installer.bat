@echo off
echo ============================================
echo   Build Installer (EXE)
echo ============================================
echo.

:: Check for admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Running as standard user. Admin recommended.
    echo Press any key to continue anyway...
    pause >nul
    echo.
)

echo Step 1: Installing Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing Python 3.13...
    winget install Python.Python.3.13 --silent --accept-package-agreements --accept-source-agreements --override "--quiet --passive --installuri https://www.python.org/ftp/python/3.13.12/python-3.13.12-amd64.exe" >nul 2>&1
    if %errorlevel% neq 0 (
        echo Python installation failed. Check manual install.
        pause
        exit /b 1
    )
    echo Python installed.
) else (
    echo Python already installed.
)

echo.
echo Step 2: Installing FFmpeg...
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing FFmpeg...
    winget install Gyan.FFmpeg --silent --accept-package-agreements --accept-source-agreements --override "--override" --exact >nul 2>&1
    if %errorlevel% neq 0 (
        echo FFmpeg installation failed. Check manual install.
        pause
        exit /b 1
    )
    echo FFmpeg installed.
) else (
    echo FFmpeg already installed.
)

echo.
echo Step 3: Installing PyInstaller...
pip install pyinstaller >nul 2>&1
if %errorlevel% neq 0 (
    echo PyInstaller installation failed.
    pause
    exit /b 1
)
echo PyInstaller installed.

echo.
echo Step 4: Building EXE...
echo This may take 2-3 minutes...
echo.

cd /d "%~dp0"

:: Find Python
set "PYTHON_PATH="
for /d %%d in ("C:\Users\*\AppData\Local\Programs\Python\Python3*") do set "PYTHON_PATH=%%d\python.exe"
if "%PYTHON_PATH%"=="" (
    set "PYTHON_PATH=C:\Python313\python.exe"
)
if not exist "%PYTHON_PATH%" (
    set "PYTHON_PATH=python.exe"
)

echo Using Python: %PYTHON_PATH%
echo.

:: Build with PyInstaller
"%PYTHON_PATH%" -m PyInstaller --noconfirm ^
    --onefile ^
    --windowed ^
    --name "Video Clipper" ^
    --clean ^
    main.py

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo   ✓ INSTALLER BUILT SUCCESSFULLY!
    echo ============================================
    echo.
    echo Location: %~dp0Video Clipper.exe
    echo.
    echo How to distribute:
    1. Copy Video Clipper.exe to any folder
    2. Share with users (no installation needed!)
    3. Users just double-click to run
    4. Clips saved to: Video_Clipper_Directory\video_clips\
    echo.
) else (
    echo.
    echo Build failed. Running script directly instead...
    echo.
    python main.py
    if %errorlevel% neq 0 pause
)

echo.
pause
