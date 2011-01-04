From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 04 Jan 2011 21:39:12 +0000
Subject: [PATCH 03/10] sparc: use _start for the start entry (like 64 bit does)
Message-Id: <1294177159-15817-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We use "_start" in 64 bit - do the same in 32 bit.
It is always good to be consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/piggyback_32.c |    6 +++---
 arch/sparc/kernel/head_32.S    |    3 +--
 arch/sparc/mm/sun4c.c          |    8 +++-----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback_32.c
index cfd95ec..5c86a7d 100644
--- a/arch/sparc/boot/piggyback_32.c
+++ b/arch/sparc/boot/piggyback_32.c
@@ -73,9 +73,9 @@ static void usage(void)
 
 static int start_line(const char *line)
 {
-	if (strcmp(line + 8, " T start\n") = 0)
+	if (strcmp(line + 8, " T _start\n") = 0)
 		return 1;
-	else if (strcmp(line + 16, " T start\n") = 0)
+	else if (strcmp(line + 16, " T _start\n") = 0)
 		return 1;
 	return 0;
 }
@@ -92,7 +92,7 @@ static int end_line(const char *line)
 /*
  * Find address for start and end in System.map.
  * The file looks like this:
- * f0004000 T start
+ * f0004000 T _start
  * f0379f79 A _end
  * 1234567890123456
  * ^coloumn 1
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 21bb259..5942349 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -73,12 +73,11 @@ sun4e_notsup:
 
 	/* The Sparc trap table, bootloader gives us control at _start. */
 	__HEAD
-	.globl	start, _stext, _start, __stext
+	.globl	_stext, _start, __stext
 	.globl  trapbase
 _start:   /* danger danger */
 __stext:
 _stext:
-start:
 trapbase:
 #ifdef CONFIG_SMP
 trapbase_cpu0:
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index ddd0d86..b5137cc 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -435,16 +435,14 @@ void __init sun4c_probe_memerr_reg(void)
 
 static inline void sun4c_init_ss2_cache_bug(void)
 {
-	extern unsigned long start;
-
 	if ((idprom->id_machtype = (SM_SUN4C | SM_4C_SS2)) ||
 	    (idprom->id_machtype = (SM_SUN4C | SM_4C_IPX)) ||
 	    (idprom->id_machtype = (SM_SUN4C | SM_4C_ELC))) {
 		/* Whee.. */
 		printk("SS2 cache bug detected, uncaching trap table page\n");
-		sun4c_flush_page((unsigned int) &start);
-		sun4c_put_pte(((unsigned long) &start),
-			(sun4c_get_pte((unsigned long) &start) | _SUN4C_PAGE_NOCACHE));
+		sun4c_flush_page((unsigned int) &_start);
+		sun4c_put_pte(((unsigned long) &_start),
+			(sun4c_get_pte((unsigned long) &_start) | _SUN4C_PAGE_NOCACHE));
 	}
 }
 
-- 
1.6.0.6

