From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 16 Feb 2017 19:57:05 +0000
Subject: [PATCH] sparc64: use latency groups to improve add_node_ranges speed
Message-Id: <1487275558-153109-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

add_node_ranges() takes 2.6s - 3.6s per 1T of boot time. On machine with 6T
memory it takes 15.4s, on 32T it would take 82s-115s of boot time.
This function sets NUMA ids for memory blocks, and scans the whole memory a
page at a time to do so. But, we could use values in latency groups mask
and match to determine the boundaries without checking every single page.
With the fix the add_node_ranges() time is reduced from 15.4s down to 0.2s
on machine with 6T memory.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/init_64.c |  208 +++++++++++++++++++++++++---------------------
 1 files changed, 113 insertions(+), 95 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 5d2f915..dc53b5d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -785,13 +785,23 @@ static void __init find_ramdisk(unsigned long phys_base)
 
 struct node_mem_mask {
 	unsigned long mask;
-	unsigned long val;
+	unsigned long match;
 };
 static struct node_mem_mask node_masks[MAX_NUMNODES];
 static int num_node_masks;
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
 
+struct mdesc_mlgroup {
+	u64	node;
+	u64	latency;
+	u64	match;
+	u64	mask;
+};
+
+static struct mdesc_mlgroup *mlgroups;
+static int num_mlgroups;
+
 int numa_cpu_lookup_table[NR_CPUS];
 cpumask_t numa_cpumask_lookup_table[MAX_NUMNODES];
 
@@ -802,78 +812,129 @@ struct mdesc_mblock {
 };
 static struct mdesc_mblock *mblocks;
 static int num_mblocks;
-static int find_numa_node_for_addr(unsigned long pa,
-				   struct node_mem_mask *pnode_mask);
 
-static unsigned long __init ra_to_pa(unsigned long addr)
+static struct mdesc_mblock * __init addr_to_mblock(unsigned long addr)
 {
+	struct mdesc_mblock *m = NULL;
 	int i;
 
 	for (i = 0; i < num_mblocks; i++) {
-		struct mdesc_mblock *m = &mblocks[i];
+		m = &mblocks[i];
 
 		if (addr >= m->base &&
 		    addr < (m->base + m->size)) {
-			addr += m->offset;
 			break;
 		}
 	}
-	return addr;
+
+	return m;
 }
 
