It is a repo that contains scripts that makes using PyTorch on Windows easier.

# Easy Installation
**Update: Starting from 0.4.0, you can go to the [official site](http://pytorch.org) for installation steps. The packages here will not be updated.**
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
Plus: The support for old NV cards (Compute Capability <= 5.0) is over. 
There're mainly two ways to resolve this:
1. You can install legacy packages. See description in this section below.
2. Install CI packages. However, you have to handle the dependencies by yourself. See __About CI packages__ for details.

If there's conflict against vc14, you may see workground [here](https://github.com/peterjc123/pytorch-scripts/issues/3).
Sometimes the new packages may not work, when that happens, you may try the legacy packages [here](https://drive.google.com/drive/folders/0B-X0-FlSGfCYdTNldW02UGl4MXM?usp=sharing). If you are from China, then the files are stored in Baidu Netdisk. You can access them through this [link](https://pan.baidu.com/s/1dF6ayLr).

# About CI packages

There may be chances that the conda package is stale and you want to try out new features. For this purpose, the CI packages are generated. 

| System                   | All                                      |
| ------------------------ | ---------------------------------------- |
| Windows CPU (master)     | [![Build status](https://ci.appveyor.com/api/projects/status/8xiih9d2w4pwnq4k/branch/windows-full?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/windows-full) |
| Windows GPU (master)     | [![Build status](https://ci.appveyor.com/api/projects/status/y6geguaq83igjh58/branch/windows-full?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch-elheu/branch/windows-full) |
| Windows CPU (0.4.0)      | [![Build status](https://ci.appveyor.com/api/projects/status/8xiih9d2w4pwnq4k/branch/v0.4.0?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/v0.4.0) |
| Windows GPU (0.4.0)      | [![Build status](https://ci.appveyor.com/api/projects/status/y6geguaq83igjh58/branch/v0.4.0?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch-elheu/branch/v0.4.0) |
| Windows CPU (0.4.1)      | [![Build status](https://ci.appveyor.com/api/projects/status/8xiih9d2w4pwnq4k/branch/v0.4.1?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch/branch/v0.4.1) |
| Windows GPU (0.4.1)      | [![Build status](https://ci.appveyor.com/api/projects/status/y6geguaq83igjh58/branch/v0.4.1?svg=true)](https://ci.appveyor.com/project/peterjc123/pytorch-elheu/branch/v0.4.1) |

# About the nightly packages

An additional CI is setup to run every night so that you can also get the latest packages. Click the badge to download the latest package for a specific configuration and python version.

| Configuration / Python version | 3.5                                                          | 3.6                                                          | 3.7                                                          |
| ------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Windows x64 CPU (Conda)        | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Conda_Build&configuration=PY3.5)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fconda%2Fpytorch-nightly-cpu-1.0-py3.5_cpu_1.tar.bz2&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=conda_3.5&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Conda_Build&configuration=PY3.6)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fconda%2Fpytorch-nightly-cpu-1.0-py3.6_cpu_1.tar.bz2&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=conda_3.6&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Conda_Build&configuration=PY3.7)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fconda%2Fpytorch-nightly-cpu-1.0-py3.7_cpu_1.tar.bz2&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=conda_3.7&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) |
| Windows x64 CPU (Wheels)       | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Wheels_Build&configuration=PY3.5)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcpu%2Ftorch-1.0-cp35-cp35m-win_amd64.whl&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3.5&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Wheels_Build&configuration=PY3.6)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcpu%2Ftorch-1.0-cp36-cp36m-win_amd64.whl&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3.6&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Wheels_Build&configuration=PY3.7)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcpu%2Ftorch-1.0-cp37-cp37m-win_amd64.whl&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3.7&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) |
| Windows x64 CUDA 9.0 (Conda)   | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Conda_Build&configuration=PY3.5)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fconda%2Fpytorch-nightly-1.0-py3.5_cuda90_cudnn7_1.tar.bz2&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=conda_3.5_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Conda_Build&configuration=PY3.6)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fconda%2Fpytorch-nightly-1.0-py3.6_cuda90_cudnn7_1.tar.bz2&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=conda_3.6_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Conda_Build&configuration=PY3.7)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fconda%2Fpytorch-nightly-1.0-py3.7_cuda90_cudnn7_1.tar.bz2&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=conda_3.7_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) |
| Windows x64 CUDA 9.0 (Wheels)  | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Wheels_Build&configuration=PY3.5)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcuda90%2Ftorch-1.0-cp35-cp35m-win_amd64.whl&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3.5_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Wheels_Build&configuration=PY3.6)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcuda90%2Ftorch-1.0-cp36-cp36m-win_amd64.whl&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3.6_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Wheels_Build&configuration=PY3.7)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcuda90%2Ftorch-1.0-cp37-cp37m-win_amd64.whl&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3.7_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) |

