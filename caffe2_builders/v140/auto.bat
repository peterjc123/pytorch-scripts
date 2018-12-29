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

if NOT DEFINED DOWNLOAD_DEPS (
    set DOWNLOAD_DEPS=1
)

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

rem Visual Studio 14 2015 Win64 is supported by this script
rem Define VC_BIN_ROOT where compiler and vcvars64.bat are located
if NOT DEFINED CMAKE_GENERATOR (
    set CMAKE_GENERATOR="Visual Studio 14 2015 Win64"
    set VC_BIN_ROOT="%VS140COMNTOOLS%..\..\VC\bin\amd64"
)

if %VC_BIN_ROOT% EQU "" (
    echo "Error: VC_BIN_ROOT must be specified"
    echo "Exiting..."
    exit
)

rem Explicitly specifiy x64 compiler to have enough heap space
if %CMAKE_GENERATOR% EQU "Visual Studio 14 2015 Win64" (
    set CXX=%VC_BIN_ROOT%\cl.exe
    set CC=%VC_BIN_ROOT%\cl.exe
    set CMAKE_LINKER=%VC_BIN_ROOT%\link.exe
)

rem Now checking, that everything is defined for build...
if %CXX% EQU "" (
    echo "Error: CXX must be specified"
    echo "Exiting..."
    exit
)

if %CC% EQU "" (
    echo "Error: CC must be specified"
    echo "Exiting..."
    exit
)

if %CMAKE_LINKER% EQU "" (
    echo "Error: CMAKE_LINKER must be specified"
    echo "Exiting..."
    exit
)

rem Install pyyaml for Aten codegen
python -m pip install pyyaml

if not exist %CAFFE2_ROOT%\build (
    mkdir %CAFFE2_ROOT%\build
)

if %DOWNLOAD_DEPS% EQU 1 (
    call %~dp0%download_deps.bat
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

