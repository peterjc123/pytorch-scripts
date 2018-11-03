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
set CUDA_VERSION=100
set CUDA_VERSION_STR=10.0

IF "%CUDA_PATH_V10_0%"=="" (
    IF %AUTO_RESOLVE_VALUE% GEQ 1 (
        call internal\auto_resolve.bat cuda100
        IF ERRORLEVEL 1 goto eof
    ) ELSE (
        echo CUDA 10.0 not found
        goto eof
    )
)

set "CUDA_PATH=%CUDA_PATH_V10_0%"
set "PATH=%CUDA_PATH_V10_0%\bin;%PATH%"

IF "%NVTOOLSEXT_PATH%"=="" (
    IF %AUTO_RESOLVE_VALUE% GEQ 1 (
        call internal\auto_resolve.bat nvtx
        IF ERRORLEVEL 1 goto eof
    ) ELSE (
        echo NVTX ^(Visual Studio Extension ^for CUDA^) ^not installed
        goto eof
    )
)

:optcheck

call internal\check_opts.bat
IF ERRORLEVEL 1 goto eof

call internal\setup.bat
IF ERRORLEVEL 1 goto eof

:eof
