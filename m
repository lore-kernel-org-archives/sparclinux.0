From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2012 20:22:24 +0000
Subject: [PATCH] sparc32: Un-btfixup update_mmu_cache().
Message-Id: <20120513.162224.175384916531399412.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The magic Swift SRMMU code in question has not been enabled for
something on the order of a decade, and it as well as it's comment
is there in the history in case we ever need it again.

Therefore all implementations are NOPs and we can kill this stuff
off.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |    4 +---
 arch/sparc/mm/srmmu.c               |   40 -----------------------------------
 2 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 088db0c..b7c202f 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -356,9 +356,7 @@ void mmu_info(struct seq_file *m);
 #define FAULT_CODE_WRITE    0x2
 #define FAULT_CODE_USER     0x4
 
-BTFIXUPDEF_CALL(void, update_mmu_cache, struct vm_area_struct *, unsigned long, pte_t *)
-
-#define update_mmu_cache(vma,addr,ptep) BTFIXUP_CALL(update_mmu_cache)(vma,addr,ptep)
+#define update_mmu_cache(vma, address, ptep) do { } while (0)
 
 void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
                       unsigned long xva, unsigned int len);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 6efcb6b..4c4002f 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -531,38 +531,6 @@ extern void tsunami_flush_tlb_range(struct vm_area_struct *vma, unsigned long st
 extern void tsunami_flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 extern void tsunami_setup_blockops(void);
 
-/*
- * Workaround, until we find what's going on with Swift. When low on memory,
- * it sometimes loops in fault/handle_mm_fault incl. flush_tlb_page to find
- * out it is already in page tables/ fault again on the same instruction.
- * I really don't understand it, have checked it and contexts
- * are right, flush_tlb_all is done as well, and it faults again...
- * Strange. -jj
- *
- * The following code is a deadwood that may be necessary when
- * we start to make precise page flushes again. --zaitcev
- */
-static void swift_update_mmu_cache(struct vm_area_struct * vma, unsigned long address, pte_t *ptep)
-{
-#if 0
-	static unsigned long last;
-	unsigned int val;
-	/* unsigned int n; */
-
-	if (address = last) {
-		val = srmmu_hwprobe(address);
-		if (val != 0 && pte_val(*ptep) != val) {
-			printk("swift_update_mmu_cache: "
-			    "addr %lx put %08x probed %08x from %pf\n",
-			    address, pte_val(*ptep), val,
-			    __builtin_return_address(0));
-			srmmu_flush_whole_tlb();
-		}
-	}
-	last = address;
-#endif
-}
-
 /* swift.S */
 extern void swift_flush_cache_all(void);
 extern void swift_flush_cache_mm(struct mm_struct *mm);
@@ -1218,10 +1186,6 @@ void mmu_info(struct seq_file *m)
 		   srmmu_nocache_map.used << SRMMU_NOCACHE_BITMAP_SHIFT);
 }
 
-static void srmmu_update_mmu_cache(struct vm_area_struct * vma, unsigned long address, pte_t pte)
-{
-}
-
 void destroy_context(struct mm_struct *mm)
 {
 
@@ -1522,8 +1486,6 @@ static void __init init_swift(void)
 	BTFIXUPSET_CALL(flush_sig_insns, swift_flush_sig_insns, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(flush_page_for_dma, swift_flush_page_for_dma, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(update_mmu_cache, swift_update_mmu_cache, BTFIXUPCALL_NORM);
-
 	flush_page_for_dma_global = 0;
 
 	/*
@@ -1982,8 +1944,6 @@ void __init load_mmu(void)
 	extern void ld_mmu_iounit(void);
 
 	/* Functions */
-	BTFIXUPSET_CALL(update_mmu_cache, srmmu_update_mmu_cache, BTFIXUPCALL_NOP);
-
 	get_srmmu_type();
 
 #ifdef CONFIG_SMP
-- 
1.7.10

