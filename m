From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jan 2011 02:33:33 +0000
Subject: Re: [PATCH 3/4] sparc: Add pci32_unmap_page.
Message-Id: <20110112.183333.140737711.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294742946-1040-4-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1294742946-1040-4-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 11 Jan 2011 11:49:05 +0100

> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> ---
>  arch/sparc/kernel/ioport.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index bfcbd1e..ba5cf62 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -529,6 +529,14 @@ static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
>  	return page_to_phys(page) + offset;
>  }
>  
> +static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
> +			     enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	if (dir != PCI_DMA_TODEVICE) {
> +		mmu_inval_dma_area((unsigned long)phys_to_virt(ba), PAGE_ALIGN(size));
> +	}
> +}
> +

Please do not enclose a basic block consisting of one single statement
into braces.

Fix this up for all of your patches and resubmit.
