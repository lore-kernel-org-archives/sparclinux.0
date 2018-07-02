From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Jul 2018 14:09:40 +0000
Subject: Re: Build regressions/improvements in v4.18-rc3
Message-Id: <CAMuHMdUHkShW5dT41x06Jz9DUJHim6=Wg6pspgTBJpsoVNphwA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180702140050.1660-1-geert@linux-m68k.org>
In-Reply-To: <20180702140050.1660-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

On Mon, Jul 2, 2018 at 4:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.18-rc3[1] to v4.18-rc2[3], the summaries are:
>   - build errors: +1/-7

  + /kisskb/src/include/linux/highmem.h: error: passing argument 1 of
'sparc_flush_page_to_ram' from incompatible pointer type
[-Werror=incompatible-pointer-types]:  => 209:20, 233:36, 137:31

sparc64/sparc-allmodconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/021c91791a5e7e85c567452f1be3e4c2c6cb6063/ (231 out of 244 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7daf201d7fe8334e2d2364d4e8ed3394ec9af819/ (231 out of 244 configs)

> *** WARNINGS ***
>
> [Deleted 26903 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
> [Deleted 19308 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

Seems they're gone. Hopefully for good ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
