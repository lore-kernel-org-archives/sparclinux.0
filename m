From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date: Tue, 21 May 2019 20:51:37 +0000
Subject: [PATCH v4 2/2] vmalloc: Avoid rare case of flushing tlb with weird arguements
Message-Id: <20190521205137.22029-3-rick.p.edgecombe@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190521205137.22029-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20190521205137.22029-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, peterz@infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, luto@kernel.org
Cc: dave.hansen@intel.com, namit@vmware.com, Rick Edgecombe <rick.p.edgecombe@intel.com>, Meelis Roos <mroos@linux.ee>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>

In a rare case, flush_tlb_kernel_range() could be called with a start
higher than the end. Most architectures should be fine with with this, but
some may not like it, so avoid doing this.

In vm_remove_mappings(), in case page_address() returns 0 for all pages,
_vm_unmap_aliases() will be called with start = ULONG_MAX, end = 0 and
flush = 1.

If at the same time, the vmalloc purge operation is triggered by something
else while the current operation is between remove_vm_area() and
_vm_unmap_aliases(), then the vm mapping just removed will be already
purged. In this case the call of vm_unmap_aliases() may not find any other
mappings to flush and so end up flushing start = ULONG_MAX, end = 0. So
only set flush = true if we find something in the direct mapping that we
need to flush, and this way this can't happen.

Fixes: 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsissions")
Cc: Meelis Roos <mroos@linux.ee>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 836888ae01f6..537d1134b40e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2125,6 +2125,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	unsigned long addr = (unsigned long)area->addr;
 	unsigned long start = ULONG_MAX, end = 0;
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
+	int flush_dmap = 0;
 	int i;
 
 	/*
@@ -2163,6 +2164,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 		if (addr) {
 			start = min(addr, start);
 			end = max(addr + PAGE_SIZE, end);
+			flush_dmap = 1;
 		}
 	}
 
@@ -2172,7 +2174,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * reset the direct map permissions to the default.
 	 */
 	set_area_direct_map(area, set_direct_map_invalid_noflush);
-	_vm_unmap_aliases(start, end, 1);
+	_vm_unmap_aliases(start, end, flush_dmap);
 	set_area_direct_map(area, set_direct_map_default_noflush);
 }
 
-- 
2.20.1
