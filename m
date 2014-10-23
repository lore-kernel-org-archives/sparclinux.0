From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Oct 2014 05:38:58 +0000
Subject: Re: [PATCH v3 09/27] arm/PCI: Clean unused pcibios_add_bus() and pcibios_remove_bus()
Message-Id: <20141023053858.GD11770@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
	<1413342435-7876-10-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-10-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu@l

On Wed, Oct 15, 2014 at 11:06:57AM +0800, Yijing Wang wrote:
> MSI chip will be saved in pci_sys_data, now we can
> clean up pcibios_add_bus() and pcibios_remove_bus()
> in arm, and use pci_find_msi_chip() to get msi chip
> in core MSI code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/arm/include/asm/mach/pci.h |    4 ----
>  arch/arm/kernel/bios32.c        |   16 ----------------
>  drivers/pci/msi.c               |   11 +++--------
>  3 files changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 59b0d87..230b2c9 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -39,8 +39,6 @@ struct hw_pci {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> -	void		(*add_bus)(struct pci_bus *bus);
> -	void		(*remove_bus)(struct pci_bus *bus);
>  };
>  
>  /*
> @@ -71,8 +69,6 @@ struct pci_sys_data {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> -	void		(*add_bus)(struct pci_bus *bus);
> -	void		(*remove_bus)(struct pci_bus *bus);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index a19038d..b1b872e 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -360,20 +360,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pcibios_fixup_bus);
>  
> -void pcibios_add_bus(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *sys = bus->sysdata;
> -	if (sys->add_bus)
> -		sys->add_bus(bus);
> -}
> -
> -void pcibios_remove_bus(struct pci_bus *bus)
> -{
> -	struct pci_sys_data *sys = bus->sysdata;
> -	if (sys->remove_bus)
> -		sys->remove_bus(bus);
> -}
> -
>  /*
>   * Swizzle the device pin each time we cross a bridge.  If a platform does
>   * not provide a swizzle function, we perform the standard PCI swizzling.
> @@ -478,8 +464,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
>  		sys->align_resource = hw->align_resource;
> -		sys->add_bus = hw->add_bus;
> -		sys->remove_bus = hw->remove_bus;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)

What do the core changes below have to do with the ARM changes above?
They should be a separate patch unless they can't be separated.

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f11108c..56e54ad 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -32,12 +32,10 @@ int pci_msi_ignore_mask;
>  
>  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  {
> -	struct msi_chip *chip = dev->bus->msi;
> +	struct msi_chip *chip;
>  	int err;
>  
> -	if (!chip)
> -		chip = pci_msi_chip(dev->bus);
> -
> +	chip = pci_msi_chip(dev->bus);
>  	if (!chip || !chip->setup_irq)
>  		return -EINVAL;
>  
> @@ -51,10 +49,7 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
>  	struct msi_desc *entry = irq_get_msi_desc(irq);
> -	struct msi_chip *chip = entry->dev->bus->msi;
> -
> -	if (!chip)
> -		chip = pci_msi_chip(entry->dev->bus);
> +	struct msi_chip *chip = pci_msi_chip(entry->dev->bus);
>  
>  	if (!chip || !chip->teardown_irq)
>  		return;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
