From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 30 Mar 2015 03:24:04 +0000
Subject: Re: [PATCH v7 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <1427685844.20500.66.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <b9dbeef3a3ae463a5198b6d34eb446ae50966a66.1427295804.git.sowmini.varadhan@oracle.com>
In-Reply-To: <b9dbeef3a3ae463a5198b6d34eb446ae50966a66.1427295804.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, 2015-03-25 at 13:34 -0400, Sowmini Varadhan wrote:
> Investigation of multithreaded iperf experiments on an ethernet
> interface show the iommu->lock as the hottest lock identified by
> lockstat, with something of the order of  21M contentions out of
> 27M acquisitions, and an average wait time of 26 us for the lock.
> This is not efficient. A more scalable design is to follow the ppc
> model, where the iommu_table has multiple pools, each stretching
> over a segment of the map, and with a separate lock for each pool.
> This model allows for better parallelization of the iommu map search.
> 
 .../...
> 
> diff --git a/include/linux/iommu-common.h b/include/linux/iommu-common.h
> new file mode 100644
> index 0000000..197111b
> --- /dev/null
> +++ b/include/linux/iommu-common.h
> @@ -0,0 +1,48 @@
> +#ifndef _LINUX_IOMMU_COMMON_H
> +#define _LINUX_IOMMU_COMMON_H
> +
> +#include <linux/spinlock_types.h>
> +#include <linux/device.h>
> +#include <asm/page.h>
> +
> +#define IOMMU_POOL_HASHBITS     4
> +#define IOMMU_NR_POOLS          (1 << IOMMU_POOL_HASHBITS)

I don't like those macros. You changed the value from what we had on
powerpc. It could be that the new values are as good for us but I'd
like to do a bit differently. Can you make the bits a variable ? Or at
least an arch-provided macro which we can change later if needed ?

> +struct iommu_pool {
> +	unsigned long	start;
> +	unsigned long	end;
> +	unsigned long	hint;
> +	spinlock_t	lock;
> +};
> +
> +struct iommu_table {

Let's make it clear that this is for allocation of DMA space only, it
would thus make my life easier when adapting powerpc to use a different
names, something like "struct iommu_area" works for me, or "iommu
alloc_region" .. whatever you fancy the most.

> +	unsigned long		page_table_map_base;
> +	unsigned long		page_table_shift;

Minor nit but I'm not fan of the naming here, maybe just use
entry_shift ? I don't like too long identifiers :) Same for
base, could just be "base" or "table_base".

> +	unsigned long		nr_pools;
> +	void			(*flush_all)(struct iommu_table *);

Call this "lazy_flush", document that it is optional and when it is
called.

> +	unsigned long		poolsize;
> +	struct iommu_pool	arena_pool[IOMMU_NR_POOLS];

Why adding the 'arena' prefix ? What was wrong with "pools" in the
powerpc imlementation ?

> +	u32			flags;
> +#define	IOMMU_HAS_LARGE_POOL	0x00000001
> +#define	IOMMU_NO_SPAN_BOUND	0x00000002
> +	struct iommu_pool	large_pool;
> +	unsigned long		*map;
> +};
> +
> +extern void iommu_tbl_pool_init(struct iommu_table *iommu,
> +				unsigned long num_entries,
> +				u32 page_table_shift,
> +				void (*flush_all)(struct iommu_table *),
> +				bool large_pool, u32 npools,
> +				bool skip_span_boundary_check);
> +
> +extern unsigned long iommu_tbl_range_alloc(struct device *dev,
> +					   struct iommu_table *iommu,
> +					   unsigned long npages,
> +					   unsigned long *handle);
> +
> +extern void iommu_tbl_range_free(struct iommu_table *iommu,
> +				 u64 dma_addr, unsigned long npages,
> +				 unsigned long entry);
> +
> +#endif
> diff --git a/lib/Makefile b/lib/Makefile
> index 3c3b30b..0ea2ac6 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -102,7 +102,7 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
>  obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
>  
>  obj-$(CONFIG_SWIOTLB) += swiotlb.o
> -obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
> +obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o iommu-common.o
>  obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
>  obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
>  obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
> diff --git a/lib/iommu-common.c b/lib/iommu-common.c
> new file mode 100644
> index 0000000..bb7e706
> --- /dev/null
> +++ b/lib/iommu-common.c
> @@ -0,0 +1,235 @@
> +/*
> + * IOMMU mmap management and range allocation functions.
> + * Based almost entirely upon the powerpc iommu allocator.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/bitmap.h>
> +#include <linux/bug.h>
> +#include <linux/iommu-helper.h>
> +#include <linux/iommu-common.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/hash.h>
> +
> +#define IOMMU_LARGE_ALLOC	15

Make that a variable, here too, the arch might want to tweak it.

I think 15 is actually not a good value for powerpc with 4k iommu pages
and 64k PAGE_SIZE, we should make the above some kind of factor of
PAGE_SHIFT - iommu_page_shift.

> +static	DEFINE_PER_CPU(unsigned int, iommu_pool_hash);
> +
> +static void setup_iommu_pool_hash(void)
> +{
> +	unsigned int i;
> +	static bool do_once;
> +
> +	if (do_once)
> +		return;
> +	do_once = true;
> +	for_each_possible_cpu(i)
> +		per_cpu(iommu_pool_hash, i) = hash_32(i, IOMMU_POOL_HASHBITS);
> +}
> +
> +/*
> + * Initialize iommu_pool entries for the iommu_table. `num_entries'
> + * is the number of table entries. If `large_pool' is set to true,
> + * the top 1/4 of the table will be set aside for pool allocations
> + * of more than IOMMU_LARGE_ALLOC pages.
> + */
> +extern void iommu_tbl_pool_init(struct iommu_table *iommu,
> +				unsigned long num_entries,
> +				u32 page_table_shift,
> +				void (*flush_all)(struct iommu_table *),
> +				bool large_pool, u32 npools,
> +				bool skip_span_boundary_check)
> +{
> +	unsigned int start, i;
> +	struct iommu_pool *p = &(iommu->large_pool);
> +
> +	setup_iommu_pool_hash();
> +	if (npools = 0)
> +		iommu->nr_pools = IOMMU_NR_POOLS;
> +	else
> +		iommu->nr_pools = npools;
> +	BUG_ON(npools > IOMMU_NR_POOLS);
> +
> +	iommu->page_table_shift = page_table_shift;
> +	iommu->flush_all = flush_all;
> +	start = 0;
> +	if (skip_span_boundary_check)
> +		iommu->flags |= IOMMU_NO_SPAN_BOUND;
> +	if (large_pool)
> +		iommu->flags |= IOMMU_HAS_LARGE_POOL;
> +
> +	if (!large_pool)
> +		iommu->poolsize = num_entries/iommu->nr_pools;
> +	else
> +		iommu->poolsize = (num_entries * 3 / 4)/iommu->nr_pools;
> +	for (i = 0; i < iommu->nr_pools; i++) {
> +		spin_lock_init(&(iommu->arena_pool[i].lock));
> +		iommu->arena_pool[i].start = start;
> +		iommu->arena_pool[i].hint = start;
> +		start += iommu->poolsize; /* start for next pool */
> +		iommu->arena_pool[i].end = start - 1;
> +	}
> +	if (!large_pool)
> +		return;
> +	/* initialize large_pool */
> +	spin_lock_init(&(p->lock));
> +	p->start = start;
> +	p->hint = p->start;
> +	p->end = num_entries;
> +}
> +EXPORT_SYMBOL(iommu_tbl_pool_init);
> +
> +unsigned long iommu_tbl_range_alloc(struct device *dev,
> +				struct iommu_table *iommu,
> +				unsigned long npages,
> +				unsigned long *handle)
> +{
> +	unsigned int pool_hash = __this_cpu_read(iommu_pool_hash);
> +	unsigned long n, end, start, limit, boundary_size;
> +	struct iommu_pool *arena;
> +	int pass = 0;
> +	unsigned int pool_nr;
> +	unsigned int npools = iommu->nr_pools;
> +	unsigned long flags;
> +	bool large_pool = ((iommu->flags & IOMMU_HAS_LARGE_POOL) != 0);
> +	bool largealloc = (large_pool && npages > IOMMU_LARGE_ALLOC);
> +	unsigned long shift;
> +
> +	/* Sanity check */
> +	if (unlikely(npages = 0)) {
> +		printk_ratelimited("npages = 0\n");

You removed the WARN_ON here which had the nice property of giving you a
backtrace which points to the offender. The above message alone is
useless.

> +		return DMA_ERROR_CODE;
> +	}
> +
> +	if (largealloc) {
> +		arena = &(iommu->large_pool);

Nit but here too, why change "pool" to "arena" ?

> +		spin_lock_irqsave(&arena->lock, flags);
> +		pool_nr = 0; /* to keep compiler happy */
> +	} else {
> +		/* pick out pool_nr */
> +		pool_nr =  pool_hash & (npools - 1);
> +		arena = &(iommu->arena_pool[pool_nr]);
> +
> +		/* find first available unlocked pool */
> +		while (!spin_trylock_irqsave(&(arena->lock), flags)) {
> +			pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
> +			arena = &(iommu->arena_pool[pool_nr]);
> +		}
> +	}

I am not certain about the "first unlocked pool"... We take the lock for
a fairly short amount of time, I have the gut feeling that the cache
line bouncing introduced by looking at a different pool may well cost
more than waiting a bit longer. Did do some measurements of that
optimisation ?

> + again:
> +	if (pass = 0 && handle && *handle &&
> +	    (*handle >= arena->start) && (*handle < arena->end))
> +		start = *handle;
> +	else
> +		start = arena->hint;
> +
> +	limit = arena->end;
> +
> +	/* The case below can happen if we have a small segment appended
> +	 * to a large, or when the previous alloc was at the very end of
> +	 * the available space. If so, go back to the beginning and flush.
> +	 */
> +	if (start >= limit) {
> +		start = arena->start;
> +		if (!large_pool && iommu->flush_all != NULL)
> +			iommu->flush_all(iommu);
> +	}

I am not too fan of the 2 copies of that logic. On the other hand you
may have no choice since we do need to do the flush when we wrap even
if we end up failing or pool hopping.

> +
> +	if (dev)
> +		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> +				      1 << iommu->page_table_shift);
> +	else
> +		boundary_size = ALIGN(1UL << 32, 1 << iommu->page_table_shift);
> +
> +	shift = iommu->page_table_map_base >> iommu->page_table_shift;
> +	boundary_size = boundary_size >> iommu->page_table_shift;
> +	/*
> +	 * if the skip_span_boundary_check had been set during init, we set
> +	 * things up so that iommu_is_span_boundary() merely checks if the
> +	 * (index + npages) < num_tsb_entries
> +	 */
> +	if ((iommu->flags & IOMMU_NO_SPAN_BOUND) != 0) {
> +		shift = 0;
> +		boundary_size = iommu->poolsize * iommu->nr_pools;
> +	}
> +	n = iommu_area_alloc(iommu->map, limit, start, npages, shift,
> +			     boundary_size, 0);
> +	if (n = -1) {
> +		if (likely(pass = 0)) {
> +			/* First failure, rescan from the beginning.  */
> +			arena->hint = arena->start;
> +			if (!large_pool && iommu->flush_all != NULL)
> +				iommu->flush_all(iommu);
> +			pass++;
> +			goto again;
> +		} else if (!largealloc && pass <= iommu->nr_pools) {
> +			spin_unlock(&(arena->lock));
> +			pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
> +			arena = &(iommu->arena_pool[pool_nr]);
> +			while (!spin_trylock(&(arena->lock))) {
> +				pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
> +				arena = &(iommu->arena_pool[pool_nr]);
> +			}
> +			arena->hint = arena->start;

Here you just "wrapped" that new pool, so you need to do a flush. I'm
thinking you should probably use a local "need_flush" bool, which
applies to the current pool. You would do a test & call flush before
releasing a pool lock (so right above this or on function exit). To make
things simpler, the below becomes:

> +			pass++;
> +			goto again;
> +		} else {
> +			/* give up */
> +			spin_unlock_irqrestore(&(arena->lock), flags);
> +			return DMA_ERROR_CODE;
> +		}
> +	}

		else {
			n = DMA_ERROR_CODE;
			goto bail;
		}

So you have only one exit point.

> +
> +	end = n + npages;
> +
> +	arena->hint = end;
> +
> +	/* Update handle for SG allocations */
> +	if (handle)
> +		*handle = end;
> +	spin_unlock_irqrestore(&(arena->lock), flags);
> +
> +	return n;
> +}
> +EXPORT_SYMBOL(iommu_tbl_range_alloc);
> +
> +static struct iommu_pool *get_pool(struct iommu_table *tbl,
> +				   unsigned long entry)
> +{
> +	struct iommu_pool *p;
> +	unsigned long largepool_start = tbl->large_pool.start;
> +	bool large_pool = ((tbl->flags & IOMMU_HAS_LARGE_POOL) != 0);
> +
> +	/* The large pool is the last pool at the top of the table */
> +	if (large_pool && entry >= largepool_start) {
> +		p = &tbl->large_pool;
> +	} else {
> +		unsigned int pool_nr = entry / tbl->poolsize;
> +
> +		BUG_ON(pool_nr >= tbl->nr_pools);
> +		p = &tbl->arena_pool[pool_nr];
> +	}
> +	return p;
> +}
> +
> +/* Caller supplies the index of the entry into the iommu map table
> + * itself when the mapping from dma_addr to the entry is not the
> + * default addr->entry mapping below.
> + */
> +void iommu_tbl_range_free(struct iommu_table *iommu, u64 dma_addr,
> +			  unsigned long npages, unsigned long entry)
> +{
> +	struct iommu_pool *pool;
> +	unsigned long flags;
> +	unsigned long shift = iommu->page_table_shift;
> +
> +	if (entry = DMA_ERROR_CODE) /* use default addr->entry mapping */
> +		entry = (dma_addr - iommu->page_table_map_base) >> shift;
> +	pool = get_pool(iommu, entry);
> +
> +	spin_lock_irqsave(&(pool->lock), flags);
> +	bitmap_clear(iommu->map, entry, npages);
> +	spin_unlock_irqrestore(&(pool->lock), flags);
> +}
> +EXPORT_SYMBOL(iommu_tbl_range_free);


