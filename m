From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:31:49 +0000
Subject: [RFC PATCH 09/12] of: merge of_node_get(),
Message-Id: <20091007043142.16890.90460.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge common code between Sparc, PowerPC and Microblaze.

Sparc differs in the implementation at this point, so this patch uses
a #ifdef to handle sparc differently for now.  The merging of
implementations will occur in a later patch

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    4 ----
 arch/powerpc/include/asm/prom.h    |    4 ----
 arch/sparc/include/asm/prom.h      |    9 ---------
 include/linux/of.h                 |   16 ++++++++++++++++
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index d4f57ff..c92b4a9 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -40,10 +40,6 @@ extern struct device_node *of_chosen;
 extern struct device_node *allnodes;	/* temporary while merging */
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-extern struct device_node *of_find_all_nodes(struct device_node *prev);
-extern struct device_node *of_node_get(struct device_node *node);
-extern void of_node_put(struct device_node *node);
-
 /* For scanning the flat device-tree at boot time */
 extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
 					const char *uname, int depth,
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index d8c0525..622769c 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -34,10 +34,6 @@ extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-extern struct device_node *of_find_all_nodes(struct device_node *prev);
-extern struct device_node *of_node_get(struct device_node *node);
-extern void of_node_put(struct device_node *node);
-
 /* For scanning the flat device-tree at boot time */
 extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
 					    const char *uname, int depth,
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index ddbd870..f845828 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -51,15 +51,6 @@ extern void prom_build_devicetree(void);
 extern void of_populate_present_mask(void);
 extern void of_fill_in_cpu_data(void);
 
-/* Dummy ref counting routines - to be implemented later */
-static inline struct device_node *of_node_get(struct device_node *node)
-{
-	return node;
-}
-static inline void of_node_put(struct device_node *node)
-{
-}
-
 /* These routines are here to provide compatibility with how powerpc
  * handles IRQ mapping for OF device nodes.  We precompute and permanently
  * register them in the of_device objects, whereas powerpc computes them
diff --git a/include/linux/of.h b/include/linux/of.h
index 18e4379..4636bba 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -79,6 +79,22 @@ set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
 	dn->pde = de;
 }
 
+#if defined(CONFIG_SPARC)
+/* Dummy ref counting routines - to be implemented later */
+static inline struct device_node *of_node_get(struct device_node *node)
+{
+	return node;
+}
+static inline void of_node_put(struct device_node *node)
+{
+}
+
+#else
+extern struct device_node *of_find_all_nodes(struct device_node *prev);
+extern struct device_node *of_node_get(struct device_node *node);
+extern void of_node_put(struct device_node *node);
+#endif
+
 /*
  * OF address retreival & translation
  */

