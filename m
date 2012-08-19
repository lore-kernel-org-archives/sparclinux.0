From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:32 +0000
Subject: [PATCH 02/17] sparc64: Add hypervisor interfaces for SPARC-T4 perf counter access.
Message-Id: <20120818.232732.1370674497684173060.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Unlike for previous chips, access to the perf-counter control
registers are all hyper-privileged.  Therefore, access to them must go
through a hypervisor interface.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/hypervisor.h |   11 +++++++++++
 arch/sparc/kernel/hvapi.c           |    1 +
 arch/sparc/kernel/hvcalls.S         |   16 ++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 015a761..ca121f0 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2934,6 +2934,16 @@ extern unsigned long sun4v_reboot_data_set(unsigned long ra,
 					   unsigned long len);
 #endif
 
+#define HV_FAST_VT_GET_PERFREG		0x184
+#define HV_FAST_VT_SET_PERFREG		0x185
+
+#ifndef __ASSEMBLY__
+extern unsigned long sun4v_vt_get_perfreg(unsigned long reg_num,
+					  unsigned long *reg_val);
+extern unsigned long sun4v_vt_set_perfreg(unsigned long reg_num,
+					  unsigned long reg_val);
+#endif
+
 /* Function numbers for HV_CORE_TRAP.  */
 #define HV_CORE_SET_VER			0x00
 #define HV_CORE_PUTCHAR			0x01
@@ -2964,6 +2974,7 @@ extern unsigned long sun4v_reboot_data_set(unsigned long ra,
 #define HV_GRP_NIU			0x0204
 #define HV_GRP_VF_CPU			0x0205
 #define HV_GRP_KT_CPU			0x0209
+#define HV_GRP_VT_CPU			0x020c
 #define HV_GRP_DIAG			0x0300
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
index 8593672..1032df4 100644
--- a/arch/sparc/kernel/hvapi.c
+++ b/arch/sparc/kernel/hvapi.c
@@ -45,6 +45,7 @@ static struct api_info api_table[] = {
 	{ .group = HV_GRP_NIU,					},
 	{ .group = HV_GRP_VF_CPU,				},
 	{ .group = HV_GRP_KT_CPU,				},
+	{ .group = HV_GRP_VT_CPU,				},
 	{ .group = HV_GRP_DIAG,		.flags = FLAG_PRE_API	},
 };
 
diff --git a/arch/sparc/kernel/hvcalls.S b/arch/sparc/kernel/hvcalls.S
index 58d60de..f3ab509 100644
--- a/arch/sparc/kernel/hvcalls.S
+++ b/arch/sparc/kernel/hvcalls.S
@@ -805,3 +805,19 @@ ENTRY(sun4v_reboot_data_set)
 	retl
 	 nop
 ENDPROC(sun4v_reboot_data_set)
+
+ENTRY(sun4v_vt_get_perfreg)
+	mov	%o1, %o4
+	mov	HV_FAST_VT_GET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	stx	%o1, [%o4]
+	retl
+	 nop
+ENDPROC(sun4v_vt_get_perfreg)
+
+ENTRY(sun4v_vt_set_perfreg)
+	mov	HV_FAST_VT_SET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 nop
+ENDPROC(sun4v_vt_set_perfreg)
-- 
1.7.10.4

