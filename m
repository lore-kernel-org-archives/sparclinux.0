From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:17 +0000
Subject: [PATCH 05/24] sparc32: fix sparse warnings in process_32.h
Message-Id: <1398100356-19794-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
process_32.c:67:6: warning: symbol 'arch_cpu_idle' was not declared. Should it be static?
process_32.c:257:16: warning: symbol 'sparc_do_fork' was not declared. Should it be static?
process_32.c:411:5: warning: symbol 'dump_fpu' was not declared. Should it be static?

Add missing includes and add one missing prototype.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h     | 6 ++++++
 arch/sparc/kernel/process_32.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index a702d9a..a922753 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -95,6 +95,12 @@ extern void floppy_hardint(void);
 extern unsigned long sun4m_cpu_startup;
 extern unsigned long sun4d_cpu_startup;
 
+/* process_32.c */
+asmlinkage int sparc_do_fork(unsigned long clone_flags,
+                             unsigned long stack_start,
+                             struct pt_regs *regs,
+                             unsigned long stack_size);
+
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 510baec..61f810b 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -10,6 +10,7 @@
 
 #include <stdarg.h>
 
+#include <linux/elfcore.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -23,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 #include <asm/auxio.h>
 #include <asm/oplib.h>
@@ -38,6 +40,8 @@
 #include <asm/unistd.h>
 #include <asm/setup.h>
 
+#include "kernel.h"
+
 /* 
  * Power management idle function 
  * Set in pm platform drivers (apc.c and pmc.c)
-- 
1.8.3.1

