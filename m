From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 19:25:08 +0000
Subject: Re: [PATCH 02/10] arm64/iommu: don't remap contiguous allocations for coherent devices
Message-Id: <20181210192508.GA31318@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208173702.15158-1-hch@lst.de>
 <20181208173702.15158-3-hch@lst.de>
 <eaf8ce49-ab5e-7c02-a028-74671172b684@arm.com>
In-Reply-To: <eaf8ce49-ab5e-7c02-a028-74671172b684@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, iommu@lists.linux-foundation.org, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@vger.kernel.org, linux-media@vger.kernel.org

On Mon, Dec 10, 2018 at 07:19:30PM +0000, Robin Murphy wrote:
> On 08/12/2018 17:36, Christoph Hellwig wrote:
>> There is no need to have an additional kernel mapping for a contiguous
>> allocation if the device already is DMA coherent, so skip it.
>
> FWIW, the "need" was that it kept the code in this path simple and the 
> mapping behaviour consistent with the regular iommu_dma_alloc() case. One 
> could quite easily retort that there is no need for the extra complexity of 
> this patch, since vmalloc is cheap on a 64-bit architecture ;)

Heh.  Well, without the remap we do less work, we prepare for a simple
implementation of DMA_ATTR_NON_CONSISTENT, and also prepapre the code
to be better reusable for architectures that don't do remapping of
DMA allocations at all.

>>   		if (addr) {
>>   			memset(addr, 0, size);
>> -			if (!coherent)
>> -				__dma_flush_area(page_to_virt(page), iosize);
>> +			__dma_flush_area(page_to_virt(page), iosize);
>
> Oh poo - seems I missed it at the time but the existing logic here is 
> wrong. Let me send a separate fix to flip those statements into the correct 
> order...

Yes, flushing the remapped alias only after zeroing it looks odd.
