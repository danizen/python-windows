rem # 
rem # Based on email from Christoph Gohlke <cgohlke@uci.edu>
rem # 
rem # Need to have CMAKE installed:
rem #   - Download CMAKE ZIP
rem #   - Expand somewhere
rem #   - Add somewhere to path
rem # 

setlocal
CALL msvc14-x64.cmd

set SOURCEDIR=win-iconv-0.0.6
set SOLUTION=win_iconv.sln

set CMAKEOPT=^
    -DCMAKE_CONFIGURATION_TYPES=Release ^
    -DCMAKE_USE_RELATIVE_PATHS=ON ^
    -DCMAKE_SKIP_RPATH=ON ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DBUILD_STATIC=ON ^
    -DBUILD_SHARED=OFF

set BUILDDIR=%SOURCEDIR%-vc14-x64

copy /Y %SOURCEDIR%\iconv.h %INCLIB%\
copy /Y %SOURCEDIR%\mlang.h %INCLIB%\

rd /q /s %BUILDDIR%
cmake -G"Visual Studio 10 Win64" -H%SOURCEDIR% -B%BUILDDIR%  %CMAKEOPT%
cd %BUILDDIR%
devenv %SOLUTION% /build "Release"

copy /Y /B Release\iconv.lib %INCLIB%\
copy /Y /B Release\iconv.lib %INCLIB%\libiconv.lib 
copy /Y /B Release\iconv.lib %INCLIB%\iconv_a.lib
copy /Y /B Release\*.exe %INCLIB%\ 

cd ..
endlocal

