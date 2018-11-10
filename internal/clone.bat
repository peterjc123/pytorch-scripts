@echo off

IF "%PYTORCH_REPO%" == "" set PYTORCH_REPO=pytorch

git clone https://github.com/%PYTORCH_REPO%/pytorch

cd pytorch

IF NOT "%PYTORCH_BUILD_VERSION%"=="" (
    git checkout tags/v%PYTORCH_BUILD_VERSION%
    IF ERRORLEVEL 1 git checkout v%PYTORCH_BUILD_VERSION%
    IF ERRORLEVEL 1 (
        echo Version %PYTORCH_BUILD_VERSION% not found, staying on the master branch
    ) ELSE (
        echo Building for version %PYTORCH_BUILD_VERSION%
    )
) ELSE (
    IF NOT "%PYTORCH_BRANCH%" == "" git checkout %PYTORCH_BRANCH%
    IF ERRORLEVEL 1 (
        echo Branch %PYTORCH_BRANCH% not found, staying on the master branch
    ) ELSE (
        echo Building for branch %PYTORCH_BRANCH%
    )
)

git submodule update --init --recursive
