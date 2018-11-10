@echo off

::MKL
curl -k https://s3.amazonaws.com/ossci-windows/mkl_2018.2.185.7z --output mkl.7z
if errorlevel 1 exit /b 1

7z x -aoa mkl.7z -omkl
if errorlevel 1 exit /b 1

set CMAKE_INCLUDE_PATH=%cd%\mkl\include
set LIB=%cd%\mkl\lib;%LIB%
