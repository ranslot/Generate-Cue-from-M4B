import json
import sys
import os

def seconds_to_cue_time(seconds):
    minutes = int(seconds // 60)
    secs = int(seconds % 60)
    frames = int((seconds - secs) * 75)
    return f"{minutes:02d}:{secs:02d}:{frames:02d}"

def generate_cue_from_chapters(json_file, audio_file, output_cue_file):
    with open(json_file, 'r', encoding='utf-8') as f:
        data = json.load(f)

    chapters = data.get('chapters', [])
    if not chapters:
        print("No chapters found.")
        return

    cue_lines = []
    cue_lines.append(f'FILE "{os.path.basename(audio_file)}" WAVE')

    for i, ch in enumerate(chapters):
        title = ch.get('tags', {}).get('title', f"Chapter {i+1}")
        start = float(ch.get('start_time', 0))
        index = seconds_to_cue_time(start)
        cue_lines.append(f'  TRACK {i+1:02d} AUDIO')
        cue_lines.append(f'    TITLE "{title}"')
        cue_lines.append(f'    INDEX 01 {index}')

    with open(output_cue_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(cue_lines))

    print(f"CUE file '{output_cue_file}' generated successfully.")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python generate_cue.py <chapters.json> <audio.m4b> <output.cue>")
        sys.exit(1)
    generate_cue_from_chapters(sys.argv[1], sys.argv[2], sys.argv[3])
