From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Oct 2014 05:18:31 +0000
Subject: Re: [PATCH v3 05/27] PCI: tegra: Save msi chip in pci_sys_data
Message-Id: <20141023051831.GB11770@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
	<1413342435-7876-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-6-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu@l

On Wed, Oct 15, 2014 at 11:06:53AM +0800, Yijing Wang wrote:
> Save msi chip in pci_sys_data instead of assign
> msi chip to every pci bus in .add_bus().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host/pci-tegra.c |   13 +++----------
>  1 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3d43874..5af0525 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  	return irq;
>  }
>  
> -static void tegra_pcie_add_bus(struct pci_bus *bus)
> -{
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		struct tegra_pcie *pcie = sys_to_pcie(bus->sysdata);
> -
> -		bus->msi = &pcie->msi.chip;
> -	}
> -}
> -
>  static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(sys);
> @@ -1881,11 +1872,13 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
>  
>  	memset(&hw, 0, sizeof(hw));
>  
> +#ifdef CONFIG_PCI_MSI
> +	hw.msi_chip = &pcie->msi.chip;
> +#endif

Why did you use "#ifdef CONFIG_PCI_MSI" instead of the
"IS_ENABLED(CONFIG_PCI_MSI)" used previously?

It's true that CONFIG_PCI_MSI will never be a tristate symbol, so we don't
really *need* the extra smarts of IS_ENABLED(), but I'm fairly sympathetic
to James' argument [1] that we should just use IS_ENABLED() all the time
because it's simpler overall.

If you want to change the #ifdef to IS_ENABLED(), that should be a separate
patch from your msi_chip change, and we can debate the merits of that by
itself.

[1] http://lkml.iu.edu//hypermail/linux/kernel/1204.3/00081.html

>  	hw.nr_controllers = 1;
>  	hw.private_data = (void **)&pcie;
>  	hw.setup = tegra_pcie_setup;
>  	hw.map_irq = tegra_pcie_map_irq;
> -	hw.add_bus = tegra_pcie_add_bus;
>  	hw.scan = tegra_pcie_scan_bus;
>  	hw.ops = &tegra_pcie_ops;
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
