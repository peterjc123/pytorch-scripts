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
set CUDA_VERSION=80
set CUDA_VERSION_STR=8.0

IF "%NVTOOLSEXT_PATH%"=="" (
    echo NVTX ^(Visual Studio Extension ^for CUDA^) ^not installed, disabling CUDA
    set NO_CUDA=1
    goto optcheck
)

IF "%CUDA_PATH_V8_0%"=="" (
    echo CUDA 8 not found, disabling it
    set NO_CUDA=1
) ELSE (
    IF "%VS140COMNTOOLS%"=="" (
        echo CUDA 8 found, but VS2015 not found, disabling it
        set NO_CUDA=1
    ) ELSE (
        set "CUDA_PATH=%CUDA_PATH_V8_0%"
        set "PATH=%CUDA_PATH_V8_0%\bin;%PATH%"
        set CMAKE_GENERATOR=Visual Studio 14 2015 Win64
        set "CUDAHOSTCXX=%VS140COMNTOOLS%\..\..\VC\bin\amd64\cl.exe"
    )
)

IF "%CUDA_PATH_V8_0%"=="" (
    IF %AUTO_RESOLVE_VALUE% GEQ 1 (
        call internal\auto_resolve.bat cuda80
        IF ERRORLEVEL 1 goto eof
    ) ELSE (
        echo CUDA 8.0 not found
        goto eof
    )
)

set "CUDA_PATH=%CUDA_PATH_V8_0%"
set "PATH=%CUDA_PATH_V8_0%\bin;%PATH%"

IF "%VS140COMNTOOLS%"=="" (
    echo CUDA 8 found, but VS2015 not found
    goto eof
) ELSE (
    set CMAKE_GENERATOR=Visual Studio 14 2015 Win64
    set "CUDAHOSTCXX=%VS140COMNTOOLS%\..\..\VC\bin\amd64\cl.exe"
)

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
