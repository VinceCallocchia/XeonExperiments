# Overview

This repository is a collection of various test files for my Intel Xeon E5-2697 v2 processor. This project tests the upgraded CPU capabilities of a Mac Pro 6.1 ,running Arch Linux, from the ground up.

![12-core Intel Xeon Processor](/images/12-core_Intel_Xeon_Processor.png)

## Contents

[Functions](/functions/) - Recursive functions to test runtime & calculation subroutines.

[File System](/filesystem/) - File creation and manipulation within the Linux environment.

[Read Write](/readwrite/) - Reading and writing simple records using the Linux kernel.

[Shared Libraries](/sharedlib/) - Basic testing of static and dynamic linking.

[Memory Managment](/memalloc/) - Basic demo of memory management by allocating and deallocating memory as requested.


## Specifications

The following are the test platforms specs:

1. 2.7GHz 12-core Intel Xeon processor with 30MB L3 cache.
2. Samsung 64GB (4x16GB) 1866MHz DDR3 RAM.
3. Samsung 980 PRO SSD 1TB - M.2 NVMe.
4. AMD FirePro (D700X2) GDDR5 SDRAM 6GB VRAM.
5. Arch Linux Version 5.14.8.

![Xeon Processor Board](/images/Xeon_Processor_Board.png)

## Build

Assembly files in this repository can be assembled as followed:

```bash
as -g -o $filename.o filename.s && ld -o $filename $filename.o && ./filename
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
