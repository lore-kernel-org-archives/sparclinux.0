From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:46:38 +0000
Subject: [PATCH 07/11] of/flattree: Merge unflatten_dt_node
Message-Id: <20091105074631.10460.97676.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between PowerPC and MicroBlaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |  195 ----------------------------------------
 arch/powerpc/kernel/prom.c    |  194 ----------------------------------------
 drivers/of/fdt.c              |  200 +++++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h        |    4 +
 4 files changed, 204 insertions(+), 389 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index eb27bd3..021770a 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,201 +50,6 @@ typedef u32 cell_t;
 /* export that to outside world */
 struct device_node *of_chosen;
 
-static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
-					unsigned long align)
-{
-	void *res;
-
-	*mem = _ALIGN(*mem, align);
-	res = (void *)*mem;
-	*mem += size;
-
-	return res;
-}
-
-static unsigned long __init unflatten_dt_node(unsigned long mem,
-					unsigned long *p,
-					struct device_node *dad,
-					struct device_node ***allnextpp,
-					unsigned long fpsize)
-{
-	struct device_node *np;
-	struct property *pp, **prev_pp = NULL;
-	char *pathp;
-	u32 tag;
-	unsigned int l, allocl;
-	int has_name = 0;
-	int new_format = 0;
-
-	tag = *((u32 *)(*p));
-	if (tag != OF_DT_BEGIN_NODE) {
-		printk("Weird tag at start of node: %x\n", tag);
-		return mem;
-	}
-	*p += 4;
-	pathp = (char *)*p;
-	l = allocl = strlen(pathp) + 1;
-	*p = _ALIGN(*p + l, 4);
-
-	/* version 0x10 has a more compact unit name here instead of the full
-	 * path. we accumulate the full path size using "fpsize", we'll rebuild
-	 * it later. We detect this because the first character of the name is
-	 * not '/'.
-	 */
-	if ((*pathp) != '/') {
-		new_format = 1;
-		if (fpsize = 0) {
-			/* root node: special case. fpsize accounts for path
-			 * plus terminating zero. root node only has '/', so
-			 * fpsize should be 2, but we want to avoid the first
-			 * level nodes to have two '/' so we use fpsize 1 here
-			 */
-			fpsize = 1;
-			allocl = 2;
-		} else {
-			/* account for '/' and path size minus terminal 0
-			 * already in 'l'
-			 */
-			fpsize += l;
-			allocl = fpsize;
-		}
-	}
-
-	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
-				__alignof__(struct device_node));
-	if (allnextpp) {
-		memset(np, 0, sizeof(*np));
-		np->full_name = ((char *)np) + sizeof(struct device_node);
-		if (new_format) {
-			char *p2 = np->full_name;
-			/* rebuild full path for new format */
-			if (dad && dad->parent) {
-				strcpy(p2, dad->full_name);
-#ifdef DEBUG
-				if ((strlen(p2) + l + 1) != allocl) {
-					pr_debug("%s: p: %d, l: %d, a: %d\n",
-						pathp, (int)strlen(p2),
-						l, allocl);
-				}
-#endif
-				p2 += strlen(p2);
-			}
-			*(p2++) = '/';
-			memcpy(p2, pathp, l);
-		} else
-			memcpy(np->full_name, pathp, l);
-		prev_pp = &np->properties;
-		**allnextpp = np;
-		*allnextpp = &np->allnext;
-		if (dad != NULL) {
-			np->parent = dad;
-			/* we temporarily use the next field as `last_child'*/
-			if (dad->next = NULL)
-				dad->child = np;
-			else
-				dad->next->sibling = np;
-			dad->next = np;
-		}
-		kref_init(&np->kref);
-	}
-	while (1) {
-		u32 sz, noff;
-		char *pname;
-
-		tag = *((u32 *)(*p));
-		if (tag = OF_DT_NOP) {
-			*p += 4;
-			continue;
-		}
-		if (tag != OF_DT_PROP)
-			break;
-		*p += 4;
-		sz = *((u32 *)(*p));
-		noff = *((u32 *)((*p) + 4));
-		*p += 8;
-		if (initial_boot_params->version < 0x10)
-			*p = _ALIGN(*p, sz >= 8 ? 8 : 4);
-
-		pname = find_flat_dt_string(noff);
-		if (pname = NULL) {
-			printk(KERN_INFO
-				"Can't find property name in list !\n");
-			break;
-		}
-		if (strcmp(pname, "name") = 0)
-			has_name = 1;
-		l = strlen(pname) + 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
-					__alignof__(struct property));
-		if (allnextpp) {
-			if (strcmp(pname, "linux,phandle") = 0) {
-				np->node = *((u32 *)*p);
-				if (np->linux_phandle = 0)
-					np->linux_phandle = np->node;
-			}
-			if (strcmp(pname, "ibm,phandle") = 0)
-				np->linux_phandle = *((u32 *)*p);
-			pp->name = pname;
-			pp->length = sz;
-			pp->value = (void *)*p;
-			*prev_pp = pp;
-			prev_pp = &pp->next;
-		}
-		*p = _ALIGN((*p) + sz, 4);
-	}
-	/* with version 0x10 we may not have the name property, recreate
-	 * it here from the unit name if absent
-	 */
-	if (!has_name) {
-		char *p1 = pathp, *ps = pathp, *pa = NULL;
-		int sz;
-
-		while (*p1) {
-			if ((*p1) = '@')
-				pa = p1;
-			if ((*p1) = '/')
-				ps = p1 + 1;
-			p1++;
-		}
-		if (pa < ps)
-			pa = p1;
-		sz = (pa - ps) + 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
-					__alignof__(struct property));
-		if (allnextpp) {
-			pp->name = "name";
-			pp->length = sz;
-			pp->value = pp + 1;
-			*prev_pp = pp;
-			prev_pp = &pp->next;
-			memcpy(pp->value, ps, sz - 1);
-			((char *)pp->value)[sz - 1] = 0;
-			pr_debug("fixed up name for %s -> %s\n", pathp,
-				(char *)pp->value);
-		}
-	}
-	if (allnextpp) {
-		*prev_pp = NULL;
-		np->name = of_get_property(np, "name", NULL);
-		np->type = of_get_property(np, "device_type", NULL);
-
-		if (!np->name)
-			np->name = "<NULL>";
-		if (!np->type)
-			np->type = "<NULL>";
-	}
-	while (tag = OF_DT_BEGIN_NODE) {
-		mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
-		tag = *((u32 *)(*p));
-	}
-	if (tag != OF_DT_END_NODE) {
-		printk(KERN_INFO "Weird tag at end of node: %x\n", tag);
-		return mem;
-	}
-	*p += 4;
-	return mem;
-}
-
 /**
  * unflattens the device-tree passed by the firmware, creating the
  * tree of struct device_node. It also fills the "name" and "type"
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 413e608..a102a0a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -80,200 +80,6 @@ extern rwlock_t devtree_lock;	/* temporary while merging */
 /* export that to outside world */
 struct device_node *of_chosen;
 
