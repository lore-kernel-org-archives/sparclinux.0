From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2012 21:01:34 +0000
Subject: [PATCH] sparc32: Convert mmu_* interfaces from btfixup to method ops.
Message-Id: <20120513.170134.51396229221676970.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This set of changes displays one major danger of btfixup, interface
signatures are not always type checked fully.  As seen here the iounit
variant of the map_dma_area routine had an incorrect type for one of
it's arguments.

It turns out to be harmless in this case, but just imagine trying to
debug something involving this kind of problem.  No thanks.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h       |   39 +++++++++++++++++-----------
 arch/sparc/kernel/ioport.c         |    8 +++---
 arch/sparc/kernel/sparc_ksyms_32.c |    4 ---
 arch/sparc/mm/io-unit.c            |   23 +++++++++--------
 arch/sparc/mm/iommu.c              |   49 ++++++++++++++++++++++++++----------
 5 files changed, 79 insertions(+), 44 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index 1ef6f0b..3d434ef 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -92,21 +92,31 @@ extern int isa_dma_bridge_buggy;
 #ifdef CONFIG_SPARC32
 
 /* Routines for data transfer buffers. */
-struct page;
 struct device;
 struct scatterlist;
 
-/* These are implementations for sbus_map_sg/sbus_unmap_sg... collapse later */
-BTFIXUPDEF_CALL(__u32, mmu_get_scsi_one, struct device *, char *, unsigned long)
-BTFIXUPDEF_CALL(void,  mmu_get_scsi_sgl, struct device *, struct scatterlist *, int)
-BTFIXUPDEF_CALL(void,  mmu_release_scsi_one, struct device *, __u32, unsigned long)
-BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct device *, struct scatterlist *, int)
+struct sparc32_dma_ops {
+	__u32 (*get_scsi_one)(struct device *, char *, unsigned long);
+	void (*get_scsi_sgl)(struct device *, struct scatterlist *, int);
+	void (*release_scsi_one)(struct device *, __u32, unsigned long);
+	void (*release_scsi_sgl)(struct device *, struct scatterlist *,int);
+#ifdef CONFIG_SBUS
+	int (*map_dma_area)(struct device *, dma_addr_t *, unsigned long, unsigned long, int);
+	void (*unmap_dma_area)(struct device *, unsigned long, int);
+#endif
+};
+extern const struct sparc32_dma_ops *sparc32_dma_ops;
 
-#define mmu_get_scsi_one(dev,vaddr,len) BTFIXUP_CALL(mmu_get_scsi_one)(dev,vaddr,len)
-#define mmu_get_scsi_sgl(dev,sg,sz) BTFIXUP_CALL(mmu_get_scsi_sgl)(dev,sg,sz)
-#define mmu_release_scsi_one(dev,vaddr,len) BTFIXUP_CALL(mmu_release_scsi_one)(dev,vaddr,len)
-#define mmu_release_scsi_sgl(dev,sg,sz) BTFIXUP_CALL(mmu_release_scsi_sgl)(dev,sg,sz)
+#define mmu_get_scsi_one(dev,vaddr,len) \
+	sparc32_dma_ops->get_scsi_one(dev, vaddr, len)
+#define mmu_get_scsi_sgl(dev,sg,sz) \
+	sparc32_dma_ops->get_scsi_sgl(dev, sg, sz)
+#define mmu_release_scsi_one(dev,vaddr,len) \
+	sparc32_dma_ops->release_scsi_one(dev, vaddr,len)
+#define mmu_release_scsi_sgl(dev,sg,sz) \
+	sparc32_dma_ops->release_scsi_sgl(dev, sg, sz)
 
+#ifdef CONFIG_SBUS
 /*
  * mmu_map/unmap are provided by iommu/iounit; Invalid to call on IIep.
  *
@@ -122,11 +132,12 @@ BTFIXUPDEF_CALL(void,  mmu_release_scsi_sgl, struct device *, struct scatterlist
  * know if we are mapping RAM or I/O, so it has to be an additional argument
  * to a separate mapping function for CPU visible mappings.
  */
