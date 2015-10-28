From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 28 Oct 2015 01:00:20 +0000
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-Id: <56301E24.1060304@ozlabs.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com> <562F1368.1030204@ozlabs.ru>
 <20151027222706.GF7716@linux.vnet.ibm.com>
In-Reply-To: <20151027222706.GF7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10/28/2015 09:27 AM, Nishanth Aravamudan wrote:
> On 27.10.2015 [17:02:16 +1100], Alexey Kardashevskiy wrote:
>> On 10/24/2015 07:57 AM, Nishanth Aravamudan wrote:
>>> On Power, the kernel's page size can differ from the IOMMU's page size,
>>> so we need to override the generic implementation, which always returns
>>> the kernel's page size. Lookup the IOMMU's page size from struct
>>> iommu_table, if available. Fallback to the kernel's page size,
>>> otherwise.
>>>
>>> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/dma-mapping.h | 3 +++
>>>   arch/powerpc/kernel/dma.c              | 9 +++++++++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
>>> index 7f522c0..c5638f4 100644
>>> --- a/arch/powerpc/include/asm/dma-mapping.h
>>> +++ b/arch/powerpc/include/asm/dma-mapping.h
>>> @@ -125,6 +125,9 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
>>>   #define HAVE_ARCH_DMA_SET_MASK 1
>>>   extern int dma_set_mask(struct device *dev, u64 dma_mask);
>>>
>>> +#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
>>> +extern unsigned long dma_get_page_shift(struct device *dev);
>>> +
>>>   #include <asm-generic/dma-mapping-common.h>
>>>
>>>   extern int __dma_set_mask(struct device *dev, u64 dma_mask);
>>> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
>>> index 59503ed..e805af2 100644
>>> --- a/arch/powerpc/kernel/dma.c
>>> +++ b/arch/powerpc/kernel/dma.c
>>> @@ -335,6 +335,15 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
>>>   }
>>>   EXPORT_SYMBOL(dma_set_mask);
>>>
>>> +unsigned long dma_get_page_shift(struct device *dev)
>>> +{
>>> +	struct iommu_table *tbl = get_iommu_table_base(dev);
>>> +	if (tbl)
>>> +		return tbl->it_page_shift;
>>
>>
>> All PCI devices have this initialized on POWER (at least, our, IBM's
>> POWER) so 4K will always be returned here while in the case of
>> (get_dma_ops(dev)=&dma_direct_ops) it could actually return
>> PAGE_SHIFT. Is 4K still preferred value to return here?
>
> Right, so the logic of my series, goes like this:
>
> a) We currently are assuming DMA_PAGE_SHIFT (conceptual constant) is
> PAGE_SHIFT everywhere, including Power.
>
> b) After 2/7, the Power code will return either the IOMMU table's shift
> value, if set, or PAGE_SHIFT (I guess this would be the case if
> get_dma_ops(dev) = &dma_direct_ops, as you said). That is no different
> than we have now, except we can return the accurate IOMMU value if
> available.

If it is not available, then something went wrong and BUG_ON(!tbl || 
!tbl->it_page_shift) make more sense here than pretending that this 
function can ever return PAGE_SHIFT. imho.


>
> 3) After 3/7, the platform can override the generic Power
> get_dma_page_shift().
>
> 4) After 4/7, pseries will return the DDW value, if available, then
> fallback to the IOMMU table's value. I think in the case of
> get_dma_ops(dev)=&dma_direct_ops, the only way that can happen is if we
> are using DDW, right?

This is for pseries guests; for the powernv host it is a "bypass" mode 
which does 64bit direct DMA mapping and there is no additional window for 
that (i.e. DIRECT64_PROPNAME, etc).



-- 
Alexey
