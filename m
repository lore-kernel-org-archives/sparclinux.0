From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 08:26:07 +0000
Subject: [PATCH 2/2] sparc32: drop btfixup in pgtable_32.h
Message-Id: <20120513082607.GB16943@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From bd31df87e82ddea253d41422c78353b947b6993d Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 10:21:25 +0200
Subject: [PATCH 2/2] sparc32: drop btfixup in pgtable_32.h

Only one function left using btfixup.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_32.h |   60 ++++++++++++++++-----------
 arch/sparc/kernel/ioport.c          |   10 ++--
 arch/sparc/mm/srmmu.c               |   77 ++++++++---------------------------
 3 files changed, 58 insertions(+), 89 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 6c823f9..088db0c 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -17,6 +17,7 @@
 #include <linux/swap.h>
 #include <asm/types.h>
 #include <asm/pgtsrmmu.h>
+#include <asm/vaddrs.h>
 #include <asm/oplib.h>
 #include <asm/btfixup.h>
 #include <asm/cpu_type.h>
@@ -137,9 +138,15 @@ static inline struct page *pmd_page(pmd_t pmd)
 	return pfn_to_page((pmd_val(pmd) & SRMMU_PTD_PMASK) >> (PAGE_SHIFT-4));
 }
 
-BTFIXUPDEF_CALL_CONST(unsigned long, pgd_page_vaddr, pgd_t)
-
-#define pgd_page_vaddr(pgd) BTFIXUP_CALL(pgd_page_vaddr)(pgd)
+static inline unsigned long pgd_page_vaddr(pgd_t pgd)
+{
+	if (srmmu_device_memory(pgd_val(pgd))) {
+		return ~0;
+	} else {
+		unsigned long v = pgd_val(pgd) & SRMMU_PTD_PMASK;
+		return (unsigned long)__nocache_va(v << 4);
+	}
+}
 
 static inline int pte_present(pte_t pte)
 {
@@ -310,12 +317,10 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
 	return prot;
 }
 
-BTFIXUPDEF_INT(pte_modify_mask)
-
 static pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	return __pte((pte_val(pte) & BTFIXUP_INT(pte_modify_mask)) |
+	return __pte((pte_val(pte) & SRMMU_CHG_MASK) |
 		pgprot_val(newprot));
 }
 
@@ -328,12 +333,14 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 /* Find an entry in the second-level page table.. */
-BTFIXUPDEF_CALL(pmd_t *, pmd_offset, pgd_t *, unsigned long)
-#define pmd_offset(dir,addr) BTFIXUP_CALL(pmd_offset)(dir,addr)
+static inline pmd_t *pmd_offset(pgd_t * dir, unsigned long address)
+{
+	return (pmd_t *) pgd_page_vaddr(*dir) +
+		((address >> PMD_SHIFT) & (PTRS_PER_PMD - 1));
+}
 
 /* Find an entry in the third-level page table.. */
-BTFIXUPDEF_CALL(pte_t *, pte_offset_kernel, pmd_t *, unsigned long)
-#define pte_offset_kernel(dir,addr) BTFIXUP_CALL(pte_offset_kernel)(dir,addr)
+pte_t *pte_offset_kernel(pmd_t * dir, unsigned long address);
 
 /*
  * This shortcut works on sun4m (and sun4d) because the nocache area is static.
@@ -342,9 +349,7 @@ BTFIXUPDEF_CALL(pte_t *, pte_offset_kernel, pmd_t *, unsigned long)
 #define pte_unmap(pte)		do{}while(0)
 
 struct seq_file;
-BTFIXUPDEF_CALL(void, mmu_info, struct seq_file *)
-
-#define mmu_info(p) BTFIXUP_CALL(mmu_info)(p)
+void mmu_info(struct seq_file *m);
 
 /* Fault handler stuff... */
 #define FAULT_CODE_PROT     0x1
