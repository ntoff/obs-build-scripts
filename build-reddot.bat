@echo off
set DepsPath32=C:\projects\dependencies2015\win32
set DepsPath64=C:\projects\dependencies2015\win64
set LibObs=c:\projects\obs-studio
set build_config=Release
cd C:\projects\obs-reddot\
if exist build32 rmdir /S /Q build32
if exist build64 rmdir /S /Q build64
mkdir build32
mkdir build64
cd ./build32
cmake -G "Visual Studio 15 2017" -DLibObs_DIR="%LibObs%\build32\libobs" -DLIBOBS_INCLUDE_DIR="%LibObs%\libobs" -DOBS_FRONTEND_LIB="%LibObs%\build32\UI\obs-frontend-api\%build_config%\obs-frontend-api.lib" ..
cd ../build64
cmake -G "Visual Studio 15 2017 Win64" -DLibObs_DIR="%LibObs%\build64\libobs" -DLIBOBS_INCLUDE_DIR="%LibObs%\libobs" -DOBS_FRONTEND_LIB="%LibObs%\build64\UI\obs-frontend-api\%build_config%\obs-frontend-api.lib" ..
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-reddot\build32\obs-reddot.sln
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-reddot\build64\obs-reddot.sln
cd C:\projects\obs-reddot\