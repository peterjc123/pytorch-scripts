@echo off

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
xcopy /Y aten\src\ATen\common_with_cwrap.py tools\shared\cwrap_common.py
