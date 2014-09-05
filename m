From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Sep 2014 11:41:40 +0000
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <5409A174.3050205@cogentembedded.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
	<1409911806-10519-16-git-send-email-wangyijing@huawei.com>
	<540994D4.6040500@cogentembedded.com>
	<43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
In-Reply-To: <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wangyijing <wangyijing0307-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org" <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, "arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Xinwei Hu <huxinwei>

On 9/5/2014 3:33 PM, wangyijing wrote:

>>> Use MSI chip framework instead of arch MSI functions to configure
>>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> ---
>>>   arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>>>   1 files changed, 12 insertions(+), 2 deletions(-)

>>> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
>>> index 71bd161..01781a4 100644
>>> --- a/arch/powerpc/kernel/msi.c
>>> +++ b/arch/powerpc/kernel/msi.c
>> [...]
>>> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>       return ppc_md.setup_msi_irqs(dev, nvec, type);
>>>   }
>>>
>>> -void arch_teardown_msi_irqs(struct pci_dev *dev)
>>> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)

>>    Shouldn't this function take IRQ # instead?

> This function need to teardown all msi irqs of the pci dev, we should pass the pci dev as argument .

    Ah, I've mixed up the teardown_irqs() method with teardown_irq()! Too 
similar. :-)

> Thanks!
> Yijing.

WBR, Sergei

