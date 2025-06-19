@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: drag and drop .m4b files onto this script OR run:
    echo.
    echo     %~nx0 file1.m4b file2.m4b ...
    echo.
    pause
    exit /b
)

:: Loop through each input file
for %%F in (%*) do (
    set "inputFile=%%~fF"
    set "baseName=%%~nF"
    set "jsonFile=!baseName!.json"
    set "cueFile=!baseName!.cue"

    echo ---------------------------------------
    echo Processing: !inputFile!
    echo Extracting chapters with ffprobe...

    ffprobe -i "!inputFile!" -print_format json -show_chapters -loglevel error > "!jsonFile!"

    if not exist "!jsonFile!" (
        echo [Error] Failed to generate chapter JSON for !inputFile!
        echo Skipping...
        echo.
        continue
    )

    echo Running Node.js to generate cue file...
    call node generate_cue.js "!baseName!"

    if exist "!cueFile!" (
        echo [OK] Success: !cueFile! created.
        echo Cleaning up JSON...
        del "!jsonFile!"
    ) else (
        echo [Error] Node script did not produce a cue file.
        echo JSON retained for debugging: !jsonFile!
    )
    echo.
)

echo [OK] All files processed.
pause
endlocal
