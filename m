From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 06 Apr 2004 04:44:41 +0000
Subject: [TEST THIS] sparc32 swap fix
Message-Id: <20040406044441.GB17154@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This seems to work fine on sparc32; I can create up to 32 swaps and
swapping actually works.

However, I need people with sun4c userland to test this.  Also, if you
have a weird swap workload (lots of swaps or very big ones) you need
to try this as well.

The current limits are 4GB per swapfile, 32 swapfiles max.  Have at
it.  Thanks.

=== arch/sparc/mm/srmmu.c 1.43 vs edited ==--- 1.43/arch/sparc/mm/srmmu.c	Sun Mar 21 14:43:34 2004
+++ edited/arch/sparc/mm/srmmu.c	Mon Apr  5 20:43:27 2004
@@ -276,6 +276,23 @@
 	    ((address >> PAGE_SHIFT) & (SRMMU_PTRS_PER_PTE_SOFT - 1));
 }
 
+static unsigned long srmmu_swp_type(swp_entry_t entry)
+{
+	return (entry.val >> SRMMU_SWP_TYPE_SHIFT) & SRMMU_SWP_TYPE_MASK;
+}
+
+static unsigned long srmmu_swp_offset(swp_entry_t entry)
+{
+	return (entry.val >> SRMMU_SWP_OFF_SHIFT) & SRMMU_SWP_OFF_MASK;
+}
+
+static swp_entry_t srmmu_swp_entry(unsigned long type, unsigned long offset)
+{
+	return (swp_entry_t) {
+		  (type & SRMMU_SWP_TYPE_MASK) << SRMMU_SWP_TYPE_SHIFT
+		| (offset & SRMMU_SWP_OFF_MASK) << SRMMU_SWP_OFF_SHIFT };
+}
+
 /*
  * size: bytes to allocate in the nocache area.
  * align: bytes, number to align at.
@@ -2204,6 +2221,10 @@
 
 	BTFIXUPSET_CALL(sparc_mapiorange, srmmu_mapiorange, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(sparc_unmapiorange, srmmu_unmapiorange, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(__swp_type, srmmu_swp_type, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__swp_offset, srmmu_swp_offset, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__swp_entry, srmmu_swp_entry, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(mmu_info, srmmu_mmu_info, BTFIXUPCALL_NORM);
 
=== arch/sparc/mm/sun4c.c 1.38 vs edited ==--- 1.38/arch/sparc/mm/sun4c.c	Sun Mar 21 14:43:34 2004
+++ edited/arch/sparc/mm/sun4c.c	Mon Apr  5 20:48:22 2004
@@ -1863,6 +1863,23 @@
 			((address >> PAGE_SHIFT) & (SUN4C_PTRS_PER_PTE - 1));
 }
 
+static unsigned long sun4c_swp_type(swp_entry_t entry)
+{
+	return (entry.val & SUN4C_SWP_TYPE_MASK);
+}
+
+static unsigned long sun4c_swp_offset(swp_entry_t entry)
+{
+	return (entry.val >> SUN4C_SWP_OFF_SHIFT) & SUN4C_SWP_OFF_MASK;
+}
+
+static swp_entry_t sun4c_swp_entry(unsigned long type, unsigned long offset)
+{
+	return (swp_entry_t) {
+		  (offset & SUN4C_SWP_OFF_MASK) << SUN4C_SWP_OFF_SHIFT
+		| (type & SUN4C_SWP_TYPE_MASK) };
+}
+
 static void sun4c_free_pte_slow(pte_t *pte)
 {
 	free_page((unsigned long)pte);
@@ -2241,6 +2258,10 @@
 
 	BTFIXUPSET_CALL(sparc_mapiorange, sun4c_mapiorange, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(sparc_unmapiorange, sun4c_unmapiorange, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(__swp_type, sun4c_swp_type, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__swp_offset, sun4c_swp_offset, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(__swp_entry, sun4c_swp_entry, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(alloc_thread_info, sun4c_alloc_thread_info, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(free_thread_info, sun4c_free_thread_info, BTFIXUPCALL_NORM);
=== include/asm-sparc/pgtable.h 1.19 vs edited ==--- 1.19/include/asm-sparc/pgtable.h	Sun Mar 21 14:43:34 2004
+++ edited/include/asm-sparc/pgtable.h	Mon Apr  5 20:52:42 2004
@@ -11,6 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/spinlock.h>
+#include <linux/swap.h>
 #include <asm/types.h>
 #ifdef CONFIG_SUN4
 #include <asm/pgtsun4.h>
@@ -401,9 +402,14 @@
 extern int invalid_segment;
 
 /* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 2) & 0x7f)
-#define __swp_offset(x)			(((x).val >> 9) & 0x3ffff)
-#define __swp_entry(type,offset)	((swp_entry_t) { (((type) & 0x7f) << 2) | (((offset) & 0x3ffff) << 9) })
+BTFIXUPDEF_CALL(unsigned long, __swp_type, swp_entry_t)
+BTFIXUPDEF_CALL(unsigned long, __swp_offset, swp_entry_t)
+BTFIXUPDEF_CALL(swp_entry_t, __swp_entry, unsigned long, unsigned long)
+
+#define __swp_type(__x)			BTFIXUP_CALL(__swp_type)(__x)
+#define __swp_offset(__x)		BTFIXUP_CALL(__swp_offset)(__x)
+#define __swp_entry(__type,__off)	BTFIXUP_CALL(__swp_entry)(__type,__off)
+
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
=== include/asm-sparc/pgtsrmmu.h 1.9 vs edited ==--- 1.9/include/asm-sparc/pgtsrmmu.h	Mon Feb  2 10:13:41 2004
+++ edited/include/asm-sparc/pgtsrmmu.h	Mon Apr  5 20:51:49 2004
@@ -90,6 +90,22 @@
 
 #define SRMMU_CHG_MASK    (0xffffff00 | SRMMU_REF | SRMMU_DIRTY)
 
+/* SRMMU swap entry encoding
+ *
+ * We use 5 bits for the type and 19 for the offset.  This gives us
+ * 32 swapfiles of 4GB each.  Encoding looks like:
+ *
+ * oooooooooooooooooootttttRRRRRRRR
+ * fedcba9876543210fedcba9876543210
+ *
+ * The bottom 8 bits are reserved for protection and status bits, especially
+ * FILE and PRESENT.
+ */
+#define SRMMU_SWP_TYPE_MASK	0x1f
+#define SRMMU_SWP_TYPE_SHIFT	SRMMU_PTE_FILE_SHIFT
+#define SRMMU_SWP_OFF_MASK	0x7ffff
+#define SRMMU_SWP_OFF_SHIFT	(SRMMU_PTE_FILE_SHIFT + 5)
+
 /* Some day I will implement true fine grained access bits for
  * user pages because the SRMMU gives us the capabilities to
  * enforce all the protection levels that vma's can have.
=== include/asm-sparc/pgtsun4c.h 1.4 vs edited ==--- 1.4/include/asm-sparc/pgtsun4c.h	Tue Oct 14 15:53:46 2003
+++ edited/include/asm-sparc/pgtsun4c.h	Mon Apr  5 20:53:23 2004
@@ -74,6 +74,21 @@
 #define SUN4C_PAGE_KERNEL	__pgprot(_SUN4C_READABLE|_SUN4C_WRITEABLE|\
 					 _SUN4C_PAGE_DIRTY|_SUN4C_PAGE_PRIV)
 
+/* SUN4C swap entry encoding
+ *
+ * We use 5 bits for the type and 19 for the offset.  This gives us
+ * 32 swapfiles of 4GB each.  Encoding looks like:
+ *
+ * RRRRRRRRooooooooooooooooooottttt
+ * fedcba9876543210fedcba9876543210
+ *
+ * The top 8 bits are reserved for protection and status bits, especially
+ * FILE and PRESENT.
+ */
+#define SUN4C_SWP_TYPE_MASK	0x1f
+#define SUN4C_SWP_OFF_MASK	0x7ffff
+#define SUN4C_SWP_OFF_SHIFT	5
+
 #ifndef __ASSEMBLY__
 
 static inline unsigned long sun4c_get_synchronous_error(void)


-- 
Keith M Wesolowski
