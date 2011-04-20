From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 20:09:00 +0000
Subject: [PATCH 2/3] sparc: consolidate show_cpuinfo in cpu.c
Message-Id: <1303330141-31123-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We have all the cpu related info in cpu.c - so move
the remaining functions to support /proc/cpuinfo to this file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_64.h |    3 +
 arch/sparc/include/asm/smp_64.h     |    4 +
 arch/sparc/include/asm/system_64.h  |    4 -
 arch/sparc/kernel/cpu.c             |  127 ++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/kernel.h          |    4 +-
 arch/sparc/kernel/perf_event.c      |    1 +
 arch/sparc/kernel/setup_32.c        |   69 -------------------
 arch/sparc/kernel/setup_64.c        |   78 ---------------------
 8 files changed, 133 insertions(+), 157 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index f8dddb7..b77128c 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -699,6 +699,9 @@ extern pmd_t swapper_low_pmd_dir[2048];
 extern void paging_init(void);
 extern unsigned long find_ecache_flush_span(unsigned long size);
 
+struct seq_file;
+extern void mmu_info(struct seq_file *);
+
 /* These do nothing with the way I have things setup. */
 #define mmu_lockarea(vaddr, len)		(vaddr)
 #define mmu_unlockarea(vaddr, len)		do { } while(0)
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index f49e11c..20bca89 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -49,6 +49,10 @@ extern void cpu_play_dead(void);
 
 extern void smp_fetch_global_regs(void);
 
