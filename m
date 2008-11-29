From: David Miller <davem@davemloft.net>
Date: Sat, 29 Nov 2008 06:08:34 +0000
Subject: [PATCH 2/2]: sparc64: Provide oprofile pseudo-NMI on Niagara.
Message-Id: <20081128.220834.50632802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Provide oprofile pseudo-NMI on Niagara.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/oprofile/init.c |  151 +++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 135 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/oprofile/init.c b/arch/sparc/oprofile/init.c
index e979dcd..d6e170c 100644
--- a/arch/sparc/oprofile/init.c
+++ b/arch/sparc/oprofile/init.c
@@ -13,32 +13,97 @@
 #include <linux/init.h>
  
 #ifdef CONFIG_SPARC64
+#include <asm/hypervisor.h>
 #include <asm/spitfire.h>
 #include <asm/cpudata.h>
 #include <asm/irq.h>
 
 static int nmi_enabled;
 
+struct pcr_ops {
+	u64 (*read)(void);
+	void (*write)(u64);
+};
+static const struct pcr_ops *pcr_ops;
+
+static u64 direct_pcr_read(void)
+{
+	u64 val;
+
+	read_pcr(val);
+	return val;
+}
+
+static void direct_pcr_write(u64 val)
+{
+	write_pcr(val);
+}
+
+static const struct pcr_ops direct_pcr_ops = {
+	.read	= direct_pcr_read,
+	.write	= direct_pcr_write,
+};
+
+static void n2_pcr_write(u64 val)
+{
+	unsigned long ret;
+
+	ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
+	if (val != HV_EOK)
+		write_pcr(val);
+}
+
+static const struct pcr_ops n2_pcr_ops = {
+	.read	= direct_pcr_read,
+	.write	= n2_pcr_write,
+};
+
+/* In order to commonize as much of the implementation as
+ * possible, we use PICH as our counter.  Mostly this is
+ * to accomodate Niagara-1 which can only count insn cycles
+ * in PICH.
+ */
 static u64 picl_value(void)
 {
 	u32 delta = local_cpu_data().clock_tick / HZ;
 
-	return (0 - delta) & 0xffffffff;
+	return ((u64)((0 - delta) & 0xffffffff)) << 32;
 }
 
-#define PCR_PIC_PRIV	0x1 /* PIC access is privileged */
-#define PCR_STRACE	0x2 /* Trace supervisor events  */
-#define PCR_UTRACE	0x4 /* Trace user events        */
+#define PCR_PIC_PRIV		0x00000001 /* PIC access is privileged */
+#define PCR_STRACE		0x00000002 /* Trace supervisor events  */
+#define PCR_UTRACE		0x00000004 /* Trace user events        */
+#define PCR_N2_HTRACE		0x00000008 /* Trace hypervisor events  */
+#define PCR_N2_TOE_OV0		0x00000010 /* Trap if PIC 0 overflows  */
+#define PCR_N2_TOE_OV1		0x00000020 /* Trap if PIC 1 overflows  */
+#define PCR_N2_MASK0		0x00003fc0
+#define PCR_N2_MASK0_SHIFT	6
+#define PCR_N2_SL0		0x0003c000
+#define PCR_N2_SL0_SHIFT	14
+#define PCR_N2_OV0		0x00040000
+#define PCR_N2_MASK1		0x07f80000
+#define PCR_N2_MASK1_SHIFT	19
+#define PCR_N2_SL1		0x78000000
+#define PCR_N2_SL1_SHIFT	27
+#define PCR_N2_OV1		0x80000000
+
+#define PCR_SUN4U_ENABLE	(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE)
+#define PCR_N2_ENABLE		(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE | \
+				 PCR_N2_TOE_OV1 | \
+				 (2 << PCR_N2_SL1_SHIFT) | \
+				 (0xff << PCR_N2_MASK1_SHIFT))
+
+static u64 pcr_enable = PCR_SUN4U_ENABLE;
 
 static void nmi_handler(struct pt_regs *regs)
 {
-	write_pcr(PCR_PIC_PRIV);
+	pcr_ops->write(PCR_PIC_PRIV);
 
 	if (nmi_enabled) {
 		oprofile_add_sample(regs, 0);
 
 		write_pic(picl_value());
-		write_pcr(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE);
+		pcr_ops->write(pcr_enable);
 	}
 }
 
@@ -48,21 +113,15 @@ static void nmi_handler(struct pt_regs *regs)
  */
 static void cpu_nmi_start(void *_unused)
 {
-	write_pcr(PCR_PIC_PRIV);
+	pcr_ops->write(PCR_PIC_PRIV);
 	write_pic(picl_value());
 
-	/* Bit 0: PIC access is privileged
-	 * Bit 1: Supervisor Trace
-	 * Bit 2: User Trace
-	 *
-	 * And the event selection code for cpu cycles is zero.
-	 */
-	write_pcr(PCR_PIC_PRIV | PCR_STRACE | PCR_UTRACE);
+	pcr_ops->write(pcr_enable);
 }
 
 static void cpu_nmi_stop(void *_unused)
 {
-	write_pcr(PCR_PIC_PRIV);
+	pcr_ops->write(PCR_PIC_PRIV);
 }
 
 static int nmi_start(void)
@@ -94,10 +153,67 @@ static void nmi_stop(void)
 	synchronize_sched();
 }
 
+static unsigned long perf_hsvc_group;
+static unsigned long perf_hsvc_major;
+static unsigned long perf_hsvc_minor;
+
+static int __init register_perf_hsvc(void)
+{
+	if (tlb_type = hypervisor) {
+		switch (sun4v_chip_type) {
+		case SUN4V_CHIP_NIAGARA1:
+			perf_hsvc_group = HV_GRP_NIAG_PERF;
+			break;
+
+		case SUN4V_CHIP_NIAGARA2:
+			perf_hsvc_group = HV_GRP_N2_CPU;
+			break;
+
+		default:
+			return -ENODEV;
+		}
+
+
+		perf_hsvc_major = 1;
+		perf_hsvc_minor = 0;
+		if (sun4v_hvapi_register(perf_hsvc_group,
+					 perf_hsvc_major,
+					 &perf_hsvc_minor)) {
+			printk("perfmon: Could not register N2 hvapi.\n");
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+static void unregister_perf_hsvc(void)
+{
+	if (tlb_type != hypervisor)
+		return;
+	sun4v_hvapi_unregister(perf_hsvc_group);
+}
+
 static int oprofile_nmi_init(struct oprofile_operations *ops)
 {
-	if (tlb_type != cheetah && tlb_type != cheetah_plus)
+	int err = register_perf_hsvc();
+
+	if (err)
+		return err;
+
+	switch (tlb_type) {
+	case hypervisor:
+		pcr_ops = &n2_pcr_ops;
+		pcr_enable = PCR_N2_ENABLE;
+		break;
+
+	case cheetah:
+	case cheetah_plus:
+		pcr_ops = &direct_pcr_ops;
+		break;
+
+	default:
 		return -ENODEV;
+	}
 
 	ops->create_files = NULL;
 	ops->setup = NULL;
@@ -128,4 +244,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 
 void oprofile_arch_exit(void)
 {
+#ifdef CONFIG_SPARC64
+	unregister_perf_hsvc();
+#endif
 }
-- 
1.5.6.5

