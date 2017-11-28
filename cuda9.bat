@echo off

IF NOT exist "setup.py" (
    call internal\clone.bat
    IF ERRORLEVEL 1 goto eof
)

call internal\check_deps.bat
IF ERRORLEVEL 1 goto eof

REM Check for optional components
set NO_CUDA=

IF "%CUDA_PATH_V9_0%"=="" (
    echo CUDA 9 not found, disabling it
    set NO_CUDA=1
) ELSE (
    set "CUDA_PATH=%CUDA_PATH_V9_0%"
    set PATH=%CUDA_PATH_V9_0%\bin;%PATH%
)

set CMAKE_GENERATOR=Visual Studio 15 2017 Win64

call internal\check_opts.bat
IF ERRORLEVEL 1 goto eof

call internal\setup.bat
IF ERRORLEVEL 1 goto eof

:eof