-static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
-				       unsigned long align)
-{
-	void *res;
-
-	*mem = _ALIGN(*mem, align);
-	res = (void *)*mem;
-	*mem += size;
-
-	return res;
-}
-
-static unsigned long __init unflatten_dt_node(unsigned long mem,
-					      unsigned long *p,
-					      struct device_node *dad,
-					      struct device_node ***allnextpp,
-					      unsigned long fpsize)
-{
-	struct device_node *np;
-	struct property *pp, **prev_pp = NULL;
-	char *pathp;
-	u32 tag;
-	unsigned int l, allocl;
-	int has_name = 0;
-	int new_format = 0;
-
-	tag = *((u32 *)(*p));
-	if (tag != OF_DT_BEGIN_NODE) {
-		printk("Weird tag at start of node: %x\n", tag);
-		return mem;
-	}
-	*p += 4;
-	pathp = (char *)*p;
-	l = allocl = strlen(pathp) + 1;
-	*p = _ALIGN(*p + l, 4);
-
-	/* version 0x10 has a more compact unit name here instead of the full
-	 * path. we accumulate the full path size using "fpsize", we'll rebuild
-	 * it later. We detect this because the first character of the name is
-	 * not '/'.
-	 */
-	if ((*pathp) != '/') {
-		new_format = 1;
-		if (fpsize = 0) {
-			/* root node: special case. fpsize accounts for path
-			 * plus terminating zero. root node only has '/', so
-			 * fpsize should be 2, but we want to avoid the first
-			 * level nodes to have two '/' so we use fpsize 1 here
-			 */
-			fpsize = 1;
-			allocl = 2;
-		} else {
-			/* account for '/' and path size minus terminal 0
-			 * already in 'l'
-			 */
-			fpsize += l;
-			allocl = fpsize;
-		}
-	}
-
-
-	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
-				__alignof__(struct device_node));
-	if (allnextpp) {
-		memset(np, 0, sizeof(*np));
-		np->full_name = ((char*)np) + sizeof(struct device_node);
-		if (new_format) {
-			char *p = np->full_name;
-			/* rebuild full path for new format */
-			if (dad && dad->parent) {
-				strcpy(p, dad->full_name);
-#ifdef DEBUG
-				if ((strlen(p) + l + 1) != allocl) {
-					DBG("%s: p: %d, l: %d, a: %d\n",
-					    pathp, (int)strlen(p), l, allocl);
-				}
-#endif
-				p += strlen(p);
-			}
-			*(p++) = '/';
-			memcpy(p, pathp, l);
-		} else
-			memcpy(np->full_name, pathp, l);
-		prev_pp = &np->properties;
-		**allnextpp = np;
-		*allnextpp = &np->allnext;
-		if (dad != NULL) {
-			np->parent = dad;
-			/* we temporarily use the next field as `last_child'*/
-			if (dad->next = 0)
-				dad->child = np;
-			else
-				dad->next->sibling = np;
-			dad->next = np;
-		}
-		kref_init(&np->kref);
-	}
-	while(1) {
-		u32 sz, noff;
-		char *pname;
-
-		tag = *((u32 *)(*p));
-		if (tag = OF_DT_NOP) {
-			*p += 4;
-			continue;
-		}
-		if (tag != OF_DT_PROP)
-			break;
-		*p += 4;
-		sz = *((u32 *)(*p));
-		noff = *((u32 *)((*p) + 4));
-		*p += 8;
-		if (initial_boot_params->version < 0x10)
-			*p = _ALIGN(*p, sz >= 8 ? 8 : 4);
-
-		pname = find_flat_dt_string(noff);
-		if (pname = NULL) {
-			printk("Can't find property name in list !\n");
-			break;
-		}
-		if (strcmp(pname, "name") = 0)
-			has_name = 1;
-		l = strlen(pname) + 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
-					__alignof__(struct property));
-		if (allnextpp) {
-			if (strcmp(pname, "linux,phandle") = 0) {
-				np->node = *((u32 *)*p);
-				if (np->linux_phandle = 0)
-					np->linux_phandle = np->node;
-			}
-			if (strcmp(pname, "ibm,phandle") = 0)
-				np->linux_phandle = *((u32 *)*p);
-			pp->name = pname;
-			pp->length = sz;
-			pp->value = (void *)*p;
-			*prev_pp = pp;
-			prev_pp = &pp->next;
-		}
-		*p = _ALIGN((*p) + sz, 4);
-	}
-	/* with version 0x10 we may not have the name property, recreate
-	 * it here from the unit name if absent
-	 */
-	if (!has_name) {
-		char *p = pathp, *ps = pathp, *pa = NULL;
-		int sz;
-
-		while (*p) {
-			if ((*p) = '@')
-				pa = p;
-			if ((*p) = '/')
-				ps = p + 1;
-			p++;
-		}
-		if (pa < ps)
-			pa = p;
-		sz = (pa - ps) + 1;
-		pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
-					__alignof__(struct property));
-		if (allnextpp) {
-			pp->name = "name";
-			pp->length = sz;
-			pp->value = pp + 1;
-			*prev_pp = pp;
-			prev_pp = &pp->next;
-			memcpy(pp->value, ps, sz - 1);
-			((char *)pp->value)[sz - 1] = 0;
-			DBG("fixed up name for %s -> %s\n", pathp,
-				(char *)pp->value);
-		}
-	}
-	if (allnextpp) {
-		*prev_pp = NULL;
-		np->name = of_get_property(np, "name", NULL);
-		np->type = of_get_property(np, "device_type", NULL);
-
-		if (!np->name)
-			np->name = "<NULL>";
-		if (!np->type)
-			np->type = "<NULL>";
-	}
-	while (tag = OF_DT_BEGIN_NODE) {
-		mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
-		tag = *((u32 *)(*p));
-	}
-	if (tag != OF_DT_END_NODE) {
-		printk("Weird tag at end of node: %x\n", tag);
-		return mem;
-	}
-	*p += 4;
-	return mem;
-}
-
 static int __init early_parse_mem(char *p)
 {
 	if (!p)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 01a7f5f..df1ac8d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -167,3 +167,203 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 	return 0;
 }
 
