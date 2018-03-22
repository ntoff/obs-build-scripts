Batch files to build obs studio and any plugins I happen to mess with.

Not a fully automated script, dependencies mostly still need to be installed, along with visual studio / msbuild. This is mostly for my own information and batch files may require editing to match dependency install paths, etc.

Rough (and possibly incomplete) notes:

In no particular order that I'm aware of -

* Install the visual c++ building tools from http://landinghub.visualstudio.com/visual-cpp-build-tools (make sure to also install the windows 8.1 + 10 sdk and the vs2015 build tools)
* msbuild https://github.com/Microsoft/msbuild/releases
* Qt https://download.qt.io/official_releases/qt/5.10/5.10.1/
* cmake https://cmake.org/
* git https://git-scm.com/downloads
* 7zip https://www.7-zip.org/download.html (only if you want automatic zip/unzip of dependencies by the build batch file(s), obs studio doesn't require it for compilation)
* curl https://curl.haxx.se/download.html (again, not needed for compilation, it's only used to automatically download certain deps)

Once installed, make sure the QTDIR32 and QTDIR64 path variables inside the batch file(s) match where you installed the qt library, i.e. ``QTDIR32=C:\Qt\Qt5.10.1\5.10.1\msvc2015`` and ``QTDIR64=C:\Qt\Qt5.10.1\5.10.1\msvc2015_64``.

You'll also want to make sure ``7z``, ``cmake``, ``curl``, ``git``, and ``msbuild`` are in your "path". If you open a command prompt and none of them "just work" without having to type their full path, the compile may/will probably fail. Either set their paths inside the batch file somewhere at the top or add them to your system wide "path" variable (Computer -> properties -> advanced system settings -> environment variables).

From there, running ``build-obs-studio.bat`` *should* hopefully fetch the dependencies2015.zip file, unzip it, grab the obs source code and build it, and then create a zip archive of the built binaries. Certain plugins such as the vlc video source and browser source plugins are **not** built as those require extra dependencies.