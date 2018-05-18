From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Fri, 18 May 2018 17:20:02 +0000
Subject: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20] dma-mapping: provide a generic dma
Message-Id: <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
	<bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
In-Reply-To: <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux@vg

On 05/18/2018 06:11 AM, Alexey Brodkin wrote:
>   void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
>                  size_t size, enum dma_data_direction dir)
>   {
> +       if (dir != DMA_TO_DEVICE){
> +               dump_stack();
> +               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
> +                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_TO_DEVICE));
> +       }
> +
>          return _dma_cache_sync(dev, paddr, size, dir);
>   }
>   
>   void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>                  size_t size, enum dma_data_direction dir)
>   {
> +       if (dir != DMA_FROM_DEVICE) {
> +               dump_stack();
> +               printk(" *** %s@%d: DMA direction is %s instead of %s\n",
> +                      __func__, __LINE__, dir_to_str(dir), dir_to_str(DMA_FROM_DEVICE));
> +       }
> +
>          return _dma_cache_sync(dev, paddr, size, dir);
>   }

...
> In case of MMC/DW_MCI (AKA DesignWare MobileStorage controller) that's an execution flow:
> 1) __dw_mci_start_request()
> 2) dw_mci_pre_dma_transfer()
> 3) dma_map_sg(..., mmc_get_dma_dir(data))
>
> Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
> I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
> is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
> DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
>
> I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
> in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.

So roughly 10 years ago, some kernel rookie name Vineet Gupta, asked the exact 
same question :-)

http://kernelnewbies.kernelnewbies.narkive.com/aGW1QcDv/query-about-dma-sync-for-cpu-and-direction-to-device

I never understood the need for this direction. And if memory serves me right, at 
that time I was seeing twice the amount of cache flushing !

> But the real fix of my problem is:
> ---------------------------------------->8------------------------------------
> --- a/lib/dma-noncoherent.c
> +++ b/lib/dma-noncoherent.c
> @@ -35,7 +35,7 @@ static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page
>   
>          addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>          if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -               arch_sync_dma_for_device(dev, page_to_phys(page), size, dir);
> +               arch_sync_dma_for_device(dev, page_to_phys(page) + offset, size, dir);
>          return addr;
>   }
> ---------------------------------------->8------------------------------------
>
> You seem to lost an offset in the page so if we happen to have a buffer not aligned to
> a page boundary then we were obviously corrupting data outside our data :)

Neat !

