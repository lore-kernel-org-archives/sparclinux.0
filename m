From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Oct 2015 19:12:54 +0000
Subject: Re: [PATCH] iommu-common: fix return type of iommu_tbl_range_alloc()
Message-Id: <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55FBD36C.5070301@arm.com>
 <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
In-Reply-To: <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Andre, J=C3=B6rg,

On Fri, Sep 18, 2015 at 11:09 AM, Andre Przywara <andre.przywara@arm.com> w=
rote:
> Though iommu_tbl_range_alloc() is only used by Sparc code, the
> function itself lives in lib/iommu-common.c and is thus included in
> other architecture's code as well.
> When compiled on a 32-bit architecture using 64-bit DMA addresses
> (ARM with LPAE), there is a compiler warning about a type mismatch
> between dma_addr_t and the return type of this function:
>
> In file included from /src/linux/include/linux/dma-mapping.h:86:0,
>                  from /src/linux/lib/iommu-common.c:11:
> /src/linux/lib/iommu-common.c: In function 'iommu_tbl_range_alloc':
> /src/linux/arch/arm/include/asm/dma-mapping.h:16:24: warning: large integ=
er implicitly truncated to unsigned type [-Woverflow]
>  #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
>                         ^
> /src/linux/lib/iommu-common.c:127:10: note: in expansion of macro
> 'DMA_ERROR_CODE'
>    return DMA_ERROR_CODE;

While I welcome a fix for this annoying warning on arm...

> --- a/lib/iommu-common.c
> +++ b/lib/iommu-common.c
> @@ -99,15 +99,16 @@ void iommu_tbl_pool_init(struct iommu_map_table *iomm=
u,
>  }
>  EXPORT_SYMBOL(iommu_tbl_pool_init);
>
> -unsigned long iommu_tbl_range_alloc(struct device *dev,
> -                               struct iommu_map_table *iommu,
> -                               unsigned long npages,
> -                               unsigned long *handle,
> -                               unsigned long mask,
> -                               unsigned int align_order)
> +dma_addr_t iommu_tbl_range_alloc(struct device *dev,
> +                                struct iommu_map_table *iommu,
> +                                unsigned long npages,
> +                                unsigned long *handle,
> +                                unsigned long mask,
> +                                unsigned int align_order)
>  {
>         unsigned int pool_hash =3D __this_cpu_read(iommu_hash_common);
> -       unsigned long n, end, start, limit, boundary_size;
> +       dma_addr_t n;
> +       unsigned long end, start, limit, boundary_size;

... this doesn't look like the right fix.

Apparently 64-bit parisc doesn't set ARCH_DMA_ADDR_T_64BIT, hence assigning
(64-bit) "unsigned long" to (32-bit) dma_addr_t will truncate the address.

Does this function really need to return DMA_ERROR_CODE in case of
failure?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