And here are the libtorch packages. Only shared build is supported now.

| Configuration / LibTorch version | Shared library                                               |
| -------------------------------- | ------------------------------------------------------------ |
| Windows x64 CPU                  | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CPU_Wheels_Build&configuration=LIBTORCH)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcpu%2Flibtorch-shared-with-deps-1.0.zip&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) |
| Windows x64 CUDA 9.0             | [![Build status](https://dev.azure.com/pytorch/PyTorch/_apis/build/status/peterjc123.builder?branchName=master&jobName=Windows_CUDA90_Wheels_Build&configuration=LIBTORCH)](https://dev.azure.com/peterjc123/46ef0f8e-f34b-4a52-b6e0-c1000caf14a1/_apis/git/repositories/49b30ad3-8e9b-43ff-bbc8-87179a36d246/Items?path=%2Fwheels%2Fcuda90%2Flibtorch-shared-with-deps-1.0.zip&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=wheels_3_cuda90&download=true&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1) |

## How to find the package and install?

You can first click the icon to get to the main page of the CI system for a certain package. You can see a few jobs under that page. There're several variables that is used to distinguish the packages.


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
# CUDA 9 / 9.1
# cuDNN 7
# NVTX (Visual Studio Integration in CUDA. if it fails to be installed, you can extract
#       the CUDA installer exe and found the NVTX installer under the CUDAVisualStudioIntegration)

pip install numpy mkl intel-openmp
pip install pytorch-[version]-cp[pyversion]-cp[pyversion]m-win-amd64.whl
# Add [PythonRoot]\Library\bin into environment variable `PATH` and restart command prompt before using.
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
There're more details about MSVC 2017 setup in [#23](https://github.com/peterjc123/pytorch-scripts/issues/23).
```Powershell
################################################################################
# These are the flags that you can set before running the scripts.
################################################################################

# You can specify which version you want to build
# If you omit it, it will build for the master branch on default
set PYTORCH_BUILD_VERSION=0.4.1

# If you want to build your own fork of PyTorch
set PYTORCH_REPO=pytorch

# If you want to build for a specific branch
# Note: If you specify PYTORCH_BUILD_VERSION too, it won't be used.
set PYTORCH_BRANCH=master

# If you want to skip the confirmation of the flags configured by our script
set NO_PROMPT=1

# If you want to continue build without a verified VS version (Safe for CPU builds)
set SKIP_VS_VER_CHECK=1

# If you want to skip prompt for building for Python 2.7 (Not recommended)
set SKIP_PY_VER_CHECK=1

# If you want to build for LibTorch
set BUILD_PYTHONLESS=1

################################################################################
# These are the available scripts that you can use.
################################################################################

# If you don't want to override the default settings
auto.bat

# If you don't want to compile with CUDA
cpu.bat

# If you want to compile with CUDA 8
cuda80.bat

# If you want to compile with CUDA 9
cuda90.bat

# If you want to compile with CUDA 9.1
cuda91.bat

# If you want to compile with CUDA 9.2
cuda92.bat

# If you want to compile with CUDA 10.0
cuda100.bat

```

# Using Examples
```Python
# The main difference in Python between Windows and Unix systems is multiprocessing
# So please refactor your code into the following structure if you use DataLoader

import torch

def main():
    for i, (x, y) in dataloader:
        # do something here

if __name__ == '__main__':
    main()
```
