From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 25 Nov 2020 12:34:04 +0000
Subject: Re: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
Message-Id: <6418f355-ae69-a0bc-3006-b89a4e1cc09c@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20201125034655.27687-1-willy@infradead.org>
 <20201125034655.27687-2-willy@infradead.org>
In-Reply-To: <20201125034655.27687-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, akpm@linux-foundation.org
Cc: davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On 11/25/20 4:46 AM, Matthew Wilcox (Oracle) wrote:
> Code outside mm/ should not be calling free_unref_page().  Also
> move free_unref_page_list().

Good idea.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

There seems to be some effort to remove "extern" from function 
declarations from headers. Do we want to do that, at once, or piecemeal? 
If the latter, this is a chance for these functions at least :)

> ---
>   include/linux/gfp.h | 2 --
>   mm/internal.h       | 3 +++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..6e479e9c48ce 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -580,8 +580,6 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
>   
>   extern void __free_pages(struct page *page, unsigned int order);
>   extern void free_pages(unsigned long addr, unsigned int order);
> -extern void free_unref_page(struct page *page);
> -extern void free_unref_page_list(struct list_head *list);
>   
>   struct page_frag_cache;
>   extern void __page_frag_cache_drain(struct page *page, unsigned int count);
> diff --git a/mm/internal.h b/mm/internal.h
> index 75ae680d0a2c..5864815947fe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -201,6 +201,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>   					gfp_t gfp_flags);
>   extern int user_min_free_kbytes;
>   
> +extern void free_unref_page(struct page *page);
> +extern void free_unref_page_list(struct list_head *list);
> +
>   extern void zone_pcp_update(struct zone *zone);
>   extern void zone_pcp_reset(struct zone *zone);
>   extern void zone_pcp_disable(struct zone *zone);
> 
