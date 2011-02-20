From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 20:39:56 +0000
Subject: [PATCH 1/5] sparc32: fix build with leon or floppy enabled
Message-Id: <1298234400-22378-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add a few includes back required to build with floppy enabled
Fix declaration of trapbase_cpu* so it is now consistent

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h |    3 ---
 arch/sparc/kernel/irq_32.c    |    1 +
 arch/sparc/kernel/kernel.h    |    8 +++++---
 arch/sparc/kernel/leon_smp.c  |   20 +++++++++++---------
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 8580d17..c04f96f 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -375,9 +375,6 @@ void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
 
 extern unsigned int real_irq_entry[], smpleon_ticker[];
 extern unsigned int patchme_maybe_smp_msg[];
-extern unsigned long trapbase_cpu1[];
-extern unsigned long trapbase_cpu2[];
-extern unsigned long trapbase_cpu3[];
 extern unsigned int t_nmi[], linux_trap_ipi15_leon[];
 extern unsigned int linux_trap_ipi15_sun4m[];
 
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 974dab0..93afee0 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -14,6 +14,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
 
+#include <asm/cacheflush.h>
 #include <asm/pcic.h>
 #include <asm/leon.h>
 
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 7eb7363..24ad449 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -3,6 +3,8 @@
 
 #include <linux/interrupt.h>
 
+#include <asm/traps.h>
+
 /* cpu.c */
 extern const char *sparc_cpu_type;
 extern const char *sparc_pmu_type;
@@ -54,9 +56,9 @@ extern unsigned int t_nmi[];
 extern unsigned int linux_trap_ipi15_sun4d[];
 extern unsigned int linux_trap_ipi15_sun4m[];
 
-extern unsigned long trapbase_cpu1[];
-extern unsigned long trapbase_cpu2[];
-extern unsigned long trapbase_cpu3[];
+extern struct tt_entry trapbase_cpu1;
+extern struct tt_entry trapbase_cpu2;
+extern struct tt_entry trapbase_cpu3;
 
 extern char cputypval[];
 
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index e9df87f..8f5de4a 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -41,6 +41,8 @@
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
 
+#include "kernel.h"
+
 #ifdef CONFIG_SPARC_LEON
 
 #include "irq.h"
@@ -261,23 +263,23 @@ void __init leon_smp_done(void)
 
 	/* Free unneeded trap tables */
 	if (!cpu_isset(1, cpu_present_map)) {
-		ClearPageReserved(virt_to_page(trapbase_cpu1));
-		init_page_count(virt_to_page(trapbase_cpu1));
-		free_page((unsigned long)trapbase_cpu1);
+		ClearPageReserved(virt_to_page(&trapbase_cpu1));
+		init_page_count(virt_to_page(&trapbase_cpu1));
+		free_page((unsigned long)&trapbase_cpu1);
 		totalram_pages++;
 		num_physpages++;
 	}
 	if (!cpu_isset(2, cpu_present_map)) {
-		ClearPageReserved(virt_to_page(trapbase_cpu2));
-		init_page_count(virt_to_page(trapbase_cpu2));
-		free_page((unsigned long)trapbase_cpu2);
+		ClearPageReserved(virt_to_page(&trapbase_cpu2));
+		init_page_count(virt_to_page(&trapbase_cpu2));
+		free_page((unsigned long)&trapbase_cpu2);
 		totalram_pages++;
 		num_physpages++;
 	}
 	if (!cpu_isset(3, cpu_present_map)) {
-		ClearPageReserved(virt_to_page(trapbase_cpu3));
-		init_page_count(virt_to_page(trapbase_cpu3));
-		free_page((unsigned long)trapbase_cpu3);
+		ClearPageReserved(virt_to_page(&trapbase_cpu3));
+		init_page_count(virt_to_page(&trapbase_cpu3));
+		free_page((unsigned long)&trapbase_cpu3);
 		totalram_pages++;
 		num_physpages++;
 	}
-- 
1.6.0.6

