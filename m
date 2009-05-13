From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Wed, 13 May 2009 16:52:31 +0000
Subject: [PATCH v2] sparc64: fix and optimize irq distribution
Message-Id: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

irq_choose_cpu() should compare the affinity mask against cpu_online_map
rather than CPU_MASK_ALL, since irq_select_affinity() sets the interrupt's
affinity mask to cpu_online_map "and" CPU_MASK_ALL (which ends up being
just cpu_online_map).  The mask comparison in irq_choose_cpu() will always
fail since the two masks are not the same.  So the CPU chosen is the first CPU
in the intersection of cpu_online_map and CPU_MASK_ALL, which is always CPU0.
That means all interrupts are reassigned to CPU0...

Distributing interrupts to CPUs in a linearly increasing round robin fashion
is not optimal for the UltraSPARC T1/T2.  Also, the irq_rover in
irq_choose_cpu() causes an interrupt to be assigned to a different
processor each time the interrupt is allocated and released.  This may lead
to an unbalanced distribution over time.

A static mapping of interrupts to processors is done to optimize and balance
interrupt distribution.  For the T1/T2, interrupts are spread to different
cores first, and then to strands within a core.

The following are benchmarks showing the effects of interrupt distribution
on a T2.  The test was done with iperf using a pair of T5220 boxes, each
with a 10GBe NIU (XAUI) connected back to back.

  TCP     | Stock       Linear RR IRQ  Optimized IRQ
  Streams | 2.6.30-rc5  Distribution   Distribution
          | GBits/sec   GBits/sec      GBits/sec
  --------+-----------------------------------------
    1       0.839       0.862          0.868
    8       1.16        4.96           5.88
   16       1.15        6.40           8.04
  100       1.09        7.28           8.68

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
---
 arch/sparc/kernel/Makefile |    1 +
 arch/sparc/kernel/cpumap.c |  110 ++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/cpumap.h |   15 ++++++
 arch/sparc/kernel/irq_64.c |   29 ++----------
 arch/sparc/kernel/smp_64.c |    2 +
 5 files changed, 132 insertions(+), 25 deletions(-)
 create mode 100644 arch/sparc/kernel/cpumap.c
 create mode 100644 arch/sparc/kernel/cpumap.h

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 54742e5..47029c6 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -53,8 +53,9 @@ obj-$(CONFIG_SPARC64)   += hvapi.o
 obj-$(CONFIG_SPARC64)   += sstate.o
 obj-$(CONFIG_SPARC64)   += mdesc.o
 obj-$(CONFIG_SPARC64)	+= pcr.o
 obj-$(CONFIG_SPARC64)	+= nmi.o
+obj-$(CONFIG_SPARC64_SMP) += cpumap.o
 
 # sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implementation
 obj-$(CONFIG_SPARC32)     += devres.o
 devres-y                  := ../../../kernel/irq/devres.o
diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
new file mode 100644
index 0000000..0b1dce7
--- /dev/null
+++ b/arch/sparc/kernel/cpumap.c
@@ -0,0 +1,110 @@
+/* cpumap.c: used for optimizing CPU assignment
+ *
+ * Copyright (C) 2009 Hong H. Pham <hong.pham@windriver.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cpumask.h>
+#include <linux/spinlock.h>
+#include "cpumap.h"
+
+
+static u16 cpu_distribution_map[NR_CPUS];
+static int cpu_map_entries = 0;
+static DEFINE_SPINLOCK(cpu_map_lock);
+
+
+static int strands_per_core(void)
+{
+	int n;
+
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_NIAGARA1:
+		n = 4;
+		break;
+
+	case SUN4V_CHIP_NIAGARA2:
+		n = 8;
+		break;
+
+	default:
+		n = 1;
+		break;
+	}
+	return n;
+}
+
+static int iterate_cpu(unsigned int index)
+{
+	static unsigned int num_cpus  = 0;
+	static unsigned int num_cores = 0;
+	unsigned int strand, s_per_core;
+
+	s_per_core = strands_per_core();
+
+	/* num_cpus must be a multiple of strands_per_core. */
+	if (unlikely(num_cores = 0)) {
+		num_cpus  = num_possible_cpus();
+		num_cores = ((num_cpus / s_per_core) +
+		             (num_cpus % s_per_core ? 1 : 0));
+		num_cpus  = num_cores * s_per_core;
+	}
+
+	strand = (index * s_per_core) / num_cpus;
+
+	/* Optimize for the T2.  Each core in the T2 has two instruction
+	 * pipelines.  Stagger the CPU distribution across different cores
+	 * first, and then across different pipelines.
+	 */
+	if (sun4v_chip_type = SUN4V_CHIP_NIAGARA2) {
+		if ((index / num_cores) & 0x01)
+			strand = s_per_core - strand;
+	}
+
+	return ((index * s_per_core) % num_cpus) + strand;
+}
+
+void cpu_map_init(void)
+{
+	int i, cpu, cpu_rover = 0;
+	unsigned long flag;
+
+	spin_lock_irqsave(&cpu_map_lock, flag);
+	for (i = 0; i < num_online_cpus(); i++) {
+		do {
+			cpu = iterate_cpu(cpu_rover++);
+		} while (!cpu_online(cpu));
+
+		cpu_distribution_map[i] = cpu;
+	}
+	cpu_map_entries = i;
+	spin_unlock_irqrestore(&cpu_map_lock, flag);
+}
+
+int map_to_cpu(unsigned int index)
+{
+	unsigned int mapped_cpu;
+	unsigned long flag;
+
+	spin_lock_irqsave(&cpu_map_lock, flag);
+	if (unlikely(cpu_map_entries != num_online_cpus())) {
+		spin_unlock_irqrestore(&cpu_map_lock, flag);
+		cpu_map_init();
+		spin_lock_irqsave(&cpu_map_lock, flag);
+	}
+
+	mapped_cpu = cpu_distribution_map[index % cpu_map_entries];
+#ifdef CONFIG_HOTPLUG_CPU
+	while (!cpu_online(mapped_cpu)) {
+		spin_unlock_irqrestore(&cpu_map_lock, flag);
+		cpu_map_init();
+		spin_lock_irqsave(&cpu_map_lock, flag);
+		mapped_cpu = cpu_distribution_map[index % cpu_map_entries];
+	}
+#endif /* CONFIG_HOTPLUG_CPU */
+	spin_unlock_irqrestore(&cpu_map_lock, flag);
+	return mapped_cpu;
+}
+EXPORT_SYMBOL(map_to_cpu);
diff --git a/arch/sparc/kernel/cpumap.h b/arch/sparc/kernel/cpumap.h
new file mode 100644
index 0000000..524b207
--- /dev/null
+++ b/arch/sparc/kernel/cpumap.h
@@ -0,0 +1,15 @@
+#ifndef _CPUMAP_H
+#define _CPUMAP_H
+
+#ifdef CONFIG_SMP
+extern void cpu_map_init(void);
+extern int  map_to_cpu(unsigned int index);
+#else
+#define cpu_map_init() do {} while (0)
+static inline int map_to_cpu(unsigned int index)
+{
+	return raw_smp_processor_id();
+}
+#endif
+
+#endif
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 5deabe9..b68386d 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -44,8 +44,9 @@
 #include <asm/hypervisor.h>
 #include <asm/cacheflush.h>
 
 #include "entry.h"
+#include "cpumap.h"
 
 #define NUM_IVECS	(IMAP_INR + 1)
 
 struct ino_bucket *ivector_table;
@@ -255,37 +256,15 @@ static int irq_choose_cpu(unsigned int virt_irq)
 	cpumask_t mask;
 	int cpuid;
 
 	cpumask_copy(&mask, irq_desc[virt_irq].affinity);
-	if (cpus_equal(mask, CPU_MASK_ALL)) {
-		static int irq_rover;
-		static DEFINE_SPINLOCK(irq_rover_lock);
-		unsigned long flags;
-
-		/* Round-robin distribution... */
-	do_round_robin:
-		spin_lock_irqsave(&irq_rover_lock, flags);
-
-		while (!cpu_online(irq_rover)) {
-			if (++irq_rover >= nr_cpu_ids)
-				irq_rover = 0;
-		}
-		cpuid = irq_rover;
-		do {
-			if (++irq_rover >= nr_cpu_ids)
-				irq_rover = 0;
-		} while (!cpu_online(irq_rover));
-
-		spin_unlock_irqrestore(&irq_rover_lock, flags);
+	if (cpus_equal(mask, cpu_online_map)) {
+		cpuid = map_to_cpu(virt_irq);
 	} else {
 		cpumask_t tmp;
 
 		cpus_and(tmp, cpu_online_map, mask);
-
-		if (cpus_empty(tmp))
-			goto do_round_robin;
-
-		cpuid = first_cpu(tmp);
+		cpuid = cpus_empty(tmp) ? map_to_cpu(virt_irq) : first_cpu(tmp);
 	}
 
 	return cpuid;
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f7642e5..54906aa 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1314,8 +1314,10 @@ int __cpu_disable(void)
 	ipi_call_lock();
 	cpu_clear(cpu, cpu_online_map);
 	ipi_call_unlock();
 
+	cpu_map_init();
+
 	return 0;
 }
 
 void __cpu_die(unsigned int cpu)
-- 
1.6.0.3

