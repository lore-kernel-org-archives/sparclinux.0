From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 15:16:16 +0000
Subject: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219151616.GB25248@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In iperf experiments running linux as the Tx side (TCP client) with
10 threads results in a severe performance drop when TSO is disabled,
indicating a weakness in the software that turns out to be avoidable
after this patch.

Baseline numbers before this patch:
   with default settings (TSO enabled) :    9-9.5 Gbps
   Disable TSO using ethtool- drops badly:  2-3 Gbps.  (!)

What this patch does:
Output from lockstat flags the iommu->lock as the hottest
lock, showing something of the order of  21M contentions out of
27M acquisitions, and an average wait time of 26 us for the lock.
This is not efficient. A better design is to follow the ppc model,
where the iommu_table has multiple pools, each stretching over a
segment of the map, and with a separate lock for each pool. This
model allows for better parallelization of the iommu map search.

After this patch, iperf client with 10 threads, can give a
throughput of at least 8.5 Gbps, even when TSO is disabled.


Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/include/asm/iommu_64.h |  34 ++++++++
 arch/sparc/kernel/iommu.c         | 138 +++++++++++++++++++++++++++++
 arch/sparc/kernel/iommu_common.h  |  11 +++
 arch/sparc/kernel/pci_impl.h      |   5 ++
 arch/sparc/kernel/pci_sun4v.c     | 179 +++++++++++++++++++-------------------
 5 files changed, 276 insertions(+), 91 deletions(-)

diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 2b9321a..f12287a 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -17,12 +17,22 @@
 
 #define IOMMU_NUM_CTXS	4096
 
+#define IOMMU_POOL_HASHBITS     4
+#define IOMMU_NR_POOLS          (1 << IOMMU_POOL_HASHBITS)
+
 struct iommu_arena {
 	unsigned long	*map;
 	unsigned int	hint;
 	unsigned int	limit;
 };
 
