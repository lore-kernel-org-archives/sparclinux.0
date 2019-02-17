From: Mike Rapoport <rppt@linux.ibm.com>
Date: Sun, 17 Feb 2019 08:28:17 +0000
Subject: Re: [PATCH] sparc64: simplify reduce_memory() function
Message-Id: <20190217082816.GB1176@rapoport-lnx>
List-Id: <sparclinux.vger.kernel.org>
References: <1549963956-28269-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1549963956-28269-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Any comments on this?

On Tue, Feb 12, 2019 at 11:32:36AM +0200, Mike Rapoport wrote:
> The reduce_memory() function clampls the available memory to a limit
> defined by the "mem=" command line parameter. It takes into account the
> amount of already reserved memory and excludes it from the limit
> calculations.
> 
> Rather than traverse memblocks and remove them by hand, use
> memblock_reserved_size() to account the reserved memory and
> memblock_enforce_memory_limit() to clamp the available memory.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sparc/mm/init_64.c | 42 ++----------------------------------------
>  1 file changed, 2 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index b4221d3..478b818 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2261,19 +2261,6 @@ static unsigned long last_valid_pfn;
>  static void sun4u_pgprot_init(void);
>  static void sun4v_pgprot_init(void);
>  
> -static phys_addr_t __init available_memory(void)
> -{
> -	phys_addr_t available = 0ULL;
> -	phys_addr_t pa_start, pa_end;
> -	u64 i;
> -
> -	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &pa_start,
> -				&pa_end, NULL)
> -		available = available + (pa_end  - pa_start);
> -
> -	return available;
> -}
> -
>  #define _PAGE_CACHE_4U	(_PAGE_CP_4U | _PAGE_CV_4U)
>  #define _PAGE_CACHE_4V	(_PAGE_CP_4V | _PAGE_CV_4V)
>  #define __DIRTY_BITS_4U	 (_PAGE_MODIFIED_4U | _PAGE_WRITE_4U | _PAGE_W_4U)
> @@ -2287,33 +2274,8 @@ static phys_addr_t __init available_memory(void)
>   */
>  static void __init reduce_memory(phys_addr_t limit_ram)
>  {
> -	phys_addr_t avail_ram = available_memory();
> -	phys_addr_t pa_start, pa_end;
> -	u64 i;
> -
> -	if (limit_ram >= avail_ram)
> -		return;
> -
> -	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &pa_start,
> -				&pa_end, NULL) {
> -		phys_addr_t region_size = pa_end - pa_start;
> -		phys_addr_t clip_start = pa_start;
> -
> -		avail_ram = avail_ram - region_size;
> -		/* Are we consuming too much? */
> -		if (avail_ram < limit_ram) {
> -			phys_addr_t give_back = limit_ram - avail_ram;
> -
> -			region_size = region_size - give_back;
> -			clip_start = clip_start + give_back;
> -		}
> -
> -		memblock_remove(clip_start, region_size);
> -
> -		if (avail_ram <= limit_ram)
> -			break;
> -		i = 0UL;
> -	}
> +	limit_ram += memblock_reserved_size();
> +	memblock_enforce_memory_limit(limit_ram);
>  }
>  
>  void __init paging_init(void)
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
