From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Fri, 21 Jun 2019 14:05:42 +0000
Subject: Re: [PATCH 04/16] MIPS: use the generic get_user_pages_fast code
Message-Id: <20190621140542.GO19891@ziepe.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-5-hch@lst.de>
In-Reply-To: <20190611144102.8848-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:50PM +0200, Christoph Hellwig wrote:
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 4ccb465ef3f2..7d27194e3b45 100644
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -20,6 +20,7 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/io.h>
>  #include <asm/pgtable-bits.h>
> +#include <asm/cpu-features.h>
>  
>  struct mm_struct;
>  struct vm_area_struct;
> @@ -626,6 +627,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>  
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +#define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
> +

Today this check is only being done on the get_user_pages_fast() -
after this patch it is also done for __get_user_pages_fast().

Which means __get_user_pages_fast is now non-functional on a range of
MIPS CPUs, but that seems OK as far as I can tell, so:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

However, looks to me like this patch is also a bug fix for this:

commit 5b167c123b3c3582f62cf1896465019bc40fe526
Author: Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri Jun 14 17:10:03 2013 +0000

    MIPS: Fix get_user_page_fast() for mips with cache alias
    
    get_user_pages_fast() is missing cache flushes for MIPS platforms with
    cache aliases.  Filesystem failures observed with DirectIO operations due
    to missing flush_anon_page() that use page coloring logic to work with
    cache aliases. This fix falls through to take slow_irqon path that calls
    get_user_pages() that has required logic for platforms where
    cpu_has_dc_aliases is true.

> -	pgdp = pgd_offset(mm, addr);
> -	do {
> -		pgd_t pgd = *pgdp;
> -
> -		next = pgd_addr_end(addr, end);
> -		if (pgd_none(pgd))
> -			goto slow;
> -		if (!gup_pud_range(pgd, addr, next, gup_flags & FOLL_WRITE,
> -				   pages, &nr))

This is different too, the core code has a p4d layer, but I see that
whole thing gets NOP'd by the compiler as mips uses pgtable-nop4d.h -
right?

Jason
