From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 27 Jan 2011 11:06:32 +0000
Subject: [PATCH] sparc: cleaned up FPU version probing
Message-Id: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/psr.h |   51 ++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/cpu.c      |   11 +++++---
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/psr.h b/arch/sparc/include/asm/psr.h
index b8c0e5f..3b34c5a 100644
--- a/arch/sparc/include/asm/psr.h
+++ b/arch/sparc/include/asm/psr.h
@@ -6,11 +6,14 @@
  *        PSTATE.PRIV for the current CPU privilege level.
  *
  * Copyright (C) 1994 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 2011 Daniel Hellstrom (daniel@gaisler.com)
  */
 
 #ifndef __LINUX_SPARC_PSR_H
 #define __LINUX_SPARC_PSR_H
 
+#include <linux/const.h>
+
 /* The Sparc PSR fields are laid out as the following:
  *
  *  ------------------------------------------------------------------------
@@ -34,6 +37,54 @@
 #define PSR_N       0x00800000         /* negative bit               */
 #define PSR_VERS    0x0f000000         /* cpu-version field          */
 #define PSR_IMPL    0xf0000000         /* cpu-implementation field   */
+#define PSR_CWP_SHIFT     0
+#define PSR_ET_SHIFT      5
+#define PSR_PS_SHIFT      6
+#define PSR_S_SHIFT       7
+#define PSR_PIL_SHIFT     8
+#define PSR_EF_SHIFT      12
+#define PSR_EC_SHIFT      13
+#define PSR_SYSCALL_SHIFT 14
+#define PSR_LE_SHIFT      15
+#define PSR_ICC_SHIFT     20
+#define PSR_C_SHIFT       20
+#define PSR_V_SHIFT       21
+#define PSR_Z_SHIFT       22
+#define PSR_N_SHIFT       23
+#define PSR_VERS_SHIFT    24
+#define PSR_IMPL_SHIFT    28
+
+/*
+ * The SPARC v7/v8/v9 FPU FSR Register bits. fcc on v7/v8 is equal to
+ * fcc0 on v9.
+ */
+#define FSR_CEXC    0x0000001f             /* current exception      */
+#define FSR_AEXC    0x000003e0             /* accured exception      */
+#define FSR_FCC0    0x00000c00             /* FP condition code 0    */
+#define FSR_QNE     0x00002000             /* FQ not empty           */
+#define FSR_FTT     0x0001c000             /* FP trap type           */
+#define FSR_VER     0x000e0000             /* FPU version            */
+#define FSR_NS      0x00400000             /* Non standard FP        */
+#define FSR_TEM     0x0f800000             /* FPU trap enable mask   */
+#define FSR_RD      0xc0000000             /* Rounding direction     */
+#define FSR_FCC1    _AC(0x00300000000, UL) /* v9 FP condition code 1 */
+#define FSR_FCC2    _AC(0x0c00000000, UL)  /* v9 FP condition code 2 */
+#define FSR_FCC3    _AC(0x3000000000, UL)  /* v9 FP condition code 3 */
+#define FSR_CEXC_SHIFT  0
+#define FSR_AEXC_SHIFT  5
+#define FSR_FCC0_SHIFT  10
+#define FSR_QNE_SHIFT   13
+#define FSR_FTT_SHIFT   14
+#define FSR_VER_SHIFT   17
+#define FSR_NS_SHIFT    22
+#define FSR_TEM_SHIFT   23
+#define FSR_RD_SHIFT    30
+#define FSR_FCC1_SHIFT  32
+#define FSR_FCC2_SHIFT  34
+#define FSR_FCC3_SHIFT  36
+
+/* FSR.ver=7 when no FPU available */
+#define FSR_VER_NOFPU 7
 
 #ifdef __KERNEL__
 
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 7925c54..bc8d5ef 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -318,15 +318,18 @@ void __cpuinit cpu_probe(void)
 	int psr_impl, psr_vers, fpu_vers;
 	int psr;
 
-	psr_impl = ((get_psr() >> 28) & 0xf);
-	psr_vers = ((get_psr() >> 24) & 0xf);
+	psr_impl = ((get_psr() & PSR_IMPL) >> PSR_IMPL_SHIFT);
+	psr_vers = ((get_psr() & PSR_VERS) >> PSR_VERS_SHIFT);
 
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
 #ifdef CONFIG_SPARC_LEON
-	fpu_vers = get_psr() & PSR_EF ? ((get_fsr() >> 17) & 0x7) : 7;
+	if (get_psr() & PSR_EF)
+		fpu_vers =  (get_fsr() & FSR_VER) >> FSR_VER_SHIFT;
+	else
+		fpu_vers = FSR_VER_NOFPU;
 #else
-	fpu_vers = ((get_fsr() >> 17) & 0x7);
+	fpu_vers = ((get_fsr() & FSR_VER) >> FSR_VER_SHIFT);
 #endif
 
 	put_psr(psr);
-- 
1.5.4

