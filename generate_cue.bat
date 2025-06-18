@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Check for ffprobe and Python
where ffprobe >nul 2>nul || (
    echo Error: ffprobe not found in PATH.
    pause
    exit /b
)

where python >nul 2>nul || (
    echo Error: Python not found in PATH.
    pause
    exit /b
)

:: Check input file
if "%~1"=="" (
    echo Usage: %~nx0 yourfile.m4b
    echo Drag and drop a .m4b file onto this script or specify it.
    pause
    exit /b
)

:: Set paths
set "INPUT_M4B=%~1"
set "BASENAME=%~n1"
set "JSON_FILE=%BASENAME%.json"
set "CUE_FILE=%BASENAME%.cue"

:: Extract chapters
echo Extracting chapters from "%INPUT_M4B%" to "%JSON_FILE%"...
ffprobe -v quiet -print_format json -show_chapters -i "%INPUT_M4B%" > "%JSON_FILE%"

:: Generate cue sheet
echo Generating cue sheet "%CUE_FILE%" using Python...
python generate_cue.py "%JSON_FILE%" "%INPUT_M4B%" "%CUE_FILE%"

echo Done.
pause
ENDLOCAL
