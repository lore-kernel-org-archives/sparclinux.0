From: Nicolas Boullis <nboullis@debian.org>
Date: Fri, 06 Feb 2004 01:24:38 +0000
Subject: kernel 2.4.25-pre8 fails to build for sparc32
Message-Id: <20040206012437.GB2057@tintin>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

First of all, sorry if I'm doing something wrong with this report, I'm 
still quite a newbie on this list...

I just tried to build a sparc32 kernel for my Ultra5. (I know this is 
sparc64 hardware, but I need to test some things with a sparc32 kernel, 
and I think it's supposed to work fine...) Unfortunately, the build 
fails with the following message:

,----
| make[4]: Entering directory `/usr/src/linux-2.4.25-pre8_32/drivers/ide'
| gcc -D__KERNEL__ -I/usr/src/linux-2.4.25-pre8_32/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ide_iops  -DEXPORT_SYMTAB -c ide-iops.c
| ide-iops.c:119: error: conflicting types for `ide_insw'
| /usr/src/linux-2.4.25-pre8_32/include/asm/ide.h:107: error: previous declaration of `ide_insw'
| ide-iops.c:149: error: conflicting types for `ide_outsw'
| /usr/src/linux-2.4.25-pre8_32/include/asm/ide.h:138: error: previous declaration of `ide_outsw'
| ide-iops.c: In function `ide_mm_insw':
| ide-iops.c:196: warning: implicit declaration of function `__ide_mm_insw'
| ide-iops.c: In function `ide_mm_insl':
| ide-iops.c:206: warning: implicit declaration of function `__ide_mm_insl'
| ide-iops.c: In function `ide_mm_outsw':
| ide-iops.c:226: warning: implicit declaration of function `__ide_mm_outsw'
| ide-iops.c: In function `ide_mm_outsl':
| ide-iops.c:236: warning: implicit declaration of function `__ide_mm_outsl'
| make[4]: *** [ide-iops.o] Error 1
| make[4]: Leaving directory `/usr/src/linux-2.4.25-pre8_32/drivers/ide'
`----

Can anyone help me sove this failure?


TIA,

Nicolas
