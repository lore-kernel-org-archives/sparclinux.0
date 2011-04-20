From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 09:41:20 +0000
Subject: [PATCH 1/8] sparc32: always define boot_cpu_id
Message-Id: <1303292487-12623-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch increases the data footprint with a few bytes in the
expense of more strightforward code in some places.
We may benefit more from this later as we will need the
boot_cpu_id in leon irq functions

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/setup.h |   12 ++++++++++++
 arch/sparc/kernel/setup_32.c   |    4 ++++
 arch/sparc/kernel/smp_32.c     |    2 --
 arch/sparc/kernel/sun4d_irq.c  |    4 +---
 4 files changed, 17 insertions(+), 5 deletions(-)

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
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 7b8b76c..7e1fce8 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -103,6 +103,10 @@ static unsigned int boot_flags __initdata = 0;
 /* Exported for mm/init.c:paging_init. */
 unsigned long cmdline_memory_size __initdata = 0;
 
+/* which CPU booted us */
+unsigned char boot_cpu_id;
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
index 14a0435..89cc63c 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -438,11 +438,9 @@ static void __init sun4d_init_timers(irq_handler_t counter_fn)
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

