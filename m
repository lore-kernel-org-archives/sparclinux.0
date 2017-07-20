From: Allen Pais <allen.pais@oracle.com>
Date: Thu, 20 Jul 2017 07:52:35 +0000
Subject: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Recognize SPARC-M8 cpu type, hardware caps and cpu
distribution map.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
Signed-off-by: David Aldridge <david.j.aldridge@oracle.com>
---
 arch/sparc/include/asm/spitfire.h |  1 +
 arch/sparc/kernel/cpu.c           |  6 ++++++
 arch/sparc/kernel/cpumap.c        |  1 +
 arch/sparc/kernel/head_64.S       |  6 ++++++
 arch/sparc/kernel/setup_64.c      | 15 +++++++++++++--
 arch/sparc/mm/init_64.c           |  2 ++
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 1d8321c..ba3a655 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -47,6 +47,7 @@
 #define SUN4V_CHIP_NIAGARA5	0x05
 #define SUN4V_CHIP_SPARC_M6	0x06
 #define SUN4V_CHIP_SPARC_M7	0x07
+#define SUN4V_CHIP_SPARC_M8	0x08
 #define SUN4V_CHIP_SPARC64X	0x8a
 #define SUN4V_CHIP_SPARC_SN	0x8b
 #define SUN4V_CHIP_UNKNOWN	0xff
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 493e023..ef4f18f 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -506,6 +506,12 @@ static void __init sun4v_cpu_probe(void)
 		sparc_pmu_type = "sparc-m7";
 		break;
 
+	case SUN4V_CHIP_SPARC_M8:
+		sparc_cpu_type = "SPARC-M8";
+		sparc_fpu_type = "SPARC-M8 integrated FPU";
+		sparc_pmu_type = "sparc-m8";
+		break;
+
 	case SUN4V_CHIP_SPARC_SN:
 		sparc_cpu_type = "SPARC-SN";
 		sparc_fpu_type = "SPARC-SN integrated FPU";
diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index 45c820e..90d550b 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -328,6 +328,7 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
 	case SUN4V_CHIP_NIAGARA5:
 	case SUN4V_CHIP_SPARC_M6:
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_M8:
 	case SUN4V_CHIP_SPARC_SN:
 	case SUN4V_CHIP_SPARC64X:
 		rover_inc_table = niagara_iterate_method;
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 41a4073..afcd4ca 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -439,6 +439,9 @@ EXPORT_SYMBOL(sun4v_chip_type)
 	cmp	%g2, '7'
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_M7, %g4
+	cmp	%g2, '8'
+	be,pt	%xcc, 5f
+	 mov	SUN4V_CHIP_SPARC_M8, %g4
 	cmp	%g2, 'N'
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_SN, %g4
@@ -602,6 +605,9 @@ niagara_tlb_fixup:
 	cmp	%g1, SUN4V_CHIP_SPARC_M7
 	be,pt	%xcc, niagara4_patch
 	 nop
+	cmp	%g1, SUN4V_CHIP_SPARC_M8
+	be,pt	%xcc, niagara4_patch
+	 nop
 	cmp	%g1, SUN4V_CHIP_SPARC_SN
 	be,pt	%xcc, niagara4_patch
 	 nop
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 4d9c3e1..150ee7d 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -288,10 +288,17 @@ static void __init sun4v_patch(void)
 
 	sun4v_patch_2insn_range(&__sun4v_2insn_patch,
 				&__sun4v_2insn_patch_end);
-	if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
-	    sun4v_chip_type = SUN4V_CHIP_SPARC_SN)
+
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_M8:
+	case SUN4V_CHIP_SPARC_SN:
 		sun_m7_patch_2insn_range(&__sun_m7_2insn_patch,
 					 &__sun_m7_2insn_patch_end);
+		break;
+	default:
+		break;
+	}
 
 	sun4v_hvapi_init();
 }
@@ -529,6 +536,7 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_M8 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_BLKINIT;
@@ -538,6 +546,7 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_M8 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_N2;
@@ -568,6 +577,7 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_M8 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS | AV_SPARC_VIS2 |
@@ -578,6 +588,7 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_M8 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS3 | AV_SPARC_HPC |
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3c40ebd..a111625 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2138,6 +2138,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 	 */
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_M8:
 	case SUN4V_CHIP_SPARC_SN:
 		pagecv_flag = 0x00;
 		break;
@@ -2290,6 +2291,7 @@ void __init paging_init(void)
 	 */
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_M8:
 	case SUN4V_CHIP_SPARC_SN:
 		page_cache4v_flag = _PAGE_CP_4V;
 		break;
-- 
1.9.1

