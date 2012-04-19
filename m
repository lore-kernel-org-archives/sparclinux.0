From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 19 Apr 2012 09:22:42 +0000
Subject: [PATCH 1/1] sparc: task_cpu() for stopper thread on sparc32 returns 0
Message-Id: <1334827362-3434-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The stopper thread for CPU > 0 (at least in sparc32)
has on initialization task_cpu() set to zero even
for CPUs > 0. The patch explicitly checks weather the
CPU is allowed to run on the cpu that task_cpu()
return or changes the return cpu.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 kernel/sched/stop_task.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 7b386e8..9201866 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -13,7 +13,14 @@
 static int
 select_task_rq_stop(struct task_struct *p, int sd_flag, int flags)
 {
-	return task_cpu(p); /* stop tasks as never migrate */
+	int ccpu, cpu , dcpu;
+	ccpu = cpu = task_cpu(p);
+	if (unlikely(!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)))) {
+		cpu = cpumask_first(tsk_cpus_allowed(p));
+		if (cpu >= nr_cpu_ids)
+			cpu = ccpu;
+	}
+	return cpu;
 }
 #endif /* CONFIG_SMP */
 
-- 
1.6.1.3

