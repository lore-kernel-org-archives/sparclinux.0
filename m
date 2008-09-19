From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:01 +0000
Subject: [PATCH 4/13]: sparc32: Remove #if 0'd code from sun4c_irq.c
Message-Id: <20080919.153901.78359830.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Remove #if 0'd code from sun4c_irq.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4c_irq.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 722d251..5602972 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -36,11 +36,6 @@
 #include <asm/idprom.h>
 #include <asm/machines.h>
 
-#if 0
-static struct resource sun4c_timer_eb = { "sun4c_timer" };
-static struct resource sun4c_intr_eb = { "sun4c_intr" };
-#endif
-
 /*
  * Bit field defines for the interrupt registers on various
  * Sparc machines.
@@ -173,10 +168,6 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
     
-#if 0
-	/* This does not work on 4/330 */
-	sun4c_enable_irq(10);
-#endif
 	claim_ticker14(NULL, PROFILE_IRQ, 0);
 }
 
-- 
1.5.6.5

