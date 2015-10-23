From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 21:02:45 +0000
Subject: Re: [PATCH 5/7] [RFC PATCH 5/7] sparc: rename kernel/iommu_common.h -> include/asm/iommu_common.h
Message-Id: <20151023210245.GJ10197@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023210008.GG10197@linux.vnet.ibm.com>
In-Reply-To: <20151023210008.GG10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[Apologies for the subject line, should just have the [RFC PATCH 5/7]]

On 23.10.2015 [14:00:08 -0700], Nishanth Aravamudan wrote:
> In order to cleanly expose the desired IOMMU page shift via the new
> dma_get_page_shift API, we need to have the sparc constants available in
> a more typical location. There should be no functional impact to this
> move, but it is untested.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>  arch/sparc/include/asm/iommu_common.h | 51 +++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/iommu.c             |  2 +-
>  arch/sparc/kernel/iommu_common.h      | 51 -----------------------------------
>  arch/sparc/kernel/pci_psycho.c        |  2 +-
>  arch/sparc/kernel/pci_sabre.c         |  2 +-
>  arch/sparc/kernel/pci_schizo.c        |  2 +-
>  arch/sparc/kernel/pci_sun4v.c         |  2 +-
>  arch/sparc/kernel/psycho_common.c     |  2 +-
>  arch/sparc/kernel/sbus.c              |  3 +--
>  9 files changed, 58 insertions(+), 59 deletions(-)
>  create mode 100644 arch/sparc/include/asm/iommu_common.h
>  delete mode 100644 arch/sparc/kernel/iommu_common.h
> 
> diff --git a/arch/sparc/include/asm/iommu_common.h b/arch/sparc/include/asm/iommu_common.h
> new file mode 100644
> index 0000000..b40cec2
> --- /dev/null
> +++ b/arch/sparc/include/asm/iommu_common.h
> @@ -0,0 +1,51 @@
> +/* iommu_common.h: UltraSparc SBUS/PCI common iommu declarations.
> + *
> + * Copyright (C) 1999, 2008 David S. Miller (davem@davemloft.net)
> + */
> +
> +#ifndef _IOMMU_COMMON_H
> +#define _IOMMU_COMMON_H
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/scatterlist.h>
> +#include <linux/device.h>
> +#include <linux/iommu-helper.h>
> +#include <linux/scatterlist.h>
> +
> +#include <asm/iommu.h>
> +
> +/*
> + * These give mapping size of each iommu pte/tlb.
> + */
> +#define IO_PAGE_SHIFT			13
> +#define IO_PAGE_SIZE			(1UL << IO_PAGE_SHIFT)
> +#define IO_PAGE_MASK			(~(IO_PAGE_SIZE-1))
> +#define IO_PAGE_ALIGN(addr)		ALIGN(addr, IO_PAGE_SIZE)
> +
> +#define IO_TSB_ENTRIES			(128*1024)
> +#define IO_TSB_SIZE			(IO_TSB_ENTRIES * 8)
> +
> +/*
> + * This is the hardwired shift in the iotlb tag/data parts.
> + */
> +#define IOMMU_PAGE_SHIFT		13
> +
> +#define SG_ENT_PHYS_ADDRESS(SG)	(__pa(sg_virt((SG))))
> +
> +static inline int is_span_boundary(unsigned long entry,
> +				   unsigned long shift,
> +				   unsigned long boundary_size,
> +				   struct scatterlist *outs,
> +				   struct scatterlist *sg)
> +{
> +	unsigned long paddr = SG_ENT_PHYS_ADDRESS(outs);
> +	int nr = iommu_num_pages(paddr, outs->dma_length + sg->length,
> +				 IO_PAGE_SIZE);
> +
> +	return iommu_is_span_boundary(entry, nr, shift, boundary_size);
> +}
> +
> +#endif /* _IOMMU_COMMON_H */
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 5320689..f9b6077 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -20,8 +20,8 @@
>  #endif
>  
>  #include <asm/iommu.h>
> +#include <asm/iommu_common.h>
>  
> -#include "iommu_common.h"
>  #include "kernel.h"
>  
>  #define STC_CTXMATCH_ADDR(STC, CTX)	\
> diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
> deleted file mode 100644
> index b40cec2..0000000
> --- a/arch/sparc/kernel/iommu_common.h
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -/* iommu_common.h: UltraSparc SBUS/PCI common iommu declarations.
> - *
> - * Copyright (C) 1999, 2008 David S. Miller (davem@davemloft.net)
> - */
> -
> -#ifndef _IOMMU_COMMON_H
> -#define _IOMMU_COMMON_H
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> -#include <linux/mm.h>
> -#include <linux/scatterlist.h>
> -#include <linux/device.h>
> -#include <linux/iommu-helper.h>
> -#include <linux/scatterlist.h>
> -
> -#include <asm/iommu.h>
> -
> -/*
> - * These give mapping size of each iommu pte/tlb.
> - */
> -#define IO_PAGE_SHIFT			13
> -#define IO_PAGE_SIZE			(1UL << IO_PAGE_SHIFT)
> -#define IO_PAGE_MASK			(~(IO_PAGE_SIZE-1))
> -#define IO_PAGE_ALIGN(addr)		ALIGN(addr, IO_PAGE_SIZE)
> -
> -#define IO_TSB_ENTRIES			(128*1024)
> -#define IO_TSB_SIZE			(IO_TSB_ENTRIES * 8)
> -
> -/*
> - * This is the hardwired shift in the iotlb tag/data parts.
> - */
> -#define IOMMU_PAGE_SHIFT		13
> -
> -#define SG_ENT_PHYS_ADDRESS(SG)	(__pa(sg_virt((SG))))
> -
> -static inline int is_span_boundary(unsigned long entry,
> -				   unsigned long shift,
> -				   unsigned long boundary_size,
> -				   struct scatterlist *outs,
> -				   struct scatterlist *sg)
> -{
> -	unsigned long paddr = SG_ENT_PHYS_ADDRESS(outs);
> -	int nr = iommu_num_pages(paddr, outs->dma_length + sg->length,
> -				 IO_PAGE_SIZE);
> -
> -	return iommu_is_span_boundary(entry, nr, shift, boundary_size);
> -}
> -
> -#endif /* _IOMMU_COMMON_H */
> diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
> index 7dce27b..332fd6f 100644
> --- a/arch/sparc/kernel/pci_psycho.c
> +++ b/arch/sparc/kernel/pci_psycho.c
> @@ -15,13 +15,13 @@
>  #include <linux/of_device.h>
>  
>  #include <asm/iommu.h>
> +#include <asm/iommu_common.h>
>  #include <asm/irq.h>
>  #include <asm/starfire.h>
>  #include <asm/prom.h>
>  #include <asm/upa.h>
>  
>  #include "pci_impl.h"
> -#include "iommu_common.h"
>  #include "psycho_common.h"
>  
>  #define DRIVER_NAME	"psycho"
> diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
> index 00a616f..6c2c616 100644
> --- a/arch/sparc/kernel/pci_sabre.c
> +++ b/arch/sparc/kernel/pci_sabre.c
> @@ -16,12 +16,12 @@
>  
>  #include <asm/apb.h>
>  #include <asm/iommu.h>
> +#include <asm/iommu_common.h>
>  #include <asm/irq.h>
>  #include <asm/prom.h>
>  #include <asm/upa.h>
>  
>  #include "pci_impl.h"
> -#include "iommu_common.h"
>  #include "psycho_common.h"
>  
>  #define DRIVER_NAME	"sabre"
> diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
> index c664d3e..ef23ab2 100644
> --- a/arch/sparc/kernel/pci_schizo.c
> +++ b/arch/sparc/kernel/pci_schizo.c
> @@ -13,13 +13,13 @@
>  #include <linux/of_device.h>
>  
>  #include <asm/iommu.h>
> +#include <asm/iommu_common.h>
>  #include <asm/irq.h>
>  #include <asm/pstate.h>
>  #include <asm/prom.h>
>  #include <asm/upa.h>
>  
>  #include "pci_impl.h"
> -#include "iommu_common.h"
>  
>  #define DRIVER_NAME	"schizo"
>  #define PFX		DRIVER_NAME ": "
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index d2fe57d..1d72295 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -18,12 +18,12 @@
>  #include <linux/iommu-common.h>
>  
>  #include <asm/iommu.h>
> +#include <asm/iommu_common.h>
>  #include <asm/irq.h>
>  #include <asm/hypervisor.h>
>  #include <asm/prom.h>
>  
>  #include "pci_impl.h"
> -#include "iommu_common.h"
>  
>  #include "pci_sun4v.h"
>  
> diff --git a/arch/sparc/kernel/psycho_common.c b/arch/sparc/kernel/psycho_common.c
> index 8db48e8..8eec09d 100644
> --- a/arch/sparc/kernel/psycho_common.c
> +++ b/arch/sparc/kernel/psycho_common.c
> @@ -5,10 +5,10 @@
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  
> +#include <asm/iommu_common.h>
>  #include <asm/upa.h>
>  
>  #include "pci_impl.h"
> -#include "iommu_common.h"
>  #include "psycho_common.h"
>  
>  #define  PSYCHO_STRBUF_CTRL_DENAB	0x0000000000000002ULL
> diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
> index be5bdf9..a92cdf6 100644
> --- a/arch/sparc/kernel/sbus.c
> +++ b/arch/sparc/kernel/sbus.c
> @@ -24,8 +24,7 @@
>  #include <asm/prom.h>
>  #include <asm/oplib.h>
>  #include <asm/starfire.h>
> -
> -#include "iommu_common.h"
> +#include <asm/iommu_common.h>
>  
>  #define MAP_BASE	((u32)0xc0000000)
>  
> -- 
> 1.9.1
> 

