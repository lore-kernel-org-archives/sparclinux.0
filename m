From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 27 Oct 2015 06:02:16 +0000
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-Id: <562F1368.1030204@ozlabs.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
In-Reply-To: <20151023205718.GC10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10/24/2015 07:57 AM, Nishanth Aravamudan wrote:
> On Power, the kernel's page size can differ from the IOMMU's page size,
> so we need to override the generic implementation, which always returns
> the kernel's page size. Lookup the IOMMU's page size from struct
> iommu_table, if available. Fallback to the kernel's page size,
> otherwise.
>
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/dma-mapping.h | 3 +++
>   arch/powerpc/kernel/dma.c              | 9 +++++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 7f522c0..c5638f4 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -125,6 +125,9 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
>   #define HAVE_ARCH_DMA_SET_MASK 1
>   extern int dma_set_mask(struct device *dev, u64 dma_mask);
>
> +#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
> +extern unsigned long dma_get_page_shift(struct device *dev);
> +
>   #include <asm-generic/dma-mapping-common.h>
>
>   extern int __dma_set_mask(struct device *dev, u64 dma_mask);
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 59503ed..e805af2 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -335,6 +335,15 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
>   }
>   EXPORT_SYMBOL(dma_set_mask);
>
> +unsigned long dma_get_page_shift(struct device *dev)
> +{
> +	struct iommu_table *tbl = get_iommu_table_base(dev);
> +	if (tbl)
> +		return tbl->it_page_shift;


All PCI devices have this initialized on POWER (at least, our, IBM's POWER) 
so 4K will always be returned here while in the case of 
(get_dma_ops(dev)=&dma_direct_ops) it could actually return PAGE_SHIFT. Is 
4K still preferred value to return here?



> +	return PAGE_SHIFT;
> +}
> +EXPORT_SYMBOL(dma_get_page_shift);
> +
>   u64 __dma_get_required_mask(struct device *dev)
>   {
>   	struct dma_map_ops *dma_ops = get_dma_ops(dev);
>


-- 
Alexey
