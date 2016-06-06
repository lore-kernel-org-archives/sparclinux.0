From: chris hyser <chris.hyser@oracle.com>
Date: Mon, 06 Jun 2016 22:23:22 +0000
Subject: [RFC] sparc64: Meaning of /sys/**/core_siblings on newer platforms.
Message-Id: <029d528e-27bf-b55c-5dfb-335d202dc1ce@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Before SPARC T7, the notion of core_siblings was both those CPUs that share a
common highest level cache and the set of CPUs within a particular socket
(share same package_id). This was also true on older x86 CPUs and perhaps most
recent though my knowledge of x86 is dated.

The idea of same package_id is stated in Documentation/cputopology.txt and
programs such as lscpu have relied upon this to find the number of sockets by
counting the number of unique core_siblings_list entries. I suspect the reliance
on that algorithm predates the ability to read package IDs directly which is
simpler, more straightforward and preserves the platform assigned package ID
versus an ID that is just an incremented index based on order of discovery.

The idea that it needs to represent shared common highest level cache comes
from irqbalance, an important run-time performance enhancing daemon.

irqbalance uses the following hierarchy of locality goodness:

          - shared common core (thread_siblings)
          - shared common cache (core_siblings)
          - shared common socket (CPUs with same physical_package_id)
          - shared common node (CPUS in same node)

This layout perfectly describes the T7 and interestingly suggests that there are
one or more other architectures that have reached the point where enough cores
can be jammed into the same package that a shared high level cache is either not
desirable or not worth the real estate/effort. Said differently, socket in the
future will likely become less synonymous with shared cache and instead more
synonymous with node. I'm still digging to see if and what those architectures
are.

The issue is that on newer SPARC HW both definitions can no longer be true and
that choosing one versus the other will break differing sets of code. This can
be illustrated as a choice between an unmodified lscpu spitting out nonsensical
answers (although it currently can do that for different unrelated reasons) or
an unmodified irqbalance incorrectly making cache-thrashing decisions. The
number of important programs in each class is unknown, but either way some
things will have to be fixed. As I believe the whole point of large SPARC
servers is performance and the goal of the people on the SPARC mailing list is
to maximize SPARC linux performance, I would argue for not breaking what I
would call the performance class of programs versus the topology description
class.

Rationale:

- performance class breakage is harder to diagnose as it results in lost
performance and tracing back to root cause is incredibly difficult. Topology
description programs on the other hand spit out easily identified nonsense
and can be modified in a manner that is actually more straight forward than
the current algorithm while preserving architecturally neutral functional
correctness (i.e. not hacks/workarounds)

Attached is a working sparc64 patch for redefinition in favor of "shared
highest level cache" (not intended in its current form for actual upstream
submission but to clarify the proposal and allow actual testing). I'm seeking
feedback on how to proceed here to prevent wasted effort fixing the wrong set
of user land programs and related in-progress patches for SPARC sysfs.

Example results of patch:

Before:
          [root@ca-sparc30 topology]# cat core_siblings_list
          32-63,128-223

After:
          [root@ca-sparc30 topology]# cat core_siblings_list
          32-63

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index a6cfdab..2b4e384 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -19,14 +19,19 @@ typedef struct {
    	/* Dcache line 2, rarely used */
   	unsigned int	dcache_size;
-	unsigned int	dcache_line_size;
   	unsigned int	icache_size;
-	unsigned int	icache_line_size;
   	unsigned int	ecache_size;
-	unsigned int	ecache_line_size;
-	unsigned short	sock_id;
+	unsigned int	l3_cache_size;
+
+	unsigned short	icache_line_size;
+	unsigned short	dcache_line_size;
+	unsigned short	ecache_line_size;
+	unsigned short	l3_cache_line_size;
+
+	unsigned short	sock_id;	/* physical package */
   	unsigned short	core_id;
-	int		proc_id;
+	unsigned short	max_cache_id;	/* groupings of highest shared cache */
+	unsigned short	proc_id;	/* strand (aka HW thread) id */
   } cpuinfo_sparc;
    DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index bec481a..6f98d4e 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -41,7 +41,7 @@ int __node_distance(int, int);
   #endif /* !(CONFIG_NUMA) */
    #ifdef CONFIG_SMP
