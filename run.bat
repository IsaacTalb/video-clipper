@echo off
:: Quick run script for Video Clipper

chcp 65001 > nul

:: Find Python
set "PYTHON_PATH="
for /d %%d in ("C:\Users\*\AppData\Local\Programs\Python\Python3*") do set "PYTHON_PATH=%%d\python.exe"
if "%PYTHON_PATH%"=="" (
    set "PYTHON_PATH=C:\Python313\python.exe"
)
if "%PYTHON_PATH%"=="" (
    set "PYTHON_PATH=python.exe"
)

:: Verify Python
"%PYTHON_PATH%" --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python not found at: %PYTHON_PATH%
    echo.
    echo Please install Python 3.13 using:
    echo   install.bat
    echo.
    pause
    exit /b 1
)

:: Run application
"%PYTHON_PATH%" "D:\video-clipper\main.py"
