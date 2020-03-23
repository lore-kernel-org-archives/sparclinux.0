From: Christoph Hellwig <hch@lst.de>
Date: Mon, 23 Mar 2020 08:43:42 +0000
Subject: [PATCH] sparc32: use per-device dma_ops
Message-Id: <20200323084342.27880-1-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc32 is the last platform making dynamic decisions in
get_arch_dma_ops based on the bus passed in.  Instead set the
iommu dma_ops at iommu probing and propagate them in
of_propagate_archdata, falling back to the NULL ops for the
direct mapping in the Leon or PCI case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/dma-mapping.h | 15 ++-------------
 arch/sparc/kernel/ioport.c           |  3 ---
 arch/sparc/kernel/of_device_common.c |  1 +
 arch/sparc/mm/io-unit.c              |  9 ++++-----
 arch/sparc/mm/iommu.c                | 15 ++++++++-------
 arch/sparc/mm/mm_32.h                |  3 ---
 arch/sparc/mm/srmmu.c                |  4 +---
 7 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index ed32845bd2d2..2f051343612e 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -2,23 +2,12 @@
 #ifndef ___ASM_SPARC_DMA_MAPPING_H
 #define ___ASM_SPARC_DMA_MAPPING_H
 
-#include <asm/cpu_type.h>
-
 extern const struct dma_map_ops *dma_ops;
 
-extern struct bus_type pci_bus_type;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-#ifdef CONFIG_SPARC_LEON
-	if (sparc_cpu_model = sparc_leon)
-		return NULL;
-#endif
-#if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
-	if (bus = &pci_bus_type)
-		return NULL;
-#endif
-	return dma_ops;
+	/* sparc32 uses per-device dma_ops */
+	return IS_ENABLED(CONFIG_SPARC64) ? dma_ops : NULL;
 }
 
 #endif
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index e59461d03b9a..d6874c9b639f 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -373,9 +373,6 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		dma_make_coherent(paddr, PAGE_ALIGN(size));
 }
 
-const struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 #ifdef CONFIG_PROC_FS
 
 static int sparc_io_proc_show(struct seq_file *m, void *v)
diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index b32cc5610712..e717a56efc5d 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -67,6 +67,7 @@ void of_propagate_archdata(struct platform_device *bus)
 		op->dev.archdata.stc = bus_sd->stc;
 		op->dev.archdata.host_controller = bus_sd->host_controller;
 		op->dev.archdata.numa_node = bus_sd->numa_node;
+		op->dev.dma_ops = bus->dev.dma_ops;
 
 		if (dp->child)
 			of_propagate_archdata(op);
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 33a0facd9eb5..289276b99b01 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -38,6 +38,8 @@
 #define IOPERM        (IOUPTE_CACHE | IOUPTE_WRITE | IOUPTE_VALID)
 #define MKIOPTE(phys) __iopte((((phys)>>4) & IOUPTE_PAGE) | IOPERM)
 
+static const struct dma_map_ops iounit_dma_ops;
+
 static void __init iounit_iommu_init(struct platform_device *op)
 {
 	struct iounit_struct *iounit;
@@ -70,6 +72,8 @@ static void __init iounit_iommu_init(struct platform_device *op)
 	xptend = iounit->page_table + (16 * PAGE_SIZE) / sizeof(iopte_t);
 	for (; xpt < xptend; xpt++)
 		sbus_writel(0, xpt);
+
+	op->dev.dma_ops = &iounit_dma_ops;
 }
 
 static int __init iounit_init(void)
@@ -288,8 +292,3 @@ static const struct dma_map_ops iounit_dma_ops = {
 	.map_sg			= iounit_map_sg,
 	.unmap_sg		= iounit_unmap_sg,
 };
-
-void __init ld_mmu_iounit(void)
-{
-	dma_ops = &iounit_dma_ops;
-}
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 4d3c6991f0ae..b00dde13681b 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -54,6 +54,9 @@ static pgprot_t dvma_prot;		/* Consistent mapping pte flags */
 #define IOPERM        (IOPTE_CACHE | IOPTE_WRITE | IOPTE_VALID)
 #define MKIOPTE(pfn, perm) (((((pfn)<<8) & IOPTE_PAGE) | (perm)) & ~IOPTE_WAZ)
 
+static const struct dma_map_ops sbus_iommu_dma_gflush_ops;
+static const struct dma_map_ops sbus_iommu_dma_pflush_ops;
+
 static void __init sbus_iommu_init(struct platform_device *op)
 {
 	struct iommu_struct *iommu;
@@ -129,6 +132,11 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	       (int)(IOMMU_NPTES*sizeof(iopte_t)), (int)IOMMU_NPTES);
 
 	op->dev.archdata.iommu = iommu;
+
+	if (flush_page_for_dma_global)
+		op->dev.dma_ops = &sbus_iommu_dma_gflush_ops;
+	 else
+		op->dev.dma_ops = &sbus_iommu_dma_pflush_ops;
 }
 
 static int __init iommu_init(void)
@@ -445,13 +453,6 @@ static const struct dma_map_ops sbus_iommu_dma_pflush_ops = {
 
 void __init ld_mmu_iommu(void)
 {
-	if (flush_page_for_dma_global) {
-		/* flush_page_for_dma flushes everything, no matter of what page is it */
-		dma_ops = &sbus_iommu_dma_gflush_ops;
-	} else {
-		dma_ops = &sbus_iommu_dma_pflush_ops;
-	}
-
 	if (viking_mxcc_present || srmmu_modtype = HyperSparc) {
 		dvma_prot = __pgprot(SRMMU_CACHE | SRMMU_ET_PTE | SRMMU_PRIV);
 		ioperm_noc = IOPTE_CACHE | IOPTE_WRITE | IOPTE_VALID;
diff --git a/arch/sparc/mm/mm_32.h b/arch/sparc/mm/mm_32.h
index 0d0b06e952a5..ce750a99eea9 100644
--- a/arch/sparc/mm/mm_32.h
+++ b/arch/sparc/mm/mm_32.h
@@ -20,6 +20,3 @@ void __init srmmu_paging_init(void);
 
 /* iommu.c */
 void ld_mmu_iommu(void);
-
-/* io-unit.c */
-void ld_mmu_iounit(void);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f56c3c9a9793..b7c94de70cca 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1865,9 +1865,7 @@ void __init load_mmu(void)
 		&smp_cachetlb_ops;
 #endif
 
-	if (sparc_cpu_model = sun4d)
-		ld_mmu_iounit();
-	else
+	if (sparc_cpu_model != sun4d)
 		ld_mmu_iommu();
 #ifdef CONFIG_SMP
 	if (sparc_cpu_model = sun4d)
-- 
2.25.1
