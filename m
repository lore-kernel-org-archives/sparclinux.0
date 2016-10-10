From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Mon, 10 Oct 2016 18:12:06 +0000
Subject: [PATCH 5/6] sparc64: Enable sun4v dma ops to use IOMMU v2 APIs
Message-Id: <1476123127-24314-6-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Add Hypervisor IOMMU v2 APIs pci_iotsb_map(), pci_iotsb_demap() and
enable sun4v dma ops to use IOMMU v2 API for all PCIe devices with
64bit DMA mask.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Reviewed-by: chris hyser <chris.hyser@oracle.com>
Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/include/asm/hypervisor.h |   6 +
 arch/sparc/kernel/pci_sun4v.c       | 214 ++++++++++++++++++++++++++----------
 arch/sparc/kernel/pci_sun4v.h       |  11 ++
 arch/sparc/kernel/pci_sun4v_asm.S   |  36 ++++++
 4 files changed, 209 insertions(+), 58 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 7b15df8..73cb897 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2377,6 +2377,12 @@ unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
  *	iotsb_index	Zero-based IOTTE number within an IOTSB.
  */
 
+/* The index_count argument consists of two fields:
+ * bits 63:48 #iottes and bits 47:0 iotsb_index
+ */
+#define HV_PCI_IOTSB_INDEX_COUNT(__iottes, __iotsb_index) \
+	(((u64)(__iottes) << 48UL) | ((u64)(__iotsb_index)))
+
 /* pci_iotsb_conf()
  * TRAP:	HV_FAST_TRAP
  * FUNCTION:	HV_FAST_PCI_IOTSB_CONF
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index c7f3a0b3..1ea6d30 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -72,34 +72,55 @@ static inline void iommu_batch_start(struct device *dev, unsigned long prot, uns
 }
 
 /* Interrupts must be disabled.  */