@@ -355,22 +360,29 @@ BTFIXUPDEF_CALL(void, update_mmu_cache, struct vm_area_struct *, unsigned long,
 
 #define update_mmu_cache(vma,addr,ptep) BTFIXUP_CALL(update_mmu_cache)(vma,addr,ptep)
 
-BTFIXUPDEF_CALL(void, sparc_mapiorange, unsigned int, unsigned long,
-    unsigned long, unsigned int)
-BTFIXUPDEF_CALL(void, sparc_unmapiorange, unsigned long, unsigned int)
-#define sparc_mapiorange(bus,pa,va,len) BTFIXUP_CALL(sparc_mapiorange)(bus,pa,va,len)
-#define sparc_unmapiorange(va,len) BTFIXUP_CALL(sparc_unmapiorange)(va,len)
+void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
+                      unsigned long xva, unsigned int len);
+void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len);
 
 extern int invalid_segment;
 
 /* Encode and de-code a swap entry */
-BTFIXUPDEF_CALL(unsigned long, __swp_type, swp_entry_t)
-BTFIXUPDEF_CALL(unsigned long, __swp_offset, swp_entry_t)
-BTFIXUPDEF_CALL(swp_entry_t, __swp_entry, unsigned long, unsigned long)
+static inline unsigned long __swp_type(swp_entry_t entry)
+{
+	return (entry.val >> SRMMU_SWP_TYPE_SHIFT) & SRMMU_SWP_TYPE_MASK;
+}
 
-#define __swp_type(__x)			BTFIXUP_CALL(__swp_type)(__x)
-#define __swp_offset(__x)		BTFIXUP_CALL(__swp_offset)(__x)
-#define __swp_entry(__type,__off)	BTFIXUP_CALL(__swp_entry)(__type,__off)
+static inline unsigned long __swp_offset(swp_entry_t entry)
+{
+	return (entry.val >> SRMMU_SWP_OFF_SHIFT) & SRMMU_SWP_OFF_MASK;
+}
+
+static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
+{
+	return (swp_entry_t) {
+		(type & SRMMU_SWP_TYPE_MASK) << SRMMU_SWP_TYPE_SHIFT
+		| (offset & SRMMU_SWP_OFF_MASK) << SRMMU_SWP_OFF_SHIFT };
+}
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 9b93da1..1720fc2 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -229,7 +229,7 @@ _sparc_ioremap(struct resource *res, u32 bus, u32 pa, int sz)
 	}
 
 	pa &= PAGE_MASK;
-	sparc_mapiorange(bus, pa, res->start, resource_size(res));
+	srmmu_mapiorange(bus, pa, res->start, resource_size(res));
 
 	return (void __iomem *)(unsigned long)(res->start + offset);
 }
@@ -243,7 +243,7 @@ static void _sparc_free_io(struct resource *res)
 
 	plen = resource_size(res);
 	BUG_ON((plen & (PAGE_SIZE-1)) != 0);
-	sparc_unmapiorange(res->start, plen);
+	srmmu_unmapiorange(res->start, plen);
 	release_resource(res);
 }
 
@@ -293,7 +293,7 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 	}
 
 	// XXX The mmu_map_dma_area does this for us below, see comments.
-	// sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
+	// srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
 	/*
 	 * XXX That's where sdev would be used. Currently we load
 	 * all iommu tables with the same translations.
@@ -464,7 +464,7 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 		printk("pci_alloc_consistent: cannot occupy 0x%lx", len_total);
 		goto err_nova;
 	}
-	sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
+	srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
 
 	*pba = virt_to_phys(va); /* equals virt_to_bus (R.I.P.) for us. */
 	return (void *) res->start;
@@ -509,7 +509,7 @@ static void pci32_free_coherent(struct device *dev, size_t n, void *p,
 	}
 
 	dma_make_coherent(ba, n);
-	sparc_unmapiorange((unsigned long)p, n);
+	srmmu_unmapiorange((unsigned long)p, n);
 
 	release_resource(res);
 	kfree(res);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d9487d8..32cec26 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -109,10 +109,6 @@ void *srmmu_nocache_pool;
 void *srmmu_nocache_bitmap;
 static struct bit_map srmmu_nocache_map;
 
