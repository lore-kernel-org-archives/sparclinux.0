From: David Vrabel <david.vrabel@citrix.com>
Date: Tue, 12 Aug 2014 09:09:49 +0000
Subject: Re: [Xen-devel] [RFC PATCH 01/20] x86/xen/MSI: Eliminate arch_msix_mask_irq() and arch_msi_mask_irq(
Message-Id: <53E9D9DD.3060901@citrix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
 <1407828373-24322-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12/08/14 08:25, Yijing Wang wrote:
> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
> Introduced these two funcntions make MSI code complex. This patch
> reverted commit 0e4ccb150 and add #ifdef for x86 msi_chip to fix this
> bug for simplicity. Also this is preparation for using struct
> msi_chip instead of weak arch MSI functions in all platforms.
[...]
>  static struct irq_chip msi_chip = {
>  	.name			= "PCI-MSI",
> +#ifdef CONFIG_XEN
> +	.irq_unmask		= nop_unmask_msi_irq,
> +	.irq_mask		= nop_mask_msi_irq,
> +#else
>  	.irq_unmask		= unmask_msi_irq,
>  	.irq_mask		= mask_msi_irq,
> +#endif

No.  CONFIG_XEN kernels can run on Xen and bare metal so this must be a
runtime option.

David
