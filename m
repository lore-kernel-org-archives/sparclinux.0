From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2012 21:34:58 +0000
Subject: [PATCH] sparc64: Remove trap return code which is now unnecessary.
Message-Id: <20120413.173458.1551383523426489859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Noticed by Linus.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Committed to sparc-next

 arch/sparc/kernel/rtrap_64.S |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 9171fc2..afa2a9e 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -73,18 +73,8 @@ rtrap_nmi:	ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		.globl			rtrap_irq, rtrap, irqsz_patchme, rtrap_xcall
 rtrap_irq:
 rtrap:
-#ifndef CONFIG_SMP
-		sethi			%hi(__cpu_data), %l0
-		lduw			[%l0 + %lo(__cpu_data)], %l1
-#else
-		sethi			%hi(__cpu_data), %l0
-		or			%l0, %lo(__cpu_data), %l0
-		lduw			[%l0 + %g5], %l1
-#endif
-		cmp			%l1, 0
-
 		/* mm/ultra.S:xcall_report_regs KNOWS about this load. */
-		 ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
+		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 rtrap_xcall:
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
-- 
1.7.9.5

