From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:09 +0000
Subject: [PATCH 4/14]: sparc: Mark prom_early_alloc non-static.
Message-Id: <20081205.190509.42712006.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Mark prom_early_alloc non-static.

A subsequent changeset will use this.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h    |    2 ++
 arch/sparc/kernel/prom_32.c |    2 +-
 arch/sparc/kernel/prom_64.c |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index dce53de..b7258ce 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -7,4 +7,6 @@
 extern struct device_node *allnodes;	/* temporary while merging */
 extern rwlock_t devtree_lock;	/* temporary while merging */
 
+extern void * prom_early_alloc(unsigned long size);
+
 #endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index e41df66..ba3c551 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -29,7 +29,7 @@
 
 static unsigned int prom_early_allocated;
 
-static void * __init prom_early_alloc(unsigned long size)
+void * __init prom_early_alloc(unsigned long size)
 {
 	void *ret;
 
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 1f5666a..1c7b9d7 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -34,7 +34,7 @@
 
 static unsigned int prom_early_allocated __initdata;
 
-static void * __init prom_early_alloc(unsigned long size)
+void * __init prom_early_alloc(unsigned long size)
 {
 	unsigned long paddr = lmb_alloc(size, SMP_CACHE_BYTES);
 	void *ret;
-- 
1.5.6.5

