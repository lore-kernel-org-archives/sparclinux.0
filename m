From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Thu, 15 Nov 2018 17:53:58 +0000
Subject: Re: [PATCH] arch/sparc: Use kzalloc_node
Message-Id: <CAJr6mf0GLRQiu-FBjQfWmvJsAPQLsY8XH_aacgHUmxz=yts-Wg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
In-Reply-To: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, khandual@linux.vnet.ibm.com
Cc: Souptick Joarder <jrdr.linux@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Brajeswar Ghosh <brajeswar.linux@gmail.com>

On Sat, Nov 3, 2018 at 10:54 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced kmalloc_node + memset with kzalloc_node
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/sparc/kernel/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
> index 40d008b..05eb016 100644
> --- a/arch/sparc/kernel/iommu.c
> +++ b/arch/sparc/kernel/iommu.c
> @@ -108,10 +108,9 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
>         /* Allocate and initialize the free area map.  */
>         sz = num_tsb_entries / 8;
>         sz = (sz + 7UL) & ~7UL;
> -       iommu->tbl.map = kmalloc_node(sz, GFP_KERNEL, numa_node);
> +       iommu->tbl.map = kzalloc_node(sz, GFP_KERNEL, numa_node);
>         if (!iommu->tbl.map)
>                 return -ENOMEM;
> -       memset(iommu->tbl.map, 0, sz);
>
>         iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
>                             (tlb_type != hypervisor ? iommu_flushall : NULL),
> --
> 2.7.4
>
