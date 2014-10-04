From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 23:27:18 +0000
Subject: [PATCH 7/9] sparc64: Adjust vmalloc region size based upon available virtual address bits.
Message-Id: <20141004.192718.1655412880695905158.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


In order to accomodate embedded per-cpu allocation with large numbers
of cpus and numa nodes, we have to use as much virtual address space
as possible for the vmalloc region.  Otherwise we can get things like:

PERCPU: max_distance=0x380001c10000 too large for vmalloc space 0xff00000000

So, once we select a value for PAGE_OFFSET, derive the size of the
vmalloc region based upon that.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/page_64.h    |  1 -
 arch/sparc/include/asm/pgtable_64.h |  9 +++++----
 arch/sparc/kernel/ktlb.S            |  8 ++++----
 arch/sparc/mm/init_64.c             | 30 +++++++++++++++++++-----------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 6784a33..8c2a8c9 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -117,7 +117,6 @@ extern unsigned long sparc64_va_hole_bottom;
 
 #include <asm-generic/memory_model.h>
 
-#define PAGE_OFFSET_BY_BITS(X)	(-(_AC(1,UL) << (X)))
 extern unsigned long PAGE_OFFSET;
 
 #endif /* !(__ASSEMBLY__) */
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 0552957..c093922 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -40,10 +40,7 @@
 #define LOW_OBP_ADDRESS		_AC(0x00000000f0000000,UL)
 #define HI_OBP_ADDRESS		_AC(0x0000000100000000,UL)
 #define VMALLOC_START		_AC(0x0000000100000000,UL)
-#define VMALLOC_END		_AC(0x0000010000000000,UL)
-#define VMEMMAP_BASE		_AC(0x0000010000000000,UL)
-
-#define vmemmap			((struct page *)VMEMMAP_BASE)
+#define VMEMMAP_BASE		VMALLOC_END
 
 /* PMD_SHIFT determines the size of the area a second-level page
  * table can map
@@ -81,6 +78,10 @@
 
 #ifndef __ASSEMBLY__
 
+extern unsigned long VMALLOC_END;
+
+#define vmemmap			((struct page *)VMEMMAP_BASE)
+
 #include <linux/sched.h>
 
 bool kern_addr_valid(unsigned long addr);
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 2627a7f..ef0d8e9 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -199,8 +199,8 @@ kvmap_dtlb_nonlinear:
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	/* Do not use the TSB for vmemmap.  */
-	mov		(VMEMMAP_BASE >> 40), %g5
-	sllx		%g5, 40, %g5
+	sethi		%hi(VMEMMAP_BASE), %g5
+	ldx		[%g5 + %lo(VMEMMAP_BASE)], %g5
 	cmp		%g4,%g5
 	bgeu,pn		%xcc, kvmap_vmemmap
 	 nop
@@ -212,8 +212,8 @@ kvmap_dtlb_tsbmiss:
 	sethi		%hi(MODULES_VADDR), %g5
 	cmp		%g4, %g5
 	blu,pn		%xcc, kvmap_dtlb_longpath
-	 mov		(VMALLOC_END >> 40), %g5
-	sllx		%g5, 40, %g5
+	 sethi		%hi(VMALLOC_END), %g5
+	ldx		[%g5 + %lo(VMALLOC_END)], %g5
 	cmp		%g4, %g5
 	bgeu,pn		%xcc, kvmap_dtlb_longpath
 	 nop
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index a8e3395..72547c0 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1369,25 +1369,24 @@ static unsigned long max_phys_bits = 40;
 
 bool kern_addr_valid(unsigned long addr)
 {
-	unsigned long above = ((long)addr) >> max_phys_bits;
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
-	if (above != 0 && above != -1UL)
-		return false;
-
-	if (addr >= (unsigned long) KERNBASE &&
-	    addr < (unsigned long)&_end)
-		return true;
-
-	if (addr >= PAGE_OFFSET) {
+	if ((long)addr < 0L) {
 		unsigned long pa = __pa(addr);
 
+		if ((addr >> max_phys_bits) != 0UL)
+			return false;
+
 		return pfn_valid(pa >> PAGE_SHIFT);
 	}
 
+	if (addr >= (unsigned long) KERNBASE &&
+	    addr < (unsigned long)&_end)
+		return true;
+
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd))
 		return 0;
@@ -1656,6 +1655,9 @@ unsigned long __init find_ecache_flush_span(unsigned long size)
 unsigned long PAGE_OFFSET;
 EXPORT_SYMBOL(PAGE_OFFSET);
 
+unsigned long VMALLOC_END   = 0x0000010000000000UL;
+EXPORT_SYMBOL(VMALLOC_END);
+
 unsigned long sparc64_va_hole_top =    0xfffff80000000000UL;
 unsigned long sparc64_va_hole_bottom = 0x0000080000000000UL;
 
@@ -1712,10 +1714,16 @@ static void __init setup_page_offset(void)
 		prom_halt();
 	}
 
-	PAGE_OFFSET = PAGE_OFFSET_BY_BITS(max_phys_bits);
+	PAGE_OFFSET = sparc64_va_hole_top;
+	VMALLOC_END = ((sparc64_va_hole_bottom >> 1) +
+		       (sparc64_va_hole_bottom >> 2));
 
-	pr_info("PAGE_OFFSET is 0x%016lx (max_phys_bits = %lu)\n",
+	pr_info("MM: PAGE_OFFSET is 0x%016lx (max_phys_bits = %lu)\n",
 		PAGE_OFFSET, max_phys_bits);
+	pr_info("MM: VMALLOC [0x%016lx --> 0x%016lx]\n",
+		VMALLOC_START, VMALLOC_END);
+	pr_info("MM: VMEMMAP [0x%016lx --> 0x%016lx]\n",
+		VMEMMAP_BASE, VMEMMAP_BASE << 1);
 }
 
 static void __init tsb_phys_patch(void)
-- 
1.8.1.2

