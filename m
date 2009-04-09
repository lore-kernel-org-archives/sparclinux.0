From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 05:37:21 +0000
Subject: [PATCH 1/12]: sparc64: Reclaim trap_block[]->hdesc
Message-Id: <20090408.223721.164905834.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This really isn't necessary at all, a local variable suits the
job just fine.

This frees up 8 bytes in the trap_block[] that we can use later
to store the per-cpu base addresses.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cpudata_64.h |    2 +-
 arch/sparc/kernel/smp_64.c          |   14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index a11b89e..c58d87b 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -80,7 +80,7 @@ struct trap_per_cpu {
 	unsigned int		dev_mondo_qmask;
 	unsigned int		resum_qmask;
 	unsigned int		nonresum_qmask;
-	void			*hdesc;
+	unsigned long		__unused;
 } __attribute__((aligned(64)));
 extern struct trap_per_cpu trap_block[NR_CPUS];
 extern void init_cur_cpu_trap(struct thread_info *);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 708e12a..662fea2 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -278,7 +278,7 @@ static unsigned long kimage_addr_to_ra(void *p)
 	return kern_base + (val - KERNBASE);
 }
 
-static void __cpuinit ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg)
+static void __cpuinit ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg, void **descrp)
 {
 	extern unsigned long sparc64_ttable_tl0;
 	extern unsigned long kern_locked_tte_data;
@@ -298,12 +298,12 @@ static void __cpuinit ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread
 		       "hvtramp_descr.\n");
 		return;
 	}
+	*descrp = hdesc;
 
 	hdesc->cpu = cpu;
 	hdesc->num_mappings = num_kernel_image_mappings;
 
 	tb = &trap_block[cpu];
-	tb->hdesc = hdesc;
 
 	hdesc->fault_info_va = (unsigned long) &tb->fault_info;
 	hdesc->fault_info_pa = kimage_addr_to_ra(&tb->fault_info);
@@ -341,12 +341,12 @@ static struct thread_info *cpu_new_thread = NULL;
 
 static int __cpuinit smp_boot_one_cpu(unsigned int cpu)
 {
-	struct trap_per_cpu *tb = &trap_block[cpu];
 	unsigned long entry  		(unsigned long)(&sparc64_cpu_startup);
 	unsigned long cookie  		(unsigned long)(&cpu_new_thread);
 	struct task_struct *p;
+	void *descr = NULL;
 	int timeout, ret;
 
 	p = fork_idle(cpu);
@@ -359,7 +359,8 @@ static int __cpuinit smp_boot_one_cpu(unsigned int cpu)
 #if defined(CONFIG_SUN_LDOMS) && defined(CONFIG_HOTPLUG_CPU)
 		if (ldom_domaining_enabled)
 			ldom_startcpu_cpuid(cpu,
-					    (unsigned long) cpu_new_thread);
+					    (unsigned long) cpu_new_thread,
+					    &descr);
 		else
 #endif
 			prom_startcpu_cpuid(cpu, entry, cookie);
@@ -383,10 +384,7 @@ static int __cpuinit smp_boot_one_cpu(unsigned int cpu)
 	}
 	cpu_new_thread = NULL;
 
-	if (tb->hdesc) {
-		kfree(tb->hdesc);
-		tb->hdesc = NULL;
-	}
+	kfree(descr);
 
 	return ret;
 }
-- 
1.6.2.2

