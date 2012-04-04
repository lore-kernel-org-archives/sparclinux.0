From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 04 Apr 2012 17:44:00 +0000
Subject: Re: [PATCH] irq: remove obsolete definitions in interrupt.h
Message-Id: <CAMuHMdXuODijkJrPOwppaU9z07ziBFFoag6AQT7vqr0yXva3Aw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404074553.GA14959@merkur.ravnborg.org>
In-Reply-To: <20120404074553.GA14959@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-m68k@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>, sparclinux <sparclinux@vger.kernel.org>, linux-s390@vger.kernel.org

On Wed, Apr 4, 2012 at 09:45, Sam Ravnborg <sam@ravnborg.org> wrote:
> interrupt.h contained a small fixlet for the days when
> m68k and sparc32 did not use genirq.
> As they have both entered the modern world this
> fixlet can be dropped.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: "David S. Miller" <davem@davemloft.net>

Does this affect s390 (the sole !genirq arch) negatively?

If not:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
