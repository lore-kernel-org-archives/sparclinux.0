From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 13 Jan 2011 18:43:34 +0000
Subject: Re: [PATCH 4/4 V2] sparc/leon: Add LEON dma_ops.
Message-Id: <20110113184334.GA4061@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294909535-6290-5-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1294909535-6290-5-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kristoffer.

On Thu, Jan 13, 2011 at 10:05:35AM +0100, Kristoffer Glembo wrote:
> This patch introduces a dma_ops structure for LEON. It reuses parts of the SBUS and PCI API to avoid code duplication.
> 
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> ---
>  arch/sparc/kernel/ioport.c |   69 +++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index 699120a..466f1dc 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -291,16 +291,22 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
>  	/*
>  	 * XXX That's where sdev would be used. Currently we load
>  	 * all iommu tables with the same translations.
> +	 *
> +	 * For LEON we only set up the SRMMU, no IOMMU.
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
>  	res->name = op->dev.of_node->name;
>  
>  	return (void *)(unsigned long)res->start;
>  
> -err_noiommu:
> -	release_resource(res);
>  err_nova:
>  	free_pages(va, order);
>  err_nomem:


I have failed to see what is the difference between pci32_alloc_coherent()
and the LEON variant of sbus_alloc_coherent().

> @@ -336,9 +342,15 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
>  	release_resource(res);
>  	kfree(res);
>  
> -	/* mmu_inval_dma_area(va, n); */ /* it's consistent, isn't it */
>  	pgv = virt_to_page(p);
> +
> +	/* No IOMMU support for LEON */
> +#ifdef CONFIG_SPARC_LEON
> +	mmu_inval_dma_area((unsigned long)p, n);
> +	sparc_unmapiorange((unsigned long)p, n);
> +#else
>  	mmu_unmap_dma_area(dev, ba, n);
> +#endif
>  
>  	__free_pages(pgv, get_order(n));
>  }

Likewise for this. It looks equal to pci32_free_coherent().

If they are equal then this patch can be simplified a lot.
Please investigate.

> @@ -413,9 +425,6 @@ struct dma_map_ops sbus_dma_ops = {
>  	.sync_sg_for_device	= sbus_sync_sg_for_device,
>  };
>  
> -struct dma_map_ops *dma_ops = &sbus_dma_ops;
> -EXPORT_SYMBOL(dma_ops);
> -
>  static int __init sparc_register_ioport(void)
>  {
>  	register_proc_sparc_ioport();
> @@ -427,7 +436,9 @@ arch_initcall(sparc_register_ioport);
>  
>  #endif /* CONFIG_SBUS */
>  
> -#ifdef CONFIG_PCI
> +
> +/* LEON reuses PCI DMA ops */
> +#if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)
>  
>  /* Allocate and map kernel buffer using consistent mode DMA for a device.
>   * hwdev should be valid struct pci_dev pointer for PCI devices.
> @@ -667,7 +678,43 @@ struct dma_map_ops pci32_dma_ops = {
>  };
>  EXPORT_SYMBOL(pci32_dma_ops);
>  
> -#endif /* CONFIG_PCI */
> +/*
> + * We can only invalidate the whole cache
> + */
> +static void leon_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +			   int nents, enum dma_data_direction dir,
> +			   struct dma_attrs *attrs)
> +{
> +	if (dir != PCI_DMA_TODEVICE)
> +		mmu_inval_dma_area(0, 0);
> +}
Please investigate if you can use pci32_unmap_sg.
If this is the case you can reuse pci32_dma_ops direct.
As you can use pci32_map_sg() I would assume you can also
use the counterpart for unmap..

	Sam
