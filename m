From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:41:05 +0000
Subject: [PATCH 3/5] sparc32: use proper prototype for trapbase
Message-Id: <1461346867-9736-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This killed an extern ... in a .c file.
No functional change.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h   | 1 +
 arch/sparc/kernel/kgdb_32.c  | 3 +--
 arch/sparc/kernel/setup_32.c | 4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index e7f652b..11eaac7 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -127,6 +127,7 @@ extern unsigned int t_nmi[];
 extern unsigned int linux_trap_ipi15_sun4d[];
 extern unsigned int linux_trap_ipi15_sun4m[];
 
+extern struct tt_entry trapbase;
 extern struct tt_entry trapbase_cpu1;
 extern struct tt_entry trapbase_cpu2;
 extern struct tt_entry trapbase_cpu3;
diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 8602e88..6e8e318 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -12,10 +12,9 @@
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
 
+#include "kernel.h"
 #include "entry.h"
 
-extern unsigned long trapbase;
-
 void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
 	struct reg_window32 *win;
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index baef495..555a8a5 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -68,8 +68,6 @@ struct screen_info screen_info = {
  * prints out pretty messages and returns.
  */
 
-extern unsigned long trapbase;
-
 /* Pretty sick eh? */
 static void prom_sync_me(void)
 {
@@ -300,7 +298,7 @@ void __init setup_arch(char **cmdline_p)
 	int i;
 	unsigned long highest_paddr;
 
-	sparc_ttable = (struct tt_entry *) &trapbase;
+	sparc_ttable = &trapbase;
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-- 
2.5.0

