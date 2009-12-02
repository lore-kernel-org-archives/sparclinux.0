From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 02 Dec 2009 14:30:21 +0000
Subject: [PATCH 2/3] sparc32: Remove early interrupt enable.
Message-Id: <1259764222-1802-3-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Enabling interrupts at this points causes the warning
"start_kernel(): bug: interrupts were enabled early"
to be printed in start_kernel().

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
1.6.4.1

