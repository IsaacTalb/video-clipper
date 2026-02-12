"""
Demo script to test the Video Clipper setup
"""
import subprocess
import os

def check_ffmpeg():
    """Check if FFmpeg is installed and working"""
    print("Checking FFmpeg...")
    try:
        result = subprocess.run(['ffmpeg', '-version'], capture_output=True, text=True, check=True)
        print("✓ FFmpeg is installed and working!")
        print(f"  {result.stdout.splitlines()[0]}")
        return True
    except:
        print("✗ FFmpeg not found!")
        return False

def check_python():
    """Check Python version"""
    print("\nChecking Python...")
    try:
        result = subprocess.run(['python', '--version'], capture_output=True, text=True, check=True)
        print("✓ Python is installed!")
        print(f"  {result.stdout.strip()}")
        return True
    except:
        print("✗ Python not found!")
        return False

def main():
    print("=" * 50)
    print("  Video Clipper - Setup Check")
    print("=" * 50)

    ffmpeg_ok = check_ffmpeg()
    python_ok = check_python()

    print("\n" + "=" * 50)
    if ffmpeg_ok and python_ok:
        print("  ✓ All checks passed! Ready to use.")
        print("=" * 50)
        print("\nTo start the Video Clipper:")
        print("  - Double-click: launcher.bat")
        print("  - Or run: python main.py")
        print("\n")
    else:
        print("  ✗ Some checks failed. Please install missing components.")
        print("=" * 50)
        print("\nTo fix issues:")
        print("  1. Run: install.bat")
        print("  2. Or manually install:")
        print("     - Python 3.13 from Microsoft Store")
        print("     - FFmpeg using: winget install ffmpeg")
        print("\n")

if __name__ == "__main__":
    main()
