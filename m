From: Allen Pais <allen.pais@oracle.com>
Date: Wed, 06 Mar 2013 09:59:59 +0000
Subject: [PATCH v1] [SPARC64] correctly recognize SPARC64-X chips
Message-Id: <1362563279-23839-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following patch adds support for correctly
recognizing SPARC-X chips.

cpu : Unknown SUN4V CPU
fpu : Unknown SUN4V FPU
pmu : Unknown SUN4V PMU

Signed-off-by: Katayama Yoshihiro <kata1@jp.fujitsu.com>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/include/asm/spitfire.h |    1 +
 arch/sparc/kernel/cpu.c           |    6 ++++++
 arch/sparc/kernel/head_64.S       |   25 +++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index d06a2660..6b67e50 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -45,6 +45,7 @@
 #define SUN4V_CHIP_NIAGARA3	0x03
 #define SUN4V_CHIP_NIAGARA4	0x04
 #define SUN4V_CHIP_NIAGARA5	0x05
+#define SUN4V_CHIP_SPARC64X	0x8a
 #define SUN4V_CHIP_UNKNOWN	0xff
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index a6c94a2..5c51258 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -493,6 +493,12 @@ static void __init sun4v_cpu_probe(void)
 		sparc_pmu_type = "niagara5";
 		break;
 
+	case SUN4V_CHIP_SPARC64X:
+		sparc_cpu_type = "SPARC64-X";
+		sparc_fpu_type = "SPARC64-X integrated FPU";
+		sparc_pmu_type = "sparc64-x";
+		break;
+
 	default:
 		printk(KERN_WARNING "CPU: Unknown sun4v cpu type [%s]\n",
 		       prom_cpu_compatible);
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 2feb15c..26b706a 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -134,6 +134,8 @@ prom_niagara_prefix:
 	.asciz	"SUNW,UltraSPARC-T"
 prom_sparc_prefix:
 	.asciz	"SPARC-"
+prom_sparc64x_prefix:
+	.asciz	"SPARC64-X"
 	.align	4
 prom_root_compatible:
 	.skip	64
@@ -412,7 +414,7 @@ sun4v_chip_type:
 	cmp	%g2, 'T'
 	be,pt	%xcc, 70f
 	 cmp	%g2, 'M'
-	bne,pn	%xcc, 4f
+	bne,pn	%xcc, 49f
 	 nop
 
 70:	ldub	[%g1 + 7], %g2
@@ -425,7 +427,7 @@ sun4v_chip_type:
 	cmp	%g2, '5'
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA5, %g4
-	ba,pt	%xcc, 4f
+	ba,pt	%xcc, 49f
 	 nop
 
 91:	sethi	%hi(prom_cpu_compatible), %g1
@@ -439,6 +441,25 @@ sun4v_chip_type:
 	 mov	SUN4V_CHIP_NIAGARA2, %g4
 	
 4:
+	/* Athena */
+	sethi	%hi(prom_cpu_compatible), %g1
+	or	%g1, %lo(prom_cpu_compatible), %g1
+	sethi	%hi(prom_sparc64x_prefix), %g7
+	or	%g7, %lo(prom_sparc64x_prefix), %g7
+	mov	9, %g3
+41:	ldub	[%g7], %g2
+	ldub	[%g1], %g4
+	cmp	%g2, %g4
+	bne,pn	%icc, 49f
+	add	%g7, 1, %g7
+	subcc	%g3, 1, %g3
+	bne,pt	%xcc, 41b
+	add	%g1, 1, %g1
+	mov	SUN4V_CHIP_SPARC64X, %g4
+	ba,pt	%xcc, 5f
+	nop
+
+49:
 	mov	SUN4V_CHIP_UNKNOWN, %g4
 5:	sethi	%hi(sun4v_chip_type), %g2
 	or	%g2, %lo(sun4v_chip_type), %g2
-- 
1.7.10.4

