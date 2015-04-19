From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 19 Apr 2015 17:13:30 +0000
Subject: [PATCH 1/2] iommu-common: fix x86_64 compiler warnings
Message-Id: <3169f099e5811c8f77813b0fa8c9a12e1d5314c0.1429458174.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1429458174.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1429458174.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net, linux@roeck-us.net, sowmini.varadhan@oracle.com, linux-kernel@vger.kernel.org

Declare iommu_large_alloc as static. Remove extern definition  for
iommu_tbl_pool_init().

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 lib/iommu-common.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/iommu-common.c b/lib/iommu-common.c
index a1a517c..a9a53f5 100644
--- a/lib/iommu-common.c
+++ b/lib/iommu-common.c
@@ -15,7 +15,7 @@
 #define	DMA_ERROR_CODE (~(dma_addr_t)0x0)
 #endif
 
-unsigned long iommu_large_alloc = 15;
+static unsigned long iommu_large_alloc = 15;
 
 static	DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
 
@@ -53,12 +53,12 @@ static void setup_iommu_pool_hash(void)
  * the top 1/4 of the table will be set aside for pool allocations
  * of more than iommu_large_alloc pages.
  */
-extern void iommu_tbl_pool_init(struct iommu_map_table *iommu,
-				unsigned long num_entries,
-				u32 table_shift,
-				void (*lazy_flush)(struct iommu_map_table *),
-				bool large_pool, u32 npools,
-				bool skip_span_boundary_check)
+void iommu_tbl_pool_init(struct iommu_map_table *iommu,
+			 unsigned long num_entries,
+			 u32 table_shift,
+			 void (*lazy_flush)(struct iommu_map_table *),
+			 bool large_pool, u32 npools,
+			 bool skip_span_boundary_check)
 {
 	unsigned int start, i;
 	struct iommu_pool *p = &(iommu->large_pool);
-- 
1.7.1

