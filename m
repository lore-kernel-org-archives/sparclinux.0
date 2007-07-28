From: David Miller <davem@davemloft.net>
Date: Sat, 28 Jul 2007 05:55:52 +0000
Subject: Re: new parport_pc BUG
Message-Id: <20070727.225552.88342735.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 22:29:53 +0300 (EEST)

> I tested todays git (2.6.23-rc1-gd941cf5e) on Ultra 5 and got a new 
> parport_pc BUG. This time the call trace is different than last time.
> 
> The line in question is BUG_ON(dev->bus != &pci_bus_type);

This patch is big, but this transformation has been pending for
a long time, and I tested that parport_pc works on my ultra5.

Can you test it for me?

Thanks.

commit 17a90e098eb763d302436c652a5f05d7e58ea60e
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Fri Jul 27 22:39:14 2007 -0700

    [SPARC64]: Fix conflicts in SBUS/PCI/EBUS/ISA DMA handling.
    
    Fully unify all of the DMA ops so that subordinate bus types to
    the DMA operation providers (such as ebus, isa, of_device) can
    work transparently.
    
    Basically, we just make sure that for every system device we
    create, the dev->archdata 'iommu' and 'stc' fields are filled
    in.
    
    Then we have two platform variants of the DMA ops, one for SUN4U which
    actually programs the real hardware, and one for SUN4V which makes
    hypervisor calls.
    
    This also fixes the crashes in parport_pc on sparc64, reported by
    Meelis Roos.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
index b66876b..40d2f3a 100644
--- a/arch/sparc64/kernel/Makefile
+++ b/arch/sparc64/kernel/Makefile
@@ -8,14 +8,14 @@ EXTRA_CFLAGS := -Werror
 extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		:= process.o setup.o cpu.o idprom.o \
-		   traps.o auxio.o una_asm.o sysfs.o \
+		   traps.o auxio.o una_asm.o sysfs.o iommu.o \
 		   irq.o ptrace.o time.o sys_sparc.o signal.o \
 		   unaligned.o central.o pci.o starfire.o semaphore.o \
 		   power.o sbus.o iommu_common.o sparc64_ksyms.o chmc.o \
 		   visemul.o prom.o of_device.o hvapi.o sstate.o mdesc.o
 
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-$(CONFIG_PCI)	 += ebus.o isa.o pci_common.o pci_iommu.o \
+obj-$(CONFIG_PCI)	 += ebus.o isa.o pci_common.o \
 			    pci_psycho.o pci_sabre.o pci_schizo.o \
 			    pci_sun4v.o pci_sun4v_asm.o pci_fire.o
 obj-$(CONFIG_SMP)	 += smp.o trampoline.o hvtramp.o
diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
index 6d29561..bc9ae36 100644
--- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -391,6 +391,8 @@ static void __init fill_ebus_device(struct device_node *dp, struct linux_ebus_de
 	sd = &dev->ofdev.dev.archdata;
 	sd->prom_node = dp;
 	sd->op = &dev->ofdev;
+	sd->iommu = dev->bus->ofdev.dev.parent->archdata.iommu;
+	sd->stc = dev->bus->ofdev.dev.parent->archdata.stc;
 
 	dev->ofdev.node = dp;
 	dev->ofdev.dev.parent = &dev->bus->ofdev.dev;
diff --git a/arch/sparc64/kernel/iommu.c b/arch/sparc64/kernel/iommu.c
new file mode 100644
index 0000000..cf59c72
--- /dev/null
+++ b/arch/sparc64/kernel/iommu.c
@@ -0,0 +1,809 @@
+/* iommu.c: Generic sparc64 IOMMU support.
+ *
+ * Copyright (C) 1999, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1999, 2000 Jakub Jelinek (jakub@redhat.com)
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+#endif
+
+#include <asm/iommu.h>
+
+#include "iommu_common.h"
+
+#define STC_CTXMATCH_ADDR(STC, CTX)	\
+	((STC)->strbuf_ctxmatch_base + ((CTX) << 3))
+#define STC_FLUSHFLAG_INIT(STC) \
+	(*((STC)->strbuf_flushflag) = 0UL)
+#define STC_FLUSHFLAG_SET(STC) \
+	(*((STC)->strbuf_flushflag) != 0UL)
+
+#define iommu_read(__reg) \
+({	u64 __ret; \
+	__asm__ __volatile__("ldxa [%1] %2, %0" \
+			     : "=r" (__ret) \
+			     : "r" (__reg), "i" (ASI_PHYS_BYPASS_EC_E) \
+			     : "memory"); \
+	__ret; \
+})
+#define iommu_write(__reg, __val) \
+	__asm__ __volatile__("stxa %0, [%1] %2" \
+			     : /* no outputs */ \
+			     : "r" (__val), "r" (__reg), \
+			       "i" (ASI_PHYS_BYPASS_EC_E))
+
+/* Must be invoked under the IOMMU lock. */
+static void __iommu_flushall(struct iommu *iommu)
+{
+	if (iommu->iommu_flushinv) {
+		iommu_write(iommu->iommu_flushinv, ~(u64)0);
+	} else {
+		unsigned long tag;
+		int entry;
+
+		tag = iommu->iommu_tags;
+		for (entry = 0; entry < 16; entry++) {
+			iommu_write(tag, 0);
+			tag += 8;
+		}
+
+		/* Ensure completion of previous PIO writes. */
+		(void) iommu_read(iommu->write_complete_reg);
+	}
+}
+
+#define IOPTE_CONSISTENT(CTX) \
+	(IOPTE_VALID | IOPTE_CACHE | \
+	 (((CTX) << 47) & IOPTE_CONTEXT))
+
+#define IOPTE_STREAMING(CTX) \
+	(IOPTE_CONSISTENT(CTX) | IOPTE_STBUF)
+
+/* Existing mappings are never marked invalid, instead they
+ * are pointed to a dummy page.
+ */
+#define IOPTE_IS_DUMMY(iommu, iopte)	\
+	((iopte_val(*iopte) & IOPTE_PAGE) = (iommu)->dummy_page_pa)
+
+static inline void iopte_make_dummy(struct iommu *iommu, iopte_t *iopte)
+{
+	unsigned long val = iopte_val(*iopte);
+
+	val &= ~IOPTE_PAGE;
+	val |= iommu->dummy_page_pa;
+
+	iopte_val(*iopte) = val;
+}
+
+/* Based largely upon the ppc64 iommu allocator.  */
+static long arena_alloc(struct iommu *iommu, unsigned long npages)
+{
+	struct iommu_arena *arena = &iommu->arena;
+	unsigned long n, i, start, end, limit;
+	int pass;
+
+	limit = arena->limit;
+	start = arena->hint;
+	pass = 0;
+
+again:
+	n = find_next_zero_bit(arena->map, limit, start);
+	end = n + npages;
+	if (unlikely(end >= limit)) {
+		if (likely(pass < 1)) {
+			limit = start;
+			start = 0;
+			__iommu_flushall(iommu);
+			pass++;
+			goto again;
+		} else {
+			/* Scanned the whole thing, give up. */
+			return -1;
+		}
+	}
+
+	for (i = n; i < end; i++) {
+		if (test_bit(i, arena->map)) {
+			start = i + 1;
+			goto again;
+		}
+	}
+
+	for (i = n; i < end; i++)
+		__set_bit(i, arena->map);
+
+	arena->hint = end;
+
+	return n;
+}
+
+static void arena_free(struct iommu_arena *arena, unsigned long base, unsigned long npages)
+{
+	unsigned long i;
+
+	for (i = base; i < (base + npages); i++)
+		__clear_bit(i, arena->map);
+}
+
+int iommu_table_init(struct iommu *iommu, int tsbsize,
+		     u32 dma_offset, u32 dma_addr_mask)
+{
+	unsigned long i, tsbbase, order, sz, num_tsb_entries;
+
+	num_tsb_entries = tsbsize / sizeof(iopte_t);
+
+	/* Setup initial software IOMMU state. */
+	spin_lock_init(&iommu->lock);
+	iommu->ctx_lowest_free = 1;
+	iommu->page_table_map_base = dma_offset;
+	iommu->dma_addr_mask = dma_addr_mask;
+
+	/* Allocate and initialize the free area map.  */
+	sz = num_tsb_entries / 8;
+	sz = (sz + 7UL) & ~7UL;
+	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
+	if (!iommu->arena.map) {
+		printk(KERN_ERR "IOMMU: Error, kmalloc(arena.map) failed.\n");
+		return -ENOMEM;
+	}
+	iommu->arena.limit = num_tsb_entries;
+
+	/* Allocate and initialize the dummy page which we
+	 * set inactive IO PTEs to point to.
+	 */
+	iommu->dummy_page = __get_free_pages(GFP_KERNEL, 0);
+	if (!iommu->dummy_page) {
+		printk(KERN_ERR "IOMMU: Error, gfp(dummy_page) failed.\n");
+		goto out_free_map;
+	}
+	memset((void *)iommu->dummy_page, 0, PAGE_SIZE);
+	iommu->dummy_page_pa = (unsigned long) __pa(iommu->dummy_page);
+
+	/* Now allocate and setup the IOMMU page table itself.  */
+	order = get_order(tsbsize);
+	tsbbase = __get_free_pages(GFP_KERNEL, order);
+	if (!tsbbase) {
+		printk(KERN_ERR "IOMMU: Error, gfp(tsb) failed.\n");
+		goto out_free_dummy_page;
+	}
+	iommu->page_table = (iopte_t *)tsbbase;
+
+	for (i = 0; i < num_tsb_entries; i++)
+		iopte_make_dummy(iommu, &iommu->page_table[i]);
+
+	return 0;
+
+out_free_dummy_page:
+	free_page(iommu->dummy_page);
+	iommu->dummy_page = 0UL;
+
+out_free_map:
+	kfree(iommu->arena.map);
+	iommu->arena.map = NULL;
+
+	return -ENOMEM;
+}
+
+static inline iopte_t *alloc_npages(struct iommu *iommu, unsigned long npages)
+{
+	long entry;
+
+	entry = arena_alloc(iommu, npages);
+	if (unlikely(entry < 0))
+		return NULL;
+
+	return iommu->page_table + entry;
+}
+
+static inline void free_npages(struct iommu *iommu, dma_addr_t base, unsigned long npages)
+{
+	arena_free(&iommu->arena, base >> IO_PAGE_SHIFT, npages);
+}
+
+static int iommu_alloc_ctx(struct iommu *iommu)
+{
+	int lowest = iommu->ctx_lowest_free;
+	int sz = IOMMU_NUM_CTXS - lowest;
+	int n = find_next_zero_bit(iommu->ctx_bitmap, sz, lowest);
+
+	if (unlikely(n = sz)) {
+		n = find_next_zero_bit(iommu->ctx_bitmap, lowest, 1);
+		if (unlikely(n = lowest)) {
+			printk(KERN_WARNING "IOMMU: Ran out of contexts.\n");
+			n = 0;
+		}
+	}
+	if (n)
+		__set_bit(n, iommu->ctx_bitmap);
+
+	return n;
+}
+
+static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
+{
+	if (likely(ctx)) {
+		__clear_bit(ctx, iommu->ctx_bitmap);
+		if (ctx < iommu->ctx_lowest_free)
+			iommu->ctx_lowest_free = ctx;
+	}
+}
+
+static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
+				   dma_addr_t *dma_addrp, gfp_t gfp)
+{
+	struct iommu *iommu;
+	iopte_t *iopte;
+	unsigned long flags, order, first_page;
+	void *ret;
+	int npages;
+
+	size = IO_PAGE_ALIGN(size);
+	order = get_order(size);
+	if (order >= 10)
+		return NULL;
+
+	first_page = __get_free_pages(gfp, order);
+	if (first_page = 0UL)
+		return NULL;
+	memset((char *)first_page, 0, PAGE_SIZE << order);
+
+	iommu = dev->archdata.iommu;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	iopte = alloc_npages(iommu, size >> IO_PAGE_SHIFT);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	if (unlikely(iopte = NULL)) {
+		free_pages(first_page, order);
+		return NULL;
+	}
+
+	*dma_addrp = (iommu->page_table_map_base +
+		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
+	ret = (void *) first_page;
+	npages = size >> IO_PAGE_SHIFT;
+	first_page = __pa(first_page);
+	while (npages--) {
+		iopte_val(*iopte) = (IOPTE_CONSISTENT(0UL) |
+				     IOPTE_WRITE |
+				     (first_page & IOPTE_PAGE));
+		iopte++;
+		first_page += IO_PAGE_SIZE;
+	}
+
+	return ret;
+}
+
+static void dma_4u_free_coherent(struct device *dev, size_t size,
+				 void *cpu, dma_addr_t dvma)
+{
+	struct iommu *iommu;
+	iopte_t *iopte;
+	unsigned long flags, order, npages;
+
+	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
+	iommu = dev->archdata.iommu;
+	iopte = iommu->page_table +
+		((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	free_npages(iommu, dvma - iommu->page_table_map_base, npages);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	order = get_order(size);
+	if (order < 10)
+		free_pages((unsigned long)cpu, order);
+}
+
+static dma_addr_t dma_4u_map_single(struct device *dev, void *ptr, size_t sz,
+				    enum dma_data_direction direction)
+{
+	struct iommu *iommu;
+	struct strbuf *strbuf;
+	iopte_t *base;
+	unsigned long flags, npages, oaddr;
+	unsigned long i, base_paddr, ctx;
+	u32 bus_addr, ret;
+	unsigned long iopte_protection;
+
+	iommu = dev->archdata.iommu;
+	strbuf = dev->archdata.stc;
+
+	if (unlikely(direction = DMA_NONE))
+		goto bad_no_ctx;
+
+	oaddr = (unsigned long)ptr;
+	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
+	npages >>= IO_PAGE_SHIFT;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	base = alloc_npages(iommu, npages);
+	ctx = 0;
+	if (iommu->iommu_ctxflush)
+		ctx = iommu_alloc_ctx(iommu);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	if (unlikely(!base))
+		goto bad;
+
+	bus_addr = (iommu->page_table_map_base +
+		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
+	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
+	base_paddr = __pa(oaddr & IO_PAGE_MASK);
+	if (strbuf->strbuf_enabled)
+		iopte_protection = IOPTE_STREAMING(ctx);
+	else
+		iopte_protection = IOPTE_CONSISTENT(ctx);
+	if (direction != DMA_TO_DEVICE)
+		iopte_protection |= IOPTE_WRITE;
+
+	for (i = 0; i < npages; i++, base++, base_paddr += IO_PAGE_SIZE)
+		iopte_val(*base) = iopte_protection | base_paddr;
+
+	return ret;
+
+bad:
+	iommu_free_ctx(iommu, ctx);
+bad_no_ctx:
+	if (printk_ratelimit())
+		WARN_ON(1);
+	return DMA_ERROR_CODE;
+}
+
+static void strbuf_flush(struct strbuf *strbuf, struct iommu *iommu,
+			 u32 vaddr, unsigned long ctx, unsigned long npages,
+			 enum dma_data_direction direction)
+{
+	int limit;
+
+	if (strbuf->strbuf_ctxflush &&
+	    iommu->iommu_ctxflush) {
+		unsigned long matchreg, flushreg;
+		u64 val;
+
+		flushreg = strbuf->strbuf_ctxflush;
+		matchreg = STC_CTXMATCH_ADDR(strbuf, ctx);
+
+		iommu_write(flushreg, ctx);
+		val = iommu_read(matchreg);
+		val &= 0xffff;
+		if (!val)
+			goto do_flush_sync;
+
+		while (val) {
+			if (val & 0x1)
+				iommu_write(flushreg, ctx);
+			val >>= 1;
+		}
+		val = iommu_read(matchreg);
+		if (unlikely(val)) {
+			printk(KERN_WARNING "strbuf_flush: ctx flush "
+			       "timeout matchreg[%lx] ctx[%lx]\n",
+			       val, ctx);
+			goto do_page_flush;
+		}
+	} else {
+		unsigned long i;
+
+	do_page_flush:
+		for (i = 0; i < npages; i++, vaddr += IO_PAGE_SIZE)
+			iommu_write(strbuf->strbuf_pflush, vaddr);
+	}
+
+do_flush_sync:
+	/* If the device could not have possibly put dirty data into
+	 * the streaming cache, no flush-flag synchronization needs
+	 * to be performed.
+	 */
+	if (direction = DMA_TO_DEVICE)
+		return;
+
+	STC_FLUSHFLAG_INIT(strbuf);
+	iommu_write(strbuf->strbuf_fsync, strbuf->strbuf_flushflag_pa);
+	(void) iommu_read(iommu->write_complete_reg);
+
+	limit = 100000;
+	while (!STC_FLUSHFLAG_SET(strbuf)) {
+		limit--;
+		if (!limit)
+			break;
+		udelay(1);
+		rmb();
+	}
+	if (!limit)
+		printk(KERN_WARNING "strbuf_flush: flushflag timeout "
+		       "vaddr[%08x] ctx[%lx] npages[%ld]\n",
+		       vaddr, ctx, npages);
+}
+
+static void dma_4u_unmap_single(struct device *dev, dma_addr_t bus_addr,
+				size_t sz, enum dma_data_direction direction)
+{
+	struct iommu *iommu;
+	struct strbuf *strbuf;
+	iopte_t *base;
+	unsigned long flags, npages, ctx, i;
+
+	if (unlikely(direction = DMA_NONE)) {
+		if (printk_ratelimit())
+			WARN_ON(1);
+		return;
+	}
+
+	iommu = dev->archdata.iommu;
+	strbuf = dev->archdata.stc;
+
+	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
+	npages >>= IO_PAGE_SHIFT;
+	base = iommu->page_table +
+		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+	bus_addr &= IO_PAGE_MASK;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Record the context, if any. */
+	ctx = 0;
+	if (iommu->iommu_ctxflush)
+		ctx = (iopte_val(*base) & IOPTE_CONTEXT) >> 47UL;
+
+	/* Step 1: Kick data out of streaming buffers if necessary. */
+	if (strbuf->strbuf_enabled)
+		strbuf_flush(strbuf, iommu, bus_addr, ctx,
+			     npages, direction);
+
+	/* Step 2: Clear out TSB entries. */
+	for (i = 0; i < npages; i++)
+		iopte_make_dummy(iommu, base + i);
+
+	free_npages(iommu, bus_addr - iommu->page_table_map_base, npages);
+
+	iommu_free_ctx(iommu, ctx);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+#define SG_ENT_PHYS_ADDRESS(SG)	\
+	(__pa(page_address((SG)->page)) + (SG)->offset)
+
+static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg,
+			   int nused, int nelems,
+			   unsigned long iopte_protection)
+{
+	struct scatterlist *dma_sg = sg;
+	struct scatterlist *sg_end = sg + nelems;
+	int i;
+
+	for (i = 0; i < nused; i++) {
+		unsigned long pteval = ~0UL;
+		u32 dma_npages;
+
+		dma_npages = ((dma_sg->dma_address & (IO_PAGE_SIZE - 1UL)) +
+			      dma_sg->dma_length +
+			      ((IO_PAGE_SIZE - 1UL))) >> IO_PAGE_SHIFT;
+		do {
+			unsigned long offset;
+			signed int len;
+
+			/* If we are here, we know we have at least one
+			 * more page to map.  So walk forward until we
+			 * hit a page crossing, and begin creating new
+			 * mappings from that spot.
+			 */
+			for (;;) {
+				unsigned long tmp;
+
+				tmp = SG_ENT_PHYS_ADDRESS(sg);
+				len = sg->length;
+				if (((tmp ^ pteval) >> IO_PAGE_SHIFT) != 0UL) {
+					pteval = tmp & IO_PAGE_MASK;
+					offset = tmp & (IO_PAGE_SIZE - 1UL);
+					break;
+				}
+				if (((tmp ^ (tmp + len - 1UL)) >> IO_PAGE_SHIFT) != 0UL) {
+					pteval = (tmp + IO_PAGE_SIZE) & IO_PAGE_MASK;
+					offset = 0UL;
+					len -= (IO_PAGE_SIZE - (tmp & (IO_PAGE_SIZE - 1UL)));
+					break;
+				}
+				sg++;
+			}
+
+			pteval = iopte_protection | (pteval & IOPTE_PAGE);
+			while (len > 0) {
+				*iopte++ = __iopte(pteval);
+				pteval += IO_PAGE_SIZE;
+				len -= (IO_PAGE_SIZE - offset);
+				offset = 0;
+				dma_npages--;
+			}
+
+			pteval = (pteval & IOPTE_PAGE) + len;
+			sg++;
+
+			/* Skip over any tail mappings we've fully mapped,
+			 * adjusting pteval along the way.  Stop when we
+			 * detect a page crossing event.
+			 */
+			while (sg < sg_end &&
+			       (pteval << (64 - IO_PAGE_SHIFT)) != 0UL &&
+			       (pteval = SG_ENT_PHYS_ADDRESS(sg)) &&
+			       ((pteval ^
+				 (SG_ENT_PHYS_ADDRESS(sg) + sg->length - 1UL)) >> IO_PAGE_SHIFT) = 0UL) {
+				pteval += sg->length;
+				sg++;
+			}
+			if ((pteval << (64 - IO_PAGE_SHIFT)) = 0UL)
+				pteval = ~0UL;
+		} while (dma_npages != 0);
+		dma_sg++;
+	}
+}
+
+static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
+			 int nelems, enum dma_data_direction direction)
+{
+	struct iommu *iommu;
+	struct strbuf *strbuf;
+	unsigned long flags, ctx, npages, iopte_protection;
+	iopte_t *base;
+	u32 dma_base;
+	struct scatterlist *sgtmp;
+	int used;
+
+	/* Fast path single entry scatterlists. */
+	if (nelems = 1) {
+		sglist->dma_address +			dma_4u_map_single(dev,
+					  (page_address(sglist->page) +
+					   sglist->offset),
+					  sglist->length, direction);
+		if (unlikely(sglist->dma_address = DMA_ERROR_CODE))
+			return 0;
+		sglist->dma_length = sglist->length;
+		return 1;
+	}
+
+	iommu = dev->archdata.iommu;
+	strbuf = dev->archdata.stc;
+	
+	if (unlikely(direction = DMA_NONE))
+		goto bad_no_ctx;
+
+	/* Step 1: Prepare scatter list. */
+
+	npages = prepare_sg(sglist, nelems);
+
+	/* Step 2: Allocate a cluster and context, if necessary. */
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	base = alloc_npages(iommu, npages);
+	ctx = 0;
+	if (iommu->iommu_ctxflush)
+		ctx = iommu_alloc_ctx(iommu);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	if (base = NULL)
+		goto bad;
+
+	dma_base = iommu->page_table_map_base +
+		((base - iommu->page_table) << IO_PAGE_SHIFT);
+
+	/* Step 3: Normalize DMA addresses. */
+	used = nelems;
+
+	sgtmp = sglist;
+	while (used && sgtmp->dma_length) {
+		sgtmp->dma_address += dma_base;
+		sgtmp++;
+		used--;
+	}
+	used = nelems - used;
+
+	/* Step 4: Create the mappings. */
+	if (strbuf->strbuf_enabled)
+		iopte_protection = IOPTE_STREAMING(ctx);
+	else
+		iopte_protection = IOPTE_CONSISTENT(ctx);
+	if (direction != DMA_TO_DEVICE)
+		iopte_protection |= IOPTE_WRITE;
+
+	fill_sg(base, sglist, used, nelems, iopte_protection);
+
+#ifdef VERIFY_SG
+	verify_sglist(sglist, nelems, base, npages);
+#endif
+
+	return used;
+
+bad:
+	iommu_free_ctx(iommu, ctx);
+bad_no_ctx:
+	if (printk_ratelimit())
+		WARN_ON(1);
+	return 0;
+}
+
+static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
+			    int nelems, enum dma_data_direction direction)
+{
+	struct iommu *iommu;
+	struct strbuf *strbuf;
+	iopte_t *base;
+	unsigned long flags, ctx, i, npages;
+	u32 bus_addr;
+
+	if (unlikely(direction = DMA_NONE)) {
+		if (printk_ratelimit())
+			WARN_ON(1);
+	}
+
+	iommu = dev->archdata.iommu;
+	strbuf = dev->archdata.stc;
+	
+	bus_addr = sglist->dma_address & IO_PAGE_MASK;
+
+	for (i = 1; i < nelems; i++)
+		if (sglist[i].dma_length = 0)
+			break;
+	i--;
+	npages = (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length) -
+		  bus_addr) >> IO_PAGE_SHIFT;
+
+	base = iommu->page_table +
+		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Record the context, if any. */
+	ctx = 0;
+	if (iommu->iommu_ctxflush)
+		ctx = (iopte_val(*base) & IOPTE_CONTEXT) >> 47UL;
+
+	/* Step 1: Kick data out of streaming buffers if necessary. */
+	if (strbuf->strbuf_enabled)
+		strbuf_flush(strbuf, iommu, bus_addr, ctx, npages, direction);
+
+	/* Step 2: Clear out the TSB entries. */
+	for (i = 0; i < npages; i++)
+		iopte_make_dummy(iommu, base + i);
+
+	free_npages(iommu, bus_addr - iommu->page_table_map_base, npages);
+
+	iommu_free_ctx(iommu, ctx);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+static void dma_4u_sync_single_for_cpu(struct device *dev,
+				       dma_addr_t bus_addr, size_t sz,
+				       enum dma_data_direction direction)
+{
+	struct iommu *iommu;
+	struct strbuf *strbuf;
+	unsigned long flags, ctx, npages;
+
+	iommu = dev->archdata.iommu;
+	strbuf = dev->archdata.stc;
+
+	if (!strbuf->strbuf_enabled)
+		return;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
+	npages >>= IO_PAGE_SHIFT;
+	bus_addr &= IO_PAGE_MASK;
+
+	/* Step 1: Record the context, if any. */
+	ctx = 0;
+	if (iommu->iommu_ctxflush &&
+	    strbuf->strbuf_ctxflush) {
+		iopte_t *iopte;
+
+		iopte = iommu->page_table +
+			((bus_addr - iommu->page_table_map_base)>>IO_PAGE_SHIFT);
+		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
+	}
+
+	/* Step 2: Kick data out of streaming buffers. */
+	strbuf_flush(strbuf, iommu, bus_addr, ctx, npages, direction);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+static void dma_4u_sync_sg_for_cpu(struct device *dev,
+				   struct scatterlist *sglist, int nelems,
+				   enum dma_data_direction direction)
+{
+	struct iommu *iommu;
+	struct strbuf *strbuf;
+	unsigned long flags, ctx, npages, i;
+	u32 bus_addr;
+
+	iommu = dev->archdata.iommu;
+	strbuf = dev->archdata.stc;
+
+	if (!strbuf->strbuf_enabled)
+		return;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	/* Step 1: Record the context, if any. */
+	ctx = 0;
+	if (iommu->iommu_ctxflush &&
+	    strbuf->strbuf_ctxflush) {
+		iopte_t *iopte;
+
+		iopte = iommu->page_table +
+			((sglist[0].dma_address - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
+		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
+	}
+
+	/* Step 2: Kick data out of streaming buffers. */
+	bus_addr = sglist[0].dma_address & IO_PAGE_MASK;
+	for(i = 1; i < nelems; i++)
+		if (!sglist[i].dma_length)
+			break;
+	i--;
+	npages = (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length)
+		  - bus_addr) >> IO_PAGE_SHIFT;
+	strbuf_flush(strbuf, iommu, bus_addr, ctx, npages, direction);
+
+	spin_unlock_irqrestore(&iommu->lock, flags);
+}
+
+const struct dma_ops sun4u_dma_ops = {
+	.alloc_coherent		= dma_4u_alloc_coherent,
+	.free_coherent		= dma_4u_free_coherent,
+	.map_single		= dma_4u_map_single,
+	.unmap_single		= dma_4u_unmap_single,
+	.map_sg			= dma_4u_map_sg,
+	.unmap_sg		= dma_4u_unmap_sg,
+	.sync_single_for_cpu	= dma_4u_sync_single_for_cpu,
+	.sync_sg_for_cpu	= dma_4u_sync_sg_for_cpu,
+};
+
+const struct dma_ops *dma_ops = &sun4u_dma_ops;
+EXPORT_SYMBOL(dma_ops);
+
+int dma_supported(struct device *dev, u64 device_mask)
+{
+	struct iommu *iommu = dev->archdata.iommu;
+	u64 dma_addr_mask = iommu->dma_addr_mask;
+
+	if (device_mask >= (1UL << 32UL))
+		return 0;
+
+	if ((device_mask & dma_addr_mask) = dma_addr_mask)
+		return 1;
+
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_dma_supported(to_pci_dev(dev), device_mask);
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL(dma_supported);
+
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus = &pci_bus_type)
+		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+#endif
+	return -EINVAL;
+}
+EXPORT_SYMBOL(dma_set_mask);
diff --git a/arch/sparc64/kernel/isa.c b/arch/sparc64/kernel/isa.c
index 1a1043f..0f19dce 100644
--- a/arch/sparc64/kernel/isa.c
+++ b/arch/sparc64/kernel/isa.c
@@ -90,6 +90,8 @@ static void __init isa_fill_devices(struct sparc_isa_bridge *isa_br)
 		sd = &isa_dev->ofdev.dev.archdata;
 		sd->prom_node = dp;
 		sd->op = &isa_dev->ofdev;
+		sd->iommu = isa_br->ofdev.dev.parent->archdata.iommu;
+		sd->stc = isa_br->ofdev.dev.parent->archdata.stc;
 
 		isa_dev->ofdev.node = dp;
 		isa_dev->ofdev.dev.parent = &isa_br->ofdev.dev;
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 77449a0..3d93e92 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -283,12 +283,6 @@ int __init pcic_present(void)
 	return pci_controller_scan(pci_is_controller);
 }
 
-const struct pci_iommu_ops *pci_iommu_ops;
-EXPORT_SYMBOL(pci_iommu_ops);
-
-extern const struct pci_iommu_ops pci_sun4u_iommu_ops,
-	pci_sun4v_iommu_ops;
-
 /* Find each controller in the system, attach and initialize
  * software state structure for each and link into the
  * pci_pbm_root.  Setup the controller enough such
@@ -296,11 +290,6 @@ extern const struct pci_iommu_ops pci_sun4u_iommu_ops,
  */
 static void __init pci_controller_probe(void)
 {
-	if (tlb_type = hypervisor)
-		pci_iommu_ops = &pci_sun4v_iommu_ops;
-	else
-		pci_iommu_ops = &pci_sun4u_iommu_ops;
-
 	printk("PCI: Probing for controllers.\n");
 
 	pci_controller_scan(pci_controller_init);
@@ -406,6 +395,10 @@ struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	sd->op = of_find_device_by_node(node);
 	sd->msi_num = 0xffffffff;
 
+	sd = &sd->op->dev.archdata;
+	sd->iommu = pbm->iommu;
+	sd->stc = &pbm->stc;
+
 	type = of_get_property(node, "device_type", NULL);
 	if (type = NULL)
 		type = "";
@@ -1226,4 +1219,51 @@ struct device_node *pci_device_to_OF_node(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pci_device_to_OF_node);
 
+static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
+{
+	struct pci_dev *ali_isa_bridge;
+	u8 val;
+
+	/* ALI sound chips generate 31-bits of DMA, a special register
+	 * determines what bit 31 is emitted as.
+	 */
+	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL,
+					 PCI_DEVICE_ID_AL_M1533,
+					 NULL);
+
+	pci_read_config_byte(ali_isa_bridge, 0x7e, &val);
+	if (set_bit)
+		val |= 0x01;
+	else
+		val &= ~0x01;
+	pci_write_config_byte(ali_isa_bridge, 0x7e, val);
+	pci_dev_put(ali_isa_bridge);
+}
+
+int pci_dma_supported(struct pci_dev *pdev, u64 device_mask)
+{
+	u64 dma_addr_mask;
+
+	if (pdev = NULL) {
+		dma_addr_mask = 0xffffffff;
+	} else {
+		struct iommu *iommu = pdev->dev.archdata.iommu;
+
+		dma_addr_mask = iommu->dma_addr_mask;
+
+		if (pdev->vendor = PCI_VENDOR_ID_AL &&
+		    pdev->device = PCI_DEVICE_ID_AL_M5451 &&
+		    device_mask = 0x7fffffff) {
+			ali_sound_dma_hack(pdev,
+					   (dma_addr_mask & 0x80000000) != 0);
+			return 1;
+		}
+	}
+
+	if (device_mask >= (1UL << 32UL))
+		return 0;
+
+	return (device_mask & dma_addr_mask) = dma_addr_mask;
+}
+
 #endif /* !(CONFIG_PCI) */
diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index 7f5d473..14d67fe 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -39,12 +39,12 @@ static void pci_fire_scan_bus(struct pci_pbm_info *pbm)
 #define FIRE_IOMMU_FLUSH	0x40100UL
 #define FIRE_IOMMU_FLUSHINV	0x40108UL
 
-static void pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
+static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 {
 	struct iommu *iommu = pbm->iommu;
 	u32 vdma[2], dma_mask;
 	u64 control;
-	int tsbsize;
+	int tsbsize, err;
 
 	/* No virtual-dma property on these guys, use largest size.  */
 	vdma[0] = 0xc0000000; /* base */
@@ -68,7 +68,9 @@ static void pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 	 */
 	fire_write(iommu->iommu_flushinv, ~(u64)0);
 
-	pci_iommu_table_init(iommu, tsbsize * 8 * 1024, vdma[0], dma_mask);
+	err = iommu_table_init(iommu, tsbsize * 8 * 1024, vdma[0], dma_mask);
+	if (err)
+		return err;
 
 	fire_write(iommu->iommu_tsbbase, __pa(iommu->page_table) | 0x7UL);
 
@@ -78,6 +80,8 @@ static void pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 		    0x00000002 /* Bypass enable */		|
 		    0x00000001 /* Translation enable */);
 	fire_write(iommu->iommu_control, control);
+
+	return 0;
 }
 
 /* Based at pbm->controller_regs */
@@ -167,8 +171,8 @@ static void pci_fire_hw_init(struct pci_pbm_info *pbm)
 	fire_write(pbm->pbm_regs + FIRE_PEC_IENAB, ~(u64)0);
 }
 
-static void pci_fire_pbm_init(struct pci_controller_info *p,
-			      struct device_node *dp, u32 portid)
+static int pci_fire_pbm_init(struct pci_controller_info *p,
+			     struct device_node *dp, u32 portid)
 {
 	const struct linux_prom64_registers *regs;
 	struct pci_pbm_info *pbm;
@@ -203,7 +207,8 @@ static void pci_fire_pbm_init(struct pci_controller_info *p,
 	pci_get_pbm_props(pbm);
 
 	pci_fire_hw_init(pbm);
-	pci_fire_pbm_iommu_init(pbm);
+
+	return pci_fire_pbm_iommu_init(pbm);
 }
 
 static inline int portid_compare(u32 x, u32 y)
@@ -222,7 +227,8 @@ void fire_pci_init(struct device_node *dp, const char *model_name)
 
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (portid_compare(pbm->portid, portid)) {
-			pci_fire_pbm_init(pbm->parent, dp, portid);
+			if (pci_fire_pbm_init(pbm->parent, dp, portid))
+				goto fatal_memory_error;
 			return;
 		}
 	}
