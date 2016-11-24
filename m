From: tndave <tushar.n.dave@oracle.com>
Date: Thu, 24 Nov 2016 01:44:14 +0000
Subject: Re: [PATCH] qlogicpti: Fix compiler warnings
Message-Id: <359a771a-8a19-4fc6-67a3-322f328f3262@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1479936597-29061-1-git-send-email-tushar.n.dave@oracle.com>
 <1479941859.2417.28.camel@HansenPartnership.com>
 <f551b4db-610a-441d-e01d-1be258f7408e@oracle.com>
 <20161123.202552.1154659754872541108.davem@davemloft.net>
In-Reply-To: <20161123.202552.1154659754872541108.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org, thomas.tai@oracle.com, sparclinux@vger.kernel.org



On 11/23/2016 05:25 PM, David Miller wrote:
> From: tndave <tushar.n.dave@oracle.com>
> Date: Wed, 23 Nov 2016 17:08:23 -0800
>
>> As per my understanding, I think, all DMA map/unmap go through
>> ATU (iommu) in sun4v sparc. To guarantee that driver doesn't get DMA
>> address beyond its addressable range , driver must set dma mask before
>> requesting any DMA mapping!
>>
>> I will investigate further and send v2.
>>
>> Thanks for the review.
>
> This is an SBUS driver, it's not going to execute on any sun4v
> system.
Thank you for the info, Dave.

In that case, the DMA address comes from legacy iommu and that address
is always in 32-bit range i.e. below 4G.

-Tushar

> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
