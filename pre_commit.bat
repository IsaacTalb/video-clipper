@echo off
echo ============================================
echo   Pre-Commit Hook
echo ============================================
echo.
echo Running checks before commit...
echo.

:: Check Python script syntax
echo [1/3] Checking Python syntax...
python -m py_compile "D:\video-clipper\main.py"
if %errorlevel% neq 0 (
    echo    ✗ Python syntax error found!
    echo    Please fix the syntax errors before committing.
    pause
    exit /b 1
)
echo    ✓ PASS
echo.

:: Check if main.py exists
echo [2/3] Verifying files...
if not exist "D:\video-clipper\main.py" (
    echo    ✗ FAIL: main.py not found
    pause
    exit /b 1
)
echo    ✓ PASS
echo.

:: Check documentation
echo [3/3] Checking documentation...
if not exist "D:\video-clipper\README.md" (
    echo    ✗ FAIL: README.md not found
    pause
    exit /b 1
)
echo    ✓ PASS
echo.

echo ============================================
echo   ✓ ALL CHECKS PASSED
echo ============================================
echo.
echo You can now commit your changes.
echo.
echo Suggested commit message:
echo   "Update: Make project GitHub-ready with auto-detection and installers"
echo.
pause