-static int __init find_node(unsigned long addr)
+static u64 __init memblock_nid_range_sun4u(u64 start, u64 end, int *nid)
 {
-	static bool search_mdesc = true;
-	static struct node_mem_mask last_mem_mask = { ~0UL, ~0UL };
-	static int last_index;
-	int i;
+	int prev_nid, new_nid;
 
-	addr = ra_to_pa(addr);
-	for (i = 0; i < num_node_masks; i++) {
-		struct node_mem_mask *p = &node_masks[i];
+	prev_nid = -1;
+	for ( ; start < end; start += PAGE_SIZE) {
+		for (new_nid = 0; new_nid < num_node_masks; new_nid++) {
+			struct node_mem_mask *p = &node_masks[new_nid];
 
-		if ((addr & p->mask) = p->val)
-			return i;
-	}
-	/* The following condition has been observed on LDOM guests because
-	 * node_masks only contains the best latency mask and value.
-	 * LDOM guest's mdesc can contain a single latency group to
-	 * cover multiple address range. Print warning message only if the
-	 * address cannot be found in node_masks nor mdesc.
-	 */
-	if ((search_mdesc) &&
-	    ((addr & last_mem_mask.mask) != last_mem_mask.val)) {
-		/* find the available node in the mdesc */
-		last_index = find_numa_node_for_addr(addr, &last_mem_mask);
-		numadbg("find_node: latency group for address 0x%lx is %d\n",
-			addr, last_index);
-		if ((last_index < 0) || (last_index >= num_node_masks)) {
-			/* WARN_ONCE() and use default group 0 */
-			WARN_ONCE(1, "find_node: A physical address doesn't match a NUMA node rule. Some physical memory will be owned by node 0.");
-			search_mdesc = false;
-			last_index = 0;
+			if ((start & p->mask) = p->match) {
+				if (prev_nid = -1)
+					prev_nid = new_nid;
+				break;
+			}
 		}
+
+		if (new_nid = num_node_masks) {
+			prev_nid = 0;
+			WARN_ONCE(1, "addr[%Lx] doesn't match a NUMA node rule. Some memory will be owned by node 0.",
+				  start);
+			break;
+		}
+
+		if (prev_nid != new_nid)
+			break;
 	}
+	*nid = prev_nid;
 
-	return last_index;
+	return start > end ? end : start;
 }
 
 static u64 __init memblock_nid_range(u64 start, u64 end, int *nid)
 {
-	*nid = find_node(start);
-	start += PAGE_SIZE;
-	while (start < end) {
-		int n = find_node(start);
+	u64 ret_end, pa_start, m_mask, m_match, m_end;
+	struct mdesc_mblock *mblock;
+	int _nid, i;
+
+	if (tlb_type != hypervisor)
+		return memblock_nid_range_sun4u(start, end, nid);
+
+	mblock = addr_to_mblock(start);
+	if (!mblock) {
+		WARN_ONCE(1, "memblock_nid_range: Can't find mblock addr[%Lx]",
+			  start);
+
+		_nid = 0;
+		ret_end = end;
+		goto done;
+	}
+
+	pa_start = start + mblock->offset;
+	m_match = 0;
+	m_mask = 0;
+
+	for (_nid = 0; _nid < num_node_masks; _nid++) {
+		struct node_mem_mask *const m = &node_masks[_nid];
 
-		if (n != *nid)
+		if ((pa_start & m->mask) = m->match) {
+			m_match = m->match;
+			m_mask = m->mask;
 			break;
-		start += PAGE_SIZE;
+		}
 	}
 
-	if (start > end)
-		start = end;
+	if (num_node_masks = _nid) {
+		/* We could not find NUMA group, so default to 0, but lets
+		 * search for latency group, so we could calculate the correct
+		 * end address that we return
+		 */
+		_nid = 0;
 
-	return start;
+		for (i = 0; i < num_mlgroups; i++) {
+			struct mdesc_mlgroup *const m = &mlgroups[i];
+
+			if ((pa_start & m->mask) = m->match) {
+				m_match = m->match;
+				m_mask = m->mask;
+				break;
+			}
+		}
+
+		if (i = num_mlgroups) {
+			WARN_ONCE(1, "memblock_nid_range: Can't find latency group addr[%Lx]",
+				  start);
+
+			ret_end = end;
+			goto done;
+		}
+	}
+
+	/*
+	 * Each latency group has match and mask, and each memory block has an
+	 * offset.  An address belongs to a latency group if its address matches
+	 * the following formula: ((addr + offset) & mask) = match
+	 * It is, however, slow to check every single page if it matches a
+	 * particular latency group. As optimization we calculate end value by
+	 * using bit arithmetics.
+	 */
+	m_end = m_match + (1ul << __ffs(m_mask)) - mblock->offset;
+	m_end += pa_start & ~((1ul << fls64(m_mask)) - 1);
+	ret_end = m_end > end ? end : m_end;
+
+done:
+	*nid = _nid;
+	return ret_end;
 }
 #endif
 
@@ -914,7 +975,8 @@ static void init_node_masks_nonnuma(void)
 
 	numadbg("Initializing tables for non-numa.\n");
 
-	node_masks[0].mask = node_masks[0].val = 0;
+	node_masks[0].mask = 0;
+	node_masks[0].match = 0;
 	num_node_masks = 1;
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
@@ -932,15 +994,6 @@ static void init_node_masks_nonnuma(void)
 EXPORT_SYMBOL(numa_cpumask_lookup_table);
 EXPORT_SYMBOL(node_data);
 
-struct mdesc_mlgroup {
-	u64	node;
-	u64	latency;
-	u64	match;
-	u64	mask;
-};
-static struct mdesc_mlgroup *mlgroups;
-static int num_mlgroups;
-
 static int scan_pio_for_cfg_handle(struct mdesc_handle *md, u64 pio,
 				   u32 cfg_handle)
 {
@@ -1182,41 +1235,6 @@ int __node_distance(int from, int to)
 	return numa_latency[from][to];
 }
 
-static int find_numa_node_for_addr(unsigned long pa,
-				   struct node_mem_mask *pnode_mask)
-{
-	struct mdesc_handle *md = mdesc_grab();
-	u64 node, arc;
-	int i = 0;
-
-	node = mdesc_node_by_name(md, MDESC_NODE_NULL, "latency-groups");
-	if (node = MDESC_NODE_NULL)
-		goto out;
-
-	mdesc_for_each_node_by_name(md, node, "group") {
-		mdesc_for_each_arc(arc, md, node, MDESC_ARC_TYPE_FWD) {
-			u64 target = mdesc_arc_target(md, arc);
-			struct mdesc_mlgroup *m = find_mlgroup(target);
-
-			if (!m)
-				continue;
-			if ((pa & m->mask) = m->match) {
-				if (pnode_mask) {
-					pnode_mask->mask = m->mask;
-					pnode_mask->val = m->match;
-				}
-				mdesc_release(md);
-				return i;
-			}
-		}
-		i++;
-	}
-
-out:
-	mdesc_release(md);
-	return -1;
-}
-
 static int __init find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 {
 	int i;
@@ -1224,7 +1242,7 @@ static int __init find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		struct node_mem_mask *n = &node_masks[i];
 
-		if ((grp->mask = n->mask) && (grp->match = n->val))
+		if ((grp->mask = n->mask) && (grp->match = n->match))
 			break;
 	}
 	return i;
@@ -1279,10 +1297,10 @@ static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
 	n = &node_masks[num_node_masks++];
 
 	n->mask = candidate->mask;
-	n->val = candidate->match;
+	n->match = candidate->match;
 
-	numadbg("NUMA NODE[%d]: mask[%lx] val[%lx] (latency[%llx])\n",
-		index, n->mask, n->val, candidate->latency);
+	numadbg("NUMA NODE[%d]: mask[%lx] match[%lx] (latency[%llx])\n",
+		index, n->mask, n->match, candidate->latency);
 
 	return 0;
 }
@@ -1379,7 +1397,7 @@ static int __init numa_parse_jbus(void)
 		numa_cpu_lookup_table[cpu] = index;
 		cpumask_copy(&numa_cpumask_lookup_table[index], cpumask_of(cpu));
 		node_masks[index].mask = ~((1UL << 36UL) - 1UL);
-		node_masks[index].val = cpu << 36UL;
+		node_masks[index].match = cpu << 36UL;
 
 		index++;
 	}
-- 
1.7.1

