From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 20 May 2011 14:01:10 +0000
Subject: [PATCH 2/2] SCHED_TTWU_QUEUE is not longer needed since sparc32 now implements IPI
Message-Id: <1305900070-23492-2-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1305900070-23492-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1305900070-23492-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, peterz@infradead.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
---
 init/Kconfig   |    5 -----
 kernel/sched.c |    2 +-
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index df64627..a66b656 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -827,11 +827,6 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
-config SCHED_TTWU_QUEUE
-	bool
-	depends on !SPARC32
-	default y
-
 config MM_OWNER
 	bool
 
diff --git a/kernel/sched.c b/kernel/sched.c
index c62acf4..0516af4 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2564,7 +2564,7 @@ static void ttwu_queue(struct task_struct *p, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_SCHED_TTWU_QUEUE)
+#if defined(CONFIG_SMP)
 	if (sched_feat(TTWU_QUEUE) && cpu != smp_processor_id()) {
 		ttwu_queue_remote(p, cpu);
 		return;
-- 
1.6.0.3

