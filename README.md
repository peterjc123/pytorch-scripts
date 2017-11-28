It is a repo that contains scripts that makes using PyTorch on Windows easier.

# Comiling Examples
You can download it in the PyTorch directory or use it standalone.
```CMD
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