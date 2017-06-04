From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2017 23:46:53 +0000
Subject: Re: [PATCH] arch/sparc: support NR_CPUS = 4096
Message-Id: <20170604.194653.1906726081560123777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1496353153-587795-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1496353153-587795-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jane.chu@oracle.com
Cc: tglx@linutronix.de, atish.patra@oracle.com, Liam.Howlett@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>
Date: Thu,  1 Jun 2017 15:39:13 -0600

> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index 4d0248a..5b19108 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -1034,12 +1034,12 @@ static void __init init_cpu_send_mondo_info(struct trap_per_cpu *tb)
>  {
>  #ifdef CONFIG_SMP
>  	unsigned long page;
> +	unsigned int order;
>  
> -	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > (PAGE_SIZE - 64));
> -
> -	page = get_zeroed_page(GFP_KERNEL);
> +	order = get_order(num_possible_cpus() * sizeof(u16) + 64);
> +	page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!page) {

The only reason we allocated these two items together was because it
was convenient and it all fit into a single page.

Since it now doesn't, it makes sense to split it up.

Simply use a single page for the cpu_list_pa and kzalloc for the
cpu_mondo_block.

This also allows to keep the BUILD_BUG_ON(), which I really wish
you hadn't tried to remove.

static void __init init_cpu_send_mondo_info(struct trap_per_cpu *tb)
{
#ifdef CONFIG_SMP
	unsigned long page;
	void *mondo;

	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > PAGE_SIZE);

	mondo = kzalloc(64, GFP_KERNEL);
	if (!mondo) {
		prom_printf("SUN4V: Error, cannot allocate mondo block.\n");
		prom_halt();
	}
	tb->cpu_mondo_block_pa = __pa(mondo);

	page = get_zeroed_page(GFP_KERNEL);
	if (!page) {
		prom_printf("SUN4V: Error, cannot allocate cpu list page.\n");
		prom_halt();
	}
	tb->cpu_list_pa = __pa(page);
#endif
}

Thanks.
