From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:35 +0000
Subject: [PATCH 20/29] sparc32: fix sparse warnings in auxio_32.c
Message-Id: <1398109184-3283-20-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
auxio_32.c:23:14: warning: symbol 'auxio_register' was not declared. Should it be static?
auxio_32.c:26:13: warning: symbol 'auxio_probe' was not declared. Should it be static?
auxio_32.c:108:13: warning: symbol 'auxio_power_probe' was not declared. Should it be static?

Add proper decalarations for the above.

The leaves one sparse warning:
auxio_32.c:130:33: warning: cast removes address space of expression

This is here:
    auxio_power_register = (unsigned char *) of_ioremap()

This is __iomem that is removed from return value of of_ioremap()
The pointer is later used without any helpers in process_32.c:
    *auxio_power_register |= AUXIO_POWER_OFF;

It would be simple to introduce a few sbus() helpers.
But as I was not sure this was correct the warning are left as-is.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/auxio.h    | 7 +++++++
 arch/sparc/include/asm/auxio_64.h | 2 --
 arch/sparc/kernel/auxio_32.c      | 3 +++
 arch/sparc/kernel/devices.c       | 8 ++------
 arch/sparc/kernel/kernel.h        | 4 ++++
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/auxio.h b/arch/sparc/include/asm/auxio.h
index 13dc67f..3e09a07 100644
--- a/arch/sparc/include/asm/auxio.h
+++ b/arch/sparc/include/asm/auxio.h
@@ -1,5 +1,12 @@
 #ifndef ___ASM_SPARC_AUXIO_H
 #define ___ASM_SPARC_AUXIO_H
+
+#ifndef __ASSEMBLY__
+
+extern void __iomem *auxio_register;
+
+#endif /* ifndef __ASSEMBLY__ */
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/auxio_64.h>
 #else
diff --git a/arch/sparc/include/asm/auxio_64.h b/arch/sparc/include/asm/auxio_64.h
index f61cd1e..7af9766 100644
--- a/arch/sparc/include/asm/auxio_64.h
+++ b/arch/sparc/include/asm/auxio_64.h
@@ -75,8 +75,6 @@
 
 #ifndef __ASSEMBLY__
 
-extern void __iomem *auxio_register;
-
 #define AUXIO_LTE_ON	1
 #define AUXIO_LTE_OFF	0
 
diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index e20cc55..c6fc1d4 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -9,12 +9,15 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/export.h>
+
 #include <asm/oplib.h>
 #include <asm/io.h>
 #include <asm/auxio.h>
 #include <asm/string.h>		/* memset(), Linux has no bzero() */
 #include <asm/cpu_type.h>
 
+#include "kernel.h"
+
 /* Probe and map in the Auxiliary I/O register */
 
 /* auxio_register is not static because it is referenced 
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index 086faf6..6f39916 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -132,11 +132,7 @@ void __init device_scan(void)
 	}
 #endif /* !CONFIG_SMP */
 
-	{
-		extern void auxio_probe(void);
-		extern void auxio_power_probe(void);
-		auxio_probe();
-		auxio_power_probe();
-	}
+	auxio_probe();
+	auxio_power_probe();
 	clock_stop_probe();
 }
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 4877626..716158a 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -116,6 +116,10 @@ void try_to_clear_window_buffer(struct pt_regs *regs, int who);
 /* tadpole.c */
 void __init clock_stop_probe(void);
 
+/* auxio_32.c */
+void __init auxio_probe(void);
+void __init auxio_power_probe(void);
+
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
-- 
1.8.3.1

