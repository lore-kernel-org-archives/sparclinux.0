From: Bob Breuer <breuerr@mc.net>
Date: Tue, 23 Nov 2004 06:18:48 +0000
Subject: Re: hypersparc dvma aliasing
Message-Id: <41A2D648.3000306@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <419AB742.1000103@mc.net>
In-Reply-To: <419AB742.1000103@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hmmm, no reports on whether the previous patch works or not for anyone.
Well, I'll report my status.  Using Aurora 1.92, runlevel 2 works without
any major problems, but with runlevel 3 it looks like nfs is causing
problems, but I'm not certain.  I would like to know if it's just me,
or if it happens only with hypersparcs or any sparc32 machine.

In the meantime, I've revised the last patch.  This is against 2.6.10-rc2
and is just enough to fix the hypersparc dvma problems.  The other changes
can be looked at later.

If anyone has a more elegant solution than my overloading of the align
argument to bit_map_string_get(), let me know.  The alignment for page
coloring is known ahead of time, so we only need to pass either the
alignment or the page color hint.

Then when setting up the number of colors, where can I get the proper
cache size from?  I've only enabled the page coloring for hypersparcs,
should we do the coloring for the rest as well?

Bob


diff -X dontdiff -urp linux-2.6.10-rc2-clean/include/asm-sparc/bitext.h linux-2.6.10-rc2/include/asm-sparc/bitext.h
--- linux-2.6.10-rc2-clean/include/asm-sparc/bitext.h	2004-10-18 16:54:40.000000000 -0500
+++ linux-2.6.10-rc2/include/asm-sparc/bitext.h	2004-11-19 23:08:08.000000000 -0600
@@ -17,6 +17,7 @@ struct bit_map {
  	int last_off;
  	int last_size;
  	int first_free;
+	int num_colors;
  };

  extern int bit_map_string_get(struct bit_map *t, int len, int align);
diff -X dontdiff -urp linux-2.6.10-rc2-clean/arch/sparc/lib/bitext.c linux-2.6.10-rc2/arch/sparc/lib/bitext.c
--- linux-2.6.10-rc2-clean/arch/sparc/lib/bitext.c	2004-11-21 14:58:21.000000000 -0600
+++ linux-2.6.10-rc2/arch/sparc/lib/bitext.c	2004-11-21 17:59:45.000000000 -0600
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
@@ -121,6 +129,4 @@ void bit_map_init(struct bit_map *t, uns
  	spin_lock_init(&t->lock);
  	t->map = map;
  	t->size = size;
-	t->last_size = 0;
-	t->first_free = 0;
  }
diff -X dontdiff -urp linux-2.6.10-rc2-clean/arch/sparc/mm/iommu.c linux-2.6.10-rc2/arch/sparc/mm/iommu.c
--- linux-2.6.10-rc2-clean/arch/sparc/mm/iommu.c	2004-11-21 14:58:22.000000000 -0600
+++ linux-2.6.10-rc2/arch/sparc/mm/iommu.c	2004-11-21 18:09:28.000000000 -0600
@@ -119,6 +119,14 @@ iommu_init(int iommund, struct sbus_bus
  		prom_halt();
  	}
  	bit_map_init(&iommu->usemap, bitmap, IOMMU_NPTES);
+	/* To be coherent on HyperSparc, the page color of DVMA
+	 * and physical addresses must match.
+	 */
+	if (srmmu_modtype = HyperSparc)
+		/* XXX Use real cache size */
+		iommu->usemap.num_colors = (1<<20) >> PAGE_SHIFT;
+	else
+		iommu->usemap.num_colors = 1;

  	printk("IOMMU: impl %d vers %d table 0x%p[%d B] map [%d b]\n",
  	    impl, vers, iommu->page_table,
@@ -128,7 +136,9 @@ iommu_init(int iommund, struct sbus_bus
  }

  /* This begs to be btfixup-ed by srmmu. */
-static void iommu_viking_flush_iotlb(iopte_t *iopte, unsigned int niopte)
+/* Flush the iotlb entries to ram. */
+/* This could be better if we didn't have to flush whole pages. */
+static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
  {
  	unsigned long start;
  	unsigned long end;
@@ -145,6 +155,11 @@ static void iommu_viking_flush_iotlb(iop
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

@@ -156,7 +171,8 @@ static u32 iommu_get_one(struct page *pa
  	unsigned int busa, busa0;
  	int i;

-	ioptex = bit_map_string_get(&iommu->usemap, npages, 1);
+	/* page color = pfn of page */
+	ioptex = bit_map_string_get(&iommu->usemap, npages, page_to_pfn(page));
  	if (ioptex < 0)
  		panic("iommu out");
  	busa0 = iommu->start + (ioptex << PAGE_SHIFT);
@@ -172,8 +188,7 @@ static u32 iommu_get_one(struct page *pa
  		page++;
  	}

-	iommu_viking_flush_iotlb(iopte0, npages);
-	flush_cache_all(); // hack to fix dma errors with hypersparc
+	iommu_flush_iotlb(iopte0, npages);

  	return busa0;
  }
@@ -328,7 +343,9 @@ static int iommu_map_dma_area(dma_addr_t
  	if ((addr & ~PAGE_MASK) != 0) BUG();
  	if ((len & ~PAGE_MASK) != 0) BUG();

-	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT, 1);
+	/* page color = physical address */
+	ioptex = bit_map_string_get(&iommu->usemap, len >> PAGE_SHIFT,
+		addr >> PAGE_SHIFT);
  	if (ioptex < 0)
  		panic("iommu out");

@@ -372,7 +389,7 @@ static int iommu_map_dma_area(dma_addr_t
  	 *        to handle the latter case as well.
  	 */
  	flush_cache_all();
-	iommu_viking_flush_iotlb(first, len >> PAGE_SHIFT);
+	iommu_flush_iotlb(first, len >> PAGE_SHIFT);
  	flush_tlb_all();
  	iommu_invalidate(iommu->regs);


