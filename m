From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 06:55:49 +0000
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to lib/Kconfig
Message-Id: <20180424065549.GA18468@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-12-hch@lst.de>
 <20180423235205.GH16141@n2100.armlinux.org.uk>
In-Reply-To: <20180423235205.GH16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 24, 2018 at 12:52:05AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 23, 2018 at 07:04:18PM +0200, Christoph Hellwig wrote:
> > This way we have one central definition of it, and user can select it as
> > needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> > indicate the architecture supports swiotlb at all, so that we can still
> > make the usage optional for a few architectures that want this feature
> > to be user selectable.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Hmm, this looks like we end up with NEED_SG_DMA_LENGTH=y on ARM by
> default, which probably isn't a good idea - ARM pre-dates the dma_length
> parameter in scatterlists, and I don't think all code is guaranteed to
> do the right thing if this is enabled.

We shouldn't end up with NEED_SG_DMA_LENGTH=y on ARM by default.
It is only select by ARM_DMA_USE_IOMMU before the patch, and it will
now also be selected by SWIOTLB, which for arm is never used or seleted
directly by anything but xen-swiotlb.

Then again looking at the series there shouldn't be any need to
even select NEED_SG_DMA_LENGTH for swiotlb, as we'll never merge segments,
so I'll fix that up.
