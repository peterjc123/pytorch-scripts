@echo off

git clone --recursive https://github.com/pytorch/pytorch

IF NOT "%PYTORCH_BUILD_VERSION%"=="" (
    git checkout tags/v%PYTORCH_BUILD_VERSION%
    IF ERRORLEVEL 1 git checkout v%PYTORCH_BUILD_VERSION%
    IF ERRORLEVEL 1 (
        echo Version %PYTORCH_BUILD_VERSION% not found, staying on the master branch
    ) ELSE (
        echo Building for version %PYTORCH_BUILD_VERSION%
    )
)

cd pytorch
