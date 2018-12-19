@echo off

IF "%~1" == "vs" goto vs
IF "%~1" == "vs1411" goto vs1411
IF "%~1" == "cuda" goto cuda
IF "%~1" == "cuda90" goto cuda90
IF "%~1" == "cuda91" goto cuda91
IF "%~1" == "nvtx" goto nvtx
IF "%~1" == "magma" goto magma
IF "%~1" == "mkl" goto mkl
IF "%~1" == "ninja" goto ninja

echo "The dependency you specified is not yet avaiable: %~1"
exit /b 1

:vs

curl -k https://www.dropbox.com/s/spq7vtfb6uxgo0m/vs_BuildTools.exe?dl=1 --output "%SRC_DIR%\temp_build\vs_BuildTools.exe"
IF EXIST "vs_BuildTools.exe" (
    start /wait "%SRC_DIR%\temp_build\vs_buildtools.exe" --quiet --wait --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.14.11
) ELSE (
    echo Download failed
    exit /b 1
)

goto end_check

:vs1411

IF EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vs_installer.exe" (
    start /wait "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vs_installer.exe" --quiet --wait --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.14.11
) ELSE (
    echo VS Installer does not exist
    exit /b 1
)

goto end_check

:cuda80

:cuda
:cuda90

IF NOT EXIST "%SRC_DIR%\temp_build\cuda_9.0.176_windows.7z" (
    curl -k https://www.dropbox.com/s/z5b7ryz0zrimntl/cuda_9.0.176_windows.7z?dl=1 --output "%SRC_DIR%\temp_build\cuda_9.0.176_windows.7z"
    set "CUDA_SETUP_FILE=%SRC_DIR%\temp_build\cuda_9.0.176_windows.7z"
    set "NVCC_PACKAGE=compiler_%CUDA_VERSION_STR%"
)

IF NOT EXIST "%SRC_DIR%\temp_build\cudnn-9.0-windows7-x64-v7.zip" (
    curl -k https://www.dropbox.com/s/6p0xyqh472nu8m1/cudnn-9.0-windows7-x64-v7.zip?dl=1 --output "%SRC_DIR%\temp_build\cudnn-9.0-windows7-x64-v7.zip"
    set "CUDNN_SETUP_FILE=%SRC_DIR%\temp_build\cudnn-9.0-windows7-x64-v7.zip"
)

goto cuda_common

:cuda91

IF NOT EXIST "%SRC_DIR%\temp_build\cuda_9.1.85_windows.7z" (
    curl -k https://www.dropbox.com/s/7a4sbq0dln6v7t2/cuda_9.1.85_windows.7z?dl=1 --output "%SRC_DIR%\temp_build\cuda_9.1.85_windows.7z"
    set "CUDA_SETUP_FILE=%SRC_DIR%\temp_build\cuda_9.1.85_windows.7z"
    set "NVCC_PACKAGE=nvcc_%CUDA_VERSION_STR%"
)

IF NOT EXIST "%SRC_DIR%\temp_build\cudnn-9.1-windows7-x64-v7.zip" (
    curl -k https://www.dropbox.com/s/e0prhgsrbyfi4ov/cudnn-9.1-windows7-x64-v7.zip?dl=1 --output "%SRC_DIR%\temp_build\cudnn-9.1-windows7-x64-v7.zip"
    set "CUDNN_SETUP_FILE=%SRC_DIR%\temp_build\cudnn-9.1-windows7-x64-v7.zip"
)

goto cuda_common

:cuda_common

set "CUDA_PREFIX=cuda%CUDA_VERSION%"

IF NOT EXIST "%SRC_DIR%\temp_build\NvToolsExt.7z" (
    curl -k https://drive.google.com/uc?export=download&id=0B-X0-FlSGfCYclUyTWROZVlLT2s --output "%SRC_DIR%\temp_build\NvToolsExt.7z"
)

echo Installing CUDA toolkit...

7z x %CUDA_SETUP_FILE% -o"%SRC_DIR%\temp_build\cuda"
start /wait "%SRC_DIR%\temp_build\cuda\setup.exe" -s %NVCC_PACKAGE% cublas_%CUDA_VERSION_STR% cublas_dev_%CUDA_VERSION_STR% cudart_%CUDA_VERSION_STR% curand_%CUDA_VERSION_STR% curand_dev_%CUDA_VERSION_STR% cusparse_%CUDA_VERSION_STR% cusparse_dev_%CUDA_VERSION_STR% nvrtc_%CUDA_VERSION_STR% nvrtc_dev_%CUDA_VERSION_STR% cufft_%CUDA_VERSION_STR% cufft_dev_%CUDA_VERSION_STR%
echo Installing VS integration...
xcopy /Y "%SRC_DIR%\temp_build\cuda\_vs\*.*" "c:\Program Files (x86)\MSBuild\Microsoft.Cpp\v4.0\V140\BuildCustomizations"

