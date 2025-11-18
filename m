Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E162E888C
	for <sparclinux@vger.kernel.org>; Tue, 18 Nov 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763472318; cv=none; b=sxTR04oWgLVW7n/JFPAA3qnQymVtmNq4bRezWENQjDpnR5MWOEi/azUvARagKmfV08YvG8mqueny8TN3C/ABb54M8EksssAKcJRfPLgG0RMEWE9VB7Kj/mlrwidImT8DqHqxKDv2vXy9IWsPWh2PAFySzdN56DWHQttIy2fjXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763472318; c=relaxed/simple;
	bh=je1pf5IVSuzxqfukr7jP2vJ1NVCkk8A6nFBwbbBT628=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=dvrwPylChl4KOwMXyOpV+oyhWdU6itor3kstDHO6z5SS51PB2hyTEoCtgYQLodow+bYEVJpkdIYf7mGMmXK6zeoEosRl+jimIMnVkVU7Xty+KL6HAvZ50G3FD/PyM12AKUFGSSMWjz7WL+LhUVyu4fgDSFPzCsmdrPb8HgdrQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=BDugBwMO; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="BDugBwMO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=HqAnscOu8qOAY02GznLodFxpKw8qgPyFwyJbYKDFYR8=; b=B
	DugBwMOsKLUbqh6yrxoNdTbWhgxe6lIgyHXPlIOW0tP+hx4eWg+lcQ2Kyite1+S0aHto0b0oHLkVI
	PCXwjyzVRA3gSbyWtYY3KZJnLSa7MNml0eZLmLW6gGRsV6ajWdZPZHcLiZZk49nBfF6XLTr4vscjx
	h+PPT7VwPkBZqiGQU1VNJbfEhBHIlNTkuds5Tve/DWo8TahrkbCkXffnX+ExqzaErwU/ziA7UjJHq
	H1m5T2u02oWQlsEU30dLEJJ17J+zN/Wlf8bXq5K6oIzhw7iajYChzONqEWr/v8vNNJb3UiTTonZDC
	66x9pODl7zowQc8aUVYNR/HfLGKvyRTdw==;
Date: Tue, 18 Nov 2025 14:25:21 +0100 (CET)
Message-Id: <20251118.142521.973960159957848254.rene@exactco.de>
To: sparclinux@vger.kernel.org
Cc: Joe Moriarty <joe.moriarty@oracle.com>, Dave Aldridge
 <david.j.aldridge@oracle.com>, Allen Pais <allen.pais@oracle.com>, "David
 S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] sparc: Correctly recognize Sonoma S7/S8 cpus and perf
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fix SPARC Sonoma S7 incorrectly identify as M7. Orabug: 23041

Add support for Sonoma S7 into perf to ensure that perf will
recognise that it is running on a Sonoma device and initialize
correctly. Orabug: 24931042

Rename SN to correctly identifying Sonoma 2 systems. Orabug: 22960812

While at it, fix S8 to use M7 optimizations instead of Niagra4, too.

Signed-off-by: René Rebe <rene@exactco.de>
Originally-by: Joe Moriarty <joe.moriarty@oracle.com>
Originally-by: Dave Aldridge <david.j.aldridge@oracle.com>
Originally-by: Allen Pais <allen.pais@oracle.com>
---
Changes:
- rebase and cleanup
- use sparc_m7_patch in niagara_tlb_fixup for all Sonoma
- use sparc_m7_pmu
---
Based on previous patches series shipped by Oracle UEK Linux:
https://github.com/sparclinux/linux-uek/commit/01bd59051e17dc04785211350a05fd337460b86b
https://github.com/sparclinux/linux-uek/commit/e3125b871798dcd831daaf70bb05ff3f005277fb
https://github.com/sparclinux/linux-uek/commit/4bd843999066b23fe501ead37e94bf716d2b7c6a
---
 arch/sparc/include/asm/spitfire.h |  3 ++-
 arch/sparc/kernel/cpu.c           | 14 ++++++++++----
 arch/sparc/kernel/cpumap.c        |  3 ++-
 arch/sparc/kernel/head_64.S       | 19 +++++++++++++++----
 arch/sparc/kernel/pcr.c           |  2 ++
 arch/sparc/kernel/perf_event.c    |  3 ++-
 arch/sparc/kernel/setup_64.c      | 15 ++++++++++-----
 arch/sparc/mm/init_64.c           |  9 ++++++---
 8 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 79b9dd5e9ac6..96cbd15f3094 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -49,8 +49,9 @@
 #define SUN4V_CHIP_SPARC_M6	0x06
 #define SUN4V_CHIP_SPARC_M7	0x07
 #define SUN4V_CHIP_SPARC_M8	0x08
