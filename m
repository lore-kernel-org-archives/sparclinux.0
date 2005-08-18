From: Meelis Roos <mroos@linux.ee>
Date: Thu, 18 Aug 2005 20:09:51 +0000
Subject: Re: current_thread_info_reg undefined
Message-Id: <Pine.SOC.4.61.0508182257400.9003@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> What does the compiler spit out when drivers/net/ppp_deflate.o
> is being built?

I removed the file and reran make. gcc does not say anything and the 
later warning stay.

The warnings are actually longer (were before too):
*** Warning: "" [drivers/net/ppp_deflate.ko] undefined!
*** Warning: "" [drivers/net/ppp_deflate.ko] undefined!
*** Warning: "" [drivers/net/ppp_deflate.ko] undefined!
*** Warning: "current_thread_info_reg" [drivers/net/ppp_deflate.ko] undefined!

make V=1 just shows
   gcc -Wp,-MD,drivers/net/.ppp_deflate.o.d  -nostdinc -isystem 
/usr/lib/gcc/sparc-linux-gnu/4.0.2/include -D__KERNEL__ -Iinclude  -Wall 
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common 
-ffreestanding -O2     -fomit-frame-pointer -m64 -pipe -mno-fpu 
-mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -ffixed-g5 -fcall-used-g7 
-Wno-sign-compare -Wa,--undeclared-regs -finline-limit0000 
-Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE 
-DKBUILD_BASENAME=ppp_deflate -DKBUILD_MODNAME=ppp_deflate -c -o 
drivers/net/ppp_deflate.o drivers/net/ppp_deflate.c


> Perhaps it's toolchain dependent, thus some binutils or gcc
> bug.

This host is running up to date Debian unstable so it might easily be 
buggy:

gcc-4.0                4.0.1-4
gcc -v tells it's gcc version 4.0.2 20050806 (prerelease) (Debian 4.0.1-4)

binutils               2.16.1-2
ld -v tells GNU ld version 2.16.1 Debian GNU/Linux

-- 
Meelis Roos (mroos@linux.ee)
