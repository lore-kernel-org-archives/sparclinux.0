From: Olaf Hering <olh@suse.de>
Date: Sat, 06 Aug 2005 16:27:56 +0000
Subject: [PATCH] remove linux/pagemap.h from linux/swap.h
Message-Id: <20050806162756.GA10132@suse.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, bboissin@gmail.com


sparc can not include linux/pagemap.h because of the following circular
dependency:

asm-sparc/pgtable include linux/swap.h
linux/swap.h include now linux/pagemap.h
linux/pagemap.h include linux/mm.h
linux/mm.h include asm/pgtable.h

It needs to have the swp_entry_t type fully visible in pgtable.h,
we can't work around this using macros.

Signed-off-by: Olaf Hering <olh@suse.de>

 include/linux/swap.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc5-git3.sparc/include/linux/swap.h
=================================--- linux-2.6.13-rc5-git3.sparc.orig/include/linux/swap.h
+++ linux-2.6.13-rc5-git3.sparc/include/linux/swap.h
@@ -7,7 +7,6 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
-#include <linux/pagemap.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
@@ -255,6 +254,8 @@ static inline void put_swap_token(struct
 
 #define si_swapinfo(val) \
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
+/* only sparc can not include linux/pagemap.h in this file
+ * so leave page_cache_release and release_pages undeclared... */
 #define free_page_and_swap_cache(page) \
 	page_cache_release(page)
 #define free_pages_and_swap_cache(pages, nr) \