+#define SUN4V_CHIP_SPARC_S7	0x7a
 #define SUN4V_CHIP_SPARC64X	0x8a
-#define SUN4V_CHIP_SPARC_SN	0x8b
+#define SUN4V_CHIP_SPARC_S8	0x8b
 #define SUN4V_CHIP_UNKNOWN	0xff
 
 /*
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 79cd6ccfeac0..aa51a8cee84f 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -513,10 +513,16 @@ static void __init sun4v_cpu_probe(void)
 		sparc_pmu_type = "sparc-m8";
 		break;
 
-	case SUN4V_CHIP_SPARC_SN:
-		sparc_cpu_type = "SPARC-SN";
-		sparc_fpu_type = "SPARC-SN integrated FPU";
-		sparc_pmu_type = "sparc-sn";
+	case SUN4V_CHIP_SPARC_S7:
+		sparc_cpu_type = "SPARC-S7 (Sonoma)";
+		sparc_fpu_type = "SPARC-S7 integrated FPU";
+		sparc_pmu_type = "sparc-s7";
+		break;
+
+	case SUN4V_CHIP_SPARC_S8:
+		sparc_cpu_type = "SPARC-S8 (Sonoma 2)";
+		sparc_fpu_type = "SPARC-S8 integrated FPU";
+		sparc_pmu_type = "sparc-s8";
 		break;
 
 	case SUN4V_CHIP_SPARC64X:
diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index 8fcf2d8c6bd2..d64af5b88eb7 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -328,8 +328,9 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
 	case SUN4V_CHIP_NIAGARA5:
 	case SUN4V_CHIP_SPARC_M6:
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_S7:
 	case SUN4V_CHIP_SPARC_M8:
-	case SUN4V_CHIP_SPARC_SN:
+	case SUN4V_CHIP_SPARC_S8:
 	case SUN4V_CHIP_SPARC64X:
 		rover_inc_table = niagara_iterate_method;
 		break;
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index cf0549134234..a48a2dc3e857 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -421,6 +421,7 @@ EXPORT_SYMBOL(sun4v_chip_type)
 	 cmp	%g2, 'M'
 	be,pt	%xcc, 70f
 	 cmp	%g2, 'S'
+       be,pt   %xcc, 71f
 	bne,pn	%xcc, 49f
 	 nop
 
@@ -443,10 +444,17 @@ EXPORT_SYMBOL(sun4v_chip_type)
 	cmp	%g2, CPU_ID_M8
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_M8, %g4
-	cmp	%g2, CPU_ID_SONOMA1
+	ba,pt	%xcc, 49f
+	 nop
+71:
+	ldub    [%g1 + 7], %g2
+	cmp     %g2, '7'
 	be,pt	%xcc, 5f
-	 mov	SUN4V_CHIP_SPARC_SN, %g4
+	 mov	SUN4V_CHIP_SPARC_S7, %g4
 	ba,pt	%xcc, 49f
+	cmp	%g2, '8'
+	be,pt	%xcc, 5f
+	 mov	SUN4V_CHIP_SPARC_S8, %g4
 	 nop
 
 91:	sethi	%hi(prom_cpu_compatible), %g1
@@ -609,8 +617,11 @@ niagara_tlb_fixup:
 	cmp	%g1, SUN4V_CHIP_SPARC_M8
 	be,pt	%xcc, sparc_m7_patch
 	 nop
-	cmp	%g1, SUN4V_CHIP_SPARC_SN
-	be,pt	%xcc, niagara4_patch
+	cmp	%g1, SUN4V_CHIP_SPARC_S7
+	be,pt	%xcc, sparc_m7_patch
+	 nop
+	cmp	%g1, SUN4V_CHIP_SPARC_S8
+	be,pt	%xcc, sparc_m7_patch
 	 nop
 
 	call	generic_patch_copyops
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 2a12c86af956..72ef532c06aa 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -275,6 +275,7 @@ static int __init register_perf_hsvc(void)
 			break;
 
 		case SUN4V_CHIP_SPARC_M7:
+		case SUN4V_CHIP_SPARC_S7:
 			perf_hsvc_group = HV_GRP_M7_PERF;
 			break;
 
@@ -324,6 +325,7 @@ static int __init setup_sun4v_pcr_ops(void)
 		break;
 
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_S7:
 		pcr_ops = &m7_pcr_ops;
 		break;
 
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index cae4d33002a5..4fc56d8fbf84 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1705,7 +1705,8 @@ static bool __init supported_pmu(void)
 		sparc_pmu = &niagara4_pmu;
 		return true;
 	}
-	if (!strcmp(sparc_pmu_type, "sparc-m7")) {
+	if (!strcmp(sparc_pmu_type, "sparc-m7") ||
+	    !strcmp(sparc_pmu_type, "sparc-s7")) {
 		sparc_pmu = &sparc_m7_pmu;
 		return true;
 	}
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..ef78faec1506 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -277,8 +277,9 @@ static void __init sun4v_patch(void)
 
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_S7:
 	case SUN4V_CHIP_SPARC_M8:
-	case SUN4V_CHIP_SPARC_SN:
+	case SUN4V_CHIP_SPARC_S8:
 		sun4v_patch_1insn_range(&__sun_m7_1insn_patch,
 					&__sun_m7_1insn_patch_end);
 		sun_m7_patch_2insn_range(&__sun_m7_2insn_patch,
@@ -530,8 +531,9 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type == SUN4V_CHIP_NIAGARA5 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC_M6 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC_M7 ||
+		    sun4v_chip_type == SUN4V_CHIP_SPARC_S7 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC_M8 ||
-		    sun4v_chip_type == SUN4V_CHIP_SPARC_SN ||
+		    sun4v_chip_type == SUN4V_CHIP_SPARC_S8 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_BLKINIT;
 		if (sun4v_chip_type == SUN4V_CHIP_NIAGARA2 ||
@@ -540,8 +542,9 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type == SUN4V_CHIP_NIAGARA5 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC_M6 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC_M7 ||
+		    sun4v_chip_type == SUN4V_CHIP_SPARC_S7 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC_M8 ||
-		    sun4v_chip_type == SUN4V_CHIP_SPARC_SN ||
+		    sun4v_chip_type == SUN4V_CHIP_SPARC_S8 ||
 		    sun4v_chip_type == SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_N2;
 	}
@@ -571,8 +574,9 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type == SUN4V_CHIP_NIAGARA5 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC_M6 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC_M7 ||
+			    sun4v_chip_type == SUN4V_CHIP_SPARC_S7 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC_M8 ||
-			    sun4v_chip_type == SUN4V_CHIP_SPARC_SN ||
+			    sun4v_chip_type == SUN4V_CHIP_SPARC_S8 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS | AV_SPARC_VIS2 |
 					AV_SPARC_ASI_BLK_INIT |
@@ -583,7 +587,8 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type == SUN4V_CHIP_SPARC_M6 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC_M7 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC_M8 ||
-			    sun4v_chip_type == SUN4V_CHIP_SPARC_SN ||
+			    sun4v_chip_type == SUN4V_CHIP_SPARC_S7 ||
+			    sun4v_chip_type == SUN4V_CHIP_SPARC_S8 ||
 			    sun4v_chip_type == SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS3 | AV_SPARC_HPC |
 					AV_SPARC_FMAF);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..8b2ea31b2971 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1989,7 +1989,8 @@ static void __init setup_page_offset(void)
 			max_phys_bits = 47;
 			break;
 		case SUN4V_CHIP_SPARC_M7:
-		case SUN4V_CHIP_SPARC_SN:
+		case SUN4V_CHIP_SPARC_S7:
+		case SUN4V_CHIP_SPARC_S8:
 			/* M7 and later support 52-bit virtual addresses.  */
 			sparc64_va_hole_top =    0xfff8000000000000UL;
 			sparc64_va_hole_bottom = 0x0008000000000000UL;
@@ -2217,8 +2218,9 @@ static void __init sun4v_linear_pte_xor_finalize(void)
 	 */
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_S7:
 	case SUN4V_CHIP_SPARC_M8:
-	case SUN4V_CHIP_SPARC_SN:
+	case SUN4V_CHIP_SPARC_S8:
 		pagecv_flag = 0x00;
 		break;
 	default:
@@ -2332,8 +2334,9 @@ void __init paging_init(void)
 	 */
 	switch (sun4v_chip_type) {
 	case SUN4V_CHIP_SPARC_M7:
+	case SUN4V_CHIP_SPARC_S7:
 	case SUN4V_CHIP_SPARC_M8:
-	case SUN4V_CHIP_SPARC_SN:
+	case SUN4V_CHIP_SPARC_S8:
 		page_cache4v_flag = _PAGE_CP_4V;
 		break;
 	default:
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
