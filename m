From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 13 Oct 2011 07:00:05 +0000
Subject: [PATCH 4/4] sparc32: Add support for KGDB with SMP for leon and sun4d
Message-Id: <1318489205-315-5-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch enables KGDB support when SMP is enabled. kgdb_nmicallback
calls for leon and sun4d are implemented. For sun4m the smp4m_ipi_kgdbcapture
is still a stub to be implemented later.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/Kconfig              |    2 +-
 arch/sparc/include/asm/smp_32.h |    3 +++
 arch/sparc/kernel/entry.S       |    2 +-
 arch/sparc/kernel/irq.h         |    2 +-
 arch/sparc/kernel/leon_smp.c    |   31 +++++++++++++++++++++++++++++--
 arch/sparc/kernel/smp_32.c      |   14 ++++++++++++++
 arch/sparc/kernel/sun4d_irq.c   |    2 +-
 arch/sparc/kernel/sun4d_smp.c   |   30 ++++++++++++++++++++++++++++--
 arch/sparc/kernel/sun4m_smp.c   |   11 +++++++++++
 9 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 253986b..ad333a4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -16,7 +16,7 @@ config SPARC
 	select OF_PROMTREE
 	select HAVE_IDE
 	select HAVE_OPROFILE
-	select HAVE_ARCH_KGDB if !SMP || SPARC64
+	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select RTC_CLASS
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 093f108..f8fe5c1 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -60,6 +60,9 @@ void smp_info(struct seq_file *);
 
 BTFIXUPDEF_CALL(void, smp_cross_call, smpfunc_t, cpumask_t, unsigned long, unsigned long, unsigned long, unsigned long)
 BTFIXUPDEF_CALL(int, __hard_smp_processor_id, void)
+#ifdef CONFIG_KGDB
+BTFIXUPDEF_CALL(void, smp_ipi_kgdbcapture, int);
+#endif
 BTFIXUPDEF_CALL(void, smp_ipi_resched, int);
 BTFIXUPDEF_CALL(void, smp_ipi_single, int);
 BTFIXUPDEF_CALL(void, smp_ipi_mask_one, int);
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index f445e98..4c4c20f 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -433,7 +433,7 @@ smpleon_ipi:
 	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	call	leonsmp_ipi_interrupt
-	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
+	 add	%sp, STACKFRAME_SZ, %o0 ! pt_regs
 	wr	%l0, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 100b9c2..a66118b 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -90,6 +90,6 @@ BTFIXUPDEF_CALL(void, set_irq_udt, int)
 /* All SUN4D IPIs are sent on this IRQ, may be shared with hard IRQs */
 #define SUN4D_IPI_IRQ 14
 
-extern void sun4d_ipi_interrupt(void);
+extern void sun4d_ipi_interrupt(struct pt_regs *regs);
 
 #endif
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index fe8fb44..cfb2b58 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -9,6 +9,8 @@
 #include <asm/head.h>
 
 #include <linux/kernel.h>
+#include <linux/kgdb.h>
+#include <linux/kdebug.h>
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <linux/smp.h>
@@ -42,6 +44,7 @@
 #include <asm/asi.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
+#include <asm/kdebug.h>
 
 #include "kernel.h"
 
@@ -306,6 +309,7 @@ struct leon_ipi_work {
 	int single;
 	int msk;
 	int resched;
+	int kgdbcapture;
 };
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct leon_ipi_work, leon_ipi_work);
@@ -340,7 +344,7 @@ static void __init leon_ipi_init(void)
 
 	for_each_possible_cpu(cpu) {
 		work = &per_cpu(leon_ipi_work, cpu);
-		work->single = work->msk = work->resched = 0;
+		work->single = work->msk = work->resched = work->kgdbcapture = 0;
 	}
 }
 
@@ -355,6 +359,19 @@ static void leon_ipi_single(int cpu)
 	set_cpu_int(cpu, leon_ipi_irq);
 }
 
+#ifdef CONFIG_KGDB
+static void leon_ipi_kgdbcapture(int cpu)
+{
+	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
+
+	/* Mark work */
+	work->kgdbcapture = 1;
+
+	/* Generate IRQ on the CPU */
+	set_cpu_int(cpu, leon_ipi_irq);
+}
+#endif
+
 static void leon_ipi_mask_one(int cpu)
 {
 	struct leon_ipi_work *work = &per_cpu(leon_ipi_work, cpu);
@@ -377,7 +394,7 @@ static void leon_ipi_resched(int cpu)
 	set_cpu_int(cpu, leon_ipi_irq);
 }
 
-void leonsmp_ipi_interrupt(void)
+void leonsmp_ipi_interrupt(struct pt_regs *regs)
 {
 	struct leon_ipi_work *work = &__get_cpu_var(leon_ipi_work);
 
@@ -393,6 +410,13 @@ void leonsmp_ipi_interrupt(void)
 		work->resched = 0;
 		smp_resched_interrupt();
 	}
