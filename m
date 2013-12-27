From: Matthew Wilcox <willy@linux.intel.com>
Date: Fri, 27 Dec 2013 18:00:18 +0000
Subject: [PATCH] remap_file_pages needs to check for cache coherency
Message-Id: <20131227180018.GC4945@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org


It seems to me that while (for example) on SPARC, it's not possible to
create a non-coherent mapping with mmap(), after we've done an mmap,
we can then use remap_file_pages() to create a mapping that no longer
aliases in the D-cache.

I have only compile-tested this patch.  I don't have any SPARC hardware,
and my PA-RISC hardware hasn't been turned on in six years ... I noticed
this while wandering around looking at some other stuff.

diff --git a/mm/fremap.c b/mm/fremap.c
index 5bff081..01fc2e7 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -19,6 +19,7 @@
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
+#include <asm/shmparam.h>
 #include <asm/tlbflush.h>
 
 #include "internal.h"
@@ -177,6 +178,13 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (start < vma->vm_start || start + size > vma->vm_end)
 		goto out;
 
+#ifdef __ARCH_FORCE_SHMLBA
+	/* Is the mapping cache-coherent? */
+	if ((pgoff ^ linear_page_index(vma, start)) &
+	    ((SHMLBA-1) >> PAGE_SHIFT))
+		goto out;
+#endif
+
 	/* Must set VM_NONLINEAR before any pages are populated. */
 	if (!(vma->vm_flags & VM_NONLINEAR)) {
 		/*
