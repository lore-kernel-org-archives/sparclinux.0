From: Andre Przywara <andre.przywara@arm.com>
Date: Mon, 21 Sep 2015 17:17:09 +0000
Subject: [PATCH] sparc(64)/iommu: fixup iommu_tbl_range_alloc() types
Message-Id: <1442855829-11245-1-git-send-email-andre.przywara@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55FC49B8.3020100@arm.com>
In-Reply-To: <55FC49B8.3020100@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

With DMA_ERROR_CODE now being dma_addr_t in most architectures, it
turned out that iommu_tbl_range_alloc (defined in lib/iommu-common.c)
is actually using a wrong return type.
This was easily fixed in a previous patch, but now the types in the
callers do not match anymore.
This patch fixes the obvious mismatches to allow sane comparisons with
the error return value.
Compile-tested on sparc, sparc64, x86, ARM, arm64.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi David,

as promised my first naive try on fixing the callers of
iommu_tbl_range_alloc() as well. This goes on top of the return type
fix I sent on Friday.
Please let me know if that makes sense or whether I am looking in the
totally wrong direction.

Cheers,
Andre.
 arch/sparc/kernel/iommu.c     | 5 +++--
 arch/sparc/kernel/ldc.c       | 5 +++--
 arch/sparc/kernel/pci_sun4v.c | 7 ++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 5320689..7d04a87 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -157,7 +157,7 @@ static inline iopte_t *alloc_npages(struct device *dev,
 				    struct iommu *iommu,
 				    unsigned long npages)
 {
-	unsigned long entry;
+	dma_addr_t entry;
 
 	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
 				      (unsigned long)(-1), 0);
@@ -476,7 +476,8 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
 	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
-		unsigned long paddr, npages, entry, out_entry = 0, slen;
+		unsigned long paddr, npages, slen;
+		dma_addr_t entry, out_entry = 0;
 		iopte_t *base;
 
 		slen = s->length;
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 1ae5eb1..41e79cb 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
@@ -1949,11 +1950,11 @@ static u64 make_cookie(u64 index, u64 pgsz_code, u64 page_offset)
 static struct ldc_mtable_entry *alloc_npages(struct ldc_iommu *iommu,
 					     unsigned long npages)
 {
-	long entry;
+	dma_addr_t entry;
 
 	entry = iommu_tbl_range_alloc(NULL, &iommu->iommu_map_table,
 				      npages, NULL, (unsigned long)-1, 0);
-	if (unlikely(entry < 0))
+	if (unlikely(entry = DMA_ERROR_CODE))
 		return NULL;
 
 	return iommu->page_table + entry;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index d2fe57d..f86902f 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -136,7 +136,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	struct iommu *iommu;
 	struct page *page;
 	void *ret;
-	long entry;
+	dma_addr_t entry;
 	int nid;
 
 	size = IO_PAGE_ALIGN(size);
@@ -242,7 +242,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	unsigned long i, base_paddr;
 	u32 bus_addr, ret;
 	unsigned long prot;
-	long entry;
+	dma_addr_t entry;
 
 	iommu = dev->archdata.iommu;
 
@@ -361,7 +361,8 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
 	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
-		unsigned long paddr, npages, entry, out_entry = 0, slen;
+		unsigned long paddr, npages, slen;
+		dma_addr_t entry, out_entry = 0;
 
 		slen = s->length;
 		/* Sanity check */
-- 
2.5.1

