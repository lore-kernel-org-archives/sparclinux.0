From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 19 Aug 2014 04:53:50 +0000
Subject: [PATCH 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 The following patch adds support for correctly
recognising M7 cpu type.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/include/asm/spitfire.h |    1 +
 arch/sparc/kernel/cpu.c           |    6 ++++++
 arch/sparc/kernel/head_64.S       |   13 +++++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 3fc5869..9aec17b 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -45,6 +45,7 @@
 #define SUN4V_CHIP_NIAGARA3	0x03
 #define SUN4V_CHIP_NIAGARA4	0x04
 #define SUN4V_CHIP_NIAGARA5	0x05
+#define SUN4V_CHIP_SPARC_M7	0x08
 #define SUN4V_CHIP_SPARC64X	0x8a
 #define SUN4V_CHIP_UNKNOWN	0xff
 
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 82a3a71..55dfb62 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -494,6 +494,12 @@ static void __init sun4v_cpu_probe(void)
 		sparc_pmu_type = "niagara5";
 		break;
 
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
index 452f04f..508a542 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -414,6 +414,7 @@ sun4v_chip_type:
 	cmp	%g2, 'T'
 	be,pt	%xcc, 70f
 	 cmp	%g2, 'M'
+	be,pt	%xcc, 71f
 	bne,pn	%xcc, 49f
 	 nop
 
@@ -430,6 +431,14 @@ sun4v_chip_type:
 	ba,pt	%xcc, 49f
 	 nop
 
+71:
+	ldub	[%g1 + 7], %g2
+	cmp	%g2, '7'
+	be,pt	%xcc, 5f
+	 mov	SUN4V_CHIP_SPARC_M7, %g4
+	ba,pt	%xcc, 49f
+	 nop
+
 91:	sethi	%hi(prom_cpu_compatible), %g1
 	or	%g1, %lo(prom_cpu_compatible), %g1
 	ldub	[%g1 + 17], %g2
@@ -586,6 +595,10 @@ niagara_tlb_fixup:
 	be,pt	%xcc, niagara4_patch
 	 nop
 
+	cmp	%g1, SUN4V_CHIP_SPARC_M7
+	be,pt	%xcc, niagara4_patch
+	 nop
+
 	call	generic_patch_copyops
 	 nop
 	call	generic_patch_bzero
-- 
1.7.1

