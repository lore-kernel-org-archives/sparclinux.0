From: Bob Breuer <breuerr@mc.net>
Date: Tue, 20 Jun 2006 04:08:59 +0000
Subject: [PATCH] sparc32: fix iommu_flush_iotlb end address
Message-Id: <449774DB.6090201@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000303020107050908040802"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303020107050908040802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fix the calculation of the end address when flushing iotlb entries to
ram.  This bug has been a cause of esp dma errors, and it affects
HyperSPARC systems much worse than SuperSPARC systems.

Signed-off-by: Bob Breuer <breuerr@mc.net>
---

Just in case it's not obvious from the patch as to how the dma was
broken:  Each dma mapping sets up iopte entries for the iommu, and the
iommu only looks in main memory for the iopte entries.  If there is a
group of iopte entries that are smaller than a page in size, but
straddle a page boundary, the broken code would fail to flush the last
page to ram.

Bob


--------------000303020107050908040802
Content-Type: text/plain;
 name="sparc32-fix-flush_iotlb_end.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-fix-flush_iotlb_end.patch.txt"

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 77840c8..7215849 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -144,8 +144,9 @@ static void iommu_flush_iotlb(iopte_t *i
 	unsigned long start;
 	unsigned long end;
 
-	start = (unsigned long)iopte & PAGE_MASK;
+	start = (unsigned long)iopte;
 	end = PAGE_ALIGN(start + niopte*sizeof(iopte_t));
+	start &= PAGE_MASK;
 	if (viking_mxcc_present) {
 		while(start < end) {
 			viking_mxcc_flush_page(start);

--------------000303020107050908040802--