-static long iommu_batch_flush(struct iommu_batch *p)
+static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
 {
 	struct pci_pbm_info *pbm = p->dev->archdata.host_controller;
+	u64 *pglist = p->pglist;
+	u64 index_count;
 	unsigned long devhandle = pbm->devhandle;
 	unsigned long prot = p->prot;
 	unsigned long entry = p->entry;
-	u64 *pglist = p->pglist;
 	unsigned long npages = p->npages;
+	unsigned long iotsb_num;
+	unsigned long ret;
+	long num;
 
 	/* VPCI maj=1, min=[0,1] only supports read and write */
 	if (vpci_major < 2)
 		prot &= (HV_PCI_MAP_ATTR_READ | HV_PCI_MAP_ATTR_WRITE);
 
 	while (npages != 0) {
-		long num;
-
-		num = pci_sun4v_iommu_map(devhandle, HV_PCI_TSBID(0, entry),
-					  npages, prot, __pa(pglist));
-		if (unlikely(num < 0)) {
-			if (printk_ratelimit())
-				printk("iommu_batch_flush: IOMMU map of "
-				       "[%08lx:%08llx:%lx:%lx:%lx] failed with "
-				       "status %ld\n",
-				       devhandle, HV_PCI_TSBID(0, entry),
-				       npages, prot, __pa(pglist), num);
-			return -1;
+		if (mask <= DMA_BIT_MASK(32)) {
+			num = pci_sun4v_iommu_map(devhandle,
+						  HV_PCI_TSBID(0, entry),
+						  npages,
+						  prot,
+						  __pa(pglist));
+			if (unlikely(num < 0)) {
+				pr_err_ratelimited("iommu_batch_flush: IOMMU map of [%08lx:%08llx:%lx:%lx:%lx] failed with status %ld\n",
+						   devhandle,
+						   HV_PCI_TSBID(0, entry),
+						   npages, prot, __pa(pglist),
+						   num);
+				return -1;
+			}
+		} else {
+			index_count = HV_PCI_IOTSB_INDEX_COUNT(npages, entry),
+			iotsb_num = pbm->iommu->atu->iotsb->iotsb_num;
+			ret = pci_sun4v_iotsb_map(devhandle,
+						  iotsb_num,
+						  index_count,
+						  prot,
+						  __pa(pglist),
+						  &num);
+			if (unlikely(ret != HV_EOK)) {
+				pr_err_ratelimited("iommu_batch_flush: ATU map of [%08lx:%lx:%llx:%lx:%lx] failed with status %ld\n",
+						   devhandle, iotsb_num,
+						   index_count, prot,
+						   __pa(pglist), ret);
+				return -1;
+			}
 		}
-
 		entry += num;
 		npages -= num;
 		pglist += num;
@@ -111,19 +132,19 @@ static long iommu_batch_flush(struct iommu_batch *p)
 	return 0;
 }
 
-static inline void iommu_batch_new_entry(unsigned long entry)
+static inline void iommu_batch_new_entry(unsigned long entry, u64 mask)
 {
 	struct iommu_batch *p = this_cpu_ptr(&iommu_batch);
 
 	if (p->entry + p->npages = entry)
 		return;
 	if (p->entry != ~0UL)
-		iommu_batch_flush(p);
+		iommu_batch_flush(p, mask);
 	p->entry = entry;
 }
 
 /* Interrupts must be disabled.  */
-static inline long iommu_batch_add(u64 phys_page)
+static inline long iommu_batch_add(u64 phys_page, u64 mask)
 {
 	struct iommu_batch *p = this_cpu_ptr(&iommu_batch);
 
@@ -131,28 +152,31 @@ static inline long iommu_batch_add(u64 phys_page)
 
 	p->pglist[p->npages++] = phys_page;
 	if (p->npages = PGLIST_NENTS)
-		return iommu_batch_flush(p);
+		return iommu_batch_flush(p, mask);
 
 	return 0;
 }
 
 /* Interrupts must be disabled.  */
-static inline long iommu_batch_end(void)
+static inline long iommu_batch_end(u64 mask)
 {
 	struct iommu_batch *p = this_cpu_ptr(&iommu_batch);
 
 	BUG_ON(p->npages >= PGLIST_NENTS);
 
-	return iommu_batch_flush(p);
+	return iommu_batch_flush(p, mask);
 }
 
 static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 				   dma_addr_t *dma_addrp, gfp_t gfp,
 				   unsigned long attrs)
 {
+	u64 mask;
 	unsigned long flags, order, first_page, npages, n;
 	unsigned long prot = 0;
 	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
 	struct page *page;
 	void *ret;
 	long entry;
@@ -177,14 +201,21 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	memset((char *)first_page, 0, PAGE_SIZE << order);
 
 	iommu = dev->archdata.iommu;
+	atu = iommu->atu;
+
+	mask = dev->coherent_dma_mask;
+	if (mask <= DMA_BIT_MASK(32))
+		tbl = &iommu->tbl;
+	else
+		tbl = &atu->tbl;
 
-	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
+	entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
 				      (unsigned long)(-1), 0);
 
 	if (unlikely(entry = IOMMU_ERROR_CODE))
 		goto range_alloc_fail;
 
-	*dma_addrp = (iommu->tbl.table_map_base + (entry << IO_PAGE_SHIFT));
+	*dma_addrp = (tbl->table_map_base + (entry << IO_PAGE_SHIFT));
 	ret = (void *) first_page;
 	first_page = __pa(first_page);
 
@@ -196,12 +227,12 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 			  entry);
 
 	for (n = 0; n < npages; n++) {
-		long err = iommu_batch_add(first_page + (n * PAGE_SIZE));
+		long err = iommu_batch_add(first_page + (n * PAGE_SIZE), mask);
 		if (unlikely(err < 0L))
 			goto iommu_map_fail;
 	}
 
-	if (unlikely(iommu_batch_end() < 0L))
+	if (unlikely(iommu_batch_end(mask) < 0L))
 		goto iommu_map_fail;
 
 	local_irq_restore(flags);
@@ -209,7 +240,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	return ret;
 
 iommu_map_fail:
-	iommu_tbl_range_free(&iommu->tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
+	iommu_tbl_range_free(tbl, *dma_addrp, npages, IOMMU_ERROR_CODE);
 
 range_alloc_fail:
 	free_pages(first_page, order);
@@ -253,18 +284,27 @@ unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
 	return 0;
 }
 
