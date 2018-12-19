@echo off

REM Check for necessary components

set SRC_DIR=%~dp0\..

IF NOT "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo You should use 64 bits Windows to build and run PyTorch
    exit /b 1
)

where /q python.exe

IF ERRORLEVEL 1 (
    echo Python x64 3.5 or up is required to compile PyTorch on Windows
    exit /b 1
)

for /F "usebackq delims=" %%i in (`python -c "import sys; print('{0[0]}{0[1]}'.format(sys.version_info))"`) do (
    set /a PYVER=%%i
)

if  %PYVER% LSS 35 (
    echo Warning: PyTorch for Python 2 under Windows is experimental.
    echo Python x64 3.5 or up is recommended to compile PyTorch on Windows
    echo Maybe you can create a virual environment if you have conda installed:
    echo ^> conda create -n test python=3.6 pyyaml mkl numpy
    echo ^> activate test
) ELSE (
    goto after_py27
)

IF "%SKIP_PY_VER_CHECK%" == "1" (
    goto after_py27
)

setlocal EnableDelayedExpansion
IF /I "%~1" NEQ "/y" (
:reask
    echo Do you still want to build PyTorch for Python 2.7 on Windows anyway? (Y/N^)
    set INPUT=
    set /P INPUT=Type input: %=%
    If /I "!INPUT!"=="y" goto yes
    If /I "!INPUT!"=="n" goto no
    goto reask
)
setlocal DisableDelayedExpansion

:no
exit /b 1

:yes
set FORCE_PY27_BUILD=1

:after_py27

for /F "usebackq delims=" %%i in (`python -c "import struct;print( 8 * struct.calcsize('P'))"`) do (
    set /a PYSIZE=%%i
)

if %PYSIZE% NEQ 64 (
    echo Python x64 3.5 or up is required to compile PyTorch on Windows
    exit /b 1
)

IF "%AUTO_RESOLVE_MODE%" == "RECOMMENDED" (
    set /a AUTO_RESOLVE_VALUE=2
) ELSE (
    IF "%AUTO_RESOLVE_MODE%" == "MINIMAL" (
        set /a AUTO_RESOLVE_VALUE=1
    ) ELSE (
        set /a AUTO_RESOLVE_VALUE=0
    )
)

IF NOT %AUTO_RESOLVE_VALUE% GEQ 1 goto auto_resolve_check_end

IF NOT EXIST "%CD%\tmp_build" (
    mkdir %CD%\tmp_build
)

where /q choco.exe
IF ERRORLEVEL 1 (
    set NO_CHOCO=1
)

where /q curl.exe

IF ERRORLEVEL 1 (
    IF "%NO_CHOCO%" == "1" (
        echo Chocolatey is required to resolve missing dependencies automatically.
        echo If you don't want to install it, please install cURL.
        exit /b 1
    )
    echo Installing cURL...
    choco install -y curl
)

where /q 7z.exe

IF ERRORLEVEL 1 (
    IF "%NO_CHOCO%" == "1" (
        echo Chocolatey is required to resolve missing dependencies automatically.
        echo If you don't want to install it, please install 7Zip.
        exit /b 1
    )
    echo Installing 7Zip...
    choco install -y 7Zip
)

for /F "usebackq delims=" %%i in (`python -c "import sys; print('{0[0]}{0[1]}'.format(sys.version_info))"`) do (
    set "PIP_BIN=%%i\Scripts\pip.exe"
)

IF NOT EXIST %PIP_BIN% (
    echo It looks like pip is not installed in your current Python environment.
    echo Please install it before running this build script.
    exit /b 1
)

:auto_resolve_check_end

IF NOT EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (
    IF %AUTO_RESOLVE_VALUE% GEQ 1 (
        echo Installing VS BuildTools...
        call .\auto_resolve.bat vs
        IF ERRORLEVEL 1 exit /b 1
        goto vs_check
    ) ELSE (
        echo Visual Studio 2017 C++ BuildTools is required to compile PyTorch on Windows
        exit /b 1
    )
)

:vs_check
for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -legacy -version [15^,16^) -property installationPath`) do (
    if exist "%%i" if exist "%%i\VC\Auxiliary\Build\vcvarsall.bat" (
        set "VS15INSTALLDIR=%%i"
        set "VS15VCVARSALL=%%i\VC\Auxiliary\Build\vcvarsall.bat"
        goto vswhere
    )
)

:vswhere
IF "%VS15VCVARSALL%"=="" (
    echo Visual Studio 2017 C++ BuildTools is required to compile PyTorch on Windows
    exit /b 1
)

set MSSdk=1
set DISTUTILS_USE_SDK=1

where /q cmake.exe

IF ERRORLEVEL 1 (
    IF %AUTO_RESOLVE_VALUE% GEQ 1 (
        IF "%NO_CHOCO%" == 1 (
            echo Chocolatey is required to resolve missing dependencies automatically.
            echo If you don't want to install it, please install CMake.
        ) ELSE (
            echo Installing CMake...
            choco install -y cmake
        )
    ) ELSE (
        echo CMake is required to compile PyTorch on Windows
        exit /b 1
    )
)
