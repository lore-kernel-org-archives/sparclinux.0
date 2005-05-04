From: Christoph Hellwig <hch@lst.de>
Date: Wed, 04 May 2005 18:47:14 +0000
Subject: [PATCH] sparc64: kill useless __pte_alloc_one_kernel indirection
Message-Id: <20050504184714.GC20671@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

warning: untested, but it there's not too much chance for screwups

--- 1.86/arch/sparc64/kernel/sparc64_ksyms.c	2005-02-06 00:23:23 +01:00
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	2005-03-07 07:06:38 +01:00
@@ -261,7 +261,7 @@
 
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(__pte_alloc_one_kernel);
+EXPORT_SYMBOL(pte_alloc_one_kernel);
 #ifndef CONFIG_SMP
 EXPORT_SYMBOL(pgt_quicklists);
 #endif
=== arch/sparc64/mm/init.c 1.71 vs edited ==--- 1.71/arch/sparc64/mm/init.c	2005-02-24 02:45:36 +01:00
+++ edited/arch/sparc64/mm/init.c	2005-03-07 07:06:29 +01:00
@@ -1092,7 +1092,7 @@
 #else
 #define DC_ALIAS_SHIFT	0
 #endif
-pte_t *__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	struct page *page;
 	unsigned long color;
=== include/asm-sparc64/pgalloc.h 1.28 vs edited ==--- 1.28/include/asm-sparc64/pgalloc.h	2005-02-24 02:45:37 +01:00
+++ edited/include/asm-sparc64/pgalloc.h	2005-03-07 07:06:54 +01:00
@@ -187,17 +187,12 @@
 #define pmd_populate(MM,PMD,PTE_PAGE)		\
 	pmd_populate_kernel(MM,PMD,page_address(PTE_PAGE))
 
-extern pte_t *__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address);
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	return __pte_alloc_one_kernel(mm, address);
-}
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address);
 
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	pte_t *pte = __pte_alloc_one_kernel(mm, addr);
+	pte_t *pte = pte_alloc_one_kernel(mm, addr);
 
 	if (pte)
 		return virt_to_page(pte);
