From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 09 Dec 2018 06:42:03 +0000
Subject: Re: [PATCH 2/4] sparc: factor the dma coherent mapping into helper
Message-Id: <20181209064203.GB28894@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181207141407.3154-3-hch@lst.de>
In-Reply-To: <20181207141407.3154-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Christoph.

On Fri, Dec 07, 2018 at 06:14:05AM -0800, Christoph Hellwig wrote:
> Factor the code to remap memory returned from the DMA coherent allocator
> into two helpers that can be shared by the IOMMU and direct mapping code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/kernel/ioport.c | 151 ++++++++++++++++---------------------
>  1 file changed, 67 insertions(+), 84 deletions(-)
> 
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index 4b2167a0ec0b..fd7a41c6d688 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -247,6 +247,53 @@ static void _sparc_free_io(struct resource *res)
>  	release_resource(res);
>  }
>  
> +static unsigned long sparc_dma_alloc_resource(struct device *dev, size_t len)
> +{
> +	struct resource *res;
> +
> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return 0;
> +	res->name = dev->of_node->name;
Rob Herrring would prefer us to use dev->of_node->full_name

> +
> +	if (allocate_resource(&_sparc_dvma, res, len, _sparc_dvma.start,
> +			_sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
Fix indent here. "_sparc_dvma.end," must be aligned below "&_sparc_dvma"

> +		printk("sbus_alloc_consistent: cannot occupy 0x%zx", len);
Use __func__ so we avoid hardcoding the (wrong) function name.

Other than these details then it looks good.
Acked-by: Sam Ravnborg <sam@ravnborg.org>
