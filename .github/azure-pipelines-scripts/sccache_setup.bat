@echo off

:: SCCACHE
IF NOT "%USE_SCCACHE%" == "false" (
    git clone https://ccache:PushFiles123@peter-jc.visualstudio.com/DefaultCollection/peter_jiachen/_git/peter_jiachen > nul 2>&1
    IF ERRORLEVEL 1 echo Clone cache failed

    set SCCACHE_DIR=%CD%\peter_jiachen
    set SCCACHE_CACHE_SIZE=1
    set SCCACHE_NO_DAEMON=1
    set SCCACHE_ERROR_LOG=%CD%\error.log
    set RUST_LOG=sccache::compiler=debug

    mkdir %CD%\tmp_bin

    curl -k https://s3.amazonaws.com/ossci-windows/sccache.exe --output %CD%\tmp_bin\sccache.exe

    set "PATH=%CD%\tmp_bin;%PATH%"

    sccache --stop-server
    sccache --start-server
    sccache --zero-stats
)
