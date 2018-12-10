From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 16:32:56 +0000
Subject: Re: [PATCH 6/6] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181210163256.GA27331@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-7-hch@lst.de>
 <20181208.205806.42785512174962944.davem@davemloft.net>
In-Reply-To: <20181208.205806.42785512174962944.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-parisc@vger.kernel.org, ezequiel@collabora.com, vgupta@synopsys.com, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, matwey@sai.msu.ru, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, laurent.pinchart@ideasonboard.com, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

Dave, can you pick the series up through the sparc tree?  I could also
merge it through the dma-mapping tree, but given that there is no
dependency on it the sparc tree seem like the better fit.
