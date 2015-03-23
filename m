From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 23 Mar 2015 22:36:42 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427150202.4770.248.camel@kernel.crashing.org>
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

Our allocator more/less allocates bottom-up from the last successful
allocation and tries again if it fails, so in essence, it is not so
different from what you have done. What we need to do is:

 - One pool only

 - Whenever the allocation is before the previous hint, do a flush, that
should only happen if a wrap around occurred or in some cases if the
device DMA mask forced it. I think we always update the hint whenever we
successfully allocate from the small pools.

 - Deal with the largealloc case. That's the contentious issue, see
below.

So if we ignore the largealloc split we have, we can pretty much recover
David's behaviour using our allocator. There might be the odd flush here
or there that we do and he didn't due to differences in implementation
details, but I doubt those are statistically relevant, as long as we
don't flush on every network packet, we should be good.

The largealloc issue is a different can of worms. We can try adding an
option to disable the largealloc business completely (instead of hard
wiring the "15", make that a variable and define that 0 means no
largealloc pool).

Or we can decide that large allocs are rare (typically
pci_alloc_consistent, ie, driver init time), and thus always flush on
them (or rather on free of a large chunk). David, what's your take
there ? I have a feeling that should work fine without a noticeable
performance issue...

I would also keep a "dirty" flag set on any free and cleared on any
flush to avoid more spurrious flushes, but here too the benefit might be
in the noise.

Cheers,
Ben.

