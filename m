From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 12 Nov 2004 05:51:05 +0000
Subject: Re: hme broken on 2.6 hypersparc
Message-Id: <20041111215105.34cfe59c.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4192D294.8090305@mc.net>
In-Reply-To: <4192D294.8090305@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 11 Nov 2004 21:41:04 -0600
Bob Breuer <breuerr@mc.net> wrote:

> I think I have an idea on what is going wrong.
> 
> First off, I came across an old publication:
> http://www.usenix.org/publications/library/proceedings/sd96/full_papers/chu.txt
> In section 5.3, it states that cache aliasing can occur between
> DVMA and host memory addresses.  I'm not sure if that is physical
> or virtual host addresses, but either way cache aliasing can
> happen.  The cache aliasing is most prominent with the hypersparcs
> because of the virtually indexed, phyically tagged cache.
> 
> Before the iommu rewrite, dvma addresses were pre-allocated and
> mapped 1 to 1 with the kernel low memory.  Because of the 1:1
> mapping, no cache aliases will ever occur in low memory.
> 
> After the iommu rewrite, all dvma addresses are allocated on
> the fly.  I suspect that very little consideration was given
> to cache aliasing.

Perhaps.  But it could also be the IOMMU page tables and caching
causing some problem too.

I don't think the actual data mappings are causing aliasing
problems.  Even though the hypersparc is virtually indexed
it has physical tags.  And device DVMA data transfers make
physical address transactions appear on the bus, if the HyperSPARC
cache sees that this physical tag matches one of it's cache
lines it acts accordingly to keep the cacheline uptodate or
to flush it.

> I have found two easy ways in a low-memory only hypersparc
> machine to make the hme work: 1) revert my srmmu fix, and
> 2) revert the iommu back to the fixed 1:1 dvma mapping.
> Neither fix should be considered correct.

Hmmm, in many ways what you see mostly disagrees with my
(admittedly foggy) understanding of the hardware described
above :)

> The hme driver uses a consistent dma mapping for it's transmit
> descriptors.  If those descriptors are cacheable, they must
> not be aliased in the cache.  Fix 1 makes them uncached, and
> fix 2 eliminates the cache alias.
> 
> Looking on to the esp dma errors, I think there are only 2
> reasons why it was failing: A) the iotlb changes were not
> seen by the iommu, or B) a cache alias prevented the cpu
> from seeing the new data.  Doing a flush_cache_all happens
> to fix both possible problems.  Being unfamiliar with the
> iommu, it is hard to rule out A.  However, after trying to
> figure out the hme problem, I'm leaning toward B as the core
> problem here.
> 
> After all this, I think that if the dvma address allocation
> could be made to actively avoid cache aliasing, it might
> fix both problems.

Another issue here is how the cacheability bits are set
in both the srmmu page tables and the IOMMU page table
entries.

As we see in the ld_mmu_iommu() routine, the IOPTE_CACHE
bit is set for consistent mappings on HyperSPARC and Viking
w/MXCC.

When we setup a consistent DMA mapping, in iommu_map_dma_area(),
we flush the page out before setting up the DMA mapping to it
as follows:

			if (viking_mxcc_present)
				viking_mxcc_flush_page(page);
			else if (viking_flush)
				viking_flush_page(page);
			else
				__flush_page_to_ram(page);

Then we change the srmmu page table mapping over to
"dvma_prot" which has the cacheability bit set in
the same cases that we set IOPTE_CACHE for consistent
IOMMU mappings.

So in the HyperSPARC case the __flush_page_to_ram() is
superfluous.

And we know that before your bug fix the other day,
srmmu_modtype was not being set correctly at all so
these things above were not correctly occuring for
HyperSPARC.

So this should actually work just fine.

Just as an offhand idea, one thing you could play around
with is programming the HyperSPARC cache to not use
write-back mode.  The way you do that is to clear the
HYPERSPARC_WBENABLE bit in poke_hypersparc().

Let me know if you get some more clues or ideas.
It really is interesting that returning to straight
1:1 DVMA mappings makes the problems go away.
