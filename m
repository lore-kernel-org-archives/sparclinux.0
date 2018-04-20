From: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 20 Apr 2018 10:23:43 +0000
Subject: Re: [PATCH 01/22] dma-debug: move initialization to common code
Message-Id: <294a1469-01d6-10fb-5de1-b1d4513a066c@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-2-hch@lst.de>
In-Reply-To: <20180420080313.18796-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Christoph,

Nice cleanup! Looks good overall, just a couple of nits.

On 20/04/18 09:02, Christoph Hellwig wrote:
[...]
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 7f5cdc1e6b29..712a897174e4 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -41,6 +41,11 @@
>   #define HASH_FN_SHIFT   13
>   #define HASH_FN_MASK    (HASH_SIZE - 1)
>   
> +/* allow architectures to override this if absolutely required */
> +#ifndef PREALLOC_DMA_DEBUG_ENTRIES
> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> +#endif
> +
>   enum {
>   	dma_debug_single,
>   	dma_debug_page,
> @@ -1004,18 +1009,16 @@ void dma_debug_add_bus(struct bus_type *bus)
>   	bus_register_notifier(bus, nb);
>   }
>   
> -/*
> - * Let the architectures decide how many entries should be preallocated.
> - */
> -void dma_debug_init(u32 num_entries)
> +static int dma_debug_init(void)
>   {
> +	u32 num_entries;

Maybe initialise it to PREALLOC_DMA_DEBUG_ENTRIES?

>   	int i;
>   
>   	/* Do not use dma_debug_initialized here, since we really want to be
>   	 * called to set dma_debug_initialized
>   	 */
>   	if (global_disable)
> -		return;
> +		return 0;
>   
>   	for (i = 0; i < HASH_SIZE; ++i) {
>   		INIT_LIST_HEAD(&dma_entry_hash[i].list);
> @@ -1026,17 +1029,19 @@ void dma_debug_init(u32 num_entries)
>   		pr_err("DMA-API: error creating debugfs entries - disabling\n");
>   		global_disable = true;
>   
> -		return;
> +		return 0;
>   	}
>   
>   	if (req_entries)
>   		num_entries = req_entries;
> +	else
> +		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   	if (prealloc_memory(num_entries) != 0) {
>   		pr_err("DMA-API: debugging out of memory error - disabled\n");
>   		global_disable = true;
>   
> -		return;
> +		return 0;
>   	}
>   
>   	nr_total_entries = num_free_entries;
> @@ -1044,7 +1049,9 @@ void dma_debug_init(u32 num_entries)
>   	dma_debug_initialized = true;
>   
>   	pr_info("DMA-API: debugging enabled by kernel config\n");
> +	return 0;
>   }
> +core_initcall(dma_debug_init);

I think it's worth noting that for most users this now happens much 
earlier than before. In general that's probably good (e.g. on arm64 it 
should prevent false-positives from the Arm SMMU drivers under ACPI), 
and I can't imagine it's high-risk, but it is a behaviour change.

Robin.

>   
>   static __init int dma_debug_cmdline(char *str)
>   {
> 
