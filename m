From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Apr 2011 07:48:17 +0000
Subject: [PATCH] sparc32,leon: SMP power down implementation
Message-Id: <1303804097-488-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/process_32.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 1752929..c8cc461 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -128,8 +128,16 @@ void cpu_idle(void)
         set_thread_flag(TIF_POLLING_NRFLAG);
 	/* endless idle loop with no priority at all */
 	while(1) {
-		while (!need_resched())
-			cpu_relax();
+#ifdef CONFIG_SPARC_LEON
+		if (pm_idle) {
+			while (!need_resched())
+				(*pm_idle)();
+		} else
+#endif
+		{
+			while (!need_resched())
+				cpu_relax();
+		}
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
-- 
1.5.4

