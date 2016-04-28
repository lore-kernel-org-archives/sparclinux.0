From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Apr 2016 17:51:06 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <CAMuHMdU2e2PdwKYVaEsJ73X8Di1XHNPqnxuunr8R8bN8udazxw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
 <20160428164856.10120.qmail@ns.horizon.com>
In-Reply-To: <20160428164856.10120.qmail@ns.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 28, 2016 at 6:48 PM, George Spelvin <linux@horizon.com> wrote:
> Another few comments:
>
> 1. Would ARCH_HAS_FAST_FFS involve fewer changes than CPU_NO_EFFICIENT_FFS?

No, as you want to _disable_ ARCH_HAS_FAST_FFS / _enable_
CPU_NO_EFFICIENT_FFS as soon as you're enabling support for a
CPU that doesn't support it.

Logical OR is easier in both the Kconfig and C preprocessor languages
than logical NAND.

E.g. in Kconfig, a CPU core not supporting it can just select
CPU_NO_EFFICIENT_FFS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
