From: David Miller <davem@davemloft.net>
Date: Tue, 06 Mar 2007 05:37:58 +0000
Subject: [PATCH 3/4]: [SPARC64]: Add tick_nohz_{stop,restart}_sched_tick()
Message-Id: <20070305.213758.95894643.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


From 12dfac63a2e0977473115d8e10a96d1c0e91bf24 Mon Sep 17 00:00:00 2001
From: David S. Miller <davem@sunset.davemloft.net>
Date: Thu, 22 Feb 2007 06:24:45 -0800
Subject: [PATCH] [SPARC64]: Add tick_nohz_{stop,restart}_sched_tick() calls to cpu_idle().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/process.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 7d75cd4..cca0360 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/compat.h>
+#include <linux/tick.h>
 #include <linux/init.h>
 
 #include <asm/oplib.h>
@@ -88,12 +89,14 @@ void cpu_idle(void)
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	while(1) {
-		if (need_resched()) {
-			preempt_enable_no_resched();
-			schedule();
-			preempt_disable();
-		}
-		sparc64_yield();
+		tick_nohz_stop_sched_tick();
+		while (!need_resched())
+			sparc64_yield();
+		tick_nohz_restart_sched_tick();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
 	}
 }
 
-- 
1.5.0

