From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:28 +0000
Subject: [PATCH 4/49]: sparc32: Make IOMMU and IO-UNIT init work with
Message-Id: <20080827.212328.142149745.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Make IOMMU and IO-UNIT init work with device nodes.

And stick the iommu archdata pointer into the generic OF device tree
of_device struct as well.

We still have to pass the sbus_bus object down into the routines so
that the SBUS bus objects get the iommu cookies set properly.  After
drivers get converted to being pure OF drivers, that can go away.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io-unit.h  |    2 ++
 arch/sparc/include/asm/iommu_32.h |    2 ++
 arch/sparc/kernel/ioport.c        |   17 ++++++-----------
 arch/sparc/mm/io-unit.c           |   29 +++++++++++++++--------------
 arch/sparc/mm/iommu.c             |   35 ++++++++++++++++++++---------------
 5 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/arch/sparc/include/asm/io-unit.h b/arch/sparc/include/asm/io-unit.h
index 96823b4..5df63ef 100644
--- a/arch/sparc/include/asm/io-unit.h
+++ b/arch/sparc/include/asm/io-unit.h
@@ -59,4 +59,6 @@ extern __u32 iounit_map_dma_init(struct sbus_bus *, int);
 #define iounit_map_dma_finish(sbus, addr, len) mmu_release_scsi_one(addr, len, sbus)
 extern __u32 iounit_map_dma_page(__u32, void *, struct sbus_bus *);
 
+extern void iounit_init(struct sbus_bus *sbus);
+
 #endif /* !(_SPARC_IO_UNIT_H) */
diff --git a/arch/sparc/include/asm/iommu_32.h b/arch/sparc/include/asm/iommu_32.h
index 70c589c..6b115a1 100644
--- a/arch/sparc/include/asm/iommu_32.h
+++ b/arch/sparc/include/asm/iommu_32.h
@@ -118,4 +118,6 @@ static inline void iommu_invalidate_page(struct iommu_regs *regs, unsigned long
 	regs->pageflush = (ba & PAGE_MASK);
 }
 
+extern void iommu_init(struct device_node *dp, struct sbus_bus *sbus);
+
 #endif /* !(_SPARC_IOMMU_H) */
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 2a8a847..f6158c4 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -46,6 +46,8 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/dma.h>
+#include <asm/iommu.h>
+#include <asm/io-unit.h>
 
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
 
@@ -515,18 +517,11 @@ void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 
 	if (sparc_cpu_model != sun4d &&
 	    parent != NULL &&
-	    !strcmp(parent->name, "iommu")) {
-		extern void iommu_init(int iommu_node, struct sbus_bus *sbus);
+	    !strcmp(parent->name, "iommu"))
+		iommu_init(parent, sbus);
 
-		iommu_init(parent->node, sbus);
-	}
-
-	if (sparc_cpu_model = sun4d) {
-		extern void iounit_init(int sbi_node, int iounit_node,
-					struct sbus_bus *sbus);
-
-		iounit_init(dp->node, parent->node, sbus);
-	}
+	if (sparc_cpu_model = sun4d)
+		iounit_init(sbus);
 #endif
 }
 
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index f167835..1093514 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -34,13 +34,18 @@
 #define IOPERM        (IOUPTE_CACHE | IOUPTE_WRITE | IOUPTE_VALID)
 #define MKIOPTE(phys) __iopte((((phys)>>4) & IOUPTE_PAGE) | IOPERM)
 
