@echo off

:: Install Miniconda3
set "CONDA_HOME=%CD%\conda"
set "tmp_conda=%CONDA_HOME%"
set "miniconda_exe=%CD%\miniconda.exe"
if exist conda rmdir /s /q conda
if exist miniconda.exe del miniconda.exe

curl -k https://repo.continuum.io/miniconda/Miniconda3-latest-Windows-x86_64.exe -o "%miniconda_exe%"
if errorlevel 1 exit /b 1

start /wait "" "%miniconda_exe%" /S /InstallationType=JustMe /RegisterPython=0 /AddToPath=0 /D=%tmp_conda%
if errorlevel 1 exit /b 1

set "PATH=%CONDA_HOME%;%CONDA_HOME%\scripts;%CONDA_HOME%\Library\bin;%PATH%"

conda install numpy pyyaml mkl
pip install ninja
