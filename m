From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 29 Mar 2013 13:44:44 +0000
Subject: [PATCH] sparc/iommu: fix typo s/265KB/256KB/
Message-Id: <1364564684-15469-2-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

IOMMU_NPTES is 64K PTEs, so the size is 256KB (= 64K * sizeof(iopte_t))

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---

This patch is extracted a comment typo fix from the patch I send:
"sparc/iommu: use BITS_TO_LONGS() to calculate bitmap size"

 arch/sparc/mm/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 0f4f719..28f96f2 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -34,7 +34,7 @@
 #define IOMMU_RNGE	IOMMU_RNGE_256MB
 #define IOMMU_START	0xF0000000
 #define IOMMU_WINSIZE	(256*1024*1024U)
-#define IOMMU_NPTES	(IOMMU_WINSIZE/PAGE_SIZE)	/* 64K PTEs, 265KB */
+#define IOMMU_NPTES	(IOMMU_WINSIZE/PAGE_SIZE)	/* 64K PTEs, 256KB */
 #define IOMMU_ORDER	6				/* 4096 * (1<<6) */
 
 /* srmmu.c */
-- 
1.8.1.4