-static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
-			       unsigned long npages)
+static void dma_4v_iommu_demap(struct device *dev, unsigned long devhandle,
+			       dma_addr_t dvma, unsigned long iotsb_num,
+			       unsigned long entry, unsigned long npages)
 {
-	u32 devhandle = *(u32 *)demap_arg;
 	unsigned long num, flags;
+	unsigned long ret;
 
 	local_irq_save(flags);
 	do {
-		num = pci_sun4v_iommu_demap(devhandle,
-					    HV_PCI_TSBID(0, entry),
-					    npages);
-
+		if (dvma <= DMA_BIT_MASK(32)) {
+			num = pci_sun4v_iommu_demap(devhandle,
+						    HV_PCI_TSBID(0, entry),
+						    npages);
+		} else {
+			ret = pci_sun4v_iotsb_demap(devhandle, iotsb_num,
+						    entry, npages, &num);
+			if (unlikely(ret != HV_EOK)) {
+				pr_err_ratelimited("pci_iotsb_demap() failed with error: %ld\n",
+						   ret);
+			}
+		}
 		entry += num;
 		npages -= num;
 	} while (npages != 0);
@@ -276,16 +316,28 @@ static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
 	unsigned long order, npages, entry;
+	unsigned long iotsb_num;
 	u32 devhandle;
 
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
 	pbm = dev->archdata.host_controller;
+	atu = iommu->atu;
 	devhandle = pbm->devhandle;
-	entry = ((dvma - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT);
-	dma_4v_iommu_demap(&devhandle, entry, npages);
-	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
+
+	if (dvma <= DMA_BIT_MASK(32)) {
+		tbl = &iommu->tbl;
+		iotsb_num = 0; /* we don't care for legacy iommu */
+	} else {
+		tbl = &atu->tbl;
+		iotsb_num = atu->iotsb->iotsb_num;
+	}
+	entry = ((dvma - tbl->table_map_base) >> IO_PAGE_SHIFT);
+	dma_4v_iommu_demap(dev, devhandle, dvma, iotsb_num, entry, npages);
+	iommu_tbl_range_free(tbl, dvma, npages, IOMMU_ERROR_CODE);
 	order = get_order(size);
 	if (order < 10)
 		free_pages((unsigned long)cpu, order);
@@ -297,13 +349,17 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 				  unsigned long attrs)
 {
 	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
+	u64 mask;
 	unsigned long flags, npages, oaddr;
 	unsigned long i, base_paddr;
-	u32 bus_addr, ret;
 	unsigned long prot;
+	dma_addr_t bus_addr, ret;
 	long entry;
 
 	iommu = dev->archdata.iommu;
+	atu = iommu->atu;
 
 	if (unlikely(direction = DMA_NONE))
 		goto bad;
@@ -312,13 +368,19 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 
-	entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages, NULL,
+	mask = *dev->dma_mask;
+	if (mask <= DMA_BIT_MASK(32))
+		tbl = &iommu->tbl;
+	else
+		tbl = &atu->tbl;
+
+	entry = iommu_tbl_range_alloc(dev, tbl, npages, NULL,
 				      (unsigned long)(-1), 0);
 
 	if (unlikely(entry = IOMMU_ERROR_CODE))
 		goto bad;
 
-	bus_addr = (iommu->tbl.table_map_base + (entry << IO_PAGE_SHIFT));
+	bus_addr = (tbl->table_map_base + (entry << IO_PAGE_SHIFT));
 	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
 	base_paddr = __pa(oaddr & IO_PAGE_MASK);
 	prot = HV_PCI_MAP_ATTR_READ;
@@ -333,11 +395,11 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 	iommu_batch_start(dev, prot, entry);
 
 	for (i = 0; i < npages; i++, base_paddr += IO_PAGE_SIZE) {
-		long err = iommu_batch_add(base_paddr);
+		long err = iommu_batch_add(base_paddr, mask);
 		if (unlikely(err < 0L))
 			goto iommu_map_fail;
 	}
-	if (unlikely(iommu_batch_end() < 0L))
+	if (unlikely(iommu_batch_end(mask) < 0L))
 		goto iommu_map_fail;
 
 	local_irq_restore(flags);
@@ -350,7 +412,7 @@ bad:
 	return DMA_ERROR_CODE;
 
 iommu_map_fail:
-	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, IOMMU_ERROR_CODE);
+	iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
 	return DMA_ERROR_CODE;
 }
 
@@ -360,7 +422,10 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
 	unsigned long npages;
+	unsigned long iotsb_num;
 	long entry;
 	u32 devhandle;
 
