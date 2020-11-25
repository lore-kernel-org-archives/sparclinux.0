From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 25 Nov 2020 08:58:18 +0000
Subject: Re: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
Message-Id: <20201125085818.GM8537@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201125034655.27687-1-willy@infradead.org>
 <20201125034655.27687-2-willy@infradead.org>
In-Reply-To: <20201125034655.27687-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: akpm@linux-foundation.org, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Wed, Nov 25, 2020 at 03:46:55AM +0000, Matthew Wilcox (Oracle) wrote:
> Code outside mm/ should not be calling free_unref_page().  Also
> move free_unref_page_list().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/gfp.h | 2 --
>  mm/internal.h       | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..6e479e9c48ce 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -580,8 +580,6 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
>  
>  extern void __free_pages(struct page *page, unsigned int order);
>  extern void free_pages(unsigned long addr, unsigned int order);
> -extern void free_unref_page(struct page *page);
> -extern void free_unref_page_list(struct list_head *list);
>  
>  struct page_frag_cache;
>  extern void __page_frag_cache_drain(struct page *page, unsigned int count);
> diff --git a/mm/internal.h b/mm/internal.h
> index 75ae680d0a2c..5864815947fe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -201,6 +201,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
>  
> +extern void free_unref_page(struct page *page);
> +extern void free_unref_page_list(struct list_head *list);
> +
>  extern void zone_pcp_update(struct zone *zone);
>  extern void zone_pcp_reset(struct zone *zone);
>  extern void zone_pcp_disable(struct zone *zone);
> -- 
> 2.29.2
> 

-- 
Sincerely yours,
Mike.
