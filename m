From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 01 Dec 2009 14:52:54 +0000
Subject: [PATCH 2/4] Enabling interrupts at this point causes warning in start_kernel()
Message-Id: <1259679176-29835-2-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enabling interrupts at this points causes the warning
"start_kernel(): bug: interrupts were enabled early" 
to be printed in start_kernel().

Interrupts are enabled shortly after time_init() in start_kernel().

Tested on LEON only.

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/time_32.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 614ac7b..5b2f595 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -210,9 +210,6 @@ static void __init sbus_time_init(void)
 	btfixup();
 
 	sparc_init_timers(timer_interrupt);
-	
-	/* Now that OBP ticker has been silenced, it is safe to enable IRQ. */
-	local_irq_enable();
 }
 
 void __init time_init(void)
-- 
1.5.4

