From: Bob Breuer <breuerr@mc.net>
Date: Wed, 17 Nov 2004 03:35:03 +0000
Subject: Re: hypersparc dvma aliasing
Message-Id: <419AC6E7.5000202@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419AB742.1000103@mc.net>
In-Reply-To: <419AB742.1000103@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's the preliminary patch.  This time around, both the hme
and esp drivers are working for me.  This replaces my previous
patch and is against the vanilla 2.6.9 kernel.  I've tried to
reduce the amount of unnecessary cache flushing, therefore this
will need some testing on non-hypersparc cpus also.  It needs
some cleanup yet, and will be rediffed against a later kernel.
I'm looking for comments and feedback.

Bob

--- linux-2.6.9/include/asm-sparc/bitext.h.orig	2004-10-18 16:54:40.000000000 -0500
+++ linux-2.6.9/include/asm-sparc/bitext.h	2004-11-15 23:41:03.000000000 -0600
@@ -17,6 +17,7 @@ struct bit_map {
  	int last_off;
  	int last_size;
  	int first_free;
+	int num_colors;
  };

  extern int bit_map_string_get(struct bit_map *t, int len, int align);
--- linux-2.6.9/arch/sparc/mm/iommu.c.orig	2004-10-18 16:55:29.000000000 -0500
+++ linux-2.6.9/arch/sparc/mm/iommu.c	2004-11-16 20:30:35.563411000 -0600
@@ -119,6 +119,11 @@ iommu_init(int iommund, struct sbus_bus
  		prom_halt();
  	}
  	bit_map_init(&iommu->usemap, bitmap, IOMMU_NPTES);
+	if (srmmu_modtype = HyperSparc)
+		/* fixme: use real cache size */
+		iommu->usemap.num_colors = (1<<20) >> PAGE_SHIFT;
+	else
+		iommu->usemap.num_colors = 1;

  	printk("IOMMU: impl %d vers %d table 0x%p[%d B] map [%d b]\n",
  	    impl, vers, iommu->page_table,
@@ -128,7 +133,9 @@ iommu_init(int iommund, struct sbus_bus
  }

  /* This begs to be btfixup-ed by srmmu. */
-static void iommu_viking_flush_iotlb(iopte_t *iopte, unsigned int niopte)
+/* Flush the iotlb entries to ram. */
+/* This could be better if we didn't have to flush whole pages. */
+static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
  {
  	unsigned long start;
  	unsigned long end;
@@ -145,9 +152,16 @@ static void iommu_viking_flush_iotlb(iop
  			viking_flush_page(start);
  			start += PAGE_SIZE;
  		}
+	} else {
+		while(start < end) {
+			__flush_page_to_ram(start);
+			start += PAGE_SIZE;
+		}
  	}
  }

+//#define IOMMU_MAP_1TO1
+
  static u32 iommu_get_one(struct page *page, int npages, struct sbus_bus *sbus)
  {
  	struct iommu_struct *iommu = sbus->iommu;
@@ -156,7 +170,12 @@ static u32 iommu_get_one(struct page *pa
  	unsigned int busa, busa0;
  	int i;

-	ioptex = bit_map_string_get(&iommu->usemap, npages, 1);
+#ifdef IOMMU_MAP_1TO1
+	ioptex = page_to_pfn(page); /* physical address index */
+#else
+	/* page color = physical address */
+	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
+#endif
  	if (ioptex < 0)
  		panic("iommu out");
  	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
@@ -172,7 +191,7 @@ static u32 iommu_get_one(struct page *pa
  		page++;
  	}

-	iommu_viking_flush_iotlb(iopte0, npages);
+	iommu_flush_iotlb(iopte0, npages);

  	return busa0;
  }
@@ -286,7 +305,9 @@ static void iommu_release_one(u32 busa,
  		iommu_invalidate_page(iommu->regs, busa);
  		busa += PAGE_SIZE;
  	}
+#ifndef IOMMU_MAP_1TO1
  	bit_map_clear(&iommu->usemap, ioptex, npages);
+#endif
  }

  static void iommu_release_scsi_one(__u32 vaddr, unsigned long len, struct sbus_bus *sbus)
@@ -327,7 +348,13 @@ static int iommu_map_dma_area(dma_addr_t
  	if ((addr & ~PAGE_MASK) != 0) BUG();
  	if ((len & ~PAGE_MASK) != 0) BUG();

-	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT, 1);
+#ifdef IOMMU_MAP_1TO1
+	ioptex = (addr - iommu->start) >> PAGE_SHIFT;
+#else
+	/* page color = physical address */
+	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT,
+		addr >> PAGE_SHIFT);
+#endif
  	if (ioptex < 0)
  		panic("iommu out");

@@ -335,25 +362,28 @@ static int iommu_map_dma_area(dma_addr_t
  	first = iopte;
  	end = addr + len;
  	while(addr < end) {
+		pgd_t *pgdp;
+		pmd_t *pmdp;
+		pte_t *ptep;
+
  		page = va;
+
+		/* if we change to uncached, flush the cache first */
+		if (!(ioperm_noc & IOPTE_CACHE))
  		{
-			pgd_t *pgdp;
-			pmd_t *pmdp;
-			pte_t *ptep;
-
-			if (viking_mxcc_present)
-				viking_mxcc_flush_page(page);
-			else if (viking_flush)
+			if (viking_flush)
  				viking_flush_page(page);
  			else
+				/* Is everything else covered here? */
  				__flush_page_to_ram(page);
+		}

-			pgdp = pgd_offset(&init_mm, addr);
-			pmdp = pmd_offset(pgdp, addr);
-			ptep = pte_offset_map(pmdp, addr);
+		pgdp = pgd_offset(&init_mm, addr);
+		pmdp = pmd_offset(pgdp, addr);
+		ptep = pte_offset_map(pmdp, addr);
+
+		set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));

