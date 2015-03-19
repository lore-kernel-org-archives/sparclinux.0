From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 20:06:37 +0000
Subject: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The M7 processor has a different hypervisor group id and different PCR fast
trap values. PIC read/write functions and PCR bit fields are the same as
the T4 so those are reused.

Signed-off-by: David Ahern <david.ahern@oracle.com>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/hypervisor.h | 12 +++++++++++
 arch/sparc/kernel/hvapi.c           |  1 +
 arch/sparc/kernel/hvcalls.S         | 16 +++++++++++++++
 arch/sparc/kernel/pcr.c             | 33 ++++++++++++++++++++++++++++++
 arch/sparc/kernel/perf_event.c      | 40 +++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 4f6725ff4c33..f5b6537306f0 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2957,6 +2957,17 @@ unsigned long sun4v_t5_set_perfreg(unsigned long reg_num,
 				   unsigned long reg_val);
 #endif
 
+
+#define HV_FAST_M7_GET_PERFREG	0x43
+#define HV_FAST_M7_SET_PERFREG	0x44
+
+#ifndef	__ASSEMBLY__
+unsigned long sun4v_m7_get_perfreg(unsigned long reg_num,
+				      unsigned long *reg_val);
+unsigned long sun4v_m7_set_perfreg(unsigned long reg_num,
+				      unsigned long reg_val);
+#endif
+
 /* Function numbers for HV_CORE_TRAP.  */
 #define HV_CORE_SET_VER			0x00
 #define HV_CORE_PUTCHAR			0x01
@@ -2981,6 +2992,7 @@ unsigned long sun4v_t5_set_perfreg(unsigned long reg_num,
 #define HV_GRP_SDIO			0x0108
 #define HV_GRP_SDIO_ERR			0x0109
 #define HV_GRP_REBOOT_DATA		0x0110
+#define HV_GRP_M7_PERF			0x0114
 #define HV_GRP_NIAG_PERF		0x0200
 #define HV_GRP_FIRE_PERF		0x0201
 #define HV_GRP_N2_CPU			0x0202
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 5c55145bfbf0..662500fa555f 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -48,6 +48,7 @@ static struct api_info api_table[] = {
 	{ .group = HV_GRP_VT_CPU,				},
 	{ .group = HV_GRP_T5_CPU,				},
 	{ .group = HV_GRP_DIAG,		.flags = FLAG_PRE_API	},
+	{ .group = HV_GRP_M7_PERF,				},
 };
 
 static DEFINE_SPINLOCK(hvapi_lock);
diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index caedf8320416..afbaba52d2f1 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -837,3 +837,19 @@ ENTRY(sun4v_t5_set_perfreg)
 	retl
 	 nop
 ENDPROC(sun4v_t5_set_perfreg)
+
+ENTRY(sun4v_m7_get_perfreg)
+	mov	%o1, %o4
+	mov	HV_FAST_M7_GET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	stx	%o1, [%o4]
+	retl
+	nop
+ENDPROC(sun4v_m7_get_perfreg)
+
+ENTRY(sun4v_m7_set_perfreg)
+	mov	HV_FAST_M7_SET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	retl
+	nop
+ENDPROC(sun4v_m7_set_perfreg)
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 7e967c8018c8..eb978c77c76a 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -217,6 +217,31 @@ static const struct pcr_ops n5_pcr_ops = {
 	.pcr_nmi_disable	= PCR_N4_PICNPT,
 };
 
+static u64 m7_pcr_read(unsigned long reg_num)
+{
+	unsigned long val;
+
+	(void) sun4v_m7_get_perfreg(reg_num, &val);
+
+	return val;
+}
+
+static void m7_pcr_write(unsigned long reg_num, u64 val)
+{
+	(void) sun4v_m7_set_perfreg(reg_num, val);
+}
+
+static const struct pcr_ops m7_pcr_ops = {
+	.read_pcr		= m7_pcr_read,
+	.write_pcr		= m7_pcr_write,
+	.read_pic		= n4_pic_read,
+	.write_pic		= n4_pic_write,
+	.nmi_picl_value		= n4_picl_value,
+	.pcr_nmi_enable		= (PCR_N4_PICNPT | PCR_N4_STRACE |
+				   PCR_N4_UTRACE | PCR_N4_TOE |
+				   (26 << PCR_N4_SL_SHIFT)),
+	.pcr_nmi_disable	= PCR_N4_PICNPT,
+};
 
 static unsigned long perf_hsvc_group;
 static unsigned long perf_hsvc_major;
@@ -248,6 +273,10 @@ static int __init register_perf_hsvc(void)
 			perf_hsvc_group = HV_GRP_T5_CPU;
 			break;
 
+		case SUN4V_CHIP_SPARC_M7:
+			perf_hsvc_group = HV_GRP_M7_PERF;
+			break;
+
 		default:
 			return -ENODEV;
 		}
@@ -293,6 +322,10 @@ static int __init setup_sun4v_pcr_ops(void)
 		pcr_ops = &n5_pcr_ops;
 		break;
 
+	case SUN4V_CHIP_SPARC_M7:
+		pcr_ops = &m7_pcr_ops;
+		break;
+
 	default:
 		ret = -ENODEV;
 		break;
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index af53c25da2e7..86eebfa3b158 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -792,6 +792,42 @@ static const struct sparc_pmu niagara4_pmu = {
 	.num_pic_regs	= 4,
 };
 
+static void sparc_m7_write_pmc(int idx, u64 val)
+{
+	u64 pcr;
+
+	pcr = pcr_ops->read_pcr(idx);
+	/* ensure ov and ntc are reset */
+	pcr &= ~(PCR_N4_OV | PCR_N4_NTC);
+
+	pcr_ops->write_pic(idx, val & 0xffffffff);
+
+	pcr_ops->write_pcr(idx, pcr);
+}
+
+static const struct sparc_pmu sparc_m7_pmu = {
+	.event_map	= niagara4_event_map,
+	.cache_map	= &niagara4_cache_map,
+	.max_events	= ARRAY_SIZE(niagara4_perfmon_event_map),
+	.read_pmc	= sparc_vt_read_pmc,
+	.write_pmc	= sparc_m7_write_pmc,
+	.upper_shift	= 5,
+	.lower_shift	= 5,
+	.event_mask	= 0x7ff,
+	.user_bit	= PCR_N4_UTRACE,
+	.priv_bit	= PCR_N4_STRACE,
+
+	/* We explicitly don't support hypervisor tracing. */
+	.hv_bit		= 0,
+
+	.irq_bit	= PCR_N4_TOE,
+	.upper_nop	= 0,
+	.lower_nop	= 0,
+	.flags		= 0,
+	.max_hw_events	= 4,
+	.num_pcrs	= 4,
+	.num_pic_regs	= 4,
+};
 static const struct sparc_pmu *sparc_pmu __read_mostly;
 
 static u64 event_encoding(u64 event_id, int idx)
@@ -1658,6 +1694,10 @@ static bool __init supported_pmu(void)
 		sparc_pmu = &niagara4_pmu;
 		return true;
 	}
+	if (!strcmp(sparc_pmu_type, "sparc-m7")) {
+		sparc_pmu = &sparc_m7_pmu;
+		return true;
+	}
 	return false;
 }
 
-- 
2.3.0

