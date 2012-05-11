From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:37:20 +0000
Subject: [PATCH v2 06/14] sparc32: delete pgtsun4c.h
Message-Id: <20120511213720.GA1598@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 6446dc7142c998139d77c8d74699345f2b818b14 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 10 May 2012 23:12:10 +0200
Subject: [PATCH v2 06/14] sparc32: delete pgtsun4c.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Fixed subject - sorry!

	Sam


 arch/sparc/include/asm/pgtable_32.h |   11 +--
 arch/sparc/include/asm/pgtsun4c.h   |  172 -----------------------------------
 arch/sparc/kernel/entry.S           |    1 -
 3 files changed, 2 insertions(+), 182 deletions(-)
 delete mode 100644 arch/sparc/include/asm/pgtsun4c.h

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 3d71018..225030b 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -16,7 +16,6 @@
 #include <linux/spinlock.h>
 #include <linux/swap.h>
 #include <asm/types.h>
-#include <asm/pgtsun4c.h>
 #include <asm/pgtsrmmu.h>
 #include <asm/vac-ops.h>
 #include <asm/oplib.h>
@@ -47,7 +46,7 @@ BTFIXUPDEF_INT(page_copy)
 BTFIXUPDEF_INT(page_readonly)
 BTFIXUPDEF_INT(page_kernel)
 
-#define PMD_SHIFT		SUN4C_PMD_SHIFT
+#define PMD_SHIFT		22
 #define PMD_SIZE        	(1UL << PMD_SHIFT)
 #define PMD_MASK        	(~(PMD_SIZE-1))
 #define PMD_ALIGN(__addr) 	(((__addr) + ~PMD_MASK) & PMD_MASK)
