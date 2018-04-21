From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 21 Apr 2018 21:42:47 +0000
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
Message-Id: <1524346967.3335.9.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de>
         <20180420080313.18796-23-hch@lst.de>
In-Reply-To: <20180420080313.18796-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 10:03 +0200, Christoph Hellwig wrote:
> diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
> index 8d3a7b80ac42..4e87c35c22b7 100644
> --- a/arch/parisc/kernel/setup.c
> +++ b/arch/parisc/kernel/setup.c
> @@ -97,14 +97,12 @@ void __init dma_ops_init(void)
>  		panic(	"PA-RISC Linux currently only supports
> machines that conform to\n"
>  			"the PA-RISC 1.1 or 2.0 architecture
> specification.\n");
>  
> -	case pcxs:
> -	case pcxt:
> -		hppa_dma_ops = &pcx_dma_ops;
> -		break;
>  	case pcxl2:
>  		pa7300lc_init();
>  	case pcxl: /* falls through */
> -		hppa_dma_ops = &pcxl_dma_ops;
> +	case pcxs:
> +	case pcxt:
> +		hppa_dma_ops = &dma_noncoherent_ops;
>  		break;
>  	default:
>  		break;

Well, this is wrong: you just made every 32 bit parisc system
unnecessarily use non-coherent.  We actually only have a small small
set of non-coherent systems.  The pxcs and pcxt systems (which are
about 99% of the user base) can use coherent dma ops.  The problem
seems to be in your new world you only have one dma_noncoherent_ops
pointer ... we definitely need two on parisc, so whether
arch_dma_cache_sync is present or not needs to be dynamic not config
defined.

James

