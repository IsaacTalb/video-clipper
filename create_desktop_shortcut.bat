@echo off
echo Creating desktop shortcut for Video Clipper...

set SCRIPT_PATH="%USERPROFILE%\Desktop\Video Clipper.lnk"

:: Create the shortcut using PowerShell
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SCRIPT_PATH%'); $Shortcut.TargetPath = 'D:\video-clipper\launcher.bat'; $Shortcut.WorkingDirectory = 'D:\video-clipper'; $Shortcut.Description = 'Video Clipper - KoKo Isaac''s Tool'; $Shortcut.Save()"

if %errorlevel% equ 0 (
    echo.
    echo ============================================
    echo   ✓ Shortcut Created Successfully!
    echo ============================================
    echo.
    echo Desktop Shortcut: %USERPROFILE%\Desktop\Video Clipper.lnk
    echo.
) else (
    echo.
    echo ============================================
    echo   ✗ Failed to create shortcut
    echo ============================================
    echo.
    echo Please manually create a shortcut:
    echo 1. Right-click on D:\video-clipper\launcher.bat
    echo 2. Select "Send to" > "Desktop (create shortcut)"
    echo.
)

pause
