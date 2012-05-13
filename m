From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2012 20:28:32 +0000
Subject: [PATCH] sparc: Kill mmu_{un,}lockarea().
Message-Id: <20120513.162832.471802901712883558.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


These were used on sun4c during floppy data transfers since on that
chip we had to lock the cpu mappings into the TLB because we cannot
take a TLB miss during the assembler floppy interrupt handler that
does the data transfer.

That is no longer necessary since we've removed sun4c support, thus
this stuff can disappear completely.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma.h        |    6 ------
 arch/sparc/include/asm/floppy_32.h  |    6 +-----
 arch/sparc/include/asm/floppy_64.h  |    7 ++-----
 arch/sparc/include/asm/pgtable_64.h |    4 ----
 arch/sparc/kernel/sparc_ksyms_32.c  |    2 --
 arch/sparc/mm/io-unit.c             |   14 --------------
 arch/sparc/mm/iommu.c               |   11 -----------
 7 files changed, 3 insertions(+), 47 deletions(-)

diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index 67e017f..1ef6f0b 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -92,12 +92,6 @@ extern int isa_dma_bridge_buggy;
 #ifdef CONFIG_SPARC32
 
 /* Routines for data transfer buffers. */
-BTFIXUPDEF_CALL(char *, mmu_lockarea, char *, unsigned long)
-BTFIXUPDEF_CALL(void,   mmu_unlockarea, char *, unsigned long)
-
-#define mmu_lockarea(vaddr,len) BTFIXUP_CALL(mmu_lockarea)(vaddr,len)
-#define mmu_unlockarea(vaddr,len) BTFIXUP_CALL(mmu_unlockarea)(vaddr,len)
-
 struct page;
 struct device;
 struct scatterlist;
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index c514864..fb3f169 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -229,10 +229,7 @@ static inline void virtual_dma_init(void)
 static inline void sun_fd_disable_dma(void)
 {
 	doing_pdma = 0;
-	if (pdma_base) {
-		mmu_unlockarea(pdma_base, pdma_areasize);
-		pdma_base = NULL;
-	}
+	pdma_base = NULL;
 }
 
 static inline void sun_fd_set_dma_mode(int mode)
@@ -262,7 +259,6 @@ static inline void sun_fd_set_dma_count(int length)
 
 static inline void sun_fd_enable_dma(void)
 {
-	pdma_vaddr = mmu_lockarea(pdma_vaddr, pdma_size);
 	pdma_base = pdma_vaddr;
 	pdma_areasize = pdma_size;
 }
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index bcef1f5..d534c27 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -161,10 +161,7 @@ unsigned long pdma_areasize;
 static void sun_fd_disable_dma(void)
 {
 	doing_pdma = 0;
-	if (pdma_base) {
-		mmu_unlockarea(pdma_base, pdma_areasize);
-		pdma_base = NULL;
-	}
+	pdma_base = NULL;
 }
 
 static void sun_fd_set_dma_mode(int mode)
@@ -194,7 +191,7 @@ static void sun_fd_set_dma_count(int length)
 
 static void sun_fd_enable_dma(void)
 {
-	pdma_vaddr = mmu_lockarea(pdma_vaddr, pdma_size);
+	pdma_vaddr = pdma_vaddr;
 	pdma_base = pdma_vaddr;
 	pdma_areasize = pdma_size;
 }
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 76e4a52..61210db 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -717,10 +717,6 @@ extern unsigned long find_ecache_flush_span(unsigned long size);
 struct seq_file;
 extern void mmu_info(struct seq_file *);
 
-/* These do nothing with the way I have things setup. */
-#define mmu_lockarea(vaddr, len)		(vaddr)
-#define mmu_unlockarea(vaddr, len)		do { } while(0)
-
 struct vm_area_struct;
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
 
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index 9763895..5cc35ba 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -32,8 +32,6 @@ EXPORT_SYMBOL(empty_zero_page);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(BTFIXUP_CALL(__hard_smp_processor_id));
 #endif
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_unlockarea));
-EXPORT_SYMBOL(BTFIXUP_CALL(mmu_lockarea));
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_sgl));
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_get_scsi_one));
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_release_scsi_sgl));
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index fc58c3e..d175c0a 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -242,22 +242,8 @@ static void iounit_unmap_dma_area(struct device *dev, unsigned long addr, int le
 }
 #endif
 
-static char *iounit_lockarea(char *vaddr, unsigned long len)
-{
-/* FIXME: Write this */
-	return vaddr;
-}
-
-static void iounit_unlockarea(char *vaddr, unsigned long len)
-{
-/* FIXME: Write this */
-}
-
 void __init ld_mmu_iounit(void)
 {
-	BTFIXUPSET_CALL(mmu_lockarea, iounit_lockarea, BTFIXUPCALL_RETO0);
-	BTFIXUPSET_CALL(mmu_unlockarea, iounit_unlockarea, BTFIXUPCALL_NOP);
-
 	BTFIXUPSET_CALL(mmu_get_scsi_one, iounit_get_scsi_one, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_get_scsi_sgl, iounit_get_scsi_sgl, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(mmu_release_scsi_one, iounit_release_scsi_one, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 07fc6a6..349ba83 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -426,20 +426,9 @@ static void iommu_unmap_dma_area(struct device *dev, unsigned long busa, int len
 }
 #endif
 
-static char *iommu_lockarea(char *vaddr, unsigned long len)
-{
-	return vaddr;
-}
-
-static void iommu_unlockarea(char *vaddr, unsigned long len)
-{
-}
-
 void __init ld_mmu_iommu(void)
 {
 	viking_flush = (BTFIXUPVAL_CALL(flush_page_for_dma) = (unsigned long)viking_flush_page);
-	BTFIXUPSET_CALL(mmu_lockarea, iommu_lockarea, BTFIXUPCALL_RETO0);
-	BTFIXUPSET_CALL(mmu_unlockarea, iommu_unlockarea, BTFIXUPCALL_NOP);
 
 	if (!BTFIXUPVAL_CALL(flush_page_for_dma)) {
 		/* IO coherent chip */
-- 
1.7.10