@@ -250,7 +256,9 @@ void fire_pci_init(struct device_node *dp, const char *model_name)
 	 */
 	pci_memspace_mask = 0x7fffffffUL;
 
-	pci_fire_pbm_init(p, dp, portid);
+	if (pci_fire_pbm_init(p, dp, portid))
+		goto fatal_memory_error;
+
 	return;
 
 fatal_memory_error:
diff --git a/arch/sparc64/kernel/pci_iommu.c b/arch/sparc64/kernel/pci_iommu.c
deleted file mode 100644
index 70d2364..0000000
--- a/arch/sparc64/kernel/pci_iommu.c
+++ /dev/null
@@ -1,823 +0,0 @@
-/* pci_iommu.c: UltraSparc PCI controller IOM/STC support.
- *
- * Copyright (C) 1999, 2007 David S. Miller (davem@davemloft.net)
- * Copyright (C) 1999, 2000 Jakub Jelinek (jakub@redhat.com)
- */
-
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/pci.h>
-
-#include <asm/oplib.h>
-
-#include "iommu_common.h"
-#include "pci_impl.h"
-
-#define PCI_STC_CTXMATCH_ADDR(STC, CTX)	\
-	((STC)->strbuf_ctxmatch_base + ((CTX) << 3))
-
-/* Accessing IOMMU and Streaming Buffer registers.
- * REG parameter is a physical address.  All registers
- * are 64-bits in size.
- */
-#define pci_iommu_read(__reg) \
-({	u64 __ret; \
-	__asm__ __volatile__("ldxa [%1] %2, %0" \
-			     : "=r" (__ret) \
-			     : "r" (__reg), "i" (ASI_PHYS_BYPASS_EC_E) \
-			     : "memory"); \
-	__ret; \
-})
-#define pci_iommu_write(__reg, __val) \
-	__asm__ __volatile__("stxa %0, [%1] %2" \
-			     : /* no outputs */ \
-			     : "r" (__val), "r" (__reg), \
-			       "i" (ASI_PHYS_BYPASS_EC_E))
-
-/* Must be invoked under the IOMMU lock. */
-static void __iommu_flushall(struct iommu *iommu)
-{
-	if (iommu->iommu_flushinv) {
-		pci_iommu_write(iommu->iommu_flushinv, ~(u64)0);
-	} else {
-		unsigned long tag;
-		int entry;
-
-		tag = iommu->iommu_flush + (0xa580UL - 0x0210UL);
-		for (entry = 0; entry < 16; entry++) {
-			pci_iommu_write(tag, 0);
-			tag += 8;
-		}
-
-		/* Ensure completion of previous PIO writes. */
-		(void) pci_iommu_read(iommu->write_complete_reg);
-	}
-}
-
-#define IOPTE_CONSISTENT(CTX) \
-	(IOPTE_VALID | IOPTE_CACHE | \
-	 (((CTX) << 47) & IOPTE_CONTEXT))
-
-#define IOPTE_STREAMING(CTX) \
-	(IOPTE_CONSISTENT(CTX) | IOPTE_STBUF)
-
-/* Existing mappings are never marked invalid, instead they
- * are pointed to a dummy page.
- */
-#define IOPTE_IS_DUMMY(iommu, iopte)	\
-	((iopte_val(*iopte) & IOPTE_PAGE) = (iommu)->dummy_page_pa)
-
-static inline void iopte_make_dummy(struct iommu *iommu, iopte_t *iopte)
-{
-	unsigned long val = iopte_val(*iopte);
-
-	val &= ~IOPTE_PAGE;
-	val |= iommu->dummy_page_pa;
-
-	iopte_val(*iopte) = val;
-}
-
-/* Based largely upon the ppc64 iommu allocator.  */
-static long pci_arena_alloc(struct iommu *iommu, unsigned long npages)
-{
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long n, i, start, end, limit;
-	int pass;
-
-	limit = arena->limit;
-	start = arena->hint;
-	pass = 0;
-
-again:
-	n = find_next_zero_bit(arena->map, limit, start);
-	end = n + npages;
-	if (unlikely(end >= limit)) {
-		if (likely(pass < 1)) {
-			limit = start;
-			start = 0;
-			__iommu_flushall(iommu);
-			pass++;
-			goto again;
-		} else {
-			/* Scanned the whole thing, give up. */
-			return -1;
-		}
-	}
-
-	for (i = n; i < end; i++) {
-		if (test_bit(i, arena->map)) {
-			start = i + 1;
-			goto again;
-		}
-	}
-
-	for (i = n; i < end; i++)
-		__set_bit(i, arena->map);
-
-	arena->hint = end;
-
-	return n;
-}
-
-static void pci_arena_free(struct iommu_arena *arena, unsigned long base, unsigned long npages)
-{
-	unsigned long i;
-
-	for (i = base; i < (base + npages); i++)
-		__clear_bit(i, arena->map);
-}
-
-void pci_iommu_table_init(struct iommu *iommu, int tsbsize, u32 dma_offset, u32 dma_addr_mask)
-{
-	unsigned long i, tsbbase, order, sz, num_tsb_entries;
-
-	num_tsb_entries = tsbsize / sizeof(iopte_t);
-
-	/* Setup initial software IOMMU state. */
-	spin_lock_init(&iommu->lock);
-	iommu->ctx_lowest_free = 1;
-	iommu->page_table_map_base = dma_offset;
-	iommu->dma_addr_mask = dma_addr_mask;
-
-	/* Allocate and initialize the free area map.  */
-	sz = num_tsb_entries / 8;
-	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
-	if (!iommu->arena.map) {
-		prom_printf("PCI_IOMMU: Error, kmalloc(arena.map) failed.\n");
-		prom_halt();
-	}
-	iommu->arena.limit = num_tsb_entries;
-
-	/* Allocate and initialize the dummy page which we
-	 * set inactive IO PTEs to point to.
-	 */
-	iommu->dummy_page = __get_free_pages(GFP_KERNEL, 0);
-	if (!iommu->dummy_page) {
-		prom_printf("PCI_IOMMU: Error, gfp(dummy_page) failed.\n");
-		prom_halt();
-	}
-	memset((void *)iommu->dummy_page, 0, PAGE_SIZE);
-	iommu->dummy_page_pa = (unsigned long) __pa(iommu->dummy_page);
-
-	/* Now allocate and setup the IOMMU page table itself.  */
-	order = get_order(tsbsize);
-	tsbbase = __get_free_pages(GFP_KERNEL, order);
-	if (!tsbbase) {
-		prom_printf("PCI_IOMMU: Error, gfp(tsb) failed.\n");
-		prom_halt();
-	}
-	iommu->page_table = (iopte_t *)tsbbase;
-
-	for (i = 0; i < num_tsb_entries; i++)
-		iopte_make_dummy(iommu, &iommu->page_table[i]);
-}
-
-static inline iopte_t *alloc_npages(struct iommu *iommu, unsigned long npages)
-{
-	long entry;
-
-	entry = pci_arena_alloc(iommu, npages);
-	if (unlikely(entry < 0))
-		return NULL;
-
-	return iommu->page_table + entry;
-}
-
-static inline void free_npages(struct iommu *iommu, dma_addr_t base, unsigned long npages)
-{
-	pci_arena_free(&iommu->arena, base >> IO_PAGE_SHIFT, npages);
-}
-
-static int iommu_alloc_ctx(struct iommu *iommu)
-{
-	int lowest = iommu->ctx_lowest_free;
-	int sz = IOMMU_NUM_CTXS - lowest;
-	int n = find_next_zero_bit(iommu->ctx_bitmap, sz, lowest);
-
-	if (unlikely(n = sz)) {
-		n = find_next_zero_bit(iommu->ctx_bitmap, lowest, 1);
-		if (unlikely(n = lowest)) {
-			printk(KERN_WARNING "IOMMU: Ran out of contexts.\n");
-			n = 0;
-		}
-	}
-	if (n)
-		__set_bit(n, iommu->ctx_bitmap);
-
-	return n;
-}
-
-static inline void iommu_free_ctx(struct iommu *iommu, int ctx)
-{
-	if (likely(ctx)) {
-		__clear_bit(ctx, iommu->ctx_bitmap);
-		if (ctx < iommu->ctx_lowest_free)
-			iommu->ctx_lowest_free = ctx;
-	}
-}
-
-/* Allocate and map kernel buffer of size SIZE using consistent mode
- * DMA for PCI device PDEV.  Return non-NULL cpu-side address if
- * successful and set *DMA_ADDRP to the PCI side dma address.
- */
-static void *pci_4u_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp, gfp_t gfp)
-{
-	struct iommu *iommu;
-	iopte_t *iopte;
-	unsigned long flags, order, first_page;
-	void *ret;
-	int npages;
-
-	size = IO_PAGE_ALIGN(size);
-	order = get_order(size);
-	if (order >= 10)
-		return NULL;
-
-	first_page = __get_free_pages(gfp, order);
-	if (first_page = 0UL)
-		return NULL;
-	memset((char *)first_page, 0, PAGE_SIZE << order);
-
-	iommu = pdev->dev.archdata.iommu;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	iopte = alloc_npages(iommu, size >> IO_PAGE_SHIFT);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	if (unlikely(iopte = NULL)) {
-		free_pages(first_page, order);
-		return NULL;
-	}
-
-	*dma_addrp = (iommu->page_table_map_base +
-		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
-	ret = (void *) first_page;
-	npages = size >> IO_PAGE_SHIFT;
-	first_page = __pa(first_page);
-	while (npages--) {
-		iopte_val(*iopte) = (IOPTE_CONSISTENT(0UL) |
-				     IOPTE_WRITE |
-				     (first_page & IOPTE_PAGE));
-		iopte++;
-		first_page += IO_PAGE_SIZE;
-	}
-
-	return ret;
-}
-
-/* Free and unmap a consistent DMA translation. */
-static void pci_4u_free_consistent(struct pci_dev *pdev, size_t size, void *cpu, dma_addr_t dvma)
-{
-	struct iommu *iommu;
-	iopte_t *iopte;
-	unsigned long flags, order, npages;
-
-	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
-	iommu = pdev->dev.archdata.iommu;
-	iopte = iommu->page_table +
-		((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	free_npages(iommu, dvma - iommu->page_table_map_base, npages);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	order = get_order(size);
-	if (order < 10)
-		free_pages((unsigned long)cpu, order);
-}
-
-/* Map a single buffer at PTR of SZ bytes for PCI DMA
- * in streaming mode.
- */
-static dma_addr_t pci_4u_map_single(struct pci_dev *pdev, void *ptr, size_t sz, int direction)
-{
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	iopte_t *base;
-	unsigned long flags, npages, oaddr;
-	unsigned long i, base_paddr, ctx;
-	u32 bus_addr, ret;
-	unsigned long iopte_protection;
-
-	iommu = pdev->dev.archdata.iommu;
-	strbuf = pdev->dev.archdata.stc;
-
-	if (unlikely(direction = PCI_DMA_NONE))
-		goto bad_no_ctx;
-
-	oaddr = (unsigned long)ptr;
-	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
-	npages >>= IO_PAGE_SHIFT;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	base = alloc_npages(iommu, npages);
-	ctx = 0;
-	if (iommu->iommu_ctxflush)
-		ctx = iommu_alloc_ctx(iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	if (unlikely(!base))
-		goto bad;
-
-	bus_addr = (iommu->page_table_map_base +
-		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
-	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
-	base_paddr = __pa(oaddr & IO_PAGE_MASK);
-	if (strbuf->strbuf_enabled)
-		iopte_protection = IOPTE_STREAMING(ctx);
-	else
-		iopte_protection = IOPTE_CONSISTENT(ctx);
-	if (direction != PCI_DMA_TODEVICE)
-		iopte_protection |= IOPTE_WRITE;
-
-	for (i = 0; i < npages; i++, base++, base_paddr += IO_PAGE_SIZE)
-		iopte_val(*base) = iopte_protection | base_paddr;
-
-	return ret;
-
-bad:
-	iommu_free_ctx(iommu, ctx);
-bad_no_ctx:
-	if (printk_ratelimit())
-		WARN_ON(1);
-	return PCI_DMA_ERROR_CODE;
-}
-
-static void pci_strbuf_flush(struct strbuf *strbuf, struct iommu *iommu, u32 vaddr, unsigned long ctx, unsigned long npages, int direction)
-{
-	int limit;
-
-	if (strbuf->strbuf_ctxflush &&
-	    iommu->iommu_ctxflush) {
-		unsigned long matchreg, flushreg;
-		u64 val;
-
-		flushreg = strbuf->strbuf_ctxflush;
-		matchreg = PCI_STC_CTXMATCH_ADDR(strbuf, ctx);
-
-		pci_iommu_write(flushreg, ctx);
-		val = pci_iommu_read(matchreg);
-		val &= 0xffff;
-		if (!val)
-			goto do_flush_sync;
-
-		while (val) {
-			if (val & 0x1)
-				pci_iommu_write(flushreg, ctx);
-			val >>= 1;
-		}
-		val = pci_iommu_read(matchreg);
-		if (unlikely(val)) {
-			printk(KERN_WARNING "pci_strbuf_flush: ctx flush "
-			       "timeout matchreg[%lx] ctx[%lx]\n",
-			       val, ctx);
-			goto do_page_flush;
-		}
-	} else {
-		unsigned long i;
-
-	do_page_flush:
-		for (i = 0; i < npages; i++, vaddr += IO_PAGE_SIZE)
-			pci_iommu_write(strbuf->strbuf_pflush, vaddr);
-	}
-
-do_flush_sync:
-	/* If the device could not have possibly put dirty data into
-	 * the streaming cache, no flush-flag synchronization needs
-	 * to be performed.
-	 */
-	if (direction = PCI_DMA_TODEVICE)
-		return;
-
-	PCI_STC_FLUSHFLAG_INIT(strbuf);
-	pci_iommu_write(strbuf->strbuf_fsync, strbuf->strbuf_flushflag_pa);
-	(void) pci_iommu_read(iommu->write_complete_reg);
-
-	limit = 100000;
-	while (!PCI_STC_FLUSHFLAG_SET(strbuf)) {
-		limit--;
-		if (!limit)
-			break;
-		udelay(1);
-		rmb();
-	}
-	if (!limit)
-		printk(KERN_WARNING "pci_strbuf_flush: flushflag timeout "
-		       "vaddr[%08x] ctx[%lx] npages[%ld]\n",
-		       vaddr, ctx, npages);
-}
-
-/* Unmap a single streaming mode DMA translation. */
-static void pci_4u_unmap_single(struct pci_dev *pdev, dma_addr_t bus_addr, size_t sz, int direction)
-{
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	iopte_t *base;
-	unsigned long flags, npages, ctx, i;
-
-	if (unlikely(direction = PCI_DMA_NONE)) {
-		if (printk_ratelimit())
-			WARN_ON(1);
-		return;
-	}
-
-	iommu = pdev->dev.archdata.iommu;
-	strbuf = pdev->dev.archdata.stc;
-
-	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
-	npages >>= IO_PAGE_SHIFT;
-	base = iommu->page_table +
-		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-#ifdef DEBUG_PCI_IOMMU
-	if (IOPTE_IS_DUMMY(iommu, base))
-		printk("pci_unmap_single called on non-mapped region %08x,%08x from %016lx\n",
-		       bus_addr, sz, __builtin_return_address(0));
-#endif
-	bus_addr &= IO_PAGE_MASK;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	/* Record the context, if any. */
-	ctx = 0;
-	if (iommu->iommu_ctxflush)
-		ctx = (iopte_val(*base) & IOPTE_CONTEXT) >> 47UL;
-
-	/* Step 1: Kick data out of streaming buffers if necessary. */
-	if (strbuf->strbuf_enabled)
-		pci_strbuf_flush(strbuf, iommu, bus_addr, ctx,
-				 npages, direction);
-
-	/* Step 2: Clear out TSB entries. */
-	for (i = 0; i < npages; i++)
-		iopte_make_dummy(iommu, base + i);
-
-	free_npages(iommu, bus_addr - iommu->page_table_map_base, npages);
-
-	iommu_free_ctx(iommu, ctx);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-#define SG_ENT_PHYS_ADDRESS(SG)	\
-	(__pa(page_address((SG)->page)) + (SG)->offset)
-
-static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg,
-			   int nused, int nelems, unsigned long iopte_protection)
-{
-	struct scatterlist *dma_sg = sg;
-	struct scatterlist *sg_end = sg + nelems;
-	int i;
-
-	for (i = 0; i < nused; i++) {
-		unsigned long pteval = ~0UL;
-		u32 dma_npages;
-
-		dma_npages = ((dma_sg->dma_address & (IO_PAGE_SIZE - 1UL)) +
-			      dma_sg->dma_length +
-			      ((IO_PAGE_SIZE - 1UL))) >> IO_PAGE_SHIFT;
-		do {
-			unsigned long offset;
-			signed int len;
-
-			/* If we are here, we know we have at least one
-			 * more page to map.  So walk forward until we
-			 * hit a page crossing, and begin creating new
-			 * mappings from that spot.
-			 */
-			for (;;) {
-				unsigned long tmp;
-
-				tmp = SG_ENT_PHYS_ADDRESS(sg);
-				len = sg->length;
-				if (((tmp ^ pteval) >> IO_PAGE_SHIFT) != 0UL) {
-					pteval = tmp & IO_PAGE_MASK;
-					offset = tmp & (IO_PAGE_SIZE - 1UL);
-					break;
-				}
-				if (((tmp ^ (tmp + len - 1UL)) >> IO_PAGE_SHIFT) != 0UL) {
-					pteval = (tmp + IO_PAGE_SIZE) & IO_PAGE_MASK;
-					offset = 0UL;
-					len -= (IO_PAGE_SIZE - (tmp & (IO_PAGE_SIZE - 1UL)));
-					break;
-				}
-				sg++;
-			}
-
-			pteval = iopte_protection | (pteval & IOPTE_PAGE);
-			while (len > 0) {
-				*iopte++ = __iopte(pteval);
-				pteval += IO_PAGE_SIZE;
-				len -= (IO_PAGE_SIZE - offset);
-				offset = 0;
-				dma_npages--;
-			}
-
-			pteval = (pteval & IOPTE_PAGE) + len;
-			sg++;
-
-			/* Skip over any tail mappings we've fully mapped,
-			 * adjusting pteval along the way.  Stop when we
-			 * detect a page crossing event.
-			 */
-			while (sg < sg_end &&
-			       (pteval << (64 - IO_PAGE_SHIFT)) != 0UL &&
-			       (pteval = SG_ENT_PHYS_ADDRESS(sg)) &&
-			       ((pteval ^
-				 (SG_ENT_PHYS_ADDRESS(sg) + sg->length - 1UL)) >> IO_PAGE_SHIFT) = 0UL) {
-				pteval += sg->length;
-				sg++;
-			}
-			if ((pteval << (64 - IO_PAGE_SHIFT)) = 0UL)
-				pteval = ~0UL;
-		} while (dma_npages != 0);
-		dma_sg++;
-	}
-}
-
-/* Map a set of buffers described by SGLIST with NELEMS array
- * elements in streaming mode for PCI DMA.
- * When making changes here, inspect the assembly output. I was having
- * hard time to keep this routine out of using stack slots for holding variables.
- */
-static int pci_4u_map_sg(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
-{
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	unsigned long flags, ctx, npages, iopte_protection;
-	iopte_t *base;
-	u32 dma_base;
-	struct scatterlist *sgtmp;
-	int used;
-
-	/* Fast path single entry scatterlists. */
-	if (nelems = 1) {
-		sglist->dma_address -			pci_4u_map_single(pdev,
-					  (page_address(sglist->page) + sglist->offset),
-					  sglist->length, direction);
-		if (unlikely(sglist->dma_address = PCI_DMA_ERROR_CODE))
-			return 0;
-		sglist->dma_length = sglist->length;
-		return 1;
-	}
-
-	iommu = pdev->dev.archdata.iommu;
-	strbuf = pdev->dev.archdata.stc;
-	
-	if (unlikely(direction = PCI_DMA_NONE))
-		goto bad_no_ctx;
-
-	/* Step 1: Prepare scatter list. */
-
-	npages = prepare_sg(sglist, nelems);
-
-	/* Step 2: Allocate a cluster and context, if necessary. */
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	base = alloc_npages(iommu, npages);
-	ctx = 0;
-	if (iommu->iommu_ctxflush)
-		ctx = iommu_alloc_ctx(iommu);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	if (base = NULL)
-		goto bad;
-
-	dma_base = iommu->page_table_map_base +
-		((base - iommu->page_table) << IO_PAGE_SHIFT);
-
-	/* Step 3: Normalize DMA addresses. */
-	used = nelems;
-
-	sgtmp = sglist;
-	while (used && sgtmp->dma_length) {
-		sgtmp->dma_address += dma_base;
-		sgtmp++;
-		used--;
-	}
-	used = nelems - used;
-
-	/* Step 4: Create the mappings. */
-	if (strbuf->strbuf_enabled)
-		iopte_protection = IOPTE_STREAMING(ctx);
-	else
-		iopte_protection = IOPTE_CONSISTENT(ctx);
-	if (direction != PCI_DMA_TODEVICE)
-		iopte_protection |= IOPTE_WRITE;
-
-	fill_sg(base, sglist, used, nelems, iopte_protection);
-
-#ifdef VERIFY_SG
-	verify_sglist(sglist, nelems, base, npages);
-#endif
-
-	return used;
-
-bad:
-	iommu_free_ctx(iommu, ctx);
-bad_no_ctx:
-	if (printk_ratelimit())
-		WARN_ON(1);
-	return 0;
-}
-
-/* Unmap a set of streaming mode DMA translations. */
-static void pci_4u_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
-{
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	iopte_t *base;
-	unsigned long flags, ctx, i, npages;
-	u32 bus_addr;
-
-	if (unlikely(direction = PCI_DMA_NONE)) {
-		if (printk_ratelimit())
-			WARN_ON(1);
-	}
-
-	iommu = pdev->dev.archdata.iommu;
-	strbuf = pdev->dev.archdata.stc;
-	
-	bus_addr = sglist->dma_address & IO_PAGE_MASK;
-
-	for (i = 1; i < nelems; i++)
-		if (sglist[i].dma_length = 0)
-			break;
-	i--;
-	npages = (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length) -
-		  bus_addr) >> IO_PAGE_SHIFT;
-
-	base = iommu->page_table +
-		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-
-#ifdef DEBUG_PCI_IOMMU
-	if (IOPTE_IS_DUMMY(iommu, base))
-		printk("pci_unmap_sg called on non-mapped region %016lx,%d from %016lx\n", sglist->dma_address, nelems, __builtin_return_address(0));
-#endif
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	/* Record the context, if any. */
-	ctx = 0;
-	if (iommu->iommu_ctxflush)
-		ctx = (iopte_val(*base) & IOPTE_CONTEXT) >> 47UL;
-
-	/* Step 1: Kick data out of streaming buffers if necessary. */
-	if (strbuf->strbuf_enabled)
-		pci_strbuf_flush(strbuf, iommu, bus_addr, ctx, npages, direction);
-
-	/* Step 2: Clear out the TSB entries. */
-	for (i = 0; i < npages; i++)
-		iopte_make_dummy(iommu, base + i);
-
-	free_npages(iommu, bus_addr - iommu->page_table_map_base, npages);
-
-	iommu_free_ctx(iommu, ctx);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-/* Make physical memory consistent for a single
- * streaming mode DMA translation after a transfer.
- */
-static void pci_4u_dma_sync_single_for_cpu(struct pci_dev *pdev, dma_addr_t bus_addr, size_t sz, int direction)
-{
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	unsigned long flags, ctx, npages;
-
-	iommu = pdev->dev.archdata.iommu;
-	strbuf = pdev->dev.archdata.stc;
-
-	if (!strbuf->strbuf_enabled)
-		return;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
-	npages >>= IO_PAGE_SHIFT;
-	bus_addr &= IO_PAGE_MASK;
-
-	/* Step 1: Record the context, if any. */
-	ctx = 0;
-	if (iommu->iommu_ctxflush &&
-	    strbuf->strbuf_ctxflush) {
-		iopte_t *iopte;
-
-		iopte = iommu->page_table +
-			((bus_addr - iommu->page_table_map_base)>>IO_PAGE_SHIFT);
-		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
-	}
-
-	/* Step 2: Kick data out of streaming buffers. */
-	pci_strbuf_flush(strbuf, iommu, bus_addr, ctx, npages, direction);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-/* Make physical memory consistent for a set of streaming
- * mode DMA translations after a transfer.
- */
-static void pci_4u_dma_sync_sg_for_cpu(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
-{
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	unsigned long flags, ctx, npages, i;
-	u32 bus_addr;
-
-	iommu = pdev->dev.archdata.iommu;
-	strbuf = pdev->dev.archdata.stc;
-
-	if (!strbuf->strbuf_enabled)
-		return;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	/* Step 1: Record the context, if any. */
-	ctx = 0;
-	if (iommu->iommu_ctxflush &&
-	    strbuf->strbuf_ctxflush) {
-		iopte_t *iopte;
-
-		iopte = iommu->page_table +
-			((sglist[0].dma_address - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
-	}
-
-	/* Step 2: Kick data out of streaming buffers. */
-	bus_addr = sglist[0].dma_address & IO_PAGE_MASK;
-	for(i = 1; i < nelems; i++)
-		if (!sglist[i].dma_length)
-			break;
-	i--;
-	npages = (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length)
-		  - bus_addr) >> IO_PAGE_SHIFT;
-	pci_strbuf_flush(strbuf, iommu, bus_addr, ctx, npages, direction);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-const struct pci_iommu_ops pci_sun4u_iommu_ops = {
-	.alloc_consistent		= pci_4u_alloc_consistent,
-	.free_consistent		= pci_4u_free_consistent,
-	.map_single			= pci_4u_map_single,
-	.unmap_single			= pci_4u_unmap_single,
-	.map_sg				= pci_4u_map_sg,
-	.unmap_sg			= pci_4u_unmap_sg,
-	.dma_sync_single_for_cpu	= pci_4u_dma_sync_single_for_cpu,
-	.dma_sync_sg_for_cpu		= pci_4u_dma_sync_sg_for_cpu,
-};
-
-static void ali_sound_dma_hack(struct pci_dev *pdev, int set_bit)
-{
-	struct pci_dev *ali_isa_bridge;
-	u8 val;
-
-	/* ALI sound chips generate 31-bits of DMA, a special register
-	 * determines what bit 31 is emitted as.
-	 */
-	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL,
-					 PCI_DEVICE_ID_AL_M1533,
-					 NULL);
-
-	pci_read_config_byte(ali_isa_bridge, 0x7e, &val);
-	if (set_bit)
-		val |= 0x01;
-	else
-		val &= ~0x01;
-	pci_write_config_byte(ali_isa_bridge, 0x7e, val);
-	pci_dev_put(ali_isa_bridge);
-}
-
-int pci_dma_supported(struct pci_dev *pdev, u64 device_mask)
-{
-	u64 dma_addr_mask;
-
-	if (pdev = NULL) {
-		dma_addr_mask = 0xffffffff;
-	} else {
-		struct iommu *iommu = pdev->dev.archdata.iommu;
-
-		dma_addr_mask = iommu->dma_addr_mask;
-
-		if (pdev->vendor = PCI_VENDOR_ID_AL &&
-		    pdev->device = PCI_DEVICE_ID_AL_M5451 &&
-		    device_mask = 0x7fffffff) {
-			ali_sound_dma_hack(pdev,
-					   (dma_addr_mask & 0x80000000) != 0);
-			return 1;
-		}
-	}
-
-	if (device_mask >= (1UL << 32UL))
-		return 0;
-
-	return (device_mask & dma_addr_mask) = dma_addr_mask;
-}
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 598393a..b6b4cfe 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -813,16 +813,19 @@ static void psycho_scan_bus(struct pci_pbm_info *pbm)
 	psycho_register_error_handlers(pbm);
 }
 
-static void psycho_iommu_init(struct pci_pbm_info *pbm)
+static int psycho_iommu_init(struct pci_pbm_info *pbm)
 {
 	struct iommu *iommu = pbm->iommu;
 	unsigned long i;
 	u64 control;
+	int err;
 
 	/* Register addresses. */
 	iommu->iommu_control  = pbm->controller_regs + PSYCHO_IOMMU_CONTROL;
 	iommu->iommu_tsbbase  = pbm->controller_regs + PSYCHO_IOMMU_TSBBASE;
 	iommu->iommu_flush    = pbm->controller_regs + PSYCHO_IOMMU_FLUSH;
+	iommu->iommu_tags     = iommu->iommu_flush + (0xa580UL - 0x0210UL);
+
 	/* PSYCHO's IOMMU lacks ctx flushing. */
 	iommu->iommu_ctxflush = 0;
 
@@ -845,7 +848,9 @@ static void psycho_iommu_init(struct pci_pbm_info *pbm)
 	/* Leave diag mode enabled for full-flushing done
 	 * in pci_iommu.c
 	 */
-	pci_iommu_table_init(iommu, IO_TSB_SIZE, 0xc0000000, 0xffffffff);
+	err = iommu_table_init(iommu, IO_TSB_SIZE, 0xc0000000, 0xffffffff);
+	if (err)
+		return err;
 
 	psycho_write(pbm->controller_regs + PSYCHO_IOMMU_TSBBASE,
 		     __pa(iommu->page_table));
@@ -858,6 +863,8 @@ static void psycho_iommu_init(struct pci_pbm_info *pbm)
 	/* If necessary, hook us up for starfire IRQ translations. */
 	if (this_is_starfire)
 		starfire_hookup(pbm->portid);
+
+	return 0;
 }
 
 #define PSYCHO_IRQ_RETRY	0x1a00UL
@@ -1031,15 +1038,12 @@ void psycho_init(struct device_node *dp, char *model_name)
 	}
 
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
-	if (!p) {
-		prom_printf("PSYCHO: Fatal memory allocation error.\n");
-		prom_halt();
-	}
+	if (!p)
+		goto fatal_memory_error;
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
-	if (!iommu) {
-		prom_printf("PSYCHO: Fatal memory allocation error.\n");
-		prom_halt();
-	}
+	if (!iommu)
+		goto fatal_memory_error;
+
 	p->pbm_A.iommu = p->pbm_B.iommu = iommu;
 
 	p->pbm_A.portid = upa_portid;
@@ -1062,8 +1066,14 @@ void psycho_init(struct device_node *dp, char *model_name)
 
 	psycho_controller_hwinit(&p->pbm_A);
 
-	psycho_iommu_init(&p->pbm_A);
+	if (psycho_iommu_init(&p->pbm_A))
+		goto fatal_memory_error;
 
 	is_pbm_a = ((pr_regs[0].phys_addr & 0x6000) = 0x2000);
 	psycho_pbm_init(p, dp, is_pbm_a);
+	return;
+
+fatal_memory_error:
+	prom_printf("PSYCHO: Fatal memory allocation error.\n");
+	prom_halt();
 }
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index 22e1be5..fba67c3 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -672,18 +672,20 @@ static void sabre_scan_bus(struct pci_pbm_info *pbm)
 	sabre_register_error_handlers(pbm);
 }
 
-static void sabre_iommu_init(struct pci_pbm_info *pbm,
-			     int tsbsize, unsigned long dvma_offset,
-			     u32 dma_mask)
+static int sabre_iommu_init(struct pci_pbm_info *pbm,
+			    int tsbsize, unsigned long dvma_offset,
+			    u32 dma_mask)
 {
 	struct iommu *iommu = pbm->iommu;
 	unsigned long i;
 	u64 control;
+	int err;
 
 	/* Register addresses. */
 	iommu->iommu_control  = pbm->controller_regs + SABRE_IOMMU_CONTROL;
 	iommu->iommu_tsbbase  = pbm->controller_regs + SABRE_IOMMU_TSBBASE;
 	iommu->iommu_flush    = pbm->controller_regs + SABRE_IOMMU_FLUSH;
+	iommu->iommu_tags     = iommu->iommu_flush + (0xa580UL - 0x0210UL);
 	iommu->write_complete_reg = pbm->controller_regs + SABRE_WRSYNC;
 	/* Sabre's IOMMU lacks ctx flushing. */
 	iommu->iommu_ctxflush = 0;
@@ -701,7 +703,10 @@ static void sabre_iommu_init(struct pci_pbm_info *pbm,
 	/* Leave diag mode enabled for full-flushing done
 	 * in pci_iommu.c
 	 */
-	pci_iommu_table_init(iommu, tsbsize * 1024 * 8, dvma_offset, dma_mask);
+	err = iommu_table_init(iommu, tsbsize * 1024 * 8,
+			       dvma_offset, dma_mask);
+	if (err)
+		return err;
 
 	sabre_write(pbm->controller_regs + SABRE_IOMMU_TSBBASE,
 		    __pa(iommu->page_table));
@@ -722,6 +727,8 @@ static void sabre_iommu_init(struct pci_pbm_info *pbm,
 		break;
 	}
 	sabre_write(pbm->controller_regs + SABRE_IOMMU_CONTROL, control);
+
+	return 0;
 }
 
 static void sabre_pbm_init(struct pci_controller_info *p, struct pci_pbm_info *pbm, struct device_node *dp)
@@ -775,16 +782,12 @@ void sabre_init(struct device_node *dp, char *model_name)
 	}
 
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
-	if (!p) {
-		prom_printf("SABRE: Error, kmalloc(pci_controller_info) failed.\n");
-		prom_halt();
-	}
+	if (!p)
+		goto fatal_memory_error;
 
 	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
-	if (!iommu) {
-		prom_printf("SABRE: Error, kmalloc(pci_iommu) failed.\n");
-		prom_halt();
-	}
+	if (!iommu)
+		goto fatal_memory_error;
 	pbm = &p->pbm_A;
 	pbm->iommu = iommu;
 
@@ -847,10 +850,16 @@ void sabre_init(struct device_node *dp, char *model_name)
 			prom_halt();
 	}
 
-	sabre_iommu_init(pbm, tsbsize, vdma[0], dma_mask);
+	if (sabre_iommu_init(pbm, tsbsize, vdma[0], dma_mask))
+		goto fatal_memory_error;
 
 	/*
 	 * Look for APB underneath.
 	 */
 	sabre_pbm_init(p, pbm, dp);
+	return;
+
+fatal_memory_error:
+	prom_printf("SABRE: Fatal memory allocation error.\n");
+	prom_halt();
 }
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index ae76898..3c30bfa 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1148,14 +1148,14 @@ static void schizo_pbm_strbuf_init(struct pci_pbm_info *pbm)
 #define SCHIZO_IOMMU_FLUSH		(0x00210UL)
 #define SCHIZO_IOMMU_CTXFLUSH		(0x00218UL)
 
-static void schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
+static int schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 {
 	struct iommu *iommu = pbm->iommu;
 	unsigned long i, tagbase, database;
 	struct property *prop;
 	u32 vdma[2], dma_mask;
+	int tsbsize, err;
 	u64 control;
-	int tsbsize;
 
 	prop = of_find_property(pbm->prom_node, "virtual-dma", NULL);
 	if (prop) {
@@ -1195,6 +1195,7 @@ static void schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	iommu->iommu_control  = pbm->pbm_regs + SCHIZO_IOMMU_CONTROL;
 	iommu->iommu_tsbbase  = pbm->pbm_regs + SCHIZO_IOMMU_TSBBASE;
 	iommu->iommu_flush    = pbm->pbm_regs + SCHIZO_IOMMU_FLUSH;
+	iommu->iommu_tags     = iommu->iommu_flush + (0xa580UL - 0x0210UL);
 	iommu->iommu_ctxflush = pbm->pbm_regs + SCHIZO_IOMMU_CTXFLUSH;
 
 	/* We use the main control/status register of SCHIZO as the write
@@ -1219,7 +1220,9 @@ static void schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 	/* Leave diag mode enabled for full-flushing done
 	 * in pci_iommu.c
 	 */
-	pci_iommu_table_init(iommu, tsbsize * 8 * 1024, vdma[0], dma_mask);
+	err = iommu_table_init(iommu, tsbsize * 8 * 1024, vdma[0], dma_mask);
+	if (err)
+		return err;
 
 	schizo_write(iommu->iommu_tsbbase, __pa(iommu->page_table));
 
@@ -1236,6 +1239,8 @@ static void schizo_pbm_iommu_init(struct pci_pbm_info *pbm)
 
 	control |= SCHIZO_IOMMU_CTRL_ENAB;
 	schizo_write(iommu->iommu_control, control);
+
+	return 0;
 }
 
 #define SCHIZO_PCI_IRQ_RETRY	(0x1a00UL)
@@ -1328,14 +1333,14 @@ static void schizo_pbm_hw_init(struct pci_pbm_info *pbm)
 	}
 }
 
-static void schizo_pbm_init(struct pci_controller_info *p,
-			    struct device_node *dp, u32 portid,
-			    int chip_type)
+static int schizo_pbm_init(struct pci_controller_info *p,
+			   struct device_node *dp, u32 portid,
+			   int chip_type)
 {
 	const struct linux_prom64_registers *regs;
 	struct pci_pbm_info *pbm;
 	const char *chipset_name;
-	int is_pbm_a;
+	int is_pbm_a, err;
 
 	switch (chip_type) {
 	case PBM_CHIP_TYPE_TOMATILLO:
@@ -1406,8 +1411,13 @@ static void schizo_pbm_init(struct pci_controller_info *p,
 
 	pci_get_pbm_props(pbm);
 
-	schizo_pbm_iommu_init(pbm);
+	err = schizo_pbm_iommu_init(pbm);
+	if (err)
+		return err;
+
 	schizo_pbm_strbuf_init(pbm);
+
+	return 0;
 }
 
 static inline int portid_compare(u32 x, u32 y, int chip_type)
@@ -1431,34 +1441,38 @@ static void __schizo_init(struct device_node *dp, char *model_name, int chip_typ
 
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (portid_compare(pbm->portid, portid, chip_type)) {
-			schizo_pbm_init(pbm->parent, dp, portid, chip_type);
+			if (schizo_pbm_init(pbm->parent, dp,
+					    portid, chip_type))
+				goto fatal_memory_error;
 			return;
 		}
 	}
 
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
 	if (!p)
-		goto memfail;
+		goto fatal_memory_error;
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu)
-		goto memfail;
+		goto fatal_memory_error;
 
 	p->pbm_A.iommu = iommu;
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu)
-		goto memfail;
+		goto fatal_memory_error;
 
 	p->pbm_B.iommu = iommu;
 
 	/* Like PSYCHO we have a 2GB aligned area for memory space. */
 	pci_memspace_mask = 0x7fffffffUL;
 
-	schizo_pbm_init(p, dp, portid, chip_type);
+	if (schizo_pbm_init(p, dp, portid, chip_type))
+		goto fatal_memory_error;
+
 	return;
 
-memfail:
+fatal_memory_error:
 	prom_printf("SCHIZO: Fatal memory allocation error.\n");
 	prom_halt();
 }
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 639cf06..466f4aa 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -33,30 +33,30 @@ static unsigned long vpci_minor = 1;
 #define PGLIST_NENTS	(PAGE_SIZE / sizeof(u64))
 
 struct iommu_batch {
-	struct pci_dev	*pdev;		/* Device mapping is for.	*/
+	struct device	*dev;		/* Device mapping is for.	*/
 	unsigned long	prot;		/* IOMMU page protections	*/
 	unsigned long	entry;		/* Index into IOTSB.		*/
 	u64		*pglist;	/* List of physical pages	*/
 	unsigned long	npages;		/* Number of pages in list.	*/
 };
 
-static DEFINE_PER_CPU(struct iommu_batch, pci_iommu_batch);
+static DEFINE_PER_CPU(struct iommu_batch, iommu_batch);
 
 /* Interrupts must be disabled.  */
-static inline void pci_iommu_batch_start(struct pci_dev *pdev, unsigned long prot, unsigned long entry)
+static inline void iommu_batch_start(struct device *dev, unsigned long prot, unsigned long entry)
 {
-	struct iommu_batch *p = &__get_cpu_var(pci_iommu_batch);
+	struct iommu_batch *p = &__get_cpu_var(iommu_batch);
 
-	p->pdev		= pdev;
+	p->dev		= dev;
 	p->prot		= prot;
 	p->entry	= entry;
 	p->npages	= 0;
 }
 
 /* Interrupts must be disabled.  */
-static long pci_iommu_batch_flush(struct iommu_batch *p)
+static long iommu_batch_flush(struct iommu_batch *p)
 {
-	struct pci_pbm_info *pbm = p->pdev->dev.archdata.host_controller;
+	struct pci_pbm_info *pbm = p->dev->archdata.host_controller;
 	unsigned long devhandle = pbm->devhandle;
 	unsigned long prot = p->prot;
 	unsigned long entry = p->entry;
@@ -70,7 +70,7 @@ static long pci_iommu_batch_flush(struct iommu_batch *p)
 					  npages, prot, __pa(pglist));
 		if (unlikely(num < 0)) {
 			if (printk_ratelimit())
-				printk("pci_iommu_batch_flush: IOMMU map of "
+				printk("iommu_batch_flush: IOMMU map of "
 				       "[%08lx:%08lx:%lx:%lx:%lx] failed with "
 				       "status %ld\n",
 				       devhandle, HV_PCI_TSBID(0, entry),
@@ -90,30 +90,30 @@ static long pci_iommu_batch_flush(struct iommu_batch *p)
 }
 
 /* Interrupts must be disabled.  */
-static inline long pci_iommu_batch_add(u64 phys_page)
+static inline long iommu_batch_add(u64 phys_page)
 {
-	struct iommu_batch *p = &__get_cpu_var(pci_iommu_batch);
+	struct iommu_batch *p = &__get_cpu_var(iommu_batch);
 
 	BUG_ON(p->npages >= PGLIST_NENTS);
 
 	p->pglist[p->npages++] = phys_page;
 	if (p->npages = PGLIST_NENTS)
-		return pci_iommu_batch_flush(p);
+		return iommu_batch_flush(p);
 
 	return 0;
 }
 
 /* Interrupts must be disabled.  */
-static inline long pci_iommu_batch_end(void)
+static inline long iommu_batch_end(void)
 {
-	struct iommu_batch *p = &__get_cpu_var(pci_iommu_batch);
+	struct iommu_batch *p = &__get_cpu_var(iommu_batch);
 
 	BUG_ON(p->npages >= PGLIST_NENTS);
 
-	return pci_iommu_batch_flush(p);
+	return iommu_batch_flush(p);
 }
 
-static long pci_arena_alloc(struct iommu_arena *arena, unsigned long npages)
+static long arena_alloc(struct iommu_arena *arena, unsigned long npages)
 {
 	unsigned long n, i, start, end, limit;
 	int pass;
@@ -152,7 +152,8 @@ again:
 	return n;
 }
 
-static void pci_arena_free(struct iommu_arena *arena, unsigned long base, unsigned long npages)
+static void arena_free(struct iommu_arena *arena, unsigned long base,
+		       unsigned long npages)
 {
 	unsigned long i;
 
@@ -160,7 +161,8 @@ static void pci_arena_free(struct iommu_arena *arena, unsigned long base, unsign
 		__clear_bit(i, arena->map);
 }
 
-static void *pci_4v_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp, gfp_t gfp)
+static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
+				   dma_addr_t *dma_addrp, gfp_t gfp)
 {
 	struct iommu *iommu;
 	unsigned long flags, order, first_page, npages, n;
@@ -180,10 +182,10 @@ static void *pci_4v_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr
 
 	memset((char *)first_page, 0, PAGE_SIZE << order);
 
-	iommu = pdev->dev.archdata.iommu;
+	iommu = dev->archdata.iommu;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	entry = pci_arena_alloc(&iommu->arena, npages);
+	entry = arena_alloc(&iommu->arena, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (unlikely(entry < 0L))
@@ -196,18 +198,18 @@ static void *pci_4v_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr
 
 	local_irq_save(flags);
 
-	pci_iommu_batch_start(pdev,
-			      (HV_PCI_MAP_ATTR_READ |
-			       HV_PCI_MAP_ATTR_WRITE),
-			      entry);
+	iommu_batch_start(dev,
+			  (HV_PCI_MAP_ATTR_READ |
+			   HV_PCI_MAP_ATTR_WRITE),
+			  entry);
 
 	for (n = 0; n < npages; n++) {
-		long err = pci_iommu_batch_add(first_page + (n * PAGE_SIZE));
+		long err = iommu_batch_add(first_page + (n * PAGE_SIZE));
 		if (unlikely(err < 0L))
 			goto iommu_map_fail;
 	}
 
-	if (unlikely(pci_iommu_batch_end() < 0L))
+	if (unlikely(iommu_batch_end() < 0L))
 		goto iommu_map_fail;
 
 	local_irq_restore(flags);
@@ -217,7 +219,7 @@ static void *pci_4v_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr
 iommu_map_fail:
 	/* Interrupts are disabled.  */
 	spin_lock(&iommu->lock);
-	pci_arena_free(&iommu->arena, entry, npages);
+	arena_free(&iommu->arena, entry, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
 arena_alloc_fail:
@@ -225,7 +227,8 @@ arena_alloc_fail:
 	return NULL;
 }
 
-static void pci_4v_free_consistent(struct pci_dev *pdev, size_t size, void *cpu, dma_addr_t dvma)
+static void dma_4v_free_coherent(struct device *dev, size_t size, void *cpu,
+				 dma_addr_t dvma)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -233,14 +236,14 @@ static void pci_4v_free_consistent(struct pci_dev *pdev, size_t size, void *cpu,
 	u32 devhandle;
 
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
-	iommu = pdev->dev.archdata.iommu;
-	pbm = pdev->dev.archdata.host_controller;
+	iommu = dev->archdata.iommu;
+	pbm = dev->archdata.host_controller;
 	devhandle = pbm->devhandle;
 	entry = ((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	pci_arena_free(&iommu->arena, entry, npages);
+	arena_free(&iommu->arena, entry, npages);
 
 	do {
 		unsigned long num;
@@ -258,7 +261,8 @@ static void pci_4v_free_consistent(struct pci_dev *pdev, size_t size, void *cpu,
 		free_pages((unsigned long)cpu, order);
 }
 
-static dma_addr_t pci_4v_map_single(struct pci_dev *pdev, void *ptr, size_t sz, int direction)
+static dma_addr_t dma_4v_map_single(struct device *dev, void *ptr, size_t sz,
+				    enum dma_data_direction direction)
 {
 	struct iommu *iommu;
 	unsigned long flags, npages, oaddr;
@@ -267,9 +271,9 @@ static dma_addr_t pci_4v_map_single(struct pci_dev *pdev, void *ptr, size_t sz,
 	unsigned long prot;
 	long entry;
 
-	iommu = pdev->dev.archdata.iommu;
+	iommu = dev->archdata.iommu;
 
-	if (unlikely(direction = PCI_DMA_NONE))
+	if (unlikely(direction = DMA_NONE))
 		goto bad;
 
 	oaddr = (unsigned long)ptr;
@@ -277,7 +281,7 @@ static dma_addr_t pci_4v_map_single(struct pci_dev *pdev, void *ptr, size_t sz,
 	npages >>= IO_PAGE_SHIFT;
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	entry = pci_arena_alloc(&iommu->arena, npages);
+	entry = arena_alloc(&iommu->arena, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (unlikely(entry < 0L))
@@ -288,19 +292,19 @@ static dma_addr_t pci_4v_map_single(struct pci_dev *pdev, void *ptr, size_t sz,
 	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
 	base_paddr = __pa(oaddr & IO_PAGE_MASK);
 	prot = HV_PCI_MAP_ATTR_READ;
-	if (direction != PCI_DMA_TODEVICE)
+	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
 
 	local_irq_save(flags);
 
-	pci_iommu_batch_start(pdev, prot, entry);
+	iommu_batch_start(dev, prot, entry);
 
 	for (i = 0; i < npages; i++, base_paddr += IO_PAGE_SIZE) {
-		long err = pci_iommu_batch_add(base_paddr);
+		long err = iommu_batch_add(base_paddr);
 		if (unlikely(err < 0L))
 			goto iommu_map_fail;
 	}
-	if (unlikely(pci_iommu_batch_end() < 0L))
+	if (unlikely(iommu_batch_end() < 0L))
 		goto iommu_map_fail;
 
 	local_irq_restore(flags);
@@ -310,18 +314,19 @@ static dma_addr_t pci_4v_map_single(struct pci_dev *pdev, void *ptr, size_t sz,
 bad:
 	if (printk_ratelimit())
 		WARN_ON(1);
-	return PCI_DMA_ERROR_CODE;
+	return DMA_ERROR_CODE;
 
 iommu_map_fail:
 	/* Interrupts are disabled.  */
 	spin_lock(&iommu->lock);
-	pci_arena_free(&iommu->arena, entry, npages);
+	arena_free(&iommu->arena, entry, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	return PCI_DMA_ERROR_CODE;
+	return DMA_ERROR_CODE;
 }
 
-static void pci_4v_unmap_single(struct pci_dev *pdev, dma_addr_t bus_addr, size_t sz, int direction)
+static void dma_4v_unmap_single(struct device *dev, dma_addr_t bus_addr,
+				size_t sz, enum dma_data_direction direction)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -329,14 +334,14 @@ static void pci_4v_unmap_single(struct pci_dev *pdev, dma_addr_t bus_addr, size_
 	long entry;
 	u32 devhandle;
 
-	if (unlikely(direction = PCI_DMA_NONE)) {
+	if (unlikely(direction = DMA_NONE)) {
 		if (printk_ratelimit())
 			WARN_ON(1);
 		return;
 	}
 
-	iommu = pdev->dev.archdata.iommu;
-	pbm = pdev->dev.archdata.host_controller;
+	iommu = dev->archdata.iommu;
+	pbm = dev->archdata.host_controller;
 	devhandle = pbm->devhandle;
 
 	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
@@ -346,7 +351,7 @@ static void pci_4v_unmap_single(struct pci_dev *pdev, dma_addr_t bus_addr, size_
 	spin_lock_irqsave(&iommu->lock, flags);
 
 	entry = (bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT;
-	pci_arena_free(&iommu->arena, entry, npages);
+	arena_free(&iommu->arena, entry, npages);
 
 	do {
 		unsigned long num;
@@ -363,7 +368,7 @@ static void pci_4v_unmap_single(struct pci_dev *pdev, dma_addr_t bus_addr, size_
 #define SG_ENT_PHYS_ADDRESS(SG)	\
 	(__pa(page_address((SG)->page)) + (SG)->offset)
 
-static inline long fill_sg(long entry, struct pci_dev *pdev,
+static inline long fill_sg(long entry, struct device *dev,
 			   struct scatterlist *sg,
 			   int nused, int nelems, unsigned long prot)
 {
@@ -374,7 +379,7 @@ static inline long fill_sg(long entry, struct pci_dev *pdev,
 
 	local_irq_save(flags);
 
-	pci_iommu_batch_start(pdev, prot, entry);
+	iommu_batch_start(dev, prot, entry);
 
 	for (i = 0; i < nused; i++) {
 		unsigned long pteval = ~0UL;
@@ -415,7 +420,7 @@ static inline long fill_sg(long entry, struct pci_dev *pdev,
 			while (len > 0) {
 				long err;
 
-				err = pci_iommu_batch_add(pteval);
+				err = iommu_batch_add(pteval);
 				if (unlikely(err < 0L))
 					goto iommu_map_failed;
 
@@ -446,7 +451,7 @@ static inline long fill_sg(long entry, struct pci_dev *pdev,
 		dma_sg++;
 	}
 
-	if (unlikely(pci_iommu_batch_end() < 0L))
+	if (unlikely(iommu_batch_end() < 0L))
 		goto iommu_map_failed;
 
 	local_irq_restore(flags);
@@ -457,7 +462,8 @@ iommu_map_failed:
 	return -1L;
 }
 
-static int pci_4v_map_sg(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
+static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
+			 int nelems, enum dma_data_direction direction)
 {
 	struct iommu *iommu;
 	unsigned long flags, npages, prot;
@@ -469,18 +475,19 @@ static int pci_4v_map_sg(struct pci_dev *pdev, struct scatterlist *sglist, int n
 	/* Fast path single entry scatterlists. */
 	if (nelems = 1) {
 		sglist->dma_address -			pci_4v_map_single(pdev,
-					  (page_address(sglist->page) + sglist->offset),
+			dma_4v_map_single(dev,
+					  (page_address(sglist->page) +
+					   sglist->offset),
 					  sglist->length, direction);
-		if (unlikely(sglist->dma_address = PCI_DMA_ERROR_CODE))
+		if (unlikely(sglist->dma_address = DMA_ERROR_CODE))
 			return 0;
 		sglist->dma_length = sglist->length;
 		return 1;
 	}
 
-	iommu = pdev->dev.archdata.iommu;
+	iommu = dev->archdata.iommu;
 	
-	if (unlikely(direction = PCI_DMA_NONE))
+	if (unlikely(direction = DMA_NONE))
 		goto bad;
 
 	/* Step 1: Prepare scatter list. */
@@ -488,7 +495,7 @@ static int pci_4v_map_sg(struct pci_dev *pdev, struct scatterlist *sglist, int n
 
 	/* Step 2: Allocate a cluster and context, if necessary. */
 	spin_lock_irqsave(&iommu->lock, flags);
-	entry = pci_arena_alloc(&iommu->arena, npages);
+	entry = arena_alloc(&iommu->arena, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	if (unlikely(entry < 0L))
@@ -510,10 +517,10 @@ static int pci_4v_map_sg(struct pci_dev *pdev, struct scatterlist *sglist, int n
 
 	/* Step 4: Create the mappings. */
 	prot = HV_PCI_MAP_ATTR_READ;
-	if (direction != PCI_DMA_TODEVICE)
+	if (direction != DMA_TO_DEVICE)
 		prot |= HV_PCI_MAP_ATTR_WRITE;
 
-	err = fill_sg(entry, pdev, sglist, used, nelems, prot);
+	err = fill_sg(entry, dev, sglist, used, nelems, prot);
 	if (unlikely(err < 0L))
 		goto iommu_map_failed;
 
@@ -526,13 +533,14 @@ bad:
 
 iommu_map_failed:
 	spin_lock_irqsave(&iommu->lock, flags);
-	pci_arena_free(&iommu->arena, entry, npages);
+	arena_free(&iommu->arena, entry, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return 0;
 }
 
-static void pci_4v_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
+static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
+			    int nelems, enum dma_data_direction direction)
 {
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
@@ -540,13 +548,13 @@ static void pci_4v_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist, in
 	long entry;
 	u32 devhandle, bus_addr;
 
-	if (unlikely(direction = PCI_DMA_NONE)) {
+	if (unlikely(direction = DMA_NONE)) {
 		if (printk_ratelimit())
 			WARN_ON(1);
 	}
 
-	iommu = pdev->dev.archdata.iommu;
-	pbm = pdev->dev.archdata.host_controller;
+	iommu = dev->archdata.iommu;
+	pbm = dev->archdata.host_controller;
 	devhandle = pbm->devhandle;
 	
 	bus_addr = sglist->dma_address & IO_PAGE_MASK;
@@ -562,7 +570,7 @@ static void pci_4v_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist, in
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	pci_arena_free(&iommu->arena, entry, npages);
+	arena_free(&iommu->arena, entry, npages);
 
 	do {
 		unsigned long num;
@@ -576,25 +584,29 @@ static void pci_4v_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist, in
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static void pci_4v_dma_sync_single_for_cpu(struct pci_dev *pdev, dma_addr_t bus_addr, size_t sz, int direction)
+static void dma_4v_sync_single_for_cpu(struct device *dev,
+				       dma_addr_t bus_addr, size_t sz,
+				       enum dma_data_direction direction)
 {
 	/* Nothing to do... */
 }
 
-static void pci_4v_dma_sync_sg_for_cpu(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
+static void dma_4v_sync_sg_for_cpu(struct device *dev,
+				   struct scatterlist *sglist, int nelems,
+				   enum dma_data_direction direction)
 {
 	/* Nothing to do... */
 }
 
-const struct pci_iommu_ops pci_sun4v_iommu_ops = {
-	.alloc_consistent		= pci_4v_alloc_consistent,
-	.free_consistent		= pci_4v_free_consistent,
-	.map_single			= pci_4v_map_single,
-	.unmap_single			= pci_4v_unmap_single,
-	.map_sg				= pci_4v_map_sg,
-	.unmap_sg			= pci_4v_unmap_sg,
-	.dma_sync_single_for_cpu	= pci_4v_dma_sync_single_for_cpu,
-	.dma_sync_sg_for_cpu		= pci_4v_dma_sync_sg_for_cpu,
+const struct dma_ops sun4v_dma_ops = {
+	.alloc_coherent			= dma_4v_alloc_coherent,
+	.free_coherent			= dma_4v_free_coherent,
+	.map_single			= dma_4v_map_single,
+	.unmap_single			= dma_4v_unmap_single,
+	.map_sg				= dma_4v_map_sg,
+	.unmap_sg			= dma_4v_unmap_sg,
+	.sync_single_for_cpu		= dma_4v_sync_single_for_cpu,
+	.sync_sg_for_cpu		= dma_4v_sync_sg_for_cpu,
 };
 
 static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm)
@@ -1186,6 +1198,8 @@ void __init sun4v_pci_init(struct device_node *dp, char *model_name)
 		}
 		printk("SUN4V_PCI: Registered hvapi major[%lu] minor[%lu]\n",
 		       vpci_major, vpci_minor);
+
+		dma_ops = &sun4v_dma_ops;
 	}
 
 	prop = of_find_property(dp, "reg", NULL);
@@ -1206,7 +1220,7 @@ void __init sun4v_pci_init(struct device_node *dp, char *model_name)
 		if (!page)
 			goto fatal_memory_error;
 
-		per_cpu(pci_iommu_batch, i).pglist = (u64 *) page;
+		per_cpu(iommu_batch, i).pglist = (u64 *) page;
 	}
 
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index a1fd9bc..d1fb13b 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -26,11 +26,6 @@
 
 #define MAP_BASE	((u32)0xc0000000)
 
-struct sbus_info {
-	struct iommu	iommu;
-	struct strbuf	strbuf;
-};
-
 /* Offsets from iommu_regs */
 #define SYSIO_IOMMUREG_BASE	0x2400UL
 #define IOMMU_CONTROL	(0x2400UL - 0x2400UL)	/* IOMMU control register */
@@ -44,19 +39,6 @@ struct sbus_info {
 
 #define IOMMU_DRAM_VALID	(1UL << 30UL)
 
-static void __iommu_flushall(struct iommu *iommu)
-{
-	unsigned long tag;
-	int entry;
-
-	tag = iommu->iommu_control + (IOMMU_TAGDIAG - IOMMU_CONTROL);
-	for (entry = 0; entry < 16; entry++) {
-		upa_writeq(0, tag);
-		tag += 8UL;
-	}
-	upa_readq(iommu->write_complete_reg);
-}
-
 /* Offsets from strbuf_regs */
 #define SYSIO_STRBUFREG_BASE	0x2800UL
 #define STRBUF_CONTROL	(0x2800UL - 0x2800UL)	/* Control */
@@ -69,511 +51,10 @@ static void __iommu_flushall(struct iommu *iommu)
 
 #define STRBUF_TAG_VALID	0x02UL
 
-static void sbus_strbuf_flush(struct iommu *iommu, struct strbuf *strbuf, u32 base, unsigned long npages, int direction)
-{
-	unsigned long n;
-	int limit;
-
-	n = npages;
-	while (n--)
-		upa_writeq(base + (n << IO_PAGE_SHIFT), strbuf->strbuf_pflush);
-
-	/* If the device could not have possibly put dirty data into
-	 * the streaming cache, no flush-flag synchronization needs
-	 * to be performed.
-	 */
-	if (direction = SBUS_DMA_TODEVICE)
-		return;
-
-	*(strbuf->strbuf_flushflag) = 0UL;
-
-	/* Whoopee cushion! */
-	upa_writeq(strbuf->strbuf_flushflag_pa, strbuf->strbuf_fsync);
-	upa_readq(iommu->write_complete_reg);
-
-	limit = 100000;
-	while (*(strbuf->strbuf_flushflag) = 0UL) {
-		limit--;
-		if (!limit)
-			break;
-		udelay(1);
-		rmb();
-	}
-	if (!limit)
-		printk(KERN_WARNING "sbus_strbuf_flush: flushflag timeout "
-		       "vaddr[%08x] npages[%ld]\n",
-		       base, npages);
-}
-
-/* Based largely upon the ppc64 iommu allocator.  */
-static long sbus_arena_alloc(struct iommu *iommu, unsigned long npages)
-{
-	struct iommu_arena *arena = &iommu->arena;
-	unsigned long n, i, start, end, limit;
-	int pass;
-
-	limit = arena->limit;
-	start = arena->hint;
-	pass = 0;
-
-again:
-	n = find_next_zero_bit(arena->map, limit, start);
-	end = n + npages;
-	if (unlikely(end >= limit)) {
-		if (likely(pass < 1)) {
-			limit = start;
-			start = 0;
-			__iommu_flushall(iommu);
-			pass++;
-			goto again;
-		} else {
-			/* Scanned the whole thing, give up. */
-			return -1;
-		}
-	}
-
-	for (i = n; i < end; i++) {
-		if (test_bit(i, arena->map)) {
-			start = i + 1;
-			goto again;
-		}
-	}
-
-	for (i = n; i < end; i++)
-		__set_bit(i, arena->map);
-
-	arena->hint = end;
-
-	return n;
-}
-
-static void sbus_arena_free(struct iommu_arena *arena, unsigned long base, unsigned long npages)
-{
-	unsigned long i;
-
-	for (i = base; i < (base + npages); i++)
-		__clear_bit(i, arena->map);
-}
-
-static void sbus_iommu_table_init(struct iommu *iommu, unsigned int tsbsize)
-{
-	unsigned long tsbbase, order, sz, num_tsb_entries;
-
-	num_tsb_entries = tsbsize / sizeof(iopte_t);
-
-	/* Setup initial software IOMMU state. */
-	spin_lock_init(&iommu->lock);
-	iommu->page_table_map_base = MAP_BASE;
-
-	/* Allocate and initialize the free area map.  */
-	sz = num_tsb_entries / 8;
-	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
-	if (!iommu->arena.map) {
-		prom_printf("SBUS_IOMMU: Error, kmalloc(arena.map) failed.\n");
-		prom_halt();
-	}
-	iommu->arena.limit = num_tsb_entries;
-
-	/* Now allocate and setup the IOMMU page table itself.  */
-	order = get_order(tsbsize);
-	tsbbase = __get_free_pages(GFP_KERNEL, order);
-	if (!tsbbase) {
-		prom_printf("IOMMU: Error, gfp(tsb) failed.\n");
-		prom_halt();
-	}
-	iommu->page_table = (iopte_t *)tsbbase;
-	memset(iommu->page_table, 0, tsbsize);
-}
-
-static inline iopte_t *alloc_npages(struct iommu *iommu, unsigned long npages)
-{
-	long entry;
-
-	entry = sbus_arena_alloc(iommu, npages);
-	if (unlikely(entry < 0))
-		return NULL;
-
-	return iommu->page_table + entry;
-}
-
-static inline void free_npages(struct iommu *iommu, dma_addr_t base, unsigned long npages)
-{
-	sbus_arena_free(&iommu->arena, base >> IO_PAGE_SHIFT, npages);
-}
-
-void *sbus_alloc_consistent(struct sbus_dev *sdev, size_t size, dma_addr_t *dvma_addr)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	iopte_t *iopte;
-	unsigned long flags, order, first_page;
-	void *ret;
-	int npages;
-
-	size = IO_PAGE_ALIGN(size);
-	order = get_order(size);
-	if (order >= 10)
-		return NULL;
-
-	first_page = __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
-	if (first_page = 0UL)
-		return NULL;
-	memset((char *)first_page, 0, PAGE_SIZE << order);
-
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	iopte = alloc_npages(iommu, size >> IO_PAGE_SHIFT);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	if (unlikely(iopte = NULL)) {
-		free_pages(first_page, order);
-		return NULL;
-	}
-
-	*dvma_addr = (iommu->page_table_map_base +
-		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
-	ret = (void *) first_page;
-	npages = size >> IO_PAGE_SHIFT;
-	first_page = __pa(first_page);
-	while (npages--) {
-		iopte_val(*iopte) = (IOPTE_VALID | IOPTE_CACHE |
-				     IOPTE_WRITE |
-				     (first_page & IOPTE_PAGE));
-		iopte++;
-		first_page += IO_PAGE_SIZE;
-	}
-
-	return ret;
-}
-
-void sbus_free_consistent(struct sbus_dev *sdev, size_t size, void *cpu, dma_addr_t dvma)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	iopte_t *iopte;
-	unsigned long flags, order, npages;
-
-	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-	iopte = iommu->page_table +
-		((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	free_npages(iommu, dvma - iommu->page_table_map_base, npages);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	order = get_order(size);
-	if (order < 10)
-		free_pages((unsigned long)cpu, order);
-}
-
-dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *ptr, size_t sz, int direction)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	iopte_t *base;
-	unsigned long flags, npages, oaddr;
-	unsigned long i, base_paddr;
-	u32 bus_addr, ret;
-	unsigned long iopte_protection;
-
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-
-	if (unlikely(direction = SBUS_DMA_NONE))
-		BUG();
-
-	oaddr = (unsigned long)ptr;
-	npages = IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
-	npages >>= IO_PAGE_SHIFT;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	base = alloc_npages(iommu, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	if (unlikely(!base))
-		BUG();
-
-	bus_addr = (iommu->page_table_map_base +
-		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
-	ret = bus_addr | (oaddr & ~IO_PAGE_MASK);
-	base_paddr = __pa(oaddr & IO_PAGE_MASK);
-
-	iopte_protection = IOPTE_VALID | IOPTE_STBUF | IOPTE_CACHE;
-	if (direction != SBUS_DMA_TODEVICE)
-		iopte_protection |= IOPTE_WRITE;
-
-	for (i = 0; i < npages; i++, base++, base_paddr += IO_PAGE_SIZE)
-		iopte_val(*base) = iopte_protection | base_paddr;
-
-	return ret;
-}
-
-void sbus_unmap_single(struct sbus_dev *sdev, dma_addr_t bus_addr, size_t sz, int direction)
-{
-	struct sbus_info *info = sdev->bus->iommu;
-	struct iommu *iommu = &info->iommu;
-	struct strbuf *strbuf = &info->strbuf;
-	iopte_t *base;
-	unsigned long flags, npages, i;
-
-	if (unlikely(direction = SBUS_DMA_NONE))
-		BUG();
-
-	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
-	npages >>= IO_PAGE_SHIFT;
-	base = iommu->page_table +
-		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-
-	bus_addr &= IO_PAGE_MASK;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	sbus_strbuf_flush(iommu, strbuf, bus_addr, npages, direction);
-	for (i = 0; i < npages; i++)
-		iopte_val(base[i]) = 0UL;
-	free_npages(iommu, bus_addr - iommu->page_table_map_base, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-#define SG_ENT_PHYS_ADDRESS(SG)	\
-	(__pa(page_address((SG)->page)) + (SG)->offset)
-
-static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg,
-			   int nused, int nelems, unsigned long iopte_protection)
-{
-	struct scatterlist *dma_sg = sg;
-	struct scatterlist *sg_end = sg + nelems;
-	int i;
-
-	for (i = 0; i < nused; i++) {
-		unsigned long pteval = ~0UL;
-		u32 dma_npages;
-
-		dma_npages = ((dma_sg->dma_address & (IO_PAGE_SIZE - 1UL)) +
-			      dma_sg->dma_length +
-			      ((IO_PAGE_SIZE - 1UL))) >> IO_PAGE_SHIFT;
-		do {
-			unsigned long offset;
-			signed int len;
-
-			/* If we are here, we know we have at least one
-			 * more page to map.  So walk forward until we
-			 * hit a page crossing, and begin creating new
-			 * mappings from that spot.
-			 */
-			for (;;) {
-				unsigned long tmp;
-
-				tmp = SG_ENT_PHYS_ADDRESS(sg);
-				len = sg->length;
-				if (((tmp ^ pteval) >> IO_PAGE_SHIFT) != 0UL) {
-					pteval = tmp & IO_PAGE_MASK;
-					offset = tmp & (IO_PAGE_SIZE - 1UL);
-					break;
-				}
-				if (((tmp ^ (tmp + len - 1UL)) >> IO_PAGE_SHIFT) != 0UL) {
-					pteval = (tmp + IO_PAGE_SIZE) & IO_PAGE_MASK;
-					offset = 0UL;
-					len -= (IO_PAGE_SIZE - (tmp & (IO_PAGE_SIZE - 1UL)));
-					break;
-				}
-				sg++;
-			}
-
-			pteval = iopte_protection | (pteval & IOPTE_PAGE);
-			while (len > 0) {
-				*iopte++ = __iopte(pteval);
-				pteval += IO_PAGE_SIZE;
-				len -= (IO_PAGE_SIZE - offset);
-				offset = 0;
-				dma_npages--;
-			}
-
-			pteval = (pteval & IOPTE_PAGE) + len;
-			sg++;
-
-			/* Skip over any tail mappings we've fully mapped,
-			 * adjusting pteval along the way.  Stop when we
-			 * detect a page crossing event.
-			 */
-			while (sg < sg_end &&
-			       (pteval << (64 - IO_PAGE_SHIFT)) != 0UL &&
-			       (pteval = SG_ENT_PHYS_ADDRESS(sg)) &&
-			       ((pteval ^
-				 (SG_ENT_PHYS_ADDRESS(sg) + sg->length - 1UL)) >> IO_PAGE_SHIFT) = 0UL) {
-				pteval += sg->length;
-				sg++;
-			}
-			if ((pteval << (64 - IO_PAGE_SHIFT)) = 0UL)
-				pteval = ~0UL;
-		} while (dma_npages != 0);
-		dma_sg++;
-	}
-}
-
-int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sglist, int nelems, int direction)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	unsigned long flags, npages, iopte_protection;
-	iopte_t *base;
-	u32 dma_base;
-	struct scatterlist *sgtmp;
-	int used;
-
-	/* Fast path single entry scatterlists. */
-	if (nelems = 1) {
-		sglist->dma_address -			sbus_map_single(sdev,
-					(page_address(sglist->page) + sglist->offset),
-					sglist->length, direction);
-		sglist->dma_length = sglist->length;
-		return 1;
-	}
-
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-
-	if (unlikely(direction = SBUS_DMA_NONE))
-		BUG();
-
-	npages = prepare_sg(sglist, nelems);
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	base = alloc_npages(iommu, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	if (unlikely(base = NULL))
-		BUG();
-
-	dma_base = iommu->page_table_map_base +
-		((base - iommu->page_table) << IO_PAGE_SHIFT);
-
-	/* Normalize DVMA addresses. */
-	used = nelems;
-
-	sgtmp = sglist;
-	while (used && sgtmp->dma_length) {
-		sgtmp->dma_address += dma_base;
-		sgtmp++;
-		used--;
-	}
-	used = nelems - used;
-
-	iopte_protection = IOPTE_VALID | IOPTE_STBUF | IOPTE_CACHE;
-	if (direction != SBUS_DMA_TODEVICE)
-		iopte_protection |= IOPTE_WRITE;
-
-	fill_sg(base, sglist, used, nelems, iopte_protection);
-
-#ifdef VERIFY_SG
-	verify_sglist(sglist, nelems, base, npages);
-#endif
-
-	return used;
-}
-
-void sbus_unmap_sg(struct sbus_dev *sdev, struct scatterlist *sglist, int nelems, int direction)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	iopte_t *base;
-	unsigned long flags, i, npages;
-	u32 bus_addr;
-
-	if (unlikely(direction = SBUS_DMA_NONE))
-		BUG();
-
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-	strbuf = &info->strbuf;
-
-	bus_addr = sglist->dma_address & IO_PAGE_MASK;
-
-	for (i = 1; i < nelems; i++)
-		if (sglist[i].dma_length = 0)
-			break;
-	i--;
-	npages = (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length) -
-		  bus_addr) >> IO_PAGE_SHIFT;
-
-	base = iommu->page_table +
-		((bus_addr - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	sbus_strbuf_flush(iommu, strbuf, bus_addr, npages, direction);
-	for (i = 0; i < npages; i++)
-		iopte_val(base[i]) = 0UL;
-	free_npages(iommu, bus_addr - iommu->page_table_map_base, npages);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev, dma_addr_t bus_addr, size_t sz, int direction)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	unsigned long flags, npages;
-
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-	strbuf = &info->strbuf;
-
-	npages = IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
-	npages >>= IO_PAGE_SHIFT;
-	bus_addr &= IO_PAGE_MASK;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	sbus_strbuf_flush(iommu, strbuf, bus_addr, npages, direction);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-void sbus_dma_sync_single_for_device(struct sbus_dev *sdev, dma_addr_t base, size_t size, int direction)
-{
-}
-
-void sbus_dma_sync_sg_for_cpu(struct sbus_dev *sdev, struct scatterlist *sglist, int nelems, int direction)
-{
-	struct sbus_info *info;
-	struct iommu *iommu;
-	struct strbuf *strbuf;
-	unsigned long flags, npages, i;
-	u32 bus_addr;
-
-	info = sdev->bus->iommu;
-	iommu = &info->iommu;
-	strbuf = &info->strbuf;
-
-	bus_addr = sglist[0].dma_address & IO_PAGE_MASK;
-	for (i = 0; i < nelems; i++) {
-		if (!sglist[i].dma_length)
-			break;
-	}
-	i--;
-	npages = (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length)
-		  - bus_addr) >> IO_PAGE_SHIFT;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	sbus_strbuf_flush(iommu, strbuf, bus_addr, npages, direction);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-void sbus_dma_sync_sg_for_device(struct sbus_dev *sdev, struct scatterlist *sg, int nents, int direction)
-{
-}
-
 /* Enable 64-bit DVMA mode for the given device. */
 void sbus_set_sbus64(struct sbus_dev *sdev, int bursts)
 {
-	struct sbus_info *info = sdev->bus->iommu;
-	struct iommu *iommu = &info->iommu;
+	struct iommu *iommu = sdev->ofdev.dev.archdata.iommu;
 	int slot = sdev->slot;
 	unsigned long cfg_reg;
 	u64 val;
@@ -713,8 +194,7 @@ static unsigned long sysio_imap_to_iclr(unsigned long imap)
 unsigned int sbus_build_irq(void *buscookie, unsigned int ino)
 {
 	struct sbus_bus *sbus = (struct sbus_bus *)buscookie;
-	struct sbus_info *info = sbus->iommu;
-	struct iommu *iommu = &info->iommu;
+	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned long imap, iclr;
 	int sbus_level = 0;
@@ -776,8 +256,7 @@ unsigned int sbus_build_irq(void *buscookie, unsigned int ino)
 static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 {
 	struct sbus_bus *sbus = dev_id;
-	struct sbus_info *info = sbus->iommu;
-	struct iommu *iommu = &info->iommu;
+	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned long afsr_reg, afar_reg;
 	unsigned long afsr, afar, error_bits;
@@ -849,8 +328,7 @@ static irqreturn_t sysio_ue_handler(int irq, void *dev_id)
 static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 {
 	struct sbus_bus *sbus = dev_id;
-	struct sbus_info *info = sbus->iommu;
-	struct iommu *iommu = &info->iommu;
+	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned long afsr_reg, afar_reg;
 	unsigned long afsr, afar, error_bits;
@@ -927,8 +405,7 @@ static irqreturn_t sysio_ce_handler(int irq, void *dev_id)
 static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 {
 	struct sbus_bus *sbus = dev_id;
-	struct sbus_info *info = sbus->iommu;
-	struct iommu *iommu = &info->iommu;
+	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
 	unsigned long afsr_reg, afar_reg, reg_base;
 	unsigned long afsr, afar, error_bits;
 	int reported;
@@ -995,8 +472,7 @@ static irqreturn_t sysio_sbus_error_handler(int irq, void *dev_id)
 
 static void __init sysio_register_error_handlers(struct sbus_bus *sbus)
 {
-	struct sbus_info *info = sbus->iommu;
-	struct iommu *iommu = &info->iommu;
+	struct iommu *iommu = sbus->ofdev.dev.archdata.iommu;
 	unsigned long reg_base = iommu->write_complete_reg - 0x2000UL;
 	unsigned int irq;
 	u64 control;
@@ -1041,7 +517,6 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 {
 	const struct linux_prom64_registers *pr;
 	struct device_node *dp;
-	struct sbus_info *info;
 	struct iommu *iommu;
 	struct strbuf *strbuf;
 	unsigned long regs, reg_base;
@@ -1054,25 +529,28 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 
 	pr = of_get_property(dp, "reg", NULL);
 	if (!pr) {
-		prom_printf("sbus_iommu_init: Cannot map SYSIO control registers.\n");
+		prom_printf("sbus_iommu_init: Cannot map SYSIO "
+			    "control registers.\n");
 		prom_halt();
 	}
 	regs = pr->phys_addr;
 
-	info = kzalloc(sizeof(*info), GFP_ATOMIC);
-	if (info = NULL) {
-		prom_printf("sbus_iommu_init: Fatal error, "
-			    "kmalloc(info) failed\n");
-		prom_halt();
-	}
+	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
+	if (!iommu)
+		goto fatal_memory_error;
+	strbuf = kzalloc(sizeof(*strbuf), GFP_ATOMIC);
+	if (!strbuf)
+		goto fatal_memory_error;
 
-	iommu = &info->iommu;
-	strbuf = &info->strbuf;
+	sbus->ofdev.dev.archdata.iommu = iommu;
+	sbus->ofdev.dev.archdata.stc = strbuf;
 
 	reg_base = regs + SYSIO_IOMMUREG_BASE;
 	iommu->iommu_control = reg_base + IOMMU_CONTROL;
 	iommu->iommu_tsbbase = reg_base + IOMMU_TSBBASE;
 	iommu->iommu_flush = reg_base + IOMMU_FLUSH;
+	iommu->iommu_tags = iommu->iommu_control +
+		(IOMMU_TAGDIAG - IOMMU_CONTROL);
 
 	reg_base = regs + SYSIO_STRBUFREG_BASE;
 	strbuf->strbuf_control = reg_base + STRBUF_CONTROL;
@@ -1093,14 +571,12 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 	 */
 	iommu->write_complete_reg = regs + 0x2000UL;
 
-	/* Link into SYSIO software state. */
-	sbus->iommu = info;
-
 	printk("SYSIO: UPA portID %x, at %016lx\n",
 	       sbus->portid, regs);
 
 	/* Setup for TSB_SIZE=7, TBW_SIZE=0, MMU_DE=1, MMU_EN=1 */
-	sbus_iommu_table_init(iommu, IO_TSB_SIZE);
+	if (iommu_table_init(iommu, IO_TSB_SIZE, MAP_BASE, 0xffffffff))
+		goto fatal_memory_error;
 
 	control = upa_readq(iommu->iommu_control);
 	control = ((7UL << 16UL)	|
@@ -1157,6 +633,10 @@ static void __init sbus_iommu_init(int __node, struct sbus_bus *sbus)
 		starfire_hookup(sbus->portid);
 
 	sysio_register_error_handlers(sbus);
+	return;
+
+fatal_memory_error:
+	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
 }
 
 void sbus_fill_device_irq(struct sbus_dev *sdev)
diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 2553629..c37d7c2 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -210,6 +210,10 @@ static void __init walk_children(struct device_node *dp, struct sbus_dev *parent
 
 			sdev->bus = sbus;
 			sdev->parent = parent;
+			sdev->ofdev.dev.archdata.iommu +				sbus->ofdev.dev.archdata.iommu;
+			sdev->ofdev.dev.archdata.stc +				sbus->ofdev.dev.archdata.stc;
 
 			fill_sbus_device(dp, sdev);
 
@@ -269,6 +273,11 @@ static void __init build_one_sbus(struct device_node *dp, int num_sbus)
 
 			sdev->bus = sbus;
 			sdev->parent = NULL;
+			sdev->ofdev.dev.archdata.iommu +				sbus->ofdev.dev.archdata.iommu;
+			sdev->ofdev.dev.archdata.stc +				sbus->ofdev.dev.archdata.stc;
+
 			fill_sbus_device(dev_dp, sdev);
 
 			walk_children(dev_dp, sdev, sbus);
diff --git a/include/asm-sparc/device.h b/include/asm-sparc/device.h
index 4a56d84..c0a7786 100644
--- a/include/asm-sparc/device.h
+++ b/include/asm-sparc/device.h
@@ -10,6 +10,10 @@ struct device_node;
 struct of_device;
 
 struct dev_archdata {
+	void			*iommu;
+	void			*stc;
+	void			*host_controller;
+
 	struct device_node	*prom_node;
 	struct of_device	*op;
 };
diff --git a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
index c58ec16..0a10066 100644
--- a/include/asm-sparc64/dma-mapping.h
+++ b/include/asm-sparc64/dma-mapping.h
@@ -1,307 +1,134 @@
 #ifndef _ASM_SPARC64_DMA_MAPPING_H
 #define _ASM_SPARC64_DMA_MAPPING_H
 
-
-#ifdef CONFIG_PCI
-
-/* we implement the API below in terms of the existing PCI one,
- * so include it */
-#include <linux/pci.h>
-/* need struct page definitions */
+#include <linux/scatterlist.h>
 #include <linux/mm.h>
 
-#include <asm/of_device.h>
-
-static inline int
-dma_supported(struct device *dev, u64 mask)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_dma_supported(to_pci_dev(dev), mask);
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
-}
-
-static inline void *
-dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		   gfp_t flag)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_iommu_ops->alloc_consistent(to_pci_dev(dev), size, dma_handle, flag);
-}
-
-static inline void
-dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-		    dma_addr_t dma_handle)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
-}
-
-static inline dma_addr_t
-dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
-}
-
-static inline void
-dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
-}
-
-static inline dma_addr_t
-dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
-}
-
-static inline void
-dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
-}
-
-static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
-}
-
-static inline void
-dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
-}
-
-static inline void
-dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_dma_sync_single_for_cpu(to_pci_dev(dev), dma_handle,
-				    size, (int)direction);
-}
-
-static inline void
-dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			   enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_dma_sync_single_for_device(to_pci_dev(dev), dma_handle,
-				       size, (int)direction);
-}
-
-static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_dma_sync_sg_for_cpu(to_pci_dev(dev), sg, nelems, (int)direction);
-}
-
-static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		       enum dma_data_direction direction)
-{
-	BUG_ON(dev->bus != &pci_bus_type);
-
-	pci_dma_sync_sg_for_device(to_pci_dev(dev), sg, nelems, (int)direction);
-}
-
-static inline int
-dma_mapping_error(dma_addr_t dma_addr)
-{
-	return pci_dma_mapping_error(dma_addr);
-}
-
-#else
-
-struct device;
-struct page;
-struct scatterlist;
-
-static inline int
-dma_supported(struct device *dev, u64 mask)
-{
-	BUG();
-	return 0;
-}
-
-static inline int
-dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	BUG();
-	return 0;
-}
+#define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
+
+struct dma_ops {
+	void *(*alloc_coherent)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flag);
+	void (*free_coherent)(struct device *dev, size_t size,
+			      void *cpu_addr, dma_addr_t dma_handle);
+	dma_addr_t (*map_single)(struct device *dev, void *cpu_addr,
+				 size_t size,
+				 enum dma_data_direction direction);
+	void (*unmap_single)(struct device *dev, dma_addr_t dma_addr,
+			     size_t size,
+			     enum dma_data_direction direction);
+	int (*map_sg)(struct device *dev, struct scatterlist *sg, int nents,
+		      enum dma_data_direction direction);
+	void (*unmap_sg)(struct device *dev, struct scatterlist *sg,
+			 int nhwentries,
+			 enum dma_data_direction direction);
+	void (*sync_single_for_cpu)(struct device *dev,
+				    dma_addr_t dma_handle, size_t size,
+				    enum dma_data_direction direction);
+	void (*sync_single_for_device)(struct device *dev,
+				       dma_addr_t dma_handle, size_t size,
+				       enum dma_data_direction direction);
+	void (*sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg,
+				int nelems,
+				enum dma_data_direction direction);
+	void (*sync_sg_for_device)(struct device *dev, struct scatterlist *sg,
+				   int nelems,
+				   enum dma_data_direction direction);
+};
+extern const struct dma_ops *dma_ops;
+
+extern int dma_supported(struct device *dev, u64 mask);
+extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, gfp_t flag)
+				       dma_addr_t *dma_handle, gfp_t flag)
 {
-	BUG();
-	return NULL;
+	return dma_ops->alloc_coherent(dev, size, dma_handle, flag);
 }
 
 static inline void dma_free_coherent(struct device *dev, size_t size,
-		       void *vaddr, dma_addr_t dma_handle)
+				     void *cpu_addr, dma_addr_t dma_handle)
 {
-	BUG();
+	dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
 }
 
-static inline dma_addr_t
-dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-	       enum dma_data_direction direction)
+static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
+					size_t size,
+					enum dma_data_direction direction)
 {
-	BUG();
-	return 0;
+	return dma_ops->map_single(dev, cpu_addr, size, direction);
 }
 
-static inline void
-dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		 enum dma_data_direction direction)
+static inline void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+				    size_t size,
+				    enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->unmap_single(dev, dma_addr, size, direction);
 }
 
-static inline dma_addr_t
-dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size,
-	     enum dma_data_direction direction)
+static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
+				      unsigned long offset, size_t size,
+				      enum dma_data_direction direction)
 {
-	BUG();
-	return 0;
+	return dma_ops->map_single(dev, page_address(page) + offset,
+				   size, direction);
 }
 
-static inline void
-dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-	       enum dma_data_direction direction)
+static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
+				  size_t size,
+				  enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->unmap_single(dev, dma_address, size, direction);
 }
 
-static inline int
-dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-	   enum dma_data_direction direction)
+static inline int dma_map_sg(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction direction)
 {
-	BUG();
-	return 0;
+	return dma_ops->map_sg(dev, sg, nents, direction);
 }
 
-static inline void
-dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-	     enum dma_data_direction direction)
+static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->unmap_sg(dev, sg, nents, direction);
 }
 
-static inline void
-dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
-			enum dma_data_direction direction)
+static inline void dma_sync_single_for_cpu(struct device *dev,
+					   dma_addr_t dma_handle, size_t size,
+					   enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->sync_single_for_cpu(dev, dma_handle, size, direction);
 }
 
-static inline void
-dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
-			   enum dma_data_direction direction)
+static inline void dma_sync_single_for_device(struct device *dev,
+					      dma_addr_t dma_handle,
+					      size_t size,
+					      enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->sync_single_for_device(dev, dma_handle, size, direction);
 }
 
-static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
-		    enum dma_data_direction direction)
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+				       struct scatterlist *sg, int nelems,
+				       enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->sync_sg_for_cpu(dev, sg, nelems, direction);
 }
 
-static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
-		       enum dma_data_direction direction)
+static inline void dma_sync_sg_for_device(struct device *dev,
+					  struct scatterlist *sg, int nelems,
+					  enum dma_data_direction direction)
 {
-	BUG();
+	dma_ops->sync_sg_for_device(dev, sg, nelems, direction);
 }
 
-static inline int
-dma_mapping_error(dma_addr_t dma_addr)
+static inline int dma_mapping_error(dma_addr_t dma_addr)
 {
-	BUG();
-	return 0;
+	return (dma_addr = DMA_ERROR_CODE);
 }
 
-#endif /* PCI */
-
-
-/* Now for the API extensions over the pci_ one */
-
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #define dma_is_consistent(d, h)	(1)
 
-static inline int
-dma_get_cache_alignment(void)
-{
-	/* no easy way to get cache size on all processors, so return
-	 * the maximum possible, to be safe */
-	return (1 << INTERNODE_CACHE_SHIFT);
-}
-
-static inline void
-dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
-{
-	/* just sync everything, that's all the pci API can do */
-	dma_sync_single_for_cpu(dev, dma_handle, offset+size, direction);
-}
-
-static inline void
-dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-				 unsigned long offset, size_t size,
-				 enum dma_data_direction direction)
-{
-	/* just sync everything, that's all the pci API can do */
-	dma_sync_single_for_device(dev, dma_handle, offset+size, direction);
-}
-
-static inline void
-dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-	       enum dma_data_direction direction)
-{
-	/* could define this in terms of the dma_cache ... operations,
-	 * but if you get this on a platform, you should convert the platform
-	 * to using the generic device DMA API */
-	BUG();
-}
-
 #endif /* _ASM_SPARC64_DMA_MAPPING_H */
diff --git a/include/asm-sparc64/iommu.h b/include/asm-sparc64/iommu.h
index 0b1813f..9eac667 100644
--- a/include/asm-sparc64/iommu.h
+++ b/include/asm-sparc64/iommu.h
@@ -1,7 +1,6 @@
-/* $Id: iommu.h,v 1.10 2001/03/08 09:55:56 davem Exp $
- * iommu.h: Definitions for the sun5 IOMMU.
+/* iommu.h: Definitions for the sun5 IOMMU.
  *
- * Copyright (C) 1996, 1999 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1996, 1999, 2007 David S. Miller (davem@davemloft.net)
  */
 #ifndef _SPARC64_IOMMU_H
 #define _SPARC64_IOMMU_H
@@ -33,6 +32,7 @@ struct iommu {
 	unsigned long		iommu_tsbbase;
 	unsigned long		iommu_flush;
 	unsigned long		iommu_flushinv;
+	unsigned long		iommu_tags;
 	unsigned long		iommu_ctxflush;
 	unsigned long		write_complete_reg;
 	unsigned long		dummy_page;
@@ -54,4 +54,7 @@ struct strbuf {
 	volatile unsigned long	__flushflag_buf[(64+(64-1)) / sizeof(long)];
 };
 
-#endif /* !(_SPARC_IOMMU_H) */
+extern int iommu_table_init(struct iommu *iommu, int tsbsize,
+			    u32 dma_offset, u32 dma_addr_mask);
+
+#endif /* !(_SPARC64_IOMMU_H) */
diff --git a/include/asm-sparc64/parport.h b/include/asm-sparc64/parport.h
index 600afe5..8116e8f 100644
--- a/include/asm-sparc64/parport.h
+++ b/include/asm-sparc64/parport.h
@@ -117,7 +117,7 @@ static int __devinit ecpp_probe(struct of_device *op, const struct of_device_id
 	if (!strcmp(parent->name, "dma")) {
 		p = parport_pc_probe_port(base, base + 0x400,
 					  op->irqs[0], PARPORT_DMA_NOFIFO,
-					  op->dev.parent);
+					  op->dev.parent->parent);
 		if (!p)
 			return -ENOMEM;
 		dev_set_drvdata(&op->dev, p);
diff --git a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
index e11ac10..1393e57 100644
--- a/include/asm-sparc64/pci.h
+++ b/include/asm-sparc64/pci.h
@@ -3,8 +3,7 @@
 
 #ifdef __KERNEL__
 
-#include <linux/fs.h>
-#include <linux/mm.h>
+#include <linux/dma-mapping.h>
 
 /* Can be used to override the logic in pci_scan_bus for skipping
  * already-configured bus numbers - to be used for buggy BIOSes
@@ -30,80 +29,42 @@ static inline void pcibios_penalize_isa_irq(int irq, int active)
 	/* We don't do dynamic PCI IRQ allocation */
 }
 
-/* Dynamic DMA mapping stuff.
- */
-
 /* The PCI address space does not equal the physical memory
  * address space.  The networking and block device layers use
  * this boolean for bounce buffer decisions.
  */
 #define PCI_DMA_BUS_IS_PHYS	(0)
 
-#include <asm/scatterlist.h>
-
-struct pci_dev;
-
-struct pci_iommu_ops {
-	void *(*alloc_consistent)(struct pci_dev *, size_t, dma_addr_t *, gfp_t);
-	void (*free_consistent)(struct pci_dev *, size_t, void *, dma_addr_t);
-	dma_addr_t (*map_single)(struct pci_dev *, void *, size_t, int);
-	void (*unmap_single)(struct pci_dev *, dma_addr_t, size_t, int);
-	int (*map_sg)(struct pci_dev *, struct scatterlist *, int, int);
-	void (*unmap_sg)(struct pci_dev *, struct scatterlist *, int, int);
-	void (*dma_sync_single_for_cpu)(struct pci_dev *, dma_addr_t, size_t, int);
-	void (*dma_sync_sg_for_cpu)(struct pci_dev *, struct scatterlist *, int, int);
-};
-
-extern const struct pci_iommu_ops *pci_iommu_ops;
-
-/* Allocate and map kernel buffer using consistent mode DMA for a device.
- * hwdev should be valid struct pci_dev pointer for PCI devices.
- */
-static inline void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size, dma_addr_t *dma_handle)
+static inline void *pci_alloc_consistent(struct pci_dev *pdev, size_t size,
+					 dma_addr_t *dma_handle)
 {
-	return pci_iommu_ops->alloc_consistent(hwdev, size, dma_handle, GFP_ATOMIC);
+	return dma_alloc_coherent(&pdev->dev, size, dma_handle, GFP_ATOMIC);
 }
 
-/* Free and unmap a consistent DMA buffer.
- * cpu_addr is what was returned from pci_alloc_consistent,
- * size must be the same as what as passed into pci_alloc_consistent,
- * and likewise dma_addr must be the same as what *dma_addrp was set to.
- *
- * References to the memory and mappings associated with cpu_addr/dma_addr
- * past this call are illegal.
- */
-static inline void pci_free_consistent(struct pci_dev *hwdev, size_t size, void *vaddr, dma_addr_t dma_handle)
+static inline void pci_free_consistent(struct pci_dev *pdev, size_t size,
+				       void *vaddr, dma_addr_t dma_handle)
 {
-	return pci_iommu_ops->free_consistent(hwdev, size, vaddr, dma_handle);
+	return dma_free_coherent(&pdev->dev, size, vaddr, dma_handle);
 }
 
-/* Map a single buffer of the indicated size for DMA in streaming mode.
- * The 32-bit bus address to use is returned.
- *
- * Once the device is given the dma address, the device owns this memory
- * until either pci_unmap_single or pci_dma_sync_single_for_cpu is performed.
- */
-static inline dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
+static inline dma_addr_t pci_map_single(struct pci_dev *pdev, void *ptr,
+					size_t size, int direction)
 {
-	return pci_iommu_ops->map_single(hwdev, ptr, size, direction);
+	return dma_map_single(&pdev->dev, ptr, size,
+			      (enum dma_data_direction) direction);
 }
 
-/* Unmap a single streaming mode DMA translation.  The dma_addr and size
- * must match what was provided for in a previous pci_map_single call.  All
- * other usages are undefined.
- *
- * After this call, reads by the cpu to the buffer are guaranteed to see
- * whatever the device wrote there.
- */
-static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr, size_t size, int direction)
+static inline void pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr,
+				    size_t size, int direction)
 {
-	pci_iommu_ops->unmap_single(hwdev, dma_addr, size, direction);
+	dma_unmap_single(&pdev->dev, dma_addr, size,
+			 (enum dma_data_direction) direction);
 }
 
-/* No highmem on sparc64, plus we have an IOMMU, so mapping pages is easy. */
 #define pci_map_page(dev, page, off, size, dir) \
 	pci_map_single(dev, (page_address(page) + (off)), size, dir)
-#define pci_unmap_page(dev,addr,sz,dir) pci_unmap_single(dev,addr,sz,dir)
+#define pci_unmap_page(dev,addr,sz,dir) \
+	pci_unmap_single(dev,addr,sz,dir)
 
 /* pci_unmap_{single,page} is not a nop, thus... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	\
@@ -119,75 +80,48 @@ static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)		\
 	(((PTR)->LEN_NAME) = (VAL))
 
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scatter-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nents, int direction)
+static inline int pci_map_sg(struct pci_dev *pdev, struct scatterlist *sg,
+			     int nents, int direction)
 {
-	return pci_iommu_ops->map_sg(hwdev, sg, nents, direction);
+	return dma_map_sg(&pdev->dev, sg, nents,
+			  (enum dma_data_direction) direction);
 }
 
-/* Unmap a set of streaming mode DMA translations.
- * Again, cpu read rules concerning calls here are the same as for
- * pci_unmap_single() above.
- */
-static inline void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nhwents, int direction)
+static inline void pci_unmap_sg(struct pci_dev *pdev, struct scatterlist *sg,
+				int nents, int direction)
 {
-	pci_iommu_ops->unmap_sg(hwdev, sg, nhwents, direction);
+	dma_unmap_sg(&pdev->dev, sg, nents,
+		     (enum dma_data_direction) direction);
 }
 
