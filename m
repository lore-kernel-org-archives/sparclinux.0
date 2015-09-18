From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 18 Sep 2015 09:09:35 +0000
Subject: [PATCH] iommu-common: fix return type of iommu_tbl_range_alloc()
Message-Id: <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55FBD36C.5070301@arm.com>
In-Reply-To: <55FBD36C.5070301@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Though iommu_tbl_range_alloc() is only used by Sparc code, the
function itself lives in lib/iommu-common.c and is thus included in
other architecture's code as well.
When compiled on a 32-bit architecture using 64-bit DMA addresses
(ARM with LPAE), there is a compiler warning about a type mismatch
between dma_addr_t and the return type of this function:

In file included from /src/linux/include/linux/dma-mapping.h:86:0,
                 from /src/linux/lib/iommu-common.c:11:
/src/linux/lib/iommu-common.c: In function 'iommu_tbl_range_alloc':
/src/linux/arch/arm/include/asm/dma-mapping.h:16:24: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
                        ^
/src/linux/lib/iommu-common.c:127:10: note: in expansion of macro
'DMA_ERROR_CODE'
   return DMA_ERROR_CODE;

If I am not mistaken, dma_addr_t on both Sparc variants is always
32-bit, so we don't need necessarily to adjust the callers, just the
function itself.
This still isn't right (since now the types in the caller mismatch,
though in a different way the compiler does not complain about), but
works as a fix for the 4.3 release. I couldn't spot any warnings on
the architectures I managed to compile.

Compile tested on Sparc, Sparc64, PowerPC64, ARM, ARM64, x86.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/linux/iommu-common.h | 12 ++++++------
 lib/iommu-common.c           | 15 ++++++++-------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/iommu-common.h b/include/linux/iommu-common.h
index bbced83..fdff585 100644
--- a/include/linux/iommu-common.h
+++ b/include/linux/iommu-common.h
@@ -37,12 +37,12 @@ extern void iommu_tbl_pool_init(struct iommu_map_table *iommu,
 				bool large_pool, u32 npools,
 				bool skip_span_boundary_check);
 
-extern unsigned long iommu_tbl_range_alloc(struct device *dev,
-					   struct iommu_map_table *iommu,
-					   unsigned long npages,
-					   unsigned long *handle,
-					   unsigned long mask,
-					   unsigned int align_order);
+extern dma_addr_t iommu_tbl_range_alloc(struct device *dev,
+					struct iommu_map_table *iommu,
+					unsigned long npages,
+					unsigned long *handle,
+					unsigned long mask,
+					unsigned int align_order);
 
 extern void iommu_tbl_range_free(struct iommu_map_table *iommu,
 				 u64 dma_addr, unsigned long npages,
diff --git a/lib/iommu-common.c b/lib/iommu-common.c
index ff19f66..6f0324e 100644
--- a/lib/iommu-common.c
+++ b/lib/iommu-common.c
@@ -99,15 +99,16 @@ void iommu_tbl_pool_init(struct iommu_map_table *iommu,
 }
 EXPORT_SYMBOL(iommu_tbl_pool_init);
 
-unsigned long iommu_tbl_range_alloc(struct device *dev,
-				struct iommu_map_table *iommu,
-				unsigned long npages,
-				unsigned long *handle,
-				unsigned long mask,
-				unsigned int align_order)
+dma_addr_t iommu_tbl_range_alloc(struct device *dev,
+				 struct iommu_map_table *iommu,
+				 unsigned long npages,
+				 unsigned long *handle,
+				 unsigned long mask,
+				 unsigned int align_order)
 {
 	unsigned int pool_hash = __this_cpu_read(iommu_hash_common);
-	unsigned long n, end, start, limit, boundary_size;
+	dma_addr_t n;
+	unsigned long end, start, limit, boundary_size;
 	struct iommu_pool *pool;
 	int pass = 0;
 	unsigned int pool_nr;
-- 
2.5.1

