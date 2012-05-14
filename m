From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 16:01:22 +0000
Subject: [PATCH 1/2] sparc32: remove remaining users of btfixup
Message-Id: <20120514160122.GA11195@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 5cc7ae31c647d27cf03074f980a94f76c0b8798a Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 17:30:35 +0200
Subject: [PATCH 1/2] sparc32: remove remaining users of btfixup

Use sparc_config to hold the last two function pointers.
There was no pint generating dedicated _ops structures onyl for these.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h   |    4 ----
 arch/sparc/kernel/irq.h         |   24 +++---------------------
 arch/sparc/kernel/leon_kernel.c |   13 +++++--------
 arch/sparc/kernel/pcic.c        |    5 ++---
 arch/sparc/kernel/sun4d_irq.c   |    5 ++---
 arch/sparc/kernel/sun4m_irq.c   |    8 ++++----
 arch/sparc/kernel/sun4m_smp.c   |    2 +-
 arch/sparc/kernel/time_32.c     |   11 ++++++-----
 8 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index cf35a26..8095be2 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -321,11 +321,7 @@ extern unsigned int leon_build_device_irq(unsigned int real_irq,
 extern void leon_update_virq_handling(unsigned int virq,
 			      irq_flow_handler_t flow_handler,
 			      const char *name, int do_ack);
-extern void leon_clear_clock_irq(void);
-extern void leon_load_profile_irq(int cpu, unsigned int limit);
 extern void leon_init_timers(void);
-extern void leon_clear_clock_irq(void);
-extern void leon_load_profile_irq(int cpu, unsigned int limit);
 extern void leon_trans_init(struct device_node *dp);
 extern void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 extern void leon_init_IRQ(void);
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index e40ca6c..f558f71 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -70,6 +70,9 @@ struct sparc_config {
 
 	/* function to obtain offsett for cs period */
 	unsigned int (*get_cycles_offset)(void);
+
+	void (*clear_clock_irq)(void);
+	void (*load_profile_irq)(int cpu, unsigned int limit);
 };
 extern struct sparc_config sparc_config;
 
@@ -78,27 +81,6 @@ void irq_link(unsigned int irq);
 void irq_unlink(unsigned int irq);
 void handler_irq(unsigned int pil, struct pt_regs *regs);
 
-/* Dave Redman (djhr@tadpole.co.uk)
- * changed these to function pointers.. it saves cycles and will allow
- * the irq dependencies to be split into different files at a later date
- * sun4m_irq.c etc so we could reduce the kernel size.
- * Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * Changed these to btfixup entities... It saves cycles :)
- */
-
-BTFIXUPDEF_CALL(void, clear_clock_irq, void)
-BTFIXUPDEF_CALL(void, load_profile_irq, int, unsigned int)
-
-static inline void clear_clock_irq(void)
-{
-	BTFIXUP_CALL(clear_clock_irq)();
-}
-
-static inline void load_profile_irq(int cpu, int limit)
-{
-	BTFIXUP_CALL(load_profile_irq)(cpu, limit);
-}
-
 unsigned long leon_get_irqmask(unsigned int irq);
 
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 1770b3c..77c1b91 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -463,11 +463,11 @@ bad:
 	return;
 }
 
-void leon_clear_clock_irq(void)
+static void leon_clear_clock_irq(void)
 {
 }
 
-void leon_load_profile_irq(int cpu, unsigned int limit)
+static void leon_load_profile_irq(int cpu, unsigned int limit)
 {
 }
 
