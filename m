From: David Miller <davem@davemloft.net>
Date: Sun, 09 Dec 2018 04:58:55 +0000
Subject: Re: [PATCH 08/10] sparc64/pci_sun4v: implement DMA_ATTR_NON_CONSISTENT
Message-Id: <20181208.205855.1922834726608485490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-9-hch@lst.de>
In-Reply-To: <20181208173702.15158-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:37:00 -0800

> Just allocate the memory and use map_page to map the memory.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David S. Miller <davem@davemloft.net>
