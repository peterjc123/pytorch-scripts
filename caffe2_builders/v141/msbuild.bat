if not exist %CAFFE2_ROOT%\build\%CONFIG% (
    mkdir %CAFFE2_ROOT%\build\%CONFIG%
)   
cd %CAFFE2_ROOT%\build\%CONFIG%

if %CMAKE_GENERATOR% EQU "Visual Studio 15 2017 Win64" (

    cmake %CAFFE2_ROOT% ^
         -G%CMAKE_GENERATOR% ^
         -T host=x64 ^
         -DUSE_OPENCV=ON ^
         -DCMAKE_BUILD_TYPE=%CONFIG% ^
         -DCMAKE_INSTALL_PREFIX=%CAFFE2_ROOT%\build\%CONFIG%\install ^
         -DBUILD_SHARED_LIBS=ON ^
         -DBUILD_BINARY=ON
                                 
    if errorlevel 1 exit /b 1
    
    cd %CAFFE2_ROOT%\build\%CONFIG%
            
) else (
    echo "Error: Script supports only Visual Studio 15 2017 Win64 generator"
    echo "Exiting..."
    cd %ORIGINAL_DIR%
    exit /b 1
)


"%MSBUILD_EXE%" INSTALL.vcxproj             ^
                /p:Configuration=%CONFIG%   ^
                /p:Platform=x64             ^
                /p:VisualStudioVersion=15.0 ^
                /p:CL_MPCount=%MAX_JOBS%
    
if errorlevel 1 exit /b 1

