From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jul 2013 13:08:43 +0000
Subject: Re: [PATCH 0/2] Make PPC macro spin_event_timeout() architecture independent
Message-Id: <CAMuHMdXP3-uKbftP-2UeZdE6X_iTi1podNDh0aVF3bJwDYssdg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
In-Reply-To: <1375187900-17582-1-git-send-email-B44344@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 30, 2013 at 2:38 PM, Arpit Goel <B44344@freescale.com> wrote:
> This patch-set moves USECS_PER_JIFFY to architecture timex.h from architecture
> specific C files. Patch-set further uses this to make PPC macro
> spin_event_timeout() architecture independent. This change enables drivers to
> use spin_event_timeout() even in non-PowerPC based SoC's.
>
> This patchset has been compiled for ARM, PowerPC and x86.
>
> Patch[1/2] : Moves USECS_PER_JIFFY to architecture specific timex.h files from
>              architecture specific C files.

>  arch/arm/include/asm/timex.h      |  2 ++
>  arch/arm/kernel/time.c            |  3 ---
>  arch/m32r/include/asm/timex.h     |  2 ++
>  arch/m32r/kernel/time.c           |  3 ---
>  arch/m68k/hp300/time.c            |  4 +---
>  arch/m68k/include/asm/timex.h     |  2 ++
>  arch/s390/include/asm/timex.h     |  2 ++
>  arch/s390/kernel/time.c           |  2 --
>  arch/sparc/include/asm/timex_32.h |  2 ++
>  arch/sparc/include/asm/timex_64.h |  2 ++
>  arch/sparc/kernel/pcic.c          |  1 -

As the definition is the same on all architectures, why not move it to
<linux/delay.h>?

> Patch[2/2] : Converts PPC macro spin_event_timeout() in architecture independent
>              macro.

>  include/linux/delay.h             | 40 +++++++++++++++++++++++++++++++++++++++

After your first patch, USECS_PER_JIFFY is still available only on
arm/m32r/m68k/s390/sparc. What about other architectures?
If anyone uses spin_event_timeout() on e.g. x86, it will fail to compile.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
