From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Jul 2007 15:07:42 +0000
Subject: [PATCH 01/12] Split out common parts of prom.h
Message-Id: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
In-Reply-To: <20070718173024.50204a1a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
Cc: paulus@samba.org, "David S. Miller" <davem@davemloft.net>, wli@holomorphy.com

This creates linux/of.h and includes asm/prom.h from it.

We also include linux/of.h from asm/prom.h while we transition.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/prom.h |   43 ++++--------------------------
 include/asm-sparc/prom.h   |   46 ++++----------------------------
 include/asm-sparc64/prom.h |   46 ++++----------------------------
 include/linux/of.h         |   61 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 117 deletions(-)
 create mode 100644 include/linux/of.h

I intend to ask Linus to pull this series in the next day or so as David
appears quite anxious that they get merged, so this is "Last call,
gentlemen".  :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 1632baa..1134aea 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -97,10 +97,6 @@ struct device_node {
 
 extern struct device_node *of_chosen;
 
-/* flag descriptions */
-#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
-#define OF_DETACHED	2 /* node has been detached from the device tree */
-
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 {
 	return test_bit(flag, &n->_flags);
@@ -120,31 +116,7 @@ static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_e
 }
 
 
-/* New style node lookup */
-extern struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name);
-#define for_each_node_by_name(dn, name) \
-	for (dn = of_find_node_by_name(NULL, name); dn; \
-	     dn = of_find_node_by_name(dn, name))
-extern struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type);
-#define for_each_node_by_type(dn, type) \
-	for (dn = of_find_node_by_type(NULL, type); dn; \
-	     dn = of_find_node_by_type(dn, type))
-extern struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compat);
-#define for_each_compatible_node(dn, type, compatible) \
-	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
-	     dn = of_find_compatible_node(dn, type, compatible))
-extern struct device_node *of_find_node_by_path(const char *path);
-extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_find_all_nodes(struct device_node *prev);
-extern struct device_node *of_get_parent(const struct device_node *node);
-extern struct device_node *of_get_next_child(const struct device_node *node,
-					     struct device_node *prev);
-extern struct property *of_find_property(const struct device_node *np,
-					 const char *name,
-					 int *lenp);
 extern struct device_node *of_node_get(struct device_node *node);
 extern void of_node_put(struct device_node *node);
 
@@ -166,17 +138,9 @@ extern void of_detach_node(const struct device_node *);
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
-extern int of_device_is_compatible(const struct device_node *device,
-				const char *);
 #define device_is_compatible(d, c)	of_device_is_compatible((d), (c))
 extern int machine_is_compatible(const char *compat);
-extern const void *of_get_property(const struct device_node *node,
-				const char *name,
-				int *lenp);
-#define get_property(a, b, c)	of_get_property((a), (b), (c))
 extern void print_properties(struct device_node *node);
-extern int of_n_addr_cells(struct device_node* np);
-extern int of_n_size_cells(struct device_node* np);
 extern int prom_n_intr_cells(struct device_node* np);
 extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
 extern int prom_add_property(struct device_node* np, struct property* prop);
@@ -230,7 +194,6 @@ static inline unsigned long of_read_ulong(const u32 *cell, int size)
 
 /* Translate an OF address block into a CPU physical address
  */
-#define OF_BAD_ADDR	((u64)-1)
 extern u64 of_translate_address(struct device_node *np, const u32 *addr);
 
 /* Extract an address from a device, returns the region size and
@@ -357,5 +320,11 @@ extern int of_irq_to_resource(struct device_node *dev, int index,
  */
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
+/*
+ * NB:  This is here while we transition from using asm/prom.h
+ * to linux/of.h
+ */
+#include <linux/of.h>
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 9ea105e..d67af08 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -2,7 +2,6 @@
 #define _SPARC_PROM_H
 #ifdef __KERNEL__
 
-
 /*
  * Definitions for talking to the Open Firmware PROM on
  * Power Macintosh computers.
@@ -17,7 +16,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
@@ -55,53 +53,21 @@ struct device_node {
 	unsigned int unique_id;
 };
 
-/* flag descriptions */
-#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
-
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
-#define OF_BAD_ADDR	((u64)-1)
-
-static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->pde = de;
-}
-
-extern struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name);
-#define for_each_node_by_name(dn, name) \
-	for (dn = of_find_node_by_name(NULL, name); dn; \
-	     dn = of_find_node_by_name(dn, name))
-extern struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type);
-#define for_each_node_by_type(dn, type) \
-	for (dn = of_find_node_by_type(NULL, type); dn; \
-	     dn = of_find_node_by_type(dn, type))
-extern struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compat);
-extern struct device_node *of_find_node_by_path(const char *path);
-extern struct device_node *of_find_node_by_phandle(phandle handle);
-extern struct device_node *of_get_parent(const struct device_node *node);
-extern struct device_node *of_get_next_child(const struct device_node *node,
-					     struct device_node *prev);
-extern struct property *of_find_property(const struct device_node *np,
-					 const char *name,
-					 int *lenp);
-extern int of_device_is_compatible(const struct device_node *device,
-				   const char *);
-extern const void *of_get_property(const struct device_node *node,
-				   const char *name,
-				   int *lenp);
-#define get_property(node,name,lenp) of_get_property(node,name,lenp)
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
 				 int def);