@@ -399,9 +398,6 @@ static inline unsigned long
 __get_phys (unsigned long addr)
 {
 	switch (sparc_cpu_model){
-	case sun4:
-	case sun4c:
-		return sun4c_get_pte (addr) << PAGE_SHIFT;
 	case sun4m:
 	case sun4d:
 		return ((srmmu_get_pte (addr) & 0xffffff00) << 4);
@@ -414,9 +410,6 @@ static inline int
 __get_iospace (unsigned long addr)
 {
 	switch (sparc_cpu_model){
-	case sun4:
-	case sun4c:
-		return -1; /* Don't check iospace on sun4c */
 	case sun4m:
 	case sun4d:
 		return (srmmu_get_pte (addr) >> 28);
@@ -463,7 +456,7 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 		set_pte_at((__vma)->vm_mm, (__address), __ptep, __entry); \
 		flush_tlb_page(__vma, __address);			  \
 	}								  \
-	(sparc_cpu_model = sun4c) || __changed;			  \
+	__changed;							  \
 })
 
 #include <asm-generic/pgtable.h>
diff --git a/arch/sparc/include/asm/pgtsun4c.h b/arch/sparc/include/asm/pgtsun4c.h
deleted file mode 100644
index aeb25e9..0000000
--- a/arch/sparc/include/asm/pgtsun4c.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * pgtsun4c.h:  Sun4c specific pgtable.h defines and code.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-#ifndef _SPARC_PGTSUN4C_H
-#define _SPARC_PGTSUN4C_H
-
-#include <asm/contregs.h>
-
-/* PMD_SHIFT determines the size of the area a second-level page table can map */
-#define SUN4C_PMD_SHIFT       22
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define SUN4C_PGDIR_SHIFT       22
-#define SUN4C_PGDIR_SIZE        (1UL << SUN4C_PGDIR_SHIFT)
-#define SUN4C_PGDIR_MASK        (~(SUN4C_PGDIR_SIZE-1))
-#define SUN4C_PGDIR_ALIGN(addr) (((addr)+SUN4C_PGDIR_SIZE-1)&SUN4C_PGDIR_MASK)
-
-/* To represent how the sun4c mmu really lays things out. */
-#define SUN4C_REAL_PGDIR_SHIFT       18
-#define SUN4C_REAL_PGDIR_SIZE        (1UL << SUN4C_REAL_PGDIR_SHIFT)
-#define SUN4C_REAL_PGDIR_MASK        (~(SUN4C_REAL_PGDIR_SIZE-1))
-#define SUN4C_REAL_PGDIR_ALIGN(addr) (((addr)+SUN4C_REAL_PGDIR_SIZE-1)&SUN4C_REAL_PGDIR_MASK)
-
-/* 16 bit PFN on sun4c */
-#define SUN4C_PFN_MASK 0xffff
-
-/* Don't increase these unless the structures in sun4c.c are fixed */
-#define SUN4C_MAX_SEGMAPS 256
-#define SUN4C_MAX_CONTEXTS 16
-
-/*
- * To be efficient, and not have to worry about allocating such
- * a huge pgd, we make the kernel sun4c tables each hold 1024
- * entries and the pgd similarly just like the i386 tables.
- */
-#define SUN4C_PTRS_PER_PTE    1024
-#define SUN4C_PTRS_PER_PMD    1
-#define SUN4C_PTRS_PER_PGD    1024
-
-/*
- * Sparc SUN4C pte fields.
- */
-#define _SUN4C_PAGE_VALID        0x80000000
-#define _SUN4C_PAGE_SILENT_READ  0x80000000   /* synonym */
-#define _SUN4C_PAGE_DIRTY        0x40000000
-#define _SUN4C_PAGE_SILENT_WRITE 0x40000000   /* synonym */
-#define _SUN4C_PAGE_PRIV         0x20000000   /* privileged page */
-#define _SUN4C_PAGE_NOCACHE      0x10000000   /* non-cacheable page */
-#define _SUN4C_PAGE_PRESENT      0x08000000   /* implemented in software */
-#define _SUN4C_PAGE_IO           0x04000000   /* I/O page */
-#define _SUN4C_PAGE_FILE         0x02000000   /* implemented in software */
-#define _SUN4C_PAGE_READ         0x00800000   /* implemented in software */
-#define _SUN4C_PAGE_WRITE        0x00400000   /* implemented in software */
-#define _SUN4C_PAGE_ACCESSED     0x00200000   /* implemented in software */
-#define _SUN4C_PAGE_MODIFIED     0x00100000   /* implemented in software */
-
-#define _SUN4C_READABLE		(_SUN4C_PAGE_READ|_SUN4C_PAGE_SILENT_READ|\
-				 _SUN4C_PAGE_ACCESSED)
-#define _SUN4C_WRITEABLE	(_SUN4C_PAGE_WRITE|_SUN4C_PAGE_SILENT_WRITE|\
-				 _SUN4C_PAGE_MODIFIED)
-
-#define _SUN4C_PAGE_CHG_MASK	(0xffff|_SUN4C_PAGE_ACCESSED|_SUN4C_PAGE_MODIFIED)
-
-#define SUN4C_PAGE_NONE		__pgprot(_SUN4C_PAGE_PRESENT)
-#define SUN4C_PAGE_SHARED	__pgprot(_SUN4C_PAGE_PRESENT|_SUN4C_READABLE|\
-					 _SUN4C_PAGE_WRITE)
-#define SUN4C_PAGE_COPY		__pgprot(_SUN4C_PAGE_PRESENT|_SUN4C_READABLE)
-#define SUN4C_PAGE_READONLY	__pgprot(_SUN4C_PAGE_PRESENT|_SUN4C_READABLE)
-#define SUN4C_PAGE_KERNEL	__pgprot(_SUN4C_READABLE|_SUN4C_WRITEABLE|\
-					 _SUN4C_PAGE_DIRTY|_SUN4C_PAGE_PRIV)
-
-/* SUN4C swap entry encoding
- *
- * We use 5 bits for the type and 19 for the offset.  This gives us
- * 32 swapfiles of 4GB each.  Encoding looks like:
- *
- * RRRRRRRRooooooooooooooooooottttt
- * fedcba9876543210fedcba9876543210
- *
- * The top 8 bits are reserved for protection and status bits, especially
- * FILE and PRESENT.
- */
-#define SUN4C_SWP_TYPE_MASK	0x1f
-#define SUN4C_SWP_OFF_MASK	0x7ffff
-#define SUN4C_SWP_OFF_SHIFT	5
-
-#ifndef __ASSEMBLY__
-
-static inline unsigned long sun4c_get_synchronous_error(void)
-{
-	unsigned long sync_err;
-
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (sync_err) :
-			     "r" (AC_SYNC_ERR), "i" (ASI_CONTROL));
-	return sync_err;
-}
-
-static inline unsigned long sun4c_get_synchronous_address(void)
-{
-	unsigned long sync_addr;
-
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (sync_addr) :
-			     "r" (AC_SYNC_VA), "i" (ASI_CONTROL));
-	return sync_addr;
-}
-
-/* SUN4C pte, segmap, and context manipulation */
-static inline unsigned long sun4c_get_segmap(unsigned long addr)
-{
-  register unsigned long entry;
-
-  __asm__ __volatile__("\n\tlduba [%1] %2, %0\n\t" : 
-		       "=r" (entry) :
-		       "r" (addr), "i" (ASI_SEGMAP));
-
-  return entry;
-}
-
-static inline void sun4c_put_segmap(unsigned long addr, unsigned long entry)
-{
-
-  __asm__ __volatile__("\n\tstba %1, [%0] %2; nop; nop; nop;\n\t" : :
-		       "r" (addr), "r" (entry),
-		       "i" (ASI_SEGMAP)
-		       : "memory");
-}
-
-static inline unsigned long sun4c_get_pte(unsigned long addr)
-{
-  register unsigned long entry;
-
-  __asm__ __volatile__("\n\tlda [%1] %2, %0\n\t" : 
-		       "=r" (entry) :
-		       "r" (addr), "i" (ASI_PTE));
-  return entry;
-}
-
-static inline void sun4c_put_pte(unsigned long addr, unsigned long entry)
-{
-  __asm__ __volatile__("\n\tsta %1, [%0] %2; nop; nop; nop;\n\t" : :
-		       "r" (addr), 
-		       "r" ((entry & ~(_SUN4C_PAGE_PRESENT))), "i" (ASI_PTE)
-		       : "memory");
-}
-
-static inline int sun4c_get_context(void)
-{
-  register int ctx;
-
-  __asm__ __volatile__("\n\tlduba [%1] %2, %0\n\t" :
-		       "=r" (ctx) :
-		       "r" (AC_CONTEXT), "i" (ASI_CONTROL));
-
-  return ctx;
-}
-
-static inline int sun4c_set_context(int ctx)
-{
-  __asm__ __volatile__("\n\tstba %0, [%1] %2; nop; nop; nop;\n\t" : :
-		       "r" (ctx), "r" (AC_CONTEXT), "i" (ASI_CONTROL)
-		       : "memory");
-
-  return ctx;
-}
-
-#endif /* !(__ASSEMBLY__) */
-
-#endif /* !(_SPARC_PGTSUN4C_H) */
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 8abe65d..b7a543c 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -19,7 +19,6 @@
 #include <asm/vaddrs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/pgtsun4c.h>
 #include <asm/winmacro.h>
 #include <asm/signal.h>
 #include <asm/obio.h>
-- 
1.6.0.6

