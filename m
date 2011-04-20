From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 09:06:54 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <20110420090654.GA25935@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>
> Yes, it might remove a ifdef to the expence of a bigger footprint.
>
>> Note: leon actually set this variable in head_32.S already.
>>  
>>
> I agree that it would be nicer, however I think the SUNs will never be  
> booted on CPU1 anyway? Anyways, I think this should go into another  
> patch series.

I have implmented what I have in mind in following patch.
You can add this to your serie and we have this prepared
for further cleanup.

Just add your sob below mine and forward to David.

	Sam

[PATCH]sparc32: always define boot_cpu_id

This patch increases the data footprint with a few bytes in the
expense of more strightforward code in some places.
We may benefit more from this later as we will need the
boot_cpu_id in leon irq functions

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
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
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 8f5de4a..9a2e9b5 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -50,7 +50,6 @@
 extern ctxd_t *srmmu_ctx_table_phys;
 static int smp_processors_ready;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
-extern unsigned char boot_cpu_id;
 extern cpumask_t smp_commenced_mask;
 void __init leon_configure_cache_smp(void);
 
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
