From: David Ahern <david.ahern@oracle.com>
Date: Wed, 18 Mar 2015 16:56:22 +0000
Subject: maps mismatch in /proc/kcore for sparc
Message-Id: <5509AE36.8040902@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: sparclinux@vger.kernel.org

I am trying to understand why the perf tool on sparc fails to convert 
kernel symbols when /proc/kcore is used. I have instrumented perf to the 
point I can see that it drops symbols from kallsyms because it cannot 
find a corresponding map when the kernel maps are created based on 
parsing /proc/kcore.


For sparc kernel symbols start at 0x404000:

# less /proc/kallsyms
0000000000404000 T start
0000000000404000 T stext
0000000000404000 T _start
0000000000404000 T _stext
0000000000404000 T _text
0000000000404012 T root_flags
0000000000404014 T root_dev
0000000000404016 T ram_flags
0000000000404018 T sparc_ramdisk_image
000000000040401c T sparc_ramdisk_size
0000000000404030 T sparc_ramdisk_image64
000000000040403c t sparc64_boot
...


But 'objdump -x /proc/kcore' does not show a map covering 0x404000:
# objdump -x /proc/kcore

/proc/kcore:     file format elf64-sparc
/proc/kcore
architecture: sparc:v9, flags 0x00000000:

start address 0x0000000000000000

Program Header:
     NOTE off    0x00000000000005b8 vaddr 0x0000000000000000 paddr 
0x0000000000000000 align 2**0
          filesz 0x0000000000001a3c memsz 0x0000000000000000 flags ---
     LOAD off    0x0008000100004000 vaddr 0x0000000100000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0005ffff00000000 memsz 0x0005ffff00000000 flags rwx
     LOAD off    0x0008000010004000 vaddr 0x0000000010000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x00000000e0000000 memsz 0x00000000e0000000 flags rwx
     LOAD off    0x00000000a0404000 vaddr 0xfff80000a0400000 paddr 
0x0000000000000000 align 2**13
          filesz 0x000000000f800000 memsz 0x000000000f800000 flags rwx
     LOAD off    0x000e00000140c000 vaddr 0x0006000001408000 paddr 
0x0000000000000000 align 2**13
          filesz 0x00000000001f0000 memsz 0x00000000001f0000 flags rwx
     LOAD off    0x00000000afd84000 vaddr 0xfff80000afd80000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000018000 memsz 0x0000000000018000 flags rwx
     LOAD off    0x000e0000015fe000 vaddr 0x00060000015fa000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000002000 memsz 0x0000000000002000 flags rwx
     LOAD off    0x00000020c0004000 vaddr 0xfff80020c0000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000040000000 memsz 0x0000000040000000 flags rwx
     LOAD off    0x000e000041804000 vaddr 0x0006000041800000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000800000 memsz 0x0000000000800000 flags rwx
     LOAD off    0x0000004250004000 vaddr 0xfff8004250000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000150000000 memsz 0x0000000150000000 flags rwx
     LOAD off    0x000e000084a04000 vaddr 0x0006000084a00000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000002a00000 memsz 0x0000000002a00000 flags rwx
     LOAD off    0x0000006000004000 vaddr 0xfff8006000000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000800000000 memsz 0x0000000800000000 flags rwx
     LOAD off    0x000e0000c0004000 vaddr 0x00060000c0000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000010000000 memsz 0x0000000010000000 flags rwx
     LOAD off    0x0000008170004000 vaddr 0xfff8008170000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000010000000 memsz 0x0000000010000000 flags rwx
     LOAD off    0x000e000102e04000 vaddr 0x0006000102e00000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000200000 memsz 0x0000000000200000 flags rwx
     LOAD off    0x000000a2d0004000 vaddr 0xfff800a2d0000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000060000000 memsz 0x0000000060000000 flags rwx
     LOAD off    0x000e000145a04000 vaddr 0x0006000145a00000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000c00000 memsz 0x0000000000c00000 flags rwx
     LOAD off    0x000000c340004000 vaddr 0xfff800c340000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000040000000 memsz 0x0000000040000000 flags rwx
     LOAD off    0x000e000186804000 vaddr 0x0006000186800000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000800000 memsz 0x0000000000800000 flags rwx
     LOAD off    0x000000e390004000 vaddr 0xfff800e390000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000530000000 memsz 0x0000000530000000 flags rwx
     LOAD off    0x000e0001c7204000 vaddr 0x00060001c7200000 paddr 
0x0000000000000000 align 2**13
          filesz 0x000000000a600000 memsz 0x000000000a600000 flags rwx
     LOAD off    0x0000010000004000 vaddr 0xfff8010000000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x000000007fd3e000 memsz 0x000000007fd3e000 flags rwx
     LOAD off    0x000e000200004000 vaddr 0x0006000200000000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000ffc000 memsz 0x0000000000ffc000 flags rwx
     LOAD off    0x000001007ffd2000 vaddr 0xfff801007ffce000 paddr 
0x0000000000000000 align 2**13
          filesz 0x000000000000a000 memsz 0x000000000000a000 flags rwx
     LOAD off    0x000e000201002000 vaddr 0x0006000200ffe000 paddr 
0x0000000000000000 align 2**13
          filesz 0x0000000000002000 memsz 0x0000000000002000 flags rwx


'objdump -x vmlinux' shows:

vmlinux:     file format elf64-sparc
vmlinux
architecture: sparc:v9a, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x0000000000404000

Program Header:
     LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 
0x0000000000400000 align 2**20
          filesz 0x0000000000917b00 memsz 0x0000000000a2bd39 flags rwx
     NOTE off    0x000000000088de98 vaddr 0x0000000000c8de98 paddr 
0x0000000000c8de98 align 2**2
          filesz 0x0000000000000024 memsz 0x0000000000000024 flags r-x
    STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 
0x0000000000000000 align 2**3
          filesz 0x0000000000000000 memsz 0x0000000000000000 flags rwx


Any ideas on where it is going off the rails?

Thanks,
David
