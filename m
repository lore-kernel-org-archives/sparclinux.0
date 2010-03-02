From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Mar 2010 12:03:25 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <201003021303.26064.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100226.043536.63730567.davem@davemloft.net> <201003011229.51399.arnd@arndb.de> <20100302123326H.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100302123326H.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 March 2010, FUJITA Tomonori wrote:
> If we go with such approach, then we could use something like the
> following. There are only two kinds of scatterlist definitions (use
> dma_length or not) so we can cover all the architectures.
> 
> diff --git a/include/asm-generic/scatterlist.h b/include/asm-generic/scatterlist.h
> index 8b94544..1bf620d 100644
> --- a/include/asm-generic/scatterlist.h
> +++ b/include/asm-generic/scatterlist.h
> @@ -11,7 +11,9 @@ struct scatterlist {
>         unsigned int    offset;
>         unsigned int    length;
>         dma_addr_t      dma_address;
> +#ifdef CONFIG_NEED_SG_DMA_LENGTH
>         unsigned int    dma_length;
> +#endif
>  };

Yes, that sounds good. If the only reason to need dma_length is virtual merging,
a clearer (from the Kconfig perspective, not from the implementation) name 
might be CONFIG_HAVE_IOMMU_VMERGE, similar to the CONFIG_IOMMU_VMERGE option
on PPC64 that determines the default for the virtual merging runtime option.

	Arnd
