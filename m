From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 07 Nov 2009 18:58:13 +0000
Subject: [patch] sparc: Remove bogus of_set_property_mutex
Message-Id: <20091107184538.543684450@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

of_set_property_mutex is taken inside the devtree_lock write locked
region which triggers the might_sleep check. The mutex protects the
call to prom_setprop() which is not necessary as the code is the only
caller of prom_setprop() and already serialized by devtree_lock. The
mutex is nowhere else used despite being exported. So it can be
removed safely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/prom.h   |    2 --
 arch/sparc/kernel/prom_common.c |    5 -----
 2 files changed, 7 deletions(-)

Index: linux-2.6/arch/sparc/include/asm/prom.h
=================================--- linux-2.6.orig/arch/sparc/include/asm/prom.h
+++ linux-2.6/arch/sparc/include/asm/prom.h
@@ -18,7 +18,6 @@
  */
 #include <linux/types.h>
 #include <linux/proc_fs.h>
-#include <linux/mutex.h>
 #include <asm/atomic.h>
 
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
@@ -74,7 +73,6 @@ struct of_irq_controller {
 
 extern struct device_node *of_find_node_by_cpuid(int cpuid);
 extern int of_set_property(struct device_node *node, const char *name, void *val, int len);
-extern struct mutex of_set_property_mutex;
 extern int of_getintprop_default(struct device_node *np,
 				 const char *name,
 				 int def);
Index: linux-2.6/arch/sparc/kernel/prom_common.c
=================================--- linux-2.6.orig/arch/sparc/kernel/prom_common.c
+++ linux-2.6/arch/sparc/kernel/prom_common.c
@@ -62,9 +62,6 @@ int of_getintprop_default(struct device_
 }
 EXPORT_SYMBOL(of_getintprop_default);
 
-DEFINE_MUTEX(of_set_property_mutex);
-EXPORT_SYMBOL(of_set_property_mutex);
-
 int of_set_property(struct device_node *dp, const char *name, void *val, int len)
 {
 	struct property **prevp;
@@ -88,9 +85,7 @@ int of_set_property(struct device_node *
 			void *old_val = prop->value;
 			int ret;
 
-			mutex_lock(&of_set_property_mutex);
 			ret = prom_setprop(dp->node, name, val, len);
-			mutex_unlock(&of_set_property_mutex);
 
 			err = -EINVAL;
 			if (ret >= 0) {


