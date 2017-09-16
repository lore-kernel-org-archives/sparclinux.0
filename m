From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Sat, 16 Sep 2017 04:46:08 +0000
Subject: [PATCH] Expose mdesc to sysfs
Message-Id: <62f2be29-f0e7-98f0-6104-714a8fa2ea1e@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

To get a snapshot as complete as possible of what the system is composed of,
this commit adds the ability to browse machine description from sysfs.

This commit eases porting of user-space utilities that exist on other 
architectures
like lshw for instance.

Whenever the HV changes machine description content, sysfs will be 
autopmatically
re-populated. This is done almost atomically by swapping the old mdesc 
sysfs folder
with the new one. While the tree under the new folder is being created, 
reading from
/sys/firmware/mdesc will return EAGAIN. That way userspace programs will 
not see
stale content in /sys/firmware/mdesc

Signed-off-by: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Reviewed-by: Dave Aldridge <david.j.aldridge@oracle.com>

---
  arch/sparc/Kconfig              |    8 +
  arch/sparc/kernel/Makefile      |    2 +
  arch/sparc/kernel/mdesc.c       |    7 +
  arch/sparc/kernel/mdesc_sysfs.c |  830 
+++++++++++++++++++++++++++++++++++++++
  4 files changed, 847 insertions(+), 0 deletions(-)
  create mode 100644 arch/sparc/kernel/mdesc_sysfs.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cac67aa..5ecdebf 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -508,6 +508,14 @@ config UBOOT_ENTRY_ADDR
  endmenu
  endif

+config MDESC_SYSFS
+    bool "Maps machine description to sysfs"
+    depends on SPARC64
+    default y
+    ---help---
+      If you say Y here, the directed acyclic graph described in the 
machine
+      description will be expanded and made available in 
/sys/firmware/mdesc
+
  endmenu

  menu "Bus options (PCI etc.)"
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 5e6463d..213179e 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -122,6 +122,8 @@ obj-$(CONFIG_SPARC64)    += $(pc--y)

  obj-$(CONFIG_UPROBES)    += uprobes.o

+obj-$(CONFIG_MDESC_SYSFS) += mdesc_sysfs.o
+
  obj-$(CONFIG_SPARC64)    += jump_label.o

  obj-$(CONFIG_SPARC64)    += kexec_shim.o
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 1fbf6ff..2e999fe 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -92,6 +92,10 @@ struct md_node_ops {
      mdesc_node_match_f node_match;
  };

