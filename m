From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Apr 2011 14:20:24 +0000
Subject: [PATCH 2/3] sparc32,leon: operate on boot-cpu IRQ controller registers
Message-Id: <1303395625-6911-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 * proper initialization of boot_cpu_id (no hardcoding to 0)
 * use boot_cpu_id index to address into the IRQ controller where
   appropriate

Each CPU has a separate set of IRQ controller registers, this
patch makes sure that the boot-cpu registers are used instead
of CPU0's.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/head_32.S     |   27 ++++++++++++---------------
 arch/sparc/kernel/leon_kernel.c |   18 +++++++++---------
 arch/sparc/kernel/leon_smp.c    |    1 -
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 520c615..5877857 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -810,28 +810,25 @@ found_version:
 got_prop:
 #ifdef CONFIG_SPARC_LEON
 	        /* no cpu-type check is needed, it is a SPARC-LEON */
-#ifdef CONFIG_SMP
-		ba leon_smp_init
-		 nop
 
-		.global leon_smp_init
-leon_smp_init:
-		/* let boot_cpu_id default to 0 (master always 0) */
+		sethi	%hi(boot_cpu_id), %g2	! boot-cpu index
 
-		rd     %asr17,%g1
-		srl    %g1,28,%g1
+#ifdef CONFIG_SMP
+		ldub	[%g2 + %lo(boot_cpu_id)], %g1
+		cmp	%g1, 0xff		! unset means first CPU
+		bne	leon_smp_cpu_startup	! continue only with master
+		 nop
+#endif
+		/* Get CPU-ID from most significant 4-bit of ASR17 */
+		rd     %asr17, %g1
+		srl    %g1, 28, %g1
 
-		cmp %g0,%g1
-		 beq sun4c_continue_boot         !continue with master
-		nop
+		/* Update boot_cpu_id only on boot cpu */
+		stub	%g1, [%g2 + %lo(boot_cpu_id)]
 
-		ba leon_smp_cpu_startup
-		 nop
-#else
 		ba sun4c_continue_boot
 		 nop
 #endif
-#endif
 		set	cputypval, %o2
 		ldub	[%o2 + 0x4], %l1
 
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index ab14584..8417a91 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -20,6 +20,7 @@
 #include <asm/traps.h>
 #include <asm/cacheflush.h>
 #include <asm/smp.h>
+#include <asm/setup.h>
 
 #include "prom.h"
 #include "irq.h"
@@ -53,7 +54,7 @@ static inline unsigned int leon_eirq_get(int cpu)
 static void leon_handle_ext_irq(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int eirq;
-	int cpu = hard_smp_processor_id();
+	int cpu = sparc_leon3_cpuid();
 
 	eirq = leon_eirq_get(cpu);
 	if ((eirq & 0x10) && irq_map[eirq]->irq) /* bit4 tells if IRQ happened */
@@ -79,8 +80,8 @@ void leon_eirq_setup(unsigned int eirq)
 	 */
 	irq_link(veirq);
 	mask = 1 << eirq;
-	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(0));
-	LEON3_BYPASS_STORE_PA(LEON_IMASK(0), (oldmask | mask));
+	oldmask = LEON3_BYPASS_LOAD_PA(LEON_IMASK(boot_cpu_id));
+	LEON3_BYPASS_STORE_PA(LEON_IMASK(boot_cpu_id), (oldmask | mask));
 	sparc_leon_eirq = eirq;
 }
 
@@ -106,12 +107,12 @@ static int irq_choose_cpu(const struct cpumask *affinity)
 
 	cpus_and(mask, cpu_online_map, *affinity);
 	if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
-		return 0;
+		return boot_cpu_id;
 	else
 		return first_cpu(mask);
 }
 #else
-#define irq_choose_cpu(affinity) 0
+#define irq_choose_cpu(affinity) boot_cpu_id
 #endif
 
 static int leon_set_affinity(struct irq_data *data, const struct cpumask *dest,
@@ -241,7 +242,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	struct device_node *rootnp, *np, *nnp;
 	struct property *pp;
 	int len;
-	int cpu, icsel;
+	int icsel;
 	int ampopts;
 	int err;
 
@@ -340,9 +341,8 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	 * accessed anyway.
 	 * In AMP systems, Linux must run on CPU0 for the time being.
 	 */
-	cpu = sparc_leon3_cpuid();
-	icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[cpu/8]);
-	icsel = (icsel >> ((7 - (cpu&0x7)) * 4)) & 0xf;
+	icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[boot_cpu_id/8]);
+	icsel = (icsel >> ((7 - (boot_cpu_id&0x7)) * 4)) & 0xf;
 	leon3_irqctrl_regs += icsel;
 
 	/* Probe extended IRQ controller */
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 053eca9..496b95f 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -50,7 +50,6 @@
 extern ctxd_t *srmmu_ctx_table_phys;
 static int smp_processors_ready;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
-extern unsigned char boot_cpu_id;
 extern cpumask_t smp_commenced_mask;
 void __init leon_configure_cache_smp(void);
 
-- 
1.5.4