-/* Make physical memory consistent for a single
- * streaming mode DMA translation after a transfer.
- *
- * If you perform a pci_map_single() but wish to interrogate the
- * buffer using the cpu, yet do not wish to teardown the PCI dma
- * mapping, you must call this function before doing so.  At the
- * next point you give the PCI dma address back to the card, you
- * must first perform a pci_dma_sync_for_device, and then the
- * device again owns the buffer.
- */
-static inline void pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t dma_handle, size_t size, int direction)
+static inline void pci_dma_sync_single_for_cpu(struct pci_dev *pdev,
+					       dma_addr_t dma_handle,
+					       size_t size, int direction)
 {
-	pci_iommu_ops->dma_sync_single_for_cpu(hwdev, dma_handle, size, direction);
+	dma_sync_single_for_cpu(&pdev->dev, dma_handle, size,
+				(enum dma_data_direction) direction);
 }
 
-static inline void
-pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
-			       size_t size, int direction)
+static inline void pci_dma_sync_single_for_device(struct pci_dev *pdev,
+						  dma_addr_t dma_handle,
+						  size_t size, int direction)
 {
 	/* No flushing needed to sync cpu writes to the device.  */
-	BUG_ON(direction = PCI_DMA_NONE);
 }
 
-/* Make physical memory consistent for a set of streaming
- * mode DMA translations after a transfer.
- *
- * The same as pci_dma_sync_single_* but for a scatter-gather list,
- * same rules and usage.
- */
-static inline void pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg, int nelems, int direction)
+static inline void pci_dma_sync_sg_for_cpu(struct pci_dev *pdev,
+					   struct scatterlist *sg,
+					   int nents, int direction)
 {
-	pci_iommu_ops->dma_sync_sg_for_cpu(hwdev, sg, nelems, direction);
+	dma_sync_sg_for_cpu(&pdev->dev, sg, nents,
+			    (enum dma_data_direction) direction);
 }
 
