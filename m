From: David Miller <davem@davemloft.net>
Date: Fri, 03 Apr 2020 01:12:17 +0000
Subject: Re: [PATCH] sparc32: use per-device dma_ops
Message-Id: <20200402.181217.1913032342905680599.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 23 Mar 2020 09:43:42 +0100

> sparc32 is the last platform making dynamic decisions in
> get_arch_dma_ops based on the bus passed in.  Instead set the
> iommu dma_ops at iommu probing and propagate them in
> of_propagate_archdata, falling back to the NULL ops for the
> direct mapping in the Leon or PCI case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied, thanks.
