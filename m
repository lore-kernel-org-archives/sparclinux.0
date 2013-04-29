From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2013 07:20:25 +0000
Subject: Re: [PATCH] lib: add weak __clzsi2()/__clzdi2() functions
Message-Id: <CAMuHMdWk4oi_KCmZv7hLZ7JSwy=meziKPBMQ1HJiJR9W8AdrDg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1367214005-14302-1-git-send-email-chanho.min@lge.com>
In-Reply-To: <1367214005-14302-1-git-send-email-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanho Min <chanho.min@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kyungsik Lee <kyungsik.lee@lge.com>, Yann Collet <yann.collet.73@gmail.com>, Bob Pearson <rpearson@systemfabricworks.com>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Next <linux-next@vger.kernel.org>

On Mon, Apr 29, 2013 at 7:40 AM, Chanho Min <chanho.min@lge.com> wrote:
> Some architectures need __clzsi2() or __clzdi2() for __builtin_clz and
> It causes build failure. They can be implemented using the fls() and
> overridden by linking arch-specific versions may not be implemented yet.
>
> Reference: https://lkml.org/lkml/2013/4/18/603
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Chanho Min <chanho.min@lge.com>

Thanks, this fixes the link error on m68k, so

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
