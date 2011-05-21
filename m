From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 21 May 2011 21:27:58 +0000
Subject: [PATCH 2/2] sparc32: fix build, move inline function to .c file
Message-Id: <20110521212758.GB18545@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 875da4871c4654390d41aa110480211ccbd2aac2 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 21 May 2011 22:59:19 +0200
Subject: [PATCH 2/2] sparc32: fix build, move inline function to .c file

Fix following build eroor:

  CC      arch/sparc/kernel/irq_32.o
In file included from arch/sparc/include/asm/smp.h:6:0,
                 from arch/sparc/include/asm/system_32.h:12,
                 from arch/sparc/include/asm/system.h:6,
                 from arch/sparc/include/asm/ptrace.h:235,
                 from arch/sparc/include/asm/thread_info_32.h:19,
                 from sparc/include/asm/thread_info.h:6,
                 from include/linux/thread_info.h:53,
                 from include/linux/preempt.h:9,
                 from include/linux/smp.h:34,
                 from include/linux/kernel_stat.h:4,
                 from arch/sparc/kernel/irq_32.c:14:
arch/sparc/include/asm/smp_32.h:82:19: error: static declaration of 'smp_call_function_single' follows non-static declaration
include/linux/smp.h:29:5: note: previous declaration of 'smp_call_function_single' was here

Bug is likely triggered by changes in include files.
The fix was obviously correct so I found no value in tracking
down the offending commit.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/smp_32.h |    8 --------
 arch/sparc/kernel/smp_32.c      |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index d82d7f4..4b905ab 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -79,14 +79,6 @@ static inline int smp_call_function(void (*func)(void *info), void *info, int wa
 	return 0;
 }
 
-static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
-					   void *info, int wait)
-{
-	smp_cross_call((smpfunc_t)func, cpumask_of_cpu(cpuid),
-		       (unsigned long) info, 0, 0, 0);
-	return 0;
-}
-
 static inline int cpu_logical_map(int cpu)
 {
 	return cpu;
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 442286d..d677327 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -235,6 +235,14 @@ void smp_reschedule_irq(void)
 	set_need_resched();
 }
 
+inline int smp_call_function_single(int cpuid, void (*func) (void *info),
+                                           void *info, int wait)
+{
+	smp_cross_call((smpfunc_t)func, cpumask_of_cpu(cpuid),
+	               (unsigned long) info, 0, 0, 0);
+	return 0;
+}
+
 void smp_flush_page_to_ram(unsigned long page)
 {
 	/* Current theory is that those who call this are the one's
-- 
1.6.0.6

