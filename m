From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 11 Aug 2017 13:04:49 +0000
Subject: Re: [v6 13/15] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <20170811130449.GL30811@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-14-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1502138329-123460-14-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 07-08-17 16:38:47, Pavel Tatashin wrote:
> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
> we will get the performance improvement by zeroing the memory in parallel
> when struct pages are zeroed.

First of all this should be probably merged with the previous patch. The
I think vmemmap_alloc_block would be better to split up into
__vmemmap_alloc_block which doesn't zero and vmemmap_alloc_block which
does zero which would reduce the memset callsites and it would make it
slightly more robust interface.
 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> ---
>  mm/sparse-vmemmap.c | 6 +++---
>  mm/sparse.c         | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index d40c721ab19f..3b646b5ce1b6 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -41,7 +41,7 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
>  				unsigned long align,
>  				unsigned long goal)
>  {
> -	return memblock_virt_alloc_try_nid(size, align, goal,
> +	return memblock_virt_alloc_try_nid_raw(size, align, goal,
>  					    BOOTMEM_ALLOC_ACCESSIBLE, node);
>  }
>  
> @@ -56,11 +56,11 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
>  
>  		if (node_state(node, N_HIGH_MEMORY))
>  			page = alloc_pages_node(
> -				node, GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL,
> +				node, GFP_KERNEL | __GFP_RETRY_MAYFAIL,
>  				get_order(size));
>  		else
>  			page = alloc_pages(
> -				GFP_KERNEL | __GFP_ZERO | __GFP_RETRY_MAYFAIL,
> +				GFP_KERNEL | __GFP_RETRY_MAYFAIL,
>  				get_order(size));
>  		if (page)
>  			return page_address(page);
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7b4be3fd5cac..0e315766ad11 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -441,9 +441,9 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
>  	}
>  
>  	size = PAGE_ALIGN(size);
> -	map = memblock_virt_alloc_try_nid(size * map_count,
> -					  PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> -					  BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
> +	map = memblock_virt_alloc_try_nid_raw(size * map_count,
> +					      PAGE_SIZE, __pa(MAX_DMA_ADDRESS),
> +					      BOOTMEM_ALLOC_ACCESSIBLE, nodeid);
>  	if (map) {
>  		for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
>  			if (!present_section_nr(pnum))
> -- 
> 2.14.0

-- 
Michal Hocko
SUSE Labs
