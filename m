From: Ezequiel Garcia <ezequiel@collabora.com>
Date: Sat, 08 Dec 2018 22:52:04 +0000
Subject: Re: [PATCH 04/10] arm: implement DMA_ATTR_NON_CONSISTENT
Message-Id: <3aeb99c505fd1c33199fcc26fe5e0bf239dee57e.camel@collabora.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
	<20181208173702.15158-5-hch@lst.de>
In-Reply-To: <20181208173702.15158-5-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Sat, 2018-12-08 at 09:36 -0800, Christoph Hellwig wrote:
> For the iommu ops we can just use the implementaton for DMA coherent
> devices.  For the regular ops we need mix and match a bit so that
> we either use the CMA allocator without remapping, but with a special
> error handling case for highmem pages, or the simple allocator.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/mm/dma-mapping.c | 49 ++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 2cfb17bad1e6..b3b66b41c450 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -49,6 +49,7 @@ struct arm_dma_alloc_args {
>  	const void *caller;
>  	bool want_vaddr;
>  	int coherent_flag;
> +	bool nonconsistent_flag;
>  };
>  
>  struct arm_dma_free_args {
> @@ -57,6 +58,7 @@ struct arm_dma_free_args {
>  	void *cpu_addr;
>  	struct page *page;
>  	bool want_vaddr;
> +	bool nonconsistent_flag;
>  };
>  
>  #define NORMAL	    0
> @@ -348,7 +350,8 @@ static void __dma_free_buffer(struct page *page, size_t size)
>  static void *__alloc_from_contiguous(struct device *dev, size_t size,
>  				     pgprot_t prot, struct page **ret_page,
>  				     const void *caller, bool want_vaddr,
> -				     int coherent_flag, gfp_t gfp);
> +				     int coherent_flag, bool nonconsistent_flag,
> +				     gfp_t gfp);
>  
>  static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
>  				 pgprot_t prot, struct page **ret_page,
> @@ -405,7 +408,7 @@ static int __init atomic_pool_init(void)
>  	if (dev_get_cma_area(NULL))
>  		ptr = __alloc_from_contiguous(NULL, atomic_pool_size, prot,
>  				      &page, atomic_pool_init, true, NORMAL,
> -				      GFP_KERNEL);
> +				      false, GFP_KERNEL);
>  	else
>  		ptr = __alloc_remap_buffer(NULL, atomic_pool_size, gfp, prot,
>  					   &page, atomic_pool_init, true);
> @@ -579,7 +582,8 @@ static int __free_from_pool(void *start, size_t size)
>  static void *__alloc_from_contiguous(struct device *dev, size_t size,
>  				     pgprot_t prot, struct page **ret_page,
>  				     const void *caller, bool want_vaddr,
> -				     int coherent_flag, gfp_t gfp)
> +				     int coherent_flag, bool nonconsistent_flag,
> +				     gfp_t gfp)
>  {
>  	unsigned long order = get_order(size);
>  	size_t count = size >> PAGE_SHIFT;
> @@ -595,12 +599,16 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
>  	if (!want_vaddr)
>  		goto out;
>  
> +	if (nonconsistent_flag) {
> +		if (PageHighMem(page))
> +			goto fail;
> +		goto out;
> +	}
> +
>  	if (PageHighMem(page)) {
>  		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
> -		if (!ptr) {
> -			dma_release_from_contiguous(dev, page, count);
> -			return NULL;
> -		}
> +		if (!ptr)
> +			goto fail;
>  	} else {
>  		__dma_remap(page, size, prot);
>  		ptr = page_address(page);
> @@ -609,12 +617,15 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
>   out:
>  	*ret_page = page;
>  	return ptr;
> + fail:
> +	dma_release_from_contiguous(dev, page, count);
> +	return NULL;
>  }
>  
>  static void __free_from_contiguous(struct device *dev, struct page *page,
> -				   void *cpu_addr, size_t size, bool want_vaddr)
> +				   void *cpu_addr, size_t size, bool remapped)
>  {
> -	if (want_vaddr) {
> +	if (remapped) {
>  		if (PageHighMem(page))
>  			__dma_free_remap(cpu_addr, size);
>  		else
> @@ -635,7 +646,11 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
>  				   struct page **ret_page)
>  {
>  	struct page *page;
> -	/* __alloc_simple_buffer is only called when the device is coherent */
> +	/*
> +	 * __alloc_simple_buffer is only called when the device is coherent,
> +	 * or if the caller explicitly asked for an allocation that is not
> +	 * consistent.
> +	 */
>  	page = __dma_alloc_buffer(dev, size, gfp, COHERENT);
>  	if (!page)
>  		return NULL;
> @@ -667,13 +682,15 @@ static void *cma_allocator_alloc(struct arm_dma_alloc_args *args,
>  	return __alloc_from_contiguous(args->dev, args->size, args->prot,
>  				       ret_page, args->caller,
>  				       args->want_vaddr, args->coherent_flag,
> +				       args->nonconsistent_flag,
>  				       args->gfp);
>  }
>  
>  static void cma_allocator_free(struct arm_dma_free_args *args)
>  {
>  	__free_from_contiguous(args->dev, args->page, args->cpu_addr,
> -			       args->size, args->want_vaddr);
> +			       args->size,
> +			       args->want_vaddr || args->nonconsistent_flag);
>  }
>  
>  static struct arm_dma_allocator cma_allocator = {
> @@ -735,6 +752,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  		.caller = caller,
>  		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) = 0),
>  		.coherent_flag = is_coherent ? COHERENT : NORMAL,
> +		.nonconsistent_flag = (attrs & DMA_ATTR_NON_CONSISTENT),
>  	};
>  
>  #ifdef CONFIG_DMA_API_DEBUG
> @@ -773,7 +791,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  
>  	if (cma)
>  		buf->allocator = &cma_allocator;
> -	else if (is_coherent)
> +	else if (is_coherent || (attrs & DMA_ATTR_NON_CONSISTENT))
>  		buf->allocator = &simple_allocator;

Reading through your code I can't really see where the pgprot is changed
for non-consistent requests. Namely, __get_dma_pgprot only
returns writecombine or coherent memory.

Regards,
Ezequiel
