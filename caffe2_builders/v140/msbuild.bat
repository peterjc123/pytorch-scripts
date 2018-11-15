if not exist %CAFFE2_ROOT%\build\%CONFIG% (
    mkdir %CAFFE2_ROOT%\build\%CONFIG%
)   
cd %CAFFE2_ROOT%\build\%CONFIG%

if %CMAKE_GENERATOR% EQU "Visual Studio 14 2015 Win64" (

    cmake %CAFFE2_ROOT% -G%CMAKE_GENERATOR% ^
                             -DUSE_OPENCV=ON ^
                             -DCMAKE_BUILD_TYPE=%CONFIG% ^
                             -DCMAKE_INSTALL_PREFIX=%CAFFE2_ROOT%\build\%CONFIG%\install ^
                             -DCMAKE_CXX_COMPILER=%CXX% ^
                             -DCMAKE_C_COMPILER=%CC% ^
                             -DCMAKE_LINKER=%CMAKE_LINER% ^
                             -DBUILD_C10_EXPERIMENTAL_OPS=OFF ^
                             -DBUILD_SHARED_LIBS=ON ^
                             -DBUILD_BINARY=ON
                                 
    if errorlevel 1 exit /b 1
    
    call %VC_BIN_ROOT%\vcvars64.bat
            
) else (
    echo "Error: Script supports only Visual Studio 14 2015 Win64 generator"
    echo "Exiting..."
    cd %ORIGINAL_DIR%
    exit
)

msbuild /p:Configuration=%CONFIG% /p:Platform=x64 /m:%MAX_JOBS% INSTALL.vcxproj /p:PreferredToolArchitecture=x64
if errorlevel 1 exit /b 1

