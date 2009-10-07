From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:30:34 +0000
Subject: [RFC PATCH 03/12] of: merge struct device_node
Message-Id: <20091007043027.16890.46731.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, microblaze-uclinux

Merge of common code duplicated between Sparc, PowerPC and Microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   20 --------------------
 arch/powerpc/include/asm/prom.h    |   20 --------------------
 arch/sparc/include/asm/prom.h      |   24 ------------------------
 include/linux/of.h                 |   32 ++++++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 64 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 11cb484..64e8b3a 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -73,26 +73,6 @@ struct boot_param_header {
 	u32	dt_struct_size; /* size of the DT structure block */
 };
 
-struct device_node {
-	const char *name;
-	const char *type;
-	phandle	node;
-	phandle linux_phandle;
-	char	*full_name;
-
-	struct	property *properties;
-	struct	property *deadprops; /* removed properties */
-	struct	device_node *parent;
-	struct	device_node *child;
-	struct	device_node *sibling;
-	struct	device_node *next; /* next device of same type */
-	struct	device_node *allnext; /* next in list of all nodes */
-	struct	proc_dir_entry *pde; /* this node's proc directory */
-	struct	kref kref;
-	unsigned long _flags;
-	void	*data;
-};
-
 extern struct device_node *of_chosen;
 
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index c236326..c918db5 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -71,26 +71,6 @@ struct boot_param_header
 	u32	dt_struct_size;		/* size of the DT structure block */
 };
 
-struct device_node {
-	const char *name;
-	const char *type;
-	phandle	node;
-	phandle linux_phandle;
-	char	*full_name;
-
-	struct	property *properties;
-	struct  property *deadprops; /* removed properties */
-	struct	device_node *parent;
-	struct	device_node *child;
-	struct	device_node *sibling;
-	struct	device_node *next;	/* next device of same type */
-	struct	device_node *allnext;	/* next in list of all nodes */
-	struct  proc_dir_entry *pde;	/* this node's proc directory */
-	struct  kref kref;
-	unsigned long _flags;
-	void	*data;
-};
-
 extern struct device_node *of_chosen;
 
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index b34f988..e5f4a1d 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -29,30 +29,6 @@
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
 
-struct of_irq_controller;
-struct device_node {
-	const char	*name;
-	const char	*type;
-	phandle	node;
-	char	*path_component_name;
-	char	*full_name;
-
-	struct	property *properties;
-	struct  property *deadprops; /* removed properties */
-	struct	device_node *parent;
-	struct	device_node *child;
-	struct	device_node *sibling;
-	struct	device_node *next;	/* next device of same type */
-	struct	device_node *allnext;	/* next in list of all nodes */
-	struct  proc_dir_entry *pde;	/* this node's proc directory */
-	struct  kref kref;
-	unsigned long _flags;
-	void	*data;
-	unsigned int unique_id;
-
-	struct of_irq_controller *irq_trans;
-};
-
 struct of_irq_controller {
 	unsigned int	(*irq_build)(struct device_node *, unsigned int, void *);
 	void		*data;
diff --git a/include/linux/of.h b/include/linux/of.h
index 4668b29..65a158d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -17,6 +17,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/kref.h>
 #include <linux/mod_devicetable.h>
 
 typedef u32 phandle;
@@ -31,6 +32,37 @@ struct property {
 	unsigned int unique_id;
 };
 
+#if defined(CONFIG_SPARC)
+struct of_irq_controller;
+#endif
+
+struct device_node {
+	const char *name;
+	const char *type;
+	phandle	node;
+#if !defined(CONFIG_SPARC)
+	phandle linux_phandle;
+#endif
+	char	*full_name;
+
+	struct	property *properties;
+	struct	property *deadprops;	/* removed properties */
+	struct	device_node *parent;
+	struct	device_node *child;
+	struct	device_node *sibling;
+	struct	device_node *next;	/* next device of same type */
+	struct	device_node *allnext;	/* next in list of all nodes */
+	struct	proc_dir_entry *pde;	/* this node's proc directory */
+	struct	kref kref;
+	unsigned long _flags;
+	void	*data;
+#if defined(CONFIG_SPARC)
+	char	*path_component_name;
+	unsigned int unique_id;
+	struct of_irq_controller *irq_trans;
+#endif
+};
+
 #include <asm/prom.h>
 
 /* flag descriptions */

