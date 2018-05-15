From: Mark Salter <msalter@redhat.com>
Date: Tue, 15 May 2018 00:25:52 +0000
Subject: Re: [Linux-c6x-dev] [PATCH 05/20] c6x: use generic dma_noncoherent_ops
Message-Id: <f3a126c511ca75869e3f21dc60364e6a89cda90b.camel@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-6-hch@lst.de>
In-Reply-To: <20180511075945.16548-6-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Fri, 2018-05-11 at 09:59 +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/c6x/Kconfig                   |   3 +
>  arch/c6x/include/asm/Kbuild        |   1 +
>  arch/c6x/include/asm/dma-mapping.h |  28 ------
>  arch/c6x/include/asm/setup.h       |   2 +
>  arch/c6x/kernel/Makefile           |   2 +-
>  arch/c6x/kernel/dma.c              | 138 -----------------------------
>  arch/c6x/mm/dma-coherent.c         |  40 ++++++++-
>  7 files changed, 44 insertions(+), 170 deletions(-)
>  delete mode 100644 arch/c6x/include/asm/dma-mapping.h
>  delete mode 100644 arch/c6x/kernel/dma.c
> 
> diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> index 8c088b96e372..bf59855628ac 100644
> --- a/arch/c6x/Kconfig
> +++ b/arch/c6x/Kconfig
> @@ -6,7 +6,10 @@
>  
>  config C6X
>  	def_bool y
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select CLKDEV_LOOKUP
> +	select DMA_NONCOHERENT_OPS
>  	select GENERIC_ATOMIC64
>  	select GENERIC_IRQ_SHOW
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
> index fd4c840de837..434600e47662 100644
> --- a/arch/c6x/include/asm/Kbuild
> +++ b/arch/c6x/include/asm/Kbuild
> @@ -5,6 +5,7 @@ generic-y += current.h
>  generic-y += device.h
>  generic-y += div64.h
>  generic-y += dma.h
> +generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
>  generic-y += extable.h
> diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/dma-mapping.h
> deleted file mode 100644
> index 05daf1038111..000000000000
> --- a/arch/c6x/include/asm/dma-mapping.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - *  Port on Texas Instruments TMS320C6x architecture
> - *
> - *  Copyright (C) 2004, 2009, 2010, 2011 Texas Instruments Incorporated
> - *  Author: Aurelien Jacquiot <aurelien.jacquiot@ti.com>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 as
> - *  published by the Free Software Foundation.
> - *
> - */
> -#ifndef _ASM_C6X_DMA_MAPPING_H
> -#define _ASM_C6X_DMA_MAPPING_H
> -
> -extern const struct dma_map_ops c6x_dma_ops;
> -
> -static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> -{
> -	return &c6x_dma_ops;
> -}
> -
> -extern void coherent_mem_init(u32 start, u32 size);
> -void *c6x_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> -		gfp_t gfp, unsigned long attrs);
> -void c6x_dma_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_handle, unsigned long attrs);
> -
> -#endif	/* _ASM_C6X_DMA_MAPPING_H */
> diff --git a/arch/c6x/include/asm/setup.h b/arch/c6x/include/asm/setup.h
> index 852afb209afb..350f34debb19 100644
> --- a/arch/c6x/include/asm/setup.h
> +++ b/arch/c6x/include/asm/setup.h
> @@ -28,5 +28,7 @@ extern unsigned char c6x_fuse_mac[6];
>  extern void machine_init(unsigned long dt_ptr);
>  extern void time_init(void);
>  
> +extern void coherent_mem_init(u32 start, u32 size);
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASM_C6X_SETUP_H */
> diff --git a/arch/c6x/kernel/Makefile b/arch/c6x/kernel/Makefile
> index 02f340d7b8fe..fbe74174de87 100644
> --- a/arch/c6x/kernel/Makefile
> +++ b/arch/c6x/kernel/Makefile
> @@ -8,6 +8,6 @@ extra-y := head.o vmlinux.lds
>  obj-y := process.o traps.o irq.o signal.o ptrace.o
>  obj-y += setup.o sys_c6x.o time.o devicetree.o
>  obj-y += switch_to.o entry.o vectors.o c6x_ksyms.o
> -obj-y += soc.o dma.o
> +obj-y += soc.o
>  
>  obj-$(CONFIG_MODULES)           += module.o
> diff --git a/arch/c6x/kernel/dma.c b/arch/c6x/kernel/dma.c
> deleted file mode 100644
> index 31e1a9ec3a9c..000000000000
> --- a/arch/c6x/kernel/dma.c
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -/*
> - *  Copyright (C) 2011 Texas Instruments Incorporated
> - *  Author: Mark Salter <msalter@redhat.com>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2 as
> - *  published by the Free Software Foundation.
> - */
> -#include <linux/module.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/mm.h>
> -#include <linux/mm_types.h>
> -#include <linux/scatterlist.h>
> -
> -#include <asm/cacheflush.h>
> -
> -static void c6x_dma_sync(dma_addr_t handle, size_t size,
> -			 enum dma_data_direction dir)
> -{
> -	unsigned long paddr = handle;
> -
> -	BUG_ON(!valid_dma_direction(dir));
> -
> -	switch (dir) {
> -	case DMA_FROM_DEVICE:
> -		L2_cache_block_invalidate(paddr, paddr + size);
> -		break;
> -	case DMA_TO_DEVICE:
> -		L2_cache_block_writeback(paddr, paddr + size);
> -		break;
> -	case DMA_BIDIRECTIONAL:
> -		L2_cache_block_writeback_invalidate(paddr, paddr + size);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
> -static dma_addr_t c6x_dma_map_page(struct device *dev, struct page *page,
> -		unsigned long offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	dma_addr_t handle = virt_to_phys(page_address(page) + offset);
> -
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		c6x_dma_sync(handle, size, dir);
> -
> -	return handle;
> -}
> -
> -static void c6x_dma_unmap_page(struct device *dev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		c6x_dma_sync(handle, size, dir);
> -}
> -
> -static int c6x_dma_map_sg(struct device *dev, struct scatterlist *sglist,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	struct scatterlist *sg;
> -	int i;
> -
> -	for_each_sg(sglist, sg, nents, i) {
> -		sg->dma_address = sg_phys(sg);
> -		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -			c6x_dma_sync(sg->dma_address, sg->length, dir);
> -	}
> -
> -	return nents;
> -}
> -
> -static void c6x_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
> -		  int nents, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	struct scatterlist *sg;
> -	int i;
> -
> -	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
> -		return;
> -
> -	for_each_sg(sglist, sg, nents, i)
> -		c6x_dma_sync(sg_dma_address(sg), sg->length, dir);
> -}
> -
> -static void c6x_dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle,
> -		size_t size, enum dma_data_direction dir)
> -{
> -	c6x_dma_sync(handle, size, dir);
> -
> -}
> -
> -static void c6x_dma_sync_single_for_device(struct device *dev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	c6x_dma_sync(handle, size, dir);
> -
> -}
> -
> -static void c6x_dma_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sglist, int nents,
> -		enum dma_data_direction dir)
> -{
> -	struct scatterlist *sg;
> -	int i;
> -
> -	for_each_sg(sglist, sg, nents, i)
> -		c6x_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> -					sg->length, dir);
> -
> -}
> -
> -static void c6x_dma_sync_sg_for_device(struct device *dev,
> -		struct scatterlist *sglist, int nents,
> -		enum dma_data_direction dir)
> -{
> -	struct scatterlist *sg;
> -	int i;
> -
> -	for_each_sg(sglist, sg, nents, i)
> -		c6x_dma_sync_single_for_device(dev, sg_dma_address(sg),
> -					   sg->length, dir);
> -
> -}
> -
> -const struct dma_map_ops c6x_dma_ops = {
> -	.alloc			= c6x_dma_alloc,
> -	.free			= c6x_dma_free,
> -	.map_page		= c6x_dma_map_page,
> -	.unmap_page		= c6x_dma_unmap_page,
> -	.map_sg			= c6x_dma_map_sg,
> -	.unmap_sg		= c6x_dma_unmap_sg,
> -	.sync_single_for_device	= c6x_dma_sync_single_for_device,
> -	.sync_single_for_cpu	= c6x_dma_sync_single_for_cpu,
> -	.sync_sg_for_device	= c6x_dma_sync_sg_for_device,
> -	.sync_sg_for_cpu	= c6x_dma_sync_sg_for_cpu,
> -};
> -EXPORT_SYMBOL(c6x_dma_ops);
> diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
> index 95e38ad27c69..d0a8e0c4b27e 100644
> --- a/arch/c6x/mm/dma-coherent.c
> +++ b/arch/c6x/mm/dma-coherent.c
> @@ -19,10 +19,12 @@
>  #include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/memblock.h>
>  
> +#include <asm/cacheflush.h>
>  #include <asm/page.h>
> +#include <asm/setup.h>
>  
>  /*
>   * DMA coherent memory management, can be redefined using the memdma> @@ -73,7 +75,7 @@ static void __free_dma_pages(u32 addr, int order)
>   * Allocate DMA coherent memory space and return both the kernel
>   * virtual and DMA address for that space.
>   */
> -void *c6x_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  		gfp_t gfp, unsigned long attrs)
>  {
>  	u32 paddr;
> @@ -98,7 +100,7 @@ void *c6x_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  /*
>   * Free DMA coherent memory as defined by the above mapping.
>   */
> -void c6x_dma_free(struct device *dev, size_t size, void *vaddr,
> +void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  		dma_addr_t dma_handle, unsigned long attrs)
>  {
>  	int order;
> @@ -139,3 +141,35 @@ void __init coherent_mem_init(phys_addr_t start, u32 size)
>  	dma_bitmap = phys_to_virt(bitmap_phys);
>  	memset(dma_bitmap, 0, dma_pages * PAGE_SIZE);
>  }
> +
> +static void c6x_dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
> +		enum dma_data_direction dir)
> +{
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		L2_cache_block_invalidate(paddr, paddr + size);
> +		break;
> +	case DMA_TO_DEVICE:
> +		L2_cache_block_writeback(paddr, paddr + size);
> +		break;
> +	case DMA_BIDIRECTIONAL:
> +		L2_cache_block_writeback_invalidate(paddr, paddr + size);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	return c6x_dma_sync(dev, paddr, size, dir);
> +}
> +
> +void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	return c6x_dma_sync(dev, paddr, size, dir);
> +}
Acked-by: Mark Salter <msalter@redhat.com>

