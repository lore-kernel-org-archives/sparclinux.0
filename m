From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 17 Apr 2015 02:28:04 +0000
Subject: [PATCH] iommu-common: Fix PARISC compile-time warnings
Message-Id: <20150417022804.GA708@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Fixes warnings due to
- no DMA_ERROR_CODE on PARISC,
- sizeof (unsigned long) = 4 bytes on PARISC.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 lib/iommu-common.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/iommu-common.c b/lib/iommu-common.c
index 7583f9b..fac4f35 100644
--- a/lib/iommu-common.c
+++ b/lib/iommu-common.c
@@ -10,6 +10,10 @@
 #include <linux/iommu-common.h>
 #include <linux/dma-mapping.h>
 
+#ifndef	DMA_ERROR_CODE
+#define	DMA_ERROR_CODE (~(dma_addr_t)0x0)
+#endif
+
 #define IOMMU_LARGE_ALLOC	15
 
 /*
@@ -121,7 +125,7 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
 				      1 << iommu->page_table_shift);
 	else
-		boundary_size = ALIGN(1UL << 32, 1 << iommu->page_table_shift);
+		boundary_size = ALIGN(1ULL << 32, 1 << iommu->page_table_shift);
 
 	shift = iommu->page_table_map_base >> iommu->page_table_shift;
 	boundary_size = boundary_size >> iommu->page_table_shift;
-- 
1.7.1

