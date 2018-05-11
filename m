From: John Garry <john.garry@huawei.com>
Date: Fri, 11 May 2018 13:56:16 +0000
Subject: Re: [PATCH 04/20] arm-nommu: use generic dma_noncoherent_ops
Message-Id: <73603c68-da05-22bd-efab-d0387a98225d@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-5-hch@lst.de>
In-Reply-To: <20180511075945.16548-5-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 11/05/2018 08:59, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation for
> the nommu dma map implementation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                |   1 +
>  arch/arm/Kconfig                |   4 +
>  arch/arm/mm/dma-mapping-nommu.c | 139 +++++---------------------------
>  3 files changed, 23 insertions(+), 121 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 89d47eac18b2..3a492a9aeaad 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -9,6 +9,7 @@
>  config ARC
>  	def_bool y
>  	select ARC_TIMERS
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE

I guess that this arc change is here by accident, no? And isn't 
ARCH_HAS_SYNC_DMA_FOR_DEVICE already selected (by 3/20)?

>  	select ARCH_HAS_SG_CHAIN
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c43f5bb55ac8..76ddd0064f87 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig

