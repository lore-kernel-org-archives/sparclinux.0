From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:07 +0000
Subject: [PATCH 02/34] sparc32: fix remaining sparse warnings in iommu.c + io-unit.c
Message-Id: <1399157559-19901-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
iommu.c:69:21: warning: incorrect type in assignment (different address spaces)
io-unit.c:56:13: warning: incorrect type in assignment (different address spaces)
io-unit.c:256:13: warning: symbol 'ld_mmu_iounit' was not declared. Should it be static?

Add proper __iomem annotation for pointers obtained via of_ioremap()
Use sbus_xxx helpers when reading/writing from/to the pointers
Add include of mm_32.h to see prototype

This drops one use of iopte_val() - which anyway evaluate to
nothing when we do not enable  STRICT_MM_TYPECHECKS.
Enabling STRICT_MM_TYPECHECKS resulted in several build failures
so this is not a big loose.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io-unit.h  |  2 +-
 arch/sparc/include/asm/iommu_32.h | 10 +++++-----
 arch/sparc/mm/io-unit.c           | 21 ++++++++++++---------
 arch/sparc/mm/iommu.c             | 20 +++++++++++++-------
 4 files changed, 31 insertions(+), 22 deletions(-)

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
diff --git a/arch/sparc/include/asm/iommu_32.h b/arch/sparc/include/asm/iommu_32.h
index 70c589c..f6c066b 100644
--- a/arch/sparc/include/asm/iommu_32.h
+++ b/arch/sparc/include/asm/iommu_32.h
@@ -99,7 +99,7 @@ struct iommu_regs {
 #define IOPTE_WAZ           0x00000001 /* Write as zeros */
 
 struct iommu_struct {
-	struct iommu_regs *regs;
+	struct iommu_regs __iomem *regs;
 	iopte_t *page_table;
 	/* For convenience */
 	unsigned long start; /* First managed virtual address */
@@ -108,14 +108,14 @@ struct iommu_struct {
 	struct bit_map usemap;
 };
 
-static inline void iommu_invalidate(struct iommu_regs *regs)
+static inline void iommu_invalidate(struct iommu_regs __iomem *regs)
 {
-	regs->tlbflush = 0;
+	sbus_writel(0, &regs->tlbflush);
 }
 
-static inline void iommu_invalidate_page(struct iommu_regs *regs, unsigned long ba)
+static inline void iommu_invalidate_page(struct iommu_regs __iomem *regs, unsigned long ba)
 {
-	regs->pageflush = (ba & PAGE_MASK);
+	sbus_writel(ba & PAGE_MASK, &regs->pageflush);
 }
 
 #endif /* !(_SPARC_IOMMU_H) */
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
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 35384cb..2785ff88 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -58,6 +58,8 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	struct iommu_struct *iommu;
 	unsigned int impl, vers;
 	unsigned long *bitmap;
+	unsigned long control;
+	unsigned long base;
 	unsigned long tmp;
 
 	iommu = kmalloc(sizeof(struct iommu_struct), GFP_KERNEL);
@@ -72,12 +74,14 @@ static void __init sbus_iommu_init(struct platform_device *op)
 		prom_printf("Cannot map IOMMU registers\n");
 		prom_halt();
 	}
-	impl = (iommu->regs->control & IOMMU_CTRL_IMPL) >> 28;
-	vers = (iommu->regs->control & IOMMU_CTRL_VERS) >> 24;
-	tmp = iommu->regs->control;
-	tmp &= ~(IOMMU_CTRL_RNGE);
-	tmp |= (IOMMU_RNGE_256MB | IOMMU_CTRL_ENAB);
-	iommu->regs->control = tmp;
+
+	control = sbus_readl(&iommu->regs->control);
+	impl = (control & IOMMU_CTRL_IMPL) >> 28;
+	vers = (control & IOMMU_CTRL_VERS) >> 24;
+	control &= ~(IOMMU_CTRL_RNGE);
+	control |= (IOMMU_RNGE_256MB | IOMMU_CTRL_ENAB);
+	sbus_writel(control, iommu->regs);
+
 	iommu_invalidate(iommu->regs);
 	iommu->start = IOMMU_START;
 	iommu->end = 0xffffffff;
@@ -99,7 +103,9 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	memset(iommu->page_table, 0, IOMMU_NPTES*sizeof(iopte_t));
 	flush_cache_all();
 	flush_tlb_all();
-	iommu->regs->base = __pa((unsigned long) iommu->page_table) >> 4;
+
+	base = __pa((unsigned long) iommu->page_table) >> 4;
+	sbus_writel(base, &iommu->regs->base);
 	iommu_invalidate(iommu->regs);
 
 	bitmap = kmalloc(IOMMU_NPTES>>3, GFP_KERNEL);
-- 
1.9.0

