From: David Miller <davem@davemloft.net>
Date: Thu, 04 Aug 2011 09:03:06 +0000
Subject: [PATCH 4/7] sparc: Use hweight64() in popc emulation.
Message-Id: <20110804.020306.1844262867115474120.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/unaligned_64.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 35cff16..76e4ac1 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/perf_event.h>
 #include <linux/ratelimit.h>
+#include <linux/bitops.h>
 #include <asm/fpumacro.h>
 
 enum direction {
@@ -373,16 +374,11 @@ asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn)
 	}
 }
 
-static char popc_helper[] = {
-0, 1, 1, 2, 1, 2, 2, 3,
-1, 2, 2, 3, 2, 3, 3, 4, 
-};
-
 int handle_popc(u32 insn, struct pt_regs *regs)
 {
-	u64 value;
-	int ret, i, rd = ((insn >> 25) & 0x1f);
 	int from_kernel = (regs->tstate & TSTATE_PRIV) != 0;
+	int ret, rd = ((insn >> 25) & 0x1f);
+	u64 value;
 	                        
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
 	if (insn & 0x2000) {
@@ -392,10 +388,7 @@ int handle_popc(u32 insn, struct pt_regs *regs)
 		maybe_flush_windows(0, insn & 0x1f, rd, from_kernel);
 		value = fetch_reg(insn & 0x1f, regs);
 	}
-	for (ret = 0, i = 0; i < 16; i++) {
-		ret += popc_helper[value & 0xf];
-		value >>= 4;
-	}
+	ret = hweight64(value);
 	if (rd < 16) {
 		if (rd)
 			regs->u_regs[rd] = ret;
-- 
1.7.5.4

