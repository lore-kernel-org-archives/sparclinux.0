From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 22 Mar 2015 19:22:52 +0000
Subject: [PATCH v5 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and lock
Message-Id: <42a2dc849f419466db3eff8368bb5e578a06a6ba.1426986386.git.sowmini.varadhan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1426986386.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1426986386.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, davem@davemloft.net

Investigation of multithreaded iperf experiments on an ethernet
interface show the iommu->lock as the hottest lock identified by
lockstat, with something of the order of  21M contentions out of
27M acquisitions, and an average wait time of 26 us for the lock.
This is not efficient. A more scalable design is to follow the ppc
model, where the iommu_table has multiple pools, each stretching
over a segment of the map, and with a separate lock for each pool.
This model allows for better parallelization of the iommu map search.

This patch adds the iommu range alloc/free function infrastructure.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
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

 include/linux/iommu-common.h |   55 +++++++++++
 lib/Makefile                 |    2 +-
 lib/iommu-common.c           |  219 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 275 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/iommu-common.h
 create mode 100644 lib/iommu-common.c

diff --git a/include/linux/iommu-common.h b/include/linux/iommu-common.h
new file mode 100644
index 0000000..50753cf
--- /dev/null
+++ b/include/linux/iommu-common.h
@@ -0,0 +1,55 @@
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
+struct iommu_table;
+
+struct iommu_tbl_ops {
+	void		(*reset)(struct iommu_table *);
+};
+
+struct iommu_table {
+	unsigned long		page_table_map_base;
+	unsigned long		page_table_shift;
+	unsigned long		nr_pools;
+	const struct iommu_tbl_ops  *iommu_tbl_ops;
+	unsigned long		poolsize;
+	struct iommu_pool	arena_pool[IOMMU_NR_POOLS];
+	u32			flags;
+#define	IOMMU_HAS_LARGE_POOL	0x00000001
+#define	IOMMU_NO_SPAN_BOUND	0x00000002
+	struct iommu_pool	large_pool;
+	unsigned long		*map;
+};
+
+extern void iommu_tbl_pool_init(struct iommu_table *iommu,
+				unsigned long num_entries,
+				u32 page_table_shift,
+				const struct iommu_tbl_ops *iommu_tbl_ops,
+				bool large_pool, u32 npools,
+				bool skip_span_boundary_check);
+
+extern unsigned long iommu_tbl_range_alloc(struct device *dev,
+					   struct iommu_table *iommu,
+					   unsigned long npages,
+					   unsigned long *handle,
+					   unsigned int pool_hash);
+
+extern void iommu_tbl_range_free(struct iommu_table *iommu,
+				 u64 dma_addr, unsigned long npages,
+				 unsigned long entry);
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index 3c3b30b..0ea2ac6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -102,7 +102,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
-obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
+obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o iommu-common.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
diff --git a/lib/iommu-common.c b/lib/iommu-common.c
new file mode 100644
index 0000000..f416191
--- /dev/null
+++ b/lib/iommu-common.c
@@ -0,0 +1,219 @@
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
+
+#define IOMMU_LARGE_ALLOC	15
+
+/*
+ * Initialize iommu_pool entries for the iommu_table. `num_entries'
+ * is the number of table entries. If `large_pool' is set to true,
+ * the top 1/4 of the table will be set aside for pool allocations
+ * of more than IOMMU_LARGE_ALLOC pages.
+ */
+extern void iommu_tbl_pool_init(struct iommu_table *iommu,
+				unsigned long num_entries,
+				u32 page_table_shift,
+				const struct iommu_tbl_ops *iommu_tbl_ops,
+				bool large_pool, u32 npools,
+				bool skip_span_boundary_check)
+{
+	unsigned int start, i;
+	struct iommu_pool *p = &(iommu->large_pool);
+
+	if (npools = 0)
+		iommu->nr_pools = IOMMU_NR_POOLS;
+	else
+		iommu->nr_pools = npools;
+	BUG_ON(npools > IOMMU_NR_POOLS);
+
+	iommu->page_table_shift = page_table_shift;
+	iommu->iommu_tbl_ops = iommu_tbl_ops;
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
+		spin_lock_init(&(iommu->arena_pool[i].lock));
+		iommu->arena_pool[i].start = start;
+		iommu->arena_pool[i].hint = start;
+		start += iommu->poolsize; /* start for next pool */
+		iommu->arena_pool[i].end = start - 1;
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
+	bool large_pool = ((iommu->flags & IOMMU_HAS_LARGE_POOL) != 0);
+	bool largealloc = (large_pool && npages > IOMMU_LARGE_ALLOC);
+	unsigned long shift;
+
+	/* Sanity check */
+	if (unlikely(npages = 0)) {
+		printk_ratelimited("npages = 0\n");
+		return DMA_ERROR_CODE;
+	}
+
+	if (largealloc) {
+		arena = &(iommu->large_pool);
+		spin_lock_irqsave(&arena->lock, flags);
+		pool_nr = 0; /* to keep compiler happy */
+	} else {
+		/* pick out pool_nr */
+		pool_nr =  pool_hash & (npools - 1);
+		arena = &(iommu->arena_pool[pool_nr]);
+
+		/* find first available unlocked pool */
+		while (!spin_trylock_irqsave(&(arena->lock), flags)) {
+			pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
+			arena = &(iommu->arena_pool[pool_nr]);
+		}
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
+		if (iommu->iommu_tbl_ops->reset != NULL)
+			iommu->iommu_tbl_ops->reset(iommu);
+	}
+
+	if (dev)
+		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
+				      1 << iommu->page_table_shift);
+	else
+		boundary_size = ALIGN(1UL << 32, 1 << iommu->page_table_shift);
+
+	shift = iommu->page_table_map_base >> iommu->page_table_shift;
+	boundary_size = boundary_size >> iommu->page_table_shift;
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
+			     boundary_size, 0);
+	if (n = -1) {
+		if (likely(pass = 0)) {
+			/* First failure, rescan from the beginning.  */
+			arena->hint = arena->start;
+			if (iommu->iommu_tbl_ops->reset != NULL)
+				iommu->iommu_tbl_ops->reset(iommu);
+			pass++;
+			goto again;
+		} else if (!largealloc && pass <= iommu->nr_pools) {
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
+EXPORT_SYMBOL(iommu_tbl_range_alloc);
+
+static struct iommu_pool *get_pool(struct iommu_table *tbl,
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
+		p = &tbl->arena_pool[pool_nr];
+	}
+	return p;
+}
+
+/* Caller supplies the index of the entry into the iommu map table
+ * itself when the mapping from dma_addr to the entry is not the
+ * default addr->entry mapping below.
+ */
+void iommu_tbl_range_free(struct iommu_table *iommu, u64 dma_addr,
+			  unsigned long npages, unsigned long entry)
+{
+	struct iommu_pool *pool;
+	unsigned long flags;
+	unsigned long shift = iommu->page_table_shift;
+
+	if (entry = DMA_ERROR_CODE) /* use default addr->entry mapping */
+		entry = (dma_addr - iommu->page_table_map_base) >> shift;
+	pool = get_pool(iommu, entry);
+
+	spin_lock_irqsave(&(pool->lock), flags);
+	bitmap_clear(iommu->map, entry, npages);
+	spin_unlock_irqrestore(&(pool->lock), flags);
+}
+EXPORT_SYMBOL(iommu_tbl_range_free);
-- 
1.7.1

