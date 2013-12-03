From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Dec 2013 21:01:27 +0000
Subject: Re: Build regressions/improvements in v3.13-rc2
Message-Id: <CAMuHMdXsn9R6-R5yMCnjEmum5LjBRmL8+v+_ryvRLJyQBg1ZtA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV1hoUnYixPghCAy-LuTaB9JU-BFfBPH06gxhLRAqfp8Q@mail.gmail.com>
 <20131203204540.GA4796@roeck-us.net>
In-Reply-To: <20131203204540.GA4796@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Dec 3, 2013 at 9:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> ia64-defconfig:
>
> arch/ia64/kernel/built-in.o: In function `skip_rbs_switch':
> (.text+0xef2): undefined reference to `preempt_schedule_irq'

Funny, that one was actually introduced in v3.13-rc1, but it fell through
the cracks of the regex handling in my script.

BTW, my scripts are back online: https://github.com/geertu/linux-scripts.
linux-log-diff didn't see the ia64 breakage, linux-log-summary did.
One day I plan to merge linux-log-diff and linux-log-summary, so I have
to maintain only one regex chain.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