-static inline void
-pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
-			int nelems, int direction)
+static inline void pci_dma_sync_sg_for_device(struct pci_dev *pdev,
+					      struct scatterlist *sg,
+					      int nelems, int direction)
 {
 	/* No flushing needed to sync cpu writes to the device.  */
-	BUG_ON(direction = PCI_DMA_NONE);
 }
 
 /* Return whether the given PCI device DMA address mask can
@@ -206,11 +140,9 @@ extern int pci_dma_supported(struct pci_dev *hwdev, u64 mask);
 #define PCI64_REQUIRED_MASK	(~(dma64_addr_t)0)
 #define PCI64_ADDR_BASE		0xfffc000000000000UL
 
-#define PCI_DMA_ERROR_CODE	(~(dma_addr_t)0x0)
-
 static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
 {
-	return (dma_addr = PCI_DMA_ERROR_CODE);
+	return dma_mapping_error(dma_addr);
 }
 
 #ifdef CONFIG_PCI
diff --git a/include/asm-sparc64/sbus.h b/include/asm-sparc64/sbus.h
index 7efd49d..0151cad 100644
--- a/include/asm-sparc64/sbus.h
+++ b/include/asm-sparc64/sbus.h
@@ -1,7 +1,6 @@
-/* $Id: sbus.h,v 1.14 2000/02/18 13:50:55 davem Exp $
- * sbus.h: Defines for the Sun SBus.
+/* sbus.h: Defines for the Sun SBus.
  *
- * Copyright (C) 1996, 1999 David S. Miller (davem@redhat.com)
+ * Copyright (C) 1996, 1999, 2007 David S. Miller (davem@davemloft.net)
  */
 
 #ifndef _SPARC64_SBUS_H
