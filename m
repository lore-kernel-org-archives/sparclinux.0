From: Atish Patra <atish.patra@oracle.com>
Date: Thu, 20 Oct 2016 00:33:29 +0000
Subject: [PATCH] sparc64: Setup a scheduling domain for highest level cache.
Message-Id: <1476923609-11125-1-git-send-email-atish.patra@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Individual scheduler domain should consist different hierarchy
consisting of cores sharing similar property. Currently, no
scheduler domain is defined separately for the cores that shares
the last level cache. As a result, the scheduler fails to take
advantage of cache locality while migrating tasks during load
balancing.

Here are the cpu masks currently present for sparc that are/can
be used in scheduler domain construction.
cpu_core_map : set based on the cores that shares l1 cache.
core_core_sib_map : is set based on the socket id.
The prior SPARC notion of socket was defined as highest level of
shared cache. However, the MD record on T7 platforms now describes
the CPUs that share the physical socket and this is no longer tied
to shared cache.

That's why a separate cpu mask needs to be created that truly
represent highest level of shared cache for all platforms.

Signed-off-by: Atish Patra <atish.patra@oracle.com>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
---
 arch/sparc/include/asm/cpudata_64.h  |    5 ++-
 arch/sparc/include/asm/topology_64.h |    8 +++++-
 arch/sparc/kernel/mdesc.c            |   46 ++++++++++++++++++++-------------
 arch/sparc/kernel/smp_64.c           |    8 ++++++
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index a6cfdab..5b0ed48 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -24,9 +24,10 @@ typedef struct {
 	unsigned int	icache_line_size;
 	unsigned int	ecache_size;
 	unsigned int	ecache_line_size;
-	unsigned short	sock_id;
+	unsigned short	sock_id;	/* physical package */
 	unsigned short	core_id;
-	int		proc_id;
+	unsigned short  max_cache_id;	/* groupings of highest shared cache */
+	unsigned short	proc_id;	/* strand (aka HW thread) id */
 } cpuinfo_sparc;
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index bec481a..7b4898a 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -44,14 +44,20 @@ int __node_distance(int, int);
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).proc_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).core_id)
 #define topology_core_cpumask(cpu)		(&cpu_core_sib_map[cpu])
+#define topology_core_cache_cpumask(cpu)	(&cpu_core_sib_cache_map[cpu])
 #define topology_sibling_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
 #endif /* CONFIG_SMP */
 
 extern cpumask_t cpu_core_map[NR_CPUS];
 extern cpumask_t cpu_core_sib_map[NR_CPUS];
+extern cpumask_t cpu_core_sib_cache_map[NR_CPUS];
+
+/**
+ * Return cores that shares the last level cache.
+ */
 static inline const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-        return &cpu_core_map[cpu];
+	return &cpu_core_sib_cache_map[cpu];
 }
 
 #endif /* _ASM_SPARC64_TOPOLOGY_H */
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 1122886..8a6982d 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -645,13 +645,20 @@ static void __mark_core_id(struct mdesc_handle *hp, u64 node,
 		cpu_data(*id).core_id = core_id;
 }
 
-static void __mark_sock_id(struct mdesc_handle *hp, u64 node,
-			   int sock_id)
+static void __mark_max_cache_id(struct mdesc_handle *hp, u64 node,
+				int max_cache_id)
 {
 	const u64 *id = mdesc_get_property(hp, node, "id", NULL);
 
-	if (*id < num_possible_cpus())
-		cpu_data(*id).sock_id = sock_id;
+	if (*id < num_possible_cpus()) {
+		cpu_data(*id).max_cache_id = max_cache_id;
+
+		/**
+		 * On systems without explicit socket descriptions socket
+		 * is max_cache_id
+		 */
+		cpu_data(*id).sock_id = max_cache_id;
+	}
 }
 
 static void mark_core_ids(struct mdesc_handle *hp, u64 mp,
@@ -660,10 +667,11 @@ static void mark_core_ids(struct mdesc_handle *hp, u64 mp,
 	find_back_node_value(hp, mp, "cpu", __mark_core_id, core_id, 10);
 }
 
-static void mark_sock_ids(struct mdesc_handle *hp, u64 mp,
-			  int sock_id)
+static void mark_max_cache_ids(struct mdesc_handle *hp, u64 mp,
+			       int max_cache_id)
 {
-	find_back_node_value(hp, mp, "cpu", __mark_sock_id, sock_id, 10);
+	find_back_node_value(hp, mp, "cpu", __mark_max_cache_id,
+			     max_cache_id, 10);
 }
 
 static void set_core_ids(struct mdesc_handle *hp)
@@ -694,14 +702,15 @@ static void set_core_ids(struct mdesc_handle *hp)
 	}
 }
 