echo Installing NvToolsExt...
7z x %SRC_DIR%\temp_build\NvToolsExt.7z -o"%SRC_DIR%\temp_build\NvToolsExt"
mkdir "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\bin\x64"
mkdir "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\include"
mkdir "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\lib\x64"
xcopy /Y "%SRC_DIR%\temp_build\NvToolsExt\bin\x64\*.*" "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\bin\x64"
xcopy /Y "%SRC_DIR%\temp_build\NvToolsExt\include\*.*" "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\include"
xcopy /Y "%SRC_DIR%\temp_build\NvToolsExt\lib\x64\*.*" "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\lib\x64"

echo Installing cuDNN...
7z x %CUDNN_SETUP_FILE% -o"%SRC_DIR%\temp_build\cudnn"
xcopy /Y "%SRC_DIR%\temp_build\cudnn\cuda\bin\*.*" "%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%\bin"
xcopy /Y "%SRC_DIR%\temp_build\cudnn\cuda\lib\x64\*.*" "%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%\lib\x64"
xcopy /Y "%SRC_DIR%\temp_build\cudnn\cuda\include\*.*" "%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%\include"

echo Setting up environment...
set "PATH=%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%\bin;%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%\libnvvp;%PATH%"
set "CUDA_PATH=%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%"
set "CUDA_PATH_V8_0=%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v%CUDA_VERSION_STR%"
set "NVTOOLSEXT_PATH=%ProgramFiles%\NVIDIA Corporation\NvToolsExt\"

goto end_check

:nvtx

IF NOT EXIST "%SRC_DIR%\temp_build\NvToolsExt.7z" (
    curl -k https://drive.google.com/uc?export=download&id=0B-X0-FlSGfCYclUyTWROZVlLT2s --output "%SRC_DIR%\temp_build\NvToolsExt.7z"
)

7z x %SRC_DIR%\temp_build\NvToolsExt.7z -o"%SRC_DIR%\temp_build\NvToolsExt"
mkdir "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\bin\x64"
mkdir "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\include"
mkdir "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\lib\x64"
xcopy /Y "%SRC_DIR%\temp_build\NvToolsExt\bin\x64\*.*" "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\bin\x64"
xcopy /Y "%SRC_DIR%\temp_build\NvToolsExt\include\*.*" "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\include"
xcopy /Y "%SRC_DIR%\temp_build\NvToolsExt\lib\x64\*.*" "%ProgramFiles%\NVIDIA Corporation\NvToolsExt\lib\x64"

set "NVTOOLSEXT_PATH=%ProgramFiles%\NVIDIA Corporation\NvToolsExt\"

goto end_check

:magma

set "CUDA_PREFIX=cuda%CUDA_VERSION%"
set "MAGMA_URL=https://s3.amazonaws.com/ossci-windows/magma_%CUDA_PREFIX%_release_mkl_2018.2.185.7z"
curl -k %MAGMA_URL% --output "%SRC_DIR%\temp_build\magma.7z"

echo Installing MAGMA...
7z x %SRC_DIR%\temp_build\magma.7z -o"%SRC_DIR%\temp_build\magma"
set "MAGMA_HOME=%SRC_DIR%\temp_build\magma\"

goto end_check

:mkl

IF NOT EXIST "%SRC_DIR%\temp_build\mkl.7z" (
    curl -k https://s3.amazonaws.com/ossci-windows/mkl_2018.2.185.7z --output %SRC_DIR%\temp_build\mkl.7z
)

7z x "%SRC_DIR%\temp_build\mkl.7z" -o"%SRC_DIR%\temp_build\mkl"
set "LIB=%SRC_DIR%\temp_build\mkl\lib;%LIB%"
set "CMAKE_INCLUDE_PATH=%CD%\temp_build\mkl\include"

goto end_check

:ninja

%PIP_BIN% install ninja

goto end_check


:end_check
IF ERRORLEVEL 1 exit /b 1
IF NOT ERRORLEVEL 0 exit /b 1