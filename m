From: Anatoly Pugachev <matorola@gmail.com>
Date: Fri, 03 Jul 2020 16:29:58 +0000
Subject: Re: [PATCH 1/2] sparc64: Deselect IRQ_PREFLOW_FASTEOI
Message-Id: <CADxRZqxcLXz4wp6Bj7=MWx04BJ7cHmHy6o_f+1V9_yNXNHH6-g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200703155645.29703-1-valentin.schneider@arm.com> <20200703155645.29703-2-valentin.schneider@arm.com>
In-Reply-To: <20200703155645.29703-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>

On Fri, Jul 3, 2020 at 6:58 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> sparc64 hasn't needed to select this since commit:
>
>   ee6a9333fa58 ("sparc64: sparse irq")
>
> which got rid of the calls to __irq_set_preflow_handler() first installed
> by commit:
>
>   fcd8d4f49869 ("sparc: Use the new genirq functionality")
>
> Deselect this option.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  arch/sparc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index da515fdad83d..ed35760043e8 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -81,7 +81,6 @@ config SPARC64
>         select RTC_DRV_STARFIRE
>         select HAVE_PERF_EVENTS
>         select PERF_USE_VMALLOC
> -       select IRQ_PREFLOW_FASTEOI
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG
>         select HAVE_C_RECORDMCOUNT
>         select HAVE_ARCH_AUDITSYSCALL


tried/tested this patch on my test sparc64 ldom , boots ok
