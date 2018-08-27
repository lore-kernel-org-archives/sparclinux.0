From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Aug 2018 09:55:10 +0000
Subject: Re: Build regressions/improvements in v4.19-rc1
Message-Id: <CAMuHMdVDmq+Kmi74jhL6CTS1cEt61xq-sX8cm208anYggUPWxg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180827094926.15512-1-geert@linux-m68k.org>
In-Reply-To: <20180827094926.15512-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, Aug 27, 2018 at 11:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.19-rc1[1] compared to v4.18[2].
>
> Summarized:
>   - build errors: +5/-3
>   - build warnings: +14732/-179
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5b394b2ddf0347bef56e50c69a58773c94343ff3/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94710cac0ef4ee177a63b5227664b38c95bbf703/ (239 out of 240 configs)
>
>
> *** ERRORS ***
>
> 5 error regressions:
>   + /kisskb/src/arch/nds32/include/asm/elf.h: error: expected '}' before ';' token:  => 126:29

nds32-allmodconfig, nds32-allyesconfig

>   + error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>   + error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x0), (.fixup+0x8), (.fixup+0x10), (.fixup+0x18), (.fixup+0x20)

sparc64/sparc-allmodconfig

> *** WARNINGS ***
>
> [Deleted 14564 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on powerpc-all{mod,yes}config*]

Parisc finally managed to get rid of these, and now powerpc got them :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
