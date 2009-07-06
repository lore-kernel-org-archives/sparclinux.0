From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 06 Jul 2009 08:21:28 +0000
Subject: Re: [PATCH 5/5] sparc: use asm-generic/pci-dma-compat
Message-Id: <200907061021.28360.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1246860820-20629-1-git-send-email-fujita.tomonori@lab.ntt.co.jp> <1246860820-20629-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1246860820-20629-6-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, reif@earthlink.net

On Monday 06 July 2009, FUJITA Tomonori wrote:

> --- a/arch/sparc/include/asm/pci_64.h
> +++ b/arch/sparc/include/asm/pci_64.h
> -/* Return whether the given PCI device DMA address mask can
> - * be supported properly.  For example, if your device can
> - * only drive the low 24-bits during PCI bus mastering, then
> - * you would pass 0x00ffffff as the mask to this function.
> - */
> -extern int pci_dma_supported(struct pci_dev *hwdev, u64 mask);
> -
>  /* PCI IOMMU mapping bypass support. */
>  
>  /* PCI 64-bit addressing works for all slots on all controller
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -840,6 +840,8 @@ static struct dma_map_ops sun4u_dma_ops = {
>  struct dma_map_ops *dma_ops = &sun4u_dma_ops;
>  EXPORT_SYMBOL(dma_ops);
>  
> +extern int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
> +
>  int dma_supported(struct device *dev, u64 device_mask)
>  {
>  	struct iommu *iommu = dev->archdata.iommu;

Minor nitpicking: The declaration should better be left in the header
file to avoid extern declarations in C files.

	Arnd <><
