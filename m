From: David Miller <davem@davemloft.net>
Date: Thu, 18 Sep 2014 04:45:38 +0000
Subject: Re: [PATCH] sparc64: vmemmap boot sizing
Message-Id: <20140918.004538.2180447417605510683.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886404-16359-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 12:53:24 -0400

> From: bob picco <bpicco@meloft.net>
> 
> This patch attempts to accomodate the coarse grain memory controller unit
> (MCU) in Niagara5 and later generations. This is achieved by having a root
> array which is array of pointers to arrays of TTE-s for vmemmap. The ktlb
> paths are patched when using the root array.
> 
> Older sparc64 should have the net effect of being treated similar to before
> the introduction of Niagara5 and Athena which caused an increase in memory
> footprint of static sparc64 related memory management items.
> 
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

We already have a rather nice data structure for storing sparse mappings
of the virtual address space, in the form of the Linux page tables, so
let's just use that. :-)

This also shrinks the kernel BSS by 2MB.

==========
[PATCH] sparc64: Use kernel page tables for vmemmap.

For sparse memory configurations, the vmemmap array behaves terribly
and it takes up an inordinate amount of space in the BSS section of
the kernel image unconditionally.

Just build huge PMDs and look them up just like we do for TLB misses
in the vmalloc area.

Align debugging logs with what x86-64 does.

Kernel BSS shrinks by about 2MB.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/tsb.h | 19 ++++++++++++++++
 arch/sparc/kernel/ktlb.S     | 11 +++++----
 arch/sparc/mm/init_64.c      | 53 ++++++++++++++++++++++++++++----------------
 arch/sparc/mm/init_64.h      | 11 ---------
 4 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/include/asm/tsb.h b/arch/sparc/include/asm/tsb.h
index def62ed4..56acef9 100644
--- a/arch/sparc/include/asm/tsb.h
+++ b/arch/sparc/include/asm/tsb.h
@@ -155,6 +155,25 @@ extern struct tsb_phys_patch_entry __tsb_phys_patch, __tsb_phys_patch_end;
 	andn		REG2, 0x7, REG2; \
 	add		REG1, REG2, REG1;
 
