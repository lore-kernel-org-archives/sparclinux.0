From: Atish Patra <atish.patra@oracle.com>
Date: Thu, 15 Sep 2016 20:54:40 +0000
Subject: [PATCH 1/2] sparc64: Fix cpu_possible_mask if nr_cpus is set
Message-Id: <1473972881-10671-2-git-send-email-atish.patra@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If kernel boot parameter nr_cpus is set, it should define the number
of CPUs that can ever be available in the system i.e.
cpu_possible_mask. setup_nr_cpu_ids() overrides the nr_cpu_ids based
on the cpu_possible_mask during kernel initialization. If
cpu_possible_mask is not set based on the nr_cpus value, earlier part
of the kernel would be initialized using nr_cpus value leading to a
kernel crash.

Set cpu_possible_mask based on nr_cpus value. Thus setup_nr_cpu_ids()
becomes redundant and does not corrupt nr_cpu_ids value.

Signed-off-by: Atish Patra <atish.patra@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/include/asm/smp_64.h |    1 +
 arch/sparc/kernel/setup_64.c    |    1 +
 arch/sparc/kernel/smp_64.c      |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 26d9e77..87b0575 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -43,6 +43,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
+void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
 void cpu_play_dead(void);
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 599f120..f32cfe8 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -650,6 +650,7 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 	init_sparc64_elf_hwcap();
+	smp_fill_in_cpu_possible_map();
 }
 
 extern int stop_a_enabled;
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 8a6151a..d3035ba 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1227,6 +1227,20 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
+void __init smp_fill_in_cpu_possible_map(void)
+{
+	int possible_cpus = num_possible_cpus();
+	int i;
+
+	if (possible_cpus > nr_cpu_ids)
+		possible_cpus = nr_cpu_ids;
+
+	for (i = 0; i < possible_cpus; i++)
+		set_cpu_possible(i, true);
+	for (; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
+}
+
 void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;
-- 
1.7.1

