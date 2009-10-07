From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:31:24 +0000
Subject: [RFC PATCH 07/12] of: merge of_node_*_flag() and set_node_proc_entry()
Message-Id: <20091007043117.16890.91667.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge common code between PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   16 ----------------
 arch/powerpc/include/asm/prom.h    |   17 -----------------
 include/linux/of.h                 |   16 ++++++++++++++++
 3 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index dfc4afc..180d844 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -35,24 +35,8 @@
 
 extern struct device_node *of_chosen;
 
-static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
-{
-	return test_bit(flag, &n->_flags);
-}
-
-static inline void of_node_set_flag(struct device_node *n, unsigned long flag)
-{
-	set_bit(flag, &n->_flags);
-}
-
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-static inline void set_node_proc_entry(struct device_node *dn,
-					struct proc_dir_entry *de)
-{
-	dn->pde = de;
-}
-
 extern struct device_node *allnodes;	/* temporary while merging */
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index ef20e6c..2cfd432 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -32,25 +32,8 @@
 
 extern struct device_node *of_chosen;
 
-static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
-{
-	return test_bit(flag, &n->_flags);
-}
-
-static inline void of_node_set_flag(struct device_node *n, unsigned long flag)
-{
-	set_bit(flag, &n->_flags);
-}
-
-
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->pde = de;
-}
-
-
 extern struct device_node *of_find_all_nodes(struct device_node *prev);
 extern struct device_node *of_node_get(struct device_node *node);
 extern void of_node_put(struct device_node *node);
diff --git a/include/linux/of.h b/include/linux/of.h
index a66c1eb..d5f6662 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -63,6 +63,22 @@ struct device_node {
 #endif
 };
 
+static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
+{
+	return test_bit(flag, &n->_flags);
+}
+
+static inline void of_node_set_flag(struct device_node *n, unsigned long flag)
+{
+	set_bit(flag, &n->_flags);
+}
+
+static inline void
+set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
+{
+	dn->pde = de;
+}
+
 #include <asm/prom.h>
 
 /* flag descriptions */

