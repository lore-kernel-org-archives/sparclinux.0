From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:50:14 +0000
Subject: [PATCH 16/16]: sparc64: Fix sparse warnings in chmc.c
Message-Id: <20080912.145014.266129774.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in chmc.c

Several constants are larger than 32-bit and need "UL" markers.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/chmc.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sparc64/kernel/chmc.c b/arch/sparc64/kernel/chmc.c
index 2ed4010..967b048 100644
--- a/arch/sparc64/kernel/chmc.c
+++ b/arch/sparc64/kernel/chmc.c
@@ -104,20 +104,20 @@ struct chmc {
 
 #define JBUSMC_REGS_SIZE		8
 
-#define JB_MC_REG1_DIMM2_BANK3		0x8000000000000000
-#define JB_MC_REG1_DIMM1_BANK1		0x4000000000000000
-#define JB_MC_REG1_DIMM2_BANK2		0x2000000000000000
-#define JB_MC_REG1_DIMM1_BANK0		0x1000000000000000
-#define JB_MC_REG1_XOR			0x0000010000000000
-#define JB_MC_REG1_ADDR_GEN_2		0x000000e000000000
+#define JB_MC_REG1_DIMM2_BANK3		0x8000000000000000UL
+#define JB_MC_REG1_DIMM1_BANK1		0x4000000000000000UL
+#define JB_MC_REG1_DIMM2_BANK2		0x2000000000000000UL
+#define JB_MC_REG1_DIMM1_BANK0		0x1000000000000000UL
+#define JB_MC_REG1_XOR			0x0000010000000000UL
+#define JB_MC_REG1_ADDR_GEN_2		0x000000e000000000UL
 #define JB_MC_REG1_ADDR_GEN_2_SHIFT	37
-#define JB_MC_REG1_ADDR_GEN_1		0x0000001c00000000
+#define JB_MC_REG1_ADDR_GEN_1		0x0000001c00000000UL
 #define JB_MC_REG1_ADDR_GEN_1_SHIFT	34
-#define JB_MC_REG1_INTERLEAVE		0x0000000001800000
+#define JB_MC_REG1_INTERLEAVE		0x0000000001800000UL
 #define JB_MC_REG1_INTERLEAVE_SHIFT	23
-#define JB_MC_REG1_DIMM2_PTYPE		0x0000000000200000
+#define JB_MC_REG1_DIMM2_PTYPE		0x0000000000200000UL
 #define JB_MC_REG1_DIMM2_PTYPE_SHIFT	21
-#define JB_MC_REG1_DIMM1_PTYPE		0x0000000000100000
+#define JB_MC_REG1_DIMM1_PTYPE		0x0000000000100000UL
 #define JB_MC_REG1_DIMM1_PTYPE_SHIFT	20
 
 #define PART_TYPE_X8		0
-- 
1.5.6.5.GIT

