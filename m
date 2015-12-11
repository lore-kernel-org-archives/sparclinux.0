From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Dec 2015 11:10:02 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
In-Reply-To: <1449667265-17525-5-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
>                      13 =>   8 KB for each CPU
>                      12 =>   4 KB for each CPU
>
> +config NMI_LOG_BUF_SHIFT
> +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
> +       range 10 21
> +       default 13
> +       depends on PRINTK && HAVE_NMI

Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.

> +       help
> +         Select the size of a per-CPU buffer where NMI messages are temporary
> +         stored. They are copied to the main log buffer in a safe context
> +         to avoid a deadlock. The value defines the size as a power of 2.
> +
> +         NMI messages are rare and limited. The largest one is when
> +         a backtrace is printed. It usually fits into 4KB. Select
> +         8KB if you want to be on the safe side.
> +
> +         Examples:
> +                    17 => 128 KB for each CPU
> +                    16 =>  64 KB for each CPU
> +                    15 =>  32 KB for each CPU
> +                    14 =>  16 KB for each CPU
> +                    13 =>   8 KB for each CPU
> +                    12 =>   4 KB for each CPU
> +
>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> index 5465230b75ec..78c07d441b4e 100644
> --- a/kernel/printk/nmi.c
> +++ b/kernel/printk/nmi.c
> @@ -41,7 +41,8 @@ DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
>  static int printk_nmi_irq_ready;
>  atomic_t nmi_message_lost;
>
> -#define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
> +#define NMI_LOG_BUF_LEN ((1 << CONFIG_NMI_LOG_BUF_SHIFT) -             \
> +                        sizeof(atomic_t) - sizeof(struct irq_work))

kernel/printk/nmi.c:50:24: error: 'CONFIG_NMI_LOG_BUF_SHIFT'
undeclared here (not in a function)

E.g. efm32_defconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/12565754/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
