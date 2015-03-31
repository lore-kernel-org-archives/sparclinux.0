From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 31 Mar 2015 14:40:45 +0000
Subject: [PATCH v8 RFC 2/3] sparc: Make sparc64 use scalable lib/iommu-common.c functions
Message-Id: <ea601a7bfa819e654614c3c0e2772d55750b2207.1427761300.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1427761300.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

In iperf experiments running linux as the Tx side (TCP client) with
10 threads results in a severe performance drop when TSO is disabled,
indicating a weakness in the software that can be avoided by using
the scalable IOMMU arena DMA allocation.

Baseline numbers before this patch:
   with default settings (TSO enabled) :    9-9.5 Gbps
   Disable TSO using ethtool- drops badly:  2-3 Gbps.

After this patch, iperf client with 10 threads, can give a
throughput of at least 8.5 Gbps, even when TSO is disabled.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
v2: moved sparc specific fileds into iommu_sparc
v3: converted all sparc users of iommu, so lot of cleanup and streamlining
v4: David Miller review change:
    - s/IOMMU_ERROR_CODE/DMA_ERROR_CODE
    - reverts pci_impl.h (now that all iommu usage has been converted)
v5: benh/aik feedback modifies the function signatures: pass in 
    modified args to iommmu_tbl_pool_init() and iommu_tbl_range_free()
v6: removed iommu_tbl_ops. Pass flush_all as function pointer to 
    iommu_tbl_pool_init
v7: move pool_hash initialization to iommu_tbl_pool_init()
v8: BenH comments

 arch/sparc/include/asm/iommu_64.h |    7 +-
 arch/sparc/kernel/iommu.c         |  171 +++++++++--------------------------
 arch/sparc/kernel/iommu_common.h  |    8 --
 arch/sparc/kernel/pci_sun4v.c     |  181 ++++++++++++++++---------------------
 4 files changed, 125 insertions(+), 242 deletions(-)

diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 2b9321a..cd0d69f 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -16,6 +16,7 @@
 #define IOPTE_WRITE   0x0000000000000002UL
 
 #define IOMMU_NUM_CTXS	4096
