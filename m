From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 02 Apr 2015 20:54:04 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <1428008044.20500.272.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
In-Reply-To: <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Tue, 2015-03-31 at 10:40 -0400, Sowmini Varadhan wrote:

> +	if (largealloc) {
> +		pool = &(iommu->large_pool);
> +		spin_lock_irqsave(&pool->lock, flags);
> +		pool_nr = 0; /* to keep compiler happy */
> +	} else {
> +		/* pick out pool_nr */
> +		pool_nr =  pool_hash & (npools - 1);
> +		pool = &(iommu->pools[pool_nr]);
> +		spin_lock_irqsave(&(pool->lock), flags);
> +	}

Move spin_lock_irqsave outside of if/else

> + again:
> +	if (pass = 0 && handle && *handle &&
> +	    (*handle >= pool->start) && (*handle < pool->end))
> +		start = *handle;
> +	else
> +		start = pool->hint;

Now this means "handle" might be < pool->hint, in that case you also
need a lazy flush. Or rather only if the resulting alloc is. My
suggestion originally was to test that after the area alloc. See further
down.

> +	limit = pool->end;
> +
> +	/* The case below can happen if we have a small segment appended
> +	 * to a large, or when the previous alloc was at the very end of
> +	 * the available space. If so, go back to the beginning and flush.
> +	 */
> +	if (start >= limit) {
> +		start = pool->start;
> +		if (!large_pool && iommu->lazy_flush != NULL)
> +			iommu->lazy_flush(iommu);

Add need_flush = false;

In fact, looking more closely, I see a another problems:

You never flush the large pool. You should either remove all
your large_pool checks since you treat it as a normal pool you
your code, and let it flush normally, or you should have an
unconditional flush somewhere in there for the large pool (or in
free()), either way. The current implementation you show me, afaik,
never calls lazy_flush on a large allocation.

Also, if you fix the problem I mentioned earlier about *handle < hint,
you also don't need the above flush, it will be handled further down
in the else case for the if (n = -1), see below

> +	}

I only just noticed too, you completely dropped the code to honor
the dma mask. Why that ? Some devices rely on this.

> +	if (dev)
> +		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> +				      1 << iommu->table_shift);
> +	else
> +		boundary_size = ALIGN(1UL << 32, 1 << iommu->table_shift);
> +
> +	shift = iommu->table_map_base >> iommu->table_shift;
> +	boundary_size = boundary_size >> iommu->table_shift;
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

You have completely dropped the alignment support. This will break
drivers. There are cases (especially with consistent allocations) where
the driver have alignment constraints on the address, those must be
preserved.

> +	if (n = -1) {
> +		if (likely(pass = 0)) {
> +			/* First failure, rescan from the beginning.  */
> +			pool->hint = pool->start;
> +			if (!large_pool && iommu->lazy_flush != NULL)
> +				need_flush = true;

Same question about the large pool check... I wouldn't bother with the
function pointer NULL check here either, only test it at the call site.

> +			pass++;
> +			goto again;
> +		} else if (!largealloc && pass <= iommu->nr_pools) {
> +	

Here, you might have moved the hint of the pool (case above), and then
hit this code path, no ? In that case, need_flush might be set, which
means you must flush before you unlock.

> 			spin_unlock(&(pool->lock));
> +
> 			pool_nr = (pool_nr + 1) & (iommu->nr_pools - 1);
> +			pool = &(iommu->pools[pool_nr]);
> +			spin_lock(&(pool->lock));
> +			pool->hint = pool->start;
> +			if (!large_pool && iommu->lazy_flush != NULL)
> +				need_flush = true;

I wouldn't bother with the test. This can't be large_alloc afaik and
the NULL check can be done at the call site.

> +			pass++;
> +			goto again;
> +		} else {
> +			/* give up */
> +			n = DMA_ERROR_CODE;
> +			goto bail;
> +		}
> +	}

Here, make this something like:

	} else if (end < pool->hint)
		need_flush = true;

To handle the case where you started your alloc below the hint without
having updated the hint yet, ie, a *handle < hint or a wrap around,
this will also handle the start >= limit case.

Basically you need to flush iff you are going to provide an alloc below
the current hint, or change the current hint to something lower than it
was.

> +	end = n + npages;
> +
> +	pool->hint = end;

Here you completely removed our "blocky" allocation scheme for small
pools. Now that being said, I'm not sure what it bought us to be honest
so I'm not necessarily upset about it. I'll ask around here see if
somebody can remember why we did that in the first place.

> +	/* Update handle for SG allocations */
> +	if (handle)
> +		*handle = end;
> +bail:
> +	if (need_flush)

Here I would put the test for lazy_flush being non-NULL

> +		iommu->lazy_flush(iommu);
> +	spin_unlock_irqrestore(&(pool->lock), flags);
> +
> +	return n;
> +}
> +EXPORT_SYMBOL(iommu_tbl_range_alloc);
> +
> +static struct iommu_pool *get_pool(struct iommu_map_table *tbl,
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
> +		p = &tbl->pools[pool_nr];
> +	}
> +	return p;
> +}
> +
> +/* Caller supplies the index of the entry into the iommu map table
> + * itself when the mapping from dma_addr to the entry is not the
> + * default addr->entry mapping below.
> + */
> +void iommu_tbl_range_free(struct iommu_map_table *iommu, u64 dma_addr,
> +			  unsigned long npages, unsigned long entry)
> +{
> +	struct iommu_pool *pool;
> +	unsigned long flags;
> +	unsigned long shift = iommu->table_shift;
> +
> +	if (entry = DMA_ERROR_CODE) /* use default addr->entry mapping */
> +		entry = (dma_addr - iommu->table_map_base) >> shift;
> +	pool = get_pool(iommu, entry);
> +
> +	spin_lock_irqsave(&(pool->lock), flags);
> +	bitmap_clear(iommu->map, entry, npages);
> +	spin_unlock_irqrestore(&(pool->lock), flags);
> +}
> +EXPORT_SYMBOL(iommu_tbl_range_free);


