From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:14 +0000
Subject: [PATCH 6/14]: sparc: Move 'unique_id' into prom_common.c and
Message-Id: <20081205.190514.50848820.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move 'unique_id' into prom_common.c and rename to 'prom_unique_id'

This will be used in a subsequent changeset.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h        |    2 ++
 arch/sparc/kernel/prom_32.c     |    6 ++----
 arch/sparc/kernel/prom_64.c     |    6 ++----
 arch/sparc/kernel/prom_common.c |    1 +
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index 4992510..2575cdb 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -13,4 +13,6 @@ extern void * prom_early_alloc(unsigned long size);
 extern void irq_trans_init(struct device_node *dp);
 #endif
 
+extern unsigned int prom_unique_id;
+
 #endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index ba3c551..c34888a 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -196,8 +196,6 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static unsigned int unique_id;
-
 static struct property * __init build_one_prop(phandle node, char *prev, char *special_name, void *special_val, int special_len)
 {
 	static struct property *tmp = NULL;
@@ -211,7 +209,7 @@ static struct property * __init build_one_prop(phandle node, char *prev, char *s
 		tmp = NULL;
 	} else {
 		p = prom_early_alloc(sizeof(struct property) + 32);
-		p->unique_id = unique_id++;
+		p->unique_id = prom_unique_id++;
 	}
 
 	p->name = (char *) (p + 1);
@@ -286,7 +284,7 @@ static struct device_node * __init create_node(phandle node)
 		return NULL;
 
 	dp = prom_early_alloc(sizeof(*dp));
-	dp->unique_id = unique_id++;
+	dp->unique_id = prom_unique_id++;
 
 	kref_init(&dp->kref);
 
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index d745b9f..61cc967 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -399,8 +399,6 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static unsigned int unique_id;
-
 static struct property * __init build_one_prop(phandle node, char *prev, char *special_name, void *special_val, int special_len)
 {
 	static struct property *tmp = NULL;
@@ -412,7 +410,7 @@ static struct property * __init build_one_prop(phandle node, char *prev, char *s
 		tmp = NULL;
 	} else {
 		p = prom_early_alloc(sizeof(struct property) + 32);
-		p->unique_id = unique_id++;
+		p->unique_id = prom_unique_id++;
 	}
 
 	p->name = (char *) (p + 1);
@@ -483,7 +481,7 @@ static struct device_node * __init create_node(phandle node, struct device_node
 		return NULL;
 
 	dp = prom_early_alloc(sizeof(*dp));
-	dp->unique_id = unique_id++;
+	dp->unique_id = prom_unique_id++;
 	dp->parent = parent;
 
 	kref_init(&dp->kref);
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index ded8c62..a231808 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -119,3 +119,4 @@ int of_find_in_proplist(const char *list, const char *match, int len)
 }
 EXPORT_SYMBOL(of_find_in_proplist);
 
+unsigned int prom_unique_id;
-- 
1.5.6.5

