From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 23:27:07 +0000
Subject: [PATCH 5/9] sparc64: Use kernel page tables for vmemmap.
Message-Id: <20141004.192707.378876209162336297.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


For sparse memory configurations, the vmemmap array behaves terribly
and it takes up an inordinate amount of space in the BSS section of
the kernel image unconditionally.

Just build huge PMDs and look them up just like we do for TLB misses
in the vmalloc area.

Kernel BSS shrinks by about 2MB.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ktlb.S |  9 ++----
 arch/sparc/mm/init_64.c  | 72 +++++++++++++++++++++++-------------------------
 arch/sparc/mm/init_64.h  | 11 --------
 3 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 94a1e66..2627a7f 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -186,13 +186,8 @@ kvmap_dtlb_load:
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 kvmap_vmemmap:
-	sub		%g4, %g5, %g5
-	srlx		%g5, ILOG2_4MB, %g5
-	sethi		%hi(vmemmap_table), %g1
-	sllx		%g5, 3, %g5
-	or		%g1, %lo(vmemmap_table), %g1
-	ba,pt		%xcc, kvmap_dtlb_load
-	 ldx		[%g1 + %g5], %g5
+	KERN_PGTABLE_WALK(%g4, %g5, %g2, kvmap_dtlb_longpath)
+	ba,a,pt		%xcc, kvmap_dtlb_load
 #endif
 
 kvmap_dtlb_nonlinear:
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d43b03b..08ab4f4 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2308,18 +2308,9 @@ unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-unsigned long vmemmap_table[VMEMMAP_SIZE];
-
-static long __meminitdata addr_start, addr_end;
-static int __meminitdata node_start;
-
 int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 			       int node)
 {
-	unsigned long phys_start = (vstart - VMEMMAP_BASE);
-	unsigned long phys_end = (vend - VMEMMAP_BASE);
-	unsigned long addr = phys_start & VMEMMAP_CHUNK_MASK;
-	unsigned long end = VMEMMAP_ALIGN(phys_end);
 	unsigned long pte_base;
 
 	pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4U |
@@ -2330,47 +2321,52 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 			    _PAGE_CP_4V | _PAGE_CV_4V |
 			    _PAGE_P_4V | _PAGE_W_4V);
 
-	for (; addr < end; addr += VMEMMAP_CHUNK) {
-		unsigned long *vmem_pp -			vmemmap_table + (addr >> VMEMMAP_CHUNK_SHIFT);
-		void *block;
+	pte_base |= _PAGE_PMD_HUGE;
 
-		if (!(*vmem_pp & _PAGE_VALID)) {
-			block = vmemmap_alloc_block(1UL << ILOG2_4MB, node);
-			if (!block)
+	vstart = vstart & PMD_MASK;
+	vend = ALIGN(vend, PMD_SIZE);
+	for (; vstart < vend; vstart += PMD_SIZE) {
+		pgd_t *pgd = pgd_offset_k(vstart);
+		unsigned long pte;
+		pud_t *pud;
+		pmd_t *pmd;
+
+		if (pgd_none(*pgd)) {
+			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
+
+			if (!new)
 				return -ENOMEM;
+			pgd_populate(&init_mm, pgd, new);
+		}
 
-			*vmem_pp = pte_base | __pa(block);
+		pud = pud_offset(pgd, vstart);
+		if (pud_none(*pud)) {
+			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
 
-			/* check to see if we have contiguous blocks */
-			if (addr_end != addr || node_start != node) {
-				if (addr_start)
-					printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
-					       addr_start, addr_end-1, node_start);
-				addr_start = addr;
-				node_start = node;
-			}
-			addr_end = addr + VMEMMAP_CHUNK;
+			if (!new)
+				return -ENOMEM;
+			pud_populate(&init_mm, pud, new);
 		}
-	}
-	return 0;
-}
 
-void __meminit vmemmap_populate_print_last(void)
-{
-	if (addr_start) {
-		printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
-		       addr_start, addr_end-1, node_start);
-		addr_start = 0;
-		addr_end = 0;
-		node_start = 0;
+		pmd = pmd_offset(pud, vstart);
+
+		pte = pmd_val(*pmd);
+		if (!(pte & _PAGE_VALID)) {
+			void *block = vmemmap_alloc_block(PMD_SIZE, node);
+
+			if (!block)
+				return -ENOMEM;
+
+			pmd_val(*pmd) = pte_base | __pa(block);
+		}
 	}
+
+	return 0;
 }
 
 void vmemmap_free(unsigned long start, unsigned long end)
 {
 }
-
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 static void prot_init_common(unsigned long page_none,
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index 29ff73f..a4c0960 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -31,15 +31,4 @@ extern unsigned long kern_locked_tte_data;
 
 void prom_world(int enter);
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-#define VMEMMAP_CHUNK_SHIFT	22
-#define VMEMMAP_CHUNK		(1UL << VMEMMAP_CHUNK_SHIFT)
-#define VMEMMAP_CHUNK_MASK	~(VMEMMAP_CHUNK - 1UL)
-#define VMEMMAP_ALIGN(x)	(((x)+VMEMMAP_CHUNK-1UL)&VMEMMAP_CHUNK_MASK)
-
-#define VMEMMAP_SIZE	((((1UL << MAX_PHYSADDR_BITS) >> PAGE_SHIFT) * \
-			  sizeof(struct page)) >> VMEMMAP_CHUNK_SHIFT)
-extern unsigned long vmemmap_table[VMEMMAP_SIZE];
-#endif
-
 #endif /* _SPARC64_MM_INIT_H */
-- 
1.8.1.2

