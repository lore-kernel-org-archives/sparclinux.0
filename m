From: David Miller <davem@davemloft.net>
Date: Mon, 10 Dec 2018 18:10:39 +0000
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181210.101039.1882227517259366533.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-7-hch@lst.de>
 <20181208.205806.42785512174962944.davem@davemloft.net>
 <20181210163256.GA27331@lst.de>
In-Reply-To: <20181210163256.GA27331@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 17:32:56 +0100

> Dave, can you pick the series up through the sparc tree?  I could also
> merge it through the dma-mapping tree, but given that there is no
> dependency on it the sparc tree seem like the better fit.

I thought that some of this is a prerequisite for the DMA mapping
work and overall consolidation you are doing.  So I kinda assumed
you wanted to merge it via your tree.

I anticipate no conflicts at all, even until the next merge window,
so it could very easily go through your tree.

Let me know if you still want me to merge this.

Thanks.