+#include <linux/iommu-common.h>
 
 struct iommu_arena {
 	unsigned long	*map;
@@ -24,11 +25,10 @@ struct iommu_arena {
 };
 
 struct iommu {
+	struct iommu_map_table	tbl;
 	spinlock_t		lock;
-	struct iommu_arena	arena;
-	void			(*flush_all)(struct iommu *);
+	u32			dma_addr_mask;
 	iopte_t			*page_table;
-	u32			page_table_map_base;
 	unsigned long		iommu_control;
 	unsigned long		iommu_tsbbase;
 	unsigned long		iommu_flush;
@@ -40,7 +40,6 @@ struct iommu {
 	unsigned long		dummy_page_pa;
 	unsigned long		ctx_lowest_free;
 	DECLARE_BITMAP(ctx_bitmap, IOMMU_NUM_CTXS);
-	u32			dma_addr_mask;
 };
 
 struct strbuf {
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index bfa4d0c..8b76e21 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/iommu-helper.h>
 #include <linux/bitmap.h>
+#include <linux/iommu-common.h>
 
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
@@ -45,8 +46,9 @@
 			       "i" (ASI_PHYS_BYPASS_EC_E))
 
 /* Must be invoked under the IOMMU lock. */
-static void iommu_flushall(struct iommu *iommu)
+static void iommu_flushall(struct iommu_map_table *iommu_map_table)
 {
+	struct iommu *iommu = container_of(iommu_map_table, struct iommu, tbl);
 	if (iommu->iommu_flushinv) {
 		iommu_write(iommu->iommu_flushinv, ~(u64)0);
 	} else {
@@ -87,94 +89,6 @@ static inline void iopte_make_dummy(struct iommu *iommu, iopte_t *iopte)
 	iopte_val(*iopte) = val;
 }
 
-/* Based almost entirely upon the ppc64 iommu allocator.  If you use the 'handle'
- * facility it must all be done in one pass while under the iommu lock.
- *
- * On sun4u platforms, we only flush the IOMMU once every time we've passed
- * over the entire page table doing allocations.  Therefore we only ever advance
- * the hint and cannot backtrack it.
- */
-unsigned long iommu_range_alloc(struct device *dev,
-				struct iommu *iommu,
-				unsigned long npages,
-				unsigned long *handle)
-{
-	unsigned long n, end, start, limit, boundary_size;
-	struct iommu_arena *arena = &iommu->arena;
-	int pass = 0;
-
-	/* This allocator was derived from x86_64's bit string search */
-
-	/* Sanity check */
-	if (unlikely(npages = 0)) {
-		if (printk_ratelimit())
-			WARN_ON(1);
-		return DMA_ERROR_CODE;
-	}
-
-	if (handle && *handle)
-		start = *handle;
-	else
-		start = arena->hint;
-
-	limit = arena->limit;
-
-	/* The case below can happen if we have a small segment appended
-	 * to a large, or when the previous alloc was at the very end of
-	 * the available space. If so, go back to the beginning and flush.
-	 */
-	if (start >= limit) {
-		start = 0;
-		if (iommu->flush_all)
-			iommu->flush_all(iommu);
-	}
-
- again:
-
-	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << IO_PAGE_SHIFT);
-	else
-		boundary_size = ALIGN(1UL << 32, 1 << IO_PAGE_SHIFT);
-
-	n = iommu_area_alloc(arena->map, limit, start, npages,
-			     iommu->page_table_map_base >> IO_PAGE_SHIFT,
-			     boundary_size >> IO_PAGE_SHIFT, 0);
-	if (n = -1) {
-		if (likely(pass < 1)) {
-			/* First failure, rescan from the beginning.  */
-			start = 0;
-			if (iommu->flush_all)
-				iommu->flush_all(iommu);
-			pass++;
-			goto again;
-		} else {
-			/* Second failure, give up */
-			return DMA_ERROR_CODE;
-		}
-	}
-
-	end = n + npages;
-
-	arena->hint = end;
-
-	/* Update handle for SG allocations */
-	if (handle)
-		*handle = end;
-
-	return n;
-}
-
-void iommu_range_free(struct iommu *iommu, dma_addr_t dma_addr, unsigned long npages)
-{
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long entry;
-
-	entry = (dma_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT;
-
-	bitmap_clear(arena->map, entry, npages);
-}
-
 int iommu_table_init(struct iommu *iommu, int tsbsize,
 		     u32 dma_offset, u32 dma_addr_mask,
 		     int numa_node)
@@ -187,22 +101,20 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 	/* Setup initial software IOMMU state. */
 	spin_lock_init(&iommu->lock);
 	iommu->ctx_lowest_free = 1;
-	iommu->page_table_map_base = dma_offset;
+	iommu->tbl.table_map_base = dma_offset;
 	iommu->dma_addr_mask = dma_addr_mask;
 
 	/* Allocate and initialize the free area map.  */
 	sz = num_tsb_entries / 8;
 	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kmalloc_node(sz, GFP_KERNEL, numa_node);
-	if (!iommu->arena.map) {
-		printk(KERN_ERR "IOMMU: Error, kmalloc(arena.map) failed.\n");
+	iommu->tbl.map = kmalloc_node(sz, GFP_KERNEL, numa_node);
+	if (!iommu->tbl.map)
 		return -ENOMEM;
-	}
-	memset(iommu->arena.map, 0, sz);
-	iommu->arena.limit = num_tsb_entries;
+	memset(iommu->tbl.map, 0, sz);
 
-	if (tlb_type != hypervisor)
-		iommu->flush_all = iommu_flushall;
+	iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
+			    (tlb_type != hypervisor ? iommu_flushall : NULL),
+			    false, 1, false);
 
 	/* Allocate and initialize the dummy page which we
 	 * set inactive IO PTEs to point to.
@@ -235,18 +147,19 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 	iommu->dummy_page = 0UL;
 
 out_free_map:
-	kfree(iommu->arena.map);
-	iommu->arena.map = NULL;
+	kfree(iommu->tbl.map);
+	iommu->tbl.map = NULL;
 
 	return -ENOMEM;
 }
 
-static inline iopte_t *alloc_npages(struct device *dev, struct iommu *iommu,
+static inline iopte_t *alloc_npages(struct device *dev,
+				    struct iommu *iommu,
 				    unsigned long npages)
 {
 	unsigned long entry;
 
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
+	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL);
 	if (unlikely(entry = DMA_ERROR_CODE))
 		return NULL;
 
@@ -284,7 +197,7 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
 				   struct dma_attrs *attrs)
 {
-	unsigned long flags, order, first_page;
+	unsigned long order, first_page;
 	struct iommu *iommu;
 	struct page *page;
 	int npages, nid;
@@ -306,16 +219,14 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 
 	iommu = dev->archdata.iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
 	iopte = alloc_npages(dev, iommu, size >> IO_PAGE_SHIFT);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (unlikely(iopte = NULL)) {
 		free_pages(first_page, order);
 		return NULL;
 	}
 
-	*dma_addrp = (iommu->page_table_map_base +
+	*dma_addrp = (iommu->tbl.table_map_base +
 		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
 	ret = (void *) first_page;
 	npages = size >> IO_PAGE_SHIFT;
@@ -336,16 +247,12 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 				 struct dma_attrs *attrs)
 {
 	struct iommu *iommu;
-	unsigned long flags, order, npages;
+	unsigned long order, npages;
 
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	iommu_range_free(iommu, dvma, npages);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	iommu_tbl_range_free(&iommu->tbl, dvma, npages, DMA_ERROR_CODE);
 
 	order = get_order(size);
 	if (order < 10)
@@ -375,8 +282,8 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 
-	spin_lock_irqsave(&iommu->lock, flags);
 	base = alloc_npages(dev, iommu, npages);
+	spin_lock_irqsave(&iommu->lock, flags);
 	ctx = 0;
 	if (iommu->iommu_ctxflush)
 		ctx = iommu_alloc_ctx(iommu);
@@ -385,7 +292,7 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 	if (unlikely(!base))
 		goto bad;
 
-	bus_addr = (iommu->page_table_map_base +
+	bus_addr = (iommu->tbl.table_map_base +
 		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
 	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
 	base_paddr = __pa(oaddr & IO_PAGE_MASK);
@@ -496,7 +403,7 @@ static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 	base = iommu->page_table +
-		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+		((bus_addr - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT);
 	bus_addr &= IO_PAGE_MASK;
 
 	spin_lock_irqsave(&iommu->lock, flags);
@@ -515,11 +422,10 @@ static void dma_4u_unmap_page(struct device *dev, dma_addr_t bus_addr,
 	for (i = 0; i < npages; i++)
 		iopte_make_dummy(iommu, base + i);
 
-	iommu_range_free(iommu, bus_addr, npages);
-
 	iommu_free_ctx(iommu, ctx);
-
 	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, DMA_ERROR_CODE);
 }
 
 static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
@@ -567,7 +473,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 	max_seg_size = dma_get_max_seg_size(dev);
 	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
 				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
-	base_shift = iommu->page_table_map_base >> IO_PAGE_SHIFT;
+	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
 		iopte_t *base;
@@ -581,7 +487,8 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 		/* Allocate iommu entries for that segment */
 		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
-		entry = iommu_range_alloc(dev, iommu, npages, &handle);
+		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
+					      &handle);
 
 		/* Handle failure */
 		if (unlikely(entry = DMA_ERROR_CODE)) {
@@ -594,7 +501,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 		base = iommu->page_table + entry;
 
 		/* Convert entry to a dma_addr_t */
-		dma_addr = iommu->page_table_map_base +
+		dma_addr = iommu->tbl.table_map_base +
 			(entry << IO_PAGE_SHIFT);
 		dma_addr |= (s->offset & ~IO_PAGE_MASK);
 
@@ -654,15 +561,17 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			vaddr = s->dma_address & IO_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IO_PAGE_SIZE);
-			iommu_range_free(iommu, vaddr, npages);
 
-			entry = (vaddr - iommu->page_table_map_base)
+			entry = (vaddr - iommu->tbl.table_map_base)
 				>> IO_PAGE_SHIFT;
 			base = iommu->page_table + entry;
 
 			for (j = 0; j < npages; j++)
 				iopte_make_dummy(iommu, base + j);
 
+			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
+					     DMA_ERROR_CODE);
+
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
 		}
