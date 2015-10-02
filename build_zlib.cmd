rem # 
rem # Based on email from Christoph Gohlke <cgohlke@uci.edu>
rem # 

setlocal
CALL msvc10-x64.cmd
cd zlib-1.2.8

copy /Y zlib.h %INCLIB%\
copy /Y zutil.h %INCLIB%\
copy /Y zconf.h %INCLIB%\

cd contrib\masmx64
call bld_ml64.bat
cd ..\..
nmake -f win32/Makefile.msc clean
nmake -f win32/Makefile.msc AS=ml64 LOC="-DASMV -DASMINF -I." OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
nmake -f win32/Makefile.msc test testdll

copy /Y /B zlib1.dll %INCLIB%\
copy /Y /B zlib.lib %INCLIB%\
copy /Y /B zlib.lib %INCLIB%\z.lib
copy /Y /B zdll.lib %INCLIB%\
copy /Y /B zdll.lib %INCLIB%\zlib1.lib

cd ..
endlocal

