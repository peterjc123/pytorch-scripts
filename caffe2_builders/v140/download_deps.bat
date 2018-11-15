@echo off

pushd %CAFFE2_ROOT%\build

if not exist Caffe2WinDeps (
    git clone https://github.com/ArutyunovG/Caffe2WinDeps.git
)

set CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%cd%\Caffe2WinDeps\v140\gflags\lib\cmake\gflags
set CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%cd%\Caffe2WinDeps\v140\glog\lib\cmake\glog
set CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%cd%\Caffe2WinDeps\v140\lmdb\cmake
set CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%cd%\Caffe2WinDeps\v140\opencv

popd

if errorlevel 1 exit /b 1

