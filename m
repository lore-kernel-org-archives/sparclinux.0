From: tndave <tushar.n.dave@oracle.com>
Date: Tue, 11 Oct 2016 19:42:06 +0000
Subject: Re: [RFC PATCH 6/6] sparc64: Enable 64-bit DMA
Message-Id: <edf7f9f1-1437-80d3-a2fb-a14c133539a1@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475796816-14448-1-git-send-email-tushar.n.dave@oracle.com>
 <1475796816-14448-7-git-send-email-tushar.n.dave@oracle.com>
 <20161007073252.GA8290@infradead.org>
 <4a70e648-a854-55d1-54ac-313b84841d04@oracle.com>
 <20161011163806.GA21231@infradead.org>
In-Reply-To: <20161011163806.GA21231@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/11/2016 09:38 AM, Christoph Hellwig wrote:
> Hi Tushar,
>
> On Fri, Oct 07, 2016 at 01:09:15AM -0700, tndave wrote:
>> With change made by patch 6/6, dma_addr_t is always 64-bit, no matter if
>> device DMA mask is 32-bit (i.e. using existing IOMMU) or 64-bit (i.e
>> using ATU)
>
> But only iff CONFIG_ARCH_ATU is set.  Anyway, I'll wait for your patches
> to got in first and will then propose getting rid of
> CONFIG_ARCH_DMA_ADDR_T_64BIT separately.
CONFIG_ARCH_ATU is by default set on 'SPARC64'. Therefore
CONFIG_ARCH_DMA_ADDR_T_64BIT is also always set as well on SPARC64.

-Tushar
>
