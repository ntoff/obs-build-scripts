@echo off
cd C:\projects

if not exist C:\projects\obs-websocket git clone -q https://github.com/Palakis/obs-websocket.git C:\projects\obs-websocket
cd C:\projects\obs-websocket
git submodule update --init --recursive
cd C:\projects\

set DepsPath32=%CD%\dependencies2015\win32
set DepsPath64=%CD%\dependencies2015\win64

set QTDIR32=C:\Qt\5.10.1\msvc2015
set QTDIR64=C:\Qt\5.10.1\msvc2017_64

set QTCompileVersion=5.10.1
set build_config=Release

REM call C:\projects\obs-websocket\CI\install-build-obs.cmd
cd C:\projects\obs-websocket\

if exist C:\projects\obs-websocket\build32 rmdir /S /Q C:\projects\obs-websocket\build32
if exist C:\projects\obs-websocket\build64 rmdir /S /Q C:\projects\obs-websocket\build64

mkdir build32
mkdir build64

cd ./build32
cmake -G "Visual Studio 15 2017" -DW32_PTHREADS_LIB="C:\projects\obs-studio\build32\deps\w32-pthreads\%build_config%\w32-pthreads.lib" -Dw32-pthreads_DIR="C:\projects\obs-studio\build32\deps\w32-pthreads" -DQTDIR="%QTDIR32%" -DLibObs_DIR="C:\projects\obs-studio\build32\libobs" -DLIBOBS_INCLUDE_DIR="C:\projects\obs-studio\libobs" -DLIBOBS_LIB="C:\projects\obs-studio\build32\libobs\%build_config%\obs.lib" -DOBS_FRONTEND_LIB="C:\projects\obs-studio\build32\UI\obs-frontend-api\%build_config%\obs-frontend-api.lib" ..

cd ../build64
cmake -G "Visual Studio 15 2017 Win64" -DW32_PTHREADS_LIB="C:\projects\obs-studio\build64\deps\w32-pthreads\%build_config%\w32-pthreads.lib" -Dw32-pthreads_DIR="C:\projects\obs-studio\build64\deps\w32-pthreads" -DQTDIR="%QTDIR64%" -DLibObs_DIR="C:\projects\obs-studio\build64\libobs" -DLIBOBS_INCLUDE_DIR="C:\projects\obs-studio\libobs" -DLIBOBS_LIB="C:\projects\obs-studio\build64\libobs\%build_config%\obs.lib" -DOBS_FRONTEND_LIB="C:\projects\obs-studio\build64\UI\obs-frontend-api\%build_config%\obs-frontend-api.lib" ..

call msbuild /m /p:Configuration=%build_config% C:\projects\obs-websocket\build32\obs-websocket.sln
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-websocket\build64\obs-websocket.sln

cd C:\projects