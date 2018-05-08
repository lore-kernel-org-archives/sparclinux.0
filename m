From: Robin Murphy <robin.murphy@arm.com>
Date: Tue, 08 May 2018 09:50:06 +0000
Subject: Re: [PATCH 2/3] dma-debug: simplify counting of preallocated requests
Message-Id: <b50ef15a-8ffb-e8f2-11a7-b38d2ebda1c6@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180424140235.9125-1-hch@lst.de>
	<20180424140235.9125-3-hch@lst.de>
In-Reply-To: <20180424140235.9125-3-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 24/04/18 15:02, Christoph Hellwig wrote:
> Just keep a single variable with a descriptive name instead of two
> with confusing names.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-debug.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 712a897174e4..075253cb613b 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -132,7 +132,7 @@ static u32 min_free_entries;
>   static u32 nr_total_entries;
>   
>   /* number of preallocated entries requested by kernel cmdline */
> -static u32 req_entries;
> +static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   /* debugfs dentry's for the stuff above */
>   static struct dentry *dma_debug_dent        __read_mostly;
> @@ -1011,7 +1011,6 @@ void dma_debug_add_bus(struct bus_type *bus)
>   
>   static int dma_debug_init(void)
>   {
> -	u32 num_entries;
>   	int i;
>   
>   	/* Do not use dma_debug_initialized here, since we really want to be
> @@ -1032,12 +1031,7 @@ static int dma_debug_init(void)
>   		return 0;
>   	}
>   
> -	if (req_entries)
> -		num_entries = req_entries;
> -	else
> -		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> -
> -	if (prealloc_memory(num_entries) != 0) {
> +	if (prealloc_memory(nr_prealloc_entries) != 0) {
>   		pr_err("DMA-API: debugging out of memory error - disabled\n");
>   		global_disable = true;
>   
> @@ -1068,16 +1062,10 @@ static __init int dma_debug_cmdline(char *str)
>   
>   static __init int dma_debug_entries_cmdline(char *str)
>   {
> -	int res;
> -
>   	if (!str)
>   		return -EINVAL;
> -
> -	res = get_option(&str, &req_entries);
> -
> -	if (!res)
> -		req_entries = 0;
> -
> +	if (!get_option(&str, &nr_prealloc_entries))
> +		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   	return 0;
>   }
>   
> 
