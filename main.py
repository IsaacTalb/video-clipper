"""
Video Clipper - GUI Tool for Clipping Videos
Built for KoKo Isaac - https://github.com/kokoisaac/video-clipper
"""

import tkinter as tk
from tkinter import filedialog, messagebox, ttk
import subprocess
import os
import re

__version__ = "1.0.0"

class VideoClipper:
    def __init__(self, root):
        self.root = root
        self.root.title("Video Clipper - KoKo Isaac's Tool v1.0.0")
        self.root.geometry("800x600")
        self.root.resizable(False, False)

        # Set window icon (optional, can be omitted if no icon file)
        self.root.iconbitmap("")

        self.video_path = ""
        self.clips = []

        self.setup_ui()

    def setup_ui(self):
        # Main container
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.grid(row=0, column=0, sticky="nsew")

        # Title
        title_label = ttk.Label(
            main_frame,
            text="🎬 Video Clipper",
            font=("Arial", 18, "bold")
        )
        title_label.grid(row=0, column=0, pady=(0, 20))

        # Video Selection
        ttk.Label(main_frame, text="Video File:").grid(row=1, column=0, sticky="w", pady=(0, 5))
        self.video_path_var = tk.StringVar()
        video_entry = ttk.Entry(main_frame, textvariable=self.video_path_var, width=50)
        video_entry.grid(row=1, column=1, pady=(0, 10), sticky="ew")

        browse_btn = ttk.Button(main_frame, text="Browse", command=self.browse_video)
        browse_btn.grid(row=1, column=2, pady=(0, 10))

        # Clips List
        ttk.Label(main_frame, text="Video Clips:").grid(row=2, column=0, sticky="w", pady=(10, 5))

        clips_frame = ttk.Frame(main_frame)
        clips_frame.grid(row=3, column=0, columnspan=3, sticky="nsew", pady=(0, 10))

        self.clips_listbox = tk.Listbox(clips_frame, height=8, width=60)
        self.clips_listbox.pack(side="left", fill="both", expand=True)

        scroll_btn = ttk.Button(clips_frame, text="+ Add Clip", command=self.add_clip)
        scroll_btn.pack(side="left", padx=(5, 0))

        # Clip Details
        clip_frame = ttk.LabelFrame(main_frame, text="Clip Details", padding="15")
        clip_frame.grid(row=4, column=0, columnspan=3, sticky="ew", pady=(0, 10))

        # Title
        ttk.Label(clip_frame, text="Clip Title:").grid(row=0, column=0, sticky="w")
        self.clip_title_var = tk.StringVar(value="clip_")
        ttk.Entry(clip_frame, textvariable=self.clip_title_var, width=30).grid(row=0, column=1, sticky="w", pady=5)

        # Time Range
        time_frame = ttk.Frame(clip_frame)
        time_frame.grid(row=1, column=0, columnspan=2, sticky="ew", pady=5)

        ttk.Label(time_frame, text="Start (mm:ss):").grid(row=0, column=0, sticky="w")
        self.start_time_var = tk.StringVar(value="00:00")
        ttk.Entry(time_frame, textvariable=self.start_time_var, width=8).grid(row=0, column=1, padx=5)

        ttk.Label(time_frame, text="End (mm:ss):").grid(row=0, column=2, sticky="w")
        self.end_time_var = tk.StringVar(value="00:05")
        ttk.Entry(time_frame, textvariable=self.end_time_var, width=8).grid(row=0, column=3, padx=5)

        # Duration Preview
        ttk.Label(time_frame, text="Duration:").grid(row=0, column=4, sticky="w", padx=(10, 5))
        self.duration_var = tk.StringVar(value="00:05")
        ttk.Label(time_frame, textvariable=self.duration_var, foreground="blue").grid(row=0, column=5, sticky="w")

        # Buttons
        btn_frame = ttk.Frame(main_frame)
        btn_frame.grid(row=5, column=0, columnspan=3, pady=15)

        add_clip_btn = ttk.Button(btn_frame, text="+ Add to List", command=self.add_clip)
        add_clip_btn.pack(side="left", padx=5)

        preview_btn = ttk.Button(btn_frame, text="Preview Time", command=self.preview_time)
        preview_btn.pack(side="left", padx=5)

        clear_btn = ttk.Button(btn_frame, text="Clear All", command=self.clear_clips)
        clear_btn.pack(side="left", padx=5)

        # Export Section
        export_frame = ttk.LabelFrame(main_frame, text="Export Settings", padding="15")
        export_frame.grid(row=6, column=0, columnspan=3, sticky="ew", pady=(0, 10))

        ttk.Label(export_frame, text="Output Directory:").grid(row=0, column=0, sticky="w")
        self.output_dir_var = tk.StringVar(value="video_clips")
        ttk.Entry(export_frame, textvariable=self.output_dir_var, width=40).grid(row=0, column=1, sticky="ew", pady=5)

        create_dir_btn = ttk.Button(export_frame, text="Create Folder", command=self.create_output_dir)
        create_dir_btn.grid(row=0, column=2, padx=5)

        # Process Button
        process_btn = ttk.Button(
            main_frame,
            text="🎬 Start Clipping",
            command=self.process_clips,
            style="Accent.TButton"
        )
        process_btn.grid(row=7, column=0, columnspan=3, pady=20)

        # Progress
        self.progress = ttk.Progressbar(main_frame, mode="indeterminate")
        self.progress.grid(row=8, column=0, columnspan=3, sticky="ew", pady=(10, 5))

        # Status Label
        self.status_var = tk.StringVar(value="Ready")
        ttk.Label(main_frame, textvariable=self.status_var).grid(row=9, column=0, columnspan=3, pady=5)

        # Configure grid weights
        main_frame.columnconfigure(1, weight=1)

    def browse_video(self):
        file_path = filedialog.askopenfilename(
            title="Select Video File",
            filetypes=[
                ("Video Files", "*.mp4 *.avi *.mkv *.mov *.wmv *.flv *.webm"),
                ("All Files", "*.*")
            ]
        )
        if file_path:
            self.video_path = file_path
            self.video_path_var.set(file_path)

    def create_output_dir(self):
        output_dir = self.output_dir_var.get()
        try:
            os.makedirs(output_dir, exist_ok=True)
            messagebox.showinfo("Success", f"Created folder:\n{os.path.abspath(output_dir)}")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to create folder:\n{e}")

    def time_to_seconds(self, time_str):
        """Convert mm:ss to seconds"""
        try:
            minutes, seconds = map(int, time_str.split(':'))
            return minutes * 60 + seconds
        except:
            return 0

    def seconds_to_time(self, seconds):
        """Convert seconds to mm:ss"""
        minutes = int(seconds // 60)
        secs = int(seconds % 60)
        return f"{minutes:02d}:{secs:02d}"

    def preview_time(self):
        try:
            start = self.time_to_seconds(self.start_time_var.get())
            end = self.time_to_seconds(self.end_time_var.get())

            if start >= end:
                messagebox.showerror("Error", "Start time must be before end time")
                return

            duration = end - start
            self.duration_var.set(self.seconds_to_time(duration))
        except:
            messagebox.showerror("Error", "Invalid time format. Use mm:ss")

    def add_clip(self):
        if not self.video_path:
            messagebox.showwarning("Warning", "Please select a video file first")
            return

        try:
            start = self.time_to_seconds(self.start_time_var.get())
            end = self.time_to_seconds(self.end_time_var.get())

            if start >= end:
                messagebox.showerror("Error", "Start time must be before end time")
                return

            title = self.clip_title_var.get().strip() or f"clip_{len(self.clips) + 1}"

            clip_info = {
                'title': title,
                'start': start,
                'end': end,
                'duration': end - start
            }

            self.clips.append(clip_info)
            self.clips_listbox.insert(tk.END, f"{title}: {self.seconds_to_time(start)} - {self.seconds_to_time(end)}")

        except Exception as e:
            messagebox.showerror("Error", f"Failed to add clip: {e}")

    def clear_clips(self):
        self.clips = []
        self.clips_listbox.delete(0, tk.END)

    def get_ffmpeg_path(self):
        """Find FFmpeg path"""
        possible_paths = [
            r"C:\Program Files\ffmpeg\bin\ffmpeg.exe",
            r"C:\ffmpeg\bin\ffmpeg.exe",
            os.path.join(os.environ.get('LOCALAPPDATA', ''), 'ffmpeg', 'bin', 'ffmpeg.exe'),
        ]

        for path in possible_paths:
            if os.path.exists(path):
                return path

        return "ffmpeg"  # Try from PATH

    def process_clips(self):
        if not self.video_path:
            messagebox.showwarning("Warning", "Please select a video file first")
            return

        if not self.clips:
            messagebox.showwarning("Warning", "Please add at least one clip")
            return

        output_dir = self.output_dir_var.get()
        if not os.path.exists(output_dir):
            try:
                os.makedirs(output_dir, exist_ok=True)
            except Exception as e:
                messagebox.showerror("Error", f"Failed to create output folder:\n{e}")
                return

        self.progress.start()
        self.status_var.set("Processing...")

        # Get FFmpeg path
        ffmpeg_path = self.get_ffmpeg_path()

        # Process each clip
        for i, clip in enumerate(self.clips):
            try:
                clip_num = i + 1
                output_path = os.path.join(output_dir, f"{clip['title']}.mp4")

                # Generate ffmpeg command
                ffmpeg_cmd = [
                    ffmpeg_path,
                    '-i', self.video_path,
                    '-ss', self.seconds_to_time(clip['start']),
                    '-to', self.seconds_to_time(clip['end']),
                    '-c', 'copy',
                    output_path
                ]

                # Run ffmpeg
                result = subprocess.run(
                    ffmpeg_cmd,
                    capture_output=True,
                    text=True,
                    check=True
                )

                self.status_var.set(f"Processed: {clip['title']} ({clip_num}/{len(self.clips)})")

            except subprocess.CalledProcessError as e:
                messagebox.showerror("Error", f"Failed to clip {clip['title']}:\n{e.stderr}")
                self.progress.stop()
                self.status_var.set("Error")
                return
            except Exception as e:
                messagebox.showerror("Error", f"Failed to clip {clip['title']}:\n{e}")
                self.progress.stop()
                self.status_var.set("Error")
                return

        self.progress.stop()
        self.status_var.set(f"✓ All clips processed successfully!")
        messagebox.showinfo(
            "Success",
            f"All clips saved to:\n{os.path.abspath(output_dir)}\n\n"
            f"Total clips: {len(self.clips)}"
        )

if __name__ == "__main__":
    root = tk.Tk()
    app = VideoClipper(root)
    root.mainloop()
