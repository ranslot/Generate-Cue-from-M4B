const fs = require('fs');
const path = require('path');

// Helper: seconds → MM:SS:FF
function secondsToCueTime(seconds) {
  const totalSeconds = Math.floor(parseFloat(seconds));
  const minutes = Math.floor(totalSeconds / 60);
  const secs = totalSeconds % 60;
  const frames = Math.floor((parseFloat(seconds) - totalSeconds) * 75);
  return `${String(minutes).padStart(2, '0')}:${String(secs).padStart(2, '0')}:${String(frames).padStart(2, '0')}`;
}

// Get base filename from CLI argument
const baseName = process.argv[2];
if (!baseName) {
  console.error("Usage: node generateCue.js <baseName>");
  process.exit(1);
}

const jsonFile = path.resolve(__dirname, `${baseName}.json`);
if (!fs.existsSync(jsonFile)) {
  console.error(`File not found: ${jsonFile}`);
  process.exit(1);
}

// Parse chapters
const chaptersData = JSON.parse(fs.readFileSync(jsonFile, 'utf-8'));
const chapters = chaptersData.chapters;

if (!chapters || chapters.length === 0) {
  console.error('No chapters found in JSON.');
  process.exit(1);
}

// Build CUE content
let cueOutput = `FILE "${baseName}.m4b" AAC\n`;

chapters.forEach((chapter, index) => {
  const title = chapter.tags?.title || `Chapter ${index + 1}`;
  const time = secondsToCueTime(chapter.start_time);

  cueOutput += `  TRACK ${String(index + 1).padStart(2, '0')} AUDIO\n`;
  cueOutput += `    TITLE "${title}"\n`;
  cueOutput += `    INDEX 01 ${time}\n`;
});

// Write to output CUE file
const cueFile = path.resolve(__dirname, `${baseName}.cue`);
fs.writeFileSync(cueFile, cueOutput);
console.log(`Generated: ${cueFile}`);
