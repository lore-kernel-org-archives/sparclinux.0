From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 19 Apr 2016 17:12:54 +0000
Subject: [PATCH] sparc64: recognize and support Sonoma CPU type
Message-Id: <1461085974-13534-1-git-send-email-khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, allen.pais@oracle.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, david.j.aldridge@oracle.com, rob.gardner@oracle.com, nitin.m.gupta@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, khalid@gonehiking.org

Add code to recognize SPARC-Sonoma cpu correctly and update cpu hardware
caps and cpu distribution map. SPARC-Sonoma is based upon SPARC-M7 core
along with additional PCI functions added on and is reported by firmware
as "SPARC-SN".

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/sparc/include/asm/spitfire.h | 1 +
 arch/sparc/kernel/cpu.c           | 6 ++++++
 arch/sparc/kernel/cpumap.c        | 1 +
 arch/sparc/kernel/head_64.S       | 8 ++++++++
 arch/sparc/kernel/setup_64.c      | 7 ++++++-
 arch/sparc/mm/init_64.c           | 3 +++
 6 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 56f9338..1d8321c 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -48,6 +48,7 @@
 #define SUN4V_CHIP_SPARC_M6	0x06
 #define SUN4V_CHIP_SPARC_M7	0x07
 #define SUN4V_CHIP_SPARC64X	0x8a
+#define SUN4V_CHIP_SPARC_SN	0x8b
 #define SUN4V_CHIP_UNKNOWN	0xff
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index dfad8b1..493e023 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -506,6 +506,12 @@ static void __init sun4v_cpu_probe(void)
 		sparc_pmu_type = "sparc-m7";
 		break;
 
+	case SUN4V_CHIP_SPARC_SN:
+		sparc_cpu_type = "SPARC-SN";
+		sparc_fpu_type = "SPARC-SN integrated FPU";
+		sparc_pmu_type = "sparc-sn";
+		break;
+
 	case SUN4V_CHIP_SPARC64X:
 		sparc_cpu_type = "SPARC64-X";
 		sparc_fpu_type = "SPARC64-X integrated FPU";
diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index e69ec0e..45c820e 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -328,6 +328,7 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
 	case SUN4V_CHIP_NIAGARA5:
 	case SUN4V_CHIP_SPARC_M6:
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_SN:
 	case SUN4V_CHIP_SPARC64X:
 		rover_inc_table = niagara_iterate_method;
 		break;
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index f2d30ca..aff3ea8 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -414,6 +414,8 @@ sun4v_chip_type:
 	cmp	%g2, 'T'
 	be,pt	%xcc, 70f
 	 cmp	%g2, 'M'
+	be,pt	%xcc, 70f
+	 cmp	%g2, 'S'
 	bne,pn	%xcc, 49f
 	 nop
 
@@ -433,6 +435,9 @@ sun4v_chip_type:
 	cmp	%g2, '7'
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_M7, %g4
+	cmp	%g2, 'N'
+	be,pt	%xcc, 5f
+	 mov	SUN4V_CHIP_SPARC_SN, %g4
 	ba,pt	%xcc, 49f
 	 nop
 
@@ -597,6 +602,9 @@ niagara_tlb_fixup:
 	cmp	%g1, SUN4V_CHIP_SPARC_M7
 	be,pt	%xcc, niagara4_patch
 	 nop
+	cmp	%g1, SUN4V_CHIP_SPARC_SN
+	be,pt	%xcc, niagara4_patch
+	 nop
 
 	call	generic_patch_copyops
 	 nop
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index f3185e2..9e3cdfc 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -285,7 +285,8 @@ static void __init sun4v_patch(void)
 
 	sun4v_patch_2insn_range(&__sun4v_2insn_patch,
 				&__sun4v_2insn_patch_end);
-	if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7)
+	if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+	    sun4v_chip_type = SUN4V_CHIP_SPARC_SN)
 		sun_m7_patch_2insn_range(&__sun_m7_2insn_patch,
 					 &__sun_m7_2insn_patch_end);
 
@@ -524,6 +525,7 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_BLKINIT;
 		if (sun4v_chip_type = SUN4V_CHIP_NIAGARA2 ||
@@ -532,6 +534,7 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_N2;
 	}
@@ -561,6 +564,7 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS | AV_SPARC_VIS2 |
 					AV_SPARC_ASI_BLK_INIT |
@@ -570,6 +574,7 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_SN ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS3 | AV_SPARC_HPC |
 					AV_SPARC_FMAF);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 6f21685..ee953f9 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1769,6 +1769,7 @@ static void __init setup_page_offset(void)
 			max_phys_bits = 47;
 			break;
 		case SUN4V_CHIP_SPARC_M7:
+		case SUN4V_CHIP_SPARC_SN:
 		default:
 			/* M7 and later support 52-bit virtual addresses.  */
 			sparc64_va_hole_top =    0xfff8000000000000UL;
@@ -1986,6 +1987,7 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 	 */
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_SN:
 		pagecv_flag = 0x00;
 		break;
 	default:
@@ -2138,6 +2140,7 @@ void __init paging_init(void)
 	 */
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_SN:
 		page_cache4v_flag = _PAGE_CP_4V;
 		break;
 	default:
-- 
2.1.4

