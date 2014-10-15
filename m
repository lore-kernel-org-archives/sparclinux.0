From: David Miller <davem@davemloft.net>
Date: Wed, 15 Oct 2014 02:36:41 +0000
Subject: Re: [PATCH v3 25/27] Sparc/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <20141014.223641.1750858832286185881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
	<1413342435-7876-26-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1413342435-7876-26-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 11:07:13 +0800

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
