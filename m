From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 09 Apr 2015 19:33:30 +0000
Subject: [PATCH v10 1/3] Break up monolithic iommu table/lock into finer graularity pools and lock
Message-Id: <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428605063.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1428605063.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1428605063.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Investigation of multithreaded iperf experiments on an ethernet
interface show the iommu->lock as the hottest lock identified by
lockstat, with something of the order of  21M contentions out of
27M acquisitions, and an average wait time of 26 us for the lock.
This is not efficient. A more scalable design is to follow the ppc
model, where the iommu_map_table has multiple pools, each stretching
over a segment of the map, and with a separate lock for each pool.
This model allows for better parallelization of the iommu map search.

This patch adds the iommu range alloc/free function infrastructure.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
v2 changes:
  - incorporate David Miller editorial comments: sparc specific
    fields moved from iommu-common into sparc's iommu_64.h
  - make the npools value an input parameter, for the case when
    the iommu map size is not very large
  - cookie_to_index mapping, and optimizations for span-boundary
    check, for use case such as LDC.
v3: eliminate iommu_sparc, rearrange the ->demap indirection to
    be invoked under the pool lock.

v4: David Miller review changes:
  - s/IOMMU_ERROR_CODE/DMA_ERROR_CODE
  - page_table_map_base and page_table_shift are unsigned long, not u32.

v5: Feedback from benh@kernel.crashing.org and aik@ozlabs.ru
  - removed ->cookie_to_index and ->demap indirection: caller should
    invoke these as needed before calling into the generic allocator

v6: Benh/DaveM discussion eliminationg iommu_tbl_ops, but retaining flush_all
    optimization.

v7: one-time initialization of pool_hash from iommu_tbl_pool_init()

v8: Benh code review comments.

v9: More Benh code review comments, added dma_mask, align_order logic to
    iommu_tbl_range_alloc.

v10: resend without RFC tag, and new mail message-id

 include/linux/iommu-common.h |   51 ++++++++
 lib/Makefile                 |    2 +-
 lib/iommu-common.c           |  266 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