-BTFIXUPDEF_CALL(int, mmu_map_dma_area, struct device *, dma_addr_t *, unsigned long, unsigned long, int len)
-BTFIXUPDEF_CALL(void, mmu_unmap_dma_area, struct device *, unsigned long busa, int len)
+#define sbus_map_dma_area(dev,pba,va,a,len) \
+	sparc32_dma_ops->map_dma_area(dev, pba, va, a, len)
+#define sbus_unmap_dma_area(dev,ba,len) \
+	sparc32_dma_ops->unmap_dma_area(dev, ba, len)
+#endif /* CONFIG_SBUS */
 
-#define mmu_map_dma_area(dev,pba,va,a,len) BTFIXUP_CALL(mmu_map_dma_area)(dev,pba,va,a,len)
-#define mmu_unmap_dma_area(dev,ba,len) BTFIXUP_CALL(mmu_unmap_dma_area)(dev,ba,len)
 #endif
 
 #endif /* !(_ASM_SPARC_DMA_H) */
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 1720fc2..a2846f5 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -50,6 +50,8 @@
 #include <asm/io-unit.h>
 #include <asm/leon.h>
 
+const struct sparc32_dma_ops *sparc32_dma_ops;
+
 /* This function must make sure that caches and memory are coherent after DMA
  * On LEON systems without cache snooping it flushes the entire D-CACHE.
  */
@@ -292,13 +294,13 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 		goto err_nova;
 	}
 
-	// XXX The mmu_map_dma_area does this for us below, see comments.
+	// XXX The sbus_map_dma_area does this for us below, see comments.
 	// srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
 	/*
 	 * XXX That's where sdev would be used. Currently we load
 	 * all iommu tables with the same translations.
 	 */
-	if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
+	if (sbus_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
 		goto err_noiommu;
 
 	res->name = op->dev.of_node->name;
@@ -343,7 +345,7 @@ static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 	kfree(res);
 
 	pgv = virt_to_page(p);
-	mmu_unmap_dma_area(dev, ba, n);
+	sbus_unmap_dma_area(dev, ba, n);
 
 	__free_pages(pgv, get_order(n));
 }
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index 5cc35ba..4ad7377 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -32,10 +32,6 @@ EXPORT_SYMBOL(empty_zero_page);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(BTFIXUP_CALL(__hard_smp_processor_id));
 #endif
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_sgl));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_one));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_sgl));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_one));
 
 /* Exporting a symbol from /init/main.c */
 EXPORT_SYMBOL(saved_command_line);
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index d175c0a..eb99862 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -197,7 +197,7 @@ static void iounit_release_scsi_sgl(struct device *dev, struct scatterlist *sg,
 }
 
 #ifdef CONFIG_SBUS
