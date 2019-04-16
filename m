From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:45 +0000
Subject: [PATCH 7/9] sparc/iommu: fix __sbus_iommu_map_page for highmem pages
Message-Id: <20190416182347.18441-8-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

__sbus_iommu_map_page currently assumes all pages are mapped into the
kernel direct mapping.  Switch to using physical address instead of
virtual ones for all the normal mapping operations, and only use
the virtual addresses for cache flushing when not operating on
a highmem page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 7e191c8ae46a..37b5ce7657f6 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -209,24 +209,23 @@ static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
 static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t len, bool per_page_flush)
 {
-	void *vaddr = page_address(page) + offset;
-	unsigned long off = (unsigned long)vaddr & ~PAGE_MASK;
+	phys_addr_t paddr = page_to_phys(page) + offset;
+	unsigned long off = paddr & ~PAGE_MASK;
 	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
 
-	if (per_page_flush) {
-		unsigned long p = (unsigned long)vaddr & PAGE_MASK;
+	if (per_page_flush && !PageHighMem(page)) {
+		unsigned long vaddr, p;
 
-		while (p < (unsigned long)vaddr + len) {
+		vaddr = (unsigned long)page_address(page) + offset;
+		for (p = vaddr & PAGE_MASK; p < vaddr + len; p += PAGE_SIZE)
 			flush_page_for_dma(p);
-			p += PAGE_SIZE;
-		}
 	}
 
-	return iommu_get_one(dev, virt_to_phys(vaddr), npages) + off;
+	return iommu_get_one(dev, paddr, npages) + off;
 }
 
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
-- 
2.20.1
