From: Petr Mladek <pmladek@suse.com>
Date: Thu, 18 Aug 2016 14:12:42 +0000
Subject: Re: [PATCH v8 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace() methods
Message-Id: <20160818141242.GK26194@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-2-git-send-email-cmetcalf@mellanox.com>
In-Reply-To: <1471377024-2244-2-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue 2016-08-16 15:50:21, Chris Metcalf wrote:
> Currently you can only request a backtrace of either all cpus, or
> all cpus but yourself.  It can also be helpful to request a remote
> backtrace of a single cpu, and since we want that, the logical
> extension is to support a cpumask as the underlying primitive.
> 
> This change modifies the existing lib/nmi_backtrace.c code to take
> a cpumask as its basic primitive, and modifies the linux/nmi.h code
> to use the new "cpumask" method instead.
> 
> The mips code ignored the "include_self" boolean but with this change
> it will now also dump a local backtrace if requested.
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 7429ad09fbe3..fea1fa7726e3 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -569,9 +569,16 @@ static void arch_dump_stack(void *info)
>  	dump_stack();
>  }
>  
> -void arch_trigger_all_cpu_backtrace(bool include_self)
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  {
> -	smp_call_function(arch_dump_stack, NULL, 1);
> +	long this_cpu = get_cpu();
> +
> +	if (cpumask_test_cpu(this_cpu, mask) && !exclude_self)
> +		dump_stack();

The bit is not cleared in the mask. Therefore arch_dump_stack
will get called for this CPU as well.

We could either use similar tricks as in lib/nmi_backtrace().
I mean to copy the mask into a global variable and prevent
parallel call with a backtrace_flag.

Or we could ignore the exclude_self flag as it was done
before. It is a separate problem after all and it need
not be solved in this patch(set).

> +
> +	smp_call_function_many(mask, arch_dump_stack, NULL, 1);
> +
> +	put_cpu();
>  }

Otherwise the patch patch looks good to me.

Best Regards,
Petr
