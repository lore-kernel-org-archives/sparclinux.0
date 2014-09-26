From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 26 Sep 2014 10:38:26 +0000
Subject: Re: [PATCH v2 06/22] PCI/MSI: Introduce weak arch_find_msi_chip() to find MSI chip
Message-Id: <alpine.DEB.2.11.1409261236160.4567@nanos>
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-7-git-send-email-wangyijing@huawei.com>
	<alpine.DEB.2.10.1409251220570.4604@nanos>
	<5424D30A.6040900@huawei.com>
In-Reply-To: <5424D30A.6040900-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David

On Fri, 26 Sep 2014, Yijing Wang wrote:
> On 2014/9/25 18:38, Thomas Gleixner wrote:
> > On Thu, 25 Sep 2014, Yijing Wang wrote:
> > 
> >> Introduce weak arch_find_msi_chip() to find the match msi_chip.
> >> Currently, MSI chip associates pci bus to msi_chip. Because in
> >> ARM platform, there may be more than one MSI controller in system.
> >> Associate pci bus to msi_chip help pci device to find the match
> >> msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
> >> like in x86. we only need one MSI chip, because all device use
> >> the same MSI address/data and irq etc. So it's no need to associate
> >> pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
> >> to return the MSI chip for simplicity. The default weak
> >> arch_find_msi_chip() used in ARM platform, find the MSI chip
> >> by pci bus.
> > 
> > This is really backwards. On one hand you try to get rid of the weak
> > arch functions zoo and then you invent new ones for no good
> > reason. Why can't x86 store the chip in the pci bus?
> > 
> > Looking deeper, I'm questioning the whole notion of different
> > msi_chips. Are this really different MSI controllers with a different
> > feature set or are this defacto multiple instances of the same
> > controller which just need a different data set?
> 
> MSI chip in this series is to setup MSI irq, including IRQ allocation, Map,
> compose MSI msg ..., in different platform, many arch specific MSI irq details in it.
> It's difficult to extract the common data and code.
> 
> I have a plan to rework MSI related irq_chips in kernel, PCI and Non-PCI, currently,
> HPET, DMAR and PCI have their own irq_chip and MSI related functions, write_msi_msg(),
> mask_msi_irq(), etc... I want to extract the common data set for that, so we can
> remove lots of unnecessary MSI code.

That makes sense. Can you please make sure that this does not conflict
with the ongoing work Jiang is doing in the x86 irq area with
hierarchical irqdomains to distangle layered levels like MSI from the
underlying vector/irqremap mechanics.

Thanks,

	tglx