@@ -69,7 +68,6 @@ struct sbus_dev {
 /* This struct describes the SBus(s) found on this machine. */
 struct sbus_bus {
 	struct of_device	ofdev;
-	void			*iommu;		/* Opaque IOMMU cookie	*/
 	struct sbus_dev		*devices;	/* Tree of SBUS devices	*/
 	struct sbus_bus		*next;		/* Next SBUS in system	*/
 	int			prom_node;      /* OBP node of SBUS	*/
@@ -102,9 +100,18 @@ extern struct sbus_bus *sbus_root;
 extern void sbus_set_sbus64(struct sbus_dev *, int);
 extern void sbus_fill_device_irq(struct sbus_dev *);
 
-/* These yield IOMMU mappings in consistent mode. */
-extern void *sbus_alloc_consistent(struct sbus_dev *, size_t, dma_addr_t *dma_addrp);
-extern void sbus_free_consistent(struct sbus_dev *, size_t, void *, dma_addr_t);
+static inline void *sbus_alloc_consistent(struct sbus_dev *sdev , size_t size,
+					  dma_addr_t *dma_handle)
+{
+	return dma_alloc_coherent(&sdev->ofdev.dev, size,
+				  dma_handle, GFP_ATOMIC);
+}
+
+static inline void sbus_free_consistent(struct sbus_dev *sdev, size_t size,
+					void *vaddr, dma_addr_t dma_handle)
+{
+	return dma_free_coherent(&sdev->ofdev.dev, size, vaddr, dma_handle);
+}
 
 #define SBUS_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
 #define SBUS_DMA_TODEVICE	DMA_TO_DEVICE
@@ -112,18 +119,67 @@ extern void sbus_free_consistent(struct sbus_dev *, size_t, void *, dma_addr_t);
 #define	SBUS_DMA_NONE		DMA_NONE
 
 /* All the rest use streaming mode mappings. */
-extern dma_addr_t sbus_map_single(struct sbus_dev *, void *, size_t, int);
-extern void sbus_unmap_single(struct sbus_dev *, dma_addr_t, size_t, int);
-extern int sbus_map_sg(struct sbus_dev *, struct scatterlist *, int, int);
-extern void sbus_unmap_sg(struct sbus_dev *, struct scatterlist *, int, int);
+static inline dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *ptr,
+					 size_t size, int direction)
+{
+	return dma_map_single(&sdev->ofdev.dev, ptr, size,
+			      (enum dma_data_direction) direction);
+}
+
+static inline void sbus_unmap_single(struct sbus_dev *sdev,
+				     dma_addr_t dma_addr, size_t size,
+				     int direction)
+{
+	dma_unmap_single(&sdev->ofdev.dev, dma_addr, size,
+			 (enum dma_data_direction) direction);
+}
+
+static inline int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sg,
+			      int nents, int direction)
+{
+	return dma_map_sg(&sdev->ofdev.dev, sg, nents,
+			  (enum dma_data_direction) direction);
+}
+
+static inline void sbus_unmap_sg(struct sbus_dev *sdev, struct scatterlist *sg,
+				 int nents, int direction)
+{
+	dma_unmap_sg(&sdev->ofdev.dev, sg, nents,
+		     (enum dma_data_direction) direction);
+}
 
 /* Finally, allow explicit synchronization of streamable mappings. */
