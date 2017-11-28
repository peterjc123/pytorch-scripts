@echo off

IF NOT exist "setup.py" (
    call internal\clone.bat
    IF ERRORLEVEL 1 goto eof
)

call internal\check_deps.bat
IF ERRORLEVEL 1 goto eof

REM Check for optional components

set CMAKE_GENERATOR=Visual Studio 15 2017 Win64

IF "%CUDA_PATH_V8_0%"=="" (
    echo CUDA 8 not found, disabling it
    set NO_CUDA=1
) ELSE (
    IF "%VS140COMNTOOLS%"=="" (
        echo CUDA 8 found, but VS2015 not found, disabling it
        set NO_CUDA=1
    ) ELSE (
        set "CUDA_PATH=%CUDA_PATH_V8_0%"
        set PATH=%CUDA_PATH_V8_0%\bin;%PATH%
        set CMAKE_GENERATOR=Visual Studio 14 2015 Win64
        set "PREBUILD_COMMAND=%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat"
        set PREBUILD_COMMAND_ARGS=x86_amd64
        set NO_CUDA=
    )
)

echo %CUDA_PATH%

call internal\check_opts.bat
IF ERRORLEVEL 1 goto eof

call internal\setup.bat
IF ERRORLEVEL 1 goto eof

:eof