-#define topology_physical_package_id(cpu)	(cpu_data(cpu).proc_id)
+#define topology_physical_package_id(cpu)	(cpu_data(cpu).sock_id)
   #define topology_core_id(cpu)			(cpu_data(cpu).core_id)
   #define topology_core_cpumask(cpu)		(&cpu_core_sib_map[cpu])
   #define topology_sibling_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 1122886..e1b3893 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -578,6 +578,7 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
   	const u64 *line_size = mdesc_get_property(hp, mp, "line-size", NULL);
   	const char *type;
   	int type_len;
+	u64 a;
    	type = mdesc_get_property(hp, mp, "type", &type_len);
   @@ -597,20 +598,21 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
   		c->ecache_line_size = *line_size;
   		break;
   +	case 3:
+		c->l3_cache_size = *size;
+		c->l3_cache_line_size = *line_size;
+		break;
+
   	default:
   		break;
   	}
   -	if (*level = 1) {
-		u64 a;
-
-		mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_FWD) {
-			u64 target = mdesc_arc_target(hp, a);
-			const char *name = mdesc_node_name(hp, target);
+	mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_FWD) {
+		u64 target = mdesc_arc_target(hp, a);
+		const char *name = mdesc_node_name(hp, target);
   -			if (!strcmp(name, "cache"))
-				fill_in_one_cache(c, hp, target);
-		}
+		if (!strcmp(name, "cache"))
+			fill_in_one_cache(c, hp, target);
   	}
   }
   @@ -645,13 +647,19 @@ static void __mark_core_id(struct mdesc_handle *hp, u64 node,
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
+		/* On systems without explicit socket descriptions, socket
+		 * is max_cache_id
+		 */
+		cpu_data(*id).sock_id = max_cache_id;
+	}
   }
    static void mark_core_ids(struct mdesc_handle *hp, u64 mp,
@@ -660,10 +668,11 @@ static void mark_core_ids(struct mdesc_handle *hp, u64 mp,
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
@@ -694,14 +703,15 @@ static void set_core_ids(struct mdesc_handle *hp)
   	}
   }
   -static int set_sock_ids_by_cache(struct mdesc_handle *hp, int level)
+static int set_max_cache_ids_by_cache(struct mdesc_handle *hp,
+				      int level)
   {
   	u64 mp;
   	int idx = 1;
   	int fnd = 0;
   -	/* Identify unique sockets by looking for cpus backpointed to by
-	 * shared level n caches.
+	/* Identify unique highest level of shared cache by looking for cpus
+	 * backpointed to by shared level N caches.
   	 */
   	mdesc_for_each_node_by_name(hp, mp, "cache") {
   		const u64 *cur_lvl;
@@ -710,7 +720,7 @@ static int set_sock_ids_by_cache(struct mdesc_handle *hp, int level)
   		if (*cur_lvl != level)
   			continue;
   -		mark_sock_ids(hp, mp, idx);
+		mark_max_cache_ids(hp, mp, idx);
   		idx++;
   		fnd = 1;
   	}
@@ -745,15 +755,17 @@ static void set_sock_ids(struct mdesc_handle *hp)
   {
   	u64 mp;
   +	/* Find the highest level of shared cache which on pre-T7 is also
+	 * the socket.
+	 */
+	if (!set_max_cache_ids_by_cache(hp, 3))
+		set_max_cache_ids_by_cache(hp, 2);
+
   	/* If machine description exposes sockets data use it.
-	 * Otherwise fallback to use shared L3 or L2 caches.
   	 */
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
index 8a6151a..bbe27a4 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1250,8 +1250,11 @@ void smp_fill_in_sib_core_maps(void)
   	for_each_present_cpu(i)  {
   		unsigned int j;
   +		cpumask_clear(&cpu_core_sib_map[i]);
+
   		for_each_present_cpu(j)  {
-			if (cpu_data(i).sock_id = cpu_data(j).sock_id)
+			if (cpu_data(i).max_cache_id =
+			    cpu_data(j).max_cache_id)
   				cpumask_set_cpu(j, &cpu_core_sib_map[i]);
   		}
   	}
