From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 06:18:28 +0000
Subject: [PATCH 2/4] sparc32: setup cpu_possible_map
Message-Id: <448BB5B4.4070704@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040608040306040003090807"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040608040306040003090807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Setup cpu_possible_map so the secondary cpus will get started.

Signed-off-by: Bob Breuer <breuerr@mc.net>
---


--------------040608040306040003090807
Content-Type: text/plain;
 name="sparc32-cpu_possible_map.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-cpu_possible_map.patch.txt"

--- linux-2.6.17-rc1/arch/sparc/kernel/setup.c.orig	2006-04-04 00:02:00.000000000 -0500
+++ linux-2.6.17-rc1/arch/sparc/kernel/setup.c	2006-04-04 00:02:40.000000000 -0500
@@ -349,6 +349,8 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.context = (unsigned long) NO_CONTEXT;
 	init_task.thread.kregs = &fake_swapper_regs;
 
+	smp_setup_cpu_possible_map();
+
 	paging_init();
 }
 
--- linux-2.6.17-rc1/arch/sparc/kernel/smp.c.orig	2006-04-04 00:02:00.000000000 -0500
+++ linux-2.6.17-rc1/arch/sparc/kernel/smp.c	2006-04-04 00:02:40.000000000 -0500
@@ -256,22 +256,18 @@ int setup_profiling_timer(unsigned int m
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	extern void smp4m_boot_cpus(void);
-	int i, cpuid, ncpus, extra;
+	int i, cpuid, extra;
 
 	BUG_ON(sparc_cpu_model != sun4m);
 	printk("Entering SMP Mode...\n");
 
-	ncpus = 1;
 	extra = 0;
 	for (i = 0; !cpu_find_by_instance(i, NULL, &cpuid); i++) {
-		if (cpuid == boot_cpu_id)
-			continue;
-		if (cpuid < NR_CPUS && ncpus++ < max_cpus)
-			cpu_set(cpuid, phys_cpu_present_map);
-		else
+		if (cpuid >= NR_CPUS)
 			extra++;
 	}
-	if (max_cpus >= NR_CPUS && extra)
+	/* i = number of cpus */
+	if (extra && max_cpus > i - extra)
 		printk("Warning: NR_CPUS is too low to start all cpus\n");
 
 	smp_store_cpu_info(boot_cpu_id);
@@ -279,6 +275,24 @@ void __init smp_prepare_cpus(unsigned in
 	smp4m_boot_cpus();
 }
 
+/* Set this up early so that things like the scheduler can init
+ * properly.  We use the same cpu mask for both the present and
+ * possible cpu map.
+ */
+void __init smp_setup_cpu_possible_map(void)
+{
+	int instance, mid;
+
+	instance = 0;
+	while (!cpu_find_by_instance(instance, NULL, &mid)) {
+		if (mid < NR_CPUS) {
+			cpu_set(mid, phys_cpu_present_map);
+			cpu_set(mid, cpu_present_map);
+		}
+		instance++;
+	}
+}
+
 void __devinit smp_prepare_boot_cpu(void)
 {
 	int cpuid = hard_smp_processor_id();
--- linux-2.6.17-rc1/include/asm-sparc/smp.h.orig	2006-04-04 00:02:00.000000000 -0500
+++ linux-2.6.17-rc1/include/asm-sparc/smp.h	2006-04-04 00:02:40.000000000 -0500
@@ -146,6 +146,8 @@ static inline int hard_smp_processor_id(
 #define prof_multiplier(__cpu)		cpu_data(__cpu).multiplier
 #define prof_counter(__cpu)		cpu_data(__cpu).counter
 
+void smp_setup_cpu_possible_map(void);
+
 #endif /* !(__ASSEMBLY__) */
 
 /* Sparc specific messages. */
@@ -162,7 +164,11 @@ static inline int hard_smp_processor_id(
 #define MBOX_IDLECPU2         0xFD
 #define MBOX_STOPCPU2         0xFE
 
-#endif /* SMP */
+#else /* SMP */
+
+#define smp_setup_cpu_possible_map() do { } while (0)
+
+#endif /* !(SMP) */
 
 #define NO_PROC_ID            0xFF
 

--------------040608040306040003090807--
