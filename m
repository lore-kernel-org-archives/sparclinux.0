From: Hugh Dickins <hughd@google.com>
Date: Thu, 28 May 2020 03:46:22 +0000
Subject: Re: Cache flush issue with page_mapping_file() and swap back shmem page ?
Message-Id: <alpine.LSU.2.11.2005272021220.3857@eggly.anvils>
List-Id: <sparclinux.vger.kernel.org>
References: <20200528002033.GB1992500@redhat.com>
In-Reply-To: <20200528002033.GB1992500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jerome Glisse <jglisse@redhat.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Paul Burton <paulburton@kernel.org>, Helge Deller <deller@gmx.de>, Huang Ying <ying.huang@intel.com>, James Hogan <jhogan@kernel.org>, rmk+kernel@arm.linux.org.uk, linux-xtensa@linux-xtensa.org, Steven Capper <steve.capper@linaro.org>, Rabin Vincent <rabinv@axis.com>, Ley Foon Tan <lftan@altera.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

Hi Jerome,

On Wed, 27 May 2020, Jerome Glisse wrote:
> So any arch code which uses page_mapping_file() might get the wrong
> answer, this function will return NULL for a swap backed page which
> can be a shmem pages. But shmem pages can still be shared among
> multiple process (and possibly at different virtual addresses if
> mremap was use).
> 
> Attached is a patch that changes page_mapping_file() to return the
> shmem mapping for swap backed shmem page. I have not tested it (no
> way for me to test all those architecture) and i spotted this while
> working on something else. So i hope someone can take a closer look.

I'm certainly no expert on flush_dcache_page() and friends, but I'd
be very surprised if such a problem exists, yet has gone unnoticed
for so long.  page_mapping_file() itself is fairly new, added when
a risk of crashing on a race with swapoff came in: but the previous
use of page_mapping() would have suffered equally if there were such
a cache flushinhg problem here.

And I'm afraid your patch won't do anything to help if there is a
problem: very soon after shmem calls add_to_swap_cache(), it calls
shmem_delete_from_page_cache(), which sets page->mapping to NULL.

But I can assure you that a shmem page (unlike an anon page) is never
put into swap cache while it is mapped into userspace, and never
mapped into userspace while it is still in swap cache: does that help?

Hugh

> This might be a shmem page that is in a sense a file that
> can be mapped multiple times in different processes at
> possibly different virtual addresses (fork + mremap). So
> return the shmem mapping that will allow any arch code to
> find all mappings of the page.
> 
> Note that even if page is not anonymous then the page might
> have a NULL page->mapping field if it is being truncated,
> but then it is fine as each pte poiting to the page will be
> remove and cache flushing should be handled properly by that
> part of the code.
> 
> Signed-off-by: Jerome Glisse <jglisse@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> ---
>  mm/util.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..ec8739ab0cc3 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -685,8 +685,24 @@ EXPORT_SYMBOL(page_mapping);
>   */
>  struct address_space *page_mapping_file(struct page *page)
>  {
> -	if (unlikely(PageSwapCache(page)))
> +	if (unlikely(PageSwapCache(page))) {
> +		/*
> +		 * This might be a shmem page that is in a sense a file that
> +		 * can be mapped multiple times in different processes at
> +		 * possibly different virtual addresses (fork + mremap). So
> +		 * return the shmem mapping that will allow any arch code to
> +		 * find all mappings of the page.
> +		 *
> +		 * Note that even if page is not anonymous then the page might
> +		 * have a NULL page->mapping field if it is being truncated,
> +		 * but then it is fine as each pte poiting to the page will be
> +		 * remove and cache flushing should be handled properly by that
> +		 * part of the code.
> +		 */
> +		if (!PageAnon(page))
> +			return page->mapping;
>  		return NULL;
> +	}
>  	return page_mapping(page);
>  }
>  
> -- 
> 2.26.2
