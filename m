From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 14 Aug 2017 11:47:55 +0000
Subject: Re: [v6 05/15] mm: don't accessed uninitialized struct pages
Message-Id: <20170814114755.GI19063@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
 <20170811093746.GF30811@dhcp22.suse.cz>
 <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
In-Reply-To: <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 11-08-17 11:55:39, Pasha Tatashin wrote:
> On 08/11/2017 05:37 AM, Michal Hocko wrote:
> >On Mon 07-08-17 16:38:39, Pavel Tatashin wrote:
> >>In deferred_init_memmap() where all deferred struct pages are initialized
> >>we have a check like this:
> >>
> >>     if (page->flags) {
> >>             VM_BUG_ON(page_zone(page) != zone);
> >>             goto free_range;
> >>     }
> >>
> >>This way we are checking if the current deferred page has already been
> >>initialized. It works, because memory for struct pages has been zeroed, and
> >>the only way flags are not zero if it went through __init_single_page()
> >>before.  But, once we change the current behavior and won't zero the memory
> >>in memblock allocator, we cannot trust anything inside "struct page"es
> >>until they are initialized. This patch fixes this.
> >>
> >>This patch defines a new accessor memblock_get_reserved_pfn_range()
> >>which returns successive ranges of reserved PFNs.  deferred_init_memmap()
> >>calls it to determine if a PFN and its struct page has already been
> >>initialized.
> >
> >Why don't we simply check the pfn against pgdat->first_deferred_pfn?
> 
> Because we are initializing deferred pages, and all of them have pfn greater
> than pgdat->first_deferred_pfn. However, some of deferred pages were already
> initialized if they were reserved, in this path:
> 
> mem_init()
>  free_all_bootmem()
>   free_low_memory_core_early()
>    for_each_reserved_mem_region()
>     reserve_bootmem_region()
>      init_reserved_page() <- if this is deferred reserved page
>       __init_single_pfn()
>        __init_single_page()
> 
> So, currently, we are using the value of page->flags to figure out if this
> page has been initialized while being part of deferred page, but this is not
> going to work for this project, as we do not zero the memory that is backing
> the struct pages, and size the value of page->flags can be anything.

True, this is the initialization part I've missed in one of the previous
patches already. Would it be possible to only iterate over !reserved
memory blocks instead? Now that we discard all the metadata later it
should be quite easy to do for_each_memblock_type, no?

-- 
Michal Hocko
SUSE Labs
