From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 03 Nov 2015 13:18:24 +0000
Subject: Re: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-Id: <20151103131824.GA12232@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
In-Reply-To: <20151030213511.GK7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 30, 2015 at 02:35:11PM -0700, Nishanth Aravamudan wrote:
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index ccc0c1f93daa..a9a5285bdb39 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1717,7 +1717,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	u32 aqa;
>  	u64 cap = readq(&dev->bar->cap);
>  	struct nvme_queue *nvmeq;
> -	unsigned page_shift = PAGE_SHIFT;
> +	/*
> +	 * default to a 4K page size, with the intention to update this
> +	 * path in the future to accomodate architectures with differing
> +	 * kernel and IO page sizes.
> +	 */
> +	unsigned page_shift = 12;
>  	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
>  	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;

Looks good as a start.  Note that all the MPSMIN/MAX checking could
be removed as NVMe devices must support 4k pages.
