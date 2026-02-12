# 🎬 Video Clipper

A beginner-friendly GUI tool for clipping videos using FFmpeg. Built By KoKo Isaac.

## Features

- **Easy Video Selection** - Browse and select your video file
- **Clip Management** - Add multiple clips with custom titles
- **Time Control** - Set start and end times in mm:ss format
- **Fast Export** - Uses FFmpeg for quick, high-quality clips (no re-encoding)
- **Auto-Folder Creation** - Creates output folder automatically
- **No Installation Required** - Runs as standalone EXE or from source
- **Portable** - No admin privileges needed

## System Requirements

- **Operating System**: Windows 10/11
- **RAM**: 2GB minimum (4GB recommended)
- **Disk Space**: 100MB free space

## Installation

### Option 1: Run as EXE (No Installation Needed)

1. Download `Video Clipper.exe` from releases
2. Double-click to run
3. Done!

### Option 2: Install from Source

1. Clone this repository
2. Run `setup_dependencies.bat` to install Python and FFmpeg
3. Run `build_installer.bat` to create the EXE
4. Or directly run `launcher.bat`

### Option 3: Run Without Installing

1. Clone this repository
2. Run `launcher.bat` (will auto-detect Python and FFmpeg)
3. Done!

## Quick Start Guide

### First Time Users (EXE)

1. **Run the EXE** - Double-click `Video Clipper.exe`
2. **Select Video** - Click "Browse" and choose your video
3. **Create Output Folder** - Click "Create Folder" (default: `D:\video_clips`)
4. **Add Clips** - Enter title, start/end times, click "+ Add to List"
5. **Start Clipping** - Click "🎬 Start Clipping" button
6. **Done!** - All clips saved in your output folder

### Using the EXE

The EXE automatically:
- Detects Python installation
- Detects FFmpeg installation
- Creates output folder
- Runs video clips

No installation or setup required!

## Usage Example

For a tutorial video `how-to.mp4`:

```
Clip 1: "Introduction"      → 00:00 to 00:30
Clip 2: "Problem Section"   → 00:30 to 01:45
Clip 3: "Solution Steps"    → 01:45 to 04:20
Clip 4: "Conclusion"       → 04:20 to 05:00
```

Output: 4 individual MP4 files in `video_clips\`

## Command Line Options

### As Source Code

```bash
# Run directly (auto-detects Python/FFmpeg)
launcher.bat

# Quick run (assumes Python in PATH)
run.bat

# Check setup before running
test_setup.bat
```

### Build EXE

```bash
# Install dependencies and build installer
setup_dependencies.bat

# Build the EXE
build_installer.bat
```

## File Structure

```
video-clipper/
├── Video Clipper.exe       # Standalone installer (built with build_installer.bat)
├── main.py                 # Main Python application
├── launcher.bat            # Launcher script (finds Python/FFmpeg automatically)
├── portable_launcher.bat   # Alternative launcher for unknown setups
├── setup_dependencies.bat  # Install Python, FFmpeg, PyInstaller
├── build_installer.bat     # Build the EXE installer
├── run.bat                 # Quick run script
├── test_setup.bat          # Check installation status
├── requirements.txt        # Dependencies (none needed!)
└── README.md               # This file
```

## Keyboard Shortcuts

- **Ctrl+O** - Browse video file (Tkinter default)
- **Ctrl+N** - New clip
- **Ctrl+X** - Clear all clips
- **F5** - Preview time range
- **Ctrl+S** - Start clipping

## Output Format

- **File Format**: MP4 (H.264)
- **Quality**: Same as source (no re-encoding)
- **Container**: MP4
- **Audio**: Preserved from source
- **Folder**: `video_clips\` or custom path

## Troubleshooting

### "Python not found"

**Solution 1**: Run `setup_dependencies.bat` to install Python
**Solution 2**: Run `build_installer.bat` which auto-installs dependencies

### "FFmpeg not found"

**Solution 1**: Run `winget install Gyan.FFmpeg`
**Solution 2**: Use the EXE which includes FFmpeg detection

### "Video won't load"

- Ensure video format is supported (MP4, AVI, MKV, MOV, WMV)
- Check file path - no special characters in filename
- Try copying video to desktop first

### EXE won't run

- Run as Administrator (some security features require this)
- Check Windows Defender isn't blocking execution
- Try running `build_installer.bat` to rebuild the EXE

## Keyboard Shortcuts

- **Ctrl+O** - Browse video file
- **Ctrl+N** - New clip
- **Ctrl+X** - Clear all clips
- **F5** - Preview time range
- **Ctrl+S** - Start clipping

## Limitations

- Maximum clip duration depends on available RAM
- Very large videos (>4GB) may take time to load
- Real-time preview not available (shows calculated duration only)
- FFmpeg must be installed or included in EXE

## Development

### Requirements

- Python 3.13+
- FFmpeg
- PyInstaller (for building EXE)

### Building

```bash
# Install dependencies
setup_dependencies.bat

# Build EXE
build_installer.bat
```

### Running Tests

```bash
# Check setup
test_setup.bat

# Run application
launcher.bat
```

## Credits

**Built for**: KoKo Isaac 🦅

**Technologies**:
- Python 3.13
- Tkinter (GUI)
- FFmpeg 8.0+
- PyInstaller

## License

MIT License - Feel free to use, modify, and distribute!

## Contributing

Contributions welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

---

Made with ❤️ by KoKo Isaac's Assistant
