From: "Joseph S. Myers" <joseph@codesourcery.com>
Date: Thu, 04 Dec 2008 00:41:50 +0000
Subject: [PATCH] Fix VIS emulation bugs
Message-Id: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch fixes some bugs in VIS emulation that cause the GCC test
failure

FAIL: gcc.target/sparc/pdist-3.c execution test

for both 32-bit and 64-bit testing on hardware lacking these
instructions.  The emulation code for the pdist instruction uses
RS1(insn) for both source registers rs1 and rs2, which is obviously
wrong and leads to the instruction doing nothing (the observed
problem), and further inspection of the code shows that RS1 uses a
shift of 24 and RD a shift of 25, which clearly cannot both be right;
examining SPARC documentation indicates the correct shift for RS1 is
14.

This patch fixes the bug if single-stepping over the affected
instruction in the debugger, but not if the testcase is run
standalone.  For that, Wind River has another patch I hope they will
send as a followup to this patch submission.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
diff --git a/arch/sparc64/kernel/visemul.c b/arch/sparc64/kernel/visemul.c
index 9e05cb5..69f8a35 100644
--- a/arch/sparc64/kernel/visemul.c
+++ b/arch/sparc64/kernel/visemul.c
@@ -131,7 +131,7 @@
 #define VIS_OPF_SHIFT	5
 #define VIS_OPF_MASK	(0x1ff << VIS_OPF_SHIFT)
 
-#define RS1(INSN)	(((INSN) >> 24) & 0x1f)
+#define RS1(INSN)	(((INSN) >> 14) & 0x1f)
 #define RS2(INSN)	(((INSN) >>  0) & 0x1f)
 #define RD(INSN)	(((INSN) >> 25) & 0x1f)
 
@@ -445,7 +445,7 @@ static void pdist(struct pt_regs *regs, unsigned int insn)
 	unsigned long i;
 
 	rs1 = fpd_regval(f, RS1(insn));
-	rs2 = fpd_regval(f, RS1(insn));
+	rs2 = fpd_regval(f, RS2(insn));
 	rd = fpd_regaddr(f, RD(insn));
 
 	rd_val = *rd;

-- 
Joseph S. Myers
joseph@codesourcery.com
