From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 03 Mar 2015 14:22:40 +0000
Subject: [PATCH v2 2/2] sparc: Make sparc64 use scalable lib/iommu-common.c functions
Message-Id: <20150303142240.GC7696@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


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
 arch/sparc/include/asm/iommu_64.h |   19 ++++
 arch/sparc/kernel/pci_impl.h      |    7 +-
 arch/sparc/kernel/pci_sun4v.c     |  217 +++++++++++++++++--------------------
 3 files changed, 127 insertions(+), 116 deletions(-)

diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 2b9321a..cb327d9 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -16,6 +16,7 @@
 #define IOPTE_WRITE   0x0000000000000002UL
 
 #define IOMMU_NUM_CTXS	4096
+#include <linux/iommu-common.h>
 
 struct iommu_arena {
 	unsigned long	*map;
@@ -43,6 +44,24 @@ struct iommu {
 	u32			dma_addr_mask;
 };
 
+struct iommu_sparc {
+	struct iommu_table	tbl;
+	u32			dma_addr_mask;
+	void			(*flush_all)(struct iommu *);
+	iopte_t			*page_table;
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
+};
+
 struct strbuf {
 	int			strbuf_enabled;
 	unsigned long		strbuf_control;
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 75803c7..f800a1d 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -142,7 +142,12 @@ struct pci_pbm_info {
 	struct strbuf			stc;
 
 	/* IOMMU state, potentially shared by both PBM segments. */
-	struct iommu			*iommu;
+#ifdef notyet
+	struct iommu_sparc			*iommu;
+#else
+	/* change only pci_sun4v and DMA to use new iommu_table for now */
+	void					*iommu;
+#endif
 
 	/* Now things for the actual PCI bus probes. */
 	unsigned int			pci_first_busno;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 49d33b1..b3d58ce 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -20,14 +20,17 @@
 #include <asm/irq.h>
 #include <asm/hypervisor.h>
 #include <asm/prom.h>
+#include <linux/hash.h>
 
 #include "pci_impl.h"
 #include "iommu_common.h"
+#include <linux/iommu-common.h>
 
 #include "pci_sun4v.h"
 
 #define DRIVER_NAME	"pci_sun4v"
 #define PFX		DRIVER_NAME ": "
+static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
 
 static unsigned long vpci_major = 1;
 static unsigned long vpci_minor = 1;
@@ -132,7 +135,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   struct dma_attrs *attrs)
 {
 	unsigned long flags, order, first_page, npages, n;
-	struct iommu *iommu;
+	struct iommu_sparc *iommu;
 	struct page *page;
 	void *ret;
 	long entry;
@@ -155,14 +158,13 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 
 	iommu = dev->archdata.iommu;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
+				      __this_cpu_read(iommu_pool_hash));
 
-	if (unlikely(entry = DMA_ERROR_CODE))
+	if (unlikely(entry = IOMMU_ERROR_CODE))
 		goto range_alloc_fail;
 
-	*dma_addrp = (iommu->page_table_map_base +
+	*dma_addrp = (iommu->tbl.page_table_map_base +
 		      (entry << IO_PAGE_SHIFT));
 	ret = (void *) first_page;
 	first_page = __pa(first_page);
@@ -188,45 +190,43 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 
 iommu_map_fail:
-	/* Interrupts are disabled.  */
-	spin_lock(&iommu->lock);
-	iommu_range_free(iommu, *dma_addrp, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	iommu_tbl_range_free(&iommu->tbl, *dma_addrp, npages, false, NULL);
 
 range_alloc_fail:
 	free_pages(first_page, order);
 	return NULL;
 }
 
+static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
+			       unsigned long npages)
+{
+	u32 devhandle = *(u32 *)demap_arg;
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
+	struct iommu_sparc *iommu;
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
+	entry = ((dvma - iommu->tbl.page_table_map_base) >> IO_PAGE_SHIFT);
+	iommu_tbl_range_free(&iommu->tbl, dvma, npages, true, &devhandle);
 	order = get_order(size);
 	if (order < 10)
 		free_pages((unsigned long)cpu, order);
@@ -237,7 +237,7 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  enum dma_data_direction direction,
 				  struct dma_attrs *attrs)
 {
-	struct iommu *iommu;
+	struct iommu_sparc *iommu;
 	unsigned long flags, npages, oaddr;
 	unsigned long i, base_paddr;
 	u32 bus_addr, ret;
@@ -253,14 +253,13 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	entry = iommu_range_alloc(dev, iommu, npages, NULL);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
+				      __this_cpu_read(iommu_pool_hash));
 
-	if (unlikely(entry = DMA_ERROR_CODE))
+	if (unlikely(entry = IOMMU_ERROR_CODE))
 		goto bad;
 
-	bus_addr = (iommu->page_table_map_base +
+	bus_addr = (iommu->tbl.page_table_map_base +
 		    (entry << IO_PAGE_SHIFT));
 	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
 	base_paddr = __pa(oaddr & IO_PAGE_MASK);
@@ -287,15 +286,11 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 bad:
 	if (printk_ratelimit())
 		WARN_ON(1);
-	return DMA_ERROR_CODE;
+	return IOMMU_ERROR_CODE;
 
 iommu_map_fail:
-	/* Interrupts are disabled.  */
-	spin_lock(&iommu->lock);
-	iommu_range_free(iommu, bus_addr, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	return DMA_ERROR_CODE;
+	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, false, NULL);
+	return IOMMU_ERROR_CODE;
 }
 
 static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
@@ -303,9 +298,8 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 			      struct dma_attrs *attrs)
 {
 	struct pci_pbm_info *pbm;
-	struct iommu *iommu;
-	unsigned long flags, npages;
-	long entry;
+	struct iommu_sparc *iommu;
+	unsigned long npages;
 	u32 devhandle;
 
 	if (unlikely(direction = DMA_NONE)) {
@@ -321,22 +315,7 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
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
+	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, true, &devhandle);
 }
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
@@ -349,7 +328,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	unsigned int max_seg_size;
 	unsigned long seg_boundary_size;
 	int outcount, incount, i;
-	struct iommu *iommu;
+	struct iommu_sparc *iommu;
 	unsigned long base_shift;
 	long err;
 
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
+	base_shift = iommu->tbl.page_table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
 
@@ -391,10 +370,11 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		/* Allocate iommu entries for that segment */
 		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
-		entry = iommu_range_alloc(dev, iommu, npages, &handle);
+		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, &handle,
+				      __this_cpu_read(iommu_pool_hash));
 
 		/* Handle failure */
