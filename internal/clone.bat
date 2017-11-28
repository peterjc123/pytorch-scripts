@echo off

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
xcopy /Y aten\src\ATen\common_with_cwrap.py tools\shared\cwrap_common.py

# Before the merge of PR 3757
mkdir torch\lib\build\ATen\src\ATen
cd torch\lib\build\ATen\src\ATen
mkdir ATen
python  ../../../../../../aten/src/ATen/gen.py -s  ../../../../../../aten/src/ATen  ../../../../../../aten/src/ATen/Declarations.cwrap  ../../../../../../aten/src/THNN/generic/THNN.h  ../../../../../../aten/src/THCUNN/generic/THCUNN.h  ../../../../../../aten/src/ATen/nn.yaml  ../../../../../../aten/src/ATen/native/native_functions.yaml
cd ../../../../../..