+static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long size,
+				       unsigned long align)
+{
+	void *res;
+
+	*mem = _ALIGN(*mem, align);
+	res = (void *)*mem;
+	*mem += size;
+
+	return res;
+}
+
+/**
+ * unflatten_dt_node - Alloc and populate a device_node from the flat tree
+ * @p: pointer to node in flat tree
+ * @dad: Parent struct device_node
+ * @allnextpp: pointer to ->allnext from last allocated device_node
+ * @fpsize: Size of the node path up at the current depth.
+ */
+unsigned long __init unflatten_dt_node(unsigned long mem,
+					unsigned long *p,
+					struct device_node *dad,
+					struct device_node ***allnextpp,
+					unsigned long fpsize)
+{
+	struct device_node *np;
+	struct property *pp, **prev_pp = NULL;
+	char *pathp;
+	u32 tag;
+	unsigned int l, allocl;
+	int has_name = 0;
+	int new_format = 0;
+
+	tag = *((u32 *)(*p));
+	if (tag != OF_DT_BEGIN_NODE) {
+		printk("Weird tag at start of node: %x\n", tag);
+		return mem;
+	}
+	*p += 4;
+	pathp = (char *)*p;
+	l = allocl = strlen(pathp) + 1;
+	*p = _ALIGN(*p + l, 4);
+
+	/* version 0x10 has a more compact unit name here instead of the full
+	 * path. we accumulate the full path size using "fpsize", we'll rebuild
+	 * it later. We detect this because the first character of the name is
+	 * not '/'.
+	 */
+	if ((*pathp) != '/') {
+		new_format = 1;
+		if (fpsize = 0) {
+			/* root node: special case. fpsize accounts for path
+			 * plus terminating zero. root node only has '/', so
+			 * fpsize should be 2, but we want to avoid the first
+			 * level nodes to have two '/' so we use fpsize 1 here
+			 */
+			fpsize = 1;
+			allocl = 2;
+		} else {
+			/* account for '/' and path size minus terminal 0
+			 * already in 'l'
+			 */
+			fpsize += l;
+			allocl = fpsize;
+		}
+	}
+
+	np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
+				__alignof__(struct device_node));
+	if (allnextpp) {
+		memset(np, 0, sizeof(*np));
+		np->full_name = ((char *)np) + sizeof(struct device_node);
+		if (new_format) {
+			char *fn = np->full_name;
+			/* rebuild full path for new format */
+			if (dad && dad->parent) {
+				strcpy(fn, dad->full_name);
+#ifdef DEBUG
+				if ((strlen(fn) + l + 1) != allocl) {
+					pr_debug("%s: p: %d, l: %d, a: %d\n",
+						pathp, (int)strlen(fn),
+						l, allocl);
+				}
+#endif
+				fn += strlen(fn);
+			}
+			*(fn++) = '/';
+			memcpy(fn, pathp, l);
+		} else
+			memcpy(np->full_name, pathp, l);
+		prev_pp = &np->properties;
+		**allnextpp = np;
+		*allnextpp = &np->allnext;
+		if (dad != NULL) {
+			np->parent = dad;
+			/* we temporarily use the next field as `last_child'*/
+			if (dad->next = NULL)
+				dad->child = np;
+			else
+				dad->next->sibling = np;
+			dad->next = np;
+		}
+		kref_init(&np->kref);
+	}
+	while (1) {
+		u32 sz, noff;
+		char *pname;
+
+		tag = *((u32 *)(*p));
+		if (tag = OF_DT_NOP) {
+			*p += 4;
+			continue;
+		}
+		if (tag != OF_DT_PROP)
+			break;
+		*p += 4;
+		sz = *((u32 *)(*p));
+		noff = *((u32 *)((*p) + 4));
+		*p += 8;
+		if (initial_boot_params->version < 0x10)
+			*p = _ALIGN(*p, sz >= 8 ? 8 : 4);
+
+		pname = find_flat_dt_string(noff);
+		if (pname = NULL) {
+			pr_info("Can't find property name in list !\n");
+			break;
+		}
+		if (strcmp(pname, "name") = 0)
+			has_name = 1;
+		l = strlen(pname) + 1;
+		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
+					__alignof__(struct property));
+		if (allnextpp) {
+			if (strcmp(pname, "linux,phandle") = 0) {
+				np->node = *((u32 *)*p);
+				if (np->linux_phandle = 0)
+					np->linux_phandle = np->node;
+			}
+			if (strcmp(pname, "ibm,phandle") = 0)
+				np->linux_phandle = *((u32 *)*p);
+			pp->name = pname;
+			pp->length = sz;
+			pp->value = (void *)*p;
+			*prev_pp = pp;
+			prev_pp = &pp->next;
+		}
+		*p = _ALIGN((*p) + sz, 4);
+	}
+	/* with version 0x10 we may not have the name property, recreate
+	 * it here from the unit name if absent
+	 */
+	if (!has_name) {
+		char *p1 = pathp, *ps = pathp, *pa = NULL;
+		int sz;
+
+		while (*p1) {
+			if ((*p1) = '@')
+				pa = p1;
+			if ((*p1) = '/')
+				ps = p1 + 1;
+			p1++;
+		}
+		if (pa < ps)
+			pa = p1;
+		sz = (pa - ps) + 1;
+		pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
+					__alignof__(struct property));
+		if (allnextpp) {
+			pp->name = "name";
+			pp->length = sz;
+			pp->value = pp + 1;
+			*prev_pp = pp;
+			prev_pp = &pp->next;
+			memcpy(pp->value, ps, sz - 1);
+			((char *)pp->value)[sz - 1] = 0;
+			pr_debug("fixed up name for %s -> %s\n", pathp,
+				(char *)pp->value);
+		}
+	}
+	if (allnextpp) {
+		*prev_pp = NULL;
+		np->name = of_get_property(np, "name", NULL);
+		np->type = of_get_property(np, "device_type", NULL);
+
+		if (!np->name)
+			np->name = "<NULL>";
+		if (!np->type)
+			np->type = "<NULL>";
+	}
+	while (tag = OF_DT_BEGIN_NODE) {
+		mem = unflatten_dt_node(mem, p, np, allnextpp, fpsize);
+		tag = *((u32 *)(*p));
+	}
+	if (tag != OF_DT_END_NODE) {
+		printk("Weird tag at end of node: %x\n", tag);
+		return mem;
+	}
+	*p += 4;
+	return mem;
+}
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 81231e0..ace9068 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -69,6 +69,10 @@ extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
+extern unsigned long unflatten_dt_node(unsigned long mem, unsigned long *p,
+					struct device_node *dad,
+					struct device_node ***allnextpp,
+					unsigned long fpsize);
 
 /* Other Prototypes */
 extern void finish_device_tree(void);

