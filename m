From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 16 Mar 2008 12:47:19 +0000
Subject: Re: only sparc can not include linux/pagemap.h?
Message-Id: <20080316124719.GD4902@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0803161317470.7207@anakin>
In-Reply-To: <Pine.LNX.4.64.0803161317470.7207@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: sparclinux@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sun, Mar 16, 2008 at 01:22:22PM +0100, Geert Uytterhoeven wrote:
> When trying to compile a m68k kernel with CONFIG_SWAP=n (e.g. allnoconfig), I'm
> bitten by:
> 
>     include/asm-generic/tlb.h: In function 'tlb_flush_mmu':
>     include/asm-generic/tlb.h:76: error: implicit declaration of function 'release_pages'
>     include/asm-generic/tlb.h: In function 'tlb_remove_page':
>     include/asm-generic/tlb.h:105: error: implicit declaration of function 'page_cache_release'
> 
> because include/linux/swap.h defines free_page_and_swap_cache() and
> free_pages_and_swap_cache() to page_cache_release() resp. release_pages()
> without including <linux/pagemap.h>.
> 
> include/linux/swap.h has a comment that says:
> 
>     /* only sparc can not include linux/pagemap.h in this file
>      * so leave page_cache_release and release_pages undeclared... */
>     #define free_page_and_swap_cache(page) \
> 	    page_cache_release(page)
>     #define free_pages_and_swap_cache(pages, nr) \
> 	    release_pages((pages), (nr), 0);
> 
> Is this comment still true?
>...

Yes, see http://lkml.org/lkml/2008/1/31/268

> Thanks!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

