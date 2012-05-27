From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 May 2012 21:39:02 +0000
Subject: [PATCH v2 1/4] sparc32: refactor cpu_idle()
Message-Id: <20120527213902.GA27706@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From ceaf359496c21a901127c2d61fcdeecf4bd0155a Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 May 2012 23:35:16 +0200
Subject: [PATCH] sparc32: refactor cpu_idle()

With the removal of sun4c we can use the same cpu_idle()
implementation on UP and SMP.
This also fix it so we use the same version independent on LEON
enabled or not.

V2: Fixed whitespace issue pointed out by Josip Rodin.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Josip Rodin <joy@entuzijast.net>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---

I took the opportunity to fix-up the body of cpu_idle
so we only call "while (!need_resched())" once.
The diff got uglier but the end result is better.

	Sam

 arch/sparc/kernel/process_32.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index fe6787c..cb36e82 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -65,50 +65,25 @@ extern void fpsave(unsigned long *, unsigned long *, void *, unsigned long *);
 struct task_struct *last_task_used_math = NULL;
 struct thread_info *current_set[NR_CPUS];
 
-#ifndef CONFIG_SMP
-
 /*
  * the idle loop on a Sparc... ;)
  */
 void cpu_idle(void)
 {
-	/* endless idle loop with no priority at all */
-	for (;;) {
-		if (pm_idle) {
-			while (!need_resched())
-				(*pm_idle)();
-		} else {
-			while (!need_resched())
-				cpu_relax();
-		}
-		schedule_preempt_disabled();
-	}
-}
-
-#else
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
-/* This is being executed in task 0 'user space'. */
-void cpu_idle(void)
-{
-        set_thread_flag(TIF_POLLING_NRFLAG);
 	/* endless idle loop with no priority at all */
-	while(1) {
-#ifdef CONFIG_SPARC_LEON
-		if (pm_idle) {
-			while (!need_resched())
+	for (;;) {
+		while (!need_resched()) {
+			if (pm_idle)
 				(*pm_idle)();
-		} else
-#endif
-		{
-			while (!need_resched())
+			else
 				cpu_relax();
 		}
 		schedule_preempt_disabled();
 	}
 }
 
-#endif
-
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
 void machine_halt(void)
 {
-- 
1.6.0.6

