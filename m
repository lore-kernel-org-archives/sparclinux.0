From: Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Jul 2017 07:21:18 +0000
Subject: Re: [sparc-next] SPARC64: Fix sun4v DMA panic
Message-Id: <20170712072118.GB5739@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1499808887-31483-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1499808887-31483-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tushar Dave <tushar.n.dave@oracle.com>
Cc: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, egtvedt@samfundet.no, dan.carpenter@oracle.com, krzk@kernel.org, bart.vanassche@sandisk.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, mroos@linux.ee

On Tue, Jul 11, 2017 at 02:34:47PM -0700, Tushar Dave wrote:
> 64bit DMA only supported on sun4v equipped with ATU IOMMU HW.
> 'Commit b02c2b0bfd7ae ("sparc: remove arch specific dma_supported
> implementations")' introduced a code that incorrectly allow
> dma_supported() to succeed for 64bit dma mask even if system doesn't
> have ATU IOMMU. This results into panic.
> 
> Fix it.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
>  arch/sparc/kernel/pci_sun4v.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> index 24f21c7..f10e2f7 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -673,12 +673,14 @@ static void dma_4v_unmap_sg(struct device *dev, struct scatterlist *sglist,
>  static int dma_4v_supported(struct device *dev, u64 device_mask)
>  {
>  	struct iommu *iommu = dev->archdata.iommu;
> -	u64 dma_addr_mask;
> +	u64 dma_addr_mask = iommu->dma_addr_mask;
>  
> -	if (device_mask > DMA_BIT_MASK(32) && iommu->atu)
> -		dma_addr_mask = iommu->atu->dma_addr_mask;
> -	else
> -		dma_addr_mask = iommu->dma_addr_mask;
> +	if (device_mask > DMA_BIT_MASK(32)) {
> +		if (iommu->atu)
> +			dma_addr_mask = iommu->atu->dma_addr_mask;
> +		else
> +			return 0;
> +	}

This would be more readable as:

	if (device_mask > DMA_BIT_MASK(32)) {
		if (!iommu->atu)
			return 0;
		dma_addr_mask = iommu->atu->dma_addr_mask;
	}

But except for that it looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
