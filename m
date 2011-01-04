From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:30 +0000
Subject: [PATCH 2/7] SPARC/LEON: added support for IRQAMP IRQ Controller
Message-Id: <1294141295-26584-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Needed for LEON AMP systems where different CPUs are routed to
different IRQ controllers. This patch selects the IRQ Controller
which has been routed to the boot CPU, it is up to the boot loader
to configure the IRQ controller.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/leon.h      |   12 ++++++++++++
 arch/sparc/include/asm/leon_amba.h |    6 +++---
 arch/sparc/kernel/leon_kernel.c    |   14 ++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 3ea5964..8580d17 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -224,6 +224,18 @@ static inline void sparc_leon3_disable_cache(void)
 			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
 };
 
+static inline unsigned long sparc_leon3_asr17(void)
+{
+	u32 asr17;
+	__asm__ __volatile__ ("rd %%asr17, %0\n\t" : "=r"(asr17));
+	return asr17;
+};
+
+static inline int sparc_leon3_cpuid(void)
+{
+	return sparc_leon3_asr17() >> 28;
+}
+
 #endif /*!__ASSEMBLY__*/
 
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index 618e888..263c719 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -100,9 +100,8 @@ struct leon3_irqctrl_regs_map {
 	u32 mpbroadcast;
 	u32 notused02;
 	u32 notused03;
-	u32 notused10;
-	u32 notused11;
-	u32 notused12;
+	u32 ampctrl;
+	u32 icsel[2];
 	u32 notused13;
 	u32 notused20;
 	u32 notused21;
@@ -112,6 +111,7 @@ struct leon3_irqctrl_regs_map {
 	u32 force[16];
 	/* Extended IRQ registers */
 	u32 intid[16];	/* 0xc0 */
+	u32 unused[(0x1000-0x100)/4];
 };
 
 struct leon3_apbuart_regs_map {
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 80ba8f5..91a978f 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -108,6 +108,7 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	struct device_node *rootnp, *np;
 	struct property *pp;
 	int len;
+	int cpu, icsel;
 
 	leondebug_irq_disable = 0;
 	leon_debug_irqout = 0;
@@ -160,6 +161,19 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 		LEON3_BYPASS_STORE_PA(&leon3_gptimer_regs->e[1].ctrl, 0);
 # endif
 
+		/*
+		 * The IRQ controller may (if implemented) consist of multiple
+		 * IRQ controllers, each mapped on a 4Kb boundary.
+		 * Each CPU may be routed to different IRQCTRLs, however
+		 * we assume that all CPUs (in SMP system) is routed to the
+		 * same IRQ Controller, and for non-SMP only one IRQCTRL is
+		 * accessed anyway.
+		 * In AMP systems, Linux must run on CPU0 for the time being.
+		 */
+		cpu = sparc_leon3_cpuid();
+		icsel = LEON3_BYPASS_LOAD_PA(&leon3_irqctrl_regs->icsel[cpu/8]);
+		icsel = (icsel >> ((7 - (cpu&0x7)) * 4)) & 0xf;
+		leon3_irqctrl_regs += icsel;
 	} else {
 		goto bad;
 	}
-- 
1.5.4

