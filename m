From: David Miller <davem@davemloft.net>
Date: Sun, 09 Dec 2018 04:58:06 +0000
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181208.205806.42785512174962944.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-7-hch@lst.de>
In-Reply-To: <20181208174115.16237-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@lst.de
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat,  8 Dec 2018 09:41:15 -0800

> There are enough common defintions that a single header seems nicer.
> 
> Also drop the pointless <linux/dma-mapping.h> include.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>
