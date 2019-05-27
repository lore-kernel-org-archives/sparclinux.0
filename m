From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 27 May 2019 12:20:22 +0000
Subject: Re: [PATCH v4 1/2] vmalloc: Fix calculation of direct map addr range
Message-Id: <20190527122022.GP2606@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190521205137.22029-1-rick.p.edgecombe@intel.com>
 <20190521205137.22029-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20190521205137.22029-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@kernel.org, dave.hansen@intel.com, namit@vmware.com, Meelis Roos <mroos@linux.ee>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>

On Tue, May 21, 2019 at 01:51:36PM -0700, Rick Edgecombe wrote:
> The calculation of the direct map address range to flush was wrong.
> This could cause problems on x86 if a RO direct map alias ever got loaded
> into the TLB. This shouldn't normally happen, but it could cause the
> permissions to remain RO on the direct map alias, and then the page
> would return from the page allocator to some other component as RO and
> cause a crash.
> 
> So fix fix the address range calculation so the flush will include the
> direct map range.
> 
> Fixes: 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsissions")
> Cc: Meelis Roos <mroos@linux.ee>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  mm/vmalloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c42872ed82ac..836888ae01f6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2159,9 +2159,10 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
>  	 * the vm_unmap_aliases() flush includes the direct map.
>  	 */
>  	for (i = 0; i < area->nr_pages; i++) {
> -		if (page_address(area->pages[i])) {
> +		addr = (unsigned long)page_address(area->pages[i]);
> +		if (addr) {
>  			start = min(addr, start);
> -			end = max(addr, end);
> +			end = max(addr + PAGE_SIZE, end);
>  		}
>  	}
>  

Indeed; howevr I'm thinking this bug was caused to exist by the dual use
of @addr in this function, so should we not, perhaps, do something like
the below instead?

Also; having looked at this, it makes me question the use of
flush_tlb_kernel_range() in _vm_unmap_aliases() and
__purge_vmap_area_lazy(), it's potentially combining multiple ranges,
which never really works well.

Arguably, we should just do flush_tlb_all() here, but that's for another
patch I'm thinking.

---
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2123,7 +2123,6 @@ static inline void set_area_direct_map(c
 /* Handle removing and resetting vm mappings related to the vm_struct. */
 static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 {
-	unsigned long addr = (unsigned long)area->addr;
 	unsigned long start = ULONG_MAX, end = 0;
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
 	int i;
@@ -2135,8 +2134,8 @@ static void vm_remove_mappings(struct vm
 	 * execute permissions, without leaving a RW+X window.
 	 */
 	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		set_memory_nx(addr, area->nr_pages);
-		set_memory_rw(addr, area->nr_pages);
+		set_memory_nx((unsigned long)area->addr, area->nr_pages);
+		set_memory_rw((unsigned long)area->addr, area->nr_pages);
 	}
 
 	remove_vm_area(area->addr);
@@ -2160,9 +2159,10 @@ static void vm_remove_mappings(struct vm
 	 * the vm_unmap_aliases() flush includes the direct map.
 	 */
 	for (i = 0; i < area->nr_pages; i++) {
-		if (page_address(area->pages[i])) {
+		unsigned long addr = (unsigned long)page_address(area->pages[i]);
+		if (addr) {
 			start = min(addr, start);
-			end = max(addr, end);
+			end = max(addr + PAGE_SIZE, end);
 		}
 	}
 
