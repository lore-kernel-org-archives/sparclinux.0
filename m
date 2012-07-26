From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:13 +0000
Subject: [PATCH 03/18] sparc32: fix coding-style in srmmu.c
Message-Id: <1343336548-3879-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix the most annoying issues that distracts me:
- whitespace
- missing space after "if" and "while"
- spaces around operators
and similar simple things.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/srmmu.c |  132 ++++++++++++++++++++++++-------------------------
 1 files changed, 64 insertions(+), 68 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 533143b..4b00f69 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -136,8 +136,8 @@ void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep)
 	}
 }
 
-/* Find an entry in the third-level page table.. */ 
-pte_t *pte_offset_kernel(pmd_t * dir, unsigned long address)
+/* Find an entry in the third-level page table.. */
+pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
 {
 	void *pte;
 
@@ -166,7 +166,7 @@ static unsigned long __srmmu_get_nocache(int size, int align)
 	BUG_ON(align > SRMMU_NOCACHE_ALIGN_MAX);
 
 	offset = bit_map_string_get(&srmmu_nocache_map,
-		       			size >> SRMMU_NOCACHE_BITMAP_SHIFT,
+					size >> SRMMU_NOCACHE_BITMAP_SHIFT,
 					align >> SRMMU_NOCACHE_BITMAP_SHIFT);
 	if (offset = -1) {
 		printk("srmmu: out of nocache %d: %d/%d\n",
@@ -199,7 +199,7 @@ void srmmu_free_nocache(unsigned long vaddr, int size)
 		    vaddr, (unsigned long)SRMMU_NOCACHE_VADDR);
 		BUG();
 	}
-	if (vaddr+size > srmmu_nocache_end) {
+	if (vaddr + size > srmmu_nocache_end) {
 		printk("Vaddr %lx is bigger than nocache end 0x%lx\n",
 		    vaddr, srmmu_nocache_end);
 		BUG();
@@ -212,7 +212,7 @@ void srmmu_free_nocache(unsigned long vaddr, int size)
 		printk("Size 0x%x is too small\n", size);
 		BUG();
 	}
-	if (vaddr & (size-1)) {
+	if (vaddr & (size - 1)) {
 		printk("Vaddr %lx is not aligned to size 0x%x\n", vaddr, size);
 		BUG();
 	}
@@ -330,7 +330,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 
 	if ((pte = (unsigned long)pte_alloc_one_kernel(mm, address)) = 0)
 		return NULL;
-	page = pfn_to_page( __nocache_pa(pte) >> PAGE_SHIFT );
+	page = pfn_to_page(__nocache_pa(pte) >> PAGE_SHIFT);
 	pgtable_page_ctor(page);
 	return page;
 }
@@ -355,7 +355,7 @@ static inline void alloc_context(struct mm_struct *old_mm, struct mm_struct *mm)
 	struct ctx_list *ctxp;
 
 	ctxp = ctx_free.next;
-	if(ctxp != &ctx_free) {
+	if (ctxp != &ctx_free) {
 		remove_from_ctx_list(ctxp);
 		add_to_used_ctxlist(ctxp);
 		mm->context = ctxp->ctx_number;
@@ -363,9 +363,9 @@ static inline void alloc_context(struct mm_struct *old_mm, struct mm_struct *mm)
 		return;
 	}
 	ctxp = ctx_used.next;
-	if(ctxp->ctx_mm = old_mm)
+	if (ctxp->ctx_mm = old_mm)
 		ctxp = ctxp->next;
-	if(ctxp = &ctx_used)
+	if (ctxp = &ctx_used)
 		panic("out of mmu contexts");
 	flush_cache_mm(ctxp->ctx_mm);
 	flush_tlb_mm(ctxp->ctx_mm);
@@ -389,7 +389,7 @@ static inline void free_context(int context)
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk)
 {
-	if(mm->context = NO_CONTEXT) {
+	if (mm->context = NO_CONTEXT) {
 		spin_lock(&srmmu_context_spinlock);
 		alloc_context(old_mm, mm);
 		spin_unlock(&srmmu_context_spinlock);
@@ -407,7 +407,7 @@ void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 
 /* Low level IO area allocation on the SRMMU. */
 static inline void srmmu_mapioaddr(unsigned long physaddr,
-    unsigned long virt_addr, int bus_type)
+				   unsigned long virt_addr, int bus_type)
 {
 	pgd_t *pgdp;
 	pmd_t *pmdp;
@@ -420,8 +420,7 @@ static inline void srmmu_mapioaddr(unsigned long physaddr,
 	ptep = pte_offset_kernel(pmdp, virt_addr);
 	tmp = (physaddr >> 4) | SRMMU_ET_PTE;
 
-	/*
-	 * I need to test whether this is consistent over all
+	/* I need to test whether this is consistent over all
 	 * sun4m's.  The bus_type represents the upper 4 bits of
 	 * 36-bit physical address on the I/O space lines...
 	 */
@@ -591,7 +590,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	while(start < end) {
+	while (start < end) {
 		pgdp = pgd_offset_k(start);
 		if (pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
 			pmdp = (pmd_t *) __srmmu_get_nocache(
@@ -602,7 +601,7 @@ static void __init srmmu_early_allocate_ptable_skeleton(unsigned long start,
 			pgd_set(__nocache_fix(pgdp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pgdp), start);
-		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
 			ptep = (pte_t *)__srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
@@ -622,7 +621,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	while(start < end) {
+	while (start < end) {
 		pgdp = pgd_offset_k(start);
 		if (pgd_none(*pgdp)) {
 			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
@@ -632,7 +631,7 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 			pgd_set(pgdp, pmdp);
 		}
 		pmdp = pmd_offset(pgdp, start);
-		if(srmmu_pmd_none(*pmdp)) {
+		if (srmmu_pmd_none(*pmdp)) {
 			ptep = (pte_t *) __srmmu_get_nocache(PTE_SIZE,
 							     PTE_SIZE);
 			if (ptep = NULL)
@@ -677,32 +676,32 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 	int what = 0; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
 	unsigned long prompte;
 
-	while(start <= end) {
+	while (start <= end) {
 		if (start = 0)
 			break; /* probably wrap around */
-		if(start = 0xfef00000)
+		if (start = 0xfef00000)
 			start = KADB_DEBUGGER_BEGVM;
-		if(!(prompte = srmmu_probe(start))) {
+		if (!(prompte = srmmu_probe(start))) {
 			start += PAGE_SIZE;
 			continue;
 		}
-    
+
 		/* A red snapper, see what it really is. */
 		what = 0;
-    
-		if(!(start & ~(SRMMU_REAL_PMD_MASK))) {
-			if(srmmu_probe((start-PAGE_SIZE) + SRMMU_REAL_PMD_SIZE) = prompte)
+
+		if (!(start & ~(SRMMU_REAL_PMD_MASK))) {
+			if (srmmu_probe((start - PAGE_SIZE) + SRMMU_REAL_PMD_SIZE) = prompte)
 				what = 1;
 		}
-    
-		if(!(start & ~(SRMMU_PGDIR_MASK))) {
-			if(srmmu_probe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE) =
+
+		if (!(start & ~(SRMMU_PGDIR_MASK))) {
+			if (srmmu_probe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE) =
 			   prompte)
 				what = 2;
 		}
-    
+
 		pgdp = pgd_offset_k(start);
-		if(what = 2) {
+		if (what = 2) {
 			*(pgd_t *)__nocache_fix(pgdp) = __pgd(prompte);
 			start += SRMMU_PGDIR_SIZE;
 			continue;
@@ -715,17 +714,15 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 			pgd_set(__nocache_fix(pgdp), pmdp);
 		}
 		pmdp = pmd_offset(__nocache_fix(pgdp), start);
-		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
-			ptep = (pte_t *) __srmmu_get_nocache(PTE_SIZE,
-							     PTE_SIZE);
+		if (srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+			ptep = (pte_t *)__srmmu_get_nocache(PTE_SIZE, PTE_SIZE);
 			if (ptep = NULL)
 				early_pgtable_allocfail("pte");
 			memset(__nocache_fix(ptep), 0, PTE_SIZE);
 			pmd_set(__nocache_fix(pmdp), ptep);
 		}
-		if(what = 1) {
-			/*
-			 * We bend the rule where all 16 PTPs in a pmd_t point
+		if (what = 1) {
+			/* We bend the rule where all 16 PTPs in a pmd_t point
 			 * inside the same PTE page, and we leak a perfectly
 			 * good hardware PTE piece. Alternatives seem worse.
 			 */
@@ -765,11 +762,11 @@ static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
 
 	if (vstart < min_vaddr || vstart >= max_vaddr)
 		return vstart;
-	
+
 	if (vend > max_vaddr || vend < min_vaddr)
 		vend = max_vaddr;
 
-	while(vstart < vend) {
+	while (vstart < vend) {
 		do_large_mapping(vstart, pstart);
 		vstart += SRMMU_PGDIR_SIZE; pstart += SRMMU_PGDIR_SIZE;
 	}
@@ -814,9 +811,9 @@ void __init srmmu_paging_init(void)
 		/* Find the number of contexts on the srmmu. */
 		cpunode = prom_getchild(prom_root_node);
 		num_contexts = 0;
-		while(cpunode != 0) {
+		while (cpunode != 0) {
 			prom_getstring(cpunode, "device_type", node_str, sizeof(node_str));
-			if(!strcmp(node_str, "cpu")) {
+			if (!strcmp(node_str, "cpu")) {
 				num_contexts = prom_getintdefault(cpunode, "mmu-nctx", 0x8);
 				break;
 			}
@@ -824,7 +821,7 @@ void __init srmmu_paging_init(void)
 		}
 	}
 
-	if(!num_contexts) {
+	if (!num_contexts) {
 		prom_printf("Something wrong, can't find cpu node in paging_init.\n");
 		prom_halt();
 	}
@@ -834,14 +831,14 @@ void __init srmmu_paging_init(void)
 
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
-        srmmu_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM-PAGE_SIZE));
 	map_kernel();
 
 	/* ctx table has to be physically aligned to its size */
 	srmmu_context_table = (ctxd_t *)__srmmu_get_nocache(num_contexts*sizeof(ctxd_t), num_contexts*sizeof(ctxd_t));
 	srmmu_ctx_table_phys = (ctxd_t *)__nocache_pa((unsigned long)srmmu_context_table);
 
-	for(i = 0; i < num_contexts; i++)
+	for (i = 0; i < num_contexts; i++)
 		srmmu_ctxd_set((ctxd_t *)__nocache_fix(&srmmu_context_table[i]), srmmu_swapper_pg_dir);
 
 	flush_cache_all();
@@ -897,7 +894,7 @@ void __init srmmu_paging_init(void)
 
 void mmu_info(struct seq_file *m)
 {
-	seq_printf(m, 
+	seq_printf(m,
 		   "MMU type\t: %s\n"
 		   "contexts\t: %d\n"
 		   "nocache total\t: %ld\n"
@@ -911,7 +908,7 @@ void mmu_info(struct seq_file *m)
 void destroy_context(struct mm_struct *mm)
 {
 
-	if(mm->context != NO_CONTEXT) {
+	if (mm->context != NO_CONTEXT) {
 		flush_cache_mm(mm);
 		srmmu_ctxd_set(&srmmu_context_table[mm->context], srmmu_swapper_pg_dir);
 		flush_tlb_mm(mm);
@@ -941,13 +938,12 @@ static void __init init_vac_layout(void)
 #endif
 
 	nd = prom_getchild(prom_root_node);
-	while((nd = prom_getsibling(nd)) != 0) {
+	while ((nd = prom_getsibling(nd)) != 0) {
 		prom_getstring(nd, "device_type", node_str, sizeof(node_str));
-		if(!strcmp(node_str, "cpu")) {
+		if (!strcmp(node_str, "cpu")) {
 			vac_line_size = prom_getint(nd, "cache-line-size");
 			if (vac_line_size = -1) {
-				prom_printf("can't determine cache-line-size, "
-					    "halting.\n");
+				prom_printf("can't determine cache-line-size, halting.\n");
 				prom_halt();
 			}
 			cache_lines = prom_getint(nd, "cache-nlines");
@@ -958,9 +954,9 @@ static void __init init_vac_layout(void)
 
 			vac_cache_size = cache_lines * vac_line_size;
 #ifdef CONFIG_SMP
-			if(vac_cache_size > max_size)
+			if (vac_cache_size > max_size)
 				max_size = vac_cache_size;
-			if(vac_line_size < min_line_size)
+			if (vac_line_size < min_line_size)
 				min_line_size = vac_line_size;
 			//FIXME: cpus not contiguous!!
 			cpu++;
@@ -971,7 +967,7 @@ static void __init init_vac_layout(void)
 #endif
 		}
 	}
-	if(nd = 0) {
+	if (nd = 0) {
 		prom_printf("No CPU nodes found, halting.\n");
 		prom_halt();
 	}
@@ -1082,7 +1078,7 @@ static void __init init_swift(void)
 			     "=r" (swift_rev) :
 			     "r" (SWIFT_MASKID_ADDR), "i" (ASI_M_BYPASS));
 	srmmu_name = "Fujitsu Swift";
-	switch(swift_rev) {
+	switch (swift_rev) {
 	case 0x11:
 	case 0x20:
 	case 0x23:
@@ -1222,10 +1218,11 @@ static void __cpuinit poke_turbosparc(void)
 
 	/* Clear any crap from the cache or else... */
 	turbosparc_flush_cache_all();
-	mreg &= ~(TURBOSPARC_ICENABLE | TURBOSPARC_DCENABLE); /* Temporarily disable I & D caches */
+	/* Temporarily disable I & D caches */
+	mreg &= ~(TURBOSPARC_ICENABLE | TURBOSPARC_DCENABLE);
 	mreg &= ~(TURBOSPARC_PCENABLE);		/* Don't check parity */
 	srmmu_set_mmureg(mreg);
-	
+
 	ccreg = turbosparc_get_ccreg();
 
 #ifdef TURBOSPARC_WRITEBACK
@@ -1248,7 +1245,7 @@ static void __cpuinit poke_turbosparc(void)
 	default:
 		ccreg |= (TURBOSPARC_SCENABLE);
 	}
-	turbosparc_set_ccreg (ccreg);
+	turbosparc_set_ccreg(ccreg);
 
 	mreg |= (TURBOSPARC_ICENABLE | TURBOSPARC_DCENABLE); /* I & D caches on */
 	mreg |= (TURBOSPARC_ICSNOOP);		/* Icache snooping on */
@@ -1342,7 +1339,7 @@ static void __cpuinit poke_viking(void)
 		unsigned long bpreg;
 
 		mreg &= ~(VIKING_TCENABLE);
-		if(smp_catch++) {
+		if (smp_catch++) {
 			/* Must disable mixed-cmd mode here for other cpu's. */
 			bpreg = viking_get_bpreg();
 			bpreg &= ~(VIKING_ACTION_MIX);
@@ -1411,7 +1408,7 @@ static void __init init_viking(void)
 	unsigned long mreg = srmmu_get_mmureg();
 
 	/* Ahhh, the viking.  SRMMU VLSI abortion number two... */
-	if(mreg & VIKING_MMODE) {
+	if (mreg & VIKING_MMODE) {
 		srmmu_name = "TI Viking";
 		viking_mxcc_present = 0;
 		msi_set_sync();
@@ -1467,8 +1464,8 @@ static void __init get_srmmu_type(void)
 	}
 
 	/* Second, check for HyperSparc or Cypress. */
-	if(mod_typ = 1) {
-		switch(mod_rev) {
+	if (mod_typ = 1) {
+		switch (mod_rev) {
 		case 7:
 			/* UP or MP Hypersparc */
 			init_hypersparc();
@@ -1488,9 +1485,8 @@ static void __init get_srmmu_type(void)
 		}
 		return;
 	}
-	
-	/*
-	 * Now Fujitsu TurboSparc. It might happen that it is
+
+	/* Now Fujitsu TurboSparc. It might happen that it is
 	 * in Swift emulation mode, so we will check later...
 	 */
 	if (psr_typ = 0 && psr_vers = 5) {
@@ -1499,15 +1495,15 @@ static void __init get_srmmu_type(void)
 	}
 
 	/* Next check for Fujitsu Swift. */
-	if(psr_typ = 0 && psr_vers = 4) {
+	if (psr_typ = 0 && psr_vers = 4) {
 		phandle cpunode;
 		char node_str[128];
 
 		/* Look if it is not a TurboSparc emulating Swift... */
 		cpunode = prom_getchild(prom_root_node);
-		while((cpunode = prom_getsibling(cpunode)) != 0) {
+		while ((cpunode = prom_getsibling(cpunode)) != 0) {
 			prom_getstring(cpunode, "device_type", node_str, sizeof(node_str));
-			if(!strcmp(node_str, "cpu")) {
+			if (!strcmp(node_str, "cpu")) {
 				if (!prom_getintdefault(cpunode, "psr-implementation", 1) &&
 				    prom_getintdefault(cpunode, "psr-version", 1) = 5) {
 					init_turbosparc();
@@ -1516,13 +1512,13 @@ static void __init get_srmmu_type(void)
 				break;
 			}
 		}
-		
+
 		init_swift();
 		return;
 	}
 
 	/* Now the Viking family of srmmu. */
-	if(psr_typ = 4 &&
+	if (psr_typ = 4 &&
 	   ((psr_vers = 0) ||
 	    ((psr_vers = 1) && (mod_typ = 0) && (mod_rev = 0)))) {
 		init_viking();
@@ -1530,7 +1526,7 @@ static void __init get_srmmu_type(void)
 	}
 
 	/* Finally the Tsunami. */
-	if(psr_typ = 4 && psr_vers = 1 && (mod_typ || mod_rev)) {
+	if (psr_typ = 4 && psr_vers = 1 && (mod_typ || mod_rev)) {
 		init_tsunami();
 		return;
 	}
-- 
1.6.0.6

