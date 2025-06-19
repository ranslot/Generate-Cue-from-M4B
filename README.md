# M4B to CUE Generater

Convert `.m4b` audiobook files with chapter metadata into `.cue` sheets using `ffprobe`, Node.js, and a batch script.

---

## 📦 Features

- Extracts chapter metadata from `.m4b` using `ffprobe`
- Converts chapter start times (including time_base correction) to standard CUE format
- Automatically deletes temporary JSON files after processing
- Easy-to-use batch script with support for drag-and-drop or command-line input

---

## 🛠 Requirements

- [Node.js](https://nodejs.org/)
- [ffmpeg](https://ffmpeg.org/) (must be accessible via command line)
- Windows (for batch script execution)

---

## 📁 Files

- `generateCue.js` — Node.js script that generates a `.cue` file from JSON metadata.
- `generate_cue.bat` — Batch script to run the entire process.
- `README.md` — You're reading it!

---

## 🚀 Usage

### 🖱 Option 1: Drag-and-Drop

1. Drag your `.m4b` file onto `generate_cue.bat`.
2. The script will:
   - Run `ffprobe` to extract chapters
   - Generate a `.cue` file via Node.js
   - Delete the temporary `.json` file
3. Your `.cue` file will appear next to your `.m4b`.

### 💻 Option 2: Command Line

```sh
generate_cue.bat "MyAudiobook.m4b"
```

### 📋 Example Output
For a file named MyBook.m4b, the following files are generated:

MyBook.cue ✅ (Final output)

MyBook.json ❌ (Deleted automatically after success)

---

## 🧠 Notes

If an error occurs, the .json is kept for debugging.

---

## 🧪 Debugging
If something goes wrong:

Open a terminal and run the batch script manually to see error output.

Check that ffprobe is installed and in your system PATH.

Confirm your .m4b file has embedded chapters.

