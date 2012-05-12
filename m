From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 19:57:08 +0000
Subject: [PATCH] sparc32: Un-btfixup PAGE_{NONE,COPY,READONLY,SHARED,KERNEL}.
Message-Id: <20120512.155708.2271206921822847114.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


That lets us also get rid of the run-time initialization of
protection_map[] and all the ugly module workarounds for
PAGE_KERNEL and PAGE_SHARED to deal with the fact that we
can't do btfixups for modular code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtable_32.h |   62 +++++++++++++----------------------
 arch/sparc/mm/init_32.c             |   23 -------------
 arch/sparc/mm/srmmu.c               |    9 -----
 3 files changed, 23 insertions(+), 71 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 1c31ef1..c0e4d73 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -32,11 +32,6 @@ extern unsigned long calc_highpages(void);
 #define pmd_ERROR(e)   __builtin_trap()
 #define pgd_ERROR(e)   __builtin_trap()
 
-BTFIXUPDEF_INT(page_none)
-BTFIXUPDEF_INT(page_copy)
-BTFIXUPDEF_INT(page_readonly)
-BTFIXUPDEF_INT(page_kernel)
-
 #define PMD_SHIFT		22
 #define PMD_SIZE        	(1UL << PMD_SHIFT)
 #define PMD_MASK        	(~(PMD_SIZE-1))
@@ -51,18 +46,11 @@ BTFIXUPDEF_INT(page_kernel)
 #define FIRST_USER_ADDRESS	0
 #define PTE_SIZE		(PTRS_PER_PTE*4)
 
-#define PAGE_NONE      __pgprot(BTFIXUP_INT(page_none))
-extern pgprot_t PAGE_SHARED;
-#define PAGE_COPY      __pgprot(BTFIXUP_INT(page_copy))
-#define PAGE_READONLY  __pgprot(BTFIXUP_INT(page_readonly))
-
-extern unsigned long page_kernel;
-
-#ifdef MODULE
-#define PAGE_KERNEL	page_kernel
-#else
-#define PAGE_KERNEL    __pgprot(BTFIXUP_INT(page_kernel))
-#endif
+#define PAGE_NONE	SRMMU_PAGE_NONE
+#define PAGE_SHARED	SRMMU_PAGE_SHARED
+#define PAGE_COPY	SRMMU_PAGE_COPY
+#define PAGE_READONLY	SRMMU_PAGE_RDONLY
+#define PAGE_KERNEL	SRMMU_PAGE_KERNEL
 
 /* Top-level page directory */
 extern pgd_t swapper_pg_dir[1024];
@@ -71,28 +59,24 @@ extern void paging_init(void);
 
 extern unsigned long ptr_in_current_pgd;
 
-/* Here is a trick, since mmap.c need the initializer elements for
- * protection_map[] to be constant at compile time, I set the following
- * to all zeros.  I set it to the real values after I link in the
- * appropriate MMU page table routines at boot time.
- */
-#define __P000  __pgprot(0)
-#define __P001  __pgprot(0)
-#define __P010  __pgprot(0)
-#define __P011  __pgprot(0)
-#define __P100  __pgprot(0)
-#define __P101  __pgprot(0)
-#define __P110  __pgprot(0)
-#define __P111  __pgprot(0)
-
-#define __S000	__pgprot(0)
-#define __S001	__pgprot(0)
-#define __S010	__pgprot(0)
-#define __S011	__pgprot(0)
-#define __S100	__pgprot(0)
-#define __S101	__pgprot(0)
-#define __S110	__pgprot(0)
-#define __S111	__pgprot(0)
+/*         xwr */
+#define __P000  PAGE_NONE
+#define __P001  PAGE_READONLY
+#define __P010  PAGE_COPY
+#define __P011  PAGE_COPY
+#define __P100  PAGE_READONLY
+#define __P101  PAGE_READONLY
+#define __P110  PAGE_COPY
+#define __P111  PAGE_COPY
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READONLY
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY
+#define __S101	PAGE_READONLY
+#define __S110	PAGE_SHARED
+#define __S111	PAGE_SHARED
 
 extern int num_contexts;
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 79b215e..61f9b70 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -44,9 +44,6 @@ EXPORT_SYMBOL(phys_base);
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
-unsigned long page_kernel;
-EXPORT_SYMBOL(page_kernel);
-
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 unsigned long sparc_unmapped_base;
 
@@ -293,9 +290,6 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 extern void srmmu_paging_init(void);
 extern void device_scan(void);
 
-pgprot_t PAGE_SHARED __read_mostly;
-EXPORT_SYMBOL(PAGE_SHARED);
-
 void __init paging_init(void)
 {
 	switch(sparc_cpu_model) {
@@ -315,23 +309,6 @@ void __init paging_init(void)
 		prom_halt();
 	}
 
-	/* Initialize the protection map with non-constant, MMU dependent values. */
-	protection_map[0] = PAGE_NONE;
-	protection_map[1] = PAGE_READONLY;
-	protection_map[2] = PAGE_COPY;
-	protection_map[3] = PAGE_COPY;
-	protection_map[4] = PAGE_READONLY;
-	protection_map[5] = PAGE_READONLY;
-	protection_map[6] = PAGE_COPY;
-	protection_map[7] = PAGE_COPY;
-	protection_map[8] = PAGE_NONE;
-	protection_map[9] = PAGE_READONLY;
-	protection_map[10] = PAGE_SHARED;
-	protection_map[11] = PAGE_SHARED;
-	protection_map[12] = PAGE_READONLY;
-	protection_map[13] = PAGE_READONLY;
-	protection_map[14] = PAGE_SHARED;
-	protection_map[15] = PAGE_SHARED;
 	btfixup();
 	prom_build_devicetree();
 	of_fill_in_cpu_data();
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d852962..c696271 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -59,8 +59,6 @@ extern struct resource sparc_iomap;
 
 extern unsigned long last_valid_pfn;
 
-extern unsigned long page_kernel;
-
 static pgd_t *srmmu_swapper_pg_dir;
 
 #ifdef CONFIG_SMP
@@ -2078,13 +2076,6 @@ void __init ld_mmu_srmmu(void)
 	extern void ld_mmu_iounit(void);
 	extern void ___xchg32_sun4md(void);
 
-	BTFIXUPSET_INT(page_none, pgprot_val(SRMMU_PAGE_NONE));
-	PAGE_SHARED = pgprot_val(SRMMU_PAGE_SHARED);
-	BTFIXUPSET_INT(page_copy, pgprot_val(SRMMU_PAGE_COPY));
-	BTFIXUPSET_INT(page_readonly, pgprot_val(SRMMU_PAGE_RDONLY));
-	BTFIXUPSET_INT(page_kernel, pgprot_val(SRMMU_PAGE_KERNEL));
-	page_kernel = pgprot_val(SRMMU_PAGE_KERNEL);
-
 	/* Functions */
 #ifndef CONFIG_SMP	
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
-- 
1.7.10

