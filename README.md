## 🎧 Generate Cue from M4B

This tool lets you convert `.m4b` audiobook chapter bookmarks into `.cue` files using `ffprobe` and Python.

---

### 🔧 Features

* Extracts chapter data from `.m4b` files using `ffprobe`
* Converts bookmarks to a standard `.cue` sheet
* Works on Windows (Batch + Python)
* Automatically names files based on the original `.m4b`

---

### 📁 Files

* `generate_cue.bat` — Batch script that:

  * Extracts chapter info as `.json`
  * Calls the Python script to generate a `.cue` file
* `generate_cue.py` — Python script that:

  * Converts chapter JSON into `.cue` format

---

### 📦 Requirements

* [FFmpeg](https://ffmpeg.org/) (make sure `ffprobe` is in your system PATH)
* [Python 3.x](https://www.python.org/)

---

### ▶️ How to Use

1. Put your `.m4b` file in the same folder as the scripts

2. **Drag and drop** the `.m4b` file onto `generate_cue.bat`
   *or* run it via command line:

   ```bash
   generate_cue.bat yourbook.m4b
   ```

3. It will generate:

   * `yourbook.json` — extracted chapter metadata
   * `yourbook.cue` — cue sheet

---

### 📌 Example

Given a file called `audiobook.m4b`, the script will output:

```
audiobook.json
audiobook.cue
```

A snippet of the `.cue` might look like:

```
FILE "audiobook.m4b" WAVE
  TRACK 01 AUDIO
    TITLE "Chapter 1"
    INDEX 01 00:00:00
  TRACK 02 AUDIO
    TITLE "Chapter 2"
    INDEX 01 05:32:42
```


