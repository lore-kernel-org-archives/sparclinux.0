From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:19 +0000
Subject: [PATCH 15/15] sparc32: srmmu_probe now knows about leon too
Message-Id: <1338016819-22245-15-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h     |    2 +-
 arch/sparc/include/asm/pgtsrmmu.h |   17 -----------------
 arch/sparc/mm/leon_mm.c           |    2 +-
 arch/sparc/mm/srmmu.c             |   25 +++++++++++++++++++++----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 995c4e0..ba46083 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -197,7 +197,7 @@ static inline int sparc_leon3_cpuid(void)
 #ifndef __ASSEMBLY__
 struct vm_area_struct;
 
-extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
+extern unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr);
 extern void leon_flush_icache_all(void);
 extern void leon_flush_dcache_all(void);
 extern void leon_flush_cache_all(void);
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 72f7121..79da178 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -166,23 +166,6 @@ static inline void srmmu_flush_whole_tlb(void)
 
 }
 
-/* These flush types are not available on all chips... */
-#ifndef CONFIG_SPARC_LEON
-static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
-{
-	unsigned long retval;
-
-	vaddr &= PAGE_MASK;
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (vaddr | 0x400), "i" (ASI_M_FLUSH_PROBE));
-
-	return retval;
-}
-#else
-#define srmmu_hwprobe(addr) srmmu_swprobe(addr, 0)
-#endif
-
 static inline int
 srmmu_get_pte (unsigned long addr)
 {
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 4c67ae6..5bed085 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -32,7 +32,7 @@ static inline unsigned long leon_get_ctable_ptr(void)
 }
 
 
-unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr)
+unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr)
 {
 
 	unsigned int ctxtbl;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 256db6b..62e3f57 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -646,6 +646,23 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 	}
 }
 
+/* These flush types are not available on all chips... */
+static inline unsigned long srmmu_probe(unsigned long vaddr)
+{
+	unsigned long retval;
+
+	if (sparc_cpu_model != sparc_leon) {
+
+		vaddr &= PAGE_MASK;
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (vaddr | 0x400), "i" (ASI_M_FLUSH_PROBE));
+	} else {
+		retval = leon_swprobe(vaddr, 0);
+	}
+	return retval;
+}
+
 /*
  * This is much cleaner than poking around physical address space
  * looking at the prom's page table directly which is what most
@@ -665,7 +682,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			break; /* probably wrap around */
 		if(start = 0xfef00000)
 			start = KADB_DEBUGGER_BEGVM;
-		if(!(prompte = srmmu_hwprobe(start))) {
+		if(!(prompte = srmmu_probe(start))) {
 			start += PAGE_SIZE;
 			continue;
 		}
@@ -674,12 +691,12 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		what = 0;
     
 		if(!(start & ~(SRMMU_REAL_PMD_MASK))) {
-			if(srmmu_hwprobe((start-PAGE_SIZE) + SRMMU_REAL_PMD_SIZE) = prompte)
+			if(srmmu_probe((start-PAGE_SIZE) + SRMMU_REAL_PMD_SIZE) = prompte)
 				what = 1;
 		}
     
 		if(!(start & ~(SRMMU_PGDIR_MASK))) {
-			if(srmmu_hwprobe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE) =
+			if(srmmu_probe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE) =
 			   prompte)
 				what = 2;
 		}
@@ -1156,7 +1173,7 @@ static void turbosparc_flush_page_to_ram(unsigned long page)
 #ifdef TURBOSPARC_WRITEBACK
 	volatile unsigned long clear;
 
-	if (srmmu_hwprobe(page))
+	if (srmmu_probe(page))
 		turbosparc_flush_page_cache(page);
 	clear = srmmu_get_fstatus();
 #endif
-- 
1.6.0.6

