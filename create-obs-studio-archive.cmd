robocopy C:\projects\obs-studio\build32\rundir\Release C:\projects\obs-studio\build\ /E /XF .gitignore
robocopy C:\projects\obs-studio\build64\rundir\Release C:\projects\obs-studio\build\ /E /XC /XN /XO /XF .gitignore
7z a obs-studio.zip C:\projects\obs-studio\build\*