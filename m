From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 27 Apr 2012 17:27:50 +0000
Subject: Re: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120427172750.GA5358@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120426.235507.1967848292117984225.davem@davemloft.net>
In-Reply-To: <20120426.235507.1967848292117984225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 5b84559..def9223 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -1748,22 +1748,27 @@ void __init paging_init(void)
>  #endif
>  	}
>  
> +	/* Setup bootmem... */
> +	last_valid_pfn = end_pfn = bootmem_init(phys_base);
> +


> +#ifndef CONFIG_NEED_MULTIPLE_NODES
> +	max_mapnr = last_valid_pfn;
> +#endif
This assignment looks redundant. I cannot see any uses of max_mapnr
in the kernel (which is relevant for sparc64).

I am perfectly aware that this was not introduced by your patch,
but I looked at it anyway.


>  	/* Once the OF device tree and MDESC have been setup, we know
>  	 * the list of possible cpus.  Therefore we can allocate the
>  	 * IRQ stacks.
>  	 */
>  	for_each_possible_cpu(i) {
> -		/* XXX Use node local allocations... XXX */
> -		softirq_stack[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> -		hardirq_stack[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> -	}
> +		int node = cpu_to_node(i);
>  
> -	/* Setup bootmem... */
> -	last_valid_pfn = end_pfn = bootmem_init(phys_base);
> +		softirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
> +							THREAD_SIZE,
> +							THREAD_SIZE, 0);
Knowing that sparc64 just got converted to NO_BOOTMEM it
hurts my eyes to see memblock_alloc() be replaced
by __alloc_bootmem_node().

It looks like memblock_alloc_try_nid() could be used.
It will try nid and revert back to all nodes if it fails to allocate
memory on nid.

But you would then have to memset the memory manually and convert to __va() too.

	Sam
