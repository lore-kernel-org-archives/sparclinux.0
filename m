From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 05:37:48 +0000
Subject: [PATCH 8/12]: sparc64: Make mdesc_fill_in_cpu_data take a
Message-Id: <20090408.223748.69543906.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/mdesc.h |    2 +-
 arch/sparc/kernel/ds.c         |    2 +-
 arch/sparc/kernel/mdesc.c      |    6 +++---
 arch/sparc/mm/init_64.c        |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdesc.h
index 8f8a520..9faa046 100644
--- a/arch/sparc/include/asm/mdesc.h
+++ b/arch/sparc/include/asm/mdesc.h
@@ -71,7 +71,7 @@ struct mdesc_notifier_client {
 
 extern void mdesc_register_notifier(struct mdesc_notifier_client *client);
 
-extern void mdesc_fill_in_cpu_data(cpumask_t mask);
+extern void mdesc_fill_in_cpu_data(cpumask_t *mask);
 extern void mdesc_populate_present_mask(cpumask_t *mask);
 
 extern void sun4v_mdesc_init(void);
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 90350f8..51b05c4 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -544,7 +544,7 @@ static int __cpuinit dr_cpu_configure(struct ds_info *dp,
 			     resp_len, ncpus, mask,
 			     DR_CPU_STAT_CONFIGURED);
 
-	mdesc_fill_in_cpu_data(*mask);
+	mdesc_fill_in_cpu_data(mask);
 
 	for_each_cpu_mask(cpu, *mask) {
 		int err;
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 602cbb7..6d2015e 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -857,12 +857,12 @@ static void * __cpuinit fill_in_one_cpu(struct mdesc_handle *hp, u64 mp, int cpu
 	return NULL;
 }
 
-void __cpuinit mdesc_fill_in_cpu_data(cpumask_t mask)
+void __cpuinit mdesc_fill_in_cpu_data(cpumask_t *mask)
 {
 	struct mdesc_handle *hp;
 
-	mdesc_populate_present_mask(&mask);
-	mdesc_iterate_over_cpus(fill_in_one_cpu, NULL, &mask);
+	mdesc_populate_present_mask(mask);
+	mdesc_iterate_over_cpus(fill_in_one_cpu, NULL, mask);
 
 #ifdef CONFIG_SMP
 	sparc64_multi_core = 1;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c589d6e..87fea94 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1810,7 +1810,7 @@ void __init paging_init(void)
 
 	if (tlb_type = hypervisor) {
 		sun4v_mdesc_init();
-		mdesc_fill_in_cpu_data(CPU_MASK_ALL);
+		mdesc_fill_in_cpu_data(CPU_MASK_ALL_PTR);
 	}
 
 	/* Once the OF device tree and MDESC have been setup, we know
-- 
1.6.2.2

