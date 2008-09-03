From: Robert Reif <reif@earthlink.net>
Date: Wed, 03 Sep 2008 23:15:43 +0000
Subject: [PATCH] sparc32: add init memory poisoning
Message-Id: <48BF1A9F.6080100@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080100040801070208060604"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100040801070208060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds init memory poisoning.  It looks like
totalram_pages was not updated properly in free_initrd_mem
so I fixed that as well.

Signed-off-by: Robert Reif <reif@earthlink.net>



--------------080100040801070208060604
Content-Type: text/plain;
 name="mm.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm.diff.txt"

diff --git a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
index e103f1b..677c1e1 100644
--- a/arch/sparc/mm/init.c
+++ b/arch/sparc/mm/init.c
@@ -23,6 +23,7 @@
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
 #include <linux/pagemap.h>
+#include <linux/poison.h>
 
 #include <asm/system.h>
 #include <asm/vac-ops.h>
@@ -480,6 +481,7 @@ void free_initmem (void)
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		struct page *p;
 
+		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
 		p = virt_to_page(addr);
 
 		ClearPageReserved(p);
@@ -488,20 +490,26 @@ void free_initmem (void)
 		totalram_pages++;
 		num_physpages++;
 	}
-	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (&__init_end - &__init_begin) >> 10);
+	printk(KERN_INFO "Freeing unused kernel memory: %dk freed\n",
+		(&__init_end - &__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+		printk(KERN_INFO "Freeing initrd memory: %ldk freed\n",
+			(end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
-		struct page *p = virt_to_page(start);
+		struct page *p;
+
+		memset((void *)start, POISON_FREE_INITMEM, PAGE_SIZE);
+		p = virt_to_page(start);
 
 		ClearPageReserved(p);
 		init_page_count(p);
 		__free_page(p);
+		totalram_pages++;
 		num_physpages++;
 	}
 }

--------------080100040801070208060604--
