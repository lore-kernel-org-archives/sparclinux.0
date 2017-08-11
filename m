From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 15:39:41 +0000
Subject: Re: [v6 02/15] x86/mm: setting fields in deferred pages
Message-Id: <b0422e38-a6da-081a-71c5-82a36dd2a5bb@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-3-git-send-email-pasha.tatashin@oracle.com>
 <20170811090214.GD30811@dhcp22.suse.cz>
In-Reply-To: <20170811090214.GD30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> AFAIU register_page_bootmem_info_node is only about struct pages backing
> pgdat, usemap and memmap. Those should be in reserved memblocks and we
> do not initialize those at later times, they are not relevant to the
> deferred initialization as your changelog suggests so the ordering with
> get_page_bootmem shouldn't matter. Or am I missing something here?

The pages for pgdata, usemap, and memmap are part of reserved, and thus 
getting initialized when free_all_bootmem() is called.

So, we have something like this in mem_init()

register_page_bootmem_info
  register_page_bootmem_info_node
   get_page_bootmem
    .. setting fields here ..
    such as: page->freelist = (void *)type;

free_all_bootmem()
  free_low_memory_core_early()
   for_each_reserved_mem_region()
    reserve_bootmem_region()
     init_reserved_page() <- Only if this is deferred reserved page
      __init_single_pfn()
       __init_single_page()
           memset(0) <-- Loose the set fields here!

memblock does not know about deferred pages, and can be requested to 
allocate physical pages anywhere. So, the reserved pages in memblock can 
be both in non-deferred and deferred part of the memory.

Without deferred pages enabled, by the time register_page_bootmem_info() 
is called every page went through __init_single_page(), but with 
deferred pages enabled, there is scenario where fields can be set before 
pages go through __init_single_page(). This patch fixes it.
