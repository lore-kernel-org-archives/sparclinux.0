From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 02 Dec 2009 14:30:20 +0000
Subject: [PATCH 1/3] sparc,leon: Added Aeroflex Gaisler entry in manufacturer_info structure
Message-Id: <1259764222-1802-2-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/cpu.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 1446df9..e447938 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -185,6 +185,17 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(-1, NULL)
 	}
 },{
+	0xF,		/* Aeroflex Gaisler */
+	.cpu_info = {
+		CPU(3, "LEON"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(2, "GRFPU"),
+		FPU(3, "GRFPU-Lite"),
+		FPU(-1, NULL)
+	}
+},{
 	0x17,
 	.cpu_info = {
 		CPU_PMU(0x10, "TI UltraSparc I   (SpitFire)", "ultra12"),
-- 
1.6.4.1

