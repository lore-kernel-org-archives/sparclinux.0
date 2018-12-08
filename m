From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:36:54 +0000
Subject: [PATCH 02/10] arm64/iommu: don't remap contiguous allocations for coherent devices
Message-Id: <20181208173702.15158-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
In-Reply-To: <20181208173702.15158-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

There is no need to have an additional kernel mapping for a contiguous
allocation if the device already is DMA coherent, so skip it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4c0f498069e8..d39b60113539 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -255,13 +255,18 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 						    size >> PAGE_SHIFT);
 			return NULL;
 		}
+
+		if (coherent) {
+			memset(addr, 0, size);
+			return addr;
+		}
+
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
 						   prot,
 						   __builtin_return_address(0));
 		if (addr) {
 			memset(addr, 0, size);
-			if (!coherent)
-				__dma_flush_area(page_to_virt(page), iosize);
+			__dma_flush_area(page_to_virt(page), iosize);
 		} else {
 			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
 			dma_release_from_contiguous(dev, page,
@@ -309,7 +314,9 @@ static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 
 		iommu_dma_unmap_page(dev, handle, iosize, 0, attrs);
 		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
-		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+
+		if (!dev_is_dma_coherent(dev))
+			dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else if (is_vmalloc_addr(cpu_addr)){
 		struct vm_struct *area = find_vm_area(cpu_addr);
 
@@ -336,11 +343,12 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		return ret;
 
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
+		unsigned long pfn;
+
+		if (dev_is_dma_coherent(dev))
+			pfn = virt_to_pfn(cpu_addr);
+		else
+			pfn = vmalloc_to_pfn(cpu_addr);
 		return __swiotlb_mmap_pfn(vma, pfn, size);
 	}
 
@@ -359,11 +367,12 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
 	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		struct page *page = vmalloc_to_page(cpu_addr);
+		struct page *page;
+
+		if (dev_is_dma_coherent(dev))
+			page = virt_to_page(cpu_addr);
+		else
+			page = vmalloc_to_page(cpu_addr);
 		return __swiotlb_get_sgtable_page(sgt, page, size);
 	}
 
-- 
2.19.2
