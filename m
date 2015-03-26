From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Mar 2015 00:49:13 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427330953.6468.101.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323.214453.255192641139042325.davem@davemloft.net>
 <1427162890.4770.307.camel@kernel.crashing.org>
 <20150323.221508.1178754097347144400.davem@davemloft.net>
 <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
In-Reply-To: <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cascardo@linux.vnet.ibm.com
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On Wed, 2015-03-25 at 21:43 -0300, cascardo@linux.vnet.ibm.com wrote:
> On Mon, Mar 23, 2015 at 10:15:08PM -0400, David Miller wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Tue, 24 Mar 2015 13:08:10 +1100
> > 
> > > For the large pool, we don't keep a hint so we don't know it's
> > > wrapped, in fact we purposefully don't use a hint to limit
> > > fragmentation on it, but then, it should be used rarely enough that
> > > flushing always is, I suspect, a good option.
> > 
> > I can't think of any use case where the largepool would be hit a lot
> > at all.
> 
> Well, until recently, IOMMU_PAGE_SIZE was 4KiB on Power, so every time a
> driver mapped a whole 64KiB page, it would hit the largepool.

Yes but I was talking of sparc here ...

> I have been suspicious for some time that after Anton's work on the
> pools, the large mappings optimization would throw away the benefit of
> using the 4 pools, since some drivers would always hit the largepool.

Right, I was thinking we should change the test for large pool from > 15
to > (PAGE_SHIFT * n) where n is TBD by experimentation.

> Of course, drivers that map entire pages, when not buggy, are optimized
> already to avoid calling dma_map all the time. I worked on that for
> mlx4_en, and I would expect that its receive side would always hit the
> largepool.
> 
> So, I decided to experiment and count the number of times that
> largealloc is true versus false.
> 
> On the transmit side, or when using ICMP, I didn't notice many large
> allocations with qlge or cxgb4.
> 
> However, when using large TCP send/recv (I used uperf with 64KB
> writes/reads), I noticed that on the transmit side, largealloc is not
> used, but on the receive side, cxgb4 almost only uses largealloc, while
> qlge seems to have a 1/1 usage or largealloc/non-largealloc mappings.
> When turning GRO off, that ratio is closer to 1/10, meaning there is
> still some fair use of largealloc in that scenario.

What are the sizes involved ? Always just 64K ? Or more ? Maybe just
changing 15 to 16 in the test would be sufficient ? We should make the
threshole a parameter set at init time so archs/platforms can adjust it.

> I confess my experiments are not complete. I would like to test a couple
> of other drivers as well, including mlx4_en and bnx2x, and test with
> small packet sizes. I suspected that MTU size could make a difference,
> but in the case of ICMP, with MTU 9000 and payload of 8000 bytes, I
> didn't notice any significant hit of largepool with either qlge or
> cxgb4.
> 
> Also, we need to keep in mind that IOMMU_PAGE_SIZE is now dynamic in the
> latest code, with plans on using 64KiB in some situations, Alexey or Ben
> should have more details.

We still mostly use 4K afaik... We will use 64K in some KVM setups and I
do plan to switch to 64K under some circumstances when we can but we
have some limits imposed by PAPR under hypervisors here.

> But I believe that on the receive side, all drivers should map entire
> pages, using some allocation strategy similar to mlx4_en, in order to
> avoid DMA mapping all the time. Some believe that is bad for latency,
> and prefer to call something like skb_alloc for every package received,
> but I haven't seen any hard numbers, and I don't know why we couldn't
> make such an allocator as good as using something like the SLAB/SLUB
> allocator. Maybe there is a jitter problem, since the allocator has to
> go out and get some new pages and map them, once in a while. But I don't
> see why this would not be a problem with SLAB/SLUB as well. Calling
> dma_map is even worse with the current implementation. It's just that
> some architectures do no work at all when dma_map/unmap is called.
> 
> Hope that helps consider the best strategy for the DMA space allocation
> as of now.

In any case, I don't think Sparc has the same issue. At this point
that's all I care about, once we adapt powerpc to use the new code, we
can revisit that problem on our side.

Cheers,
Ben.

> Regards.
> Cascardo.


