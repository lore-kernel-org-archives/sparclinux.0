From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:12 +0000
Subject: [PATCH 8/13]: sparc32: Delete claim_ticker14().
Message-Id: <20080919.153912.178664509.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Delete claim_ticker14().

No more users.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/tick14.c |   46 --------------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/sparc/kernel/tick14.c b/arch/sparc/kernel/tick14.c
index 77a4f3a..138bbf5 100644
--- a/arch/sparc/kernel/tick14.c
+++ b/arch/sparc/kernel/tick14.c
@@ -1,30 +1,12 @@
 /* tick14.c
- * linux/arch/sparc/kernel/tick14.c
  *
  * Copyright (C) 1996 David Redman (djhr@tadpole.co.uk)
  *
  * This file handles the Sparc specific level14 ticker
  * This is really useful for profiling OBP uses it for keyboard
  * aborts and other stuff.
- *
- *
  */
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/timex.h>
-#include <linux/interrupt.h>
-
-#include <asm/oplib.h>
-#include <asm/timer.h>
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-
-#include "irq.h"
 
 extern unsigned long lvl14_save[5];
 static unsigned long *linux_lvl14 = NULL;
@@ -55,31 +37,3 @@ void install_obp_ticker(void)
 	linux_lvl14[2] =  obp_lvl14[2];
 	linux_lvl14[3] =  obp_lvl14[3]; 
 }
-
-void claim_ticker14(irq_handler_t handler,
-		    int irq_nr, unsigned int timeout )
-{
-	int cpu = smp_processor_id();
-
-	/* first we copy the obp handler instructions
-	 */
-	__disable_irq(irq_nr);
-	if (!handler)
-		return;
-    
-	linux_lvl14 = (unsigned long *)lvl14_save[4];
-	obp_lvl14[0] = linux_lvl14[0];
-	obp_lvl14[1] = linux_lvl14[1];
-	obp_lvl14[2] = linux_lvl14[2];
-	obp_lvl14[3] = linux_lvl14[3];
-
-	if (!request_irq(irq_nr,
-			 handler,
-			 (IRQF_DISABLED | SA_STATIC_ALLOC),
-			 "counter14",
-			 NULL)) {
-		install_linux_ticker();
-		load_profile_irq(cpu, timeout);
-		__enable_irq(irq_nr);
-	}
-}
-- 
1.5.6.5

