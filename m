From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:28 +0000
Subject: [PATCH 18/18] sparc32: delete dead code in show_mem()
Message-Id: <1343336548-3879-18-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 9f1162f..dde85ef 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -60,13 +60,6 @@ void show_mem(unsigned int filter)
 	       nr_swap_pages << (PAGE_SHIFT-10));
 	printk("%ld pages of RAM\n", totalram_pages);
 	printk("%ld free pages\n", nr_free_pages());
-#if 0 /* undefined pgtable_cache_size, pgd_cache_size */
-	printk("%ld pages in page table cache\n",pgtable_cache_size);
-#ifndef CONFIG_SMP
-	if (sparc_cpu_model = sun4m || sparc_cpu_model = sun4d)
-		printk("%ld entries in page dir cache\n",pgd_cache_size);
-#endif	
-#endif
 }
 
 
-- 
1.6.0.6

