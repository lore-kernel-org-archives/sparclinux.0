From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:37:02 +0000
Subject: [PATCH 10/10] Documentation: update the description for DMA_ATTR_NON_CONSISTENT
Message-Id: <20181208173702.15158-11-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

We got rid of the odd selective consistent or not behavior, and now
want the normal dma_sync_single_* functions to be used for strict
ownership transfers.  While dma_cache_sync hasn't been removed from
the tree yet it should not be used in any new caller, so documentation
for it is dropped here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API.txt        | 30 ++++--------------------------
 Documentation/DMA-attributes.txt |  9 +++++----
 include/linux/dma-mapping.h      |  3 +++
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index ac66ae2509a9..c81fe8a4aeec 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -518,20 +518,9 @@ API at all.
 	dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 			gfp_t flag, unsigned long attrs)
 
-Identical to dma_alloc_coherent() except that when the
-DMA_ATTR_NON_CONSISTENT flags is passed in the attrs argument, the
-platform will choose to return either consistent or non-consistent memory
-as it sees fit.  By using this API, you are guaranteeing to the platform
-that you have all the correct and necessary sync points for this memory
-in the driver should it choose to return non-consistent memory.
-
-Note: where the platform can return consistent memory, it will
-guarantee that the sync points become nops.
-
-Warning:  Handling non-consistent memory is a real pain.  You should
-only use this API if you positively know your driver will be
-required to work on one of the rare (usually non-PCI) architectures
-that simply cannot make consistent memory.
+Similar to dma_alloc_coherent(), except that the behavior can be controlled
+in more detail using the attrs argument.  See Documentation/DMA-attributes.txt
+for more details.
 
 ::
 
@@ -540,7 +529,7 @@ that simply cannot make consistent memory.
 		       dma_addr_t dma_handle, unsigned long attrs)
 
 Free memory allocated by the dma_alloc_attrs().  All parameters common
-parameters must identical to those otherwise passed to dma_fre_coherent,
+parameters must identical to those otherwise passed to dma_free_coherent,
 and the attrs argument must be identical to the attrs passed to
 dma_alloc_attrs().
 
@@ -560,17 +549,6 @@ memory or doing partial flushes.
 	into the width returned by this call.  It will also always be a power
 	of two for easy alignment.
 
-::
-
-	void
-	dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		       enum dma_data_direction direction)
-
-Do a partial sync of memory that was allocated by dma_alloc_attrs() with
-the DMA_ATTR_NON_CONSISTENT flag starting at virtual address vaddr and
-continuing on for size.  Again, you *must* observe the cache line
-boundaries when doing this.
-
 ::
 
 	int
diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 8f8d97f65d73..2bb3fc0a621b 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -46,10 +46,11 @@ behavior.
 DMA_ATTR_NON_CONSISTENT
 -----------------------
 
-DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
-consistent or non-consistent memory as it sees fit.  By using this API,
-you are guaranteeing to the platform that you have all the correct and
-necessary sync points for this memory in the driver.
+DMA_ATTR_NON_CONSISTENT specifies that the memory returned is not
+required to be consistent.  The memory is owned by the device when
+returned from this function, and ownership must be explicitly
+transferred to the CPU using dma_sync_single_for_cpu, and back to the
+device using dma_sync_single_for_device.
 
 DMA_ATTR_NO_KERNEL_MAPPING
 --------------------------
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8c81fa5d1f44..8757ad5087c4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -432,6 +432,9 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
 #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
 
+/*
+ * Don't use in new code, use dma_sync_single_for_{device,cpu} instead.
+ */
 static inline void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction dir)
-- 
2.19.2
