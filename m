From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 27 Jul 2018 21:05:48 +0000
Subject: Re: [PATCH] sparc: use generic dma_noncoherent_ops
Message-Id: <20180727210548.GA1476@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20180727164409.14873-1-hch@lst.de>
	<20180727164409.14873-2-hch@lst.de>
In-Reply-To: <20180727164409.14873-2-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

Hi Christoph.

Some observations below - nitpick and bikeshedding only.

The parameter of phys_addr_t is sometimes renamed
to use the same name as in the original prototype (good),
and sometimes uses the old name (bad).
This makes it inconsistent as the local name changes in the
different functions, but they represents the same.

I really like how you managed to kill a lot of code
with this patch.

You can add my:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

But that does imply that this is OK, you
must wait for davem.

	Sam

On Fri, Jul 27, 2018 at 06:44:09PM +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation.
> 
> This removes the previous sync_single_for_device implementation, which
> looks bogus given that no syncing is happening in the similar but more
> important map_single case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/Kconfig                   |   2 +
>  arch/sparc/include/asm/dma-mapping.h |   5 +-
>  arch/sparc/kernel/ioport.c           | 151 ++-------------------------
>  3 files changed, 14 insertions(+), 144 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 0f535debf802..79f29c67291a 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -48,6 +48,8 @@ config SPARC
>  
>  config SPARC32
>  	def_bool !64BIT
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> +	select DMA_NONCOHERENT_OPS

The current implementation has both:
pci32_sync_single_for_cpu() AND
pci32_sync_single_for_device

Yet, the new implementation only include arch_sync_dma_for_cpu()
You addressed this in the changelog - so I guess it is OK.


> --- a/arch/sparc/include/asm/dma-mapping.h
> +++ b/arch/sparc/include/asm/dma-mapping.h
> @@ -7,7 +7,6 @@
>  #include <linux/dma-debug.h>
>  
>  extern const struct dma_map_ops *dma_ops;
> -extern const struct dma_map_ops pci32_dma_ops;
>  
>  extern struct bus_type pci_bus_type;
>  
> @@ -15,11 +14,11 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  {
>  #ifdef CONFIG_SPARC_LEON
>  	if (sparc_cpu_model = sparc_leon)
> -		return &pci32_dma_ops;
> +		return &dma_noncoherent_ops;
>  #endif
>  #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
>  	if (bus = &pci_bus_type)
> -		return &pci32_dma_ops;
> +		return &dma_noncoherent_ops;
>  #endif
>  	return dma_ops;
>  }
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index cca9134cfa7d..960c1bc22c2e 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -38,6 +38,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/scatterlist.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/of_device.h>
>  
>  #include <asm/io.h>
> @@ -434,9 +435,8 @@ arch_initcall(sparc_register_ioport);
>  /* Allocate and map kernel buffer using consistent mode DMA for a device.
>   * hwdev should be valid struct pci_dev pointer for PCI devices.
>   */
> -static void *pci32_alloc_coherent(struct device *dev, size_t len,
> -				  dma_addr_t *pba, gfp_t gfp,
> -				  unsigned long attrs)
> +void *arch_dma_alloc(struct device *dev, size_t len, dma_addr_t *pba, gfp_t gfp,
> +		unsigned long attrs)

This function was renamed in ee664a9252d24 and is now renamed again.
The printk statements should be updated to use arch_dma_alloc.


>  {
>  	unsigned long len_total = PAGE_ALIGN(len);
>  	void *va;
> @@ -488,8 +488,8 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
>   * References to the memory and mappings associated with cpu_addr/dma_addr
>   * past this call are illegal.
>   */
> -static void pci32_free_coherent(struct device *dev, size_t n, void *p,
> -				dma_addr_t ba, unsigned long attrs)
> +void arch_dma_free(struct device *dev, size_t n, void *p, dma_addr_t ba,
> +		unsigned long attrs)
Likewise, use arch_dma_free in printk statements

