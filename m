From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Nov 2016 14:29:28 +0000
Subject: Re: Build regressions/improvements in v4.9-rc7
Message-Id: <CAMuHMdXQ1--skMHOW1HLtCeeeGR4PqkYLHh8rVukPU=V8u4fQg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1480343257-26723-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1480343257-26723-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>

On Mon, Nov 28, 2016 at 3:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.9-rc7[1] to v4.9-rc6[3], the summaries are:
>   - build errors: +10/-4

  + /home/kisskb/slave/src/drivers/scsi/qlogicpti.c: error: passing
argument 3 of 'dma_alloc_coherent' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 813:9, 822:9
  + /home/kisskb/slave/src/sound/sparc/dbri.c: error: passing argument
3 of 'dma_zalloc_coherent' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 2538:6

sparc64-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/e5517c2a5a49ed5e99047008629f1cd60246ea0e/ (all 267 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9c763584b7c8911106bb77af7e648bef09af9d80/ (all 267 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
