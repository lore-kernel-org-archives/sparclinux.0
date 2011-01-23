From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 21:41:05 +0000
Subject: [PATCH 2/7] sparc32: add irq + smp declarations to headers
Message-Id: <1295818870-25450-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In preparation for cleaning up a number of files add
declarations for irq and smp related data/functions to
the relevant headers.

This showed that the extern declaration of cputypval differed
in the two files where it was used.
As cputypval is defined like this:

cputypval:
        .asciz "sun4c"

the correct representation is a char array.
Fix users to use the new declaration.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/mmu_32.h |    3 ++
 arch/sparc/include/asm/smp_32.h |    6 +++++
 arch/sparc/kernel/irq_32.c      |    6 ++--
 arch/sparc/kernel/kernel.h      |   47 +++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/setup_32.c    |   19 +++++++--------
 5 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/mmu_32.h b/arch/sparc/include/asm/mmu_32.h
index ccd36d2..6f056e5 100644
--- a/arch/sparc/include/asm/mmu_32.h
+++ b/arch/sparc/include/asm/mmu_32.h
@@ -4,4 +4,7 @@
 /* Default "unsigned long" context */
 typedef unsigned long mm_context_t;
 
+/* mm/srmmu.c */
+extern ctxd_t *srmmu_ctx_table_phys;
+
 #endif
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 841905c..d82d7f4 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -29,10 +29,16 @@
  */
 
 extern unsigned char boot_cpu_id;
+extern volatile unsigned long cpu_callin_map[NR_CPUS];
+extern cpumask_t smp_commenced_mask;
+extern struct linux_prom_registers smp_penguin_ctable;
 
 typedef void (*smpfunc_t)(unsigned long, unsigned long, unsigned long,
 		       unsigned long, unsigned long);
 
+void cpu_panic(void);
+extern void smp4m_irq_rotate(int cpu);
+
 /*
  *	General functions that each host system must provide.
  */
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 5ad6e5c..1c0634e 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -130,9 +130,9 @@ EXPORT_SYMBOL(arch_local_irq_restore);
 
 static void irq_panic(void)
 {
-    extern char *cputypval;
-    prom_printf("machine: %s doesn't have irq handlers defined!\n",cputypval);
-    prom_halt();
+	prom_printf("machine: %s doesn't have irq handlers defined!\n",
+		    &cputypval[0]);
+	prom_halt();
 }
 
 void (*sparc_init_timers)(irq_handler_t ) diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 15d8a3f..7eb7363 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -26,6 +26,53 @@ extern int static_irq_count;
 extern spinlock_t irq_action_lock;
 
 extern void unexpected_irq(int irq, void *dev_id, struct pt_regs * regs);
+extern void init_IRQ(void);
+
+/* sun4c_irq.c */
+extern void sun4c_init_IRQ(void);
+
+/* sun4m_irq.c */
+extern unsigned int lvl14_resolution;
+
+extern void sun4m_init_IRQ(void);
+extern void sun4m_clear_profile_irq(int cpu);
+
+/* sun4d_irq.c */
+extern spinlock_t sun4d_imsk_lock;
+
+extern void sun4d_init_IRQ(void);
+extern int sun4d_request_irq(unsigned int irq,
+                             irq_handler_t handler,
+                             unsigned long irqflags,
+                             const char *devname, void *dev_id);
+extern int show_sun4d_interrupts(struct seq_file *, void *);
+extern void sun4d_distribute_irqs(void);
+extern void sun4d_free_irq(unsigned int irq, void *dev_id);
+
+/* head_32.S */
+extern unsigned int t_nmi[];
+extern unsigned int linux_trap_ipi15_sun4d[];
+extern unsigned int linux_trap_ipi15_sun4m[];
+
+extern unsigned long trapbase_cpu1[];
+extern unsigned long trapbase_cpu2[];
+extern unsigned long trapbase_cpu3[];
+
+extern char cputypval[];
+
+/* entry.S */
+extern unsigned long lvl14_save[4];
+extern unsigned int real_irq_entry[];
+extern unsigned int smp4d_ticker[];
+extern unsigned int patchme_maybe_smp_msg[];
+
+extern void floppy_hardint(void);
+
+/* trampoline_32.S */
+extern int __smp4m_processor_id(void);
+extern int __smp4d_processor_id(void);
+extern unsigned long sun4m_cpu_startup;
+extern unsigned long sun4d_cpu_startup;
 
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 648f216..7b8b76c 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -184,7 +184,6 @@ static void __init boot_flags_init(char *commands)
  */
 
 extern void sun4c_probe_vac(void);
-extern char cputypval;
 
 extern unsigned short root_flags;
 extern unsigned short root_dev;
@@ -218,21 +217,21 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
-	if (!strcmp(&cputypval,"sun4 "))
+	if (!strcmp(&cputypval[0], "sun4 "))
 		sparc_cpu_model = sun4;
-	if (!strcmp(&cputypval,"sun4c"))
+	if (!strcmp(&cputypval[0], "sun4c"))
 		sparc_cpu_model = sun4c;
-	if (!strcmp(&cputypval,"sun4m"))
+	if (!strcmp(&cputypval[0], "sun4m"))
 		sparc_cpu_model = sun4m;
-	if (!strcmp(&cputypval,"sun4s"))
+	if (!strcmp(&cputypval[0], "sun4s"))
 		sparc_cpu_model = sun4m; /* CP-1200 with PROM 2.30 -E */
-	if (!strcmp(&cputypval,"sun4d"))
+	if (!strcmp(&cputypval[0], "sun4d"))
 		sparc_cpu_model = sun4d;
-	if (!strcmp(&cputypval,"sun4e"))
+	if (!strcmp(&cputypval[0], "sun4e"))
 		sparc_cpu_model = sun4e;
-	if (!strcmp(&cputypval,"sun4u"))
+	if (!strcmp(&cputypval[0], "sun4u"))
 		sparc_cpu_model = sun4u;
-	if (!strncmp(&cputypval, "leon" , 4))
+	if (!strncmp(&cputypval[0], "leon" , 4))
 		sparc_cpu_model = sparc_leon;
 
 	printk("ARCH: ");
@@ -335,7 +334,7 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 		   prom_rev,
 		   romvec->pv_printrev >> 16,
 		   romvec->pv_printrev & 0xffff,
-		   &cputypval,
+		   &cputypval[0],
 		   ncpus_probed,
 		   num_online_cpus()
 #ifndef CONFIG_SMP
-- 
1.6.0.6

