From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:36:52 +0000
Subject: make the non-consistent DMA allocator more userful
Message-Id: <20181208173702.15158-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

Hi all,

we had all kinds of discussions about how to best allocate DMAable memory
without having to deal with the problem that your normal "coherent"
DMA allocator can be very slow on platforms where DMA is not DMA
coherent.

To work around this drivers basically two choices at the moment:

 (1) just allocate memory using the page or slab allocator and the call
     one of the dma_map_* APIs on it.  This has a few drawbacks:

       - normal GFP_KERNEL memory might not actually be DMA addressable
	 for all devices, forcing fallbacks to slow bounce buffering
       - there is no easy way to access the CMA allocator for large
	 chunks, or to map small pages into single device and virtually
	 contigous chunks using the iommu and vmap

 (2) use dma_alloc_attrs with the DMA_ATTR_NON_CONSISTENT flag.  This
     has a different set of drawbacks

       - only very few architectures actually implement this API fully,
	 if it is not implemented it falls back to the potentially
	 uncached and slow coherent allocator
       - the dma_cache_sync API to use with it is not very well
	 specified and problematic in that it does not clearly
	 transfer ownership

Based on that I've been planning to introduce a proper API for
allocating DMAable memory for a while.  In the end I've ended up
improving the DMA_ATTR_NON_CONSISTENT flag instead of designing
something new.  To make it useful we need to:

 (a) ensure we don't fall back to the slow coherent allocator except
     on fully coherent platforms where they are the same anyway
 (b) replace the odd dma_cache_sync calls with the proper
     dma_sync_* APIs that we also use for other ownership trasnfers

This turned out to be surprisingly simple now that we have consolidated
most of the direct mapping code.  Note that this series is missing
the updates for powerpc which is in the process of being migrated to
the common direct mapping code in another series and would be covered
by that.

Note that these patches don't use iommu/vmap coalescing as they can
be problematic depending on the cache architecture.  But we could
opt into those when we know we don't have cache interaction problems
based on the API.

All the patches are on top of the dma-mapping for-net tree and also
available as a git tree here:

    git://git.infradead.org/users/hch/misc.git dma-noncoherent-allocator

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-noncoherent-allocator
