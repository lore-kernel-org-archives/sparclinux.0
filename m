From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2020 08:44:47 +0000
Subject: Re: Build regressions/improvements in v5.9-rc7
Message-Id: <CAMuHMdW-k05Czd4C9mq1ny9BhJUBt_=MW+digqE0ycTgWm2q4w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200928063603.22564-1-geert@linux-m68k.org>
In-Reply-To: <20200928063603.22564-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Mon, Sep 28, 2020 at 8:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9-rc7[1] to v5.9-rc6[3], the summaries are:
>   - build errors: +5/-3

  + error: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko]
undefined!:  => N/A

mips-allmodconfig (It's back, first seen in v5.9-rc1)

  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040),
(.head.text+0x5100)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text
section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to
fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.text':  => (.fixup+0x28), (.fixup+0x4),
(.fixup+0x10), (.fixup+0x1c), (.fixup+0x34)

Probably nothing we can do?

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a1b8638ba1320e6684aa98233c15255eb803fac7/ (all 192 configs)

> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ba4f184e126b751d1bffad5897f263108befc780/ (all 192 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
