@echo off

IF NOT exist "setup.py" (
    call internal\clone.bat
    IF ERRORLEVEL 1 goto eof
)

call internal\check_deps.bat
IF ERRORLEVEL 1 goto eof

REM Check for optional components

echo Disabling CUDA
set NO_CUDA=1

call internal\check_opts.bat
IF ERRORLEVEL 1 goto eof

call internal\setup.bat
IF ERRORLEVEL 1 goto eof

:eof
