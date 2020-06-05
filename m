From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Fri, 05 Jun 2020 11:05:35 +0000
Subject: Fail to build tftpboot.img
Message-Id: <20200605110535.GA9025@Red>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hello

For reinstalling an old SPARC machine , I need a netboot image.
I tried to create it via make tftpboot.img but got:
BUILD: sparc to /home/compile/crossbuild/next/sparc/sparc64/defconfig
make[1]: Entering directory '/usr/src/crossbuild/next/sparc/sparc64/defconfig'
  GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
  GEN     Makefile
  CALL    /linux-next/scripts/atomic/check-atomics.sh
  CALL    /linux-next/scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CHK     include/generated/compile.h
  GZIP    kernel/config_data.gz
  CC      kernel/configs.o
  AR      kernel/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.kallsyms1
  KSYM    .tmp_vmlinux.kallsyms1.o
  LD      .tmp_vmlinux.kallsyms2
  KSYM    .tmp_vmlinux.kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  MODPOST Module.symvers
  STRIP   arch/sparc/boot/image
  kernel: arch/sparc/boot/image is ready
  ELFTOAOUT arch/sparc/boot/tftpboot.img
PT 0 Entry: Loadable to 0x400000[0x5288d0] from 0x0[0x4ca694] align 0x100000
PT 1 Entry: Note
PT 2 Entry: unknown
  PIGGY   arch/sparc/boot/tftpboot.img
lseek: Invalid argument
make[2]: *** [/linux-next/arch/sparc/boot/Makefile:72: arch/sparc/boot/tftpboot.img] Error 1
make[2]: *** Deleting file 'arch/sparc/boot/tftpboot.img'
make[1]: *** [arch/sparc/Makefile:76: tftpboot.img] Error 2
make[1]: Leaving directory '/usr/src/crossbuild/next/sparc/sparc64/defconfig'
make: *** [Makefile:185: __sub-make] Error 2

I got this result on both linux-next and 5.6.15

I have straced the process:
22495 openat(AT_FDCWD, "arch/sparc/boot/tftpboot.img", O_RDWR) = 3              
22495 read(3, "\1\3\1\7\0\0\0\0\0Lf\224\0\0\0\0\0\0\0\0\0\0\0\0\0\5\342<\0\0\0\0"..., 512) = 512
22495 lseek(3, 0, SEEK_SET)             = 0                                     
22495 read(3, "\1\3\1\7\0\0\0\0\0Lf\224\0\0\0\0\0\0\0\0\0\0\0\0\0\5\342<\0\0\0\0"..., 1024) = 1024
22495 lseek(3, -480, SEEK_SET)          = -1 EINVAL (Argument invalide)         
22495 dup(2)                            = 4                                     
22495 fcntl(4, F_GETFL)                 = 0x402 (flags O_RDWR|O_APPEND)         
22495 fstat(4, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x1a), ...}) = 0    
22495 write(4, "lseek: Invalid argument\n", 24) = 24                            
22495 close(4)                          = 0                                     

Regards