-static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va, __u32 addr, int len)
+static int iounit_map_dma_area(struct device *dev, dma_addr_t *pba, unsigned long va, unsigned long addr, int len)
 {
 	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long page, end;
@@ -242,15 +242,18 @@ static void iounit_unmap_dma_area(struct device *dev, unsigned long addr, int le
 }
 #endif
 
-void __init ld_mmu_iounit(void)
-{
-	BTFIXUPSET_CALL(mmu_get_scsi_one, iounit_get_scsi_one, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_get_scsi_sgl, iounit_get_scsi_sgl, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_release_scsi_one, iounit_release_scsi_one, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_release_scsi_sgl, iounit_release_scsi_sgl, BTFIXUPCALL_NORM);
-
+static const struct sparc32_dma_ops iounit_dma_ops = {
+	.get_scsi_one		= iounit_get_scsi_one,
+	.get_scsi_sgl		= iounit_get_scsi_sgl,
+	.release_scsi_one	= iounit_release_scsi_one,
+	.release_scsi_sgl	= iounit_release_scsi_sgl,
 #ifdef CONFIG_SBUS
-	BTFIXUPSET_CALL(mmu_map_dma_area, iounit_map_dma_area, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_unmap_dma_area, iounit_unmap_dma_area, BTFIXUPCALL_NORM);
+	.map_dma_area		= iounit_map_dma_area,
+	.unmap_dma_area		= iounit_unmap_dma_area,
 #endif
+};
+
+void __init ld_mmu_iounit(void)
+{
+	sparc32_dma_ops = &iounit_dma_ops;
 }
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 349ba83..c64f81e 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -426,29 +426,52 @@ static void iommu_unmap_dma_area(struct device *dev, unsigned long busa, int len
 }
 #endif
 
+static const struct sparc32_dma_ops iommu_dma_noflush_ops = {
+	.get_scsi_one		= iommu_get_scsi_one_noflush,
+	.get_scsi_sgl		= iommu_get_scsi_sgl_noflush,
+	.release_scsi_one	= iommu_release_scsi_one,
+	.release_scsi_sgl	= iommu_release_scsi_sgl,
+#ifdef CONFIG_SBUS
+	.map_dma_area		= iommu_map_dma_area,
+	.unmap_dma_area		= iommu_unmap_dma_area,
+#endif
+};
+
+static const struct sparc32_dma_ops iommu_dma_gflush_ops = {
+	.get_scsi_one		= iommu_get_scsi_one_gflush,
+	.get_scsi_sgl		= iommu_get_scsi_sgl_gflush,
+	.release_scsi_one	= iommu_release_scsi_one,
+	.release_scsi_sgl	= iommu_release_scsi_sgl,
+#ifdef CONFIG_SBUS
+	.map_dma_area		= iommu_map_dma_area,
+	.unmap_dma_area		= iommu_unmap_dma_area,
+#endif
+};
+
+static const struct sparc32_dma_ops iommu_dma_pflush_ops = {
+	.get_scsi_one		= iommu_get_scsi_one_pflush,
+	.get_scsi_sgl		= iommu_get_scsi_sgl_pflush,
+	.release_scsi_one	= iommu_release_scsi_one,
+	.release_scsi_sgl	= iommu_release_scsi_sgl,
+#ifdef CONFIG_SBUS
+	.map_dma_area		= iommu_map_dma_area,
+	.unmap_dma_area		= iommu_unmap_dma_area,
+#endif
+};
+
 void __init ld_mmu_iommu(void)
 {
 	viking_flush = (BTFIXUPVAL_CALL(flush_page_for_dma) = (unsigned long)viking_flush_page);
 
 	if (!BTFIXUPVAL_CALL(flush_page_for_dma)) {
 		/* IO coherent chip */
-		BTFIXUPSET_CALL(mmu_get_scsi_one, iommu_get_scsi_one_noflush, BTFIXUPCALL_RETO0);
-		BTFIXUPSET_CALL(mmu_get_scsi_sgl, iommu_get_scsi_sgl_noflush, BTFIXUPCALL_NORM);
+		sparc32_dma_ops = &iommu_dma_noflush_ops;
 	} else if (flush_page_for_dma_global) {
 		/* flush_page_for_dma flushes everything, no matter of what page is it */
-		BTFIXUPSET_CALL(mmu_get_scsi_one, iommu_get_scsi_one_gflush, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(mmu_get_scsi_sgl, iommu_get_scsi_sgl_gflush, BTFIXUPCALL_NORM);
+		sparc32_dma_ops = &iommu_dma_gflush_ops;
 	} else {
-		BTFIXUPSET_CALL(mmu_get_scsi_one, iommu_get_scsi_one_pflush, BTFIXUPCALL_NORM);
-		BTFIXUPSET_CALL(mmu_get_scsi_sgl, iommu_get_scsi_sgl_pflush, BTFIXUPCALL_NORM);
+		sparc32_dma_ops = &iommu_dma_pflush_ops;
 	}
-	BTFIXUPSET_CALL(mmu_release_scsi_one, iommu_release_scsi_one, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_release_scsi_sgl, iommu_release_scsi_sgl, BTFIXUPCALL_NORM);
-
-#ifdef CONFIG_SBUS
-	BTFIXUPSET_CALL(mmu_map_dma_area, iommu_map_dma_area, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(mmu_unmap_dma_area, iommu_unmap_dma_area, BTFIXUPCALL_NORM);
-#endif
 
 	if (viking_mxcc_present || srmmu_modtype = HyperSparc) {
 		dvma_prot = __pgprot(SRMMU_CACHE | SRMMU_ET_PTE | SRMMU_PRIV);
-- 
1.7.10

