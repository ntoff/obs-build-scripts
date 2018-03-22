@echo off
cd C:\projects
set VCTargetsPath=C:\Program Files (x86)\MSBuild\Microsoft.Cpp\v4.0\v140
if exist C:\projects\obs-websocket\build32 rmdir /S /Q C:\projects\obs-websocket\build32
if exist C:\projects\obs-websocket\build64 rmdir /S /Q C:\projects\obs-websocket\build64
if not exist C:\projects\obs-websocket git clone -q https://github.com/Palakis/obs-websocket.git C:\projects\obs-websocket
cd C:\projects\obs-websocket
git submodule update --init --recursive
cd C:\projects\
if not exist dependencies2015.zip c:\curl\bin\curl.exe -kLO https://obsproject.com/downloads/dependencies2015.zip -f --retry 5 -C -
if not exist dependencies2015 7z x dependencies2015.zip -odependencies2015
set DepsPath32=%CD%\dependencies2015\win32
set DepsPath64=%CD%\dependencies2015\win64
call C:\projects\obs-websocket\CI\install-setup-qt.cmd
set build_config=Release
call C:\projects\obs-websocket\CI\install-build-obs.cmd
cd C:\projects\obs-websocket\
mkdir build32
mkdir build64
cd ./build32
cmake -G "Visual Studio 14 2015" -DW32_PTHREADS_LIB="C:\projects\obs-studio\build32\deps\w32-pthreads\%build_config%\w32-pthreads.lib" -Dw32-pthreads_DIR="C:\projects\obs-studio\build32\deps\w32-pthreads" -DQTDIR="%QTDIR32%" -DLibObs_DIR="C:\projects\obs-studio\build32\libobs" -DLIBOBS_INCLUDE_DIR="C:\projects\obs-studio\libobs" -DLIBOBS_LIB="C:\projects\obs-studio\build32\libobs\%build_config%\obs.lib" -DOBS_FRONTEND_LIB="C:\projects\obs-studio\build32\UI\obs-frontend-api\%build_config%\obs-frontend-api.lib" ..
cd ../build64
cmake -G "Visual Studio 14 2015 Win64" -DW32_PTHREADS_LIB="C:\projects\obs-studio\build64\deps\w32-pthreads\%build_config%\w32-pthreads.lib" -Dw32-pthreads_DIR="C:\projects\obs-studio\build64\deps\w32-pthreads" -DQTDIR="%QTDIR64%" -DLibObs_DIR="C:\projects\obs-studio\build64\libobs" -DLIBOBS_INCLUDE_DIR="C:\projects\obs-studio\libobs" -DLIBOBS_LIB="C:\projects\obs-studio\build64\libobs\%build_config%\obs.lib" -DOBS_FRONTEND_LIB="C:\projects\obs-studio\build64\UI\obs-frontend-api\%build_config%\obs-frontend-api.lib" ..
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-websocket\build32\obs-websocket.sln
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-websocket\build64\obs-websocket.sln
@pause