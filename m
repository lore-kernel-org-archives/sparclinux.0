From: David Miller <davem@davemloft.net>
Date: Wed, 11 Jan 2012 07:35:29 +0000
Subject: Re: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120110.233529.1691130793821248205.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120103204516.GA4271@merkur.ravnborg.org>
In-Reply-To: <20120103204516.GA4271@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Jan 2012 22:56:18 +0100

> On Wed, Jan 04, 2012 at 04:29:19PM -0500, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 3 Jan 2012 21:45:16 +0100
>> 
>> > - kern_addr_valid is (temporary) disabled
>> >   I could not grock the code allocating sparc_valid_addr_bitmap
>> >   and I noticed most archs do not implement this check
>> 
>> Is it hard to grok where the memory is allocated from or the
>> calculation of the bitmap memory's size? :-)
> 
>         i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
>         i += 1;
>         sparc_valid_addr_bitmap = (unsigned long *)
>                 __alloc_bootmem(i << 2, SMP_CACHE_BYTES, 0UL);
> 
> I failed to find out how we calculate the amount
> of memory to allocate.

It could just simply be buggy.  Be wary of code that has been in
the tree more than 10 years :-)

The formula here has changed several times, at one point the code
looked like:

	sparc_valid_addr_bitmap = (unsigned long *)start_mem;
	i = max_mapnr >> (8 + 5);
	i += 1;
	memset(sparc_valid_addr_bitmap, 0, i << 2);
	start_mem += i << 2;

Then it looked something like:

	i = last_valid_pfn >> (8 + 5);
	i += 1;
	sparc_valid_addr_bitmap = (unsigned long *)
		__alloc_bootmem(i << 2, SMP_CACHE_BYTES, 0UL);

and finally the "8" was replaced with 20 - PAGE_SHIFT.

> last_valid_pfn is the last page of the available memory.
> So last_valid_pfn >> (20 - PAGE_SHIFT) is the amount of
> memory expressed in MB.
> 
> But then we shifted an additional "+ 5".
> This looks like we go for 32 MB.
> + 1 is just to make sure we cover the last page I think.
> And when we allocate we do " i << 2 " so we are down to
> 8 MB.
> 
> When we use it we do:
> #define kern_addr_valid(addr) \
>         (test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))
> 
> so here it looks like we have one bit for each MB.

Indeed, it looks like we mis-size this allocation.

> I also looked at:
> static void __init taint_real_pages(void)
 ...
> Here I could see that we set a bit for each MB
> in sparc_valid_addr_bitmap and it is not limited
> to the kernel address range.

It is indeed marking every MB present in the physical memory
tables.
