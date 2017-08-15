From: Michal Hocko <mhocko@kernel.org>
Date: Tue, 15 Aug 2017 09:33:07 +0000
Subject: Re: [v6 05/15] mm: don't accessed uninitialized struct pages
Message-Id: <20170815093306.GC29067@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[CC Mel - the original patch was
http://lkml.kernel.org/r/1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com]

On Mon 07-08-17 16:38:39, Pavel Tatashin wrote:
> In deferred_init_memmap() where all deferred struct pages are initialized
> we have a check like this:
> 
>     if (page->flags) {
>             VM_BUG_ON(page_zone(page) != zone);
>             goto free_range;
>     }
> 
> This way we are checking if the current deferred page has already been
> initialized. It works, because memory for struct pages has been zeroed, and
> the only way flags are not zero if it went through __init_single_page()
> before.  But, once we change the current behavior and won't zero the memory
> in memblock allocator, we cannot trust anything inside "struct page"es
> until they are initialized. This patch fixes this.
> 
> This patch defines a new accessor memblock_get_reserved_pfn_range()
> which returns successive ranges of reserved PFNs.  deferred_init_memmap()
> calls it to determine if a PFN and its struct page has already been
> initialized.

Maybe I am missing something but how can we see reserved ranges here
when for_each_mem_pfn_range iterates over memblock.memory?

The loop is rather complex but I am wondering whether the page->flags
check is needed at all. We shouldn't have duplicated memblocks covering
the same pfn ranges so we cannot initialize the same range multiple
times, right? Reserved ranges are excluded altogether so how exactly can
we see an initialized struct page? In other words, why this simply
doesn't work?
---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 90e331e4c077..987a340a5bed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1524,11 +1524,6 @@ static int __init deferred_init_memmap(void *data)
 				cond_resched();
 			}
 
-			if (page->flags) {
-				VM_BUG_ON(page_zone(page) != zone);
-				goto free_range;
-			}
-
 			__init_single_page(page, pfn, zid, nid);
 			if (!free_base_page) {
 				free_base_page = page;
-- 
Michal Hocko
SUSE Labs