@@ -372,14 +437,23 @@ static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
 
 	iommu = dev->archdata.iommu;
 	pbm = dev->archdata.host_controller;
+	atu = iommu->atu;
 	devhandle = pbm->devhandle;
 
 	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
 	npages >>= IO_PAGE_SHIFT;
 	bus_addr &= IO_PAGE_MASK;
-	entry = (bus_addr - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT;
-	dma_4v_iommu_demap(&devhandle, entry, npages);
-	iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, IOMMU_ERROR_CODE);
+
+	if (bus_addr <= DMA_BIT_MASK(32)) {
+		iotsb_num = 0; /* we don't care for legacy iommu */
+		tbl = &iommu->tbl;
+	} else {
+		iotsb_num = atu->iotsb->iotsb_num;
+		tbl = &atu->tbl;
+	}
+	entry = (bus_addr - tbl->table_map_base) >> IO_PAGE_SHIFT;
+	dma_4v_iommu_demap(dev, devhandle, bus_addr, iotsb_num, entry, npages);
+	iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
 }
 
 static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
@@ -393,12 +467,17 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	unsigned long seg_boundary_size;
 	int outcount, incount, i;
 	struct iommu *iommu;
+	struct atu *atu;
+	struct iommu_map_table *tbl;
+	u64 mask;
 	unsigned long base_shift;
 	long err;
 
 	BUG_ON(direction = DMA_NONE);
 
 	iommu = dev->archdata.iommu;
+	atu = iommu->atu;
+
 	if (nelems = 0 || !iommu)
 		return 0;
 	
@@ -424,7 +503,15 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	max_seg_size = dma_get_max_seg_size(dev);
 	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
 				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
-	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
+
+	mask = *dev->dma_mask;
+	if (mask <= DMA_BIT_MASK(32))
+		tbl = &iommu->tbl;
+	else
+		tbl = &atu->tbl;
+
+	base_shift = tbl->table_map_base >> IO_PAGE_SHIFT;
+
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
 
@@ -437,27 +524,26 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		/* Allocate iommu entries for that segment */
 		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
-		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
+		entry = iommu_tbl_range_alloc(dev, tbl, npages,
 					      &handle, (unsigned long)(-1), 0);
 
 		/* Handle failure */
 		if (unlikely(entry = IOMMU_ERROR_CODE)) {
-			if (printk_ratelimit())
-				printk(KERN_INFO "iommu_alloc failed, iommu %p paddr %lx"
-				       " npages %lx\n", iommu, paddr, npages);
+			pr_err_ratelimited("iommu_alloc failed, iommu %p paddr %lx npages %lx\n",
+					   tbl, paddr, npages);
 			goto iommu_map_failed;
 		}
 
-		iommu_batch_new_entry(entry);
+		iommu_batch_new_entry(entry, mask);
 
 		/* Convert entry to a dma_addr_t */
-		dma_addr = iommu->tbl.table_map_base + (entry << IO_PAGE_SHIFT);
+		dma_addr = tbl->table_map_base + (entry << IO_PAGE_SHIFT);
 		dma_addr |= (s->offset & ~IO_PAGE_MASK);
 
 		/* Insert into HW table */
 		paddr &= IO_PAGE_MASK;
 		while (npages--) {
-			err = iommu_batch_add(paddr);
+			err = iommu_batch_add(paddr, mask);
 			if (unlikely(err < 0L))
 				goto iommu_map_failed;
 			paddr += IO_PAGE_SIZE;
@@ -492,7 +578,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 		dma_next = dma_addr + slen;
 	}
 
-	err = iommu_batch_end();
+	err = iommu_batch_end(mask);
 
 	if (unlikely(err < 0L))
 		goto iommu_map_failed;
@@ -515,7 +601,7 @@ iommu_map_failed:
 			vaddr = s->dma_address & IO_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IO_PAGE_SIZE);
