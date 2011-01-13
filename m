From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 13 Jan 2011 09:50:41 +0000
Subject: Re: [PATCH 2/4 V2] sparc: Add pci32_unmap_page.
Message-Id: <20110113095041.GB27203@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294909535-6290-3-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1294909535-6290-3-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 13, 2011 at 10:05:33AM +0100, Kristoffer Glembo wrote:
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>

I totally miss _why_ you add this function.
Just a small comment in the changelog would help.
It may due to my ignorance of all the dma stuff...


> ---
>  arch/sparc/kernel/ioport.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index cea49c0..1b9f07c 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -524,6 +524,13 @@ static dma_addr_t pci32_map_page(struct device *dev, struct page *page,
>  	return page_to_phys(page) + offset;
>  }
>  
> +static void pci32_unmap_page(struct device *dev, dma_addr_t ba, size_t size,
> +			     enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	if (dir != PCI_DMA_TODEVICE)
> +		mmu_inval_dma_area((unsigned long)phys_to_virt(ba), PAGE_ALIGN(size));
> +}

How about a patch that fix it so mmu_inval_dma_area() takes a void *
as first argument?
In most cases I see a cast from void * => unsigned long where we call
mmu_inval_dma_area().

In sbus_alloc_coherent() we use the result of __get_free_pages()
but the general pattern is that the result of __get_free_pages()
is cast to the right type when used.

So if we did:

void * va;

va = (void *)__get_free_pages(GFP_KERNEL|__GFP_COMP, order);
Then we could remove all the other casts.


	Sam
