From: Andres Salomon <dilinger@queued.net>
Date: Mon, 30 Aug 2010 04:04:45 +0000
Subject: [PATCH 7/9] of: add package-to-path support to pdt
Message-Id: <20100830000445.3beb3e79@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian>
	<20100829235100.6dcedcb8@debxo>
In-Reply-To: <20100829235100.6dcedcb8@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, grant.likely@secretlab.ca, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>


package-to-path is a PROM function which tells us the real (full) name of the
node.  This provides a hook for that in the prom ops struct, and makes use
of it in the pdt code when attempting to determine a node's name.  If the
hook is available, try using it (falling back to looking at the "name"
property if it fails).

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/of/pdt.c       |   43 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/of_pdt.h |    3 +++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 31a4fb8..28295d0 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -132,6 +132,47 @@ static char * __init of_pdt_get_one_property(phandle node, const char *name)
 	return buf;
 }
 
+static char * __init of_pdt_try_pkg2path(phandle node)
+{
+	char *res, *buf = NULL;
+	int len;
+
+	if (!of_pdt_prom_ops->pkg2path)
+		return NULL;
+
+	if (of_pdt_prom_ops->pkg2path(node, buf, 0, &len))
+		return NULL;
+	buf = prom_early_alloc(len + 1);
+	if (of_pdt_prom_ops->pkg2path(node, buf, len, &len)) {
+		pr_err("%s: package-to-path failed\n", __func__);
+		return NULL;
+	}
+
+	res = strrchr(buf, '/');
+	if (!res) {
+		pr_err("%s: couldn't find / in %s\n", __func__, buf);
+		return NULL;
+	}
+	return res+1;
+}
+
+/*
+ * When fetching the node's name, first try using package-to-path; if
+ * that fails (either because the arch hasn't supplied a PROM callback,
+ * or some other random failure), fall back to just looking at the node's
+ * 'name' property.
+ */
+static char * __init of_pdt_build_name(phandle node)
+{
+	char *buf;
+
+	buf = of_pdt_try_pkg2path(node);
+	if (!buf)
+		buf = of_pdt_get_one_property(node, "name");
+
+	return buf;
+}
+
 static struct device_node * __init of_pdt_create_node(phandle node,
 						    struct device_node *parent)
 {
@@ -146,7 +187,7 @@ static struct device_node * __init of_pdt_create_node(phandle node,
 
 	kref_init(&dp->kref);
 
-	dp->name = of_pdt_get_one_property(node, "name");
+	dp->name = of_pdt_build_name(node);
 	dp->type = of_pdt_get_one_property(node, "device_type");
 	dp->phandle = node;
 
diff --git a/include/linux/of_pdt.h b/include/linux/of_pdt.h
index a057417..9945e58 100644
--- a/include/linux/of_pdt.h
+++ b/include/linux/of_pdt.h
@@ -29,6 +29,9 @@ struct of_pdt_ops {
 	/* phandles are 0 if no child or sibling exists */
 	phandle (*getchild)(phandle parent);
 	phandle (*getsibling)(phandle node);
+
+	/* return 0 on success; fill in 'len' with number of bytes in path */
+	int (*pkg2path)(phandle node, char *buf, const int buflen, int *len);
 };
 
 extern void *prom_early_alloc(unsigned long size);
-- 
1.5.6.5

