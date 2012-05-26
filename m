From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 14:43:26 +0000
Subject: [PATCH 1/4] sparc32: refactor cpu_idle()
Message-Id: <1338043409-6827-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With the removal of sun4c we can use the same cpu_idle()
implementation on UP and SMP.
This also fix it so we use the same version independent on LEON
enabled or not.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/process_32.c |   28 ++--------------------------
 1 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index fe6787c..7d6f60e 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -65,13 +65,13 @@ extern void fpsave(unsigned long *, unsigned long *, void *, unsigned long *);
 struct task_struct *last_task_used_math = NULL;
 struct thread_info *current_set[NR_CPUS];
 
-#ifndef CONFIG_SMP
-
 /*
  * the idle loop on a Sparc... ;)
  */
 void cpu_idle(void)
 {
+        set_thread_flag(TIF_POLLING_NRFLAG);
+
 	/* endless idle loop with no priority at all */
 	for (;;) {
 		if (pm_idle) {
@@ -85,30 +85,6 @@ void cpu_idle(void)
 	}
 }
 
-#else
-
-/* This is being executed in task 0 'user space'. */
-void cpu_idle(void)
-{
-        set_thread_flag(TIF_POLLING_NRFLAG);
-	/* endless idle loop with no priority at all */
-	while(1) {
-#ifdef CONFIG_SPARC_LEON
-		if (pm_idle) {
-			while (!need_resched())
-				(*pm_idle)();
-		} else
-#endif
-		{
-			while (!need_resched())
-				cpu_relax();
-		}
-		schedule_preempt_disabled();
-	}
-}
-
-#endif
-
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
 void machine_halt(void)
 {
-- 
1.6.0.6

