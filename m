From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 02 Feb 2004 09:34:39 +0000
Subject: [sparc32] Align pkmap properly
Message-Id: <20040202093439.GA22498@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After the last round of memory map changes, I now find that sometimes,
depending on the amount of memory and amount of userland exercising
done, the following sequence occurs:

kmap_high
fault on pkmap address
oops

Other problems included processes getting KILL or SEGV for no apparent
reason.  The immediate cause is that the pkmap pagetable doesn't cover
the whole pkmap region, and thus the pkmap actually trashes random
pagetables instead.  Rather than try to allocate another contiguous
pagetable, this fixes it by aligning on a 4MB boundary.

Dave, please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1552  -> 1.1553 
#	include/asm-sparc/pgtsrmmu.h	1.8     -> 1.9    
#	arch/sparc/mm/srmmu.c	1.38    -> 1.39   
#	include/asm-sparc/highmem.h	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/02	wesolows@foobazco.org	1.1553
# Align the pkmap area on a 4MB region so that a single
# large pagetable can be used.  Fixes random killing of
# processes which used high memory.
# --------------------------------------------
#
diff -Nru a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	Mon Feb  2 01:25:52 2004
+++ b/arch/sparc/mm/srmmu.c	Mon Feb  2 01:25:52 2004
@@ -51,26 +51,6 @@
 
 #include <asm/btfixup.h>
 
-/*
- * To support pagetables in highmem, Linux introduces APIs which
- * return struct page* and generally manipulate page tables when
- * they are not mapped into kernel space. Our hardware page tables
- * are smaller than pages. We lump hardware tabes into big, page sized
- * software tables.
- *
- * PMD_SHIFT determines the size of the area a second-level page table entry
- * can map, and our pmd_t is 16 times larger than normal.
- */
-#define SRMMU_PTRS_PER_PMD_SOFT    0x4	/* Each pmd_t contains 16 hard PTPs */
-#define SRMMU_PTRS_PER_PTE_SOFT  0x400	/* 16 hard tables per 4K page */
-#define SRMMU_PTE_SZ_SOFT       0x1000	/* same as above, in bytes */
-
-#define SRMMU_PMD_SHIFT_SOFT	22
-#define SRMMU_PMD_SIZE_SOFT	(1UL << SRMMU_PMD_SHIFT_SOFT)
-#define SRMMU_PMD_MASK_SOFT	(~(SRMMU_PMD_SIZE_SOFT-1))
-// #define SRMMU_PMD_ALIGN(addr)  (((addr)+SRMMU_PMD_SIZE-1)&SRMMU_PMD_MASK)
-
-
 enum mbus_module srmmu_modtype;
 unsigned int hwbug_bitmask;
 int vac_cache_size;
diff -Nru a/include/asm-sparc/highmem.h b/include/asm-sparc/highmem.h
--- a/include/asm-sparc/highmem.h	Mon Feb  2 01:25:52 2004
+++ b/include/asm-sparc/highmem.h	Mon Feb  2 01:25:52 2004
@@ -38,10 +38,12 @@
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
- * chunk of RAM.
+ * chunk of RAM.  Currently the simplest way to do this is to align the
+ * pkmap region on a pagetable boundary (4MB).
  */
-#define PKMAP_BASE (SRMMU_NOCACHE_VADDR + (SRMMU_MAX_NOCACHE_PAGES << PAGE_SHIFT))
 #define LAST_PKMAP 1024
+#define PKMAP_SIZE (LAST_PKMAP << PAGE_SHIFT)
+#define PKMAP_BASE SRMMU_PMD_ALIGN_SOFT(SRMMU_NOCACHE_VADDR + (SRMMU_MAX_NOCACHE_PAGES << PAGE_SHIFT))
 
 #define LAST_PKMAP_MASK (LAST_PKMAP - 1)
 #define PKMAP_NR(virt)  ((virt - PKMAP_BASE) >> PAGE_SHIFT)
diff -Nru a/include/asm-sparc/pgtsrmmu.h b/include/asm-sparc/pgtsrmmu.h
--- a/include/asm-sparc/pgtsrmmu.h	Mon Feb  2 01:25:52 2004
+++ b/include/asm-sparc/pgtsrmmu.h	Mon Feb  2 01:25:52 2004
@@ -36,6 +36,25 @@
 #define SRMMU_PMD_TABLE_SIZE    0x100 /* 64 entries, 4 bytes a piece */
 #define SRMMU_PGD_TABLE_SIZE    0x400 /* 256 entries, 4 bytes a piece */
 
+/*
+ * To support pagetables in highmem, Linux introduces APIs which
+ * return struct page* and generally manipulate page tables when
+ * they are not mapped into kernel space. Our hardware page tables
+ * are smaller than pages. We lump hardware tabes into big, page sized
+ * software tables.
+ *
+ * PMD_SHIFT determines the size of the area a second-level page table entry
+ * can map, and our pmd_t is 16 times larger than normal.
+ */
+#define SRMMU_PTRS_PER_PTE_SOFT	(PAGE_SIZE/4)	/* 16 hard tables per 4K page */
+#define SRMMU_PTRS_PER_PMD_SOFT	4	/* Each pmd_t contains 16 hard PTPs */
+#define SRMMU_PTE_SZ_SOFT       PAGE_SIZE	/* same as above, in bytes */
+
+#define SRMMU_PMD_SHIFT_SOFT	22
+#define SRMMU_PMD_SIZE_SOFT	(1UL << SRMMU_PMD_SHIFT_SOFT)
+#define SRMMU_PMD_MASK_SOFT	(~(SRMMU_PMD_SIZE_SOFT-1))
+#define SRMMU_PMD_ALIGN_SOFT(addr)  (((addr)+SRMMU_PMD_SIZE_SOFT-1)&SRMMU_PMD_MASK_SOFT)
+
 /* Definition of the values in the ET field of PTD's and PTE's */
 #define SRMMU_ET_MASK         0x3
 #define SRMMU_ET_INVALID      0x0


-- 
Keith M Wesolowski

