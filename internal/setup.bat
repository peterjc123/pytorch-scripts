@echo off

echo The flags after configuration:
echo NO_CUDA=%NO_CUDA%
echo CMAKE_GENERATOR=%CMAKE_GENERATOR%
if "%NO_CUDA%"==""  echo CUDA_PATH=%CUDA_PATH%
if NOT "%CC%"==""   echo CC=%CC%
if NOT "%CXX%"==""  echo CXX=%CXX%
if NOT "%DISTUTILS_USE_SDK%"==""  echo DISTUTILS_USE_SDK=%DISTUTILS_USE_SDK%
IF NOT "%PYTORCH_BUILD_VERSION%"=="" echo PYTORCH_BUILD_VERSION=%PYTORCH_BUILD_VERSION%
IF "%NO_CUDA%"=="" IF NOT "%MAGMA_HOME%"=="" echo MAGMA_HOME=%MAGMA_HOME%

setlocal EnableDelayedExpansion
IF NOT "%NO_PROMPT%" == "1" (
:reask
    echo Do you wish to continue? (Y/N^)
    set INPUT=
    set /P INPUT=Type input: %=%
    If /I "!INPUT!"=="y" goto yes 
    If /I "!INPUT!"=="n" goto no
    goto reask
)
setlocal DisableDelayedExpansion

:yes

IF NOT "%CMAKE_GENERATOR%" == "Ninja" goto reactivate_end

set SRC_DIR=%~dp0\..

setlocal
call "%VS15VCVARSALL%" x64 -vcvars_ver=14.11
call "%VS15VCVARSALL%" x86_amd64 -vcvars_ver=14.11
where /q cl.exe

IF ERRORLEVEL 1 (
    echo VS 14.11 toolset not found
    endlocal
    IF NOT "%SKIP_VS_VER_CHECK%" == "1" (
        echo Use ^`set SKIP_VS_VER_CHECK^=1^` to override this error.
        goto no
    )
) ELSE (
    goto reactivate_end
)

call "%VS15VCVARSALL%" x64
call "%VS15VCVARSALL%" x86_amd64

:reactivate_end

pushd %SRC_DIR%

IF NOT exist "setup.py" (
    cd pytorch
)

if "%BUILD_PYTHONLESS%" == "" goto pytorch else goto libtorch

:libtorch
set VARIANT=shared-with-deps

mkdir libtorch
set "CMAKE_INSTALL_PREFIX=%CD%\libtorch"

mkdir build
pushd build
python ../tools/build_libtorch.py
popd

IF ERRORLEVEL 1 goto no
IF NOT ERRORLEVEL 0 goto no

move /Y libtorch\bin\*.dll libtorch\lib\

echo LibTorch is built in %CD%\libtorch.

goto build_end

:pytorch
python setup.py install

:build_end

IF ERRORLEVEL 1 goto no
IF NOT ERRORLEVEL 0 goto no

goto :eof

:no
exit /b 1
