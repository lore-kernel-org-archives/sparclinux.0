From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 02 Apr 2015 21:43:43 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150402214343.GA15680@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
In-Reply-To: <1428008044.20500.272.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On (04/03/15 07:54), Benjamin Herrenschmidt wrote:
> > +	limit = pool->end;
> > +
> > +	/* The case below can happen if we have a small segment appended
> > +	 * to a large, or when the previous alloc was at the very end of
> > +	 * the available space. If so, go back to the beginning and flush.
> > +	 */
> > +	if (start >= limit) {
> > +		start = pool->start;
> > +		if (!large_pool && iommu->lazy_flush != NULL)
> > +			iommu->lazy_flush(iommu);
> 
> Add need_flush = false;

A few clarifications, while I parse the rest of your comments:

Not sure I follow- need_flush is initialized to true at the start of the function?

> I only just noticed too, you completely dropped the code to honor
> the dma mask. Why that ? Some devices rely on this.

so that's an interesting question: the existing iommu_range_alloc() in
arch/sparc/kernel/iommu.c does not use the mask at all. I based most of
the code  on this (except for the lock fragmentation part). 
I dont know if this is arch specific.

> 
> > +	if (dev)
> > +		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> > +				      1 << iommu->table_shift);
> > +	else
> > +		boundary_size = ALIGN(1UL << 32, 1 << iommu->table_shift);
> > +
> > +	shift = iommu->table_map_base >> iommu->table_shift;
> > +	boundary_size = boundary_size >> iommu->table_shift;
> > +	/*
> > +	 * if the skip_span_boundary_check had been set during init, we set
> > +	 * things up so that iommu_is_span_boundary() merely checks if the
> > +	 * (index + npages) < num_tsb_entries
> > +	 */
> > +	if ((iommu->flags & IOMMU_NO_SPAN_BOUND) != 0) {
> > +		shift = 0;
> > +		boundary_size = iommu->poolsize * iommu->nr_pools;
> > +	}
> > +	n = iommu_area_alloc(iommu->map, limit, start, npages, shift,
> > +			     boundary_size, 0);
> 
> You have completely dropped the alignment support. This will break
> drivers. There are cases (especially with consistent allocations) where

Again, not sure I follow? are you referring to the IOMMU_NO_SPAN_BOUND case?
That's very specific to LDC (sparc ldoms virtualization infra). The default
is to not have IOMMU_NO_SPAN_BOUND set. 
For the rest of the drivers, the code that sets up boundary_size aligns things
in the same way as the ppc code.


> the driver have alignment constraints on the address, those must be
> preserved.
> 

--Sowmini
