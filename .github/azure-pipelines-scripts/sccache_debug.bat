@echo off

IF NOT "%USE_SCCACHE%" == "false" (
    sccache -s
    type %SCCACHE_ERROR_LOG%
)
