From: David Miller <davem@davemloft.net>
Date: Mon, 21 Mar 2016 18:22:55 +0000
Subject: Re: [PATCH 1/1] [RFC]sparc64: enable cpu hotplug feature
Message-Id: <20160321.142255.1043423950476768542.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Sat, 27 Feb 2016 15:08:26 +0530

> @@ -1277,20 +1277,26 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
>  	int ret = smp_boot_one_cpu(cpu, tidle);
>  
> -	if (!ret) {
> -		cpumask_set_cpu(cpu, &smp_commenced_mask);
> -		while (!cpu_online(cpu))
> -			mb();
> -		if (!cpu_online(cpu)) {
> -			ret = -ENODEV;
> -		} else {
> -			/* On SUN4V, writes to %tick and %stick are
> -			 * not allowed.
> -			 */
> -			if (tlb_type != hypervisor)
> -				smp_synchronize_one_tick(cpu);
> -		}
> +	if (ret)
> +		goto out;
> +
> +	cpumask_set_cpu(cpu, &smp_commenced_mask);
> +	while (!cpu_online(cpu))
> +		mb();
> +	if (!cpu_online(cpu)) {
> +		ret = -ENODEV;
> +		goto out;
>  	}
> +
> +	/* On SUN4V, writes to %tick and %stick are
> +	 * not allowed.
> +	 */
> +	if (tlb_type != hypervisor)
> +		smp_synchronize_one_tick(cpu);
> +
> +	smp_fill_in_sib_core_maps();
> +	cpu_map_rebuild();
> +out:
>  	return ret;
>  }
>  

You've made this significantly harder to review and audit by moving the code
around so much.

Just add the new calls:

	smp_fill_in_sib_core_maps();
	cpu_map_rebuild();

in the existing basic block containing the smp_synchronize_one_tick() call.

Then it's obvious to reviewers what your change is actually doing.

>  
> +	set_cpu_online(cpu, false);
> +
>  	/* Make sure no interrupts point to this cpu.  */
>  	fixup_irqs();

This looks like a bug fix, to make sure fixup_irqs() does the right
thing, right?

All the little bug fixes like this should be split out into separate
patches.

Thanks.
