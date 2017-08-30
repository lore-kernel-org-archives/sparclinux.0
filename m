From: David Miller <davem@davemloft.net>
Date: Wed, 30 Aug 2017 01:09:28 +0000
Subject: Re: [PATCH v7 02/11] sparc64/mm: setting fields in deferred pages
Message-Id: <20170829.180928.896986367806428362.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1503972142-289376-1-git-send-email-pasha.tatashin@oracle.com>
 <1503972142-289376-3-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1503972142-289376-3-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 28 Aug 2017 22:02:13 -0400

> Without deferred struct page feature (CONFIG_DEFERRED_STRUCT_PAGE_INIT),
> flags and other fields in "struct page"es are never changed prior to first
> initializing struct pages by going through __init_single_page().
> 
> With deferred struct page feature enabled there is a case where we set some
> fields prior to initializing:
> 
> mem_init() {
>      register_page_bootmem_info();
>      free_all_bootmem();
>      ...
> }
> 
> When register_page_bootmem_info() is called only non-deferred struct pages
> are initialized. But, this function goes through some reserved pages which
> might be part of the deferred, and thus are not yet initialized.
> 
> mem_init
> register_page_bootmem_info
> register_page_bootmem_info_node
>  get_page_bootmem
>   .. setting fields here ..
>   such as: page->freelist = (void *)type;
> 
> free_all_bootmem()
> free_low_memory_core_early()
>  for_each_reserved_mem_region()
>   reserve_bootmem_region()
>    init_reserved_page() <- Only if this is deferred reserved page
>     __init_single_pfn()
>      __init_single_page()
>       memset(0) <-- Loose the set fields here
> 
> We end-up with similar issue as in the previous patch, where currently we
> do not observe problem as memory is zeroed. But, if flag asserts are
> changed we can start hitting issues.
> 
> Also, because in this patch series we will stop zeroing struct page memory
> during allocation, we must make sure that struct pages are properly
> initialized prior to using them.
> 
> The deferred-reserved pages are initialized in free_all_bootmem().
> Therefore, the fix is to switch the above calls.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

Acked-by: David S. Miller <davem@davemloft.net>