-		if (unlikely(entry = DMA_ERROR_CODE)) {
+		if (unlikely(entry = IOMMU_ERROR_CODE)) {
 			if (printk_ratelimit())
 				printk(KERN_INFO "iommu_alloc failed, iommu %p paddr %lx"
 				       " npages %lx\n", iommu, paddr, npages);
@@ -404,7 +384,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		iommu_batch_new_entry(entry);
 
 		/* Convert entry to a dma_addr_t */
-		dma_addr = iommu->page_table_map_base +
+		dma_addr = iommu->tbl.page_table_map_base +
 			(entry << IO_PAGE_SHIFT);
 		dma_addr |= (s->offset & ~IO_PAGE_MASK);
 
@@ -451,11 +431,11 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	if (unlikely(err < 0L))
 		goto iommu_map_failed;
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
-		outs->dma_address = DMA_ERROR_CODE;
+		outs->dma_address = IOMMU_ERROR_CODE;
 		outs->dma_length = 0;
 	}
 
@@ -469,15 +449,16 @@ iommu_map_failed:
 			vaddr = s->dma_address & IO_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IO_PAGE_SIZE);
-			iommu_range_free(iommu, vaddr, npages);
+			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
+					     false, NULL);
 			/* XXX demap? XXX */
-			s->dma_address = DMA_ERROR_CODE;
+			s->dma_address = IOMMU_ERROR_CODE;
 			s->dma_length = 0;
 		}
 		if (s = outs)
 			break;
 	}
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -488,7 +469,7 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 {
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
-	struct iommu *iommu;
+	struct iommu_sparc *iommu;
 	unsigned long flags;
 	u32 devhandle;
 
@@ -498,33 +479,23 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
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
+		iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
+				     true, &devhandle);
 		sg = sg_next(sg);
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	local_irq_restore(flags);
 }
 
 static struct dma_map_ops sun4v_dma_ops = {
@@ -536,6 +507,10 @@ static struct dma_map_ops sun4v_dma_ops = {
 	.unmap_sg			= dma_4v_unmap_sg,
 };
 
+static struct iommu_tbl_ops dma_4v_iommu_ops = {
+	.demap				= dma_4v_iommu_demap,
+};
+
 static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
 {
 	struct property *prop;
@@ -550,37 +525,40 @@ static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
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
+		pool = &(iommu->arena_pool[pool_nr]);
+		for (i = pool->start; i <= pool->end; i++) {
+			unsigned long ret, io_attrs, ra;
+
+			ret = pci_sun4v_iommu_getmap(devhandle,
+						     HV_PCI_TSBID(0, i),
+						     &io_attrs, &ra);
+			if (ret = HV_EOK) {
+				if (page_in_phys_avail(ra)) {
+					pci_sun4v_iommu_demap(devhandle,
+							      HV_PCI_TSBID(0, i),
+							      1);
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
+	struct iommu_sparc *iommu = pbm->iommu;
 	unsigned long num_tsb_entries, sz;
 	u32 dma_mask, dma_offset;
 	const u32 *vdma;
@@ -601,22 +579,22 @@ static int pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 	dma_offset = vdma[0];
 
 	/* Setup initial software IOMMU state. */
-	spin_lock_init(&iommu->lock);
 	iommu->ctx_lowest_free = 1;
-	iommu->page_table_map_base = dma_offset;
+	iommu->tbl.page_table_map_base = dma_offset;
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
+			    &dma_4v_iommu_ops, false /* no large_pool */,
+			    0 /* default npools */);
+	sz = probe_existing_entries(pbm, &iommu->tbl);
 	if (sz)
 		printk("%s: Imported %lu TSB entries from OBP\n",
 		       pbm->name, sz);
@@ -924,7 +902,7 @@ static int pci_sun4v_probe(struct platform_device *op)
 	static int hvapi_negotiated = 0;
 	struct pci_pbm_info *pbm;
 	struct device_node *dp;
-	struct iommu *iommu;
+	struct iommu_sparc *iommu;
 	u32 devhandle;
 	int i, err;
 
@@ -973,7 +951,7 @@ static int pci_sun4v_probe(struct platform_device *op)
 		goto out_err;
 	}
 
-	iommu = kzalloc(sizeof(struct iommu), GFP_KERNEL);
+	iommu = kzalloc(sizeof(struct iommu_sparc), GFP_KERNEL);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Could not allocate pbm iommu\n");
 		goto out_free_controller;
@@ -1016,8 +994,17 @@ static struct platform_driver pci_sun4v_driver = {
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
1.7.1

