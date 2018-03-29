if not exist c:\projects\obs-studio git clone --recursive https://github.com/jp9000/obs-studio.git c:\projects\obs-studio
cd C:\projects\
REM 2015 deps are compatible with vs2017
if not exist dependencies2015.zip c:\curl\bin\curl.exe -kLO https://obsproject.com/downloads/dependencies2015.zip -f --retry 5 -C -
if not exist dependencies2015 7z x dependencies2015.zip -odependencies2015

set DepsPath32=%CD%\dependencies2015\win32
set DepsPath64=%CD%\dependencies2015\win64

set QTDIR32=C:\Qt\5.10.1\msvc2015
set QTDIR64=C:\Qt\5.10.1\msvc2017_64

set QTCompileVersion=5.10.1
set build_config=Release

cd C:\projects\obs-studio\

if exist build32 rmdir /S /Q build32
if exist build64 rmdir /S /Q build64

REM set CMAKE_PREFIX_PATH=%QTDIR64%
mkdir build32
mkdir build64

cd ./build32
cmake -G "Visual Studio 15 2017" -DQTDIR="%QTDIR32%" -DDepsPath="%DepsPath32%" -DCOPIED_DEPENDENCIES=false -DCOPY_DEPENDENCIES=true ..

cd ../build64
cmake -G "Visual Studio 15 2017 Win64" -DQTDIR="%QTDIR64%" -DDepsPath="%DepsPath64%" -DCOPIED_DEPENDENCIES=false -DCOPY_DEPENDENCIES=true ..

call msbuild /m /p:Configuration=%build_config% C:\projects\obs-studio\build32\obs-studio.sln /fl /flp:logfile=obs-studio_x86.log
call msbuild /m /p:Configuration=%build_config% C:\projects\obs-studio\build64\obs-studio.sln /fl /flp:logfile=obs-studio_x64.log

cd C:\projects\