+struct seq_file;
+void smp_bogo(struct seq_file *);
+void smp_info(struct seq_file *);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
diff --git a/arch/sparc/include/asm/system_64.h b/arch/sparc/include/asm/system_64.h
index e3b65d8..3c96d3b 100644
--- a/arch/sparc/include/asm/system_64.h
+++ b/arch/sparc/include/asm/system_64.h
@@ -29,10 +29,6 @@ enum sparc_cpu {
 /* This cannot ever be a sun4c :) That's just history. */
 #define ARCH_SUN4C 0
 
-extern const char *sparc_cpu_type;
-extern const char *sparc_fpu_type;
-extern const char *sparc_pmu_type;
-
 extern char reboot_command[];
 
 /* These are here in an effort to more fully work around Spitfire Errata
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 7925c54..c3483c7 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -4,6 +4,7 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/seq_file.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -11,7 +12,9 @@
 #include <linux/threads.h>
 
 #include <asm/spitfire.h>
+#include <asm/pgtable.h>
 #include <asm/oplib.h>
+#include <asm/setup.h>
 #include <asm/page.h>
 #include <asm/head.h>
 #include <asm/psr.h>
@@ -23,6 +26,9 @@
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
 EXPORT_PER_CPU_SYMBOL(__cpu_data);
 
+int ncpus_probed;
+unsigned int fsr_storage;
+
 struct cpu_info {
 	int psr_vers;
 	const char *name;
@@ -247,11 +253,10 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
  * machine type value into consideration too.  I will fix this.
  */
 
-const char *sparc_cpu_type;
-const char *sparc_fpu_type;
+static const char *sparc_cpu_type;
+static const char *sparc_fpu_type;
 const char *sparc_pmu_type;
 
-unsigned int fsr_storage;
 
 static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 {
@@ -313,6 +318,122 @@ static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 }
 
 #ifdef CONFIG_SPARC32
+static int show_cpuinfo(struct seq_file *m, void *__unused)
+{
+	seq_printf(m,
+		   "cpu\t\t: %s\n"
+		   "fpu\t\t: %s\n"
+		   "promlib\t\t: Version %d Revision %d\n"
+		   "prom\t\t: %d.%d\n"
+		   "type\t\t: %s\n"
+		   "ncpus probed\t: %d\n"
+		   "ncpus active\t: %d\n"
+#ifndef CONFIG_SMP
+		   "CPU0Bogo\t: %lu.%02lu\n"
+		   "CPU0ClkTck\t: %ld\n"
+#endif
+		   ,
+		   sparc_cpu_type,
+		   sparc_fpu_type ,
+		   romvec->pv_romvers,
+		   prom_rev,
+		   romvec->pv_printrev >> 16,
+		   romvec->pv_printrev & 0xffff,
+		   &cputypval[0],
+		   ncpus_probed,
+		   num_online_cpus()
+#ifndef CONFIG_SMP
+		   , cpu_data(0).udelay_val/(500000/HZ),
+		   (cpu_data(0).udelay_val/(5000/HZ)) % 100,
+		   cpu_data(0).clock_tick
+#endif
+		);
+
+#ifdef CONFIG_SMP
+	smp_bogo(m);
+#endif
+	mmu_info(m);
+#ifdef CONFIG_SMP
+	smp_info(m);
+#endif
+	return 0;
+}
+#endif /* CONFIG_SPARC32 */
+
+#ifdef CONFIG_SPARC64
+unsigned int dcache_parity_tl1_occurred;
+unsigned int icache_parity_tl1_occurred;
+
+
+static int show_cpuinfo(struct seq_file *m, void *__unused)
+{
+	seq_printf(m,
+		   "cpu\t\t: %s\n"
+		   "fpu\t\t: %s\n"
+		   "pmu\t\t: %s\n"
+		   "prom\t\t: %s\n"
+		   "type\t\t: %s\n"
+		   "ncpus probed\t: %d\n"
+		   "ncpus active\t: %d\n"
+		   "D$ parity tl1\t: %u\n"
+		   "I$ parity tl1\t: %u\n"
+#ifndef CONFIG_SMP
+		   "Cpu0ClkTck\t: %016lx\n"
+#endif
+		   ,
+		   sparc_cpu_type,
+		   sparc_fpu_type,
+		   sparc_pmu_type,
+		   prom_version,
+		   ((tlb_type = hypervisor) ?
+		    "sun4v" :
+		    "sun4u"),
+		   ncpus_probed,
+		   num_online_cpus(),
+		   dcache_parity_tl1_occurred,
+		   icache_parity_tl1_occurred
+#ifndef CONFIG_SMP
+		   , cpu_data(0).clock_tick
+#endif
+		);
+#ifdef CONFIG_SMP
+	smp_bogo(m);
+#endif
+	mmu_info(m);
+#ifdef CONFIG_SMP
+	smp_info(m);
+#endif
+	return 0;
+}
+#endif /* CONFIG_SPARC64 */
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	/* The pointer we are returning is arbitrary,
+	 * it just has to be non-NULL and not IS_ERR
+	 * in the success case.
+	 */
+	return *pos = 0 ? &c_start : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start =c_start,
+	.next =	c_next,
+	.stop =	c_stop,
+	.show =	show_cpuinfo,
+};
+
+#ifdef CONFIG_SPARC32
 void __cpuinit cpu_probe(void)
 {
 	int psr_impl, psr_vers, fpu_vers;
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 487d67a..6f6544c 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -6,11 +6,9 @@
 #include <asm/traps.h>
 
 /* cpu.c */
-extern const char *sparc_cpu_type;
 extern const char *sparc_pmu_type;
-extern const char *sparc_fpu_type;
-
 extern unsigned int fsr_storage;
+extern int ncpus_probed;
 
 #ifdef CONFIG_SPARC32
 /* cpu.c */
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index ee8426e..2cb0e1c 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -26,6 +26,7 @@
 #include <asm/nmi.h>
 #include <asm/pcr.h>
 
+#include "kernel.h"
 #include "kstack.h"
 
 /* Sparc64 chips have two performance counters, 32-bits each, with
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 7b8b76c..8f3031f 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -311,75 +311,6 @@ void __init setup_arch(char **cmdline_p)
 	smp_setup_cpu_possible_map();
 }
 
-static int ncpus_probed;
-
-static int show_cpuinfo(struct seq_file *m, void *__unused)
-{
-	seq_printf(m,
-		   "cpu\t\t: %s\n"
-		   "fpu\t\t: %s\n"
-		   "promlib\t\t: Version %d Revision %d\n"
-		   "prom\t\t: %d.%d\n"
-		   "type\t\t: %s\n"
-		   "ncpus probed\t: %d\n"
-		   "ncpus active\t: %d\n"
-#ifndef CONFIG_SMP
-		   "CPU0Bogo\t: %lu.%02lu\n"
-		   "CPU0ClkTck\t: %ld\n"
-#endif
-		   ,
-		   sparc_cpu_type,
-		   sparc_fpu_type ,
-		   romvec->pv_romvers,
-		   prom_rev,
-		   romvec->pv_printrev >> 16,
-		   romvec->pv_printrev & 0xffff,
-		   &cputypval[0],
-		   ncpus_probed,
-		   num_online_cpus()
-#ifndef CONFIG_SMP
-		   , cpu_data(0).udelay_val/(500000/HZ),
-		   (cpu_data(0).udelay_val/(5000/HZ)) % 100,
-		   cpu_data(0).clock_tick
-#endif
-		);
-
-#ifdef CONFIG_SMP
-	smp_bogo(m);
-#endif
-	mmu_info(m);
-#ifdef CONFIG_SMP
-	smp_info(m);
-#endif
-	return 0;
-}
-
-static void *c_start(struct seq_file *m, loff_t *pos)
-{
-	/* The pointer we are returning is arbitrary,
-	 * it just has to be non-NULL and not IS_ERR
-	 * in the success case.
-	 */
-	return *pos = 0 ? &c_start : NULL;
-}
-
-static void *c_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return c_start(m, pos);
-}
-
-static void c_stop(struct seq_file *m, void *v)
-{
-}
-
-const struct seq_operations cpuinfo_op = {
-	.start =c_start,
-	.next =	c_next,
-	.stop =	c_stop,
-	.show =	show_cpuinfo,
-};
-
 extern int stop_a_enabled;
 
 void sun_do_break(void)
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 29bafe0..f3b6850 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -339,84 +339,6 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 }
 
