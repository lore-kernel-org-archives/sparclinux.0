From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 11 Aug 2017 08:07:07 +0000
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
Message-Id: <20170811080706.GC30811@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 07-08-17 16:38:35, Pavel Tatashin wrote:
> Struct pages are initialized by going through __init_single_page(). Since
> the existing physical memory in memblock is represented in memblock.memory
> list, struct page for every page from this list goes through
> __init_single_page().

By a page _from_ this list you mean struct pages backing the physical
memory of the memblock lists?
 
> The second memblock list: memblock.reserved, manages the allocated memory.
> The memory that won't be available to kernel allocator. So, every page from
> this list goes through reserve_bootmem_region(), where certain struct page
> fields are set, the assumption being that the struct pages have been
> initialized beforehand.
> 
> In trim_low_memory_range() we unconditionally reserve memoryfrom PFN 0, but
> memblock.memory might start at a later PFN. For example, in QEMU,
> e820__memblock_setup() can use PFN 1 as the first PFN in memblock.memory,
> so PFN 0 is not on memblock.memory (and hence isn't initialized via
> __init_single_page) but is on memblock.reserved (and hence we set fields in
> the uninitialized struct page).
> 
> Currently, the struct page memory is always zeroed during allocation,
> which prevents this problem from being detected. But, if some asserts
> provided by CONFIG_DEBUG_VM_PGFLAGS are tighten, this problem may become
> visible in existing kernels.
> 
> In this patchset we will stop zeroing struct page memory during allocation.
> Therefore, this bug must be fixed in order to avoid random assert failures
> caused by CONFIG_DEBUG_VM_PGFLAGS triggers.
> 
> The fix is to reserve memory from the first existing PFN.

Hmm, I assume this is a result of some assert triggering, right? Which
one? Why don't we need the same treatment for other than x86 arch?

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

I guess that the review happened inhouse. I do not want to question its
value but it is rather strange to not hear the specific review comments
which might be useful in general and moreover even not include those
people on the CC list so they are aware of the follow up discussion.

> ---
>  arch/x86/kernel/setup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3486d0498800..489cdc141bcb 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -790,7 +790,10 @@ early_param("reservelow", parse_reservelow);
>  
>  static void __init trim_low_memory_range(void)
>  {
> -	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
> +	unsigned long min_pfn = find_min_pfn_with_active_regions();
> +	phys_addr_t base = min_pfn << PAGE_SHIFT;
> +
> +	memblock_reserve(base, ALIGN(reserve_low, PAGE_SIZE));
>  }
>  	
>  /*
> -- 
> 2.14.0

-- 
Michal Hocko
SUSE Labs
