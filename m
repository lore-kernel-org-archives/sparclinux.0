From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:39 +0000
Subject: [PATCH 34/34] sparc64: fix sparse warnings in int_64.c
Message-Id: <1399157559-19901-34-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
init_64.c:798:5: warning: symbol 'numa_cpu_lookup_table' was not declared. Should it be static?
init_64.c:799:11: warning: symbol 'numa_cpumask_lookup_table' was not declared. Should it be static?

The warnings were present with an allnoconfig
Fix so the variables are only declared if CONFIG_NEED_MULTIPLE_NODES is defined.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_64.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0ebe2fd..6dfad56 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -795,11 +795,11 @@ struct node_mem_mask {
 static struct node_mem_mask node_masks[MAX_NUMNODES];
 static int num_node_masks;
 
+#ifdef CONFIG_NEED_MULTIPLE_NODES
+
 int numa_cpu_lookup_table[NR_CPUS];
 cpumask_t numa_cpumask_lookup_table[MAX_NUMNODES];
 
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-
 struct mdesc_mblock {
 	u64	base;
 	u64	size;
@@ -888,17 +888,21 @@ static void __init allocate_node_data(int nid)
 
 static void init_node_masks_nonnuma(void)
 {
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 	int i;
+#endif
 
 	numadbg("Initializing tables for non-numa.\n");
 
 	node_masks[0].mask = node_masks[0].val = 0;
 	num_node_masks = 1;
 
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 	for (i = 0; i < NR_CPUS; i++)
 		numa_cpu_lookup_table[i] = 0;
 
 	cpumask_setall(&numa_cpumask_lookup_table[0]);
+#endif
 }
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-- 
1.9.0

