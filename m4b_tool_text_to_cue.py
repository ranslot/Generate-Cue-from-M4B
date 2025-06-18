import sys
import os
import re

def time_to_cue(timestamp):
    """
    Convert HH:MM:SS.mmm to MM:SS:FF format for CUE (75 frames/sec).
    """
    if '.' in timestamp:
        time_part, ms_part = timestamp.rsplit('.', 1)
    else:
        time_part, ms_part = timestamp, "0"

    h, m, s = map(int, time_part.split(':'))
    milliseconds = int(ms_part)

    total_seconds = h * 3600 + m * 60 + s + milliseconds / 1000.0
    minutes = int(total_seconds // 60)
    seconds = int(total_seconds % 60)
    frames = int((total_seconds - int(total_seconds)) * 75)

    return f"{minutes:02}:{seconds:02}:{frames:02}"

def parse_chapters(lines):
    """
    Extract chapter timestamps and titles.
    """
    chapters = []
    chapter_re = re.compile(r"^(\d{2}:\d{2}:\d{2}\.\d{3})\s+(.*)$")
    for line in lines:
        match = chapter_re.match(line.strip())
        if match:
            timestamp, title = match.groups()
            cue_ts = time_to_cue(timestamp)
            chapters.append((title.strip(), cue_ts))
    return chapters

def generate_cue(chapters, audio_file):
    """
    Build CUE sheet content.
    """
    filename = os.path.basename(audio_file)
    cue = [f'FILE "{filename}" AAC']
    for i, (title, time) in enumerate(chapters):
        cue.append(f'  TRACK {i+1:02d} AUDIO')
        cue.append(f'    TITLE "{title}"')
        cue.append(f'    INDEX 01 {time}')
    return "\n".join(cue)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python m4b_text_to_cue.py <chapters.txt> <audio_file.m4b>")
        sys.exit(1)

    chapters_file = sys.argv[1]
    audio_file = sys.argv[2]

    with open(chapters_file, encoding='utf-8') as f:
        lines = f.readlines()

    chapters = parse_chapters(lines)
    if not chapters:
        print("No valid chapters found.")
        sys.exit(1)

    cue_text = generate_cue(chapters, audio_file)

    cue_filename = os.path.splitext(audio_file)[0] + ".cue"
    with open(cue_filename, "w", encoding="utf-8") as f:
        f.write(cue_text)

    print(f"CUE sheet written to: {cue_filename}")
