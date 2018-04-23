From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 23 Apr 2018 20:09:30 +0000
Subject: Re: [PATCH 10/12] arm: don't build swiotlb by default
Message-Id: <20180423200930.GB5215@char.us.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-11-hch@lst.de>
In-Reply-To: <20180423170419.20330-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 23, 2018 at 07:04:17PM +0200, Christoph Hellwig wrote:
> swiotlb is only used as a library of helper for xen-swiotlb if Xen support
> is enabled on arm, so don't build it by default.
> 

CCing Stefano
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aa1c187d756d..90b81a3a28a7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1774,7 +1774,7 @@ config SECCOMP
>  	  defined by each seccomp mode.
>  
>  config SWIOTLB
> -	def_bool y
> +	bool
>  
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
> @@ -1807,6 +1807,7 @@ config XEN
>  	depends on MMU
>  	select ARCH_DMA_ADDR_T_64BIT
>  	select ARM_PSCI
> +	select SWIOTLB
>  	select SWIOTLB_XEN
>  	select PARAVIRT
>  	help
> -- 
> 2.17.0
> 
