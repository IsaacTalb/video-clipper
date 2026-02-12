@echo off
chcp 65001 > nul

echo ============================================
echo   Video Clipper - Full Test Suite
echo ============================================
echo.

set "TESTS_PASSED=0"
set "TESTS_FAILED=0"

:: Test 1: Python Installation
echo [TEST 1/7] Checking Python installation...
set "PYTHON_PATH="
for /d %%d in ("C:\Users\*\AppData\Local\Programs\Python\Python3*") do set "PYTHON_PATH=%%d\python.exe"
if "%PYTHON_PATH%"=="" set "PYTHON_PATH=C:\Python313\python.exe"
if "%PYTHON_PATH%"=="" set "PYTHON_PATH=python.exe"

if exist "%PYTHON_PATH%" (
    for /f "tokens=*" %%i in ('"%PYTHON_PATH%" --version 2^>^&1') do (
        echo    ✓ PASS: %%i
        set /a TESTS_PASSED+=1
    )
) else (
    echo    ✗ FAIL: Python not found
    set /a TESTS_FAILED+=1
)
echo.

:: Test 2: Python Script
echo [TEST 2/7] Checking main.py...
if exist "D:\video-clipper\main.py" (
    echo    ✓ PASS: main.py exists
    set /a TESTS_PASSED+=1
) else (
    echo    ✗ FAIL: main.py not found
    set /a TESTS_FAILED+=1
)
echo.

:: Test 3: FFmpeg
echo [TEST 3/7] Checking FFmpeg installation...
set "FFMPEG_PATH="
if exist "C:\Program Files\ffmpeg\bin\ffmpeg.exe" set "FFMPEG_PATH=C:\Program Files\ffmpeg\bin\ffmpeg.exe"
if exist "C:\ffmpeg\bin\ffmpeg.exe" set "FFMPEG_PATH=C:\ffmpeg\bin\ffmpeg.exe"

if "%FFMPEG_PATH%"=="" (
    winget list --name ffmpeg | findstr "Gyan.FFmpeg" >nul 2>&1
    if %errorlevel% equ 0 (
        echo    ✓ PASS: FFmpeg installed (via winget)
        set /a TESTS_PASSED+=1
    ) else (
        echo    ✗ FAIL: FFmpeg not found
        set /a TESTS_FAILED+=1
    )
) else (
    echo    ✓ PASS: FFmpeg found at %FFMPEG_PATH%
    set /a TESTS_PASSED+=1
)
echo.

:: Test 4: Launcher Script
echo [TEST 4/7] Checking launcher.bat...
if exist "D:\video-clipper\launcher.bat" (
    echo    ✓ PASS: launcher.bat exists
    set /a TESTS_PASSED+=1
) else (
    echo    ✗ FAIL: launcher.bat not found
    set /a TESTS_FAILED+=1
)
echo.

:: Test 5: Build Script
echo [TEST 5/7] Checking build_installer.bat...
if exist "D:\video-clipper\build_installer.bat" (
    echo    ✓ PASS: build_installer.bat exists
    set /a TESTS_PASSED+=1
) else (
    echo    ✗ FAIL: build_installer.bat not found
    set /a TESTS_FAILED+=1
)
echo.

:: Test 6: Dependencies
echo [TEST 6/7] Checking requirements.txt...
if exist "D:\video-clipper\requirements.txt" (
    echo    ✓ PASS: requirements.txt exists
    set /a TESTS_PASSED+=1
) else (
    echo    ✗ FAIL: requirements.txt not found
    set /a TESTS_FAILED+=1
)
echo.

:: Test 7: Documentation
echo [TEST 7/7] Checking README.md...
if exist "D:\video-clipper\README.md" (
    echo    ✓ PASS: README.md exists
    set /a TESTS_PASSED+=1
) else (
    echo    ✗ FAIL: README.md not found
    set /a TESTS_FAILED+=1
)
echo.

:: Summary
echo ============================================
echo   TEST SUMMARY
echo ============================================
echo.
echo Total Tests: %TESTS_PASSED% + %TESTS_FAILED% = %TESTS_PASSED% + %TESTS_FAILED% / %TESTS_FAILED% Failed
echo.
echo Passed: %TESTS_PASSED%
echo Failed: %TESTS_FAILED%
echo.

if %TESTS_FAILED% equ 0 (
    echo ============================================
    echo   ✓ ALL TESTS PASSED! Ready for GitHub.
    echo ============================================
    echo.
    echo Next steps:
    echo   1. Run: git init
    echo   2. Add all files
    echo   3. Commit
    echo   4. Push to GitHub
    echo.
) else (
    echo ============================================
    echo   ✗ SOME TESTS FAILED
    echo ============================================
    echo.
    echo Please fix the failed tests before pushing.
    echo.
)

echo.
echo Press any key to exit...
pause >nul
