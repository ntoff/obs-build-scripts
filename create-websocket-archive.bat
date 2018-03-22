@echo off
FOR /F "tokens=* USEBACKQ" %%F IN (`git -C c:\projects\obs-websocket  rev-parse --abbrev-ref HEAD`) DO (
    SET branch=%%F
    rem ECHO %branch%
)
FOR /F "tokens=* USEBACKQ" %%F IN (`git -C c:\projects\obs-websocket rev-parse --short --verify %branch%`) DO (
    SET hash=%%F
    rem ECHO %hash%
)
7z a "C:\projects\obs-websocket_%branch%_%hash%.zip" C:\projects\obs-websocket\release\*
@pause