@@ -684,10 +593,11 @@ static unsigned long fetch_sg_ctx(struct iommu *iommu, struct scatterlist *sg)
 	if (iommu->iommu_ctxflush) {
 		iopte_t *base;
 		u32 bus_addr;
+		struct iommu_map_table *tbl = &iommu->tbl;
 
 		bus_addr = sg->dma_address & IO_PAGE_MASK;
 		base = iommu->page_table +
-			((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+			((bus_addr - tbl->table_map_base) >> IO_PAGE_SHIFT);
 
 		ctx = (iopte_val(*base) & IOPTE_CONTEXT) >> 47UL;
 	}
@@ -723,9 +633,8 @@ static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		if (!len)
 			break;
 		npages = iommu_num_pages(dma_handle, len, IO_PAGE_SIZE);
-		iommu_range_free(iommu, dma_handle, npages);
 
-		entry = ((dma_handle - iommu->page_table_map_base)
+		entry = ((dma_handle - iommu->tbl.table_map_base)
 			 >> IO_PAGE_SHIFT);
 		base = iommu->page_table + entry;
 
@@ -737,6 +646,8 @@ static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		for (i = 0; i < npages; i++)
 			iopte_make_dummy(iommu, base + i);
 
+		iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
+				     DMA_ERROR_CODE);
 		sg = sg_next(sg);
 	}
 
@@ -770,9 +681,10 @@ static void dma_4u_sync_single_for_cpu(struct device *dev,
 	if (iommu->iommu_ctxflush &&
 	    strbuf->strbuf_ctxflush) {
 		iopte_t *iopte;
+		struct iommu_map_table *tbl = &iommu->tbl;
 
 		iopte = iommu->page_table +
-			((bus_addr - iommu->page_table_map_base)>>IO_PAGE_SHIFT);
+			((bus_addr - tbl->table_map_base)>>IO_PAGE_SHIFT);
 		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
 	}
 
@@ -805,9 +717,10 @@ static void dma_4u_sync_sg_for_cpu(struct device *dev,
 	if (iommu->iommu_ctxflush &&
 	    strbuf->strbuf_ctxflush) {
 		iopte_t *iopte;
+		struct iommu_map_table *tbl = &iommu->tbl;
 
-		iopte = iommu->page_table +
-			((sglist[0].dma_address - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+		iopte = iommu->page_table + ((sglist[0].dma_address -
+			tbl->table_map_base) >> IO_PAGE_SHIFT);
 		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
 	}
 
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index 1ec0de4..f4be0d7 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -48,12 +48,4 @@ static inline int is_span_boundary(unsigned long entry,
 	return iommu_is_span_boundary(entry, nr, shift, boundary_size);
 }
 
-unsigned long iommu_range_alloc(struct device *dev,
-				struct iommu *iommu,
-				unsigned long npages,
-				unsigned long *handle);
-void iommu_range_free(struct iommu *iommu,
-		      dma_addr_t dma_addr,
-		      unsigned long npages);
-
 #endif /* _IOMMU_COMMON_H */
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 47ddbd4..6ca0190 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/log2.h>
 #include <linux/of_device.h>
+#include <linux/iommu-common.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
@@ -155,15 +156,12 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 
 	iommu = dev->archdata.iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL);
 
 	if (unlikely(entry = DMA_ERROR_CODE))
 		goto range_alloc_fail;
 
-	*dma_addrp = (iommu->page_table_map_base +
-		      (entry << IO_PAGE_SHIFT));
+	*dma_addrp = (iommu->tbl.table_map_base + (entry << IO_PAGE_SHIFT));
 	ret = (void *) first_page;
 	first_page = __pa(first_page);
 
@@ -188,45 +186,46 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 
 iommu_map_fail:
-	/* Interrupts are disabled.  */
-	spin_lock(&iommu->lock);
-	iommu_range_free(iommu, *dma_addrp, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	iommu_tbl_range_free(&iommu->tbl, *dma_addrp, npages, DMA_ERROR_CODE);
 
 range_alloc_fail:
 	free_pages(first_page, order);
 	return NULL;
 }
 
+static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
+			       unsigned long npages)
+{
+	u32 devhandle = *(u32 *)demap_arg;
+	unsigned long num, flags;
+
+	local_irq_save(flags);
+	do {
+		num = pci_sun4v_iommu_demap(devhandle,
+					    HV_PCI_TSBID(0, entry),
+					    npages);
+
+		entry += num;
+		npages -= num;
+	} while (npages != 0);
+	local_irq_restore(flags);
+}
+
 static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 				 dma_addr_t dvma, struct dma_attrs *attrs)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
-	unsigned long flags, order, npages, entry;
+	unsigned long order, npages, entry;
 	u32 devhandle;
 
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
 	pbm = dev->archdata.host_controller;
 	devhandle = pbm->devhandle;
-	entry = ((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	iommu_range_free(iommu, dvma, npages);
-
-	do {
-		unsigned long num;
-
-		num = pci_sun4v_iommu_demap(devhandle, HV_PCI_TSBID(0, entry),
-					    npages);
-		entry += num;
-		npages -= num;
-	} while (npages != 0);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
+	entry = ((dvma - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT);
+	dma_4v_iommu_demap(&devhandle, entry, npages);
+	iommu_tbl_range_free(&iommu->tbl, dvma, npages, DMA_ERROR_CODE);
 	order = get_order(size);
 	if (order < 10)
 		free_pages((unsigned long)cpu, order);
@@ -253,15 +252,12 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL);
 
 	if (unlikely(entry = DMA_ERROR_CODE))
 		goto bad;
 
-	bus_addr = (iommu->page_table_map_base +
-		    (entry << IO_PAGE_SHIFT));
+	bus_addr = (iommu->tbl.table_map_base + (entry << IO_PAGE_SHIFT));
 	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
 	base_paddr = __pa(oaddr & IO_PAGE_MASK);
 	prot = HV_PCI_MAP_ATTR_READ;
@@ -290,11 +286,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	return DMA_ERROR_CODE;
 
 iommu_map_fail:
-	/* Interrupts are disabled.  */
-	spin_lock(&iommu->lock);
-	iommu_range_free(iommu, bus_addr, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
+	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, DMA_ERROR_CODE);
 	return DMA_ERROR_CODE;
 }
 
@@ -304,7 +296,7 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
-	unsigned long flags, npages;
+	unsigned long npages;
 	long entry;
 	u32 devhandle;
 
@@ -321,22 +313,9 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 	bus_addr &= IO_PAGE_MASK;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	iommu_range_free(iommu, bus_addr, npages);
-
-	entry = (bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT;
-	do {
-		unsigned long num;
-
-		num = pci_sun4v_iommu_demap(devhandle, HV_PCI_TSBID(0, entry),
-					    npages);
-		entry += num;
-		npages -= num;
-	} while (npages != 0);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = (bus_addr - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT;
+	dma_4v_iommu_demap(&devhandle, entry, npages);
+	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, DMA_ERROR_CODE);
 }
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
@@ -371,14 +350,14 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	/* Init first segment length for backout at failure */
 	outs->dma_length = 0;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	local_irq_save(flags);
 
 	iommu_batch_start(dev, prot, ~0UL);
 
 	max_seg_size = dma_get_max_seg_size(dev);
 	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
 				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
-	base_shift = iommu->page_table_map_base >> IO_PAGE_SHIFT;
+	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
 
@@ -391,7 +370,8 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		/* Allocate iommu entries for that segment */
 		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
-		entry = iommu_range_alloc(dev, iommu, npages, &handle);
+		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
+					      &handle);
 
 		/* Handle failure */
 		if (unlikely(entry = DMA_ERROR_CODE)) {
@@ -404,8 +384,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		iommu_batch_new_entry(entry);
 
 		/* Convert entry to a dma_addr_t */
-		dma_addr = iommu->page_table_map_base +
-			(entry << IO_PAGE_SHIFT);
+		dma_addr = iommu->tbl.table_map_base + (entry << IO_PAGE_SHIFT);
 		dma_addr |= (s->offset & ~IO_PAGE_MASK);
 
 		/* Insert into HW table */
@@ -451,7 +430,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	if (unlikely(err < 0L))
 		goto iommu_map_failed;
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
@@ -469,7 +448,8 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			vaddr = s->dma_address & IO_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IO_PAGE_SIZE);
-			iommu_range_free(iommu, vaddr, npages);
+			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
+					     DMA_ERROR_CODE);
 			/* XXX demap? XXX */
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
@@ -477,7 +457,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		if (s = outs)
 			break;
 	}
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -489,7 +469,7 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
 	struct iommu *iommu;
