From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 22 Jul 2018 02:57:21 +0000
Subject: [PATCH] sparc: fix header problem in sparc32 build
Message-Id: <42f344e6-73c1-87c5-ea2f-b3299675266b@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

From: Randy Dunlap <rdunlap@infradead.org>

Add a "struct page;" "stub" to fix a build error in sparc32.
Fixes this error:

../include/linux/highmem.h: In function 'clear_user_highpage':
../include/linux/highmem.h:137:31: error: passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type [-Werror=incompatible-pointer-types]
  clear_user_page(addr, vaddr, page);
                               ^~~~
../arch/sparc/include/asm/page_32.h:24:27: note: in definition of macro 'clear_user_page'
   sparc_flush_page_to_ram(page); \
                           ^~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/sparc/include/asm/cacheflush_32.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180717.orig/arch/sparc/include/asm/cacheflush_32.h
+++ linux-next-20180717/arch/sparc/include/asm/cacheflush_32.h
@@ -37,6 +37,7 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
 
+struct page;
 void sparc_flush_page_to_ram(struct page *page);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1


