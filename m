From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:00 +0000
Subject: [PATCH 1/14]: sparc: Create common header file for prom_{32,64}.c
Message-Id: <20081205.190500.28702030.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Create common header file for prom_{32,64}.c

This is where common declarations will go as we unify
these files as much as possible into common code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h    |   10 ++++++++++
 arch/sparc/kernel/prom_32.c |    4 +---
 arch/sparc/kernel/prom_64.c |    4 +---
 3 files changed, 12 insertions(+), 6 deletions(-)
 create mode 100644 arch/sparc/kernel/prom.h

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
new file mode 100644
index 0000000..dce53de
--- /dev/null
+++ b/arch/sparc/kernel/prom.h
@@ -0,0 +1,10 @@
+#ifndef __PROM_H
+#define __PROM_H
+
+#include <linux/spinlock.h>
+#include <asm/prom.h>
+
+extern struct device_node *allnodes;	/* temporary while merging */
+extern rwlock_t devtree_lock;	/* temporary while merging */
+
+#endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index eee5efc..715455b 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -25,9 +25,7 @@
 #include <asm/prom.h>
 #include <asm/oplib.h>
 
-extern struct device_node *allnodes;	/* temporary while merging */
-
-extern rwlock_t devtree_lock;	/* temporary while merging */
+#include "prom.h"
 
 struct device_node *of_find_node_by_phandle(phandle handle)
 {
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index dbba82f..651448d 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -30,9 +30,7 @@
 #include <asm/upa.h>
 #include <asm/smp.h>
 
-extern struct device_node *allnodes;	/* temporary while merging */
-
-extern rwlock_t devtree_lock;	/* temporary while merging */
+#include "prom.h"
 
 struct device_node *of_find_node_by_phandle(phandle handle)
 {
-- 
1.5.6.5

