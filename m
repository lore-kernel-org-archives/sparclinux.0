From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:15 +0000
Subject: [PATCH 46/49]: sparc32: Kill iounit_map_dma_*().
Message-Id: <20080827.212515.88132955.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill iounit_map_dma_*().

Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io-unit.h |    4 ---
 arch/sparc/kernel/sparc_ksyms.c  |    3 --
 arch/sparc/mm/io-unit.c          |   48 --------------------------------------
 3 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/arch/sparc/include/asm/io-unit.h b/arch/sparc/include/asm/io-unit.h
index 96823b4..01ab2f6 100644
--- a/arch/sparc/include/asm/io-unit.h
+++ b/arch/sparc/include/asm/io-unit.h
@@ -55,8 +55,4 @@ struct iounit_struct {
 #define IOUNIT_BMAPM_START	IOUNIT_BMAP2_END
 #define IOUNIT_BMAPM_END	((IOUNIT_DMA_SIZE - IOUNIT_DVMA_SIZE) >> PAGE_SHIFT)
 
-extern __u32 iounit_map_dma_init(struct sbus_bus *, int);
-#define iounit_map_dma_finish(sbus, addr, len) mmu_release_scsi_one(addr, len, sbus)
-extern __u32 iounit_map_dma_page(__u32, void *, struct sbus_bus *);
-
 #endif /* !(_SPARC_IO_UNIT_H) */
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index f2722ee..a9478db 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -134,9 +134,6 @@ EXPORT_SYMBOL(set_auxio);
 EXPORT_SYMBOL(get_auxio);
 #endif
 EXPORT_SYMBOL(io_remap_pfn_range);
-  /* P3: iounit_xxx may be needed, sun4d users */
-/* EXPORT_SYMBOL(iounit_map_dma_init); */
-/* EXPORT_SYMBOL(iounit_map_dma_page); */
 
 #ifndef CONFIG_SMP
 EXPORT_SYMBOL(BTFIXUP_CALL(___xchg32));
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index caf551a..5390023 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -267,51 +267,3 @@ void __init ld_mmu_iounit(void)
 	BTFIXUPSET_CALL(mmu_unmap_dma_area, iounit_unmap_dma_area, BTFIXUPCALL_NORM);
 #endif
 }
-
-__u32 iounit_map_dma_init(struct sbus_bus *sbus, int size)
-{
-	int i, j, k, npages;
-	unsigned long rotor, scan, limit;
-	unsigned long flags;
-	__u32 ret;
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
-
-        npages = (size + (PAGE_SIZE-1)) >> PAGE_SHIFT;
-	i = 0x0213;
-	spin_lock_irqsave(&iounit->lock, flags);
-next:	j = (i & 15);
-	rotor = iounit->rotor[j - 1];
-	limit = iounit->limit[j];
-	scan = rotor;
-nexti:	scan = find_next_zero_bit(iounit->bmap, limit, scan);
-	if (scan + npages > limit) {
-		if (limit != rotor) {
-			limit = rotor;
-			scan = iounit->limit[j - 1];
-			goto nexti;
-		}
-		i >>= 4;
-		if (!(i & 15))
-			panic("iounit_map_dma_init: Couldn't find free iopte slots for %d bytes\n", size);
-		goto next;
-	}
-	for (k = 1, scan++; k < npages; k++)
-		if (test_bit(scan++, iounit->bmap))
-			goto nexti;
-	iounit->rotor[j - 1] = (scan < limit) ? scan : iounit->limit[j - 1];
-	scan -= npages;
-	ret = IOUNIT_DMA_BASE + (scan << PAGE_SHIFT);
-	for (k = 0; k < npages; k++, scan++)
-		set_bit(scan, iounit->bmap);
-	spin_unlock_irqrestore(&iounit->lock, flags);
-	return ret;
-}
-
-__u32 iounit_map_dma_page(__u32 vaddr, void *addr, struct sbus_bus *sbus)
-{
-	int scan = (vaddr - IOUNIT_DMA_BASE) >> PAGE_SHIFT;
-	struct iounit_struct *iounit = sbus->ofdev.dev.archdata.iommu;
-	
-	iounit->page_table[scan] = MKIOPTE(__pa(((unsigned long)addr) & PAGE_MASK));
-	return vaddr + (((unsigned long)addr) & ~PAGE_MASK);
-}
-- 
1.5.6.5.GIT

