From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:24 +0000
Subject: [PATCH 19/34] sparc64: fix sparse warnings in smp_64.c
Message-Id: <1399157559-19901-19-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
smp_64.c:88:6: warning: symbol 'smp_callin' was not declared. Should it be static?
smp_64.c:133:6: warning: symbol 'cpu_panic' was not declared. Should it be static?
smp_64.c:187:6: warning: symbol 'smp_synchronize_tick_client' was not declared. Should it be static?
smp_64.c:821:18: warning: symbol 'smp_call_function_client' was not declared. Should it be static?
smp_64.c:827:18: warning: symbol 'smp_call_function_single_client' was not declared. Should it be static?
smp_64.c:964:18: warning: symbol 'smp_new_mmu_context_version_client' was not declared. Should it be static?
smp_64.c:1149:6: warning: symbol 'smp_capture' was not declared. Should it be static?
smp_64.c:1171:6: warning: symbol 'smp_release' was not declared. Should it be static?
smp_64.c:1190:18: warning: symbol 'smp_penguin_jailcell' was not declared. Should it be static?
smp_64.c:1410:18: warning: symbol 'smp_receive_signal_client' was not declared. Should it be static?

Add prototypes in kernel.h or asm/smp_64.h as appropriate.
Delete duplicate function kimage_addr_to_ra(), and
adapt parameter to const void * to match the broader use.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/smp_64.h |  6 ++++++
 arch/sparc/kernel/kernel.h      | 10 +++++++++-
 arch/sparc/kernel/smp_64.c      |  9 +--------
 arch/sparc/prom/misc_64.c       |  5 -----
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 753c9d9..26d9e77 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -53,6 +53,12 @@ struct seq_file;
 void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
+void smp_callin(void);
+void cpu_panic(void);
+void smp_synchronize_tick_client(void);
+void smp_capture(void);
+void smp_release(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void);
 void __cpu_die(unsigned int cpu);
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index e122b4b..5ab4bc2 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -2,6 +2,7 @@
 #define __SPARC_KERNEL_H
 
 #include <linux/interrupt.h>
+#include <linux/ftrace.h>
 
 #include <asm/traps.h>
 #include <asm/head.h>
@@ -17,7 +18,7 @@ extern int ncpus_probed;
 struct seq_file;
 void cpucap_info(struct seq_file *);
 
-static inline unsigned long kimage_addr_to_ra(const char *p)
+static inline unsigned long kimage_addr_to_ra(const void *p)
 {
 	unsigned long val = (unsigned long) p;
 
@@ -33,6 +34,13 @@ int handle_popc(u32 insn, struct pt_regs *regs);
 void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr);
 void handle_stdfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr);
 
+/* smp_64.c */
+void __irq_entry smp_call_function_client(int irq, struct pt_regs *regs);
+void __irq_entry smp_call_function_single_client(int irq, struct pt_regs *regs);
+void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *regs);
+void __irq_entry smp_penguin_jailcell(int irq, struct pt_regs *regs);
+void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
+
 #endif
 
 #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 9781048..df91e78 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -52,6 +52,7 @@
 #include <asm/pcr.h>
 
 #include "cpumap.h"
+#include "kernel.h"
 
 DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly @@ -272,14 +273,6 @@ static void smp_synchronize_one_tick(int cpu)
 }
 
 #if defined(CONFIG_SUN_LDOMS) && defined(CONFIG_HOTPLUG_CPU)
-/* XXX Put this in some common place. XXX */
-static unsigned long kimage_addr_to_ra(void *p)
-{
-	unsigned long val = (unsigned long) p;
-
-	return kern_base + (val - KERNBASE);
-}
-
 static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
 				void **descrp)
 {
diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index f178b9d..53a696d 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -81,11 +81,6 @@ void prom_feval(const char *fstring)
 }
 EXPORT_SYMBOL(prom_feval);
 
-#ifdef CONFIG_SMP
-extern void smp_capture(void);
-extern void smp_release(void);
-#endif
-
 /* Drop into the prom, with the chance to continue with the 'go'
  * prom command.
  */
-- 
1.9.0

