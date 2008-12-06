From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:16 +0000
Subject: [PATCH 7/14]: sparc: Move property building code into prom_common.c
Message-Id: <20081205.190516.239992617.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move property building code into prom_common.c

Unfortunately there is some sparc32/sparc64 ifdef'ery in
here due to the difference in how the prom_firstprop()
and prom_nextprop() routines work.

This will be eliminated eventually.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom.h        |    2 +
 arch/sparc/kernel/prom_32.c     |   66 -------------------------------
 arch/sparc/kernel/prom_64.c     |   60 -----------------------------
 arch/sparc/kernel/prom_common.c |   81 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 126 deletions(-)

diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index 2575cdb..49c25bd 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -15,4 +15,6 @@ extern void irq_trans_init(struct device_node *dp);
 
 extern unsigned int prom_unique_id;
 
+extern struct property * __init build_prop_list(phandle node);
+
 #endif /* __PROM_H */
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index c34888a..a9859d2 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -196,72 +196,6 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static struct property * __init build_one_prop(phandle node, char *prev, char *special_name, void *special_val, int special_len)
-{
-	static struct property *tmp = NULL;
-	struct property *p;
-	int len;
-	const char *name;
-
-	if (tmp) {
-		p = tmp;
-		memset(p, 0, sizeof(*p) + 32);
-		tmp = NULL;
-	} else {
-		p = prom_early_alloc(sizeof(struct property) + 32);
-		p->unique_id = prom_unique_id++;
-	}
-
-	p->name = (char *) (p + 1);
-	if (special_name) {
-		strcpy(p->name, special_name);
-		p->length = special_len;
-		p->value = prom_early_alloc(special_len);
-		memcpy(p->value, special_val, special_len);
-	} else {
-		if (prev = NULL) {
-			name = prom_firstprop(node, NULL);
-		} else {
-			name = prom_nextprop(node, prev, NULL);
-		}
-		if (strlen(name) = 0) {
-			tmp = p;
-			return NULL;
-		}
-		strcpy(p->name, name);
-		p->length = prom_getproplen(node, p->name);
-		if (p->length <= 0) {
-			p->length = 0;
-		} else {
-			p->value = prom_early_alloc(p->length + 1);
-			len = prom_getproperty(node, p->name, p->value,
-					       p->length);
-			if (len <= 0)
-				p->length = 0;
-			((unsigned char *)p->value)[p->length] = '\0';
-		}
-	}
-	return p;
-}
-
-static struct property * __init build_prop_list(phandle node)
-{
-	struct property *head, *tail;
-
-	head = tail = build_one_prop(node, NULL,
-				     ".node", &node, sizeof(node));
-
-	tail->next = build_one_prop(node, NULL, NULL, NULL, 0);
-	tail = tail->next;
-	while(tail) {
-		tail->next = build_one_prop(node, tail->name,
-					    NULL, NULL, 0);
-		tail = tail->next;
-	}
-
-	return head;
-}
-
 static char * __init get_one_property(phandle node, char *name)
 {
 	char *buf = "<NULL>";
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 61cc967..e3969db 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -399,66 +399,6 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static struct property * __init build_one_prop(phandle node, char *prev, char *special_name, void *special_val, int special_len)
-{
-	static struct property *tmp = NULL;
-	struct property *p;
-
-	if (tmp) {
-		p = tmp;
-		memset(p, 0, sizeof(*p) + 32);
-		tmp = NULL;
-	} else {
-		p = prom_early_alloc(sizeof(struct property) + 32);
-		p->unique_id = prom_unique_id++;
-	}
-
-	p->name = (char *) (p + 1);
-	if (special_name) {
-		strcpy(p->name, special_name);
-		p->length = special_len;
-		p->value = prom_early_alloc(special_len);
-		memcpy(p->value, special_val, special_len);
-	} else {
-		if (prev = NULL) {
-			prom_firstprop(node, p->name);
-		} else {
-			prom_nextprop(node, prev, p->name);
-		}
-		if (strlen(p->name) = 0) {
-			tmp = p;
-			return NULL;
-		}
-		p->length = prom_getproplen(node, p->name);
-		if (p->length <= 0) {
-			p->length = 0;
-		} else {
-			p->value = prom_early_alloc(p->length + 1);
-			prom_getproperty(node, p->name, p->value, p->length);
-			((unsigned char *)p->value)[p->length] = '\0';
-		}
-	}
-	return p;
-}
-
-static struct property * __init build_prop_list(phandle node)
-{
-	struct property *head, *tail;
-
-	head = tail = build_one_prop(node, NULL,
-				     ".node", &node, sizeof(node));
-
-	tail->next = build_one_prop(node, NULL, NULL, NULL, 0);
-	tail = tail->next;
-	while(tail) {
-		tail->next = build_one_prop(node, tail->name,
-					    NULL, NULL, 0);
-		tail = tail->next;
-	}
-
-	return head;
-}
-
 static char * __init get_one_property(phandle node, const char *name)
 {
 	char *buf = "<NULL>";
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index a231808..7620567 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -120,3 +120,84 @@ int of_find_in_proplist(const char *list, const char *match, int len)
 EXPORT_SYMBOL(of_find_in_proplist);
 
 unsigned int prom_unique_id;
+
+static struct property * __init build_one_prop(phandle node, char *prev,
+					       char *special_name,
+					       void *special_val,
+					       int special_len)
+{
+	static struct property *tmp = NULL;
+	struct property *p;
+	const char *name;
+
+	if (tmp) {
+		p = tmp;
+		memset(p, 0, sizeof(*p) + 32);
+		tmp = NULL;
+	} else {
+		p = prom_early_alloc(sizeof(struct property) + 32);
+		p->unique_id = prom_unique_id++;
+	}
+
+	p->name = (char *) (p + 1);
+	if (special_name) {
+		strcpy(p->name, special_name);
+		p->length = special_len;
+		p->value = prom_early_alloc(special_len);
+		memcpy(p->value, special_val, special_len);
+	} else {
+#ifdef CONFIG_SPARC32
+		if (prev = NULL) {
+			name = prom_firstprop(node, NULL);
+		} else {
+			name = prom_nextprop(node, prev, NULL);
+		}
+#else
+		if (prev = NULL) {
+			prom_firstprop(node, p->name);
+		} else {
+			prom_nextprop(node, prev, p->name);
+		}
+		name = p->name;
+#endif
+		if (strlen(name) = 0) {
+			tmp = p;
+			return NULL;
+		}
+#ifdef CONFIG_SPARC32
+		strcpy(p->name, name);
+#endif
+		p->length = prom_getproplen(node, p->name);
+		if (p->length <= 0) {
+			p->length = 0;
+		} else {
+			int len;
+
+			p->value = prom_early_alloc(p->length + 1);
+			len = prom_getproperty(node, p->name, p->value,
+					       p->length);
+			if (len <= 0)
+				p->length = 0;
+			((unsigned char *)p->value)[p->length] = '\0';
+		}
+	}
+	return p;
+}
+
+struct property * __init build_prop_list(phandle node)
+{
+	struct property *head, *tail;
+
+	head = tail = build_one_prop(node, NULL,
+				     ".node", &node, sizeof(node));
+
+	tail->next = build_one_prop(node, NULL, NULL, NULL, 0);
+	tail = tail->next;
+	while(tail) {
+		tail->next = build_one_prop(node, tail->name,
+					    NULL, NULL, 0);
+		tail = tail->next;
+	}
+
+	return head;
+}
-- 
1.5.6.5