+	if (work->kgdbcapture) {
+		work->kgdbcapture = 0;
+#ifdef CONFIG_KGDB
+		if (atomic_read(&kgdb_active) != -1)
+			kgdb_nmicallback(raw_smp_processor_id(), regs);
+#endif
+	}
 }
 
 static struct smp_funcall {
@@ -548,6 +572,9 @@ void __init leon_init_smp(void)
 	BTFIXUPSET_CALL(smp_cross_call, leon_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __leon_processor_id,
 			BTFIXUPCALL_NORM);
+#ifdef CONFIG_KGDB
+	BTFIXUPSET_CALL(smp_ipi_kgdbcapture, leon_ipi_kgdbcapture, BTFIXUPCALL_NORM);
+#endif
 	BTFIXUPSET_CALL(smp_ipi_resched, leon_ipi_resched, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_single, leon_ipi_single, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_mask_one, leon_ipi_mask_one, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 21b1253..331902a 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -179,6 +179,20 @@ void smp_call_function_interrupt(void)
 	irq_exit();
 }
 
+#ifdef CONFIG_KGDB
+void kgdb_roundup_cpus(unsigned long flags)
+{
+	int i, this_cpu = smp_processor_id();
+	const cpumask_t *mask = cpu_online_mask;
+	
+	for_each_cpu(i, mask) {
+		if (i = this_cpu || !cpu_online(i))
+			continue;
+		BTFIXUP_CALL(smp_ipi_kgdbcapture)(i);
+	}
+}
+#endif
+
 void smp_flush_cache_all(void)
 {
 	xc0((smpfunc_t) BTFIXUP_CALL(local_flush_cache_all));
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 1d13c5b..31296f2 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -158,7 +158,7 @@ void sun4d_handler_irq(int pil, struct pt_regs *regs)
 	 * IRQ can happen at the same time, so both cases are always handled.
 	 */
 	if (pil = SUN4D_IPI_IRQ)
-		sun4d_ipi_interrupt();
+		sun4d_ipi_interrupt(regs);
 #endif
 
 	old_regs = set_irq_regs(regs);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 1333879..9010a06 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -10,6 +10,7 @@
 #include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/kgdb.h>
 
 #include <asm/sbi.h>
 #include <asm/mmu.h>
@@ -196,6 +197,7 @@ struct sun4d_ipi_work {
 	int single;
 	int msk;
 	int resched;
+	int kgdbcapture;
 };
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct sun4d_ipi_work, sun4d_ipi_work);
@@ -210,11 +212,11 @@ static void __init smp4d_ipi_init(void)
 
 	for_each_possible_cpu(cpu) {
 		work = &per_cpu(sun4d_ipi_work, cpu);
-		work->single = work->msk = work->resched = 0;
+		work->single = work->msk = work->resched = work->kgdbcapture = 0;
 	}
 }
 
-void sun4d_ipi_interrupt(void)
+void sun4d_ipi_interrupt(struct pt_regs *regs)
 {
 	struct sun4d_ipi_work *work = &__get_cpu_var(sun4d_ipi_work);
 
@@ -230,7 +232,28 @@ void sun4d_ipi_interrupt(void)
 		work->resched = 0;
 		smp_resched_interrupt();
 	}
+	if (work->kgdbcapture) {
+		work->kgdbcapture = 0;
+#ifdef CONFIG_KGDB
+		if (atomic_read(&kgdb_active) != -1)
+			kgdb_nmicallback(raw_smp_processor_id(), regs);
+#endif
+	}
+	
+}
+
+#ifdef CONFIG_KGDB
+static void smp4d_ipi_kgdbcapture(int cpu)
+{
+	struct sun4d_ipi_work *work = &per_cpu(sun4d_ipi_work, cpu);
+
+	/* Mark work */
+	work->kgdbcapture = 1;
+
+	/* Generate IRQ on the CPU */
+	sun4d_send_ipi(cpu, SUN4D_IPI_IRQ);
 }
+#endif
 
 static void smp4d_ipi_single(int cpu)
 {
@@ -430,6 +453,9 @@ void __init sun4d_init_smp(void)
 	BTFIXUPSET_BLACKBOX(load_current, smp4d_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4d_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4d_processor_id, BTFIXUPCALL_NORM);
+#ifdef CONFIG_KGDB
+	BTFIXUPSET_CALL(smp_ipi_kgdbcapture, smp4d_ipi_kgdbcapture, BTFIXUPCALL_NORM);
+#endif
 	BTFIXUPSET_CALL(smp_ipi_resched, smp4d_ipi_resched, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_single, smp4d_ipi_single, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4d_ipi_mask_one, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5947686..6b5b4a4 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -159,6 +159,14 @@ static void __init smp4m_ipi_init(void)
 {
 }
 
+#ifdef CONFIG_KGDB
+static void smp4m_ipi_kgdbcapture(int cpu)
+{
+	printk(KERN_INFO "Note: Not implemented yet\n");
+	BUG();
+}
+#endif
+
 static void smp4m_ipi_resched(int cpu)
 {
 	set_cpu_int(cpu, IRQ_IPI_RESCHED);
@@ -316,6 +324,9 @@ void __init sun4m_init_smp(void)
 	BTFIXUPSET_BLACKBOX(load_current, smp4m_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4m_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
+#ifdef CONFIG_KGDB
+	BTFIXUPSET_CALL(smp_ipi_kgdbcapture, smp4m_ipi_kgdbcapture, BTFIXUPCALL_NORM);
+#endif
 	BTFIXUPSET_CALL(smp_ipi_resched, smp4m_ipi_resched, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_single, smp4m_ipi_single, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4m_ipi_mask_one, BTFIXUPCALL_NORM);
-- 
1.6.4.1

