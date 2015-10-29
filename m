From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 29 Oct 2015 00:03:46 +0000
Subject: [PATCH] sparc64: Fix numa distance values
Message-Id: <1446077026-5598-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux <sparclinux@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Chris Hyser <chris.hyser@oracle.com>, Khalid Aziz <khalid.aziz@oracle.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>

Orabug: 21896119

Use machine descriptor (MD) to get node latency
values instead of just using default values.

Testing:
On an T5-8 system with:
 - total nodes = 8
 - self latencies = 0x26d18
 - latency to other nodes = 0x3a598
   => latency ratio = ~1.5

output of numactl --hardware

 - before fix:

node distances:
node   0   1   2   3   4   5   6   7
  0:  10  20  20  20  20  20  20  20
  1:  20  10  20  20  20  20  20  20
  2:  20  20  10  20  20  20  20  20
  3:  20  20  20  10  20  20  20  20
  4:  20  20  20  20  10  20  20  20
  5:  20  20  20  20  20  10  20  20
  6:  20  20  20  20  20  20  10  20
  7:  20  20  20  20  20  20  20  10

 - after fix:

node distances:
node   0   1   2   3   4   5   6   7
  0:  10  15  15  15  15  15  15  15
  1:  15  10  15  15  15  15  15  15
  2:  15  15  10  15  15  15  15  15
  3:  15  15  15  10  15  15  15  15
  4:  15  15  15  15  10  15  15  15
  5:  15  15  15  15  15  10  15  15
  6:  15  15  15  15  15  15  10  15
  7:  15  15  15  15  15  15  15  10

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
---
 arch/sparc/include/asm/topology_64.h |    3 +
 arch/sparc/mm/init_64.c              |   70 +++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index 01d1704..ed3dfdd 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -31,6 +31,9 @@ static inline int pcibus_to_node(struct pci_bus *pbus)
 	 cpu_all_mask : \
 	 cpumask_of_node(pcibus_to_node(bus)))
 
+extern int __node_distance(int, int);
+#define node_distance(a, b) __node_distance(a, b)
+
 #else /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4ac88b7..3025bd5 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -93,6 +93,8 @@ static unsigned long cpu_pgsz_mask;
 static struct linux_prom64_registers pavail[MAX_BANKS];
 static int pavail_ents;
 
+u64 numa_latency[MAX_NUMNODES][MAX_NUMNODES];
+
 static int cmp_p64(const void *a, const void *b)
 {
 	const struct linux_prom64_registers *x = a, *y = b;
@@ -1157,6 +1159,48 @@ static struct mdesc_mlgroup * __init find_mlgroup(u64 node)
 	return NULL;
 }
 
+int __node_distance(int from, int to)
+{
+	if ((from >= MAX_NUMNODES) || (to >= MAX_NUMNODES)) {
+		pr_warn("Returning default NUMA distance value for %d->%d\n",
+			from, to);
+		return (from = to) ? LOCAL_DISTANCE : REMOTE_DISTANCE;
+	}
+	return numa_latency[from][to];
+}
+
+static int find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
+{
+	int i;
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		struct node_mem_mask *n = &node_masks[i];
+
+		if ((grp->mask = n->mask) && (grp->match = n->val))
+			break;
+	}
+	return i;
+}
+
+static void find_numa_latencies_for_group(struct mdesc_handle *md, u64 grp,
+					  int index)
+{
+	u64 arc;
+
+	mdesc_for_each_arc(arc, md, grp, MDESC_ARC_TYPE_FWD) {
+		int tnode;
+		u64 target = mdesc_arc_target(md, arc);
+		struct mdesc_mlgroup *m = find_mlgroup(target);
+
+		if (!m)
+			continue;
+		tnode = find_best_numa_node_for_mlgroup(m);
+		if (tnode = MAX_NUMNODES)
+			continue;
+		numa_latency[index][tnode] = m->latency;
+	}
+}
+
 static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
 				      int index)
 {
@@ -1220,9 +1264,16 @@ static int __init numa_parse_mdesc_group(struct mdesc_handle *md, u64 grp,
 static int __init numa_parse_mdesc(void)
 {
 	struct mdesc_handle *md = mdesc_grab();
-	int i, err, count;
+	int i, j, err, count;
 	u64 node;
 
+	/* Some sane defaults for numa latency values */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		for (j = 0; j < MAX_NUMNODES; j++)
+			numa_latency[i][j] = (i = j) ?
+				LOCAL_DISTANCE : REMOTE_DISTANCE;
+	}
+
 	node = mdesc_node_by_name(md, MDESC_NODE_NULL, "latency-groups");
 	if (node = MDESC_NODE_NULL) {
 		mdesc_release(md);
@@ -1245,6 +1296,23 @@ static int __init numa_parse_mdesc(void)
 		count++;
 	}
 
+	count = 0;
+	mdesc_for_each_node_by_name(md, node, "group") {
+		find_numa_latencies_for_group(md, node, count);
+		count++;
+	}
+
+	/* Normalize numa latency matrix according to ACPI SLIT spec. */
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		u64 self_latency = numa_latency[i][i];
+
+		for (j = 0; j < MAX_NUMNODES; j++) {
+			numa_latency[i][j] +				(numa_latency[i][j] * LOCAL_DISTANCE) /
+				self_latency;
+		}
+	}
+
 	add_node_ranges();
 
 	for (i = 0; i < num_node_masks; i++) {
-- 
1.7.1