-static inline unsigned long srmmu_pgd_page(pgd_t pgd)
-{ return srmmu_device_memory(pgd_val(pgd))?~0:(unsigned long)__nocache_va((pgd_val(pgd) & SRMMU_PTD_PMASK) << 4); }
-
-
 static inline int srmmu_pte_none(pte_t pte)
 { return !(pte_val(pte) & 0xFFFFFFF); }
 
@@ -163,15 +159,8 @@ static inline pte_t srmmu_pte_modify(pte_t pte, pgprot_t newprot)
 static inline pgd_t *srmmu_pgd_offset(struct mm_struct * mm, unsigned long address)
 { return mm->pgd + (address >> SRMMU_PGDIR_SHIFT); }
 
-/* Find an entry in the second-level page table.. */
-static inline pmd_t *srmmu_pmd_offset(pgd_t * dir, unsigned long address)
-{
-	return (pmd_t *) srmmu_pgd_page(*dir) +
-	    ((address >> PMD_SHIFT) & (PTRS_PER_PMD - 1));
-}
-
 /* Find an entry in the third-level page table.. */ 
-static inline pte_t *srmmu_pte_offset(pmd_t * dir, unsigned long address)
+pte_t *pte_offset_kernel(pmd_t * dir, unsigned long address)
 {
 	void *pte;
 
@@ -180,23 +169,6 @@ static inline pte_t *srmmu_pte_offset(pmd_t * dir, unsigned long address)
 	    ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1));
 }
 
-static unsigned long srmmu_swp_type(swp_entry_t entry)
-{
-	return (entry.val >> SRMMU_SWP_TYPE_SHIFT) & SRMMU_SWP_TYPE_MASK;
-}
-
-static unsigned long srmmu_swp_offset(swp_entry_t entry)
-{
-	return (entry.val >> SRMMU_SWP_OFF_SHIFT) & SRMMU_SWP_OFF_MASK;
-}
-
-static swp_entry_t srmmu_swp_entry(unsigned long type, unsigned long offset)
-{
-	return (swp_entry_t) {
-		  (type & SRMMU_SWP_TYPE_MASK) << SRMMU_SWP_TYPE_SHIFT
-		| (offset & SRMMU_SWP_OFF_MASK) << SRMMU_SWP_OFF_SHIFT };
-}
-
 /*
  * size: bytes to allocate in the nocache area.
  * align: bytes, number to align at.
@@ -333,8 +305,8 @@ static void __init srmmu_nocache_init(void)
 
 	while (vaddr < srmmu_nocache_end) {
 		pgd = pgd_offset_k(vaddr);
-		pmd = srmmu_pmd_offset(__nocache_fix(pgd), vaddr);
-		pte = srmmu_pte_offset(__nocache_fix(pmd), vaddr);
+		pmd = pmd_offset(__nocache_fix(pgd), vaddr);
+		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
 
 		pteval = ((paddr >> 4) | SRMMU_ET_PTE | SRMMU_PRIV);
 
@@ -467,8 +439,8 @@ static inline void srmmu_mapioaddr(unsigned long physaddr,
 
 	physaddr &= PAGE_MASK;
 	pgdp = pgd_offset_k(virt_addr);
-	pmdp = srmmu_pmd_offset(pgdp, virt_addr);
-	ptep = srmmu_pte_offset(pmdp, virt_addr);
+	pmdp = pmd_offset(pgdp, virt_addr);
+	ptep = pte_offset_kernel(pmdp, virt_addr);
 	tmp = (physaddr >> 4) | SRMMU_ET_PTE;
 
 	/*
@@ -482,8 +454,8 @@ static inline void srmmu_mapioaddr(unsigned long physaddr,
 	set_pte(ptep, __pte(tmp));
 }
 
-static void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
-    unsigned long xva, unsigned int len)
+void srmmu_mapiorange(unsigned int bus, unsigned long xpa,
+		      unsigned long xva, unsigned int len)
 {
 	while (len != 0) {
 		len -= PAGE_SIZE;
@@ -501,14 +473,14 @@ static inline void srmmu_unmapioaddr(unsigned long virt_addr)
 	pte_t *ptep;
 
 	pgdp = pgd_offset_k(virt_addr);
-	pmdp = srmmu_pmd_offset(pgdp, virt_addr);
-	ptep = srmmu_pte_offset(pmdp, virt_addr);
+	pmdp = pmd_offset(pgdp, virt_addr);
+	ptep = pte_offset_kernel(pmdp, virt_addr);
 
 	/* No need to flush uncacheable page. */
 	__pte_clear(ptep);
 }
 
