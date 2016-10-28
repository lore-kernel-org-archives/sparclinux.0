From: tndave <tushar.n.dave@oracle.com>
Date: Fri, 28 Oct 2016 16:09:54 +0000
Subject: Re: [PATCH v2 5/6] sparc64: Enable sun4v dma ops to use IOMMU v2 APIs
Message-Id: <0e1910d2-da1a-22cc-08f1-86366fde8f70@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477614212-13466-1-git-send-email-tushar.n.dave@oracle.com>
 <1477614212-13466-6-git-send-email-tushar.n.dave@oracle.com>
 <1477615287.1961.4.camel@perches.com>
In-Reply-To: <1477615287.1961.4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, jroedel@suse.de, egtvedt@samfundet.no, robin.murphy@arm.com, m.szyprowski@samsung.com, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/27/2016 05:41 PM, Joe Perches wrote:
> On Thu, 2016-10-27 at 17:23 -0700, Tushar Dave wrote:
>> Add Hypervisor IOMMU v2 APIs pci_iotsb_map(), pci_iotsb_demap() and
>> enable sun4v dma ops to use IOMMU v2 API for all PCIe devices with
>> 64bit DMA mask.
>
> trivia:
>
>> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> []
>> @@ -72,34 +72,55 @@ static inline void iommu_batch_start(struct device *dev, unsigned long prot, uns
>>  }
>>
>>  /* Interrupts must be disabled.  */
>> -static long iommu_batch_flush(struct iommu_batch *p)
>> +static long iommu_batch_flush(struct iommu_batch *p, u64 mask)
>>  {
>>
> []
>> +			if (unlikely(num < 0)) {
>> +				pr_err_ratelimited("iommu_batch_flush: IOMMU map of [%08lx:%08llx:%lx:%lx:%lx] failed with status %ld\n",
>> +						   devhandle,
>> +						   HV_PCI_TSBID(0, entry),
>> +						   npages, prot, __pa(pglist),
>> +						   num);
>> +				return -1;
>> +			}
>> +		} else {
>> +			index_count = HV_PCI_IOTSB_INDEX_COUNT(npages, entry),
>> +			iotsb_num = pbm->iommu->atu->iotsb->iotsb_num;
>> +			ret = pci_sun4v_iotsb_map(devhandle,
>> +						  iotsb_num,
>> +						  index_count,
>> +						  prot,
>> +						  __pa(pglist),
>> +						  &num);
>> +			if (unlikely(ret != HV_EOK)) {
>> +				pr_err_ratelimited("iommu_batch_flush: ATU map of [%08lx:%lx:%llx:%lx:%lx] failed with status %ld\n",
>> +						   devhandle, iotsb_num,
>> +						   index_count, prot,
>> +						   __pa(pglist), ret);
>
> Here and above, it's nicer to use %s, __func__ instead of
> embedding the function name in the format in case the
> code is ever refactored.
Okay. I will make the change and send v3 soon.

-Tushar
>
> 				pr_err_ratelimited("%s: ATU map of [%08lx:%lx:%llx:%lx:%lx] failed with status %ld\n",
> 						   __func__,
> 						   devhandle, iotsb_num,
> 						   index_count, prot,
> 						   __pa(pglist), ret);
>
>
