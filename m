From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:32:02 +0000
Subject: [RFC PATCH 10/12] of: merge of_*_flat_dt*() functions
Message-Id: <20091007043154.16890.18883.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Merge common flattened device tree code between Microblaze and PowerPC

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   11 -----------
 arch/powerpc/include/asm/prom.h    |   10 ----------
 include/linux/of_fdt.h             |   14 ++++++++++++++
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index c92b4a9..be4db2a 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -40,17 +40,6 @@ extern struct device_node *of_chosen;
 extern struct device_node *allnodes;	/* temporary while merging */
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
-/* For scanning the flat device-tree at boot time */
-extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
-					const char *uname, int depth,
-					void *data),
-				void *data);
-extern void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
-					unsigned long *size);
-extern int __init
-		of_flat_dt_is_compatible(unsigned long node, const char *name);
-extern unsigned long __init of_get_flat_dt_root(void);
-
 /* For updating the device tree at runtime */
 extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 622769c..c8b5933 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -34,16 +34,6 @@ extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
-/* For scanning the flat device-tree at boot time */
-extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
-					    const char *uname, int depth,
-					    void *data),
-				  void *data);
-extern void* __init of_get_flat_dt_prop(unsigned long node, const char *name,
-					unsigned long *size);
-extern int __init of_flat_dt_is_compatible(unsigned long node, const char *name);
-extern unsigned long __init of_get_flat_dt_root(void);
-
 /* For updating the device tree at runtime */
 extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 8b87bcb..ac31d4f 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -16,6 +16,9 @@
 #ifndef _LINUX_OF_FDT_H
 #define _LINUX_OF_FDT_H
 
+#include <linux/types.h>
+#include <linux/init.h>
+
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
@@ -57,4 +60,15 @@ struct boot_param_header {
 	u32	dt_struct_size;		/* size of the DT structure block */
 };
 
+/* For scanning the flat device-tree at boot time */
+extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
+					    const char *uname, int depth,
+					    void *data),
+				  void *data);
+extern void __init *of_get_flat_dt_prop(unsigned long node, const char *name,
+					unsigned long *size);
+extern int __init of_flat_dt_is_compatible(unsigned long node,
+					   const char *name);
+extern unsigned long __init of_get_flat_dt_root(void);
+
 #endif /* _LINUX_OF_FDT_H */