-/* BUFFER is PAGE_SIZE bytes long. */
-
-extern void smp_info(struct seq_file *);
-extern void smp_bogo(struct seq_file *);
-extern void mmu_info(struct seq_file *);
-
-unsigned int dcache_parity_tl1_occurred;
-unsigned int icache_parity_tl1_occurred;
-
-int ncpus_probed;
-
-static int show_cpuinfo(struct seq_file *m, void *__unused)
-{
-	seq_printf(m, 
-		   "cpu\t\t: %s\n"
-		   "fpu\t\t: %s\n"
-		   "pmu\t\t: %s\n"
-		   "prom\t\t: %s\n"
-		   "type\t\t: %s\n"
-		   "ncpus probed\t: %d\n"
-		   "ncpus active\t: %d\n"
-		   "D$ parity tl1\t: %u\n"
-		   "I$ parity tl1\t: %u\n"
-#ifndef CONFIG_SMP
-		   "Cpu0ClkTck\t: %016lx\n"
-#endif
-		   ,
-		   sparc_cpu_type,
-		   sparc_fpu_type,
-		   sparc_pmu_type,
-		   prom_version,
-		   ((tlb_type = hypervisor) ?
-		    "sun4v" :
-		    "sun4u"),
-		   ncpus_probed,
-		   num_online_cpus(),
-		   dcache_parity_tl1_occurred,
-		   icache_parity_tl1_occurred
-#ifndef CONFIG_SMP
-		   , cpu_data(0).clock_tick
-#endif
-		);
-#ifdef CONFIG_SMP
-	smp_bogo(m);
-#endif
-	mmu_info(m);
-#ifdef CONFIG_SMP
-	smp_info(m);
-#endif
-	return 0;
-}
-
-static void *c_start(struct seq_file *m, loff_t *pos)
-{
-	/* The pointer we are returning is arbitrary,
-	 * it just has to be non-NULL and not IS_ERR
-	 * in the success case.
-	 */
-	return *pos = 0 ? &c_start : NULL;
-}
-
-static void *c_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	++*pos;
-	return c_start(m, pos);
-}
-
-static void c_stop(struct seq_file *m, void *v)
-{
-}
-
-const struct seq_operations cpuinfo_op = {
-	.start =c_start,
-	.next =	c_next,
-	.stop =	c_stop,
-	.show =	show_cpuinfo,
-};
-
 extern int stop_a_enabled;
 
 void sun_do_break(void)
-- 
1.6.0.6

