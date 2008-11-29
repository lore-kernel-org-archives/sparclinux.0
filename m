From: David Miller <davem@davemloft.net>
Date: Sat, 29 Nov 2008 06:08:32 +0000
Subject: [PATCH 1/2]: sparc64: Add performance counter hypervisor calls for
Message-Id: <20081128.220832.153227228.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Add performance counter hypervisor calls for sun4v.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/hypervisor.h |   24 ++++++++++++++++++++++++
 arch/sparc64/kernel/hvcalls.S       |   32 ++++++++++++++++++++++++++++++++
 arch/sparc64/kernel/sparc64_ksyms.c |    6 ++++++
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index 109ae24..bafe5a6 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -2713,6 +2713,30 @@ extern unsigned long sun4v_ldc_revoke(unsigned long channel,
  */
 #define HV_FAST_SET_PERFREG		0x101
 
+#define HV_N2_PERF_SPARC_CTL		0x0
+#define HV_N2_PERF_DRAM_CTL0		0x1
+#define HV_N2_PERF_DRAM_CNT0		0x2
+#define HV_N2_PERF_DRAM_CTL1		0x3
+#define HV_N2_PERF_DRAM_CNT1		0x4
+#define HV_N2_PERF_DRAM_CTL2		0x5
+#define HV_N2_PERF_DRAM_CNT2		0x6
+#define HV_N2_PERF_DRAM_CTL3		0x7
+#define HV_N2_PERF_DRAM_CNT3		0x8
+
+#define HV_FAST_N2_GET_PERFREG		0x104
+#define HV_FAST_N2_SET_PERFREG		0x105
+
+#ifndef __ASSEMBLY__
+extern unsigned long sun4v_niagara_getperf(unsigned long reg,
+					   unsigned long *val);
+extern unsigned long sun4v_niagara_setperf(unsigned long reg,
+					   unsigned long val);
+extern unsigned long sun4v_niagara2_getperf(unsigned long reg,
+					    unsigned long *val);
+extern unsigned long sun4v_niagara2_setperf(unsigned long reg,
+					    unsigned long val);
+#endif
+
 /* MMU statistics services.
  *
  * The hypervisor maintains MMU statistics and privileged code provides
diff --git a/arch/sparc64/kernel/hvcalls.S b/arch/sparc64/kernel/hvcalls.S
index e066269..8a5f35f 100644
--- a/arch/sparc64/kernel/hvcalls.S
+++ b/arch/sparc64/kernel/hvcalls.S
@@ -766,3 +766,35 @@ ENTRY(sun4v_mmu_demap_all)
 	retl
 	 nop
 ENDPROC(sun4v_mmu_demap_all)
+
+ENTRY(sun4v_niagara_getperf)
+	mov	%o0, %o4
+	mov	HV_FAST_GET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	stx	%o1, [%o4]
+	retl
+	 nop
+ENDPROC(sun4v_niagara_getperf)
+
+ENTRY(sun4v_niagara_setperf)
+	mov	HV_FAST_SET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 nop
+ENDPROC(sun4v_niagara_setperf)
+
+ENTRY(sun4v_niagara2_getperf)
+	mov	%o0, %o4
+	mov	HV_FAST_N2_GET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	stx	%o1, [%o4]
+	retl
+	 nop
+ENDPROC(sun4v_niagara2_getperf)
+
+ENTRY(sun4v_niagara2_setperf)
+	mov	HV_FAST_N2_SET_PERFREG, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 nop
+ENDPROC(sun4v_niagara2_setperf)
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 30bba8b..c450825 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -49,6 +49,7 @@
 #include <asm/timer.h>
 #include <asm/cpudata.h>
 #include <asm/ftrace.h>
+#include <asm/hypervisor.h>
 
 struct poll {
 	int fd;
@@ -148,6 +149,11 @@ EXPORT_SYMBOL(flush_dcache_page);
 EXPORT_SYMBOL(__flush_dcache_range);
 #endif
 
+EXPORT_SYMBOL(sun4v_niagara_getperf);
+EXPORT_SYMBOL(sun4v_niagara_setperf);
+EXPORT_SYMBOL(sun4v_niagara2_getperf);
+EXPORT_SYMBOL(sun4v_niagara2_setperf);
+
 #ifdef CONFIG_SUN_AUXIO
 EXPORT_SYMBOL(auxio_set_led);
 EXPORT_SYMBOL(auxio_set_lte);
-- 
1.5.6.5

