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
IF /I "%~1" NEQ "/y" (
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

set SRC_DIR=%~dp0\..

call "%VS15VCVARSALL%" x64 -vcvars_ver=14.11

pushd %SRC_DIR%

IF NOT exist "setup.py" (
    cd pytorch
)
python setup.py install

goto :eof

:no
exit /b 1
