From: Atish Patra <atish.patra@oracle.com>
Date: Thu, 28 Sep 2017 20:27:19 +0000
Subject: [PATCH] sparc64: Set possible and present masks based on nr_cpu_ids
Message-Id: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Currently, smp_fill_in_cpu_possible_map() unncessarily iterates
over all cpus to update possible/present cpumask based on nr_cpu_ids.
nr_cpus can be supported if nr_cpu_ids is checked instead of NR_CPUS
during MD parsing as well and saves some tiny boot time as well.

Update possible/present masks during MD parsing based on nr_cpu_ids.

Signed-off-by: Atish Patra <atish.patra@oracle.com>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/sparc/include/asm/smp_64.h |    2 --
 arch/sparc/kernel/mdesc.c       |   16 ++++++++--------
 arch/sparc/kernel/prom_64.c     |   16 ++++++++++++----
 arch/sparc/kernel/setup_64.c    |    1 -
 arch/sparc/kernel/smp_64.c      |   14 --------------
 5 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index ce2233f..26d9e77 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -43,7 +43,6 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
 void cpu_play_dead(void);
 
@@ -73,7 +72,6 @@ void __cpu_die(unsigned int cpu);
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
-#define smp_fill_in_cpu_possible_map() do { } while (0)
 
 #endif /* !(CONFIG_SMP) */
 
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 1122886..51f5e73 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -558,10 +558,10 @@ static void __init report_platform_properties(void)
 
 		if (v) {
 			max_cpu = *v;
-			if (max_cpu > NR_CPUS)
-				max_cpu = NR_CPUS;
+			if (max_cpu > nr_cpu_ids)
+				max_cpu = nr_cpu_ids;
 		} else {
-			max_cpu = NR_CPUS;
+			max_cpu = nr_cpu_ids;
 		}
 		for (i = 0; i < max_cpu; i++)
 			set_cpu_possible(i, true);
@@ -770,7 +770,7 @@ static void mark_proc_ids(struct mdesc_handle *hp, u64 mp, int proc_id)
 			continue;
 
 		id = mdesc_get_property(hp, t, "id", NULL);
-		if (*id < NR_CPUS)
+		if (*id < nr_cpu_ids)
 			cpu_data(*id).proc_id = proc_id;
 	}
 }
@@ -861,12 +861,12 @@ static void *mdesc_iterate_over_cpus(void *(*func)(struct mdesc_handle *, u64, i
 		int cpuid = *id;
 
 #ifdef CONFIG_SMP
-		if (cpuid >= NR_CPUS) {
-			printk(KERN_WARNING "Ignoring CPU %d which is "
-			       ">= NR_CPUS (%d)\n",
-			       cpuid, NR_CPUS);
+		if (cpuid >= nr_cpu_ids) {
+			pr_warn("Ignoring CPU %d which is >= nr_cpu_ids (%d)\n",
+				cpuid, nr_cpu_ids);
 			continue;
 		}
+
 		if (!cpumask_test_cpu(cpuid, mask))
 			continue;
 #endif
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 20cc5d8..34775f7 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -448,10 +448,9 @@ static void *of_iterate_over_cpus(void *(*func)(struct device_node *, int, int),
 			prom_halt();
 		}
 #ifdef CONFIG_SMP
-		if (cpuid >= NR_CPUS) {
-			printk(KERN_WARNING "Ignoring CPU %d which is "
-			       ">= NR_CPUS (%d)\n",
-			       cpuid, NR_CPUS);
+		if (cpuid >= nr_cpu_ids) {
+			pr_warn("Ignoring CPU %d which is >= nr_cpu_ids (%d)\n",
+				cpuid, nr_cpu_ids);
 			continue;
 		}
 #endif
@@ -491,6 +490,15 @@ void __init of_populate_present_mask(void)
 
 	ncpus_probed = 0;
 	of_iterate_over_cpus(record_one_cpu, 0);
+
+	/* This is a hack to accommodate the assumption in timer code that CPU0
+	 * always exists and therefore timers can be assigned to CPU0 at static
+	 * initialization time.  Setting CPU0 in the possible mask ensures that
+	 * the per-cpu timer data structures for CPU0 are properly initialized
+	 * for use by such timers even when there is no CPU0 present.
+	 */
+	if (!cpu_possible(0))
+		set_cpu_possible(0, true);
 }
 
 static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 6b7331d..9ce259a 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -669,7 +669,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 	init_sparc64_elf_hwcap();
-	smp_fill_in_cpu_possible_map();
 	/*
 	 * Once the OF device tree and MDESC have been setup and nr_cpus has
 	 * been parsed, we know the list of possible cpus.  Therefore we can
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index d3035ba..8a6151a 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1227,20 +1227,6 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
-void __init smp_fill_in_cpu_possible_map(void)
-{
-	int possible_cpus = num_possible_cpus();
-	int i;
-
-	if (possible_cpus > nr_cpu_ids)
-		possible_cpus = nr_cpu_ids;
-
-	for (i = 0; i < possible_cpus; i++)
-		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
-		set_cpu_possible(i, false);
-}
-
 void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;
-- 
1.7.1

