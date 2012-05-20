From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:50 +0000
Subject: [PATCH 7/8] sparc32: drop unused functions in pgtsrmmu.h
Message-Id: <1337493771-18535-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

One function was only used by leon - move it to a leon specific file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtsrmmu.h |   50 -------------------------------------
 arch/sparc/mm/leon_mm.c           |   16 ++++++++++-
 2 files changed, 14 insertions(+), 52 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index f6ae2b2..cb82870 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -173,17 +173,6 @@ static inline void srmmu_set_ctable_ptr(unsigned long paddr)
 			     "memory");
 }
 
-static inline unsigned long srmmu_get_ctable_ptr(void)
-{
-	unsigned int retval;
-
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_CTXTBL_PTR),
-			     "i" (ASI_M_MMUREGS));
-	return (retval & SRMMU_CTX_PMASK) << 4;
-}
-
 static inline void srmmu_set_context(int context)
 {
 	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
@@ -231,42 +220,6 @@ static inline void srmmu_flush_whole_tlb(void)
 }
 
 /* These flush types are not available on all chips... */
-static inline void srmmu_flush_tlb_ctx(void)
-{
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
-			     "r" (0x300),        /* Flush TLB ctx.. */
-			     "i" (ASI_M_FLUSH_PROBE) : "memory");
-
-}
-
-static inline void srmmu_flush_tlb_region(unsigned long addr)
-{
-	addr &= SRMMU_PGDIR_MASK;
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
-			     "r" (addr | 0x200), /* Flush TLB region.. */
-			     "i" (ASI_M_FLUSH_PROBE) : "memory");
-
-}
-
-
-static inline void srmmu_flush_tlb_segment(unsigned long addr)
-{
-	addr &= SRMMU_REAL_PMD_MASK;
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
-			     "r" (addr | 0x100), /* Flush TLB segment.. */
-			     "i" (ASI_M_FLUSH_PROBE) : "memory");
-
-}
-
-static inline void srmmu_flush_tlb_page(unsigned long page)
-{
-	page &= PAGE_MASK;
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
-			     "r" (page),        /* Flush TLB page.. */
-			     "i" (ASI_M_FLUSH_PROBE) : "memory");
-
-}
-
 #ifndef CONFIG_SPARC_LEON
 static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 {
@@ -294,9 +247,6 @@ srmmu_get_pte (unsigned long addr)
 	return entry;
 }
 
-extern unsigned long (*srmmu_read_physical)(unsigned long paddr);
-extern void (*srmmu_write_physical)(unsigned long paddr, unsigned long word);
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC_PGTSRMMU_H) */
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index ccbcba4..3062f4d 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -20,6 +20,18 @@
 int leon_flush_during_switch = 1;
 int srmmu_swprobe_trace;
 
+static inline unsigned long leon_get_ctable_ptr(void)
+{
+	unsigned int retval;
+
+	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+			     "=r" (retval) :
+			     "r" (SRMMU_CTXTBL_PTR),
+			     "i" (ASI_LEON_MMUREGS));
+	return (retval & SRMMU_CTX_PMASK) << 4;
+}
+
+
 unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
 {
 
@@ -35,10 +47,10 @@ unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
 	if (srmmu_swprobe_trace)
 		printk(KERN_INFO "swprobe: trace on\n");
 
-	ctxtbl = srmmu_get_ctable_ptr();
+	ctxtbl = leon_get_ctable_ptr();
 	if (!(ctxtbl)) {
 		if (srmmu_swprobe_trace)
-			printk(KERN_INFO "swprobe: srmmu_get_ctable_ptr returned 0=>0\n");
+			printk(KERN_INFO "swprobe: leon_get_ctable_ptr returned 0=>0\n");
 		return 0;
 	}
 	if (!_pfn_valid(PFN(ctxtbl))) {
-- 
1.6.0.6

