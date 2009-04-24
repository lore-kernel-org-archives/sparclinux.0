From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Fri, 24 Apr 2009 13:58:24 +0000
Subject: [PATCH] SPARC:  Simplify code using is_power_of_2() routine.
Message-Id: <alpine.LFD.2.00.0904240957240.17234@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 06c9a7d..ade4eb3 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/kdebug.h>
+#include <linux/log2.h>

 #include <asm/bitext.h>
 #include <asm/page.h>
@@ -349,7 +350,7 @@ static void srmmu_free_nocache(unsigned long vaddr, int size)
 		    vaddr, srmmu_nocache_end);
 		BUG();
 	}
-	if (size & (size-1)) {
+	if (!is_power_of_2(size)) {
 		printk("Size 0x%x is not a power of 2\n", size);
 		BUG();
 	}

====================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Linked In:                             http://www.linkedin.com/in/rpjday
Twitter:                                       http://twitter.com/rpjday
====================================