+	/* Do a 4MB kernel page table walk.  Leaves large PMD value in
+	 * REG1.  Jumps to FAIL_LABEL on early page table walk termination.
+	 * VADDR will not be clobbered, but REG2 will.
+	 */
+#define KERN_4M_PGTABLE_WALK(VADDR, REG1, REG2, FAIL_LABEL)	\
+	sethi		%hi(swapper_pg_dir), REG1; \
+	or		REG1, %lo(swapper_pg_dir), REG1; \
+	sllx		VADDR, 64 - (PGDIR_SHIFT + PGDIR_BITS), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
+	andn		REG2, 0x7, REG2; \
+	ldx		[REG1 + REG2], REG1; \
+	brz,pn		REG1, FAIL_LABEL; \
+	 sllx		VADDR, 64 - (PMD_SHIFT + PMD_BITS), REG2; \
+	srlx		REG2, 64 - PAGE_SHIFT, REG2; \
+	andn		REG2, 0x7, REG2; \
+	ldxa		[REG1 + REG2] ASI_PHYS_USE_EC, REG1; \
+	brz,pn		REG1, FAIL_LABEL; \
+	 nop;
+
 	/* PMD has been loaded into REG1, interpret the value, seeing
 	 * if it is a HUGE PMD or a normal one.  If it is not valid
 	 * then jump to FAIL_LABEL.  If it is a HUGE PMD, and it
diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 7036a65..92762f1 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -247,13 +247,12 @@ kvmap_dtlb_load:
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 kvmap_vmemmap:
-	sub		%g4, %g5, %g5
-	srlx		%g5, ILOG2_4MB, %g5
-	sethi		%hi(vmemmap_table), %g1
-	sllx		%g5, 3, %g5
-	or		%g1, %lo(vmemmap_table), %g1
+	KERN_4M_PGTABLE_WALK(%g4, %g5, %g2, kvmap_dtlb_longpath)
+	sethi		%hi(4 * 1024 * 1024), %g2
+	andn		%g5, %g2, %g5
+	and		%g4, %g2, %g2
 	ba,pt		%xcc, kvmap_dtlb_load
-	 ldx		[%g1 + %g5], %g5
+	 or		%g5, %g2, %g5
 #endif
 
 kvmap_dtlb_nonlinear:
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4acabb0..c46d44a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2332,18 +2332,13 @@ unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-unsigned long vmemmap_table[VMEMMAP_SIZE];
-
 static long __meminitdata addr_start, addr_end;
+static void __meminitdata *p_start, *p_end;
 static int __meminitdata node_start;
 
 int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 			       int node)
 {
-	unsigned long phys_start = (vstart - VMEMMAP_BASE);
-	unsigned long phys_end = (vend - VMEMMAP_BASE);
-	unsigned long addr = phys_start & VMEMMAP_CHUNK_MASK;
-	unsigned long end = VMEMMAP_ALIGN(phys_end);
 	unsigned long pte_base;
 
 	pte_base = (_PAGE_VALID | _PAGE_SZ4MB_4U |
@@ -2354,29 +2349,49 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 			    _PAGE_CP_4V | _PAGE_CV_4V |
 			    _PAGE_P_4V | _PAGE_W_4V);
 
-	for (; addr < end; addr += VMEMMAP_CHUNK) {
-		unsigned long *vmem_pp -			vmemmap_table + (addr >> VMEMMAP_CHUNK_SHIFT);
-		void *block;
+	vstart = vstart & PMD_MASK;
+	vend = ALIGN(vend, PMD_SIZE);
+	for (; vstart < vend; vstart += PMD_SIZE) {
+		pgd_t *pgd = pgd_offset_k(vstart);
+		unsigned long pte;
+		pud_t *pud;
+		pmd_t *pmd;
+
+		pud = pud_offset(pgd, vstart);
+		if (pud_none(*pud)) {
+			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
+
+			if (!new)
+				return -ENOMEM;
+			pud_populate(&init_mm, pud, new);
+		}
+
+		pmd = pmd_offset(pud, vstart);
+
+		pte = pmd_val(*pmd);
+		if (!(pte & _PAGE_VALID)) {
+			void *block = vmemmap_alloc_block(PMD_SIZE, node);
 
-		if (!(*vmem_pp & _PAGE_VALID)) {
-			block = vmemmap_alloc_block(1UL << ILOG2_4MB, node);
 			if (!block)
 				return -ENOMEM;
 
-			*vmem_pp = pte_base | __pa(block);
+			pmd_val(*pmd) = pte_base | __pa(block);
 
 			/* check to see if we have contiguous blocks */
-			if (addr_end != addr || node_start != node) {
-				if (addr_start)
-					printk(KERN_DEBUG " [%lx-%lx] on node %d\n",
-					       addr_start, addr_end-1, node_start);
-				addr_start = addr;
+			if (p_end != block || node_start != node) {
+				if (p_start)
+					printk(KERN_DEBUG " [%lx-%lx] PMD -> [%p-%p] on node %d\n",
+					       addr_start, addr_end-1, p_start, p_end-1, node_start);
+				addr_start = vstart;
 				node_start = node;
+				p_start = block;
 			}
-			addr_end = addr + VMEMMAP_CHUNK;
+
+			addr_end = vstart + PMD_SIZE;
+			p_end = block + PMD_SIZE;
 		}
 	}
+
 	return 0;
 }
 
diff --git a/arch/sparc/mm/init_64.h b/arch/sparc/mm/init_64.h
index bdef0a6..0718582 100644
--- a/arch/sparc/mm/init_64.h
+++ b/arch/sparc/mm/init_64.h
@@ -35,15 +35,4 @@ extern unsigned long kern_locked_tte_data;
 
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

