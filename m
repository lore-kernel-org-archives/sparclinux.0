From: Johannes Weiner <hannes@saeurebad.de>
Date: Thu, 14 Aug 2008 23:40:38 +0000
Subject: Re: Bootmem allocator broken
Message-Id: <8763q3xj0p.fsf@skyscraper.fehenstaub.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0808122053280.31704@hs20-bc2-1.build.redhat.com>
	<20080812.184052.193693538.davem@davemloft.net>
	<Pine.LNX.4.64.0808130845290.8416@hs20-bc2-1.build.redhat.com>
	<20080813.202559.193705172.davem@davemloft.net>
	<Pine.LNX.4.64.0808141855500.15262@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0808141855500.15262@hs20-bc2-1.build.redhat.com>
	(Mikulas Patocka's message of "Thu, 14 Aug 2008 19:11:19 -0400 (EDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

Hi Mikulas,

Mikulas Patocka <mpatocka@redhat.com> writes:

> Examining the problem further, it turned out that Johannes Weiner 
> committed new bootmem allocator to 2.6.27-rc1 and the allocator is broken.
>
> This is the minimal sequence that jams the allocator:
>
> void *p, *q, *r;
> p = alloc_bootmem(PAGE_SIZE);
> q = alloc_bootmem(64);
> free_bootmem(p, PAGE_SIZE);
> p = alloc_bootmem(PAGE_SIZE);
> r = alloc_bootmem(64);
>
> --- after this sequence (assuming that the allocator was empty or 
> page-aligned before), pointer "q" will be equal to pointer "r".
>
> What's hapenning inside the allocator:
> p = alloc_bootmem(PAGE_SIZE);
> in allocator: last_end_off = PAGE_SIZE, bitmap contains bits 10000...
> q = alloc_bootmem(64);
> in allocator: last_end_off = PAGE_SIZE + 64, bitmap contains 11000...
> free_bootmem(p, PAGE_SIZE);
> in allocator: last_end_off = PAGE_SIZE + 64, bitmap contains 01000...
> p = alloc_bootmem(PAGE_SIZE);
> in allocator: last_end_off = PAGE_SIZE, bitmap contains 11000...
> r = alloc_bootmem(64);
> and now:
> it finds bit "2", as a place where to allocate (sidx)
> it hits the condition
> if (bdata->last_end_off && PFN_DOWN(bdata->last_end_off) + 1 = sidx))
> start_off = ALIGN(bdata->last_end_off, align);
> --- you can see that the condition is true, so it assigns start_off = 
> ALIGN(bdata->last_end_off, align); --- that is PAGE_SIZE --- and allocates 
> over already allocated block.
>
> This patch fixes it (kernels 2.6.27-rc2 and 2.6.27-rc3 boot ok after the 
> patch). Johannes, please review the patch and submit it to Linus.
>
> With the patch it tries to continue at the end of previous allocation only 
> if the previous allocation ended in the middle of the page.

Yes, taking last_end_off into account when it's page-aligned is bogus as
the whole merging thing is about partial pages.

Cool spot and nice fix!

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Acked-by: Johannes Weiner <hannes@saeurebad.de>

	Hannes

> ---
>  mm/bootmem.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6.27-rc2-orig/mm/bootmem.c
> =================================> --- linux-2.6.27-rc2-orig.orig/mm/bootmem.c	2008-08-15 00:10:38.000000000 +0200
> +++ linux-2.6.27-rc2-orig/mm/bootmem.c	2008-08-15 00:10:53.000000000 +0200
> @@ -473,7 +473,7 @@ find_block:
>  				goto find_block;
>  			}
>  
> -		if (bdata->last_end_off &&
> +		if (bdata->last_end_off & (PAGE_SIZE - 1) &&
>  				PFN_DOWN(bdata->last_end_off) + 1 = sidx)
>  			start_off = ALIGN(bdata->last_end_off, align);
>  		else
