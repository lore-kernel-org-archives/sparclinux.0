From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:53 +0000
Subject: [PATCH 15/34] sparc64: fix sparse warning in process_64.c
Message-Id: <1400275572-17424-15-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-15-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-15-git-send-email-sam@ravnborg.org>
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

