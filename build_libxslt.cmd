rem # 
rem # Based on email from Christoph Gohlke <cgohlke@uci.edu>
rem # 
rem # CHanges to src:
rem #    Only on VS 2015 - must modify libxslt-1.1.28 for __vsprintf __printf issues
rem #    Must remove OPT:NOWIN98 from Makefile.msvc
rem # 
rem # 
rem # 

setlocal
CALL msvc10-x64.cmd

set SOURCEDIR=libxslt-1.1.28

set include=%include%;%INCLIB%
set lib=%lib%;%INCLIB%

set BUILDDIR=%SOURCEDIR%-vc10-x64

rd /q /s %INCLIB%\libexslt
mkdir %INCLIB%\libexslt
copy /Y %SOURCEDIR%\libexslt\*.h %INCLIB\libexslt

rd /q /s %INCLIB%\libxslt
mkdir %INCLIB%\libxslt
copy /Y %SOURCEDIR%\libxslt\*.h %INCLIB\libxslt

cd %SOURCEDIR%\win32
cscript configure.js compiler=msvc prefix=%BUILDDIR% debug=no zlib=yes
nmake /f Makefile.msvc clean
nmake /f Makefile.msvc
nmake /f Makefile.msvc install

copy /Y /B %BUILDDIR%\bin\*.exe %INCLIB%\
copy /Y /B %BUILDDIR%\lib\*.lib %INCLIB%\
copy /Y /B %BUILDDIR%\lib\*.dll %INCLIB%\
copy /Y /B %BUILDDIR%\lib\libexslt_a.lib %INCLIB%\xslt.lib
copy /Y /B %BUILDDIR%\lib\libxslt_a.lib %INCLIB%\xslt.lib

cd ..\..
endlocal