-static int set_sock_ids_by_cache(struct mdesc_handle *hp, int level)
+static int set_max_cache_ids_by_cache(struct mdesc_handle *hp, int level)
 {
 	u64 mp;
 	int idx = 1;
 	int fnd = 0;
 
-	/* Identify unique sockets by looking for cpus backpointed to by
-	 * shared level n caches.
+	/**
+	 * Identify unique highest level of shared cache by looking for cpus
+	 * backpointed to by shared level N caches.
 	 */
 	mdesc_for_each_node_by_name(hp, mp, "cache") {
 		const u64 *cur_lvl;
@@ -709,8 +718,7 @@ static int set_sock_ids_by_cache(struct mdesc_handle *hp, int level)
 		cur_lvl = mdesc_get_property(hp, mp, "level", NULL);
 		if (*cur_lvl != level)
 			continue;
-
-		mark_sock_ids(hp, mp, idx);
+		mark_max_cache_ids(hp, mp, idx);
 		idx++;
 		fnd = 1;
 	}
@@ -745,15 +753,17 @@ static void set_sock_ids(struct mdesc_handle *hp)
 {
 	u64 mp;
 
-	/* If machine description exposes sockets data use it.
-	 * Otherwise fallback to use shared L3 or L2 caches.
+	/**
+	 * Find the highest level of shared cache which pre-T7 is also
+	 * the socket.
 	 */
+	if (!set_max_cache_ids_by_cache(hp, 3))
+		set_max_cache_ids_by_cache(hp, 2);
+
+	/* If machine description exposes sockets data use it.*/
 	mp = mdesc_node_by_name(hp, MDESC_NODE_NULL, "sockets");
 	if (mp != MDESC_NODE_NULL)
-		return set_sock_ids_by_socket(hp, mp);
-
-	if (!set_sock_ids_by_cache(hp, 3))
-		set_sock_ids_by_cache(hp, 2);
+		set_sock_ids_by_socket(hp, mp);
 }
 
 static void mark_proc_ids(struct mdesc_handle *hp, u64 mp, int proc_id)
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 8a6151a..dc99454 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -63,9 +63,13 @@ cpumask_t cpu_core_map[NR_CPUS] __read_mostly  cpumask_t cpu_core_sib_map[NR_CPUS] __read_mostly = {
 	[0 ... NR_CPUS-1] = CPU_MASK_NONE };
 
+cpumask_t cpu_core_sib_cache_map[NR_CPUS] __read_mostly = {
+	[0 ... NR_CPUS - 1] = CPU_MASK_NONE };
+
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 EXPORT_SYMBOL(cpu_core_map);
 EXPORT_SYMBOL(cpu_core_sib_map);
+EXPORT_SYMBOL(cpu_core_sib_cache_map);
 
 static cpumask_t smp_commenced_mask;
 
@@ -1251,6 +1255,10 @@ void smp_fill_in_sib_core_maps(void)
 		unsigned int j;
 
 		for_each_present_cpu(j)  {
+			if (cpu_data(i).max_cache_id =
+			    cpu_data(j).max_cache_id)
+				cpumask_set_cpu(j, &cpu_core_sib_cache_map[i]);
+
 			if (cpu_data(i).sock_id = cpu_data(j).sock_id)
 				cpumask_set_cpu(j, &cpu_core_sib_map[i]);
 		}
-- 
1.7.1

