From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 04 Apr 2015 13:33:31 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <1428154411.20500.312.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150403182852.GI26158@oracle.com>
 <1428095210.20500.291.camel@kernel.crashing.org>
 <20150404112714.GA2117@oracle.com>
In-Reply-To: <20150404112714.GA2117@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Sat, 2015-04-04 at 07:27 -0400, Sowmini Varadhan wrote:
> One last question before I spin out v9.. the dma_mask code
> is a bit confusing to me, so I want to make sure... the code is 
> 
> > if (limit + tbl->it_offset > mask) {
> >               limit = mask - tbl->it_offset + 1;
> >               /* If we're constrained on address range, first try
> >                * at the masked hint to avoid O(n) search complexity,
> >                * but on second pass, start at 0 in pool 0.
> >                */
> >               if ((start & mask) >= limit || pass > 0) {
> >                       spin_unlock(&(pool->lock));
> >                       pool = &(tbl->pools[0]);
> >                       spin_lock(&(pool->lock));
> >                       start = pool->start;
> 
> So here I would need to mark need_flush to true, right?

Well, no but ...

So you aren't changing any pool hint, so you don't have to mark any pool
for flushing. The "n < hint" check will do the flush later on if needed
(the one I told you to add).

You only need to force a flush if you modify the hint.

*However*, you do an unlock, which means that if you have modified any
*other* pool's hint (ie, need_flush is true), you need to actually
perform a flush.

I think that business with flushing on unlock is becoming too ugly, I
would suggest you simplify things by moving need_flush to be part of the
pool structure (maybe a flag).

IE, when you modify a pool's hint, your mark it for flushing. 

When you allocate from a pool, you flush it at the end, just before you
return success, if either it was marked for flushing or n < hint (and
clear the mark of course).

That should cleanly factor all cases in a simpler & more readable code
path. The flush is done only when needed (an actual allocation happen on
a pool), you just "mark them dirty" when you change their hints, you
don't have to worry about the lock dropped case & pool hop'ing anymore.

Basically the logic looks like that:

	.../...

	n = iommu_area_alloc(...)
	if (n = -1) {
		if (pass = 0) {
			change pool hint
			pool->need_flush = true;
			pass++;
			goto again;
		} else if (!largealloc && .... ) {
			unlock/pool hop/lock
			// no need to flush anything here
			pool->hint = pool->start;
			pool->need_flush = true;
			etc...
		} else {
			n = DMA_ERROR_CODE;
			goto fail;
		}
	}
	end = n + pages;

	if (n < pool->hint || pool->need_flush) {
		pool->need_flush = false;
		iommu->lazy_flush(...);
	}
	pool->hint = end;

	.../...

Now this can be further simplified imho. For example that logic:

+       if (pass = 0 && handle && *handle &&
+           (*handle >= pool->start) && (*handle < pool->end))
+               start = *handle;
+       else
+               start = pool->hint;

Can move above the again: label. that way, you remove the pass test
and you no longer have to adjust pool->hint in the "if (likely(pass =
0))" failure case. Just adjust "start" and try again, which means you
also no longer need to set need_flush.

Additionally, when pool hop'ing, now you only need to adjust "start" as
well. By not resetting it, you also remove the need for marking it "need
flush". I would add to that, why not set "start" to the new pool's hint
instead of the new pool's start ? That will save some flushes, no ?

Anton, do you remember why you reset the hint when changing pool ? I
don't see that gaining us anything and it does make lazy flushing more
complex.

At that point, you have removed all setters of need_flush, that logic
can be entirely removed, or am I just too tired (it's past midnight) and
missing something entirely here ?

We only need the if (n < pool->hint) check to do the lazy flush at the
end, that's it.

Cheers,
Ben.


