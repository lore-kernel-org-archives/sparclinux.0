From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 25 Oct 2016 15:59:04 +0000
Subject: Re: NMI watchdog: BUG: soft lockup
Message-Id: <7939EB66-BE99-4FD6-ACBF-33FBF6502F6B@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
In-Reply-To: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

> On 25 Oct 2016, at 16:50, David Miller <davem@davemloft.net> wrote:
> 
> From: David Miller <davem@davemloft.net>
> Date: Tue, 25 Oct 2016 11:22:31 -0400 (EDT)
> 
>> From: James Clarke <jrtc27@jrtc27.com>
>> Date: Tue, 25 Oct 2016 16:11:52 +0100
>> 
>>> Yep, that fix is still there, but you will note that end *is* above start in
>>> the call. Something is being allocated and freed right at the end of the malloc
>>> area, so it’s iterating over almost the entire thing.
>> 
>> Ok, let me think about this some more.
> 
> So, for the TSB part we don't need to do anything fancy, something like
> the patch below will suffice.
> 
> As per the TLB flush that's a bit more complicated.
> 
> For the older chips we need to do more work because they unfortunately
> defined the context flush to even remove locked TLB entries.
> Otherwise we could simply do a nucleus context flush if the range is
> too large.  So we'll have to use diagnostic accesses to implement the
> same functionality.
> 
> UltraSPARC-III and later provide more usable facilities for this
> situation.  UltraSPARC-III/IV have a "flush all" which removes all
> non-locked TLB entries.  And all of the sun4v chips have a more
> reasonable context flush, which does not remove "permanent" entries.
> 
> I'll start hacking something up.
> 
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index f2b7711..1f63411 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -27,6 +27,20 @@ static inline int tag_compare(unsigned long tag, unsigned long vaddr)
> 	return (tag == (vaddr >> 22));
> }
> 
> +static void flush_tsb_kernel_range_scan(unsigned long start, unsigned long end)
> +{
> +	unsigned long idx;
> +
> +	start >> 22;
> +	end >> 22;
> +	for (idx = 0; idx < KERNEL_TSB_NENTRIES; idx++) {
> +		struct tsb *ent = &swapper_tsb[idx];
> +
> +		if (ent->tag >= start && end->tag < end)
> +			ent->tag = (1UL << TSB_TAG_INVALID_BIT);
> +	}
> +}
> +
> /* TSB flushes need only occur on the processor initiating the address
>  * space modification, not on each cpu the address space has run on.
>  * Only the TLB flush needs that treatment.
> @@ -36,6 +50,9 @@ void flush_tsb_kernel_range(unsigned long start, unsigned long end)
> {
> 	unsigned long v;
> 
> +	if ((end - start) >> PAGE_SHIFT >= 2 * KERNEL_TSB_NENTRIES)
> +		return flush_tsb_kernel_range_scan(start, end);
> +
> 	for (v = start; v < end; v += PAGE_SIZE) {
> 		unsigned long hash = tsb_hash(v, PAGE_SHIFT,
> 					      KERNEL_TSB_NENTRIES);

That’s basically the same as my patch, except this potentially flushes things
outside [start, end) if they’re not on 2^22-byte boundaries. Of course, the
performance hit of that may be better than my patch which also walks through
pages up to the first 2^22-aligned address after start, and those after the
last 2^22-aligned address before end, but won’t flush anything that’s outside
the range.

Can we do a similar thing for the TLB by iterating over all its entries? Surely
one of the ASIs lets you do that?

James

