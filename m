From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 08 Sep 2014 06:30:55 +0000
Subject: [PATCH v2 3/3] sparc64: cpu hardware caps support for sparc M6 and M7
Message-Id: <1410157135-20393-3-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/kernel/setup_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 3fdb455..1c7bfdf 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -500,12 +500,16 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_BLKINIT;
 		if (sun4v_chip_type = SUN4V_CHIP_NIAGARA2 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
 		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_N2;
 	}
@@ -533,6 +537,8 @@ static void __init init_sparc64_elf_hwcap(void)
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS | AV_SPARC_VIS2 |
 					AV_SPARC_ASI_BLK_INIT |
@@ -540,6 +546,8 @@ static void __init init_sparc64_elf_hwcap(void)
 			if (sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_M6 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC_M7 ||
 			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS3 | AV_SPARC_HPC |
 					AV_SPARC_FMAF);
-- 
1.8.4.2

