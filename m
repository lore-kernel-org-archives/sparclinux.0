From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 03 Apr 2015 20:52:01 +0000
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
Message-Id: <20150403205201.GF10892@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org>
 <20150403193234.GD10892@google.com>
In-Reply-To: <20150403193234.GD10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[+cc Sam (commented on previous versions), Russell, linux-arm-kernel, Ralf,
linux-mips, Ben, linuxppc-dev, x86]

On Fri, Apr 03, 2015 at 02:32:34PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
> > David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
> > to fit in upstream windows") broke booting on sparc/T5-8.
> > 
> > In the boot log, there is
> >   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
> >   0x110204000)
> > but that only could happen when dma_addr_t is 32-bit.
> > 
> > According to David Miller, all DMA occurs behind an IOMMU and these
> > IOMMUs only support 32-bit addressing, therefore dma_addr_t is
> > 32-bit on sparc64.
> > 
> > Let's introduce pci_bus_addr_t instead of using dma_addr_t,
> > and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
> > 
> > Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
> > Fixes: commit 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
> > Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
> > Reported-by: David Ahern <david.ahern@oracle.com>
> > Tested-by: David Ahern <david.ahern@oracle.com>
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Cc: <stable@vger.kernel.org> #3.19
> > ---
> >  drivers/pci/Kconfig |  4 ++++
> >  drivers/pci/bus.c   | 10 +++++-----
> >  drivers/pci/probe.c | 12 ++++++------
> >  include/linux/pci.h | 12 +++++++++---
> >  4 files changed, 24 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 7a8f1c5..6a5a269 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -1,6 +1,10 @@
> >  #
> >  # PCI configuration
> >  #
> > +config PCI_BUS_ADDR_T_64BIT
> > +	def_bool y if (64BIT || X86_PAE)
> > +	depends on PCI
> 
> We're going to use pci_bus_addr_t in some places where we previously used
> dma_addr_t, which means pci_bus_addr_t should be at least as large as
> dma_addr_t.  Can you enforce that directly, e.g., with something like this?
> 
>     def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT || X86_PAE)
> 
> Unless we do something like that, I think this may break these arches by
> changing the addresses in struct pci_bus_region from 64 bits to 32:
> 
>     arch/arm/Kconfig:
> 	XEN selects ARCH_DMA_ADDR_T_64BIT but not 64BIT, so it would not
> 	set PCI_BUS_ADDR_T_64BIT
> 
>     arch/arm/mach-axxia/Kconfig:
> 	ARCH_AXXIA selects ARCH_DMA_ADDR_T_64BIT but not 64BIT, so it
> 	would not set PCI_BUS_ADDR_T_64BIT
> 
>     arch/arm/mach-exynos/Kconfig:
> 	SOC_EXYNOS5440 selects ARCH_DMA_ADDR_T_64BIT if ARM_LPAE, but not
> 	64BIT, so it would not set PCI_BUS_ADDR_T_64BIT
> 
>     arch/arm/mach-highbank/Kconfig:
> 	ARCH_HIGHBANK selects ARCH_DMA_ADDR_T_64BIT if ARM_LPAE, but not
> 	64BIT, so it would not set PCI_BUS_ADDR_T_64BIT
> 
>     arch/arm/mach-shmobile/Kconfig:
> 	ARCH_SHMOBILE_MULTI selects ARCH_DMA_ADDR_T_64BIT if ARM_LPAE, but
> 	not 64BIT, so it would not set PCI_BUS_ADDR_T_64BIT
> 
>     arch/mips/Kconfig:
> 	sets ARCH_DMA_ADDR_T_64BIT if (HIGHMEM && ARCH_PHYS_ADDR_T_64BIT)
> 	|| 64BIT, so if we have (HIGHMEM && ARCH_PHYS_ADDR_T_64BIT) but not
> 	64BIT, it would not set PCI_BUS_ADDR_T_64BIT
> 	
>     arch/powerpc/Kconfig:
> 	sets ARCH_DMA_ADDR_T_64BIT if ARCH_PHYS_ADDR_T_64BIT, which isn't
> 	trivially identical to (64BIT || X86_PAE), so we may not set
> 	PCI_BUS_ADDR_T_64BIT in all cases where we set
> 	ARCH_DMA_ADDR_T_64BIT
> 
>     arch/x86/Kconfig:
> 	sets ARCH_DMA_ADDR_T_64BIT if X86_64 || HIGHMEM64G, which isn't
> 	trivially identical to (64BIT || X86_PAE), so we may not set
> 	PCI_BUS_ADDR_T_64BIT in all cases where we set
> 	ARCH_DMA_ADDR_T_64BIT
> 
> >  config PCI_MSI
> >  	bool "Message Signaled Interrupts (MSI and MSI-X)"
> >  	depends on PCI
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 90fa3a7..6fbd3f2 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -92,11 +92,11 @@ void pci_bus_remove_resources(struct pci_bus *bus)
> >  }
> >  
> >  static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
> > -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> >  static struct pci_bus_region pci_64_bit = {0,
> > -				(dma_addr_t) 0xffffffffffffffffULL};
> > -static struct pci_bus_region pci_high = {(dma_addr_t) 0x100000000ULL,
> > -				(dma_addr_t) 0xffffffffffffffffULL};
> > +				(pci_bus_addr_t) 0xffffffffffffffffULL};
> > +static struct pci_bus_region pci_high = {(pci_bus_addr_t) 0x100000000ULL,
> > +				(pci_bus_addr_t) 0xffffffffffffffffULL};
> >  #endif
> >  
> >  /*
> > @@ -200,7 +200,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
> >  					  resource_size_t),
> >  		void *alignf_data)
> >  {
> > -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> >  	int rc;
> >  
> >  	if (res->flags & IORESOURCE_MEM_64) {
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 8d2f400..f71cb7c 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -253,8 +253,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  	}
> >  
> >  	if (res->flags & IORESOURCE_MEM_64) {
> > -		if ((sizeof(dma_addr_t) < 8 || sizeof(resource_size_t) < 8) &&
> > -		    sz64 > 0x100000000ULL) {
> > +		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
> > +		    && sz64 > 0x100000000ULL) {
> >  			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> >  			res->start = 0;
> >  			res->end = 0;
> > @@ -263,7 +263,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  			goto out;
> >  		}
> >  
> > -		if ((sizeof(dma_addr_t) < 8) && l) {
> > +		if ((sizeof(pci_bus_addr_t) < 8) && l) {
> >  			/* Above 32-bit boundary; try to reallocate */
> >  			res->flags |= IORESOURCE_UNSET;
> >  			res->start = 0;
> > @@ -398,7 +398,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
> >  	struct pci_dev *dev = child->self;
> >  	u16 mem_base_lo, mem_limit_lo;
> >  	u64 base64, limit64;
> > -	dma_addr_t base, limit;
> > +	pci_bus_addr_t base, limit;
> >  	struct pci_bus_region region;
> >  	struct resource *res;
> >  
> > @@ -425,8 +425,8 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
> >  		}
> >  	}
> >  
> > -	base = (dma_addr_t) base64;
> > -	limit = (dma_addr_t) limit64;
> > +	base = (pci_bus_addr_t) base64;
> > +	limit = (pci_bus_addr_t) limit64;
> >  
> >  	if (base != base64) {
> >  		dev_err(&dev->dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 211e9da..6021bbe 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -573,9 +573,15 @@ int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
> >  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
> >  		  int reg, int len, u32 val);
> >  
> > +#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> > +typedef u64 pci_bus_addr_t;
> > +#else
> > +typedef u32 pci_bus_addr_t;
> > +#endif
> > +
> >  struct pci_bus_region {
> > -	dma_addr_t start;
> > -	dma_addr_t end;
> > +	pci_bus_addr_t start;
> > +	pci_bus_addr_t end;
> >  };
> >  
> >  struct pci_dynids {
> > @@ -1124,7 +1130,7 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
> >  
> >  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> >  
> > -static inline dma_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
> > +static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
> >  {
> >  	struct pci_bus_region region;
> >  
> > -- 
> > 1.8.4.5
> > 
