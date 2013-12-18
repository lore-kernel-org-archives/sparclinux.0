From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 18 Dec 2013 08:49:06 +0000
Subject: Re: [PATCH 2/3] [RESEND]sparc64: convert spinloc_t to raw_spinlock_t in  mmu_context_t
Message-Id: <52B16182.9090209@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1387345326-20185-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1387345326-20185-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Allen Pais <allen.pais@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 12/18/2013 06:42 AM, Allen Pais wrote:
> index 554995d..aae5aa9 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -27,6 +27,7 @@ config SPARC
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_GENERIC_HARDIRQS
> +	select IRQ_FORCED_THREADING
>  	select GENERIC_IRQ_SHOW
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select USE_GENERIC_SMP_HELPERS if SMP

Sorry for not noticing this earlier but this has nothing to do with the
remaining part of the patch.
To be able to set this flag, you need to mark timer & perf interrupts.
If you already use IRQF_TIMER for the timer and perf interrupts are
already coming as NMU then you are done. But please split this out as a
separate patch.

Sebastian
