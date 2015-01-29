From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 29 Jan 2015 16:33:51 +0000
Subject: Re: [PATCH] sparc: io_64.h: Replace io function-link macros
Message-Id: <CAPybu_2T93eMc7pBh9gUwwBjv0TfsKR6=YVmYLRTQF7E88F5Xw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1422543122-21956-1-git-send-email-ricardo.ribalda@gmail.com> <2627276.KBn6RpFkKO@wuerfel>
In-Reply-To: <2627276.KBn6RpFkKO@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello Arnd

On Thu, Jan 29, 2015 at 5:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I suspect such code is broken on a lot of platforms:
>
> arch/alpha/include/asm/io.h:#define ioread32be(p) be32_to_cpu(ioread32(p))
> arch/arm/include/asm/io.h:#define ioread32be(p)         ({ __u32 __v = be32_to_cpu((__force arch/arm/mach-ixp4xx/include/mach/io.h:#define  ioread32(p)                     ioread32(p)
> arch/arm/mach-ixp4xx/include/mach/io.h:#define  ioread32_rep(p, v, c)           ioread32_rep(p, v, c)
> arch/arm64/include/asm/io.h:#define ioread32be(p)               ({ __u32 __v = be32_to_cpu((__force arch/avr32/include/asm/io.h:#define ioread32(p)         ((unsigned int)readl(p))
> arch/avr32/include/asm/io.h:#define ioread32be(p)               ((unsigned int)__raw_readl(p))
> arch/mn10300/include/asm/io.h:#define ioread32(addr)            readl(addr)
> arch/sparc/include/asm/io_64.h:#define ioread32(X)                      readl(X)
> arch/sparc/include/asm/io_64.h:#define ioread32be(X)                    __raw_readl(X)
> arch/tile/include/asm/io.h:#define ioread32be(addr)     be32_to_cpu(ioread32(addr))
> arch/arm/include/asm/io.h:#define readl(c)              ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> arch/arm/mach-ebsa110/include/mach/io.h:#define readl(b)                __readl(b)
> arch/arm/mach-ebsa110/include/mach/io.h:#define readl_relaxed(addr)     readl(addr)
> arch/arm/mach-ixp4xx/include/mach/io.h:#define readl(p)                 __indirect_readl(p)
> arch/arm64/include/asm/io.h:#define readl(c)            ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> arch/cris/include/asm/io.h:#define readl_relaxed(addr) readl(addr)
> arch/ia64/include/asm/io.h:#define readl(a)     __readl((a))
> arch/m32r/include/asm/io.h:#define readl(addr)   _readl((unsigned long)(addr))
> arch/m68k/include/asm/io.h:#define readl_relaxed(addr)  readl(addr)
> arch/m68k/include/asm/io_mm.h:#define readl(addr)      in_le32(addr)
> arch/m68k/include/asm/io_no.h:#define readl(addr) \
> arch/nios2/include/asm/io.h:#define readl_relaxed(addr) readl(addr)
> arch/parisc/include/asm/io.h:#define readl_relaxed(addr)        readl(addr)
> arch/powerpc/include/asm/io.h:#define readl_relaxed(addr)       readl(addr)
> arch/sh/include/asm/io.h:#define readl(a)               ({ u32 r_ = readl_relaxed(a); rmb(); r_; })
>
> Maybe it's easier to fix the drivers that do this?

Instead of having 1000 wrappers on the drivers I believe that all the
arches should behave the same.

So far, the build daemon has only complained about this arch when
changing spi/xilinx.

I dont mind reviewing also the other arches, but anyway, with some
luck another developer will base his code on this driver, trigger
another build error and eventually all the arches will be fixed :).


>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Fixes: 99082eab63449f9d spi/xilinx: Remove iowrite/ioread wrappers
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>
> I don't see 99082eab63449f9d in linux-next.

It is at broonie/spi.git/topic/xilinx

>
>         Arnd

Thanks!!!



-- 
Ricardo Ribalda
