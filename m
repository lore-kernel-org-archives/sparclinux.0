From: tndave <tushar.n.dave@oracle.com>
Date: Sat, 08 Oct 2016 22:49:32 +0000
Subject: Re: [linux-review:Tushar-Dave/sparc-Enable-sun4v-hypervisor-PCI-IOMMU-v2-APIs-and-ATU/20161007-13142
Message-Id: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 10/08/2016 12:30 PM, tndave wrote:
>
>
> On 10/08/2016 04:04 AM, kbuild test robot wrote:
>> tree:   https://github.com/0day-ci/linux
>> Tushar-Dave/sparc-Enable-sun4v-hypervisor-PCI-IOMMU-v2-APIs-and-ATU/20161007-131420
>>
>> head:   c8f58dfeb3376eb4fa4c2f3cb0618bb2cd8796c3
>> commit: c8f58dfeb3376eb4fa4c2f3cb0618bb2cd8796c3 [6/6] sparc64: Enable
>> 64-bit DMA
>> config: sparc64-allmodconfig (attached as .config)
>> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget
>> https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout c8f58dfeb3376eb4fa4c2f3cb0618bb2cd8796c3
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=sparc64
>>
>> All errors (new ones prefixed by >>):
> Thanks for the report.
>
> In SPARC, dma_addr_t has always been of type u32.
> However with ATU patches 64bit dma is enabled therefore
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y and dma_addr_t is of type u64.
>
> I am looking into this.
I have patches ready that resolve the warning/errors reported by kbuild
test robot. I will be sending v2 RFC for ATU series.

Thanks.
-Tushar
>
>
> -Tushar
>>
>>    drivers/net/ethernet/sun/sunqe.c: In function 'qec_ether_init':
>>>> drivers/net/ethernet/sun/sunqe.c:883:8: error: passing argument 3 of
>>>> 'dma_alloc_coherent' from incompatible pointer type
>>>> [-Werror=incompatible-pointer-types]
>>            &qe->qblock_dvma, GFP_ATOMIC);
>>            ^
>>    In file included from include/linux/skbuff.h:34:0,
>>                     from include/linux/if_ether.h:23,
>>                     from include/uapi/linux/ethtool.h:18,
>>                     from include/linux/ethtool.h:17,
>>                     from include/linux/netdevice.h:42,
>>                     from drivers/net/ethernet/sun/sunqe.c:22:
>>    include/linux/dma-mapping.h:445:21: note: expected 'dma_addr_t *
>> {aka long long unsigned int *}' but argument is of type '__u32 * {aka
>> unsigned int *}'
>>     static inline void *dma_alloc_coherent(struct device *dev, size_t
>> size,
>>                         ^~~~~~~~~~~~~~~~~~
>>    drivers/net/ethernet/sun/sunqe.c:885:7: error: passing argument 3
>> of 'dma_alloc_coherent' from incompatible pointer type
>> [-Werror=incompatible-pointer-types]
>>           &qe->buffers_dvma, GFP_ATOMIC);
>>           ^
>>    In file included from include/linux/skbuff.h:34:0,
>>                     from include/linux/if_ether.h:23,
>>                     from include/uapi/linux/ethtool.h:18,
>>                     from include/linux/ethtool.h:17,
>>                     from include/linux/netdevice.h:42,
>>                     from drivers/net/ethernet/sun/sunqe.c:22:
>>    include/linux/dma-mapping.h:445:21: note: expected 'dma_addr_t *
>> {aka long long unsigned int *}' but argument is of type '__u32 * {aka
>> unsigned int *}'
>>     static inline void *dma_alloc_coherent(struct device *dev, size_t
>> size,
>>                         ^~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>> --
>>    drivers/net/ethernet/sun/sunbmac.c: In function 'bigmac_ether_init':
>>>> drivers/net/ethernet/sun/sunbmac.c:1166:10: error: passing argument
>>>> 3 of 'dma_alloc_coherent' from incompatible pointer type
>>>> [-Werror=incompatible-pointer-types]
>>              &bp->bblock_dvma, GFP_ATOMIC);
>>              ^
>>    In file included from include/linux/skbuff.h:34:0,
>>                     from include/linux/if_ether.h:23,
>>                     from include/uapi/linux/ethtool.h:18,
>>                     from include/linux/ethtool.h:17,
>>                     from drivers/net/ethernet/sun/sunbmac.c:18:
>>    include/linux/dma-mapping.h:445:21: note: expected 'dma_addr_t *
>> {aka long long unsigned int *}' but argument is of type '__u32 * {aka
>> unsigned int *}'
>>     static inline void *dma_alloc_coherent(struct device *dev, size_t
>> size,
>>                         ^~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>> --
>>    drivers/scsi/qlogicpti.c: In function 'qpti_map_queues':
>>>> drivers/scsi/qlogicpti.c:813:9: error: passing argument 3 of
>>>> 'dma_alloc_coherent' from incompatible pointer type
>>>> [-Werror=incompatible-pointer-types]
>>             &qpti->res_dvma, GFP_ATOMIC);
>>             ^
>>    In file included from drivers/scsi/qlogicpti.c:28:0:
>>    include/linux/dma-mapping.h:445:21: note: expected 'dma_addr_t *
>> {aka long long unsigned int *}' but argument is of type '__u32 * {aka
>> unsigned int *}'
>>     static inline void *dma_alloc_coherent(struct device *dev, size_t
>> size,
>>                         ^~~~~~~~~~~~~~~~~~
>>    drivers/scsi/qlogicpti.c:822:9: error: passing argument 3 of
>> 'dma_alloc_coherent' from incompatible pointer type
>> [-Werror=incompatible-pointer-types]
>>             &qpti->req_dvma, GFP_ATOMIC);
>>             ^
>>    In file included from drivers/scsi/qlogicpti.c:28:0:
>>    include/linux/dma-mapping.h:445:21: note: expected 'dma_addr_t *
>> {aka long long unsigned int *}' but argument is of type '__u32 * {aka
>> unsigned int *}'
>>     static inline void *dma_alloc_coherent(struct device *dev, size_t
>> size,
>>                         ^~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>> --
>>    sound/sparc/dbri.c: In function 'snd_dbri_create':
>>>> sound/sparc/dbri.c:2538:6: error: passing argument 3 of
>>>> 'dma_zalloc_coherent' from incompatible pointer type
>>>> [-Werror=incompatible-pointer-types]
>>          &dbri->dma_dvma, GFP_ATOMIC);
>>          ^
>>    In file included from sound/sparc/dbri.c:60:0:
>>    include/linux/dma-mapping.h:608:21: note: expected 'dma_addr_t *
>> {aka long long unsigned int *}' but argument is of type 'u32 * {aka
>> unsigned int *}'
>>     static inline void *dma_zalloc_coherent(struct device *dev, size_t
>> size,
>>                         ^~~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>>
>> vim +/dma_alloc_coherent +883 drivers/net/ethernet/sun/sunqe.c
>>
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  867      res
>> = -ENOMEM;
>> 8e912b33 drivers/net/sunqe.c David S. Miller 2008-08-27  868
>> qe->qcregs = of_ioremap(&op->resource[0], 0,
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16
>> 869                  CREG_REG_SIZE, "QEC Channel Registers");
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  870      if
>> (!qe->qcregs) {
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  871
>> printk(KERN_ERR "qe: Cannot map channel registers.\n");
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  872
>> goto fail;
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  873      }
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  874
>> 8e912b33 drivers/net/sunqe.c David S. Miller 2008-08-27  875
>> qe->mregs = of_ioremap(&op->resource[1], 0,
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16
>> 876                     MREGS_REG_SIZE, "QE MACE Registers");
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  877      if
>> (!qe->mregs) {
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  878
>> printk(KERN_ERR "qe: Cannot map MACE registers.\n");
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  879
>> goto fail;
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  880      }
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  881
>> 8e912b33 drivers/net/sunqe.c David S. Miller 2008-08-27  882
>> qe->qe_block = dma_alloc_coherent(&op->dev, PAGE_SIZE,
>> 738f2b7b drivers/net/sunqe.c David S. Miller 2008-08-27
>> @883                        &qe->qblock_dvma, GFP_ATOMIC);
>> 8e912b33 drivers/net/sunqe.c David S. Miller 2008-08-27  884
>> qe->buffers = dma_alloc_coherent(&op->dev, sizeof(struct sunqe_buffers),
>> 738f2b7b drivers/net/sunqe.c David S. Miller 2008-08-27
>> 885                       &qe->buffers_dvma, GFP_ATOMIC);
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  886      if
>> (qe->qe_block = NULL || qe->qblock_dvma = 0 ||
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  887
>> qe->buffers = NULL || qe->buffers_dvma = 0)
>> ecba38ab drivers/net/sunqe.c David S. Miller 2006-06-23  888
>> goto fail;
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  889
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  890      /*
>> Stop this QE. */
>> ^1da177e drivers/net/sunqe.c Linus Torvalds  2005-04-16  891
>> qe_stop(qe);
>>
>> :::::: The code at line 883 was first introduced by commit
>> :::::: 738f2b7b813913e651f39387d007dd961755dee2 sparc: Convert all
>> SBUS drivers to dma_*() interfaces.
>>
>> :::::: TO: David S. Miller <davem@davemloft.net>
>> :::::: CC: David S. Miller <davem@davemloft.net>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology
>> Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel
>> Corporation
>>
