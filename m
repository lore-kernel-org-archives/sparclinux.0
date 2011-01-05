From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 18:16:23 +0000
Subject: Re: [PATCH] sparc32: Added LEON dma_ops
Message-Id: <20110105181623.GA25187@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294243785-8082-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294243785-8082-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 05, 2011 at 05:09:45PM +0100, Daniel Hellstrom wrote:
> From: Kristoffer Glembo <kristoffer@gaisler.com>
> 
> Added leon3_dma_ops and mmu_inval_dma_area.

Hi Kristoffer.

This patch mixes cleanup with added functionality.
I would have preferred that you divided this into
several smaller patches.

I am not familiar with the area that your patch touches - but
I have tried to give some feedback below.

	Sam

> ---
>  arch/sparc/include/asm/dma-mapping.h |   13 +---
>  arch/sparc/kernel/ioport.c           |  139 +++++++++++++++++++++++++---------
>  2 files changed, 103 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
> index 8c0e4f7..fadc653 100644
> --- a/arch/sparc/include/asm/dma-mapping.h
> +++ b/arch/sparc/include/asm/dma-mapping.h
> @@ -51,17 +51,6 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  	return (dma_addr = DMA_ERROR_CODE);
>  }
>  
> -static inline int dma_set_mask(struct device *dev, u64 mask)
> -{
> -#ifdef CONFIG_PCI
> -	if (dev->bus = &pci_bus_type) {
> -		if (!dev->dma_mask || !dma_supported(dev, mask))
> -			return -EINVAL;
> -		*dev->dma_mask = mask;
> -		return 0;
> -	}
> -#endif
> -	return -EINVAL;
> -}
> +extern int dma_set_mask(struct device *dev, u64 dma_mask);

So dma_set_mask() is moved to ioport.c
>  
> +int dma_set_mask(struct device *dev, u64 dma_mask)
> +{
> +#ifdef CONFIG_PCI
> +	if (dev->bus = &pci_bus_type)
> +		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
> +#endif
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(dma_set_mask);

And it is now an exported symbol - looks OK.
But the new implementation differs from the old implementation.

Grepping for pci_set_dma_mask() turned up this implmentation:
static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
{
        return dma_set_mask(&dev->dev, mask);
}

It looks like an infinite loop??


Note: This change alone warrant an independent patch.

>  #endif
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index 41f7e4e..7359369 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -50,10 +50,15 @@
>  #include <asm/io-unit.h>
>  #include <asm/leon.h>
>  
> -#ifdef CONFIG_SPARC_LEON
> -#define mmu_inval_dma_area(p, l) leon_flush_dcache_all()
> -#else
> +#ifndef CONFIG_SPARC_LEON
>  #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
> +#else
> +static inline void mmu_inval_dma_area(unsigned long va, unsigned long len)
> +{
> +	if (!sparc_leon3_snooping_enabled()) {
> +		leon_flush_dcache_all();
> +	}
> +}
>  #endif
This is better than before as we no longer has a double definition.
But why do we call mmu_inval_dma_area() wich is empty in SPARC32 build
from SBUS code? LEON does not support SBUS only AMBA + PCI IIRC.
Hmm - looking at Kconfig LEON supports SBUS too. Is that correct?

>  
>  static struct resource *_sparc_find_resource(struct resource *r,
> @@ -254,7 +259,7 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
>  				 dma_addr_t *dma_addrp, gfp_t gfp)
>  {
>  	struct platform_device *op = to_platform_device(dev);
> -	unsigned long len_total = (len + PAGE_SIZE-1) & PAGE_MASK;
> +	unsigned long len_total = PAGE_ALIGN(len);
PAGE_ALIGN is much better than the old version.
But again - please do such cleanup in a separate step.
If we are going to revert your functional change we do not
want to lose such cleanups.


>  	unsigned long va;
>  	struct resource *res;
>  	int order;
> @@ -287,15 +292,19 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
>  	 * XXX That's where sdev would be used. Currently we load
>  	 * all iommu tables with the same translations.
>  	 */
> -	if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
> -		goto err_noiommu;
> -
> +#ifdef CONFIG_SPARC_LEON
> +	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
> +	*dma_addrp = virt_to_phys(va);
> +#else
> +	if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0) {
> +		release_resource(res);
> +		goto err_nova;
> +	}
> +#endif


I cannot follow why you need this ugly ifdef here.
Some comments please.

>  	res->name = op->dev.of_node->name;
>  
>  	return (void *)(unsigned long)res->start;
>  
> -err_noiommu:
> -	release_resource(res);
>  err_nova:
>  	free_pages(va, order);
>  err_nomem:
> @@ -321,7 +330,7 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
>  		return;
>  	}
>  
> -	n = (n + PAGE_SIZE-1) & PAGE_MASK;
> +	n = PAGE_ALIGN(n);
Another patch..

