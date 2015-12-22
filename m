From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 22 Dec 2015 04:48:03 +0000
Subject: [PATCH] sparc64: Don't set %pil in rtrap_nmi too early
Message-Id: <1450759683-1080-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Commit 28a1f53 delays setting %pil to avoid potential
hardirq stack overflow in the common rtrap_irq path.
Setting %pil also needs to be delayed in the rtrap_nmi
path for the same reason.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
---
 arch/sparc/kernel/rtrap_64.S |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 39f0c66..d08bdaf 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -73,7 +73,13 @@ rtrap_nmi:	ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		andn			%l1, %l4, %l1
 		srl			%l4, 20, %l4
 		ba,pt			%xcc, rtrap_no_irq_enable
-		 wrpr			%l4, %pil
+		nop
+		/* Do not actually set the %pil here.  We will do that
+		 * below after we clear PSTATE_IE in the %pstate register.
+		 * If we re-enable interrupts here, we can recurse down
+		 * the hardirq stack potentially endlessly, causing a
+		 * stack overflow.
+		 */
 
 		.align			64
 		.globl			rtrap_irq, rtrap, irqsz_patchme, rtrap_xcall
-- 
1.7.9.5

