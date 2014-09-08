From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 08 Sep 2014 06:30:53 +0000
Subject: [PATCH v2 1/3] sparc64: correctly recognise M6 and M7 cpu type
Message-Id: <1410157135-20393-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following patch adds support for correctly
recognising M6 and M7 cpu type.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/include/asm/spitfire.h |  2 ++
 arch/sparc/kernel/cpu.c           | 12 ++++++++++++
 arch/sparc/kernel/head_64.S       | 12 ++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 3fc58691..56f9338 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -45,6 +45,8 @@
 #define SUN4V_CHIP_NIAGARA3	0x03
 #define SUN4V_CHIP_NIAGARA4	0x04
 #define SUN4V_CHIP_NIAGARA5	0x05
+#define SUN4V_CHIP_SPARC_M6	0x06
+#define SUN4V_CHIP_SPARC_M7	0x07
 #define SUN4V_CHIP_SPARC64X	0x8a
 #define SUN4V_CHIP_UNKNOWN	0xff
 
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 82a3a71..dfad8b1 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -494,6 +494,18 @@ static void __init sun4v_cpu_probe(void)
 		sparc_pmu_type = "niagara5";
 		break;
 
+	case SUN4V_CHIP_SPARC_M6:
+		sparc_cpu_type = "SPARC-M6";
+		sparc_fpu_type = "SPARC-M6 integrated FPU";
+		sparc_pmu_type = "sparc-m6";
+		break;
+
+	case SUN4V_CHIP_SPARC_M7:
+		sparc_cpu_type = "SPARC-M7";
+		sparc_fpu_type = "SPARC-M7 integrated FPU";
+		sparc_pmu_type = "sparc-m7";
+		break;
+
 	case SUN4V_CHIP_SPARC64X:
 		sparc_cpu_type = "SPARC64-X";
 		sparc_fpu_type = "SPARC64-X integrated FPU";
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 452f04f..4fdeb80 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -427,6 +427,12 @@ sun4v_chip_type:
 	cmp	%g2, '5'
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA5, %g4
+	cmp	%g2, '6'
+	be,pt	%xcc, 5f
+	 mov	SUN4V_CHIP_SPARC_M6, %g4
+	cmp	%g2, '7'
+	be,pt	%xcc, 5f
+	 mov	SUN4V_CHIP_SPARC_M7, %g4
 	ba,pt	%xcc, 49f
 	 nop
 
@@ -585,6 +591,12 @@ niagara_tlb_fixup:
 	cmp	%g1, SUN4V_CHIP_NIAGARA5
 	be,pt	%xcc, niagara4_patch
 	 nop
+	cmp	%g1, SUN4V_CHIP_SPARC_M6
+	be,pt	%xcc, niagara4_patch
+	 nop
+	cmp	%g1, SUN4V_CHIP_SPARC_M7
+	be,pt	%xcc, niagara4_patch
+	 nop
 
 	call	generic_patch_copyops
 	 nop
-- 
1.8.4.2

