@echo off

REM Check for optional components

where /q ninja.exe

IF NOT ERRORLEVEL 1 (
    echo Ninja found, using it to speed up builds
    set CMAKE_GENERATOR=Ninja
) ELSE (
    echo Ninja not found. It can be used to accelerate builds.
    echo You can install ninja using ^`pip install ninja^`.
)

where /q clcache.exe

IF NOT ERRORLEVEL 1 (
    echo clcache found, using it to speed up builds
    set CC=clcache
    set CXX=clcache
)

where /q sccache.exe

IF NOT ERRORLEVEL 1 (
    echo sccache found, using it to speed up builds
    IF "%CC%" == "" (
        set CC=sccache cl
    ) ELSE (
        set CC=sccache %CC%
    )
    IF "%CXX%" == "" (
        set CXX=sccache cl
    ) ELSE (
        set CXX=sccache %CXX%
    )
)

IF "%MKLProductDir%" == "" IF exist "C:\Program Files (x86)\IntelSWTools\compilers_and_libraries\windows" (
    set "MKLProductDir=C:\Program Files (x86)\IntelSWTools\compilers_and_libraries\windows";
)

IF exist "%MKLProductDir%\mkl\lib\intel64_win" (
    echo MKL found, adding it to build
    set "CMAKE_INCLUDE_PATH=%MKLProductDir%\mkl\include"
    set "LIB=%MKLProductDir%\mkl\lib\intel64_win;%MKLProductDir%\compiler\lib\intel64_win;%LIB%";
)

if "%NO_CUDA%"=="" (
    IF "%MAGMA_HOME%" == "" (
        echo MAGMA_HOME is set. MAGMA will be included in build.
    ) ELSE (
        echo MAGMA_HOME not set. Skip MAGMA in build.
    )
)

exit /b 0