-static void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len)
+void srmmu_unmapiorange(unsigned long virt_addr, unsigned int len)
 {
 	while (len != 0) {
 		len -= PAGE_SIZE;
@@ -949,7 +921,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
 			pgd_set(__nocache_fix(pgdp), pmdp);
 		}
-		pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
+		pmdp = pmd_offset(__nocache_fix(pgdp), start);
 		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
 			ptep = (pte_t *)__srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
@@ -979,7 +951,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 			memset(pmdp, 0, SRMMU_PMD_TABLE_SIZE);
 			pgd_set(pgdp, pmdp);
 		}
-		pmdp = srmmu_pmd_offset(pgdp, start);
+		pmdp = pmd_offset(pgdp, start);
 		if(srmmu_pmd_none(*pmdp)) {
 			ptep = (pte_t *) __srmmu_get_nocache(PTE_SIZE,
 							     PTE_SIZE);
@@ -1045,7 +1017,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
 			pgd_set(__nocache_fix(pgdp), pmdp);
 		}
-		pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
+		pmdp = pmd_offset(__nocache_fix(pgdp), start);
 		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
 			ptep = (pte_t *) __srmmu_get_nocache(PTE_SIZE,
 							     PTE_SIZE);
@@ -1066,7 +1038,7 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			start += SRMMU_REAL_PMD_SIZE;
 			continue;
 		}
-		ptep = srmmu_pte_offset(__nocache_fix(pmdp), start);
+		ptep = pte_offset_kernel(__nocache_fix(pmdp), start);
 		*(pte_t *)__nocache_fix(ptep) = __pte(prompte);
 		start += PAGE_SIZE;
 	}
@@ -1200,8 +1172,8 @@ void __init srmmu_paging_init(void)
 	srmmu_allocate_ptable_skeleton(PKMAP_BASE, PKMAP_END);
 
 	pgd = pgd_offset_k(PKMAP_BASE);
-	pmd = srmmu_pmd_offset(pgd, PKMAP_BASE);
-	pte = srmmu_pte_offset(pmd, PKMAP_BASE);
+	pmd = pmd_offset(pgd, PKMAP_BASE);
+	pte = pte_offset_kernel(pmd, PKMAP_BASE);
 	pkmap_page_table = pte;
 
 	flush_cache_all();
@@ -1233,7 +1205,7 @@ void __init srmmu_paging_init(void)
 	}
 }
 
-static void srmmu_mmu_info(struct seq_file *m)
+void mmu_info(struct seq_file *m)
 {
 	seq_printf(m, 
 		   "MMU type\t: %s\n"
@@ -2015,24 +1987,9 @@ void __init load_mmu(void)
 	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
 #endif
 
-	BTFIXUPSET_CALL(pgd_page_vaddr, srmmu_pgd_page, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_INT(pte_modify_mask, SRMMU_CHG_MASK);
-	BTFIXUPSET_CALL(pmd_offset, srmmu_pmd_offset, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(pte_offset_kernel, srmmu_pte_offset, BTFIXUPCALL_NORM);
-
 	BTFIXUPSET_CALL(update_mmu_cache, srmmu_update_mmu_cache, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(destroy_context, srmmu_destroy_context, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_CALL(sparc_mapiorange, srmmu_mapiorange, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(sparc_unmapiorange, srmmu_unmapiorange, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(__swp_type, srmmu_swp_type, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__swp_offset, srmmu_swp_offset, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__swp_entry, srmmu_swp_entry, BTFIXUPCALL_NORM);
-
-	BTFIXUPSET_CALL(mmu_info, srmmu_mmu_info, BTFIXUPCALL_NORM);
-
 	get_srmmu_type();
 
 #ifdef CONFIG_SMP
-- 
1.6.0.6

