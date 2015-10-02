# Python/Django C-Build for Development Tools #

Building most of Python/Django for Windows is not too hard.   Getting lxml working is pretty hard.   You need the following tools.

## Tools ##

- Visual Studio
    + Visual Studio 2010 with C++ for Python 3.4
    + Visual Studio 2015 with C++ for Python 3.5
- CYGWIN or Gnu Win32
    + You need a wget, tar, and unzip pretty much
- CMAKE for Windows
    + Download CMAKE as a ZIP
    + Unzip it somewhere
    + Put somewhere in your path
- Python itself should be installed, with pip before you build


## Download Sources ##

To build `lxml`, you'll need:

- zlib
- win-iconv
- libxml2
- libxslt

Go get the latest source distributions for these.   You can use your browser and just save them in downloads.

I expanded them using CYGWIN for convenience:

```
cd <directory of this README>
tar xvf /cygdrive/c/Users/davisda4/downloads/zlib-1.2.8.tar.gz
unzip /cygdrive/c/users/davisda4/downloads/win-iconv-0.0.6.zip
tar xvf /cygdrive/c/users/davisda4/downloads/libxml2-2.9.2.tar.gz
unzip /cygdrive/c/users/davisda4/downloads/libxslt-1.1.28.zip
```

## Command-Line Setup ##

Define `%INCLIB%` as the location you will put all of this:

```
set INCLIB=C:\Users\davisda4\Tools\lib
```

This is where both headers and library code will be copied

## Building Libraries ##

The scripts in this directory should mostly work, but there are a couple of changes that I had to make to the sources manually.  These are noted in each script, not here.

Build as follows:

```
build_zlib.cmd
build_iconv.cmd
build_libxml2.cmd
build_libxslt.cmd
```

__NOTE__: Check the build files to see if you need to change the lines CALL MSVC10-x64.cmd to match your compiler!   Check also for source modifications.

## Building lxml ##

- Download lxml as a `.tar.gz` from https://pypi.python.org
- Expand it
- cd into that directory
- Modify setup.py to set the path to your includes:

```
STATIC_INCLUDE_DIRS = [ 'C:/Users/davisda4/Tools/lib' ]
STATIC_LIBRARY_DIRS = [ 'C:/Users/davisda4/Tools/lib' ]
```

- Make sure you have wheel and cython installed

```
pip install wheel
pip install Cython
```

- Make sure your Python matches the compiler you used

```
python --version
```

- Build it

```
python setup.py bdist_wheel --with-cython --static
```

- Copy wheel file from `dist` sub-directory to Artifactory/wheel directory

## Other Libraries ##

### pyaml ###

pyaml Does not link with libyaml unless you tell it.   I'm assuming compatible.

### PyCrypto ###

At present writing there's a bug that required a code change.

To get past it, do the following:

- Download `.tar.gz`
- Expand it
- Modify `lib/Crypto/Random/OSRNG/nt.py` so that `winrandom` is imported locally:

```
from . import winrandom
```

- Package that directory up again to be the `.tar.gz`
- Use pip wheel command on the `.tar.gz`

### cx_Oracle ###

You must make sure instantclient 12.1 both basic and SDK are expanded at same location in path.   No other instantclient should be ahead of them.  Also define `ORACLE_HOME` to be the instantclient directory.  Paranoid now.

## Author ##

Dan Davis, Systems/Applications Architect (Contractor),
Office of Computer and Communications Systems,
National Library of Medicine, NIH

## Acknowledgements ##

This is mostly a packaging of a subset of Christoph Gohlke's [builds](http://www.lfd.uci.edu/~gohlke/pythonlibs/).   He has been most generous in describing how he does it.   I've done it myself because in goverment we cannot just take anyone's packages and use them, even anyone so excellent as Dr. Gohlke. 

## Disclaimer ##

These packages are built at NLM only for a development environment.  They are not expected to be used for production.   Production runs on Linux, only we don't all have Linux laptops that can talk to our servers.