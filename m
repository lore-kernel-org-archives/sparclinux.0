From: David Miller <davem@davemloft.net>
Date: Tue, 06 Nov 2012 17:41:33 +0000
Subject: Re: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
Message-Id: <20121106.124133.1287008316099748150.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-16-git-send-email-walken@google.com>
 <20121105.202501.1246122770431623794.davem@davemloft.net>
 <5098BC7F.7090702@redhat.com>
In-Reply-To: <5098BC7F.7090702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rik van Riel <riel@redhat.com>
Date: Tue, 06 Nov 2012 02:30:07 -0500

> On 11/05/2012 08:25 PM, David Miller wrote:
>> From: Michel Lespinasse <walken@google.com>
>> Date: Mon,  5 Nov 2012 14:47:12 -0800
>>
>>> Update the sparc32 arch_get_unmapped_area function to make use of
>>> vm_unmapped_area() instead of implementing a brute force search.
>>>
>>> Signed-off-by: Michel Lespinasse <walken@google.com>
>>
>> Hmmm...
>>
>>> -	if (flags & MAP_SHARED)
>>> -		addr = COLOUR_ALIGN(addr);
>>> -	else
>>> -		addr = PAGE_ALIGN(addr);
>>
>> What part of vm_unmapped_area() is going to duplicate this special
>> aligning logic we need on sparc?
>>
> 
> That would be this part:
> 
> +found:
> + /* We found a suitable gap. Clip it with the original low_limit. */
> +	if (gap_start < info->low_limit)
> +		gap_start = info->low_limit;
> +
> +	/* Adjust gap address to the desired alignment */
> + gap_start += (info->align_offset - gap_start) & info->align_mask;
> +
> +	VM_BUG_ON(gap_start + info->length > info->high_limit);
> +	VM_BUG_ON(gap_start + info->length > gap_end);
> +	return gap_start;
> +}

Ok, now I understand.  Works for me:

Acked-by: David S. Miller <davem@davemloft.net>
