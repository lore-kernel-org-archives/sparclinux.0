From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 06:22:36 +0000
Subject: Re: [PATCH 11/12] swiotlb: move the SWIOTLB config symbol to lib/Kconfig
Message-Id: <1c4007b5-c0d4-7077-b2c1-767c6abbf79f@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-12-hch@lst.de>
In-Reply-To: <20180415145947.1248-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.  Note that we also add a second ARCH_HAS_SWIOTLB symbol to
> indicate the architecture supports swiotlb at all, so that we can still
> make the usage optional for a few architectures that want this feature
> to be user selectable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


snip

> +
> +config SWIOTLB
> +	bool "SWIOTLB support"
> +	default ARCH_HAS_SWIOTLB
> +	select DMA_DIRECT_OPS
> +	select NEED_DMA_MAP_STATE
> +	select NEED_SG_DMA_LENGTH
> +	---help---
> +	  Support for IO bounce buffering for systems without an IOMMU.
> +	  This allows us to DMA to the full physical address space on
> +	  platforms where the size of a physical address is larger
> +	  than the bus address.  If unsure, say Y.
> +
>  config CHECK_SIGNATURE
>  	bool

Pulling DMA_DIRECT_OPS config option by default when SWIOTLB is enabled
makes sense. This option was also needed to be enabled separately even
to use swiotlb_dma_ops.