>  	if ((res->end-res->start)+1 != n) {
>  		printk("sbus_free_consistent: region 0x%lx asked 0x%zx\n",
>  		    (long)((res->end-res->start)+1), n);
> @@ -333,7 +342,12 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
>  
>  	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
>  	pgv = virt_to_page(p);
> +
> +#ifdef CONFIG_SPARC_LEON
> +	sparc_unmapiorange((unsigned long)p, n);
> +#else
>  	mmu_unmap_dma_area(dev, ba, n);
> +#endif
Why? comemnts needed again.
Or better find another way to do this.

Looking a bit around...
Is it correct understood that BTFIXUPSET_CALL() is used
to patch in another function here for for example sun4c?
So mmu_unmap_dma_area() becomes a call to sun4c_unmap_dma_area()?


>  
>  	__free_pages(pgv, get_order(n));
>  }
> @@ -408,9 +422,6 @@ struct dma_map_ops sbus_dma_ops = {
>  	.sync_sg_for_device	= sbus_sync_sg_for_device,
>  };
>  
> -struct dma_map_ops *dma_ops = &sbus_dma_ops;
> -EXPORT_SYMBOL(dma_ops);
> -
>  static int __init sparc_register_ioport(void)
>  {
>  	register_proc_sparc_ioport();
> @@ -422,7 +433,7 @@ arch_initcall(sparc_register_ioport);
>  
>  #endif /* CONFIG_SBUS */
>  
> -#ifdef CONFIG_PCI
> +#if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)

Why do we need PCI functions when PCI is not defined?
>  
>  /* Allocate and map kernel buffer using consistent mode DMA for a device.
>   * hwdev should be valid struct pci_dev pointer for PCI devices.
> @@ -430,7 +441,7 @@ arch_initcall(sparc_register_ioport);
>  static void *pci32_alloc_coherent(struct device *dev, size_t len,
>  				  dma_addr_t *pba, gfp_t gfp)
>  {
> -	unsigned long len_total = (len + PAGE_SIZE-1) & PAGE_MASK;
> +	unsigned long len_total = PAGE_ALIGN(len);
>  	unsigned long va;
>  	struct resource *res;
>  	int order;
> @@ -463,10 +474,6 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
>  		return NULL;
>  	}
>  	mmu_inval_dma_area(va, len_total);
> -#if 0
> -/* P3 */ printk("pci_alloc_consistent: kva %lx uncva %lx phys %lx size %lx\n",
> -  (long)va, (long)res->start, (long)virt_to_phys(va), len_total);
> -#endif
unrealted cleanup...

>  	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
>  
>  	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
> @@ -498,7 +505,7 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
>  		return;
>  	}
>  
> -	n = (n + PAGE_SIZE-1) & PAGE_MASK;
> +	n = PAGE_ALIGN(n);
Another patch.

>  	if ((res->end-res->start)+1 != n) {
>  		printk("pci_free_consistent: region 0x%lx asked 0x%lx\n",
>  		    (long)((res->end-res->start)+1), (long)n);
> @@ -515,6 +522,15 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
>  	free_pages(pgp, get_order(n));
>  }
>  
> +static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
> +			     enum dma_data_direction dir,
> +			     struct dma_attrs *attrs)
> +{
> +	if (dir != PCI_DMA_TODEVICE)
> +		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
> +				   PAGE_ALIGN(size));
> +}
Looks like ordinary SPARC32 gained an unmap_page - correct?
Looks like a separate chage to me.

