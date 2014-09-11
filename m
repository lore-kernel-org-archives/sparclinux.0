From: David Vrabel <david.vrabel@citrix.com>
Date: Thu, 11 Sep 2014 13:08:34 +0000
Subject: Re: [Xen-devel] [PATCH v1 04/21] x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq()
Message-Id: <54119ED2.3070802@citrix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>	<1409911806-10519-5-git-send-email-wangyijing@huawei.com>	<541045BE.9050804@citrix.com>
	<5410F955.80609@huawei.com>
In-Reply-To: <5410F955.80609-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wuyun <wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On 11/09/14 02:22, Yijing Wang wrote:
> On 2014/9/10 20:36, David Vrabel wrote:
>> On 05/09/14 11:09, Yijing Wang wrote:
>>> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
>>> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
>>> Introduced these two funcntions make MSI code complex. And mask/unmask
>>> is the irq actions related to interrupt controller, should not use
>>> weak arch functions to override mask/unmask interfaces. This patch
>>> reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
>>> msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
>>> bug for simplicity. Also this is preparation for using struct
>>> msi_chip instead of weak arch MSI functions in all platforms.
>>
>> Acked-by: David Vrabel <david.vrabel@citrix.com>
>>
>> But I wonder if it would be better the Xen subsystem to provide its own
>> struct irq_chip instead of adjusting the fields in the generic x86 one.
> 
> Thanks! Currently, Xen and the bare x86 system only have the different irq_chip->irq_mask/irq_unmask.
> So I chose to override the two ops of bare x86 irq_chip in xen. Konrad Rzeszutek Wilk has been tested it
> ok in his platform, so I think we could use its own irq_chip for xen later if the difference become large.

This sounds reasonable.

David
