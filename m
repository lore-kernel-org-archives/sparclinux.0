From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Jan 2015 16:02:54 +0000
Subject: Re: [PATCH] sparc: io_64.h: Replace io function-link macros
Message-Id: <2627276.KBn6RpFkKO@wuerfel>
List-Id: <sparclinux.vger.kernel.org>
References: <1422543122-21956-1-git-send-email-ricardo.ribalda@gmail.com>
In-Reply-To: <1422543122-21956-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 29 January 2015 15:52:02 Ricardo Ribalda Delgado wrote:
> Function like macros cannot be assigned to function pointers. This patch
> convert the function-like macros into object-macros, that the
> precompiler will replace with the name of the final function.
> 
> With this patch this kind of code will work:
> 
> if (priv->mode_big_endian)
> 	priv.read = ioread32be;
> else
> 	priv.read = ioread32;
> 
> Same approach has been taken on asm-generic/io.h

I suspect such code is broken on a lot of platforms:

arch/alpha/include/asm/io.h:#define ioread32be(p) be32_to_cpu(ioread32(p))
arch/arm/include/asm/io.h:#define ioread32be(p)         ({ __u32 __v = be32_to_cpu((__force arch/arm/mach-ixp4xx/include/mach/io.h:#define  ioread32(p)                     ioread32(p)
arch/arm/mach-ixp4xx/include/mach/io.h:#define  ioread32_rep(p, v, c)           ioread32_rep(p, v, c)
arch/arm64/include/asm/io.h:#define ioread32be(p)               ({ __u32 __v = be32_to_cpu((__force arch/avr32/include/asm/io.h:#define ioread32(p)         ((unsigned int)readl(p))
arch/avr32/include/asm/io.h:#define ioread32be(p)               ((unsigned int)__raw_readl(p))
arch/mn10300/include/asm/io.h:#define ioread32(addr)            readl(addr)
arch/sparc/include/asm/io_64.h:#define ioread32(X)                      readl(X)
arch/sparc/include/asm/io_64.h:#define ioread32be(X)                    __raw_readl(X)
arch/tile/include/asm/io.h:#define ioread32be(addr)     be32_to_cpu(ioread32(addr))
arch/arm/include/asm/io.h:#define readl(c)              ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
arch/arm/mach-ebsa110/include/mach/io.h:#define readl(b)                __readl(b)
arch/arm/mach-ebsa110/include/mach/io.h:#define readl_relaxed(addr)     readl(addr)
arch/arm/mach-ixp4xx/include/mach/io.h:#define readl(p)                 __indirect_readl(p)
arch/arm64/include/asm/io.h:#define readl(c)            ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
arch/cris/include/asm/io.h:#define readl_relaxed(addr) readl(addr)
arch/ia64/include/asm/io.h:#define readl(a)     __readl((a))
arch/m32r/include/asm/io.h:#define readl(addr)   _readl((unsigned long)(addr))
arch/m68k/include/asm/io.h:#define readl_relaxed(addr)  readl(addr)
arch/m68k/include/asm/io_mm.h:#define readl(addr)      in_le32(addr)
arch/m68k/include/asm/io_no.h:#define readl(addr) \
arch/nios2/include/asm/io.h:#define readl_relaxed(addr) readl(addr)
arch/parisc/include/asm/io.h:#define readl_relaxed(addr)        readl(addr)
arch/powerpc/include/asm/io.h:#define readl_relaxed(addr)       readl(addr)
arch/sh/include/asm/io.h:#define readl(a)               ({ u32 r_ = readl_relaxed(a); rmb(); r_; })

Maybe it's easier to fix the drivers that do this?

> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: 99082eab63449f9d spi/xilinx: Remove iowrite/ioread wrappers
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

I don't see 99082eab63449f9d in linux-next.

	Arnd