> +
>  /*
>   * Same as pci_map_single, but with pages.
>   */
> @@ -551,8 +567,7 @@ static int pci32_map_sg(struct device *device, struct scatterlist *sgl,
>  
>  	/* IIep is write-through, not flushing. */
>  	for_each_sg(sgl, sg, nents, n) {
> -		BUG_ON(page_address(sg_page(sg)) = NULL);
Why is this BUG_ON() removed?

> -		sg->dma_address = virt_to_phys(sg_virt(sg));
> +		sg->dma_address = sg_phys(sg);

Why - is this better or what?

>  		sg->dma_length = sg->length;
>  	}
>  	return nents;
> @@ -571,10 +586,8 @@ static void pci32_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  
>  	if (dir != PCI_DMA_TODEVICE) {
>  		for_each_sg(sgl, sg, nents, n) {
> -			BUG_ON(page_address(sg_page(sg)) = NULL);
> -			mmu_inval_dma_area(
> -			    (unsigned long) page_address(sg_page(sg)),
> -			    (sg->length + PAGE_SIZE-1) & PAGE_MASK);
> +			mmu_inval_dma_area((unsigned long)sg_virt(sg),
> +					   PAGE_ALIGN(sg->length));
>  		}

Partly same type of comments like above.


>  	}
>  }
> @@ -594,7 +607,7 @@ static void pci32_sync_single_for_cpu(struct device *dev, dma_addr_t ba,
>  {
>  	if (dir != PCI_DMA_TODEVICE) {
>  		mmu_inval_dma_area((unsigned long)phys_to_virt(ba),
> -		    (size + PAGE_SIZE-1) & PAGE_MASK);
> +				   PAGE_ALIGN(size));
Another patch...
Same goes for additional spots in this file - I did not comment these.

> +/* LEON3 unmapping functions
> + *
> + * We can only invalidate the whole cache so unmap_page and unmap_sg do the
> + * same thing
> + */
> +static void leon3_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
> +			     enum dma_data_direction dir,
> +			     struct dma_attrs *attrs)
> +{
> +	if (dir != PCI_DMA_TODEVICE)
> +		mmu_inval_dma_area(0, 0);
> +}
> +
> +static void leon3_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +			   int nents, enum dma_data_direction dir,
> +			   struct dma_attrs *attrs)
> +{
> +	if (dir != PCI_DMA_TODEVICE)
> +		mmu_inval_dma_area(0, 0);
> +}
> +
>  struct dma_map_ops pci32_dma_ops = {
>  	.alloc_coherent		= pci32_alloc_coherent,
>  	.free_coherent		= pci32_free_coherent,
>  	.map_page		= pci32_map_page,
> +	.unmap_page		= pci32_unmap_page,
>  	.map_sg			= pci32_map_sg,
>  	.unmap_sg		= pci32_unmap_sg,
>  	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
> @@ -658,7 +689,30 @@ struct dma_map_ops pci32_dma_ops = {
>  };
>  EXPORT_SYMBOL(pci32_dma_ops);
>  
> -#endif /* CONFIG_PCI */
> +struct dma_map_ops leon3_dma_ops = {
> +	.alloc_coherent		= sbus_alloc_coherent,
> +	.free_coherent		= sbus_free_coherent,
> +	.map_page		= pci32_map_page,
> +	.unmap_page		= leon3_unmap_page,
> +	.map_sg			= pci32_map_sg,
> +	.unmap_sg		= leon3_unmap_sg,
> +	.sync_single_for_cpu	= pci32_sync_single_for_cpu,
> +	.sync_single_for_device	= pci32_sync_single_for_device,
> +	.sync_sg_for_cpu	= pci32_sync_sg_for_cpu,
> +	.sync_sg_for_device	= pci32_sync_sg_for_device,
> +};
> +
> +#endif /* CONFIG_PCI || CONFIG_SPARC_LEON */
> +
> +#ifdef CONFIG_SPARC_LEON
> +struct dma_map_ops *dma_ops = &leon3_dma_ops;
> +#else
> +struct dma_map_ops *dma_ops = &sbus_dma_ops;
> +#endif
> +
> +#ifdef CONFIG_SBUS
> +EXPORT_SYMBOL(dma_ops);
> +#endif

This just looks wrong to me...
Why we need to export only is SBUS is defined - but
we define leon3_dma_ops if LEON is defined.

I think this need to be revisited - and then see if you
can hide more of the ifdef in dma-mapping.h


>  
>  /*
>   * Return whether the given PCI device DMA address mask can be
> @@ -676,6 +730,17 @@ int dma_supported(struct device *dev, u64 mask)
>  }
>  EXPORT_SYMBOL(dma_supported);
>  
> +int dma_set_mask(struct device *dev, u64 dma_mask)
> +{
> +#ifdef CONFIG_PCI
> +	if (dev->bus = &pci_bus_type)
> +		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
> +#endif
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(dma_set_mask);
> +
> +
>  #ifdef CONFIG_PROC_FS
>  
>  static int sparc_io_proc_show(struct seq_file *m, void *v)
> @@ -717,7 +782,7 @@ static const struct file_operations sparc_io_proc_fops = {
>  static struct resource *_sparc_find_resource(struct resource *root,
>  					     unsigned long hit)
>  {
> -        struct resource *tmp;
> +	struct resource *tmp;

Minor nit but unrelated change.

	Sam
