@echo off

REM Check for optional components

where /q ninja.exe

IF NOT ERRORLEVEL 1 (
    echo Ninja found, using it to speed up builds
    set CMAKE_GENERATOR=Ninja
)

where /q clcache.exe

IF NOT ERRORLEVEL 1 (
    echo clcache found, using it to speed up builds
    set CC=clcache
    set CXX=clcache
)