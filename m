From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 19:16:34 +0000
Subject: Re: [PATCH 04/10] arm: implement DMA_ATTR_NON_CONSISTENT
Message-Id: <20181210191634.GB30648@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-5-hch@lst.de>
 <3aeb99c505fd1c33199fcc26fe5e0bf239dee57e.camel@collabora.com>
In-Reply-To: <3aeb99c505fd1c33199fcc26fe5e0bf239dee57e.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

On Sat, Dec 08, 2018 at 07:52:04PM -0300, Ezequiel Garcia wrote:
> >  #ifdef CONFIG_DMA_API_DEBUG
> > @@ -773,7 +791,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> >  
> >  	if (cma)
> >  		buf->allocator = &cma_allocator;
> > -	else if (is_coherent)
> > +	else if (is_coherent || (attrs & DMA_ATTR_NON_CONSISTENT))
> >  		buf->allocator = &simple_allocator;
> 
> Reading through your code I can't really see where the pgprot is changed
> for non-consistent requests. Namely, __get_dma_pgprot only
> returns writecombine or coherent memory.

We don't look at the pgprot at all for the simple allocator, and
don't look at prot for the DMA_ATTR_NON_CONSISTENT case in the
CMA allocator, so this should not be a problem.  However we need to
take DMA_ATTR_NON_CONSISTENT into account for calculating the mmap
pgprot, with something like this as an incremental patch:

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b3b66b41c450..6ac7e430a47c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -873,7 +873,8 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
+		vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
