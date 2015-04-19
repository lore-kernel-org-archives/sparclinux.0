From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 19 Apr 2015 17:13:31 +0000
Subject: [PATCH 2/2] iommu-common: rename iommu_pool_hash to iommu_hash_common
Message-Id: <b170eb1ca5dbe92a4f4dd0ac7e0c3e84a6e14464.1429458174.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1429458174.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1429458174.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net, linux@roeck-us.net, sowmini.varadhan@oracle.com, linux-kernel@vger.kernel.org

When CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set, the DEFINE_PER_CPU_SECTION
macro will define an extern __pcpu_unique_##name variable that could
conflict with the same definition in powerpc at this time. Avoid that
conflict by renaming iommu_pool_hash in iommu-common.c

Thanks to Guenter Roeck for catching this, and helping to test the fix.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 lib/iommu-common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/iommu-common.c b/lib/iommu-common.c
index a9a53f5..df30632 100644
--- a/lib/iommu-common.c
+++ b/lib/iommu-common.c
@@ -17,7 +17,7 @@
 
 static unsigned long iommu_large_alloc = 15;
 
-static	DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
+static	DEFINE_PER_CPU(unsigned int, iommu_hash_common);
 
 static inline bool need_flush(struct iommu_map_table *iommu)
 {
@@ -44,7 +44,7 @@ static void setup_iommu_pool_hash(void)
 		return;
 	do_once = true;
 	for_each_possible_cpu(i)
-		per_cpu(iommu_pool_hash, i) = hash_32(i, IOMMU_POOL_HASHBITS);
+		per_cpu(iommu_hash_common, i) = hash_32(i, IOMMU_POOL_HASHBITS);
 }
 
 /*
@@ -106,7 +106,7 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 				unsigned long mask,
 				unsigned int align_order)
 {
-	unsigned int pool_hash = __this_cpu_read(iommu_pool_hash);
+	unsigned int pool_hash = __this_cpu_read(iommu_hash_common);
 	unsigned long n, end, start, limit, boundary_size;
 	struct iommu_pool *pool;
 	int pass = 0;
-- 
1.7.1