@@ -517,12 +517,9 @@ void __init leon_init_IRQ(void)
 {
 	sparc_config.init_timers      = leon_init_timers;
 	sparc_config.build_device_irq = _leon_build_device_irq;
-	sparc_config.clock_rate = 1000000;
-
-	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq,
-			BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(load_profile_irq, leon_load_profile_irq,
-			BTFIXUPCALL_NOP);
+	sparc_config.clock_rate       = 1000000;
+	sparc_config.clear_clock_irq  = leon_clear_clock_irq;
+	sparc_config.load_profile_irq = leon_load_profile_irq;
 }
 
 void __init leon_init(void)
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index f0ec939..ded3f60 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -880,9 +880,8 @@ static void pcic_load_profile_irq(int cpu, unsigned int limit)
 void __init sun4m_pci_init_IRQ(void)
 {
 	sparc_config.build_device_irq = pcic_build_device_irq;
-
-	BTFIXUPSET_CALL(clear_clock_irq, pcic_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(load_profile_irq, pcic_load_profile_irq, BTFIXUPCALL_NORM);
+	sparc_config.clear_clock_irq  = pcic_clear_clock_irq;
+	sparc_config.load_profile_irq = pcic_load_profile_irq;
 }
 
 int pcibios_assign_resource(struct pci_dev *pdev, int resource)
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index e8e4f14..e490ac9 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -506,12 +506,11 @@ void __init sun4d_init_IRQ(void)
 {
 	local_irq_disable();
 
-	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
-
 	sparc_config.init_timers      = sun4d_init_timers;
 	sparc_config.build_device_irq = sun4d_build_device_irq;
 	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
+	sparc_config.clear_clock_irq  = sun4d_clear_clock_irq;
+	sparc_config.load_profile_irq = sun4d_load_profile_irq;
 
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index eb2c277..c5ade9d 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -462,12 +462,12 @@ void __init sun4m_init_IRQ(void)
 	if (num_cpu_iregs = 4)
 		sbus_writel(0, &sun4m_irq_global->interrupt_target);
 
-	BTFIXUPSET_CALL(clear_clock_irq, sun4m_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NORM);
-
-	sparc_config.init_timers = sun4m_init_timers;
+	sparc_config.init_timers      = sun4m_init_timers;
 	sparc_config.build_device_irq = sun4m_build_device_irq;
 	sparc_config.clock_rate       = SBUS_CLOCK_RATE;
+	sparc_config.clear_clock_irq  = sun4m_clear_clock_irq;
+	sparc_config.load_profile_irq = sun4m_load_profile_irq;
+
 
 	/* Cannot enable interrupts until OBP ticker is disabled. */
 }
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index ee21c43..960e8ab 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -268,7 +268,7 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 	if (ce->mode & CLOCK_EVT_MODE_PERIODIC)
 		sun4m_clear_profile_irq(cpu);
 	else
-		load_profile_irq(cpu, 0); /* Is this needless? */
+		sparc_config.load_profile_irq(cpu, 0); /* Is this needless? */
 
 	irq_enter();
 	ce->event_handler(ce);
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 1e25a7a..459cf66 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -95,10 +95,10 @@ irqreturn_t notrace timer_interrupt(int dummy, void *dev_id)
 	if (timer_cs_enabled) {
 		write_seqlock(&timer_cs_lock);
 		timer_cs_internal_counter++;
-		clear_clock_irq();
+		sparc_config.clear_clock_irq();
 		write_sequnlock(&timer_cs_lock);
 	} else {
-		clear_clock_irq();
+		sparc_config.clear_clock_irq();
 	}
 
 	if (timer_ce_enabled)
@@ -200,12 +200,13 @@ static void percpu_ce_setup(enum clock_event_mode mode,
 
 	switch (mode) {
 		case CLOCK_EVT_MODE_PERIODIC:
-			load_profile_irq(cpu, SBUS_CLOCK_RATE / HZ);
+			sparc_config.load_profile_irq(cpu,
+						      SBUS_CLOCK_RATE / HZ);
 			break;
 		case CLOCK_EVT_MODE_ONESHOT:
 		case CLOCK_EVT_MODE_SHUTDOWN:
 		case CLOCK_EVT_MODE_UNUSED:
-			load_profile_irq(cpu, 0);
+			sparc_config.load_profile_irq(cpu, 0);
 			break;
 		default:
 			break;
@@ -218,7 +219,7 @@ static int percpu_ce_set_next_event(unsigned long delta,
 	int cpu = __first_cpu(evt->cpumask);
 	unsigned int next = (unsigned int)delta;
 
-	load_profile_irq(cpu, next);
+	sparc_config.load_profile_irq(cpu, next);
 	return 0;
 }
 
-- 
1.6.0.6