-	unsigned long flags;
+	unsigned long flags, entry;
 	u32 devhandle;
 
 	BUG_ON(direction = DMA_NONE);
@@ -498,33 +478,27 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	pbm = dev->archdata.host_controller;
 	devhandle = pbm->devhandle;
 	
-	spin_lock_irqsave(&iommu->lock, flags);
+	local_irq_save(flags);
 
 	sg = sglist;
 	while (nelems--) {
 		dma_addr_t dma_handle = sg->dma_address;
 		unsigned int len = sg->dma_length;
-		unsigned long npages, entry;
+		unsigned long npages;
+		struct iommu_map_table *tbl = &iommu->tbl;
+		unsigned long shift = IO_PAGE_SHIFT;
 
 		if (!len)
 			break;
 		npages = iommu_num_pages(dma_handle, len, IO_PAGE_SIZE);
-		iommu_range_free(iommu, dma_handle, npages);
-
-		entry = ((dma_handle - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-		while (npages) {
-			unsigned long num;
-
-			num = pci_sun4v_iommu_demap(devhandle, HV_PCI_TSBID(0, entry),
-						    npages);
-			entry += num;
-			npages -= num;
-		}
-
+		entry = ((dma_handle - tbl->table_map_base) >> shift);
+		dma_4v_iommu_demap(&devhandle, entry, npages);
+		iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
+				     DMA_ERROR_CODE);
 		sg = sg_next(sg);
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 }
 
 static struct dma_map_ops sun4v_dma_ops = {
@@ -550,30 +524,33 @@ static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
 }
 
 static unsigned long probe_existing_entries(struct pci_pbm_info *pbm,
-					    struct iommu *iommu)
+					    struct iommu_map_table *iommu)
 {
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long i, cnt = 0;
+	struct iommu_pool *pool;
+	unsigned long i, pool_nr, cnt = 0;
 	u32 devhandle;
 
 	devhandle = pbm->devhandle;
-	for (i = 0; i < arena->limit; i++) {
-		unsigned long ret, io_attrs, ra;
-
-		ret = pci_sun4v_iommu_getmap(devhandle,
-					     HV_PCI_TSBID(0, i),
-					     &io_attrs, &ra);
-		if (ret = HV_EOK) {
-			if (page_in_phys_avail(ra)) {
-				pci_sun4v_iommu_demap(devhandle,
-						      HV_PCI_TSBID(0, i), 1);
-			} else {
-				cnt++;
-				__set_bit(i, arena->map);
+	for (pool_nr = 0; pool_nr < iommu->nr_pools; pool_nr++) {
+		pool = &(iommu->pools[pool_nr]);
+		for (i = pool->start; i <= pool->end; i++) {
+			unsigned long ret, io_attrs, ra;
+
+			ret = pci_sun4v_iommu_getmap(devhandle,
+						     HV_PCI_TSBID(0, i),
+						     &io_attrs, &ra);
+			if (ret = HV_EOK) {
+				if (page_in_phys_avail(ra)) {
+					pci_sun4v_iommu_demap(devhandle,
+							      HV_PCI_TSBID(0,
+							      i), 1);
+				} else {
+					cnt++;
+					__set_bit(i, iommu->map);
+				}
 			}
 		}
 	}
-
 	return cnt;
 }
 
@@ -603,20 +580,22 @@ static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	/* Setup initial software IOMMU state. */
 	spin_lock_init(&iommu->lock);
 	iommu->ctx_lowest_free = 1;
-	iommu->page_table_map_base = dma_offset;
+	iommu->tbl.table_map_base = dma_offset;
 	iommu->dma_addr_mask = dma_mask;
 
 	/* Allocate and initialize the free area map.  */
 	sz = (num_tsb_entries + 7) / 8;
 	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
-	if (!iommu->arena.map) {
+	iommu->tbl.map = kzalloc(sz, GFP_KERNEL);
+	if (!iommu->tbl.map) {
 		printk(KERN_ERR PFX "Error, kmalloc(arena.map) failed.\n");
 		return -ENOMEM;
 	}
-	iommu->arena.limit = num_tsb_entries;
-
-	sz = probe_existing_entries(pbm, iommu);
+	iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
+			    NULL, false /* no large_pool */,
+			    0 /* default npools */,
+			    false /* want span boundary checking */);
+	sz = probe_existing_entries(pbm, &iommu->tbl);
 	if (sz)
 		printk("%s: Imported %lu TSB entries from OBP\n",
 		       pbm->name, sz);
-- 
1.7.1

