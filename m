From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 25 Apr 2018 01:43:43 +0000
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-Id: <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de>
 <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com> <20180424191640.GA32495@lst.de>
In-Reply-To: <20180424191640.GA32495@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2018-04-25 3:16 GMT+08:00 Christoph Hellwig <hch@lst.de>:
> Hi Greentime,
>
> thanks for testing the patch!
>
> It looks like nds32 doesn't have a buildbot yet, so this code didn't
> even get syntax checkin, sorry.
>
> Below is the incremental fixes based on this thread.
>
> Can you check if my tree works if you just revert the
> "nds32: use generic dma_noncoherent_ops" commit?
>
> diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
> index 688f1a03dee6..48018275e7f4 100644
> --- a/arch/nds32/kernel/dma.c
> +++ b/arch/nds32/kernel/dma.c
> @@ -330,7 +330,7 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
>         void *addr = kmap_atomic_pfn(PHYS_PFN(paddr));
>         unsigned long start = (unsigned long)addr;
>
> -       switch (direction) {
> +       switch (dir) {
>         case DMA_FROM_DEVICE:
>                 break;
>         case DMA_TO_DEVICE:
> @@ -350,12 +350,12 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>         void *addr = kmap_atomic_pfn(PHYS_PFN(paddr));
>         unsigned long start = (unsigned long)addr;
>
> -       switch (direction) {
> +       switch (dir) {
>         case DMA_TO_DEVICE:
>                 break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
> -               cpu_dma_inval_range(start, end);
> +               cpu_dma_inval_range(start, start + size);
>                 break;
>         default:
>                 BUG();

Hi Crhistoph,

The ftmac100 works if I revert this commit.

commit de46b9ba5298aafc47284735a4f21baa8e4ed4b7
Author: Greentime Hu <greentime@andestech.com>
Date:   Wed Apr 25 09:33:51 2018 +0800

    Revert "nds32: use generic dma_noncoherent_ops"

    This reverts commit 0489ce952072e7542456e0d962437062916ce0df.
