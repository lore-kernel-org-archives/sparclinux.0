From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Apr 2011 14:20:23 +0000
Subject: [PATCH 1/3] sparc32: always define boot_cpu_id
Message-Id: <1303395625-6911-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Define boot_cpu_id in single-processor kernels as well. This is
to support architectures which can boot on other than CPU0.

Sam Ravnborg has written the cleanup parts by extracting
boot_cpu_id from smp_32.c into setup_32.c and cleaned up
sun4d_irq.c.

boot_cpu_id was initialized before BSS was cleared in
sun4c_continue_boot, instead boot_cpu_id is set to 0xff to
avoid BSS. If boot_cpu_id is untouched (0xff) by bootup code
it will be overwritten to 0. boot_cpu_id4 is automatically
calculated in common code.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/setup.h |   12 ++++++++++++
 arch/sparc/kernel/head_32.S    |   26 +++++++++++++++++---------
 arch/sparc/kernel/setup_32.c   |    4 ++++
 arch/sparc/kernel/smp_32.c     |    2 --
 arch/sparc/kernel/sun4d_irq.c  |    5 ++---
 5 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 2643c62..64718ba 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -11,4 +11,16 @@
 # define COMMAND_LINE_SIZE 256
 #endif
 
+#ifdef __KERNEL__
+
+#ifdef CONFIG_SPARC32
+/* The CPU that was used for booting
+ * Only sun4d + leon may have boot_cpu_id != 0
+ */
+extern unsigned char boot_cpu_id;
+extern unsigned char boot_cpu_id4;
+#endif
+
+#endif /* __KERNEL__ */
+
 #endif /* _SPARC_SETUP_H */
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 5942349..520c615 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -816,10 +816,7 @@ got_prop:
 
 		.global leon_smp_init
 leon_smp_init:
-		sethi	%hi(boot_cpu_id), %g1    ! master always 0
-		stb	%g0, [%g1 + %lo(boot_cpu_id)]
-		sethi	%hi(boot_cpu_id4), %g1   ! master always 0
-		stb	%g0, [%g1 + %lo(boot_cpu_id4)]
+		/* let boot_cpu_id default to 0 (master always 0) */
 
 		rd     %asr17,%g1
 		srl    %g1,28,%g1
@@ -893,9 +890,6 @@ sun4d_init:
 	sta     %g4, [%g0] ASI_M_VIKING_TMP1
 	sethi	%hi(boot_cpu_id), %g5
 	stb	%g4, [%g5 + %lo(boot_cpu_id)]
-	sll	%g4, 2, %g4
-	sethi	%hi(boot_cpu_id4), %g5
-	stb	%g4, [%g5 + %lo(boot_cpu_id4)]
 #endif
 
 	/* Fall through to sun4m_init */
@@ -1024,14 +1018,28 @@ sun4c_continue_boot:
 		bl	1b
 		 add	%o0, 0x1, %o0
 
+		/* If boot_cpu_id has not been setup by machine specific
+		 * init-code above we default it to zero.
+		 */
+		sethi	%hi(boot_cpu_id), %g2
+		ldub	[%g2 + %lo(boot_cpu_id)], %g3
+		cmp	%g3, 0xff
+		bne	1f
+		 nop
+		mov	%g0, %g3
+		stub	%g3, [%g2 + %lo(boot_cpu_id)]
+
+1:		/* boot_cpu_id set. calculate boot_cpu_id4 = boot_cpu_id*4 */
+		sll	%g3, 2, %g3
+		sethi	%hi(boot_cpu_id4), %g2
+		stub	%g3, [%g2 + %lo(boot_cpu_id4)]
+
 		/* Initialize the uwinmask value for init task just in case.
 		 * But first make current_set[boot_cpu_id] point to something useful.
 		 */
 		set	init_thread_union, %g6
 		set	current_set, %g2
 #ifdef CONFIG_SMP
-		sethi	%hi(boot_cpu_id4), %g3
-		ldub	[%g3 + %lo(boot_cpu_id4)], %g3
 		st	%g6, [%g2]
 		add	%g2, %g3, %g2
 #endif
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 7b8b76c..e3fc6e2 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -103,6 +103,10 @@ static unsigned int boot_flags __initdata = 0;
 /* Exported for mm/init.c:paging_init. */
 unsigned long cmdline_memory_size __initdata = 0;
 
+/* which CPU booted us (0xff = not set) */
+unsigned char boot_cpu_id = 0xff; /* 0xff will make it into DATA section... */
+unsigned char boot_cpu_id4; /* boot_cpu_id << 2 */
+
 static void
 prom_console_write(struct console *con, const char *s, unsigned n)
 {
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 91c10fb..4a1d5b7 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -37,8 +37,6 @@
 #include "irq.h"
 
 volatile unsigned long cpu_callin_map[NR_CPUS] __cpuinitdata = {0,};
-unsigned char boot_cpu_id = 0;
-unsigned char boot_cpu_id4 = 0; /* boot_cpu_id << 2 */
 
 cpumask_t smp_commenced_mask = CPU_MASK_NONE;
 
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 14a0435..b830914 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <asm/sbi.h>
 #include <asm/cacheflush.h>
+#include <asm/setup.h>
 
 #include "kernel.h"
 #include "irq.h"
@@ -438,11 +439,9 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
 void __init sun4d_init_sbi_irq(void)
 {
 	struct device_node *dp;
-	int target_cpu = 0;
+	int target_cpu;
 
-#ifdef CONFIG_SMP
 	target_cpu = boot_cpu_id;
-#endif
 	for_each_node_by_name(dp, "sbi") {
 		int devid = of_getintprop_default(dp, "device-id", 0);
 		int board = of_getintprop_default(dp, "board#", 0);
-- 
1.5.4