-void __init
-iounit_init(int sbi_node, int io_node, struct sbus_bus *sbus)
+void __init iounit_init(struct sbus_bus *sbus)
 {
-	iopte_t *xpt, *xptend;
+	struct device_node *dp = sbus->ofdev.node;
 	struct iounit_struct *iounit;
-	struct linux_prom_registers iommu_promregs[PROMREG_MAX];
-	struct resource r;
+	iopte_t *xpt, *xptend;
+	struct of_device *op;
+
+	op = of_find_device_by_node(dp);
+	if (!op) {
+		prom_printf("SUN4D: Cannot find SBI of_device.\n");
+		prom_halt();
+	}
 
 	iounit = kzalloc(sizeof(struct iounit_struct), GFP_ATOMIC);
 	if (!iounit) {
@@ -55,18 +60,14 @@ iounit_init(int sbi_node, int io_node, struct sbus_bus *sbus)
 	iounit->rotor[1] = IOUNIT_BMAP2_START;
 	iounit->rotor[2] = IOUNIT_BMAPM_START;
 
-	xpt = NULL;
-	if(prom_getproperty(sbi_node, "reg", (void *) iommu_promregs,
-			    sizeof(iommu_promregs)) != -1) {
-		prom_apply_generic_ranges(io_node, 0, iommu_promregs, 3);
-		memset(&r, 0, sizeof(r));
-		r.flags = iommu_promregs[2].which_io;
-		r.start = iommu_promregs[2].phys_addr;
-		xpt = (iopte_t *) sbus_ioremap(&r, 0, PAGE_SIZE * 16, "XPT");
+	xpt = of_ioremap(&op->resource[2], 0, PAGE_SIZE * 16, "XPT");
+	if (!xpt) {
+		prom_printf("SUN4D: Cannot map External Page Table.");
+		prom_halt();
 	}
-	if(!xpt) panic("Cannot map External Page Table.");
 	
 	sbus->ofdev.dev.archdata.iommu = iounit;
+	op->dev.archdata.iommu = iounit;
 	iounit->page_table = xpt;
 	spin_lock_init(&iounit->lock);
 	
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 4b93427..a86c9f5 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -55,30 +55,34 @@ static pgprot_t dvma_prot;		/* Consistent mapping pte flags */
 #define IOPERM        (IOPTE_CACHE | IOPTE_WRITE | IOPTE_VALID)
 #define MKIOPTE(pfn, perm) (((((pfn)<<8) & IOPTE_PAGE) | (perm)) & ~IOPTE_WAZ)
 
-void __init
-iommu_init(int iommund, struct sbus_bus *sbus)
+void __init iommu_init(struct device_node *parent, struct sbus_bus *sbus)
 {
-	unsigned int impl, vers;
-	unsigned long tmp;
+	struct of_device *parent_op, *op;
 	struct iommu_struct *iommu;
-	struct linux_prom_registers iommu_promregs[PROMREG_MAX];
-	struct resource r;
+	unsigned int impl, vers;
 	unsigned long *bitmap;
+	unsigned long tmp;
+
+	parent_op = of_find_device_by_node(parent);
+	if (!parent_op) {
+		prom_printf("Unable to find IOMMU of_device\n");
+		prom_halt();
+	}
+
+	op = of_find_device_by_node(sbus->ofdev.node);
+	if (!op) {
+		prom_printf("Unable to find SBUS of_device\n");
+		prom_halt();
+	}
 
 	iommu = kmalloc(sizeof(struct iommu_struct), GFP_ATOMIC);
 	if (!iommu) {
 		prom_printf("Unable to allocate iommu structure\n");
 		prom_halt();
 	}
-	iommu->regs = NULL;
-	if (prom_getproperty(iommund, "reg", (void *) iommu_promregs,
-			 sizeof(iommu_promregs)) != -1) {
-		memset(&r, 0, sizeof(r));
-		r.flags = iommu_promregs[0].which_io;
-		r.start = iommu_promregs[0].phys_addr;
-		iommu->regs = (struct iommu_regs *)
-			sbus_ioremap(&r, 0, PAGE_SIZE * 3, "iommu_regs");
-	}
+
+	iommu->regs = of_ioremap(&parent_op->resource[0], 0, PAGE_SIZE * 3,
+				 "iommu_regs");
 	if (!iommu->regs) {
 		prom_printf("Cannot map IOMMU registers\n");
 		prom_halt();
@@ -133,6 +137,7 @@ iommu_init(int iommund, struct sbus_bus *sbus)
 	    (int)(IOMMU_NPTES*sizeof(iopte_t)), (int)IOMMU_NPTES);
 
 	sbus->ofdev.dev.archdata.iommu = iommu;
+	op->dev.archdata.iommu = iommu;
 }
 
 /* This begs to be btfixup-ed by srmmu. */
-- 
1.5.6.5.GIT

