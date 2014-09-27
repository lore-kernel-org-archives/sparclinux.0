From: David Miller <davem@davemloft.net>
Date: Sat, 27 Sep 2014 18:29:01 +0000
Subject: [PATCH 7/8] sparc64: Adjust vmalloc region size based upon available virtual address bits.
Message-Id: <20140927.142901.374337023375502394.davem@davemloft.net>
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
 arch/sparc/mm/init_64.c             | 16 ++++++++++++++--
 4 files changed, 23 insertions(+), 11 deletions(-)

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
index 7f34a47..ede1840 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1656,6 +1656,9 @@ unsigned long __init find_ecache_flush_span(unsigned long size)
 unsigned long PAGE_OFFSET;
 EXPORT_SYMBOL(PAGE_OFFSET);
 
+unsigned long VMALLOC_END   = 0x0000010000000000UL;
+EXPORT_SYMBOL(VMALLOC_END);
+
 unsigned long sparc64_va_hole_top =    0xfffff80000000000UL;
 unsigned long sparc64_va_hole_bottom = 0x0000080000000000UL;
 
@@ -1712,10 +1715,19 @@ static void __init setup_page_offset(void)
 		prom_halt();
 	}
 
-	PAGE_OFFSET = PAGE_OFFSET_BY_BITS(max_phys_bits);
+	/* PAGE_OFFSET must be calculated this way in order for the
+	 * 'above' checks in kern_addr_valid to work properly.
+	 */
+	PAGE_OFFSET = (-(1UL << max_phys_bits));
+
+	VMALLOC_END = (~PAGE_OFFSET + 1) >> 1;
 
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

