@echo off
set PATH=%PATH%;"C:\\Program Files (x86)\\Inno Setup 5"
@iscc "C:\projects\obs-websocket\installer\installer.iss"

FOR /F "tokens=* USEBACKQ" %%F IN (`git -C c:\projects\obs-websocket  rev-parse --abbrev-ref HEAD`) DO (
    SET branch=%%F
    rem ECHO %branch%
)
FOR /F "tokens=* USEBACKQ" %%F IN (`git -C c:\projects\obs-websocket rev-parse --short --verify %branch%`) DO (
    SET hash=%%F
    rem ECHO %hash%
)

move C:\projects\obs-websocket\installer\Output\obs-websocket-git-Windows-Installer.exe c:\projects\obs-websocket_%branch%_%hash%_Windows-Installer.exe
@echo "Installer located at c:\projects\obs-websocket_%branch%_%hash%_Windows-Installer.exe"
@pause