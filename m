From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2020 07:44:36 +0000
Subject: Re: Build regressions/improvements in v5.8-rc1
Message-Id: <CAMuHMdWh9w_50uPhFYZ26GOfp=Uv_DCg94M1GN9cuizz2+GxJQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200615073533.1809-1-geert@linux-m68k.org>
In-Reply-To: <20200615073533.1809-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>

On Mon, Jun 15, 2020 at 9:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.8-rc1[1] compared to v5.7[2].
>
> Summarized:
>   - build errors: +4/-4
>   - build warnings: +66/-42
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b3a9e3b9622ae10064826dccb4f7a52bd88c7407/ (192 out of 194 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162/ (all 194 configs)
>
>
> *** ERRORS ***
>
> 4 error regressions:
>   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x28), (.fixup+0x1c), (.fixup+0x4), (.fixup+0x10), (.fixup+0x34)

sparc-allmodconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
