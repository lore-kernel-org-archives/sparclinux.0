From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Apr 2011 08:29:34 +0000
Subject: [PATCH] sparc32: fix sparcstation 5 boot
Message-Id: <20110421082934.GA22659@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From b0777dd526dbc375fa6e35fc07016af82cf71636 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Apr 2011 10:25:41 +0200
Subject: [PATCH] sparc32: fix sparcstation 5 boot

The sparcstation 5 I have available has no MID property for the CPU.
This resulted in a panic when booting a SMP kernel on this box.

The assigned field in cpu_data is never used, so if we fail
to read the MID property then inform user and continue booting.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/smp_32.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 91c10fb..850a136 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -53,6 +53,7 @@ cpumask_t smp_commenced_mask = CPU_MASK_NONE;
 void __cpuinit smp_store_cpu_info(int id)
 {
 	int cpu_node;
+	int mid;
 
 	cpu_data(id).udelay_val = loops_per_jiffy;
 
@@ -60,10 +61,13 @@ void __cpuinit smp_store_cpu_info(int id)
 	cpu_data(id).clock_tick = prom_getintdefault(cpu_node,
 						     "clock-frequency", 0);
 	cpu_data(id).prom_node = cpu_node;
-	cpu_data(id).mid = cpu_get_hwmid(cpu_node);
+	mid = cpu_get_hwmid(cpu_node);
 
-	if (cpu_data(id).mid < 0)
-		panic("No MID found for CPU%d at node 0x%08d", id, cpu_node);
+	if (mid < 0) {
+		printk(KERN_NOTICE "No MID found for CPU%d at node 0x%08d", id, cpu_node);
+		mid = 0;
+	}
+	cpu_data(id).mid = mid;
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
-- 
1.6.0.6

