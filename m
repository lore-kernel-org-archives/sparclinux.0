From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 27 Apr 2016 09:31:45 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20160427093145.GJ19428@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
In-Reply-To: <1461239325-22779-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 21, 2016 at 01:48:42PM +0200, Petr Mladek wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cdfa6c2b7626..259543ec6dc9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -66,6 +66,7 @@ config ARM
>  	select HAVE_KRETPROBES if (HAVE_KPROBES)
>  	select HAVE_MEMBLOCK
>  	select HAVE_MOD_ARCH_SPECIFIC
> +	select HAVE_NMI
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_OPTPROBES if !THUMB2_KERNEL
>  	select HAVE_PERF_EVENTS
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index baee70267f29..df90bc59bfce 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -644,9 +644,11 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		break;
>  
>  	case IPI_CPU_BACKTRACE:
> +		printk_nmi_enter();
>  		irq_enter();
>  		nmi_cpu_backtrace(regs);
>  		irq_exit();
> +		printk_nmi_exit();
>  		break;
>  
>  	default:

For the above,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
