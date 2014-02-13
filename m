From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 13 Feb 2014 21:15:01 +0000
Subject: [PATCH] sparc32: make copy_to/from_user_page() usable from modular code
Message-Id: <1392326101-20388-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

While copy_to/from_user_page() users are uncommon, there is one in
drivers/staging/lustre/lustre/libcfs/linux/linux-curproc.c which leads
to the following:

ERROR: "sparc32_cachetlb_ops" [drivers/staging/lustre/lustre/libcfs/libcfs.ko] undefined!

during routine allmodconfig build coverage.  The reason this happens
is as follows:

In arch/sparc/include/asm/cacheflush_32.h we have:

 #define flush_cache_page(vma,addr,pfn) \
        sparc32_cachetlb_ops->cache_page(vma, addr)

 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
        do {                                                    \
                flush_cache_page(vma, vaddr, page_to_pfn(page));\
                memcpy(dst, src, len);                          \
        } while (0)
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
        do {                                                    \
                flush_cache_page(vma, vaddr, page_to_pfn(page));\
                memcpy(dst, src, len);                          \
        } while (0)

However, sparc32_cachetlb_ops isn't exported and hence the error.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sparc/mm/srmmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 869023abe5a4..cfbe53c17b0d 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 #include <linux/kdebug.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/log2.h>
@@ -62,6 +63,7 @@ extern unsigned long last_valid_pfn;
 static pgd_t *srmmu_swapper_pg_dir;
 
 const struct sparc32_cachetlb_ops *sparc32_cachetlb_ops;
+EXPORT_SYMBOL(sparc32_cachetlb_ops);
 
 #ifdef CONFIG_SMP
 const struct sparc32_cachetlb_ops *local_ops;
-- 
1.8.5.2

