From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Thu, 15 Oct 2015 22:52:19 +0000
Subject: Re: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
Message-Id: <20151015225219.GD30179@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
 <20151012210651.GB26702@linux.vnet.ibm.com>
 <20151014153900.GC30179@linux.vnet.ibm.com>
 <20151014154251.GA7271@infradead.org>
In-Reply-To: <20151014154251.GA7271@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 14.10.2015 [08:42:51 -0700], Christoph Hellwig wrote:
> Hi Nishanth,
> 
> sorry for the late reply.
> 
> > > On Power, since it's technically variable, we'd need a function. So are
> > > you suggesting define'ing it to a function just on Power and leaving it
> > > a constant elsewhere?
> > > 
> > > I noticed that sparc has a IOMMU_PAGE_SHIFT already, fwiw.
> > 
> > Sorry, I should have been more specific -- I'm ready to spin out a v3,
> > with a sparc-specific function.
> > 
> > Are you ok with leaving it a function for now (the only caller is in
> > NVMe obviously).
> 
> 
> I guess we do indeed need a function then.  I'll take a look at your
> patch, but as long you found a way to avoid adding too much boilerplate
> code it should be fine.

Ok, so I've got the moved function (include/linux/dma-mapping.h instead
of dma-mapping-common.h) ready to go, which should only involve changing
the first patch in the series. But I'm really mystified by what to do
for sparc, which defines IOMMU_PAGE_SHIFT and IO_PAGE_SHIFT in
arch/sparc/kernel/iommu_common.h.

1) Which constant reflects the value we mean for this function on sparc?
I assume it should be IOMMU_PAGE_SHIFT, but they are the same value and
I want to make sure I get the semantics right.

2) Where would I put sparc's definition of dma_get_page_shift()? Should
it be in a asm/dma-mapping.h? Should we move some of the constants from
arch/sparc/kernel/iommu_common.h to
arch/sparc/include/asm/iommu_common.h and then #include that in
asm/dma-mapping.h?

Dave M., any opinions/insights? Essentially, this helper function
assists the NVMe driver in determining what page size it should use to
satisfy both the device and IOMMU's requirements. Maybe I misunderstand
the constants on sparc and PAGE_SHIFT is fine there too?

-Nish

