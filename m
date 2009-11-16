From: David Miller <davem@davemloft.net>
Date: Mon, 16 Nov 2009 10:55:29 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091116.025529.149146544.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 16 Nov 2009 10:51:07 +0100

> @@ -524,7 +536,16 @@ static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
>  				 struct dma_attrs *attrs)
>  {
>  	/* IIep is write-through, not flushing. */
> -	return page_to_phys(page) + offset;
> +	return virt_to_phys(page_address(page)) + offset;
> +}

What's wrong with page_to_phys()?

page_to_phys() is what must be used, because it is legal to DMA to or
from a highmem page, and for those page_address(page) does not
necessaily evaluate fully.
