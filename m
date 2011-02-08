From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 08 Feb 2011 14:59:50 +0000
Subject: [PATCH] sparc: fix size argument to find_next_zero_bit()
Message-Id: <1297177190-1423-2-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

iommu_alloc_ctx() finds a zero bit in iommu->ctx_bitmap.  It starts
searching from iommu->ctx_lowest_free to the end of the bitmap.
But the size argument to find_next_zero_bit() in iommu_alloc_ctx()
is wrong.  It should be the bitmap size, not the maximum size to
search from the offset argument.

Fortunately iommu->ctx_lowest_free is almost unused and it will not
be more than 1. So the bug wasted only 1-bit at the end of
iommu->ctx_bitmap.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/iommu.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 47977a7..72509d0 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -255,10 +255,9 @@ static inline iopte_t *alloc_npages(struct device *dev, struct iommu *iommu,
 static int iommu_alloc_ctx(struct iommu *iommu)
 {
 	int lowest = iommu->ctx_lowest_free;
-	int sz = IOMMU_NUM_CTXS - lowest;
-	int n = find_next_zero_bit(iommu->ctx_bitmap, sz, lowest);
+	int n = find_next_zero_bit(iommu->ctx_bitmap, IOMMU_NUM_CTXS, lowest);
 
-	if (unlikely(n = sz)) {
+	if (unlikely(n = IOMMU_NUM_CTXS)) {
 		n = find_next_zero_bit(iommu->ctx_bitmap, lowest, 1);
 		if (unlikely(n = lowest)) {
 			printk(KERN_WARNING "IOMMU: Ran out of contexts.\n");
-- 
1.7.4

