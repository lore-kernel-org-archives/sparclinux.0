From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Feb 2010 16:02:53 +0000
Subject: [PATCH 5/9] of: put default string compare and #a/s-cell values into
Message-Id: <20100213160252.4767.94582.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org, jeremy.kerr@canonical.com, davem@davemloft.net, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

Most architectures don't need to change these.  Put them into common
code to eliminate some duplication

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |    7 -------
 arch/powerpc/include/asm/prom.h    |    7 -------
 include/linux/of.h                 |   13 +++++++++++++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 6c6b386..ddc5c57 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -26,13 +26,6 @@
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
-
-#define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
-#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
-
 extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index f384db8..4a5070e 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -23,13 +23,6 @@
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
-#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
-#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
-
-#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
-#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
-
 extern struct device_node *of_chosen;
 
 #define HAVE_ARCH_DEVTREE_FIXUPS
diff --git a/include/linux/of.h b/include/linux/of.h
index 48b0ee6..5cd2840 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -116,6 +116,19 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 
 #include <asm/prom.h>
 
+/* Default #address and #size cells.  Allow arch asm/prom.h to override */
+#if !defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)
+#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
+#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
+#endif
+
+/* Default string compare functions, Allow arch asm/prom.h to override */
+#if !defined(of_compat_cmp)
+#define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+#endif
+
 /* flag descriptions */
 #define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
 #define OF_DETACHED	2 /* node has been detached from the device tree */

