From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 17 Nov 2016 18:35:38 +0000
Subject: [PATCH 17/20] sparc/sysfs: Convert to hotplug state machine
Message-Id: <20161117183541.8588-18-bigeasy@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

The previous convention of keeping the files around until the CPU is dead
has not been preserved as there is no point to keep them available when the
cpu is going down. This makes the hotplug call symmetric.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/sparc/kernel/sysfs.c | 45 +++++++++------------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index fa8e21abb5e0..4808b6d23455 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -221,7 +221,7 @@ static struct device_attribute cpu_core_attrs[] = {
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
-static void register_cpu_online(unsigned int cpu)
+static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct device *s = &c->dev;
@@ -231,11 +231,12 @@ static void register_cpu_online(unsigned int cpu)
 		device_create_file(s, &cpu_core_attrs[i]);
 
 	register_mmu_stats(s);
+	return 0;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-static void unregister_cpu_online(unsigned int cpu)
+static int unregister_cpu_online(unsigned int cpu)
 {
+#ifdef CONFIG_HOTPLUG_CPU
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct device *s = &c->dev;
 	int i;
@@ -243,33 +244,10 @@ static void unregister_cpu_online(unsigned int cpu)
 	unregister_mmu_stats(s);
 	for (i = 0; i < ARRAY_SIZE(cpu_core_attrs); i++)
 		device_remove_file(s, &cpu_core_attrs[i]);
-}
 #endif
-
-static int sysfs_cpu_notify(struct notifier_block *self,
-				      unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (unsigned int)(long)hcpu;
-
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
-		register_cpu_online(cpu);
-		break;
-#ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-		unregister_cpu_online(cpu);
-		break;
-#endif
-	}
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block sysfs_cpu_nb = {
-	.notifier_call	= sysfs_cpu_notify,
-};
-
 static void __init check_mmu_stats(void)
 {
 	unsigned long dummy1, err;
@@ -294,26 +272,21 @@ static void register_nodes(void)
 
 static int __init topology_init(void)
 {
-	int cpu;
+	int cpu, ret;
 
 	register_nodes();
 
 	check_mmu_stats();
 
-	cpu_notifier_register_begin();
-
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
 
 		register_cpu(c, cpu);
-		if (cpu_online(cpu))
-			register_cpu_online(cpu);
 	}
 
-	__register_cpu_notifier(&sysfs_cpu_nb);
-
-	cpu_notifier_register_done();
-
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "sparc/topology:online",
+				register_cpu_online, unregister_cpu_online);
+	WARN_ON(ret < 0);
 	return 0;
 }
 
-- 
2.10.2

