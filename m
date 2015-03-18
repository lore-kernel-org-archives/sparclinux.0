From: David Ahern <david.ahern@oracle.com>
Date: Wed, 18 Mar 2015 21:22:37 +0000
Subject: Re: maps mismatch in /proc/kcore for sparc
Message-Id: <5509EC9D.2060506@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5509AE36.8040902@oracle.com>	<20150318.154359.1325469409095627387.davem@davemloft.net>	<5509D8C7.5080504@oracle.com> <20150318.161403.1392052398222912621.davem@davemloft.net>
In-Reply-To: <20150318.161403.1392052398222912621.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 3/18/15 2:14 PM, David Miller wrote:
> Oh I see, you're using older sources which don't have:
>
> 	commit abaf3787ac26ba33e2f75e76b1174c32254c25b0
> 	Author: Paul Gortmaker <paul.gortmaker@windriver.com>
> 	Date:   Thu Jan 23 15:55:45 2014 -0800
>
> 	    fs/proc: don't use module_init for non-modular core code

Interesting.

# git describe abaf3787ac26ba33e2f75e76b1174c32254c25b0
v3.13-4322-gabaf3787ac26

I am running 3.18 and that patch has been applied to the tree.

Looking at 4.0.0-rc3 and I do see the 0-length problem. Perhaps another 
defect is the root cause?

Regardless the below works.

David

>
> And that explains everything, I'll submit the following:
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 96ac69c..efb00ec 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -86,6 +86,9 @@ config ARCH_DEFCONFIG
>   	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
>   	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
>
> +config ARCH_PROC_KCORE_TEXT
> +	def_bool y
> +
>   config IOMMU_HELPER
>   	bool
>   	default y if SPARC64
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 3ea267c..4ca0d6b 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2820,7 +2820,7 @@ static int __init report_memory(void)
>
>   	return 0;
>   }
> -device_initcall(report_memory);
> +arch_initcall(report_memory);
>
>   #ifdef CONFIG_SMP
>   #define do_flush_tlb_kernel_range	smp_flush_tlb_kernel_range
>