+struct iommu_pool {
+	unsigned long	start;
+	unsigned long	end;
+	unsigned long	hint;
+	spinlock_t	lock;
+};
+
 struct iommu {
 	spinlock_t		lock;
 	struct iommu_arena	arena;
@@ -43,6 +53,30 @@ struct iommu {
 	u32			dma_addr_mask;
 };
 
+struct iommu_table {
+	spinlock_t		table_lock;
+	struct iommu_arena	notused2;
+	void			(*flush_all)(struct iommu *);
+	iopte_t			*page_table;
+	u32			page_table_map_base;
+	unsigned long		iommu_control;
+	unsigned long		iommu_tsbbase;
+	unsigned long		iommu_flush;
+	unsigned long		iommu_flushinv;
+	unsigned long		iommu_tags;
+	unsigned long		iommu_ctxflush;
+	unsigned long		write_complete_reg;
+	unsigned long		dummy_page;
+	unsigned long		dummy_page_pa;
+	unsigned long		ctx_lowest_free;
+	DECLARE_BITMAP(ctx_bitmap, IOMMU_NUM_CTXS);
+	u32			dma_addr_mask;
+	unsigned long		nr_pools;
+	struct iommu_pool	arena_pool[IOMMU_NR_POOLS];
+	unsigned long		poolsize;
+	unsigned long		*map;
+};
+
 struct strbuf {
 	int			strbuf_enabled;
 	unsigned long		strbuf_control;
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index bfa4d0c..fb9afad 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -94,6 +94,108 @@ static inline void iopte_make_dummy(struct iommu *iommu, iopte_t *iopte)
  * over the entire page table doing allocations.  Therefore we only ever advance
  * the hint and cannot backtrack it.
  */
+unsigned long iommu_tbl_range_alloc(struct device *dev,
+				struct iommu_table *iommu,
+				unsigned long npages,
+				unsigned long *handle,
+				unsigned int pool_hash)
+{
+	unsigned long n, end, start, limit, boundary_size;
+	struct iommu_pool *arena;
+	int pass = 0;
+	unsigned int pool_nr;
+	unsigned int npools = iommu->nr_pools;
+	unsigned long flags;
+
+	/* This allocator was derived from x86_64's bit string search */
+
+	/* Sanity check */
+	if (unlikely(npages = 0)) {
+		if (printk_ratelimit())
+			WARN_ON(1);
+		return DMA_ERROR_CODE;
+	}
+
+	/* pick out pool_nr */
+	pool_nr =  pool_hash & (npools - 1);
+	arena = &(iommu->arena_pool[pool_nr]);
+
+	while (!spin_trylock_irqsave(&(arena->lock), flags)) {
+		pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
+		arena = &(iommu->arena_pool[pool_nr]);
+	}
+
+ again:
+	if (pass = 0 && handle && *handle &&
+	    (*handle >= arena->start) && (*handle < arena->end))
+		start = *handle;
+	else
+		start = arena->hint;
+
+	limit = arena->end;
+
+	/* The case below can happen if we have a small segment appended
+	 * to a large, or when the previous alloc was at the very end of
+	 * the available space. If so, go back to the beginning and flush.
+	 */
+	if (start >= limit) {
+		start = arena->start;
+		BUG_ON (iommu->flush_all != NULL); /* for now */
+	}
+
+	if (dev)
+		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
+				      1 << IO_PAGE_SHIFT);
+	else
+		boundary_size = ALIGN(1UL << 32, 1 << IO_PAGE_SHIFT);
+
+	n = iommu_area_alloc(iommu->map, limit, start, npages,
+			     iommu->page_table_map_base >> IO_PAGE_SHIFT,
+			     boundary_size >> IO_PAGE_SHIFT, 0);
+	if (n = -1) {
+		if (likely(pass = 0)) {
+			/* First failure, rescan from the beginning.  */
+			arena->hint = arena->start;
+			BUG_ON (iommu->flush_all != NULL); /* for now */
+			pass++;
+			goto again;
+		} else if (pass <= iommu->nr_pools) {
+			spin_unlock(&(arena->lock));
+			pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
+			arena = &(iommu->arena_pool[pool_nr]);
+			while (!spin_trylock(&(arena->lock))) {
+				pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
+				arena = &(iommu->arena_pool[pool_nr]);
+			}
+			arena->hint = arena->start;
+			pass++;
+			goto again;
+		} else {
+			/* give up */
+			spin_unlock_irqrestore(&(arena->lock), flags);
+			return DMA_ERROR_CODE;
+		}
+	}
+
+	end = n + npages;
+
+	arena->hint = end;
+
+	/* Update handle for SG allocations */
+	if (handle)
+		*handle = end;
+	spin_unlock_irqrestore(&(arena->lock), flags);
+		
+	return n;
+}
+
+/* Based almost entirely upon the ppc64 iommu allocator.  If you use the 'handle'
+ * facility it must all be done in one pass while under the iommu lock.
+ *
+ * On sun4u platforms, we only flush the IOMMU once every time we've passed
+ * over the entire page table doing allocations.  Therefore we only ever advance
+ * the hint and cannot backtrack it.
+ */
 unsigned long iommu_range_alloc(struct device *dev,
 				struct iommu *iommu,
 				unsigned long npages,
@@ -165,6 +267,42 @@ unsigned long iommu_range_alloc(struct device *dev,
 	return n;
 }
 
+static struct iommu_pool *get_pool(struct iommu_table *tbl,
+				   unsigned long entry)
+{
+	struct iommu_pool *p;
+	unsigned int pool_nr = entry / tbl->poolsize;
+
+	BUG_ON(pool_nr >= tbl->nr_pools);
+	
+	p = &tbl->arena_pool[pool_nr];
+
+        return p;
+}
+
+void iommu_tbl_range_free(struct iommu_table *iommu, dma_addr_t dma_addr,
+			  unsigned long npages,
+			  void (*demap)(void *, unsigned long, unsigned long),
+			  void *demap_arg)
+{
+	unsigned long entry;
+	struct iommu_pool *pool;
+	unsigned long flags;
+
+	entry = (dma_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT;
+	pool = get_pool(iommu, entry);
+
+	local_irq_save(flags);
+	if (demap) {
+		(*demap)(demap_arg, entry, npages);
+	}
+	local_irq_restore(flags);
+
+	spin_lock_irqsave(&(pool->lock), flags);
+	bitmap_clear(iommu->map, entry, npages);
+	spin_unlock_irqrestore(&(pool->lock), flags);
+}
+
 void iommu_range_free(struct iommu *iommu, dma_addr_t dma_addr, unsigned long npages)
 {
 	struct iommu_arena *arena = &iommu->arena;
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index 1ec0de4..fbaa3df 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -56,4 +56,15 @@ void iommu_range_free(struct iommu *iommu,
 		      dma_addr_t dma_addr,
 		      unsigned long npages);
 
+unsigned long iommu_tbl_range_alloc(struct device *dev,
+				struct iommu_table *iommu,
+				unsigned long npages,
+				unsigned long *handle,
+				unsigned int pool_hash);
+void iommu_tbl_range_free(struct iommu_table *iommu,
+			  dma_addr_t dma_addr,
+			  unsigned long npages,
+    			  void (*demap)(void *, unsigned long, unsigned long),
+			  void *demap_arg);
+
 #endif /* _IOMMU_COMMON_H */
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 75803c7..315257d 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -142,7 +142,12 @@ struct pci_pbm_info {
 	struct strbuf			stc;
 
 	/* IOMMU state, potentially shared by both PBM segments. */
+#ifdef notdef
 	struct iommu			*iommu;
+#else
+	/* change only pci_sun4v and dma stuff first.. */
+	void				*iommu;
+#endif
 
 	/* Now things for the actual PCI bus probes. */
 	unsigned int			pci_first_busno;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 49d33b1..f4fff9a 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -20,6 +20,7 @@
 #include <asm/irq.h>
 #include <asm/hypervisor.h>
 #include <asm/prom.h>
+#include <linux/hash.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
@@ -28,6 +29,7 @@
 
 #define DRIVER_NAME	"pci_sun4v"
 #define PFX		DRIVER_NAME ": "
+static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
 
 static unsigned long vpci_major = 1;
 static unsigned long vpci_minor = 1;
@@ -132,7 +134,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   struct dma_attrs *attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
-	struct iommu *iommu;
+	struct iommu_table *iommu;
 	struct page *page;
 	void *ret;
 	long entry;
@@ -155,9 +157,8 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 
 	iommu = dev->archdata.iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = iommu_tbl_range_alloc(dev, iommu, npages, NULL,
+				      __raw_get_cpu_var(iommu_pool_hash));
 
 	if (unlikely(entry = DMA_ERROR_CODE))
 		goto range_alloc_fail;
@@ -188,22 +189,35 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 
 iommu_map_fail:
-	/* Interrupts are disabled.  */
-	spin_lock(&iommu->lock);
-	iommu_range_free(iommu, *dma_addrp, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	iommu_tbl_range_free(iommu, *dma_addrp, npages, NULL, NULL);
 
 range_alloc_fail:
 	free_pages(first_page, order);
 	return NULL;
 }
 
+static void dma_4v_iommu_demap(void *handle, unsigned long entry,
+			       unsigned long npages)
+{
+	u32 devhandle = *(u32 *)handle;
+	unsigned long num;
+
+	do {
+		num = pci_sun4v_iommu_demap(devhandle,
+					    HV_PCI_TSBID(0, entry),
+					    npages);
+
+		entry += num;
+		npages -= num;
+	} while (npages != 0);
+}
+
 static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 				 dma_addr_t dvma, struct dma_attrs *attrs)
 {
 	struct pci_pbm_info *pbm;
-	struct iommu *iommu;
-	unsigned long flags, order, npages, entry;
+	struct iommu_table *iommu;
+	unsigned long order, npages, entry;
 	u32 devhandle;
 
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
@@ -212,20 +226,9 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 	devhandle = pbm->devhandle;
 	entry = ((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
 
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	iommu_range_free(iommu, dvma, npages);
 
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
+	iommu_tbl_range_free(iommu, dvma, npages,
+			     dma_4v_iommu_demap, &devhandle);
 
 	order = get_order(size);
 	if (order < 10)
@@ -237,7 +240,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  enum dma_data_direction direction,
 				  struct dma_attrs *attrs)
 {
-	struct iommu *iommu;
+	struct iommu_table *iommu;
 	unsigned long flags, npages, oaddr;
 	unsigned long i, base_paddr;
 	u32 bus_addr, ret;
@@ -253,9 +256,8 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = iommu_tbl_range_alloc(dev, iommu, npages, NULL,
+				      __raw_get_cpu_var(iommu_pool_hash));
 
 	if (unlikely(entry = DMA_ERROR_CODE))
 		goto bad;
@@ -290,10 +292,7 @@ bad:
 	return DMA_ERROR_CODE;
 
 iommu_map_fail:
-	/* Interrupts are disabled.  */
-	spin_lock(&iommu->lock);
-	iommu_range_free(iommu, bus_addr, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	iommu_tbl_range_free(iommu, bus_addr, npages, NULL, NULL);
 
 	return DMA_ERROR_CODE;
 }
@@ -303,9 +302,8 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      struct dma_attrs *attrs)
 {
 	struct pci_pbm_info *pbm;
-	struct iommu *iommu;
-	unsigned long flags, npages;
-	long entry;
+	struct iommu_table *iommu;
+	unsigned long npages;
 	u32 devhandle;
 
 	if (unlikely(direction = DMA_NONE)) {
@@ -322,21 +320,8 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 	npages >>= IO_PAGE_SHIFT;
 	bus_addr &= IO_PAGE_MASK;
 
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
+	iommu_tbl_range_free(iommu, bus_addr, npages,
+			     dma_4v_iommu_demap, &devhandle);
 }
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
@@ -349,7 +334,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	unsigned int max_seg_size;
 	unsigned long seg_boundary_size;
 	int outcount, incount, i;
-	struct iommu *iommu;
+	struct iommu_table *iommu;
 	unsigned long base_shift;
 	long err;
 
@@ -371,7 +356,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	/* Init first segment length for backout at failure */
 	outs->dma_length = 0;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	local_irq_save(flags);
 
 	iommu_batch_start(dev, prot, ~0UL);
 
@@ -391,7 +376,8 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		/* Allocate iommu entries for that segment */
 		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
-		entry = iommu_range_alloc(dev, iommu, npages, &handle);
+		entry = iommu_tbl_range_alloc(dev, iommu, npages, &handle,
+				      __raw_get_cpu_var(iommu_pool_hash));
 
 		/* Handle failure */
 		if (unlikely(entry = DMA_ERROR_CODE)) {
@@ -451,7 +437,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	if (unlikely(err < 0L))
 		goto iommu_map_failed;
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
@@ -469,7 +455,7 @@ iommu_map_failed:
 			vaddr = s->dma_address & IO_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IO_PAGE_SIZE);
-			iommu_range_free(iommu, vaddr, npages);
+			iommu_tbl_range_free(iommu, vaddr, npages, NULL, NULL);
 			/* XXX demap? XXX */
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
@@ -477,7 +463,7 @@ iommu_map_failed:
 		if (s = outs)
 			break;
 	}
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -488,7 +474,7 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 {
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
-	struct iommu *iommu;
+	struct iommu_table *iommu;
 	unsigned long flags;
 	u32 devhandle;
 
@@ -498,33 +484,23 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
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
+		iommu_tbl_range_free(iommu, dma_handle, npages,
+			     dma_4v_iommu_demap, &devhandle);
 		sg = sg_next(sg);
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 }
 
 static struct dma_map_ops sun4v_dma_ops = {
@@ -550,40 +526,43 @@ static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
 }
 
 static unsigned long probe_existing_entries(struct pci_pbm_info *pbm,
-					    struct iommu *iommu)
+					    struct iommu_table *iommu)
 {
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long i, cnt = 0;
+	struct iommu_pool *pool;
+	unsigned long i, pool_nr, cnt = 0;
 	u32 devhandle;
 
 	devhandle = pbm->devhandle;
-	for (i = 0; i < arena->limit; i++) {
-		unsigned long ret, io_attrs, ra;
+	for (pool_nr = 0; pool_nr < iommu->nr_pools; pool_nr++) {
+		pool = &(iommu->arena_pool[pool_nr]);
+		for (i = pool->start; i <= pool->end; i++) {
+			unsigned long ret, io_attrs, ra;
 
-		ret = pci_sun4v_iommu_getmap(devhandle,
+			ret = pci_sun4v_iommu_getmap(devhandle,
 					     HV_PCI_TSBID(0, i),
 					     &io_attrs, &ra);
-		if (ret = HV_EOK) {
-			if (page_in_phys_avail(ra)) {
-				pci_sun4v_iommu_demap(devhandle,
+			if (ret = HV_EOK) {
+				if (page_in_phys_avail(ra)) {
+					pci_sun4v_iommu_demap(devhandle,
 						      HV_PCI_TSBID(0, i), 1);
-			} else {
-				cnt++;
-				__set_bit(i, arena->map);
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
 
 static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 {
 	static const u32 vdma_default[] = { 0x80000000, 0x80000000 };
-	struct iommu *iommu = pbm->iommu;
+	struct iommu_table *iommu = pbm->iommu;
 	unsigned long num_tsb_entries, sz;
 	u32 dma_mask, dma_offset;
 	const u32 *vdma;
+	unsigned int start, i;
 
 	vdma = of_get_property(pbm->op->dev.of_node, "virtual-dma", NULL);
 	if (!vdma)
@@ -601,7 +580,6 @@ static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	dma_offset = vdma[0];
 
 	/* Setup initial software IOMMU state. */
-	spin_lock_init(&iommu->lock);
 	iommu->ctx_lowest_free = 1;
 	iommu->page_table_map_base = dma_offset;
 	iommu->dma_addr_mask = dma_mask;
@@ -609,12 +587,22 @@ static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	/* Allocate and initialize the free area map.  */
 	sz = (num_tsb_entries + 7) / 8;
 	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
-	if (!iommu->arena.map) {
+	iommu->map = kzalloc(sz, GFP_KERNEL);
+	if (!iommu->map) {
 		printk(KERN_ERR PFX "Error, kmalloc(arena.map) failed.\n");
 		return -ENOMEM;
 	}
-	iommu->arena.limit = num_tsb_entries;
+	iommu->nr_pools = IOMMU_NR_POOLS;
+	start = 0;
+	iommu->poolsize = num_tsb_entries/iommu->nr_pools;
+	spin_lock_init(&(iommu->table_lock));
+	for (i = 0; i < iommu->nr_pools; i++) {
+		spin_lock_init(&(iommu->arena_pool[i].lock));
+		iommu->arena_pool[i].start = start;
+		iommu->arena_pool[i].hint = start;
+		start += iommu->poolsize; /* start for next pool */
+		iommu->arena_pool[i].end = start - 1;
+	}
 
 	sz = probe_existing_entries(pbm, iommu);
 	if (sz)
@@ -924,7 +912,7 @@ static int pci_sun4v_probe(struct platform_device *op)
 	static int hvapi_negotiated = 0;
 	struct pci_pbm_info *pbm;
 	struct device_node *dp;
-	struct iommu *iommu;
+	struct iommu_table *iommu;
 	u32 devhandle;
 	int i, err;
 
@@ -973,7 +961,7 @@ static int pci_sun4v_probe(struct platform_device *op)
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_KERNEL);
+	iommu = kzalloc(sizeof(struct iommu_table), GFP_KERNEL);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Could not allocate pbm iommu\n");
 		goto out_free_controller;
@@ -1016,8 +1004,17 @@ static struct platform_driver pci_sun4v_driver = {
 	.probe		= pci_sun4v_probe,
 };
 
+static void setup_iommu_pool_hash(void)
+{
+	unsigned int i;
+
+	for_each_possible_cpu(i)
+		per_cpu(iommu_pool_hash, i) = hash_32(i, IOMMU_POOL_HASHBITS);
+}
+
 static int __init pci_sun4v_init(void)
 {
+	setup_iommu_pool_hash();
 	return platform_driver_register(&pci_sun4v_driver);
 }
 
-- 
1.8.4.2

