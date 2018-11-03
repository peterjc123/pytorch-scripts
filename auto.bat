@echo off

IF /I "%~1" == "/y" (
    set NO_PROMPT=1
)

IF NOT EXIST "setup.py" IF NOT EXIST "pytorch" (
    call internal\clone.bat
    cd ..
    IF ERRORLEVEL 1 goto eof
)

call internal\check_deps.bat
IF ERRORLEVEL 1 goto eof

REM Check for optional components

set NO_CUDA=
set CMAKE_GENERATOR=Visual Studio 15 2017 Win64

IF "%CUDA_PATH%"=="" (
    echo CUDA not found, disabling it
    set NO_CUDA=1
    goto optcheck
)

IF "%NVTOOLSEXT_PATH%"=="" (
    echo NVTX ^(Visual Studio Extension ^for CUDA^) ^not installed, disabling CUDA
    set NO_CUDA=1
    goto optcheck
)

IF NOT "%CUDA_PATH_V8_0%"=="" IF "%CUDA_PATH_V8_0%"=="%CUDA_PATH%" (
    IF "%VS140COMNTOOLS%"=="" (
        echo CUDA 8 found, but VS2015 not found, disabling it
        set NO_CUDA=1
    ) ELSE (
        set CMAKE_GENERATOR=Visual Studio 14 2015 Win64
        set "CUDAHOSTCXX=%VS140COMNTOOLS%\..\..\VC\bin\amd64\cl.exe"
    )
)


IF "%CUDA_PATH_V8_0%"=="%CUDA_PATH%" (
    set CUDA_VERSION=80
    set CUDA_VERSION_STR=8.0
)
IF "%CUDA_PATH_V9_0%"=="%CUDA_PATH%" (
    set CUDA_VERSION=90
    set CUDA_VERSION_STR=9.0
)
IF "%CUDA_PATH_V9_1%"=="%CUDA_PATH%" (
    set CUDA_VERSION=91
    set CUDA_VERSION_STR=9.1
)
IF "%CUDA_PATH_V9_2%"=="%CUDA_PATH%" (
    set CUDA_VERSION=92
    set CUDA_VERSION_STR=9.2
)
IF "%CUDA_PATH_V10_0%"=="%CUDA_PATH%" (
    set CUDA_VERSION=100
    set CUDA_VERSION_STR=10.0
)


:optcheck

call internal\check_opts.bat
IF ERRORLEVEL 1 goto eof

call internal\setup.bat
IF ERRORLEVEL 1 goto eof

:eof