diff --git a/include/linux/iommu-common.h b/include/linux/iommu-common.h
new file mode 100644
index 0000000..bbced83
--- /dev/null
+++ b/include/linux/iommu-common.h
@@ -0,0 +1,51 @@
+#ifndef _LINUX_IOMMU_COMMON_H
+#define _LINUX_IOMMU_COMMON_H
+
+#include <linux/spinlock_types.h>
+#include <linux/device.h>
+#include <asm/page.h>
+
+#define IOMMU_POOL_HASHBITS     4
+#define IOMMU_NR_POOLS          (1 << IOMMU_POOL_HASHBITS)
+
+struct iommu_pool {
+	unsigned long	start;
+	unsigned long	end;
+	unsigned long	hint;
+	spinlock_t	lock;
+};
+
+struct iommu_map_table {
+	unsigned long		table_map_base;
+	unsigned long		table_shift;
+	unsigned long		nr_pools;
+	void			(*lazy_flush)(struct iommu_map_table *);
+	unsigned long		poolsize;
+	struct iommu_pool	pools[IOMMU_NR_POOLS];
+	u32			flags;
+#define	IOMMU_HAS_LARGE_POOL	0x00000001
+#define	IOMMU_NO_SPAN_BOUND	0x00000002
+#define	IOMMU_NEED_FLUSH	0x00000004
+	struct iommu_pool	large_pool;
+	unsigned long		*map;
+};
+
+extern void iommu_tbl_pool_init(struct iommu_map_table *iommu,
+				unsigned long num_entries,
+				u32 table_shift,
+				void (*lazy_flush)(struct iommu_map_table *),
+				bool large_pool, u32 npools,
+				bool skip_span_boundary_check);
+
+extern unsigned long iommu_tbl_range_alloc(struct device *dev,
+					   struct iommu_map_table *iommu,
+					   unsigned long npages,
+					   unsigned long *handle,
+					   unsigned long mask,
+					   unsigned int align_order);
+
+extern void iommu_tbl_range_free(struct iommu_map_table *iommu,
+				 u64 dma_addr, unsigned long npages,
+				 unsigned long entry);
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index 58f74d2..60c22e6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -106,7 +106,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
-obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
+obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o iommu-common.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
diff --git a/lib/iommu-common.c b/lib/iommu-common.c
new file mode 100644
index 0000000..b99f1d7
--- /dev/null
+++ b/lib/iommu-common.c
@@ -0,0 +1,266 @@
+/*
+ * IOMMU mmap management and range allocation functions.
+ * Based almost entirely upon the powerpc iommu allocator.
+ */
+
+#include <linux/export.h>
+#include <linux/bitmap.h>
+#include <linux/bug.h>
+#include <linux/iommu-helper.h>
+#include <linux/iommu-common.h>
+#include <linux/dma-mapping.h>
+#include <linux/hash.h>
+
+unsigned long iommu_large_alloc = 15;
+
+static	DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
+
+static inline bool need_flush(struct iommu_map_table *iommu)
+{
+	return (iommu->lazy_flush != NULL &&
+		(iommu->flags & IOMMU_NEED_FLUSH) != 0);
+}
+
+static inline void set_flush(struct iommu_map_table *iommu)
+{
+	iommu->flags |= IOMMU_NEED_FLUSH;
+}
+
+static inline void clear_flush(struct iommu_map_table *iommu)
+{
+	iommu->flags &= ~IOMMU_NEED_FLUSH;
+}
+
+static void setup_iommu_pool_hash(void)
+{
+	unsigned int i;
+	static bool do_once;
+
+	if (do_once)
+		return;
+	do_once = true;
+	for_each_possible_cpu(i)
+		per_cpu(iommu_pool_hash, i) = hash_32(i, IOMMU_POOL_HASHBITS);
+}
+
+/*
+ * Initialize iommu_pool entries for the iommu_map_table. `num_entries'
+ * is the number of table entries. If `large_pool' is set to true,
+ * the top 1/4 of the table will be set aside for pool allocations
+ * of more than iommu_large_alloc pages.
+ */
+extern void iommu_tbl_pool_init(struct iommu_map_table *iommu,
+				unsigned long num_entries,
+				u32 table_shift,
+				void (*lazy_flush)(struct iommu_map_table *),
+				bool large_pool, u32 npools,
+				bool skip_span_boundary_check)
+{
+	unsigned int start, i;
+	struct iommu_pool *p = &(iommu->large_pool);
+
+	setup_iommu_pool_hash();
+	if (npools = 0)
+		iommu->nr_pools = IOMMU_NR_POOLS;
+	else
+		iommu->nr_pools = npools;
+	BUG_ON(npools > IOMMU_NR_POOLS);
+
+	iommu->table_shift = table_shift;
+	iommu->lazy_flush = lazy_flush;
+	start = 0;
+	if (skip_span_boundary_check)
+		iommu->flags |= IOMMU_NO_SPAN_BOUND;
+	if (large_pool)
+		iommu->flags |= IOMMU_HAS_LARGE_POOL;
+
+	if (!large_pool)
+		iommu->poolsize = num_entries/iommu->nr_pools;
+	else
+		iommu->poolsize = (num_entries * 3 / 4)/iommu->nr_pools;
+	for (i = 0; i < iommu->nr_pools; i++) {
+		spin_lock_init(&(iommu->pools[i].lock));
+		iommu->pools[i].start = start;
+		iommu->pools[i].hint = start;
+		start += iommu->poolsize; /* start for next pool */
+		iommu->pools[i].end = start - 1;
+	}
+	if (!large_pool)
+		return;
+	/* initialize large_pool */
+	spin_lock_init(&(p->lock));
+	p->start = start;
+	p->hint = p->start;
+	p->end = num_entries;
+}
+EXPORT_SYMBOL(iommu_tbl_pool_init);
+
+unsigned long iommu_tbl_range_alloc(struct device *dev,
+				struct iommu_map_table *iommu,
+				unsigned long npages,
+				unsigned long *handle,
+				unsigned long mask,
+				unsigned int align_order)
+{
+	unsigned int pool_hash = __this_cpu_read(iommu_pool_hash);
+	unsigned long n, end, start, limit, boundary_size;
+	struct iommu_pool *pool;
+	int pass = 0;
+	unsigned int pool_nr;
+	unsigned int npools = iommu->nr_pools;
+	unsigned long flags;
+	bool large_pool = ((iommu->flags & IOMMU_HAS_LARGE_POOL) != 0);
+	bool largealloc = (large_pool && npages > iommu_large_alloc);
+	unsigned long shift;
+	unsigned long align_mask = 0;
+
+	if (align_order > 0)
+		align_mask = 0xffffffffffffffffl >> (64 - align_order);
+
+	/* Sanity check */
+	if (unlikely(npages = 0)) {
+		WARN_ON_ONCE(1);
+		return DMA_ERROR_CODE;
+	}
+
+	if (largealloc) {
+		pool = &(iommu->large_pool);
+		pool_nr = 0; /* to keep compiler happy */
+	} else {
+		/* pick out pool_nr */
+		pool_nr =  pool_hash & (npools - 1);
+		pool = &(iommu->pools[pool_nr]);
+	}
+	spin_lock_irqsave(&pool->lock, flags);
+
+ again:
+	if (pass = 0 && handle && *handle &&
+	    (*handle >= pool->start) && (*handle < pool->end))
+		start = *handle;
+	else
+		start = pool->hint;
+
+	limit = pool->end;
+
+	/* The case below can happen if we have a small segment appended
+	 * to a large, or when the previous alloc was at the very end of
+	 * the available space. If so, go back to the beginning. If a
+	 * flush is needed, it will get done based on the return value
+	 * from iommu_area_alloc() below.
+	 */
+	if (start >= limit)
+		start = pool->start;
+	shift = iommu->table_map_base >> iommu->table_shift;
+	if (limit + shift > mask) {
+		limit = mask - shift + 1;
+		/* If we're constrained on address range, first try
+		 * at the masked hint to avoid O(n) search complexity,
+		 * but on second pass, start at 0 in pool 0.
+		 */
+		if ((start & mask) >= limit || pass > 0) {
+			spin_unlock(&(pool->lock));
+			pool = &(iommu->pools[0]);
+			spin_lock(&(pool->lock));
+			start = pool->start;
+		} else {
+			start &= mask;
+		}
+	}
+
+	if (dev)
+		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
+				      1 << iommu->table_shift);
+	else
+		boundary_size = ALIGN(1UL << 32, 1 << iommu->table_shift);
+
+	boundary_size = boundary_size >> iommu->table_shift;
+	/*
+	 * if the skip_span_boundary_check had been set during init, we set
+	 * things up so that iommu_is_span_boundary() merely checks if the
+	 * (index + npages) < num_tsb_entries
+	 */
+	if ((iommu->flags & IOMMU_NO_SPAN_BOUND) != 0) {
+		shift = 0;
+		boundary_size = iommu->poolsize * iommu->nr_pools;
+	}
+	n = iommu_area_alloc(iommu->map, limit, start, npages, shift,
+			     boundary_size, align_mask);
+	if (n = -1) {
+		if (likely(pass = 0)) {
+			/* First failure, rescan from the beginning.  */
+			pool->hint = pool->start;
+			set_flush(iommu);
+			pass++;
+			goto again;
+		} else if (!largealloc && pass <= iommu->nr_pools) {
+			spin_unlock(&(pool->lock));
+			pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
+			pool = &(iommu->pools[pool_nr]);
+			spin_lock(&(pool->lock));
+			pool->hint = pool->start;
+			set_flush(iommu);
+			pass++;
+			goto again;
+		} else {
+			/* give up */
+			n = DMA_ERROR_CODE;
+			goto bail;
+		}
+	}
+	if (n < pool->hint || need_flush(iommu)) {
+		clear_flush(iommu);
+		iommu->lazy_flush(iommu);
+	}
+
+	end = n + npages;
+	pool->hint = end;
+
+	/* Update handle for SG allocations */
+	if (handle)
+		*handle = end;
+bail:
+	spin_unlock_irqrestore(&(pool->lock), flags);
+
+	return n;
+}
+EXPORT_SYMBOL(iommu_tbl_range_alloc);
+
+static struct iommu_pool *get_pool(struct iommu_map_table *tbl,
+				   unsigned long entry)
+{
+	struct iommu_pool *p;
+	unsigned long largepool_start = tbl->large_pool.start;
+	bool large_pool = ((tbl->flags & IOMMU_HAS_LARGE_POOL) != 0);
+
+	/* The large pool is the last pool at the top of the table */
+	if (large_pool && entry >= largepool_start) {
+		p = &tbl->large_pool;
+	} else {
+		unsigned int pool_nr = entry / tbl->poolsize;
+
+		BUG_ON(pool_nr >= tbl->nr_pools);
+		p = &tbl->pools[pool_nr];
+	}
+	return p;
+}
+
+/* Caller supplies the index of the entry into the iommu map table
+ * itself when the mapping from dma_addr to the entry is not the
+ * default addr->entry mapping below.
+ */
+void iommu_tbl_range_free(struct iommu_map_table *iommu, u64 dma_addr,
+			  unsigned long npages, unsigned long entry)
+{
+	struct iommu_pool *pool;
+	unsigned long flags;
+	unsigned long shift = iommu->table_shift;
+
+	if (entry = DMA_ERROR_CODE) /* use default addr->entry mapping */
+		entry = (dma_addr - iommu->table_map_base) >> shift;
+	pool = get_pool(iommu, entry);
+
+	spin_lock_irqsave(&(pool->lock), flags);
+	bitmap_clear(iommu->map, entry, npages);
+	spin_unlock_irqrestore(&(pool->lock), flags);
+}
+EXPORT_SYMBOL(iommu_tbl_range_free);
-- 
1.7.1

