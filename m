From: tndave <tushar.n.dave@oracle.com>
Date: Fri, 07 Oct 2016 08:09:15 +0000
Subject: Re: [RFC PATCH 6/6] sparc64: Enable 64-bit DMA
Message-Id: <4a70e648-a854-55d1-54ac-313b84841d04@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475796816-14448-1-git-send-email-tushar.n.dave@oracle.com>
 <1475796816-14448-7-git-send-email-tushar.n.dave@oracle.com>
 <20161007073252.GA8290@infradead.org>
In-Reply-To: <20161007073252.GA8290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/07/2016 12:32 AM, Christoph Hellwig wrote:
> On Thu, Oct 06, 2016 at 04:33:36PM -0700, Tushar Dave wrote:
>> ATU 64bit addressing allows PCIe devices with 64bit DMA capabilities
>> to use ATU for 64bit DMA.
>
> Any chance to always enable this?  Last I checked sparc was the only
> architecture still using a 32-bit dma_addr_t, leading to some fun
> breakage in things like the software RDMA drivers that abuse it to
> store a kernel pointer..
With change made by patch 6/6, dma_addr_t is always 64-bit, no matter if
device DMA mask is 32-bit (i.e. using existing IOMMU) or 64-bit (i.e
using ATU)

-Tushar

>
