From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 23 Mar 2015 22:21:05 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427149265.4770.238.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
In-Reply-To: <20150323.150508.149509757161802782.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon, 2015-03-23 at 15:05 -0400, David Miller wrote:
> From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Date: Mon, 23 Mar 2015 12:54:06 -0400
> 
> > If it was only an optimization (i.e., removing it would not break
> > any functionality), and if this was done for older hardware,
> > and *if* we believe that the direction of most architectures is to 
> > follow the sun4v/HV model, then, given that the sun4u code only uses 1 
> > arena pool anyway, one thought that I have for refactoring this
> > is the following:
> 
> Why add performance regressions to old machines who already are
> suffering too much from all the bloat we are constantly adding to the
> kernel?

So we have two choices here that I can see:

 - Keep that old platform use the old/simpler allocator

 - Try to regain the bulk of that benefit with the new one

Sowmini, I see various options for the second choice. We could stick to
1 pool, and basically do as before, ie, if we fail on the first pass of
alloc, it means we wrap around and do a flush, I don't think that will
cause a significant degradation from today, do you ? We might have an
occasional additional flush but I would expect it to be in the noise.

Another option would be trickier, is to keep an additional bitmap
of "stale" entries. When an entry is freed, instead of freeing it
in the main bitmap, set a bit in the "stale" bit map. If we fail to
allocate, then flush, xor off the main bitmap bits using the stale
bitmap, and try again.

However, the second approach means that as the main bitmap gets full, we
will start allocating from remote pools, so it partially defeats the
pool system, unless we do everything locally per-pool (ie flush when the
pool is full before we fallback to another pool), in which case we go
back to flushing more often than we used to. But here too, the
difference might end up in the noise, we still flush order of magnitude
less than once per translation update.

Dave, what's your feeling there ? Does anybody around still have some
HW that we can test with ?

Sowmini, I think we can still kill the ops and have a separate data
structure exclusively concerned by allocations by having the alloc
functions take the lazy flush function as an argument (which can be
NULL), I don't think we should bother with ops.

Cheers,
Ben.


