From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 05:15:28 +0000
Subject: [PATCH 02/13] iommu-helper: unexport iommu_area_alloc
Message-Id: <20180425051539.1989-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180425051539.1989-1-hch@lst.de>
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This function is only used by built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 lib/iommu-helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index 23633c0fda4a..ded1703e7e64 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -3,7 +3,6 @@
  * IOMMU helper functions for the free area management
  */
 
-#include <linux/export.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 
@@ -38,4 +37,3 @@ unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
 	}
 	return -1;
 }
-EXPORT_SYMBOL(iommu_area_alloc);
-- 
2.17.0

