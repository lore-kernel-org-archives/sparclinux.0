From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jan 2011 23:26:10 +0000
Subject: [PATCH] sparc32: remove tick14.c
Message-Id: <20110122232610.GA4188@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From b676100143a84b63c5bcdeda44909147d59fe9a3 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 00:12:55 +0100
Subject: [PATCH] sparc32: remove tick14.c

The two methods included in tick14.c are no-op because
the static variable linux_lvl14 is always NULL.

So remove the file and callers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/Makefile |    1 -
 arch/sparc/kernel/tick14.c |   39 ---------------------------------------
 arch/sparc/prom/misc_32.c  |    4 ----
 3 files changed, 0 insertions(+), 44 deletions(-)
 delete mode 100644 arch/sparc/kernel/tick14.c

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 599398f..5beae63 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -42,7 +42,6 @@ obj-$(CONFIG_SPARC32)   += windows.o
 obj-y                   += cpu.o
 obj-$(CONFIG_SPARC32)   += devices.o
 obj-$(CONFIG_SPARC32)   += tadpole.o
-obj-$(CONFIG_SPARC32)   += tick14.o
 obj-y                   += ptrace_$(BITS).o
 obj-y                   += unaligned_$(BITS).o
 obj-y                   += una_asm_$(BITS).o
diff --git a/arch/sparc/kernel/tick14.c b/arch/sparc/kernel/tick14.c
deleted file mode 100644
index 138bbf5..0000000
--- a/arch/sparc/kernel/tick14.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/* tick14.c
- *
- * Copyright (C) 1996 David Redman (djhr@tadpole.co.uk)
- *
- * This file handles the Sparc specific level14 ticker
- * This is really useful for profiling OBP uses it for keyboard
- * aborts and other stuff.
- */
-#include <linux/kernel.h>
-
-extern unsigned long lvl14_save[5];
-static unsigned long *linux_lvl14 = NULL;
-static unsigned long obp_lvl14[4];
- 
-/*
- * Call with timer IRQ closed.
- * First time we do it with disable_irq, later prom code uses spin_lock_irq().
- */
-void install_linux_ticker(void)
-{
-
-	if (!linux_lvl14)
-		return;
-	linux_lvl14[0] =  lvl14_save[0];
-	linux_lvl14[1] =  lvl14_save[1];
-	linux_lvl14[2] =  lvl14_save[2];
-	linux_lvl14[3] =  lvl14_save[3];
-}
-
-void install_obp_ticker(void)
-{
-
-	if (!linux_lvl14)
-		return;
-	linux_lvl14[0] =  obp_lvl14[0];
-	linux_lvl14[1] =  obp_lvl14[1];
-	linux_lvl14[2] =  obp_lvl14[2];
-	linux_lvl14[3] =  obp_lvl14[3]; 
-}
diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
index 8c278c3..677b6a1 100644
--- a/arch/sparc/prom/misc_32.c
+++ b/arch/sparc/prom/misc_32.c
@@ -54,15 +54,11 @@ EXPORT_SYMBOL(prom_feval);
 void
 prom_cmdline(void)
 {
-	extern void install_obp_ticker(void);
-	extern void install_linux_ticker(void);
 	unsigned long flags;
 
 	spin_lock_irqsave(&prom_lock, flags);
-	install_obp_ticker();
 	(*(romvec->pv_abort))();
 	restore_current();
-	install_linux_ticker();
 	spin_unlock_irqrestore(&prom_lock, flags);
 	set_auxio(AUXIO_LED, 0);
 }
-- 
1.6.0.6

