It is a repo that contains scripts that makes using PyTorch on Windows easier.

# Easy Installation
If you just want to install PyTorch as soon as possible, you can try this one out.
The current version of the conda package for PyTorch is 0.3.1.
You'll need Anaconda first. And then type in the following commands.
```Powershell
# If your main Python version is not 3.5 or 3.6
conda create -n test python=3.6 numpy pyyaml mkl

# for CPU only packages
conda install -c peterjc123 pytorch-cpu

# for Windows 10 and Windows Server 2016, CUDA 8
conda install -c peterjc123 pytorch

# for Windows 10 and Windows Server 2016, CUDA 9
conda install -c peterjc123 pytorch cuda90

# for Windows 7/8/8.1 and Windows Server 2008/2012, CUDA 8
conda install -c peterjc123 pytorch_legacy
```
If there's conflict against vc14, you may see workground [here](https://github.com/peterjc123/pytorch-scripts/issues/3).
Sometimes the new packages may not work, when that happens, you may try the legacy packages [here](https://drive.google.com/drive/folders/0B-X0-FlSGfCYdTNldW02UGl4MXM?usp=sharing). If you are from China, then the files are stored in Baidu Netdisk. You can access them through this [link](https://pan.baidu.com/s/1dF6ayLr).

# About CI packages

There may be chances that the conda package is stale and you want to try out new features. For this purpose, the CI packages are generated. 

| System                   | All                                      |
| ------------------------ | ---------------------------------------- |
| Windows CPU (master)     | [![Build status](https://ci.appveyor.com/api/projects/status/8xiih9d2w4pwnq4k/branch/windows-full?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows GPU (master)     | [![Build status](https://ci.appveyor.com/api/projects/status/y6geguaq83igjh58/branch/windows-full?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch-elheu/branch/windows-full) |
| Windows CPU (0.3.0)      | [![Build status](https://ci.appveyor.com/api/projects/status/8xiih9d2w4pwnq4k/branch/v0.3.0_win?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/v0.3.0_win) |
| Windows GPU (0.3.0)      | [![Build status](https://ci.appveyor.com/api/projects/status/y6geguaq83igjh58/branch/v0.3.0_win?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch-elheu/branch/v0.3.0_win) |
| Windows CPU (0.3.1)      | [![Build status](https://ci.appveyor.com/api/projects/status/8xiih9d2w4pwnq4k/branch/v0.3.1_win?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/v0.3.1_win) |
| Windows GPU (0.3.1)      | [![Build status](https://ci.appveyor.com/api/projects/status/y6geguaq83igjh58/branch/v0.3.1_win?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch-elheu/branch/v0.3.1_win) |

## How to find the package and install?

You can first click the icon to get to the main page of the CI system for a certain package. You can see a few jobs under that page. There're several variables that is used to distinguish the packages.

- **APPVEYOR\_BUILD\_WORKER_IMAGE** : VS 2015/2017 This **does not** indicate the compiler it used, but the **system** it can run on. The former one can be used on Windows 7/8/8.1 and Windows Server 2008/2012, while the latter on Windows 10 and Windows Server 2016.


- **PYTHON_VERSION** : This one indicates the python version it use. 


- **TORCH\_CUDA\_ARCH\_LIST** : It implies the architecture of the GPU, only **Pascal**, **Maxwell** and **Kepler** is supported.

After the choice of the jobs, you can see the generated package if you click on **Artifact** on the navigation bar in the middle of the page.

Installation is simple, but there're some requirements.

```powershell
# For all versions
# Windows x64
# Python x64 3.5 / 3.6
# MKL/Numpy/PyYAML

# For GPU versions
# CUDA 8
# cuDNN 6
# NVTX (Visual Studio Integration in CUDA. if it fails to be installed, you can extract
#       the CUDA installer exe and found the NVTX installer under the CUDAVisualStudioIntegration)

pip install pytorch-[version]-cp[pyversion]-cp[pyversion]m-win-amd64.whl
```

Note: You may face with the following issue. First, check that all the dependencies are installed. Second, try if a fresh virtual environment helps. If it helps, it may be an issue of the python version. And you can install VC 2017 Redist. Finally, you may have to manually compile PyTorch from source.

```pytb
C:\Anaconda2\lib\site-packages\torch\__init__.pyc in <module>()
     39     os.environ['PATH'] = os.path.dirname(__file__) + '\\lib\\;' + os.environ['PATH']
     40
---> 41     from torch._C import *
     42     __all__ += [name for name in dir(_C)
     43                 if name[0] != '_' and

ImportError: DLL load failed: The specified procedure could not be found.
```

# Compiling Examples
You can download it and put it in the PyTorch directory or use it in a standalone way.
```Powershell
# If you don't want to override the default settings
auto.bat

# If you don't want to compile with CUDA
cpu.bat

# If you want to compile with CUDA 8
cuda8.bat

# If you want to compile with CUDA 9
cuda9.bat

```

# Using Examples
```Python
# The main difference in Python between Windows and Unix systems is multiprocessing
# So please refactor your code into the following structure if you use DataLoader

import torch

def main()
    for i, (x, y) in dataloader:
        # do something here

if __name__ == '__main__':
    main()
```
