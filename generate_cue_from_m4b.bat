@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: === Check requirements ===
where php >nul 2>nul || (
    echo Error: PHP not found in PATH.
    pause
    exit /b
)
where python >nul 2>nul || (
    echo Error: Python not found in PATH.
    pause
    exit /b
)

:: === Input check ===
if "%~1"=="" (
    echo Usage: %~nx0 yourfile.m4b
    echo Drag and drop a .m4b file onto this script or specify it.
    pause
    exit /b
)

:: === Paths ===
set "INPUT_M4B=%~1"
set "BASENAME=%~n1"
set "CHAPTERS_TXT=%BASENAME%_chapters.txt"
set "CUE_FILE=%BASENAME%.cue"

:: === Extract chapters from m4b-tool ===
echo Extracting chapters from "%INPUT_M4B%"...
php m4b-tool.phar meta "%INPUT_M4B%" > "%CHAPTERS_TXT%.tmp"

:: === Filter only chapter lines ===
findstr /R "^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\.[0-9][0-9][0-9] " "%CHAPTERS_TXT%.tmp" > "%CHAPTERS_TXT%"
del "%CHAPTERS_TXT%.tmp"

:: === Generate cue ===
echo Generating CUE sheet...
python m4b_tool_text_to_cue.py "%CHAPTERS_TXT%" "%INPUT_M4B%"

echo Done.
pause
ENDLOCAL
