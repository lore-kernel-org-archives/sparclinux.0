From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 30 Mar 2015 10:55:43 +0000
Subject: Re: [PATCH v7 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <1427712943.20500.77.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <b9dbeef3a3ae463a5198b6d34eb446ae50966a66.1427295804.git.sowmini.varadhan@oracle.com>
 <1427685844.20500.66.camel@kernel.crashing.org>
 <20150330103824.GA26127@oracle.com>
In-Reply-To: <20150330103824.GA26127@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Mon, 2015-03-30 at 06:38 -0400, Sowmini Varadhan wrote:
> On (03/30/15 14:24), Benjamin Herrenschmidt wrote:
> > > +
> > > +#define IOMMU_POOL_HASHBITS     4
> > > +#define IOMMU_NR_POOLS          (1 << IOMMU_POOL_HASHBITS)
> > 
> > I don't like those macros. You changed the value from what we had on
> > powerpc. It could be that the new values are as good for us but I'd
> > like to do a bit differently. Can you make the bits a variable ? Or at
> > least an arch-provided macro which we can change later if needed ?
> 
> Actuallly, this are just the upper bound (16) on the number of pools.
> 
> The actual number is selected by the value passed to the 
> iommu_tbl_range_init(), and is not hard-coded (as was the case with
> the power-pc code).
> 
> Thus powerpc can continue to use 4 pools without any loss of 
> generality.

Right, but it affects the way we hash... not a huge deal though.

>    :
> > Let's make it clear that this is for allocation of DMA space only, it
> > would thus make my life easier when adapting powerpc to use a different
> > names, something like "struct iommu_area" works for me, or "iommu
> > alloc_region" .. whatever you fancy the most.
>   :
> > Why adding the 'arena' prefix ? What was wrong with "pools" in the
> > powerpc imlementation ?
> 
> for the same reason you want to re-baptize iommu_table above- at
> the time, I was doing it to minimize conflicts with existing usage.
> But I can rename everything if you like. 

But in that case it doesn't make much sense and makes the names longer.
Those are just "pools", it's sufficient.

> > > +#define IOMMU_LARGE_ALLOC	15
> > 
> > Make that a variable, here too, the arch might want to tweak it.
> > 
> > I think 15 is actually not a good value for powerpc with 4k iommu pages
> > and 64k PAGE_SIZE, we should make the above some kind of factor of
> > PAGE_SHIFT - iommu_page_shift.
> 
> Ok.
> 
> > > +	/* Sanity check */
> > > +	if (unlikely(npages = 0)) {
> > > +		printk_ratelimited("npages = 0\n");
> > 
> > You removed the WARN_ON here which had the nice property of giving you a
> > backtrace which points to the offender. The above message alone is
> > useless.
> 
> yes, the original code was generating checkpatch warnings and errors.
> That's why I removed it. 

Put it back please, and ignore checkpatch, it's become an annoyance more
than anything else.

Note that nowadays, you can probably use WARN_ON_ONCE(npages = 0); in
place of the whole construct.

> > I am not certain about the "first unlocked pool"... We take the lock for
> > a fairly short amount of time, I have the gut feeling that the cache
> > line bouncing introduced by looking at a different pool may well cost
> > more than waiting a bit longer. Did do some measurements of that
> > optimisation ?
> 
> if you are really only taking it for a short amount of time, then
> the trylock should just succeed, so there is no cache line bouncing.

No that's not my point. The lock is only taken for a short time but
might still collide, the bouncing in that case will probably (at least
that's my feeling) hurt more than help.

However, I have another concern with your construct. Essentially you
spin looking for an unlocked pool without a cpu_relax. Now it's unlikely
but you *can* end up eating cycles, which on a high SMT like POWER8
might mean slowing down the actual owner of the pool lock. 

> But yes, I did instrument it with iperf, and there was lock contention
> on the spinlock, which was eliminted by the trylock. 

What is iperf ? What does that mean "there was lock contention" ? IE,
was the overall performance improved or not ? Removing contention by
trading it for cache line bouncing will not necessarily help. I'm not
saying this is a bad optimisation but it makes the code messy and I
think deserves some solid numbers demonstrating its worth.

> I'll fix the rest of the variable naming etc nits and send out
> a new version later today.

There was also an actual bug in the case where you hop'ed to a new pool
and forgot the flush.

Cheers,
Ben.