-			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
+			iommu_tbl_range_free(tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
 			/* XXX demap? XXX */
 			s->dma_address = DMA_ERROR_CODE;
@@ -536,13 +622,16 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct pci_pbm_info *pbm;
 	struct scatterlist *sg;
 	struct iommu *iommu;
+	struct atu *atu;
 	unsigned long flags, entry;
+	unsigned long iotsb_num;
 	u32 devhandle;
 
 	BUG_ON(direction = DMA_NONE);
 
 	iommu = dev->archdata.iommu;
 	pbm = dev->archdata.host_controller;
+	atu = iommu->atu;
 	devhandle = pbm->devhandle;
 	
 	local_irq_save(flags);
@@ -552,15 +641,24 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		dma_addr_t dma_handle = sg->dma_address;
 		unsigned int len = sg->dma_length;
 		unsigned long npages;
-		struct iommu_map_table *tbl = &iommu->tbl;
+		struct iommu_map_table *tbl;
 		unsigned long shift = IO_PAGE_SHIFT;
 
 		if (!len)
 			break;
 		npages = iommu_num_pages(dma_handle, len, IO_PAGE_SIZE);
+
+		if (dma_handle <= DMA_BIT_MASK(32)) {
+			iotsb_num = 0; /* we don't care for legacy iommu */
+			tbl = &iommu->tbl;
+		} else {
+			iotsb_num = atu->iotsb->iotsb_num;
+			tbl = &atu->tbl;
+		}
 		entry = ((dma_handle - tbl->table_map_base) >> shift);
-		dma_4v_iommu_demap(&devhandle, entry, npages);
-		iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
+		dma_4v_iommu_demap(dev, devhandle, dma_handle, iotsb_num,
+				   entry, npages);
+		iommu_tbl_range_free(tbl, dma_handle, npages,
 				     IOMMU_ERROR_CODE);
 		sg = sg_next(sg);
 	}
diff --git a/arch/sparc/kernel/pci_sun4v.h b/arch/sparc/kernel/pci_sun4v.h
index 1019e0f..22603a4 100644
--- a/arch/sparc/kernel/pci_sun4v.h
+++ b/arch/sparc/kernel/pci_sun4v.h
@@ -99,4 +99,15 @@ unsigned long pci_sun4v_iotsb_conf(unsigned long devhandle,
 unsigned long pci_sun4v_iotsb_bind(unsigned long devhandle,
 				   unsigned long iotsb_num,
 				   unsigned int pci_device);
+unsigned long pci_sun4v_iotsb_map(unsigned long devhandle,
+				  unsigned long iotsb_num,
+				  unsigned long iotsb_index_iottes,
+				  unsigned long io_attributes,
+				  unsigned long io_page_list_pa,
+				  long *mapped);
+unsigned long pci_sun4v_iotsb_demap(unsigned long devhandle,
+				    unsigned long iotsb_num,
+				    unsigned long iotsb_index,
+				    unsigned long iottes,
+				    unsigned long *demapped);
 #endif /* !(_PCI_SUN4V_H) */
diff --git a/arch/sparc/kernel/pci_sun4v_asm.S b/arch/sparc/kernel/pci_sun4v_asm.S
index 22024a9..578f096 100644
--- a/arch/sparc/kernel/pci_sun4v_asm.S
+++ b/arch/sparc/kernel/pci_sun4v_asm.S
@@ -392,3 +392,39 @@ ENTRY(pci_sun4v_iotsb_bind)
 	retl
 	 nop
 ENDPROC(pci_sun4v_iotsb_bind)
+
+	/*
+	 * %o0:	devhandle
+	 * %o1:	iotsb_num/iotsb_handle
+	 * %o2:	index_count
+	 * %o3:	iotte_attributes
+	 * %o4:	io_page_list_p
+	 * %o5: &mapped
+	 *
+	 * returns %o0:	status
+	 *         %o1:	#mapped
+	 */
+ENTRY(pci_sun4v_iotsb_map)
+	mov	%o5, %g1
+	mov	HV_FAST_PCI_IOTSB_MAP, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 stx	%o1, [%g1]
+ENDPROC(pci_sun4v_iotsb_map)
+
+	/*
+	 * %o0:	devhandle
+	 * %o1:	iotsb_num/iotsb_handle
+	 * %o2:	iotsb_index
+	 * %o3:	#iottes
+	 * %o4: &demapped
+	 *
+	 * returns %o0:	status
+	 *         %o1:	#demapped
+	 */
+ENTRY(pci_sun4v_iotsb_demap)
+	mov	HV_FAST_PCI_IOTSB_DEMAP, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 stx	%o1, [%o4]
+ENDPROC(pci_sun4v_iotsb_demap)
-- 
1.9.1

