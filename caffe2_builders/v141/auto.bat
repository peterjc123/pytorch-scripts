rem Remove to original folder after script is finished
set ORIGINAL_DIR=%cd%

rem Build folders are 
rem %CAFFE2_ROOT%\build\Debug for Debug and
rem %CAFFE2_ROOT%\build\Release for Release
set CAFFE2_ROOT=%~dp0%\pytorch

cd %CAFFE2_ROOT%\..

rem Cloning repository if it doesn't exist
if not exist pytorch (
    call  %~dp0%..\..\internal\clone.bat
    cd %CAFFE2_ROOT%\..
)

call %~dp0%..\..\internal\check_deps.bat
if errorlevel 1 exit /b 1

rem Should build folder be deleted and build start from scratch?
if NOT DEFINED REBUILD (
    set REBUILD=0
)

rem Debug build enabled by default
if NOT DEFINED BUILD_DEBUG (
    set BUILD_DEBUG=1
)

rem Release build enabled by default
if NOT DEFINED BUILD_RELEASE (
    set BUILD_RELEASE=1
)

rem msbuild /m: option value
if NOT DEFINED MAX_JOBS (
    set MAX_JOBS=%NUMBER_OF_PROCESSORS%
)

if %REBUILD% EQU 1 (
    if exist %CAFFE2_ROOT%\build (
        cd %CAFFE2_ROOT%
        python setup.py clean
    )
)

rem Visual Studio 15 2017 Win64 is supported by this script
if NOT DEFINED CMAKE_GENERATOR (
    set CMAKE_GENERATOR="Visual Studio 15 2017 Win64"
)

rem Building Debug in %CAFFE2_ROOT%\build\Debug
if %BUILD_DEBUG% EQU 1 (
    set CONFIG=Debug
    call %~dp0%msbuild.bat
    if errorlevel 1 exit /b 1
)

rem Building Release in %CAFFE2_ROOT%\build\Release
if %BUILD_RELEASE% EQU 1 (
    set CONFIG=Release
    call %~dp0%msbuild.bat
    if errorlevel 1 exit /b 1
)

cd %ORIGINAL_DIR%

