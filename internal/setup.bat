@echo off

echo The flags after configuring:
echo NO_CUDA=%NO_CUDA%
echo CMAKE_GENERATOR=%CMAKE_GENERATOR%
if "%NO_CUDA%"==""  echo CUDA_PATH=%CUDA_PATH%
if NOT "%CC%"==""   echo CC=%CC%
if NOT "%CXX%"==""  echo CXX=%CXX%
if NOT "%DISTUTILS_USE_SDK%"==""  echo DISTUTILS_USE_SDK=%DISTUTILS_USE_SDK%

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
call "%VS15VCVARSALL%" x86_amd64

IF NOT exist "setup.py" (
    cd pytorch
)
python setup.py install

:no
exit /b 1
