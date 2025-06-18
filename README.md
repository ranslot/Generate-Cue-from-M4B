## 🎧 Generate Cue from M4B

This tool lets you convert `.m4b` audiobook chapter bookmarks into `.cue` files using **m4b-tool** and Python.

---

### 🔧 Features

* Extracts chapter data from `.m4b` files using **m4b-tool**
* Converts bookmarks to a standard `.cue` sheet
* Works on Windows (Batch + Python)
* Automatically names files based on the original `.m4b`

---

### 📁 Files

* `generate_cue_from_m4b.bat` — Batch script that:

  * Extracts chapter info using **m4b-tool**
  * Calls the Python script to generate a `.cue` file
* `m4b_tool_text_to_cue.py` — Python script that:

  * Converts chapter JSON into `.cue` format
* `m4b-tool.phar` — m4b-tool file to Extracts chapter info
---

### 📦 Requirements

* [m4b-tool](https://github.com/iwalton3/m4b-tool) — **must be in the same folder as the scripts**
* [PHP](https://www.php.net/) with **zip** and **curl** extensions enabled
* [Python 3.x](https://www.python.org/)

---

### ▶️ How to Use

1. Put your `.m4b` file and the `m4b-tool` executable in the same folder as the scripts

2. **Drag and drop** the `.m4b` file onto `generate_cue.bat`
   *or* run it via command line:

   ```bash
   generate_cue.bat yourbook.m4b
   ```

3. It will generate:

   * `yourbook.cue` — cue sheet

---