From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:58 +0000
Subject: [PATCH 07/17] sparc64: Add PCR ops for SPARC-T4.
Message-Id: <20120818.232758.1799293256830817462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is enough to get the NMIs working, more work is needed
for perf events.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/asi.h |    4 +-
 arch/sparc/include/asm/pcr.h |   13 +++++++
 arch/sparc/kernel/pcr.c      |   83 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index 61ebe74..cc0006d 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -141,7 +141,8 @@
 /* SpitFire and later extended ASIs.  The "(III)" marker designates
  * UltraSparc-III and later specific ASIs.  The "(CMT)" marker designates
  * Chip Multi Threading specific ASIs.  "(NG)" designates Niagara specific
- * ASIs, "(4V)" designates SUN4V specific ASIs.
+ * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
+ * and later ASIs.
  */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
 #define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
@@ -243,6 +244,7 @@
 #define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
 #define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
 #define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
 #define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
 #define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
 #define ASI_PST16_P		0xc2 /* Primary, 4 16-bit, partial	*/
diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index 9ebc7f3..942bb17 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -32,6 +32,19 @@ extern void schedule_deferred_pcr_work(void);
 #define PCR_N2_SL1_SHIFT	27
 #define PCR_N2_OV1		0x80000000
 
+#define PCR_N4_OV		0x00000001 /* PIC overflow             */
+#define PCR_N4_TOE		0x00000002 /* Trap On Event            */
+#define PCR_N4_UTRACE		0x00000004 /* Trace user events        */
+#define PCR_N4_STRACE		0x00000008 /* Trace supervisor events  */
+#define PCR_N4_HTRACE		0x00000010 /* Trace hypervisor events  */
+#define PCR_N4_MASK		0x000007e0 /* Event mask               */
+#define PCR_N4_MASK_SHIFT	5
+#define PCR_N4_SL		0x0000f800 /* Event Select             */
+#define PCR_N4_SL_SHIFT		11
+#define PCR_N4_PICNPT		0x00010000 /* PIC non-privileged trap  */
+#define PCR_N4_PICNHT		0x00020000 /* PIC non-hypervisor trap  */
+#define PCR_N4_NTC		0x00040000 /* Next-To-Commit wrap      */
+
 extern int pcr_arch_init(void);
 
 #endif /* __PCR_H */
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index e408fc5..269af58 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -13,6 +13,7 @@
 #include <asm/pil.h>
 #include <asm/pcr.h>
 #include <asm/nmi.h>
+#include <asm/asi.h>
 #include <asm/spitfire.h>
 
 /* This code is shared between various users of the performance
@@ -139,6 +140,57 @@ static const struct pcr_ops n2_pcr_ops = {
 	.pcr_nmi_disable	= PCR_PIC_PRIV,
 };
 
+static u64 n4_pcr_read(unsigned long reg_num)
+{
+	unsigned long val;
+
+	(void) sun4v_vt_get_perfreg(reg_num, &val);
+
+	return val;
+}
+
+static void n4_pcr_write(unsigned long reg_num, u64 val)
+{
+	(void) sun4v_vt_set_perfreg(reg_num, val);
+}
+
+static u64 n4_pic_read(unsigned long reg_num)
+{
+	unsigned long val;
+
+	__asm__ __volatile__("ldxa [%1] %2, %0"
+			     : "=r" (val)
+			     : "r" (reg_num * 0x8UL), "i" (ASI_PIC));
+
+	return val;
+}
+
+static void n4_pic_write(unsigned long reg_num, u64 val)
+{
+	__asm__ __volatile__("stxa %0, [%1] %2"
+			     : /* no outputs */
+			     : "r" (val), "r" (reg_num * 0x8UL), "i" (ASI_PIC));
+}
+
+static u64 n4_picl_value(unsigned int nmi_hz)
+{
+	u32 delta = local_cpu_data().clock_tick / (nmi_hz << 2);
+
+	return ((u64)((0 - delta) & 0xffffffff));
+}
+
+static const struct pcr_ops n4_pcr_ops = {
+	.read_pcr		= n4_pcr_read,
+	.write_pcr		= n4_pcr_write,
+	.read_pic		= n4_pic_read,
+	.write_pic		= n4_pic_write,
+	.nmi_picl_value		= n4_picl_value,
+	.pcr_nmi_enable		= (PCR_N4_PICNPT | PCR_N4_STRACE |
+				   PCR_N4_UTRACE | PCR_N4_TOE |
+				   (26 << PCR_N4_SL_SHIFT)),
+	.pcr_nmi_disable	= PCR_N4_PICNPT,
+};
+
 static unsigned long perf_hsvc_group;
 static unsigned long perf_hsvc_major;
 static unsigned long perf_hsvc_minor;
@@ -159,6 +211,10 @@ static int __init register_perf_hsvc(void)
 			perf_hsvc_group = HV_GRP_KT_CPU;
 			break;
 
+		case SUN4V_CHIP_NIAGARA4:
+			perf_hsvc_group = HV_GRP_VT_CPU;
+			break;
+
 		default:
 			return -ENODEV;
 		}
@@ -183,6 +239,29 @@ static void __init unregister_perf_hsvc(void)
 	sun4v_hvapi_unregister(perf_hsvc_group);
 }
 
+static int __init setup_sun4v_pcr_ops(void)
+{
+	int ret = 0;
+
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_NIAGARA1:
+	case SUN4V_CHIP_NIAGARA2:
+	case SUN4V_CHIP_NIAGARA3:
+		pcr_ops = &n2_pcr_ops;
+		break;
+
+	case SUN4V_CHIP_NIAGARA4:
+		pcr_ops = &n4_pcr_ops;
+		break;
+
+	default:
+		ret = -ENODEV;
+		break;
+	}
+
+	return ret;
+}
+
 int __init pcr_arch_init(void)
 {
 	int err = register_perf_hsvc();
@@ -192,7 +271,9 @@ int __init pcr_arch_init(void)
 
 	switch (tlb_type) {
 	case hypervisor:
-		pcr_ops = &n2_pcr_ops;
+		err = setup_sun4v_pcr_ops();
+		if (err)
+			goto out_unregister;
 		break;
 
 	case cheetah:
-- 
1.7.10.4

