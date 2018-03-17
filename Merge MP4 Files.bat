:: Requires ffmpeg.exe - you can download that here:  https://ffmpeg.zeranoe.com/builds/ 
TITLE Merge .mp4 videos
ECHO OFF
mode con: cols=150 lines=30
CLS
:MENU
CLS
ECHO.
ECHO __________________________________
ECHO.
ECHO  Join .mp4 files into single file  
ECHO __________________________________
ECHO.
ECHO. The files you are going to merge MUST be .mp4 files
ECHO.
ECHO  This will join the files in alphabetical order.
ECHO.
ECHO  1 - Merge .mp4 files into single .mp4 file
ECHO  0 - Exit
ECHO.
SET /P M=Type 1 to join multiple .mp4 files into a single .mp4 file, then press ENTER:
IF %M%== 1 GOTO MERGE-MP4
IF %M%== 0 GOTO exit
GOTO MENU
:MERGE-MP4
if exist MergedFiles.mp4 (
    GOTO FILEEXISTS
) else (
    GOTO MERGE
)
GOTO MENU
:MERGE
(for %%i in (*.mp4) do @echo file '%%i') > FilesToMerge.txt
ffmpeg -f concat -safe 0 -i FilesToMerge.txt -c copy MergedFiles.mp4
if "%errorlevel%"=="0" GOTO DONE
if "%errorlevel%"=="1" GOTO ERROR
endlocal
GOTO MENU
:DONE
msg * "Merged .mp4 files"
GOTO MENU
:ERROR
msg * "Merge .mp4 files FAILED"
GOTO MENU
:FILEEXISTS
CLS
CHOICE /M "Output file already exists. Would you like to delete MergedFiles.mp4 and continue?"
if "%errorlevel%"=="0" GOTO MENU
if "%errorlevel%"=="1" GOTO DEL
GOTO MENU
:DEL
del MergedFiles.mp4
GOTO MERGE-MP4
:EXIT
EOF
