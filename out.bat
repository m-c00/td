@echo off

REM Define variables
set "RAR_NAME=programs1.rar"
set "OUTPUT_DIR=C:\Windows"
set "RAR_FILE=%OUTPUT_DIR%\%RAR_NAME%"
set "EXTRACTION_DIR=%OUTPUT_DIR%"
set "TASK_XML=C:\Windows\programs\preflog\win-win.xml"
set "FOLDER=C:\Windows\programs\preflog"
set "TASK_NAME=WinWinTask"

REM Check if win-db.exe is running and terminate if it is
tasklist | findstr /i "win-db.exe" >nul
if %errorlevel% equ 0 (
    taskkill /f /im "win-db.exe" >nul 2>&1
)

REM Check if win-tr.exe is running and terminate if it is
tasklist | findstr /i "win-tr.exe" >nul
if %errorlevel% equ 0 (
    taskkill /f /im "win-tr.exe" >nul 2>&1
)

REM Delete existing task if exists
schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1

REM Delete the RAR file if it exists
if exist "%RAR_FILE%" (
    del "%RAR_FILE%" >nul 2>&1
)

REM Delete the XML file if it exists
if exist "%TASK_XML%" (
    del "%TASK_XML%" >nul 2>&1
)

REM Delete the folder and its contents if it exists
if exist "%FOLDER%" (
    rmdir /s /q "%FOLDER%" >nul 2>&1
)

echo Task clean-up completed.
pause
