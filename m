From: David Miller <davem@davemloft.net>
Date: Tue, 27 Mar 2007 08:14:49 +0000
Subject: Re: [PATCH 2.6.21-rc5] sparc64: gcc-4.2.0 20070317 -Werror failure
Message-Id: <20070327.011449.116354981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200703270742.l2R7gBGv016635@harpo.it.uu.se>
In-Reply-To: <200703270742.l2R7gBGv016635@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 27 Mar 2007 09:42:11 +0200 (MEST)

> Compiling 2.6.21-rc5 with gcc-4.2.0 20070317 (prerelease)
> for sparc64 fails as follows:
> 
>   gcc -Wp,-MD,arch/sparc64/kernel/.time.o.d  -nostdinc -isystem /home/mikpe/pkgs/linux-sparc64/gcc-4.2.0/lib/gcc/sparc64-unknown-linux-gnu/4.2.0/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs -fomit-frame-pointer  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign -Werror   -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(time)"  -D"KBUILD_MODNAME=KBUILD_STR(time)" -c -o arch/sparc64/kernel/time.o arch/sparc64/kernel/time.c
> cc1: warnings being treated as errors
> arch/sparc64/kernel/time.c: In function 'kick_start_clock':
> arch/sparc64/kernel/time.c:559: warning: overflow in implicit constant conversion
> make[1]: *** [arch/sparc64/kernel/time.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2
> 
> gcc gets unhappy when the MSTK_SET macro's u8 __val variable
> is updated with &= ~0xff (MSTK_YEAR_MASK). Making the constant
> unsigned fixes the problem.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Patch applied, thanks a lot.  I took care of the 32-bit sparc
header file which had the same problem.
