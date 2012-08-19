From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:50 +0000
Subject: [PATCH 06/17] sparc64: Abstract away the %pcr values used to enable/disable NMI
Message-Id: <20120818.232750.2178847497346970851.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We assumed PCR_PIC_PRIV can always be used to disable it, but that
won't be true for SPARC-T4.

This allows us also to get rid of some messy defines used in only
one location.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pcr.h |    4 ++--
 arch/sparc/kernel/nmi.c      |   14 +++++++-------
 arch/sparc/kernel/pcr.c      |   37 +++++++++++++++++--------------------
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index 4c71bec..9ebc7f3 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -7,6 +7,8 @@ struct pcr_ops {
 	u64 (*read_pic)(unsigned long);
 	void (*write_pic)(unsigned long, u64);
 	u64 (*nmi_picl_value)(unsigned int nmi_hz);
+	u64 pcr_nmi_enable;
+	u64 pcr_nmi_disable;
 };
 extern const struct pcr_ops *pcr_ops;
 
@@ -30,8 +32,6 @@ extern void schedule_deferred_pcr_work(void);
 #define PCR_N2_SL1_SHIFT	27
 #define PCR_N2_OV1		0x80000000
 
-extern u64 pcr_enable;
-
 extern int pcr_arch_init(void);
 
 #endif /* __PCR_H */
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 4c45158..6479256 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -108,7 +108,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 		       pt_regs_trap_type(regs), SIGINT) = NOTIFY_STOP)
 		touched = 1;
 	else
-		pcr_ops->write_pcr(0, PCR_PIC_PRIV);
+		pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_disable);
 
 	sum = local_cpu_data().irq0_irqs;
 	if (__get_cpu_var(nmi_touch)) {
@@ -126,7 +126,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 	}
 	if (__get_cpu_var(wd_enabled)) {
 		pcr_ops->write_pic(0, pcr_ops->nmi_picl_value(nmi_hz));
-		pcr_ops->write_pcr(0, pcr_enable);
+		pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_enable);
 	}
 
 	restore_hardirq_stack(orig_sp);
@@ -165,7 +165,7 @@ static void report_broken_nmi(int cpu, int *prev_nmi_count)
 
 void stop_nmi_watchdog(void *unused)
 {
-	pcr_ops->write_pcr(0, PCR_PIC_PRIV);
+	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_disable);
 	__get_cpu_var(wd_enabled) = 0;
 	atomic_dec(&nmi_active);
 }
@@ -222,10 +222,10 @@ void start_nmi_watchdog(void *unused)
 	__get_cpu_var(wd_enabled) = 1;
 	atomic_inc(&nmi_active);
 
-	pcr_ops->write_pcr(0, PCR_PIC_PRIV);
+	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_disable);
 	pcr_ops->write_pic(0, pcr_ops->nmi_picl_value(nmi_hz));
 
-	pcr_ops->write_pcr(0, pcr_enable);
+	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_enable);
 }
 
 static void nmi_adjust_hz_one(void *unused)
@@ -233,10 +233,10 @@ static void nmi_adjust_hz_one(void *unused)
 	if (!__get_cpu_var(wd_enabled))
 		return;
 
-	pcr_ops->write_pcr(0, PCR_PIC_PRIV);
+	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_disable);
 	pcr_ops->write_pic(0, pcr_ops->nmi_picl_value(nmi_hz));
 
-	pcr_ops->write_pcr(0, pcr_enable);
+	pcr_ops->write_pcr(0, pcr_ops->pcr_nmi_enable);
 }
 
 void nmi_adjust_hz(unsigned int new_hz)
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 494af32..e408fc5 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -20,14 +20,6 @@
  * perf_event support layer.
  */
 
-#define PCR_SUN4U_ENABLE	(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE)
-#define PCR_N2_ENABLE		(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE | \
-				 PCR_N2_TOE_OV1 | \
-				 (2 << PCR_N2_SL1_SHIFT) | \
-				 (0xff << PCR_N2_MASK1_SHIFT))
-
-u64 pcr_enable;
-
 /* Performance counter interrupts run unmasked at PIL level 15.
  * Therefore we can't do things like wakeups and other work
  * that expects IRQ disabling to be adhered to in locking etc.
@@ -105,11 +97,13 @@ static u64 direct_picl_value(unsigned int nmi_hz)
 }
 
 static const struct pcr_ops direct_pcr_ops = {
-	.read_pcr	= direct_pcr_read,
-	.write_pcr	= direct_pcr_write,
-	.read_pic	= direct_pic_read,
-	.write_pic	= direct_pic_write,
-	.nmi_picl_value	= direct_picl_value,
+	.read_pcr		= direct_pcr_read,
+	.write_pcr		= direct_pcr_write,
+	.read_pic		= direct_pic_read,
+	.write_pic		= direct_pic_write,
+	.nmi_picl_value		= direct_picl_value,
+	.pcr_nmi_enable		= (PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE),
+	.pcr_nmi_disable	= PCR_PIC_PRIV,
 };
 
 static void n2_pcr_write(unsigned long reg_num, u64 val)
@@ -133,11 +127,16 @@ static u64 n2_picl_value(unsigned int nmi_hz)
 }
 
 static const struct pcr_ops n2_pcr_ops = {
-	.read_pcr	= direct_pcr_read,
-	.write_pcr	= n2_pcr_write,
-	.read_pic	= direct_pic_read,
-	.write_pic	= direct_pic_write,
-	.nmi_picl_value	= n2_picl_value,
+	.read_pcr		= direct_pcr_read,
+	.write_pcr		= n2_pcr_write,
+	.read_pic		= direct_pic_read,
+	.write_pic		= direct_pic_write,
+	.nmi_picl_value		= n2_picl_value,
+	.pcr_nmi_enable		= (PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE |
+				   PCR_N2_TOE_OV1 |
+				   (2 << PCR_N2_SL1_SHIFT) |
+				   (0xff << PCR_N2_MASK1_SHIFT)),
+	.pcr_nmi_disable	= PCR_PIC_PRIV,
 };
 
 static unsigned long perf_hsvc_group;
@@ -194,13 +193,11 @@ int __init pcr_arch_init(void)
 	switch (tlb_type) {
 	case hypervisor:
 		pcr_ops = &n2_pcr_ops;
-		pcr_enable = PCR_N2_ENABLE;
 		break;
 
 	case cheetah:
 	case cheetah_plus:
 		pcr_ops = &direct_pcr_ops;
-		pcr_enable = PCR_SUN4U_ENABLE;
 		break;
 
 	case spitfire:
-- 
1.7.10.4

