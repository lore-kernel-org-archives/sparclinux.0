From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Mon, 19 Nov 2018 18:53:58 +0000
Subject: Re: [mm PATCH v5 4/7] mm: Initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections
Message-Id: <5815470723f5e97bc26bad42da219598e2775837.camel@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: 
	<154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
	 <154145278583.30046.4918131143612801028.stgit@ahduyck-desk1.jf.intel.com>
	 <20181110010238.jnabddtfpr5kjhdz@xakep.localdomain>
In-Reply-To: <20181110010238.jnabddtfpr5kjhdz@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, davem@davemloft.net, pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, yi.z.zhang@linux.intel.com

On Fri, 2018-11-09 at 20:02 -0500, Pavel Tatashin wrote:
> On 18-11-05 13:19:45, Alexander Duyck wrote:
> >  	}
> > -	first_init_pfn = max(zone->zone_start_pfn, first_init_pfn);
> > +
> > +	/* If the zone is empty somebody else may have cleared out the zone */
> > +	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> > +						 first_init_pfn)) {
> > +		pgdat_resize_unlock(pgdat, &flags);
> > +		pgdat_init_report_one_done();
> > +		return 0;
> 
> It would make more sense to add goto to the end of this function and report
> that in Node X had 0 pages initialized. Otherwise, it will be confusing
> why some nodes are not initialized during boot. It is simply because
> they do not have deferred pages left to be initialized.

This part makes sense and will be implemented for v6.

> 
> > +	}
> >  
> >  	/*
> > -	 * Initialize and free pages. We do it in two loops: first we initialize
> > -	 * struct page, than free to buddy allocator, because while we are
> > -	 * freeing pages we can access pages that are ahead (computing buddy
> > -	 * page in __free_one_page()).
> > +	 * Initialize and free pages in MAX_ORDER sized increments so
> > +	 * that we can avoid introducing any issues with the buddy
> > +	 * allocator.
> >  	 */
> > -	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
> > -		spfn = max_t(unsigned long, first_init_pfn, spfn);
> > -		nr_pages += deferred_init_pages(zone, spfn, epfn);
> > -	}
> > -	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
> > -		spfn = max_t(unsigned long, first_init_pfn, spfn);
> > -		deferred_free_pages(spfn, epfn);
> > -	}
> > +	while (spfn < epfn)
> > +		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> > +
> >  	pgdat_resize_unlock(pgdat, &flags);
> >  
> >  	/* Sanity check that the next zone really is unpopulated */
> > @@ -1602,9 +1689,9 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
> >  {
> 
> How about order = max(order, max_order)?

I'm not sure what you are getting at here? The "order" variable passed
is only really used to get the nr_pages_needed, and that value is
rounded up to PAGES_PER_SECTION which should always be equal to or
greater than MAX_ORDER pages.

If order is greater than MAX_ORDER we would want to process some number
of MAX_ORDER sized blocks until we get to the size specified by order.
If we process it all as one large block it will perform worse as we
risk pushing page structs out of the cache.

> >  	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
> 
> 
> > -	first_init_pfn = max(zone->zone_start_pfn, first_deferred_pfn);
> > -
> > -	if (first_init_pfn >= pgdat_end_pfn(pgdat)) {
> > +	/* If the zone is empty somebody else may have cleared out the zone */
> > +	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> > +						 first_deferred_pfn)) {
> >  		pgdat_resize_unlock(pgdat, &flags);
> > -		return false;
> > +		return true;
> 
> I am OK to change to true here, please also set
> pgdat->first_deferred_pfn to ULONG_MAX to indicate that there are no
> more deferred pages in this node.

Done for v6 of the patch set.

> 
> Overall, I like this patch, makes things a lot easier, assuming the
> above is addressed:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Thank you,
> Pasha