-extern int of_n_addr_cells(struct device_node *np);
-extern int of_n_size_cells(struct device_node *np);
 
 extern void prom_build_devicetree(void);
 
+/*
+ * NB:  This is here while we transition from using asm/prom.h
+ * to linux/of.h
+ */
+#include <linux/of.h>
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC_PROM_H */
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index b4df304..9905ed0 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -2,7 +2,6 @@
 #define _SPARC64_PROM_H
 #ifdef __KERNEL__
 
-
 /*
  * Definitions for talking to the Open Firmware PROM on
  * Power Macintosh computers.
@@ -17,7 +16,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <asm/atomic.h>
@@ -63,54 +61,22 @@ struct of_irq_controller {
 	void		*data;
 };
 
-/* flag descriptions */
-#define OF_DYNAMIC 1 /* node and properties were allocated via kmalloc */
-
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
-#define OF_BAD_ADDR	((u64)-1)
-
-static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_entry *de)
-{
-	dn->pde = de;
-}
-
-extern struct device_node *of_find_node_by_name(struct device_node *from,
-	const char *name);
-#define for_each_node_by_name(dn, name) \
-	for (dn = of_find_node_by_name(NULL, name); dn; \
-	     dn = of_find_node_by_name(dn, name))
-extern struct device_node *of_find_node_by_type(struct device_node *from,
-	const char *type);
-#define for_each_node_by_type(dn, type) \
-	for (dn = of_find_node_by_type(NULL, type); dn; \
-	     dn = of_find_node_by_type(dn, type))
-extern struct device_node *of_find_compatible_node(struct device_node *from,
-	const char *type, const char *compat);
-extern struct device_node *of_find_node_by_path(const char *path);
-extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_find_node_by_cpuid(int cpuid);
-extern struct device_node *of_get_parent(const struct device_node *node);
-extern struct device_node *of_get_next_child(const struct device_node *node,
-					     struct device_node *prev);
-extern struct property *of_find_property(const struct device_node *np,
-					 const char *name,
-					 int *lenp);
-extern int of_device_is_compatible(const struct device_node *device,
-				   const char *);
-extern const void *of_get_property(const struct device_node *node,
-			     const char *name,
-			     int *lenp);
-#define get_property(node,name,lenp) of_get_property(node,name,lenp)
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
 				 int def);
-extern int of_n_addr_cells(struct device_node *np);
-extern int of_n_size_cells(struct device_node *np);
 
 extern void prom_build_devicetree(void);
 
+/*
+ * NB:  This is here while we transition from using asm/prom.h
+ * to linux/of.h
+ */
+#include <linux/of.h>
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC64_PROM_H */
diff --git a/include/linux/of.h b/include/linux/of.h
new file mode 100644
index 0000000..47734ff
--- /dev/null
+++ b/include/linux/of.h
@@ -0,0 +1,61 @@
+#ifndef _LINUX_OF_H
+#define _LINUX_OF_H
+/*
+ * Definitions for talking to the Open Firmware PROM on
+ * Power Macintosh and other computers.
+ *
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
+ * Updates for SPARC64 by David S. Miller
+ * Derived from PowerPC and Sparc prom.h files by Stephen Rothwell, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/types.h>
+
+#include <asm/bitops.h>
+#include <asm/prom.h>
+
+/* flag descriptions */
+#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
+#define OF_DETACHED	2 /* node has been detached from the device tree */
+
+#define OF_BAD_ADDR	((u64)-1)
+
+extern struct device_node *of_find_node_by_name(struct device_node *from,
+	const char *name);
+#define for_each_node_by_name(dn, name) \
+	for (dn = of_find_node_by_name(NULL, name); dn; \
+	     dn = of_find_node_by_name(dn, name))
+extern struct device_node *of_find_node_by_type(struct device_node *from,
+	const char *type);
+#define for_each_node_by_type(dn, type) \
+	for (dn = of_find_node_by_type(NULL, type); dn; \
+	     dn = of_find_node_by_type(dn, type))
+extern struct device_node *of_find_compatible_node(struct device_node *from,
+	const char *type, const char *compat);
+#define for_each_compatible_node(dn, type, compatible) \
+	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
+	     dn = of_find_compatible_node(dn, type, compatible))
+extern struct device_node *of_find_node_by_path(const char *path);
+extern struct device_node *of_find_node_by_phandle(phandle handle);
+extern struct device_node *of_get_parent(const struct device_node *node);
+extern struct device_node *of_get_next_child(const struct device_node *node,
+					     struct device_node *prev);
+extern struct property *of_find_property(const struct device_node *np,
+					 const char *name,
+					 int *lenp);
+extern int of_device_is_compatible(const struct device_node *device,
+				   const char *);
+extern const void *of_get_property(const struct device_node *node,
+				const char *name,
+				int *lenp);
+#define get_property(a, b, c)	of_get_property((a), (b), (c))
+extern int of_n_addr_cells(struct device_node *np);
+extern int of_n_size_cells(struct device_node *np);
+
+#endif /* _LINUX_OF_H */
-- 
1.5.2.3

