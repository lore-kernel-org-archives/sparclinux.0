From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 11 Aug 2017 13:08:31 +0000
Subject: Re: [v6 15/15] mm: debug for raw alloctor
Message-Id: <20170811130831.GN30811@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 07-08-17 16:38:49, Pavel Tatashin wrote:
> When CONFIG_DEBUG_VM is enabled, this patch sets all the memory that is
> returned by memblock_virt_alloc_try_nid_raw() to ones to ensure that no
> places excpect zeroed memory.

Please fold this into the patch which introduces
memblock_virt_alloc_try_nid_raw. I am not sure CONFIG_DEBUG_VM is the
best config because that tends to be enabled quite often. Maybe
CONFIG_MEMBLOCK_DEBUG? Or even make it kernel command line parameter?

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> ---
>  mm/memblock.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3fbf3bcb52d9..29fcb1dd8a81 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1363,12 +1363,19 @@ void * __init memblock_virt_alloc_try_nid_raw(
>  			phys_addr_t min_addr, phys_addr_t max_addr,
>  			int nid)
>  {
> +	void *ptr;
> +
>  	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=0x%llx max_addr=0x%llx %pF\n",
>  		     __func__, (u64)size, (u64)align, nid, (u64)min_addr,
>  		     (u64)max_addr, (void *)_RET_IP_);
>  
> -	return memblock_virt_alloc_internal(size, align,
> -					    min_addr, max_addr, nid);
> +	ptr = memblock_virt_alloc_internal(size, align,
> +					   min_addr, max_addr, nid);
> +#ifdef CONFIG_DEBUG_VM
> +	if (ptr && size > 0)
> +		memset(ptr, 0xff, size);
> +#endif
> +	return ptr;
>  }
>  
>  /**
> -- 
> 2.14.0

-- 
Michal Hocko
SUSE Labs
