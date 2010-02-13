From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Feb 2010 16:03:09 +0000
Subject: [PATCH 8/9] of/sparc: Remove sparc-local declaration of allnodes and
Message-Id: <20100213160309.4767.94443.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org, jeremy.kerr@canonical.com, davem@davemloft.net, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

Both allnodes and devtree_lock are defined in common code.  The
extern declaration should be in the common header too so that the
compiler can type check.  allnodes is already in of.h, but
devtree_lock should be declared there too.

This patch removes the SPARC declarations and uses decls in of.h instead.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/sparc/kernel/prom.h |    3 ---
 include/linux/of.h       |    2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index 453397f..a8591ef 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -4,9 +4,6 @@
 #include <linux/spinlock.h>
 #include <asm/prom.h>
 
-extern struct device_node *allnodes;	/* temporary while merging */
-extern rwlock_t devtree_lock;	/* temporary while merging */
-
 extern void * prom_early_alloc(unsigned long size);
 extern void irq_trans_init(struct device_node *dp);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index d34cc5d..f6d9cbc 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/kref.h>
 #include <linux/mod_devicetable.h>
+#include <linux/spinlock.h>
 
 #include <asm/byteorder.h>
 
@@ -67,6 +68,7 @@ struct device_node {
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *allnodes;
 extern struct device_node *of_chosen;
+extern rwlock_t devtree_lock;
 
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 {

