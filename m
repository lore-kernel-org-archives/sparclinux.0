From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 20:07:10 +0000
Subject: [PATCH] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <1426795630-135778-1-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The current sparc kernel has no representation for sockets though tools like
lscpu can pull this from sysfs. This patch walks the machine description
cache and socket hierarchy and marks sockets as well as cores and threads
such that a representative sysfs is created by drivers/base/topology.c.

Before this patch:
$ lscpu
Architecture:          sparc64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Big Endian
CPU(s):                1024
On-line CPU(s) list:   0-1023
Thread(s) per core:    8
Core(s) per socket:    1     <--- wrong
Socket(s):             128   <--- wrong
NUMA node(s):          4
NUMA node0 CPU(s):     0-255
NUMA node1 CPU(s):     256-511
NUMA node2 CPU(s):     512-767
NUMA node3 CPU(s):     768-1023

After this patch:
$ lscpu
Architecture:          sparc64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Big Endian
CPU(s):                1024
On-line CPU(s) list:   0-1023
Thread(s) per core:    8
Core(s) per socket:    32
Socket(s):             4
NUMA node(s):          4
NUMA node0 CPU(s):     0-255
NUMA node1 CPU(s):     256-511
NUMA node2 CPU(s):     512-767
NUMA node3 CPU(s):     768-1023

Most of this patch was done by Chris with updates by David.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/include/asm/cpudata_64.h  |   3 +-
 arch/sparc/include/asm/topology_64.h |   3 +-
 arch/sparc/kernel/mdesc.c            | 142 +++++++++++++++++++++++++++++------
 arch/sparc/kernel/smp_64.c           |  13 ++++
 4 files changed, 134 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index a6e424d185d0..a6cfdabb6054 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -24,7 +24,8 @@ typedef struct {
 	unsigned int	icache_line_size;
 	unsigned int	ecache_size;
 	unsigned int	ecache_line_size;
-	int		core_id;
+	unsigned short	sock_id;
+	unsigned short	core_id;
 	int		proc_id;
 } cpuinfo_sparc;
 
diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index ed8f071132e4..d1761df5cca6 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -40,11 +40,12 @@ static inline int pcibus_to_node(struct pci_bus *pbus)
 #ifdef CONFIG_SMP
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).proc_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).core_id)
-#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
+#define topology_core_cpumask(cpu)		(&cpu_core_sib_map[cpu])
 #define topology_thread_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
 #endif /* CONFIG_SMP */
 
 extern cpumask_t cpu_core_map[NR_CPUS];
+extern cpumask_t cpu_core_sib_map[NR_CPUS];
 static inline const struct cpumask *cpu_coregroup_mask(int cpu)
 {
         return &cpu_core_map[cpu];
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 99632a87e697..ac46a9d53f5a 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -614,45 +614,69 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
 	}
 }
 
-static void mark_core_ids(struct mdesc_handle *hp, u64 mp, int core_id)
+static void __cpuinit find_back_node_value(struct mdesc_handle *hp, u64 node,
+	       char *srch_val, void(*func)(struct mdesc_handle *, u64, int),
+	       u64 val, int depth)
 {
-	u64 a;
+	u64 arc;
 
-	mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_BACK) {
-		u64 t = mdesc_arc_target(hp, a);
-		const char *name;
-		const u64 *id;
-
-		name = mdesc_node_name(hp, t);
-		if (!strcmp(name, "cpu")) {
-			id = mdesc_get_property(hp, t, "id", NULL);
-			if (*id < NR_CPUS)
-				cpu_data(*id).core_id = core_id;
-		} else {
-			u64 j;
+	/*since we have estimate of how deep, do recursion sanity check */
+	if (depth = 0)
+		return;
 
-			mdesc_for_each_arc(j, hp, t, MDESC_ARC_TYPE_BACK) {
-				u64 n = mdesc_arc_target(hp, j);
-				const char *n_name;
+	mdesc_for_each_arc(arc, hp, node, MDESC_ARC_TYPE_BACK) {
+		u64 n = mdesc_arc_target(hp, arc);
+		const char *name = mdesc_node_name(hp, n);
 
-				n_name = mdesc_node_name(hp, n);
-				if (strcmp(n_name, "cpu"))
-					continue;
+	if (!strcmp(srch_val, name))
+		(*func)(hp, n, val);
 
-				id = mdesc_get_property(hp, n, "id", NULL);
-				if (*id < NR_CPUS)
-					cpu_data(*id).core_id = core_id;
-			}
-		}
+	find_back_node_value(hp, n, srch_val, func, val, depth-1);
 	}
 }
 
