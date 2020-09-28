From: Mike Rapoport <rppt@kernel.org>
Date: Mon, 28 Sep 2020 14:46:59 +0000
Subject: Re: [PATCH] sparc: Fix handling of page table constructor failure
Message-Id: <20200928144659.GY2142832@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200927151950.32725-1-willy@infradead.org>
In-Reply-To: <20200927151950.32725-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Sep 27, 2020 at 04:19:50PM +0100, Matthew Wilcox (Oracle) wrote:
> The page has just been allocated, so its refcount is 1.  free_unref_page()
> is for use on pages which have a zero refcount.  Use __free_page()
> like the other implementations of pte_alloc_one().
> 
> Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/sparc/mm/init_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index fad6d3129904..4288f08a5736 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2898,7 +2898,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  	if (!page)
>  		return NULL;
>  	if (!pgtable_pte_page_ctor(page)) {
> -		free_unref_page(page);
> +		__free_page(page);
>  		return NULL;
>  	}
>  	return (pte_t *) page_address(page);
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
