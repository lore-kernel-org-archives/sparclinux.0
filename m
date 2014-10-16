From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Thu, 16 Oct 2014 12:13:20 +0000
Subject: Re: [PATCH v3 22/27] s390/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <alpine.LFD.2.11.1410161411340.1575@denkbrett>
List-Id: <sparclinux.vger.kernel.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
	<1413342435-7876-23-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-23-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs8@public.gmane.org

On Wed, 15 Oct 2014, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
> Hi Sebastian,
>    I dropped the Acked-by , because this version has a
> lot changes compared to last. So, I guess you may want to check it again.

I did and I agree with that one too.

Regards,
Sebastian

> ---
>  arch/s390/include/asm/pci.h |    9 +++++++++
>  arch/s390/pci/pci.c         |   12 ++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index c030900..4d41f08 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -88,6 +88,8 @@ struct zpci_dev {
>  	u32 uid;			/* user defined id */
>  	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
> 
> +	struct msi_chip *msi_chip;
> +
>  	/* IRQ stuff */
>  	u64		msi_addr;	/* MSI address */
>  	struct airq_iv *aibv;		/* adapter interrupt bit vector */
> @@ -121,6 +123,13 @@ struct zpci_dev {
>  	struct dentry	*debugfs_perf;
>  };
> 
> +static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
> +{
> +	struct zpci_dev *zpci = bus->sysdata;
> +
> +	return zpci->msi_chip;
> +}
> +
>  static inline bool zdev_enabled(struct zpci_dev *zdev)
>  {
>  	return (zdev->fh & (1UL << 31)) ? true : false;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 552b990..bf6732f 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -358,7 +358,8 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
> 
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +static int zpci_setup_msi_irqs(struct msi_chip *chip,
> +		struct pci_dev *pdev, int nvec, int type)
>  {
>  	struct zpci_dev *zdev = get_zdev(pdev);
>  	unsigned int hwirq, msi_vecs;
> @@ -434,7 +435,8 @@ out:
>  	return rc;
>  }
> 
> -void arch_teardown_msi_irqs(struct pci_dev *pdev)
> +static void zpci_teardown_msi_irqs(struct msi_chip *chip,
> +		struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = get_zdev(pdev);
>  	struct msi_desc *msi;
> @@ -464,6 +466,11 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>  	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
>  }
> 
> +static struct msi_chip zpci_msi_chip = {
> +	.setup_irqs = zpci_setup_msi_irqs,
> +	.teardown_irqs = zpci_teardown_msi_irqs,
> +};
> +
>  static void zpci_map_resources(struct zpci_dev *zdev)
>  {
>  	struct pci_dev *pdev = zdev->pdev;
> @@ -749,6 +756,7 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
>  	if (ret)
>  		return ret;
> 
> +	zdev->msi_chip = &zpci_msi_chip;
>  	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
>  				      zdev, &resources);
>  	if (!zdev->bus) {
> -- 
> 1.7.1
> 
> 

