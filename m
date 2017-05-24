From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 May 2017 09:59:21 +0000
Subject: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_BIG_
Message-Id: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
> Found this problem while enabling queued rwlock on SPARC.
> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
> specific byte in qrwlock structure. Without this parameter,
> we clear the wrong byte. Here is the code.
>
> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>  {
>         return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>  }
>
> Define CPU_BIG_ENDIAN for SPARC to fix it.

> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>  config ARCH_PROC_KCORE_TEXT
>         def_bool y
>
> +config CPU_BIG_ENDIAN
> +       bool
> +       default y if SPARC

Nice catch!

Traditionally, CPU_BIG_ENDIAN and CPU_LITTLE_ENDIAN were defined only on
architectures that may support both.  And it was checked in platform code
and drivers only.
Hence the symbol is lacking from most architectures. Heck, even
architectures that support both may default to one endiannes, and declare
only the symbol for the other endianness:

--- arch/alpha ---
--- arch/arc ---
arch/arc/Kconfig:config CPU_BIG_ENDIAN
--- arch/arm ---
arch/arm/mm/Kconfig:config CPU_BIG_ENDIAN
--- arch/arm64 ---
arch/arm64/Kconfig:config CPU_BIG_ENDIAN
--- arch/blackfin ---
--- arch/c6x ---
arch/c6x/Kconfig:config CPU_BIG_ENDIAN
--- arch/cris ---
--- arch/frv ---
--- arch/h8300 ---
--- arch/hexagon ---
--- arch/ia64 ---
--- arch/Kconfig ---
--- arch/m32r ---
arch/m32r/Kconfig:config CPU_LITTLE_ENDIAN
--- arch/m68k ---
--- arch/metag ---
--- arch/microblaze ---
--- arch/mips ---
arch/mips/Kconfig:config CPU_BIG_ENDIAN
arch/mips/Kconfig:config CPU_LITTLE_ENDIAN
--- arch/mn10300 ---
--- arch/nios2 ---
--- arch/openrisc ---
--- arch/parisc ---
--- arch/powerpc ---
arch/powerpc/platforms/Kconfig.cputype:config CPU_BIG_ENDIAN
arch/powerpc/platforms/Kconfig.cputype:config CPU_LITTLE_ENDIAN
--- arch/s390 ---
arch/s390/Kconfig:config CPU_BIG_ENDIAN
--- arch/score ---
--- arch/sh ---
arch/sh/Kconfig.cpu:config CPU_LITTLE_ENDIAN
arch/sh/Kconfig.cpu:config CPU_BIG_ENDIAN
--- arch/sparc ---
--- arch/tile ---
--- arch/um ---
--- arch/unicore32 ---
--- arch/x86 ---
--- arch/xtensa ---

However, there are already a few users in generic code, which are thus
broken on many platforms:

    drivers/of/base.c
    drivers/of/fdt.c
    drivers/tty/serial/earlycon.c
    drivers/tty/serial/serial_core.c

include/asm-generic/qrwlock.h is also generic, but depends on the
architecture to select ARCH_USE_QUEUED_RWLOCKS, which only very few do
(x86, and now sparc).

I guess the time is ripe for adding (both) symbols to all architectures?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
