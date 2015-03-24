From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Mar 2015 00:47:28 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427158048.4770.295.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323230811.GA21966@oracle.com>
In-Reply-To: <20150323230811.GA21966@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On Mon, 2015-03-23 at 19:08 -0400, Sowmini Varadhan wrote:

> > Sowmini, I see various options for the second choice. We could stick to
> > 1 pool, and basically do as before, ie, if we fail on the first pass of
> > alloc, it means we wrap around and do a flush, I don't think that will
> > cause a significant degradation from today, do you ? We might have an
> > occasional additional flush but I would expect it to be in the noise.
> 
> Isn't this essentially what I have in patch v5 here:
> http://www.spinics.net/lists/sparclinux/msg13534.html

Possibly, I haven't looked at it in details yet.

My point is that while we might flush a bit more often than the original
code, it should remain in the noise performance-wise and thus David
might rescind his objection, but we need to prove this with a
measurement.

> (the ops->reset is the flushall indirection, can be renamed if the
> latter is preferred)
> 
> > Dave, what's your feeling there ? Does anybody around still have some
> > HW that we can test with ?
> 
> I actually tested this on a V440 and a ultra45 (had a heck of a
> time finding these, since the owners keep them turned off because
> they are too noisy and consume too much power :-). Thus while I
> have no opinion, I would not shed any tears if we lost this extra
> perf-tweak in the interest of being earth-friendly  :-))
> 
> so testing it is not a problem, though I dont have any perf
> benchmarks for them either.

That's what we'll need unfortunately to confirm our "gut feeling". It
might be sufficient to add a flush counter and compare it between runs
if actual wall-clock benchmarks are too hard to do (especially if you
don't have things like very fast network cards at hand).

Number of flush / number of packets might be a sufficient metric, it
depends on whether it makes David happy :-)

> > Sowmini, I think we can still kill the ops and have a separate data
> > structure exclusively concerned by allocations by having the alloc
> > functions take the lazy flush function as an argument (which can be
> > NULL), I don't think we should bother with ops.
> 
> I dont quite follow what you have in mind? The caller would somehow
> have to specify a flush_all indirection for the legacy platforms 

Yes, pass a function pointer argument that can be NULL or just make it a
member of the iommu_allocator struct (or whatever you call it) passed to
the init function and that can be NULL. My point is we don't need a
separate "ops" structure.

> Also, you mention
> 
> > You must hold the lock until you do the flush, otherwise somebody
> > else might allocate the not-yet-flushed areas and try to use them...
> > kaboom. However if that's the only callback left, pass it as an
> > argument.
> 
> Passing  in a function pointer to the flushall to iommu_tbl_range_alloc
> would work, or we could pass it in as an arg to iommu_tbl_init,
> and stash it in the struct iommu_table.

Pass it to init and stash it in the table but don't call it
"iommu_table", let's use a name that conveys better the fact that this
is purely a DMA space allocator (to be embedded by the arch specific
iommu table). Something like iommu_alloc_zone or whatever you want to
call it. I keep finding new names whenever I think of it :-)

Cheers,
Ben.


