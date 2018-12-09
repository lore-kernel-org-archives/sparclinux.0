From: David Miller <davem@davemloft.net>
Date: Sun, 09 Dec 2018 04:57:47 +0000
Subject: Re: [PATCH 3/6] sparc: remove the sparc32_dma_ops indirection
Message-Id: <20181208.205747.2007860478185366370.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-4-hch@lst.de>
In-Reply-To: <20181208174115.16237-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:12 -0800

> There is no good reason to have a double indirection for the sparc32
> dma ops, so remove the sparc32_dma_ops and define separate dma_map_ops
> instance for the different IOMMU types.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
