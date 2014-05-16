From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:41 +0000
Subject: [PATCH 03/34] sparc32: fix sparse warning in io-unit.c
Message-Id: <1400275572-17424-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
io-unit.c:56:13: warning: incorrect type in assignment (different address spaces)

The page table for the io unit resides in __iomem.
Fix up all users of the io unit page table.
Introduce sbus helers for all read/write operations.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io-unit.h |  2 +-
 arch/sparc/mm/io-unit.c          | 21 ++++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/io-unit.h b/arch/sparc/include/asm/io-unit.h
index 01ab2f6..04a9701 100644
--- a/arch/sparc/include/asm/io-unit.h
+++ b/arch/sparc/include/asm/io-unit.h
@@ -43,7 +43,7 @@
 struct iounit_struct {
 	unsigned long		bmap[(IOUNIT_DMA_SIZE >> (PAGE_SHIFT + 3)) / sizeof(unsigned long)];
 	spinlock_t		lock;
-	iopte_t			*page_table;
+	iopte_t __iomem		*page_table;
 	unsigned long		rotor[3];
 	unsigned long		limit[4];
 };
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index eb99862..f311bf2 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -25,6 +25,8 @@
 #include <asm/dma.h>
 #include <asm/oplib.h>
 
+#include "mm_32.h"
+
 /* #define IOUNIT_DEBUG */
 #ifdef IOUNIT_DEBUG
 #define IOD(x) printk(x)
@@ -38,7 +40,8 @@
 static void __init iounit_iommu_init(struct platform_device *op)
 {
 	struct iounit_struct *iounit;
-	iopte_t *xpt, *xptend;
+	iopte_t __iomem *xpt;
+	iopte_t __iomem *xptend;
 
 	iounit = kzalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
 	if (!iounit) {
@@ -62,10 +65,10 @@ static void __init iounit_iommu_init(struct platform_device *op)
 	op->dev.archdata.iommu = iounit;
 	iounit->page_table = xpt;
 	spin_lock_init(&iounit->lock);
-	
-	for (xptend = iounit->page_table + (16 * PAGE_SIZE) / sizeof(iopte_t);
-	     xpt < xptend;)
-	     	iopte_val(*xpt++) = 0;
+
+	xptend = iounit->page_table + (16 * PAGE_SIZE) / sizeof(iopte_t);
+	for (; xpt < xptend; xpt++)
+		sbus_writel(0, xpt);
 }
 
 static int __init iounit_init(void)
@@ -130,7 +133,7 @@ nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
 	vaddr = IOUNIT_DMA_BASE + (scan << PAGE_SHIFT) + (vaddr & ~PAGE_MASK);
 	for (k = 0; k < npages; k++, iopte = __iopte(iopte_val(iopte) + 0x100), scan++) {
 		set_bit(scan, iounit->bmap);
-		iounit->page_table[scan] = iopte;
+		sbus_writel(iopte, &iounit->page_table[scan]);
 	}
 	IOD(("%08lx\n", vaddr));
 	return vaddr;
@@ -202,7 +205,7 @@ static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned lon
 	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long page, end;
 	pgprot_t dvma_prot;
-	iopte_t *iopte;
+	iopte_t __iomem *iopte;
 
 	*pba = addr;
 
@@ -224,8 +227,8 @@ static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned lon
 			
 			i = ((addr - IOUNIT_DMA_BASE) >> PAGE_SHIFT);
 
-			iopte = (iopte_t *)(iounit->page_table + i);
-			*iopte = MKIOPTE(__pa(page));
+			iopte = iounit->page_table + i;
+			sbus_writel(MKIOPTE(__pa(page)), iopte);
 		}
 		addr += PAGE_SIZE;
 		va += PAGE_SIZE;
-- 
1.9.0

