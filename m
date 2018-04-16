From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 09:58:16 +0000
Subject: Re: [PATCH 06/12] dma-mapping: move the NEED_DMA_MAP_STATE config symbol to lib/Kconfig
Message-Id: <1ac5e633-5455-fcb6-6b3c-ea74d6691513@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-7-hch@lst.de>
In-Reply-To: <20180415145947.1248-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.  Note that we now also always select it when CONFIG_DMA_API_DEBUG
> is select, which fixes some incorrect checks in a few network drivers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

