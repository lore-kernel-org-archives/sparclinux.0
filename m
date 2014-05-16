From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:40 +0000
Subject: [PATCH 02/34] sparc32: fix sparse warning in iommu.c
Message-Id: <1400275572-17424-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
iommu.c:69:21: warning: incorrect type in assignment (different address spaces)

iommu_struct.regs is __iomem - fix up all users.
Introduce sbus operations for all read/write operations.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/iommu_32.h | 10 +++++-----
 arch/sparc/mm/iommu.c             | 20 +++++++++++++-------
 2 files changed, 18 insertions(+), 12 deletions(-)

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
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 35384cb..491511d 100644
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
+	sbus_writel(control, &iommu->regs->control);
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
+	base = __pa((unsigned long)iommu->page_table) >> 4;
+	sbus_writel(base, &iommu->regs->base);
 	iommu_invalidate(iommu->regs);
 
 	bitmap = kmalloc(IOMMU_NPTES>>3, GFP_KERNEL);
-- 
1.9.0

