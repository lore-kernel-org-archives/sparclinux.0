From: David Miller <davem@davemloft.net>
Date: Sun, 07 Dec 2008 08:48:42 +0000
Subject: [PATCH]: Sparc64 bootup fix
Message-Id: <20081207.004842.141261612.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just checked the following sparc64 bootup fix to
sparc-next-2.6, it was caused by the prom_common.c
unification.

I must have screwed this up while respinning this set
in order to fix the sparc32 build problems in my initial
version, and I could have sworn I boot tested this several
times on sparc64, oh well :-)

sparc: Restore irq_trans_init() call in prom_create_node().

This broke sparc64 in various ways.

Add an empty dummy hook in sparc32's prom_32.c so that we
can potentially handle things on that side similarly, and
in particular avoid a prom_common.c ifdef :-)

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h        |    3 ---
 arch/sparc/kernel/prom_32.c     |    4 ++++
 arch/sparc/kernel/prom_common.c |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index 0764b35..bb0f0fd 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -8,10 +8,7 @@ extern struct device_node *allnodes;	/* temporary while merging */
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
 extern void * prom_early_alloc(unsigned long size);
-
-#ifdef CONFIG_SPARC64
 extern void irq_trans_init(struct device_node *dp);
-#endif
 
 extern unsigned int prom_unique_id;
 
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index f21e8fc..fe43e80 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -289,3 +289,7 @@ void __init of_console_init(void)
 void __init of_fill_in_cpu_data(void)
 {
 }
+
+void __init irq_trans_init(struct device_node *dp)
+{
+}
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 2736f3d..4e9af59 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -243,10 +243,10 @@ static struct device_node * __init prom_create_node(phandle node,
 	dp->type = get_one_property(node, "device_type");
 	dp->node = node;
 
-	/* Build interrupts later... */
-
 	dp->properties = build_prop_list(node);
 
+	irq_trans_init(dp);
+
 	return dp;
 }
 
-- 
1.5.6.5

