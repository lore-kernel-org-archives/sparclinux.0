From: Allen Pais <allen.pais@oracle.com>
Date: Sat, 27 Feb 2016 09:50:26 +0000
Subject: [PATCH 1/1] [RFC]sparc64: enable cpu hotplug feature
Message-Id: <1456565906-2072-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch provides users with an option to
disable/enable cpu at runtime by writing to
/sys/devices/system/cpu/cpuX/online field.

Eg:
$ echo [0/1] > /sys/devices/system/cpu/cpu2/online

Signed-off-by: Allen Pais <allen.pais@oracle.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/sparc/kernel/smp_64.c |   48 +++++++++++++++++++++++--------------------
 arch/sparc/kernel/sysfs.c  |    4 +++
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 19cd08d..5ea2f91 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1277,20 +1277,26 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret = smp_boot_one_cpu(cpu, tidle);
 
-	if (!ret) {
-		cpumask_set_cpu(cpu, &smp_commenced_mask);
-		while (!cpu_online(cpu))
-			mb();
-		if (!cpu_online(cpu)) {
-			ret = -ENODEV;
-		} else {
-			/* On SUN4V, writes to %tick and %stick are
-			 * not allowed.
-			 */
-			if (tlb_type != hypervisor)
-				smp_synchronize_one_tick(cpu);
-		}
+	if (ret)
+		goto out;
+
+	cpumask_set_cpu(cpu, &smp_commenced_mask);
+	while (!cpu_online(cpu))
+		mb();
+	if (!cpu_online(cpu)) {
+		ret = -ENODEV;
+		goto out;
 	}
+
+	/* On SUN4V, writes to %tick and %stick are
+	 * not allowed.
+	 */
+	if (tlb_type != hypervisor)
+		smp_synchronize_one_tick(cpu);
+
+	smp_fill_in_sib_core_maps();
+	cpu_map_rebuild();
+out:
 	return ret;
 }
 
@@ -1333,24 +1339,24 @@ void cpu_play_dead(void)
 int __cpu_disable(void)
 {
 	int cpu = smp_processor_id();
-	cpuinfo_sparc *c;
 	int i;
 
 	for_each_cpu(i, &cpu_core_map[cpu])
 		cpumask_clear_cpu(cpu, &cpu_core_map[i]);
 	cpumask_clear(&cpu_core_map[cpu]);
 
+	for_each_cpu(i, &cpu_core_sib_map[cpu])
+		cpumask_clear_cpu(cpu, &cpu_core_sib_map[i]);
+	cpumask_clear(&cpu_core_sib_map[cpu]);
+
 	for_each_cpu(i, &per_cpu(cpu_sibling_map, cpu))
 		cpumask_clear_cpu(cpu, &per_cpu(cpu_sibling_map, i));
 	cpumask_clear(&per_cpu(cpu_sibling_map, cpu));
 
-	c = &cpu_data(cpu);
-
-	c->core_id = 0;
-	c->proc_id = -1;
-
 	smp_wmb();
 
+	set_cpu_online(cpu, false);
+
 	/* Make sure no interrupts point to this cpu.  */
 	fixup_irqs();
 
@@ -1358,8 +1364,6 @@ int __cpu_disable(void)
 	mdelay(1);
 	local_irq_disable();
 
-	set_cpu_online(cpu, false);
-
 	cpu_map_rebuild();
 
 	return 0;
@@ -1385,7 +1389,7 @@ void __cpu_die(unsigned int cpu)
 		do {
 			hv_err = sun4v_cpu_stop(cpu);
 			if (hv_err = HV_EOK) {
-				set_cpu_present(cpu, false);
+				set_cpu_online(cpu, false);
 				break;
 			}
 		} while (--limit > 0);
diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index 7f41d40..43dc6ef 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -240,6 +240,8 @@ static void unregister_cpu_online(unsigned int cpu)
 	struct device *s = &c->dev;
 	int i;
 
+	BUG_ON(!c->hotpluggable);
+
 	unregister_mmu_stats(s);
 	for (i = 0; i < ARRAY_SIZE(cpu_core_attrs); i++)
 		device_remove_file(s, &cpu_core_attrs[i]);
@@ -305,7 +307,9 @@ static int __init topology_init(void)
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
+		c->hotpluggable = 1;
 		register_cpu(c, cpu);
+
 		if (cpu_online(cpu))
 			register_cpu_online(cpu);
 	}
-- 
1.7.1

