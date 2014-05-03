From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:19 +0000
Subject: [PATCH 14/34] sparc64: fix sparse warning in process_64.c
Message-Id: <1399157559-19901-14-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
process_64.c:91:25: warning: non-ANSI function declaration of function 'arch_cpu_idle_dead'

Add proper (void) to function definition

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d7b4967..b2988f2 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -88,7 +88,7 @@ void arch_cpu_idle(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-void arch_cpu_idle_dead()
+void arch_cpu_idle_dead(void)
 {
 	sched_preempt_enable_no_resched();
 	cpu_play_dead();
-- 
1.9.0

