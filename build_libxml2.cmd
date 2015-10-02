rem # 
rem # Based on email from Christoph Gohlke <cgohlke@uci.edu>
rem # 
rem # change configure.in to be configure.ac on line 17 of libxml2-2.9.2\win32\configure.js
rem # 

setlocal
CALL msvc10-x64.cmd

set SOURCEDIR=libxml2-2.9.2
set include=%include%;%INCLIB%
set lib=%lib%;%INCLIB%
set BUILDDIR=%SOURCEDIR%-vc10-x64

copy /Y %SOURCEDIR%\include\*.h %INCLIB%\
rd /q /s %INCLIB%\libxml
mkdir %INCLIB%\libxml
copy /Y %SOURCEDIR%\include\libxml\*.h %INCLIB%\libxml

cd %SOURCEDIR%\win32
cscript configure.js compiler=msvc prefix=%BUILDDIR% debug=no python=yes zlib=yes lzma=no
nmake /f Makefile.msvc clean
nmake /f Makefile.msvc
nmake /f Makefile.msvc install

copy /Y /B %BUILDDIR%\bin\*.dll %INCLIB%\
copy /Y /B %BUILDDIR%\lib\*.lib %INCLIB%\
copy /Y /B %BUILDDIR%\lib\libxml2_a.lib %INCLIB%\xml2.lib 

cd ..\..
endlocal