+#ifdef MDESC_SYSFS
+int mdesc_sysfs_populate(void);
+#endif
+
  static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
      union md_node_info *node_info);
  static bool vdev_port_node_match(union md_node_info *a_node_info,
@@ -506,6 +510,9 @@ void mdesc_update(void)
          cur_mdesc = hp;
          spin_unlock_irqrestore(&mdesc_lock, flags);

+#ifdef MDESC_SYSFS
+        mdesc_sysfs_populate();
+#endif
          mdesc_notify_clients(orig_hp, hp);

          spin_lock_irqsave(&mdesc_lock, flags);
diff --git a/arch/sparc/kernel/mdesc_sysfs.c 
b/arch/sparc/kernel/mdesc_sysfs.c
new file mode 100644
index 0000000..6fb8713
--- /dev/null
+++ b/arch/sparc/kernel/mdesc_sysfs.c
@@ -0,0 +1,830 @@
+/*
+ * mdesc_sysfs.c - Maps machine description DAG to sysfs
+ *
+ * Copyright (c) 2016 Oracle and/or its affiliates. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ * USA.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/mdesc.h>
+
+#define MDESC_SYSFS_TOO_LARGE "Error: Not enough space to output the 
data, retrieve it from /dev/mdesc instead."
+
+/*
+ * Machine Description is described in slides 37-39 here:
+ * 
http://www.oracle.com/technetwork/systems/opensparc/2008-oct-opensparc-slide-cast-09-mw-1539018.html
+ *
+ * It is composed of three main sections decribed by the following 
mdesc header.
+ * Since these blocks are contiguous, describing their size is 
sufficient to
+ * precisely locate them within the mdesc blob.
+ *
+ * - The NODE block contains the nodes of the directed acyclic graph (DAG)
+ * - The NAME block contains names of properties referred to by the DAG 
nodes
+ * - The DATA block contains values for the properties: strings and 
binary data
+ *
+ * A public specification of mdesc is available online at:
+ * https://kenai.com/downloads/hypervisor/hypervisor-api-3.0draft7.pdf
+ */
+struct mdesc_hdr {
+    u32    version; /* Transport version */
+    u32    node_sz; /* node block size */
+    u32    name_sz; /* name block size */
+    u32    data_sz; /* data block size */
+} __aligned(16)__;
+
+struct mdesc_elem {
+    u8    tag;
+#define MD_LIST_END    0x00
+#define MD_NODE        0x4e
+#define MD_NODE_END    0x45
+#define MD_NOOP        0x20
+#define MD_PROP_ARC    0x61
+#define MD_PROP_VAL    0x76
+#define MD_PROP_STR    0x73
+#define MD_PROP_DATA    0x64
+    u8    name_len;
+    u16    resv;
+    u32    name_offset;
+    union {
+        struct {
+            u32    data_len;
+            u32    data_offset;
+        } data;
+        u64    val;
+    } d;
+};
+
+struct mdesc_mem_ops {
+    struct mdesc_handle *(*alloc)(unsigned int mdesc_size);
+    void (*free)(struct mdesc_handle *handle);
+};
+
+struct mdesc_handle {
+    struct list_head     list;
+    struct mdesc_mem_ops *mops;
+    void                 *self_base;
+    atomic_t             refcnt;
+    unsigned int         handle_size;
+    struct mdesc_hdr     mdesc;
+};
+
+/*
+ * The following 3 functions return a pointer of the right type to the
+ * 3 main mdesc blocks
+ */
+
+static inline struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
+{
+    return (struct mdesc_elem *) (mdesc + 1);
+}
+
+static inline void *name_block(struct mdesc_hdr *mdesc)
+{
+    return ((void *) node_block(mdesc)) + mdesc->node_sz;
+}
+
+static inline void *data_block(struct mdesc_hdr *mdesc)
+{
+    return ((void *) name_block(mdesc)) + mdesc->name_sz;
+}
+
+/*
+ * Dynamically allocates the right amount of characters to format according
+ * to the printf-like format specified in "fmt".
+ * "*buf" is allocated and filled.
+ *
+ * Return 0 upon success
+ */
+static int alloc_sprintf(char **buf, const char *fmt, ...)
+{
+    va_list args;
+    size_t len, actual;
+
+    va_start(args, fmt);
+    len = vsnprintf(NULL, 0, fmt, args);
+    va_end(args);
+
+    *buf = kmalloc(len+1, GFP_KERNEL);
+    if (!*buf)
+        return -ENOMEM;
+
+    va_start(args, fmt);
+    actual = vscnprintf(*buf, len + 1, fmt, args);
+    va_end(args);
+
+    if (actual != len) {
+        kfree(*buf);
+        *buf = NULL;
+        return -ENOMEM;
+    }
+
+    return 0;
+}
+
+/*
+ * Flags used with the following formatting functions that modify the way
+ * node names are formatted
+ */
+#define FORMAT_APPEND    0x01
+#define FORMAT_USE_INDEX 0x02
+
+/*
+ * Take an arc node in "ep" and format it using the "id" field as to avoid
+ * collision when adding to sysfs.
+ * Ex: multiple "cpu" nodes in the same folder will be named: "0", "1"...
+ *
+ * When FORMAT_APPEND is used, the names will become: "cpu0", "cpu1"...
+ * The formatted string is found in *formatted, to be freed by the caller
+ *
+ * Return 0 upon success
+ */
+static int format_using_id(struct mdesc_handle *hp,
+               struct mdesc_elem *ep,
+               char const *name,
+               char **formatted,
+               unsigned int flags,
+               unsigned int index,
+               unsigned int total)
+{
+    const u64 *prop_id = mdesc_get_property(hp, ep->d.val, "id", NULL);
+
+    if (!prop_id) {
+        pr_err("mdesc %s doesn't have a property \"id\"\n", name);
+        return -ENOENT;
+    }
+
+    if (flags & FORMAT_APPEND)
+        return alloc_sprintf(formatted, "%s%lld", name, *prop_id);
+
+    return alloc_sprintf(formatted, "%lld", *prop_id);
+}
+
+/*
+ * Take an arc node in "ep" and format it using the "name" field as to 
avoid
+ * collision when adding to sysfs.
+ * Ex: multiple "virtual-device" nodes in the same folder will be named:
+ * "disk", "network"...
+ *
+ * When FORMAT_APPEND is used: "virtual-device-disk", 
virtual-device-network"...
+ *
+ * Because the "name" field is not guaranteed to be unique, one can use the
+ * flag FORMAT_USE_INDEX: "virtual-device0-disk", 
virtual-device1-network"...
+ * In this case "index" is used.
+ *
+ * The formatted string is found in *formatted, to be freed by the caller
+ *
+ * Return 0 upon success
+ */
+static int format_using_name(struct mdesc_handle *hp,
+                 struct mdesc_elem *ep,
+                 const char *name,
+                 char **formatted,
+                 unsigned int flags,
+                 unsigned int index,
+                 unsigned int total)
+{
+    const char *prop_name = mdesc_get_property(hp, ep->d.val, "name", 
NULL);
+
+    if (!prop_name) {
+        pr_err("mdesc %s doesn't have a property \"name\"\n", name);
+        return -ENOENT;
+    }
+
+    if (flags & FORMAT_APPEND) {
+        if (flags & FORMAT_USE_INDEX)
+            return alloc_sprintf(formatted, "%s%d_%s",
+                         name, index, prop_name);
+        else
+            return alloc_sprintf(formatted, "%s_%s",
+                         name, prop_name);
+    }
+
+    if (flags & FORMAT_USE_INDEX)
+        return alloc_sprintf(formatted, "%s%d", prop_name, index);
+    else
+        return alloc_sprintf(formatted, "%s", prop_name);
+}
+
+/*
+ * Default formatting used in format_name() for arcs nodes.
+ * Called when we find multiple arcs with the same name for which no
+ * formatting is specified in format_nodes array.
+ * This default formatting guarantees uniqueness because it is using 
the node
+ * index in the mdesc nodes array
+ */
+static char *format_name_fallback(struct mdesc_handle *hp,
+                  struct mdesc_elem *ep,
+                  const char *name,
+                  unsigned int    index,
+                  unsigned int    total)
+{
+    char *formatted = NULL;
+    int err;
+
+    err = alloc_sprintf(&formatted, "%s_0x%x", name, ep->d.val);
+    return err ? NULL : formatted;
+}
+
+struct format_node {
+    char    *name;
+    int    (*format)(struct mdesc_handle*, struct mdesc_elem*, const char*,
+            char**, unsigned int, unsigned int, unsigned int);
+    unsigned int flags;
+};
+
+struct format_node format_nodes[] = {
+#define FORMAT_APPEND_USE_INDEX (FORMAT_APPEND | FORMAT_USE_INDEX)
+    { "virtual-device",       format_using_name, FORMAT_APPEND_USE_INDEX },
+    { "domain-services-port", format_using_id,   FORMAT_APPEND },
+    { "virtual-device-port",  format_using_id,   FORMAT_APPEND },
+    { "channel-endpoint",     format_using_id,   FORMAT_APPEND },
+    { "cpu",                  format_using_id,   FORMAT_APPEND },
+    { NULL, NULL, 0 }
+};
+
+/*
+ * Format the name of an arc node according to the table "format_nodes".
+ * If no entry is found for the arc node in "ep", it falls back to using
+ * format_name_fallback()
+ * Returns the formatted string, to be freed by the caller
+ */
+static char *format_name(struct mdesc_handle *hp,
+             struct mdesc_elem *ep,
+             const char *name,
+             int    index,
+             int    total)
+{
+    struct format_node *fn;
+    char   *formatted = NULL;
+    bool   found = false;
+    int    err = 0;
+
+    for (fn = format_nodes; fn->name; fn++) {
+        if (strcmp(fn->name, name))
+            continue;
+        err = fn->format(hp, ep, name, &formatted,
+                 fn->flags, index, total);
+        found = true;
+        break;
+    }
+
+    if (!found && (total != 1)) {
+        /*
+         * there's no handler for this node and we've got more
+         * than one so we format it by appending the index
+         * (by order of appearance)
+         */
+        err = alloc_sprintf(&formatted, "%s%lld", name, index);
+    }
+
+    if (err)
+        return format_name_fallback(hp, ep, name, index, total);
+
+    return formatted;
+}
+
+/*
+ * Takes an arc node in "ep" and create a folder in sysfs with the name as
+ * provided by format_name() which uses the format_nodes array as input
+ * "total" is the number of arcs nodes with the same type (ex: cpu)
+ * "index" is the occurrence number of the arc node (ex: cpu number 32)
+ * Fills *kobj with the kobject
+ * Return 0 upon success
+ */
+static int create_sysfs_folder(struct mdesc_handle *hp,
+                   struct mdesc_elem *ep,
+                   const char *name,
+                   struct kobject **kobj,
+                   struct kobject *parent_kobj,
+                   unsigned int index,
+                   unsigned int total)
+{
+    char *formatted;
+    int  err = 0;
+
+    formatted = format_name(hp, ep, name, index, total);
+    if (!formatted)
+        formatted = (char *) name;
+
+    *kobj = kobject_create_and_add(formatted, parent_kobj);
+
+    err = (*kobj = NULL) ? -ENOMEM : 0;
+    if (err)
+        pr_err("mdesc_sysfs: unable to create sysfs entry for \"%s\"\n",
+               name);
+
+    if (formatted != name)
+        kfree(formatted);
+
+    return err;
+}
+
+/*
+ * Similar to create_sysfs_folder() except that because the node in "ep"
+ * already exist elsewhere in sysfs, a link is created instead.
+ * Return 0 upon success
+ */
+static int create_sysfs_link(struct mdesc_handle *hp,
+                 struct mdesc_elem *ep,
+                 const char *name,
+                 struct kobject *target_kobj,
+                 struct kobject *parent_kobj,
+                 unsigned int index,
+                 unsigned int total)
+{
+    char *formatted;
+    int  err = 0;
+
+    formatted = format_name(hp, ep, name, index, total);
+    if (!formatted)
+        formatted = (char *) name;
+
+    err = sysfs_create_link(parent_kobj, target_kobj, formatted);
+    if (err)
+        pr_err("mdesc_sysfs: unable to create sysfs link for \"%s\"\n",
+               name);
+
+    if (formatted != name)
+        kfree(formatted);
+
+    return err;
+}
+
+struct mdesc_arcs {
+    struct list_head list;
+    const char *name;
+    unsigned int count;
+};
+
+/*
+ * Take a node in "ep" and build a linked list of mdesc_arcs elements.
+ * Each element contains a name and how many occurrences exists in "ep".
+ * Return 0 upon success
+ */
+static int sysfs_populate_build_arcs_list(struct mdesc_handle *hp,
+                      struct mdesc_elem *ep,
+                      struct mdesc_arcs *arcs_list)
+{
+    struct mdesc_elem *base = node_block(&hp->mdesc);
+    const char *names = name_block(&hp->mdesc);
+
+    for (ep++; ep->tag != MD_NODE_END; ep++) {
+        const char *arc_name;
+        struct mdesc_arcs *p;
+
+        /* We only care of the forward arcs of the DAG */
+        if (ep->tag != MD_PROP_ARC ||
+                strcmp(names + ep->name_offset, "fwd"))
+            continue;
+
+        arc_name = names + (base + ep->d.val)->name_offset;
+        list_for_each_entry(p, &arcs_list->list, list) {
+            if (!strcmp(p->name, arc_name))
+                break;
+        }
+        /* Have we found arc_name in the list? */
+        if (p = arcs_list) {
+            /* no, we add it to the list */
+            p = kzalloc(sizeof(struct mdesc_arcs), GFP_KERNEL);
+            if (p = NULL) {
+                struct list_head *pos, *q;
+
+                /* An error occured: free the whole list */
+                list_for_each_safe(pos, q, &arcs_list->list) {
+                    p = list_entry(pos, struct mdesc_arcs,
+                            list);
+                    list_del(pos);
+                    kfree(p);
+                }
+                return -ENOMEM;
+            }
+            p->name = arc_name;
+            /* add tail allows to keep mdesc's order */
+            list_add_tail(&p->list, &arcs_list->list);
+        }
+        /* increment the occurrence for this arc */
+        p->count++;
+    }
+    return 0;
+}
+
+struct sysfs_property {
+    struct kobj_attribute kattr;
+    char *value;
+    unsigned int length;
+};
+
+static bool updating;
+
+static ssize_t mdesc_sysfs_show(struct kobject *object,
+                struct kobj_attribute *attr,
+                char *buf)
+{
+    struct sysfs_property *prop;
+
+    if (updating)
+        return -EAGAIN; /* This version is stale */
+
+    prop = container_of(attr, struct sysfs_property, kattr);
+    if (prop->length <= PAGE_SIZE) {
+        memcpy(buf, prop->value, prop->length);
+        return prop->length;
+    }
+    return sprintf(buf, "%s\n", MDESC_SYSFS_TOO_LARGE);
+}
+
+/*
+ * Append a property to the list that will be later
+ * passed to sysfs_create_files()
+ * "attributes" is a pointer to an array of "struct attribute*"
+ */
+static int add_property(struct sysfs_property *prop,
+            struct attribute ***attributes,
+            int *length,
+            int *size)
+{
+    if (*size <= (*length + 1)) {
+        struct attribute **p;
+
+        *size += 16; /* pre-allocation to relieve the allocator */
+        p = krealloc(*attributes, *size * sizeof(struct attribute *),
+                GFP_KERNEL);
+        if (!p)
+            return -ENOMEM;
+
+        *attributes = p;
+    }
+    (*attributes)[(*length)++] = &prop->kattr.attr;
+    /* the array must be NULL terminated */
+    (*attributes)[*length] = NULL;
+    return 0;
+}
+
+/*
+ * Given an arc node in "ep", loop through its entries and create
+ * a list of attributes suitable for sysfs_create_files()
+ * the entries should be be unique within "ep" but there are versions
+ * where entries are duplicated, so we only add them once to the list
+ */
+static int mdesc_sysfs_add_propeties(struct mdesc_handle *hp,
+                     struct mdesc_elem *ep,
+                     struct kobject *parent_kobj)
+{
+    const char *names = name_block(&hp->mdesc);
+    void *data = data_block(&hp->mdesc);
+    struct attribute **sysfs_attributes = NULL;
+    int sysfs_attributes_length = 0;
+    int sysfs_attributes_size = 0;
+    int err;
+
+    for (ep++; ep->tag != MD_NODE_END; ep++) {
+        struct sysfs_property *prop;
+        char *s = NULL;
+        size_t len = 0;
+        bool valid = false;
+
+        switch (ep->tag) {
+        case MD_PROP_VAL:
+            err = alloc_sprintf(&s, "%lld\n", ep->d.val);
+            if (err)
+                return -ENOMEM;
+            len = strlen(s);
+            valid = true;
+            break;
+        case MD_PROP_STR:
+            s = kstrndup(data + ep->d.data.data_offset,
+                     ep->d.data.data_len, GFP_KERNEL);
+            s = kmalloc(ep->d.data.data_len+1, GFP_KERNEL);
+            if (s = NULL)
+                return -ENOMEM;
+            memcpy(s, data + ep->d.data.data_offset,
+                   ep->d.data.data_len-1);
+            s[ep->d.data.data_len-1] = '\n';
+            s[ep->d.data.data_len] = '\0';
+            len = ep->d.data.data_len;
+            valid = true;
+            break;
+        case MD_PROP_DATA:
+            s = kmalloc(ep->d.data.data_len, GFP_KERNEL);
+            if (s = NULL)
+                return -ENOMEM;
+            memcpy(s, data + ep->d.data.data_offset,
+                    ep->d.data.data_len);
+            len = ep->d.data.data_len;
+            valid = true;
+            break;
+        default:
+            break;
+        }
+
+        prop = kmalloc(sizeof(*prop), GFP_KERNEL);
+        if (!prop) {
+            kfree(s);
+            kfree(sysfs_attributes);
+            return -ENOMEM;
+        }
+
+        if (valid) {
+            const char *c_name = names + ep->name_offset;
+            char *name;
+            int i;
+            bool found = false;
+
+            /*
+             * Check if a property with the same name
+             * has already been added
+             */
+            for (i = 0; i < sysfs_attributes_length; i++) {
+                struct sysfs_property *prop;
+
+                prop = container_of(sysfs_attributes[i],
+                            struct sysfs_property,
+                            kattr.attr);
+                if (!strcmp(prop->kattr.attr.name, c_name)) {
+                    found = true;
+                    break;
+                }
+            }
+            if (found) {
+                pr_info("mdesc_sysfs: duplicate property found\n");
+                continue;
+            }
+
+            name = kstrdup(c_name, GFP_KERNEL);
+            if (!name) {
+                kfree(s);
+                kfree(sysfs_attributes);
+                return -ENOMEM;
+            }
+
+            /* Set the name */
+            prop->kattr.attr.name = name;
+            prop->kattr.attr.mode = S_IRUSR;
+            prop->kattr.show = mdesc_sysfs_show;
+            prop->kattr.store = NULL;
+            prop->value = s;
+            prop->length = len;
+
+            /* Add to the (automatically growing) array */
+            add_property(prop, &sysfs_attributes,
+                     &sysfs_attributes_length,
+                     &sysfs_attributes_size);
+        }
+    }
+
+    if (sysfs_attributes) {
+        int err;
+        const struct attribute **pattr = (const struct attribute **)
+                         sysfs_attributes;
+
+        err = sysfs_create_files(parent_kobj, pattr);
+        if (err)
+            pr_err("mdesc_sysfs: unable to create sysfs properties\n");
+
+        /*
+         * Free the array of attributes, but not the individual elements
+         * because each element points to a "struct sysfs_property" that
+         * mdesc_sysfs_show() uses whenever users read from sysfs
+         */
+        kfree(sysfs_attributes);
+    }
+
+    return 0;
+}
+
+/*
+ * Function called on the root that recursively add nodes to sysfs
+ * It first looks at the current node in "ep", gathering statistics
+ * on every forward arcs it points to,
+ * then for every arc type it create a sysfs folder or link
+ * Finally it adds the properties (non arcs) to sysfs
+ * Return 0 upon success
+ */
+static int sysfs_populate(struct mdesc_handle *hp,
+              struct mdesc_elem *ep,
+              struct kobject *parent_kobj,
+              struct kobject **all_nodes)
+{
+    struct mdesc_elem *base = node_block(&hp->mdesc);
+    const char *names = name_block(&hp->mdesc);
+    struct mdesc_arcs arcs_list, *p;
+    struct list_head *pos, *q;
+    int err = 0;
+
+    /*
+     * Check that it's indeed an arc node
+     * and lose the 1st entry as it's not useful hereafter
+     */
+    if (ep++->tag != MD_NODE) {
+        pr_err("mdesc_sysfs: Not a valid arc node\n");
+        return -EINVAL;
+    }
+
+    /*
+     * In a high level language we'd create a dictionary
+     * for example: {"cpu": 64", "memory": 1, ...}
+     * In the kernel we use a linked list of structs.
+     * We end up with: ("cpu", 64) --> ("memory", 1) -->...
+     */
+    INIT_LIST_HEAD(&arcs_list.list);
+    err = sysfs_populate_build_arcs_list(hp, ep, &arcs_list);
+    if (err)
+        return err;
+
+    /*
+     * For each arc type, we browse the current arc "ep" and
+     * add to sysfs. That allows us to keep an index for these
+     * arcs that don't contain an "id" or "name" field
+     */
+    list_for_each_entry(p, &arcs_list.list, list) {
+        struct mdesc_elem *elem;
+        unsigned int index = 0;
+
+        for (elem = ep; elem->tag != MD_NODE_END; elem++) {
+            struct kobject *kobj;
+            const char *name;
+
+            /* Need to be a forward arc... */
+            if (elem->tag != MD_PROP_ARC ||
+                strcmp(names + elem->name_offset, "fwd"))
+                continue;
+
+            /*
+             * ...whose name matches the element of the list
+             * that we're currently considering
+             */
+            name = names + (base + elem->d.val)->name_offset;
+            if (strcmp(p->name, name))
+                continue;
+
+            /* Have we already added this arc to sysfs? */
+            if (all_nodes[elem->d.val]) {
+                /* Yes, we link to it */
+                err = create_sysfs_link(hp, elem, name,
+                    all_nodes[elem->d.val], parent_kobj,
+                    index, p->count);
+            } else {
+                /* No, we create a folder for it */
+                err = create_sysfs_folder(hp, elem, name,
+                    &kobj, parent_kobj, index, p->count);
+                if (err)
+                    return -ENOMEM;
+
+                all_nodes[elem->d.val] = kobj;
+
+                /* And we add to sysfs whatever it contains */
+                sysfs_populate(hp, base + elem->d.val,
+                           kobj, all_nodes);
+            }
+
+            /*
+             * If it's the last entry of its kind, there's
+             * no point in looping again
+             */
+            if (++index = p->count)
+                break;
+        }
+    }
+
+    /* Free the linked list */
+    list_for_each_safe(pos, q, &arcs_list.list) {
+        p = list_entry(pos, struct mdesc_arcs, list);
+        list_del(pos);
+        kfree(p);
+    }
+
+    /* Add the properties (non-arc) to sysfs (string, int, binary data) */
+    return mdesc_sysfs_add_propeties(hp, ep, parent_kobj);
+}
+
+static struct kobject *mdesc_kobj;
+
+int mdesc_sysfs_populate(void)
+{
+    struct mdesc_handle *hp;
+    unsigned int num_node;
+    struct kobject **all_nodes, *old_mdesc_kobj;
+    unsigned int major, minor;
+    mode_t mode;
+    int retval = 0;
+
+    hp = mdesc_grab();
+    if (!hp) {
+        pr_err("mdesc_sysfs: hv mdesc not found\n");
+        return -ENODEV;
+    }
+
+    major = hp->mdesc.version >> 16;
+    minor = hp->mdesc.version & 0xffff;
+
+    if (major != 1) {
+        pr_err("mdesc_sysfs: unsupported hv mdesc version: %d.%d\n",
+               major, minor);
+        mdesc_release(hp);
+        return -EINVAL;
+    }
+
+    pr_info("mdesc_sysfs: machine desc version %d.%d\n", major, minor);
+
+    num_node = hp->mdesc.node_sz / sizeof(struct mdesc_hdr);
+    all_nodes = kcalloc(num_node, sizeof(struct kobject *), GFP_KERNEL);
+    if (!all_nodes) {
+        mdesc_release(hp);
+        return -ENOMEM;
+    }
+
+    updating = true;
+
+    old_mdesc_kobj = mdesc_kobj;
+    mdesc_kobj = kobject_create_and_add(".mdesc.tmp", firmware_kobj);
+    if (!mdesc_kobj) {
+        pr_err("mdesc_sysfs: unable to create sysfs entry\n");
+        kfree(all_nodes);
+        mdesc_release(hp);
+        return -ENOMEM;
+    }
+    mode = mdesc_kobj->sd->mode;
+     /* Remove access to everyone since we're populating
+      * the tree. Regardless, root has always access! */
+    mdesc_kobj->sd->mode &= ~0777;
+
+    retval = sysfs_populate(hp, node_block(&hp->mdesc),
+                mdesc_kobj, all_nodes);
+
+    mdesc_release(hp);
+    kfree(all_nodes);
+
+    /* Rename existing mdesc to avoid conflicts */
+    if (retval)
+        return retval;
+
+    if (old_mdesc_kobj) {
+        retval = kobject_rename(old_mdesc_kobj, ".mdesc.old");
+        if (retval) {
+            pr_err("mdesc_sysfs: unable to rename /sys/firmware/mdesc\n");
+            kobject_del(mdesc_kobj);
+            kobject_put(mdesc_kobj);
+            updating = false;
+            return retval;
+        }
+    }
+
+    /* Restore original mode and set name */
+    retval = kobject_rename(mdesc_kobj, "mdesc");
+    if (!retval) {
+        mdesc_kobj->sd->mode = mode;
+        if (old_mdesc_kobj) {
+            kobject_del(old_mdesc_kobj);
+            kobject_put(old_mdesc_kobj);
+        }
+    } else {
+        int dummy;
+
+        /* Attempt to restore the old entry (if any) */
+        if (old_mdesc_kobj)
+            dummy = kobject_rename(old_mdesc_kobj, "mdesc");
+        kobject_del(mdesc_kobj);
+        kobject_put(mdesc_kobj);
+    }
+
+    updating = false;
+
+    return retval;
+}
+EXPORT_SYMBOL(mdesc_sysfs_populate);
+
+MODULE_DESCRIPTION("Maps machine description graph to sysfs in 
/sys/firmware/mdesc");
+MODULE_AUTHOR("Oracle");
+MODULE_LICENSE("GPL");
+
+static int __init mdesc_sysfs_init(void)
+{
+    return mdesc_sysfs_populate();
+}
+
+static void __exit mdesc_sysfs_cleanup(void)
+{
+    if (mdesc_kobj) {
+        kobject_del(mdesc_kobj);
+        kobject_put(mdesc_kobj);
+    }
+}
+
+module_init(mdesc_sysfs_init);
+module_exit(mdesc_sysfs_cleanup);
-- 
1.7.1
