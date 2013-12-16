From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 16 Dec 2013 10:26:51 +0000
Subject: Re: [PATCH 1/3] sparc64: use generic rwsem spinlocks rt
Message-Id: <52AED56B.2090102@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1387166853-10782-1-git-send-email-allen.pais@oracle.com> <1387166853-10782-2-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1387166853-10782-2-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Allen Pais <allen.pais@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 12/16/2013 05:07 AM, Allen Pais wrote:
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -179,12 +179,10 @@ config NR_CPUS
>  source kernel/Kconfig.hz
>  
>  config RWSEM_GENERIC_SPINLOCK
> -	bool
> -	default y if SPARC32
> +	def_bool PREEMPT_RT_FULL
>  
>  config RWSEM_XCHGADD_ALGORITHM
> -	bool
> -	default y if SPARC64
> +	def_bool !RWSEM_GENERIC_SPINLOCK && !PREEMPT_RT_FULL
>  
>  config GENERIC_HWEIGHT
>  	bool


davem won't apply this because the PREEMPT_RT symbol is not available
upstream. I referred to patch two+.

Sebastian
