From: David Miller <davem@davemloft.net>
Date: Fri, 05 Aug 2011 10:09:42 +0000
Subject: [PATCH] sparc: Size mondo queues more sanely.
Message-Id: <20110805.030942.1092674593233364039.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


There is currently no upper limit on the mondo queue sizes we'll use,
which guarentees that we'll eventually his page allocation limits, and
thus allocation failures, due to MAX_ORDER.

Cap the sizes sanely, current limits are:

CPU  MONDO	2 * max_possible_cpus
DEV  MONDO	256 (basically NR_IRQS)
RES  MONDO	128
NRES MONDO	4

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/mdesc.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 42f28c7..acaebb6 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -508,6 +508,8 @@ const char *mdesc_node_name(struct mdesc_handle *hp, u64 node)
 }
 EXPORT_SYMBOL(mdesc_node_name);
 
+static u64 max_cpus = 64;
+
 static void __init report_platform_properties(void)
 {
 	struct mdesc_handle *hp = mdesc_grab();
@@ -543,8 +545,10 @@ static void __init report_platform_properties(void)
 	if (v)
 		printk("PLATFORM: watchdog-max-timeout [%llu ms]\n", *v);
 	v = mdesc_get_property(hp, pn, "max-cpus", NULL);
-	if (v)
-		printk("PLATFORM: max-cpus [%llu]\n", *v);
+	if (v) {
+		max_cpus = *v;
+		printk("PLATFORM: max-cpus [%llu]\n", max_cpus);
+	}
 
 #ifdef CONFIG_SMP
 	{
@@ -715,7 +719,7 @@ static void __cpuinit set_proc_ids(struct mdesc_handle *hp)
 }
 
 static void __cpuinit get_one_mondo_bits(const u64 *p, unsigned int *mask,
-					 unsigned char def)
+					 unsigned long def, unsigned long max)
 {
 	u64 val;
 
@@ -726,6 +730,9 @@ static void __cpuinit get_one_mondo_bits(const u64 *p, unsigned int *mask,
 	if (!val || val >= 64)
 		goto use_default;
 
+	if (val > max)
+		val = max;
+
 	*mask = ((1U << val) * 64U) - 1U;
 	return;
 
@@ -736,19 +743,28 @@ use_default:
 static void __cpuinit get_mondo_data(struct mdesc_handle *hp, u64 mp,
 				     struct trap_per_cpu *tb)
 {
+	static int printed;
 	const u64 *val;
 
 	val = mdesc_get_property(hp, mp, "q-cpu-mondo-#bits", NULL);
-	get_one_mondo_bits(val, &tb->cpu_mondo_qmask, 7);
+	get_one_mondo_bits(val, &tb->cpu_mondo_qmask, 7, ilog2(max_cpus * 2));
 
 	val = mdesc_get_property(hp, mp, "q-dev-mondo-#bits", NULL);
-	get_one_mondo_bits(val, &tb->dev_mondo_qmask, 7);
+	get_one_mondo_bits(val, &tb->dev_mondo_qmask, 7, 8);
 
 	val = mdesc_get_property(hp, mp, "q-resumable-#bits", NULL);
-	get_one_mondo_bits(val, &tb->resum_qmask, 6);
+	get_one_mondo_bits(val, &tb->resum_qmask, 6, 7);
 
 	val = mdesc_get_property(hp, mp, "q-nonresumable-#bits", NULL);
-	get_one_mondo_bits(val, &tb->nonresum_qmask, 2);
+	get_one_mondo_bits(val, &tb->nonresum_qmask, 2, 2);
+	if (!printed++) {
+		pr_info("SUN4V: Mondo queue sizes "
+			"[cpu(%u) dev(%u) r(%u) nr(%u)]\n",
+			tb->cpu_mondo_qmask + 1,
+			tb->dev_mondo_qmask + 1,
+			tb->resum_qmask + 1,
+			tb->nonresum_qmask + 1);
+	}
 }
 
 static void * __cpuinit mdesc_iterate_over_cpus(void *(*func)(struct mdesc_handle *, u64, int, void *), void *arg, cpumask_t *mask)
-- 
1.7.6.401.g6a319