-extern void sbus_dma_sync_single_for_cpu(struct sbus_dev *, dma_addr_t, size_t, int);
+static inline void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev,
+						dma_addr_t dma_handle,
+						size_t size, int direction)
+{
+	dma_sync_single_for_cpu(&sdev->ofdev.dev, dma_handle, size,
+				(enum dma_data_direction) direction);
+}
 #define sbus_dma_sync_single sbus_dma_sync_single_for_cpu
-extern void sbus_dma_sync_single_for_device(struct sbus_dev *, dma_addr_t, size_t, int);
-extern void sbus_dma_sync_sg_for_cpu(struct sbus_dev *, struct scatterlist *, int, int);
+
+static inline void sbus_dma_sync_single_for_device(struct sbus_dev *sdev,
+						   dma_addr_t dma_handle,
+						   size_t size, int direction)
+{
+	/* No flushing needed to sync cpu writes to the device.  */
+}
+
+static inline void sbus_dma_sync_sg_for_cpu(struct sbus_dev *sdev,
+					    struct scatterlist *sg,
+					    int nents, int direction)
+{
+	dma_sync_sg_for_cpu(&sdev->ofdev.dev, sg, nents,
+			    (enum dma_data_direction) direction);
+}
 #define sbus_dma_sync_sg sbus_dma_sync_sg_for_cpu
-extern void sbus_dma_sync_sg_for_device(struct sbus_dev *, struct scatterlist *, int, int);
+
+static inline void sbus_dma_sync_sg_for_device(struct sbus_dev *sdev,
+					       struct scatterlist *sg,
+					       int nents, int direction)
+{
+	/* No flushing needed to sync cpu writes to the device.  */
+}
 
 extern void sbus_arch_bus_ranges_init(struct device_node *, struct sbus_bus *);
 extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
