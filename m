From: David Miller <davem@davemloft.net>
Date: Mon, 31 Oct 2011 08:24:26 +0000
Subject: [PATCH] sparc64: Fix masking and shifting in VIS fpcmp emulation.
Message-Id: <20111031.042426.1575599469581271017.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/visemul.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/visemul.c b/arch/sparc/kernel/visemul.c
index 32b626c..7337067 100644
--- a/arch/sparc/kernel/visemul.c
+++ b/arch/sparc/kernel/visemul.c
@@ -713,17 +713,17 @@ static void pcmp(struct pt_regs *regs, unsigned int insn, unsigned int opf)
 			s16 b = (rs2 >> (i * 16)) & 0xffff;
 
 			if (a > b)
-				rd_val |= 1 << i;
+				rd_val |= 8 >> i;
 		}
 		break;
 
 	case FCMPGT32_OPF:
 		for (i = 0; i < 2; i++) {
-			s32 a = (rs1 >> (i * 32)) & 0xffff;
-			s32 b = (rs2 >> (i * 32)) & 0xffff;
+			s32 a = (rs1 >> (i * 32)) & 0xffffffff;
+			s32 b = (rs2 >> (i * 32)) & 0xffffffff;
 
 			if (a > b)
-				rd_val |= 1 << i;
+				rd_val |= 2 >> i;
 		}
 		break;
 
@@ -733,17 +733,17 @@ static void pcmp(struct pt_regs *regs, unsigned int insn, unsigned int opf)
 			s16 b = (rs2 >> (i * 16)) & 0xffff;
 
 			if (a <= b)
-				rd_val |= 1 << i;
+				rd_val |= 8 >> i;
 		}
 		break;
 
 	case FCMPLE32_OPF:
 		for (i = 0; i < 2; i++) {
-			s32 a = (rs1 >> (i * 32)) & 0xffff;
-			s32 b = (rs2 >> (i * 32)) & 0xffff;
+			s32 a = (rs1 >> (i * 32)) & 0xffffffff;
+			s32 b = (rs2 >> (i * 32)) & 0xffffffff;
 
 			if (a <= b)
-				rd_val |= 1 << i;
+				rd_val |= 2 >> i;
 		}
 		break;
 
@@ -753,17 +753,17 @@ static void pcmp(struct pt_regs *regs, unsigned int insn, unsigned int opf)
 			s16 b = (rs2 >> (i * 16)) & 0xffff;
 
 			if (a != b)
-				rd_val |= 1 << i;
+				rd_val |= 8 >> i;
 		}
 		break;
 
 	case FCMPNE32_OPF:
 		for (i = 0; i < 2; i++) {
-			s32 a = (rs1 >> (i * 32)) & 0xffff;
-			s32 b = (rs2 >> (i * 32)) & 0xffff;
+			s32 a = (rs1 >> (i * 32)) & 0xffffffff;
+			s32 b = (rs2 >> (i * 32)) & 0xffffffff;
 
 			if (a != b)
-				rd_val |= 1 << i;
+				rd_val |= 2 >> i;
 		}
 		break;
 
@@ -773,17 +773,17 @@ static void pcmp(struct pt_regs *regs, unsigned int insn, unsigned int opf)
 			s16 b = (rs2 >> (i * 16)) & 0xffff;
 
 			if (a = b)
-				rd_val |= 1 << i;
+				rd_val |= 8 >> i;
 		}
 		break;
 
 	case FCMPEQ32_OPF:
 		for (i = 0; i < 2; i++) {
-			s32 a = (rs1 >> (i * 32)) & 0xffff;
-			s32 b = (rs2 >> (i * 32)) & 0xffff;
+			s32 a = (rs1 >> (i * 32)) & 0xffffffff;
+			s32 b = (rs2 >> (i * 32)) & 0xffffffff;
 
 			if (a = b)
-				rd_val |= 1 << i;
+				rd_val |= 2 >> i;
 		}
 		break;
 	}
-- 
1.7.6.401.g6a319