-			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
-		}
  		iopte_val(*iopte++)   		    MKIOPTE(page_to_pfn(virt_to_page(page)), ioperm_noc);
  		addr += PAGE_SIZE;
@@ -370,8 +400,16 @@ static int iommu_map_dma_area(dma_addr_t
  	 *        cpu mappings of pages potentially in the cpu caches, we have
  	 *        to handle the latter case as well.
  	 */
-	flush_cache_all();
-	iommu_viking_flush_iotlb(first, len >> PAGE_SHIFT);
+	/* With regards to cache flushing, there are 3 things to worry about:
+	 *
+	 * 1. the data in the region we are messing with
+	 *   - handled in the loop only if we are not I/O coherent
+	 * 2. the modified pte values
+	 *   - currently uncached
+	 * 3. the modifed iopte values
+	 *   - anything with a cache that is not write-through needs flushing
+	 */
+	iommu_flush_iotlb(first, len >> PAGE_SHIFT);
  	flush_tlb_all();
  	iommu_invalidate(iommu->regs);

@@ -392,12 +430,15 @@ static void iommu_unmap_dma_area(unsigne
  	iopte += ioptex;
  	end = busa + len;
  	while (busa < end) {
+		/* todo: restore pte changes done in iommu_map_dma_area */
  		iopte_val(*iopte++) = 0;
  		busa += PAGE_SIZE;
  	}
  	flush_tlb_all();
  	iommu_invalidate(iommu->regs);
+#ifndef IOMMU_MAP_1TO1
  	bit_map_clear(&iommu->usemap, ioptex, len >> PAGE_SHIFT);
+#endif
  }

  static struct page *iommu_translate_dvma(unsigned long busa)
--- linux-2.6.9/arch/sparc/mm/srmmu.c.orig	2004-10-18 16:54:32.000000000 -0500
+++ linux-2.6.9/arch/sparc/mm/srmmu.c	2004-11-16 20:33:36.923411000 -0600
@@ -90,8 +90,6 @@ ctxd_t *srmmu_context_table;
  int viking_mxcc_present;
  static spinlock_t srmmu_context_spinlock = SPIN_LOCK_UNLOCKED;

-int is_hypersparc;
-
  /*
   * In general all page table modifications should use the V8 atomic
   * swap instruction.  This insures the mmu and the cpu are in sync
@@ -565,7 +563,7 @@ static void srmmu_switch_mm(struct mm_st
  		srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
  	}

-	if (is_hypersparc)
+	if (srmmu_modtype = HyperSparc)
  		hyper_flush_whole_icache();

  	srmmu_set_context(mm->context);
@@ -1463,11 +1461,10 @@ static void __init poke_hypersparc(void)
  static void __init init_hypersparc(void)
  {
  	srmmu_name = "ROSS HyperSparc";
+	srmmu_modtype = HyperSparc;

  	init_vac_layout();

-	is_hypersparc = 1;
-
  	BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_NORM);
  	BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_NORM);
  	BTFIXUPSET_CALL(pgd_clear, srmmu_pgd_clear, BTFIXUPCALL_NORM);
--- linux-2.6.9/arch/sparc/lib/bitext.c.orig	2004-10-18 16:54:08.000000000 -0500
+++ linux-2.6.9/arch/sparc/lib/bitext.c	2004-11-15 23:54:04.000000000 -0600
@@ -29,10 +29,17 @@ int bit_map_string_get(struct bit_map *t
  	int offset, count;	/* siamese twins */
  	int off_new;
  	int align1;
-	int i;
+	int i, color;

-	if (align = 0)
-		align = 1;
+	if (t->num_colors) {
+		/* align is overloaded to be the page color */
+		color = align;
+		align = t->num_colors;
+	} else {
+		color = 0;
+		if (align = 0)
+			align = 1;
+	}
  	align1 = align - 1;
  	if ((align & align1) != 0)
  		BUG();
@@ -40,6 +47,7 @@ int bit_map_string_get(struct bit_map *t
  		BUG();
  	if (len <= 0 || len > t->size)
  		BUG();
+	color &= align1;

  	spin_lock(&t->lock);
  	if (len < t->last_size)
@@ -49,7 +57,7 @@ int bit_map_string_get(struct bit_map *t
  	count = 0;
  	for (;;) {
  		off_new = find_next_zero_bit(t->map, t->size, offset);
-		off_new = (off_new + align1) & ~align1;
+		off_new = ((off_new + align1) & ~align1) + color;
  		count += off_new - offset;
  		offset = off_new;
  		if (offset >= t->size)
@@ -69,6 +77,7 @@ int bit_map_string_get(struct bit_map *t
  		}

  		i = 0;
+		/* try using find_next_bit(t->map, len+1, offset) */
  		while (test_bit(offset + i, t->map) = 0) {
  			i++;
  			if (i = len) {
@@ -121,6 +130,8 @@ void bit_map_init(struct bit_map *t, uns
  	spin_lock_init(&t->lock);
  	t->map = map;
  	t->size = size;
-	t->last_size = 0;
-	t->first_free = 0;
+
+	// redundent, zeroed above
+	//t->last_size = 0;
+	//t->first_free = 0;
  }

