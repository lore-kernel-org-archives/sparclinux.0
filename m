From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 14 Aug 2015 12:03:03 +0000
Subject: Re: [PATCH 14/31] sparc32/io-unit: handle page-less SG entries
Message-Id: <20150814120303.GA21682@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1439363150-8661-15-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-15-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 12, 2015 at 09:05:33AM +0200, Christoph Hellwig wrote:
> For the iommu offset we just need and offset into the page.  Calculate
> that using the physical address instead of using the virtual address
> so that we don't require a virtual mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/mm/io-unit.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
> index f311bf2..82f97ae 100644
> --- a/arch/sparc/mm/io-unit.c
> +++ b/arch/sparc/mm/io-unit.c

> -static unsigned long iounit_get_area(struct iounit_struct *iounit, unsigned long vaddr, int size)
> +static dma_addr_t iounit_get_area(struct iounit_struct *iounit,
> +		unsigned long paddr, int size)
>  {

> -	unsigned long rotor, scan, limit;
> +	unsigned long rotor, scan, limit, dma_addr;

> +	dma_addr = IOUNIT_DMA_BASE + (scan << PAGE_SHIFT) + (paddr & ~PAGE_MASK);

> +	return dma_addr;
>  }

> @@ -145,7 +146,7 @@ static __u32 iounit_get_scsi_one(struct device *dev, char *vaddr, unsigned long
>  	unsigned long ret, flags;

> -	ret = iounit_get_area(iounit, (unsigned long)vaddr, len);
> +	ret = iounit_get_area(iounit, virt_to_phys(vaddr), len);

>  	return ret;
>  }

Would it make sense to normalize all these other instances of unsigned long
into dma_addr_t, and not just one?

-- 
     2. That which causes joy or happiness.
