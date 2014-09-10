From: David Vrabel <david.vrabel@citrix.com>
Date: Wed, 10 Sep 2014 12:38:25 +0000
Subject: Re: [Xen-devel] [PATCH v1 08/21] x86/xen/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <54104641.7020007@citrix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>	<1409911806-10519-9-git-send-email-wangyijing@huawei.com>	<5409C8C0.8020200@citrix.com>
	<540E6095.8030409@huawei.com>
In-Reply-To: <540E6095.8030409-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wuyun <wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On 09/09/14 03:06, Yijing Wang wrote:
> On 2014/9/5 22:29, David Vrabel wrote:
>> On 05/09/14 11:09, Yijing Wang wrote:
>>> Use MSI chip framework instead of arch MSI functions to configure
>>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>> [...]
>>> --- a/arch/x86/pci/xen.c
>>> +++ b/arch/x86/pci/xen.c
>> [...]
>>> @@ -418,9 +430,9 @@ int __init pci_xen_init(void)
>>>  #endif
>>>  
>>>  #ifdef CONFIG_PCI_MSI
>>> -	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
>>> -	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
>>> -	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
>>> +	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
>>> +	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
>>> +	x86_msi_chip = &xen_msi_chip;
>>>  	msi_chip.irq_mask = xen_nop_msi_mask;
>>>  	msi_chip.irq_unmask = xen_nop_msi_mask;
>>
>> Why have these not been changed to set the x86_msi_chip.mask/unmask
>> fields instead?
> 
> Hi David, x86_msi_chip here is struct msi_chip data type, used to configure MSI/MSI-X
> irq. msi_chip above is struct irq_chip data type, represent the MSI irq controller. They are
> not the same object. Their name easily confusing people.

Ok, it all makes sense now.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
