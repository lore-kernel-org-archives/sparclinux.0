From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Date: Fri, 04 Jan 2013 02:58:57 +0000
Subject: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line of /proc/stat" (commit 7386cdbf2f57ea8c
Message-Id: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
cpu's idle time as last recorded in its ts->idle_sleeptime will be reported
(thus excluding its offline time as part of idle time statistics).

Cc: mhocko@suse.cz
Cc: srivatsa.bhat@linux.vnet.ibm.com
Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 fs/proc/stat.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index e296572..64c3b31 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -45,13 +45,10 @@ static cputime64_t get_iowait_time(int cpu)
 
 static u64 get_idle_time(int cpu)
 {
-	u64 idle, idle_time = -1ULL;
-
-	if (cpu_online(cpu))
-		idle_time = get_cpu_idle_time_us(cpu, NULL);
+	u64 idle, idle_time = get_cpu_idle_time_us(cpu, NULL);
 
 	if (idle_time = -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
+		/* !NO_HZ so we can rely on cpustat.idle */
 		idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
 	else
 		idle = usecs_to_cputime64(idle_time);
@@ -61,13 +58,10 @@ static u64 get_idle_time(int cpu)
 
 static u64 get_iowait_time(int cpu)
 {
-	u64 iowait, iowait_time = -1ULL;
-
-	if (cpu_online(cpu))
-		iowait_time = get_cpu_iowait_time_us(cpu, NULL);
+	u64 iowait, iowait_time = get_cpu_iowait_time_us(cpu, NULL);
 
 	if (iowait_time = -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
+		/* !NO_HZ so we can rely on cpustat.iowait */
 		iowait = kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
 	else
 		iowait = usecs_to_cputime64(iowait_time);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

