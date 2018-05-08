From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 08 May 2018 10:05:20 +0000
Subject: Re: [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries and debug_dma_dump_mappings
Message-Id: <bb5bb25f-24da-9729-a39b-3b88c65ef628@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180424140235.9125-1-hch@lst.de>
	<20180424140235.9125-4-hch@lst.de>
In-Reply-To: <20180424140235.9125-4-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 24/04/18 15:02, Christoph Hellwig wrote:
> Only used by the AMD GART driver, which must be built in.

FWIW debug_dma_dump_mappings() is also called by the Intel VT-d driver, 
but the same reasoning still applies. This does rather beg the question 
of whether it's right to have bits of low-level dma-debug internals 
*only* called by a couple of IOMMU drivers, but that can wait for 
another day.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-debug.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 075253cb613b..6a1ebaa83623 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
>   		spin_unlock_irqrestore(&bucket->lock, flags);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_dump_mappings);
>   
>   /*
>    * For each mapping (initial cacheline in the case of
> @@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(dma_debug_resize_entries);
>   
>   /*
>    * DMA-API debugging init code
> 
