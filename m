From: Christoph Hellwig <hch@lst.de>
Date: Thu, 03 May 2018 03:56:43 +0000
Subject: Re: [PATCH 11/13] mips,unicore32: swiotlb doesn't need sg->dma_length
Message-Id: <20180503035643.GA9781@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de> <20180502222017.GC20766@jamesdev>
In-Reply-To: <20180502222017.GC20766@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, May 02, 2018 at 11:20:18PM +0100, James Hogan wrote:
> On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> > Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> > swiotlb.  swiotlb itself never merges segements and doesn't accesses the
> > dma_length field directly, so drop the dependency.
> 
> Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
> suggest arch ports should enable it for IOMMUs?

swiotlb isn't really an iommu..  That being said iommus don't have to
merge segments either if they don't want to, and we have various
implementations that don't.  The whole dma api documentation needs
a major overhaul, including merging the various files and dropping a lot
of dead wood.  It has been on my todo list for a while, with an inner
hope that someone else would do it before me.
