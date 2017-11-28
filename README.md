It is a repo that contains scripts that makes using PyTorch on Windows easier.

# Easy Installation
If you just want to install PyTorch as soon as possible.
You'll need Anaconda with Python 3 first. And then type in the following commands.
```Powershell
# for Windows 10 / Server 2016
conda install -c peterjc123 pytorch

# for Windows 7,8,8.1 / Server 2008,2012
conda install -c peterjc123 pytorch-legacy
```

# About CI packages

There may be chances that the conda package is stale and you want to try out new features. For this purpose, the CI packages are generated. 

| System                   | 3.5                                      | 3.6                                      |
| ------------------------ | ---------------------------------------- | ---------------------------------------- |
| Windows CPU              | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch/branch/windows-full/2)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch/branch/windows-full/1)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows 7 GPU (Pascal)   | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/8)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/7)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows 7 GPU (Maxwell)  | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/4)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/3)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows 7 GPU (Kepler)   | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/12)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/11)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows 10 GPU (Pascal)  | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/6)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/5)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows 10 GPU (Maxwell) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/2)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/1)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows 10 GPU (Kepler)  | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/10)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) | [![Build Status](http://appveyor-badge.azurewebsites.net/repos/peterjc123/pytorch-elheu/branch/windows-full/9)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |

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

Note: You may face with the following issue. First, check that all the dependencies are installed. Second, try if a fresh virtual environment helps. If it helps, it may be an issue of the python version. Finally, you may have to manually compile PyTorch from source.

```pycon
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