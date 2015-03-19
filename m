From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 20:06:53 +0000
Subject: [PATCH] sparc: Touch NMI watchdog when walking cpus and calling printk
Message-Id: <1426795613-135746-1-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With the increase in number of CPUs calls to functions that dump
output to console (e.g., arch_trigger_all_cpu_backtrace) can take
a long time to complete. If IRQs are disabled eventually the NMI
watchdog kicks in and creates more havoc. Avoid by telling the NMI
watchdog everything is ok.

Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/kernel/process_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 0be7bf978cb1..46a59643bb1c 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -287,6 +287,8 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 			printk("             TPC[%lx] O7[%lx] I7[%lx] RPC[%lx]\n",
 			       gp->tpc, gp->o7, gp->i7, gp->rpc);
 		}
+
+		touch_nmi_watchdog();
 	}
 
 	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
@@ -362,6 +364,8 @@ static void pmu_snapshot_all_cpus(void)
 		       (cpu = this_cpu ? '*' : ' '), cpu,
 		       pp->pcr[0], pp->pcr[1], pp->pcr[2], pp->pcr[3],
 		       pp->pic[0], pp->pic[1], pp->pic[2], pp->pic[3]);
+
+		touch_nmi_watchdog();
 	}
 
 	memset(global_cpu_snapshot, 0, sizeof(global_cpu_snapshot));
-- 
2.3.0

