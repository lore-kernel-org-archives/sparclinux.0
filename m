From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 02 Feb 2016 15:06:15 +0000
Subject: Re: [PATCH v6 3/9] s390/dma: Allow per device dma ops
Message-Id: <20160202160615.7c7f6663.cornelia.huck@de.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
	<454ab46cd61644851aa437c73e6c8c7da79bfb30.1454349471.git.luto@kernel.org>
In-Reply-To: <454ab46cd61644851aa437c73e6c8c7da79bfb30.1454349471.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S.
	Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon,  1 Feb 2016 10:00:53 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> As virtio-ccw will have dma ops, we can no longer default to the
> zPCI ones. Make use of dev_archdata to keep the dma_ops per device.
> The pci devices now use that to override the default, and the
> default is changed to use the noop ops for everything that does not
> specify a device specific one.
> To compile without PCI support we will enable HAS_DMA all the time,
> via the default config in lib/Kconfig.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  arch/s390/Kconfig                   | 6 ++----
>  arch/s390/include/asm/device.h      | 6 +++++-
>  arch/s390/include/asm/dma-mapping.h | 6 ++++--
>  arch/s390/pci/pci.c                 | 1 +
>  arch/s390/pci/pci_dma.c             | 4 ++--
>  5 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3be9c832dec1..5b22a26337b2 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -124,6 +124,8 @@ config S390
>  	select HAVE_CMPXCHG_DOUBLE
>  	select HAVE_CMPXCHG_LOCAL
>  	select HAVE_DEBUG_KMEMLEAK
> +	select HAVE_DMA_ATTRS

HAVE_DMA_ATTRS no longer exists in the current tree.

> +	select HAVE_DMA_API_DEBUG
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_FTRACE_MCOUNT_RECORD

With the line above removed:

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

