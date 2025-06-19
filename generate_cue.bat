@echo off
setlocal

set "inputFile=%~1"
if "%inputFile%"=="" (
    echo Usage: %~nx0 ^<audiobook.m4b^>
    pause
    exit /b
)

set "baseName=%~n1"
set "jsonFile=%baseName%.json"
set "cueFile=%baseName%.cue"

echo Extracting chapters from "%inputFile%"...
ffprobe -i "%inputFile%" -print_format json -show_chapters -loglevel error > "%jsonFile%"

if not exist "%jsonFile%" (
    echo Failed to generate chapter JSON. Aborting.
    pause
    exit /b
)

echo Running Node.js script to generate .cue file...
call node generate_cue.js "%baseName%"

:: Wait until cue file exists before cleanup
if exist "%cueFile%" (
    echo Deleting temporary JSON file...
    del "%jsonFile%"
    echo Done. CUE file created: %cueFile%
) else (
    echo Node script did not produce a .cue file. Keeping JSON for debug.
)

pause
endlocal
