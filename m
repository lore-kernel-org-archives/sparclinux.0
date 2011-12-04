From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 04 Dec 2011 10:49:17 +0000
Subject: Re: [PATCH-RFC 10/10] sparc: switch to GENERIC_PCI_IOMAP
Message-Id: <20111204104916.GL15464@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Nov 24, 2011 at 10:21:27PM +0200, Michael S. Tsirkin wrote:
> sparc copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in.  Since that's in
> a separate file now, we can reuse the common implementation.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sorry to nag, any ACKs/NACKs on the sparc changes?
I intend to send this to Linus if there are no
objections. Thanks!

> ---
>  arch/sparc/Kconfig             |    1 +
>  arch/sparc/include/asm/io_32.h |    5 ++++-
>  arch/sparc/include/asm/io_64.h |    5 ++++-
>  arch/sparc/lib/iomap.c         |   23 -----------------------
>  4 files changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index f92602e..a4644f5 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -28,6 +28,7 @@ config SPARC
>  	select HAVE_GENERIC_HARDIRQS
>  	select GENERIC_IRQ_SHOW
>  	select USE_GENERIC_SMP_HELPERS if SMP
> +	select GENERIC_PCI_IOMAP
>  
>  config SPARC32
>  	def_bool !64BIT
> diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
> index c2ced21..9be8778 100644
> --- a/arch/sparc/include/asm/io_32.h
> +++ b/arch/sparc/include/asm/io_32.h
> @@ -8,6 +8,10 @@
>  #include <asm/page.h>      /* IO address mapping routines need this */
>  #include <asm/system.h>
>  
> +#ifdef __KERNEL__
> +#include <asm-generic/pci_iomap.h>
> +#endif
> +
>  #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
>  
>  static inline u32 flip_dword (u32 l)
> @@ -324,7 +328,6 @@ extern void ioport_unmap(void __iomem *);
>  
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
> -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>  
>  /*
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index 9c89654..19cd51d 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -9,6 +9,10 @@
>  #include <asm/system.h>
>  #include <asm/asi.h>
>  
> +#ifdef __KERNEL__
> +#include <asm-generic/pci_iomap.h>
> +#endif
> +
>  /* PC crapola... */
>  #define __SLOW_DOWN_IO	do { } while (0)
>  #define SLOW_DOWN_IO	do { } while (0)
> @@ -514,7 +518,6 @@ extern void ioport_unmap(void __iomem *);
>  
>  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
>  struct pci_dev;
> -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
>  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>  
>  static inline int sbus_can_dma_64bit(void)
> diff --git a/arch/sparc/lib/iomap.c b/arch/sparc/lib/iomap.c
> index 9ef37e1..c4d42a5 100644
> --- a/arch/sparc/lib/iomap.c
> +++ b/arch/sparc/lib/iomap.c
> @@ -18,31 +18,8 @@ void ioport_unmap(void __iomem *addr)
>  EXPORT_SYMBOL(ioport_map);
>  EXPORT_SYMBOL(ioport_unmap);
>  
> -/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> -{
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -	if (!len || !start)
> -		return NULL;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -	if (flags & IORESOURCE_IO)
> -		return ioport_map(start, len);
> -	if (flags & IORESOURCE_MEM) {
> -		if (flags & IORESOURCE_CACHEABLE)
> -			return ioremap(start, len);
> -		return ioremap_nocache(start, len);
> -	}
> -	/* What? */
> -	return NULL;
> -}
> -
>  void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>  {
>  	/* nothing to do */
>  }
> -EXPORT_SYMBOL(pci_iomap);
>  EXPORT_SYMBOL(pci_iounmap);
> -- 
> 1.7.5.53.gc233e
