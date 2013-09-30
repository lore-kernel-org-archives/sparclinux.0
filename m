From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 15:47:54 +0000
Subject: Re: [PATCH 0/3] Fully support 47-bit physical addresses.
Message-Id: <20130930.114754.1453753555872720780.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.165242.1048533011152185981.davem@redhat.com>
In-Reply-To: <20130926.165242.1048533011152185981.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Mon, 30 Sep 2013 10:22:43 -0400

> Hi,
> David Miller wrote:	[Sat Sep 28 2013, 03:34:12PM EDT]
>> From: Gurudas Pai <gurudas.pai@oracle.com>
>> Date: Fri, 27 Sep 2013 21:07:11 -0700
>> 
>> > This is on a t4-1, machine becomes unusable with hundreds of
>> > "WARNING: CPU: 0 PID: 441 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()"
>> 
>> Strange, it boots perfectly fine on my T4-2.  Can you reply to
>> this email with the ".config" you used?
>> 
>> Also, did you make sure to have the PAGE_OFFSET patches applied
>> first?  They are a prerequisite for this series.
>> 
>> Thanks.
> It seems to be the forever confusing MMU hole. Debian wheezy has no issue with
> the patch below.

Yes, that is the patch I was just about to test as well:

> @@ -101,7 +101,7 @@ typedef pte_t *pgtable_t;
>   * the actual exclusion region we enforce, wherein we use a 4GB red
>   * zone on each side of the VA hole.
>   */
> -#define SPARC64_VA_HOLE_TOP	_AC(0xfffff80000000000,UL)
> +#define SPARC64_VA_HOLE_TOP	_AC(0xfffffc0000000000,UL)
>  #define SPARC64_VA_HOLE_BOTTOM	_AC(0x0000080000000000,UL)

You have to adjust VA_HOLE_BOTTOM as well, shifting it down by one bit,
to be complete.

So my calculations were off by one, we need 44-bits to support the
current SPARC64_VA_HOLE_{TOP,BOTTOM} settings.

Anyways, I'm going to respin my series with minor adjustments plus
the VA_HOLE changes and post them here.

Thanks.
