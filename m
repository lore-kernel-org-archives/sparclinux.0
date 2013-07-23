From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 23 Jul 2013 11:32:38 +0000
Subject: [PATCH 1/2] [sparc64] cpu hw caps support for sparc64x
Message-Id: <1374578438-2861-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/kernel/setup_64.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 1378554..3fdb455 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -499,12 +499,14 @@ static void __init init_sparc64_elf_hwcap(void)
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA2 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
-		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5)
+		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_BLKINIT;
 		if (sun4v_chip_type = SUN4V_CHIP_NIAGARA2 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 		    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
-		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5)
+		    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+		    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 			cap |= HWCAP_SPARC_N2;
 	}
 
@@ -530,13 +532,15 @@ static void __init init_sparc64_elf_hwcap(void)
 			if (sun4v_chip_type = SUN4V_CHIP_NIAGARA2 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
-			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5)
+			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS | AV_SPARC_VIS2 |
 					AV_SPARC_ASI_BLK_INIT |
 					AV_SPARC_POPC);
 			if (sun4v_chip_type = SUN4V_CHIP_NIAGARA3 ||
 			    sun4v_chip_type = SUN4V_CHIP_NIAGARA4 ||
-			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5)
+			    sun4v_chip_type = SUN4V_CHIP_NIAGARA5 ||
+			    sun4v_chip_type = SUN4V_CHIP_SPARC64X)
 				cap |= (AV_SPARC_VIS3 | AV_SPARC_HPC |
 					AV_SPARC_FMAF);
 		}
-- 
1.7.10.4

