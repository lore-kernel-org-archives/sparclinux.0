From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 21:03:44 +0000
Subject: [PATCH 1/4] sparc: drop ifdef CONFIG_SBUS in arch/sparc - SBUS is always defined
Message-Id: <1294261427-26104-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Noticed by: Kristoffer Glembo <kristoffer@gaisler.com>

Cc: Kristoffer Glembo <kristoffer@gaisler.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/ioport.c        |    4 ----
 arch/sparc/kernel/prom_irqtrans.c |    5 -----
 arch/sparc/mm/io-unit.c           |    4 ----
 arch/sparc/mm/iommu.c             |    4 ----
 4 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 41f7e4e..ee21708 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -237,8 +237,6 @@ static void _sparc_free_io(struct resource *res)
 	release_resource(res);
 }
 
-#ifdef CONFIG_SBUS
-
 void sbus_set_sbus64(struct device *dev, int x)
 {
 	printk("sbus_set_sbus64: unsupported\n");
@@ -420,8 +418,6 @@ static int __init sparc_register_ioport(void)
 
 arch_initcall(sparc_register_ioport);
 
-#endif /* CONFIG_SBUS */
-
 #ifdef CONFIG_PCI
 
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index ce65114..bfbcd20 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -556,7 +556,6 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 }
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_SBUS
 /* INO number to IMAP register offset for SYSIO external IRQ's.
  * This should conform to both Sunfire/Wildfire server and Fusion
  * desktop designs.
@@ -711,8 +710,6 @@ static void __init sbus_irq_trans_init(struct device_node *dp)
 	regs = of_get_property(dp, "reg", NULL);
 	dp->irq_trans->data = (void *) (unsigned long) regs->phys_addr;
 }
-#endif /* CONFIG_SBUS */
-
 
 static unsigned int central_build_irq(struct device_node *dp,
 				      unsigned int ino,
@@ -822,13 +819,11 @@ void __init irq_trans_init(struct device_node *dp)
 		}
 	}
 #endif
-#ifdef CONFIG_SBUS
 	if (!strcmp(dp->name, "sbus") ||
 	    !strcmp(dp->name, "sbi")) {
 		sbus_irq_trans_init(dp);
 		return;
 	}
-#endif
 	if (!strcmp(dp->name, "fhc") &&
 	    !strcmp(dp->parent->name, "central")) {
 		central_irq_trans_init(dp);
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index fc58c3e..27eb5b4 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -196,7 +196,6 @@ static void iounit_release_scsi_sgl(struct device *dev, struct scatterlist *sg,
 	spin_unlock_irqrestore(&iounit->lock, flags);
 }
 
-#ifdef CONFIG_SBUS
 static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va, __u32 addr, int len)
 {
 	struct iounit_struct *iounit = dev->archdata.iommu;
@@ -240,7 +239,6 @@ static void iounit_unmap_dma_area(struct device *dev, unsigned long addr, int le
 {
 	/* XXX Somebody please fill this in */
 }
-#endif
 
 static char *iounit_lockarea(char *vaddr, unsigned long len)
 {
@@ -263,8 +261,6 @@ void __init ld_mmu_iounit(void)
 	BTFIXUPSET_CALL(mmu_release_scsi_one, iounit_release_scsi_one, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_release_scsi_sgl, iounit_release_scsi_sgl, BTFIXUPCALL_NORM);
 
-#ifdef CONFIG_SBUS
 	BTFIXUPSET_CALL(mmu_map_dma_area, iounit_map_dma_area, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_unmap_dma_area, iounit_unmap_dma_area, BTFIXUPCALL_NORM);
-#endif
 }
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 07fc6a6..a9f4108 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -336,7 +336,6 @@ static void iommu_release_scsi_sgl(struct device *dev, struct scatterlist *sg, i
 	}
 }
 
-#ifdef CONFIG_SBUS
 static int iommu_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va,
 			      unsigned long addr, int len)
 {
@@ -424,7 +423,6 @@ static void iommu_unmap_dma_area(struct device *dev, unsigned long busa, int len
 	iommu_invalidate(iommu->regs);
 	bit_map_clear(&iommu->usemap, ioptex, len >> PAGE_SHIFT);
 }
-#endif
 
 static char *iommu_lockarea(char *vaddr, unsigned long len)
 {
@@ -456,10 +454,8 @@ void __init ld_mmu_iommu(void)
 	BTFIXUPSET_CALL(mmu_release_scsi_one, iommu_release_scsi_one, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_release_scsi_sgl, iommu_release_scsi_sgl, BTFIXUPCALL_NORM);
 
-#ifdef CONFIG_SBUS
 	BTFIXUPSET_CALL(mmu_map_dma_area, iommu_map_dma_area, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_unmap_dma_area, iommu_unmap_dma_area, BTFIXUPCALL_NORM);
-#endif
 
 	if (viking_mxcc_present || srmmu_modtype = HyperSparc) {
 		dvma_prot = __pgprot(SRMMU_CACHE | SRMMU_ET_PTE | SRMMU_PRIV);
-- 
1.6.0.6

