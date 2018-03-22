@echo off
REM This will (hopefully) build OBS Studio's base
REM Certain plugins like the vlc source, and browser source, are not built as they require other dependencies
REM so this is just the minimum build in order to get OBS Studio to function.

REM If the obs studio source files don't exist, get them. If they do exist, check for an existing build and remove it.
if not exist c:\projects\obs-studio git clone --recursive https://github.com/jp9000/obs-studio.git c:\projects\obs-studio
if exist C:\projects\obs-studio\build32 rmdir /S /Q C:\projects\obs-studio\build32
if exist C:\projects\obs-studio\build64 rmdir /S /Q C:\projects\obs-studio\build64
cd C:\projects\
REM Fetch the dependencies and unzip them if not already done
if not exist dependencies2015.zip c:\curl\bin\curl.exe -kLO https://obsproject.com/downloads/dependencies2015.zip -f --retry 5 -C -
if not exist dependencies2015 7z x dependencies2015.zip -odependencies2015
REM Set up the environment variables
REM Don't forget to set VCTargetsPath to the correct version for the compiler used, in this case visual studio 2015
set VCTargetsPath=C:\Program Files (x86)\MSBuild\Microsoft.Cpp\v4.0\v140
set DepsPath32=%CD%\dependencies2015\win32
set DepsPath64=%CD%\dependencies2015\win64
REM You'll need to install the QT library https://download.qt.io/official_releases/qt/5.10/5.10.1/
set QTDIR32=C:\Qt\5.10.1\msvc2015
set QTDIR64=C:\Qt\5.10.1\msvc2015_64
set QTCompileVersion=5.10.1
REM Build type: Release (smaller footprint), RelWithDebInfo (what I think OBS studio ships with, larger footprint but more debug info for crash logs)
set build_config=Release
REM Set up the build directories
cd C:\projects\obs-studio\
mkdir build32
mkdir build64
REM cMake it so...
cd ./build32
cmake -G "Visual Studio 14 2015" -DQTDIR="%QTDIR32%" -DDepsPath="%DepsPath32%" ..
cd ../build64
cmake -G "Visual Studio 14 2015 Win64" -DQTDIR="%QTDIR64%" -DDepsPath="%DepsPath64%" ..
REM Build and pray
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-studio\build32\obs-studio.sln
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-studio\build64\obs-studio.sln
cd C:\projects\
call create-obs-studio-archive.cmd