+static void __cpuinit __mark_core_id(struct mdesc_handle *hp, u64 node,
+		int core_id)
+{
+	const u64 *id = mdesc_get_property(hp, node, "id", NULL);
+
+	if (*id < num_possible_cpus())
+		cpu_data(*id).core_id = core_id;
+}
+
+static void __cpuinit __mark_sock_id(struct mdesc_handle *hp, u64 node,
+		int sock_id)
+{
+	const u64 *id = mdesc_get_property(hp, node, "id", NULL);
+
+	if (*id < num_possible_cpus())
+		cpu_data(*id).sock_id = sock_id;
+}
+
+static void __cpuinit mark_core_ids(struct mdesc_handle *hp, u64 mp,
+		int core_id)
+{
+	find_back_node_value(hp, mp, "cpu", __mark_core_id, core_id, 10);
+}
+
+static void __cpuinit mark_sock_ids(struct mdesc_handle *hp, u64 mp,
+		int sock_id)
+{
+	find_back_node_value(hp, mp, "cpu", __mark_sock_id, sock_id, 10);
+}
+
 static void set_core_ids(struct mdesc_handle *hp)
 {
 	int idx;
 	u64 mp;
 
 	idx = 1;
+
+	/*
+	 * identify unique cores by looking for cpus backpointed to by
+	 * level 1 instruction caches
+	 */
+
 	mdesc_for_each_node_by_name(hp, mp, "cache") {
 		const u64 *level;
 		const char *type;
@@ -672,6 +696,73 @@ static void set_core_ids(struct mdesc_handle *hp)
 	}
 }
 
+static void __cpuinit set_sock_ids_by_cache(struct mdesc_handle *hp, u64 mp)
+{
+	int idx = 1;
+
+	/*
+	 * identify unique sockets by looking for cpus backpointed to by
+	 * level 3 caches
+	 */
+	mdesc_for_each_node_by_name(hp, mp, "cache") {
+		const u64 *level;
+
+		level = mdesc_get_property(hp, mp, "level", NULL);
+		if (*level != 3)
+			continue;
+
+		mark_sock_ids(hp, mp, idx);
+
+		idx++;
+	}
+}
+
+static void __cpuinit set_sock_ids_by_socket(struct mdesc_handle *hp, u64 mp)
+{
+	int idx = 1;
+
+	mdesc_for_each_node_by_name(hp, mp, "socket") {
+		u64 a;
+
+		mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_FWD) {
+			u64 t = mdesc_arc_target(hp, a);
+			const char *name;
+			const u64 *id;
+
+			name = mdesc_node_name(hp, t);
+			if (strcmp(name, "cpu"))
+				continue;
+
+			id = mdesc_get_property(hp, t, "id", NULL);
+			if (*id < num_possible_cpus())
+				cpu_data(*id).sock_id = idx;
+		}
+
+		idx++;
+	}
+}
+
+static void __cpuinit set_sock_ids(struct mdesc_handle *hp)
+{
+	u64 mp;
+
+	/* if machine description exposes sockets data use it.
+	 * otherwise fallback to use L3 cache
+	 */
+	mp = mdesc_node_by_name(hp, MDESC_NODE_NULL, "sockets");
+	if (mp = MDESC_NODE_NULL) {
+		if (sun4v_chip_type = SUN4V_CHIP_SPARC_M7) {
+			pr_warn("Machine description does not contain sockets node. Falling back\n");
+			pr_warn("to identifying CPUs to sockets using L3 cache which is known to\n");
+			pr_warn("be wrong for M7 processors (e.g, lscpu shows wrong number of sockets).\n");
+			pr_warn("Please update the firmware.\n");
+		}
+		return set_sock_ids_by_cache(hp, mp);
+	}
+
+	return set_sock_ids_by_socket(hp, mp);
+}
+
 static void mark_proc_ids(struct mdesc_handle *hp, u64 mp, int proc_id)
 {
 	u64 a;
@@ -900,6 +991,7 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
 
 	set_core_ids(hp);
 	set_proc_ids(hp);
+	set_sock_ids(hp);
 
 	mdesc_release(hp);
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 61139d9924ca..19cd08d18672 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -60,8 +60,12 @@ DEFINE_PER_CPU(cpumask_t, cpu_sibling_map) = CPU_MASK_NONE;
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly  	{ [0 ... NR_CPUS-1] = CPU_MASK_NONE };
 
+cpumask_t cpu_core_sib_map[NR_CPUS] __read_mostly = {
+	[0 ... NR_CPUS-1] = CPU_MASK_NONE };
+
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 EXPORT_SYMBOL(cpu_core_map);
+EXPORT_SYMBOL(cpu_core_sib_map);
 
 static cpumask_t smp_commenced_mask;
 
@@ -1243,6 +1247,15 @@ void smp_fill_in_sib_core_maps(void)
 		}
 	}
 
+	for_each_present_cpu(i)  {
+		unsigned int j;
+
+		for_each_present_cpu(j)  {
+			if (cpu_data(i).sock_id = cpu_data(j).sock_id)
+				cpumask_set_cpu(j, &cpu_core_sib_map[i]);
+		}
+	}
+
 	for_each_present_cpu(i) {
 		unsigned int j;
 
-- 
2.3.0

