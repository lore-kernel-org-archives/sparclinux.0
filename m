From: Alexey Dobriyan <adobriyan@sw.ru>
Date: Thu, 28 Jun 2007 13:14:48 +0000
Subject: [PATCH] sparc64: add linux/pagemap.h to asm/tlb.h
Message-Id: <20070628131448.GA8888@localhost.sw.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

As seen on sparc64-allnoconfig:

  CC      arch/sparc64/mm/tlb.o
In file included from arch/sparc64/mm/tlb.c:19:
include/asm/tlb.h: In function 'tlb_flush_mmu':
include/asm/tlb.h:60: warning: implicit declaration of function 'release_pages'
include/asm/tlb.h: In function 'tlb_remove_page':
include/asm/tlb.h:92: warning: implicit declaration of function 'page_cache_release'

Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>
---

 include/asm-sparc64/tlb.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/asm-sparc64/tlb.h
+++ b/include/asm-sparc64/tlb.h
@@ -2,6 +2,7 @@
 #define _SPARC64_TLB_H
 
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>

