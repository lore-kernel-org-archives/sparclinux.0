From: David Miller <davem@davemloft.net>
Date: Mon, 15 Oct 2018 03:26:31 +0000
Subject: [PATCH] sparc64: Set %l4 properly on trap return after handling signals.
Message-Id: <20181014.202631.1332592487175071585.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If we did some signal processing, we have to reload the pt_regs
tstate register because it's value may have changed.

In doing so we also have to extract the %pil value contained in there
anre load that into %l4.

This value is at bit 20 and thus needs to be shifted down before we
later write it into the %pil register.

Most of the time this is harmless as we are returning to userspace
and the %pil is zero for that case.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/rtrap_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index f6528884a2c8..4073e2b87dd0 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -84,8 +84,9 @@ __handle_signal:
 		ldx			[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 		sethi			%hi(0xf << 20), %l4
 		and			%l1, %l4, %l4
+		andn			%l1, %l4, %l1
 		ba,pt			%xcc, __handle_preemption_continue
-		 andn			%l1, %l4, %l1
+		 srl			%l4, 20, %l4
 
 		/* When returning from a NMI (%pil=15) interrupt we want to
 		 * avoid running softirqs, doing IRQ tracing, preempting, etc.
-- 
2.19.1
