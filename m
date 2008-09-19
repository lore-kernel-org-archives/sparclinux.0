From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:10 +0000
Subject: [PATCH 7/13]: sparc32: Stop calling claim_ticker14() from
Message-Id: <20080919.153910.235190073.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Stop calling claim_ticker14() from sun4c_irq.c

Since the first argument is always NULL, the only side effect
is to disable the PROFILE_IRQ, so just do that directly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4c_irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 6f28a13..ae3149e 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -163,7 +163,7 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 		prom_halt();
 	}
     
-	claim_ticker14(NULL, PROFILE_IRQ, 0);
+	sun4c_disable_irq(PROFILE_IRQ);
 }
 
 #ifdef CONFIG_SMP
-- 
1.5.6.5

